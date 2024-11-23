Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C882DE6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB57893D2;
	Sat, 23 Nov 2024 17:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380804;
	bh=mqwgnJgzRg1F2+ZmfKD3ajZKLujnACkbxZAv0gms1xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mwdrqjhWoddKHTzjVuAcccvFTs7Oa4Ll5HxWI1h1rvAIaIkrePmyiY3+O1z50X3fi
	 Pbti52szFz6af+U5fDd97iKaNBsbYwgN6AKwIfkAg93GArqQ8QPYKZ2fm3cNsUq9YX
	 6glnh1rn818meQ/HZyJOi+jrBJq2EGmShioHh5paAwRmqcQMGqYpQAaXrklTcjo3eH
	 w/x+tSRIh66KuODEchmJDkasUmCYvfPom4dk/vOVbZU0zb7EycglzsKYd6ZucEK150
	 WNXam9PuPRMaRowU/FUDZ9qnTRMdAk400FPKiVYimG1c6PwG3COvd6feuJDtG131v7
	 bQBxyg38/Qsjw==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9F11D885F5;
 Sat, 23 Nov 2024 17:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380800;
 bh=mqwgnJgzRg1F2+ZmfKD3ajZKLujnACkbxZAv0gms1xo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ykoRLnXf6hRw5ORBwaIXalZdNCXNoOAzbm3VVrqQgk7FJA/ISBgSX/34MfXRlzrWW
 BJqK7wxcujlcmGLmlsNRu7KJv7yx3ODM3I8OUHx+EEddrodG7FwUkO7ju96rCv8HpU
 Jl4KYJgv2S1iEN8ITP19de+hgji2fBgj28iSTHhR042OCnOazdZ05E9se1O9d7Hq2K
 TnQtQDEeWAlUwzgZv4AJ0gGfnx4Z3PiNANdnySet0ra40gf0O3t4fUEKkT3AuRla+3
 b1lH5Xd/8PeOG/Wtdn0jMB1/uPWZwP2Gu992+l5iGkzpmBwAj5nDJ9gKlbvTIw60cl
 H86+RMYCtNSJA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 09/20] siemens: imximage.cfg: correct comment
Date: Sat, 23 Nov 2024 17:52:53 +0100
Message-Id: <20241123165304.100538-10-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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

fix wrong comment.

Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---

(no changes since v2)

Changes in v2:
- add Reviewed-by from Alexander

 board/siemens/capricorn/imximage.cfg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/siemens/capricorn/imximage.cfg b/board/siemens/capricorn/imximage.cfg
index e45f2c9589e..f73c5a7a9b0 100644
--- a/board/siemens/capricorn/imximage.cfg
+++ b/board/siemens/capricorn/imximage.cfg
@@ -21,5 +21,6 @@ APPEND ahab-container.img
 CONTAINER
 /* Add scfw image with exec attribute */
 IMAGE SCU capricorn-scfw-tcm.bin
-/* Add ATF image with exec attribute */
+
+/* Add SPL image with exec attribute */
 IMAGE A35 spl/u-boot-spl.bin 0x00100000
-- 
2.20.1

