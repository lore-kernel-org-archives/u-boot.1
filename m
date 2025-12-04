Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA127D29FB2
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 19:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 221ED840F5;
	Thu,  4 Dec 2025 20:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G3Wk5v7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBDA840CB; Thu,  4 Dec 2025 20:31:50 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5F384083
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c75fd8067fso935921a34.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 11:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764876707; x=1765481507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsQ6Ox5sFzSdf3SMIpY3C8l46g1wOwPZjKuLZfh+WZ4=;
 b=G3Wk5v7zL7qkPqRm39tcr2Ab4pj/xSiH+yeq0DhCoHSa8gHx/AENX0XvwxB1mhrhnA
 UZfhQ7FY2wMICgPbywp1FLYo2mFZGogjm6O2mLQYr/BtiS5hJlNvzj4uXR2BXzpWmc4W
 U2GNnaj408LCcxzHjyPymdM3L4hwYXlTUQjVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764876707; x=1765481507;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rsQ6Ox5sFzSdf3SMIpY3C8l46g1wOwPZjKuLZfh+WZ4=;
 b=dOKk8hF5joqfwT5CzepJBobQMpLbtyJQDTg5Zte5HbaMDEBLZLpy2rrbTQTXo6bVda
 4stLyzzlTKkDmnEqDpoJlx9cr8ktmIZWNoYSoLkpG/ZRobQNqTLg9u1qDSvZrDWRgAvm
 Vnb2TdQ4i1eYCzB0mUsqpGieBVy/zLD5ochJ8/h1qd0onBgX25qfoVWGhId8z0DE6VGC
 lm+esmnJ6A8T4T9St1YU4IkCOa6EFSrAJcjwUJZ8FBFCXcqvnGP244vUGuEltgSECBtV
 7Oe3riVkBglDxFyW7muqwBX0iMPOqppTqpiEA7ei0JwSSPsTc2PXPyvyd5jr6JugVtEL
 5bgg==
X-Gm-Message-State: AOJu0YxmOAnIQxiQeiEEHOGyzFrZxPl47UarOBuVDgz/dILypqHT5DT0
 9tG2FPvaqFCpCu3otRZ+heL0BecZZ2UIPzFGdNWUo+lOKb0XRKvsQL13T8KY6xtpvAQ=
X-Gm-Gg: ASbGncvr0Gpr481Zt6lPkIQMb0ey6xxa+NIRDUBm58OCRd9x9+QiHZIfuUKdSvjH8uQ
 GlqkZRw8IbDVE4ZD/exq0++fFCwyHFeRBfPFXssphlz3sCzSDvADnaYB007MJdGeHMfKZFp8JhS
 uJUeTxr7wkJIMi5QwWL+PfUsOWufNTE7DaaDBxcSS/szIriZSYtqhr9VR43cW2+/n/vbR1QkU14
 Y++OdsHVf+csYqhVsdzvad91DE1jsz82q4lUAVK4HZ5F7Oy7lnhgYw8X5WoSiCzPHYI+QjW/owL
 /ve/n7/1iQm2H2OREO1miGlkA1VBOGIgLrcPUxfadV8IYi1jv90PT43DRBqr49TRdQWIRV26xva
 r3W6u0Nz0kC44fMULAO8exP0AeAES6UWGlfVsJGOXaTf29tXDqbQEDtrJhh+VL1mnPr23T+Hqlp
 xccAJZRUhf3fL6N5FXCifdkKu8suY6lV/+QqJ0gOYkE1+vzioa
X-Google-Smtp-Source: AGHT+IGzW6AtgfAL6k+gKHEJMux261TdKijelFY42avE6C7RkQ3pPn7ydwtuK8G+DOATOk4FVDNZNQ==
X-Received: by 2002:a05:6830:442a:b0:7c7:5907:b1a1 with SMTP id
 46e09a7af769-7c958aabc82mr1917182a34.1.1764876707244; 
 Thu, 04 Dec 2025 11:31:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef0c840sm1147095eaf.9.2025.12.04.11.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:31:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <87tsy6sn9z.fsf@kernel.org>
References: <87tsy6sn9z.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20251203 into next
Message-Id: <176487670618.2050783.6936024614784578473.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 13:31:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 04 Dec 2025 08:45:44 +0100, Mattijs Korpershoek wrote:

> Here is a PR for next
> 
> Fastboot:
> * Add generic flashing support using BLK
> 
> CI:
> * https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/28617
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


