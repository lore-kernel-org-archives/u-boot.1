Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D27C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 07:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F56387559;
	Wed,  1 Nov 2023 08:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="pIWn/BqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E25858761C; Wed,  1 Nov 2023 08:23:27 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459D986D62
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 08:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101072320epoutp046069ba3820cecd78c39e8fae585d3eef~TbuHBS8Dd1370913709epoutp04Z
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 07:23:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101072320epoutp046069ba3820cecd78c39e8fae585d3eef~TbuHBS8Dd1370913709epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698823400;
 bh=jzk6yJtiVmmNptVidb/sDkJlKsb6ouUdsntnSBG9kjc=;
 h=From:To:Cc:Subject:Date:References:From;
 b=pIWn/BqZkwjSrFs4V2CWr5FiaIk7oay1i0/tQ0A5zIO0tOrRetifZCRc70f05cgrC
 70HdLy3F+3Euwexa4IN3yUmGo4wCCUgeFWYBmmFZRTi4Veg3HEOwwAkkK/N3/OsP+E
 2N1446SbqpoJbyH9tRRL+ZFrwMytd3TfkAimp6vo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231101072319epcas1p4ca763d8dc62f841ab71d2781cb0a35a5~TbuGl8WNt1463914639epcas1p4X;
 Wed,  1 Nov 2023 07:23:19 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.237]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKz4k6bLXz4x9Q2; Wed,  1 Nov
 2023 07:23:18 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 86.AD.10211.6ECF1456; Wed,  1 Nov 2023 16:23:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20231101072318epcas1p2dbf8d1c1bbbb521c8e6744fae8e0b01d~TbuFQ9X0I0461304613epcas1p2T;
 Wed,  1 Nov 2023 07:23:18 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101072318epsmtrp24f981f5ba37f4690cd622bfe9addf85a~TbuFQT6bz0134301343epsmtrp2S;
 Wed,  1 Nov 2023 07:23:18 +0000 (GMT)
X-AuditID: b6c32a38-6d3fd700000027e3-2b-6541fce6b873
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 F8.B3.18939.6ECF1456; Wed,  1 Nov 2023 16:23:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101072318epsmtip1f13b6b45b728bdffa3094bd6de5fb008~TbuFADH4K0801008010epsmtip18;
 Wed,  1 Nov 2023 07:23:18 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, patrice.chotard@foss.st.com,
 eugen.hristev@collabora.com, trini@konsulko.com, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: [PATCH] power: regulator: Fix an handling error about EALREADY
Date: Wed,  1 Nov 2023 16:23:16 +0900
Message-Id: <20231101072316.190541-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTT/fZH8dUgw/rTSxaF91mtLjxq43V
 4ufJ9+wW37ZsY7SYOmkzu8XbvZ3sDmwesxsusnjsuLuE0eNp/1Z2j1cHVrF7nL2zg9Gjb8sq
 xgC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKA7
 lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFpgV6xYm5xaV56Xp5qSVWhgYGRqZA
 hQnZGS83P2UsOMpW8fmSTAPjDtYuRk4OCQETid93fwLZXBxCAjsYJbafecgEkhAS+MQoMemA
 A0QCyO7cPJ8ZpqPt0152iMRORomjx94wQThfGCWmPvnOCFLFJqAjsf3bcbBRIgISEr/6rzKC
 FDEL9DFKtK36B5YQFnCXaHkEMoqTg0VAVeLDthlgcV4BG4klPx8yQqyTl5h56Ts7RFxQ4uTM
 JywgNjNQvHnrbGaQoRIC59glHt7vY4FocJF4Mucw1K3CEq+Ob2GHsKUkPr/bywbR0MwosXTJ
 QVYIp4dR4l/DdTaIKmOJ/UsnA53BAbRCU2L9Ln2IsKLEzt9zGSE280m8+9rDClIiIcAr0dEm
 BFGiInHp9UsmmF13n/yHhrCHxIr3e5lByoUEYiVuzbeYwCg/C8k7s5C8Mwth7wJG5lWMYqkF
 xbnpqcWGBSbwWE3Oz93ECE6LWhY7GOe+/aB3iJGJg/EQowQHs5II72FTh1Qh3pTEyqrUovz4
 otKc1OJDjKbAAJ7ILCWanA9MzHkl8YYmlgYmZkbGJhaGZoZK4rzHXvWmCAmkJ5akZqemFqQW
 wfQxcXBKNTBJPApf+1S7nvl0T12Dw0Melf86NuEntc6kOR6Od9eQrYo3W6Sw94TNrm/MYcJT
 5s6d8/pLvWP0J9eWtrfdxt+tf+2dsj+S69ld/rtTwv/MPfN5T0++xc4zuhP450xtkv+aW1Fn
 dHbLngn733sw+Og0f3u+sn79lbNzXazC30/Z99/l1JWz9hov3lrU/2X+zJ/i63Z99gqb5b4z
 RBMnC/2q+7Zk7ovGphLZhF1Rn0Wf9BnF5CjITrePKLj8V/fOim0vg048zRR0MzF3yTWp6t9o
 sHH/zPakGSu5GW9H5fsuU1kp8lN6xmGN0ETZVakaVT0tCn/3KcxNe7z+Htebo99P8zss/n19
 A9/GmTbPkwIzlViKMxINtZiLihMBmoGAfhQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSnO6zP46pBi96xS1aF91mtLjxq43V
 4ufJ9+wW37ZsY7SYOmkzu8XbvZ3sDmwesxsusnjsuLuE0eNp/1Z2j1cHVrF7nL2zg9Gjb8sq
 xgC2KC6blNSczLLUIn27BK6Ml5ufMhYcZav4fEmmgXEHaxcjJ4eEgIlE26e97F2MXBxCAtsZ
 JT78/cMEkZCS+Px0KlsXIweQLSxx+HAxRM0nRokN00+ygNSwCehIbP92HKxeREBC4lf/VUaQ
 ImaBSYwSK7b9ZwRJCAu4S7Q8AtnAycEioCrxYdsMsAZeARuJJT8fMkIsk5eYeek7O0RcUOLk
 zCdgC5iB4s1bZzNPYOSbhSQ1C0lqASPTKkbR1ILi3PTc5AJDveLE3OLSvHS95PzcTYzg8NQK
 2sG4bP1fvUOMTByMhxglOJiVRHgPmzqkCvGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJI
 TyxJzU5NLUgtgskycXBKNTB1bblQYtRksL3Z+Z9l6ZW786fY2O4N/+rDN3/1tuNLu9UfTeSq
 vry664J5BdfZ1jAdnrVOcQ9rv77LYLwj8UPuAP/3ELd8N75PwVaGS2qzXZrcZs7refKz98Oq
 H/XT+8xrDzd4LbzyJ/9T8627a6+Zx8zX//1xI0ub2osn5ZNFRFbdEmq+NOHtZvl9nH95q1mN
 Jt/0Xawl+9j6cWe3+weF6X6/gjXfTun+b/UoVC7Cdc9G0ZBzIWmz1ZeuenHD+WjSumXqAUrG
 pznmNNy42X69gLer4mDtu9UK2Y0pDx6GhDkFLlh5jPnyP/45rQ4tOkJ+0zee14xZwWPNmFB5
 Zu7i1yfWnL9acvl67Ppp+h9eKbEUZyQaajEXFScCAIswWNS+AgAA
X-CMS-MailID: 20231101072318epcas1p2dbf8d1c1bbbb521c8e6744fae8e0b01d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101072318epcas1p2dbf8d1c1bbbb521c8e6744fae8e0b01d
References: <CGME20231101072318epcas1p2dbf8d1c1bbbb521c8e6744fae8e0b01d@epcas1p2.samsung.com>
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

If reegulator is already enabled, it will be return to EALREADY.
But driver that its function is called can notice as error, even though
it's working fine.

Fixes: 4fcba5d556b ("regulator: implement basic reference counter")

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/power/regulator/regulator-uclass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 3a6ba69f6d5f..fc1c3eb93c9d 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -187,6 +187,10 @@ int regulator_set_enable(struct udevice *dev, bool enable)
 		}
 	}
 
+	/* Regulator is already enabled */
+	if (ret == -EALREADY)
+		return 0;
+
 	return ret;
 }
 
-- 
2.25.1

