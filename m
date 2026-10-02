Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A07CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 882078142B;
	Fri,  2 Oct 2026 21:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w8D-NAn3mcZH; Fri,  2 Oct 2026 21:31:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F84B8141B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976679;
	b=W3EdhawNjJ6merCyXnRfVzYlnvOVZRJOQUgSGaXiu0AuBLkVa2sJbXwmG1SzRH6muQFT
	 0DfxjKjLBmYgbDJzCVjkxTqGSmCX/kdYjp/sF2cONuDtmY+7BNHnDDszRxoF06vVxTJKn
	 L/BaiYaysqZnK76Bv8aGRtA7rIMPJhyWi+p6qSqArDzuE/jNkI3AMyQwi5XDJuEL+zjhW
	 UIzxMgPF1Pv5KHhpjQhCUceEZhe8pEj5Rh4xa/L7HO+v0juMdHSFo+up+5Xy0PtogQaOO
	 fMPZVYZLkgrV6CdvDGq6JMpPKOSgpvO5GsNzIoqx8bzzEjBRL6RZ7Rrf6KZCDxKck4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ooDxzdhtbP/7Dx1Km0l/aqU56ThwvqaUzJkjYDzcg5A=;
	b=HY0JmZ2WtfT+k93m8FMo1YzHVRHWZ+QQVmT0d3dewL2LkQEDmA8XZSivu7Lr2ex0frXe
	 ulZXNAtgGeXvNvZ3mr6OXjYhyqmhP/U4WGIyBhBjYbztC0VYWZd8u4X9kWeZkxbOOMlqk
	 aTk9i0qsY9oUN5rPhcJn9H7GYgpji0XnpHN3eTJDotHkkuRt5VgKJPXGrnDoV999pXFQ0
	 OfQx4iF7u11G6QuMpyFdbiL/au0adNYoiP9jNp2i5e6E6IfmxlBdGT6HXSg6KQAlkhJvt
	 cp0D/+EYcpetK3sNHIgZb+jfdP7DtCHu1RbDLliwt17XUBaUkA2bR+WQR8eInXMPpzg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976679;
	bh=ooDxzdhtbP/7Dx1Km0l/aqU56ThwvqaUzJkjYDzcg5A=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=b1xwEhYOfUf6EbpXMUIrB7uh3G89O+RIsFZko8tkV5Pyrc0fntS7rkoT7uMy8zCS6
	 H3ZNYBudRaO8LvS5a3A5y14gHo0trqX63mnVRtBsusLv/IzoB02AOc6YUe2KHBVmcf
	 jgZNAp0Ug7D9rz72T+ViDiS/HI4xAV7rE5EfaGCQ6qK3IMTQoDuWImakAW3scMhESU
	 mjBsZ1ynyYDNOQc5Tw03nOS5/c3vZil7LV6pUFNr0mgxzcaxXuDzvLcQwIjvnrReyL
	 cysnabDTxw3/NTyRf3Lr2na1/iApFoPxQS/B5SHioMuWplnNPMyBE0h6If1TMZkXx0
	 bo/3ioGomfHLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F84B8141B;
	Fri,  2 Oct 2026 21:31:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BA4934E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80CD840590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kFnXu-yeby3w for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 20:53:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9B6EF40585
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790974381;
 b=HBQm3eG9s1CsKa/YGKw8PqE2ytuNEQQc6tBHKwdUFBLQ/WVDsYUQ4Thbq8Cfa8rjVURQ
 xnRspKeksXZwMaAWDlEeFwbJEWzlJy1U1pTLrJn54erkLf4ARw0Zu2zEc24MQegTy6QS1
 luq9gTeZswvxdIRs0odCThHvXuHa+xj0jEOPEryG6BLAZfDwOuPdNj0pBPwF5Gsjq5JBd
 QdBjKKKCuHsMKruUxsOWshwu3jOcTQzR7nt/9etvj7SmJ++Qyt+69jj400i/NJvLsL7KD
 UvJhS7Byq6/ai06OuU1zhTTq3V92iCKDRECPD/y8nFZ2Z7oLGY7pXNmICVrH6Pr6PrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790974381;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=ooDxzdhtbP/7Dx1Km0l/aqU56ThwvqaUzJkjYDzcg5A=;
 b=BdHW7wVf4QU2pJ0DnZoIPC+A6c2QcIfyJcc0J5drTW/LPFoLZlKw3Dy/Vmr9LMfXebmW
 VHnF9Hf68NBrpvYgETsWBjJrervsMcxLqZdF3+/D61Og6PZ+BvNQU1LCRh3I8uYCOFLA5
 BkIlzzptgScr5BewmJ/Y2C+YeBNIyI9Era64AI4zu2OFibSYLj/16a+AMxSWib5NJq7mg
 +lPp3MtPKfDAsEVu3IR9fHhv7LJcKYxW9Z6nEZvEZCchGlG5sx8kuLbpItUdmlbTs6Wi1
 u0KRO+8NIrFQI/J99mRMRXaEoenJHq6AN2wPUAynHiybE/gqpxKq5hDFs9/7CxOzTuA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TD1bYrp8; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TD1bYrp8
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B6EF40585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 20:53:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B25E960AAF;
 Fri,  2 Oct 2026 20:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DC05C2BCF6;
 Fri,  2 Oct 2026 20:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790974379;
 bh=kKu+7zsS/SrP2X2TxjoWzVV2+ftvNQQHJxB1lb9a8BM=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=TD1bYrp8EwL66P5PWevG7UArZ2bZlgc/s7KJ6RXxR9vUx86OiY5tJsMmA2jgVF8TQ
 jQRS/jYH67bbO4wLEJo3AKVY9WGoLxQdtDE1CR/Xm3aHzrT4WKX+WMd2t2cogW/HRo
 kCLihYvjImHyN5Ux1ZZe3+2jJf2tfbKotL+eB8OjBxEc9S6WOhloWyF+Quk6qrZl5T
 FuvorWPIiYPYhIcB634yFTAfdCLev8YGGl3qZyuKO2t8Eqsaecu5heEh97eWO6oQfO
 LqGTX5IDD2GfXvMMumdbpbRKCbi55pVhVejuQ5wNacCvhBI85Aqpgrb6UJfcoPazd3
 PeHqhM6GimUtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4423CCA5FE4;
 Fri,  2 Oct 2026 20:52:59 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 02 Oct 2026 22:52:57 +0200
Subject: [PATCH] fastboot: scale download progress dots to video console width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-b4-fastboot-dot-width-v1-1-93bb3cb13179@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAyF4asgz7WUpBCpvQrqQIgDZiAoTgsS4
 u4NMLzhG96/g1BiEnhXOyT6sXCcC/Sjgn7s5oGQfTEYZaxWyqCrMXSSXYwZfdnKPo8YGksv/dT
 WNgrKd0kUeLu67ee2fN1EfT5jcBx/nH9OcXkAAAA=
X-Change-ID: 20261002-b4-fastboot-dot-width-f56e91316650
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790974378; l=2407;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=DqDiwDLDrHJFHp1VXxDk67SMOKbkDAfKJjs+UpfW8CU=;
 b=aFjAEP+qoXRyRJj/zpy7ayg5D/jsIbGybeMA5HDOEzHQxcKu1Eo3Irt8NUH5z/y6mWq53je+3
 k0xe8j+FZD/A03HUYnojFnCJBxdvSD102Fgd6hYMe71Nrfp2zoaVeg1
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:31:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

The download progress indicator wraps to a new line every 74 dots.
On boards with a video console the row is usually a different width,
so query the active video console's column count and use that instead,
falling back to the old default when no video console is probed.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Found while testing fastboot flashing on a device using the on-screen
video console. The fixed 74-column dot-wrap assumed a serial terminal
and looked broken on the panel's actual row width.
---
 drivers/fastboot/fb_command.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..e6a5f9b840c 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -5,6 +5,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <dm.h>
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
@@ -14,9 +15,12 @@
 #include <fb_spi_flash.h>
 #include <part.h>
 #include <stdlib.h>
+#include <video_console.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
 
+#define FASTBOOT_DOT_LINE_WIDTH_DEFAULT	74
+
 /**
  * image_size - final fastboot image size
  */
@@ -266,6 +270,26 @@ u32 fastboot_data_remaining(void)
 	return fastboot_bytes_expected - fastboot_bytes_received;
 }
 
+/**
+ * fastboot_dot_line_width() - number of dot columns to print per line
+ *
+ * Return: number of dot columns per line
+ */
+static int fastboot_dot_line_width(void)
+{
+	struct udevice *dev;
+	struct vidconsole_priv *priv;
+
+	if (IS_ENABLED(CONFIG_VIDEO) &&
+	    !uclass_first_device_err(UCLASS_VIDEO_CONSOLE, &dev)) {
+		priv = dev_get_uclass_priv(dev);
+		if (priv->cols > 0)
+			return priv->cols;
+	}
+
+	return FASTBOOT_DOT_LINE_WIDTH_DEFAULT;
+}
+
 /**
  * fastboot_data_download() - Copy image data to fastboot_buf_addr.
  *
@@ -304,7 +328,7 @@ void fastboot_data_download(const void *fastboot_data,
 
 	if (pre_dot_num != now_dot_num) {
 		putc('.');
-		if (!(now_dot_num % 74))
+		if (!(now_dot_num % fastboot_dot_line_width()))
 			putc('\n');
 	}
 	*response = '\0';

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261002-b4-fastboot-dot-width-f56e91316650

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


