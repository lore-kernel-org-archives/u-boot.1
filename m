Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9644C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 10:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C588765B;
	Thu, 11 Jan 2024 11:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eRhGWZZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B878765B; Thu, 11 Jan 2024 11:17:42 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D358187613
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 11:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id BAC01B80ACD;
 Thu, 11 Jan 2024 10:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDACBC433C7;
 Thu, 11 Jan 2024 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704968258;
 bh=Gb2kX71f3+QBBn2KsSXB5XZqPgX4ur3uPoHdMUH7RfA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eRhGWZZh2JOCtSW1IAaG5u4IFbcWaMZEGX6GlZKu64pnYk8jgJISz4+2E10x+Nfu4
 0T6MH5jYyLd5wVO4PeVnWYJieAqkpjhONRoKpVLTmxjmFJ/au9rusJzVFoDECf7N1F
 pKbV5ZQSbha4oA6b6zy6/qcSN72sTXzu2lv1wO3WmjnmWbPWmT2nNiUMvyuWHSf8P+
 gRoDzVaobC72iosqpaW19S+9YFFs3IqQJ3Gng3L0P1NtdpV7pS7EmY2KTqNcHIAHGJ
 rkjDzjkpVQ8gZJB1uJLxJvx/xKAMmkXgIbwASZsOI5lrtn4mjBZIG3Jc7UkzYNK0wr
 ScQ47XctdYCYw==
Message-ID: <a0a7b0a6-9575-4783-9409-3dd915bc862c@kernel.org>
Date: Thu, 11 Jan 2024 12:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/10] board/ti: k3 boards: Stop using findfdt
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 u-boot@lists.denx.de, Jon Humphreys <j-humphreys@ti.com>
References: <20240109191506.3820908-1-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240109191506.3820908-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 09/01/2024 21:14, Nishanth Menon wrote:
> This is a wide cleanup to switch to setting fdtfile using env_set
> instead of scripted magic. 'fdtfile' is expected to be set by default.
> This allows the stdboot triggered efi loaders to find the correct OS
> device tree file even if regular boot process is interrupted by user
> intervention.
> 
> This is a refresh of
> https://lore.kernel.org/all/86le9dwz4d.fsf@udb0321960.dhcp.ti.com/ which
> was the wrong approach.
> 
> Updates from V1:
>  * Renames of variables and macros for various review comments.
>  * Commit message updates in some patches for clarity.
> 
> Bootlogs: https://gist.github.com/nmenon/843e343cde645ec4aa57b60cece5256a
> 
> based on master: c5e461fbf7cc Merge tag 'u-boot-imx-master-20240108' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
> 
> NOTE: There are a couple of checkpatch WARN (around LATE_INIT) and
> CHECK (fdt_ops #ifdeffery) that on closer inspection looks fine and
> consistent with other similar usage.
> 
> V1: https://lore.kernel.org/all/20240108173301.2692332-1-nm@ti.com/
> 
> Nishanth Menon (10):
>   board: ti: common: Introduce a common fdt ops library
>   board: ti: am62ax: Set fdtfile from C code instead of findfdt script
>   board: ti: am62x: Set fdtfile from C code instead of findfdt script
>   board: ti: am64x: Set fdtfile from C code instead of findfdt script
>   board: ti: am65x: Set fdtfile from C code instead of findfdt script
>   board: ti: j721e: Set fdtfile from C code instead of findfdt script
>   board: ti: j721s2: Set fdtfile from C code instead of findfdt script
>   board: beagle: beagleboneai64: Set fdtfile from C code instead of
>     findfdt script
>   board: beagle: beagleplay: Set fdtfile from C code instead of findfdt
>     script
>   include: env: ti: Drop default_findfdt

For this series:

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger
