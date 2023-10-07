Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A952E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2383B86EE1;
	Sat,  7 Oct 2023 22:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WrQ+4+zZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6CF86DF4; Sat,  7 Oct 2023 22:38:00 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D169286DF9
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32487efc319so3126331f8f.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711073; x=1697315873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AX/U7CqBD0XXHfygNU4uKz0dRokhULMolc/PDE6/sHA=;
 b=WrQ+4+zZd+LIfdWfYzks31/m9ELtkioXdE24DwmDfETJxQwWB3rrCA10+k/54iJANq
 q+p7eVL3iuLbYcIX8DuoEDfqd7cfAOBMs9mDOqQQMOKEU61LjA34MhNQYSuBSUfiUlsS
 PmgoRFqGWIj1Kw4VJXA8FzyEabrb+gaEKA0fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711073; x=1697315873;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AX/U7CqBD0XXHfygNU4uKz0dRokhULMolc/PDE6/sHA=;
 b=HOZQ/9cuPNWwjyzTBqGoiLG55CAdA2J9dypnb/+wmscMIF111QjMiiRtXDCt0ImjZZ
 SuIUrrNE0LyBdUv25B60qCL5tQILv8Ub7CmxQ1mXUHqqiugyACDwxdEeW+YWOAtXKA06
 aMUv4TshOUlsX2VeUKHHnJWhCcO/XGXGrc2b19RkQPhY9jHrWowZ1hQ/lb7LldQSPHD4
 o4yeagPM6Su57bTorOX9VYsG98McW7OnZDaqoQ4IvrpqX9m+fMNWAt1At2QG6g98PnhS
 k4o0tPbDln8mzYke6omn8MLYeh89/PgsQc6DfI91J9lIx/kdIreohWvZvT71SecY5Bak
 FgsQ==
X-Gm-Message-State: AOJu0YyTIyJ63cGWDPQR0Ksvw26SjS59vlDIUunLcQU4uc0FH4Z5xm98
 s0cGkpKLQRynHTQjv3HMZqw1df6UK/8awGCooltzrrjMBvvPKCszcg4=
X-Google-Smtp-Source: AGHT+IE6b1hw03TJghxB3mOzrIX4//XNkrqyaVjc5fHD1wwud5Mt/VQ7ZoJ+fG0OcRRITN3zZBVx/TPSQsm08LEylhk=
X-Received: by 2002:a05:6000:1201:b0:320:10c:37a4 with SMTP id
 e1-20020a056000120100b00320010c37a4mr10475648wrx.21.1696711073048; Sat, 07
 Oct 2023 13:37:53 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:52 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2hz+Vc=isBExOUvdbqF-9WC1PgKPfMAnnhjXkR7DXQ4A@mail.gmail.com>
References: <CAPnjgZ2hz+Vc=isBExOUvdbqF-9WC1PgKPfMAnnhjXkR7DXQ4A@mail.gmail.com>
 <20230923194424.1739224-16-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:51 -0700
X-Google-Sender-Auth: u5_iGtgWPHY8hlOyuvO6oe6cKrg
Message-ID: <CAPnjgZ1QahjO1i+H2zJACp7WypFquTfpt31iRbw8Hym0rcqF8g@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] moveconfig: Use an encoding with open()
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

Fix pylint warnings about needing an explicit character encoding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
