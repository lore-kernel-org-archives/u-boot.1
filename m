Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5E6C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 12:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BA5807E1;
	Tue, 11 Feb 2025 13:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C29A8033D; Tue, 11 Feb 2025 08:31:01 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4FA80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 08:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=yt@radxa.com
X-QQ-mid: bizesmtpip4t1739259042t8pj09x
X-QQ-Originating-IP: d4GhyLDvTU2Jaq085ZNfALW8lXut68enNSiaMKB+3dA=
Received: from yuntian.vamrs.org ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 11 Feb 2025 15:30:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4534592478335416093
From: ZHANG Yuntian <yt@radxa.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	ZHANG Yuntian <yt@radxa.com>
Subject: [PATCH] mbedtls/external: remove broken git submodule
Date: Tue, 11 Feb 2025 15:30:27 +0800
Message-ID: <A189BD12BC0A2ED2+20250211073027.1351783-1-yt@radxa.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NU3R89Kb/SxWIYl+1ZsjMhqBOL0xb3FLi9SVsXHTs5HE6iR6cFOo0Gf4
 +A6L7ovaj2mvquJGtaNw6mg9jDtjI+dUo97Sy1fJobJoHdz2J214epTxJH+vSABbSM1jMJH
 0QgvNLK8gVlS4BBRTPRn4rPLOQSUs65MLZ/Har36R3zXF5YhImDCD6jBjQcsvFDwWAn2R17
 LWRhOUrSdA0e7bGz1uoofQo3D7R5mIhT7qjoF40kyGHjur11AZrNcp3Kf3wuXpfDaycQi2A
 HhERQNdP7+dhLW5SSN2iD1MomVIc5xdA1DGEWLXo+CeZw7GfAvaKfJZzRXvDbnqX6w/QQZN
 WNZPi3vLZEf5efHugbUQ8qtcAWsYyftpU68o9VVoQ+mErJy2BXxE+cBDMUkp6L3NLpkSknx
 EC99VpZBXnaImQaoHEWHilUrVgYj7Bc9Z24TXKKKAXtL88H1F2boLyZKD8458+5EcIYnKx+
 4aSb3C+XYFr3CallQdAwVSZ6AmJhdu2Kv+ppxg4fD4UI/cYA5/tgNJrgqryaM6MOEgSgzZK
 PXimn/+9jgBJLx0pxaKjxnFqGS6cpCn/KJzSvlY1ornGuia62YcBCYjNPh/D/uMXa0Rak5a
 628GqEg9VkydP7ZUh7N2AdrRr0C6GB1tEPSv8v2lG+TszmKAlSjTdsVesAI3ojuK41Ah4bZ
 VwniZ8lbpGGjGzxnbwSm2u5uaDQq6tgkkoDOeceojr+/G1CY7xSput0Qo44y5jPjn06UrlL
 8BdOnisWaykt/d8VT/AmxD2K9fVFKdRQBNcRUFNwm1tlwqfmMgiWWf+ozCfjiXs4GSrupHM
 VNDRorSoW2nz1w/hQgUOKH7mJZQgaDFemv/1mR+VvU/46RVAoKub6prdoSJmeZOG2XYnKVS
 0kHUHCs10HHBQym4m+zCg+L27M7IEvb28v6asbB+HHtFF39xJXpbIwAdCimQ0c44tDTWcz2
 tOKeyovRp9HW3FV2pu5QZ6TFgoD+Iu7xmM8Afg2rBM54RHW5HHe8Sb7T47eUkZu8/hg3JtQ
 fOLUhZnUxurkQB4Ouv
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 11 Feb 2025 13:49:22 +0100
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

When we squash imported mbedtls, the git submodule "framework" was
preserved in the commit. However, U-Boot itself does not use git
submodule, and provides no .gitmodules file to specify the submodule
repository.

This is normally not an issue when cloning U-Boot repository. However,
when U-Boot is imported as a submodule, this will break git option
`--recurse-submodules` as it fails to resolve "framework".

As we do not use the submodule, remove it to unbreak existing workflows.

Fixes: 12f1212e95fe ("Merge commit '0344c602eadc0802776b65ff90f0a02c856cf53c' as 'lib/mbedtls/external/mbedtls'")
Signed-off-by: ZHANG Yuntian <yt@radxa.com>
---
 lib/mbedtls/external/mbedtls/framework | 1 -
 1 file changed, 1 deletion(-)
 delete mode 160000 lib/mbedtls/external/mbedtls/framework

diff --git a/lib/mbedtls/external/mbedtls/framework b/lib/mbedtls/external/mbedtls/framework
deleted file mode 160000
index 750634d3a51..00000000000
--- a/lib/mbedtls/external/mbedtls/framework
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit 750634d3a51eb9d61b59fd5d801546927c946588
-- 
2.48.1

