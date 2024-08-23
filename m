Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0054C5321D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EAD988A39;
	Fri, 23 Aug 2024 21:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SJo4Jpj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD03C88A3D; Fri, 23 Aug 2024 21:14:59 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD4A88914
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f502086419so1136501fa.3
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440497; x=1725045297; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVyyxYMWniWwfbF6Mk4gPvGx7nC3X4RxUR75TOWlsXo=;
 b=SJo4Jpj8U8tlxXdcBzp72WYnAdZZOzLNXrrb73US6Q+Xzi8r/oJA3zANnseUxPR+f9
 Xx+JYKHLSf89b8vXaJDqhQKMTKLQvWzyecyFjKPCcqwIxVhsXJ+P7W9znn30qce5iriC
 dp4zYv3HDhSKSB0HtoW327aY6FLq60uXF47gnmrmUjogJp+RAx73eLDtmOHaqH1c2cUP
 Zfze9O0hVIF448QRUMXthsyxgYaI1rP7w4SIiAkVv57AXAuDDVh5XTRPtFBIpXAJXEX5
 GkAS8PQZDF0/5D8rAUQIShPulA3vvbP1NZXuJarHq6c6XITRCW6lFv+H7LYRxZZT+Fvp
 pVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440497; x=1725045297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVyyxYMWniWwfbF6Mk4gPvGx7nC3X4RxUR75TOWlsXo=;
 b=kAXKAOall0VAOppqjvDlvYruz+21SdHxWx2dvCTU2Gd2EU+TcdxPllRaNGws3avPn1
 we6N/T8bgK79OxQUpberk4nQ/gBT404kh0bc1lBgUwF03Kh44V+rr3pPaIarLznO0IaH
 e5qXNqg9Q+/Zb52zQWoXTgDI7emGOOflXIHwX2icttC4kOg2AG/P+l6VCYaF6rI3A3Gt
 RF4QFv1oHeSHFgK1rPIaJ89tuZoe9buX1GI4tbcGC+fb/R8RpANZnZyLpRy1E0TL4zRh
 sjCupCPfkNreUUjev+MVlT46Qhp5ZbSU1BbHKEUZSDp8yhLL2EDIYoijONVTt0Dap/uD
 HLyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzMIZI/0ynBs6IqxPffnH+fPxcuLNNdaavi69xlLpb1sE6543EdBkq1PdCDhg6ODqW83q16LE=@lists.denx.de
X-Gm-Message-State: AOJu0YydZ+svfSf1y6RdYpdGOvGcj31t8IsykxcyzLv8o2gxpb/KWS2v
 r6sI2iwNquHaF/CCHcDb1ir92mP98u55+vIz73bc86f8JKhn+YwGUk8JvzyeMW0AOQE6NqnRCC9
 +28WVecJPT43l7+AdpiS2g4cyZHw=
X-Google-Smtp-Source: AGHT+IHYsDNdOiDDAkRoCnwXH/tezLep6PN/Q3dWl4jcoSAGH1B4OfaYC+oawzieNvitr7ZGV2c2hlEWDz/lk9LCS14=
X-Received: by 2002:a05:651c:1505:b0:2ef:2dfd:15dc with SMTP id
 38308e7fff4ca-2f4f48ef636mr26994071fa.9.1724440496630; Fri, 23 Aug 2024
 12:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240809165332.1898756-1-lukma@denx.de>
In-Reply-To: <20240809165332.1898756-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:14:45 -0300
Message-ID: <CAOMZO5CXtM_HZ3rfap-811g=W+Ue2EpRJztAgU9WUCbJN_EP4g@mail.gmail.com>
Subject: Re: [PATCH v4] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
To: Lukasz Majewski <lukma@denx.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Cem Tenruh <c.tenruh@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>
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

On Fri, Aug 9, 2024 at 1:53=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> This command allows easy update on SD card or eMMC of the flash.bin
> generated (with binman) during u-boot build.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied, thanks.
