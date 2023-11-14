Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D04C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 09:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E303871FC;
	Tue, 14 Nov 2023 10:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVMowwvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE23E87215; Tue, 14 Nov 2023 10:05:45 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6F1871A0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6bf20d466cdso992748b3a.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699952742; x=1700557542; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oy0N8QBCfNM9R4SaKrN1+COZbboxvixGX9pFTwsUhS4=;
 b=MVMowwvTE415SVfYKMCbxveUEz9aJlYP5GXRNhy5uYkwX2Cm35lpunQD58zOO2IW+X
 hYOUT3GtG/Tbs8grCooZ0drfIrgmN6Khgy5ogg3zsd8uiWPS/uVY1ChSry89KkTnpXYj
 3K3lpWhrjiaz0TkuJ1FrOhyCeLG0FG8NgLUyFxVeA0otYi58B3cm1EpSNDwgMtWE3vtv
 RVD6YTJ1vuhxsMaMgjgXe9UbqParWNr3oTbyoWTtNcC7/jO62lu0QI4MJa/mVP2ar5/i
 kvVWggO4yZGBciCKJc4mOKGq6Xf6YA+PBMs2X3JDCJ8LLUwevJ/O91jeXGFtUC4GaKyC
 WJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699952742; x=1700557542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oy0N8QBCfNM9R4SaKrN1+COZbboxvixGX9pFTwsUhS4=;
 b=PxfyVmplVva62BKUVb3oHlWj4z8/Wtc2zHQPQ7cYB6lVgaCfoQG837axHlIXb5Gpir
 9Cw1es1KDzGlw9IhlA2eKEPHqOAld0eG/8wwmZeWwlrd2hMZlRmvZY1Ypd3AWJ6JT91X
 EQRzguxxYmquK/e6DQZtp/NSRl/QsGVxuYCXSixiVAsadoHF0fnrfpj7vq6mZO+HY8kb
 I1nRvnQ2W8sE0fFabowHV2JYR3NCYCwLbnXVDHnRabK+wHYE1eCc0tgTfn8n4hwTwJAg
 Y0CLyD+8uk2TmqiZO7sP9fQpRDe2PpFlkR1IMjjBDwDC7Jh9f0xSyw/H9ZVDlVzpLwGM
 i1sg==
X-Gm-Message-State: AOJu0Yxo9YSumWMvefFzNvM6Smf4kfFf10rOcaNeYY6TKOwS95QaXTaP
 KUMQKlsyqtbCO565MSrB/RcBC1ythWkjBwWrnRwzndl0Mss=
X-Google-Smtp-Source: AGHT+IGSZ1G3sIJJbHnwcior2FiU+2TaAzqGo2E5mI7YVHpx5OwO8qqP+YGJv1C7D9LQJ0Dyc2NyJ5ekVceMobGwrj8=
X-Received: by 2002:a05:6a21:9984:b0:16c:b514:a4bc with SMTP id
 ve4-20020a056a21998400b0016cb514a4bcmr2010141pzb.4.1699952741966; Tue, 14 Nov
 2023 01:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
 <20231110042542.3797301-10-masahisa.kojima@linaro.org>
In-Reply-To: <20231110042542.3797301-10-masahisa.kojima@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 14 Nov 2023 06:05:28 -0300
Message-ID: <CAOMZO5CoduEgwgdQiybmoKh6qQZOezUtRRQO4ecaGdZBBz5dDw@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] doc: uefi: add HTTP Boot support
To: Masahisa Kojima <masahisa.kojima@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>
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

Hi Masahisa,

On Fri, Nov 10, 2023 at 1:29=E2=80=AFAM Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:

> +Set up the load option specifying the target URI::
> +
> +    efidebug boot add -u 1 netinst http://foo/bar
> +
> +When this load option is selected as boot selection, resolve the
> +host ip address by dns, then download the file with wget.

Just curious: what is the typical size of the file that is downloaded via w=
get?

We are observing some inconsistent behavior with wget as discussed in
this thread:

https://lore.kernel.org/u-boot/CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf=
1CNaZBw@mail.gmail.com/

Do you see the same problem?

Thanks,

Fabio Estevam
