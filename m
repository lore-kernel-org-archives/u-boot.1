Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E69D30000
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 093A389131;
	Fri, 18 Oct 2024 14:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Au/p4g84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A53F8901D; Fri, 18 Oct 2024 14:33:13 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29FD889128
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so2195195e87.2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729254790; x=1729859590; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSch0QRGIUKi5tlhwkQe5dMAXY1pR0VeCEKUv5KKMrE=;
 b=Au/p4g84YEGGqQIRpw8c5FCNvzzBg2OuyeihY0fBw6ErwyTQ3/FO9YpX8FziIv7fQY
 6Grzvcujw3jAE9chOiA/qIMbtTa2Sw0qhyITdITagPm7reCFuDQQISIlh/fVKzJdEseA
 SyJKNdpCxRKoufUkAShCX1a7HKOmJ2XZovSRrOgfYqyKls7Tt+FEVasr/A2HHG6iVnul
 v12vQj/r+Yk5V65bOnDJoF4d96eUkiR3Pg8r/O4TajjShgVs5kK1dAtPwqf8K60AIiWw
 F/r59q7HqLmaS/xx94k6oWHqzwPnHQEbEggvLkTbod6tPO9CDXjOp4ZdowvdW0s9tVp6
 7a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729254790; x=1729859590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSch0QRGIUKi5tlhwkQe5dMAXY1pR0VeCEKUv5KKMrE=;
 b=ILa2SEit3q5yTchUYeJpQv0nU6KedC5JI+HVPksNdjnELoSxwvTq4F15do85G20onW
 X1MLISKXJLc9AWYnZQnwCmfATcX+GofNudV/M02kUhTmBkeGBHNI6RZlwBfIT/0RI4G+
 iceZnyKgLJ5nBvZ0AO/17m0rsZLD9EYWt8GZrYolViOifYD0++BGQ4EmeWT8V9Ccoo/v
 j69lOr058MamGjcS1lwprxaCCD4yJ5jwfFJNicDjsxn/OCrv3wj52geWKp8giGrcTPd+
 bD3iVF1UWmDegLXyM4OUm5U58CtoeFGEDPsgg8PFnO2ntYTrj/yc7BzkLCNw7TDgzIRF
 De5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUQJrFBkqIj1A29FRRM/uDpms0214VQ6hsTPpBbqGFi5jLhmUcD2acMly0dsHwWjrqXZvGI1c=@lists.denx.de
X-Gm-Message-State: AOJu0YxK9pr6HR/oCjeOkb7Wf83EWStMyB6zrzFbnBid2qdnugtFtlZv
 tAR7DhQdUonCl+I5aRlMRoTF3CgWsOlg75b2WuaqPpBcVdxCbCtpP4Oyw6LIHMyJvz34dmi1w/l
 vXiHuYUyYiuDrWcx+68sGM2tqOhc=
X-Google-Smtp-Source: AGHT+IFah4TGWTilWtr5stAQ3IhM1y33Zc0YXzCJ1XHPmhdfenIlOtf6B0hnL/zS+NK7OEjz9QoI/GbULB7Ykoap5mw=
X-Received: by 2002:a05:6512:3da9:b0:539:f696:777c with SMTP id
 2adb3069b0e04-53a1522a9d7mr1769126e87.29.1729254790081; Fri, 18 Oct 2024
 05:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241016075029.15469-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241016075029.15469-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Oct 2024 09:32:58 -0300
Message-ID: <CAOMZO5DK_ZrP6GcDnibNRogz=Nra5+szPdMwx=99DJNX+OfP0A@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8: Add dummy clk
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, hs@denx.de, uboot-imx@nxp.com, 
 lukma@denx.de, seanga2@gmail.com, Peng Fan <peng.fan@nxp.com>
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

On Wed, Oct 16, 2024 at 3:46=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> There is a dummy clk entry for i.MX8QM/QXP, so add the dummy clk enable
> and get rate. Otherwise "__imx8_clk_enable(Invalid clk ID #0)".
>
> Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk=
 API")
> Reviewed-by: Heiko Schocher <hs@denx.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
