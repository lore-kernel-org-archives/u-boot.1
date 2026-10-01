Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1707ACA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:25:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC51140CBA;
	Thu,  1 Oct 2026 21:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ybohepq5ukNs; Thu,  1 Oct 2026 21:24:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E23CB40C00
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889899;
	b=g4mGYm0m5N1cQ/UdLDmoBkj3R43oXhmJ9QiByfnE7TGqCEI9cRvUUBi3cv9892MKcQiY
	 yUgcyvNDDgf4pmt06EoOZ24nl92XXUi2Klp34EMtIbzy/DYvRnnx+ar9xmJ1c14Q/HlJY
	 FO0/t7Zk2vAZAexuTOkLOVUDWMhBnGrSsx7rA6/sCRU0zYqyaOMeoii2VYmSpj0CP06NZ
	 DTmFNop+faUYchHKmNNfcw++Xbfu4pJKVoUlEdNbd8swUEtzBs6FrVAn/VKyweU3X0gmf
	 wSlmKXNkMtTsealrJFBhRlu0BGZuLjHeuJyuVxr1xvsq75e1HMXXkZIoutJQIAqdizQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8E/K+jzZ+8aL7IdSB+JiWOS9RKT+/+u4wJvFpOzs/H0=;
	b=ZuH551SMr7NEYOSZk+So3E2QA+0NdKDG2GVVChJ+1AgI7Y/MT22xt5byxvXxLKYSrlyy
	 zFlkLre0W8OHUTFeT1UqcFUyQJFZ2uc3n5Mbl2au3W51e3KhHtBNm+hQR4S71PIdqj2uX
	 sscOgKHhYPGZUuIOmGTVVkGvc0d/WP2hfV/Nr+jXd1UtdDpCX1zROgl8FQo/j1uxKtyWU
	 EbUYBkT72IyjFiiaYUPV2p0nfzmGdJUCr0QW0RLnfuzU4AziEgx+9f7D0SJdghyIrNHA2
	 PaQtS0PaqR0MfL85kbFNyb4iYF/DGBIkzdoRU2fFsrUV4I79etyE/ybMfqwtplgUfkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889899;
	bh=8E/K+jzZ+8aL7IdSB+JiWOS9RKT+/+u4wJvFpOzs/H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AK8htcOflHtgJyriak8f7YTPYDV2zhjifb8rdWUfjYJGuGpk389aU4fMrI7+CbFai
	 mHyFmM6dEyvhcZwo8IlN88yK0qNdoiTSiT7S56Xs9dOAzaVBTMSTAGpRGYoIh84qgh
	 ckOpAszRNRE8tS/RSmZ1mxTZ2mtB1J2NeNv63SH3QBBCLCohCSmqAMOfDTk3Rv9jyE
	 F6IhtbEWlHMJrBIxDUFCoyD1flMt9snwiSKf+E1TK+cKgeWvfcxUmHRoclgs+0WE3b
	 kqJEtZB2z5b+M3/zrm+S8AUR5C5CCj8pGDpOLTSv/rXs9JYID5Vob5eqAskLr3ab6g
	 /lTXURZWBp5ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E23CB40C00;
	Thu,  1 Oct 2026 21:24:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCFF222B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEB2B811D4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAVd9pou3w9N for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0478C810B8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887531;
 b=LKDlu/QIrH7xpRJDXy0ctpLsPfLKUakQ3db/ZvuxyLoNZGRJt89j7fLr5RSePFJ6cSXK
 fMmrhMLhhxj151a6ZJDFf013wHpjD7QtV2KLDsDNGwf0EEe1sDlUaf2RJUp2DHY3gD/x3
 81z0x8mMlhepcWSmiX3qaL5T9IbyA2aRtO3Tikk6S9lFP/vm+FQIMkm72L2yVtszG2m4z
 SgNvBUX/ckcQQYnKuOeMOSyL+IuZlmMee4AaJqUt6RpDs68hkGGmnMINhJX6+7XV041O+
 RdF1D49iRfMDNqcmKRCzothXVsdX522k840fA//EcNjaIPo44hUITzEvDZShgkSAVQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887531;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=8E/K+jzZ+8aL7IdSB+JiWOS9RKT+/+u4wJvFpOzs/H0=;
 b=sPYGhUvse+vszuVwEer1bwEfGzoIWrkUUK7XUlJ+epn/KvJx/SUQnfeCP+yaeDAdKpai
 f58T0IxonW4OBB9URkKte51Z7VndqQ8uH4ve7RV7oe5hGH6XgcfqBGQGT+7RrWf9w6vEl
 uNOa1sEIzTFtR4Hoiqdi9gC8sAWlAZusUEuo5k19/8sTmgP/Q6IGpWjbcomn89pNoTkQ4
 iyYlQayF7Lnzx065SKV03erKjv20XNneIEvLVAM9vn3AJ6VoAq2sjx5P4N8U7A7FUv/G2
 EMA4DTAepI4YHCUJ3vJ1IQt3nr5MpI8zxp6wQVNpSvrO2v8EFhXpWf81e/6f2pHwJYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JiaEUAJE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=lqing2013@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JiaEUAJE
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0478C810B8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:30 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so5045870a91.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887530; x=1791492330;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8E/K+jzZ+8aL7IdSB+JiWOS9RKT+/+u4wJvFpOzs/H0=;
 b=JiaEUAJEEoCVDlMeAyN4F5n+81uPxPmDJHLVsKjpAbDEh3ZwJbNWDx0MoGUZkOv/fZ
 gFwq6yIMUJpM8h1Zi476/QRhew8ljwSw0F/wA2BBb+K6cFfF7BscEDtNM46tlo27Q7Ii
 Pt4bJYYZI/vb9NWyxNf5F9XdYiEz1yk6NI0C87XtjMLtH5anPW7vL8I7/Lws1kzqT0K6
 0EdysPUIA+5xY4wInm5/cbarfjPJp78xT0V8Fb1LXbo4KGEkAZ4PShcO9Y8fNA1Gc09W
 615wUjy2IBefWG6De650UzolTDFsrF7wBMOLrD0Wz/p36BQo4BDIggTIDI8PnN8GEbP3
 CjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887530; x=1791492330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8E/K+jzZ+8aL7IdSB+JiWOS9RKT+/+u4wJvFpOzs/H0=;
 b=Y9cWBleEqrAolJEHXdPSGQDzIh8rZX4JIqPJI/Sm/GgNXnNGiy6yaOxtultIFpzY8H
 848DLF0ZJCzC4swuT+4EiEYP8FZmTGRN6u1phl9WnIGhV6hHcv2iYEScY39ATE2ni7zL
 DQzTjmO7pvntVCIDLwK+yqeIWWc1pzI3k1u9IJYUB/3HrnLO1JSo1Ysjd/RsffjRTIB1
 0hwD7JlBbQJz7eQlxZBymAMGNsxZY4HczBRtQkvEuTAAxpvOimWkqj+N0+rSC641SOKT
 IJzQp3luwDq+gsqfnypONVF+oO/3A5lD2exmra+jYOlRsiodj+OQh9cmaQmtQTzJ+gtj
 aLkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByxiFkIR/ioZs1mbu42tW7SotC4g+vxKCw44D5s113CI2Ic6giEbBJh9L/wJudRzAR1zfS/jBc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJDT1jWOop1XOqNIMJp30GyFMEQpZeqzyV38UWlEuU2Yls0c3+3
 E2pKw9OadbowQPSJ1p5iL0LUTUduAf15iLwRA16TVVYF6pHJ4blFLiL+
X-Gm-Gg: AYBFou36vct1BERdiqnBDEl6zNJBK1pUTDDtTqH2Rh0WlaQdzwrYzDN7ysA1f5yyW74
 CICSheIAI6DtgsbuKiFbbms/ZLq+nKR+Vp/eiZyQZSPWEISF3Il9hxK0vsxkxOJfckUbMHKK1PJ
 YqJRqXNSjUkOCrOqhRU+Ig9tSxXyTdEKS9ZoOfYOPPhets8UCYK1Dk3A2mJzDxruyIZPcBvIG4y
 a07MShNY1CK61KEmqlTQmeP0meKTaW9cSqWQegZTaud+YtgiO75JeGPtxwg14ynKPRm0TmSXktT
 7C3DDplksSin7LyHs2adsWkwDekDSFiilTUkx3B/fOYwUUI00+IkgxmkuvbqWNmJElwBlXy8BFI
 2Zw2OQYjo51uhKXWe/0QalrfdSKalgKr5hnP4coED5057dzR4IRWdn0rdY2a8UpLoSmFXSGeZX/
 OAoHtHIk9HWYCAYG1m9zyvxKVdyP4VuHdykI//HQEuHnuxZnndpqdyzhJHAh7pPGFlcqKixCLXB
 OZbealUuW5t6IZoh/eaHKdmW4cQXbzItosseQ==
X-Received: by 2002:a17:90b:4d83:b0:3a0:7261:d58e with SMTP id
 98e67ed59e1d1-3a6ce6e7eb1mr628939a91.22.1790887529693; 
 Thu, 01 Oct 2026 13:45:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:29 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Qing Li <lqing2013@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 9/9] board: qualcomm: xiaomi-crux: add board support
Date: Fri,  2 Oct 2026 04:44:52 +0800
Message-ID: <e17ece23193bea9c9107d96bba117ec0f8fc45f3.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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

Add the defconfig and default environment for the Xiaomi Mi 9 Pro 5G
(crux, SM8150), based on qcom_defconfig plus the phone settings from
board/qualcomm/qcom-phone.config.

- build the devicetree from arch/arm/dts because CONFIG_OF_UPSTREAM is
  disabled for the board: the crux devicetree is not in dts/upstream
  yet
- disable CONFIG_REQUIRE_SERIAL_CONSOLE: the phone has no externally
  accessible UART and U-Boot would panic before bringing up the USB
  console
- probe UFS and bring up the USB CDC-ACM console during preboot so the
  board is usable without a serial port
- enable the pstore command with the ramoops layout used by the
  downstream kernel (0xB0000000, 4 MiB, console/pmsg 2 MiB each), but
  keep CONFIG_CMD_PSTORE_FDT off because that kernel registers its own
  ramoops device
- enable CONFIG_SUPPORT_RAW_INITRD and CONFIG_OF_LIBFDT_OVERLAY to
  chainload Android recovery images with raw ramdisks and DTBO overlays
- keep the fastboot buffer in normal DRAM: 0x1A000000 is below the crux
  DRAM base and cannot be used for DMA; add fastboot_addr_r to the
  default environment

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 board/qualcomm/xiaomi-crux.env | 50 ++++++++++++++++++++++++++++++++
 configs/xiaomi-crux_defconfig  | 53 ++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 board/qualcomm/xiaomi-crux.env
 create mode 100644 configs/xiaomi-crux_defconfig

diff --git a/board/qualcomm/xiaomi-crux.env b/board/qualcomm/xiaomi-crux.env
new file mode 100644
index 00000000000..de3cf1e4de5
--- /dev/null
+++ b/board/qualcomm/xiaomi-crux.env
@@ -0,0 +1,50 @@
+# Bring-up environment for Xiaomi Mi 9 Pro 5G (crux)
+#
+# The phone has no external UART, so the first job is to bring the USB
+# (CDC-ACM) console up automatically, then drop to the U-Boot shell.
+
+bootdelay=-1
+loglevel=7
+bootretry=-1
+stdin=serial,button-kbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+
+# Probe storage and enable the USB serial gadget console on every boot.
+preboot=log level 6; scsi scan; run serial_gadget
+fastboot_addr_r=0xC0000000
+
+serial_gadget=setenv stdin serial,button-kbd,usbacm; \
+	setenv stdout serial,vidconsole,usbacm; \
+	setenv stderr serial,vidconsole,usbacm; \
+	echo "USB CDC-ACM console enabled"
+
+# Handy shortcuts, mapped to the qcom-phone menu too.
+fastboot=fastboot -l $fastboot_addr_r usb 0
+usb_mass_storage=ums 0 scsi 0
+
+# Keep autoboot disabled; leave the board at the U-Boot shell for bring-up.
+bootcmd=echo "crux U-Boot: starting fastboot mode"; fastboot usb 0
+
+menucmd=bootmenu
+bootmenu_0=Boot first available device=bootefi bootmgr
+bootmenu_1=Enable serial console gadget=run serial_gadget
+bootmenu_2=Enable USB mass storage=echo "Press any key to exit UMS"; ums 0 scsi 0
+bootmenu_3=Enable fastboot mode=run fastboot
+bootmenu_4=Drop to shell=setenv bootretry -1
+bootmenu_5=Reset device=reset
+bootmenu_6=Dump environment=printenv
+bootmenu_7=Board info=bdinfo
+bootmenu_8=UFS device info=scsi info
+bootmenu_9=Reset device=reset
+
+button_cmd_0_name=Volume Down
+button_cmd_0=run menucmd
+
+# Drop the USB CDC-ACM console (its stop() releases the UDC) and
+# start U-Boot's fastboot gadget instead.
+usb_fastboot=setenv stdin serial,button-kbd; \
+	setenv stdout serial,vidconsole; \
+	setenv stderr serial,vidconsole; \
+	echo "ACM stopped, starting fastboot"; \
+	fastboot usb 0
diff --git a/configs/xiaomi-crux_defconfig b/configs/xiaomi-crux_defconfig
new file mode 100644
index 00000000000..ae545e3b957
--- /dev/null
+++ b/configs/xiaomi-crux_defconfig
@@ -0,0 +1,53 @@
+# Configuration for building U-Boot for Xiaomi Mi 9 Pro 5G (crux)
+#
+# Based on qcom_defconfig plus the phone-oriented settings from
+# board/qualcomm/qcom-phone.config, with a crux-specific environment.
+
+#include "qcom_defconfig"
+
+# The crux devicetree is not in dts/upstream yet; build it from
+# arch/arm/dts like other boards whose DT has not been synced.
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_DEFAULT_DEVICE_TREE="sm8150-xiaomi-crux"
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/xiaomi-crux.env"
+
+# --- phone settings (mirrors board/qualcomm/qcom-phone.config) ---
+CONFIG_PANIC_HANG=y
+CONFIG_CMD_PAUSE=y
+CONFIG_BOOT_RETRY=y
+CONFIG_BOOT_RETRY_TIME=1
+CONFIG_BUTTON_REMAP_PHONE_KEYS=y
+CONFIG_RETRY_BOOTCMD=y
+# Crux DRAM starts at 0x80000000; keep DMA/fastboot buffers in normal RAM.
+CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_USB_FUNCTION_ACM=y
+CONFIG_CMD_UMS_ABORT_KEYED=y
+CONFIG_CONSOLE_RECORD=y
+CONFIG_CONSOLE_RECORD_INIT_F=y
+CONFIG_CONSOLE_RECORD_OUT_SIZE=0x6000
+CONFIG_FASTBOOT_CMD_OEM_CONSOLE=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_OEM_RUN=y
+CONFIG_CMD_FASTBOOT_ABORT_KEYED=y
+
+# Phones have no serial port; without this U-Boot panics early
+# ("No serial driver found") and PANIC_HANG hides everything.
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
+
+# Pstore / ramoops (stock crux kernel uses ramoops_memreserve=4M @ 0xB0000000)
+CONFIG_CMD_PSTORE=y
+# The downstream kernel registers ramoops itself via ramoops_memreserve.
+# CONFIG_CMD_PSTORE_FDT is not set
+CONFIG_CMD_PSTORE_MEM_ADDR=0xB0000000
+CONFIG_CMD_PSTORE_MEM_SIZE=0x400000
+CONFIG_CMD_PSTORE_RECORD_SIZE=0x1000
+CONFIG_CMD_PSTORE_CONSOLE_SIZE=0x200000
+CONFIG_CMD_PSTORE_FTRACE_SIZE=0x0
+CONFIG_CMD_PSTORE_PMSG_SIZE=0x200000
+CONFIG_CMD_PSTORE_ECC_SIZE=0x0
+
+# Chainload helpers: raw (gzip) Android ramdisks + DTBO overlays
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_OF_LIBFDT_OVERLAY=y
-- 
2.50.1 (Apple Git-155)

