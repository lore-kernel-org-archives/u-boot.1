Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCAFC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 21:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D8EA87734;
	Mon, 11 Dec 2023 22:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jc41lNpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62418876F4; Mon, 11 Dec 2023 22:19:45 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE9C8779E
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 22:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-286f3e0d010so1492778a91.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 13:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702329580; x=1702934380; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayVn8KN/6xFe+Kont3U/0fx6RW6SMLingDFXvhGHn7k=;
 b=jc41lNpTOeyxVfAyrtAfPxSGRBbokANdmfQn9YGmr3rjiRA+tl4phHIKv1uBKrSPsS
 2r4c3rAOIlgzRKu20m1T2Q1tyfotF9gh/4jTxfnlq6tQenpFwv3LWHE1B6LPBpXBujBE
 v7EoKWBT5WcZZxKZmt9HI+o/90brG4YBXsBM92CuD3aFrmNTXvH8So3tLgc3t6WMDFKG
 7MJ+Q6NzaFStmD/g9lgvKoPdILnLr2aCsRUcTIWIjMNdEXHcBl9y5Lao/9U/hNVuy8s9
 od8qBOrClpJwxbdPdf/5A+QGz8+KysDePzRpXZVVeUhPCh6A8FDfxl0D+jwOxo1sRGOq
 5+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329580; x=1702934380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayVn8KN/6xFe+Kont3U/0fx6RW6SMLingDFXvhGHn7k=;
 b=TH3fuz9qY/SNDwAl/+Ex1atTmNynCGFJxQCwdB6lHqW7mR5NyVhdRNIlpJIl+Ze3xb
 4nKZOldPrDFd4OaeM4SerKnBSLl3c4DLBebkLVpJOiJWG2MgEfCRmXSbTsN3KX/wAF9m
 UYLp+o/gaUgdlR+bPYSrMnnOfLxEB4jOi2jjNFHGFeY06ywQxNQD/OYDqVa7/mvl6ahW
 xkPS+2OD+90lPj+rx1wsWHQX1Ixxop5ynFN1oiMusufNECkY9svZQrHMCOsUhjVSb5QA
 R5ObdiWmRjZ2+zuPPlD1lwo2DqXZZi4FCtciYaQDkOeH86JSLiLEz1V1K0/77yBkmyLj
 6YsQ==
X-Gm-Message-State: AOJu0YyymoXs/1N5aWMLradYbhb1phvf8aWFPxxCNUPQuZgsZTbmwkIB
 KVqMEUnEKBGaet9cdtFyM9HhfdvPuedfFGHjvo0=
X-Google-Smtp-Source: AGHT+IGQQFF/ZqUDJUhfImxrdBZpxuvHVeXvixZR+mM20o8UYIKUjmd7+IRlahtVJKqhtPtB2eEn3Un6/A+BRHYaa54=
X-Received: by 2002:a17:90b:3718:b0:286:6955:6754 with SMTP id
 mg24-20020a17090b371800b0028669556754mr8855859pjb.0.1702329580133; Mon, 11
 Dec 2023 13:19:40 -0800 (PST)
MIME-Version: 1.0
References: <20231211100613.46650-1-nicolas.heemeryck@devialet.com>
 <20231211100613.46650-2-nicolas.heemeryck@devialet.com>
In-Reply-To: <20231211100613.46650-2-nicolas.heemeryck@devialet.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Dec 2023 18:19:27 -0300
Message-ID: <CAOMZO5BGOK=SMBxAA6QcAziZQurTN-p-Bh0hWuQiduSHoUvmPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk: imx8mn: add pwm clocks
To: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
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

Hi Nicolas,

On Mon, Dec 11, 2023 at 1:52=E2=80=AFPM Nicolas Heemeryck
<nicolas.heemeryck@devialet.com> wrote:
>
> Based on Linux kernel 6.7-rc4, add necessary clocks for the PWM
> controllers.
>
> Signed-off-by: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
