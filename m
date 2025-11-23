Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790CECFD2F6
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FC983C13;
	Sun, 23 Nov 2025 23:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="L8QSMcKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF88183C28; Sun, 23 Nov 2025 23:58:16 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D740883B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 547DD409BE; 
 Sun, 23 Nov 2025 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938678;
 bh=9LYZ42beSvz5/htNQT0+KbSiuyXc6OlJCeiYby/9pWI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=L8QSMcKxxvF9R2gsIZQWTVN5tMRGs2jCk5VgWacFS/x3G36wuIc7Vkq9Dw1k/Ys3D
 0SrrY71GnJjm1bIzG4gkooub2hhgiR4DjVJTbUhfV5HxvNVEmAM5vGGUCP5aEviZFl
 Z78EztPOFpwu5Y9KZDhgJX8ISgr3ZiHLQMVAhUV+7VmOOs1md1rW3o/pruiMy3mUXa
 BHIZHr/ylkrNWxV+7twWOfMQEuFJ7djrcN4UCHddS0aSIecIzg1svlWbpcOHGXAs8y
 ZZTOTO4CHaXo1pCWOLfadh/W/SC7OUyS824A2DYHfTMH1T6iHVMLUmOYjEUQNL3Zs6
 mOyeSSYS5zYp72hNYnL1g/TJV1sZG1rNYXQVFBXqDYe6/lGGjd/21IZTa1I4njafHE
 0/yN4P/QNtWTI2+2uIyeJULiTXkWrnL7XK6BaXnemvaR4HIuXDphctpEEB0jba6bAS
 axlZ1HWB0hD+oCTQAGEbl5rNknWNhk4Q4Lar7aVZHHPavTPS/pZ3nBwNgwYgrlNXdf
 8Prvk4/pGSL9/amY7BIBqeiYDXgquecg5VORSXp13MhjKmuQGTIoS75+cy/dNJhtH2
 mQz4orWBFyv6vkKZ5sQxUAr2hKAfdPm9bLARLr+F7+Bw5iLHviOooQIQGYlChqhV2i
 GDkuqr7Lo43vOPCxHXxrMkQE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 05/19] test: print_do_hex_dump test depends on HEXDUMP
Date: Sun, 23 Nov 2025 23:56:57 +0100
Message-ID: <20251123225711.227016-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

Skip the test if CONFIG_HEXDUMP=n

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/common/print.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/common/print.c b/test/common/print.c
index a8feb07971d..23109188317 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -271,6 +271,9 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	int i;
 	ulong addr;
 
+	if (!CONFIG_IS_ENABLED(HEXDUMP))
+		return -EAGAIN;
+
 	buf = calloc(1, BUF_SIZE);
 	ut_assertnonnull(buf);
 	addr = map_to_sysmem(buf);
-- 
2.51.0

