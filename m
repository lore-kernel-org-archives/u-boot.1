Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1907C83F27
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 01:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF668373B;
	Sun, 20 Jul 2025 03:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.b="Bka1Aae7";
	dkim=pass (2048-bit key; unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="DDEvsxZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 267BC83741; Sun, 20 Jul 2025 03:00:12 +0200 (CEST)
Received: from e3i311.smtp2go.com (e3i311.smtp2go.com [158.120.85.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5EB4836AC
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 03:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounce.iopycbizgxp6zp5=nvwe9k5axk4q=qnax25n5shirn3@em923567.on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752973209; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=WX0wKnd5ZFN79wIoXxR/N/2rTatUSaTrMeWjh/CA8kg=;
 b=Bka1Aae7X968xpeJr1Pw86PfsU77hxJi9MS72kmngyDHnEuJeM0HozKm3u73fcNYdjrty
 OiSk/wXWZobC3ff1H29g/QooF3Zd1QcQugMSoW+blhbPh5KBCEuvijQ/0riSehVrWjWbJh/
 n9ZdK54xWGrNC6lh3k9FB5Vju6fOaox+E9myd79YTH+YdCBDc3wxbUKfyH+I/832pmCq8Gi
 lieOTfDElHGMCezn7/vBhkfp7vyEyUUsL2mbOcWXnnIFlpQPeQ9zXUOhpBneidfEUR+DxJi
 wkemYxxQtFeS8OjpkLsIh0w7gSRlQWSO+6Y5BrTAA40bNtnLMxCQ4Ow6rAEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 i=@on-the-web.ch; q=dns/txt; s=s923567; t=1752973209; h=from : subject
 : to : message-id : date;
 bh=WX0wKnd5ZFN79wIoXxR/N/2rTatUSaTrMeWjh/CA8kg=;
 b=DDEvsxZ6oM6Aslxze9mB+5x/lpQSHAsu9sJG9EXnIrC9rqJ5luzsfmmvhAol6ow0JdqZe
 zPRbSjol+kG1ck2ikkED4dNSQtNH8oJNQOrHIX6Ov8h3ZenC18ztv7A6zgzzNuKmzOcfh4l
 t95VO2dzG/qPvUQpSwLzVJ2G8Ex42kFFS+1sqEaPZgSOt3x9zZ6uaGonRk8rw+AhW+CdJ1r
 4c4FZvyN3mfS2JYcJkn6xN0b8wwNXQ4xWcxZgqqgQ+v47tubWkhTD6BMuVEkAhQa/4wn6IQ
 u93xWLHASltUGK7i4L0hj+oO2r7CccYJYUF/N80zqMIupBEXLGnx35NsN4Ig==
Received: from [10.34.231.120] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1udFPX-U24dao-1a; Sat, 19 Jul 2025 21:48:03 +0000
Received: from [10.114.245.143] (helo=ch-web-troubles-5500.home)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1udFPW-FnQW0hPvgzA-ld4w; Sat, 19 Jul 2025 21:48:02 +0000
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] riscv: Increase Microchip Icicle's SYS_BOOTM_LEN
Date: Sat, 19 Jul 2025 23:46:35 +0200
Message-ID: <20250719214650.214931-5-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250719214650.214931-1-sputnik@on-the-web.ch>
References: <20250719214650.214931-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 923567m:923567atSSOWT:923567spY_gCehzA
X-smtpcorp-track: dmyKXlBG_Mdw.PHR18PklZDUj.Oi3V8gHyyf2
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

Increase Icicle's SYS_BOOTM_LEN to 0x4000000 which is the new default
value.
Done on Conor Dooley's request.


Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---

(no changes since v1)

 configs/microchip_mpfs_icicle_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/microchip_mpfs_icicle_defconfig b/configs/microchip_mpfs_icicle_defconfig
index 99df10dc4c2..6937aa224a1 100644
--- a/configs/microchip_mpfs_icicle_defconfig
+++ b/configs/microchip_mpfs_icicle_defconfig
@@ -5,7 +5,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-icicle-kit"
-CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SYS_MEM_TOP_HIDE=0x400000
 # CONFIG_DEBUG_UART is not set
