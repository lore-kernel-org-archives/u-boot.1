Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F05DC87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75A583965;
	Wed,  6 Aug 2025 07:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yz4dgelP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174AC836D2; Wed,  6 Aug 2025 02:35:59 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22941834B6
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 02:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ramatrinanda@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-615c29fc31eso9989289a12.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 17:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754440552; x=1755045352; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pDHRsDdldL2Yk0Nnf4ckd5jW5VQ4LUdGxonJpXFI7nA=;
 b=Yz4dgelPvVL+9mCzk9XWjix5zrUGEsQeUh0nIffJf5sTPuopDkJKSMaz92F46XrcJb
 yB6ivixiidJRwJ2CDBksoZGcV3I5fWvU9ldJljD1V/2lD7hYA19qmyCMVxIgM4gfuPZM
 x966MBywR3z/tSQXfBHTwJ/PLIG5vVDrlOtPPcT3RoQnPK6qKcaMvMLLr8gp+9BcoiOM
 81sd3seVP4O5P6Ti1oM0Tq+0gBBDLsDvAVB55R7UCI37lu1BLiF8oKpgJwicqTwx1qWN
 y7VIS7EN5NzA+n6sX7XGkhBFyp6Vp0K83znMIJrz8Xda1q5ZJYgbauFVFknN9xgcMKf+
 yZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754440552; x=1755045352;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDHRsDdldL2Yk0Nnf4ckd5jW5VQ4LUdGxonJpXFI7nA=;
 b=NcSq5C8tvuyNhSVwI8GMuMMlJWbwNq9UIRr7Gfp/GVtq5IR6PkhJFI+q/kqxEy61FY
 K2faM8QLtbGNWkn4Otam4YnLPF7R3Qsal7fHNUUVRGL+2htC39/UAi8f/wDJ4uS8BJhJ
 Plkyh7gB41C5kfG7fq5UY732KV0FmZBkS/Cj8igNpFxwrxfHp9nlvg9BuTPZpLvoAS4h
 TikIajzgg1N5etJ0AAWLKm3xFXuXbU3xYW/81d+qO0rjfK8Rt8SPubeEQu9tN0KguNoZ
 MgWqFDKO2MJd7VRiJMMCLrdqpAaO/3H2YMjUeQS+IM2iJlLhwEIsdytfYa1mAi+kU0xO
 Rdmg==
X-Gm-Message-State: AOJu0YzIfTNZI/e9tmjQFqpPoHbcnGedPR8GW07UFYLx+skch/6pwJIy
 bGuaO+o0T1fbgyY3K+pVSUB2ihPpWAObTQU5MfxV6Y+cB8n7f9F2ro6EOZlScla6xbLx3aGHoj/
 CHImLm9OFpU41OQJrjcdRiPjeB5VlZKaqA+fV
X-Gm-Gg: ASbGncsijDTnZUWWbQM83srLQaP8V8ubLG8B+O0kx41XTx9u6P26PPEcXLQsZ/BA6Te
 ib6+K0zD/EApE/HMv+ZD1uIAh+CEpo9jm+viPaxIg+GviWqhpzNVYyETQi2/HvGDfugPwPim6w5
 fnxFn/rFyAWEIvXloqGCOu1HXxsHm38cdlPOj38QU5n1opcmjYlMxaYwvUC6Vq9/IZJeNaJ435A
 L3bj4MrFQ==
X-Google-Smtp-Source: AGHT+IE82w2DsNBuLAY/1SbFBF9U5t+w3VYbYhVDcOVgP4aGExSjz9xBqYTFbl9yYj/+J4HjiAjmldrMQyw+Cl+cbao=
X-Received: by 2002:a17:907:7e9c:b0:ae0:bd4d:4d66 with SMTP id
 a640c23a62f3a-af990277aafmr90913166b.27.1754440552066; Tue, 05 Aug 2025
 17:35:52 -0700 (PDT)
MIME-Version: 1.0
From: rama <ramatrinanda@gmail.com>
Date: Wed, 6 Aug 2025 07:35:40 +0700
X-Gm-Features: Ac12FXy2HqeDZcegst0UEYRwiUxl4DUFE_D5-9a_mqOjzu1inCKC_VIYoSsMe08
Message-ID: <CALvkNmjby-kU5Ee=ZmP0FAUxYeUkHKbeXYo=6b3_9oC7Loft6w@mail.gmail.com>
Subject: Request for Clarification Regarding CVE-2025-45512 Affecting U-Boot
 v1.1.3
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear DENX Team,

I hope this message finds you well.

I am writing to seek clarification regarding a recent CVE entry =E2=80=94
**CVE-2025-45512** =E2=80=94 which claims a security issue in U-Boot versio=
n
v1.1.3, stating that it allows loading and executing arbitrary firmware
images without verifying cryptographic signatures.

As far as I understand, U-Boot (especially older versions like v1.1.3) does
not perform any image signature verification by design unless specifically
configured to do so with FIT signatures or integrated into a secure boot
chain.

Given this, I would like to ask:

1. Is CVE-2025-45512 (https://www.cve.org/CVERecord?id=3DCVE-2025-45512) an
officially acknowledged vulnerability by DENX or the U-Boot project?
2. Do you consider the described behavior to be a vulnerability, or rather
a default characteristic of early U-Boot versions?
3. Has this issue been addressed or mitigated in later U-Boot versions
(e.g., with FIT signature and RSA verification support)?
4. Are there any recommended mitigations for users still using legacy
versions like v1.1.3?

Understanding your stance would greatly help clarify the scope and risk
associated with this CVE.

Thank you for your time and for your continued work on U-Boot.

Best regards,
rama tri nanda
