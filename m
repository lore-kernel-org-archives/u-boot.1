Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D6ACD13DD
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 16:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8385588D83;
	Sat, 31 Aug 2024 18:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S6PGrbuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED0588835; Sat, 31 Aug 2024 18:48:57 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A781388AAC
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 18:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42bb9d719d4so17605495e9.3
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725122935; x=1725727735; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i24W4kkDll46qQStjY9GdsUEz7ArP6BCj1Z9xp5I/wA=;
 b=S6PGrbuXO29TMknP6JNX9VzAT8gLVHLdRhkE4pbPUaNZoGDZpT/6hTyE6wIHbN8VkA
 gsAAX9weekr/fHv0nrQCKuo7D7yKd813dLlPc3bgrKBzx1u2te0b0VWq8npMPHOAm3Ps
 44LQdWUNiYoW5zb9pmqGrGtpTHx8E9MVFG7KSVuZ7BERS2A4C2ZVmIVxze7Dk51IxQnn
 ZaLs3I63i6EQ3RC4ZWtRfXK2VR36TA5KqU+e372A5IdHFUgGqK1Hgvgpnp4VcCqIjJpe
 yM/gsV4iBLWePSLKZIiEp3HYpFhXqmr03KWGJEUhA6DQJHKhVQrb22GH61QyZruslaSX
 WsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725122935; x=1725727735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i24W4kkDll46qQStjY9GdsUEz7ArP6BCj1Z9xp5I/wA=;
 b=sE2SxH+rNO8dwpAFIky34V5eDNUkgdw2fZ4g9icmuzCnihOXo05UsGLM6nFFK4uaWn
 IgnN7cCMuLQRywLFbnKvIUW7pReFtPVdbA6uCUuQpQSPGFkiyjq3U07jgbzFymY9Z8oC
 vRAiCU1XhuU3eqjaHkbO5q0T0x7HJH04xjHHhS2Dr5asilhWv4/NGVFsVFTS1UV3/xSK
 +yJe4+y0ZJtBrdqBBh49WBShFNvwZe5RGh1L/CFk+RPq3UoAbh7GE53lJisv9ibIz59l
 SJURK25VuFMR4ACdzrcEl3r8MfjfDEibjbTnFp7o7ekxU6cT9QOUojyYrQNKDKwzQ5mX
 xTPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyKhRpqItqmppdWd6+Vox6CFLf2qwWp6CV02uCika4hwufG9jZlYm2czzWIKUS3L9uCMf6S7w=@lists.denx.de
X-Gm-Message-State: AOJu0Yyxf7I8jguwO/lJ5X+FLETPpk7zcZTiYgQaysGuEuqPCNrdIyPF
 YoMCD8gJ9MgeAS739I1pS18utM9blGxOf102bufcK73gKx0GZyEiyQ5SwGpSFRU=
X-Google-Smtp-Source: AGHT+IHq2mXoaL8U0XxKVjrdXb3kxSNqA/zUPyz7lxKfUU7LRqAICVPOuq94kdCxbDYCvFMGvjFzQA==
X-Received: by 2002:a05:600c:3c88:b0:42b:ac94:692c with SMTP id
 5b1f17b1804b1-42bb0205b6amr78691475e9.0.1725122935164; 
 Sat, 31 Aug 2024 09:48:55 -0700 (PDT)
Received: from [172.18.168.79] (ip-185-104-138-67.ptr.icomera.net.
 [185.104.138.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425a77sm116699105e9.45.2024.08.31.09.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2024 09:48:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sat, 31 Aug 2024 17:48:51 +0100
Subject: [PATCH 1/4] board/qualcomm: introduce phone config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240831-qcom-phones-v1-1-08614edd8e35@linaro.org>
References: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
In-Reply-To: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/498lubALH9NHF/IT2J0k0n671CVhRDgQSpw0A6WbdY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm00lzI1iexdsUXcKjltQG/PFTmBVeYTtustnjX
 ERxN0PP0ZSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtNJcwAKCRAFgzErGV9k
 ttslD/0YWQIc0jJxhuip16AIK5CAMkmJTiSGvDWbEl70EJ0unCeG8G9AvhUHawetENzV+j4syR9
 3ouu3e38/XgptDCAeeuVh38jkJrj6TICiWHpakMJQXgnveTr5gfu7jcMR0C3pthrq5Oeb/sCSBS
 +CEIJrLr+68j3nPkDuYyvcSY77jHcoLg9SqQv00hZ7D2FePkNqyg67rL1Rhz9Z4MuXjSgs9xmBs
 A8AcBmyzgCAyML6pBS3hWJIIeFPBZrVf/AZ+UkmxlSrVn98zflstSXRdwijFlzqjm2r1LTGBhLG
 3y3Sq50Kn7FBl0cx3ADsDPWiOuAhePKZTI4QczaiNgCgNf6eqA0yVA8SqR6e6Qic96ehcznlbjD
 RwdJ9ZeS9C8XOEFo1PbGsnEVLyfWbAA0q8CL9Dg0ZTgxaHysnlpJ6KIvOJTcUEcRk0kUrNZftWh
 EUVqxW4EPTyuG0SBcO8g1VCiHt7+Z35N6wxZKb6AEkN89TaySssLtX8Bi9/6lkyAdlPxv1Kb8CK
 5/8WlT2iNxyJI819sFhS0m1x4Z8pycDRuZPeMni1CfW+l7ENadSLMXRSRn73K5Xo6kJxOAq7fg9
 ji0wlsgkFC6MAofhwoMFLAKzIjYxorgFUHv+g0eB3qnp3hA4Y0JA90MXAd5GMNmEsNs6OZ8ExpK
 /HZgKwRAIqxttyQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Phones don't have keyboards! Introduce a phone-specific config fragment
and associated environment file to make U-Boot more useful on these
devices. This allows for navigating via the buttons and enabling
various USB gadget modes or displaying info about U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/qcom-phone.config | 12 ++++++++++
 board/qualcomm/qcom-phone.env    | 49 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
new file mode 100644
index 000000000000..4639e19a3df2
--- /dev/null
+++ b/board/qualcomm/qcom-phone.config
@@ -0,0 +1,12 @@
+# Settings for phones
+CONFIG_USE_DEFAULT_ENV_FILE=y
+CONFIG_DEFAULT_ENV_FILE="board/qualcomm/qcom-phone.env"
+CONFIG_PANIC_HANG=y
+CONFIG_CMD_PAUSE=y
+CONFIG_BOOTSTD=y
+CONFIG_BOOT_RETRY=y
+CONFIG_BOOT_RETRY_TIME=1
+CONFIG_REMAP_PHONE_KEYS=y
+
+# Many phones don't actually define a serial port in their DTS
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
new file mode 100644
index 000000000000..2a0791c888c6
--- /dev/null
+++ b/board/qualcomm/qcom-phone.env
@@ -0,0 +1,49 @@
+bootdelay=0
+bootretry=1
+stdin=serial,button-kbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+
+# Fastboot is keen to use the address from kconfig, but we
+# allocate its buffer at runtime.
+fastboot=fastboot -l $fastboot_addr_r usb 0
+
+# Shortcut to enable USB serial gadget and disable bootretry
+serial_gadget=setenv stdin serial,button-kbd,usbacm; \
+	setenv stdout serial,vidconsole,usbacm; \
+	setenv stderr serial,vidconsole,usbacm; \
+	setenv bootretry -1; \
+	echo Enabled U-Boot console serial gadget
+
+# bootretry will run this command over and over, if we fail once
+# then bail out to the boot menu instead (with a pause to read
+# the error message)
+bootcmd=bootefi bootmgr; pause; run menucmd
+
+# When entering the menu (either from button press or failed boot)
+# remap bootcmd so it will re-open the menu and we won't get stuck
+# at the console with no way to type
+menucmd=setenv bootcmd run menucmd; bootmenu -1
+
+# Pause is used so the output can be read on the display
+bootmenu_0=Boot=bootefi bootmgr; pause
+bootmenu_1=Enable serial console gadget=run serial_gadget
+bootmenu_2=Enable USB mass storage=ums 0 scsi 0
+bootmenu_3=Reset device=reset
+bootmenu_4=Dump clocks=clk dump; pause
+bootmenu_5=Dump environment=printenv; pause
+bootmenu_6=Board info=bdinfo; pause
+bootmenu_7=Dump bootargs=fdt print /chosen bootargs; pause
+bootmenu_8=Enable fastboot mode=run fastboot
+# Disabling bootretry means we'll just drop the shell
+bootmenu_9=Drop to shell=setenv bootretry -1
+
+# Allow holding the power button while U-Boot loads to enter
+# the boot menu
+button_cmd_0_name=pwrkey
+button_cmd_0=run menucmd
+
+# Hold volume down to drop to a shell with the USB serial gadget
+# enabled for debugging
+button_cmd_1_name=Volume down
+button_cmd_1=run serial_gadget

-- 
2.46.0

