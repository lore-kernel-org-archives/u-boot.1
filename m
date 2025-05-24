Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD98C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A6D835B6;
	Sat, 24 May 2025 07:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IU0+Fc2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D58C83653; Sat, 24 May 2025 07:06:26 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C504583303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad1f6aa2f84so105573466b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063183; x=1748667983; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iBybtGg0K9MBSBbDVPp8cFzQStX1WSbBoDof45FEEb8=;
 b=IU0+Fc2wn6OuIVvRRS1r6VQIHNndbFdUEXvJvDY2wzZZ9AtPK5+glsiCMDAEnjoYjW
 kJWx3A5+Q+LsjP55o1DZJQLORmGtT7zAeFKlOS74cr/enItZqc+MU3xLDcHXigGozIWq
 TSUtVhQ4jlj7YlFU1L1otvFMXG60p4vV+A1z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063183; x=1748667983;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iBybtGg0K9MBSBbDVPp8cFzQStX1WSbBoDof45FEEb8=;
 b=GhPtMRm9H3xPannHHiDJe1jYhn5gWmKkxQaMOPT7wEoivq2WtIvvtDs1PH6pNTjgdW
 uhGvBRLQWhkLbPZyziTgthg+tpQxTBhca6WtTbE4nGePK4V1KNhNnng3n1dlteXSGLud
 tZtLrk3rYxL+xhYz9EUSpBb9a2E23fCFU/RjTGWgQ/4yKOC0HkURZdcKe9hrt/Rg196j
 MFvW3QKcotRSWBEdbyzTe/3fQzAhiv4uR2NVXRxu8FHrsG5q0h6x4tNTuoXWqWaeWPU6
 BAla3Cbwy07Uuv2QpgrB6w4Wiz2AfoWE53dc9/MEAPEiMEOrrFk/W34SK9LWjD2IX3EH
 3DBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzVEmpWtw5LfSw4kqW0QF25AUV8weJRKYUKkDVHuiQ8Jcq3n8DF4f/YsnKvZsENoXKcrqz0ao=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4CTFM3WRTlz7dv25fTFh0UjtGBjBsLXy4e5tqqEQE1XrKF3zZ
 fIWZGE+PEWJ7hc7B095qI08/7kAoGbAmOMVkDSqW6jTRhcmG92m2GbEqZlZe8J0l1yr1MKIqUYl
 +OdovH+3zpNC7Xbtx8ccYFdWgyUd96XLHKXN7sCpp
X-Gm-Gg: ASbGncvQICNWxEqbRr+TT8TFWPuaHCjJ6zTroXBLm6BoVImeL2YPAlAcU/NqLR8iiN+
 TRLXFdtlbG64wAHicVW5blWDuSxhwsKj7RD4yJ41xqbi5JVFUVVcc4Ui8aU2C9MxBTlDAGVVaQ7
 ZUTAmzLatWOny20npLNHdVbsKxNPwfEgc=
X-Google-Smtp-Source: AGHT+IHmkjv41R7bZMECy71ESa+LscM3WSZW6SBJag2LP2dCD7/4i37AEC98N5re5uRxNoI0Ngf62rJfdxcGeNzqHMo=
X-Received: by 2002:a17:907:7f04:b0:ad5:6174:f947 with SMTP id
 a640c23a62f3a-ad64e84b70emr483549666b.22.1748063183272; Fri, 23 May 2025
 22:06:23 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:22 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:22 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-9-sjg@chromium.org>
References: <20250510110535.1453745-9-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:22 -0500
X-Google-Sender-Auth: ek3jtPGNOnoJf0HaLl4U-s81PHM
X-Gm-Features: AX0GCFuPq6RjfrwjiYlF5BDsBLV3Kr7dJwSlol0kDefjj-SeDE32tjf3HG7F_sc
Message-ID: <CAFLszTid2c9Exm2rVee++=_m98A-r1jJ+_ZikD8yAczkMZUaAQ@mail.gmail.com>
Subject: Re: [PATCH 08/25] patman: Avoid touching the system or local config
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Set the git variables to ensure that any local gitconfig is not used or
affected by the tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/test_common.py | 3 +++
 1 file changed, 3 insertions(+)

Applied to sjg/master, thanks!
