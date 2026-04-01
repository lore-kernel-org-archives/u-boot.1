Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11291112242
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1561E83CE3;
	Thu,  2 Apr 2026 01:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hi31RJTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2AA684011; Thu,  2 Apr 2026 01:27:40 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39E4800AE
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 01:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso32682766b.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 16:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775086058; cv=none;
 d=google.com; s=arc-20240605;
 b=cmhSDuUBc58xBU6PqYuV2kaYyIAde6j5eZgacsR5yiqf8GTSuA3R5bJX7fEEjk65hp
 jRRNu/tnqYoZZsqW73HxXGxLoL1opPKVprxHo8EU0fqfHadwMD8+yFxVjel/cv9yR0le
 AXKBaSrEzR/XWVd9ak+cEFpMbzUgcIv8z2YhPvB+cqSJ+t3+CION9z/8gn3vI0yll/of
 8bH6IFRSOLRAPbvRquMIv5Yf/gGBtdj32AgcAEgll6ICVTZmZRQb62SIBu3wUTOSZFA2
 q4+kRAKuW5dCB5XfUShwrn4cxNntXEHYcDmtfRBIrzZ/rh98Iq9R3eFMRTqGuphVUACL
 tOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zw03+DYUmCk49RpVkkSDkiFDC5R3LKFunMpoO8WJuxQ=;
 fh=wHy9g4kWrrNC0hKtYsUo6DhA5ubUW5Kqowp2vb0NpCA=;
 b=MUcFnzhwkKV94tqKvuy3R7Ac3XlNZP9Bzrr8+h6EvzPMktjZGUfa+hDBm9eWl8hw+C
 Fd5y9hKEximwmnRRTdo0f9LczOsfCIQZdhKr5U0CaMg/7tCnUSaY/CU0QshzxImvUJpJ
 GBzinphX+m3aCkr/ArPMwr/WzvkJedq3KaRhSEiV3EXk94akTIhrZXdaWkKRs0J595Nj
 /ROifvNmFWMyuYsf95/eoejn8sk1vilPPtGbbopvXKnUs3l7SpCZsqypnc3/JDXMNt0I
 TDn2mHDerl7QOatyZpZSzHs2xSLZ718rECl4wpoPgJr6eOWdirRUydo3vbfunSpsoztr
 3aVw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775086058; x=1775690858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zw03+DYUmCk49RpVkkSDkiFDC5R3LKFunMpoO8WJuxQ=;
 b=hi31RJTsT+L3s/+XtJ2QRdly+WubFG3KW7iIH/UiwzgdUuRynrtVMyrOhzk6GvZhfE
 HlWfQjTUr54EPr8wCXivyKz2VqJAdtneT2k8qByldJyDz5zKbd8g6MmKjAKt7JhPlnEv
 LNRSbXvgh0izcIsHhw74FOySJL2KQLR1GA3Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775086058; x=1775690858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zw03+DYUmCk49RpVkkSDkiFDC5R3LKFunMpoO8WJuxQ=;
 b=oOo6I4FkPmieaQosI+4lJDXylmcAy4RCK3rGNgyRBLVFXduUB1poy4RCCLZcBQmj43
 ML2cpcMzKNtszzrhKaE5+BjgrKVVtxWqlZbAHDjWTMNWB1H/wvsemSnHHxDxnnrB8QTw
 E57gNLgHOG2K/EzjAXSC9gUWaj0lEV2HxKDoLt0v44cU3snIdButSWqdpVAudrVkF4qw
 9rWsBO060jdBe65+yVvNEdGrk9W8Jf1X3OWh+1U6Ew4g55FYWJk5/cZKmUOs2dOdigxv
 b1ofBHJROiVfJ4wJU6MWXZA/CQLV0exrwxYq2qZU+MQz4ThLFpGFb93JYqSg49f4duBa
 gUoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLu3NyYPdhKeZ+9WzeF/7TZU+e1AhglzTsr4iw+lyQcGmHKHw4RcdMtBns9bTQPnpWMQambhg=@lists.denx.de
X-Gm-Message-State: AOJu0YyUCDFXFlOv5QEHTa8RO7ZxwMDcPlhVsuShUcHBOkAdNzTO4EfJ
 2o3P7AHWLuR8ygzGSrhgHqmIu0SkVv/cJNZswOQOwBOKPYZMxISraIqB3LVDlWnkImBCpfeVjMZ
 nUkmerDYw5hi5byXn9F49IoeT+sU/DGc+18rJ+omA
X-Gm-Gg: ATEYQzwm1IISauG6n3mNTmh8e4myY8lLNaVvJ1gTwSdm77N5R+1Imuie2o5z4eYWlBz
 Pqj6hodLypC3KMXxunSiFkxUPnaOEjkFdhDp95WLAbEyKtkc431dGwGrZ0ZqutVi2L2Vo6HPMRm
 XANhhGxsKev3wWowb42Qd1G4InYgBCaxBITcfItrXxACrVELGA22HTh2YZmGKwHgXQDMw/TuTNQ
 i/xN0F5TYOXhlFjkXOdfkz7vnZ4cSck/hm42lOSogzBO+EA+CF3LAxPMb9d6ZJ/lF5HWOzDGnn4
 I/y6oQ==
X-Received: by 2002:a17:906:81b:b0:b9b:308f:d9be with SMTP id
 a640c23a62f3a-b9c1393327cmr295756766b.23.1775086058206; Wed, 01 Apr 2026
 16:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260331075338.2391-1-ansuelsmth@gmail.com>
 <20260331075338.2391-6-ansuelsmth@gmail.com>
In-Reply-To: <20260331075338.2391-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 19:27:24 -0400
X-Gm-Features: AQROBzA85altYGSyh1w4WgEOQsCC3YEt3Q19aOYhelPBR8kee905HqnxUyjshQE
Message-ID: <CAFLszTgKOUxLSjTSBWkx5oPBGF6ryAoQmbupw71_Wk5Da+qrEA@mail.gmail.com>
Subject: Re: [v4,5/5] misc: fw_loader: implement request_firmware_size() OP
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Justin Klaassen <justin@tidylabs.net>,
 Harsha Vardhan V M <h-vm@ti.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Christian,

On 2026-03-31T07:53:19, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement request_firmware_size() OP
> misc: fw_loader: implement request_firmware_size() OP
>
> It might be useful to get the firmware size before reading it to allocate
> the correct size. This is needed for case where the firmware size change
> across different firmware version and is not always the same. In such case
> the only way to handle this scenario is to allocate a big-enough buffer to
> read the firmware.
>
> To better handle this, introduce the request_firmware_size() OP to get the
> firmware size before reading it. This way proper buffer can be allocated
> and dynamic firmware size can be better supported.
>
> Both FS and FIP lodaer are updated to handle the new .get_size() handler.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> @@ -92,15 +92,8 @@ static int select_fs_dev(struct device_plat *plat)
> +static int fw_get_filesystem_firmware_size(struct udevice *dev)
> +{
> +     loff_t size = 0;
> +     int ret;
> +
> +     ret = __fw_get_filesystem_firmware_prepare(dev);
> +     if (ret)
> +             goto out;
> +
> +     struct firmware *firmwarep = dev_get_priv(dev);
> +
> +     if (!firmwarep)
> +             return -ENOMEM;

This returns -ENOMEM directly without calling
__fw_get_filesystem_firmware_release(), leaking the UBIFS mount. The
existing fw_get_filesystem_firmware() does this correctly by using
'goto out'. Please can you fix this to go to out instead?

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -495,6 +495,34 @@ static int fw_get_fip_firmware(struct udevice *dev)
> +static int fw_get_fip_firmware_size(struct udevice *dev)
> +{
> +     struct fip_toc_entry ent;
> +     struct fip_storage_info info = { };
> +     int ret;
> +
> +     ret = fw_parse_storage_info(dev, &info);
> +     if (ret)
> +             return ret;
> +
> +     struct firmware *firmwarep = dev_get_priv(dev);

Please move the declaration of firmwarep to the top with the other declarations.

> diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> +     struct firmware *firmwarep = dev_get_priv(dev);
> +
> +     if (!firmwarep)
> +             return -ENOMEM;

Same here - please move the declaration to the top of the function.

> misc: fw_loader: implement request_firmware_size() OP

>
> Both FS and FIP lodaer are updated to handle the new .get_size() handler.

Typo "lodaer"

Regards,
Simon
