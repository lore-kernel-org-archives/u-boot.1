Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB0BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8795387500;
	Tue, 31 Oct 2023 09:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="pvnyjT/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3AF787576; Tue, 31 Oct 2023 09:56:35 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C923087184
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031085624epoutp03c5e7152c699fcee4566ab46c38d6a044~TJWFVMlBh2960529605epoutp03F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:56:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031085624epoutp03c5e7152c699fcee4566ab46c38d6a044~TJWFVMlBh2960529605epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698742584;
 bh=cnMdnCF5XOSdgkZNID1awK47097dfEK+qPL8hGgqPDY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=pvnyjT/3BtOsTbgnbPx4EyM5XrfhoFXNWTFpmAyHMpUT33J4jWt89BjRUnLJAq05U
 IAXCa3NHQgMuB3dtYXrI0tw2anWuUOMBSOCdeOoMCTCYCPQXQmjIkkZUVmk4oB9Io9
 zbBHsFTot9VIzPilxLCHg2f9SqI6+zEJEkrUZK4g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231031085623epcas2p16907a08dc4d3859f6c1f06f9ef90b0de~TJWE2Wn9a1478214782epcas2p1t;
 Tue, 31 Oct 2023 08:56:23 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.92]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKPBb2GwYz4x9Q7; Tue, 31 Oct
 2023 08:56:23 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 80.A8.18994.731C0456; Tue, 31 Oct 2023 17:56:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231031085622epcas2p251a9e541045f5d4eae1b6059e9a5bc00~TJWD4fdqR0813908139epcas2p2x;
 Tue, 31 Oct 2023 08:56:22 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031085622epsmtrp2be22fe62a383df13eea94099c0212745~TJWD38o9r1663616636epsmtrp2S;
 Tue, 31 Oct 2023 08:56:22 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-00-6540c137b170
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 59.BC.07368.631C0456; Tue, 31 Oct 2023 17:56:22 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031085622epsmtip1bfb9fdd1ce016a00fb5b753906d4aa39~TJWDmyxKs2518925189epsmtip1i;
 Tue, 31 Oct 2023 08:56:22 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 0/2] Support JTAG for VisionFive2 board
Date: Tue, 31 Oct 2023 17:55:58 +0900
Message-Id: <20231031085600.992544-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmua75QYdUg583+Cwu79e2ePviLKPF
 272d7BY/uh4xWjw+9JrJgdVjz+lZzB5n7+xg9OjbsorR4/ZZ3gCWqGybjNTElNQihdS85PyU
 zLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKC1SgpliTmlQKGAxOJiJX07m6L8
 0pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTsjAvHf7AWTGKp6P78jqWB
 cR1zFyMnh4SAiURv02f2LkYuDiGBPYwSU58vZARJCAl8YpRYe18EIvGNUWLWolmsMB3L256x
 QxTtZZT4MTsZomgak8SCp1/AxrIJ6Epsef6KESQhItDKKPH+5WGwscwC2hKdn6eAdQsLmEvc
 //2bDcRmEVCV2D3lCFgzr4C9RPO0SUxdjBxA2+QlFj+QgAgLSpyc+YQFYoy8RPPW2cwg8yUE
 trFLfF53iR3iOheJC1db2SBsYYlXx7dAxaUkPr/bywYxs1xix7IkiN4WRonmtj3QsLCX+HFz
 CitIDbOApsT6XfoQ5coSR25BreWT6Dj8lx0izCvR0SYE0agucWD7dBYIW1aie85naFB5SPya
 sAJsoJBArMTezoQJjPKzkPwyC8kvsxDWLmBkXsUolVpQnJuemmxUYKibl1oOj9Xk/NxNjOCk
 p+W7g/H1+r96hxiZOBgPMUpwMCuJ8B42dUgV4k1JrKxKLcqPLyrNSS0+xGgKDOCJzFKiyfnA
 tJtXEm9oYmlgYmZmaG5kamCuJM57r3VuipBAemJJanZqakFqEUwfEwenVAPTFJY0r0jFQ6/9
 BKfemHb5z72dm9ljj7KutHPgfTWdXX4rr+ncCe65jY41ERc+P5mwPFFgrzmb6rfir79s5hx2
 Omke8SVzFkvN1wTmm4JpMQqWQdOefd8oFl+wPf4W90vFdf87rxgsvHDv+ey/7EHaH9Ye5NDY
 xNz30VGf7UXZUSFu7oD2Cft1zT53iIc/XmI9WXcVg9NSP+aO2jeedywPlt/ST/k+u356r/vt
 He9DNjKvvFmhITp7zWGzvZFq32c/YE5ce0wwnV3bVOGValJfXLvjRI/eX6VdrRPOqe1V9Psc
 FcL1J50/Zt6aLZu1z71kNYl/tchLWih6XVhav+5xNqel+78XfnKTNLwdtc1biaU4I9FQi7mo
 OBEAcNhijQMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSnK7ZQYdUg//vtC0u79e2ePviLKPF
 272d7BY/uh4xWjw+9JrJgdVjz+lZzB5n7+xg9OjbsorR4/ZZ3gCWKC6blNSczLLUIn27BK6M
 C8d/sBZMYqno/vyOpYFxHXMXIyeHhICJxPK2Z+xdjFwcQgK7GSWe7dzMBJGQlXj2bgc7hC0s
 cb/lCCtE0SQmiW0t39lAEmwCuhJbnr9iBLFFBDoZJVa/KwKxmQW0JTo/TwFrFhYwl7j/+zdY
 PYuAqsTuKUfANvMK2Es0T5sEtIwDaIG8xOIHEhBhQYmTM5+wQIyRl2jeOpt5AiPfLCSpWUhS
 CxiZVjFKphYU56bnJhsWGOallusVJ+YWl+al6yXn525iBAehlsYOxnvz/+kdYmTiYDzEKMHB
 rCTCe9jUIVWINyWxsiq1KD++qDQntfgQozQHi5I4r+GM2SlCAumJJanZqakFqUUwWSYOTqkG
 JrsHuk5bQme9lZ1WUeng71s1d7dhMtfXy6uDpt1fvLbW8oGh94mM+9udnr0+rB/0UPOzlXf0
 gW0yuQ8n/A2b5XFGo/LWvNn1O3bY1HkY9twMtZ0RMIddUyfmc1DY5i1nC3J1ZZ5u2jTfddf3
 rDz1mSZn9V6U6/LsVjTtbflyq7duSuCV7PzHiR3qOZxLKk/csT3ga3xZ6qdRgUdYYVbNrx/X
 RVof91fO/NMTsOleSdknHhPW99uffmHL2lP4cPY9uTvy53u1S37c1dzt38nvMoVF9d501dTC
 r/fzg47r1e+YvTRd88FjJ/P7LAJxyUeXbGJo5L0QkyKUdfcj5zQtk4UTJNLuRfGt779cdsbc
 RImlOCPRUIu5qDgRAIePhIuxAgAA
X-CMS-MailID: 20231031085622epcas2p251a9e541045f5d4eae1b6059e9a5bc00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031085622epcas2p251a9e541045f5d4eae1b6059e9a5bc00
References: <CGME20231031085622epcas2p251a9e541045f5d4eae1b6059e9a5bc00@epcas2p2.samsung.com>
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

To support JTAG for VisionFive2 board, we need to control JTAG pins by
S/W. spl_board_init_f function seems to be proper place to initialize
these pins.

Chanho Park (2):
  riscv: cpu: jh7110: Add gpio helper macros
  board: starfive: spl: Support jtag for VisionFive2 board

 arch/riscv/include/asm/arch-jh7110/gpio.h | 85 +++++++++++++++++++++++
 board/starfive/visionfive2/spl.c          | 23 ++++++
 2 files changed, 108 insertions(+)
 create mode 100644 arch/riscv/include/asm/arch-jh7110/gpio.h

-- 
2.39.2

