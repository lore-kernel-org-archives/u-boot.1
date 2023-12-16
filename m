Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE584C46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 10:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11CEE87A10;
	Sat, 16 Dec 2023 11:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iznyN/oZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6805487A10; Sat, 16 Dec 2023 11:48:27 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC3B387661
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5c6910e93e3so370524a12.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 02:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702723702; x=1703328502; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FRdI7DVZWd+aUV67bns5qMZy7Jit5Jtw3VJk16a1ZA=;
 b=iznyN/oZDkUqRo3EgZYOyLFKCQ9YeYv9yHEdiwpvGk4OAG9asy6ylKf9tiB+G+xcDf
 bMbUUOA0gQl2TXaa9kZBqHX41QNgzOQLGR8ZtcWexHvDtubVFTaGKR+jhyQtsKiMoFoZ
 MFpog+UFSQk6ZK/Ps63O3hnr6i7Bbs0tS4qyRKptJwEFt4bl0NcX4ONOxwHsdx/F2l/p
 d64QketJYNRRLTCHFwDYCmT0O94BrJsD3csOSPXCZasaJgD105uYBeS5fT7+D1qUozBm
 HSvGI5xGzHniHWR7bXzsOilUDDyWm4O8EpYHrQJoL3Ha+xau8U1vD8d6K2gkjl/i5a6N
 85+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702723702; x=1703328502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FRdI7DVZWd+aUV67bns5qMZy7Jit5Jtw3VJk16a1ZA=;
 b=r9I052VU2skC0UcIaAI61igW+O3gnerZQDhs+dNmaK+R/WoI2/1TrE9Bl0dW/GgQuY
 8kzvaGbxaxZEXiFlNx3yz6MyiJbfz8bgTZjehyH2CXN8l5WDD86b/EYvzlFFu5UIpjtC
 WWrgQUbMx9skwGADPwAL2IBo5c5WNR3BAmbDlE3a/2DUTeoihnZKY6g1iRekHeNvI16n
 BGzxe1n09Tx3JQrM354hrqQ1QyJN3+ssNAz+J0VM/p+r6ZKQMzHsgl8ROa9HkFNmJtGP
 bq0Pym7gxfnhF9SLCvhSTXFVoS1H8xWsvFHrHl3pc49wdH2+h9tGcXwBsDwh7/F7mZMD
 eVww==
X-Gm-Message-State: AOJu0YzKfogpQcxAtjpf5swxKmEOO6tKiPkx33dG0iQylUidgLyTm3bD
 kyxjoylQr8naHfQW3sA3fD4BocgPIras25XST1k=
X-Google-Smtp-Source: AGHT+IEgfxRJ12Elo2Mj3T9sxV6ykVqux1XoXH/OB09Au/IF1wrIYIKbIAazKyiv2y4K7SQgYIWcVX0p/x+dywwGsVc=
X-Received: by 2002:a17:90b:3a82:b0:283:5405:9e90 with SMTP id
 om2-20020a17090b3a8200b0028354059e90mr22124851pjb.3.1702723702304; Sat, 16
 Dec 2023 02:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20231127193723.685180-1-tharvey@gateworks.com>
In-Reply-To: <20231127193723.685180-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 16 Dec 2023 07:48:10 -0300
Message-ID: <CAOMZO5Cz5N+sRoa9w+5uSgO8P5hOhEz3V1HUgx5Gqh-Wt9S05g@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mp-venice-gw72xx: add TPM device
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Mon, Nov 27, 2023 at 4:37=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add the TPM device found on the GW72xx revision F PCB.
>
> This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx next, thanks.
