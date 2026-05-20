Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55605CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 22:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B6784659;
	Thu, 21 May 2026 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rikRJDEF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DspOutc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEBC846DD; Thu, 21 May 2026 00:43:47 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 710638460E
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 00:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gLRR46kf7z9v0h;
 Thu, 21 May 2026 00:43:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779317025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9awvQSXyo/J6uq/fKxyXWpPj8qolhhA0l58VNJgOn4=;
 b=rikRJDEFOVOQzRXY8zG2kvdYh8VXWkow7TWOLvi7cLCpshqkVVzydjPKSdOONVzbqU9x51
 8LcnNyZOc2+on7MfS7dxX1rLGeBFHicO4EXSZwevWHReBFTVdrNclvWzvBDdAQfGcfoqGW
 yMGQyf18MkWhi4wmbKTWst390CXLLO3bs4FEam5vegUrHSLYYNdURa29O12GhUOBLMoeCr
 0bI+iPMwL09ATgcJVn1y2vJ5oxAKoyBINdUVuCIFANOUu49210HisgwkC6o1dqUH6Hd2GQ
 mLgMYaq8+m4iwHRcHGV+aMT+sMYMjqoIXsWJVKO2OrLgv3odvBkiJL3v6Vg0LQ==
Message-ID: <f48f9d8d-4b14-4745-8c96-2c315889f770@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779317022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9awvQSXyo/J6uq/fKxyXWpPj8qolhhA0l58VNJgOn4=;
 b=DspOutc8MOU3Onr3kz5rZrXKllZJgFGwigJ1INzXcGpsI5PGLjh3VNfqeC1Stx0Xbbn/d3
 lGP+0c0yTBVF6fHaiFB5QH/ZNdwoRkRfbe85eOqQBsvtnkCuVjJC5i0d3zRz5Tq0wtd4mt
 acbXDRT/H3Ax/XqSYCaOTucgVFzKpOmZV6zvguLW4B8SkhXGMYs+ap6gl7hPtIazigUdHN
 TXQY3treH/xSDdNRpmUHngSu+oIsln2kCLhJLSXMRHLV+Xpr1U9pqfj5pnUxKX+FM+zjPi
 +7MioRvfx79cMY5hiyzG2L1xFy/PqarCYJ5mcaSEcDPHlgOyouDUODMf2uzmXw==
Date: Wed, 20 May 2026 18:38:22 +0200
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v3 0/3] Enable Arm SMC watchdog for STM32MP1
To: Yann Gautier <yann.gautier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Anshul Dalal <anshuld@ti.com>,
 Christophe KERELLO <christophe.kerello@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
References: <20260520160715.175032-1-yann.gautier@foss.st.com>
Content-Language: en-US
In-Reply-To: <20260520160715.175032-1-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 2a396fceac1cc5a5f4e
X-MBO-RS-META: tt54i1ydmigkaqwkit784f5gepybk4kn
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

On 5/20/26 6:07 PM, Yann Gautier wrote:
> This series adds the supports for Arm SMC watchdog for STM32MP1x
> platforms. This enables the required config flags for both STM32MP13
> and STM32MP15, and updates the U-Boot overlay DT file for STM32MP15
> in SCMI configuration.
> 
> This series also requires a patch from Patrice[1] increasing the
> CONFIG_SYS_MALLOC_F_LEN for STM32MP15.
> 
> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20260518-master-v1-1-37fd4df56609@foss.st.com/

I hate to nitpick at this point, but, it seems the two patches in this 
series do effectively the same thing. I'd say, align the commit subjects 
to something like:

configs: stm32mp15: Enable Arm SMC watchdog

And:

configs: stm32mp13: Enable Arm SMC watchdog

Even the commit messages can likely be aligned ?
