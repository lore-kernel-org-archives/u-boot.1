Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C9DE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 18:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC280803DC;
	Tue,  7 Jan 2025 19:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BfW0ut7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B9F805E1; Tue,  7 Jan 2025 19:08:54 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C633A8036B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 19:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53e399e3310so18449675e87.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 10:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736273330; x=1736878130; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+MHtwT6fpytKWR40maPJtNoTTKFix4N4Wv1b2Pss3U=;
 b=BfW0ut7opteocEDB8r7IiZXgNGdroNSei7VF86PPvmtRhrGvD2D6JYt4vXKJB7OdIN
 nLwC4UXH8ulps7fbWXt6qBItBV60a6fzdukN6RiS98MMSTKo130EimIZKBB9k6QraTmx
 K4RrIHkSmJHS8vYryQG71MpQFVOGYQob+xnVz/JzOcS+rgrwLnxlke71DIvPJw3IY6pE
 oI0zNGSlBjxZTq6BbOopXmfhSc8nXUYPuGd96uZn4t3+MF87biavgBsjBbpapsG7P37w
 RzS8sCYQiRUQckRa8BO31hIRxgKn8in5oU4UWn1YTD+mEqtrX/0hs+EShiHvd0lk/3JF
 OWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736273330; x=1736878130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+MHtwT6fpytKWR40maPJtNoTTKFix4N4Wv1b2Pss3U=;
 b=rpcNKv9Jy7Uh6tQiZ3ueJjk0w15VCIQJOPbi1B3H1dBVIlgyDKg/4/dFxMl+2I9PG+
 GBZcNFOcmRztRbaTFv6Y/KItUSigM9pWwKhXuxhTRntw8xnYGqBw+UPu07wypqRRLNIu
 F3rAcgdY5t+IsYJUPaItkW4XrYv4TVvuKhb7eUA8+Swuq4Uj6ZIlI2LP6xdalpoPglEB
 ROnyIICFDFYk51oq19pUopmpn2YipRjEEc2kgrlx6w8QP2YmXHMtgteR5ykANX3Bjenj
 jBUfqDtM6rBCAIBtabohTlYVwXQnQPEHO4tnNntpXlhw8E2DD9SIsb+WGraNwDq1hRj8
 7+ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/BhK3SupDaMg/h89BDhD92xWLw1KeBkVYFpwLHXvm2IqjIcKO08nbxOGi2NnV0NYrd7xKM+0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxtupirf2iQZAIe6Wkr6R902YSmeHWsOspaWHNNeaWb8uj2O5VV
 XD8GC0pvzIUi4+6cGNe4XKv2d7LyI0QbppBRtfy13UXAbUfL6pfNdakNM0VVRRHRkMISE6ZANow
 7FJ9uvbwIBKjJOid67hl3ImWRUUy7aw==
X-Gm-Gg: ASbGncsy5OR0gbeyDiuxxZUnjTiHxVrip+gQQa+Og1/sbfc9G0su0fF+omRh9AlYfdr
 htLAlCtsDnX3NE3MSRDqIM+msFgEmY+y8Pu8Zpw45Gi3oC754yGc1XLm0b1q2b84UMA994Q==
X-Google-Smtp-Source: AGHT+IE6ejkT/UxSqtHdjjoZhDbisriWQk9hQDwsGu0SQPp0TK1Kii5ZAZZQbP12cVhV08wQm3HcPmUXETqeRjKLsIU=
X-Received: by 2002:a05:6512:b86:b0:542:1b63:2e52 with SMTP id
 2adb3069b0e04-542295229f2mr18666507e87.6.1736273329693; Tue, 07 Jan 2025
 10:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
 <20250107-imx-bootstd-v2-16-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-16-97671b1694cd@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 7 Jan 2025 15:08:38 -0300
X-Gm-Features: AbW1kva9PSKUITbv0prDCL78WW1VrLc0QqjskU3Lh3HAGztb4lLwB12TDxJeUJU
Message-ID: <CAOMZO5CmznxHyaA7+8JDn-ZSbBi1jAX4DYU7w2R=a4j8mY7gEg@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] imx: imx93-11x11-evk: drop duplicated nodes
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Tue, Jan 7, 2025 at 3:59=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:

> --- a/drivers/gpio/adp5585_gpio.c
> +++ b/drivers/gpio/adp5585_gpio.c
> @@ -224,7 +224,7 @@ static int adp5585_probe(struct udevice *dev)
>  }
>
>  static const struct udevice_id adp5585_ids[] =3D {
> -       { .compatible =3D "adp5585" },
> +       { .compatible =3D "adi,adp5585" },

Please don't mix dts with driver changes.

Make this driver change a separate patch.
