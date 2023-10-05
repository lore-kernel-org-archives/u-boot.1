Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F0AE7C4F4
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 07:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC63386EA3;
	Thu,  5 Oct 2023 09:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XDlL+sw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DBA86EAC; Thu,  5 Oct 2023 09:52:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB9A86C4B
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 09:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7868D61827;
 Thu,  5 Oct 2023 07:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A55AC4167D;
 Thu,  5 Oct 2023 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696492368;
 bh=ZUmUSfgXXCVKCHwr/KAN8O8L3QmiJmX/O0uV9+i5FNc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XDlL+sw22ApEIF8dXzCysq4gc84gAhgjrebtYptH3vumpaM4KUdFhftkWbO9vNqyT
 Qd50HRh3TRVWqxat2zUcDj8I2SoPCkyCS7Fy/4FKPQ0jTB6ux+mDE1OAtRXRQh3Ca2
 uOWTXEA/jG2z2DWlI0SKbkCSs09N9Sba6HtqExHu1yBH78mgrw/1uR/2AzqGt606hP
 MwIv1o2BRRIbwFDAXR838vt0yWmPjM8EfKFi2r7E9rykoxgJf/VRdwVYff2siw75do
 yZ/mpXpQbRgeSyuuzwVDyfVlXNIPWjFVk7ugLfxIiB71d/tg9nsof6NOxFz8rxjjPi
 6LkIonRa8n8Eg==
Message-ID: <3bf30507-ffe2-48a7-96e2-abf2a8271247@kernel.org>
Date: Thu, 5 Oct 2023 10:52:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am65-iot2050: Fix boot
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 afd@ti.com, bb@ti.com, praneeth@ti.com,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <3376a0eb-57f4-416a-b4b8-86cee769d6eb@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <3376a0eb-57f4-416a-b4b8-86cee769d6eb@siemens.com>
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



On 05/10/2023 07:37, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Since commit [1] A53 u-boot proper is broken. This is because nodes
> marked as 'bootph-pre-ram' are not available at u-boot proper before
> relocation.
> 
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
> 
> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
