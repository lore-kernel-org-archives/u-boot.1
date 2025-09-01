Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822E1CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 09:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32194839AC;
	Mon,  1 Sep 2025 11:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TmmbHi0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4BF833E9; Mon,  1 Sep 2025 11:00:48 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F7F8399C
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 11:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b043a33b060so45567566b.1
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756717246; x=1757322046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TiN0WCYaQau3pmUs0C8QsaWA69p/U+KnHLZC8ERWuk=;
 b=TmmbHi0nzBQdKkHy2Rfog1PQrlRzYrpzzclFEijzmF1B3c1pnO2fiSDN0ZM3487Msr
 7IvZtRj06BVvGKqJqy9Qfayu30evD9oQkOJ2HgGd7v2qqPht5QCuIWTfMPqZQF4LeQZb
 8Ftc1PZkHcBj54HmP3ak0jTriahWxTuhAZrrcLxIGAAukkckUai4PmIe6etQIuAuomBx
 /pEb/DGBHPJh5q5LOcHweCmpY9eCnbkjukCIcKzWxcN0XG/O5Jm8rwuchB8sRi30YwVv
 Depmlkc5GEC2MxME4JaDPQH1aiX3RGhS+ujFrHDIJIHp42JR7ib50VW7mqqyixLkA98O
 Z3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756717246; x=1757322046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/TiN0WCYaQau3pmUs0C8QsaWA69p/U+KnHLZC8ERWuk=;
 b=vS+3feL8KkDEu7+zaAdHNeg2s9TcprZQwa1qtlZrq8fKUb6BWacVN9Bgfwfgi997hB
 V+nqit+xAT9AMtD6HkE5Dr2d45M1St8YmW1v1GraJ2CmBC7K+kF3unaTq8AwsIEikJdD
 tdQMqn2LORArpQbHR+6ENRjhM1cYrPs/ucPgHJYhCOgin77OQKKp+yNhWq5Z8kDIHw8N
 ES6kJJvTNf8sUUdodWQ9o0TBtXUpXcmZL32tMnqD+Pq6Tg4aWcKzOGfhqxHTauZGqSiU
 LOgsCqlLDFr2lCJnXTffNbpd6mYDtFn/6HUIN9tNOZWZmo/MRlQLwtRRq1qBw9tpV+wo
 lVWw==
X-Gm-Message-State: AOJu0Ywck9tYS6ZRQoLRo+cdkW5tCLlFFhql8745zkuYplrgGH4aAKc9
 jiM5hqJqAuxYVuBDU3tCL+oZGq3Ld33+vJITB9vkVUhruLChE7zvyH1O
X-Gm-Gg: ASbGncsZkiRl5ZKfeGFgQPQcHujDIzX5AhPs2OV7gMfog/J9a5gVW5sJXVBcfQr/s72
 /y5ziVvrpAq+LW2laeryCfPD03PtxQvVEew/6dnaBwKW0KPn8okaiCwV1cDXI8XMu4xgr6qdkDy
 n0PgDXRwsVG3q96ggrTNXXj9mcFROHiFWi8EdWOVjRqFOikv9zi9zJPpWvdrnrwfJlLnQr2Z4F7
 nUjb5CC6d8MjLbV7siocl65AEuOG38AnJ46ICV7vPVSsXitY/4B2tIXZT2o3f+/C7PWoG6uAlDl
 4g2/Up3mpVIIrlZxjD5igyzIklZGsZzQjSARxTZlFMOxFMBOdh+2pf8EbL2+TszQzwrW4EJt4fP
 uEvmm8sVXYD+/6g==
X-Google-Smtp-Source: AGHT+IF1y8iRe7bPzRiJOP1LLTuWTYtBC7JbztjWUQdd4ObK9cVt9ToIZ3reUVPKLn+B48fW3nbdMg==
X-Received: by 2002:a17:906:e86:b0:b04:155a:c139 with SMTP id
 a640c23a62f3a-b04155ac1fdmr379693366b.4.1756717245861; 
 Mon, 01 Sep 2025 02:00:45 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0428f88a61sm215152566b.70.2025.09.01.02.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 02:00:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] board: transformer-t20: add separate env for SL101
Date: Mon,  1 Sep 2025 12:00:19 +0300
Message-ID: <20250901090019.11930-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250901090019.11930-1-clamor95@gmail.com>
References: <20250901090019.11930-1-clamor95@gmail.com>
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

SL101 unlike TF101/G has no Lid sensor, so lets add a separate env for
SL101 without Lid sensor used.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/transformer-t20/configs/sl101.config |  1 +
 board/asus/transformer-t20/sl101.env            | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 board/asus/transformer-t20/sl101.env

diff --git a/board/asus/transformer-t20/configs/sl101.config b/board/asus/transformer-t20/configs/sl101.config
index 4f639e1b412..87c6f7a216d 100644
--- a/board/asus/transformer-t20/configs/sl101.config
+++ b/board/asus/transformer-t20/configs/sl101.config
@@ -1 +1,2 @@
+CONFIG_ENV_SOURCE_FILE="sl101"
 CONFIG_DEFAULT_DEVICE_TREE="tegra20-asus-sl101"
diff --git a/board/asus/transformer-t20/sl101.env b/board/asus/transformer-t20/sl101.env
new file mode 100644
index 00000000000..f2bf298a997
--- /dev/null
+++ b/board/asus/transformer-t20/sl101.env
@@ -0,0 +1,15 @@
+#include <env/nvidia/prod_upd.env>
+
+button_cmd_0_name=Volume Down
+button_cmd_0=bootmenu
+partitions=name=emmc,start=0,size=-,uuid=${uuid_gpt_rootfs}
+boot_dev=1
+
+bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu
+bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu
+bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu
+bootmenu_3=update bootloader=run flash_uboot
+bootmenu_4=reboot RCM=enterrcm
+bootmenu_5=reboot=reset
+bootmenu_6=power off=poweroff
+bootmenu_delay=-1
-- 
2.48.1

