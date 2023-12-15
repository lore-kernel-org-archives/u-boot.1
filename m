Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169EBC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 01:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941B587B43;
	Fri, 15 Dec 2023 02:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFBMM1X5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D16287B32; Fri, 15 Dec 2023 02:19:28 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BA187B6A
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ce6f4d3dafso30698b3a.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702603164; x=1703207964; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rb7TCmGXoKMmwdxhYQULNJC1c3dRretYmmYgvkMpGp0=;
 b=BFBMM1X59iXGax/Wj6Ey1nYXPMMAKs9uDu7eyOoRdXjnGvapJxe5TNXUVvpfa9VuY+
 cJN/rnwl+ZFIHmGoaw3bSQnmhai0nBXI0DlYQ3ePH7L4NhJ9LxM3W6WrmQe8jYeSigjI
 R3gBUUoxaCYS/nKlTfB9KwNX9AYhgnP+62TWztYZPapZaLAi8KOXfyyrfBIFX+6bdO+i
 UFkuhtbs/I5Sb9Agvrsi9CiiGBogRyeo/sRm9+0o9sNcnMg0veK4pLkV/c61h+xPRP+m
 0NOjMKVRLjfjopBaMk5xcWpZ+N+uN3OSM8Bdt9PVE3Wpfdkp2ODUESjBbb0WPpOYy7Cx
 AvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702603164; x=1703207964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rb7TCmGXoKMmwdxhYQULNJC1c3dRretYmmYgvkMpGp0=;
 b=XMmePu7RJy2Bk7WGr3lq7M6tojzy19ivCWvkFbv06lmXSC/DatEfq1gPIaxaxqM6ox
 ebh3tqGI8kJc14y+l0yMAunkIB1Aktxv8BvkKDsbIW1WUwlvilRa1ZjzE1dCb+bQExfF
 CxVnnLXe3p++xoF5iAlYr6BBD1164GohRNHpNEYjObMCCB85zEGldcp4df5BnYNEZosA
 zPEsbEGpGfd6lXqPNDDqCMggfPAzLtN+srYNHZDM2V4WD4K7kFgwqbtpdTjg0rHQqrmb
 1A9ZAM8FuXAlJ3XjIRVz7ehyzceasEOpRTgok6fftea12QdjlTaizFgdFynSLKowxHSJ
 bLYg==
X-Gm-Message-State: AOJu0Yy8qbUTZ19KBPmrby3CqhRtXolS757wCVnCI1nG521l7wKLB0py
 Wm3UYqSevii/2DfDpgDyNEfhtHiQUTM9wPPa9R4=
X-Google-Smtp-Source: AGHT+IF1gEbZHbjFonyx3YFa9Sr6TAdR14NBKyref7cWH/iwm+UkUE5TVyINrmTDThkXU8zuL2Q6h4V2NkALGAQm0KY=
X-Received: by 2002:a05:6a20:3c8d:b0:18b:2020:8cd1 with SMTP id
 b13-20020a056a203c8d00b0018b20208cd1mr23955365pzj.3.1702603164101; Thu, 14
 Dec 2023 17:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20231207175056.336787-1-marex@denx.de>
In-Reply-To: <20231207175056.336787-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 22:19:12 -0300
Message-ID: <CAOMZO5AKvpZ0J5U7jw0GhsGnNs556NMp1adaR2BC2HNfmdMYeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: imx: Force DRAM regulators into FPWM mode on
 Data Modul i.MX8M Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
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

On Thu, Dec 7, 2023 at 2:51=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> In case the Buck5 and Buck6 regulators which supply DRAM Vdd1 and Vdd2/Vd=
dq
> respectively operate in automatic PWM/PFM mode, the DRAM EDAC detects mor=
e
> correctable errors than if the regulators operate in forced PWM only mode=
.
> Force DRAM regulators to forced PWM mode only to stop tempting the DRAM.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied both to u-boot-imx master, thanks.
