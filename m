Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C285606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D4xZfzEP;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GUaW19UZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D60B78107D;
	Thu, 22 Oct 2026 19:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HHDtG3gUqpjx; Thu, 22 Oct 2026 19:02:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B2F7811E5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695752;
	b=qvf/i8CcTaUTkeLastzWlF80HOMqWPZC0Qknk9pjuFq+pSgHgY9kSnRlIHVICeplPQGw
	 B74aiXOOdw3XfFUL2A63q5u6RufyFt+HZ81RsdxN8M1Syheb4LBRcU6eTXZ3oji3Axp+g
	 f/tjdhasYZiVFDQoSDbQdKDFbJxJS66XikLWef2wNNLpN9P268TK9CwrG/mt9OL71+WV/
	 wmir2YQoXfNXyHYXC2Xcg7W2MePI3aiLuokAb7K3r8jbvfELGsJQtw0m6Klv9FqiYWhM2
	 mWGg2RkInuJw7HLvQwyA1z/ZgpxCz49hJhWice2HZhxkEjixXSy4inWO4KquClq5inQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=J6vizOWujNAyr0n1UdvIOR/BZzTSd1dxWRt2w8og9Lw=;
	b=aZU+SKPjGdvKtrGy39kkGu8cost3UcNtq+SUe1F/LIBMn6r6/QpgEl+uGRhnoXWUNGhx
	 jrUsnAnx9ps1fP86Ri9rckpeIxIRDDhg8qUbxI6NjlKcqlJle3yPcCKrUGhQxqRoT4Khi
	 b3P0/LHYQBaqfWQR5hhZES7QEkO78cw67uYRKsE1idZd5wirfDYVzNa2cL4t4ne96GoYH
	 uzCMzdQgBvCFdkTH8pZQeMIH9RmTdZVTAqIh2hTpq1dqP8gTKospBJhjfl0U7T4C0Tny7
	 XrkIOCyRaruCGKte/TQ01ar/Wk6jdisJ4Wi0QXl55He6MqpMuKAKQuVcUc8KmCWqI5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695752;
	bh=J6vizOWujNAyr0n1UdvIOR/BZzTSd1dxWRt2w8og9Lw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D4xZfzEPiwiANPGPeN/3u3jjseJ9TGQeSur4hG7hPtrAMb/VqFEBuGSJZ6IOl+0yC
	 kgefoVO3hqKtFS3q03Hpmx3S4VBrVvoqWMBjMRKguDz3UyStFKyvzCsouPPjtELZPr
	 Sk/8rzPWaT+RpHrRZvIwC4EmYFHH6OOkLhf8dXDFeWtuZAI5yvkGnDwc+ehNvbj8QU
	 2CIdkaYSSYbtP5Uk4wDAUpPaIQ/mEadFgcOXNX6+G7h6GpYqR7+ARTqWEaUPw+r0hY
	 fJtW1it/eA2apda0nYkLuHt+Obx3+wFN+oNLE94lK4z+g6evb3cyySQFFAzWjrUVE5
	 W6JwpQJDjrrbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B2F7811E5;
	Thu, 22 Oct 2026 19:02:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED1804BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE6396068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kdbVDcjeprww for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D4451606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695749;
 b=l2nniNjC5ZA8dx0Dmiyds3bT/dHc8+TxSJVnE3m551M2cs/eAhzgYDU6L0yKATr5oMO3
 b8ZUSCYNzRxOV1dM2i67r6hRVqHxjVeUiVFPM7T4tU0Tzby/38QcYTBQBT8Oqdu6RDgAD
 kBm2VSYvPI3XAM7ptaqLZ5mXPxt5Si1JphJOjduYmAS1oa2gbIuxuNz5JLg5diHo54FoA
 cwN31WFKBqbZ8UPPf3JEnjCH8ifVRGH8r0DZORMU4l2oi6pgOCGE1ul5KfI1DXojuNx5L
 vlpEzTMfQHwDaj6EibRWULmZYCPeN9c8i+d7Fg4H5rVl2QytcGPdsBwla7uNh2NsbZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695749;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=J6vizOWujNAyr0n1UdvIOR/BZzTSd1dxWRt2w8og9Lw=;
 b=htrO0WjPD8l9R0ZlJZ5gsXKVzIdjqk3bcUd+iVS3cIS90b77sGVJ26HHxTj2HM0jUwUm
 yssMleImdANxZngo+cvwqIrURBKbxUS4eQYJIVeElRGVRxIMIKgbwovsC6j3+IFCltWG8
 vMV/bmgcMzLM3J5eIAB9Z66eOe+xzB9wbnFSSQB3e05pJey6L5gGgU1GA3HyxFMMyc497
 mGU4Xo5Qcfbi6llPqXnwVSmMd6cz5pZUoU7h7BV+RHeYv2NNv+VIc2MSUD1K9yzqnt1lF
 sIabD/Q5WfvTIYreJGWlnyGxp8bGYN/5VwiKPrDmWk6WtRsM71YPDRbTY1DcY8i8XrA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GUaW19UZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GUaW19UZ
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4451606C4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:27 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so1307465e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695745; x=1793300545;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J6vizOWujNAyr0n1UdvIOR/BZzTSd1dxWRt2w8og9Lw=;
 b=GUaW19UZqi8X/H3FJ2paK1iM6w72Gf5/shUc4KXHtZPveO9mpCCUgaRzGnSw7UYZMd
 fzLqOplj8jrff+9j+WVfQhmtgIxSZeBLzIa9QrAPLGrXttIGZ3Wqj4U6cgQqTQFUnGNC
 Y38yw9ctLh1lumYJPL5LQVcs+cmZIeb5MeTQ1wzYOHaFjm1bn9f6vOM0rXeV3xpq1zC5
 jeZGXAFn9QqDzmTGaERU1kZrJGaOcOIKNA28H0SunN0rW/uFYS7D2MJ6zXeSwHO6snCy
 5M7/TOOVCXvA8z8vRryMPZrtBsZsBtLmBdVwNJcfdxy/1GL21eVfOO31M4bHKjYZwbWw
 5G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695745; x=1793300545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J6vizOWujNAyr0n1UdvIOR/BZzTSd1dxWRt2w8og9Lw=;
 b=j+8T6HK2VRos1tNeZ/pxprLW9nQO3sHh5tuVTiK+5uoi0yaTfkML37rzDJ8cpAyeEk
 /VfRpoPdzKuO48cZF2Nhjg1J/5RVjQkI6JreglRk8Rx72mUjy9ZVtuaEwyQoVSHTWNGu
 cHJmQV+fbCujf97IA67xkXPIGMSkUWOs5Cj6CSXg8zsXUkZCsZWMy5pAhU940QyjZnz4
 5mhroJxtso12MlM72JgNgWHp7AF90PImaus6HBsIOcCISuCji5i9mnNP+xYq01Eaqnfl
 iyAlMltdV1b0R/ErSoHMxMxEWr3JuifraQWmF50FQcGFRCQaprsEELQThpqo7Bh78LMF
 BXnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5iML682kgRVRDb5sA1qPYE4LyCieFMsbvcPPtkVywYhfWxtU7imnFK966MUqNDUPyPMiYzto=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJM5TFIX+lanHG1GB7pwl+x1Fp8otWcNAfjFSHj03twCS1Z5ooh
 QB/ROFncfyH9yc406/KZtlO/GFeapUToccwvvBzdLJIeen/e18vsKO45
X-Gm-Gg: AYBFou17RvOrPws3XHg/T04BJo1hZgYeiuIcR0zPLKs4NHvcyF/NC95fA+mK22wUyuZ
 biV4cKkzOaLNCyTyaiKAPVq2nW1+Z6OLEbN1cdAoNhZt8BKs1op5yR87DHrlgtrK9vXujIK27jW
 /ExWCjLRzSet1/VU6LLZH1LK3sxvM3xRFY6CL/2p56XTcYOz2NOdecnYHoCleAjBHzUq5HUReXS
 n0vd+cp5o4yuL7+nR0e/lQ7dpecjEhyzPwOHV2yXIq3mUbIPCre3vCfeC/4KklDmLAZLSC58SUI
 Rk9k4Xa+lwNnebCL9drIbr4A3dCvKpr5bofWeX5x1DBx1+aIYsMSB88OZ35vB2FnlNNyDeFrQvH
 a7qbJqauw3rUzP7nfBy217XWkeykiqpzBH+nDWHivIsSVi3Utg/FvTNUNqgQVcPk/G0hxCyJEhO
 At1NYQE/Dqm/6XD12EdRAU27HUZCFgzSONCKKDT8V8YMz6zP0u9IBDNTxcyiq+0YXsTHfMUC7+2
 3jXEkk6exiq94ytP55wT6a7DznxSac+wywiVR7++AmMM9I7F+mnRKCLFzll8UcFwqIl7fxG9Bds
 CD6Jvzr36WpKdi7Fmm2OlrNWDj9ByBeKvq74UHA193OQTXKWPF5RcMtRZy6aL3bSQ8B5aZyyGkh
 IOCgd8g==
X-Received: by 2002:adf:e002:0:20b0:487:8ba:8aa4 with SMTP id
 ffacd0b85a97d-48e264c4ec2mr9129533f8f.38.1792695745187; 
 Thu, 22 Oct 2026 12:02:25 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 01/16] dt-bindings: clock: airoha: Document support for
 AN7583 clock
Date: Thu, 22 Oct 2026 21:01:43 +0200
Message-ID: <20261022190206.666950-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document support for Airoha AN7583 clock. This is based on the EN7523
clock schema with the new requirement of the "airoha,chip-scu"
(previously optional for EN7581).

Add additional binding for additional clock and reset lines.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/clock/an7583-clk.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 include/dt-bindings/clock/an7583-clk.h

diff --git a/include/dt-bindings/clock/an7583-clk.h b/include/dt-bindings/clock/an7583-clk.h
new file mode 100644
index 000000000000..e832961d0663
--- /dev/null
+++ b/include/dt-bindings/clock/an7583-clk.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+/*
+ * This adds up on top of upstream
+ * include/dt-bindings/clock/en7523-clk.h
+ */
+
+#define AN7583_CLK_MDIO0	9
+#define AN7583_CLK_MDIO1	10
-- 
2.55.0

