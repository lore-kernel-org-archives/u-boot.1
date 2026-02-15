Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529A8EF587C
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 15:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D4A80B98;
	Sun, 15 Feb 2026 16:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oB9IENgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B03C680FA1; Sun, 15 Feb 2026 16:58:08 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA8B8063E
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 16:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fDVtM2yYZz9t7s;
 Sun, 15 Feb 2026 16:58:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771171083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+V3E3f1ttv+fNncb5j5oUkSG8mSX/Yb/nb/08jW6tM=;
 b=oB9IENgjo016/TFjS4yY1xVRN/lbC1bWcJFB+izSwRSFqt0sf7ZPACH+P6xMIrhYFXMfuA
 sZHSZZ5xg7j5BNVY5M9b6wczMaNoxtBQ3zOpFUCVsvhWPXMMbbFNom78RIGvqreKKfS3BJ
 b1UByTUwXSq4OyvlPzbbpafJqrN1KkuW6gdeSwTVRQrkf5fAS6nRsk+ozuw+l8RxG9avV4
 TkGMdBNYwTQZpzvuZgvHY23Mg5wJmU8keUEAopctwHv1Q1VwF9unjMk4L+Hcq5eawN7bnF
 9xUKZaZ2/Vu+4Mr/tlBaBQW0Em+Joj8ElfyKWxo29QwiUXbPrBbLGTSDxVwIsg==
Message-ID: <d1791dbd-8d1f-4ecf-8b69-62b4f1fc85c2@mailbox.org>
Date: Sun, 15 Feb 2026 16:58:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG
To: Siddharth Vadapalli <s-vadapalli@ti.com>, marex@denx.de,
 trini@konsulko.com, minda.chen@starfivetech.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20260215123514.2288422-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260215123514.2288422-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4fffc66863097ec3d2b
X-MBO-RS-META: o8311j94zukg45gbr8gose6x6sgrk1or
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

On 2/15/26 1:35 PM, Siddharth Vadapalli wrote:

[...]

> +static int cdns3_get_otg_mode(struct udevice *parent, enum usb_dr_mode *mode)
> +{
> +	/* Create a temporary child device for using devfdt_remap_addr_name() */
> +	struct udevice child = {
> +		.parent = parent,
> +	};
> +	struct cdns3 cdns, *cdnsp;
> +	void __iomem *otg_regs;
> +	int vbus;

[...]

> +	/* Use VBUS Valid to determine role */
> +	vbus = !!(readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID);
> +	if (vbus)
The double-negation is not needed here, simply use:

if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID) {
...
