Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FDAC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 10:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E76988742;
	Tue,  7 May 2024 12:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ORmwfOfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F59588749; Tue,  7 May 2024 12:55:03 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005D388719
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 12:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2b432ae7dabso860051a91.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 03:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715079299; x=1715684099; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNxAWlu36Kafh92k52agZvPB70ZQomrcEgFLyMA4D30=;
 b=ORmwfOfop1aa2ir+WnGQdu27u1XLDIcm97YW6swVCv4aUusZjtVntbyG8dBqDBKawp
 ohjJEYT+OMWIl1VgV8ha+foq1GNVK5cW++n64px5WG001dOnVmUqgryQqx2Te0m6T5Ox
 nzKe0UZkQ8VaOfIuwptyZfw4Bt3MB/UC2IFAqkaerQz/fxfOe2hdmaJh0E+WHMkki5k4
 WoI30oYo5Hrm49VxAlOQHfrPEyyENzFSLYo31Qd2JxAMOnQHPwcaZQAwCht7w432iSI/
 Ft2Jm3oDgGALBb0kVFlNqiZ8caopH9n8mddhC0dHJ6Otgnj24DDfp6vWWjvKKXFT45wK
 Y9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079299; x=1715684099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNxAWlu36Kafh92k52agZvPB70ZQomrcEgFLyMA4D30=;
 b=sucI4aLpqPwjGWMTEbr7NikMhcmX1CZpKloJ1kbIn8pSzQptLgU5Pzjb9CJzUAR9S5
 FK33+0LzDBtmv9jTzjtqtijOG2GFGqAt18QZjOdNetwPREV2UoZXV8ccqKxRFjFXAMzs
 xzIaua9dmKNMH9u8IpER3F93w9hnQvyVyZQVJL2fzHegbvqhOyLVgGlkMZ0674Tv5c77
 rYyBQ43p8n4VaYcfYVd6+ItgXPAsYg2gDMVxaZD4njsydxQzUF269C6Whqu4jjXx8P9d
 /bsBoO/Y3tSsh+oPcnugEDtUHq0XCDB8dpoMdRgXoKA4B+Xwj/xJ9zLDjsJZHvbWIUMs
 Faiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2XHQxbmavr+/mUcYqMz0qy6uYaJl/fX59XCZHYQjiub4a63P3OpgIsVUvtwVsYd7nZPKCbXf33o9n+NHs7CB1ky3cTg==
X-Gm-Message-State: AOJu0Yx2I5r/GNc0NLRsNtOJHLbjZ92nAKKJeQ7yo6t8TuqTCya03fss
 gT4m9jVar/IKi2CzmehVxqSZ/XIR2JpMV0jqDC4JXukKgGbG3S2L4E4Vn6aPMgm7DA16GlYwVbp
 OW9CAF9TUmmVqmOv7wqO5aWbgBig=
X-Google-Smtp-Source: AGHT+IG5TuZbw3kIUDPJTM2Rc3ldgErkf5oeAq/vpZNk0RmgQqBm5GNHmvsswkTPG0/qBvpvHy0KJwBp6DPJ2gDWseU=
X-Received: by 2002:a05:6a20:841e:b0:1af:667c:466a with SMTP id
 c30-20020a056a20841e00b001af667c466amr15278084pzd.4.1715079299356; Tue, 07
 May 2024 03:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240503-wip-bhahn-bspimx8m-3196-v1-1-855c7242151f@phytec.de>
 <CAOMZO5DgBF7ULn4Cp7VA0c29A5TKiJrxwoBEXSbYPu-9M4nzJw@mail.gmail.com>
 <a4808081-9ae8-4556-ba5e-651e5b035c6c@phytec.de>
In-Reply-To: <a4808081-9ae8-4556-ba5e-651e5b035c6c@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 May 2024 07:54:48 -0300
Message-ID: <CAOMZO5AiY=7+oLSD_fSEfe1W377U_p1hYvADAUeDH+b3Qfkivw@mail.gmail.com>
Subject: Re: [PATCH] configs: Make USB_GADGET_MANUFACTURER consistent over all
 PHYTEC boards
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Teresa Remmet <T.Remmet@phytec.de>, Yannic Moog <Y.Moog@phytec.de>,
 Tom Rini <trini@konsulko.com>, 
 Wadim Egorov <W.Egorov@phytec.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Parthiban Nallathambi <parthitce@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Benjamin,

On Mon, May 6, 2024 at 7:52=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:

> We are not registered at USB-IF and therefore don't have a valid
> VENDOR_NUM and PRODUCT_NUM, so we rely on the VENDOR_NUM and PRODUCT_NUM
> of the SoC Vendor, so the correct features get enabled by the driver.

Ok, understood.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
