Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44238C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 18:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FE2862EB;
	Thu, 24 Aug 2023 20:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20221208.gappssmtp.com header.i=@gateworks-com.20221208.gappssmtp.com header.b="Qpa5TFmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13163865A6; Thu, 24 Aug 2023 20:05:45 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BBB68675B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 20:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99c353a395cso4331666b.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1692900341; x=1693505141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gVonDjKOww6Eq6C0RDjt57EeQzuDG/r9E6VcdIYbY4=;
 b=Qpa5TFmuPDSCKO7AZNOw+G05Y4IyM+z95dIvyNifuF+P51H5NVAw3dM838QAsTQbnV
 Q8oem6uz8gash7M1YIwbvwcmYm0TXqrEli8WQZt2eEN1lA/HY5LWOws51DgrjajHUw21
 /HhVMfMirpKfYLAkKzNzOjXTtc39/459OhXEq4L++uuzg3zlzphUktUFPKooLIVS9arX
 y7EvtoYo6gW6uVx6BAq4gn3YR1GH0qsk4t4tpCaU6ws6kGZ7j2J/vhuK/ai7ZDfeCY6p
 EEGoHNboGKdtIRLm/xDgS7ob1rQrgnFhLKx1Fk+uvividPBEWlSptDTVRDrPBL+ajjU/
 OiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692900341; x=1693505141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gVonDjKOww6Eq6C0RDjt57EeQzuDG/r9E6VcdIYbY4=;
 b=dq3B9q69Epdwduu2cQyA+L6oXdR8VNRW6MKO57yPykM4Yxf/9L+gR0CrEhM6hrBC+Z
 JsWPTX9S/AKYy6bZTOZxnOnWq2sk6HiAsy3YsavsXjLBMNkTlZp8RV2ALTyec3Db8a/M
 dbTYm2pX6T1dzoJjOYtMEOtXudMg9ZAu5tVWxr5F2IxOisk+WSeQ+pBcuEZ2jgyTfPBV
 p6Z53mS9LC5OIlnQ4/IbMe5BcEy/nLpzPULT05vLvHbQ2926Bj6mEMAKjRVd5+e11aRD
 szACUugN/YRdXJmdJaBJnjiYVHc65ZOSmigxceTjQa1kuI+3y5E0VwQTphZrl9tsvsdH
 b03w==
X-Gm-Message-State: AOJu0Yz8D3PwqpuOOHXMjOeTrQ7U1k8l0zmpohWp6meQgfw6y4ze9I5X
 TLYpDXqyyEXlxnR+yYV8PImnuUaTEyQT/shGb2Y8wQ==
X-Google-Smtp-Source: AGHT+IEm5yD8SpfZ/bXAsRLMKc/++RWCZwwCkQ831SpeqDdqdauObVpqezUoGQYHiTUc/c+TDKFhw1n+gJYtdiPeq+s=
X-Received: by 2002:a17:907:a05b:b0:9a1:e371:d9a9 with SMTP id
 gz27-20020a170907a05b00b009a1e371d9a9mr4523587ejc.16.1692900341626; Thu, 24
 Aug 2023 11:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230713185608.3647122-1-tharvey@gateworks.com>
 <20230713185608.3647122-2-tharvey@gateworks.com>
 <98904f52-9deb-9fb7-35cd-7880b1f19155@denx.de>
In-Reply-To: <98904f52-9deb-9fb7-35cd-7880b1f19155@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 24 Aug 2023 11:05:28 -0700
Message-ID: <CAJ+vNU3Ardy1i-4dO-ywKusDUC7vj0zAuDvfzvnpFejTjQa16A@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] phy: phy-imx8mq-usb: clean up clock code
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>, 
 Adam Ford <aford173@gmail.com>, Martyn Welch <martyn.welch@collabora.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Stefano Babic <sbabic@denx.de>
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

On Thu, Jul 13, 2023 at 12:17=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 7/13/23 20:56, Tim Harvey wrote:
> > use CONFIG_IS_ENABLED for clock enable/disable and change printf's
> > to dev_err. Additionlly remove the comment that does not make sense.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>
> Thanks!

Hi Marek,

Who's tree do the phy patches go through?

Best regards,

Tim
