Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B5DCA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 09:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7A9839C7;
	Mon,  1 Sep 2025 11:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1756719492;
	bh=5CEd3FypuqiAYciCThE82tEhlmSBzp48UGK+x51OD0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UVZGpKWibFv568TkRnPY6vlqczFk7ucNtiGzf/l4AaYWQkjv2RXnaDLouMrCkPwHW
	 lk4G1fxCVuO0hdMsjDRdfpKJOLInYyiXoM3GbgQIHfvyKtSKCEV8BvnxC2NikY5V1e
	 XL6YQDnb/AhJ5Smz2luSX4gcSsxZzfIVOvURxOTeQn5gVnidHzHR1UwguwpZ7uR+r5
	 INEWimavq89TX5xTX1Tqygk4O7/eM+sDxvFPCOV8ceJNw+o+0iN9c+6cCgGqDBH0kk
	 i3vb2TCXcTkjS47xK79zeV7Ki4uBerPgPrX32FYHDJEv8GYJB4YocxlYn3v59vK1Ur
	 /ofYUIs5UzDrA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D73B1839CB; Mon,  1 Sep 2025 11:38:11 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 729F083965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 11:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WxerICDL"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 670251038C102; 
 Mon,  1 Sep 2025 11:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1756719488; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=5CEd3FypuqiAYciCThE82tEhlmSBzp48UGK+x51OD0U=;
 b=WxerICDLfhUIeMaoJKdwpFPHRE04xuf0+1GXfNabSgVj7OQohw8gGkft7KdF1IIdDtDpos
 Hxyjtr+bCWwbGqGSX60ID4D15Q7zmK3v6gG/T5eOXB/UxIy5YpleuKu+tLotITCAcJimDw
 lnX86ohy4WRj4+3JaZkEbeJNObc3VuZOqUj6+QjFE9uHP5FlgSgB08RR32HTvQ4i4JZjr/
 aNvp/jyBfwEadYNGs33nQ2Dx2bZ1U5MNFhCXBTs+yndKpwCPJaSlXEmxwVWbNLU81EpR3L
 cNlw5VdIZ/Ol4WJz5iaE3WssPk2Yy8QD4SE8cbLpZ0FwxBeVQMb3tFD0WwAWKg==
Date: Mon, 1 Sep 2025 11:38:04 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Message-ID: <aLVpfP1anv7UJzzQ@pollux.denx.de>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
 <20250807201142.GC124814@bill-the-cat>
 <4813ce12-ad82-4170-999c-e5f816a42708@mailbox.org>
 <20250807232421.GD124814@bill-the-cat> <aJmuxlTEFT4R7HR_@antares>
 <83fd6db4-dc76-4f5d-9abf-9673b81eea14@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fd6db4-dc76-4f5d-9abf-9673b81eea14@mailbox.org>
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

On Thu, Aug 28, 2025 at 11:44:50PM +0200, Marek Vasut wrote:
> On 8/11/25 10:50 AM, Philip Oberfichtner wrote:
[...]
> > 	CONFIG_HAS_UBOOT_WITH_SPL_SIZE_LIMIT
> 
> What does this one do ?

UBOOT_WITH_SPL_SIZE_LIMIT will be required for my currently pending mips
board support, see here:
https://patchwork.ozlabs.org/project/uboot/list/?series=468232.

In the next version, I'll include all size limit related patches in THIS
series. Sorry for the confusion.

Best regards,
Philip
