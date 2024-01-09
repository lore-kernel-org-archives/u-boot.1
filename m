Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85AAC3DA6E
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 01:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9248775A;
	Tue,  9 Jan 2024 02:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Xts3+m2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EAFD8783A; Tue,  9 Jan 2024 02:55:24 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D5B87754
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 02:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240109015517epoutp037ae0e7d42d4607d643caa2bad1910a36~oiwZAijQi2051820518epoutp03f
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 01:55:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240109015517epoutp037ae0e7d42d4607d643caa2bad1910a36~oiwZAijQi2051820518epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1704765317;
 bh=8xfxPivZNqKQmHiEpq8E3+jaUOpSyqzth93I7qJO2tY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Xts3+m2OVrKUi4BMrNA3TnU6BQSDAJ5p+OQwCQO/mSnQaR/8+Mm/rLLdAdkkDhEjZ
 A+BU95VemMXMDpiJBZDhQ2i0uYfK3fWfUtgD/HXeKkiYPRL6voQ3lHtOOjujuLVOt9
 G3gALQMT0N89vvxdi44J6QpOZyZqyumyTPOm+aC4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240109015517epcas1p267a6e0593fb283dd8ad3762efee82701~oiwY2P2FI2269722697epcas1p2P;
 Tue,  9 Jan 2024 01:55:17 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.241]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4T8DXN5pkxz4x9Q2; Tue,  9 Jan
 2024 01:55:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 DD.EF.09739.487AC956; Tue,  9 Jan 2024 10:55:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b~oiwXq0m5r3250432504epcas1p3o;
 Tue,  9 Jan 2024 01:55:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240109015516epsmtrp2260b58c2162d3c11262035df73e54bed~oiwXqJ7sw3098130981epsmtrp2D;
 Tue,  9 Jan 2024 01:55:16 +0000 (GMT)
X-AuditID: b6c32a37-e67fa7000000260b-d9-659ca7843890
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 EE.1B.08755.487AC956; Tue,  9 Jan 2024 10:55:16 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240109015516epsmtip1dd882c0b1d68f221339794692b593b3c~oiwXejRyk2161821618epsmtip1y;
 Tue,  9 Jan 2024 01:55:16 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
Cc: <promsoft@gmail.com>
Subject: Please pull u-boot-samsung master
Date: Tue, 9 Jan 2024 10:55:16 +0900
Message-ID: <0a3d01da429e$e4427ec0$acc77c40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ado5NzuPIiMRvpT8R/Gx54kZ2t6aUQ==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmvm7L8jmpBp1/9SymPjjHaDF10mZ2
 i7d7O9kdmD12zrrL7vHqwCp2j7N3djAGMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
 6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
 FJgV6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfMXnyTtaCXt+LbHJcGxu1cXYycHBICJhJX1p9g
 6WLk4hAS2MEoserCT0YI5xOjxMOL66Ccb4wSf7acZYJpObf7NFRiL6PEvkl3oJznjBIrl0xk
 BKliE9CS+LvwPCuILSJgILHl4A4wm1lAQqLnxR2wScJANb8uPGMDsVkEVCReTtnGDGLzClhK
 rJh5lB3CFpQ4OfMJC0SvvMT2t3OYIa5QkPj5dBnUfD2JpSfWMUHUiEjM7mxjBjlIQuAcu8SM
 pR8ZIRpcJD6cuQXVLCzx6vgWdghbSuLzu71sEA2TGSUmLXrGCOGsZ5Q4POsDVLexxM31G4DW
 cQCt0JRYv0sfYhufxLuvPWBhCQFeiY42IYhqJYkDFw5AdUpIzL6+nRXC9pA4uWkh2KFCArES
 S3f0sU1gVJiF5M9ZSP6cheSfWQiLFzCyrGIUSy0ozk1PLTYsMIZHd3J+7iZGcDLUMt/BOO3t
 B71DjEwcjIcYJTiYlUR4JWfMThXiTUmsrEotyo8vKs1JLT7EaAoM+YnMUqLJ+cB0nFcSb2hi
 aWBiZmRiYWxpbKYkznvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA1PDxSlnnhiH+S1/HePRlZO+
 c07/zNf99elrZvt7adSc5qiRNc/hy5uxatrTpK+yG77f/9Tx7o1oyf/c3U87zucppW1w08l7
 x+2yMC1w+p5282/ndVvjE3zcIv29bjGnGzOV8WbX65gqrwo4GHlp9QWGA0lJWce/Wdj42ixS
 yVG/Unx34uGWPSf3nfRzEOBaxdNwapsFT87atvSbtzcUH5/ErL/jJUvrhm99NVyl3FNEkrPm
 HDPZNfHMhWDH7Ol7e8JUnzq7SVlJFmmq/7P5sZtP5GzH1Rn70r6eVC3mKAmLMCvrCeE5JZn+
 YKOur6dZVm5NSdzK1Hlv966OtGH7Nq2A3+F+bB9TscMzha4FSizFGYmGWsxFxYkACaOcgw8E
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnG7L8jmpBr+uiVpMfXCO0WLqpM3s
 Fm/3drI7MHvsnHWX3ePVgVXsHmfv7GAMYI7isklJzcksSy3St0vgypi9+CZrQS9vxbc5Lg2M
 27m6GDk5JARMJM7tPs3YxcjFISSwm1Gi8/M+doiEhMSk2ReYuhg5gGxhicOHi0HCQgJPGSXW
 fLAGsdkEtCT+LjzPCmKLCBhJtG7oZAKxmYFae17cAbOFgWp+XXjGBmKzCKhIvJyyjRnE5hWw
 lFgx8yg7hC0ocXLmExaQVcwCehJtGxkhxshLbH87hxniGgWJn0+XQa3Sk1h6Yh3UKhGJ2Z1t
 zBMYBWchmTQLYdIsJJNmIelYwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOLS1
 NHcwbl/1Qe8QIxMH4yFGCQ5mJRFeyRmzU4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRES
 SE8sSc1OTS1ILYLJMnFwSjUwzVgaoTRllXp/sdTf2LePu+vE6jrTJCIN/sm29WyNvl8Rfreb
 b42G5BzHpW5rXPoOcgi0bP0UftrxetntidHGhZqrktonSib9+MW0zSlrdWNN9APjzmfXJzww
 TjmTzaGQoVfLo1vON33iE95i2y3LS/20xebVzs9f+SBx79Qi3jW6Hhsdr23l0Dj3r6R78yTz
 7xItmWoLnqVyPnmXcCffn41PNHLpgUuFn1//Vi4Pf7eY+1nJZ78G2cBPE67OEbq58aTHlZnm
 kz5zNC+8tZcj+P7fc5/CvayuvLLwjdi2WfFV6eK+G/P3mF0NN5bPvLhq1RuRLqmVS2Nnuzc9
 uzEjfXLhfcZrkq78e4qLlv4MVmIpzkg01GIuKk4EABmH4uXcAgAA
X-CMS-MailID: 20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b
References: <CGME20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b@epcas1p3.samsung.com>
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

The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b63:

  Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)

are available in the git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 5631d20e2ef1008d55569790f79672ea8cc6894b:

  pinctrl: exynos: Convert to use livetree API for fdt access (2023-12-07
18:58:48 +0900)

----------------------------------------------------------------
Sam Protsenko (7):
      pinctrl: exynos: Improve coding style
      pinctrl: exynos: Extract pin parsing code into a separate function
      pinctrl: exynos: Rework pin_to_bank_base() to obtain data by name
      pinctrl: exynos: Support different register types in pin banks
      pinctrl: exynos: Refactor handling the pin related dt properties
      pinctrl: exynos: Reduce variables scope
      pinctrl: exynos: Convert to use livetree API for fdt access

Stefan Bosch (2):
      common: board_f: change calculation of gd->mon_len to fix s5p4418
reloc
      arm: s5p4418: fix relocation of vectors

 arch/arm/cpu/armv7/s5p4418/Makefile         |   3 ++
 arch/arm/cpu/armv7/s5p4418/relocate.S       |  24 +++++++++++++
 common/board_f.c                            |   2 +-
 drivers/pinctrl/exynos/pinctrl-exynos.c     | 125
+++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/pinctrl/exynos/pinctrl-exynos.h     |  36 ++++++++++++++++---
 drivers/pinctrl/exynos/pinctrl-exynos7420.c |   2 ++
 6 files changed, 136 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/cpu/armv7/s5p4418/relocate.S

Thanks,
Minkyu Kang.


