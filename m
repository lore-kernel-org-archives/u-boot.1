Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B3AC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 22:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5B482153;
	Thu,  8 May 2025 00:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gLPpp+nY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7776C82162; Thu,  8 May 2025 00:11:19 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065AA8209C
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 00:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-607dceb1afdso251948eaf.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 15:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746655876; x=1747260676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7orgVPzF56Rk08kBh3T0ogH1bFfGS+RaIoZtf+AhJIs=;
 b=gLPpp+nYu56to9FJf9F8+eVZX4I85AUgA5JHnSeeEC4tI2M/cfewyZgVz/4RYKyk8u
 V/NqqJyyQo+DBDlCi5RZQbzTfRIWHVBWgRnwPDvRcKXCqOVWO5JCBydFJr1KTcFLg3mq
 gY/h3MIAeyEHMSI5FZNJAEcPBik48Lk2ZzMwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746655876; x=1747260676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7orgVPzF56Rk08kBh3T0ogH1bFfGS+RaIoZtf+AhJIs=;
 b=IqUH12R6NgLSDZv7cHx6OFy/eQRSQCz3lTZDVy4jjBkbIJ96tD4KETUOjm6iXxD/vU
 BOtXYbpaKbA+3WfGKo3uOoJ2dffXR01HjmpTvYZZpdHZsTjRKisGVNlgyaOpvn+nMvR4
 FPQp/pk/k9Kj0G7P9+7WiZ4y+De/W519Ajiv0mo02ACEk5a/1K9nqdQf6y8DQEUJSmQB
 Bg9YacOu86mqMB3VwDO3ziGUprBCtghiX4qfMIeMXt5n5SvgdMjD7RY0fhh/f8X7FXrv
 FJhVht26ckEdOLLnUF23HPd4c43Nka64aFxvfx4ahDqn3p+HUCN+K6YSNWQD81jmZgm5
 n/vA==
X-Gm-Message-State: AOJu0Yyj4tE31NZnV1GTXzQgX/Mvh5pU/uMZn13NQ9CcYD+BuQkCYTJA
 wQB96u5DEj+qQXvcy8hA3y5hguSWBKBPc+OQmbPIpMCxBtcTukKNdHd0polqQJH8jLYi5LQY5TJ
 /
X-Gm-Gg: ASbGncvKzyPx/r3lVVC+LgncMyXfPp5SCotyDsQWVgyO0gObYuLvf88aJlafcobNo9r
 VxNnNAxb9wqEz62r6hjmAip5gP9KOugUPchw55rwHTdIFHv1JCTF/ab4dQPs0XQr6sAACqqYCv8
 mBK6ftfh1PAkwaKgzSU02oe0/qnodqCGbihLAnmhl0/LjvMRWBJFNHB8dIuIJm4REnI/HKCatl7
 pH7IW+e4PJhkbAg4pQLMR6ilN8WrL+fPPpzW7uwygU8THbTCNO5RNJaqaeCyO2R3bh4+IN3KzG1
 x5KICSPePMQkIPAUcy8OoOwqh2MIhKsbke8PGJoXLCFmayf88r6Aiq21iMv1OVg70mv9Rkl1wTP
 LWkDM
X-Google-Smtp-Source: AGHT+IGUphEh84cwyzMZh+Z/IoZoztQvGwpZr6LXx7u/GdTRTkmCwv0aRIMe1vSly87ZpghEfTO4PQ==
X-Received: by 2002:a05:6870:548c:b0:29e:2594:81e with SMTP id
 586e51a60fabf-2db81459633mr787491fac.13.1746655875795; 
 Wed, 07 May 2025 15:11:15 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5cbf16f1sm967181fac.20.2025.05.07.15.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 15:11:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/4] Start improving pytest documentation
Date: Wed,  7 May 2025 16:08:16 -0600
Message-ID: <20250507221112.518041-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225205003.2640910-1-trini@konsulko.com>
References: <20250225205003.2640910-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

This is a follow-up to the RFC I posted a few months back. Aside from
rebasing, the only real change here is in the last patch where I
document the functions in test_net_boot.py that Heinrich noted weren't
documented before.

Link: https://lore.kernel.org/all/20250225205003.2640910-1-trini@konsulko.com/
-- 
Tom

