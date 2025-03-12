Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17065C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 07:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75246805D7;
	Wed, 12 Mar 2025 08:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="uTmhyQ6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F1480756; Wed, 12 Mar 2025 08:53:39 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47247801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 08:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 5EF6210000B;
 Wed, 12 Mar 2025 10:53:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5EF6210000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1741766016;
 bh=0QM0SoBtS10WofydYLPAQ+kYU2xKAPo9DJikRQqtZI0=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=uTmhyQ6GQkqQeclanddhZYzQCP9jtar7jVo4Hy83A8RRSquPih7gkCa1fnvCqzPpQ
 cyPRUHpfcrweHzq5bHWVx0wRhC/x+H5IjFQ4c0sH/3hTtp34wbSa/HPfrXxUvD+kDD
 a1SJVUqxxwZ3ev01pU1UMUTwtqBlYhwcaiAeOCmXB+HmBrO598VAiAKw3bmJIX9fz9
 Ho/IkXsrtyegfN141nQJE7z7G0e2saRBm8+jcM9jnBiDlFoMtnZaaEgZ5lRsYDKvRJ
 RDSAOSovBXYRlqMoY2rD8pr60vHeCnCO2XjHsO6YaCSFCOdIMyAJ0tSPK2k19THT6g
 jnRLJK07mUVsQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru
 [172.24.201.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed, 12 Mar 2025 10:53:36 +0300 (MSK)
Message-ID: <b163f4f1-455d-465d-6fc4-3b9d32642c94@salutedevices.com>
Date: Wed, 12 Mar 2025 10:53:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH RESEND] drivers: usb: gadget: composite: add checking for
 interface number
Content-Language: en-US
To: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>, <lukma@denx.de>,
 <mkorpershoek@baylibre.com>, <marex@denx.de>, <trini@konsulko.com>,
 <l.majewski@samsung.com>, <kyungmin.park@samsung.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>
References: <20250203155505.3298965-1-vvmitrofanov@salutedevices.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20250203155505.3298965-1-vvmitrofanov@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.28.65.111]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191693 [Mar 12 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398,
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2025/03/12 06:04:00 #27719751
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hi, sorry, pls ping

On 03.02.2025 18:55, Vladimir Mitrofanov wrote:
> Some proprietary protocols uses "w_index" field not by the rules.
> When we set "intf = w_index & 0xFF" variable without check it may
> exceed maximum number of interfaces. Not all code cases below check
> the range of this variable. In some protocols it is usefull to
> guaranty that "intf" not exceed MAX_CONFIG_INTERFACES.
> 
> Fixes: 7010f5b94fa3 ("usb:gadget:composite USB composite gadget support")
> Signed-off-by: Vladimir Mitrofanov <vvmitrofanov@salutedevices.com>
> ---
>  drivers/usb/gadget/composite.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 04b8541993..4bb2afa833 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1011,7 +1011,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>  	u16				w_index = le16_to_cpu(ctrl->wIndex);
>  	u16				w_value = le16_to_cpu(ctrl->wValue);
>  	struct usb_composite_dev	*cdev = get_gadget_data(gadget);
> -	u8				intf = w_index & 0xFF;
> +	u8				intf = min_t(u8, w_index & 0xFF, MAX_CONFIG_INTERFACES - 1);
>  	int				value = -EOPNOTSUPP;
>  	struct usb_request		*req = cdev->req;
>  	struct usb_function		*f = NULL;
