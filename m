Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382DFC4452B
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 01:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEF564071D;
	Wed, 22 Jul 2026 01:37:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ynepvcze3pxf; Wed, 22 Jul 2026 01:37:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13CEE40738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784684238;
	bh=3VZ8C8SeFtjRdo/eT3W/oZIKDAnqhbZYWUATqftqKTg=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CQbdelTCwCYeIFwDiH2zEk+oBUCMN7OHw7sAGfecPIROU+LFxN07COg4cqP+HZwM3
	 V6pLHjNufqymqxiFgBawMOHESYBdBaQnog0czQc6AQcIWUR7Mwo1D8Ow+ESjT2dB/z
	 qXXJa/d5sDXxEySnoU6b88opP7M5noY96BzmVfNPMsyxytmqxymE2ga2nky1J8pOpi
	 B1h314oHpl6zFn0Kf1SM8v4OLJc/09lZoCoM/IYAwzwCl0wg0t0rgqzESyg4c669x3
	 qMs3jY2ccs4n2+OTq+s3UrTNz0qd489bgTdOFLkhdz7VdOf8Ac7fzn9WZ8g1bFbFkZ
	 6KhJ8KorTMYUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13CEE40738;
	Wed, 22 Jul 2026 01:37:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 551B29E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4728A4071D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VXkCa7etlD8R for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 01:37:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 871AB40719
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 871AB40719
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 871AB40719
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:15 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66843536f94so2629703d50.3
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 18:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784684234; x=1785289034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3VZ8C8SeFtjRdo/eT3W/oZIKDAnqhbZYWUATqftqKTg=;
 b=Iz3bidtj7HHmguucWzzmmqZg8CssMxXD5AKvRapT0yiE5XUHkmZUpDckD3csqK2tfF
 LFRTgMMKLo/sdhju3hJVbMibLpWJuISfV8q37c2tD1/dzVIXgEjqstH2uVC17qAl/b26
 4GjylhVUl+t5Bb60wlR81yYr5rblLPSHL4dHQUv3npBNXEcyVxR/j3nSwAc6MlJOa9ob
 xJ5eerpV8eZcbUHX4xtAMsVqS1bhyM9oiaxOWRKAlePPQLu6gifWgNUKm5U3YP7FW/D4
 doTfH7gCZLj85bqJFEpN73ScTa1MpzoaYAyBUFjAvxWAQbQmWXq4WjBjVgg4At1EqZF0
 6JWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RotfEX6D0yL4KPoZmfCm+NV4HbIeiexWouNAoEJr3kdxWzKz4MIqOc5QxdMQXeJ5QpSEKvrVKE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxyPSuW2JWlQTqfFUSb+tCtd0/+a75LwPTGgo3Iv7Q40Z+nSzu1
 U+OWJmwNdHX0sllI7tOs51odBIvJlHgcjCtF5z1HuQIDkXY0YSBErDAx
X-Gm-Gg: AR+sD10ZzRvUwnhpQ4CXcEacvNdpnnz2ONIB9a5oGP3jtp2/qcUi1YC1PfldIJAnRLS
 ywe27xQgBNItLgUvvSUHgcKLWWYLTlXHHAgXHV/D0SR4vFBMv62yXgd99R0HaW7vnsg8oQiqmjv
 aFzM8FlRDTCJwlJBXBxWg2qXdXojd+APiCMla+8gJJMh/i90aA5PYlIxVH461Q+gf/usOQXLK7S
 EFSscyo7Fk4jEPqJ40TosbEZEfwt7bR3eblzEtBKK+nIX7OQyyEPtRlJNfFC+hBGOs5sOOJVo5t
 Kjzng1LrWxzRsEqAcKzt6C6wqTNjyvxa8vciCLaWnfD6k/Lv63EcyvbQzge3HbuGs/Cc+Ax2mU9
 gq+1Rb64EJY8nEfpAk6gypQszmHkrd3r96SI7GiJ11pr7NFP0X9BIml4BItUU+KfT4rnxNBTpwL
 SWtARs8rU+S74BeLGvYk4VsUqmdZS+F4RRH9emJZDua4169lY=
X-Received: by 2002:a05:690c:3505:b0:81e:6c2e:f113 with SMTP id
 00721157ae682-81ef2857f57mr66114777b3.36.1784684234145; 
 Tue, 21 Jul 2026 18:37:14 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:1ad1:7a2c:313f:6408])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33ee52a0sm6372937b3.36.2026.07.21.18.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:37:13 -0700 (PDT)
To: u-boot@0leil.net
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 5/5] rockchip: roc-pc-rk3399: Enable redundant environment
Date: Tue, 21 Jul 2026 22:36:42 -0300
Message-ID: <20260722013642.1011666-5-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722013642.1011666-1-festevam@gmail.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784684234; x=1785289034;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3VZ8C8SeFtjRdo/eT3W/oZIKDAnqhbZYWUATqftqKTg=;
 b=EXLIszH+uKGFJcCP1m5hysoMRqEEyBA7jRv8YJe0bGGJSz/u1+N2irzfcjOpdqcGIJ
 imqbEtsU/6WLSOnAEJIZq8IltS9qcq0bxgVcD2ZwNudz4DUz8Y0tb1y112//U4acT0Hi
 D9U1DvVUCzKvOTuew80x60z57h5l7O/gVfh5JpqQJMRf+yK7oea6fa7EEaL/st98dG6n
 ySWCnIBQpKSRN86JL5kdC3zEYOh5wgdirv7FblGBcBuIR2qtDr74egO/Glw1lKC9C6NR
 cH2GrD8jLxDH8ygaEj5wJC4SeVgoP/ZDMR1I3uyrseHbzIHoULI/IenbVmJ9ZYnrc3Gs
 k5NQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EXLIszH+
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
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

Use the final 64 KiB of the first 4 MiB of SPI NOR for two 32 KiB
U-Boot environment copies. Place the primary copy at 0x3f0000 and
the redundant copy at 0x3f8000.

Both copies are aligned to the 4 KiB erase-sector size and together
occupy 0x3f0000 through 0x3fffff. Redundancy protects the environment
against power loss or an interrupted update.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Improved the commit log.

 configs/roc-pc-rk3399_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 127b71e97917..8ded89c6388b 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -7,7 +7,7 @@ CONFIG_SPL_I2C=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x8000
-CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_ENV_OFFSET=0x3F0000
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc"
 CONFIG_OF_LIST="rockchip/rk3399-roc-pc rockchip/rk3399-roc-pc-plus"
@@ -19,6 +19,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x3F8000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_DEBUG_UART=y
@@ -42,6 +43,7 @@ CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
-- 
2.43.0

