Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21531CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 05:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916A883B07;
	Tue, 11 Nov 2025 06:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="eECzNAEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B09F83B05; Tue, 11 Nov 2025 06:48:41 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A5EC83A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 57A7E10A49F; Tue, 11 Nov 2025 06:48:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762840118; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=nkXwxqSnYT8VcB+plP1vgKHwK/ozLj63RdkDT/zlHDw=;
 b=eECzNAEclN+VVJDQ/O9TDBlhVMZZyLRPqSIqUspbfyCHC4AuxhltbLD36xAGm2Nmq868J4
 DsnHOXsymRPAGzs16Sfy3eg3br9OkbhgwAlu2KWIe8ykztGb8ZZfXYbYGIEMaj2D9l3oqu
 Efo6FFNG3B33Wf0qAuwn7UHGQHod/ctnlC4mF3cnHP58FKNlF8Ury1bwfLfNdVNcuLi0qQ
 2txRQVTayG7KACpCzn9H/TPPBTl6qRVRVI2Iryb7SL+EPT0lKmAzkVePsVh78d+0DmPulK
 KxmUwPN8pUm5a7e0neBr424t70ncwxXnsUsQswnFCbXF+MaiKZeSPs+6g0LVAw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/5] lib: Import rol32 function from Linux
Date: Tue, 11 Nov 2025 06:48:08 +0100
Message-Id: <20251111054813.1966-2-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251111054813.1966-1-hs@nabladev.com>
References: <20251111054813.1966-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

sm3 crypto algorithm uses rol32 function from linux, so
import it. Linux base was:

commit ca91b9500108:("Merge tag 'v6.15-rc4-ksmbd-server-fixes' of git://git.samba.org/ksmbd")

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

Changes in v2:
rebase to
6b27b688694: ("Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh")
add Ilias to Series-cc

 include/linux/bitops.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index f826d7f3b34..29e0da48de8 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -148,6 +148,17 @@ static inline unsigned long hweight_long(unsigned long w)
 	return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
 }
 
+/**
+ * rol32 - rotate a 32-bit value left
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+
+static inline __u32 rol32(__u32 word, unsigned int shift)
+{
+	return (word << (shift & 31)) | (word >> ((-shift) & 31));
+}
+
 #include <asm/bitops.h>
 
 /* linux/include/asm-generic/bitops/non-atomic.h */
-- 
2.20.1

