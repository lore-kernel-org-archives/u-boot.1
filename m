Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ABDC282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 10:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B94981420;
	Tue,  4 Mar 2025 11:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D46E81436; Tue,  4 Mar 2025 11:58:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 23E0180FB6
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 11:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352F1FEC;
 Tue,  4 Mar 2025 02:58:38 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 279663F5A1;
 Tue,  4 Mar 2025 02:58:21 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] wget: check return value of store_block()
Date: Tue,  4 Mar 2025 16:27:41 +0530
Message-Id: <20250304105741.489938-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The tcp_stream_rx() function calls store_block() to check if the
destination memory region is available for the chunk of data to be
copied to it. The store_block() function returns a negative value in
case the destination memory region is already in use. However this
return value is not checked in tcp_stream_rx(). Take the return value
of store_block() into consideration.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 net/wget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wget.c b/net/wget.c
index 0b082c61947..847097a0e3e 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -227,7 +227,8 @@ static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len
 	if ((max_rx_pos == (u32)(-1)) || (max_rx_pos < rx_offs + len - 1))
 		max_rx_pos = rx_offs + len - 1;
 
-	store_block(buf, rx_offs - http_hdr_size, len);
+	if (store_block(buf, rx_offs - http_hdr_size, len) < 0)
+		return -1;
 
 	return len;
 }
-- 
2.34.1

