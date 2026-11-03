Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD91606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GXhgC4oQ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mKYGl7rE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3E9B40693;
	Tue,  3 Nov 2026 12:40:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFOae0kLgPbO; Tue,  3 Nov 2026 12:40:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 114C64064F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793709631;
	b=oY6emx6ZMTHtptzu39yo5HAK07s6eaDnQT6KLm8MeBNEF5skLlLSgP99LSxiwh2ryudx
	 hsj87rIuMjgOaC1G6/FwHYBIGq6OqdwLFwvb6eEzHkn63vyax4sUehhlez+3oe6A+D687
	 ehtwPwdD+Miv6t9it5gcnz0Jczrhp+X4tYnYMf3k2oicdQbZBJwUpBip8u4KwlfyUo6pZ
	 zL3ThpQIirMAqo3Tv8V6PuKXw6IUOUuhdVs15GmkNAazfMKbKkkkpftUHTcxP2oO7INEv
	 IbzY14rfPNj3i/Gxr7ptaSqgnXEQxk3/Z7PrbVWfVyehwUFHh4rQUtsGQwhSgqKkBoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WlzAoI9MJsbajNHtTPWdbByaMTKsczy+s1WCTyYYerc=;
	b=BIy/i37FdosoOa5PgYbq09yZ+87IItPT4Zr3XxiySNsv+zzqM6MybBJe+uT1TRfrc6Yq
	 DhXorTYaTmAl5+hTXr84tYMZjW++/7I1acl2hDj84cpyW4XPtX5R2j2V3nf/bL2Juvvhb
	 LM3+joqrDY2anDoFaqvLbMjuaCflW4iC3XRzUSrNj/HXzizPUJu3PnAuxbP+bU/k0+dxA
	 n1mPcsJ1aO4D+JDpYM4LSJoXlIB/wXZsXz2UA7WQvC8PBA75isjmL/yLTaEgjvTmUIY8W
	 F5mArcQoX7UefgVWjvrYG0DzoUEQbIvpJxf/wJJZp3UXLwVFUzCtbla8+yUYfH5Pj0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793709631;
	bh=WlzAoI9MJsbajNHtTPWdbByaMTKsczy+s1WCTyYYerc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GXhgC4oQBRJciBQlMLP53w002Jyjtm6AWUbfuulw8i2G6+uEGVWOfq+ycNgeNm1xg
	 Sw1nyLy7vJUcvMpOQUeJ4HDgDnWUNDRO3Veq4fRUYT6fS9HpEe4lJNlRu/laSlZbG5
	 H7yKLGqW0lzCy4d5eLLYYUM2FSxA3Q5S9+QWm/3k5Egkzpb/k7O/sHgo8+nPSwWV1G
	 AVJGifCpeYv0NsipRvTDtQg0BLHejApZmDCS+LYCFFiEovQyNAM9i+d4N1QbY+ksIK
	 +Vm7kWfJl/+eBv2hiHAYYG3JU+uCLvHSytkrDrv1hvaY2Mf4/LCQ7SpoCfVJAe55ya
	 gEVMWlmYMlYYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 114C64064F;
	Tue,  3 Nov 2026 12:40:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED7072AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB238606E6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sU4IdczD_9oZ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:40:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9C59B60663
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793709628;
 b=qeqbYrQ1yisjoIt1wHsrU0G1KTbQAT2yDGGVnlpOCSWMcbMym+WJ/s9o6ZJiKF5K7wpr
 LLmFNOJL0sbcTUI4H6m3zTP8GmnBauR0dKVOpgBzCdU4C+kzgzmkx4O7VUUEtDivmoFDW
 kunKWIiO3vBTbaCWvAvAmVdMljchsKPz+ljCHNbNZutZyRj8q7BPUS1O9vWY1e+3J6KyC
 j6E1GjDHs3adQvNkwMBxjzn+tcLIjF5cJ6UYU5oqXsJgVdwCo81FmeGoISC96A6O7205m
 vdX6PzYplXjn+4u8Q727Og0QURZDWclnW3+WqlCSsJmfIIgmza/stzvwXO/ZmvXVB8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793709628;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=WlzAoI9MJsbajNHtTPWdbByaMTKsczy+s1WCTyYYerc=;
 b=EyALibuZXF83SA572KN9k15FvKYU9qPjtqXF1YF4aUMgFoxCBY5JTpoNTMMWXmeURNWT
 hmDNZ02hULBiWfe/J/4QNUMHvGJmQjYnNPi/w2SagW6iAKhWS4oosQIDhKrOjcFgffw5t
 tJ9FCA8rrDIh3NheGqh6X4vx+lkYIBzRGkkm09fK/j+aswMVS1MfDRVJkZWPlNtkUOyiZ
 X43Nl2f48ZmcyxYGKoSHPs5ABIgnoVeGajy59R/Z3s8aaHDILzBZ6+WHszsa6oCKPFYyL
 w61I9+IUkq07KP8n2qOirSZpOa9h2gUBo+9IrM5KQwXHRpcrdaJ68HjI+PIy1vlubQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mKYGl7rE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mKYGl7rE
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C59B60663
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:27 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso41516395e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793709625; x=1794314425;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WlzAoI9MJsbajNHtTPWdbByaMTKsczy+s1WCTyYYerc=;
 b=mKYGl7rEfHXlHKnEvuYy4sumxXRmK7uUSVMzgclWyEKY0kKougkdv7kGw4L6Gaq2vA
 8wENKntd+m8fJdNaMlfkc9Huei8u4pNptEtgBs3srLRUdMj1TDZKsI25h/hHU7eAM0Ph
 jeFU8mqK4izm+pOfk48N9rTuTEJzFs3IdB2NwnCwqYsOFSXMkbtcbeQDSbrkdogLPwdj
 99TQqmfmGhxsoAfZGG/vYmeG2aL2b2tlQq9XCUoXef1MR+Q9uDcqmjTBxFo9Y0BKP+Pc
 HdASs2UP/oMa1/bSKx/zuvaCxjFcnqpO2LtDUt6mRiu0ZbTM375OziYtgRMl9UxvCiem
 Qbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709625; x=1794314425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WlzAoI9MJsbajNHtTPWdbByaMTKsczy+s1WCTyYYerc=;
 b=j9mKnzQPQZD/uIOi8TrDtQaTKF3izYMEB0CmxjycFpsSfjIF+98mEjyTXiFsM5Bhnq
 /QpG9nFSWfZhRmFR+iQtMPXZ9B4tsO+1VtiMy1TEw2lzfZi2zQmRH9S83yMSg2PkT3Ap
 YrKyzy52KIwLlxk+ZftSlBM6WLZMlR+GafzMzawPxjgO+KGDV6pNMh+dbfqdcQov8TMu
 NrR21fyGnzZIdJQbHWPMgfd+nOGlNDDQqlvLTUHKgWSvA3xF8Sg62Cg+SOztpN5oUufz
 6hWPFpQh0GcmN/xPYjgjV+43kRQtmCOcGZYrySgqGPsWi3kt4J2oNqR0TnDUkSjir7tQ
 cuQg==
X-Forwarded-Encrypted: i=1;
 AKwUvByB8D819Qxzkhi0yQTzF4pL7+loWy0enAId8hQhA4utAmPRilimBRiePRpAUsLYJQ2RRU0lnMQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8fwkbZtAYmGc2COnKrluoe9nPy744XU0g+ksQC2BYLvZK67EtN
 LTGkrSNh+SX0vzrAmDyHTYv24mEjRfUAsBws3SKsZwa5EA5PNxNesDPWbirmQ+zpUOEKVue+ONB
 EPOhOoUAb6g==
X-Gm-Gg: AYBFou0ilLmk4iXESD33AKsctgMnLtF70Ln/ksOJPmudZn/zSYFAeIg2eLeWGhBC59n
 xgHXRazoRNNNCiFNguBxdNjh9bHeA3/f5pBAh4yhQ8LUBt02Qb7sM3e3Y2Sz9Uv3j4sIawhs5pm
 BGDpSP/R8ov1Ur+CQUBt60N6J6AP624+kMPUIy89BA7TYLns7jNn2fhjtWer8b9Jr2BhMDlphvI
 6btvTztnKk+NLtc28wsp6U5AHCT/eEioIB0hesQRaxad46nMlDO4kHe7QHAuHZzNFOR3/cuXzth
 RUoqoA4ns+JdoaE2x1VA7QqU34waK/shQC8jiQkBRw65/zSCxg5hcJmkCVmHwAWZBv/ZbaSqlci
 t2gmPC56RofBkIJMGnW5pipCfkgy7hJw5llok1ZoGHodyzEHfIPrE0J2W7D0kRkzZsXns8iO1Qx
 z20wFaC9leEMG19uQqzDeQw5Q8aB2vtuzhCZ/BHcjZyvm9ND2NyvEW/5f/IrsksMNZq8y+bZNxF
 a787QVm/12iVagQ1USL2pjx4EnDb2Lb6PBS39FUxfImOdvFTyRP2B6iKpmZzzxSB/FFyt8oyvgy
 aCE6F2F5+YppRErqhz1cMUvHfofyQm5JTpMVCw==
X-Received: by 2002:a05:600c:6216:b0:4a3:5aea:21e5 with SMTP id
 5b1f17b1804b1-4ac1737c533mr285856445e9.9.1793709625323; 
 Tue, 03 Nov 2026 04:40:25 -0800 (PST)
Received: from [192.168.1.123] ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm60369835e9.0.2026.11.03.04.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:40:24 -0800 (PST)
From: Daniel Drake <ddrake@baylibre.com>
Date: Tue, 03 Nov 2026 12:39:22 +0000
Subject: [PATCH 1/4] imx: enter fastboot on USB serial download boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx-usb-boot-fastboot-v1-1-f3a918d55a20@baylibre.com>
References: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
In-Reply-To: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org, Christoph Stoidner <c.stoidner@phytec.de>, 
 upstream@lists.phytec.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Daniel Drake <ddrake@baylibre.com>, Ye Li <ye.li@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Torsten Rupp <torsten.rupp@8tronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@nabladev.com>, u-boot@dh-electronics.com
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Various i.MX-based boards can be booted in a USB-serial download mode,
where the bootrom pauses and waits for an upload from the host.

The documented and expected behaviour is that a separate host computer
then uploads a U-Boot binary which then boots into fastboot mode,
allowing for storage devices to be flashed, usually by the 'uuu' tool.

This is implemented inconsistently over different boards, for example
within the i.MX9 family:

- i.MX93 FRDM: fastboot mode only activates if "bootflow scan" fails to
  boot an OS from an available storage device.
- phyCORE i.MX91/93: fastboot is prepended to the default bootcmd, and
  the board boots normally once the host ends the session.
- Kontron OSM-S i.MX93: bootcmd is replaced with "fastboot 0" and
  bootdelay set to 0, so U-Boot stops at the prompt afterwards.
- Variscite i.MX93 VAR-SOM, Toradex Aquila, SMARC and Verdin i.MX95:
  USB fastboot is enabled, but nothing starts it, so the normal boot
  command runs.

Implement a common i.MX handler for this, offering consistent behaviour:
on a USB boot, prepend "fastboot usb <FASTBOOT_USB_DEV>" to bootcmd from
the last-stage init event.

This handler takes effect on i.MX8, i.MX8M, i.MX8ULP and i.MX9 families
when USB fastboot is enabled, and only when the bootcmd has not been
customised by the user or by the board code.

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
 arch/arm/mach-imx/Makefile   |  6 ++++++
 arch/arm/mach-imx/usb_boot.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 43febc10460..f3d1f7aac62 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -300,6 +300,12 @@ obj-$(CONFIG_ARCH_IMX8) += imx8/
 obj-$(CONFIG_ARCH_IMX9) += imx9/
 obj-$(CONFIG_ARCH_IMXRT) += imxrt/
 
+ifeq ($(SOC),$(filter $(SOC),imx8 imx8m imx8ulp imx9))
+ifneq ($(CONFIG_XPL_BUILD),y)
+obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += usb_boot.o
+endif
+endif
+
 obj-$(CONFIG_SPL_BOOTROM_SUPPORT) += spl_imx_romapi.o
 obj-$(CONFIG_IMX8_ROMAPI) += romapi.o
 
diff --git a/arch/arm/mach-imx/usb_boot.c b/arch/arm/mach-imx/usb_boot.c
new file mode 100644
index 00000000000..93640362fcc
--- /dev/null
+++ b/arch/arm/mach-imx/usb_boot.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 BayLibre SAS
+ */
+
+#include <env.h>
+#include <event.h>
+#include <malloc.h>
+#include <stdio.h>
+#include <vsprintf.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <linux/string.h>
+
+/*
+ * When the boot ROM loaded U-Boot in serial download mode, the host (uuu)
+ * is waiting for fastboot. Run it ahead of the default boot command.
+ */
+static int imx_usb_boot_fastboot(void)
+{
+	enum boot_device dev = get_boot_device();
+	const char *bootcmd;
+	char *buf;
+
+	if (!IS_ENABLED(CONFIG_CMD_FASTBOOT) || dev != USB_BOOT)
+		return 0;
+
+	/* Allow override by the board or by the user */
+	bootcmd = env_get("bootcmd") ?: "";
+	buf = malloc(CONFIG_ENV_SIZE);
+	if (!buf)
+		return 0;
+	if (env_get_default_into("bootcmd", buf, CONFIG_ENV_SIZE) < 0)
+		*buf = '\0';
+	if (!strcmp(bootcmd, buf)) {
+		printf("USB boot detected, entering fastboot\n");
+		snprintf(buf, CONFIG_ENV_SIZE, "fastboot usb %d; %s",
+			 CONFIG_FASTBOOT_USB_DEV, bootcmd);
+		env_set("bootcmd", buf);
+	}
+	free(buf);
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, imx_usb_boot_fastboot);

-- 
2.56.0

