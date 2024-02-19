Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A587EC48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 13:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E3387DCA;
	Mon, 19 Feb 2024 14:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="C5ybnzWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E620F87DEB; Mon, 19 Feb 2024 13:41:50 +0100 (CET)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9FD0877FB
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 13:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.stelmach@samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20240219124142euoutp0174169035a8e8ac6ed2f2942fca2806c6~1RBfS2nQB3192631926euoutp01M
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 12:41:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20240219124142euoutp0174169035a8e8ac6ed2f2942fca2806c6~1RBfS2nQB3192631926euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1708346502;
 bh=+w/A9zECUJ/ypWwabSAfyo4jbFyzdOTQems+fPoz1b0=;
 h=From:To:Cc:Subject:Date:References:From;
 b=C5ybnzWBZDxW0Nt63uQ01TOQ3B2XEuaw8B5Ul1XO8i+PA1ic7qKCUxSJq8g9qd1ub
 ni7bUh5oTGZsxrQDgQsbn8RyOq7AARpF9p9mf2ZaOxq8Uu7Bjwm3JWzClrNLb3i4C9
 sF8IsNP1vBtf0a0HxcXD6lxZeaCXSAmX+NzGqQF4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240219124142eucas1p18d2f38b8dd5176573597667102d84b7a~1RBfJOOYV1265212652eucas1p1R;
 Mon, 19 Feb 2024 12:41:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 22.0C.09539.68C43D56; Mon, 19
 Feb 2024 12:41:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240219124142eucas1p179abec33d2cf344a2c21cec12f192679~1RBerpptE1264812648eucas1p1R;
 Mon, 19 Feb 2024 12:41:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240219124142eusmtrp2bce5360cf542243e1749c2b3c4c5466d~1RBerA-yy2587525875eusmtrp2v;
 Mon, 19 Feb 2024 12:41:42 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-81-65d34c86336f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id BA.0E.10702.58C43D56; Mon, 19
 Feb 2024 12:41:41 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240219124141eusmtip1a5d90c03a553703754564d1881f90c68~1RBefK9wb1678716787eusmtip1w;
 Mon, 19 Feb 2024 12:41:41 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: u-boot@lists.denx.de
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] riscv: Repeat virtio scan
Date: Mon, 19 Feb 2024 13:41:39 +0100
Message-Id: <20240219124139.1541868-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7djP87ptPpdTDVavlbO4eWgFo8XaI3fZ
 Ld7u7WR3YPY4e2cHo0ffllWMAUxRXDYpqTmZZalF+nYJXBm3+vewFEziqPjRdoqxgfE+Wxcj
 J4eEgInEonUdrF2MXBxCAisYJTbN/s4O4XxhlDj6fj6U85lR4u/RpSwwLeu3dUO1LGeUmHj/
 AlTVC0aJBys3g1WxCThK9C89wQpiiwhISPzqv8oIYjML5EnsmXueCcQWFtCS2LHkNVgNi4Cq
 xK8f/4CO4uDgFbCV+NQtD2JKCMhLLH4gAVLBKyAocXLmE7Dp/ECda5qus0BMlJdo3jqbGeK2
 Xg6J/e/YIWwXiWUTjrNC2MISr45vgYrLSPzfOZ8J5GQJgXZGiaYrC1khnAmMEp87mpggqqwl
 7pz7BXYPs4CmxPpd+hD3OEpMvh8JYfJJ3HgrCHECn8SkbdOZIcK8Eh1tQhAzVCTWAQMdwpaS
 6H21ghHC9pBo/nWCbQKj4iwkj81C8swshLULGJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn
 525iBKaI0/+Of9rBOPfVR71DjEwcjIcYJTiYlUR43ZsupArxpiRWVqUW5ccXleakFh9ilOZg
 URLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUw+d7/znf/ddOBO7ufrV9Teihvwq+tjet+HLjS
 v3jKNrFPlw4/P7xF5UbrOyvnRVIWv/ptu/qc+hukkx+6ai61yvZceOuLy/OIVxe62HxuyU7u
 bSv+dV1TVNgznrta9uVirV/xkR3drxVO8yhZ/PNYbv5t06nKD6um3Jqd+PHPtJ7jJdf0Vdav
 YzEVfKm+jGPmHrdsk8yd/jH3Dh77e/+utvaET/IWeYqVWg174llUNM02uUw2vH2+eH1N6Qvp
 fWybreoj8nKiPgVZfG10nm3dPmFqxGyH7v3rRBmVFm5YfvHVHYNCvaj6PS3Zh6QmLhP5HOxX
 7dngG8Jwo0UgO+77E/vfzVU/ZLb4zGU6vfzbUSWW4oxEQy3mouJEAIUWSBmAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xu7ptPpdTDXbaWNw8tILRYu2Ru+wW
 b/d2sjswe5y9s4PRo2/LKsYApig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNT
 JX07m5TUnMyy1CJ9uwS9jFv9e1gKJnFU/Gg7xdjAeJ+ti5GTQ0LARGL9tm7WLkYuDiGBpYwS
 J6f+Z+5i5ABKSEmsnJsOUSMs8edaFxtEzTNGiW2HZjKDJNgEHCX6l55gBbFFBCQkfvVfZQSx
 mQXyJPbMPc8EYgsLaEnsWPIarIZFQFXi149/bCDzeQVsJT51y0OskpdY/EACpIJXQFDi5Mwn
 LCBhZgF1ifXzhEDC/EBD1jRdZ4EYLi/RvHU28wRGgVlIOmYhdMxCUrWAkXkVo0hqaXFuem6x
 kV5xYm5xaV66XnJ+7iZGYHBvO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMLr3nQhVYg3JbGyKrUo
 P76oNCe1+BCjKdD9E5mlRJPzgfGVVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQ
 WgTTx8TBKdXAZH5ByCzg+xRrRpuJZ4vOeUvyqvMumcpipHvs99/NrxY8N52cf57NKKulfH6p
 hOmBy3ImDduVD8gwiXxVu6ZQZvaiII1R+qN1q+bmdZOmsl6/8fi+2Cb2Q9f8bWtL3a9dyubZ
 Mon/laZBa1iH4E82P7n3oh4LWZ4mTdM8d4d5/+GZ0kyGZaX79yw9NUdAXPuCju+dtkViGfwO
 GUskJaZm9D+qLKo6tf+q+rr+KyEqDF49Z/uvFRm/u+1WcetKjOeUNQosXddXHlrjI7LqrVuU
 a0K9n+eKrQ8KHjFU8Mt8WPPK+FGFe19E+cr6Zw7SB5Ie3PzMO+GE6pP2FVMtbK/IbAn0maKz
 p//DzysPTpXwKLEUZyQaajEXFScCAD9JRPf3AgAA
X-CMS-MailID: 20240219124142eucas1p179abec33d2cf344a2c21cec12f192679
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240219124142eucas1p179abec33d2cf344a2c21cec12f192679
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240219124142eucas1p179abec33d2cf344a2c21cec12f192679
References: <CGME20240219124142eucas1p179abec33d2cf344a2c21cec12f192679@eucas1p1.samsung.com>
X-Mailman-Approved-At: Mon, 19 Feb 2024 14:53:09 +0100
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

The first time virtio_init() gets called from board_init() PCI isn't
ready. Thus any virtio-over-PCI (e.g. network interfaces) devices can't
be detected and used without additional `virtio scan` scan in the shell
or a script.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
The patch works for my but:

a) maybe virtio_init() should called only from board_init() the same
   way as on ARM?

b) can a repeated virtio_init() break already detected/initialized
   devices?

 board/emulation/qemu-riscv/qemu-riscv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index 181abbbf97d..567b9dc6170 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -46,6 +46,9 @@ int board_late_init(void)
 	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
 		usb_init();
 
+	/* Repeat virtio scan to detect PCI attached virtio devices. */
+	virtio_init();
+
 	return 0;
 }
 
-- 
2.39.2

