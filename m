Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465ADEF4EDE
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 12:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB7483936;
	Mon,  6 Apr 2026 14:40:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CffX5Y1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0B983C2B; Mon,  6 Apr 2026 14:40:13 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F081B8341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 14:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A82F7439AE;
 Mon,  6 Apr 2026 12:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214ECC4CEF7;
 Mon,  6 Apr 2026 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775479208;
 bh=vM/T4xqLMpg/UKca6ZP/uq69tu6xHGcmMjGpgafNBj8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CffX5Y1pJjZcm0pFra3nmleetVThY9LjV3X6XiMlUknYG78+vHt4rvQ0OLISODkwF
 GaCbqNn3QF6mNRvDVbjrT0Llco1uDf7Ci6YdhnBHiGiSZRC3R98I4z71vnAlWHewj6
 rbHiGACCGoSxlUBwMxV5Iaw6/55NrzJOlvQRJtYw4mSbXMdCIpJzFGLQqhoHERhjvh
 ULHHPqA2M1WWsXghr2nj84DUg8fE+tJHVF261xMOZDt1b1Ct6M4shAZpkk3SuWtkJ4
 0c2Cmahk35rPOojnu4oOlckXtzIzn1MQN7vFuE5yJ4PhOaxWz52/PMUfBqMXj+d8OW
 PgqLf7TPra6Mw==
Date: Mon, 6 Apr 2026 18:10:01 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 neil.armstrong@linaro.org, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] mach-snapdragon: Enable OP-TEE support
Message-ID: <adOpoaAmfBjSxBfC@sumit-xelite>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
 <acJ5vEZ2F46NS_xV@sumit-xelite>
 <194636bb-4bbc-4df8-9561-e3a34315b4f9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194636bb-4bbc-4df8-9561-e3a34315b4f9@linaro.org>
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

On Tue, Mar 24, 2026 at 12:50:00PM +0100, Casey Connolly wrote:
> Hi Sumit,
> 
> On 24/03/2026 12:47, Sumit Garg wrote:
> > Hey Casey,
> > 
> > On Tue, Jan 27, 2026 at 11:53:38AM +0530, Sumit Garg wrote:
> >> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>
> >> Introduce TF-A and OP-TEE config fragment
> >>
> >> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
> >> platforms. RB3Gen2 being the first one and more to come. U-Boot in
> >> corresponding boot flow is packaged as a position independent executable.
> >>
> >> So, lets add a generic U-Boot config fragment for Qcom platforms to
> >> support TF-A/OP-TEE based TrustZone stack. Build command:
> >>
> >> $ ./scripts/kconfig/merge_config.sh \
> >>        configs/qcom_defconfig \
> >>        board/qualcomm/tfa-optee.config
> >> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
> >>
> >> ---
> >> Changes in v3:
> >> - Incorporated misc. comments on patch #2.
> >>
> > 
> > Can we get this patch-set applied as well? Have been waiting on the list
> > for approx. 2 months.
> 
> Yeah, I'll get this into -next soon, apologies for the wait.
>

Still haven't seen any of your PR for this cycle. I see a lot of patches
reviewed but not applied on patchworks here [1].

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=&submitter=&state=&q=&archive=&delegate=151538

-Sumit
