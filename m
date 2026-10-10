Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB077CA9EC0
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7725B6066F;
	Sat, 10 Oct 2026 19:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7lqEINx_sKaa; Sat, 10 Oct 2026 19:09:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9441260622
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791659395;
	b=XnHem9udRwG2MgglO+j+a5QMVaqxmc2OVb8P3FtrhzMQAz5AAodljaeOlqIwVlsOf8x/
	 SVrRju5To48R0TsXVJPOrC2u7eMRX0bZ9Qo1wXXctudFoa7y4xh/lnIbl9Gdp7PRRYoGT
	 gfqMY45YH5NRMVu1SN0g2I2PdBZUjgL0mEKvlRB+o6sQlXJSsCM8soI4jO4Xe5veGstPX
	 FR/uydYhvwQ4ky0n2NMOhq9brVzNVer3LMn2NlUtDZtQPa42G3ZKe8/7i8/VedbyyUWUH
	 KmrbrBc9RQSHHPfm3gjEoA4ZPID70REOSrKKcP9PRw8CF2ieyNkQOQxmwryy/0kQ5xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791659395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=AslZFUfaf+hB3OYxgKuZOmWZ8gA5IuPzRnQdbQPIVD4=;
	b=QBANvTSPYZgjzAz3uBZDWkBIK0Ht/1+bNXtVLzsj3O4VkQE3PbfNAoPpamCWC/XbUHyq
	 awNUnI0hZc9nLb8BPsBDiMXgMl7ofuZOxU/079UVekkJLzaZ3/8BmNFUz792knvrYGDCm
	 L+dpJmHoM1q2SFh9Hm2ABmVoOHG9iFnWBJemS61ngCrXP2cs1bZnBxRB4TxwTgUVZCLxv
	 kyZhSufzA7c9Bzf05WZ5Wn81MJQNEbsNgdc6g7eJfdZXwhlgY4nk38nL0jLSFcg/pbuyK
	 sAuVNSjJ5hyxNPQ+t+Xebd8vv3VpL9R8o0jtuyuI1qiLX+PTM/riSBTcK3Hwk8rxXGw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791659395;
	bh=AslZFUfaf+hB3OYxgKuZOmWZ8gA5IuPzRnQdbQPIVD4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=ylWxxyM1S++tgEMnDcRYK1J5JmTBbQBwtSlX5NClOK/UQfMQ1C07lUG7I/uC7/ZtF
	 x/XA3qJarlvirsYmLwYfiDlRVkbm0VCnq9SLVp3iGtztGGzewkciIFu6Y9IDJiTSHK
	 z8VhJrz52CJDNKphWnDudBR0KN8TsiU2w1gRmwIsSe0Tu90NMTySnLxVuUg0M0kUcG
	 ncvdicmSfrpqd8NqMzmd29bMx2uBjqycrlsGWFiEohp8wgBaspCXNr6IRuVZPxWOj6
	 RB6dQe+gxpop+b21+ieU6ZLJKH1Fjl5oPGnx84uWX4UmEoTBI+xvuazH/EiVGhOYi6
	 4sXR2wfCgGqnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9441260622;
	Sat, 10 Oct 2026 19:09:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1B6D105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96D8840813
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:15:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sEXZWTkLpUik for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 13:15:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D81A540811
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791638124;
 b=YHiAMnA01zs5EhngxdP0bQeI7UOpR99NIxCymdnmhE9OlPQghZ0Z7kaHzl19w+ZKBw4W
 9Rb5+TFGMScgFl0tMprb6o5nQeAN4PKqlLDZ3C4xqHOQFEArvDVQwlxdnE8eve61GcKWp
 xvsEwGFTmjxkAMviVdSV+6YXmhu1I/KsUvKrBdiUmXXb24oQ99HR23YVknAfWJiopyuYr
 M4+2LoLfvAeUAQOIgisi0mM5S5WzqP1X0V+d0+zSdtEZvid/o1aINrvwWzTL744ydPEbe
 GgcsmKk3einy+772r4txaKyYjaXwAGZRKxY1iG/z3ZG+G2Jl/8jWC3jcUi99wkU3hNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791638124;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=AslZFUfaf+hB3OYxgKuZOmWZ8gA5IuPzRnQdbQPIVD4=;
 b=acgxXMSXsimKTZHEymQa2IOPkbSGzGM6MURNRkPSG/QgjpPSjdrql+8O8tWvNl6tYqYQ
 e322L238DE/egrQ9ACyy3fUCvb3Zie9r7aGRCclPLJolwsvkWXAVV5ApyRf5I3FfnBbH/
 2lAF54L3t4agXMFnPQhUNVZRKUM21+Tlv3uC1dDoTupa932MJ81pVT2UY7+G/i4vWIqRH
 dS+kGQu2/iiUT+R7zEoQC0BB5IW77ksYmXzeNY6ZVcFy5SnMilLlV0T3Ur706gd0keQgm
 wka7n0cc0sQSRiTT8WmkhyRGOxOlRAy7T3bal2hPMyOiUl4bM7l1xMarCYKmY3gz2lg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=det7sEQx; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=det7sEQx
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D81A540811
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 13:15:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 831A9600D4;
 Sat, 10 Oct 2026 13:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3859BC2BCB9;
 Sat, 10 Oct 2026 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791638122;
 bh=uDYFYFhmKEzBlgGS97Na1P0rZR1lZSmBezGKDpHxq5k=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=det7sEQxOBQXm38trCmHOJPKThlmrQ5LqVuOeAfp40POGbTdlhZmBSVstD8xHe896
 qdREQ2eyPIcpOE4PrmhdeQsLWGSzWF356XE0i95STEHjaTK0bD4N8cP9IvuJZ/sW/6
 ZyKZcRLKY7iUJgfGHOm5lVTOlYT6hpvGxarhNuqov/jZTJMbFR+uOhZ0fnDBBarcO5
 I/HPhVIxi1ZwKMUPE50gry6pwZ/UleiLiRp1F5M8LYwrI8zSQh/kTLgMDXzqSmthHp
 LWvzUl7xWXqrpTyVtq7GaAuooo/PPXSeRPpbm3b2VwLZ15rEKlwGptdOq3kuXxH01n
 H/a3VTQYnmEgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 13CAECA9EBE;
 Sat, 10 Oct 2026 13:15:22 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 15:15:14 +0200
Subject: [PATCH] configs: pinephone-pro-rk3399: Update defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-pinephone-pro-defconfig-v1-1-55487e8c269e@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBAAwK+YPXcTsBWafqXxgLjoelgIqDEx/
 r20Pc5lTiiUmQq8mhMy7Vw4SoW+NeBnJxMhj9XQqtZopRUOD0wslOYohClHHCn4KIEnDM+7M8r
 ZzhoLNUiZAh+//N3/XbZhIb9+R7iuD+Z3G2t+AAAA
X-Change-ID: 20261010-b4-pinephone-pro-defconfig-f83a60a75767
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Tom Rini <trini@konsulko.com>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791638121; l=2291;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=LGxoUieiAALYyI9o4TtIl9xB4kxfL8qBhBu/xVpPm4M=;
 b=6tiyaHfqjo8EP5Z5RghI+dHK957so7j/+EBtoIqDEAw5TpuJ8XoFwujbLm4fQY9yqFIPjaMj9
 j7HMBWbvTm9ABNgq1p217giOEO6brnDyryfkIBP8WuP1wRy7hOsS/IN
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:09:53 +0000
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

Enable:
- the ADC volume keys and the keyboard glue with phone key remap
- the USB gadget stack with DFU (SF/MMC/RAM) and mass storage
- the watchdog
- the clk/pause commands

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Enable the pieces needed to drive the Pinephone Pro without a serial
console:
- the ADC and GPIO buttons with the keyboard glue and phone key
remap
- the USB gadget stack with DFU (RAM/MMC/SF) and mass storage,
- the watchdog 
- the clk/pause commands.

The volume keys depend on the separate "button: adc: implement
get_code()" patch to produce key codes.
---
 configs/pinephone-pro-rk3399_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 81bc6d5400d..492b188f904 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -29,21 +29,31 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
+CONFIG_CMD_PAUSE=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_BUTTON_REMAP_PHONE_KEYS=y
+CONFIG_BUTTON_ADC=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_BUTTON_KEYBOARD=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
 CONFIG_MMC_DW=y
@@ -80,8 +90,10 @@ CONFIG_SYS_USB_EVENT_POLL_VIA_INT_QUEUE=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_GADGET=y
 CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_EDP=y
+CONFIG_WDT=y
 CONFIG_ERRNO_STR=y

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261010-b4-pinephone-pro-defconfig-f83a60a75767

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


