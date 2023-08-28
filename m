Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0D5C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 09:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03FC986496;
	Mon, 28 Aug 2023 11:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="TsZEQ/Gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC9008645F; Mon, 28 Aug 2023 11:46:37 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C62386496
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230828094630epoutp04aa92ac8d45a1d3b1c74cfddb1e8cbb26~-gvjR-8NV1896918969epoutp04N
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:46:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230828094630epoutp04aa92ac8d45a1d3b1c74cfddb1e8cbb26~-gvjR-8NV1896918969epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693215990;
 bh=7Wb4CElK5k5LEFzMTTm07MufK2d6p1uP00Moo0OaZyU=;
 h=From:To:Cc:Subject:Date:References:From;
 b=TsZEQ/Gnj43jtPSyiSVFlZ5OtSK0L70Hy+in6UnJU2iTtI+PThOUs8Dd2gh8gVDD7
 Nm7euyKKlc+RQhk6mqisoxICq1RQOmAV3x1NT74sJCljni0H6bFceWnh4E9P8KzmA6
 b56A6bSgRgvXgOcgeNlKEvPwquiwEtUBT2wGA3JE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230828094629epcas2p2a21d24ce40426b9e1b689302030bb61d~-gvi85T983231732317epcas2p2N;
 Mon, 28 Aug 2023 09:46:29 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.100]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4RZ5Kw6sRfz4x9Q7; Mon, 28 Aug
 2023 09:46:28 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 E8.C7.09693.4FC6CE46; Mon, 28 Aug 2023 18:46:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230828094628epcas2p39068c0277081701446115fec7584ab54~-gvh_MFZU3167731677epcas2p3v;
 Mon, 28 Aug 2023 09:46:28 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230828094628epsmtrp1033bdbae457291248639744133302b58~-gvh9pqBM1869318693epsmtrp1D;
 Mon, 28 Aug 2023 09:46:28 +0000 (GMT)
X-AuditID: b6c32a45-84fff700000025dd-87-64ec6cf4142d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 CB.F3.18916.4FC6CE46; Mon, 28 Aug 2023 18:46:28 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230828094628epsmtip1fb919b34933371846084980172880bd9~-gvhwQwCS2252822528epsmtip1K;
 Mon, 28 Aug 2023 09:46:28 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, Marek
 Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] spl: bootstage: move bootstage_stash before jumping to image
Date: Mon, 28 Aug 2023 18:46:17 +0900
Message-Id: <20230828094617.2060025-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmqe6XnDcpBhMvm1tc3q9t8aatkdGi
 //9zJotvW7YxWrzd28nuwOoxu+Eii8e8WSdYPM7e2cHo0bdlFaPH8RvbmQJYo7JtMlITU1KL
 FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
 lfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyMw4dvcha0MpT
 sahzH1sD4w/OLkZODgkBE4nZv1YzdjFycQgJ7GCUuH/5AjOE84lRYuu9/axwTkvHNPYuRg6w
 lt0HoIp2MkrcXjeFBcKZxiTRfPoFE8hcNgFdiS3PXzGCNIgIlEss3mUDEmYW0Jbo/DwFbI6w
 gL/EwkY3kDCLgKrEv90nWEBsXgEHift7/kOtkpdY/EACIiwocXLmExaIKfISzVtng50gIbCL
 XWLejWYmiG9cJPacP88OYQtLvDq+BcqWknjZ3wY1s1xix7IkiN4WRonmtj3MEDX2Ej9uTmEF
 qWEW0JRYv0sfolxZ4sgtqLV8Eh2H/0JN4ZXoaBOCaFSXOLB9OguELSvRPeczK0SJh8T74+Yg
 YSGBWImp124wTWCUn4Xkl1lIfpmFsHYBI/MqRrHUguLc9NRiowJDeHwm5+duYgQnPS3XHYyT
 337QO8TIxMF4iFGCg1lJhPeS46sUId6UxMqq1KL8+KLSnNTiQ4ymwMCdyCwlmpwPTLt5JfGG
 JpYGJmZmhuZGpgbmSuK891rnpggJpCeWpGanphakFsH0MXFwSjUwSb+q8/W+/GO7yqkJbZ6n
 z4dw7/TZV5sdtyn277Vlk3lz/k/8Y6ZYoWWxbpJH3uKuZq77xn+lTkfrnGk7uvvQNru2D85c
 /Wkmu3UZLt5s2bE1bPaX9Eoxy82LJwqJ7Smbs8ztsmebQ0L3mcPRNVrZlzbq/G61rXB8XCiv
 8yBuyyeZZNXLtxaY76yPW/5r78SdWyLP2O1qNJth1X7Dr17o7zzv+7XyNxlY3hzn+ldYtE+F
 T1fimfONUCWtG2FLKiq2Hc3PiTiw0uU249Oo2LIvJQZe5tNXT3kt9Wfjf6GFky42n2W2D5GY
 eTylS97wfRL7pmnnimbZponWrKlb652UODtVPpBd1TDwwRXVg8qPlViKMxINtZiLihMBkwr7
 vgMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSnO6XnDcpBof6lS0u79e2eNPWyGjR
 //85k8W3LdsYLd7u7WR3YPWY3XCRxWPerBMsHmfv7GD06NuyitHj+I3tTAGsUVw2Kak5mWWp
 Rfp2CVwZh45eZC1o5alY1LmPrYHxB2cXIweHhICJxO4DzF2MXBxCAtsZJT7cnsXUxcgJFJeV
 ePZuBzuELSxxv+UIK4gtJDCJSeLeARkQm01AV2LL81eMIHNEBKolzuxRBwkzC2hLdH6eAtYq
 LOArce/JSzCbRUBV4t/uEywgNq+Ag8T9Pf/ZIU6Ql1j8QAIiLChxcuYTFogx8hLNW2czT2Dk
 m4UkNQtJagEj0ypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4BDUCtrBuGz9X71DjEwcjIcY
 JTiYlUR4Lzm+ShHiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLg
 lGpg6i+Q7yu7K5KXMUNRjklg8mEe9ZnORxsmrSpelrKqdpK+U5GUw1Wl3cJxEZH1y26fiE54
 wDPdVdYnXOkM+8pm/9dzzz0Unqlt4VkoZeLnu0uw/KpUSfXkJZVGj/7E+6d1nps44WZ41Nqv
 8w+5yIkemi31SfM337JoPfmP6okyt6/EJPqWMUTUBD2ymKTRI38lpqJ1io+j0ot1uT6fDjR4
 PK6/bTnpZA1juN7Ww+mpFybNyA9Zk8o8vT5WxfZUypy5rgwl+5IKL+7wZ4ht8qn22vVsueus
 aSv0kp473agQ04qZ82pmzksrxY4DN8I8fP1OWR8+z/qmZtmy48fDJkXV/2uM4re2+WM+36Hq
 VL4SS3FGoqEWc1FxIgCY+FKvsAIAAA==
X-CMS-MailID: 20230828094628epcas2p39068c0277081701446115fec7584ab54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094628epcas2p39068c0277081701446115fec7584ab54
References: <CGME20230828094628epcas2p39068c0277081701446115fec7584ab54@epcas2p3.samsung.com>
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

For IH_OS_OPENSBI and IH_OS_LINUX, there is no chance to stash
bootstare record because it will not return after jumping to the image.
Hence, this patch moves the location of bootstage_stash before jumping
to image.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 common/spl/spl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 0062f3f45d9a..364d439f65e2 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -850,6 +850,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			       ret);
 	}
 
+	bootstage_mark_name(get_bootstage_id(false), "end phase");
+#ifdef CONFIG_BOOTSTAGE_STASH
+	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
+			      CONFIG_BOOTSTAGE_STASH_SIZE);
+	if (ret)
+		debug("Failed to stash bootstage: err=%d\n", ret);
+#endif
+
 	switch (spl_image.os) {
 	case IH_OS_U_BOOT:
 		debug("Jumping to %s...\n", spl_phase_name(spl_next_phase()));
@@ -890,13 +898,6 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
 	      gd->malloc_ptr / 1024);
 #endif
-	bootstage_mark_name(get_bootstage_id(false), "end phase");
-#ifdef CONFIG_BOOTSTAGE_STASH
-	ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
-			      CONFIG_BOOTSTAGE_STASH_SIZE);
-	if (ret)
-		debug("Failed to stash bootstage: err=%d\n", ret);
-#endif
 
 	if (IS_ENABLED(CONFIG_SPL_VIDEO_REMOVE)) {
 		struct udevice *dev;
-- 
2.39.2

