Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11201C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA9487641;
	Wed,  1 Nov 2023 12:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="idnxNvbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1C987641; Wed,  1 Nov 2023 12:04:21 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806D8875A8
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231101110412epoutp03f39d3e5a585719cea6b648cb2d48dca9~Teu9bwSGY2700427004epoutp03G
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:04:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231101110412epoutp03f39d3e5a585719cea6b648cb2d48dca9~Teu9bwSGY2700427004epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698836652;
 bh=i7BcMMFN3knZWC5bd9aBv81sIRW80rsC/DxpBkBuXeo=;
 h=From:To:Cc:Subject:Date:References:From;
 b=idnxNvbXKA0vfCWh1/MTn2Hsx5/qjkcHTwFX2NBIaZWcw59m38BvKpbpun6todK3z
 q69ES/helJtOtwdiE05jx31hPBV2A3tvlgxDhj8wzCMtZsGyCBNua59Mumg3XlQNNw
 s+jy2tlkSo043k93lypneZMVNqce4POBMai6IdWY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231101110412epcas1p2cba4b92cd545c2ed643c180dea6383bf~Teu8_8xvg0945009450epcas1p2L;
 Wed,  1 Nov 2023 11:04:12 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.232]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SL3zb3yMQz4x9Pq; Wed,  1 Nov
 2023 11:04:11 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 35.DA.09739.BA032456; Wed,  1 Nov 2023 20:04:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231101110411epcas1p13348bdc968aeae008244c48b6a67efd0~Teu71Nfbk0335303353epcas1p1r;
 Wed,  1 Nov 2023 11:04:11 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101110411epsmtrp1206bf0caea50b3d7be5d0b78638b64cf~Teu7z0_ON0757007570epsmtrp1n;
 Wed,  1 Nov 2023 11:04:11 +0000 (GMT)
X-AuditID: b6c32a37-c0bff7000000260b-c2-654230ab4fcd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 72.84.07368.BA032456; Wed,  1 Nov 2023 20:04:11 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101110410epsmtip1df006306ec3b22d8be2d68648396560a~Teu7nt5rB3073430734epsmtip1n;
 Wed,  1 Nov 2023 11:04:10 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, patrice.chotard@foss.st.com,
 eugen.hristev@collabora.com, trini@konsulko.com, neil.armstrong@linaro.org,
 jonas@kwiboo.se, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] usb: dwc3-meson-g12a: Use regulator_set_enable_if_allowed
Date: Wed,  1 Nov 2023 20:04:09 +0900
Message-Id: <20231101110409.212536-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmvu5qA6dUg/5eWYvWRbcZLW78amO1
 OPnmKovF+523GC1+nnzPbvFtyzZGi6mTNrNbvN3bye7A4TG74SKLx467Sxg9nvZvZfd4dWAV
 u8eJCZeYPO5c28PmcfbODkaPvi2rGAM4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
 DS0tzJUU8hJzU22VXHwCdN0yc4BuU1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
 mBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ6y4PpuxYA5XxcuTTcwNjGc4uhg5OSQETCTuvj3C
 2MXIxSEksINR4t3ONmYI5xOjxLPHG1kgnG+MEntunWCDaVm+oZEdIrGXUWL18YNQzhdGiWn3
 m8Gq2AR0JLZ/O84EYosISEj86r8KtoRZYBejxK6jrUAOB4ewgJfEhmcsIDUsAqoSS5fdZwex
 eQVsJA5/aWCH2CYvMfPSd6i4oMTJmU/A6pmB4s1bZ4PdKiHwkV1iUddvRogGF4mVa75BnSos
 8er4FqhBUhIv+9vYIRqaGSWWLjnICuH0MEr8a7gO1WEssX/pZCaQ65gFNCXW79KHCCtK7Pw9
 lxFiM5/Eu689rCAlEgK8Eh1tQhAlKhKXXr9kgtl198l/VgjbQ6L963M2kHIhgViJv138Exjl
 ZyF5ZxaSd2Yh7F3AyLyKUSy1oDg3PbXYsMAYHq3J+bmbGMEJVMt8B+O0tx/0DjEycTAeYpTg
 YFYS4T1s6pAqxJuSWFmVWpQfX1Sak1p8iNEUGMATmaVEk/OBKTyvJN7QxNLAxMzI2MTC0MxQ
 SZz31rPeFCGB9MSS1OzU1ILUIpg+Jg5OqQamLhmfNV98pkQ4/2+3Sp+YwHhw+lpfpx3sn5Xr
 ou6c2LL994XfKnndvvVRj7sSHt7v52KNurxSLTP5QsyMLze+eKU07ynzmMrxMmfBwU7fbq/1
 xpMzJ3DlsG/fryLio5BVtU6P4fLFzxs/TF50OFXNsPz0uZURvfOFm2clLL1exH5QZIH2M6VE
 Pk2F7CVPpaLW8i06u215u0+31HNRncocG+cCdeXqVdtFPjqwPqzY+c7K93/e3hulE6zC9fhD
 M1h4g1v+zI2WNPjydc3068ZXy9zMfQysXxR5SD2pzgs6KHD6Fn/Geq/cems5r1eef3fV7Ut8
 yR4/rcH1yNSv8i7/vi42CLmfoOOg+3H/LDYlluKMREMt5qLiRAAnordDKQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnO5qA6dUgydH2S1aF91mtLjxq43V
 4uSbqywW73feYrT4efI9u8W3LdsYLaZO2sxu8XZvJ7sDh8fshossHjvuLmH0eNq/ld3j1YFV
 7B4nJlxi8rhzbQ+bx9k7Oxg9+rasYgzgiOKySUnNySxLLdK3S+DKWHF9NmPBHK6KlyebmBsY
 z3B0MXJySAiYSCzf0MjexcjFISSwm1FifdNJJoiElMTnp1PZuhg5gGxhicOHi0HCQgKfGCVm
 dpeD2GwCOhLbvx0HKxcRkJD41X+VEWQOs8AhRom2vmvMIL3CAl4SG56xgNSwCKhKLF12nx3E
 5hWwkTj8pYEdYpW8xMxL36HighInZz4Bq2cGijdvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nz
 kw0LDPNSy/WKE3OLS/PS9ZLzczcxgoNZS2MH4735//QOMTJxMALdxsGsJMJ72NQhVYg3JbGy
 KrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZJg5OqQYm9dolm9etyDDZVl54
 gCPYvSq73aenLChwibTBH5a5CYtOhN3ruL3r17RTzOXC4h9nKTdv+3Hq+9e87k3HtU+XfV3P
 ZB13/qjtrduzLfuSpq8pTVh66MkEy9OrFhe+sqrc9kwx07vb0/KkfdjT81zfVuv/r12fuFl9
 F6+yOMcRgw+pi45GMdqsWba/cJYTo8CkdEm15JyXd2eKGJ3crpJTa2MidqB60r3Vv+aJPJ77
 1vg3e2RMzDzOW+/Fn/Mt/NP9IH25l52hamxDbCbLjVkBESu8fD/kz/PgE5lZcb79zHW7R2KS
 ovPqd+reyWd/sPuE7ZnS9kXH4qtdzNh3S9VJ+8mqF8YfCpwqmLvnQvdqJZbijERDLeai4kQA
 XLTa/9UCAAA=
X-CMS-MailID: 20231101110411epcas1p13348bdc968aeae008244c48b6a67efd0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101110411epcas1p13348bdc968aeae008244c48b6a67efd0
References: <CGME20231101110411epcas1p13348bdc968aeae008244c48b6a67efd0@epcas1p1.samsung.com>
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

Some meson targets are using a fixed regulator about usb.
It's always returning to EARLEADY, so driver doesn't init fine.
To prevent this problem, use the regulator_set_enable_if_allowed
instead of regulator_set_enable.

Fixes: 4fcba5d556b ("regulator: implement basic reference counter")

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index e0356e653fcc..59276483c19d 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -291,7 +291,7 @@ int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->vbus_supply) {
-		int ret = regulator_set_enable(priv->vbus_supply,
+		int ret = regulator_set_enable_if_allowed(priv->vbus_supply,
 					(mode == USB_DR_MODE_PERIPHERAL));
 		if (ret)
 			return ret;
@@ -420,7 +420,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 	}
 
 	if (priv->vbus_supply) {
-		ret = regulator_set_enable(priv->vbus_supply, true);
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply, true);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1

