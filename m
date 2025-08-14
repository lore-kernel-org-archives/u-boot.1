Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC72ECA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 21:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E1C83A5E;
	Thu, 14 Aug 2025 23:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="UxLBd8o5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB5583A1F; Thu, 14 Aug 2025 20:07:18 +0200 (CEST)
Received: from mail-yw1-x1161.google.com (mail-yw1-x1161.google.com
 [IPv6:2607:f8b0:4864:20::1161])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5024F8399C
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-yw1-x1161.google.com with SMTP id
 00721157ae682-71d6016a730so551247b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1755194835; x=1755799635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FC8FZojqUR9+8L5E19mPiCN6xKTTo4qd73j6nbhmSfQ=;
 b=UxLBd8o5N/jcs2bL2dLtUCj62k9FUWKvwPjOkjBDPQAqpKBmOrrUJBGScOmqctxLvn
 bkG6l7j6KK33oLTSWd/3/clphCr/lMgWvdX7M061gQhG39ucL3WfNgKGqaIph+/DsNLe
 VU4XwefGPFm/uxp8r1EDcCGS2mOmmJEdlpRwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755194835; x=1755799635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FC8FZojqUR9+8L5E19mPiCN6xKTTo4qd73j6nbhmSfQ=;
 b=DKggi5lZTOIaeJSKYOwhlP1lDYfo5NHjm+OtAD9bgDJTzIrlAqAWbgHbyGXrhtFlhh
 zpSZfZWySDjBX1MH/xiktMW+W01E/Y2f0v+CTwJnO62qBRqZeSlfF/1AdxrMZ97b/4Ar
 bMzEmPc+i37AElcz38yUQigI+Lop+/c7y2vKlxmZ9veymVtsySQE9ZgZ8LQG4y/Lo6/d
 lLKj1nmrKHNF+iJx1zG2sTP6mBfParrlsNb0Hx4gFQBrZKdlDyJlntu+Uz5s64mLsxsF
 j78f50Ri2q8pgGRidHglW/LLpyjLFS8sbnMyUsU8MMW+O9eRdoLv9V7/F0RxcXrar91c
 01zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDjYu2qglEwnBgkw55Kkqk7kBRO39omB8fE1C3uZsNM4XOK1m3CSCNkmwiHhiKyKmJeiFU/iM=@lists.denx.de
X-Gm-Message-State: AOJu0YyQNXoBGmTXB+4qojs0IREtl/wYNrsa5XJWa0KPjEztZqD4Uq9c
 6uz2AznMSosyBN4l4CRTJTlYpxARx30lR+iz9J7W7P8tKp2FLdeCtN3g8YrETqDMBgTbP6Kc0Zm
 vkMaNh3uZE094VEpCAqDtpEQrj7e9popFwA==
X-Gm-Gg: ASbGnct0jJm0wcaJ3KH5c6n8mrx8GuT+85pkZIYWR4vJxSJK9+beOOzjptTRGxq+E8O
 UVCMiv8uPqda9CXESIhyjb8PRhmcsBua3z4hsY3/fmRyebjpa9MGIynor7o2sy3bm0sJfLnX08z
 M5UVMrza9mWAmMAOfshOwkeOi58EJzqYhscNg6YF/G44OsaNvqDNMZ3xPqIsJw1PFYB47m0sa9i
 u/OGYpYcS00RaE4LxOlZyZQSfVccQ71JQ27VIjIj63o9qNN32RWOqZfSTHpydXMxTww8ffxHca0
 C3FHqFTsfHtAFQmRarYeq2SelrEXZ6ElNO1sICboE8oUkS4QqFRaL9J4AsK7E+a9XePOIRZx2xc
 sZaSRP6XLpHvC0Q==
X-Google-Smtp-Source: AGHT+IGpHuVwk5o1KTcUUZlX8EReXWtEt+El8dIvHR3/JXecit7D+GSUzxbw44HDd8sqyFZDJ2yjJsPmLyMh
X-Received: by 2002:a05:690c:710a:b0:71a:23b3:13a8 with SMTP id
 00721157ae682-71d6365fff6mr27057837b3.7.1755194835093; 
 Thu, 14 Aug 2025 11:07:15 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-71d60d6b387sm1970937b3.5.2025.08.14.11.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:07:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: dregan@broadcom.com, dregan@mail.com,
 Quentin Schulz <quentin.schulz@cherry.de>,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH v2 2/4] cmd: nand: more descriptive help info
Date: Thu, 14 Aug 2025 11:04:56 -0700
Message-ID: <20250814180647.1805196-3-dregan@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814180647.1805196-1-dregan@broadcom.com>
References: <20250814180647.1805196-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Aug 2025 23:00:20 +0200
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

nand read/write raw change 'count' to 'pages' since count is ambiguous

Signed-off-by: david regan <dregan@broadcom.com>
---
 v2: no change
---
 cmd/nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index e09e145bc2d8..cb2a61a2e57c 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -1026,8 +1026,8 @@ U_BOOT_LONGHELP(nand,
 	"nand write - addr off|partition size\n"
 	"    read/write 'size' bytes starting at offset 'off'\n"
 	"    to/from memory address 'addr', skipping bad blocks.\n"
-	"nand read.raw - addr off|partition [count]\n"
-	"nand write.raw[.noverify] - addr off|partition [count]\n"
+	"nand read.raw - addr off|partition [pages]\n"
+	"nand write.raw[.noverify] - addr off|partition [pages]\n"
 	"    Use read.raw/write.raw to avoid ECC and access the flash as-is.\n"
 #ifdef CONFIG_CMD_NAND_TRIMFFS
 	"nand write.trimffs - addr off|partition size\n"
-- 
2.43.5

