Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCAFCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 17:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2CA8382E;
	Fri, 26 Sep 2025 19:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LIoBgdwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46BF83855; Fri, 26 Sep 2025 19:12:56 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB228835FD
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 19:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-36bf096b092so31611271fa.1
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758906774; x=1759511574; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61ST3f6QYcM2Ke5AjZB02oJvSETxTvAzFffo5DQBaEs=;
 b=LIoBgdwKLAdB64I7gWFjqQPliKyF3FE/cVKn43XmMF1IpgTSa3ssaWk34Wdxgt79Gc
 yU7z0vIIfSiayc9/kvCcSyQHKOxnYHvly+EdrIRJJRpMtmm8XHgQ6OQMtBSSYTEMVn/2
 emdTtLibJxSPDVWbS3Pb0hb/u9vBee/5ecZxDwjERaWrnUKohOMG9Toc3R13UA3EL4T0
 4r7JPtvoBPWhznLgj9/6znhUsZOmiMmAH9cRQCbz1zIPC1SZuD6u8IkdlkGNwCWtlQXj
 6e6mjp7APkO7I3IzO3xxh0Op+FYIHYJnh3lyENIr15s+DmwmlQnV6ojn4QZuEZgmwHcy
 3AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758906774; x=1759511574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61ST3f6QYcM2Ke5AjZB02oJvSETxTvAzFffo5DQBaEs=;
 b=fJtOeVSWVG2prVRNsW8urIdL+rHFFg8+vOmeSQ/+U94FRv3NVv0Zzw97d5tC/DHbY6
 V6VNnqnGStarcbcjCUDeqRivN8ByUdxS+ZngvW2E8pOzBQLK6iuYYHVCeZmqqVzDmucU
 islbgo3TzrR2BNCJ6r5sjgY4bAzog7kTf4viWx53s2pCeR/ChrzJdI07cr+bJKNNK8qk
 4y4/S0Cri5KqENnX2pbRM6VkjztGI1eycUgDiWg2Ho5x3vPnl5hLIklQLFL6PBHU6aPq
 zQRJkInV+SZ42P+mardjpGtl26OVYPyXNgcqAL94uCO5JpFKpG/WxFC//DJwTY4UHTvC
 au5A==
X-Gm-Message-State: AOJu0YwV/IoCQKZplmxh048+I2LYiTYCoy2eh9rb88/0IFIH2OM9U+Vg
 d3DQGbRf9VnWYc/aDPNLYxKo+w+IomjJrT9kkVKLY/0bXHL/y6WXLd6kJT+zTfuXyvyvo279MXV
 Yh03pBj4bRRw52qHAnuMUanRrK3YwuXY=
X-Gm-Gg: ASbGncu3KMuDezq+Jz0eGM6cPUg4j7b0AYG5DCla1Qns8w2rF48bVVsOsxnWrGtsDaY
 Qgwvw3EoSZe+GL+3j2LOKeMqV7NLA7wO1hBxaWRuKy/PKcp+Bo/9Er3cpuM1rBQzvDeQHdrCyxR
 UVBvfjJnmvX2KSMZ1pacYkdDKMtk1U4aObYc4n2WxfWJFlESwLb+lLj06ZauAM7NmIeDGVRNXnf
 8T9csWyNcSueo7AhD2ftAhGVBC0llfY6czjFm0=
X-Google-Smtp-Source: AGHT+IGn8xwblDk/lfyOljhfIliYe52ZPoRotWydhvmC6hS1k1vOGaaYYtj1IkeJf9a4x14ezPwejao/u/ig4Y9Xlfg=
X-Received: by 2002:a2e:bd12:0:b0:36e:ca93:6299 with SMTP id
 38308e7fff4ca-36f7d2cc799mr24770931fa.15.1758906773805; Fri, 26 Sep 2025
 10:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250924021127.2866184-1-ye.li@nxp.com>
In-Reply-To: <20250924021127.2866184-1-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 26 Sep 2025 14:12:42 -0300
X-Gm-Features: AS18NWC-xwlespp1LqxxTij8oPHxqik6EejPRbhd6-hvLq-vFjwGc5NyEdn6_LU
Message-ID: <CAOMZO5DZabJANTXZdcUZXk18D94zL=T4C8tbzYLv+0tqS_BQGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] spi: nxp_fspi: Use second last LUT entry for AHB
 read
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, peng.fan@nxp.com, 
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
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

On Tue, Sep 23, 2025 at 11:11=E2=80=AFPM Ye Li <ye.li@nxp.com> wrote:
>
> Use a dedicated LUT (second last) for AHB read command, so we can
> directly read from the AHB memory-mapped address and booting M core
> for XIP on Flexspi NOR.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Series applied to -next, thanks.
