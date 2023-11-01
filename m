Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777B7C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C45C87B68;
	Wed,  1 Nov 2023 12:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="BHq/C1+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D8087AEF; Wed,  1 Nov 2023 12:40:50 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01A687701
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231101114042epoutp03aeec674704198eababcc050698bbd2b8~TfO0jHPeK2409424094epoutp03C
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:40:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231101114042epoutp03aeec674704198eababcc050698bbd2b8~TfO0jHPeK2409424094epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698838842;
 bh=URCyZ2ChWTd0cTynCIPY0Cm3BJiq3O7QEsaIokYejzk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BHq/C1+fGw/YPIStPzP76Uw7X9BlK+K4B0AHzE5mu+HNGzquOPQpJxwb1aN3mQ3Oc
 ckC6x8vXz3VBeh/xDmHz7qS6J2Wse8pCdsOc+pxvkabKw19r5btO4Yk1oFczlbdi1P
 GNcqnbw9rclp6oPRdgdi7vUacOiHT8HCP2vUKuSw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231101114041epcas2p494916082feb4897cb4a7953bcacc9e38~TfOzddGhx3105431054epcas2p4M;
 Wed,  1 Nov 2023 11:40:41 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SL4nh4jWlz4x9Q2; Wed,  1 Nov
 2023 11:40:40 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 85.5D.10022.83932456; Wed,  1 Nov 2023 20:40:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231101114040epcas2p347bd9ccb6e7fb4f74c540d8a9d3a628b~TfOyo72XY2794027940epcas2p3Q;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231101114040epsmtrp1f52c1ab2ed918ddaa51d80ed61120247~TfOyoFQO_2761227612epsmtrp11;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-14-65423938f6a7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2A.87.08755.83932456; Wed,  1 Nov 2023 20:40:40 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101114040epsmtip18bec2e306ac1aa3e0923bc1da76f6d42~TfOyYMV2W1681316813epsmtip1T;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 5/5] configs: visionfive2: Enable JH7110 RNG driver
Date: Wed,  1 Nov 2023 20:40:17 +0900
Message-Id: <20231101114017.1845960-6-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101114017.1845960-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVNfC0inVYNUXJYvL+7UtbvxqY7V4
 ++Iso8W9a3IWb/d2slscnvqB0eLxoddMDuwee07PYvb48DHO4861PWweZ+/sYPTo27KKMYA1
 KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
 xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2
 Ru/WdpaCT6wV68+uYG5gnM7axcjJISFgInG77xV7FyMXh5DADkaJQ99+QDmfGCU2br8P5Xxj
 lLjfPocJpmXFmedsEIm9jBJP/h5ggXCmMUkc3rsMrIpNQFdiy/NXjCAJEYGrjBLvZ71hBkkw
 C2hLdH6ewg5iCwu4SVz8fBWom4ODRUBVYtLhAJAwr4CDxPdTjxhBwhIC8hKLH0iAhDkFHCVW
 tv1hgygRlDg58wkLxER5ieats5lBVkkIPGKXmHr5PTvEpS4ST2fsgXpUWOLV8S1QcSmJl/1t
 7BDzyyV2LEuC6G1hlGhu28MMUWMv8ePmFFaQGmYBTYn1u/QhypUljtyCWssn0XH4L9QUXomO
 NiGIRnWJA9uns0DYshLdcz6zQpR4SEz6YAMJqCmMEj/7VzBNYFSYheSZWUiemYWwdwEj8ypG
 sdSC4tz01GKjAmN4/Cbn525iBCdJLfcdjDPeftA7xMjEwXiIUYKDWUmE97CpQ6oQb0piZVVq
 UX58UWlOavEhRlNgQE9klhJNzgem6bySeEMTSwMTMzNDcyNTA3Mlcd57rXNThATSE0tSs1NT
 C1KLYPqYODilGphc2UV4WHovrjiZFLZUUc8w9IiJAcc/T5l2nXdPa10SHtTq5jGs6Xkr0zzd
 0kdoz2zBv74yhxa1pa/wPvPQqOTtkYN9N3bsqnnzUVTv9duupH+Pwn89u/Li3NQ19vtdjqVO
 XdrCt2cm3+cfjpqn+5StK77uW8T3qFst8GvXj8AZB2V+vtm/Yfnp5Pg9B7w7LdqmJT8+dHTa
 x9sRa1duEDNm/zepVvqd/kkr74I/Susmhj76fOv0rIV6DfMTVt9ZK9bPv3vR95OnX57Ye7n+
 zpJpYrsFWA/cttNY9OLfsxNrt5YItqlfP2Fq8X/Sw7sWgl7dW+1SWie6Z+j63pB5f2Nztj/D
 t7WnuRwCXGwsgmJU2JVYijMSDbWYi4oTAZolHZQbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSnK6FpVOqQdNeXovL+7UtbvxqY7V4
 ++Iso8W9a3IWb/d2slscnvqB0eLxoddMDuwee07PYvb48DHO4861PWweZ+/sYPTo27KKMYA1
 issmJTUnsyy1SN8ugSujd2s7S8En1or1Z1cwNzBOZ+1i5OSQEDCRWHHmOVsXIxeHkMBuRonT
 i5exQCRkJZ6928EOYQtL3G85wgpRNIlJovnbVbAEm4CuxJbnrxhBEiICNxklFs75CtbNLKAt
 0fl5CliRsICbxMXPV4HiHBwsAqoSkw4HgIR5BRwkvp96xAgSlhCQl1j8QAIkzCngKLGy7Q8b
 iC0EVDL39kpWiHJBiZMzn0BNl5do3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbr
 FSfmFpfmpesl5+duYgQHtJbmDsbtqz7oHWJk4mA8xCjBwawkwnvY1CFViDclsbIqtSg/vqg0
 J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA5PT9FXPQ1YWX3+enF/Ef/SsYNUj
 /2NckaHftSs+ye6MUlAJZdZ7IlH7nuPpYbEz2wx7uA72xfJlfGC3i2a8xumfEvh66qbbLonZ
 HxlX3HU88eWhynTf2BuWB1JaMn8e+LZM/VzJkr2JKrK79/xVMNwVePR50fseS281tqDu+iif
 x/FtZxIiSleznI1p93bfI5f9SMWhlI3rrcsj/4hni+8WspssP3a/ebViYEr87iKjJmkGnTkh
 heKl/CGMmspFZwwfPl4xW81RbnNvvNU8m+3/NbZdmZy9IS7GhNVAPHKP/3FOpwkrHZgde11P
 vHPO5osU4XbX+NEfNPWq7re5mvMKNQosFj1+sLrQsfeNEktxRqKhFnNRcSIAQYd5mdcCAAA=
X-CMS-MailID: 20231101114040epcas2p347bd9ccb6e7fb4f74c540d8a9d3a628b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101114040epcas2p347bd9ccb6e7fb4f74c540d8a9d3a628b
References: <20231101114017.1845960-1-chanho61.park@samsung.com>
 <CGME20231101114040epcas2p347bd9ccb6e7fb4f74c540d8a9d3a628b@epcas2p3.samsung.com>
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

Enables JH7110 RNG driver to visionfive2 board.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index b21754feafce..b15e7d24db19 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -120,6 +120,8 @@ CONFIG_SPL_PINCTRL_STARFIVE=y
 CONFIG_SPL_PINCTRL_STARFIVE_JH7110=y
 CONFIG_PINCTRL_STARFIVE=y
 # CONFIG_RAM_SIFIVE is not set
+CONFIG_DM_RNG=y
+CONFIG_RNG_JH7110=y
 CONFIG_SYS_NS16550=y
 CONFIG_CADENCE_QSPI=y
 CONFIG_TIMER_EARLY=y
-- 
2.39.2

