Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6643EE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EBA89522;
	Thu,  5 Dec 2024 18:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MWs1OHLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF8889507; Thu,  5 Dec 2024 18:57:05 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A158950C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa55da18f89so172029066b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421422; x=1734026222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r5cQpoTor0NSZr/ObViTok5f5NqSHNIffKHlB1b1MSk=;
 b=MWs1OHLgbRmdS5YqEKS6i0NIxpnX4bKKxHiO39rixLsdVp446wb7ke6RVFHeAnylBp
 Q+f0SCTYoMtjWcMB9sHPH1zCghq08WEBZI432FELa6D9dbLum9tPp9BXrx8oVegUHfnf
 pe6QT89KI8jOl5pZ3xT4LRN/YWActS54xfMTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421422; x=1734026222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r5cQpoTor0NSZr/ObViTok5f5NqSHNIffKHlB1b1MSk=;
 b=Yt2CEIGENK0WLSt9LQXsqeGuVlgIU2sWZthC6P/oNxyRkEH+qTCdctKefMYYP/bdA/
 sfoNf0qxbHuHoSQXyysmVjR0nFjq0e7gB9LHBb6JLLJRTM+8Q3xvwRTu9dffwjzpymB+
 bLOXf1+fNOGOHMSaUxPto+rKK1b6wzVd3HeGQlANHt5rQVeHSxoy7AD8odh0+//JauwZ
 TMGx+Qa/B8uR2cxcljRcHfLrvMtp20UlkUok649a9b3Yyw3Mn8ZPc23UpmQv3PHAH2eT
 imu9I54b++bXGVHUtx+XNQUjDQdKPQm/SkHq9sJ/ePdZ5OedeWiXpmfvDEuf83PxnpJ4
 NwKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR6W3X0ZW6T4nsY4M1XhOp+A1WBiv1HvwYEL+2BuD8D71IbKWBKrT8yd2DNCoHP0uZziC7j/E=@lists.denx.de
X-Gm-Message-State: AOJu0YwWyivxIY+94dUNFNp3B+RNZ4qLIxv65MEEkYJIG1hWOgEc+4yu
 Co1EyBq9EvSc9xOMsGqmhDIvLGkEnFD2zIPqkkAiPpt8s1WQ0ikaTFjKfEDbsvvIYUp+bxhw7J6
 bTKzPNnqk1Qp5eYo8CgZ2wLUywpuUKXv6RNpq
X-Gm-Gg: ASbGncuerQzdG0p7hUroZgGpS0JTbMpC6p/RrtlX7oeqszo5vnZPJ/IvGqLAB8wB1hS
 o6/RaIogzQ1+15DefHBh6tBfhKv2gFMSL
X-Google-Smtp-Source: AGHT+IFNtJpF9KWCD1TRyxjZpRqSlUWyJd6UxQ1A+vuqhKhQoo2zGTJYdqaoMofiR+qK50CnUL1NjZz0hX7adid2dfo=
X-Received: by 2002:a17:907:a08:b0:a9a:835b:fc8e with SMTP id
 a640c23a62f3a-aa5f7f3c3dfmr1107180166b.54.1733421421559; Thu, 05 Dec 2024
 09:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
 <20241205-ge-mainline-display-support-v2-1-4683bb4388dc@bootlin.com>
In-Reply-To: <20241205-ge-mainline-display-support-v2-1-4683bb4388dc@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:56:48 -0700
Message-ID: <CAFLszThc2fKdDdcmZcaiQmJ3dooNepbcCmJrbDhmvNG8CmNxQg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] dm: doc: Fix example
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

On Thu, 5 Dec 2024 at 06:54, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> `.priv_data_size` does not exist. I believe the actual structure member
> was supposed to be `.priv_auto`.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  doc/develop/driver-model/design.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
