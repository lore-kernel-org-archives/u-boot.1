Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF1CC4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 23:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0492887B8B;
	Wed,  1 Nov 2023 00:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="GKa5GKho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51016879E2; Wed,  1 Nov 2023 00:56:01 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACF987B48
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epoutp03e2ba3742d1fe89bda2c1207da0d50b9b~TVnckPSFk2688126881epoutp03L
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031235554epoutp03e2ba3742d1fe89bda2c1207da0d50b9b~TVnckPSFk2688126881epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698796554;
 bh=v4+ng8dV90pZDx1doAeTw27BAIjwoB2d0QuHNQowivk=;
 h=From:To:Cc:Subject:Date:References:From;
 b=GKa5GKhovdw2rKKseBlVgSaX36Vv66cJUccB0mWaPJ/XudQ91wD/3BUTiZJTFxkem
 /D6J9jTF1CE4Ev7VnohOLWza1GBkkUhDRHI0LN+NU+EslYSECCR52QQ0dR4bkVt4DB
 9nwltYNF+Y63U0WtAasTFozRoDJMEVtufqKDo+zg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231031235553epcas2p26c998f3e55872d5c6b88ae465d9e9cc8~TVncTKMGn3152231522epcas2p21;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.90]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKn8T3g7Rz4x9Q2; Tue, 31 Oct
 2023 23:55:53 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 39.91.18994.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epcas2p3169e9a40b2b9783171f2f3e96d823dbf~TVnblzwWY0386503865epcas2p3F;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031235553epsmtrp1993b4331ded22ec38f8989aa26110b1a~TVnblN5Vj1667516675epsmtrp1x;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-f9-6541940922be
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 11.68.07368.80491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031235552epsmtip1ac5ce4cb9979f0c37230d8a127b1de42~TVnbXwJ3b0338903389epsmtip1r;
 Tue, 31 Oct 2023 23:55:52 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 0/5] Add support for StarFive JH7110 TRNG driver
Date: Wed,  1 Nov 2023 08:55:25 +0900
Message-Id: <20231031235530.1500393-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmqS7nFMdUgzkbxC0u79e2ePviLKPF
 vWtyFm/3drJbHJ76gdHi8aHXTA5sHntOz2L2+PAxzuPOtT1sHmfv7GD06NuyijGANSrbJiM1
 MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
 ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+Nw1ye2
 gmucFQd+JTcwrmbvYuTgkBAwkVjT79jFyMkhJLCHUeLDblYI+xOjxKefBl2MXED2N0aJiXPO
 s4MkQOrbHrexQiT2MkrcXtHECNExjUni/R1BEJtNQFdiy/NXjCBFIgKrGSW27W8G62YW0Jbo
 /DwFzBYWcJbo6F/ECnIFi4CqxKX9dSAmr4CDxOUOCYjb5CUWP5AAKeYVEJQ4OfMJC8QQeYnm
 rbOZIc45xC7R9V0YwnaRuNvRDHWmsMSr41ugbCmJl/1tUO+WS+xYlgRymIRAC6NEc9seqDn2
 Ej9uTgE7hllAU2L9Ln2IcmWJI7egtvJJdBz+CzWFV6KjTQiiUV3iwPbpLBC2rET3nM+sELaH
 xLQJ91ggQRMrcaLhI/sERvlZSH6ZheSXWQh7FzAyr2KUSi0ozk1PTTYqMNTNSy2HR2hyfu4m
 RnDy0/Ldwfh6/V+9Q4xMHIyHGCU4mJVEeA+bOqQK8aYkVlalFuXHF5XmpBYfYjQFBu9EZinR
 5Hxg+s0riTc0sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoHJ48iS1Q93
 /ruzseHfdt7/sZN/HajRPlC7wyVd/0mMWtRjpg1cs289zZtU7Vv2rOrvNRWWG/yLv3KuTFu5
 9LmSIXfrnN/Laye7O5s/DNeVqpy439dI6fWZWcfVDT+7J0sqPjw+sbhq0vfLE7ubgm5P6k1Z
 5VdQeniWOpvWxZodZd0zHgf43FyeWL0siK3/QZ7vxip78903ZYwiG1uOrP7z3KNEMGt7g8kv
 ef4DrG1VSq5TW74zMud8sbp6T+fi4u1i9sd/z362WL9EWdrvuliS4Myd6tmTDqRPPHVsebRk
 UIlF54sVC/MSZezCppm9P/dzoo3FWqnd3zos2QSDJ3DnnG55Hrrxxo7uJfNc5LknKrEUZyQa
 ajEXFScCANa9rj4HBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnC7nFMdUg38vGC0u79e2ePviLKPF
 vWtyFm/3drJbHJ76gdHi8aHXTA5sHntOz2L2+PAxzuPOtT1sHmfv7GD06NuyijGANYrLJiU1
 J7MstUjfLoEr43DXJ7aCa5wVB34lNzCuZu9i5OSQEDCRaHvcxgpiCwnsZpS41OcDEZeVePZu
 B1SNsMT9liNANVxANZOYJGZ8P8cCkmAT0JXY8vwVI0hCRGA9o8SP5e/BJjELaEt0fp4C1i0s
 4CzR0b8IKM7BwSKgKnFpfx2IySvgIHG5QwLElBCQl1j8QAKkmFdAUOLkzCcsEEPkJZq3zmae
 wMg3C0lqFpLUAkamVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwQGppbGD8d78f3qH
 GJk4GA8xSnAwK4nwHjZ1SBXiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampB
 ahFMlomDU6qB6bjgkrjI167PdT91zrj/TVim/8OaL/kXJXYcfSFh1KL7Y/J1z++NKrr8RtOc
 fs+s31t7RCZRL6ongFU1NH1+fgyvic3ni90R61NMFU/cOTW1+2phXpXPpEy2ZZqfd3Q5sxl3
 cHp3Rft1RP3sfTw7VbGNSYv5/QzGvs4VL7+fmr7u28sbW8vF/87790eMY763keSkuaraXyt2
 On5hW7tVaZ+Xd7XRavVW/dUl769vjY7gy9rExuFpdcMq+/HsT0yZGUu8m1mF/vtumNtob7N3
 8ectM/LDX7gxxddPvd5c8rroG+vcGbaPPW7vl5eq+M6UkLQsc9OHR1NNdrfen7Zz2lrzU1+1
 CteU8E7b9/w7gxJLcUaioRZzUXEiADvYBaK3AgAA
X-CMS-MailID: 20231031235553epcas2p3169e9a40b2b9783171f2f3e96d823dbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031235553epcas2p3169e9a40b2b9783171f2f3e96d823dbf
References: <CGME20231031235553epcas2p3169e9a40b2b9783171f2f3e96d823dbf@epcas2p3.samsung.com>
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
 arch/riscv/include/asm/io.h            |  45 +++++
 configs/starfive_visionfive2_defconfig |   2 +
 drivers/clk/starfive/clk-jh7110.c      |  10 +
 drivers/rng/Kconfig                    |   6 +
 drivers/rng/Makefile                   |   1 +
 drivers/rng/jh7110_rng.c               | 258 +++++++++++++++++++++++++
 7 files changed, 332 insertions(+)
 create mode 100644 drivers/rng/jh7110_rng.c

-- 
2.39.2

