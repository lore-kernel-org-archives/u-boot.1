Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C38C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3DB87FBF;
	Tue, 12 Mar 2024 21:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y5WtCdcQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE4487F47; Tue, 12 Mar 2024 21:20:49 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0804786FCE
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTsF000706;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=he56dByzqmtOq52LVeqDJQk3lz6+zv9zQwjS30SytdY=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=y5WtCdcQCDcvv1SVZV4OF2zig2XxKZh8TDDZqTsTTURVplpxtZ88DsduMJfc7rXk0
 o48mCXQuAebxWzGmHgW+t3EByOkPeo2JYTC8XAd6YXQSJWdffbGnVJgooNNZK9jW1x
 ShqFRCezyrQxzqE5iku8w/Uqg12ge1hyjQ4aKj+o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKT8d038147
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKS5q091685;
 Tue, 12 Mar 2024 15:20:28 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:26 -0500
Subject: [PATCH v4 08/13] firmware: ti_sci_static_data: add static DMA
 channel data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-8-fa772bfa623b@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=bb@ti.com;
 h=from:subject:message-id; bh=gzobrU1xdNd98YM6z6ReTHAAKEW7RbateTPm7aue1LU=;
 b=owNCWmg5MUFZJlNZRhRT9gAAZP///vfd87fyu/26/yye97n236/+3xU2/fvnx8/70Dvj/9+wA
 RmYHaQDQAAADQeoA0DQDQ00DRoNAaHqA00AAGmgABoBpmk0PSD1HqNHqB5E09J6iAANAZBkaaaa
 aYgDEaaaAaGR6hggAAwE0yMhkGQANDCaYRoaBoNA0NMg0GUwhppkeoyaZDQMhoxABkyDQMmmgGh
 kxAAyBoA0yAaDQMhiDamjIANAxAAkS/wFTlCH5W4VMRQMFCBN5boKFRQLF28DjeUiPAkOkBEGWD
 Ln3Cj3ei37nzOyAZpEC0s6VYd4CMKoNJlJ1BWEBlJac5BGPu5GoEM0uuAq+hfXNh1ZqrCt9mBR5
 jR+xcPuCc5EmheYiLY+3228V6LJ2gW9ZPF7M15F88AvZJ1nUXh5JRkfPEIrUoAapplT0csAeol+
 ezN9pOjJAztso6JfTZiLd+Vd3oGsMAXTv1v+9ctc4TGF5XNCzclqtS8C0imDVaB0NKD3xYyfhP9
 HaCdDNpRCFaY+tCAXsID7Yc3oxuKnxQdZXKhEFjEAbusVHi6Ex0sh1kouRIzOwSKFnqCFHwjvHE
 IryNYf6naA3o3AyA9zhAg4DIiJiEg4HyZ+sTWJYjklub9RoeJN5rqXcRGBjZx8ZpC9clnZc+yvK
 ApmksWaPfxf+LuSKcKEgjCin7A=
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

From: Hari Nagalla <hnagalla@ti.com>

Include the static DMA channel data for ti_sci

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/firmware/ti_sci_static_data.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci_static_data.h b/drivers/firmware/ti_sci_static_data.h
index 789f0c6b2d903..9662bd95f2835 100644
--- a/drivers/firmware/ti_sci_static_data.h
+++ b/drivers/firmware/ti_sci_static_data.h
@@ -84,7 +84,8 @@ static struct ti_sci_resource_static_data rm_static_data[] = {
 };
 #endif /* CONFIG_SOC_K3_J721S2 */
 
-#if IS_ENABLED(CONFIG_SOC_K3_AM625) || IS_ENABLED(CONFIG_SOC_K3_AM62A7)
+#if IS_ENABLED(CONFIG_SOC_K3_AM625) || IS_ENABLED(CONFIG_SOC_K3_AM62A7) || \
+	IS_ENABLED(CONFIG_SOC_K3_AM62P5)
 static struct ti_sci_resource_static_data rm_static_data[] = {
 	/* BC channels */
 	{
@@ -95,7 +96,7 @@ static struct ti_sci_resource_static_data rm_static_data[] = {
 	},
 	{ },
 };
-#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 */
+#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 || CONFIG_SOC_K3_AM62P5 */
 
 #if IS_ENABLED(CONFIG_SOC_K3_J784S4)
 static struct ti_sci_resource_static_data rm_static_data[] = {

-- 
2.43.2

