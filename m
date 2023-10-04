Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AC4E7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9858763E;
	Wed,  4 Oct 2023 19:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bn8qu/lB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A34C87610; Wed,  4 Oct 2023 19:58:43 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE0587622
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99de884ad25so17184966b.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442321; x=1697047121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FUih+CqWZGpN72YhC1EQ09KYZxlbszgXXzK1gFYrTwo=;
 b=Bn8qu/lB9SB6WesyKaZRZEmlFI/6zL/VVwuWatI90vpUJ/As1JLhCirn/Q+SrtIa0+
 apUB/JpvQKqBa9dqZIMUERSOPTuffrjN3GDiD8xK8jVwoRh4FxXcnWnAGTWVdJMwB3iQ
 FtJxmXnuTbmFMBRtdUroaTMrTDwEJrRKHFBJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442321; x=1697047121;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FUih+CqWZGpN72YhC1EQ09KYZxlbszgXXzK1gFYrTwo=;
 b=hoYQHifb7aYTK7ZyfS6bwbpbtcjso/PLZJpk4Vl2t79nYWW+oURyRMAAA9HXraKGQV
 ysIC5nqW/S7p+mWV7OgfIRstcDBs3VnGqkjXaK16LYBHL6E11FY2OMyCfBmAWW/FDDU1
 SScdULaFH3272+zbRlUWVKvvw5FPVc0uQBOTGiEbE9IvjxzicfH0RgFrg8BR6o0fuyiX
 sHW9EspSs+SS0659+mGfNLuaIanNdfBmFd6y+NO3L611IHV4xuBWAlwAL5G1G/NI/uKK
 JxG18ZSXdwBOvqQjAkqYV0upOFDczShCcty6m+IxKu6uTiBF9XcvFLRHxdH/Uo34thIa
 dFlQ==
X-Gm-Message-State: AOJu0Yzif4JCGjv+Y1MRpqDiPg5VG3cMMxKWSBoV3c5zuAY1gvLo322F
 rOVy8R5wnxxL1aBeKPE0t3EJ+mMN4lW6Y9QCKE2CLQ==
X-Google-Smtp-Source: AGHT+IGIQ776TavNAbYR97IJQJZDWZ50qr6za9ls8IkGbpZnd1lkO+b6ZUKnthwrQDp+9gfLVsH/wLdSY7RH4+heJj0=
X-Received: by 2002:a17:907:2ccf:b0:9b9:9c84:5e0f with SMTP id
 hg15-20020a1709072ccf00b009b99c845e0fmr529919ejc.29.1696442320749; Wed, 04
 Oct 2023 10:58:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-10-sjg@chromium.org>
References: <20230923194424.1739224-10-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:39 -0700
X-Google-Sender-Auth: lwxxyxCx5B9khT48CtV-tl_gncg
Message-ID: <CAPnjgZ0gJv1EkfROERHgTdhaafSv5T3dSsf6EkyVQW0tU4Se+A@mail.gmail.com>
Subject: Re: [PATCH v3 09/27] moveconfig: Correct parameter-type warnings
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Fix pylint warnings related to parameter types.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

Applied to u-boot-dm, thanks!
