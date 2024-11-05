Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5205D3E779
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 22:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE2788FD2;
	Tue,  5 Nov 2024 23:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Au29HFnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9282388FD2; Tue,  5 Nov 2024 23:19:46 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D71888E43
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 23:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241105221940epoutp0462254d97428e683f9be71b02bc52cd40~FMoVeIFOa1578815788epoutp04Z
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:19:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241105221940epoutp0462254d97428e683f9be71b02bc52cd40~FMoVeIFOa1578815788epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1730845180;
 bh=PEmt8o9CtMmxkjNCxRrOEpmCKltHObVxKh+KxMlJaw4=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Au29HFnzCCmYSnAzXdL3xEdqG6DH4vuiHpF3yTQp2vGTY2edh0lakDkz7L9jR1riE
 mCpdNLGhRNjOcyFzMhLVU6eblgg7c+mrT79iF1tjJ2lRcV6GujkrknFxtIsW3vkewe
 ASZNrSbF2SGHJQ09eubhbSI+NW8TmADpOOWt7qg4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241105221939epcas1p3e279acf5bb6b8d7ed3be8404cc5caa54~FMoVO6fLm0251902519epcas1p3B;
 Tue,  5 Nov 2024 22:19:39 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.145]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4XjjSC0DMwz4x9Px; Tue,  5 Nov
 2024 22:19:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 0C.C1.09398.AF99A276; Wed,  6 Nov 2024 07:19:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241105221938epcas1p10c135e07759fd408aa11bb5b0b246195~FMoT9xVjP2966029660epcas1p14;
 Tue,  5 Nov 2024 22:19:38 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241105221938epsmtrp28fabcfa21ae089537d4ec20711f0a2bc~FMoT9LJls1361513615epsmtrp2k;
 Tue,  5 Nov 2024 22:19:38 +0000 (GMT)
X-AuditID: b6c32a39-39fff700000024b6-a9-672a99fafd91
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E8.9E.08227.AF99A276; Wed,  6 Nov 2024 07:19:38 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20241105221938epsmtip2e97adb19440e2e453ce0a778d5571faa~FMoTw8M2X2546125461epsmtip2i;
 Tue,  5 Nov 2024 22:19:38 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, mbrugger@suse.com, pbrobinson@gmail.com, Jaehoon
 Chung <jh80.chung@samsung.com>
Subject: [PATCH] board: rpi: Change from CONFIG_ARM64 to CONFIG_PHYS_64BIT
Date: Wed,  6 Nov 2024 07:19:36 +0900
Message-Id: <20241105221936.508328-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmnu6vmVrpBhvuWFrc+NXGarFg8hNW
 i3Wr1rBZTJ20md3i7d5OdgdWj52z7rJ7vDqwit3j7J0djB59W1YxeqzfcpUlgDUq2yYjNTEl
 tUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaLuSQlliTilQKCCx
 uFhJ386mKL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj8wHxgsVs
 FQcOX2BqYFzJ2sXIySEhYCIx4/J8pi5GLg4hgR2MEpsbtjJDOJ8YJaYevcwC4XxjlGj438ME
 07Lq8BaoxF5GiffPlrFBOF8YJQ78u8cIUsUmoCOx/dtxsA4RAQmJX/1XgeIcHMwCmRLXzueB
 hIUFvCQWHWxgBrFZBFQl/k97wQ5i8wrYSOyfeoERYpm8xMxL36HighInZz5hAbGZgeLNW2eD
 nSohcIhdYs+8GWwQDS4SL95fhbpUWOLV8S3sELaUxOd3e9kgGpoZJZYuOcgK4fQwSvxruA7V
 bSyxf+lkJohLNSXW79KH2MYn8e5rDytIWEKAV6KjTQiiWkXi0uuXTDDz7z75Dw1UD4mXT76C
 7RUSiJVYdbSRaQKj3CwkP8xC8sMshGULGJlXMYqlFhTnpqcWGxaYwmMyOT93EyM41WlZ7mCc
 /vaD3iFGJg7GQ4wSHMxKIrzzUtXThXhTEiurUovy44tKc1KLDzGaAkN1IrOUaHI+MNnmlcQb
 mlgamJgZGZtYGJoZKonznrlSliokkJ5YkpqdmlqQWgTTx8TBKdXA1PPtx6bdC3T59ZS10h8v
 ubZrQSbHjtNbauesj/ASnvLlitSns4t9jzVNuM55WcjkKN/GCw7nl6z6eV+pISDucpy0Zua3
 P2KbX78JDuZxzmELOZmSdFCsXFPO4/WuplPlzJUub//N9Ss8U6Yg/cedg7clfub3e1UTGRex
 znc59pOlyumW9LSDhvlPhbRz497cvNFyQtl7wr7HYUXa85Ym2yzabC0XcmzC9J6PzD3qwe+1
 rlaarHqwxuvGl4Ivis+lQxPmM+nl/XsceuTih5eP3yz5csNO4N6BhldzDgaKX17+k3120Omv
 oi3/P880n118z0CuJHLmrcbIk/INW2zbJSIervOXfHpw/fbGk7w6804qsRRnJBpqMRcVJwIA
 yQvZpf4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO6vmVrpBvfuyFnc+NXGarFg8hNW
 i3Wr1rBZTJ20md3i7d5OdgdWj52z7rJ7vDqwit3j7J0djB59W1YxeqzfcpUlgDWKyyYlNSez
 LLVI3y6BK2PzAfGCxWwVBw5fYGpgXMnaxcjJISFgIrHq8BaWLkYuDiGB3YwSj693s0EkpCQ+
 P50KZHMA2cIShw8XQ9R8YpS4cukDC0gNm4COxPZvx5lAbBEBCYlf/VcZQWxmgVyJ5sdHwRYI
 C3hJLDrYwAxiswioSvyf9oIdxOYVsJHYP/UCI8QueYmZl75DxQUlTs58wgIxR16ieets5gmM
 fLOQpGYhSS1gZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREckFpaOxj3rPqgd4iR
 iYPxEKMEB7OSCO+8VPV0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQW
 wWSZODilGpicin6WlsXNnP5m4g7ZyzaTtrK5mEy7cJL7yzqlnkvMdjGF3/f2uvny24qzTcz9
 flHrkHTqekeOm71a6Rutiw7sjHdfopOX8vl53V6j5Qm+s3dNcWsSujPHRsx6zem/Rqz/JdYK
 75Y28drxN1ImienxJO4c/cAptX2dn/aW8p99H3S98FlPNcfkE/v1Lmy4ML9O5Fn5p7kfTom/
 vlSx7++swO0asdmCc30vTxNRTua/aHLrVvv+rbUSSrcrXhj0ibXX+7TMYDh59+jKhQn3c21X
 qh3JYnn3j/1o8xb2pcUfF1/+9bXRMPHZbrPpwo6X2ec6pj4qNao1ZjvKzyY+d+qjZpEeISPN
 fLNPPrwCOziVWIozEg21mIuKEwH+fI++twIAAA==
X-CMS-MailID: 20241105221938epcas1p10c135e07759fd408aa11bb5b0b246195
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241105221938epcas1p10c135e07759fd408aa11bb5b0b246195
References: <CGME20241105221938epcas1p10c135e07759fd408aa11bb5b0b246195@epcas1p1.samsung.com>
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

initrd_high is dependent with CONFIG_PHYS_64BIT configuration.
Even though CONFIG_ARM64 is not enabled, CONFIG_PHYS_64BIT can be
enabled.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 board/raspberrypi/rpi/rpi.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285edde..47529b0b7a68 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -61,7 +61,7 @@ dfu_alt_info+=zImage fat 0 1
  * only 64M, the remaining 25M starting at 0x02700000 should allow quite
  * large initrds before they start colliding with U-Boot.
  */
-#ifdef CONFIG_ARM64
+#ifdef CONFIG_PHYS_64BIT
 fdt_high=ffffffffffffffff
 initrd_high=ffffffffffffffff
 #else
-- 
2.25.1

