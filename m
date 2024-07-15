Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B344C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D39B8890A;
	Mon, 15 Jul 2024 15:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MeJwRoxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA34C88914; Mon, 15 Jul 2024 15:31:43 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5780C88906
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b6199ef089so26162276d6.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050298; x=1721655098; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dbY8w1+1zb+SlHUoULJubZrrVdbz2CKfT5Vyv4scMw8=;
 b=MeJwRoxwVORZcKsSolHcHpL/mF6wiFrbS14WPlIKvUZ41hK69cOdqzOvgDKat5BrJD
 CaiVNAyYBcNkVq+/cLMD6G/R8FZTpT1tWbH3aML1UzVsUrHhQ2p5OSZodCPH1Bo0+x6Y
 IPM+NdH749yMzKGlD2pY5O9ptl+Qq2qGGJDVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050298; x=1721655098;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dbY8w1+1zb+SlHUoULJubZrrVdbz2CKfT5Vyv4scMw8=;
 b=QGfxNhfV9ofZSmfIxi06XqNNuFYCpY7exo7Y+l7bQswxyy4rsY0FEHzGeNzUi5pJhi
 IhJA1+OJ9aFUoPtl1n6kvj2GD8SGdh4TJC/NEnZLpk2u2l1jN8OedVGxmhj9ojXlxued
 8w6pOEmIaOp3V6Hewbcr8v/piUEc+KM8YlJYYmGONpsrD75ip9RC0aYaL2QVYBROyDZm
 kFpoiA0IfNat9WxN5MH0dSzFlozW6cH9WHkEbGQZgsvZ+5ceYj+xFkZ5DZiTHvBwb6lo
 lAN6OSlD1U3GqangNv7akvomfh6XXvxG/eecTJWmTkPLsIax4Dm0+JN5IlZex0O1X4xF
 IYtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5OtDgycfBk1tCe3QZcN05GnrdQzdPjt4Q2W61+AEUjxXzfYVh9Tdsr/qOWxiSbNyDUQaoIrsRPut0sXUhIUhaZZOlBQ==
X-Gm-Message-State: AOJu0YxQ/cbKa5Ep9sTOCj9vQW+CqT2MBVP3mkl3XMzBml35Nv6SajM3
 4ASCXf2QbAgxfD/Zfs+J2WoOhx76VNls6M0LKK6K5h7niHODryBwT9Vk2bha2u2Tk387yYCXWZC
 SnpHfNy5XYEUkpbuqKqcysEtMHU0HnbQlGDUg
X-Google-Smtp-Source: AGHT+IHatmGdh7U8kbZ9RwO6AH7I9wbcQhEzlg+nDBIZ9oOF4apf02FT48ozHMPgBk4lrWJUxEWmW9xYAZw78exm9wU=
X-Received: by 2002:a05:6214:f28:b0:6b5:4573:4ac5 with SMTP id
 6a1803df08f44-6b61c1c5cf5mr230981226d6.45.1721050298221; Mon, 15 Jul 2024
 06:31:38 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:37 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-4-sjg@chromium.org>
References: <20240623175515.1466908-4-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:37 -0700
X-Google-Sender-Auth: T7epZTx6Fu7TVyCPzO8UBlkhV4s
Message-ID: <CAFLszTj5vkqtz7W_YA6o3cgMoxDs9rv1sX5Ey-3hTEROWPmZcg@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] binman: ti: Regenerate entry docs
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
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

Correct formatting errors in the documentation.

Regenerate the entries.rst file to include this recent addition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/entries.rst        | 35 +++++++++++++++++++++++++
 tools/binman/etype/ti_secure.py | 45 +++++++++++++++++----------------
 2 files changed, 58 insertions(+), 22 deletions(-)

Applied to u-boot-dm, thanks!
