Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614EDCF07BF
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 08:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA1788D38;
	Thu, 10 Oct 2024 10:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728548920;
	bh=q02Gnul8yFcHY62hUdaeKNzvA4QRdQK6PIasK2rkLwY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nPGHA+psEFvapLflePW7wJw+rv4PA8012n70ufya12BlEa40qf3WWqLgNri2nIrMD
	 zcowObGXfGjIug0r9LSDuQU8z1XTH+0VVbuWllhkkEXq2qId0F2dynN/FjcEyb5wkL
	 Utv9SOYGPareua60SSCrikmKH9HZZsQAbOW3wLoIh8Mqlm2kXezfCwXgbfSTbqaAht
	 cn4D3a2+dxYJG88r043SwmtI+iQLSpL4KxsIWEDEYPLSnRGq+3Ef8TRj4EORyrWO88
	 AntciFQYtTEsBY/Xu2++SMpUsVawaYbGyGHvYuFyb6yqWr32ytzHo++zKGmWTX7/fO
	 BLi302A70qvLw==
Received: from localhost.localdomain (85-66-232-204.pool.digikabel.hu
 [85.66.232.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4AA9B88A9D;
 Thu, 10 Oct 2024 10:28:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728548920;
 bh=q02Gnul8yFcHY62hUdaeKNzvA4QRdQK6PIasK2rkLwY=;
 h=From:To:Cc:Subject:Date:From;
 b=OCo3SDPckoBoWwL3B+GBhiElIyX1I8mI3ix3Gq8vyIsJqTWxDqXCaNnie77BZJjjJ
 4+7Dx3CcQPesD9qQNBWRqvSb6e6T7h2WYhd2ea69ugOqhTnmEnz+dUe/MyG8XlN8YI
 +bahz5KhIrY8U541S7zh0DX5Jk6kiwSukNXMj9y7rOoncBp9aAEEIg7h9gJLIvXBrw
 c3jcMVNCJREY2sF+VUfEnwrcAJKqmBcvM7k70g4wZDuaL7rZRR10VJ8IdgRMZO6nx3
 yKP6JOH7bZiAaW6i2/3m534VULzo6v/Yf61GJxcV3dGGay3y6EGvS11GMPY6uggnWt
 9reO6eNnaKrIw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Date: Thu, 10 Oct 2024 10:28:31 +0200
Message-Id: <20241010082831.19983-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

trying to load current flash.bin with uuu tool
leads in not booting U-Boot as missing some bytes.

Align flash.bin in this case to 0x800 bytes, to
make uuu and ROM api happy.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
I am unsure about the value of 0x800 which is twice the
value the code in spl_romapi_load_image_stream(), requests
from romapi which in my case on imx8mp is 0x400...

May I oversee something?

 arch/arm/dts/imx8mp-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/imx8mp-u-boot.dtsi b/arch/arm/dts/imx8mp-u-boot.dtsi
index 56749ccacd..3c0bf8c4d6 100644
--- a/arch/arm/dts/imx8mp-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-u-boot.dtsi
@@ -85,6 +85,7 @@
 	filename = "flash.bin";
 	section {
 		pad-byte = <0x00>;
+		align-size = <0x800>;
 
 #ifdef CONFIG_IMX_HAB
 		nxp-imx8mcst@0 {
-- 
2.20.1

