Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036A6CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 13:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A8883873;
	Fri,  5 Sep 2025 15:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NiAoN8mT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B596983885; Fri,  5 Sep 2025 15:32:25 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA05F834D4
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 15:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-55f72452a8eso2587923e87.3
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 06:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757079143; x=1757683943; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gl23jjm73AgZrJjev+kywN4JjoIJWOP7/2p69+GGmW4=;
 b=NiAoN8mTJt0xVJZEGzSvPh3ER1jPthmJV1MOPQ9z0b3nLn7HMinIKSvOLdLyI5bE8w
 a79WbZ8rwzgq5UTnG3cXbzC2AgvftRoJfyjiARM19HVh2+x5G2l6CxH2hcMHW+9izS7L
 G4Aul2RjuGBuECorSWF/q57Lc3wd90m1xsONkBZP1Qlv5CfcGZNLE50b7OCTHfGlL992
 Sa/ATchZEesYgOWpw1LFPqtTLUl/pugSw5n44sY1OsQMdeHedGWgIi+wpdpeHjbkFIQX
 3rUD6LoY1VgHjDcWhIy8g6ol5X7XKfypPHCZIXUEisgNuRUnTCX6F7AGTPQWDcemg028
 KCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757079143; x=1757683943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gl23jjm73AgZrJjev+kywN4JjoIJWOP7/2p69+GGmW4=;
 b=D5vJvw9FYrA6W3Wgni/q7Al/7jL9UxnVcYXBU//rcs8PK6M84bcXTVSDAoCfc8JQCz
 kcUfXR1m8VUkFbAh5eRgbK0Du9cwfPIswh/6bkHTsEy2cuPvfSpfkuXXwZChd6UponcZ
 mnzYtn1kN9hgqAeiygqQ3Knngg82agNaoFYFESC9cuAYYxlya2+pVflnrqAfavjMXMUQ
 yFD+L0dVBqsqncBpAQI2rC/FHXLi79zdUrb7lZLDGvznsaWvdgUfyMTGHmwwji5G5khI
 lI9eqgNEmMHQoZRjhwiRoUMhWp3zelbrppXQWq1IzJ5ozx7QNb5iRmFz9lM01XoilWcf
 sRZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/dG/vcxSq20ZA0m2mQHmeHVwOv5vOndrnfJHPFNe82w1FfUfRInx6U2ehg+6kS24WTFP2SkA=@lists.denx.de
X-Gm-Message-State: AOJu0YxRZCOqBDm94EkvC8khMCZYQxqH1xX3aAmGGEcbfVG/1999QTgA
 4VIkFZUYyFqM8d5NmSVkpv2cPmD203xv0Omwf3/r46C/Y6pYU0LfJYdhEhdmgMN68DmIs/yovrt
 8iZnJb53s4EH2sTwhGS1nunUySVHaChvneA==
X-Gm-Gg: ASbGncuvr54VKTELQiTX233g/dBbB9Cmbcv+EMpB17DgaoRZvXL2cvL4eEWugK7/8w0
 p0nITTpI0QYHG4MloYqWfpvTbnJ/1Gi71L1mMAUcHUZt2yKTMpSnFXVd7QXUukknNlCo5KBwqQO
 FjaNc+V8iBH3Upne5zk7MVM9oews/uJfk6n1iDAVY8YEuR79Uj9no75tf8/bCxRok9vtaC+8U8w
 Ht2C9Xf9/O4yuJELFKaJIvHFYPzhJPAmjBr/+tj94FSoXUGNQ==
X-Google-Smtp-Source: AGHT+IEQc6Ok60pvQZf6NJbAsC9wi4v6QPClUSa7QzuVIPv4QeNrCeUFargX1DEGxtMQp6e6Qbta9vi5sjAk/jIB2lE=
X-Received: by 2002:a05:6512:3b8b:b0:55f:4031:436f with SMTP id
 2adb3069b0e04-55f708a2b94mr6953177e87.7.1757079143021; Fri, 05 Sep 2025
 06:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250828082008.2978900-1-primoz.fiser@norik.com>
 <fa4d9eb8b7333c5871b79acf9d09f6c10f74c438.camel@phytec.de>
In-Reply-To: <fa4d9eb8b7333c5871b79acf9d09f6c10f74c438.camel@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Sep 2025 10:32:11 -0300
X-Gm-Features: Ac12FXzVoJ9ayMAoFrJz_3P4xxqlyOdPgU20HlAMMemvJgQldEMwtiKkPTgwONw
Message-ID: <CAOMZO5C3acTbY+T+Vk53-J_c6h20QNMiyoETebL5O5D+QuA16w@mail.gmail.com>
Subject: Re: [Upstream] [PATCH 1/2] configs: imx93-phycore_defconfig: Disable
 CONFIG_AHAB_BOOT
To: Martin Schwan <m.schwan@phytec.de>
Cc: Christoph Stoidner <c.stoidner@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>, 
 "m.othacehe@gmail.com" <m.othacehe@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Thu, Aug 28, 2025 at 6:33=E2=80=AFAM Martin Schwan <m.schwan@phytec.de> =
wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> Reviewed-by: Martin Schwan <m.schwan@phytec.de>

Applied both for next, thanks.
