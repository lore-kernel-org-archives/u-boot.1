Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F597C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9D9660B9D;
	Thu,  3 Sep 2026 13:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EMEMxkpnqCa6; Thu,  3 Sep 2026 13:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0845E60B8A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788441013;
	b=bLd6sYnfsNBQR9/A00AaZ+0vr9RlEuj3NLtm+Q4HNIKEDJwQIsux95tEnPiDa429otAj
	 wpNmnso0BpeZtFByIQWncX0D3ap7M7glcw37ayVOSNOxVHAsBVpa/sUxuaysYWJBhj9PV
	 +Ll1JVJzj9GcM8wdtTveszF3cTNV3CWSjmMYyzrTOysJoL68U8pOrl1kD3BPpXepE0l7y
	 QKpkMQzTOkXbLY2xj3aaHH8DnqumTnXCmvATVx/spp96TclfS9+TWXjP2p6jqMenSZM3w
	 bkx2csoAC7AqxXxo8v39tzOWTmkWuj0Gn9nuvJc3DY5OZ6mGlU+IIj4CLWg+TPcv2rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788441013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GUz8rXr9peb8VyX7btc3U2Jiq/Ue9uIzoxOPy6pBr7Y=;
	b=h3ckIhbweLof6d3Yuqo5SayD5ro0FWSN391F0iKRh3H6bQeGJHrHN58U9fexRMCv7abt
	 Q0fggFrIasO9ZDNBTDkP8JMe/+ePz5BLQO34SBdjyBAVtKZc8QAiTBcwKfsGzzdbXFfG2
	 foh4u38ZPkS2jzfYL8F1gIkuD/z6ArKt18FI9Tsau7Oa0rK1+JKtU3s6x2Qt/w1fo9E7D
	 XcdSCizYXgeN9wPnLbSl5jHoB/zHs93hoQFVU9YiRLkvY1DsaT1S9rxRNeapLx/ogQP51
	 QPkuGlIHwwYeC8K5W2lY/dLmk/BOuTBH9RPKZJ3T5lt949kXNYBZt9W9O+D0N0/9DoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788441013;
	bh=GUz8rXr9peb8VyX7btc3U2Jiq/Ue9uIzoxOPy6pBr7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yrrpTieW2OVxYsp8/HKYtvMV9i/PnpItV1lvmZvCFo1FLY6aMkxal0LZKTa0nvmaG
	 SvfFYY3B5LpdhJdtCY3ZPXfZ3IjZZaotjij081skQBMU496rsuvDE6iB3S8aTz24Qk
	 AM3Td9Kjj3PhYfPQGwfMTxD6Bny03qHZYABDi5dPa+4y0oVXXG6S0aUlyMNhw5qMTJ
	 vfHVltHRPqJUXbJdDeVIolut0MTFFRay5vuDM/9gi1s9DGlyWYUJ8hyDQdXjGM8BHu
	 jQu8PfCNM/09ftjO6/y20/g9WMnnxHUCMvv77q6/mOqc7MJArAjC4AbktUgbLW3Ta+
	 A6Rrsobx47nEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0845E60B8A;
	Thu,  3 Sep 2026 13:10:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 948EC422
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F5FA8100C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SXkpk4WsqPqj for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:10:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 735AB810DC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788441008;
 b=PAhDAdAypGYA4qNGqUZV1sgl8AHnz8S1Oendqn6Tuw02StCYL9hIt/9Zm4EYGoKq+AON
 b8pE+POkcxyHtccs9P6AkFbwg7oeThzIxiX4Mom+JMUu1xuGDhIb52oMNuhzL4rXxbN4T
 52oBY58W3PWKP3EW8iJaQ037kjmLtY3etsZ5gO+TD3uv8tP+A4/WBfpy9q47mG/ZgEPDQ
 EXq8WCBpy92SUt2ASUAb+rV9GjXTYpyKKB/bfVse6jb7JyhTDEZWmUjYqpAhsVtZqYJZu
 iD9KWDP5nCmlIhxEVJDQfnZC0U6LorFsbamIWSBr3FAbYSouSxOlUCUI103K9309mJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788441008;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=GUz8rXr9peb8VyX7btc3U2Jiq/Ue9uIzoxOPy6pBr7Y=;
 b=QnIwmjk4V26MugIjBKSsqo0rEwJaEv9uvVcckzf2IJSWHV29ezYdLSVvsWXS82ObVaKe
 JcuVSi29yCWKfeKBLorxi/LrvY7uyXgOuXtbyPwDAv8l/reRNNLKec0+Kk3QYQkolo2FO
 BP5PQznV2KuoVMIzuS8jykxjQgbU1w3kdjztLA2gViAUCTaV4GQelYILvR/HK3I1pgoA/
 r25H1GsOr2lkwnxlP0jW6Sg9p3emlqfOP3RJ9W58rppGjS/vV1EfbiK6YMPk/7fKxxlm1
 NEJ2POf/YyLpjHeiagL5lGeYlbj+OUcdqYvnF8Sgmc8F1sLvCSHDGPb6/qHmxBG7gtg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fnQ7Iw6f; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=fnQ7Iw6f
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 735AB810DC
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:10:07 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so21329085e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788441005; x=1789045805;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GUz8rXr9peb8VyX7btc3U2Jiq/Ue9uIzoxOPy6pBr7Y=;
 b=fnQ7Iw6fVRtxsxy00gXncwGuqdNCuxBH8us8seHnrUrWoPiSPUVB4pJvE80Mvy4iFJ
 19+cZWhS6fH2JXnr5CKR3Uvrd7gudADREZ2C1+T3P8+q3CdC48ekQUcH3GTBrk3gSFQe
 So6G6tvMImCXOIBydE7Kr2qCetwjsdzO2jlI5La2o8ojCPp9X8ll21U7PfeSxTSzvLa5
 3Mwo7ZFmfWn+qF5JpZMIp4Q7QAYhqAq1kIoPXd1tm8MJqjgni80y++GaY4qR1UuNwpxc
 0Rk1BnaCLZrUWU8nrxNR5E9GM6iZMpOi3byCVAoo/yiAxUiQ4N4gBFOkT94RlGAzwRYa
 xK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441005; x=1789045805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GUz8rXr9peb8VyX7btc3U2Jiq/Ue9uIzoxOPy6pBr7Y=;
 b=B7ogkN9fA1wO+vI9vsTCrhxd0RsyWqWTMUk8T297GYp8xAZ1mA1cvgU+zoWvKfsrkK
 bn/0F6Asxz6ZEsh4ujy0aa1Js4CB/2CR4bFNuGn5trBSpRo920jkxRTzrCYNifoRxSVw
 DnprkCAgy1MevWWVplYJiH5Xu3hWO/uD2HG9aHilQCq9Q48MuxFt3ExDfjuAS6U3B5O3
 oHVqLwGgQhaBVXX8tqGRMj0lJZZOj8NwTB8ACpeQHRQSqWHIjgaKKK4bKKp9aKW0zDkh
 ZAOfiVtfZo4xj5Jq/zDDUguW/0KMX9m+6CAqzyI1hmKEIN2oC+fDkhOyFc0dKq2s2UdY
 FvZw==
X-Gm-Message-State: AFuF++mQ38xkxeXq2UdL1yXz43z9QmaL7d0P5oTPhFRqD4xSrM9nY4nE
 m9s6fDsRMVvjwsc0lymvERttNe3/JB4dw283d01WATAHtcf5DhZwHCgwhZ6wyRyIi6o=
X-Gm-Gg: AYBFou3btfs0v8KAgPPTCBRe7CaLbsudhUpKzo/pvJsDGsF3K6kEwHXnjSXAlsT0qOc
 lNedMCEaS7F02bwlPApZe+F086ExvWTRWH4rSMYhfbo10ufYs8z0tx0q70DRfsPF2g9niCpGnnt
 RdvXts0GjkmQU5DdMsP1IGb7SI9NJbve7q1OI+fCZ34Hpqv/P063FtNS+0iXhqQllqDs6gb5Azq
 r/7lkI0rKw0ujdqQXcUrUdV+IbmiuQIGcuNtql07Yt0jApHaEZF2+/T+aIW51wlZjFMkfFaE0GZ
 KxEWErSp1O5lgGqTnB3QruXNfSSCiOZP7NW+644eV+FmwlQF8PogLP7uJeipqcdUFTqudSZ+pPo
 hmAXxonf05fPh30GCTKalMqksneuV/9NvceG/oqrPyEaECG5je9mC5+BiCMD7nrRz3Hx1Mu1QLq
 AsyH7o6jguuj2bDoeVNIV1/WEbGGb5BqlR5mrJ+64wCJA/qVZh8k6iOSrWknrD0dKtwu6k3x07M
 FeNANIW8MaA6D06gOXF0zh+IVS3LFIWBOq6kflHNROWY5cWYbycRPzfEcE588WrNugyIZo8Mant
 +00M
X-Received: by 2002:a05:600c:698d:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49cf4e14cb9mr42666125e9.16.1788441005111; 
 Thu, 03 Sep 2026 06:10:05 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed38cfsm12755807f8f.19.2026.09.03.06.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:10:04 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 03 Sep 2026 15:09:52 +0200
Subject: [PATCH v3 5/5] test: boot: add firmware-FDT source tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-ccaione-upstream-ebbr-v3-5-016658d0b6ba@baylibre.com>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.16.0
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

Add sandbox coverage for firmware_fdt_load(). The Python fixture creates
mmc11.img in persistent_data_dir with A/B firmware partitions. Its first
FAT partition carries five FITs covering base-plus-overlay assembly,
compatible best-match, external-data rejection and corrupt base or
overlay hashes.

Construct the complete MMC provider and firmware-FDT source topology in
each flat-tree test, including the provider phandle and source driver.
Nothing is added to the shared sandbox control devicetree, and the
sandbox test framework restores its FDT snapshot even when an assertion
fails.

Cover default and explicit configuration selection, compatible
best-match, cached-result reuse and selector invalidation, assembled-FDT
ownership, staging and its returned filename. Cover fail-closed handling
for corrupt images, configuration chaining, a missing FIT, configuration
or partition, multiple source devices, an invalid source phandle,
external data and mismatched partition selectors. Verify that only a
genuinely absent source returns -ENOENT.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/sandbox_defconfig |   1 +
 test/boot/Makefile        |   1 +
 test/boot/firmware_fdt.c  | 498 ++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 183 +++++++++++++++++
 4 files changed, 683 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 79f46317e45..b2affd96831 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -27,6 +27,7 @@ CONFIG_FIT_VERITY=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
 CONFIG_BOOTMETH_RAUC=y
+CONFIG_FIRMWARE_FDT=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
diff --git a/test/boot/Makefile b/test/boot/Makefile
index 59a87028704..681c8c4c94f 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -4,6 +4,7 @@
 
 ifdef CONFIG_UT_BOOTSTD
 obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
+obj-$(CONFIG_FIRMWARE_FDT) += firmware_fdt.o
 obj-$(CONFIG_FIT) += image.o
 
 ifdef CONFIG_VIDEO_SANDBOX_SDL
diff --git a/test/boot/firmware_fdt.c b/test/boot/firmware_fdt.c
new file mode 100644
index 00000000000..8c4ac3dca01
--- /dev/null
+++ b/test/boot/firmware_fdt.c
@@ -0,0 +1,498 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the firmware-owned devicetree source (firmware_fdt_load()).
+ *
+ * Uses a sandbox mmc image (mmc11) carrying a GPT 'firmware' partition with
+ * a FAT filesystem holding five FITs: fdt.itb, fdt-best.itb, fdt-ext.itb,
+ * fdt-corrupt.itb and fdt-corrupt-overlay.itb. The image is built by
+ * setup_firmware_fdt_image() in test/py/tests/test_ut.py.
+ *
+ * The tests create the complete source topology at runtime, including the
+ * mmc11 provider and its phandle. The shared test.dts stays unconfigured,
+ * while the sandbox DM test framework restores its FDT snapshot after every
+ * test, including a failed one.
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <firmware_fdt.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <os.h>
+#include <asm/global_data.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <dm/root.h>
+#include <linux/libfdt.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include "bootstd_common.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define FWFDT_NODE_PATH		"/fw-fdt"
+#define FWFDT_STORE_PROP	"firmware-fdt-store"
+#define FWFDT_STORE_PHANDLE	0x10000
+#define FWFDT_TYPE_UUID		"384e979b-eb76-435a-a3a6-1a071dbad91d"
+#define FWFDT_TEST_FLAGS	(UTF_DM | UTF_SCAN_FDT | UTF_FLAT_TREE)
+
+static ofnode fwfdt_source_node(void)
+{
+	return ofnode_path(FWFDT_NODE_PATH);
+}
+
+/* Bind the runtime-created media and, when present, source nodes */
+static int fwfdt_bind_nodes(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	ofnode node;
+
+	node = ofnode_path("/mmc11");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	node = fwfdt_source_node();
+	if (ofnode_valid(node))
+		ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	return 0;
+}
+
+/*
+ * Create the full firmware-FDT topology. Set @with_source to false for the
+ * no-source test, which still needs the media device.
+ */
+static int fwfdt_configure(struct unit_test_state *uts, bool with_source)
+{
+	char fname[256];
+	ofnode root, mmc, src;
+
+	ut_assertok(os_persistent_file(fname, sizeof(fname), "mmc11.img"));
+	root = oftree_root(oftree_default());
+	ut_assertok(ofnode_add_subnode(root, "mmc11", &mmc));
+	ut_assertok(ofnode_write_string(mmc, "compatible", "sandbox,mmc"));
+	ut_assertok(ofnode_write_string(mmc, "filename", fname));
+	ut_assertok(ofnode_write_u32(mmc, "phandle", FWFDT_STORE_PHANDLE));
+
+	if (!with_source)
+		return 0;
+
+	ut_assertok(ofnode_add_subnode(root, "fw-fdt", &src));
+	ut_assertok(ofnode_write_string(src, "compatible",
+					"u-boot,firmware-fdt-block"));
+	ut_assertok(ofnode_write_u32(src, FWFDT_STORE_PROP,
+				     FWFDT_STORE_PHANDLE));
+	ut_assertok(ofnode_write_string(src, "partition-type-uuid",
+					FWFDT_TYPE_UUID));
+	ut_assertok(ofnode_write_string(src, "partition-name", "firmware"));
+	ut_assertok(ofnode_write_string(src, "filename", "fdt.itb"));
+
+	return 0;
+}
+
+/* Clear the environment values used by the tests */
+static int fwfdt_clear_env(struct unit_test_state *uts)
+{
+	env_set("fw_fdt_part", NULL);
+	env_set("fw_fdt_config", NULL);
+
+	return 0;
+}
+
+/* Happy path: the FIT's default configuration applies base + overlay */
+static int firmware_fdt_test_load(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	void *fdt;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_assertok(firmware_fdt_load(&fw));
+
+	ut_asserteq_str("fdt.itb", fw.name);
+	ut_assert(fw.size > 0);
+	ut_assert(fw.fdt_owned);
+
+	fdt = fw.fdt;
+	ut_assertok(fdt_check_header(fdt));
+	/* the size reports the packed devicetree, not a padded buffer */
+	ut_asserteq(fw.size, fdt_totalsize(fdt));
+	/* the base property is present... */
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-base-prop", NULL));
+	/* ...and the overlay was applied on top */
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-overlay-prop", NULL));
+
+	firmware_fdt_free(&fw);
+	ut_assertnull(fw.fdt);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_load, FWFDT_TEST_FLAGS);
+
+/* 'fw_fdt_config' selects another configuration the FIT ships */
+static int firmware_fdt_test_select(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	void *fdt;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-base"));
+	ut_assertok(firmware_fdt_load(&fw));
+
+	fdt = fw.fdt;
+	ut_assert(!fw.fdt_owned);
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-base-prop", NULL));
+	/* the base-only configuration applies no overlay */
+	ut_assertnull(fdt_getprop(fdt, 0, "fw-overlay-prop", NULL));
+
+	firmware_fdt_free(&fw);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_select, FWFDT_TEST_FLAGS);
+
+/* Repeated loads reuse the cache until a runtime selector changes */
+static int firmware_fdt_test_cache(struct unit_test_state *uts)
+{
+	struct firmware_fdt first, second, selected;
+	void *cached_fdt;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_assertok(firmware_fdt_load(&first));
+	cached_fdt = first.fdt;
+	firmware_fdt_free(&first);
+
+	ut_assertok(firmware_fdt_load(&second));
+	ut_asserteq_ptr(cached_fdt, second.fdt);
+	firmware_fdt_free(&second);
+
+	ut_assertok(env_set("fw_fdt_part", "9"));
+	ut_asserteq(-ENODEV, firmware_fdt_load(&selected));
+	ut_assertok(env_set("fw_fdt_part", NULL));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-base"));
+	ut_assertok(firmware_fdt_load(&selected));
+	ut_assertnonnull(fdt_getprop(selected.fdt, 0, "fw-base-prop", NULL));
+	ut_assertnull(fdt_getprop(selected.fdt, 0, "fw-overlay-prop", NULL));
+	firmware_fdt_free(&selected);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_cache, FWFDT_TEST_FLAGS);
+
+/*
+ * Configuration chaining could assemble a combination which was never signed
+ * as one unit. Only one FIT configuration may be selected.
+ */
+static int firmware_fdt_test_config_chain(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-base#conf-overlay"));
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_config_chain, FWFDT_TEST_FLAGS);
+
+/* The shared EFI helper stages the result and owns its returned filename */
+static int firmware_fdt_test_stage(struct unit_test_state *uts)
+{
+	char *name;
+	ulong size;
+	void *buf;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	buf = malloc(CONFIG_FIRMWARE_FDT_MAX_SIZE);
+	ut_assertnonnull(buf);
+	ut_assertok(firmware_fdt_stage(map_to_sysmem(buf), &size, &name));
+	ut_asserteq_str("fdt.itb", name);
+	ut_asserteq(size, fdt_totalsize(buf));
+	ut_assertnonnull(fdt_getprop(buf, 0, "fw-base-prop", NULL));
+	ut_assertnonnull(fdt_getprop(buf, 0, "fw-overlay-prop", NULL));
+	free(name);
+	free(buf);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_stage, FWFDT_TEST_FLAGS);
+
+/* Compatible best-match against the control DT selects conf-sandbox */
+static int firmware_fdt_test_best_match(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	const char *value;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename", "fdt-best.itb"));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_assertok(firmware_fdt_load(&fw));
+	value = fdt_getprop(fw.fdt, 0, "fw-best-prop", NULL);
+	ut_assertnonnull(value);
+	ut_asserteq_str("sandbox", value);
+	firmware_fdt_free(&fw);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_best_match, FWFDT_TEST_FLAGS);
+
+/* A corrupted base fails hash verification and cannot fall back */
+static int firmware_fdt_test_corrupt(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename", "fdt-corrupt.itb"));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_asserteq(-EACCES, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_corrupt, FWFDT_TEST_FLAGS);
+
+/* A corrupted overlay is fatal too; it must never be silently skipped */
+static int firmware_fdt_test_corrupt_overlay(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename",
+					"fdt-corrupt-overlay.itb"));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_asserteq(-EACCES, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_corrupt_overlay, FWFDT_TEST_FLAGS);
+
+/*
+ * A selector naming a configuration the FIT does not ship must be
+ * fatal: -ENOENT strictly means "no source configured", so the inner miss
+ * must not leak out and let the caller fall back (fail closed).
+ */
+static int firmware_fdt_test_bad_config(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-nonexistent"));
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_bad_config, FWFDT_TEST_FLAGS);
+
+/* Pinning a partition that does not exist is a hard error (fail closed) */
+static int firmware_fdt_test_no_part(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_assertok(env_set("fw_fdt_part", "9"));
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_no_part, FWFDT_TEST_FLAGS);
+
+/* A configured source with a missing FIT is fatal, not an absent source */
+static int firmware_fdt_test_no_fit(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename", "missing.itb"));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_asserteq(-EIO, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_no_fit, FWFDT_TEST_FLAGS);
+
+/*
+ * Without a source node, -ENOENT is the only result which lets callers fall
+ * back. This also proves the provider alone does not configure the feature.
+ */
+static int firmware_fdt_test_no_source(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts, false));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_asserteq(-ENOENT, firmware_fdt_load(&fw));
+	/* Source detection precedes address validation in the staging helper */
+	ut_asserteq(-ENOENT, firmware_fdt_stage(0, NULL, NULL));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_no_source, FWFDT_TEST_FLAGS);
+
+/* The configuration is ambiguous if more than one source is enabled */
+static int firmware_fdt_test_multiple_sources(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	struct udevice *dev;
+	ofnode node, root;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	root = oftree_root(oftree_default());
+	ut_assertok(ofnode_add_subnode(root, "fw-fdt-second", &node));
+	ut_assertok(ofnode_write_string(node, "compatible",
+					"u-boot,firmware-fdt-block"));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_multiple_sources, FWFDT_TEST_FLAGS);
+
+/*
+ * A 'firmware-fdt-store' phandle that does not resolve is a broken
+ * configuration and must be fatal, not mistaken for "no source".
+ */
+static int firmware_fdt_test_bad_source(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	fdt32_t bad;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+
+	bad = cpu_to_fdt32(0x7fffffff);
+	ut_assertok(ofnode_write_prop(node, FWFDT_STORE_PROP, &bad,
+				      sizeof(bad), true));
+	ut_assertok(fwfdt_bind_nodes(uts));
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_bad_source, FWFDT_TEST_FLAGS);
+
+/* A FIT using external data is refused: it must be self-contained */
+static int firmware_fdt_test_external(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename", "fdt-ext.itb"));
+
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_external, FWFDT_TEST_FLAGS);
+
+/*
+ * When both partition-type-uuid and partition-name are configured, both
+ * must match: a name matching nothing must not fall back to whichever
+ * same-type (A/B) partition comes first.
+ */
+static int firmware_fdt_test_part_mismatch(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	/* the type UUID matches both A/B partitions; this name matches none */
+	ut_assertok(ofnode_write_string(node, "partition-name", "nomatch"));
+
+	ut_assertok(fwfdt_bind_nodes(uts));
+
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_part_mismatch, FWFDT_TEST_FLAGS);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fa50c8008a5..f2ecc547ac7 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -614,6 +614,188 @@ def setup_rauc_image(ubman):
     boot.cleanup()
     root.cleanup()
 
+def setup_firmware_fdt_image(ubman):
+    """Create mmc11.img for the firmware_fdt tests
+
+    A GPT disk with two firmware partitions (A/B) sharing a firmware type
+    UUID; partition 1 (label 'firmware') holds a FAT filesystem with the
+    FITs fdt.itb, fdt-best.itb, fdt-ext.itb, fdt-corrupt.itb and
+    fdt-corrupt-overlay.itb. The main FIT carries a base DTB and an overlay,
+    with two configurations: the default applies the overlay, 'conf-base'
+    does not.
+    """
+    Partition = collections.namedtuple('part', 'start,size,name')
+    parts = {}
+
+    mmc_dev = 11
+    fname = os.path.join(ubman.config.persistent_data_dir,
+                         f'mmc{mmc_dev}.img')
+    fw_type = '384e979b-eb76-435a-a3a6-1a071dbad91d'
+    sect_size = 512
+
+    # Compile a tiny base DTB and an overlay, then wrap them in the FIT
+    src = os.path.join(ubman.config.persistent_data_dir, 'fwfdt')
+    mkdir_cond(src)
+    base_dtb = os.path.join(src, 'base.dtb')
+    match_dtb = os.path.join(src, 'match.dtb')
+    ovl_dtbo = os.path.join(src, 'overlay.dtbo')
+    utils.run_and_log(
+        ubman, f'dtc -O dtb -o {base_dtb}',
+        stdin=b'/dts-v1/; / { compatible = "test,fw-fdt-base"; '
+              b'fw-base-prop = "base"; };')
+    utils.run_and_log(
+        ubman, f'dtc -O dtb -o {ovl_dtbo}',
+        stdin=b'/dts-v1/; /plugin/; &{/} { fw-overlay-prop = "applied"; };')
+    utils.run_and_log(
+        ubman, f'dtc -O dtb -o {match_dtb}',
+        stdin=b'/dts-v1/; / { compatible = "sandbox"; '
+              b'fw-best-prop = "sandbox"; };')
+
+    its = os.path.join(src, 'fdt.its')
+    with open(its, 'w', encoding='ascii') as outf:
+        outf.write(f'''
+/dts-v1/;
+/ {{
+\tdescription = "Firmware-owned OS devicetree";
+\t#address-cells = <1>;
+
+\timages {{
+\t\tfdt-base {{
+\t\t\tdata = /incbin/("{base_dtb}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t\tfdt-overlay {{
+\t\t\tdata = /incbin/("{ovl_dtbo}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t}};
+
+\tconfigurations {{
+\t\tdefault = "conf-overlay";
+\t\tconf-overlay {{
+\t\t\tfdt = "fdt-base", "fdt-overlay";
+\t\t}};
+\t\tconf-base {{
+\t\t\tfdt = "fdt-base";
+\t\t}};
+\t}};
+}};
+''')
+
+    fs_dir = os.path.join(src, 'fs')
+    mkdir_cond(fs_dir)
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    fit = os.path.join(fs_dir, 'fdt.itb')
+    utils.run_and_log(ubman, f'{mkimage} -f {its} {fit}')
+
+    # An external-data variant, which firmware_fdt_load() must refuse
+    utils.run_and_log(
+        ubman, f'{mkimage} -E -f {its} {os.path.join(fs_dir, "fdt-ext.itb")}')
+
+    # A FIT with two distinct compatibles for CONFIG_FIT_BEST_MATCH coverage
+    best_its = os.path.join(src, 'fdt-best.its')
+    with open(best_its, 'w', encoding='ascii') as outf:
+        outf.write(f'''
+/dts-v1/;
+/ {{
+\tdescription = "Firmware-owned compatible selection test";
+\t#address-cells = <1>;
+
+\timages {{
+\t\tfdt-generic {{
+\t\t\tdata = /incbin/("{base_dtb}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t\tfdt-sandbox {{
+\t\t\tdata = /incbin/("{match_dtb}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t}};
+
+\tconfigurations {{
+\t\tdefault = "conf-generic";
+\t\tconf-generic {{
+\t\t\tfdt = "fdt-generic";
+\t\t}};
+\t\tconf-sandbox {{
+\t\t\tfdt = "fdt-sandbox";
+\t\t}};
+\t}};
+}};
+''')
+    utils.run_and_log(
+        ubman,
+        f'{mkimage} -f {best_its} {os.path.join(fs_dir, "fdt-best.itb")}')
+
+    # Corrupt base data without updating its hash: loading must fail closed
+    with open(fit, 'rb') as inf:
+        corrupt_data = bytearray(inf.read())
+    with open(base_dtb, 'rb') as inf:
+        base_data = inf.read()
+    data_offset = corrupt_data.find(base_data)
+    if data_offset < 0:
+        raise ValueError('Cannot locate base DTB in firmware-FDT FIT')
+    corrupt_data[data_offset + len(base_data) - 1] ^= 1
+    with open(os.path.join(fs_dir, 'fdt-corrupt.itb'), 'wb') as outf:
+        outf.write(corrupt_data)
+
+    # A corrupt overlay must be fatal too, never silently skipped
+    with open(fit, 'rb') as inf:
+        corrupt_data = bytearray(inf.read())
+    with open(ovl_dtbo, 'rb') as inf:
+        overlay_data = inf.read()
+    data_offset = corrupt_data.find(overlay_data)
+    if data_offset < 0:
+        raise ValueError('Cannot locate overlay DTBO in firmware-FDT FIT')
+    corrupt_data[data_offset + len(overlay_data) - 1] ^= 1
+    with open(os.path.join(fs_dir, 'fdt-corrupt-overlay.itb'), 'wb') as outf:
+        outf.write(corrupt_data)
+
+    fat_img = fs_helper.mk_fs(ubman.config, 'vfat', 1 << 20, 'fwfdt',
+                              src_dir=fs_dir)
+    with open(fat_img, 'rb') as inf:
+        fat_data = inf.read()
+
+    # GPT with two same-type firmware partitions; the FAT goes in partition 1
+    fat_sects = (len(fat_data) + sect_size - 1) // sect_size
+    utils.run_and_log(ubman, f'qemu-img create {fname} 8M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+    ptr = 40
+    for num, label in ((1, 'firmware'), (2, 'firmware_b')):
+        utils.run_and_log(
+            ubman,
+            f'cgpt add -i {num} -b {ptr} -s {fat_sects} -t {fw_type} '
+            f'-l {label} {fname}')
+        ptr += fat_sects
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    # Splice the FAT image into partition 1
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+    start = parts[1].start * sect_size
+    disk_data = disk_data[:start] + fat_data + disk_data[start + len(fat_data):]
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    return fname
+
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(ubman):
@@ -626,6 +808,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_android_image(ubman)
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
+    setup_firmware_fdt_image(ubman)
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()

-- 
2.55.0

