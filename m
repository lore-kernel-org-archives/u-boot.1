Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB804C624A5
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 15:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC53740565;
	Mon, 31 Aug 2026 15:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iq_K9ESGbGey; Mon, 31 Aug 2026 15:57:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788191867;
	bh=7KWzRefBChw0ZCtz1WdByAh4Hn3evYdIaNwIzP0rESI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CAItKn9Wg3CxDtu24MOEftJnh77mHZCLV13Rq+iKLrxZL/6VC85VEPqGMKg9U1MA3
	 a8ShmKiptqLCgw0Dh6vHo065LJHwq24tw37jYTdU+na8PtkswMikvXVOktEWVH0AwG
	 nlBkuKoz2pkIZWcXqvb9yNZzEtMgyXWE/29c0v45DVFZMZCspHRKIprTwnDsXsJbiO
	 5xHlR33FdHW9AlGoVbAXXuYD2P0aOefbeR5AJSQ0/3s6abMcdOmQwAwQ0NhutXYWgn
	 IVjStTLmnMmNk5ugnmhAV9EDXJI6Hy1cJ5gJRDfWXWggzeK/3cqGi7fcmqSUurxi0b
	 /Q8DacHKJz/Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B64A4055A;
	Mon, 31 Aug 2026 15:57:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 993B82AA
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FD0E40580
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LR7yiBSZPb9m for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 14:28:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=EYOAevYa
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66B6640573
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:34 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7DF233F620
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788186513;
 bh=7KWzRefBChw0ZCtz1WdByAh4Hn3evYdIaNwIzP0rESI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=EYOAevYaVfQtmq3IhgbGI8Sg05An+f11Cs51IX77IqdNO0J963kiXuohxkBTsvJoz
 kRK3fdfAWocG0sPCdE3+sGZuBZSiXQXCuLzbJWnFNfwfhyUIWvQ0BJQRCyGCP+6CXI
 ydkpiEZZEa7vYqnyhj56VyCACHxAB2S8igE9jQJvk8ibnA+9FHBgRNFfgUxOjPlYFj
 mafQuW5OrsBhGfvsJjKmv8eZJHb0/jB2GxjfOOkv/NqUR/u7EiVLLzk63DnUor6n0O
 xzfnoTT1RGNm/p2nNPepf7pSBnRRMkgd+1RoNF7lLMgoknrOKm4YcRIiKsw6w+EQyv
 DJYTZqbrby2eOjqkp6ZQJPy3+HFZ3RkSb3JDPW3jkUDrEXidpqWq98VlaJggozjmHB
 FlphRsnPXHlt1opeeWqKrydjQfaW9kK/htIBYb96s9SkJkj9e6++N0/Ofg3GBFKKnk
 auyHgLNPfzB7rB3vFAMpMswxISaKGLA4gM+2EXGg3apPOIC3bdkgkoEqgccBbl4etz
 ka+5mebMwFbTYLhOlS26rRZzihz2ofgfOh2VQ4/JmR8kRcu1gNk9dpocJR3GWu4676
 Ay434elnIHJH0AlHhtIiIdzcRYcUaAO+6zAcltyj3M6vxbLn1FXbjyb8F04vcDak3y
 7tHH2v1fdGVx3u2eEyoljfPY=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so34312105ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788186512; x=1788791312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7KWzRefBChw0ZCtz1WdByAh4Hn3evYdIaNwIzP0rESI=;
 b=QRvKm2e9+T+UVfTvVZG05oT8UdT8b9Xb30c5BLUODvKVvOvj9viyyZmCeNtJdnyuMx
 9wodtAQUPYJ4m3wc7PK8w8mDpIhseTnBcqB04J8NN71jQkgtE3dy6xx/nv2vGD5AYc8P
 y1OG2GaYeP6Cxi37vjsUJ4cRSRD1dC5H0HsTavGKp09e6vXzhWFUuFvPedubANi6a6NZ
 OpaDAia54PyPq2Aqe6ESmyp1U/MzMuS90L5ESOhXgFdI4/l7qEpMWPxoxcFDW58TXfIp
 yIfTa9EREaAZP642Gah3CXPz480s2izYH69BN+lVH0DamIY/O+Z/Rp5e657Li7JfEmVZ
 E0GQ==
X-Gm-Message-State: AFuF++ltWi0FUzl9OkP/Aqntu+pCycrMfFtuHmLSMeywGqdTgDbE5qWJ
 ZYJvwgRwfx65oIJBS6DcV9UYYofsPV8rnDycmPa28RBZBegRJF1D/uFOuB8TMka44PSNM58krXW
 at6XVYIxyzIEuIf0nnuA7CwA5oDp5Fa7UzPyqcN7UHpXAV2E17v0DRQoG3y6vYK+FQtMbXEHpMf
 v3OSzAMhHHBnsH/qLhqg==
X-Gm-Gg: AYBFou0n8xLXaeU4mDrhiBiOdRtdBH3ssRa+esR1Z8j06UY4ZMW+TNzC5+mZAm+CSL6
 JvjzkOZjvs4mTESAk0wnHyTFcYGeA1eOLATd9ps4aCih+Saftv9JbW4KEwoqL41BP5R+e29pxOg
 CE63yY4oKLjDBA2gsiKTJCFW2um8WntwPlHr79dSfKflokpZyryJCrWdjcgap/fGs7u7cweXPA9
 g8KP+jIRk0l6QsmjvLAOdk9NjeGQk1Vwy7q+GAajMyDWDOM+vwkbdvzBJ3Vdbd7r46h+8lLy2IF
 l0gdXaTfVFEAa5Eiz0pHDUInNluyMVolVpGBPqFLjTAJDYbK2k+QzYaGVQS3OFC6r8EsXbWvaTs
 Zpv3LZ3EooPAVGGhoZliSpf62gFYKfHpBUcGBhNJ7RnTwpEE=
X-Received: by 2002:a17:902:f54c:b0:2d8:d4d3:da50 with SMTP id
 d9443c01a7336-2d94a93b44cmr14786265ad.20.1788186511893; 
 Mon, 31 Aug 2026 07:28:31 -0700 (PDT)
X-Received: by 2002:a17:902:f54c:b0:2d8:d4d3:da50 with SMTP id
 d9443c01a7336-2d94a93b44cmr14785545ad.20.1788186511482; 
 Mon, 31 Aug 2026 07:28:31 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d8ffb0d341sm22798805ad.47.2026.08.31.07.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:28:30 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Denis Mukhin <dmukhin@ford.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH 2/2] test: boot: Check that rauc rejects over-long slot names
Date: Mon, 31 Aug 2026 14:25:40 +0000
Message-ID: <20260831142800.25966-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831142800.25966-1-aristo.chen@canonical.com>
References: <20260831142800.25966-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 15:57:41 +0000
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

Boot the RAUC bootflow after setting BOOT_ORDER to a 33-character slot
name, one more than fits the "BOOT_<slot>_LEFT" env-var name buffer. The
boot must now fail with -ENAMETOOLONG.

Before the previous commit the name overflowed the stack buffer; as no
such variable exists the boot then failed with -ENOENT, hiding the
overflow.

Also check the accepted side of the boundary: a 32-character name, the
longest that fits, must pass the length check and fail only with -ENOENT
because its BOOT_<slot>_LEFT variable does not exist.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/boot/bootflow.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index ef4638ec700..ef8090f3f4a 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1445,6 +1445,29 @@ static int bootflow_rauc(struct unit_test_state *uts)
 
 	ut_assert_console_end();
 
+	/*
+	 * Boot with a BOOT_ORDER slot name (33 chars) that is too long for the
+	 * "BOOT_<slot>_LEFT" env-var name buffer. It must be rejected rather
+	 * than overflow the stack.
+	 */
+	ut_assertok(run_command("bootflow select 0", 0));
+	ut_assert_console_end();
+	ut_assertok(env_set("BOOT_ORDER", "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA B"));
+	ut_asserteq(1, run_command("bootflow boot", 0));
+	ut_assert_nextline("** Booting bootflow 'mmc10.bootdev.whole' with rauc");
+	ut_assert_nextline("Boot failed (err=%d)", -ENAMETOOLONG);
+	ut_assert_console_end();
+
+	/*
+	 * A 32-char slot name is the longest that fits. It must pass the
+	 * length check and fail only because BOOT_<slot>_LEFT does not exist.
+	 */
+	ut_assertok(env_set("BOOT_ORDER", "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"));
+	ut_asserteq(1, run_command("bootflow boot", 0));
+	ut_assert_nextline("** Booting bootflow 'mmc10.bootdev.whole' with rauc");
+	ut_assert_nextline("Boot failed (err=%d)", -ENOENT);
+	ut_assert_console_end();
+
 	/*
 	 * Scan with a BOOT_ORDER naming a slot that has no configured
 	 * partitions. get_slot() must not crash on the NULL array terminator;
-- 
2.43.0

