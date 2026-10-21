Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C3606A326
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tpuawEfm;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=SnxIi4i7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7F144085D;
	Wed, 21 Oct 2026 02:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pdrM-C4EWVvn; Wed, 21 Oct 2026 02:21:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 200CE407F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792549315;
	b=NpEbJvi6O8tG4ii9D1dQLbTOasKZGNVBqJJrSeOugu4XSQ6fZQJp/TiwbgqKlB1ptDSc
	 Yjv4Kyx2Q+nT13i0p9VSol/bL1NW1pSJR82UxgSdQ7X+xKvxu5TF/eMT2Q9hXsobhbRnV
	 xoqLDxAtBk5rZ0mZ/jKj/1HVDDmCa+Zj63bqAFRjcbt9+Q8sUuzPrHB9GSJq4VgXOM6dK
	 ANiRt+UjjOQTrEsxjbhSFRR+c3QY/kameaRaAF2fv+jqnKnG3pSX0ufox+I5B54rqnw4S
	 UZk8UYQtrextsI80X1JHUn4UrqRLdL0cjrNyRVNPj67N/xSywmQLSkmAsRcQMf6quYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792549315;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=APmDi3acPCA6WyHbCZkaGN/uSm7wgDmwQhTZcEncHQQ=;
	b=LJVWOttGAGVKyb/pqxfycD9OSqDx4NBq8wD0F2luT6wVNEGmi/5F4Bkh3LW2HNRTCzw6
	 L3VqSX5Sby563xmiNC87SP/Lmb7Ma1Ne5GFNxVi24lsvxpDx/ZgNfC/5VX6WDhQ5SnaCl
	 PPN3ws6GbO3e94zoOY5YwGyE+zvONHhKIWx8aFInK/KXeEQZ6UnHKmGyWrkz7qZBhf4PE
	 vJYFGz2Jco1LU7HbqTVhv9jcdvaosmVE8xX5flKQz2gYPfjs4+4nuGIPMRTISw5oFrXkw
	 C6uWs3twcU825rhjOC3Sb/cFoeCX/fX3Zf3D6kFtgByaMVtKnhPi1XAGetS0O9nAFKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792549315;
	bh=APmDi3acPCA6WyHbCZkaGN/uSm7wgDmwQhTZcEncHQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tpuawEfm3S98F6w4+jNwKwPYsuHM/P5oXLMbOgftDReo/PRhZMQ5Swq5l7eBLTJY/
	 Dz1qh4JD3xNiE1mM1Wo03C25hSpP//inMWyucnnNyAqzlVIx3MMAMa9XedCyRJy4Hv
	 1ahY6lFbQpYqaqWrR0ttSpUdncMZjv5IgciZ0RfIE3ebdp8X6rGzQPlJhbVNcJzAcc
	 LvkeOlm22fPrYQR7Ei6SjagyxrGFebMgAvsxeuqmnUOzz7l9Qq8HEutFDSc4g4GMnc
	 Ht3iSBFKPGCdH3cTtVEJVh4SfRI6mTqdJDyHRMLlVSfPTC/rg182Df7j+5nrxZnIYj
	 8M0xjWOK7MiYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 200CE407F5;
	Wed, 21 Oct 2026 02:21:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 79A581AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BB4A40060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kq5OQ5trtBJw for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:21:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7448040112
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792549310;
 b=nkmHRDrQ/rA1yJe+hZtoS+l/pUrJh17m0H3dvZtWFZmfuO1uiFGlCWUeF0I+8DzOo9AZ
 2LCLkqbdRDwFylMjmV1bjrKVbaIVhxqjWcpBDTjnfVCQt6cTo76mNfJfSvax2LEOFVvF4
 XrLKApTXvjfGwZZJUTNNj8Bk1cWhTbAV8hfPEAf9b0sf/hRy0npdDt9823eWBp3Y+2bBX
 yRZumm1Cgt22VzoRP4ixsHQ8RjCwL7Xgl00/twKGritDW/P/XOuV9kP5kUbO4/oyxDotH
 jokyYiQimXvF4rUGS003uJHOvNSHH3nv3YfQWD3N8GcUbOfy52h90qpocWrP15fBKBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792549310;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=APmDi3acPCA6WyHbCZkaGN/uSm7wgDmwQhTZcEncHQQ=;
 b=IJXj/XMFC+5/WOvcGwogAkkc3XDH1bO4XH0QDITlpy+tb3hui4LLjZs1CvB6SoavJxWR
 6WNcOjFYuaeG64LqBIQhExKWZxAct2xu6+f1fqIJ4grCKJcg0Rv9oeor2xfkg7OPATSSv
 gofyDtJJrhulxUQqtZ4Txe73pbvjW9fGyuvHQwyk9X+0beFm6xtwgBeeLdtRgxRm9iy3A
 +IIQPWxVXS+H/XArdxeHaQMYUFTZyiyHt6pz8uS/eD6WPg9pbCB0GX24x3sQ98MKFms53
 lQBXY88kxoQNvD4oPS8rbOH0GiAlQ6bJ1q/bIA6fcOZ7uy2R+EGAPrvpuMK1Qsuj2Kw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=SnxIi4i7; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=SnxIi4i7
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7448040112
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:21:50 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4j8Y226C1sz8vVv;
 Wed, 21 Oct 2026 04:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792549306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APmDi3acPCA6WyHbCZkaGN/uSm7wgDmwQhTZcEncHQQ=;
 b=SnxIi4i700ygkgae9Hyw+H9WPBMUqOutlEShtlBjOUoFTRUqw6ONeSpFZMqcK9aeObDCT9
 DAxiE5v0CzaQb626lE8eGiIvSQC+KVAYNeKishACvAsqHj58ErElcjd7NZDyO+dswJpEqo
 5BId2lhmIyye0qf3B6b6hQqTb5RmJ/ON34XvOFIiMAxPnKr0ButrchrnHChgF72h40hhy6
 3ZJ+ADCWn46qKCJyYwRSYxmk03znMcHYwlwVZt//VcNKclVYPV5gzXITABj28A7cYmGXcJ
 9lluzM99LlAMRr22J83vXHhaDY+y7RGnNp4He4KlSl0zRj8/B66beV179hvO/A==
Message-ID: <38372dc0-845b-428e-b26d-91c080ad6dc2@mailbox.org>
Date: Wed, 21 Oct 2026 02:13:04 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] usb: ehci-vf: enable the vbus supply of the port
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261020101608.2818265-1-mehmet.fide@gmail.com>
 <20261020101608.2818265-10-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261020101608.2818265-10-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8831cbf7d2df8f3178c
X-MBO-RS-META: ek6hkxn4x1fno7odkipcewta938zppxj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 12:16 PM, Mehmet Fide wrote:

[...]

> +++ b/drivers/usb/host/ehci-vf.c
> @@ -20,7 +20,9 @@
>   #include <asm/mach-imx/regs-usbphy.h>
>   #include <linux/delay.h>
>   #include <usb/ehci-ci.h>
> +#include <power/regulator.h>
>   #include <linux/usb/otg.h>
> +#include <dm/device_compat.h>

Keep the list sorted.

>   #include "ehci.h"
>   
> @@ -42,6 +44,8 @@ struct ehci_vf_priv_data {
>   	struct anadig_reg __iomem *anatop_addr;
>   	void __iomem *phy_addr;
>   	void __iomem *misc_addr;
> +	struct udevice *vbus_supply;
> +	struct udevice *dev;
>   	u32 portnr;
>   };
>   
> @@ -221,9 +225,9 @@ static int vf_usb_of_to_plat(struct udevice *dev)
>   	return 0;
>   }
>   
> -static int vf_init_after_reset(struct ehci_ctrl *dev)
> +static int vf_init_after_reset(struct ehci_ctrl *ctrl)

Is this rename necessary ?

>   {
> -	struct ehci_vf_priv_data *priv = dev->priv;
> +	struct ehci_vf_priv_data *priv = ctrl->priv;
>   	enum usb_init_type type = priv->init_type;
>   	struct usb_ehci *ehci = priv->ehci;
>   	int ret;
[...]
