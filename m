Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3994EC4167D
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 07:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A12B879D9;
	Mon, 30 Oct 2023 08:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="twcc5Rlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E14879F1; Mon, 30 Oct 2023 08:32:38 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8995D879DE
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231030073230epoutp01afb0c1a28bc3e67f8271b9532f96974a~S0jjPDJBB2079120791epoutp01l
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 07:32:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231030073230epoutp01afb0c1a28bc3e67f8271b9532f96974a~S0jjPDJBB2079120791epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698651150;
 bh=Oh2UtrU7DRmsJziSyin0/+2lQoJgzhCNQwFDUucV1c4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=twcc5RloeHY5mok2COOSgljOyb3Ylj9WYnHEGumQGqSYQ9506PU/YNaC5glEFtYUL
 YR8iegczVR5ogVI3Uf/ELgoYhTDPLf1yruODLD4e6Dk26YZEvttJcwMWOtegZxK8mX
 d6tm/WRBc85rHkbKipJUbulFBt1pTFJyA4GgLGqQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231030073230epcas2p1ef04ca70e007b73c0ab8263411f73729~S0jiqogks2104721047epcas2p1r;
 Mon, 30 Oct 2023 07:32:30 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SJlNF6qdPz4x9QG; Mon, 30 Oct
 2023 07:32:29 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 D5.C7.10022.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epcas2p4715faac2f35894c88d50e4293a13148e~S0jh-XfSt2578825788epcas2p4p;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231030073229epsmtrp24a2c8374ab8c745cce2df8df4d76d5ca~S0jh_0HM02856128561epsmtrp2r;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-33-653f5c0d9a8b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 94.A0.18939.D0C5F356; Mon, 30 Oct 2023 16:32:29 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073229epsmtip1f71b611ca0116bc2005f54a1969b42e8~S0jht4Zjq1001810018epsmtip1b;
 Mon, 30 Oct 2023 07:32:29 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 4/5] riscv: dts: jh7110: Add rng device tree node
Date: Mon, 30 Oct 2023 16:32:03 +0900
Message-Id: <20231030073204.150030-5-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030073204.150030-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTVJc3xj7V4O8mc4vL+7Ut3r44y2hx
 75qcxdu9newWh6d+YLR4fOg1kwObx57Ts5g9PnyM87hzbQ+bx9k7Oxg9+rasYgxgjcq2yUhN
 TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
 SCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzjh+sZm9
 4D1bxbtdF9gaGI+zdjFyckgImEisaN/P1MXIxSEksINR4szrqYwQzidGiQln7jHBOYtWtDPD
 tNz628AMkdjJKDFxwR2olmlMEpO3/GABqWIT0JXY8vwVWEJEYDWjxLb9zewgCWYBbYnOz1PA
 bGEBR4m/s0F2cHKwCKhKvPr8EWwFr4C9xKOpvUAXcgCtk5dY/EACJMwp4CCxZMp/JogSQYmT
 M5+wQIyUl2jeOhvsIgmBW+wSGw5NhTrVRaK/fx4LhC0s8er4FnYIW0ri87u9bBDzyyV2LEuC
 6G1hlGhu2wPVay/x4+YUsBuYBTQl1u/ShyhXljhyC2otn0TH4b/sEGFeiY42IYhGdYkD26dD
 LZWV6J7zGRrUHhLrv8+HBtVkRom7azcwTmBUmIXkm1lIvpmFsHgBI/MqRrHUguLc9NRiowJj
 eAwn5+duYgSnRy33HYwz3n7QO8TIxMF4iFGCg1lJhJfZ0SZViDclsbIqtSg/vqg0J7X4EKMp
 MKgnMkuJJucDE3ReSbyhiaWBiZmZobmRqYG5kjjvvda5KUIC6YklqdmpqQWpRTB9TBycUg1M
 VZESqbMLM+WDZv0N4Z61suTWfvv7e0MFcrz++yvc31AouLm34mdW5bQFnk98TNa8Sfy798m1
 pPwdzg/STwf9OeDcmdpf+yfNoj0+6Qy39O6TWbpl9rEivieyuQXc5zm2yx+QODLRYdKckGv3
 fE2tQ9l2f38zX+Xqg553psI3zYMbFlvZvM3RfN+yWOLEubaVOod8BE/ZG6dWvJ3I2n/gUcld
 pb4bmln2M42/Przdf0NmZ26E+iI3W4eUU3MURWruJb5uVZN8Ktwm2P1MNXXN08UvVp9ze6oQ
 vcFiXZLYvjPbb7UdeJv3dPObsk518b1Xls+MNmi34Co/uKcysV5NsWJlyv7Er7vk5Vr+zYlW
 YinOSDTUYi4qTgQARD/YSxgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnC5vjH2qwfbVUhaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGsVlk5Ka
 k1mWWqRvl8CVcfxiM3vBe7aKd7susDUwHmftYuTkkBAwkbj1t4G5i5GLQ0hgO6PEu9X7GSES
 shLP3u1gh7CFJe63HGGFKJrEJLFj7kOwBJuArsSW568YQRIiAusZJX4sfw82lllAW6Lz8xSw
 ImEBR4m/s+8xgdgsAqoSrz5/ZAaxeQXsJR5N7QWq5wDaIC+x+IEESJhTwEFiyZT/YOVCQCWP
 33xihSgXlDg58wkLxHh5ieats5knMArMQpKahSS1gJFpFaNoakFxbnpucoGhXnFibnFpXrpe
 cn7uJkZwAGsF7WBctv6v3iFGJg7GQ4wSHMxKIrzMjjapQrwpiZVVqUX58UWlOanFhxilOViU
 xHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUya9c3Bn3+3v3XM5a36MLN00v1TvrMvOeXe123h
 ueXmdOqj35aMK58fTcq6vbRhmh7v/r2KyfGv1U4/UWvnYLmjpflC57K79B/7iW6HLcp2Wm7c
 5rAi7dZE4xQz9VUeHm77fwi51wp8D42tWv2utN3VcdJ5rgPl3mEZP6vevjb0Nr3RObOk46h3
 3b/vLkKJ4h5H2ZZx7wthb0iYYWrpYtrwxnK/XsKGr5qcb1ZsO7+njin6vNqL1quH3RbaOd+J
 mDZJOW7K299C62c/3po53/3pRTn/0qAlGzO2XNpu1LHm/Yab4u5O89xOttj475y6suf2iwWn
 JX72Jt0+0RoeeMD8addFiy7OFcxv5/CeMy1VYinOSDTUYi4qTgQAw+fHk88CAAA=
X-CMS-MailID: 20231030073229epcas2p4715faac2f35894c88d50e4293a13148e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231030073229epcas2p4715faac2f35894c88d50e4293a13148e
References: <20231030073204.150030-1-chanho61.park@samsung.com>
 <CGME20231030073229epcas2p4715faac2f35894c88d50e4293a13148e@epcas2p4.samsung.com>
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

Adds jh7110 trng device tree node.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/riscv/dts/jh7110.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index ec237a46ffba..13c47f7caa36 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -627,6 +627,16 @@
 			status = "disabled";
 		};
 
+		rng: rng@1600c000 {
+			compatible = "starfive,jh7110-trng";
+			reg = <0x0 0x1600C000 0x0 0x4000>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
+			clock-names = "hclk", "ahb";
+			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
+			interrupts = <30>;
+		};
+
 		aoncrg: clock-controller@17000000 {
 			compatible = "starfive,jh7110-aoncrg";
 			reg = <0x0 0x17000000 0x0 0x10000>;
-- 
2.39.2

