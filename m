Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F246BCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 16:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D932846A4;
	Mon, 15 Jun 2026 18:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KoiIQIez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A69846B0; Mon, 15 Jun 2026 18:07:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F45884105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 18:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1E6B3F282
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781539645;
 bh=SJSW2vGwMqXUXRr9ZBRNxKB5oKoUV3o4HWaRa//FzVM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=KoiIQIezhpjfiYIvveWd1u9+aBmXcBGK6RtsJyGrTpugZKLIvG3mCkpaP6alqz15k
 +evqEXt9k9ddH2Yo4yUzTYAWDFshxCRUL5fMklIvWKblpGuSEz4kG3EEHxA0FQElJz
 jx1aNuC7bkKNU1jdPLiefakgptGY2bIiofjo/tGwg5ZRImA/dhy5Ua6eTLC59KONOY
 FGnmWYOGEZf+lR2tZvGbREfJEYIlJJp12CNxw0y5p8HTAuuKWSDmIXZu3l8LJ9dti3
 mF6617KiNqRINPlD19PhaiEEtB2HH2gxU36v8//iRwR37Q969QbPp7HZ4FIcfHG2LE
 QWBXgKB13l5V5fmtltxV2zAgYxIWiCFy3aJWpvREfJ2NKHW4t+EprOu6qsuj56f2sb
 hWh6creMadZDMB0xCsQIY6Q0G5HkNjjiPzWIc6lQHRm1pVuxnbfuy4OfGtcWX3ABWg
 5rZE8DdKspmHdiukrheINVyw4GluwtLBjC4yYTrmVuKdRr06eS7rARPTxoVj59Z9U3
 VByNTuyjU2Gqody9jEdGX+ozag1xvvEqb3ewZkOCjNHczW8r0OIPqdmihDd6HPknEk
 G1jy+Jl2wiUKZiWjJkdH8mu0LbE9ipAZROPtUFGqnjvqODw2kl1g0pCOIQgjEJKi/a
 48glylUkQTI59VEKTj16CEH8=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b9cd54f3so20472345e9.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781539645; x=1782144445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJSW2vGwMqXUXRr9ZBRNxKB5oKoUV3o4HWaRa//FzVM=;
 b=k380pkbOdp0Bt5gg5WlWvq2YjYSh5n8SvJ3v9xFD6QEaUsoGizSLjh1EBE3kJVD1bG
 88YlWB8VrACxQs2NJXuZ/29eDlh7zfr9n5rbe2SGuwHIxFZ7FHgo05WRG8kTl+zEMPZ2
 DznUbc98SbLd+C0rZzlM2opKz163CTggszpZ24WGp0GEVAzwPiOC2Ma8G2gZJAJyyvwx
 EBZG9okVww+87xu7g2TWu4d9+3SfsC8TwCTqb1SUxZC2vKjFyWijMy7278iba2rt7mga
 /UeWxFavYOrp/IonNqjszrU+IYDOtIuwe88mldBJPmi6aOeX2UYOgl2ec6Z5/PVBsebg
 S5bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Zj1inTqij3EWi4TqZ/fAURLKk1oA8MA7fknLiBG86I83H1J53456zo5NyXQuynd9h8XgSFPA=@lists.denx.de
X-Gm-Message-State: AOJu0YwJVazQYDgxPBjAgIHErgm9YwTa0M2YOt8b18WCL+wxu7A+uVtx
 Rha0rq2oJFoAocsdY0//9WL//GpUwlcGxpc+mwzl6La9vDmPlugvtWkEvzpzjEbnH3gUYncfBBc
 Vv8Sq7KR+1kSNBSfJLiSPNd46NJqpHdbOfXKGofQ5NnFQy9pXylzLSuC2j2QpzDK22iwxBfQ=
X-Gm-Gg: Acq92OHtLwlC7U/f9jlHzupkTqRHOuPLyEKQHN1Ssz95jmQoM7gEtfZz01obA+5OwAo
 +DD1nJk8Mhgg68sPOh5wvBph3/Vbp2H/G01RCyAXOn30uEyJ3+lJnyWsnak8WfgS6e+33M0QjvQ
 WbCGS+ZYI3r8orKoeP9Kd33nidfcUwKF4Mcy5VGMKTy+67mVYXrHfSjUQRi2nk+DgM7EpJdii+L
 tER9gBUPKpyRzFb80/xHTb7p+48SFlG4+/wJlnxu2ba2MOudGiS9+o9Ah4PXuvdpJRusLUzRBGZ
 aORvSCFjHxmSmTT+1sidk0wLS0Cg+kXSwJ45ntqR+z+r4imqFwJKz+Sosap1P8CBBC78Ty6tBe7
 uji72VTcRmasLbtjCdpnnn2i5gF+KPw3/tyjMUAr6ROG5khHAlkaflPSizQs+OBHVSoWYDeI+yD
 gSusQpNpVVX5baActdCzW7A8uLO4jnjZvG3Mh5JOgMwBzqva7pmcqQ
X-Received: by 2002:a05:600c:6298:b0:492:348:ba08 with SMTP id
 5b1f17b1804b1-4922007d38amr157423845e9.16.1781539645195; 
 Mon, 15 Jun 2026 09:07:25 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:492:348:ba08 with SMTP id
 5b1f17b1804b1-4922007d38amr157423035e9.16.1781539644600; 
 Mon, 15 Jun 2026 09:07:24 -0700 (PDT)
Received: from workstation5
 (dynamic-046-114-107-002.46.114.pool.telefonica.de. [46.114.107.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa50e97sm3202215e9.8.2026.06.15.09.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 09:07:24 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tobias Olausson <tobias@eub.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 1/1] tools: fix building with OpenSSL 4.0
Date: Mon, 15 Jun 2026 18:07:18 +0200
Message-ID: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Building with OpenSSL 4.0 fails:

    In file included from tools/generated/lib/rsa/rsa-sign.c:1:
    ./tools/../lib/rsa/rsa-sign.c: In function ‘rsa_engine_get_pub_key’:
    ./tools/../lib/rsa/rsa-sign.c:115:9: warning:
    ‘ENGINE_get_id’ is deprecated: ENGINE_get_id API symbol is removed.
    Define OPENSSL_ENGINE_STUBS to mask linker errors.
    [-Wdeprecated-declarations]
      115 |         engine_id = ENGINE_get_id(engine);
          |         ^~~~~~~~~

    rsa-sign.c: undefined reference to `ENGINE_load_builtin_engines'
    rsa-sign.c: undefined reference to `ENGINE_by_id'
    rsa-sign.c: undefined reference to `ENGINE_init'
    rsa-sign.c: undefined reference to `ENGINE_set_default_RSA'
    rsa-sign.c: undefined reference to `ENGINE_ctrl_cmd_string'
    rsa-sign.c: undefined reference to `ENGINE_free'
    rsa-sign.c: undefined reference to `ENGINE_finish

Add -DOPENSSL_ENGINE_STUBS -Wno-deprecated-declarations to the
rsa-sign.c build flags.

Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1138297
Reported-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index 1a5f425ecda..ee6c734d321 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -90,6 +90,9 @@ RSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/rsa/, \
 HOSTCFLAGS_generated/lib/rsa/rsa-sign.o += \
 	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")
 
+HOSTCFLAGS_generated/lib/rsa/rsa-sign.o += \
+	-DOPENSSL_ENGINE_STUBS -Wno-deprecated-declarations
+
 ECDSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/ecdsa/, ecdsa-libcrypto.o)
 HOSTCFLAGS_generated/lib/ecdsa/ecdsa-libcrypto.o += \
 	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")
-- 
2.53.0

