Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEB3C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C48869AB;
	Mon,  4 Sep 2023 15:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="Hk+UJAeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C2C6864A7; Mon,  4 Sep 2023 13:00:48 +0200 (CEST)
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com
 [203.205.221.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A68846D2
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 13:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rtoax@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1693825231;
 bh=6K7GoZS257A0orE3ORQFCaddCt8e+TXfpAuUIrfEKeo=;
 h=From:To:Cc:Subject:Date;
 b=Hk+UJAeb20RhHsmSrQZ4Eetk3pnxx7C0hAGgdHfmFKJ2Yjc78jdhTSXAiL1DM2irk
 OMt7zGABu65zux6NVLKyPCp2bu+7JHFW3tOYX/GfwpkWjS2liBJbfVt98Vtdx+HhY7
 bXAZ6jGDdBxMRmAnyhOYeqf2c/xxAYIKbOFDVc2A=
Received: from RT-NUC.. ([39.156.73.12])
 by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
 id 1C94C03; Mon, 04 Sep 2023 19:00:28 +0800
X-QQ-mid: xmsmtpt1693825228t17dfzrib
Message-ID: <tencent_0D22B14196104C56C3E5BB4AD46BCF283306@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujGwkykzyhLmZ+4MTQFehc81oT76wBUcrBDlofZiCu2yiX8OBK1x
 TnPfRTSgwlTjPLXdioFhPEJ9mbTrRV5PtCmHDAgAAG0Tw0owqcjLUdEVczu8xhneNukyZn9NQxvV
 LhENEkGC00huVSm2Cj8Qc7pZRbfhiVpCWXTIx9vzu0ZC1pRZRQO0qOpIU3trEOYJiejle64q9LXk
 km7BBCBKiGJXZz29LK9FSoc7tXuqnOEMkVhFSrGAOCLpKRFwcWBuI45/DjCTo3Xjqz+rWYNFBle6
 yYEi/1U5qq/Cq73hUteDnBfaClTH+G+ZXq+jkoDyao/zvvkfWOVJMbDS3CIlrz3Sij8ZpRoiYwuh
 m3cr9SSjFLrRxrVtoaXgsEgjNs9zKgDx+o80LknOvgPsIEMFbYn2E4n62QB428bJYDxIN8FW91+m
 knOoVoKI3PYW+Jy9wMcSBBB4FQ+WvGr4DhQ7AHdot9ajHS/n8kjbZq4KEjMaI8APNTuPjrMDOAHn
 f1nHQFPIdtrRdjxaehn9nq1xG+4C+lJarV9+4BCX9aYDHs549cInJSHNNfW0AJbv5mpjPdM1Ohlj
 C6w+eGdm7Wl62BSekFdwKrms4q2E/euTF/b26HzJi3gVtPFLyeMTg1i0E2/M+zLw0CNKydUrQBBa
 ugb/GXqKC+jxK2Ukpv1mP6iYrJOD9rSAuplWFHlj3n4FgO5E/XpC3UjBjs2GHIG35/fNDBKI+UwZ
 FhnxZ5jPUPEGtMyGMec/mo59qWGkvD689AqI7N/0J1xsto2Tf8TTZANRaWVzhp6UIJ59vtGBMP66
 W83cahVD2Vzmscyz+TH2u3PqekdJpbfgbIFlwqeN8/zf7IJasz6e3bkBYGBmoZsj38sgte4GOu5J
 hJUDywDQ9EX5UJAtaYX/2TxAcA2/C5SzSRC+6klHl3Wm1qNfQ/BFSw0bc9UM4fCyzocTQjH2qyQf
 +7/5t/JNjHjJ00+ciL/5osTJkT74EGAPKqWDPekL0=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 u-boot@lists.denx.de (open list)
Cc: Rong Tao <rongtao@cestc.cn>
Subject: [PATCH] binman: Fix SyntaxWarning: invalid escape sequence '\('
Date: Mon,  4 Sep 2023 19:00:27 +0800
X-OQ-MSGID: <20230904110028.142656-1-rtoax@foxmail.com>
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

Reproduct warning:

    $ sudo git clean -dfx
    $ make CROSS_COMPILE="" qemu-x86_64_defconfig
    $ sudo make -j8
    ...
    u-boot/tools/binman/etype/section.py:25:
    SyntaxWarning: invalid escape sequence '\('
    """Entry that contains other entries

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/binman/etype/section.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index fb49e85a7634..30c1041c7e8d 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -40,7 +40,7 @@ class Entry_section(Entry):
     For example code, see etypes which subclass `Entry_section`, or `cbfs.py`
     for a more involved example::
 
-       $ grep -l \(Entry_section tools/binman/etype/*.py
+       $ grep -l \\(Entry_section tools/binman/etype/*.py
 
     ReadNode()
         Call `super().ReadNode()`, then read any special properties for the
-- 
2.41.0

