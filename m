Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD40C3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 10:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 220D38824C;
	Tue,  2 Jul 2024 12:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IkJMyIRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02ED6883C3; Tue,  2 Jul 2024 12:53:21 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222B68824C
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 12:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52ce6abc2dbso416968e87.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719917598; x=1720522398; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxzGoILhYZpbjbMXMYbdmj5WY3SyxC4rPVMFQYTe+Aw=;
 b=IkJMyIRMdzQFleB61gj43t4L1OjfLVN5aXD+3P2yogXQGuAbm5OyJSVdr2A5FhYOsb
 uQe54JJTNHtZ6ifhXLHi/hXp7VTkNqUPEPf2JJS8UtQeAwW1zVBCJjEPiMuwXc4rTCtv
 FNXtggyuNwpI/p1w+XdCMVmjjri8tZOklwrTTebraJwyfgcyp4bs0ahs/dtT7VCGhfHh
 5K7LXNWcVV5tCtuTUv+Ut0W8Yi/hQ/DhQXSQF59mlMhoqbyH8wd2VoCHYguKq7dYpd+U
 JSUR9uU0X6yhof3pE6HzkanzoIbbZXW6HuvBptHO/qU7RFxwvnFca1gEmanKWi8/eObd
 ZxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719917598; x=1720522398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxzGoILhYZpbjbMXMYbdmj5WY3SyxC4rPVMFQYTe+Aw=;
 b=VrFN7r2cK9agih/I6gpLdAOTXNyntkC02YrnhHaLAIpnomKpJebL61YPE6jAV0Cu39
 1yeh8H1hypeaz9sujqnk9zP8gtVX2oRkpgowl67U1Wxx4J5G/ol7FQvdLW0iSlGLpjOa
 eVQ2UP611Wq2IWqufSE0jySreTnEyImhrtfN5otgfOKy/xwzt+aW+Mfgjo8INMR0hkiZ
 9+jLWh/ohQdERLBuo1zxjf6KfrDfK2suAL7dhsok//DBzzxBDGHOFkKdur59stybXETL
 92G2niX1nB/5lvsyYpW5IfmqSKqgSz89/8L5YKaztKqFZGGBes7yFPOLM1krrZ2A8lSO
 Dx1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnx9m5DD5XHKlHFOO04aybr5vyOoFJWRbesHJ+H3Zk+MghxRs5Qa0yk8doexzgs6c7FfZHfx/8ZUqKIx5JCst2ej8K8A==
X-Gm-Message-State: AOJu0YzHPXgXMkKLSK6ihlAwzxj10qexVhv4HZ/q8UZuv5JTM3Ovboh7
 kWoWtaaNFE0jhU/lRRbkW1snCRg0iCXAsS0KijAYv4Or+NAKatejJjXXFTDeQpzD2yvceIdFf/9
 UbrQ4ok5iEzOo8Y2nOW7js9Y/2LTHEd75
X-Google-Smtp-Source: AGHT+IE2h7amaLM2DhpAVCdo4sjwCI/GxNPfDQ1kDCgLRSb3kpaLto24cx+iKlUY6LNYM6BJvYdfTV89Z6efnKIFRcc=
X-Received: by 2002:a05:6512:15aa:b0:52c:dac6:107 with SMTP id
 2adb3069b0e04-52e8272d8c9mr4378131e87.3.1719917598052; Tue, 02 Jul 2024
 03:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240627112232.99507-1-mikhail.kshevetskiy@iopsys.eu>
 <CAOMZO5CcOA6-w8QB3radO4NXUYNfWNEzs16ACf1yvvce6b2s-Q@mail.gmail.com>
 <aa997893-82f0-4a6a-b2da-b8e542dea5a9@genexis.eu>
In-Reply-To: <aa997893-82f0-4a6a-b2da-b8e542dea5a9@genexis.eu>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 2 Jul 2024 07:53:06 -0300
Message-ID: <CAOMZO5DDECP2x5Mgi56T=BFdfJ+hyR8FHYDnhm5ZdzF0bGDA=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: soft_spi: fix miso gpio property name
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Fabio Estevam <festevam@denx.de>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de
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

Hi Mikhail,

On Tue, Jul 2, 2024 at 6:50=E2=80=AFAM Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:

> This is exactly what the patch did. Actually it just fix a miss-print.
> Other properties already have a proper fallback.

Ah, you are right.

I introduced this issue in commit 2e9fe73a883a ("spi: soft_spi:
Support the recommended soft spi properties").

Please add a commit log explaining this.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
