Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02BCC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35E286958;
	Mon,  4 Sep 2023 15:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="ulnKEu7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841CB8679F; Mon,  4 Sep 2023 04:50:29 +0200 (CEST)
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com
 [203.205.221.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F99864C5
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 04:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rtoax@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1693795810;
 bh=9mBhUfY0jAdDySEqza6e/qs2ew4Pams6qW0gq3C3g9E=;
 h=From:To:Subject:Date;
 b=ulnKEu7LS+nHtZ2Ll18DE9Lj5+1RNtJMSOCfNV0I4x7c7A/nr2VbNH7tnRVaS8+xF
 AiAvxh+16nUNhleF1KjaVEOOlVgrpVVBzI+xX8fG1fO7iO9hnCR2wZDHr1jCChPGJM
 Q5bJ8VIizNVNjRSu7ntWu08zWWGzFYagE38ifuXs=
Received: from RT-NUC.. ([39.156.73.12])
 by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
 id C883C20C; Mon, 04 Sep 2023 10:50:08 +0800
X-QQ-mid: xmsmtpt1693795808tul67wf45
Message-ID: <tencent_055CBAA884BC568E56211618940881653D0A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjCUNQosF1reiQaZbVuEe5TSZ3IvbfzK24K9UyKOM/sPD4q6ih5Y
 yoEfkzoPnrV1VFvZLVclebup2uzzZIngvzw0pui4jIO8Jm675dGlQzbZtVnurhZ1zPQsX76OPpTV
 WOtHdCTnIKB/gyVAZo7YZg9+in3bHE/yJci1Gevu01/BDszaPEXXjk8mgBrk/0iTQzn9bGLgCjf8
 4oWMcm1eSHZgDqhiY1EQBHnBNQcLml4Ck5qYiiL3UCrIaly5m0ifcNuaSRq1ECuQaJCDpzS/QrAD
 cbAJiUVVEzlm3MhVI+NC8Wib2/ngNGN1ZJyo9La3ER/UPahnn2D8Czw51HEpG6sBLNR+kOYMUvLw
 IKv5cLJO3tZWsRD2//AxWmDo6b4c9xD5crxRaoBsTqA7+z/jFnGycRnC9nO72OvYV6kjFd63qH+I
 AxVgFOLCQjsfB2tLIyy5JKBnq+3sq+YBMPQz98bRaFwiOgIHreIvY/d71WF03AxCoyxQf3zUrw79
 NpbLC3L6t4UyRu9w4fVRgAM/wSlleIadAo+nxvEBLIELDwa8p0DZ+VPBpGWiMkyes8+E+e5ZI2Hq
 r/ArSPVnxhd+N45gYlQmkXeR5cCW+obwyrvdGkBH8WEPbTRqZfBNCRHrKfWS9pLsF8lpD0ORQTmE
 fDrB6+VSDf+ZTVwiV8u2M9xZkzf93EwUypV4/wGZI+ULV1UP49pBVApnpg4iK56tPUHsdaG4R+IZ
 0EQ/pwc5yd+sedrrNV1aByMzdEZYv6H5TO5OKQZEk0BRS0wPjRdtGCaAQt0gzlfkkfW4rVFvj//o
 drXRMDVvJMAUUVI3NDVPpQm0xvxe9jvzwyDCYhP+cF0CfLNMhaQlsB9wfKCFmZsJ5a+CszpxtUmK
 BGC1A82r3KTEe4I2Ftx7qSU1wtR+fozMGdCWrFUb8wLwrC8R8ndx9itlHMAo36YcP+11FzBNmZg5
 Kl7lqsveIcnvKm3s1cz1fctY0G3hLqPYDpBLpgld0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Rong Tao <rtoax@foxmail.com>
To: Simon Glass <sjg@chromium.org>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rong Tao <rongtao@cestc.cn>, u-boot@lists.denx.de (open list)
Subject: [PATCH] Adjust gitignore for /build
Date: Mon,  4 Sep 2023 10:50:04 +0800
X-OQ-MSGID: <20230904025005.24150-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Sep 2023 15:58:30 +0200
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

From: Rong Tao <rongtao@cestc.cn>

/build-* can't ignore /build.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 .gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 002f95de4feb..9697f0088f80 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,7 +35,7 @@
 *.tab.[ch]
 
 # Build tree
-/build-*
+/build*
 
 #
 # Top-level generic files
-- 
2.41.0

