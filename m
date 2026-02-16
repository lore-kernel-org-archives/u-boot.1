Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34EDE81A29
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 14:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0BD180FA1;
	Mon, 16 Feb 2026 15:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TaxSbOkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64F07831AC; Mon, 16 Feb 2026 15:07:32 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F94A802C1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 15:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fF4NJ1ZF6z9tHg;
 Mon, 16 Feb 2026 15:07:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771250848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AP80DOt8SIga+Zl4UlNfNI6Kn8UX5GwytWcaivg3QvI=;
 b=TaxSbOkL0ptavD56cPsertFtCVJ/B2SOUP/eGQPtXI9CaemQZgpFH5T8yV+6freuQKJvKZ
 5nMDpIrTdKhnsI9HoUA0QE0z6800fsB/jVICiUcDlVGROKZg/VJMkeqUYiFNff0dumI93q
 rskGgA9FeB5RA1lBWPnxQhxeSxcwbqS4dzdcYi8yPBjEHKEotxBSgNwvYlJL6gxGvh5VYB
 V8Qq0k7d+5kc3esC8nazWU39PI+jfHym6D2YU7GGGREl0ShuhvrNrppJcReTznFb20vutF
 W0r15QTjPAgrUFd4cmlPnLccobrcUep+YNsTGJnOfRx5lECEhEQ3hBRdjZ/vQg==
Message-ID: <eb5d39a3-f8f4-4545-93b2-3a25044f5df8@mailbox.org>
Date: Mon, 16 Feb 2026 15:07:25 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4] usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 minda.chen@starfivetech.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20260216043459.2467850-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260216043459.2467850-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zcib3ecixf4bwwwp97qfcnfng133gfbm
X-MBO-RS-ID: e7ef9d505bd481a269e
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

On 2/16/26 5:34 AM, Siddharth Vadapalli wrote:
> The cdns3_bind() function is responsible for identifying the appropriate
> driver to bind to the USB Controller's device-tree node. If the device-tree
> node has the 'dr_mode' property set to 'otg', the existing approach fails
> to bind a driver, leading to loss of functionality.
> 
> To address this, use the VBUS Valid field of the OTG Status register to
> determine the role as follows:
> - If VBUS Valid field is set, it indicates that a USB Host is supplying
>    power and the Controller should assume the Peripheral role.
> - If VBUS Valid field is clear, it indicates the absence of a USB Host and
>    the Controller should assume the Host role.
> 
> Additionally, when 'dr_mode' happens to be 'otg' and the STRAP settings
> are not specified, use VBUS Valid to determine the role in cdns3_drd_init()
> and assign it to cdns->dr_mode.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks
