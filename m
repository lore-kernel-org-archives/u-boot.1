Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1CCC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809F980748;
	Sat, 18 Jan 2025 08:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A5D+A+XD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BE6E80757; Sat, 18 Jan 2025 08:25:21 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792B28063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so5072696a12.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 23:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737185119; x=1737789919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6NM5SoYKjTNB7MotZdjeLUY0Rg5KV7cRGj7gqNG/rA=;
 b=A5D+A+XDqGjExT76yMhL74FvS/xgvdC6JASn9J+u+7YCjm5hCGDtFhV9wrkUUbCqKS
 ngUULvzo24aZYuaFZhCuS2M3EHR5Isn1P6lngmmTjMVhfWzygNahJ7A/aav0r2eQOW0g
 eqBIzos2VEWtVZCl+1NFNLMX+ieqGo6OG7XEfW+X1JFrYBFGSqA1LZAY4JK+i3SBA9F/
 OdltzoZPo4nC3VtdYWpMw7b3DEi8UhCol8kVloX7r4NJ0qU7+Jz9whubMEA8g2keyuVG
 oFBPJluP8C6cPCag7GXoNCC0fg9ayB+WtlhrIw+Joe6ht6AMZmLgz4U4Jdf9xZ9soHB1
 /iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737185119; x=1737789919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6NM5SoYKjTNB7MotZdjeLUY0Rg5KV7cRGj7gqNG/rA=;
 b=O0eqVuTBBhGzr7Pf6Bl6+Hc1ODxjiir5M8gGEiciXSUSWiDMWYXoUBVbikzqjW9eVv
 hyVcTwwGQV3DOKVmZNfOyCPK4PQ+EU9eHaTIH3rhNmbCDoe58qgbxL05W7O3dCXjt6SK
 /catobJCMN/TbdsGcr+D4zmESUnsIwomlih9iwntuV/cT/xAlLyTRPNLLTpGu1AAmS3R
 bBtrkH8lLSYa0cMD64ORBFbH5Dls13WkwnwhuBMoGIGPQBnZWfD28sBClTaqWNbakgin
 uPsXP6O8JZgz1e30VHZDgAnQHSne23iC8/T1/eQkavzr+Q8PSgeqaYEhoI/Lt+57qM/u
 khAg==
X-Gm-Message-State: AOJu0YxzecnRkOp7D1HjHH3NHMqcfuoddJW7Pi+FCHlDbYQEWO11QLcm
 M6/MNFYJ99Xiqqtumhes0j1QORaFSnTwJC1ZfTv/fNDq3C26mz8ns9Bheg==
X-Gm-Gg: ASbGnctASJjA5cgIrh21CXS042gnmOflPzLLHDuXA3zGycvQSJD0Ln0xfnBCXDstA61
 6cwF5s+Zd5h8nW8JhnypTllJpotPSTsYVpFM/egSAuWDXC4kZMaG9MfOCrYhJJz4hfRzDDRQ3Jb
 8lHsmTNq86xGiY3ZjAeSbxDDhnRyRLE81U2p4qOsM4l0vDdQ1uCROSctB7KSlB6Ff+drNGT3zIg
 /0MIoJdM4IW/QMsy0aD9mqJHUYoe6i/ACS73pdu63nPlbIut7/rCSwLMr2tgNLrv0lQRIvDN85e
 HHgmUpBx6hIasuw=
X-Google-Smtp-Source: AGHT+IGWa/8JOrQHxX/rMghlDOH7g+OOw5DujSYHR6LzG8RJbAwSGcXxZVDvheVQPXHNH493kDeWHg==
X-Received: by 2002:a17:907:3f8f:b0:ab3:3184:6890 with SMTP id
 a640c23a62f3a-ab38b2eb297mr537331466b.33.1737185118715; 
 Fri, 17 Jan 2025 23:25:18 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fc35ffsm287878166b.160.2025.01.17.23.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:25:17 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 5/8] pinctrl: sunxi: add Allwinner A100/A133 pinctrl
 description
Date: Sat, 18 Jan 2025 08:25:16 +0100
Message-ID: <3329551.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20250117014537.22513-6-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne petek, 17. januar 2025 ob 02:45:34 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> The Allwinner A100 SoC has been around for a while, and has now seemingly
> been replaced with its close sibling A133.
>=20
> Add the required mapping between the pinmux group strings and their
> respective mux value, as far as used by U-Boot proper. Linux has some
> basic (clock and pinctrl) support for a while, so we can build on the
> names already used there.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


