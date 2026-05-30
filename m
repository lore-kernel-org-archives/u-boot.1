Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77A4CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3EF68486A;
	Sat, 30 May 2026 20:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DNk/efl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1ADC84704; Sat, 30 May 2026 20:37:04 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA4B846E2
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-48611ae2649so44084b6e.1
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166220; x=1780771020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHlQxttGT8MaJwDzwp+TeWxUfgJ+vCmodCiH2K4l0Y4=;
 b=DNk/efl/38jJYKx90yfhiU+owtwRfd39ZXlaMp6SVIk1eKgwv6qSIKvLoqslfI/HT8
 caWpXUGU2DD71jMdcd8smC9L7Cy26vXWuLJwJMqt48953Nuo2USFkunH5d2EaCocTqtg
 SBAbz9gQOlNEaZS2/4KONQewOUYu2n8PMiRzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166220; x=1780771020;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HHlQxttGT8MaJwDzwp+TeWxUfgJ+vCmodCiH2K4l0Y4=;
 b=JUebCpua9T5frz8RC7PhQpCDC8TtvjR7O2I9UQcu66GBuLzXThrc0g2JSB/7lcySPQ
 QQZ1I3C5nFj8JedsTT+dfGNE4kNeMew2WD22NbW1rbmFumyYg6rabn6kmawBr8B+hUE6
 w1M/ZPraZXJdg5qx6xXQetHGcEqckM1moEj8eWk3oRy4wR+k9xSrlBp4vlNL/x1nX4aU
 +Z/PeFnt+JPgiATIMUPGxdzenNlm93XbZUjGcghGD2jhVrYrMWT2YHPv1CMvZedWB8QB
 gsVe2Yv9QOnTId9bseuBp55wh/ybuqZJNxJJlWjYdcEiOXc9xQBJSOwWRJbUfa0lmHLf
 awmw==
X-Gm-Message-State: AOJu0YyA9WdfLP9COrpoV/ueZX+p9Wzsws9rSIbDKafZc26pYghUDjHU
 GRqi6ZT2wm7K8DuvLX98W8K22BI+RGFT2GCl3h3QGEV9a5z8WNkUf/cWZHG2dQOusN0=
X-Gm-Gg: Acq92OF52j1kIRlpxu5TfV/djZbGnKulXhI0YfGLPWQgl8+qLVZlgoUANa0uTGh4eZa
 wbRYJFSX5tz26W7VUQmMhy1bf0zgPNcFfkp6gdxvpbcnfRPFvg3wkzG1tdpbLtqB5UaLeaVFkg6
 pXa+/c5jQD1H6QV1oBLbTV2UcDID8TsTvJphXziqGQTbo8oxAYZmig6D1JF+T84Okb3uVCA5g/d
 Wpsg1soEd9kav7qa3b6/DEBiVFZAUF4IvE92NHHp0BSXEPAiEKEOaOdmSovxarCfPi3WgEpM1Z5
 znOc1uMlvuEXI9zD7ecPAn+Zyb35K+D6I5bTE9SswDxzjS/YtoFAlNBR123yw8zUCPg+Te764mV
 tMG4zLPIUglE3dqjhMy8BjthI7uD/sbUEs0aWipOssNg1kovJkqEgXCf2Hq5vny0aVXMJJ0VVfK
 3YwoUPoV9Voipfus5Ru2R5yXox5KVteKEzt7NkImDb95j9v8rpXvTIsoghdQRkmLibfHMgB+fHe
 r/V08VjtuxdgAwK3bA7R4EbXyQD4/TJjNfOgF3b8fm+o9OW7Ckp0Wk=
X-Received: by 2002:a05:6808:144a:b0:479:ff59:dcec with SMTP id
 5614622812f47-485fbcb6629mr2197973b6e.32.1780166220529; 
 Sat, 30 May 2026 11:37:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:37:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <20260512075145.567435-1-dario.binacchi@amarulasolutions.com>
References: <20260512075145.567435-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v4] video: Kconfig: fix indentation of help text
Message-Id: <178016621972.1038765.12630826975156283297.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:36:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 12 May 2026 09:51:40 +0200, Dario Binacchi wrote:

> Fix the indentation of the help text for VIDEO_LCD_NOVATEK_NT35510 and
> VIDEO_LCD_ORISETECH_OTM8009A to align with the standard Kconfig format.
> 
> 

Applied to u-boot/next, thanks!

[1/1] video: Kconfig: fix indentation of help text
      commit: 2be4b2269ee4cef497043e39bfe1e727fd85950f
-- 
Tom


