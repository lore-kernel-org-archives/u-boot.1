Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47FFC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BFDC40A18;
	Thu, 13 Aug 2026 17:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbK1xJssc13m; Thu, 13 Aug 2026 17:03:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00FA440A0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640586;
	bh=MObUNTIfdluMWOJ0AisafRef9liqZSbWMgsWYeOSXKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qgrYmdpWtdme0+3Dg/3Lyw4pg9WHj2wAPqTot9Dj3cJcXJZ38zdWtutLxuu4+dReu
	 u6J9TfRltsZw5Ndv0IiyIfnfP+ImVXjU756zeMnRD4dMAdSSDuAZ6erqDxyspjm1fU
	 qugBgOETu63HNF6ECtJrRaj9U4B5MjpSghKpegtF45y+4b5pIupRubXmFC9ubhROzd
	 mymN6mH7tb9Rcn5eEOwvZ5yU//6ql+dJHowEZj4JYf4pV1GKXIFW99cfTjphbr17Mq
	 jkee8ayYJJaj/t95WuhK9wKZeVsJueyyapNuW99qGQdFIR6kaFip3kYXAcKxU24PKv
	 nGZV6xWslyKqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00FA440A0A;
	Thu, 13 Aug 2026 17:03:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 04061EC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01B3D40168
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGYupiO9i20B for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:03:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6221740158
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6221740158
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6221740158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:03:04 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so17136a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 10:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640584; x=1787245384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MObUNTIfdluMWOJ0AisafRef9liqZSbWMgsWYeOSXKM=;
 b=rrOKoPX8XDvR52NxxG1RWNxmc15Y2gHgXmHLC9LoZHL+v5VmppDrRb/SeeaCm5tV4J
 rXYC7FNpPMRmuuutaYjFvWDbOEE+ZulISk7vXmpm7WKCHLQBEBffggiOfPeN2bolH6Cd
 ZsOfbNSM7Mjb6OPlR3fh8V2Rx/t72KXGyHYToJJWxeejK3ogoFxIE4hFSuhoLKqaCbhk
 QTHtQNeoS9kaZI9wfVDkwxGI8xYUb+dNnlJcU50HWv8BED+erCSMOVQwiqHYETAVuFmH
 4o8cJRcITzTFAK2rfaJ5LuneJ/s6IaLWWcHReHU7qTis/cd9eP/SBupG8CV0rhYimKre
 cmRg==
X-Forwarded-Encrypted: i=1;
 AHgh+RocpyKb7lL5s9TWK/Jtgj/5/ipTF+dzSyJH9lGmhZpwtjae+RrigN+64PQrHR9DT/5JCFxY+4o=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwHCqscwiojtnICI5HS+1MepAEFrhfc95JADDj/i3BvqTG/CRYi
 JQLfYgJ+kafk5cAHIb+Tn8IEWwcEzP0lLLpjGH222b+RHPD8dYJXfjYi
X-Gm-Gg: AR+sD13kJHts05uh8LQzGl4m+IiW0yT9ozMMFNe56UcJkC2rHqtjDoRJxMGpTpimxei
 lnML6aIzz733aMLQOxfoJHmvu2DuH+/oGrLczrl0BDVnFjrjfJTlQpazW8l3CHZtc0PDHPMzm7u
 XhOZ2t75Wn74hxCuU0dV3xY03HV5doebfrhKUrThBLZe8Q6qypkXAAhGNuLOq/WQU9SfkeriM+k
 2xoCXoemsmvwSX1uJJKnFCxMoqe1UVRF3liN1/zRNj2NcCl88DkvceDapIsGjL4713xd8SyvCFU
 BuYfWTxNAMOhoMD2VAaQoepUCQt/8xYLW/xHuh8x5mpipgT/ImHvS6PQmIOt6131/dkgyg0EZvN
 7oK0m74iH8e2sjXQu8TRsje4YMGxseeSPxSw2xUg0VbpdQ9R15xRMczHNWaVM+igqapc2s19dwN
 VIRJu/Ol/pysl1EW/cYUYYJailH7wBfm8hRRyYuAhTIke8TI9l6/JZ8vw3rvhJpzGxloKyZmfYu
 EPLfHGeiFmVzJIFaGZqroicuNwLfRA6hy+cPQ==
X-Received: by 2002:a17:90b:4a4b:b0:38f:cab0:9aa9 with SMTP id
 98e67ed59e1d1-3931f583a7cmr4120629a91.13.1786640583277; 
 Thu, 13 Aug 2026 10:03:03 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a802:463c:b2f8:f8b2:9607:d599])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1413889d914sm92391c88.13.2026.08.13.10.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:03:02 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: u-boot@0leil.net
Cc: trini@konsulko.com, kever.yang@rock-chips.com, sjg@chromium.org,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v6 4/4] rockchip: roc-pc-rk3399: Enable redundant environment
Date: Thu, 13 Aug 2026 14:02:46 -0300
Message-ID: <20260813170246.110899-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813170246.110899-1-festevam@gmail.com>
References: <20260813170246.110899-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786640584; x=1787245384;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MObUNTIfdluMWOJ0AisafRef9liqZSbWMgsWYeOSXKM=;
 b=Nw97avY6LHmXKLTbECJHIbsyE90XCYToHANQrY6Tvg32tCASWtsVg2oeKPky8GHMzo
 7sPOXbBgiJjq5/5CkNXW8pSKieeq/6iSSyEP0qhjF95Dc9x8szUdsSRZFuDdPgFuFS+e
 xgoy0tecvpWONROP6mq+zRErqFU3KAdFJo/zxKLz36F2Qc9tPUApcSYnTICRjv4IkaYU
 mZJ0ZNsKVIOzC7sgsM+8DlSJnpIqity2XTCqMLds0lIH/L04S5P2jYKh8V6be9QPCVoB
 APd8Z9ixsWf8dsRmhgHI6hVNuQ0paVrxsTCJ3e893kPR2XDe//dyvhaTSbd0crYQ89tD
 drRQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Nw97avY6
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

From: Fabio Estevam <festevam@nabladev.com>

Keep the primary U-Boot environment at its existing 0x3f8000 offset and
use the preceding 32 KiB region at 0x3f0000 for the redundant copy.

Both copies are aligned to the 4 KiB erase size and together occupy
0x3f0000 through 0x3fffff. Redundancy protects the environment against
power loss or an interrupted update.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes since v5:
- None.

 configs/roc-pc-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 53182dc8251..4347bab598a 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x3F0000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
@@ -41,6 +42,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="rockchip/rk3399-roc-pc rockchip/rk3399-roc-pc-plus"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-- 
2.43.0

