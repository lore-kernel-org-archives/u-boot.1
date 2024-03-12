Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF4FC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB68587FA0;
	Tue, 12 Mar 2024 21:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jUN6gd6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02E9387F6A; Tue, 12 Mar 2024 21:20:48 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9916887F78
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTCR004641;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=0xZGsMsE6e7xP2Iju3E5JXJac2vnOjKPorofsgZwkZ4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=jUN6gd6FXDemTake6JTLd1PFzJ0bPqD/NqjmgW00Tp8mTzj5KR1kqO364Nu+kvJVw
 7bkXhoIH9H96ZZiF0mdqg7HikSpvp6u2s52i156vJPpgnO8KQiMLPdRgoeGJsDZ9J7
 G1xFZrvjDHZAunE4RwB+kWegIAout7/hLMOsH1fE=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKTmk038141
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:28 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKSJ3097253;
 Tue, 12 Mar 2024 15:20:28 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:22 -0500
Subject: [PATCH v4 04/13] ram: k3-ddrss: enable the am62ax's DDR controller
 for am62px
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-4-fa772bfa623b@ti.com>
References: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=bb@ti.com;
 h=from:subject:message-id; bh=kzhsENR8zAxYf4DbhGgg38aVs6xp91l3v9RbggdC5PU=;
 b=owNCWmg5MUFZJlNZKxLRYwAAZ3////fN9uP57L//p/devh/fUf+//W0yif9v/9nc7979132wA
 Rs1B2oAGgaGmjQNAAABpoGgAAGg0DRoAAAAAPUZANNA0Bk0/VDCDI9DUZ6UQAABoBoANBp6gA0e
 oA00HqNB6QBoZAGj1GjQ9Rpk0GgANAZNNB6htIeiAbUBpocJoDQ0NNMjExANGJpiGmQBo0Bk00A
 YTEGQDAQNA0ABoaBoZMgAAaBoaAgR+5AtWFf1Ng+hoT6h8Ds3vsrRSUFrcwKWjDBgMiuQ/tdjos
 AO5wINjEW2XI9wFKRMdq7Bz1DL+YlEhwGkCQGh0f5jxzWrVXqOyLqHdiiHVgXEVs69hGmArkEX1
 SlL/aeQfPfMhbD83oeMlYv+LoQk6EJRsBdZEvNsNIukIT94ZjI6EyYQ2zcYmEKrn1MdyG67ts1Q
 eUIlvMaVNlTEJBVuJdQ5wCaAf2kVOxfgpPZKUvB9yNVo1YCFUp7jRkZkGnGkOUtOH8CnWjTq46D
 anq8gCtUnruaaRWaz9GJtg80fsOH4YyVCSMDMUeq2z64yLkn0oDbC1KS8eACAJuK60LqBTOl/4g
 /XlxF46oRZjsEJh8+AAHYkLwibXF7kDB3QMxOTZICyLb/P08T2CScJBDK3CWi/CcEJrFJw0dGDT
 SBA/+LuSKcKEgViWixg
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The am62px family of SoCs uses the same DDR controller as found on the
am62ax family. Enable this option when building for the am62px family

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/ram/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 8e9e53cbb0e1f..9838a2798f922 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -65,7 +65,7 @@ choice
 	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
-	default K3_AM62A_DDRSS if SOC_K3_AM62A7
+	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5
 
 config K3_J721E_DDRSS
 	bool "Enable J721E DDRSS support"

-- 
2.43.2

