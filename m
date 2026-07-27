Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464DFC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 10:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C42080DCC;
	Mon, 27 Jul 2026 10:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Qw3rT7aftEJ; Mon, 27 Jul 2026 10:09:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33A8A80D66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785146947;
	bh=OH1n70kzMz4UJg5Nlco49MXxe1oXmY1Dhm9Tf86YZ9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xK7uMtpcVQG4/mTDZEWvZyvbIPLTkcHkTPDx49ICzyxWGZlxC7j5XI2vLg/iCGCTv
	 Sue7dhi8LRvzm0lG2TJmBNMvEQPAs0uL3GeCWwJR23DbCMS1HNZqXyyIDXPG3QMqOj
	 aZyZ3xLU6ahIeODdAKmon8+K6UxOFjZ+qYK/hytI0LY+GprdTFEKiJtN3M2R/kmf1R
	 ep319tIB8OmCWGrOLXQjTD3OSD7GHHakV6hBVekok1ui+vcUtwRY7dLK6pN3TU8xGA
	 mPtaMCOAxXXtPb2QUvJGEK4/RZ4dFVM21juZjbUcK7qEopjgq4LzUg+J82qwGT0Qh2
	 ZXm8n6mokynew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33A8A80D66;
	Mon, 27 Jul 2026 10:09:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DF86357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1203680DC4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TaBP9_E2rzcL for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 10:09:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9E71380D64
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E71380D64
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E71380D64
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:09:03 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso16941065e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 03:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146941; x=1785751741;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OH1n70kzMz4UJg5Nlco49MXxe1oXmY1Dhm9Tf86YZ9Q=;
 b=WRdJlquI2INh7QJ2/6x31oz4t0VEr613zG2a0IkKVb99ieHK+0GIf2jbZmu8jvB5n0
 /pM/W46imTsB7cbEhGZGXgKJEMOkYhi+7l+gFDf5jtHzjukIJNVeKJMeLTl1vyEnV0k6
 5ctG6Hk0McrRbk81DuAtPmc/FdE//aDxeTP3H0Kyt1zVwqjgRNC0pDZTeVKTsG/pKFuW
 ojP/y5ZeL6IW/nli/AtBtzTvyNnhvf0ZUrTb8MYmMBZ94IhW2D8aZ4xi3V/eRaOyjbuD
 PfuSAS9SlZEjozr3SEjETRZMdxxDH59b2tkeT4URejGCHX9anYD4794cieQ8QM2dUM1E
 knqg==
X-Gm-Message-State: AOJu0Yy+7ggVAdPR0Sy90lMQHEJt5mOsEHMbWbIGvLfJ+p0sYRZqizdN
 Q2A9zj/z5RM3gLR/4CYC4FOAmEmL3R7mLYEi3crCNFNXljczSs184eTB
X-Gm-Gg: AR+sD11AvZxDoxZt/3oS5ogp8c9f+TCftVd2uD1rlF1ce2W6Neoe+hX/eb2xZVNGmuU
 FtF7b96iQt0QsdiKAReOswQPciQq8Y9UtlrgFcXaZfs1aKDWY/RP1FhNzk6XFiZcLP5hJTyvXH7
 GGB+bU77A5iOCg5Mv1EX/Q/q0x+vSz+q9k71g32gGWbrqvM6e4m6rJxG8W4Rt3Iz08QGNdbWp1V
 zPQk432baiCTreKxavB6PtJYIHex85j5sSVruNemen0NrzoVh26rhtf0qA4hl8YU6Uy61BiXb4n
 8QuAxqCY5k3SolgTSzMkIto4XLPQ/2jc/c3tZ1BxEZfaemXkfAlNo3W/9B9H6nmY6UniXdIQIjs
 fofkkoFP4PijOoPsa9y9SZgUXo5r22HmobqiM+5DKw3EYYqVv1fa1T5ObsAIYL20jY8s6lOsxv1
 adX42lC9xQN4DIjymBSGTMu7ayDQY0DU8CLZUDd0tv7r2M+SkH7+zfVTLlvUTz58HnJnej4Q==
X-Received: by 2002:a05:600c:190c:b0:495:495b:9248 with SMTP id
 5b1f17b1804b1-496b79068acmr90467295e9.4.1785146941471; 
 Mon, 27 Jul 2026 03:09:01 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f5665f0sm256805375e9.0.2026.07.27.03.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 03:09:00 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 27 Jul 2026 12:08:54 +0200
Subject: [PATCH v2 2/2] doc: android: refresh AVB provenance and pin libavb
 reference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-avb-libavb-1-3-v2-2-fcad1a79af24@gmail.com>
References: <20260727-avb-libavb-1-3-v2-0-fcad1a79af24@gmail.com>
In-Reply-To: <20260727-avb-libavb-1-3-v2-0-fcad1a79af24@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785146941; x=1785751741;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OH1n70kzMz4UJg5Nlco49MXxe1oXmY1Dhm9Tf86YZ9Q=;
 b=CAIgp+wFakC2M0DMrtcx7UGa9UE1PKUU5UIj3p6xe23C0kwG4BxH5Aol3sBINnCdGp
 nbusHQka/QjvrlxqiEA9oEN3ha6vjJhVk48PRfP/qdurlLhMCzbrsy3MKfr1EqHEKVjk
 2nN23xh3eBYyxilULeY7W52EvNuuj2UKbBL5bWid5jgbsrSnEkukMmQ1JBv6lzNU0lzt
 V4iwlHXrzxMHi1RNwNeFmepWn3l3/gZtCVfpEEmIwQcSt+rSPQepqgJly9YMJRjqSpUD
 55tQeGG1pO5kx7R4sOeIWPgeuN0Cn8wtBq/6WRM1zl84pm6fU83pVvRSlhVF7wbjkqX8
 An+A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CAIgp+wF
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

Note that verification is performed by the libavb copy vendored under
lib/libavb/ (AVB version 1.3.0) and which parts are U-Boot-specific, and
pin the README reference to the exact upstream commit the vendored copy
corresponds to instead of a moving master branch.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 doc/android/avb2.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index 4aca7a5c660..178e8a2681e 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -22,6 +22,11 @@ Verified Boot establishes a chain of trust from the bootloader to system images:
 
 Integrity of the bootloader (U-Boot BLOB and environment) is out of scope.
 
+Verification is performed by libavb, which is vendored under ``lib/libavb/``
+from the AOSP ``external/avb`` project (AVB version 1.3.0). Only the U-Boot
+integration in ``common/avb_verify.c`` and the platform port under
+``lib/libavb/avb_sysdeps*`` are U-Boot-specific.
+
 For additional details check [1]_.
 
 AVB using OP-TEE (optional)
@@ -135,5 +140,5 @@ partition table::
 References
 ----------
 
-.. [1] https://android.googlesource.com/platform/external/avb/+/master/README.md
+.. [1] https://android.googlesource.com/platform/external/avb/+/a1fe228b86543a21739c51352f5ce72f134fccfa/README.md
 .. [2] https://www.op-tee.org/

-- 
2.53.0

