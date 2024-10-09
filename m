Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3D2CEFC5D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 09:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A5D89197;
	Wed,  9 Oct 2024 11:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="T8WZa0q/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BBC891A0; Wed,  9 Oct 2024 11:49:48 +0200 (CEST)
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E1189197
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 102DC240E5A;
 Wed,  9 Oct 2024 11:49:46 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id 6EDF2240192;
 Wed,  9 Oct 2024 11:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1728467384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d+/MJQukET+m+5ikZYBu84j2eAqxK+GuC9Ae3sXnDus=;
 b=T8WZa0q/hMGLnn/TNCTHknGGiLJ+N82M3O0dgVYkCiBEGPVdewVeR8jeX2YS1kBuXkDaP8
 sFAvOwzlt/L4b0ksOSN9sG02EjuBs6ilwiILVDtAV4zUIrsZBFvPWqMSyfglk0/I4akUOf
 a0ASPwpkhzj0GNV3cL70+LXdvORvFyi5h3Q/aAarg4aKCnp2ICzDLH3w/wWL7zEZ1zqiFQ
 yr9OuJWznhfImu3uTzX8DLBLlAmQ0MsdYzU0E/wDP4x79y0GeOlk8mh8sH5x0S7eRU4PVO
 VG5mVFcSLMdx7RkAgB5YBgbbYNRGC1DiOGw9lgV277Rj45Tg5947KSdGZOAM9g==
Received: from p200300cbef398710000000000000076d.dip0.t-ipconnect.de
 (p200300cbef3987100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef39:8710::193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id 1D6C7240514;
 Wed,  9 Oct 2024 11:49:44 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Wed, 09 Oct 2024 11:49:33 +0200
Subject: [PATCH] clk: stub: add sm8150 compatible id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-clk-stub-sm8150-v1-1-697313752979@devpi.de>
X-B4-Tracking: v=1; b=H4sIAKxRBmcC/0XOSw7CIBCA4as0rMUMBUrpynuYLngMlWhbhbYxM
 d5dqguX/yTzzbxIxhQxk656kYRbzHGeSrBDRdzFTAPS6EuTGmrBADR1tyvNy2ppHlsmgVplao0
 QBLeGlK17whCfX/Hc/zrhYy3w8huSEXM2X7irdhZ0Ya34yxunQDGA5qAkF16ebnEyaT7OadhPW
 JORunkc49JVHoIS1gumvAmN0LVW0iEXTbt/BKpRzgTJHOnf7w/jyB3h7gAAAA==
X-Change-ID: 20241009-clk-stub-sm8150-b7a29e0f43ba
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=ogLWMzH92ryCdjLg8mg9VIU0Q6hWmOxRDSFj7oNzFnE=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBnBlG4rXutrOamed7trK6EdeHZd3EQqrfkZ2HQV
 jyqHk3shrCJAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZwZRuAAKCRAStku8QtBB
 A6BkD/4wr3c4CxF1118jnsnztdm7B0O7Fo+cWcNKx7hSQTGbMaydn8V+MDiyu/rqLbSax9Nr96v
 DB1aim5P3ZUnbzpo1zfYHPjUZSBGgPPqaXgmhPCBCmbeyK78vwbfi8GJ3l16qpk4SGd90x7i+VX
 /NRqSkUUe7NT7pN4AYnN/hwnNVRqjZR5yNVn60IQLOS7S2AMX15Peqy18QRqS2OvqzIh3DJhjvg
 y4dGbVHJorg6npxKhNij/ClvzipAOel9bB+7jxD0qrsFt6JNSciUOqSHYmrHrz7sTsbcFme+LN5
 jqqIY8Dp+iUMo0ozrM1YyrL/AcAHQWDRPLfDX+M9Un1wKjOAKl8uB0D5JQKZr07CXBIyVVBN+Gs
 fkc+YOjupZKQGluShfo+gxEgbZeNDbO9g6jqy/bf27avmgRSsfy9xNpjQtkmWtwxlEMuzBHeSWR
 VIO2+VIE0nSoTVq/dDum2Z//IqvfllZd1IIpgEf/qS+qf3P/iSzmqO3ScI2q/jmgq15F6iaWOYY
 LrvA3ntGL1/knTamroaazTRIoK8mDdfAzJ4xhYXthYrmQkJEcfWUUsbakJBdujr6ElpoYUVhC1/
 ed9C3iKEV6uLQrzb7uwVY/wdqz5i7TuKLhaOyx7bi9V3P7sh0gg0g0NvBkBJLmB4yOkFpUgy2aQ
 VVfputoZci4TMZw==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: 008b1a
X-Rspamd-UID: a19ad3
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

Add support for sm8150 clock controller to clk stub driver.

---
Simple patch to extend the clk stub driver to support binding to sm8150 clock controllers.

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index ea817031fa6c0cc1ea21000273b5651be5d05e65..76df9e3aba0e664fdaab8431f7909dda52ceb795 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
 
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sm8150-rpmh-clk" }
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
 	{ .compatible = "qcom,sm8550-rpmh-clk" },
 	{ .compatible = "qcom,sm8650-rpmh-clk" },

---
base-commit: d0f74bd417daf6492975ce346843ba0767caf51c
change-id: 20241009-clk-stub-sm8150-b7a29e0f43ba
prerequisite-message-id: 20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org
prerequisite-patch-id: 01b791d83c26250b3ff485045b88d5889f911bb8
prerequisite-patch-id: 66febbc73195c71535e2423d14f1ff6994ac36cd

Best regards,
-- 
Julius Lehmann <lehmanju@devpi.de>

