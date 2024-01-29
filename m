Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F0AC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 198D7879A0;
	Mon, 29 Jan 2024 13:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ANt5EOEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC3C87A00; Mon, 29 Jan 2024 13:00:20 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8E387960
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-602d0126e80so22911607b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706529616; x=1707134416;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbF4FpDplF4xR1wwNz6Ni9xq9/cjUnL6UpLGWTmyenw=;
 b=ANt5EOEKEF6SdW+4DrKehO+ZWgRXFQowGt1KJhYUV+ociBVQMz/FhnRJUL0UGc5uy4
 9Qcj3hK7jLWqkL8ZdpdHlyvJupEc+gwUn8xVRl7rQTmm3f1LD3cXhFjK40hllUWyGNhy
 Te9fyRK/+pUnl5DIbK7uR0NLTPvxs372Pdq70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706529616; x=1707134416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbF4FpDplF4xR1wwNz6Ni9xq9/cjUnL6UpLGWTmyenw=;
 b=mDMUMOmsy9u5sl/lymOjX0Vw45K0s93aSJ8gCOxzb1exvJ/MCOfs6u8N5f/ILl3yTI
 FV+BbQ0tl7GhcFkcfF1ZhLoJ+GvWNvJYBTPjhkZrFLfaWkPAhjGJLMeiuXh0ifpdJtNO
 XC3h3YToqU8C2FMNL3WyZ9fV+AOhj23pIk3/tan1RnN7dhKt/VaVjCMP+l7wy58L8Y3f
 PEFC9/OEOWbeQQDU1BSd+v8LtCGuWIecqKdWFkAVF2kpruzbxq3dMqqythWScv7WERY2
 tl2DTyPE/eYkc+3I9j6bzqi4TGN/MyK9Rcxym6Iz13WpP1tnYH3OBGu5VfB+v9ouklH9
 pH2g==
X-Gm-Message-State: AOJu0YxDPv9/uo6htbLGDhYtBCAE1PWMysk+VfjrFnTXnOBY8wPNwIqc
 FVjP68KAkaPaLlhr1GzJXmuwHIkns1hnDat/24Tf6UVWt5QECBExnm5A1UnUtio0WulMmjTanJy
 pVhiLt9VgMKl2WDVWfSXpk2kxBPaA7ehgT3d9s9DgxosPrLVRI/Q=
X-Google-Smtp-Source: AGHT+IEI2eeILEOpP75VHeJST3v5oe9O7CJ1SZsjCBABW8OTKai47Y8WKDZWeTkNptJBjyo3wuhcYVEQ0nqGRUjgg9s=
X-Received: by 2002:a05:690c:dc8:b0:5ff:8427:5476 with SMTP id
 db8-20020a05690c0dc800b005ff84275476mr4177669ywb.40.1706529616270; Mon, 29
 Jan 2024 04:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20231226075812.3803-1-bruce_suen@163.com>
In-Reply-To: <20231226075812.3803-1-bruce_suen@163.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:30:05 +0530
Message-ID: <CAMty3ZDRSsR-RNapU5npfdG7CixSV3NocJ4Q0oNwv9V21THRjQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinand: Add support for XTX XT26xxxDxxxxx
To: Bruce Suen <bruce_suen@163.com>
Cc: u-boot@lists.denx.de, dario.binacchi@amarulasolutions.com, 
 michael@amarulasolutions.com, frieder.schrempf@kontron.de, 
 bruce.sun@xtxtech.com
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

On Tue, Dec 26, 2023 at 1:28=E2=80=AFPM Bruce Suen <bruce_suen@163.com> wro=
te:
>
> Add Support XTX Technology XT26G01DXXXXX, XT26G11DXXXXX, XT26Q01DXXXXX,
> XT26G02DXXXXX, XT26G12DXXXXX, XT26Q02DXXXXX, XT26G04DXXXXX, and
> XT26Q04DXXXXX SPI NAND.
>
> These are 3V/1.8V 1G/2G/4Gbit serial SLC NAND flash device with on-die
> ECC(8bit strength per 512bytes).
>
> Datasheet Links:
> - http://www.xtxtech.com/download/?AId=3D458
> - http://www.xtxtech.com/download/?AId=3D495
>
> Signed-off-by: Bruce Suen <bruce_suen@163.com>
> ---

This won't apply on my spi tree, maybe some out-of-master changes are stopp=
ing.

Jagan.
