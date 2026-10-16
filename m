Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1E4CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5381881447;
	Fri, 16 Oct 2026 08:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQVm86LxeETG; Fri, 16 Oct 2026 08:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B00C81426
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792139844;
	b=FQtFr7hKdEjF6HbrWMMNRaq8/tH7H4sYMvJsiaJ+iJGLHxahjsfl3I482uwBsn4xHBec
	 OJUUKizMxz9rhVziRhyYFIn5SUPMY4gpjIL7X1tYFrVyML/D/aGQiWgpDvhcWGQvXsBH8
	 kwhUuJVlbwjoFODbbEMPHq5MiVRBoyQNUCKtmowCDzO6oKvWejHviETMi6NUlI5yjMAO3
	 TiLpW95DrRZiJtC6Wowik5JkAwBimaFgg4Ug3zRM80KtUwVVYvBeHEClPU1MhLUkiZDtP
	 cgllAWYViLj1wrlfcGgqUHyn4WHU0aFh/JTcLrSXPTSnPw7v2a6bNTgN2uq+3q7Xdcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792139844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4T+iRBybbt346xjDOYySIxFPAr9ByPAe3K3wcG1XlMk=;
	b=RbCLiHcMHqDfoaLp1aMwpkv3J+2+m5MtGSwv6jllLoSaMEZDIfHjB6gOi1/16XdAEVlY
	 Dlh9gB4M3b13XixW3iDb1kPzBkb2v37C2c6Hlr5UFzG/A52i0asv2lDFDkw7PCsm/OGEr
	 f5ofBnXZb4b8hbEtqhznVUkPKQVeC3oTKaMSF9o/yfEx1SNe/yZrVp30HMsnpIhxvH+1Z
	 SWRlMU8CYsVfxL+RAGcgIo4p0neokpujXt4HpclZYY5h9sZvnZwZVLFDcTVIOA/NQq31z
	 HTKeq98Q5vKKWhj+97mc76Ky4QXstzAByS2LzT2+34zdvWSjBJ42vgyk4zXEpFMYoPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792139844;
	bh=4T+iRBybbt346xjDOYySIxFPAr9ByPAe3K3wcG1XlMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ywn5Au2CmDEZRupUp7Ee72aYfA7gdM7OX43jgGN9D61Gp5mqKAydYNdRVpEbNdQrs
	 /UKfpCVuNoErKVtA8+5UpfdeBYxG177qSfDDwbNF7x1J87Tp037cBoe5myEc3D7y8C
	 hnM8/QuMYwDNCeQNrJKsfHew5xrfZUworLpdEi+KOv+oxwaZSB0vJKXOd6CrJCvsY8
	 A6ZOyd5djhgpmu9hMK7KbDZ1dOdDAv+rBzXiIbzCLdyXDK1ROleczNnvSrxNdDNQ4i
	 OuZMJ7vFzV8A2NzTUgTfxaAMxujSyXwUEoG79ujsyr/4Cf+BPID9PBupHOi7zwZyz5
	 Ygxv2mrrl0KYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B00C81426;
	Fri, 16 Oct 2026 08:37:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CED3263
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A9E260A72
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oj1OPlJTN-vC for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19F2160A73
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792139836;
 b=SxwEXSrwLoFpJgpiWKRH7YVW8YbhE9fD/eRzU4k5ngEm5uoRxUQaOYyrPIhj8+Erk3Vs
 FBw3c5p1G0vRlqlg2xrxb6/34Furn8RBIIbBFpuC3cKAnYEbpZZF5mVTMsQhV5yMM8hBe
 FaKH/07KXyBUyh36ukB6iqGLTTuvNuxxxjwwo5/fjmyL1gTx3LuV9CRTQvrjGBo1AFL+0
 UDEOw/SZUMTWS7f7i/AI26oOkvzB8YG9/GPMjbawMTtOH5OFYk4y5/6DKx94RLrEXImcZ
 jzAtVprJSD8CI4MCMZZgzNfXcktAIyHvcuoE3Y6tQW7e6BLUuGtR9gvWBlv1c8DSPSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792139836;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=4T+iRBybbt346xjDOYySIxFPAr9ByPAe3K3wcG1XlMk=;
 b=XJajjhAtZ7DOIY9Hns2wZZbjjjOlgWt+/Dx419T2WmuU643YHOviIw3JO1IZty1teRf3
 lUnC34iq7eeOPODeYD16ZmWcqtRGfod5vOn1yxI31wRlYMWy3jWPhsc5zUy2gUHrJtCl9
 gNzatRILes2kpMS/umHiIUwv0gCGuN/z/4MCoLmMB33pf336LoMj0bXZdfNAJGwm1z2zu
 7jx6hK8uwWH2ndq/Sq7NqrBdcwg+VXdCwXMJ0dyNcKDSLnWuBJbiiVTxqCQ8NvnNQXh1a
 bU+ruvjN4Jn2GotZmue2o1apHiOare9VFkvQ9SbnlXCkMo0V4GxpXDZs3nvngnOwTWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Gsa2cSMU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gsa2cSMU
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19F2160A73
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:15 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so3898007f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792139834; x=1792744634;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4T+iRBybbt346xjDOYySIxFPAr9ByPAe3K3wcG1XlMk=;
 b=Gsa2cSMUFD5uu4eGOQW0gmvXV4M2hxpgfuRdSfva6KpBnnP3LLb7RXKS/t0NULT1zt
 H3WheDuFGKuhkcWwREGY7lNVNpvTX3roNq4HlDgvc7v/pthIAb0lziHg//cJnvFWak7K
 Jm+SqHrXOO35M0NYOcMO6b5o2fEMWJ5RUzlwROa/1ma3xlDUZv1f6hthBR2ICv3o1X81
 BwjvxU9bG9M/BprNx87Ft1uBLYPoaif2YupfEKpDrUNlu2sLrXQBOYbhF1Takl75tkX3
 codIooyeh0N2ivuX8LepOwL+LyIlQrkW7ZkBiOCZrFMAJGXj+TikhQrx3FIj24ItJH0U
 8Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792139834; x=1792744634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4T+iRBybbt346xjDOYySIxFPAr9ByPAe3K3wcG1XlMk=;
 b=PTUpJZzjlmgDrbDUEowRqC5puIApw+syXiBWVgR+lArSyljtyC/s3ZXN4dzLf4Ojgg
 LcVhVFr5GgEmquCs9rk3MkuBNV04bZwaR1Y8s9hSjd10DbMjD81bo05wKP+8qtgU65NZ
 vdEaB28UxR3RRDup39uTW94PBsD8h/6kQu8Gay4/R3T8Gr3Nhqsl4KgH8tB7pkkf+r9Q
 SxdpUvydmHfek3QQ2dROZ8wTYmDbE6yBvQhtJPpziDQ4QNguNwu0kn30B5xnYJzyVR0H
 oqyxmZDGwSM5bIItoLdJDrNmP2/iUzkJRIEk8Ys4uYdfCCkiDxRBLJU8jD0UfI6OxIvk
 LNng==
X-Gm-Message-State: AFq9FYL8R/1nXzFTSTAmf87ZPglHfj2u2L+mUEseKuD8Amff0CTte1w2
 ztGgd93XABxJIH67OohzzfCtvT9wJXZEKOegpVmZQMusKbURR67NdzO0k5CSgV+Od2s=
X-Gm-Gg: AYBFou23QOG+mIaMSvnFuM5VkQp6ARdipex0gWFgR9OsLBCcUMh7dpFmVI+KZuVHpXP
 geRk8T2ET0QLcwmmIAdTHu8vfOtnBc0ZBzpXZlm2I1vT5Pa4jHl58gyETgvFz2oE0Umx+ygyOeG
 w+RFz16cUiY8sU8OwfmUWqqsBXHAHfm8kR7zAQqJrj8qfBPRg5rhamcu0vJTdppNq6CnlPWCfbC
 MDGA6PKykqbM2/O5zLqcmrbBPb770OUdQ3+Yew2Lqg1gccAUKq/crZ33XzH8vTYPsylS3Ooz/N5
 v3Va6kyAmPtXB07Dv1NMHfnB5k5PMij6pVj5vjaLMXZ16+08kVa9OIk222+aUBnLLnjgpW1wzAD
 OnhVEGUJChtCOi41oLwxurFHhEphNQIiMr2VxnEqaJO0xVvM+iWS7jHNlefV09/59nUCt1VJnZ0
 BIn3jfLdz4rl4kXO4EuSeKxAWYNRtE5WQ0Kq7Tk+3OFRb607FAfT8k+wrU6SvU79x4OuhVwQKy+
 u3AII4VVYiPpK7h0kj6UBkAaRvCgwf2a0qdruGPqggXziyjoanHh9g0Ypv9s8t7FG3ItV3Gi0bN
 ZREZXGhxZyOJLwc=
X-Received: by 2002:a5d:5f03:0:b0:48d:f14a:9177 with SMTP id
 ffacd0b85a97d-48df34c2420mr10670669f8f.56.1792139833606; 
 Fri, 16 Oct 2026 01:37:13 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm3100727f8f.3.2026.10.16.01.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:37:13 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 16 Oct 2026 10:37:02 +0200
Subject: [PATCH 4/5] cmd: fdt: add 'fdt fit' to prepare a devicetree for
 other boot commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ccaione-upstream-fdt-fit-v1-4-f6286ef82364@baylibre.com>
References: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
In-Reply-To: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
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

A board may keep its devicetree and overlays in a FIT while booting
a kernel or EFI application from elsewhere. Boot scripts need a way
to verify and assemble that devicetree without asking bootm to boot
the FIT.

Add fdt fit to prepare the devicetree described by one FIT
configuration and copy it to an address chosen by the script. The
result can then be passed to bootefi, booti or another boot command.

Always check image hashes and enforce any required configuration
signatures, even when verify=no. Reject chained configurations:
signing each configuration separately does not authenticate the
combination.

Only copy the completed result after verification, overlay
application and destination checks succeed. The script remains
responsible for loading the FIT and stopping the boot on failure.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 cmd/Kconfig           |  9 ++++++
 cmd/fdt.c             | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/fdt.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7124b961dc2..c81534810c5 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -577,6 +577,15 @@ config CMD_FDT
 	help
 	  Do FDT related setup before booting into the Operating System.
 
+config CMD_FDT_FIT
+	bool "fdt fit - load the devicetree of a FIT configuration"
+	depends on CMD_FDT && FIT
+	imply OF_LIBFDT_OVERLAY
+	help
+	  Add the 'fdt fit' subcommand, which loads the devicetree of a FIT
+	  configuration, applies the overlays the configuration lists and
+	  copies the result to a given address.
+
 config CMD_EXTENSION
 	bool "Extension board management command"
 	select CMD_FDT
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 7e2abf96103..94b2376d072 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -11,6 +11,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <image.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
@@ -145,6 +146,79 @@ static int fdt_get_header_value(int argc, char *const argv[])
 	return CMD_RET_FAILURE;
 }
 
+/*
+ * fdt fit <addr>[#<conf>] <dest> [<length>]
+ *
+ * Load the devicetree of a FIT configuration, with its overlays applied, and
+ * copy it to <dest>. Images are always verified, so the configuration must
+ * also satisfy any required signature in the control devicetree. Unlike bootm,
+ * image load addresses are ignored and configurations cannot be chained.
+ */
+static int fdt_fit(int argc, char *const argv[])
+{
+	struct bootm_headers images = { .verify = 1 };
+	const char *conf = NULL;
+	ulong addr, dest, data, len;
+	bool owned;
+	void *fdt;
+	int ret;
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	if (!fit_parse_conf(argv[0], image_load_addr, &addr, &conf))
+		addr = hextoul(argv[0], NULL);
+	dest = hextoul(argv[1], NULL);
+
+	/* Only a single configuration authenticates the whole combination */
+	if (conf && strchr(conf, '#')) {
+		puts("Chained configurations are not supported\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (boot_get_fdt_fit(&images, addr, NULL, &conf, IH_ARCH_DEFAULT,
+			     FIT_LOAD_PREPARE, &data, &len, &owned) < 0)
+		return CMD_RET_FAILURE;
+
+	fdt = map_sysmem(data, len);
+	ret = CMD_RET_FAILURE;
+	if (fdt_check_full(fdt, len)) {
+		puts("Invalid FDT in FIT\n");
+		goto out;
+	}
+
+	len = fdt_totalsize(fdt);
+	if (argc > 2) {
+		ulong newlen = hextoul(argv[2], NULL);
+
+		if (newlen < len) {
+			printf("New length 0x%lX < existing length 0x%lX, aborting.\n",
+			       newlen, len);
+			goto out;
+		}
+		len = newlen;
+	}
+
+	if (CONFIG_IS_ENABLED(LMB) && lmb_read_check(dest, len)) {
+		puts("ERROR: trying to overwrite reserved memory...\n");
+		goto out;
+	}
+
+	ret = fdt_open_into(fdt, map_sysmem(dest, len), len);
+	if (ret) {
+		printf("libfdt fdt_open_into(): %s\n", fdt_strerror(ret));
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+	ret = CMD_RET_SUCCESS;
+
+out:
+	if (owned)
+		free(fdt);
+
+	return ret;
+}
+
 /*
  * Flattened Device Tree command, see the help for parameter definitions.
  */
@@ -281,6 +355,10 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return CMD_RET_SUCCESS;
 	}
 
+	/* Load the devicetree of a FIT configuration */
+	if (IS_ENABLED(CONFIG_CMD_FDT_FIT) && strncmp(argv[1], "fi", 2) == 0)
+		return fdt_fit(argc - 2, argv + 2);
+
 	if (!working_fdt) {
 		puts("No FDT memory address configured. Please configure\n"
 		     "the FDT address via \"fdt addr <address>\" command.\n"
@@ -1124,6 +1202,11 @@ U_BOOT_LONGHELP(fdt,
 #endif
 #ifdef CONFIG_OF_SYSTEM_SETUP
 	"fdt systemsetup                     - Do system-specific set up\n"
+#endif
+#ifdef CONFIG_CMD_FDT_FIT
+	"fdt fit    <addr>[#<conf>] <dest> [<length>] - Load the fdt of a FIT\n"
+	"                                      configuration, apply its overlays and\n"
+	"                                      copy it to <dest>\n"
 #endif
 	"fdt move   <fdt> <newaddr> <length> - Copy the fdt to <addr> and make it active\n"
 	"fdt resize [<extrasize>]            - Resize fdt to size + padding to 4k addr + some optional <extrasize> if needed\n"
diff --git a/doc/usage/cmd/fdt.rst b/doc/usage/cmd/fdt.rst
index 493ed895bc7..88222a9939d 100644
--- a/doc/usage/cmd/fdt.rst
+++ b/doc/usage/cmd/fdt.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     fdt addr [-cq] [addr [len]]
+    fdt fit <addr>[#<conf>] <dest> [<len>]
 
 Description
 -----------
@@ -48,6 +49,46 @@ If the `len` argument is provided, then the device tree is expanded to that
 size. This can be used to make space for more nodes and properties. It is
 assumed that there is enough space in memory for this expansion.
 
+fdt fit
+~~~~~~~
+
+This loads the device tree of a FIT configuration and copies it to `dest`. The
+FIT must already be in memory at `addr`.
+
+The configuration `conf` is selected as for the bootm command. If it is
+omitted, the configuration matching the control FDT is used when
+CONFIG_FIT_BEST_MATCH is enabled, otherwise the default configuration of the
+FIT. The `fdt` property of the configuration lists a base device tree followed
+by any overlays: the base device tree is loaded and the overlays are applied to
+it in order.
+
+Each image is checked against its hashes, whatever the value of the `verify`
+environment variable. With CONFIG_FIT_SIGNATURE, the configuration must also
+satisfy the signature policy of the control FDT, so an unsigned configuration
+is rejected when a key has `required = "conf"`. A configuration signature
+covers the hashes of all the images listed by the configuration, so it
+authenticates the base device tree, the overlays and their order as one unit.
+
+Unlike bootm, the command does not accept further configurations appended to
+`conf` with `#`. Each of them would be verified on its own, so a chain could
+combine device trees in a way which no configuration lists and nobody signed.
+List each valid combination of a base device tree and overlays in its own
+configuration instead.
+
+The command fails if any image cannot be loaded, verified or applied, and
+nothing is written to `dest` in that case. Unlike bootm, the command ignores
+FIT image `load` addresses: only the completed device tree is copied to
+`dest`, after checking that the destination does not overlap reserved memory
+when CONFIG_LMB is enabled. Alignment and decompression of the base device
+tree are still handled as needed.
+
+If the `len` argument is provided, then the device tree is expanded to that
+size, leaving space for later changes. The command fails if `len` is smaller
+than the device tree. Without `len`, the device tree is copied at its own size.
+The working FDT is not changed; use `fdt addr` to select the result.
+
+This subcommand requires CONFIG_CMD_FDT_FIT.
+
 Example
 -------
 
@@ -66,3 +107,37 @@ address and expand it to 0xf000 in size::
     Working FDT set to 10000
     => md 10000 4
     00010000: edfe0dd0 00f00000 78000000 7c270000  ...........x..'|
+
+Load a FIT holding a device tree and its overlays, then copy the device tree of
+the `conf-a` configuration, a base device tree with one overlay, to 2000000 and
+inspect it::
+
+    => load mmc 0#firmware 1000000 fdt.itb
+    1771 bytes read in 1 ms (1.7 MiB/s)
+    => fdt fit 1000000#conf-a 2000000
+    ## Loading fdt (any) from FIT Image at 01000000 ...
+       Using 'conf-a' configuration
+       Verifying Hash Integrity ... OK
+       Trying 'base' fdt subimage
+       ...
+       Verifying Hash Integrity ... sha256+ OK
+    ## Loading fdt (any) from FIT Image at 01000000 ...
+       Trying 'ov-a' fdt subimage
+       ...
+       Verifying Hash Integrity ... sha256+ OK
+    => fdt addr 2000000
+    Working FDT set to 2000000
+    => fdt print /test-node
+    test-node {
+            ov-a-prop = "ov-a-value";
+            base-prop = "base-value";
+            order = "ov-a";
+    };
+
+A boot script can prepare a device tree kept with the firmware in this way and
+pass it to the boot command, stopping if any step fails::
+
+    if load mmc 0#firmware ${loadaddr} fdt.itb &&
+       fdt fit ${loadaddr}#conf-a ${fdt_addr_r}; then
+            bootefi bootmgr ${fdt_addr_r}
+    fi

-- 
2.56.0

