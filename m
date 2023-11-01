Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A76AC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A6F876C3;
	Wed,  1 Nov 2023 13:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="G2AklSvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96CD687C08; Wed,  1 Nov 2023 13:17:26 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C87418770E
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231101121716epoutp047e2bd8a44b4eb5dd5bf6f4c44af3cdd8~TfuwZlZld0345203452epoutp04j
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231101121716epoutp047e2bd8a44b4eb5dd5bf6f4c44af3cdd8~TfuwZlZld0345203452epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698841036;
 bh=jCFIl4rUEDHQ6vg5X/he3pOR3zq4mV+lqysnGK+2Fno=;
 h=From:To:Cc:Subject:Date:References:From;
 b=G2AklSvz3lXyo7ZV3NS3C8PEPczKtUxjvfhqC4bHvewSek6mCydJFk5fKKwMaz4KH
 Ju8Vf9IesvA97rvWjBihOzS41Q3wNEFqtQh52CJ3pL9S6DVkac5Uzqtuc8CeWlY1Zz
 srFN3D7mDdbnJXkMTHcWkuaeLsZg4zYuAdGl3eAY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231101121716epcas2p29280b9df92abb6b9e28056b1110a598e~TfuwBpQ5L1342213422epcas2p2G;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SL5bw1jVRz4x9Pt; Wed,  1 Nov
 2023 12:17:16 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 89.13.10022.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231101121715epcas2p4b7220bb22ab65f355202e36a29c8c6df~Tfuvbkm7f1631816318epcas2p4J;
 Wed,  1 Nov 2023 12:17:15 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101121715epsmtrp2f4402e69b9dfbb7480e52a9825f9536a~Tfuva9Wx42433224332epsmtrp20;
 Wed,  1 Nov 2023 12:17:15 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-59-654241cc8dfb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D4.13.18939.BC142456; Wed,  1 Nov 2023 21:17:15 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101121715epsmtip16852eeb836564614b2949c3fb4d93fa7~TfuvQ5Cui0809708097epsmtip1F;
 Wed,  1 Nov 2023 12:17:15 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v4 0/5] Add support for StarFive JH7110 TRNG driver
Date: Wed,  1 Nov 2023 21:16:47 +0900
Message-Id: <20231101121652.1865516-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmue4ZR6dUg1v32S0u79e2uPGrjdXi
 7YuzjBb3rslZvN3byW5xeOoHRovHh14zObB77Dk9i9njw8c4jzvX9rB5nL2zg9Gjb8sqxgDW
 qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAjlBTK
 EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZ
 Gb9/rmIpOMVdMb3zAnMD42uOLkZODgkBE4mvj9rZuhi5OIQEdjBK/P/9kBXC+cQoceXcIiY4
 Z+LzFlaYlvM7ljKB2EICOxkl/j7ThyiaxiRx+ONzdpAEm4CuxJbnrxhBEiICVxkl3s96wwyS
 YBbQluj8PAWsSFjAWeL3qT4wm0VAVeJvzyY2EJtXwEHi57OlLF2MHEDb5CUWP5CACAtKnJz5
 hAVijLxE89bZzCDzJQQOsUtc6bnBCFHvInHucy3EocISr45vYYewpSQ+v9vLBlFSLrFjWRJE
 awujRHPbHmaIGnuJHzensILUMAtoSqzfpQ9Rrixx5BbUVj6JjsN/2SHCvBIdbUIQjeoSB7ZP
 Z4GwZSW653yGhpSHxOz/l6EhFSuxaudUtgmM8rOQ/DILyS+zEPYuYGRexSiWWlCcm55abFRg
 DI/S5PzcTYzgVKjlvoNxxtsPeocYmTgYDzFKcDArifAeNnVIFeJNSaysSi3Kjy8qzUktPsRo
 CgzcicxSosn5wGScVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QD
 U5eH1pt52Ze/5/tf/foq7nntZVaxlQGTq5bNCK/r4t1QVpU1LYbHpCL+dZed0z7JCxN2HdV3
 6DFkypvwYcXi+LPHLNl3f2BcKyahxHI6IbBkpY+Mokrw2Y3qVpOeTJJTdL6+L6JSfE3WhXsv
 35vWqyaGL2A6+1ljgd/mraceLtLwP3w0+e+O30xzVhSbnVp3fXfLrw+CPIZbWbannDv3dvWn
 nNkJKkZz7SNfbD8z89XCZQtvPf50Ufj2lwO7I57J7q3y72+WtPncubty17eUvrTJyRN0ajMO
 87nt4Lv+TddBM47lQ2WM7ZN2CedH/p89TicGF3tYc5p+Prf3n9WWAzM8Nmr5lZ7V+P9b6KnX
 1u9KLMUZiYZazEXFiQA7yf/ADgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO5pR6dUg11HTSwu79e2uPGrjdXi
 7YuzjBb3rslZvN3byW5xeOoHRovHh14zObB77Dk9i9njw8c4jzvX9rB5nL2zg9Gjb8sqxgDW
 KC6blNSczLLUIn27BK6M3z9XsRSc4q6Y3nmBuYHxNUcXIyeHhICJxPkdS5m6GLk4hAS2M0os
 vHmZHSIhK/Hs3Q4oW1jifssRVoiiSUwSy9ubwBJsAroSW56/YgRJiAjcBOqe85UFJMEsoC3R
 +XkKWJGwgLPE71N9YDaLgKrE355NbCA2r4CDxM9nS4HqOYA2yEssfiABERaUODnzCdQYeYnm
 rbOZJzDyzUKSmoUktYCRaRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcGhqBe1gXLb+r94h
 RiYOxkOMEhzMSiK8h00dUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGanphak
 FsFkmTg4pRqY9KLzOqVL+5ZPikm8e8jrTsaB4zxSl2UC1TbWT/191bCb14c7f7Lj9m+b5d04
 z6S4xV6euePXTCNzkVObHWpjihaLTjh25FV45WUZL+MVZyxsPrB2M2oes32dbhCdIrf64MMH
 T7onJ/LYOZacTC+6eqxWv3+n7qqchPgtexfULl0gdjGOJ3/Vwj9LSm/k8kwzd5rz51vm1BiN
 sx+/J8n/flyw+atFgcyy/H2tfCsO8r8O7GhYP+PPevUFqc/nO4i9qovTuMmbLv59kfeN1NmH
 jFapMrBXXTh/0UFh97wV/1VvHw9ckO7/fuHxjbyuKw7cWzMxp1XQ8wQrz/sOH7PfOd+jN/bJ
 zpwfde3QwdDNv5RYijMSDbWYi4oTAfXsWDi8AgAA
X-CMS-MailID: 20231101121715epcas2p4b7220bb22ab65f355202e36a29c8c6df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101121715epcas2p4b7220bb22ab65f355202e36a29c8c6df
References: <CGME20231101121715epcas2p4b7220bb22ab65f355202e36a29c8c6df@epcas2p4.samsung.com>
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

This patchset adds to support StarFive JH7110 TRNG driver. Due to lack
of readl_relaxed API, the first patch tries to import the
APIs(read/write_relaxed) from Linux kernel's implementation. The second
patch adds the missing security clocks which are required by the trng
IP.

This IP can support 128-bit and 256-bit random number generation but
this patch makes 256-bit default mode for convenience.

Change from v3:
- Patch #3: Make one call to generate random number according to 128 or
256 bits of entropy which is suggested by Heinrich.

Changes from v2:
- Patch #3: Add error handling codes of probe() which are suggested by Jaehoon

Changes from v1:
- Patch #3: Apply Heinrich's reviews and his codes
- Patch #5: Add Heinrich's R-b tag

Chanho Park (5):
  riscv: import read/write_relaxed functions
  clk: starfive: jh7110: Add security clocks
  rng: Add StarFive JH7110 RNG driver
  riscv: dts: jh7110: Add rng device tree node
  configs: visionfive2: Enable JH7110 RNG driver

 arch/riscv/dts/jh7110.dtsi             |  10 +
 arch/riscv/include/asm/io.h            |  45 ++++
 configs/starfive_visionfive2_defconfig |   2 +
 drivers/clk/starfive/clk-jh7110.c      |  10 +
 drivers/rng/Kconfig                    |   6 +
 drivers/rng/Makefile                   |   1 +
 drivers/rng/jh7110_rng.c               | 274 +++++++++++++++++++++++++
 7 files changed, 348 insertions(+)
 create mode 100644 drivers/rng/jh7110_rng.c

-- 
2.39.2

