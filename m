Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F535C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 12:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2A2885BC;
	Tue,  9 Jul 2024 14:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElYOtqGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F65885A5; Tue,  9 Jul 2024 14:25:55 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128EE885CF
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 14:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-367a2c2e41aso2559900f8f.2
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720527952; x=1721132752;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHHo6DB9bwbMdrvvXMvaMdXmbZxAzWTFZJI/e0HuHXo=;
 b=ElYOtqGcsrrAWaXEQDzlHFsglIjR4QrjfFgpdwwdR4osG0npJs/SyLSHbxv1zIcfjj
 W0CRx9ovQiq1l5mddO1dgDR+YEU019+ISnLWcgI0ue/pPphVpBffuDe6/dLG9JlFdEi9
 strjTx5STl/QiQfJF81+5FnL4Di7Jnpi0vbFikePtlrxlu4CCVyh6yxV0U11sX/BujYl
 jDcSRoDPK9y1vb5+gGYPJuICLln3zuy6fuU7l/UVYzZkhe+QKykUmEj6X3G39egI2Jbm
 YOSB71DQQv2sHekyQvQBnCXOqaaEw9vKwGaPGfEIrVmpzx0wBuJwcaWrxDOA92K2ZQvA
 BWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720527952; x=1721132752;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OHHo6DB9bwbMdrvvXMvaMdXmbZxAzWTFZJI/e0HuHXo=;
 b=waEA1XpCpHpAaS7EC2EMBP9g3VsFn0urtgWti88Y3/u8zxx5ys2kHsTMbf8haBoSRO
 qdILxw0MNbGqUuV1n3ubI6l3u9aWoEMjqK8DJyi5RZ572hkVjLT3QMrUQPYtdH/7OmtM
 IKEG9Ez+ImV3V7i78Y91vXs17giuIzv+GOktHI4Vclc+HHU2r6/15tD2jwNodIAqdLsM
 uYQTMFiAnOsvTpznNLDJBrjXzeuIvftewQ7cv2xdgmJm+LCZyd6fQtvIYXaPMKGFI4y9
 qsYO6k4FoDDyeLC+B3RwWABG8f8Zszruh/dplwU6qzO/mEViRTOf02XLeGxWT2qBPBGw
 UBrA==
X-Gm-Message-State: AOJu0YxSEitgzTTcqsiIvukY8NMPh85NVx1SJRUqkc64EGVuciHf/4uz
 1CBux5mWt1eXU1HbHePbbEA2c26jd2ljwJXQrQUTeni2V93un7ztY72OU+ck/tE=
X-Google-Smtp-Source: AGHT+IFc1YdfV6HtURHPMvgWiETEqjO3Jk8kmG/llxAdOaqXBVxCVV+dous4oVACv1EMKAspzT82WQ==
X-Received: by 2002:a5d:47a9:0:b0:367:8f84:ee1d with SMTP id
 ffacd0b85a97d-367cea4622cmr2130327f8f.8.1720527952353; 
 Tue, 09 Jul 2024 05:25:52 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7e039sm2451640f8f.2.2024.07.09.05.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 05:25:51 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] eth: asix88179: reset during probe
In-Reply-To: <d8943137-1748-4f57-8a85-0561d2af05d4@denx.de>
References: <20240618145759.3296876-2-caleb.connolly@linaro.org>
 <87v81fhsbp.fsf@baylibre.com>
 <d8943137-1748-4f57-8a85-0561d2af05d4@denx.de>
Date: Tue, 09 Jul 2024 14:25:49 +0200
Message-ID: <87ed82iwfm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

On mar., juil. 09, 2024 at 13:13, Marek Vasut <marex@denx.de> wrote:

> On 7/9/24 10:39 AM, Mattijs Korpershoek wrote:
>> Hi Caleb,
>
> Hi,
>
>> Thank you for the patch.
>> 
>> On mar., juin 18, 2024 at 16:57, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>> 
>>> In some cases (consistently in my case with an embedded board) the
>>> ethernet controller will time out on the first init but always succeed
>>> after reset.
>>>
>>> Let's reset the controller during probe so we always start with it in a
>>> known state, and don't have wait for the first asix_wait_link() to
>>> time out.
>>>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> 
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> 
>>> ---
>>> I see this behaviour consistently across three Qualcomm platforms that use this
>>> controller.
>>> ---
>>>   drivers/usb/eth/asix88179.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>
> Do you want to pick it via usb-gadget tree or shall I pick it via usb tree ?

According to get_maintainer.pl, it should be you :)

./scripts/get_maintainer.pl -- drivers/usb/eth/asix88179.c
Marek Vasut <marex@denx.de> (maintainer:USB)
Tom Rini <trini@konsulko.com> (maintainer:THE REST,authored:3/3=100%,added_lines:1/1=100%,removed_lines:2/2=100%)
Mattijs Korpershoek <mkorpershoek@baylibre.com> (commit_signer:1/3=33%)
u-boot@lists.denx.de (open list)

If you are okay with that, please pick it up.

Thanks!
Mattijs
