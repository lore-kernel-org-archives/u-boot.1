Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F67ECA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 09:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67AEA80107;
	Mon, 18 Aug 2025 11:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1755509406;
	bh=Sck+pMaNyqq3MqNyffK1X5N3hUwa4rEClo5L6/mU3Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WeFZ8CECPt3DT6UGjvZ7G+enB63nq5eeKo1H7+Qb2y8I+jyCBXyykUvm8cyYNPGHN
	 /mqD/3DsxYndabaLnueoAoK4UJGlWRwNAd5Y1pSSwFEPlcEPPZ27Di0AfsEb4Grw+q
	 xfIFvnATzUSxA90+7pvNcQWg3YvIKYeV3hVN+KT7kQQgnrrP/9beO4Oou7nfW1TELL
	 5OZcHSvDcH5I1vqS0VitgXWewboQdxo7+n4B9IPvn5aoJ5C51cd3SmYHCKKCI4CzW6
	 J+/dMlOwrBNUURoQhrtXzP2FfJe/CJphMqtRMT6pUScGh699omhAlDTpoJSKxsbo49
	 qmcGz1nSb25cQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E6C80194; Mon, 18 Aug 2025 11:30:04 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E684F800D7
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 11:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QVqCk5Il"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1AE851038C11C; 
 Mon, 18 Aug 2025 11:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1755509401; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=Sck+pMaNyqq3MqNyffK1X5N3hUwa4rEClo5L6/mU3Io=;
 b=QVqCk5IlMqy97ZwUIVRo5byBP+PImSqgBdnam/QO/Asz2ZxTfL1GMBgE6RE7TQEa9jrvHr
 16fXBSb04GgxBgtOhevlhzsekJsu1E16hs+Wfe3JHk3l0Bx2nz8FnxwoMZg09FVJ+jbzYa
 FiH/gjSnktxDD4y3UMk0hstPNEnu7Uh61V+0GL6RoTky5fi1Ra5InOnA+SZjkudAULnI2N
 Eqs877tqs89LOMZopZY8zvezi17GRu81PFUxz1BrLxZMPS4eZ8lfnnj6GpiVYqVIpyvc6P
 gGEhhMd1WE19mrAZWig7X/KP9hnKIuuji88Edo1jk3rql82sShd/3OU8QLDRpg==
Date: Mon, 18 Aug 2025 11:29:57 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Message-ID: <aKLylfvzdfebJRWe@antares>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
 <20250807201142.GC124814@bill-the-cat>
 <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
 <20250807232421.GD124814@bill-the-cat> <aJmuxlTEFT4R7HR_@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJmuxlTEFT4R7HR_@antares>
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon, Aug 11, 2025 at 10:50:17AM +0200, Philip Oberfichtner wrote:
> The idea of treating a size limit of zero as unlimited has been common
> practice in mainline U-Boot since 2019, where CONFIG_SPL_SIZE_LIMIT has
> been introduced. The same logic has later been applied to TPL and VPL
> size limits.
> 
> If we want to consistently stick to the HAS_*_SIZE_LIMIT approach, we'd
> have to introduce four extra Kconfig options alongside
> HAS_BOARD_SIZE_LIMIT:
> 
> 	CONFIG_HAS_UBOOT_WITH_SPL_SIZE_LIMIT
> 	CONFIG_HAS_SPL_SIZE_LIMIT
> 	CONFIG_HAS_TPL_SIZE_LIMIT
> 	CONFIG_HAS_VPL_SIZE_LIMIT
> 
> 
> Furthermore, the extra lines of code in the toplevel Makefile, which
> could otherwise be removed:
> 
> 	ifneq ($(CONFIG_BOARD_SIZE_LIMIT),)
> 	BOARD_SIZE_CHECK= @ $(call size_check,$@,$(CONFIG_BOARD_SIZE_LIMIT))
> 	else
> 	BOARD_SIZE_CHECK =
> 	endif
> 
> 	ifneq ($(CONFIG_HAS_UBOOT_WITH_SPL_SIZE_LIMIT),0x0)
> 	UBOOT_WITH_SPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_UBOOT_WITH_SPL_SIZE_LIMIT)
> 	else
> 	UBOOT_WITH_SPL_SIZE_CHECK =
> 	endif
> 
> 	ifneq ($(CONFIG_SPL_SIZE_LIMIT),0x0)
> 	SPL_SIZE_CHECK = @$(call size_check,$@,$$(tools/spl_size_limit))
> 	else
> 	SPL_SIZE_CHECK =
> 	endif
> 
> 	ifneq ($(CONFIG_TPL_SIZE_LIMIT),0x0)
> 	TPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_TPL_SIZE_LIMIT))
> 	else
> 	TPL_SIZE_CHECK =
> 	endif
> 
> 	ifneq ($(CONFIG_VPL_SIZE_LIMIT),0x0)
> 	VPL_SIZE_CHECK = @$(call size_check,$@,$(CONFIG_VPL_SIZE_LIMIT))
> 	else
> 	VPL_SIZE_CHECK =
> 	endif
> 
> 
> Is it really worth adding this much of extra code?

Ping @Marek: So are you in favor of this surplus of code?
