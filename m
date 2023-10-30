Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6E9C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 07:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF633879E9;
	Mon, 30 Oct 2023 08:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="MnCklONf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6922B879DE; Mon, 30 Oct 2023 08:32:38 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23991870BB
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231030073228epoutp037db7dcd727e05b996603d17cbe442c87~S0jhJgQ0T2229922299epoutp034
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 07:32:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231030073228epoutp037db7dcd727e05b996603d17cbe442c87~S0jhJgQ0T2229922299epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698651148;
 bh=ZN6HbPneZ7bo89fFw1a/fS/BrnHKktYrk16MRMPHdZo=;
 h=From:To:Cc:Subject:Date:References:From;
 b=MnCklONfqyJt8Fi8GQSADf0uwWg8f2S+quzROeNEd83QRwpaRs3kG4N5SNJ1s0wip
 FeR6REY6mDaLU2OhYVGLQTpEmMFK+m+0IXct4eivNtclB8HSkcudJhNm81UvW8LEsz
 cEeTxpl5zNb/8BvQdOfzo14RSsL2qji+J+dXhewI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231030073228epcas2p1223a0e03ab8241bed048a44801e778c4~S0jgsv11Y1598115981epcas2p1p;
 Mon, 30 Oct 2023 07:32:28 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SJlNC635Yz4x9QL; Mon, 30 Oct
 2023 07:32:27 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 8D.05.10006.B0C5F356; Mon, 30 Oct 2023 16:32:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231030073227epcas2p4f230c08383b49e4ae5bf879575c65732~S0jgHG4PA2578825788epcas2p4k;
 Mon, 30 Oct 2023 07:32:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231030073227epsmtrp19f73aaacad716975ea352237191265b0~S0jgGEnBZ0603106031epsmtrp1h;
 Mon, 30 Oct 2023 07:32:27 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-a0-653f5c0badbd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C0.04.07368.B0C5F356; Mon, 30 Oct 2023 16:32:27 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231030073227epsmtip1049db1583fe5be03d2ab0978aff546f4~S0jf6KXp11001810018epsmtip1a;
 Mon, 30 Oct 2023 07:32:27 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 0/5] Add support for StarFive JH7110 TRNG driver
Date: Mon, 30 Oct 2023 16:31:59 +0900
Message-Id: <20231030073204.150030-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmhS53jH2qQdNEQ4vL+7Ut3r44y2hx
 75qcxdu9newWh6d+YLR4fOg1kwObx57Ts5g9PnyM87hzbQ+bx9k7Oxg9+rasYgxgjcq2yUhN
 TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
 SCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzuj+Oo+p
 4CVHxfVPp9kaGK+xdTFyckgImEhM7HjK0sXIxSEksINR4v6236wQzidGiakvZ7KDVAkJfGOU
 2PpWEKbjwoL5zBBFexklrr+axQ7hTGOSmHbtPDNIFZuArsSW568YQRIiAqsZJbbtbwYbxSyg
 LdH5eQqYLSzgING89QwTiM0ioCpx8Mk9oGYODl4Be4k9DbwgpoSAvMTiBxIgFbwCghInZz5h
 gZgiD9Q5G+wICYFj7BK3Z15jgrjORWLd1z/MELawxKvjW9ghbCmJl/1t7BAzyyV2LEuC6G1h
 lGhu2wNVby/x4+YUVpAaZgFNifW79CHKlSWO3IJayyfRcfgv1BReiY42IYhGdYkD26ezQNiy
 Et1zPrNC2B4SF35/YIUEYazE/QV3WCYwys9C8swsJM/MQti7gJF5FaNYakFxbnpqsVGBITxK
 k/NzNzGCE6CW6w7GyW8/6B1iZOJgPMQowcGsJMLL7GiTKsSbklhZlVqUH19UmpNafIjRFBi4
 E5mlRJPzgSk4ryTe0MTSwMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGpv08
 8y8p2U3Mat/Fc9Hg7/v98xM2T248wKM09VGoj5ho3pLljz4tFs56H1DgfFjzo9pVNYdmhpz5
 u9+zLIzP59i/I23vbC2R2ZFLbqaYRDee8LFfGGBz+2DIplPsh6f/CGK+5BPbwJDwXevAoeMR
 Dw9edy19uS9lsvbshXsPLVj6PVDs6Ontc29sD74uMu18JKuDQvyb7Q3+Gb+rP9XxntzPban5
 7caPH0I/D8Rfay+d8Ovnu9LUUs5Dq21sdhWfM20SP+qd/U3JWffj2bknEnb+uX425db1/zHf
 b8lEbvOZ1XMg/1hCz6SOreKeuuXc7zPzYg3q9f8Z9FtUpjy3fJB/dN/tS+tUPWtsejYX5Roq
 sRRnJBpqMRcVJwIAhtKzEgkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSnC53jH2qwdHDchaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGsVlk5Ka
 k1mWWqRvl8CV0f11HlPBS46K659OszUwXmPrYuTkkBAwkbiwYD5zFyMXh5DAbkaJH9N2MkEk
 ZCWevdvBDmELS9xvOcIKUTSJSaLn5ldWkASbgK7EluevGEESIgLrgbqXvwdLMAtoS3R+ngLW
 LSzgING89QzYVBYBVYmDT+4BrePg4BWwl9jTwAtiSgjISyx+IAFSwSsgKHFy5hMWiCnyQJ2z
 mScw8s1CkpqFJLWAkWkVo2RqQXFuem6yYYFhXmq5XnFibnFpXrpecn7uJkZwWGpp7GC8N/+f
 3iFGJg7GQ4wSHMxKIrzMjjapQrwpiZVVqUX58UWlOanFhxilOViUxHkNZ8xOERJITyxJzU5N
 LUgtgskycXBKNTDtn+xUaKZ4+KPtJhGh+bK+qr9equpv9xCw/RI0f6Fi7s/bk/xDPh76s2uT
 4vTL0rsbZxsfk6/jt3V/uGNb9bK6wkl/lri99Wt0XSlVdMGkXptlnc5ivYJlTw3CZ324xB1c
 cVWrVENHJ+DvsrnTo6a7iL1X+hCvfDJlzmr1wwVu940XLJ1we2m39P/GH2nlj3+Yr1n2/3f3
 nrIA5YwE/8DDTE6mzhu27uEtX6ct28y/l/1UhNn7zQeUj8f8lO+22svusKtJrXtzXnL/j864
 PRP+SIgzbjVvfbfC4KmNYGfDgb02Qj+FeDazuH6anpbB5l5aqfwo76PjrV3NYvM59lwuSA/h
 1Q5YcvxlSSnfWnYlluKMREMt5qLiRAC9eBD4ugIAAA==
X-CMS-MailID: 20231030073227epcas2p4f230c08383b49e4ae5bf879575c65732
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231030073227epcas2p4f230c08383b49e4ae5bf879575c65732
References: <CGME20231030073227epcas2p4f230c08383b49e4ae5bf879575c65732@epcas2p4.samsung.com>
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
 drivers/rng/jh7110_rng.c               | 272 +++++++++++++++++++++++++
 7 files changed, 346 insertions(+)
 create mode 100644 drivers/rng/jh7110_rng.c

-- 
2.39.2

