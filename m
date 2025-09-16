Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A8CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 08:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D7583071;
	Tue, 16 Sep 2025 10:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dZrLusBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F3D8318E; Tue, 16 Sep 2025 10:10:15 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C775A82C84
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 10:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cQvhf5nyWz9sZK;
 Tue, 16 Sep 2025 10:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758010210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFhRxkL3UO/lL1TQzAnc/56ddyOyYcOan+bmJcqKTbM=;
 b=dZrLusBgWFUmhjW6SfsW0TlwOWvoidNlBtH7YkyQ0jkks/LdsmghDvT1W8gJRRIT0AoxTs
 m0DwqOVExvw3TiJcYJ+c306/RZvdHPPys/MpaPMe4stwzDKvnfVQYgPJc6S4POXNu38Hlz
 xi1RCH1vx5yiVpGBGePgE0ylR9YX9CsI5YTADD/PWWXxtY3t0n9bhKdmlLxKNJorXxHmy7
 fq+K+JPcxcLYZjv43khV+x3QcB67IqitnID3B6YcnyB6eeYWuLAtKTvbWbRarPldgM1gAr
 N1a4RQmnLiW8Y6LcZuuu+AcKmNo2lXY+v3KtZII5PFkjmYJvRT0ylh5QDQdchw==
Message-ID: <348629a6-123f-4d6f-b0e2-6f01da3ae47d@mailbox.org>
Date: Tue, 16 Sep 2025 10:10:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: onboard-hub: Make i2c-bus option
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <59931e60e6ffe1f3e7605037ea3b268b9bb1cf7a.1758009455.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <59931e60e6ffe1f3e7605037ea3b268b9bb1cf7a.1758009455.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: aad63d8af3c4e8a41a7
X-MBO-RS-META: 9uujrk7nhn6r1tc87z9xegfdofkhcgno
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

On 9/16/25 9:57 AM, Michal Simek wrote:
> DT binding doesn't mandate i2c-bus as required property because hub itself
> doesn't need to have i2c connected.
> It can be in standalone mode that only power regulator and reset should be
> handled.
> Or hub should be configured via spi interface.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   common/usb_onboard_hub.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 70fa349a8817..c025200ca71b 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -62,7 +62,12 @@ static int usb5744_i2c_init(struct udevice *dev)
>   
>   	ret = dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle);

if (ret == -ENOENT)
   return 0;

if (ret) {
   ... handle errors ...
...

Also keep Fabrice on CC
