Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFF2C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 03:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B1D660BD7;
	Fri, 18 Sep 2026 03:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RuVxLp4e3KjP; Fri, 18 Sep 2026 03:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BB4CD60C0D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789701403;
	b=Q+qv5uHhFr2HAFUD1aS+Rly1qVAzXv81XzaXbiH/FP2ztdFLB5i/Qol7F0IirdMTAQPu
	 t482iEWJxbQczAzrQqs261ew+4EJ9Jul9wAsBJ189NDWheM0x6A7UI5uU1/wkiJHQh0YT
	 xbUqdvB8gzoWXw7cCM3VNZR5BV+sHUdx9PnIw8Tfed2s8aKOwa7tnpI6xOqKfJ8o48r+F
	 dvZW0QRJbAJiBgOMTo22ZMMmwrSzUePS5xjefSh9VMZro5gtF8RqOflMdE8BGAyw0NZab
	 bGhpz1eNtQxj+sIJy/jiKILv1pOSA+MQNURmAqlh/oCH1RwYQnJVcLXDWaTutLwgVHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789701403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4XAFl50eOrFEMTHZAL69dRm9cFgpZiryG09Aw/2SysE=;
	b=pIEb6+fkCp8yGxXXR3FH0B7L10r9rqUNTq+zgfJiW6tvg5SUs/sbLnf4AxWLYUp1G0TT
	 LUevaseqfd5jZH2KHo9QkMUqstN40kqCuuekoZb6VC+Bhwjb1AYljgHjc/LBhLpfyaplF
	 oCyqQNjDlvEKNNpVMeTQh5URyY1mHN+vX4E3hPv4vqe5ATpg3ScbVwvuXWbJXf0lP3IJr
	 muo8Z4VrzLaJ/1KdLaDZlIV1IduccyZ8gJ3pj30evPfIYJIhLk0m9UgQZEx8RT0jMc3x/
	 p0gp6fWfkpcTFV8mq+hXQhZyDasj5ldh2G3XowNnErp8htjVpTcNp5UKSbNsuQCswDg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789701403;
	bh=4XAFl50eOrFEMTHZAL69dRm9cFgpZiryG09Aw/2SysE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDXyR3KjNV93Qt643DFlXz9xT5A7joxOF3eHBX6DJkWA7maKendqikhaOlOdpkG4p
	 tpP/ENuhtUSkwdGlhjVSqteM5rK3IG104R/gWIJpJBro1wOYR4V+DNVu8Mv3S3xang
	 6bp1vAVVOfRes8m227ULgEnzL9EJ3R1brN50J0sfQ1gFf0cNo6r6SSj2KaBLfn3Xy/
	 8y8TwJOEW3O8FuVnef3l7bW+fA9Hj/LH4uU5prHyeYmkO9TgoFUSN/GLCPdUbiozdT
	 I56f6SC0816NwdMt+X1ayzOJ+IihZBNmqb2tUcC+ihUKZWSZcPrCr9iA80CjgraUdP
	 Fd7SgefgDbhYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB4CD60C0D;
	Fri, 18 Sep 2026 03:16:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E94A2422
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFEFC404C5
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fy-tlvEWfR17 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 03:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 240204008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789701399;
 b=T6xvcwSJjX3x1IfO+0ozVLPfzSDuDFlP66qx9+gW7XE26LuaAJhXj4/DLhPjD8X6UVeD
 D1kQlHTiyVZm+2yQLkDhv03C6Vyv/RPVhb+Us30MEjGdzum6rED63wHktcUBe8qzucW1n
 ftpVWYtbpXOxTgyjdRnlZt1jmJDgFGAwesVjrpB0e7/AKLxovtiovevftLTdS8khae8iK
 nXQJcU4l41rFKZG7qMRPNciHdSvBRRxeCGF3vpMovX1vqHCJAnM+24CHDvQxJzwjIkAiL
 q3n8efC5SaqyqjqsSjkHNz1YO1fPw6m82MmoKz+6LFysaWiLFX3eaRIey0TcZpmYFog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789701399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=4XAFl50eOrFEMTHZAL69dRm9cFgpZiryG09Aw/2SysE=;
 b=OCAsb2dJGj6/wLhVY3ccheZpG15GdN5xRpPIhsg2F1MyDzZRA/HN/ldNzij5RlD9Z2qy
 xHS2FjM9O3m7R8+RZo+uJXihNyHJmoOTO4emOfefbdvZgQbCfn9vbH/y9WeS7xJ8SUHpo
 ooGfdgFeM33dSQPnjvQjzQDow/orIpZ7AtAxfTskYrz1cAgxPwi7Bguc4IyxRNjMBUteu
 Abw8W8Xa7FHvBSW45IlUYfqZbB5SgZ1JYUP3O6oxpxBhbjKt3p9gHZX1PsRJUb0iPdmNV
 gvGGFMCWTuCBb5kVY01mmT4s+UhsDvM1VGYbcZas2kC6BrVQT6CW4N0Y2NFSE20uouQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=e+io+tUp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::e;
 helo=mail-pj2-x0e.google.com; envelope-from=jim.t90615@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=e+io+tUp
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com
 [IPv6:2607:f8b0:4864:39::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 240204008E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:38 +0000 (UTC)
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2ddaa08c890so2246905ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789701398; x=1790306198;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4XAFl50eOrFEMTHZAL69dRm9cFgpZiryG09Aw/2SysE=;
 b=e+io+tUpI7F6laN19PVHLwZ04ujAxPp1AbLuR/TBiItn6q1qyo00hxAXLLZygsbxh1
 3X11zTnLRVjB3eOlB8m9XxvVAOyLw11VrXmLnj5vkIWTUDFnqHnHUtWGlXZxBf4HtDjG
 wHDi5UarMZP8LwN/uSe9CcXOJh57l7wS4bpDIorauQHHRlPkUxkQPzzE5E4ESB7WHPhO
 W1T7q+SesxbjlV91xyWUqJfEr0yBxNjFzGlk12+KUj74M1g8VdOTej77dLTN4VvoowM6
 ue5vIrETMdFS16HHR0cuRqL3SEE5o/fRw5GR+h9p38HCxbJOvHc1beRCD82Zu+qfx1Gh
 kF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701398; x=1790306198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4XAFl50eOrFEMTHZAL69dRm9cFgpZiryG09Aw/2SysE=;
 b=iHJMn+FwjuzUNKumHj3k4hgWzX8Eq/rXg2QERTH9y0s2O5T4dz3VNZjyyRR2jZawK/
 QnmK5uqxX27axKa+BOmn3qWD9qR1duDCfXOlv793Tm03Y8RSl6DfMUN7UlAw3AzTru+G
 0csqJE97OcvnvqOye8uSVzhWOXRX3XAzH2i3eRgkzHogefg28oyi+VaFGJ9bWBHDrsXT
 0bb2fWUmkDcvIeQc2fv+DKZcqpCvsFEpxqjHzaplFCv89l9pFyx/u+Nc+LEXaGEwtZyZ
 7UwXGu9jcTPMEjnXzc7VX4PMspbrFX4RiIUboaLdu0pqoxtpMSR47w3pk8MTwi0el8q5
 QC0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEjCaxHVTYz2zd8SukZCHJGAR3Zylt4Fzmr+Vat7Es9g3v6qYWWiLeyit8KleY5kxgdQEd0PY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nYy2F0RKXdYAn0eYe4pGWrQtolZ9ImNMkrATuEIyWjzbsBkgkE
 6IkS3sWeXyEVzYbDs5wZsO+AydSaAUF2c9IFO+x9uWxvsktTly8AZXRi
X-Gm-Gg: AYBFou1i0PS+hMC7cpkAvZOyt+YLN7CMwRJzeIAuhGf65Q0B/ucOvKoBfsmU0pO6sOz
 TsR3CruuJU41is5dwlYiKZHTB2jz0K3hF4DixSridJyK7T5JvPdByN9FmC8/RYZoNSxCqvUdWTK
 1tS/zAA5Zeon538ARuFQ8eAqmACWlFKHdB6IwAGLA8ezZt67+UvWTZDeTgTXAPC48LtWdLwwO7g
 5qNgJLtifhnIh69Y05ZArGbK3zy6dxzeUSBWHi9AoIw1cfZ0w4GSpuDjnBV6eKOMqRgXPPL1cKt
 9GNofN3dfHlzqPMlhMgpKK89VYhcQcqn8ZLGZdHvH7fd9dfQmzYfKMX9pOR5WeGdRSbVYdn9/vd
 zuvIj5wWMhzvG27+PFF7wybm9bCwex93tiH+JirNIHbIbd4VPPAcKP0RqPbbpIr8OGNC6cUv77b
 PnV3IruFqTagPxUUN5oj/LW/e1IM7GvGHVFwU8SRQ+gTXplGMtQcGN9jqMWW5GZZN8Sm8kI0zBA
 CKJwO8C
X-Received: by 2002:a17:902:ef02:b0:2dd:ad73:5b6d with SMTP id
 d9443c01a7336-2ddb1c45ddamr21412295ad.29.1789701398185; 
 Thu, 17 Sep 2026 20:16:38 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75b53fesm874505ad.59.2026.09.17.20.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:16:37 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.denx.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v1 4/6] configs: arbel_evb: enable additional commands and
 drivers
Date: Fri, 18 Sep 2026 11:15:52 +0800
Message-Id: <20260918031554.1855939-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
References: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable the following options for the NPCM845 EVB:
- CONFIG_CMD_WDT: watchdog control from the console
- CONFIG_CMD_AES, CONFIG_CMD_GFX
- CONFIG_SPI_FLASH_GIGADEVICE: support GigaDevice SPI NOR parts
  populated on some board revisions
- CONFIG_SHA512 / CONFIG_SHA512_HW_ACCEL: SHA512 via the NPCM
  hardware engine

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 configs/arbel_evb_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index fa73f7caf10..8814b43dddb 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_PART=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_DHCP6=y
 CONFIG_DHCP6_PXE_DHCP_OPTION=y
 CONFIG_DHCP6_ENTERPRISE_ID=311
@@ -49,9 +50,11 @@ CONFIG_CMD_PXE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_UUID=y
+CONFIG_CMD_AES=y
 CONFIG_CMD_HASH=y
 CONFIG_CMD_TPM=y
 CONFIG_CMD_EXT4=y
+CONFIG_CMD_GFX=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -64,6 +67,7 @@ CONFIG_NPCM_SHA=y
 CONFIG_GPIO_HOG=y
 CONFIG_NPCM_GPIO=y
 CONFIG_NPCM_SGPIO=y
+CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_NPCM=y
 # CONFIG_INPUT is not set
@@ -76,6 +80,7 @@ CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
@@ -118,4 +123,6 @@ CONFIG_WDT=y
 CONFIG_WDT_NPCM=y
 CONFIG_LIB_HW_RAND=y
 CONFIG_TPM=y
+CONFIG_SHA512=y
 CONFIG_SHA_HW_ACCEL=y
+CONFIG_SHA512_HW_ACCEL=y
\ No newline at end of file
-- 
2.34.1

