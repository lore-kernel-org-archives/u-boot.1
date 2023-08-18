Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54545C001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 05:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74AEE86C1A;
	Fri, 18 Aug 2023 07:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="F2SX8zEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A589686C71; Fri, 18 Aug 2023 07:26:56 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC9186751
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 07:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230818052647epoutp028ef1140d7dae96ce265f587ddcb06ee3~8Yv7uzxy71346713467epoutp02K
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 05:26:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230818052647epoutp028ef1140d7dae96ce265f587ddcb06ee3~8Yv7uzxy71346713467epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692336407;
 bh=Q2mc+fNZV7EzelZ6z6Mlc+2vWAbBiHc8GGlse7uSKjI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F2SX8zEYJfrDkiSitlfl51iWC9X2LzcGVnDyDQKtEGYRGGmOgiC7RmkqUsDw5GOJO
 ey/FQsBZSQ96bf5Fbr/mNvbsPyNMx6UpybIVRsAToGYN23V6sbdaV1aORstzoUOTF3
 jnQ6fBsiJn6OkfPAtmi7jzFXgRmX9hMe+3dC0JSE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230818052646epcas2p29d5b0e039dba1f1f1c2606fae57eb18c~8Yv7eNZHS3181631816epcas2p2-;
 Fri, 18 Aug 2023 05:26:46 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4RRr2t19Mxz4x9Q7; Fri, 18 Aug
 2023 05:26:46 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 5A.AF.32393.6110FD46; Fri, 18 Aug 2023 14:26:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230818052645epcas2p48c419f6e6318ddadb425749319fbc3b8~8Yv6o1oXX1683816838epcas2p4o;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230818052645epsmtrp21af347284ad39b5e232df9f99feeb053~8Yv6oFtOT2268822688epsmtrp2H;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
X-AuditID: b6c32a48-87fff70000007e89-77-64df01164098
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1E.04.30535.5110FD46; Fri, 18 Aug 2023 14:26:45 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230818052645epsmtip1aff42a308ea5b187ba7da9d30eef4127~8Yv6ac9xf1055410554epsmtip1f;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 1/2] dm: event: add EVT_DM_POST_INIT_R event type
Date: Fri, 18 Aug 2023 14:11:02 +0900
Message-Id: <20230818051103.2427590-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818051103.2427590-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTXFeM8X6KQdMLNoupPfEWl/drW7x9
 cZbR4tuWbYwWb/d2sls8PvSayYHNY8/pWcwesxsusnjsnHWX3ePsnR2MHn1bVjEGsEZl22Sk
 JqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaCkUJaYUwoU
 CkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM5o3OBd
 sIOrYtG358wNjOc5uhg5OSQETCTm3DvM3sXIxSEksINRYnb7HxYI5xOjxJsLd6Ay3xglvu84
 CJThAGs51g4V38so8XDnS0YIZxqTxNkvF9hA5rIJ6Epsef6KEaRBRKBc4uEZA5Aws4CXxMwH
 95lBbGEBF4kLf56ygtgsAqoSO3pfg7XyCjhI3N/2iRlil7zE4gcSIGFOAUeJ/0/nsUKUCEqc
 nPmEBWKkvETz1tnMICdICNxil3hz8C4zxGsuElfX7mKCsIUlXh3fwg5hS0l8freXDWJ+ucSO
 ZUkQvS2MEs1te6B67SV+3JzCClLDLKApsX6XPkS5ssSRW1Br+SQ6Dv9lhwjzSnS0CUE0qksc
 2D6dBcKWleie85kVwvaQeN7QADZcSGAKo8T5JrcJjAqzkDwzC8kzsxD2LmBkXsUollpQnJue
 WmxUYAKP3OT83E2M4LSo5bGDcfbbD3qHGJk4GA8xSnAwK4nwWjDdSxHiTUmsrEotyo8vKs1J
 LT7EaAoM6YnMUqLJ+cDEnFcSb2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8T
 B6dUA5NDfqO2o56RT13R3r1NIWVnrZ18Hgfl6f+4c75t5qOb4YuqW0/krJ3oVMif4rfc+82y
 n+miWW8+lXz7rsLyrD98rmPFyqf3ls7v+7ho460Hi8/usr+ala03O+OmT8dU58W7vmnbfPl7
 PK3ma7BttJfkJefgALnXbNu4OhkFE6e/U/VuWHU45bOkMuPiwJ0lktN77jruT14ceFJkekfE
 l6XxXktfrlC0Oex0XStK77SX9TcrHu/qe9Ha75Vvn1W+XP3H/Xjb2klHa35JLhPY5cUozfDH
 1+3XpnlO27teMDxd/mvPgetSbx7azZLj2vOR29O2ZmrtQpuLDy57ciz9cXbVrulF9b5Xwkru
 Ck32DZFRYinOSDTUYi4qTgQAynaE1xQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnK4o4/0Ug289ehZTe+ItLu/Xtnj7
 4iyjxbct2xgt3u7tZLd4fOg1kwObx57Ts5g9ZjdcZPHYOesuu8fZOzsYPfq2rGIMYI3isklJ
 zcksSy3St0vgymjc4F2wg6ti0bfnzA2M5zm6GDk4JARMJI61s3cxcnEICexmlFj26SlzFyMn
 UFxW4tm7HewQtrDE/ZYjrBBFk5gkfh35wwaSYBPQldjy/BUjiC0iUC3x6+sisDizgI9EZ3s7
 WLOwgIvEhT9PWUFsFgFViR29r8FqeAUcJO5v+8QMcYS8xOIHEiBhTgFHif9P54GVCwGVbF12
 lx2iXFDi5MwnLBDj5SWat85mnsAoMAtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV5
 6XrJ+bmbGMFBrKW1g3HPqg96hxiZOBgPMUpwMCuJ8Fow3UsR4k1JrKxKLcqPLyrNSS0+xCjN
 waIkzvvtdW+KkEB6YklqdmpqQWoRTJaJg1Oqgcne947rr3M7dG6W2Tn5Rrhu66s7r7+unod7
 t/nJGO1JP4PeqNxY4V3zcee5skCmmG05B1425/da6Vxs6L03U321mUDC7ZdTZ4svyFv9WmvK
 xT2nzdXL1AuNpczfMbxnX9OprTnxLFPwOxbOzed5n7/99Srpxwy1vuU7FKVfznSSP5DX/Or+
 VAf9xU87rrzrucpq2fdH4LHtf8FTWXWfzE9aFORd67t7SPhJWecbU7YNRxSqjzaXz81zOb+E
 fXVcKm/JmusvcoxyGOObbBgXPp4jynGMf9rEvonpOws/sdiW8YYFSmhq5rQbtgmUXuZdZM0c
 4Zo11WBuzab2qVxBhd5fZx5rt2I1OiFiq+uvqcRSnJFoqMVcVJwIAGFrNvPRAgAA
X-CMS-MailID: 20230818052645epcas2p48c419f6e6318ddadb425749319fbc3b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230818052645epcas2p48c419f6e6318ddadb425749319fbc3b8
References: <20230818051103.2427590-1-chanho61.park@samsung.com>
 <CGME20230818052645epcas2p48c419f6e6318ddadb425749319fbc3b8@epcas2p4.samsung.com>
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

This patch introduces EVT_DM_POST_INIT_R event type for handling hooks
after relocation.

Fixes: 55171aedda88 ("dm: Emit the arch_cpu_init_dm() even only before relocation")
Suggested-by: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/core/root.c | 6 ++++--
 include/event.h     | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/core/root.c b/drivers/core/root.c
index 6775fb0b6575..79d871ab291a 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -436,8 +436,10 @@ int dm_init_and_scan(bool pre_reloc_only)
 			return ret;
 		}
 	}
-	if (CONFIG_IS_ENABLED(DM_EVENT) && !(gd->flags & GD_FLG_RELOC)) {
-		ret = event_notify_null(EVT_DM_POST_INIT_F);
+	if (CONFIG_IS_ENABLED(DM_EVENT)) {
+		ret = event_notify_null(gd->flags & GD_FLG_RELOC ?
+					EVT_DM_POST_INIT_R :
+					EVT_DM_POST_INIT_F);
 		if (ret)
 			return log_msg_ret("ev", ret);
 	}
diff --git a/include/event.h b/include/event.h
index daf44bf8a83b..bb38ba98e73b 100644
--- a/include/event.h
+++ b/include/event.h
@@ -24,6 +24,7 @@ enum event_t {
 
 	/* Events related to driver model */
 	EVT_DM_POST_INIT_F,
+	EVT_DM_POST_INIT_R,
 	EVT_DM_PRE_PROBE,
 	EVT_DM_POST_PROBE,
 	EVT_DM_PRE_REMOVE,
-- 
2.39.2

