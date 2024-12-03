Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45599E6C60B
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 06:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8442988E32;
	Tue,  3 Dec 2024 07:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="jOGnC8Ab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87EA488E2B; Tue,  3 Dec 2024 07:39:52 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D4388E32
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 07:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20241203063945epoutp02feb1bf6833e8f66adf07025e81b30159~Nl3rwE-PT2586025860epoutp02O
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 06:39:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20241203063945epoutp02feb1bf6833e8f66adf07025e81b30159~Nl3rwE-PT2586025860epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1733207985;
 bh=wVSkATdjErVDMoqftw8NnlVXP+qOO398kjCuo7xVhdE=;
 h=From:To:Subject:Date:References:From;
 b=jOGnC8AbnJFecZ5eNfdcBg33JhUKUhaV43Kkmi7njvqf7bRdSEC4/X+6dI5tluTPC
 roQFAU/PRjuPNTMLbSzXweyBZsE9zqVknHveJUe+nHL0Zbxzk4WT2yYd5RGpgSnl+i
 HVmgcHFz41CcgkArg+MQvb+kt7U0Gj9pPqRsYVgs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20241203063945epcas1p183b0e1a8e66b64cfc9fb1d3612975e17~Nl3rdSsbr0601106011epcas1p1j;
 Tue,  3 Dec 2024 06:39:45 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.241]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4Y2WGm467Gz4x9Pr; Tue,  3 Dec
 2024 06:39:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.F0.31735.0B7AE476; Tue,  3 Dec 2024 15:39:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241203063944epcas1p45e5c757403cd06ebd265a93e7fdbbeff~Nl3qPXGCa2170821708epcas1p47;
 Tue,  3 Dec 2024 06:39:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241203063944epsmtrp1cd195f6134f7b352f94fba2e06ec8aec~Nl3qOzJve3252232522epsmtrp11;
 Tue,  3 Dec 2024 06:39:44 +0000 (GMT)
X-AuditID: b6c32a4c-ac3ff70000007bf7-c9-674ea7b09b71
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 22.8C.18949.0B7AE476; Tue,  3 Dec 2024 15:39:44 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20241203063944epsmtip1baae5cb26119d569827e9458a7d9c191~Nl3qEqOxR3258232582epsmtip1N;
 Tue,  3 Dec 2024 06:39:44 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Please pull u-boot-samsung master
Date: Tue, 3 Dec 2024 15:39:43 +0900
Message-ID: <24da01db454e$23517c30$69f47490$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdtFTgM67oENYUCVTqqQeXuU+w7JYg==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmvu6G5X7pBr8WKlhMnbSZ3eLt3k52
 ByaPVwdWsXucvbODMYApKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
 1VbJxSdA1y0zB2i+kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafArECvODG3uDQv
 XS8vtcTK0MDAyBSoMCE748/Wh0wFl9kr7k+dy9zAOJ2ti5GTQ0LARGLLvb2sXYxcHEICexgl
 bm7aygzhfGKUmDplJlTmG6NEV8dnZpiW/TsXMEIk9jJKrNn8gQ3Cec4o0Xt5HiNIFZuAlsTf
 hedZQWwRAQOJLQd3gNnCQPFfF56BLWcRUJF4c+QSUD0HB6+ApcS79xIgYV4BQYmTM5+wgNjM
 AvIS29/OgVqsIPHz6TKokXoSR3qOMELUiEjM7myDqtnGLvGnywjCdpG49ncFO4QtLPHq+BYo
 W0riZX8bO8jNEgKTGSUmLXrGCOGsZ5Q4POsDI0SVscTN9RtYQY5jFtCUWL9LH2IZn8S7rz1g
 YQkBXomONiGIaiWJAxcOQHVKSMy+vp0VwvaQOPFwMti7QgKxEl9WzmSZwCg/C8mbs5C8OQvJ
 O7MQFi9gZFnFKJVaUJybnppsWGCom5daDo/l5PzcTYzgNKfls4Px+/q/eocYmTgYDzFKcDAr
 ifAuX++dLsSbklhZlVqUH19UmpNafIjRFBj2E5mlRJPzgYk2ryTe0MTSwMTMyMTC2NLYTEmc
 98yVslQhgfTEktTs1NSC1CKYPiYOTqkGpo4Z0pXfOhVupxdfFK1Y/nhhg/ZKAe3CKmPmPV4V
 D87H2uQKnuItlmXN/8duurDs6BIvybg7L1kCN+W+zfrtX3xC76ZftXWEqqjx1X0Xd26/+6Cp
 c9fn/H0X71Qdff9t9U+7+zJPKib+MOS42xl7KcoyLz3/EbdacO8M6dmzpzat/dCgHLw1i3P2
 9fs9k9eGPzJTnNX5TWG6xhHLrmezkz90tPNeKJYqSu7pWa3uEFL04YjkZlWmz4uTd0Z2P+NI
 T/Jd1P3v5e3IFYUfFsieCvsut8LEKMelZaVy59yty7Q3zu6asP3jJWbWPP7vbwJeaDUYuW8t
 v8HUfbX+7Cm35RFnihcv01rndtH7+4L+3UosxRmJhlrMRcWJAGbxCvj8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSnO6G5X7pBtsWcVtMnbSZ3eLt3k52
 ByaPVwdWsXucvbODMYApissmJTUnsyy1SN8ugSvjz9aHTAWX2SvuT53L3MA4na2LkZNDQsBE
 Yv/OBYxdjFwcQgK7GSWm969ihEhISEyafYGpi5EDyBaWOHy4GKLmKaPE+W/97CA1bAJaEn8X
 nmcFsUUEjCRaN3QygdjCQPFfF56BLWARUJF4c+QSI8gcXgFLiXfvJUDCvAKCEidnPmEBCTML
 6Em0bQTbyiwgL7H97RxmiAsUJH4+XQY1XU/iSM8RqBoRidmdbcwTGAVmIZk0C2HSLCSTZiHp
 WMDIsopRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhgtbR2MO5Z9UHvECMTB+MhRgkO
 ZiUR3uXrvdOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi4JRq
 YAp0n3BaW/bryZyMtedOdacckp0YmbAv3/NcSvyZJ3vll801NDmw1eu2/NUj8QWNKgen6nW4
 i6tsb5qcG17ov9uy73Km+u53ed8y9TzlHiYerbnw3ro0RrdvlswFATVW/zmLhWaGBD1xnZDx
 PbPgrnmceobh1aspMlqp85hi01QmvDQztHGo+bzx1kIuTsWwu6F9v6cFLec3PHmeu4FJeoX0
 u/o0CZlJca150j2fy8S3PpkbZxApE782Zv9rz9eXFWbc2/blYPuvTyFbOaaodre+PLA2sHqz
 1D/1F8dbjqzzDjN59bdy8itZ/m/XhFa0zm/aq3rv84sgkc9P1YOa/v0QnSdZF7Mg7ernGb79
 C5VYijMSDbWYi4oTAR5L9gnHAgAA
X-CMS-MailID: 20241203063944epcas1p45e5c757403cd06ebd265a93e7fdbbeff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203063944epcas1p45e5c757403cd06ebd265a93e7fdbbeff
References: <CGME20241203063944epcas1p45e5c757403cd06ebd265a93e7fdbbeff@epcas1p4.samsung.com>
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

Dear Tom,

The following changes since commit 56accc56b9aab87ef4809ccc588e1257969cd271:

  bios_emulator: fix first argument of pci_{read,write}_config_* function
calls (2024-11-04 18:01:58 -0600)

are available in the git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 0bbc17f06bf3ecee019090b76c8c20480516945e:

  configs: e850-96: Disable PSCI reset (2024-12-03 15:14:53 +0900)

----------------------------------------------------------------
Henrik Grimler (1):
      pinctrl: exynos: fix type of count integer

Sam Protsenko (2):
      arm: dts: e850-96: Remove TRNG node from appended dts
      configs: e850-96: Disable PSCI reset

 arch/arm/dts/exynos850-e850-96-u-boot.dtsi | 11 -----------
 configs/e850-96_defconfig                  |  2 ++
 drivers/pinctrl/exynos/pinctrl-exynos.c    |  4 ++--
 3 files changed, 4 insertions(+), 13 deletions(-)

Thanks,
Minkyu Kang.


