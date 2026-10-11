Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DF1CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FB82406DD;
	Sun, 11 Oct 2026 20:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yz0vIoLa2rhG; Sun, 11 Oct 2026 20:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB085406C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749588;
	b=FYUDF+rQep+cAWdw+cGw08SklGBareATW4DVqHLrHG7d26jvjqZFU+giPG9mSJXi0tIa
	 ElEITnRFY4Ya6dBvdWs0/mMxHClz+cPOCnN/UF9TMxk7u8PfZNr08XzeogqbiFL6gQz+E
	 1cqh7GumTigRcDiupmB5xCM3Bp3MpQDPsKVAMjCGWKKg40Lszi9SeiV2qvVR7xPOG8acr
	 jIyxtkAyslevphRWSd5wQl7GZgLwrQFHgJu6b0lY7OlWTpfRvx9Q2o3/GKm0/W6zTG8Hl
	 Rh2cUC8bB9afTW1mcKxF74XsuZP8kXxk5yydQ6a9Rg9kU/jDGqyWUASPk6LqRyYFoGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=BEg8CLPC0FvJ35J8ioCkoRcK+0ORXqJp+nIr8/74qEI=;
	b=aO0+9wwx6+1AImYLGrMxAYTtLd0OK5po5gc/hUHLfezmsvP5tULT/LinZeDJyfiOHqd0
	 iwfpqQAqnMw4S3PnRlQ+jUXlMxQZmGjUomb1wUEcEcA4ZjZRBQ9SBYDhe5CiTbnoJwFsE
	 9LcKHoX7ANqvk1c1AjHJR8wv05r6bj9K/EkixeAvO7gOaViNmoOZ8fDZVXTm/lGpA2Skl
	 PO5glCjBdtRbu5mD7dqst/toamkstWXJ8/dxpd6PxZf61MCCQLu+tYG/ar60d15v+wlJQ
	 d2E/qm3o74ZVX86FEhrxKEkA5m0knZx7Khyash4MD/PSGxgnZ7CKo5GLmiNYsEiBVXg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RaznIQPE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749588;
	bh=BEg8CLPC0FvJ35J8ioCkoRcK+0ORXqJp+nIr8/74qEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=jjwhH74N2nyu76myyAZYnsf6lIndEVgukeBIDAVEptahq/V9it/CP2VUpyjHI9tMd
	 EL8iM031o4UHjR7pYoh3rW4NQcEaagWfauJokKxNhYPTgQPvWM6rHHldqoJp5bKOn/
	 UQhyhVCPeFHQFPoMtR1kJ+u2xa00nWK7tYK3eHA0WpFe9aOPEMDeZzDMYnI7cnb6t6
	 YlBGmvynKK8lVHTCMxAhQ8WibCxbPvBIHUXc5h5IyzjmGE4iGmFCFxob/utXYGEqM3
	 PiIz9eLvEb0OMcsMUAmCgWZB+5Go/Jz7fwhstznUbfCHmplhJdSSCmn6NbpxzdYITP
	 nVZeltXGQeJhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB085406C0;
	Sun, 11 Oct 2026 20:13:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE8D5111
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93A4840577
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWXGjqssD9L7 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE5E640567
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747351;
 b=XiK8ZafqIxmpKPeuWo4x5j5k7Q81v6y9Vx4F/V+Hy9vfWNpHbQOcgCIHOvcdUEuwnz3R
 xYZi6KiAth3jRWINy3DecIsetGYBp6CctlDlqRqsZ9nngKKaHRrEh9NmXbz1rktcnd3ZR
 HdlC8fqOLy8ogXWe7KVzncCHu3yFkyNQFgBas7I0ofIGh4aX3F3KT4jCjSh846/EuVGCU
 FHVJsxp50Dfk5VqSrrPCuMZ0tj/Cz5mduStknIMjhjjTon1igJSASiTcLB7th4wHG4g60
 T2wFAwzIYVNT2DvQpPHR7IKPKm6JzPm3H95b7XpjZD57F/n3/q7W01XaqnGp1ZNJjbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747351;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=BEg8CLPC0FvJ35J8ioCkoRcK+0ORXqJp+nIr8/74qEI=;
 b=qmqWa3wvRPXepNO04jReYReo49iIxuoTG3F+guM6jn7WSQsTObzcE+TAZBV7JXZtlAiU
 MDAWvAwWzNkoIDDP0hlp7YQ1xWfBSHk15eDLUNpDDXsj6+YN0InacGRchxV/EqDbFrpqj
 8kxLvF//XEoaawYU9IkC2RcsRNswC1cowM4Ai/itrk7zccbk+U0b641yCg4eL6iW5kw5z
 iqSBSI2M5jgBmIWlEwTYTz4RDYwPRseakTTRvZf+IslRXQ91S0bW6QWfwuzve1izm3Xb1
 DC7ojKOOlBemH1pGrR3yibxL+ztzr33FSgSa5lxlFMKqu9NL6UiGTzqSIYAqlJ4fjQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RaznIQPE; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RaznIQPE
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE5E640567
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BE45443FDC;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4061C2BCFF;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=c7RXmGJpZKHuuuwTX0g1mBK5HIDSq/1hPLFrpfMkay8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=RaznIQPEvbrU36YKoL6kDosDyAoZfqTUO28Vr9+bLaCQFhGq0uHW5DMndmtpo2070
 mpTuGqYXG2qRLsCwrxU2kahoVWdsk8Prol/XsZAgcSJepPwoRjsjPo87bYPDGX0Kmo
 g54+8R8In/1XNchQMXRSVcFHel//wCIF2S3vwM0SJbe5+YXB/wvgNPUEkMjCGYqZzs
 xkFavoMJYlGqqQ809z+MoWofvKIHMifyu4uLnoEm0mmu9G8+gR3w0WzOITvAuHpScj
 xE5kA1vR3ITR482JcuDXqnnS6BvdD7edE6gB+VjvT8VxTPX7M/FNfkIr8sEVNtPLeL
 V2JLqkk0NEO6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 93633CA9ED1;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:50 +0200
Subject: [PATCH v2 8/9] configs: pinephone-pro-rk3399: Update defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-8-6b7be35fbee7@protonmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=2042;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=rQ4wSUTjR+TG1pW9NQEigFLQuEmPwsgkU+YttSHkCC8=;
 b=gwl9Hg2zf8oX+YIAngmqmQJ3MPnnabS4/vwuOodJ2lg1h/8xRD9QMzuXg6n04b8dO9RixugHv
 pBilg2gHCLjDmsnUVgpuZGNB59dhYzCOF1/VLP27QR73DpDNWunBQv2
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
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
- replace the eDP display driver with the DW MIPI DSI one which the
  Himax HX8394 panel needs
- enable the D-PHY helpers and the video bridge uclass

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 configs/pinephone-pro-rk3399_defconfig | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 81bc6d5400d..54f155abefd 100644
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
@@ -80,8 +90,13 @@ CONFIG_SYS_USB_EVENT_POLL_VIA_INT_QUEUE=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_GADGET=y
 CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
-CONFIG_DISPLAY_ROCKCHIP_EDP=y
+CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
+CONFIG_VIDEO_LCD_HIMAX_HX8394=y
+CONFIG_MIPI_DPHY_HELPERS=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_WDT=y
 CONFIG_ERRNO_STR=y

-- 
2.55.0


