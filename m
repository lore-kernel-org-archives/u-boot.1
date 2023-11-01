Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518F3C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 12:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F346D87CF1;
	Wed,  1 Nov 2023 13:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="sPRo0q5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FF8987649; Wed,  1 Nov 2023 13:17:32 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89AB87B68
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 13:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231101121718epoutp0159179ce3d5e2c6fe7aa6d9cccbb3d5f7~TfuxfYI7W1980119801epoutp01h
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:17:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231101121718epoutp0159179ce3d5e2c6fe7aa6d9cccbb3d5f7~TfuxfYI7W1980119801epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698841038;
 bh=URCyZ2ChWTd0cTynCIPY0Cm3BJiq3O7QEsaIokYejzk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sPRo0q5h0cOLNT3WvnwKOardoP2A/znopaCcPPtCQ8ob8Awi34UTV8/C7cKv58o/Z
 7L85XZFZ/tWlOpJvjOSp8y3welgvoB0o5kbrc8Q7lZhhMxkerCrKmqacs3ebFtJ6e2
 KZXDSBAjxkm68FEFg2uinfnEPm88iuBq1aldK1mk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231101121717epcas2p15a8b1db6269bc51fd570ae8f56bc91e8~TfuxLzX641934619346epcas2p1k;
 Wed,  1 Nov 2023 12:17:17 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.92]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4SL5bx283Vz4x9Pr; Wed,  1 Nov
 2023 12:17:17 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 AB.A2.09622.DC142456; Wed,  1 Nov 2023 21:17:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231101121716epcas2p4113a10a1aa252d953f3c08e604bf8a3c~Tfuv7rgS_1194811948epcas2p4h;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101121716epsmtrp24bb4ad2292e0cccc906b6a90f5f75d83~Tfuv60Dhy2459324593epsmtrp2N;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-5b-654241cde796
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BF.68.08755.CC142456; Wed,  1 Nov 2023 21:17:16 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101121716epsmtip10533f23431661fc717bb5f3fccd17fae~TfuvvASjW0849508495epsmtip1E;
 Wed,  1 Nov 2023 12:17:16 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v4 5/5] configs: visionfive2: Enable JH7110 RNG driver
Date: Wed,  1 Nov 2023 21:16:52 +0900
Message-Id: <20231101121652.1865516-6-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101121652.1865516-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTXPeso1OqwedlvBaX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
 iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTs
 jN6t7SwFn1gr1p9dwdzAOJ21i5GTQ0LAROLa9FksXYxcHEICOxglln8/yAzhfGKUeP9uLyuE
 841R4svMl3At587thErsZZRY8+YlVP80Jom3816wg1SxCehKbHn+ihEkISJwFWjWrDfMIAlm
 AW2Jzs9TwIqEBdwkXq34wwRiswioSnSuPwO2glfAQWLy7stANRxA6+QlFj+QAAlzCjhKXG1e
 zwxRIihxcuYTFoiR8hLNW2eD3S0h8Ihd4vfdu+wQp7pIXO6/DmULS7w6vgXKlpL4/G4vG8T8
 cokdy5IgelsYJZrb9jBD1NhL/Lg5hRWkhllAU2L9Ln2IcmWJI7eg1vJJdBz+C3Ulr0RHmxBE
 o7rEge3TWSBsWYnuOZ+h4eYh8er2HmjoTmGU6L89nXkCo8IsJN/MQvLNLITFCxiZVzGKpRYU
 56anFhsVGMFjODk/dxMjOFFque1gnPL2g94hRiYOxkOMEhzMSiK8h00dUoV4UxIrq1KL8uOL
 SnNSiw8xmgKDeiKzlGhyPjBV55XEG5pYGpiYmRmaG5kamCuJ895rnZsiJJCeWJKanZpakFoE
 08fEwSnVwOSXzJl1eaYdyy5bpnBZHXbBP1cjJ28Mt9hg6rnYtt+V/baXa/Nm35kdgnvduPP7
 Q90ui3NnSh54UX+5z7RXbbF614EcKYf7AszbQ+tiQ0wXndgp6hvd5OJieuyH49ED0YuOLEgt
 dLnL8ZDp2Lao9M4Dgf9L7m77/NN9WeFLu8J5HDc3dZiWSryTPfP7kMCebr1GxvUJV39P4whc
 92yhnCy35LsnS+PCLygkRl9NuZY/f9+Hqwt6HkVm12zduO3Yzk22L2zMOxXMf4aa+6lr3PrH
 X6pw3PxT4+wv9QrtbQemMSTlRT6qSXe9qx2r76Af/iR56hPlaYvm9Wu0TItt+b9sQ/v+tPS0
 oppjcSKnlFiKMxINtZiLihMBvljy+B0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO4ZR6dUg/u3JSwu79e2uPGrjdXi
 7YuzjBb3rslZvN3byW5xeOoHRovHh14zObB77Dk9i9njw8c4jzvX9rB5nL2zg9Gjb8sqxgDW
 KC6blNSczLLUIn27BK6M3q3tLAWfWCvWn13B3MA4nbWLkZNDQsBE4ty5nUA2F4eQwG5Gib7m
 fewQCVmJZ+92QNnCEvdbjkAVTWKSaLw+jxEkwSagK7Hl+StGkISIwE1GiYVzvrKAJJgFtCU6
 P08B6xYWcJN4teIPE4jNIqAq0bn+DNhqXgEHicm7LwPVcABtkJdY/EACJMwp4ChxtXk9M4gt
 BFTybsl7NohyQYmTM59AjZeXaN46m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5qWW6xUn
 5haX5qXrJefnbmIEh7SW5g7G7as+6B1iZOJgPMQowcGsJMJ72NQhVYg3JbGyKrUoP76oNCe1
 +BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwenVAPTygPaqqbpjf8M2APVhDI2THk7+dl2
 DttddY3ynqfWb+eQyA5Y+GyTTNmDrl16Oxg+dwYHBYhON5G66tXx16al9uWLedYzsxhTI64d
 Tt+vGKja9nW/XrDiC9PN0X4vr62a9l7ztpT6hIjplheUpxX/un5j7aODR9ev8guborLQdcE9
 q8Cv55bdO2y/rynjusm23riUT++EjVjqtd/zxEv0vmGweK0VxBqYvG5n5f6tf6wCsguTPrio
 5SSa8vQ/Npm5R8zR8dMu3a7Y7eKtFz+5l1Vlt123Pvi/avPLJTekqzN1n6+863jUQ7D54olo
 3vnmySzL1kj2ruJvzJulemFBXqx9V8mSqc9FE6aJfZZWYinOSDTUYi4qTgQA5jPf5dgCAAA=
X-CMS-MailID: 20231101121716epcas2p4113a10a1aa252d953f3c08e604bf8a3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101121716epcas2p4113a10a1aa252d953f3c08e604bf8a3c
References: <20231101121652.1865516-1-chanho61.park@samsung.com>
 <CGME20231101121716epcas2p4113a10a1aa252d953f3c08e604bf8a3c@epcas2p4.samsung.com>
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

