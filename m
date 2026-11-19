Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C185606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hKeHudtG;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jui/d7Kl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA91660D84;
	Thu, 19 Nov 2026 13:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id udgvE7BhzTYb; Thu, 19 Nov 2026 13:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 173DE60D86
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095215;
	b=lUFyRMcnyBZkvk6Tr8PxIgYvnBqTBUpjNfQ9r9snHSL3tWHOoAixAUcjWWsgvoVwN4EV
	 X48ftXVHGQcbqcl517mEvItZ1ljh0WhdXzxbLOdeoNjxb237NYAgu0p+P9Fy8wu8UqGcZ
	 nkiCZNBhcA3bvi/FVGkk3Jfg2T9BkbThC+IkjnMCPL8rSL/BC0T9pjivijTec2hlX+m4m
	 38uohHuLRrF0NWTbV+tXphPYBC/07dv9nIkZfa6E1ydTGAwqX45IB69dF4B5p9cLkD0qM
	 nRPEBzd9lrpjydZxGMpq/4G+lPSaiZRnx0Zl33yUVsRN8EQY6FGTg7R86PgA67DbURA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wi1zQs2V4J8GOZ9gU2kLjkWy8L+bnzJnb4AHrp8rQXI=;
	b=dFjxyPlVVgvqmZhhKkLghFA/cb3tFgkiL085GnjM/ir2YQy7ITqaK5hIhf3NQQmSUnox
	 TtB/eDdcd3IluTpbwLu+RPPDYhlP6S6zrSawLVJdOeab252tg3EG81Emm3Mr10nf5UsvY
	 sGEG59vEkHo5C/nc7P9HVXcKv7K3Q194CoqvYLJTxwjYUJu5UqwKzMmRRfQog+5PQRQ+6
	 +1ACpofaHpFvUkiRiS2W0HIOK2LKbs7fgOzuH9cx6OWZjTnGETPKzle8iadXRw/+/YqDt
	 cOWhFFGLdyP5CImk5mVQcHYZYHdIXZU74E/N8PKGJoXtDrGjWoyirR64BYPKqUe5o/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095215;
	bh=wi1zQs2V4J8GOZ9gU2kLjkWy8L+bnzJnb4AHrp8rQXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hKeHudtGCPBnTkC+lGDaYVj4AcqKwOGOzdwlEsmsOgjKzk0JvPKDZzYXDxQhjLDJW
	 gAz6De06m7wMVqBepvylkQJZbNx+BPtQXxDBoFMMRQilIVk1RsLVeJUki1b70v29yI
	 RsMrboCK+d9XejXf1GxgZnpbyr/cyWT6O0KOIOLWUbpRG8N9CxLmQI9vHnoLQ4X5pn
	 qwtfg4wR9pp1y7DPSpV6AFJ9vFdSJIIIAcll9HsqByP1dX7/EAR1NgQFfPYsen836d
	 JLtFNmKR7mjYS2IUiL8sN76ufAjqq+tB5bV4EwuPlxdfSET5E0Ghi2Mic0K2dhbamt
	 tbFpsDiItNxMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 173DE60D86;
	Thu, 19 Nov 2026 13:33:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B7AAFE4D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6EDD40527
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y_mtgD-dovV1 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A7E214052F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Jui/d7Kl
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7E214052F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:23 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so12476225e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095202; x=1795700002;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wi1zQs2V4J8GOZ9gU2kLjkWy8L+bnzJnb4AHrp8rQXI=;
 b=Jui/d7KlzGrv1IeoJB6RQt76/qh60uzNlH2iOylVtndqEpKhAu0tJeNiP1qCQkF+I3
 +CeViZLhOaEmkOc1MLR3S7a76QTx4MLcam9Vl6vBZgTGwDuGOtm8mgwbTufRPajek5oy
 D1ryBvWlj0L1apM7a9c+VtlMy3ubadoQr7IozQHucQGYi/jTJFa3LU4OdReZzPbxS/uz
 nLXH3dJEJpRFvaXVpFs1m4LVsKqlatjYGXRbjlP4WL8E4/ZTJtPT0GXbfYbdzZvsLCWh
 AYCksZB5jWkrPk86Ra9NrZtU/qyBF2bqfF2dxWvdz0LEp7I6I3e2gAHRt8+cUVog0Nzr
 5uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095202; x=1795700002;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wi1zQs2V4J8GOZ9gU2kLjkWy8L+bnzJnb4AHrp8rQXI=;
 b=fZO/pIexdw0pEl2oRyh57CZXtnkEPgLXe7dE0OcLnsn+EYjWoDtwiFyC0cLKWc5wcs
 o77FD6tg/pU+KlU3Wgpt8ZBqKA3Z0lOvwfJsTtmSDRz35hEtD5cpEmyl0PC+d04y6Tu4
 H8yEeqXBBZXIZ3jHtP6C77Mp3geSxColptiEzDTA/xN3YkrO8KP4xRDTvwVoc+5ppWkM
 PXxMeyppxNwVlukVFVuILtRRQa3+XEy+2mWcrqv8g6KIeMv8eUZuSrSS5GlfPSCsD8nX
 4OYxWSAZ3qwWfGLwvnVnXGhsbHxsKxyx4F9e8TfRA3IHGyHIJvQH0ZJZ92tt+W53L8Of
 UujA==
X-Gm-Message-State: APuU4Z85hFAZPDih6kSytUsb9/DA2myDgEFD7416M5KjAu0CqryYC41x
 e68+xcsvPt9ASU8DdIIbrLNiZf7bwnnIVIDcLeU7ByJF2lLHX+LmRrGNUI8N+D4x
X-Gm-Gg: AYBFou38s9z3RYnMVnS12+OqSnuVUwsLoCsPCoqpCdaKnci6KHbLVF6jjXnGXF886r+
 /IFejBxinjxnVq2w2Hcn/lRbnwpkPVJ+m05NsZ6BihTY1jBreLmGEoTx0PbtiM7SVK9i6QA9JlV
 ErNJ5iWD190+ENV7HFFgDSrCYPWxnJkKL1nOzHx40e1aASe5uaynq6Ncu2a2IA60JZfyjt2DO4n
 r7bAZWvpCnMWegz/JFJttlO6Nil9FVZUwZ48ufydfHT3IU5a6CxpA+QAA2RaEbTW5V2O6uJjLJG
 ZNz+tpbA77uutMgJJ5fAot/C62ca3hHSjEq8eDifVeE5btojVBQckTmjgvZh5c652i+urK8BJ8J
 0HWMBRKjS5n+jvQKMvKE6YZDXcgzXO0REo9zfZ0gnI8qVIHSm5swCSUHvaQqQyfLYomlTc7m5VI
 0FAKyxovQOA3mHfS0kZ02VFrfy196H+MhHAX90cFQ+NSfcYwygyvvbcczs4RRyQzC1SxTp5Jtgd
 zExfsBX3BseNU3idPAWRNEYZcHvIcX9oweAGSeCgQH0gATHwXYzf4dv7fNp4yfU30FITNYRIq1N
 w2n13Wpxyk+XwYtaK1ttkfR1SuKT909q3tsxC7u1nsGuiueckdSooz3GQoWwOeqx4WxQGLIdkr8
 XA44WIDnqkb8+eB8rjLzbQJIs3E1Pjj35SR1YEj1dtvXyajF9pMn0K5aSw1VPh128virIO3YQQG
 Xq7L6emcDZDHGl/sxL3ZzGSNjAGQs8KK0HVj2/FJZHirsHoMPzdBgE
X-Received: by 2002:a05:600c:6dc9:b0:4b9:f90b:1c4d with SMTP id
 5b1f17b1804b1-4bb8613950amr20360305e9.5.1795095201970; 
 Thu, 19 Nov 2026 05:33:21 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:21 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 07/14] powerpc: Drop -ffunction-sections and
 -fdata-sections with LTO
Date: Thu, 19 Nov 2026 14:33:03 +0100
Message-ID: <20261119133310.22732-8-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When LTO is enabled, omit -ffunction-sections and -fdata-sections, as
32-bit ARM does. This affects U-Boot proper only, as
scripts/Makefile.xpl adds both flags for xPL builds anyway.

Keep --gc-sections, as ARM does. It drops the .eh_frame sections, which
the linker scripts do not place.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Behún <kabel@kernel.org>
---
Changes in v3:
- compare with 32-bit ARM, as ARM64 keeps both flags with LTO
- drop the sentence and the note on "Makefile: Set LTO_ENABLE before
  including config.mk", which is in next now

Changes in v2:
- new patch

With Debian's GCC 14.2, U-Boot proper of the 71 mpc85xx LTO builds
changes by -2211 to +5628 bytes of text and data, and 70 of them
shrink. SPL/TPL sizes and builds without LTO are unchanged.
---
 arch/powerpc/config.mk | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
index 32e86d84a12..557d9360e3b 100644
--- a/arch/powerpc/config.mk
+++ b/arch/powerpc/config.mk
@@ -3,10 +3,14 @@
 # (C) Copyright 2000-2010
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+# Keep --gc-sections with LTO: it drops the .eh_frame sections, which the
+# linker scripts do not place.
 LDFLAGS_FINAL += --gc-sections
 LDFLAGS_FINAL += --bss-plt
-PLATFORM_RELFLAGS += -fpic -mrelocatable -ffunction-sections \
--fdata-sections -mcall-linux
+PLATFORM_RELFLAGS += -fpic -mrelocatable -mcall-linux
+ifneq ($(LTO_ENABLE),y)
+PLATFORM_RELFLAGS += -ffunction-sections -fdata-sections
+endif
 
 PF_CPPFLAGS_POWERPC	:= $(call cc-option,-fno-ira-hoist-pressure,) $(call cc-option,-Xassembler --fatal-warnings,)
 PLATFORM_CPPFLAGS += -D__powerpc__ -ffixed-r2 -m32 $(PF_CPPFLAGS_POWERPC)
-- 
2.54.0 (Apple Git-157)

