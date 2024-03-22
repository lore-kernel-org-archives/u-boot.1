Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8D2C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3197F8822B;
	Fri, 22 Mar 2024 12:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107826;
	bh=NZMPikK8NYq7cqUdf33MT83BrOv1OYUm8y6+gMxKV/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u1CIn0JipeqN6iiCAmYmxtX6WVuWY/BB3mVHJYvyiu89cB3Jmkb8MyKyxpbwlQPTO
	 N19XvLMQNieoZwYByNR8pxRbFyHZM8MDgnPfzL/0N5ERhS2noJclM8/LkbVoQahalY
	 WSQ/VRwYO56MUqXALKJrTECKCQLFYrtSZYm5JiNWtyhr4wrwlHp2e2/1F8QV2UAIeY
	 CGKnt+YqzZhBooA79cZxjHsmEKy4wduqHGGWTdhTOBPaf7ZG94o43K7eeACEW55+i0
	 4Q5jcrTQhsGospUhAJFNBfqhN2aiQEhqJuUh1hP6F8uGnLrgpdnH1qQlOxDbN/iZxC
	 J1yOh4hD4+jaw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5DA7488215;
 Fri, 22 Mar 2024 12:43:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107820;
 bh=NZMPikK8NYq7cqUdf33MT83BrOv1OYUm8y6+gMxKV/c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qUaLQGO98BAPVopM7/H2URkAhqSj9XzW6zVvORyybuxXy69WNAwQB3xEjpIojWomb
 9v5uZZP/NZ2I4aVfC+q6XtpgZszmsDoeczArSXgtSnl1iT0TlIQN906rrWE23q+ano
 0osHNJkQoLD8w/ydK8jhSF5U5vAbBFlCPhBmgPLNkWqDrJ2YrF7+C6/km4m17pQ+ss
 22APLGeJwSwCF+prCF5RJ0i0vaR42kcGWA5Qef2UzGIuBgHiutagz257oYtp6L6d0X
 d3PWZ7eI8KSQyZGa3GDb/zTY8oRlx8c7eMPlxIyLSrMF9+p1OLwa2exhUB3vmjfo6j
 tzgG+FkQzuHFw==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/12] arm: xea: Print information about XEA's SoM HW revision
Date: Fri, 22 Mar 2024 12:43:14 +0100
Message-Id: <20240322114315.2720727-12-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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

As now XEA has its second HW revision - this information is printed
when u-boot proper starts.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 board/liebherr/xea/xea.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index 5bac614153..876e8a70ab 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -294,6 +294,15 @@ int board_late_init(void)
 }
 #endif
 
+#if defined(CONFIG_DISPLAY_BOARDINFO)
+int checkboard(void)
+{
+	printf("Board: LWE XEA SoM HW rev %d\n", get_som_rev());
+
+	return 0;
+}
+#endif
+
 int dram_init(void)
 {
 	return mxs_dram_init();
-- 
2.39.2

