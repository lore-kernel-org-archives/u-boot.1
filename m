Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9023AC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 23:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E1D87BB3;
	Wed,  1 Nov 2023 00:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ugT55GMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C2B087B85; Wed,  1 Nov 2023 00:56:15 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A921D87B6C
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epoutp03cadff8574df19163db1fa3e8bf97224a~TVndTxUez2681526815epoutp03W
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231031235554epoutp03cadff8574df19163db1fa3e8bf97224a~TVndTxUez2681526815epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698796554;
 bh=URCyZ2ChWTd0cTynCIPY0Cm3BJiq3O7QEsaIokYejzk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ugT55GMqMSjjsn/sxBLu8TBUsUqH30Bl81+J28WVa22MCxwFtVKK3tTJyWnnbfn/b
 jqF2isohDhTREnIJ1VNeYYx6bqmgY0PdVGfLhi4isUQIgTOPA49Bz2b+vOFYYWTAdy
 r7f+KMHqTzRdJ7MPJIX77PcD7+HRIc5TWthki2ko=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epcas2p12a8a6eaf3b428b682ff71455799fef29~TVnc2i1MS1940019400epcas2p1P;
 Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.68]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SKn8T6sWbz4x9Q2; Tue, 31 Oct
 2023 23:55:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 CE.B8.09622.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epcas2p259c4d5c4aede7c48a12e4c12e674ef5e~TVncEpWuT0647406474epcas2p20;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031235553epsmtrp16a2ca02578c99c0088fab3ec7292d23d~TVncD_zQB1700217002epsmtrp1X;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-a4-654194099383
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F1.68.07368.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epsmtip194b8844fecc82f8c5a857787cd17be07~TVnb2qbAk0166001660epsmtip1-;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 5/5] configs: visionfive2: Enable JH7110 RNG driver
Date: Wed,  1 Nov 2023 08:55:30 +0900
Message-Id: <20231031235530.1500393-6-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031235530.1500393-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQpdzimOqwZKpFhaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGpVtk5Ga
 mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
 kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQndG7tZ2l
 4BNrxfqzK5gbGKezdjFyckgImEhcOzWFqYuRi0NIYAejxMruqVDOJ0aJV1N2MkM43xglJrVc
 hGt5uPUSVGIvo8SB2y/ZQRJCAtOYJD5tLQOx2QR0JbY8f8UIUiQisJpRYtv+ZrAiZgFtic7P
 U8BsYQE3iav/u1hAbBYBVYk1c5Yxgti8Ag4Slw9dAKrhANomL7H4gQRImFPAUeLU2XdsECWC
 EidnPmGBGCkv0bx1NthBEgL32CX+nG5lhLjUReLxsadQVwtLvDq+hR3ClpJ42d8GNb9cYsey
 JIjeFkaJ5rY9zBA19hI/bk5hBalhFtCUWL9LH6JcWeLILai1fBIdh/9CTeGV6GgTgmhUlziw
 fToLhC0r0T3nM9QBHhKvHk6FBtsURokbG6cxT2BUmIXkm1lIvpmFsHgBI/MqRrHUguLc9NRi
 owIjeAQn5+duYgQnRy23HYxT3n7QO8TIxMF4iFGCg1lJhPewqUOqEG9KYmVValF+fFFpTmrx
 IUZTYFBPZJYSTc4Hpue8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4
 pRqYLN5kpu90Uv506mbiHL1QdtcYzl7N+XxP5/1K65zKZjPZ/KSf1vJtx64YJqTkTnu8rcHN
 4BB3zepdYVdOfP33f9rrPf5zDjy9p3Ry9a/J0o3LEzbvyNE139vx/wD75qV/uv7Iz6q8uFVv
 /xWlBz490fX/735xPVYvcfwcn1LPCuN7oqZzft5/xNepMLOA8auwg7nzbYYn840NHNkUNi7j
 PflcL85e/MHTI+uV1aY/5eNqd7utrH7iQZK97eG0k7Fv9Y/stmG63nvEpUUpYK3uKs6nWyZ+
 260p+Pvllr08iz/9nZhXZx27T/n+IsP/U3P3evRL7yyL2HZgKWOn7P3+ZWGL6n58/sf+8uDv
 k9XMTh1KLMUZiYZazEXFiQBjm/13FwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnC7nFMdUg0u3FS0u79e2ePviLKPF
 vWtyFm/3drJbHJ76gdHi8aHXTA5sHntOz2L2+PAxzuPOtT1sHmfv7GD06NuyijGANYrLJiU1
 J7MstUjfLoEro3drO0vBJ9aK9WdXMDcwTmftYuTkkBAwkXi49RJzFyMXh5DAbkaJEyfb2SES
 shLP3u2AsoUl7rccYYUomsQkse/OUrBuNgFdiS3PXzGCJEQE1jNK/Fj+HizBLKAt0fl5Cli3
 sICbxNX/XSwgNouAqsSaOcsYQWxeAQeJy4cuANVwAG2Ql1j8QAIkzCngKHHq7Ds2EFsIqOTD
 xEnsEOWCEidnPmGBGC8v0bx1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc9NNiwwzEst1ytOzC0u
 zUvXS87P3cQIDmQtjR2M9+b/0zvEyMTBeIhRgoNZSYT3sKlDqhBvSmJlVWpRfnxRaU5q8SFG
 aQ4WJXFewxmzU4QE0hNLUrNTUwtSi2CyTBycUg1Md9acSnj0JEsw5Khqv6STRvGiWZalnJ8F
 zt8+sWf+lJnrYo78/WNwvuxX6JEND0te/04I0xD3LNyu8raYxU584e7/O/u8VwWsupb7OnpJ
 97T4HrOXIqa/rzQ33FvBxpat8qmE37xm5SQZg9CgS6dOez5T/tq3wVbp1r83M9e18Vqxz923
 OmH3krVKYqFpJXzP5daofn0fGMAku4L3yU+jicKcbLHsL+ZOV6nfITJjyYQVZxUNGneJJbxt
 fMWtNv8Ek9rVrfXBP1x1X9z/Hrt62xaXjJth3lozgpz2JontLysMmPfaqOj9/iX3uo5UuD2/
 dVi1Xd6q+Jn626rrR+V+NStfvp3tWMgkX2Dy07e/X4mlOCPRUIu5qDgRAD9BVsDTAgAA
X-CMS-MailID: 20231031235553epcas2p259c4d5c4aede7c48a12e4c12e674ef5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031235553epcas2p259c4d5c4aede7c48a12e4c12e674ef5e
References: <20231031235530.1500393-1-chanho61.park@samsung.com>
 <CGME20231031235553epcas2p259c4d5c4aede7c48a12e4c12e674ef5e@epcas2p2.samsung.com>
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

