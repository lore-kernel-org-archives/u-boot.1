Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947A9C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 17:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8B3806FC;
	Mon, 24 Mar 2025 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="de1fkfiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF2380EEF; Mon, 24 Mar 2025 18:53:05 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F71380548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 93D4E3F1F3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742838782;
 bh=LqLDiR+jiDfp2lH6NEWGoqOdRtBQW3aZJSAsNC7qbJc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=de1fkfiXsq1eOzOIT6hJsDHA/PVB5YjGit0WPpG2UczvIbNqqydI5gXAj+gBigQ4P
 7R8cXXNkAsBPddUcvSQ8MZDQ2jxQk9vfhj/dPiORf+V4lkk7sg+KvNEka6jvSPzGhH
 OOB45rjS/WDBG51ef/tXZtkS4OsMtDXvZU94wDEZfLjup1yb0zN1woKN1PYw43bvwC
 ao3f2L04/DFiITaByTcGML7ZMFu6j193dMz0RK/CEDWX7lBMJdIwxgIeDbak+PIsWa
 pA/fc9SjzSGKJ5osmuFQx1lh/8spnIhWcpm/BJA+r0BUt2W6go7FYS1Q4KJGa/e3zk
 hMLlhFL6jNoiQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bd0586a73so30666665e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742838782; x=1743443582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LqLDiR+jiDfp2lH6NEWGoqOdRtBQW3aZJSAsNC7qbJc=;
 b=wPmEZyYDnlMlZWIqkc393gqX14V6RvcAqUjwqjhq6/++/G53usHUBxW0Fb5sq8HNx5
 PsP8YTgbPSyxyPDIU0zZFA6FyzOys1H0fe1GO/HE9iphAKvvHrjoX6kd9JPSKrWBCcBh
 zNmMWnOyZqb70xmfO/jHiC0ykZz4rRSvClXGllSAUdqP3rvbaBZW7PTAgi81fvJ85Wyc
 OwNGkP+HHaw1zrAuY0AzbGckGP1EHmUlzJXZZsLe5n1m92zYc5/pW5iGGlUaC+cKR2yJ
 flEGE2s4XqyKgiTkG/c3WqjWyPJ1AxgtMMkdnSymlqcpIoctFJsg+MEUMU+JA6JQccBR
 vDLw==
X-Gm-Message-State: AOJu0YxweuGJT2nz3KY77DnVRFi0hR107IDexYZ7dz7TlsTQWI2bF4up
 ncYaiSuQxMHPCBSKMegbl884zPKHfA3clvtFTZNxwXhz5I2+0oxyvKPsAcQiFpfcUWFQFiEnauV
 XjZhiPOBBaGdVSElyBDgzJu0CCG5sL53lo42u0cZlQKsPyCTYdpVCGlu389e/E2/A7hs=
X-Gm-Gg: ASbGncvij71tyv0tYfgxyLN/6yvDfKcCqGyekvfyyCT/ON+4OO7u9V20aauLc/9JJHQ
 574eK4JEMKbE3SxfK6r4WxGNYIBZE1V6X1nKHlxiFx5nMKE8TkX78WRAV5qufcK+V02iCzlbyuX
 My47RYPtfYJd/ToY3o3euf6Fo+DaT+XRRmKWejmm/7AfJ0ATLqabnNcCI2NJwqOSaWJPc55eXJO
 knxQ2PGgkvUm5i42nFomUBFrLf3qoqRjtfQs7n6SMuUqudwkfS3EUdmMnVjDicGIcaQZ5YwL0k5
 HXtqpJaYbrmnj8sghn22jNyGWxkCkTgDfSzW/kFTr05lz26mdvN1D8JpL3rKUdDUdXw9bm7f6cQ
 g0YXnXhTlBoLlrCRazA==
X-Received: by 2002:a05:600c:1e8d:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-43d509e46bamr139272215e9.6.1742838781956; 
 Mon, 24 Mar 2025 10:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdr3zDjW6T+/RvVDILpFTcjufe449LykFCwIikPtM9CytgIW6oWlugNiEUGYPsN6z98+Xc3Q==
X-Received: by 2002:a05:600c:1e8d:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-43d509e46bamr139272055e9.6.1742838781523; 
 Mon, 24 Mar 2025 10:53:01 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdaca8sm181063455e9.28.2025.03.24.10.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 10:53:00 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2] cmd: pmic: add fall through comment
Date: Mon, 24 Mar 2025 18:52:53 +0100
Message-ID: <20250324175253.579368-1-heinrich.schuchardt@canonical.com>
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

Make fall through explicit via a fallthrough statement to allow building
with -Wimplicit-fallthrough.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	in commit message replace 'comment' by 'statement'.
---
 cmd/pmic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/pmic.c b/cmd/pmic.c
index 3ad1b8aa375..c5eea766a31 100644
--- a/cmd/pmic.c
+++ b/cmd/pmic.c
@@ -34,6 +34,7 @@ static int do_dev(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			printf("Can't get PMIC: %s!\n", name);
 			return failure(ret);
 		}
+	fallthrough;
 	case 1:
 		if (!currdev) {
 			printf("PMIC device is not set!\n\n");
-- 
2.48.1

