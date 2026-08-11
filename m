Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FE9C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 21:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5BA181163;
	Tue, 11 Aug 2026 21:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6lCP4UxCbYlM; Tue, 11 Aug 2026 21:23:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7CC7E810FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786483390;
	bh=oD56Yg1ZIDPcJF35oBDricWBzpPzoKA1NZz8/3tXCGs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V9avoannh0DDDX7hAKGgipdYCC4mlffj7ZaNE4CZL2Av4GoLDF8qBhbHB9N68UGlH
	 S9r+sd7UtoLJR3snmbTo0pnnyLNLwgtHbpxYjVf4tK4yQcz+jv4XohTCv9lYkJYr+d
	 4DCwO+wg2kOJf74yyH5i26c4gi4KSBQ7aF4sHDKY/a/aKvV7iUR/vRrIWS7tmrKTuA
	 Imy9rmc+rGMYOLZSeDE+VgKaFDUM1rm6udLa16/gkpUlynbMly+d1fBaVj5Ap/Ey9u
	 J+JelDQdxMuvpHdpKbFBJ1G29R8HE30nDYpc/23+/E2AJJ8IMhPaYinEOD8Khv2dbC
	 t3910QhgDWc5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CC7E810FE;
	Tue, 11 Aug 2026 21:23:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 29BD649B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 21:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B4AF406AE
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 21:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRfdxbvnJAzH for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 21:23:07 +0000 (UTC)
X-Greylist: delayed 939 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 11 Aug 2026 21:23:06 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 49278405BD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49278405BD
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.2.141.84;
 helo=e2i340.smtp2go.com;
 envelope-from=bt.myztqx8aiwo1947=785ab9pplba0=k4fbrpq098hjb4@em923567.on-the-web.ch;
 receiver=<UNKNOWN> 
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49278405BD
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 21:23:05 +0000 (UTC)
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1wttgX-TRk5ia-7T; Tue, 11 Aug 2026 21:06:57 +0000
Received: from [10.114.245.143] (helo=[127.0.0.1]) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <sputnik@on-the-web.ch>)
 id 1wttgW-AIkwcC8wmSY-KAN9; Tue, 11 Aug 2026 21:06:56 +0000
From: Martin Herren <sputnik@on-the-web.ch>
Date: Tue, 11 Aug 2026 23:05:54 +0200
Subject: [PATCH v2] rockchip: rk3576-rock-4d: Enable XMC SPI chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-rk3576_radxa-rock-4_spi-v2-1-515b2880999e@on-the-web.ch>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf8V07Rj6AKkr/8MQAmVqKwklU0QM4
 d8FjEuXJ7n3nJlFJI+RXQ4zIxx99KFbQRwPzLiquyP4ZmUmEpEleZIDtTI9ZyVVzVQBBdOCKmP
 vQRuhuFUoNKZsffeE1k+7+VZ8OT7rB5ph020L5+MQ6L2nR77tfhX9tzJy4IDSCi2lVZw319DB4
 BBeWJ+MY8WyLB9xwhTF1AAAAA==
X-Change-ID: 20260808-rk3576_radxa-rock-4_spi-9c241f4e29e5
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Martin Herren <sputnik@on-the-web.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786482414; l=1908;
 i=sputnik@on-the-web.ch; s=20260807; h=from:subject:message-id;
 bh=knKxwTxQXiR2AR8108F2OZg9oSYqcEsoVoR97g/As2U=;
 b=3EHAcqSIY5aA3uW5/CgNs7GnDuY2OzKh2CharGfz8d9Mv5C+fokvd9viVt6hYfoJfIJFECU24
 CeQjxv2hSZMBNaaY1rSjTQ9IwCVeTZPWn9FWxP2xmOIyVHG4nsi/iRu
X-Developer-Key: i=sputnik@on-the-web.ch; a=ed25519;
 pk=BR38NGVUwMvK69LvaMsmvH+Fv6i7mZjbbFA1/X+SwsQ=
X-Smtpcorp-Track: nU6L2BaS98Op.NfMqPOD_O5br.7wZSngpHclL
Feedback-ID: 923567m:923567atSSOWT:923567sGr-zIvrO-
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=smtpservice.net; s=mjsmn0.a1-4.dyn; x=1786484286; h=Feedback-ID:
 X-Smtpcorp-Track:To:Message-Id:Subject:Date:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=oD56Yg1ZIDPcJF35oBDricWBzpPzoKA1NZz8/3tXCGs=; b=eOrhKnYX8hrmIqW3lxtZVDIoPJ
 HJxB6KB6qczENqe5lzOhDEEakWlvVl8Pimi07pCmftS9eIk7Qxl9xeZK98UagebqpYhedWuxIX1lW
 8tGlL0YQ/pwbWIpOTZTAJBAPdyVSYQI5TASX+Iy4WU26N7W4rxQqv1xjWcX29fI1+QGEkpHyfmpTB
 NP2a4Ufz5MJFrWm67UHNjm/0mXM24OKeXzCSyLDUKMENnrk6uNYhtwlpqSlA110b/CDpbm9WDcFZB
 QJOECbK5WgO3gbUFlCHBNUXkmfLHpf9bj54CoqtXi7IBdbGT0aGltRm4cnJGuBQonz1l7UJXmOmPW
 ajklm3MQ==;
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=on-the-web.ch; 
 i=@on-the-web.ch; q=dns/txt; s=s923567; t=1786483386; h=from : subject
 : to : message-id : date;
 bh=oD56Yg1ZIDPcJF35oBDricWBzpPzoKA1NZz8/3tXCGs=;
 b=VHG7iSVIhGOyQduEYE7G6xbzzWYIKYQRb8XNnhTlLtHpt+ZdLk7PHdOOZxMnQhJx5MUuX
 Oz4GLX3AQj2FX2uHLI/tPMIQraNxF93Ejiq8+wvxEcAwh2EmeJ061SMXRSfrLEfgn4KVfUw
 f9oRqEUwyWCawE2HVu/2KY4khqw//hFV7gUj9jXe7w9YpL8xpGgTKZFJteftewEmtPM+4dJ
 Woe39PWvjH2bFk7gSz01WSY9zBs5spuDHPvpfuw7+Bly8JyauPNtEtNvEfrFYFewatNcvr7
 nS4HzPJy35e0vezLvE+ceSV2pLm7JI8ip3JNZhvgV0VsoTe4BSK8whlpC2qA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=smtpservice.net
 header.i=@smtpservice.net header.a=rsa-sha256 header.s=mjsmn0.a1-4.dyn
 header.b=eOrhKnYX; 
 dkim=pass (2048-bit key,
 unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch
 header.a=rsa-sha256 header.s=s923567 header.b=VHG7iSVI
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Radxa Rock 4D exists also with a different SPI flash chip than the
one specified in the schematic[1]: XMC XM25QU128C.
At least board revision V1.12 can be impacted.

Enable CONFIG_SPI_FLASH_XMC Kconfig options.

Without this SPL fails to probe the SPI flash and thus fails to load
U-Boot proper from it.

Vendor U-Boot also enables CONFIG_SPI_FLASH_GIGADEVICE and
CONFIG_SPI_FLASH_WINBOND so other hardware configuration might exist.
They are not enabled by this patch.

[1] https://dl.radxa.com/rock4/4d/docs/hw/Radxa_ROCK_4D_SCH_V1.12.pdf

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---
Changes in v2:
- Clarify commit message to specifically mention SPI flash instead of
  just SPI
- Capitalize properly U-Boot
- Resend with non-patch-mangling smtp server
- Link to v1: https://patch.msgid.link/20260809-rk3576_radxa-rock-4_spi-v1-1-e3f2933f411d@on-the-web.ch

To: Simon Glass <sjg@chromium.org>
To: u-boot@lists.u-boot-project.org
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Martin Herren <sputnik@on-the-web.ch>
Cc: Alexey Charkov <alchark@flipper.net>
---
 configs/rock-4d-rk3576_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rock-4d-rk3576_defconfig b/configs/rock-4d-rk3576_defconfig
index 7228a9d879a..93faf09962c 100644
--- a/configs/rock-4d-rk3576_defconfig
+++ b/configs/rock-4d-rk3576_defconfig
@@ -49,6 +49,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_XMC=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y

---
base-commit: 77bc0326456d9d6a83aa7adac201d1c97a008b61
change-id: 20260808-rk3576_radxa-rock-4_spi-9c241f4e29e5

Best regards,
--  
Martin Herren <sputnik@on-the-web.ch>

