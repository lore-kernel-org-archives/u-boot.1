Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C951FC56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BA946081C;
	Thu,  6 Aug 2026 16:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ildutuz0wxjM; Thu,  6 Aug 2026 16:53:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 535CB60815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786035207;
	bh=QucgFRtJ015It2+k6ao+ijBh0z3NXSzu7NcSKJcYgv0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s0tC28hQVf/L0M1h138vYuiHnCJnR4Xj4L2JE4NJPBsmak7auKkKwjfhg8pC0hCBG
	 imElzBCxOcL7KbnUBAo+zATxTE8ZkPsx0zJQej+gwcICWWU94pY85pZXPGLa6NWZfJ
	 MhoRVP7B4oIl0s/q7OfN5d6Udavfyn4HkCD+LuiyuuIawiVBTdhEPuzI8cO1rbU6xh
	 +IgHj+6mXl17RxM508gTgZihT9YPCZDX1UxsUhfouDBHTpEs6w9WJs96y673gSCb00
	 KOY9nDlw2OCeLOLGPz8yIrFPmB4wzbcJWz+htGc3UYEJbRrPSUVaBOCs/2jPHIXLMs
	 xRPKSibZCt6GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 535CB60815;
	Thu,  6 Aug 2026 16:53:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E726194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33D2960815
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3OnZvCeSws05 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:53:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2725360814
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2725360814
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2725360814
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:53:24 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6b01abe5d03so406828eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 09:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786035204; x=1786640004;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QucgFRtJ015It2+k6ao+ijBh0z3NXSzu7NcSKJcYgv0=;
 b=gQvj7GKHEiKkzF5Y2+7Ss3vyn/jZng2rrjBgalyctQ20A4GLxPqQqDZuFj28DEKKgB
 5AjlTwrEq/rnXcpG3Cm9vEYVcCFCTPyR/REYTj5mDbJZqXFJ8ywbBy/TIm2WUr1fKpFt
 vIE5LqYUDf3CZgQuoTKxJDMn/4xwnX34xRNv2RSYGUF5rwt+K0PisO/1ketXuq7+3qtV
 Hyc/MFcwqRmqyRSdRLPWxf/L8QwaYbYUMrABysRX4+GChIxv0tojr28f8mmsWnFrgRH2
 dDh0aJ+Gy2SH/4xVUAsCdBtNc8HebhET+dEsD/oYaXHAbwFvXQG51rraSxY6MUwifG9e
 FuTA==
X-Gm-Message-State: AOJu0YxzEl7o1mc+tJ9Jn7iRCnvuZpy6MnIgxFFtFDQWNpKUrEGyARBY
 tH0MNeC76tck7C++d8yQovyIuFThuhnolUuVlYZwyLCzN35lYUFeYfiJ7ebjxtB1by3yaAig4Di
 0GjW0v8U=
X-Gm-Gg: AR+sD134ueU59m6RMJXuwY9z/zT3OHtJZdLsHX0L6Jhs8P1mvxIbqQrbAwnT7luALGb
 nK77XeUtvLttETEn4zf+njCdoSDdgQoPgk6XRVUCHb5YUHoO+pcJHQwcAuK8KBhnHVQkWyu1pts
 HtKTJPlbf9wpsZpQOcfiAFjL7ucgFNycVcnMQvTIiqHj77LQ2LlPftigIPh2KtWPoGWLMV13Xaq
 W4JzprptAowIixHv7YPuqdMQ5gkGFS21HO8oxdTgT1jAS1WiqSfLv7wGK/7LoNhgj1tr6ikrQa+
 8IwLU3go6zxMBnmm6DMUUYtU9ICBVLHsnlBlW4Uli43fmvfUo5yJdnI6Jnfc1ipqlFWm6ysIxG3
 K8j6Vl1YvBK1E4HF/UX0snPlInM1tiWLqEDRMm8ft1HxHbV9MooKmMvWIyt0pwcXfNAWiVoLjBg
 FYHraTQfvbXqV+q4vXssNK7s3oexZrHTZ64HCEDKViuBMq08m4V6iE/38iRyAzEfX3p48F8yAzV
 iTd
X-Received: by 2002:a05:6820:1a05:b0:6ae:774d:45ab with SMTP id
 006d021491bc7-6ae96f87a73mr8793796eaf.27.1786035203795; 
 Thu, 06 Aug 2026 09:53:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:beb1:8dd1:72b8:350d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4599dd615ecsm6095446fac.0.2026.08.06.09.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:53:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 06 Aug 2026 11:53:15 -0500
Subject: [PATCH] Makefile: fix dtbs_check target
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260806-fix-dtbs-check-v1-1-2fe0b9486df5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqEMAyF4VeRrCdQK3h7lWEWNqYaBR0aFUF8d
 6suPzjnP0A5CCvUyQGBN1GZp4j0kwD1zdQxShsN1tjclCZHLzu2i1OknmnExmYFeVdULvUQT//
 AcfEEv7/XurqBabkrcJ4XdikvjXIAAAA=
X-Change-ID: 20260806-fix-dtbs-check-a237cfb79b1f
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=rqPkXRAn+z2aSzm3rCPBgRZynta8S8rHikTW2v/1/3w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdLv7w4+ePBU8FIX4pBi+O/lADPtNWmheH2XaI
 D/6gQtB/YaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanS7+xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A3kcH/08IHNoB+yiPZoBO2Ksl431aSafg3Yg1K/CLEFb
 zruPH7efOMJCSWAhkDg68rwkr9JIHw2L+tXSY1RxXiuIGzhRzTWGdK2/Afqj42+yVOal5InwTOM
 2oQW3HGQ3f/tQF1D2yqhsIWb8MGJDo1p0PX6xrwmHl4vW7rEyXNMkNYlCgsgT7pQHbaipg52ifh
 U973bdZm+TZGyun1CQXRdo2Q1lTW34MbmYBBn5CqUq1AtZh98x5pE1U4i2O7TRWz9aQ9Fal2n5M
 Ph6ivq3NEOKgAwaC61RalOTLbEJBSnMWDY/Tt7/TwIEIJYQ7Kr2I7YqWY/0IGbCvNiEItfjLUrW
 pLH8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786035204; x=1786640004;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QucgFRtJ015It2+k6ao+ijBh0z3NXSzu7NcSKJcYgv0=;
 b=VeXAcJp++cdNUEwJllwEJPci+1kij1cf1W8RSVpXcHyWAEhiXXYquVLgQKpmZtFG9j
 xXHXCaHexw8JxHW7bL36w8Q+s+Id0IIg6B29l89kaSFJSqkIS+wLm794zoSNpwWxR8ij
 r+4NhOD8UAQ6FinJw1pSO7Ee00yzc+ia1C+/+OCeoCrtDQmDTDolkguefDnQ33L40rZv
 No9j2vAlqiZokrru4fQqOUEjwIJ1+uxIf/F2c3Rn//8t6U6Rr47H6XWaSRdXiK3pQBdS
 HKMu2msumnoW/ggGQhHOozduyssYcaKPMZ1qZZkNeKoGG+IhB8ORTy24H50886DU0CWi
 BpDQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VeXAcJp+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Use absolute paths for src and srctree when calling dtbs_check via
sub-make command. This fixes dtbs checks not working.

Without this change, we see errors like:

    find: ‘dts/upstream/Bindings’: No such file or directory

This resulted in no schemas to be parsed and therefore no useful checks
were done.

Since we do not want to modify dts/upstream/Makefile, as it would be
written over when we pull upstream changes, we make the changes in the
U-Boot Makefile.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c5cc8276fa0..8e4009a18df 100644
--- a/Makefile
+++ b/Makefile
@@ -1455,7 +1455,9 @@ dtbs_check: dt_binding_check dtbs
 
 DT_BINDING_DIR := dts/upstream/Bindings
 dt_binding_check: scripts_dtc
-	$(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) $(DT_BINDING_DIR)/processed-schema.json
+	$(Q)$(MAKE) $(build)=$(DT_BINDING_DIR) srctree=$(abspath $(srctree)) \
+		src=$(abspath $(srctree))/$(DT_BINDING_DIR) \
+		$(DT_BINDING_DIR)/processed-schema.json
 
 quiet_cmd_copy = COPY    $@
       cmd_copy = cp $< $@

---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260806-fix-dtbs-check-a237cfb79b1f

Best regards,
--  
David Lechner <dlechner@baylibre.com>

