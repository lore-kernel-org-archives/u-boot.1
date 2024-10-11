Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97607CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C19892CE;
	Fri, 11 Oct 2024 12:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DhV9LcEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71887892D2; Fri, 11 Oct 2024 12:23:18 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F25886DF
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5398f3be400so2115623e87.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728642196; x=1729246996; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03R49FOJFxbTbbSgXHptKwgVrsVVqtuM0Zr9alqJuwI=;
 b=DhV9LcEVA3cZzjpv9EUTtfxRhukyokrYmkL9eA/mJDs6kmDxPcpL5VghFjy/PvdA77
 C9GptYBCUGM7dr+2mZ+1gxpWkNe20Y1iHerybIhXTEJRXA6eDbX5CcmfAgFdQqW6tU4p
 zkWn6XVlYVFMf6jC/MsC8+OO9zajihhP5Ud/Cv/7Aq/9wx+JqRMzwNBFHkdb4S+i2B8+
 3opelE66pkdmsFvuoLHT/NJDW0x9DyO04WAXbfSHMxqRDx+l1oNV75C5JqmbgKm0K9Ox
 bCsGMg5dZ84qbuzZ5u58vQtia98DfBNDiq+FxhMa422kKfCw4JRgxQp0P/un6f9izQS1
 l4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642196; x=1729246996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03R49FOJFxbTbbSgXHptKwgVrsVVqtuM0Zr9alqJuwI=;
 b=eKdw67o/x9Lt0pMv6kRnTSJK/gXYA4jyt3B3kRlAjvuQA+yu8bojf3uWI9iTtnECeo
 gDPys4Y1+sr1ogPWjSzn085ZL1HdsjSE5qGXUhMsLA22ICi8HEYKShj/3xb8kh6FFHaW
 64NaATUJ6BMcSysUtOW3xJnqZW2Bib95lOYL3oyOBTot77/tJouWj66BhifD+o3xlRni
 PoQpoY09Bb+8UueGLbyDzTcX/r6nrIrhZpJE4mPsMqPB3+ItpDzwIOQNCgUh1IoaX5Is
 dLqeBjNQ1fcPU0qK0b+yBpPjsvzxTrBuNcjpN8+MAwJ/ghJYGDdLyksqCTuFKbCMSC7c
 +NoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMwHOxtZbDURAb77/sWD5o8iNH9iQ9twKlqpgGaZYkACiTQE82t5s3fLhPGjKDHAn8gk53Rak=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb8DQUJIx/e2ReVCQGuxudAqNoDPHdn9UjYHYR5BykNGAc0BM9
 hCUGlQbrd5Bi52Ea5EXdPiYW8zI/h3ineM7DOF2vqSokwV8hvQt8yZdDE5g2CbG0Tj5XVIA7iHe
 95UJGSCYa/sDxzvaghuWFNvtbdv8=
X-Google-Smtp-Source: AGHT+IHCK9C+LwbYq3KDdN4qP+agwWUVmf7eXQO1hhGvGBxZyBJilvo9Rq0MITnOiM42XI+fx4mS2q7Nnn0uZ2lMAeg=
X-Received: by 2002:a05:6512:ad4:b0:539:9f52:9ea with SMTP id
 2adb3069b0e04-539da59bfe5mr786364e87.53.1728642195572; Fri, 11 Oct 2024
 03:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241011112402.3168-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241011112402.3168-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Oct 2024 07:23:04 -0300
Message-ID: <CAOMZO5Ba30NBsh4FRwhoWduoc=8Yd+BuVWLQGz3w9VKT4rGrhA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8mp: Add i.MX8MP Dummy clk
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, uboot-imx@nxp.com, 
 gilles.talis@nxp.com, Peng Fan <peng.fan@nxp.com>
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

On Fri, Oct 11, 2024 at 7:20=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX8MP SDHC use CLK_IMX8MP_DUMMY clk entry. Without the clk, the bulk
> api will return failure.
>
> The correct entry should be replaced with IMX8MP_IPG_ROOT clk in device
> tree. This will be done in Kernel device tree and sync to U-Boot in
> future.

Can you submit the kernel devicetree patch and add a lore link to the
patch in the commit log?
