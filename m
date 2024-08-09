Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82A2C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B89B88BD2;
	Fri,  9 Aug 2024 10:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="yG75o0bL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A070388B81; Fri,  9 Aug 2024 10:59:27 +0200 (CEST)
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com
 [203.205.221.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE24088BD6
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723193951; bh=UfTkpjJm36B9+GCOAf4W4/UZZNDIZWzZqVaecb9Z7N4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=yG75o0bLPmBB4g1tktMVkCW6smDdYzFty+ehLmU379OHctB8c+bmAhiwBZaEn/DOo
 UVLXouGAX8adbPDMwoe1fjtceICsbh0ds3E45egoMnxWuVjTlTIY8B8fQq29MzhM5p
 0F5iThFywqfIpn9mTfpcH5FUpPn57NqEy6duCYGc=
Received: from hyz-wsl.www.tendawifi.com ([166.111.226.87])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EA28703C; Fri, 09 Aug 2024 16:58:34 +0800
X-QQ-mid: xmsmtpt1723193946te5yxbz38
Message-ID: <tencent_F5D66CB6FD5795B8716800C4193F7FB15B0A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9grKQS6pLre/OSXS7B4Ky6CVUU8u02tNgeTUlTxzwk2QC597lN4
 Qs6+Es4RrcgbAlyLKfuf7ELC+4oY5nJ2x2EY8QeA1vBuv8EVHe3ReqzDqq6RUD2F8HDjRMScDk3s
 XRJXUscamvr90knXfm7UJlJstVFevSPm3LoNB8K1jkoFXWtV2Hh8r5x2iazXUVkpifX82JgsczXm
 bL6DXYsHz8IyBEVDIuKRLNIDEPOjAFUNUdLw/8MmOL2UPma39qzzHK18MxJka1OLwWTOO0+2rmaT
 dcChM7lnAyc+Y7u7S7GAltyvM44p1h5PHYsVkR1WE0AnSzSPtG7eixGjrY9KxwDKw/HHeNZA8AOa
 jBHevMXsQc248vkBqZelTt6M31WXdrPXISxdvCCHmi4nf80kgrVOpEWwZyfE1OV33AoqJMLI10IL
 9oU6DVLTNqkKDv/2kmh6mfSTzOfq+cxezokso11mcLICRXeDEM6B5xcyW6tomXUEdu/MmF8gwBPY
 +E1gczG4LrrNYYSFDdJmsCSDcppV4fm1iwaMfvRReOhDezBgMeuxh7vt/pIa70gIqAcbKQxnGqet
 Udk8jqOmcRvuNpW4bgHiiObKNCcWJjWf7PjLS7BILtIo9+YVJKfEzr2ounZ+nI5ZM9XnpfkcQybK
 /GOLKW/VI2KbfB5ry7lpu+1SAUMcW7uUCB211Lf/RrE6eYM+0WIpxt3TkI3xKBaaWSGMA1bEoddq
 ae8RHJFaThueWQkwVQVsuE3Kc/uUA/jSB2wB/gzOqyIK6HPf4MheLJ99BVDWjSitSxPjqF0E4ort
 7+fOtpvSxdZgIbmFJxU0js64d9F49k5QGkdi2hc8sq4XlRm32jB1K1MwcjqqyzAg4w/l8ywdGwvA
 6MM08pvPlMdmSfD/iMBHsM74a16Z/knl/oy7gDNxnNiv7NFSU8XQ5TcO7/I3JspxPFw+9B7uZLSE
 f4rBQt+9GNNnuB34JxjgzpB1bkZKnDlV5A887Yb1lZcrdQfpkfvP7zRC8b97pZ1WGHRoWaev18EV
 q+KtOUXxb60KmUyVwQ
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 8/8] net: dc2114x: remove the pass all multicast flag in
 operation mode settings
Date: Fri,  9 Aug 2024 16:57:01 +0800
X-OQ-MSGID: <20240809085701.22183-8-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809085701.22183-1-hanyuan-z@qq.com>
References: <20240809085701.22183-1-hanyuan-z@qq.com>
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

Remove the OMR_PM flag and choose 16 perfect filtering mode since in
modern networks there're plenty of multicasts and set ORM_PM flag will
increase the dc2114x's workload and ask the U-Boot to handle packets
not related to itself. And most of the time, U-Boot does not need this
feature.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/net/dc2114x.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 11dea9b4d7..e1edda8e19 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -437,7 +437,16 @@ static int dc21x4x_init_common(struct dc2114x_priv *priv)
 		return -1;
 	}
 
-	dc2114x_outl(priv, OMR_SDP | OMR_PS | OMR_PM, DE4X5_OMR);
+	/* 2024-07:
+	 * Remove the OMR_PM flag and choose 16 perfect filtering mode since in
+	 * modern networks there're plenty of multicasts and set ORM_PM flag will
+	 * increase the dc2114x's workload and ask the U-Boot to handle packets
+	 * not related to itself. And most of the time, U-Boot does not need this
+	 * feature.
+	 *
+	 * A better way: let user to decide whether to have this flag.
+	 */
+	dc2114x_outl(priv, OMR_SDP | OMR_PS, DE4X5_OMR);
 
 	for (i = 0; i < NUM_RX_DESC; i++) {
 		priv->rx_ring[i].status = cpu_to_le32(R_OWN);
-- 
2.39.2

