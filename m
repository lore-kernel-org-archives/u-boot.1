Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB03FC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9784287F40;
	Tue, 12 Mar 2024 21:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rZm/ByA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B9987F25; Tue, 12 Mar 2024 21:20:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAFE87F4F
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTDp088769;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=VSZddMzDcxudn5WkbJ+r9QtyQmV+YGx7ejGknzOUK0c=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=rZm/ByA1pVoCWgkjGm0Jdu6HhC/uR7QG3P1U16MjS73GJdVZ0o35dTdc9AvjdB3B6
 sYJlXVoaIrmiglyM64U2aLIfHCKzTBjV1HV4LuYWtZfepx++U2r5jTpfXmfz4SAten
 3ij6yPoFZdXl9ugcvMVnNWDbmlubfhGr20NiLc3E=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKTWC027344
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:28 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKSUp091679;
 Tue, 12 Mar 2024 15:20:28 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:23 -0500
Subject: [PATCH v4 05/13] arm: mach-k3: invert logic for split DM firmware
 config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-5-fa772bfa623b@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049; i=bb@ti.com;
 h=from:subject:message-id; bh=Sft2sR/7dE5Hurg3jhfvMAQ4+0uynYNy0cFwH0iYO6w=;
 b=owNCWmg5MUFZJlNZR0eNZAAAa/////7f//9v3HXrS927O8P7u53/+1T7vv/tTTvP5z/H3fewA
 RmMHagAA0GgAAaaAaADIAAAYgAGIA0DTQAyAAAAANHqaekZNPUaek8p5qiDQ2oAAAAADQA0A0aB
 kBoA9QADJ6gHqPUNqe1QANNNlABoNAPUBoaNGmho0HAnqZGRo0DNEA9EABk0yNAAMjQeoAGQZMm
 TJo0NAAAaAaAaekGgAA0AAPHgORtGNAthrq5lFUblBAab8MhQwiWthlXqnKiihnvj2+02FVoy9R
 CBV36yHdYtmDMmQcRkaN7cYSmHuhgW+fLHBIJF0yIcpL9ryRI8Qf4TZv7bFoNzSNOKMT+kBctQt
 mESUc2KMmt6Mkro33ghzRixLtekapZ0JMq/VacyGpIYPVps3ksdTmcYAJN4AyRPpAP4p6orsebp
 GgkBqiWa92TcfO4iKyY7Rz0oy5VGeatiPQgQi3Z5lFfg4g5eaYPoDFjP4aEs0GuCE5BIWPjV5lG
 +8BUOd++853IQ+o2sQL2Ef0hu86pca5TFLALJM6OUnDVGyxStJpmJDfDYCCGU8PwtLoMHOZSQjN
 bEAFAisVgEXXis4XYuXtf0KMX5U2kFqfYxwdKgusdMTjVi0gxbLi2GOTBJSI9USEoRlGQSQGRyB
 /i7kinChII6PGsg
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

Currently, for the K3 generation of SoCs, there are more SoCs that
utilize the split firmware approach than the combined DMSC firmware.
Invert the logic to avoid adding more and more SoCs to this list.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index fc971d517ab16..6a937ff96d208 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -133,7 +133,7 @@ config K3_OPTEE_LOAD_ADDR
 
 config K3_DM_FW
 	bool "Separate DM firmware image"
-	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_J784S4) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
+	depends on CPU_V7R && !SOC_K3_AM642 && !SOC_K3_AM654 && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
 	default y
 	help
 	  Enabling this will indicate that the system has separate DM

-- 
2.43.2

