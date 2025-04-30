Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755BBC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 09:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C34828059A;
	Wed, 30 Apr 2025 11:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nD5yTAtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81B2809D4; Wed, 30 Apr 2025 11:11:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C0A8056A
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 11:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB7C23FC41
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746004314;
 bh=v1mqNY2H/IinJls6Ku+irhr8UZinurmg11W/Yk1TfNs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nD5yTAtNhrJncl9UGa8aNr6GBKLkrc0yg+KCEEKLibauQXnAOnxkMJ3i6Jvg2mKT5
 fBYrC4QgNjtDkHEnNwUNJWiwhd4+o+j59FvrzPSyjhiZo2JlQomt0dn/w+18/s3VHQ
 s7L074AlB+DlmjZd1lYKVyaxuSSpHJ+difkjxMdlJsAl6MNezSM++7Do6+WZquOlqe
 Eu0UUoujvdXXpT1kGHW3InDJsaAjbVGZGQCrkniL9ENAt9/ehtfWebbPTphsmTAOgH
 wYnB3Xn7Zeaf+3Mrql0soWLiTrr7IQoqvhQB8K8rZLjCCT+/5yY9n6N0Op1SJPLjdv
 3A2dPwe245AUA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so38131155e9.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 02:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746004314; x=1746609114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v1mqNY2H/IinJls6Ku+irhr8UZinurmg11W/Yk1TfNs=;
 b=MjYxcWJ6jQhx3B3ud/4/7IEYa+//DptKKAUX/ILZK+IKLX4TiLtrLLdzqaWdUrIBaq
 DD79joEn0z9MBloiOPWlyKjUer47/M9d9wxTh6qDIwVu9P/fyLcb2wUH2LPsD4a6ER/c
 LSNt4pJ3p3lpn/8odvdg88YJGtBo5T6aC9UWrLC548KJty5usZe0etA+/UGfxBEppvBl
 jmY4EcshegKVlRolL8Jzw8VicdtXIblIwl5KdP/u91udlalSDt7OydubOxMEoc91HYmy
 MH2lwhQagstIpHuO+j3p2LEw8K5AcTsj6qxe4Q2KFuXFyvbYEURcGfDswv3n+RrAPkpc
 t20w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK9gAncX7bfFZoh+x6k9j/KEi+R9AQCOQSYIyvZbPsK5jvXlxOLPJSDb18wrf1bzlWUcIu4Xg=@lists.denx.de
X-Gm-Message-State: AOJu0YxULvHJ49d4qSY/cLoHf8GkUEg0NxzlrZMklxe8XmF43z0tsCLo
 s63v356DTTrpV65KFIGH6Ufgu1Hcox/Hl8xmmapxAcExhb+bMCz6HWmjTshmA+9lcHbSdgAqHfi
 5uyXRNzANKs2AGs6YPwhgji21+jZ4sGhrkQiqRy7QRs9F5iQQjhQSVVKQUFvvDEU/7NWuVP0jc5
 E=
X-Gm-Gg: ASbGncvj2/k4CAevvh3tPEM8Nxi+k/eLrNp2kyGkzASSmXNC3OQF21S4eZjwGtNo4mY
 jjpyGp6bkERh8OuyYxDQ86BJR+arweFJAW/3x2yhTwKWKRA4BsoI8hdL/sOrLdzRjYqLyfAUbg2
 ZGloCXqxvlhnI5/fLzj2g8A2FpRUG8pmqk8PtKfEoEuLTn2vQvLaQ0QqaK/yQYG/6hSrUdAnV5j
 K5MVishPRHo7zs9z3KPOVkDG18AvVYb5mZgu+Oyib5L97VoYnDVZRtPXregTkg6p46421puKcIh
 n9XKa6mT+3dKLCPG9oZXys0xn76qCUcFDH3Jr4/6Om8pJA==
X-Received: by 2002:a05:600c:444c:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-441b1f61dbcmr22097005e9.30.1746004314274; 
 Wed, 30 Apr 2025 02:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyudrAgz7jbK3g+B1ph3bPIKyPNcIaM1xAt/rCFdB9rs50SEURfyLB1FAUB39A1v5tlGcD/Q==
X-Received: by 2002:a05:600c:444c:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-441b1f61dbcmr22096705e9.30.1746004313914; 
 Wed, 30 Apr 2025 02:11:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca435dsm16356068f8f.21.2025.04.30.02.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 02:11:53 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: print the boot stage id in the report
Date: Wed, 30 Apr 2025 11:11:47 +0200
Message-ID: <20250430091147.321944-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

An output like the following is not helpful:

    Timer summary in microseconds (40 records):
           Mark    Elapsed  Stage
              0          0  reset
    ...
     56,448,158      4,845  fit_image_load
     56,448,186         28  fit_image_load
     56,448,187          1  fit_image_load
     56,451,971      3,784  fit_image_load
     56,483,951     31,980  fit_image_load
     56,483,956          5  fit_image_load
     56,483,984         28  fit_image_load
     56,484,001         17  fit_image_load
     56,484,008          7  fit_image_load

It provides no clue about what is happening in the fit_image_load stage.

Add the bootstage ID to the report. Now we get:

    Timer summary in microseconds (40 records):
           Mark    Elapsed    ID Stage
              0          0   171 reset
      3,181,017  3,181,017   178 board_init_f
      3,229,282     48,265   179 board_init_r
      4,184,866    955,584    64 eth_common_init
      4,280,304     95,438    65 eth_initialize
      4,284,509      4,205   186 main_loop
      4,390,704    106,195   180 usb_start
      5,694,146  1,303,442   187 cli_loop
     59,908,029 54,213,883   184 bootm_start
     59,908,031          2     1 boot_get_kernel
     59,912,875      4,844   100 fit_image_load
     59,912,903         28   101 fit_image_load
     59,912,904          1   102 fit_image_load
     59,916,688      3,784   110 fit_image_load
     59,948,668     31,980   105 fit_image_load
     59,948,673          5   106 fit_image_load
    ...

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/bootstage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/bootstage.c b/common/bootstage.c
index 4532100acea..0810c4e5271 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -254,7 +254,7 @@ static uint32_t print_time_record(struct bootstage_record *rec, uint32_t prev)
 		print_grouped_ull(rec->time_us, BOOTSTAGE_DIGITS);
 		print_grouped_ull(rec->time_us - prev, BOOTSTAGE_DIGITS);
 	}
-	printf("  %s\n", get_record_name(buf, sizeof(buf), rec));
+	printf("  %4u %s\n", rec->id, get_record_name(buf, sizeof(buf), rec));
 
 	return rec->time_us;
 }
@@ -333,7 +333,7 @@ void bootstage_report(void)
 
 	printf("Timer summary in microseconds (%d records):\n",
 	       data->rec_count);
-	printf("%11s%11s  %s\n", "Mark", "Elapsed", "Stage");
+	printf("%11s%11s  %4s %s\n", "Mark", "Elapsed", "ID", "Stage");
 
 	prev = print_time_record(rec, 0);
 
-- 
2.48.1

