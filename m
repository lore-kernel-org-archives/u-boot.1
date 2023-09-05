Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3995EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 02:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE8A865AB;
	Wed,  6 Sep 2023 04:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="NpVUs7XE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0588986989; Tue,  5 Sep 2023 13:46:20 +0200 (CEST)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFBF8655F
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 13:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rtoax@foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1693914068;
 bh=I92U653WPFYRcB5KerzDf0bgA/xv1rJmfHnT4vV1huE=;
 h=From:To:Cc:Subject:Date;
 b=NpVUs7XEBIwPrQ+vvewhBtZYaJYy+ZxvMDt9Y5R/aJAaUJP8iiF+GIJO2/5PfH7hl
 u1bIZKWPQy1n+N/7R2BrkFZMV+QnnAVT5HfskZB8lc1dy9BJYOPZyUXj64VFSQO+bS
 raB+SJUmsJKcLBsVjP34p9ejKNDzk8u/QLA3Janc=
Received: from RT-NUC.. ([39.156.73.12])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id A4606087; Tue, 05 Sep 2023 19:41:06 +0800
X-QQ-mid: xmsmtpt1693914066tpr2bsxex
Message-ID: <tencent_A957A85155C40E033B2189AC8CCB3995F607@qq.com>
X-QQ-XMAILINFO: Ms5xyImz3IR/tuh4CegvdptLR21dbvGzpiHlC/R+7zp+hXm4u7t4bVEge5ifAF
 lWIGyH5TAxdqi/UQoOHTDydLioy6DT/EewrxVtREQM07S26StLfYhDaSepQtvDOQ/u9PqVHpHSpr
 pSWYD6DlWIx+6x/YzJcJUgDrjV3hcT0wtXLDIxS5jPf4Lv/lBbKSaSx3ZUmfv2YxEB4l2zVARlwf
 gTNfDLeH8CeOJ78woo1FpjLc6g1xk8qqJBqH/tksVC3zlcYI0/jkFfJPcR5CTZNW/+keLwHw1S8u
 p6XzYbKbxZcjKtguga55iUqRDThWfm9BrVkDnfsr+0uVvojoXdzeXFQJiwUwvj5ni0+J4KfRzoOY
 5lvj8D0O9R/wUqZr7BIkz+c8VzDE0WF/joQF4PeW/Ffd2EHt9UxIDdilvbUuYCf+oCSAn27V9R2E
 LWFMPLKNbbqbe6vjaHyfLFGcKm0x3z33cHm364ZdOGwSdzUbDeeQUuvjQ4s56bMSEvYHD/mFDcSD
 5RxbchSXGFSKGLle1mQo6Vx+bNXKP1FX3WT7HB3Fhu2HzCaFrXlBt/8GGZS5iRKkk1btI/HIpndX
 2v7pdM3wIyN7cb/SYw3lp7PXpWo1Uxm8X1i124cHBBdLyiBja2d6EbKtoroWTqTzRF9EqOIchO8u
 qcrutB3G4NcxHqbfWdynXwP2D6Df/85ghlLkr1+QoiPWYhjt3jKffvcYljC3yJVJcuhFbWkb8Hm0
 tFvbz4M1Rt9I6rLyIYBO4ml9wEZHcwV0WzRzlYnvn+ltRjgT/o+78VqofxM/QcdD9Yabg+7Rg/eX
 B2MoAccrxh2JsKVzCJkXajWy1Lr+nIbmpQNu2Dvc8d1/xBaQZh1ULcy5Z6KP8fLJk84nzEkWp1E0
 OUEwVx2U9HhhyAFpUR+DX3YKi4bdajp+3tXZ54CB1njij03FIeZ7kPlJX++pC1Xw61QdHdWbCpq9
 wuj3DRAiYfTB5nvd+5zi0oau74PgR1+L7zHp2j2pW9+dZsMSIc32cIIUGltGnmRsdKbQoyy60=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Rong Tao <rtoax@foxmail.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de (open list)
Cc: Rong Tao <rongtao@cestc.cn>
Subject: [PATCH v2] binman: Fix SyntaxWarning: invalid escape sequence '\('
Date: Tue,  5 Sep 2023 19:41:04 +0800
X-OQ-MSGID: <20230905114104.480548-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Sep 2023 04:56:11 +0200
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

    $ git clean -dfx
    $ make CROSS_COMPILE="" qemu-x86_64_defconfig
    $ make -j8
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

