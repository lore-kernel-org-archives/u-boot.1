Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4514ECCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E54F83E4C;
	Fri,  7 Nov 2025 22:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F338in1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657B983E44; Fri,  7 Nov 2025 22:35:02 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5906E83E40
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-656b52c0f88so547972eaf.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551299; x=1763156099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVVkJOco0J374cNDXAsqkaF8ShPVJlRedonTJgtj4Eo=;
 b=F338in1VzV3ayeSdVlbJTHdmXFg11SdFFzE2CpVIyynMZA7Z1WgbYUUbJrwSCaaPiC
 WFugwaq/WG8yid0RjQXnxAs6TBItY0KtqifXG5bszDcOP90XjEf/iZYyTcm2KAF3HfSF
 IHQ74YdUVEw3u7al7DtAjF2lpYlxmm/8x6Muk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551299; x=1763156099;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DVVkJOco0J374cNDXAsqkaF8ShPVJlRedonTJgtj4Eo=;
 b=v/QherH3LCQ/Ur637dnAv/XQXla6YAocxI+6HsSSp7KgA45yBwBT4K4b9KzYLtrNEA
 0lI6Ci41zQrRKfmverTY/AJkSrCTmMw+hF4l4N2JYSMGee5IxWe1wON5FJlqzU6DLaDd
 G5KDgz/1cApS5IFG8O76sWFYi5THLAfybyXsZkxCaIfCmHBEVofquvV0VmeVqnLR4YrP
 9n0rmHwsp3sFjlT1PPIisoJ63CeEQhYGNug1W6U8FucG1ZzwZBc3TWDGt78nDkw4b3l6
 4cEIegBR2aa+BoGagmivtVlpt8Y/1pcJyjJ5F5xCb+1B0qJPxOopZ9pxQ0E7/FnC/MfH
 EfIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGXaTGuwLu20s4WdzsxrbIGxMVC8syAZON38Uwjm/Vyo2Yf/sA0XFAU8RWJdJuHdh8kOrooBg=@lists.denx.de
X-Gm-Message-State: AOJu0YzVJOMQgIHk23uZfAo6Un++KT6TBdPcO+ag+c0JSU3c5zQKwXFU
 8NHWbOPhdaDjajctpRW+g3U5+vEkaL8CcpulTPDu7dXoM6qXcUKXEmm1Lhxe9NPpS4gbu0osTw+
 kFNxA8Kiy2Q==
X-Gm-Gg: ASbGncuErPD3evFKMEoa2lRJUfCNE37xRy4yLLF6kZh+lyWCp9WB6VLwPop8qhU8idL
 wnB40knkdBoWwvq5MnU78cHqTjonRi6zOxvaKBph6t4E5KQE752/a3ILyTQIbyrKbC05Lp/jp7Z
 jOlRPc3xuhKg0M6YZtOwPF9MpcsmtZ8EVtZgcVRRrt+f1mpfyr9yv4t4dJBWdGArMdDVh5PxYH8
 6HUkn7y8G+Hl1+Ni0WmacoqYxachhfyjofZGvCaNmlBx/Mq2QPAU6VjRBC/GsMMQDaA6qY5VMie
 tIogeXlACqgaPAwLW1WfSfcw3WvQbG9JYt5JMPrh9LyJcxvX8Zki+QpS0tSZYr0wminwDpHJAhX
 9IsPV7u6af7yqRn+FRozrAAEK5oyMKEEYE4XVGNdwdUYK24jh39tpyGSqLAAr/gZlup27fKZCAB
 rYvzLqr7qLABESXKpdHPZWVSW4tKtRR8z5zp1W9R1o+qIGXfOU
X-Google-Smtp-Source: AGHT+IESr3UQdwfg5YZChs67K6wUDISswHJgIwGRe58n4ydxCLo0gxnrGzLNJTsoUuesIqKHmQq1kA==
X-Received: by 2002:a05:6870:a546:b0:3d1:d631:64f0 with SMTP id
 586e51a60fabf-3e7c280b255mr707714fac.41.1762551298970; 
 Fri, 07 Nov 2025 13:34:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:34:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20251031210700.643712-1-heinrich.schuchardt@canonical.com>
References: <20251031210700.643712-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] sound: all sound devices must depend on CONFIG_SOUND
Message-Id: <176255129808.3424353.7301001281272431705.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:34:58 -0600
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

On Fri, 31 Oct 2025 22:07:00 +0100, Heinrich Schuchardt wrote:

> Clean up the sound Kconfig options to let all sound devices depend on
> CONFIG_SOUND.
> 
> Before this patch it was possible to select CONFIG_SOUND_MAX98357A even
> with CONFIG_SOUND=n.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] sound: all sound devices must depend on CONFIG_SOUND
      commit: 45860d882f3c32ccb091820d16f02d4aaac4c35c
-- 
Tom


