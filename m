Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF71D3E775
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 22:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C35668913F;
	Tue,  5 Nov 2024 23:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="fPZZS6z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A19CC89048; Tue,  5 Nov 2024 23:12:05 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D662C88E43
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 23:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20241105221153epoutp010bec968c48726fcbc3fc563768124b05~FMhi67Dyk1344913449epoutp01G
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:11:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20241105221153epoutp010bec968c48726fcbc3fc563768124b05~FMhi67Dyk1344913449epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1730844713;
 bh=TGQwuQROTgHAzPri5g4ttobgEwdo3bqjQgmfa8yvgZI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=fPZZS6z/akCEV0AFBnpdjLIMSXegDPQyUE8xw+4Jl2uvdwz+io6MVpdpfiNn7qUxQ
 R3ZukB6nnQnwOBPRlHkQm5cq9lqH0ujVyXmCcUU6f6NJlFxkludEvs3otF26DBHoaX
 06AdkN1Ki0lZUMVzxsGA1DNraDr21xVX/ZmrXP+0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20241105221153epcas1p4b177172ce717927392ebe405ea420739~FMhigpwdm0089300893epcas1p4K;
 Tue,  5 Nov 2024 22:11:53 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.136]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4XjjHD1qcsz4x9Px; Tue,  5 Nov
 2024 22:11:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 14.23.09435.8289A276; Wed,  6 Nov 2024 07:11:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241105221151epcas1p2096fdad52d8b4977f707e4b1b3a47849~FMhhTpBAN1788417884epcas1p2o;
 Tue,  5 Nov 2024 22:11:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241105221151epsmtrp267072ccd5aab9bdf0dca25310330d65e~FMhhS_aDs0884708847epsmtrp2g;
 Tue,  5 Nov 2024 22:11:51 +0000 (GMT)
X-AuditID: b6c32a36-ac7ff700000024db-af-672a982810d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D0.5E.08227.7289A276; Wed,  6 Nov 2024 07:11:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20241105221151epsmtip2a8cbb2f6349c16a82386ca9481ef2076~FMhg-myJe1998719987epsmtip2Y;
 Tue,  5 Nov 2024 22:11:51 +0000 (GMT)
From: Jaehoon Chung <jh80.chung@samsung.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: [PATCH] boot: image-board: Mismatch a type between variable and
 return value
Date: Wed,  6 Nov 2024 07:11:49 +0900
Message-Id: <20241105221149.507119-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmnq7GDK10g5ltbBY3frWxWnROXMJu
 sfbIXXaL1pV32Cy+bdnGaDF10mZ2i7d7O9kd2D1mN1xk8ZjdMZPV49WBVeweZ+/sYPTYOXsf
 k0ffllWMAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6
 bpk5QMcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wM
 DQyMTIEKE7Iz3l0vKXjLXrFslV4D42a2LkZODgkBE4n7nz6xdzFycQgJ7GCU+HJhFRNIQkjg
 E6PEv2XJEIlvjBLzb31g7GLkAOtYMCsQIr6XUWLx2cnMEM4XRomJaxaBdbMJ6Ehs/3YczBYR
 kJD41X+VEcRmFtjEKNEzSQ3EFhYIl2i/tZYZxGYRUJW4fQeil1fARmL1/l3sEOfJS8y89J0d
 Ii4ocXLmExaIOfISzVtnM0PUXGOXaJ2RBmG7SOw69p4VwhaWeHV8C9QcKYnP7/aygRwqIdDM
 KLF0yUFWCKcH6M2G69DAMJbYv3QyE8ibzAKaEut36UMs45N497WHFeJ7XomONiGIahWJS69f
 MsHMv/vkP9ReD4l/E/4zg5QLCcRKtG7XmMAoNwvJB7OQfDALYdcCRuZVjGKpBcW56anFhgVG
 8FhMzs/dxAhOgFpmOxgnvf2gd4iRiYPxEKMEB7OSCO+8VPV0Id6UxMqq1KL8+KLSnNTiQ4ym
 wDCdyCwlmpwPTMF5JfGGJpYGJmZGxiYWhmaGSuK8Z66UpQoJpCeWpGanphakFsH0MXFwSjUw
 JUVf2sprce5dZNn+pZEhm245G37eeH/n76Ct5+6tWHSqZ1LwVafrij/990UbstW+7/lt2d7/
 0r2Ldeaa2S/NDsxbPflTwENh/Vud0f7fsx+fNtlplvBrlVcqz5PwGxHZnVs2r5NyTvVPOFqk
 bpRvyx3v+abzoVZU7ZmPZReuH1gZOOns7PtM+m672YL/ejixrtkrOCHt6oG2sl9HO3b1PP0T
 pe9m9tshndHyzi7dbY/2rXh1tXaWe8rrFc8DfW8anZBZ45d22a6vz5P7Yhwb90kHp0cJ/zz/
 OLa4+ORKTpZYf+DOku8Ms3doWM1mbStKmdHD41B2wu5Y8vu0xs820uY8F34/ZY0tfuWToXD8
 tBJLcUaioRZzUXEiAIpyDsYJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvK76DK10g1k/tSxu/GpjteicuITd
 Yu2Ru+wWrSvvsFl827KN0WLqpM3sFm/3drI7sHvMbrjI4jG7Yyarx6sDq9g9zt7Zweixc/Y+
 Jo++LasYA9iiuGxSUnMyy1KL9O0SuDLeXS8peMtesWyVXgPjZrYuRg4OCQETiQWzArsYOTmE
 BHYzSlw6xARiSwhISXx+OhWqRFji8OHiLkYuoJJPjBK3T+xhAalhE9CR2P7tOFi9iICExK/+
 q4wgRcwCOxglTnf/ZQVpFhYIlWg+LAFSwyKgKnH7ziKwel4BG4nV+3exQ+ySl5h56Ts7RFxQ
 4uTMJ2DzmYHizVtnM09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95Pzc
 TYzgQNXS2sG4Z9UHvUOMTByMhxglOJiVRHjnpaqnC/GmJFZWpRblxxeV5qQWH2KU5mBREuf9
 9ro3RUggPbEkNTs1tSC1CCbLxMEp1cA06+oq33QT1pMvPMuudd7fkTXJOal6NZvu//kVc5rV
 Xp8qP//9hcZS6QyhPYumRl+K9/pf0lzi0bomWi2do8hwg37ht8nbcmX3NgsdXmH/9Eh3bgJr
 2vtVLOej2+Sbn2pN86pdlWC6jE2r58qG1dkmqZpSJ1nvyNwKfudpcy3hS/lklgfKrlczViya
 0X3zdfKLtlXSl2QCYrfNyDnNteXHkept8s9vZO/32fbH788k9t1nVeSMJV7PYT95++6C863q
 T/7vfG2QyyurqLB83qG2LbFeKVwBekvykpYJX/gctOeKs9eGgLLHx/77Vfh+iGWcXvZY250v
 Rybp94yDD/Oq1FLPaV5TzSkT36P048EbJZbijERDLeai4kQAiYvjm8MCAAA=
X-CMS-MailID: 20241105221151epcas1p2096fdad52d8b4977f707e4b1b3a47849
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241105221151epcas1p2096fdad52d8b4977f707e4b1b3a47849
References: <CGME20241105221151epcas1p2096fdad52d8b4977f707e4b1b3a47849@epcas1p2.samsung.com>
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

phys_addr_t can be used unsigned long long type with CONFIG_PHYS_64BIT.
But hextoul() is always returning to unsigned long. It can be assigned
to unexpected value. To avoid wrong behavior, change from hextoul() to
simple_strtoull().

Fixes: a4df06e41fa2 ("boot: fdt: Change type of env_get_bootm_low() to phys_addr_t")

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 boot/image-board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index 1757e5816d84..977343a8995c 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -547,7 +547,7 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 		/* a value of "no" or a similar string will act like 0,
 		 * turning the "load high" feature off. This is intentional.
 		 */
-		initrd_high = hextoul(s, NULL);
+		initrd_high = simple_strtoull(s, NULL, 16);
 		if (initrd_high == ~0)
 			initrd_copy_to_ram = 0;
 	} else {
-- 
2.25.1

