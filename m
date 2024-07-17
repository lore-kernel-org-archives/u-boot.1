Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2959C3DA5E
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293D488A2C;
	Wed, 17 Jul 2024 10:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="qFsf9LUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B0188A35; Wed, 17 Jul 2024 10:45:52 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86465886E5
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so3803544f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1721205950; x=1721810750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVji2r1jlagOuUz4KCRxbadCTF8LVwmR4AkUCZunat4=;
 b=qFsf9LUAidGuudHO7NTSVUpkoB2CekAftReMAiwCOjVaJyyEziLUWNO0Hrlwy32fAZ
 lsY9BPenc0fsd7gLAjCpFdn/fOEF9bHjhgrK67EDdS4XeEr6jC0mDKT0uplHjRiIrs3o
 LlaJpMmO+V7zxNvNY0OxgyzwUZ3K/Nt9O371Xgza15AnJZAvSlhqvVrOAkaLMDXPc3Ft
 0Ka+k6cADywqWdNkOeYEepwVIjHG/6gS18hcMziVIwu0uM7xr+ZdOaZY2Kv95i7GtQbm
 jrngsFTgO1iaTNai29LxrYEzSgcY0D4ZLG4ciiYOVOKzk/yevBRzMKgDOL0lmsvZ1Nqb
 XI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205950; x=1721810750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVji2r1jlagOuUz4KCRxbadCTF8LVwmR4AkUCZunat4=;
 b=PrURmw8bfxkwEhzpkDQwleLhCZo2A9wiWVZeVDJpSBQGgqMDVlrwbZSf1EzZNpc5lu
 K7Yn13zWEqkpvJlzBh7ZYlMJRMz+5nxkS0F0nCC7ppFAvlfYZgahrqWj45otTFiHYnoV
 L8fJlfp49l1/pRvV1knnEqN9HKmdr2eOJuefqCX/cEs6MNdfUUR27UR8BwuRIOcCTi77
 9g9vB3fNHgcm6O1NoYlezKb4O0orQENKBL5cTSUpKTOtQG/lp1gBmUnndchg+VHegDQl
 6Tw1z094OWvMNMxRj3RAYZAvh6XfPVV12u57Fco9/a0yE/tCtRcnL+RJmmrpBvp0mzYG
 w/Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg3HDSo+zAlv+pSMFC+vSkGwNUIPsgqBbfw0qUo+umRgQnPbXbwxnD/67+BkULsdbLV8sO4KOM75cgKQ+h/PDsTEvxdw==
X-Gm-Message-State: AOJu0YxrikMdN0Mn4r4agEkCtbNNsso26ldfgxdRWIuGet1azL1tlzo5
 LRvSDrxU+3aU/W+KwxsQOArXmcnepMf8Vcc0F+m+vv6Q0ZkLYNMp9hOMDdFR/Ow=
X-Google-Smtp-Source: AGHT+IFxbtCdZNsUKZN4Q57RmhHI+g4TKKBYJktQzgMlyDNn4O5sd8C8aPg/ojBgnVH3xG1XTVAT0w==
X-Received: by 2002:adf:f042:0:b0:368:3f60:8725 with SMTP id
 ffacd0b85a97d-3683f608818mr100786f8f.39.1721205949956; 
 Wed, 17 Jul 2024 01:45:49 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23981fsm200320175e9.4.2024.07.17.01.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:45:49 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 u-boot@lists.denx.de, jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 trini@konsulko.com, upstream+uboot@sigma-star.at
Subject: Re: [PATCH 4/4] squashfs: Fix stack overflow while symlink resolving
Date: Wed, 17 Jul 2024 10:45:48 +0200
Message-ID: <2280448.KTMopqUuYO@somecomputer>
In-Reply-To: <20240717102629.5a1a863c@xps-13>
References: <20240712082344.8655-1-richard@nod.at>
 <3173526.TQGk6oTFT5@somecomputer> <20240717102629.5a1a863c@xps-13>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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

Am Mittwoch, 17. Juli 2024, 10:26:29 CEST schrieb Miquel Raynal:
> > Since U-Boot lacks a common filesystem code, there will be always
> > duplication. I can happily add a common define for the value.
>=20
> Oh yeah, I meant a define in squashfs' code.

Ah! I thought I did so, but seems like I did this cleanup only in my head. =
:-S
Will send a v2 soon.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


