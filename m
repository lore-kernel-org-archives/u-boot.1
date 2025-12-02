Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F99D116F1
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 02:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823DD83DEE;
	Tue,  2 Dec 2025 03:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gSU8HZaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4073983DF2; Tue,  2 Dec 2025 03:41:57 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCFA83DEA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 03:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5945510fd7aso3999726e87.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 18:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764643314; x=1765248114; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+raRDSfNrOC19XPezexmQuqTrRQVOG+kEB0qCg4xdOA=;
 b=gSU8HZaW53Qgg0XLabzSDO754yJTK31q0KjVUbDCu6QkmS3ZdE0ibVVtVyawXYXawN
 Xy11qGtG4ZIZvaf98IJNxMRtPSyqmP8UO527Xr1A/8vMq29CND66GeE6bp5H3L19LLXH
 dbaYBbT0QsuOxVnwaoXwnDVGCBRKLdlmVGWwICJ4u+z/KaqcTniyVc98ELtAPU+qJNd4
 3MnksY0xOHlz0gWO7nY5n5HcGqIEOBx1L7EnT5mlmERIIDNMVaOAdk2hcwWAO1jvIL68
 mDcmDC1U1WXrwUuZu0eaFRDHpwoYdCL0EMs9uEW7OkqiE2dfedPKyaTqmfCsaJoGeH+p
 1RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764643314; x=1765248114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+raRDSfNrOC19XPezexmQuqTrRQVOG+kEB0qCg4xdOA=;
 b=MO5309S2yS/pqkFN7DvaE8aLnWVXT3RRLULFZBDGW2DVlOskwCFyaLDn4KKDbz0z4Z
 HO+q/AHnWEFqGr7G3s8L3Hzrn59yzKYqo2UyQrzWO4pTqfeVmz47ZL68D8xvGDyQ3/FE
 V5LNU2Ezp85HozRI4x2GUfbcm37Kn7vmrxkc4crLCcGtIbpE/NJI6wXToqWlGfusAfC4
 H88TeYyiTPuKJSiZ87tvVdR9y8X+O9SREUqjltyA06hmVVYG2lat2jrm4oPMIE6RZxzZ
 TVzsnNEOc6tRc4ZWKPFGjNyQF6+ZGq/oBU/AhACBRRytXoQrvRzf5ijj9O4Ikmm/Wh67
 8pjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmUrizon0DHaxaMc/zxqzSGmkS4rGh9KuM7sElh3atHt6yaI3PlGOYDfTQufS+J1SxWCRkCtI=@lists.denx.de
X-Gm-Message-State: AOJu0YxG8rnGwKDUb1qPhtxxYruvYA2dGX0Qt0UuvVW4aZoKE3dVtOTz
 i2T6RsO6Rwfz8gtAFTjxyEybY7ZAj1Vv3Ulz375n8/7jhlvpdaeutCZbp8PyqmQ9xSJFSHqw00k
 y9MT1gFjv1onPFscrVbykRrIO5m/EsNs=
X-Gm-Gg: ASbGncuGTxwTm0yXn2ip3gq0A3LwmLMK8CIXtX9KtUpa8R2707itxdjCBXJqpnSFtuo
 IIBmxQsGHkFShx05Uj+iGEUm4PBHTfSeXu6cLfpsyuZ+LpImvjCF9b2rasWsXG98Jl7pWuv3f1l
 +Q13xozZ3vG9+X0HLTsPhnmc4ekiar9YkowNPZ0XMzI3Yxodi2FekHdwyWvu2LHzMpiN1GA5JX1
 Abdv7vGy6b/5AsYucxd+pdD8PK9su61/6B9na5tjG1kYLYakeDb/F0TqTu5o5n8h021fkALrE0M
 SajXefKNGxXQtWF7x3VxgErFgw==
X-Google-Smtp-Source: AGHT+IHjIfhYRed9T2W5C8dN9Ufvcm7T5ZKjgG2i3y0N+MfUe2kyE3nxEll7pM9Q2lZ80UpnJ3fu0tIIOKdkN0+db4g=
X-Received: by 2002:a05:6512:1390:b0:594:51ac:13e with SMTP id
 2adb3069b0e04-596b5058a71mr9552284e87.17.1764643313950; Mon, 01 Dec 2025
 18:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <CAOMZO5Dxi52OzFEBWU1hnn2HfHc9EZcgmwW=p-N-+Oy+JHQBHg@mail.gmail.com>
 <aS5PECe5b8576MTk@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
 <CAOMZO5CbYn544xKUb6QApg0bzc_cQEqqTSSC1r9SUgyfpQGSEA@mail.gmail.com>
 <PAXPR04MB8459355C0CE42DFCB11B17E588D8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459355C0CE42DFCB11B17E588D8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 1 Dec 2025 23:41:42 -0300
X-Gm-Features: AWmQ_bkhx06LDNdMKhiBjSuOdG9w4Dlpjy9KcKb5D5YemOPq0BgYhZ2bA7bBaDM
Message-ID: <CAOMZO5BbFUSMp_sOt0FkBMh=4a1QTbpFTjSMfTNDGvxo3ZEqfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
To: Peng Fan <peng.fan@nxp.com>
Cc: Joseph Guo <qijian.guo@nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
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

On Mon, Dec 1, 2025 at 11:36=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> With ECC enabled, some DRAM space needs to be reserved to store ECC.
> With ECC disabled, no need to reserve DRAM space for ECC area.

Thanks for the clarification. How large does the ECC area need to be?

Joseph,

Please add this explanation to the board's README to help users select
the more appropriate defconfig for their use case.

Thank
