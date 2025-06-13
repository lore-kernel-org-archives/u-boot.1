Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AE1C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427EB82D21;
	Fri, 13 Jun 2025 19:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MsZkcm1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5ACB82EDA; Fri, 13 Jun 2025 19:23:15 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F3382E5A
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so1555629f8f.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835393; x=1750440193; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xs7xiA0ipFktXUAsKK2mlzZ1QR/S2l8R+ymVYFNhpKI=;
 b=MsZkcm1WeytMncVTGPtcldK1pVHb+TQjNn45YPfTJmZjYTaOOiSgLM4CfSVkXFeiOs
 G2YncHDQyuaULtm//WcRHZCLTJkBI5busZGZtfCShB4GipPH+8vzuicwMqw8RtRN1Zi2
 dn1ytPy0gqtfaWntmZ3/yMQgqlzZIrAkBQRFLDYJYpHjCdZJKJDGo9o6CKyWZ1IKQ9yM
 BI0+qRbiMyCqCInzGTE8xLMN/IOySXTMrYLIHM8h5E4A1PhL8IAOSqndmSW3uUxPl8lY
 3qjgpvPuIgPueK4atmrclk2Bl3e1nB9Pxv/02gPLzUvw4ML6z8T10IBv6B3fS+8dw59k
 +kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835393; x=1750440193;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xs7xiA0ipFktXUAsKK2mlzZ1QR/S2l8R+ymVYFNhpKI=;
 b=ID5puA8X9Rg/nJoKSomJpZdIgTGMqq7gS3Y14fp6VE+JArLtasLLuykU9d87w4ERQm
 mAsjlxWEqQRFg9aSIDrbGVVk5HPIPcMcBwVPIZ2j+9MRDii9EgEW4GCn3Zb0EsvzBNpm
 xHmyQWwyNBL/1rDBnHg3AF7SOlLEawGtJOuHz4r+2Cg4LUKUyGfxCQXA0Jw2Ui2475gd
 vgS5QFXLp0YoOiiiGfsc3oxpIe+jFgWnbJS+gP9UmXIQSMCzQ1sXwCRAql1sGT8to78r
 3CzVjX1IAd5/hTUPlYPN0rQv0R4NVaHCPYiM/ruSEgkiu/p036LCGIO2TVwDv4w2iAhA
 kFBw==
X-Gm-Message-State: AOJu0Yzk3g1Mir9/R50eyQcJmblJKFYt7RhQ4S/yPcYuOk/B33JCdBMq
 C47NZBXECfu5Le/d8DMKQt1ixe4SO/ijIesNMEZ3KUihNUjQy6HV8HNDpk32jRpxPU8=
X-Gm-Gg: ASbGncvmWkbYTZqajW2MCRx7LII7ItykiO9Vqb7G3G5LjpVtZxE4vrydCfV4Ahax3ey
 LrRbO07fsXbDOVKZpq6iGDeilLavYcnwZBN8tQlSS98MfaYZ3YDpbD4xCv6YLWHI5D/PO4+ByZJ
 hAs/oj7miMRCfKecMoANQOuBWc7XllxtKBPTlTy//gZRW3HBzsRRkCLbHKHuEMs1NuZVboa7t35
 vJAWyQblHccC/uinUyYGnmONREs0tZm84NsxSxSx6SjIRdDcYDg0hqbbD72XvelvZ+2eeJ8i+EB
 InI1LwD7etHo1O4QYty6uIFaO3niZHWOGVCc9kxyMMV0IZ6+dJSGNj6bPkKX0VBaN9f+
X-Google-Smtp-Source: AGHT+IFIqp8f5UeshQdjkWqAGPZUvo98Jo1YVnJXYn9vKOmUUKOEaJmKyt0bSMMAfhRCwWSJf4ZMFw==
X-Received: by 2002:a05:6000:290c:b0:3a4:f35b:d016 with SMTP id
 ffacd0b85a97d-3a572367993mr527960f8f.11.1749835393312; 
 Fri, 13 Jun 2025 10:23:13 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:12 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 19:23:06 +0200
Subject: [PATCH v4 2/8] binman: support building binman dtb when
 OF_UPSTREAM is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-2-7ea1c68779fa@linaro.org>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=zpH4J/5un2orgNb3aWeipGM6L8Q2h9Oh8TvyEo7hNVI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF56VLWySM8prO88uXyeTtn8P2jhbcjuXkOOQ
 dz77AZzOhOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeegAKCRAFgzErGV9k
 tmY3D/9eTEL+kOteX+/C6icPv2/YGZDsdfu1ogC9Hh2kBm8qUfocpaafOAevqUNSaTwChTZow6b
 MXoTxXI5bS6igDobESKWAW8F7iuRM/i5M18pOrr8shhX5IkfSU31FyZnAOJAonuHHhHb6e4gwDz
 k7kbEGmUIY61MlC9If+4XskiHce530znajEhUYvhuuIa07H39ZyzvImipKyMNeCoO3jOlZn4jFc
 3npPZ2SxYO6rbv9QNM9J8IAvp2Ttrjj5Tk5CXqdZwVvs13H4aSY2WDJguvr+Xw/Prxrrd+VUFIk
 6LGTF9VeFnhSUke/yBBVm/ddc9l6aXD+CAzrgqJwD8pnspVMJb+9EeDELfPYpQSVXf4DVHKmRFv
 L6lsW5CdYYVQvCXEIzueU5lZTH0lw0DlvlWWAq1ZFVFPfwd8S9qsNTc34yqMLjG0kqq1HREvG9D
 eRmpImDhi38rwtWZI/MAbwf0eg9Webz/cXvmpfACzsBWsb0dQwOfbly5HpP+wFk1RLb8XIQVMcm
 MtLJZHoT9qwpewE9o/AWxbnYdq3eRjLVRcoeyJSw/EmsxiEA48hhrYAwrkIsISjC20rzC2ytqjo
 6SM4ZErmXfvEH4uT2CHmK3/uf05yHSqzSXZLMl50RwTrs9QC4eaD/mkhz+Uh+22GvyN5aawBEI9
 aElWH+FJhp/E6IA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Since binman DTB files are not upstream they are kept in the U-Boot dts
dirs, this means they will not be built when building with OF_UPSTREAM
enabled. Resolve this by adding a rule to build the binman DTB if both
conditions are met.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 dts/Makefile | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/dts/Makefile b/dts/Makefile
index 86bf8dc215603c3c02930e9c642d7dc06ce715fc..c20d0fb7cca9d117030a882be783a8e855e10749 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -25,8 +25,15 @@ local_dtbos := local-dtbos
 else
 local_dtbos :=
 endif
 
+binman_dtb := $(subst ",,$(CONFIG_BINMAN_DTB))
+ifneq ($(binman_dtb),)
+binman_dtb_target := binman-dtb
+else
+binman_dtb_target :=
+endif
+
 ifneq ($(EXT_DTB),)
 DTB := $(EXT_DTB)
 else
 DTB := $(dt_dir)/$(DEVICE_TREE).dtb
@@ -45,9 +52,9 @@ $(obj)/dt.dtb: $(DTB) FORCE
 endif
 
 targets += dt.dtb
 
-$(DTB): arch-dtbs $(local_dtbos)
+$(DTB): arch-dtbs $(local_dtbos) $(binman_dtb_target)
 	$(Q)test -e $@ || (						\
 	echo >&2;							\
 	echo >&2 "Device Tree Source ($@) is not correctly specified.";	\
 	echo >&2 "Please define 'CONFIG_DEFAULT_DEVICE_TREE'";		\
@@ -64,8 +71,18 @@ PHONY += local-dtbos
 local-dtbos:
 	$(Q)$(MAKE) $(build)=arch/$(ARCH)/dts dtbos
 endif
 
+# If CONFIG_BINMAN_DTB is set and CONFIG_OF_UPSTREAM is set then
+# ensure we build the binman DTB as well
+ifneq ($(binman_dtb),)
+ifeq ($(CONFIG_OF_UPSTREAM),y)
+PHONY += binman-dtb
+binman-dtb:
+	$(MAKE) $(build)=arch/$(ARCH)/dts $(binman_dtb)
+endif
+endif
+
 ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
 # support "out-of-tree" build for dtb-spl
 $(obj)/dt-spl.dtb.o: $(obj)/dt-spl.dtb.S FORCE

-- 
2.49.0

