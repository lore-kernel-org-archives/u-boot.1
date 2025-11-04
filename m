Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC44FCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CA78394E;
	Tue,  4 Nov 2025 19:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="cVLn//0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6810B8004F; Tue,  4 Nov 2025 19:26:05 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster2-host11-snip4-5.eps.apple.com [57.103.64.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A2D808AF
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bryanhinton.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bryan@bryanhinton.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPS id
 1DC61180058C; Tue,  4 Nov 2025 18:25:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1;
 bh=WGEQPx5HMSX18qdqwHWiZJBs87O+a0Jwl/qLCagVcZQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cVLn//0r6uNnFt4lr98MbtXY1nBgWtkOazfCeIUo3zyqQ+b/IyiJc96NoRUDnovok/qRG/jtEopfdDECJU5HvVEDHZ7wARsa+WwFlVEhN/FjREbro0LBxSPC0lFAw8gLsWhDo96DJ/rfc/UtS3yqvItJRaW1bCaH1Sziv/PapO908WB1snNffCV06qON+SshEmuTX8A/8yAct8SjRt95wq4G+QzF/wSrL0KvsvRtLkEuTfdpW8z+wc4IUL9CGN/4tYG2VBoj5I0Z/aLnLVM2Yf2+j1UycIqP9cokNEW/3E98joiPR9rkDWZNQZr2qV2mk+1DraSgxcuWDbBO46tK3A==
mail-alias-created-date: 1643268037438
Received: from localhost (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPSA id
 3017C1800149; Tue,  4 Nov 2025 18:25:58 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH 2/2] MAINTAINERS: Add entry for Radxa ROCK 5B+
Date: Tue,  4 Nov 2025 12:25:12 -0600
Message-ID: <20251104182523.2142120-3-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104182523.2142120-1-bryan@bryanhinton.com>
References: <20251104182523.2142120-1-bryan@bryanhinton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE1NSBTYWx0ZWRfX4L7LTPf4rDSt
 O9X/KBPNxGJ/kBU2xrFXsh4P2vPXjNah43/Hi4+80Xy519X5UmjPP96qP1z8Zbu9l5hK1CKfpTE
 d3MgQCI74k1mqjYH8Wg7graG/rvCc0GvFviR5ilLL8vXYRqqSyJViueVLnIqvvXxA4IGbeWRSAh
 dM0OayTS2TV6DX1F4xIDJS3YMReOLI5YMv5SOQ5Y6Tb5rUf357/Dg6/019xZCrmWTYakkeuqq1M
 Zl41JK9JJTR1YKT2X0Kah6piee408awU7AqwDnDqgx746BlbAMh9G8T+9BAYG1x3DNQBPWGpY=
X-Proofpoint-ORIG-GUID: b9TVcUoKjbFXnXCG9zWjGIgM7kMmJmWO
X-Proofpoint-GUID: b9TVcUoKjbFXnXCG9zWjGIgM7kMmJmWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=487 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511040155
X-JNJ: AAAAAAAByQaeKuHL4yDmXkzbabNKHtD7xGysdGeAXuXhSKr4JUb43PHPEVuZW8l1Pa7kk4gDxtyN/hPvaPpRCI32QyfFFBmqCncaM2mgBpF/KvmBKhVQ6SvRYlMn8FT/jtBF6ngxQhyEwF3fJWPvLkoiKruKAGcKNAduCdp4lQckJp/XdIvBR5/vCwo1xO9Is+9rJbVtTkwGWLfsceKLmn/3ihup/RvYXRNKnYAcs6VeksTI9uft7jXPQGC1o6PXt0uqjt9uHrq8sApz6Yq4Q0ILpu9KSiys7uf056BU+WVp5nmpOYJ4Pqc/RVeyCVykCqPkBudm24Cqm7D7kQFoyGPFImWHa8Aj29PifnRvJkU4r6YTAo85lStyjGvgWs8zFiG0I60yPgysH3WA+R3RH0Lqarwqgd2TUtUkHM6jKmIlCnuOpb0D2fQHYXa0K6rx48B57MT6UbkYQhqMqaIZ8L1ojeYkoW9ahXww16u90WpK7LBEWlHH/eB5i0qVg8QkwUr+P5e40Wn0wOFviy7bYAZJg0bkNw0d2OdjbCL5qW3qI3SUfxubDUJQmknRi4kJRIxaXk0cx9aklbpJ1WDwWg6dpmwBw94b6oU2/uidt9SSe7HkQTPXQciVSvXlIWGLw7B/9ql1BYYfrZ3INlkU9ZT+J8MJ/AFLVExKJyLw
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:32:08 +0100
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

Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c7d0e0ab2f..bae65d7c651 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1974,3 +1974,8 @@ T:	git https://source.denx.de/u-boot/u-boot.git
 F:	configs/tools-only_defconfig
 F:	*
 F:	*/
+
+RADXA ROCK 5B+
+M:    Bryan Hinton <bryan@bryanhinton.com>
+S:    Maintained
+F:    configs/rock5b_plus-rk3588_defconfig
-- 
2.51.2

