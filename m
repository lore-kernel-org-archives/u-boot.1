Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACCC606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lP8mXDmR;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8njTWMP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0280160890;
	Tue, 17 Nov 2026 17:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydFR9bkS-PnX; Tue, 17 Nov 2026 17:27:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3FAF36079A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794936479;
	b=K87PPhRUt7umyknJxyM2aGQBNg2FaIpIXEf6J+Lfs6i8glNpzanwmp6HvGTwngNcSV53
	 yfY47yViVKHzeOF65vTkyaDTQIpmiySQ5hERN57QV4brhqns6yDlTAoN2agVYr/T61UNa
	 CDuk02VdMipN7DMFblzRnHDvRuPE51Pi8SUrYTdsGWxKkhA7mEKmtSqIolIMN4MXM3kfc
	 c2+d+OyZakghuTArHR6ceC0FYqJDw/1cRn4PsxA3ofOraARNvG/f6el1JBZJ2cVlsV9+C
	 aTQSbjzrnnLsiDfIGPkvEYsmkNMGsS8fjNydW2bPuMnShbflN1bVPXrUIAVAdjnuTNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794936479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bt0QJctYkBcYwa24DqdpH0M8z820AsJXwWwI9jJk3mQ=;
	b=Aq/VnMuGNf5IKz2FZ2nvVFwSRRVDLOPx2VycUA/pVLvukVgqlaJm7tDgdNBobchbxrN4
	 IicevVNOuYo0L1MgjdY/qNMaWoceSr34io73jJMpdXQWN4uMXX3rTIqUuRhTwH/ezP3nS
	 aGyTsePVHNvChzYTOszBwRzid6jg9MqkxKA3NifmiAhhx0ooUjrNB4R9rTGk5C6LWCiSL
	 TnCSUrSRq76H2JxDNTf7IFl9xYewVcklMCvzidUaSu9ebDZ4fasLCRvC+Sl2WZQeULmX4
	 TsoMu5ICULTrmLtLU8t4kiceCSL5QwkUrD5Z+fYYn31K62GsBjgmCBr55yNbBqNxIlw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794936479;
	bh=bt0QJctYkBcYwa24DqdpH0M8z820AsJXwWwI9jJk3mQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lP8mXDmRu5x+xkjTXK6YJB0lfzozHbjUmRq1nqhhVcs+ydqiCdAvl+tnJ49NaSHkn
	 WVmKvT3h24gD9zW45FIXolYriZfLmccty9dRaWMDMtWv+Iq3qAFbW9qU6DQvwkjxiq
	 cxMtvRsgmLSHpJwAu0QUyc8/PVIGy94KPnNonokW6iMhv6/sMfwK2vYNgcGc4Fs8lW
	 ThaYn27pRpDLHTOtgb5iTV3fZhmQKacQHf/vXMiUUN3n6ZG9ZFnNcNsenmNh1lIq6U
	 VNx8bVmDiVgtUq9Lchzgq8lYyfmEDMfpOiChQm3OSMRuRERKNbVLitGYV/Y8fC0zO+
	 OHmfiqJ5nk4KQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FAF36079A;
	Tue, 17 Nov 2026 17:27:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA9B41A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0242407E5
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:27:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uX0fveGmcZWk for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 17:27:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9BF56405F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=p8njTWMP
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BF56405F4
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:27:56 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so1025905e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794936474; x=1795541274;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bt0QJctYkBcYwa24DqdpH0M8z820AsJXwWwI9jJk3mQ=;
 b=p8njTWMPnKFLiIBEZlgx8Eqd6O8HzvTif9O/7rNguUNn2JyCunIgY3tW7Kf+0cfcRT
 ifezdLdx06EBIrs19Q9O4dOPJUscyTjSHE6BQ4hRaB9OyshUs3Hb16g5FrdaDMLLPykb
 0buV7Ypks1fyFJhCQeeHjn509RVHJqjTk4uJm0QrMAWriDHrUiFgXloFR0sDBNZgrJTS
 6Wh0kFNzYuf82PtwkcXR7NJ4n4z37FcMtD/hafpkxnbwIDgjFAlO4XEHubd4vh3apyjq
 rMis0U3K6oSzpipS3GgoCnJqAGPKOCcjzZgWwecMYdMKq6O4RxfFum70eViG4mrCQSZF
 cqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794936474; x=1795541274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bt0QJctYkBcYwa24DqdpH0M8z820AsJXwWwI9jJk3mQ=;
 b=oKStxCVzF2u2t43Cbf4qNXrcIEd7JbeXAiwXKtxPfhMYYS5kgjZOfdVCy6J9p97q7/
 phyk1lXtMHHj1xZJu93oVcNfWNVMoeE8i5dVxq7idkzKrcLoCLiNeZyEGICBFPfJlHCX
 LlH/m4IWfZbb3c/su4fXsKgj25mH/upKnKoeJSOUNUCwBVP3w/VhMd7hJEwcMJBJbYX1
 aPpGz18Pc7PHS/uRWnqCst221QoaT0TWe62ffllw7DpwEwYKnjUE16TRiEW4uf8ELoae
 eDVo4vRV9GVwKoHRrd7hV69UFyvbMgWDcEDIwTIYuaxu+ZtAksX1vg2q4CjWEue1VLbJ
 tt1w==
X-Forwarded-Encrypted: i=1;
 AL+hErEMfMdomZ5KWdgyyKfPcrbW5gaMmCZ3OqIdn+fv5DBh0TjipdVZ/QCGXA997Xe/TG/c878gNxk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+vHvD0WaFj29nS4J7FjjJI10husn5mDNuacJZ6wDe/xdvcjF7k
 g8LU/kx1ykK6A+g0pllwZMjstdkSXujgL4jntvynYQxWwDe8Gssq7gz/
X-Gm-Gg: AYBFou1mcxbfAG6FqLrwFTt2EhmYsD3sb0A7ye0XGAndhkiWurUkzZSqE0AWER8+r1h
 sME3bXYEVo1sDm6FYWdfcvjJZuiMNsLnTDyul+1KcvxpqYK7KTJamDCWKDjN21MVujxgdq8Ljxs
 8LyS3MJedRN3s0uXDrX7xddu8tPnQonLjUPr8zbYR4z/sl1GyknCYgFDEEz3YgN5wKmgOWw9Jtm
 EpPV6gh3a7GEzFzGeyYa6FDHN6WyPvVqeFKmnZVg/aY1NOFsTMAGhTYaWwy54EiqzaCtnYKFsvr
 Mx73DGlIoBh0ioZekxG27QuiCBwk7IEQyI3NzRjQeBfn+vuo1XnfHNmcVnfzLHnOSpcZUOPFPNS
 739AGyHxI806aWYpgEtBOFTTX9k7cV8AH3wI/Lig58KyZcLR1hjCa3i9004ovluQqntHG2uijL1
 kbLB1/xXowD2lCbxDApUBHxhVvcXWa1pJx4SQpfQpIsygf+3N3UsXB8q7EVt/eLSttlsc/GObby
 hBPruDi4/YPLI4g1JW578Yv17WTkHOR0/C3HISuAbN53C6PnOiyoI38uREJCI/dqxl3nsswWAG3
 vw9c83FeP5XfDAvBsys7QtJAZxblv6/6vj4rgONj7EnFYDKC009guGt4YHtizXSSt2HXchviQHm
 Z/6kRAQyRDYVYOftWP7/6E+JxKnHDu2uWJ/YS7sb5XnhXskTX5MCPUNXSBmNeGMQWpCXj5b8wsd
 Rhpkp2o5AnkEpS
X-Received: by 2002:a05:600c:6208:b0:4a7:6bc7:f778 with SMTP id
 5b1f17b1804b1-4bb55a93a9amr284600585e9.30.1794936473950; 
 Tue, 17 Nov 2026 09:27:53 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4a38b9b986esm5671635f8f.59.2026.11.17.09.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:27:53 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2] disable VBE by default
Date: Tue, 17 Nov 2026 17:27:42 +0000
Message-ID: <20261117172749.2114252-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VBE protocol needs explicit device support and as
such isn't particularly useful by itself without that,
it also adds size and the potential of an attack vector
so devices that wish to use this protocol should
explicitly opt in to it like all other large features
in U-Boot.

This also cleans up some other missing dependencies
around VBE/VPL.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2:
- Leave enabled for SANDBOX
- Add some other missing VBE/VPL dependencies

 boot/Kconfig | 10 +++++-----
 lib/Kconfig  |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..44f5e7994db 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -519,7 +519,7 @@ config SPL_BOOTSTD
 config VPL_BOOTSTD
 	bool "Standard boot support in VPL"
 	depends on VPL && VPL_DM && VPL_OF_CONTROL && VPL_BLK
-	default y
+	default y if VPL
 	help
 	  This enables standard boot in SPL. This is needed so that VBE
 	  (Verified Boot for Embedded) can be used, since it depends on standard
@@ -720,7 +720,7 @@ config BOOTMETH_QFW
 config BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded"
 	depends on FIT
-	default y
+	default y if SANDBOX
 	select BOOTMETH_GLOBAL
 	select EVENT
 	help
@@ -749,7 +749,7 @@ config VPL_BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded (VPL)"
 	depends on VPL && FIT
 	select EVENT
-	default y
+	default y if SANDBOX
 	help
 	  Enables support for VBE boot. This is a standard boot method which
 	  supports selection of various firmware components, selection of an OS to
@@ -757,8 +757,8 @@ config VPL_BOOTMETH_VBE
 
 config TPL_BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded (TPL)"
-	depends on TPL
-	default y
+	depends on TPL && VBE
+	default y if SANDBOX
 	help
 	  Enables support for VBE boot. This is a standard boot method which
 	  supports selection of various firmware components, seleciton of an OS to
diff --git a/lib/Kconfig b/lib/Kconfig
index a05baa8af00..e86548985d8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1054,6 +1054,7 @@ config TPL_LZMA
 
 config VPL_LZMA
 	bool "Enable LZMA decompression support for VPL build"
+	depends on VPL
 	default y if LZMA
 	help
 	  This enables support for LZMA compression algorithm for VPL boot.
-- 
2.56.1

