Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36093C624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7A1260BAE;
	Thu,  3 Sep 2026 14:51:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l_dTivWC7PDM; Thu,  3 Sep 2026 14:51:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DCFDA60B73
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788447097;
	b=SlA1/cBxvjOn01tdzoYVdE2H/3awwuTyv4636XqvYWvyKKy+oUxeAECrSxJD/K7tg9LJ
	 V6V3/jQD5ZZRuADKYVCUddL6wK6u+kGPNMMFM+dLX8Mbl2uA04RZZyoYodw/HEPnuKOfL
	 UgBsJhtwBR0Vg0ZRNmf2ppqwEGjsx6UGpGi7JU5rqCMZAC8kLqLglsq2/CpC81Spi7i/L
	 kjDbd7c7T9Mk4L3OCX2Yg2jiOhqnuGxPfG5oVNAoyHxCrNRTfpz5q247clrmfglWsIm/Y
	 h3yNEBbon5lUf+2rwMIDeCQsMuVoveUEe5QqWw2BzEuXHTBwWp+/mMXeTajEWH+xy0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788447097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b/ezmWSVs/cuFGj5CjxMPGz8MM9OVkikkNv9nXeNC0M=;
	b=jX1kHIB3MW2auI3yegiB+UuniDJIRsSZMIEQ/RbtzjtVuG5VYIL6SVFUWrjNuzPM5iyL
	 akR8A3+SrlvO90Bmtr1spNek3YPrLpqs3QuGbQ9r2q965MbQMA8rPBFUEzsGNwTdeKPOT
	 j5d/6SyXasNXNmV1PltueQUGxL/J6LED+RiRa/pD5UGo0NWT5wzAeSkh96RrVkL2Z0uOV
	 YQSqXsPLkf79n+l9RQR45XgRelYgR25PIQpw2Os6wMfsf9xEiY8wsEGXkMfzyqa9G2I0t
	 SOFgPCdEJkleoYO7dF57pTKW7p7bKABOGUdk2rzybATTpiT1RgIAH0uXPEaf/cqnI8A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788447097;
	bh=b/ezmWSVs/cuFGj5CjxMPGz8MM9OVkikkNv9nXeNC0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tmTB2yGIaWb305kxeGSxnL3y8VoMlQwEs2BS3yN6NSDLJ1uIRpNMzCxDqoX0UoicK
	 0Fpe2t6ePalnymE6Of/qEVEeRhSpJrQqYIDWO/qXDP/NnyknRDoLsmjd0Uk5ovOeSP
	 JfCxCfnAFVp7altjQSy6qGAFQYLL7da9sSR65JlZC4Fy7d+224xFtc/sJ5i4xh9xOB
	 WNHHjWBkhtccCNyUGAlVI2Fa2hWWIHzPBvYQgwujwh8n7oSRjOnbPiaqSw67ZMIjSV
	 VuZL951trRujozpGRcIBpU5kBFJWUKCvLbMIXnyA5WZSY4UcQSLHNynOsfY3Sb1Xil
	 gAdA3yY0OyPrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCFDA60B73;
	Thu,  3 Sep 2026 14:51:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06582279
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECA4C40481
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hzOkrWFKs9Mg for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:48:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D2A9240469
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788446922;
 b=G7M3tbyveqoA78+oZHyfRrIeQP0CtH4Io7wqp/MBgYCvp+8xoQQJANJYNM3f82i9NsIS
 tCW5e6WJ8nOjjEZQtOvpR4R1oufgi/IkVJmYPMnE4MUqe3jhPZlCZbK8WGpoeuglnM+6q
 bI3pVZMAcH+IXU2+jaHm9vtZIj5/EDeHtA9T4azFirHvdweuuocO6oSLuMudAisZVXWfB
 4bQj+dfr8WgYtEbB8DEf5gnOuRUg0X5MGzMNLTgCITQMiEkKNiR2P3JiP1VOJrH9jmrbG
 SOQj9QLr4wHA/nCmC2CQI3VViqmmk89zLqX7iVbyCqyAQUy5AmbmTYMi8o7EGl6bXrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446922;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=b/ezmWSVs/cuFGj5CjxMPGz8MM9OVkikkNv9nXeNC0M=;
 b=U3zPDiLHlUhQXbM/7Olac/KiHa5xiEgq/u7BYZu29F2fluixCCX6IrH6d9qcZhPTC0Wg
 7c8CYQwHdkiQasejIdaSrR4t9Esp6+mCpEFng7AFFa1OQlOcgRdZ3HOqhAhEXM7nJre7Y
 rTzfFxinN6N2iFD3lFVTsaJbKf6KiIkUkfyxPK+DeEJX6RR2hsrll0QFGLyAlIAPms/Fq
 8U/j+idWCylNGHQ/B/goYVxeBy0pRHuomOFDvYA0QW674nIPSEsLnTBiGhpUUl1oGRHCY
 gQmQGqYct61c3nEgOBoVc1EAH/m44sp2MLD3olKkRAL6gE1uoNJ2Ke1UBqwLx3jQ/MA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=AIKhNSBC; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=AIKhNSBC
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2A9240469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:41 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A8724293D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788446920;
 bh=b/ezmWSVs/cuFGj5CjxMPGz8MM9OVkikkNv9nXeNC0M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=AIKhNSBCd67YbyoI2srTZrmPWG2/HghP6OqAeX+5sBP9jtYmFDWYfi0LMZqABxXo9
 PdgHWrEaiUhOfxc+n2BZHssnw+OMPC9pqCCQX9jQ9uSE/ULeSm7wfOaA9MWspSDkWO
 qWUo/SV8VSyUAjwpBWSlVZ/w3m2FfnSxvfJC7UedTCIFyJOlHS5P5NoHqR7CiDtX7a
 0bkSFODWqvQHJj/gldO00YCRSwloOWVspDKowjzoF3pEQURpY97+K9WddWYkc2Qxsi
 h+X4tKIgkzBGrqrECyUNrsvsswfIJ7lJl4SvRCjYmoxi93+YglqRoM56EWd+MODrGo
 0lvuPHnf0dT2YlXxD43/Q19MdJjwud80sXsnLv6fy9v0aWBIYEJPsw+SzuBee5WWTM
 6Kq66VXr8m7PAKR95DF7y18eVdO1FLZ2Ks9kv3aGldSu9/mH4WCPANa5F6RJ3pIcUO
 2rxEWfLw38lVA5tqXWFl5RBDnCHsJG9h93J3s8eQNox/qxeW8aBsQJdPaoRWanW3GJ
 9EAhlAFmWS+rKEvS66lH/iT9s/EIR3M74bxG2DTbnCW5Gy8FqAXS1YoQrEnjOa5IkJ
 +mgKE2iHfv+WBJE4MWDWtESiyzntldsAPSfYcqYCKJNhtHlhe8fK7KNAz59fL0bjRm
 G611jsoiMOvZW8CBBupViZHE=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so3694692a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446918; x=1789051718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b/ezmWSVs/cuFGj5CjxMPGz8MM9OVkikkNv9nXeNC0M=;
 b=rTEyrPLWt6yxNNZ78heSEARb/jaJ3IAFZTEhZqvdTB27ql5nbMnmC/zwEjihwjCJJf
 jR5CFUvESuNfcYwpcsKR7T3HDu5ogqygsqJok2IUJU/CxQ6CYoZRZUCRomYuXvOxpk31
 NWVWmb8yvLSNekcrS+xdlBBNMqS6ci3GHEXztwncehGUEKNI0w2yV83fzJ3quOVD+W+v
 mH2HRmOlaiUpYXyt2cOHV/unlzEU9KxctIItHOKuGnV+zhRBluegC7XmvjsY6ez0DWJX
 RRsdRk7TQV5gwYtMt/YBQAiJVR+W9vQ985QS6LaMP3V9mXwitAYhKlSclw8/bnDYO63K
 ACyw==
X-Gm-Message-State: AFuF++nSaSBDWaaaECAsV13eIofiK5xRvCzEIBTUPNJQXzPVikOAigf8
 uFpVDIv5l5RHOCEEj5Mzqi5Gh/j7mcHcAs+NDm0/Q3fkzLZQ53eUliDwaBalEqigS8J3/vNQAkp
 IefOQWVZcItMPZmhzMHa4KahunWuVJ/q2un4OErIrYaODT0Z0VyivZSQYrEPtEe7wtJxqBPh2GE
 OGu00l+jyvDAeiFhnTT4ga
X-Gm-Gg: AYBFou3w8LjrGJjM7ECaJBXqp/6uTjBXNVA+42yJr3l+hdTGc2wV5DNbo9pa2xvS8m9
 n710SHcUwSPVkg79bIPmvpMHL5US8RJDd5ZF2ybi0621m+Tc27UbD80J3pr/csBLs7eGF7N08uU
 pLbHGZqJCNjSWDTIqlFK+pLuMyRk8yP/hATOuP8mSkoviqcRBDasVLNhgDmg3uXU+HG4GshDmPN
 F+d1K3MFTPbwsZ3j5RXruGiJvaKOpOrai05byfjwQwZZmBkB2wnT6wAtBoweawMPtd6JzJJFjwy
 ZzfEHjOUzxyZfsYHnQv+VIYv0h84BxD165oq16lX0a7MDnVpw2OvF1mY64CewmeEwxD+VXLTS8D
 eDTz721/E4X1bWkU5bHUv3Ghgk+yGWctXc3/mwQ0QyvoDB667ACVJVZNh1AdIekPtCy3DXA==
X-Received: by 2002:a17:90b:2ccc:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39b22f1caa1mr262474a91.16.1788446918331; 
 Thu, 03 Sep 2026 07:48:38 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccc:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39b22f1caa1mr262396a91.16.1788446917823; 
 Thu, 03 Sep 2026 07:48:37 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08ce4221sm7051971a91.14.2026.09.03.07.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:48:36 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Denis Mukhin <dmukhin@ford.com>, Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH v2 2/2] test: boot: Check that efi_mgr boot failures are
 reported
Date: Thu,  3 Sep 2026 14:48:14 +0000
Message-ID: <20260903144817.9666-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903144817.9666-1-aristo.chen@canonical.com>
References: <20260811155940.17698-1-aristo.chen@canonical.com>
 <20260903144817.9666-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 14:51:32 +0000
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

Add a bootstd test for the error path of the efi_mgr bootmeth: remove
the BootOrder variable so that the boot manager has nothing to load and
check that booting the bootflow returns -ENOENT rather than the generic
-EFAULT that bootflow_boot() reports when a boot() method returns zero.

Running the real boot manager initialises the EFI subsystem in the
sandbox process, which would leak into later tests, so restart U-Boot
after this test in test_ut.py as is already done for other
session-changing tests.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
Changes in v2:
- Remove BootOrder instead of pointing it at a non-existent load option,
  which relied on efidebug accepting invalid input (Heinrich)
- Check for -ENOENT accordingly and drop the CMD_EFIDEBUG dependency

 test/boot/bootflow.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py |  3 ++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 1cc137c9700..9d71fffba8e 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <efi.h>
 #include <efi_loader.h>
+#include <efi_variable.h>
 #include <env.h>
 #include <expo.h>
 #include <mapmem.h>
@@ -470,6 +471,45 @@ static int bootflow_system(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_system, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_FDT |
 	     UTF_CONSOLE);
+
+/* Check that a failed 'efi_mgr' boot reports the boot manager's error */
+static int bootflow_efi_mgr_err(struct unit_test_state *uts)
+{
+	struct udevice *bootstd, *dev;
+	struct bootflow *bflow;
+	efi_status_t status;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_EFI_BOOTMGR))
+		return -EAGAIN;
+	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_3efi_mgr),
+				"efi_mgr", 0, ofnode_null(), &dev));
+	ut_assertok(device_probe(dev));
+	sandbox_set_fake_efi_mgr_dev(dev, true);
+
+	bootstd_clear_glob();
+	ut_assertok(run_command("bootflow scan -H", 0));
+
+	/* Remove any BootOrder so that the boot manager has nothing to load */
+	ut_asserteq(EFI_SUCCESS, efi_init_obj_list());
+	status = efi_set_variable_int(u"BootOrder", &efi_global_variable_guid,
+				      0, 0, NULL, false);
+	ut_assert(status == EFI_SUCCESS || status == EFI_NOT_FOUND);
+
+	for (ret = bootflow_first_glob(&bflow); !ret;
+	     ret = bootflow_next_glob(&bflow)) {
+		if (!strcmp("efi_mgr", bflow->method->name))
+			break;
+	}
+	ut_assertok(ret);
+
+	/* The boot manager finds no boot option; its error must not be lost */
+	ut_asserteq(-ENOENT, bootflow_boot(bflow));
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_efi_mgr_err, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #endif
 
 /* Check disabling a bootmethod if it requests it */
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fa50c8008a5..787020e3e0c 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -643,7 +643,8 @@ def ut_ubman_fixture(ubman, ut_subtest):
 
     yield ubman
 
-    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_scan_boot"):
+    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_scan_boot",
+                      "bootstd bootflow_efi_mgr_err"):
         ubman.restart_uboot()
 
 
-- 
2.43.0

