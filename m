Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947C606A329
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b9wYrsmM;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MUvEPalG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F4FA80F95;
	Wed,  4 Nov 2026 09:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ATgO60pB73oC; Wed,  4 Nov 2026 09:41:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12CBA80F3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785260;
	b=Bvlgns3/kZS4GUGUDM2cnrE7SrGmX09KFfsAtbnktpZNFzPr0NK7nm9dWOtES6t6vp1k
	 tQNckaVWuF0oBY4RrSQVoTQFYGnzXtIKWjH+W7hGchC1rHX/fz3piwDeaFbVX28ESRejw
	 wv/liVhhMupPYM/vr+fvhjqsv4YyuMuu+0bI5bD6jQff7B+1w9adzInOK6uW3bs+9gpF2
	 oOFQke5qiMfkIS0x+5gHBKmDCHA8/A4jhTE/keC+XebrRCScIgTRXkuQRgFco6ZCPTlPH
	 6KE8XseISk0i+OO6l/A96tvkg4rFxxh+0ta937SB1r2r3VHjfGyRjrXO0N+fC9s9OIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zt4vkw56Xn01mHo9ksLKuOien71XiUe5iac4x14fqD0=;
	b=pUR+TYT5qDP8QplS7gwddx1qjGJ75OrVPj/nZNOUec4Sv1y/kBRcHulTObcyb7EbGvQb
	 EE+QA6HR3O5lJPIG/h1Ud+JE1cBLnITcU93Z3abWe26EBPmSQTgnW46NXlP7g4Ll/94dx
	 ofFwWBBlxhH1u60gyEQ9WpOyyxcBBXTfHDUd0NX2Pj9m+4yJccjvqB3LakepHqXmaGN17
	 D2a+FyUS09Zrho0pKb4p0dnG9/oHMdNZYpIVuWRmx9fxns7hMmZ1z6tLqYgaRGQuzg0Zb
	 d68MScPXcbORgAfos+F0ZHmbHzHt9BphtDD9bDrROTMa8EITacovMVIzhhLms4ZtE7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785260;
	bh=zt4vkw56Xn01mHo9ksLKuOien71XiUe5iac4x14fqD0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9wYrsmMcwklkpoNZbjy2pQRuoMjASz11slKItCGECzbnQt1369W7j8L693UkDQJR
	 M78AMJKuRCwIcLjH0tB1jfF7qtoKNwyg9asHqa+lLSa7RAtUPfbfggG/pzbQLrE8A/
	 ZQl+t7E2MfTQjYusW0tk9AMVwKJz00GVT1oseUalPZQoiUkj4e1sb1GWEoeu2Vuz5/
	 ZAGupDHnWcYsUhP/g90aRBNZjKjExe+dJhr+sRUUq5HPuGqw71MtEh82d4JOWVDiX9
	 6QCXWJg7TcfztpTe+unoNmpDaCoipWNLqKLn5R18rvFoO6JGkzL0JqJDqw13r6OdFX
	 02+Oy6GdXlgmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12CBA80F3E;
	Wed,  4 Nov 2026 09:41:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DD23411
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26FC640535
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D6toOMPeqCnf for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:40:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1916340520
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785257;
 b=gZBoCaTwX1bT3TsByN6/SqZvT2+KbKFFXdkAInUqzGLMOXLu4SyGkC4e3nqT2dhCCRIQ
 pI8vhWv+Jg7MB+jfWWt8Z4N7GZ4LxlwZhxQWV1ki3z4LPuXC1xz2OdA5CFcMwVW2b2vJn
 rH1PZqop+PfrBgtXwhw6QjWAM6re0Eeee91wvMLUxkceJziGV/g+KS8eMiEfxr57iujJ4
 Kw7yCDolvNnSdA8nWE1IUOrHiiO5CmakcjQc3aLsFCdI2k/PktQD5JZ51WtgBL2Lwm7My
 GF7Rf+pwJf60tl2zYHatHaJaimvCSo+P1YRGeILgg1aaRQVWz0mQQQws/b6uTRJOaoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785257;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=zt4vkw56Xn01mHo9ksLKuOien71XiUe5iac4x14fqD0=;
 b=ERf6vprUj9DyLbLZwrqdoNBko8IPMe1/+TGYEULulYDCnjYyoaAli523Tz/EozpyWgMd
 pg8m97TTSELLWLSIqI858CAWyaVfIj3Vz3jcyG+OCGGkTphlujx4MspoHaW7FizfQBHot
 WqijblMq+4FGy5HKRDx3iCc1Dz7jiTZaVEWLRClYj+Q2oqqItNtDwC4Nk0lKSD/4Q9+up
 DF20PBYgkjZ48Gm9rA3K8zJTLw+vAy/qj//Y9UQkLx4M9url7/GMldaT+LzfSIj5xumC9
 YhHJCMhsNcgXNVfW4aX4fgRYfnqjBpwTFXzfeHCBA8WIOIaxZs/r5WEgTBbD6pwdX/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MUvEPalG; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MUvEPalG
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1916340520
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:40:56 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so2708095e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785255; x=1794390055;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zt4vkw56Xn01mHo9ksLKuOien71XiUe5iac4x14fqD0=;
 b=MUvEPalGWQqlyLDYqkwaPRuiCLjwGsUuM9KAMHSOfM6KIdVHWef/sJrswiwWv/bXtI
 uVIgeb+DF9oIS+Vq6E6QAHuDNlZh/oWiCxUnC3NQwVsSTfGnPzrOncxUOiw4kpQA0VpN
 /+xtnGsgi+ydxsGLaF22VUAVSjQrPd1FP5QIBcCHL9a2qjTaCIoW7yz2+utu/197B2YS
 7YqVb0ZFipQV8G05WVXcweIQv+zBljzueAUOQRRgQgxM9LDs/37STMWO2s9E+O05H1mY
 oPrS/6UaWk3tgicdMM4VcZdNqrtGljlptEqsz2UEi6mGCgOay4fAXqyD8G09pWcFdgQ6
 dUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785255; x=1794390055;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zt4vkw56Xn01mHo9ksLKuOien71XiUe5iac4x14fqD0=;
 b=Hc1u5jztzL8viEYZW1aDDFlZp+TllL4H2NEQesT4kUK6HLSQ4kNavaEd05XetmhLZO
 TlWE7UyjwHxE3CACiCa9EbPI7GwccEH4Nlu6tqw0JLng3Aqt0DJUJLqhzng820ipI0VY
 qH8I0fRXIUm68wfff/YsqiXvu0Ww8FW9u7+qRXmnkI+/CtgOrYCyhMb4gpzFQwRT91MY
 gCDKR65qLOqJe+nvoJVBOrQaUAKgP/2cJoNbzyNITO/bgMI6EKBWAqA550o22iKCGd0h
 WVFKvCkmTPks/byKgaeH/w9TcCODsZt46K5gNVbB3o/JfyoZsQfPKq0tw+ioq176Kmup
 F9XQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1hbv0R4yA+PHyzbW9TinLMOqUZcyHHIMxgPFLl2vCN0cJt97Ju+AUoVi0NWdERKzPpGSI9Bs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8U4tMx6yLp5b8ej/hOBJ8aIoF7g6TlhYlMAnQ8fWytzJOUCQGc
 PFim05NLIG/KgvHe7/BDr376544+JuxJwo5rdcxCkwykO+Q8uWsGgIoqGURJSV+LYi4=
X-Gm-Gg: AYBFou3cmnVDPyshhk4QcPlFRaIomy/AovBKhcLaH5faKIsNSc/a7FbHWTuoMyDYY2b
 bLGd1As2+vuvpcfBQ9kNQH3TRlcWFqIci91PFvHHQ2H5Yd32jEwr/sd8GKc0Ol28iYE5962E7k2
 AMTifZgYHlmUvjAv67Ro1Vwmp55/vKteugmobfufG5HUfOmcsMGGMzJPzXequmcVfHBRX9jkeeY
 P2VEh3YxS1sYxDyTqh1wFXgR296jVJJRqrpEax5hAiN7d6xd9RhHdyawwjePOwlXA+FnKp2pecK
 muClWApiK6DFQpEJpuBntUnKE5xJJNaYlHtjy7lhQflipUaUFbo2hIhS5fZtOpWMgG7yKBJ81ch
 z8TsmxazM/lw0rVTzVA1KFvV826B084sqV6woMfNSsM9KqsTa9UIwQRQPBdmc8JIfFLJxWWzj8o
 UTP9Nna5p4rqRfmLr6lfx0zEaNsoGJrK3eUOnht+9WZJXbjTzFtTZVIQNDXz7ki9NhaBJ+p82Cs
 J4XcKiNtY7rgLJuyenA93dxsynYHpID/ZhsH/AtqenWaMHhcV2DjSDPv7uK8GyvmZy0fOLnE6dt
 45jedA3c2z9QD+XSiib17L06HrXkarhnyrfJ2aQ9oOLIh6gebnHU1oo0bgNHxadRVZyG8CvqDhE
 EQk8PNrRHDajpAdgjRDjAusMLsVxAjp7b1RAfFBVa+5K3iraeFWTte7/JBmCxG0V08xo=
X-Received: by 2002:a05:600c:674a:b0:4a1:fb23:68f0 with SMTP id
 5b1f17b1804b1-4ac14ec788emr357214685e9.3.1793785254627; 
 Wed, 04 Nov 2026 01:40:54 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4527fed5bsm49856945e9.3.2026.11.04.01.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:40:54 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 10:40:21 +0100
Subject: [PATCH v2 1/7] spl: fit: reject failures loading an explicitly
 requested FDT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-spl-fastboot-boot-v2-1-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
To: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
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

A U-Boot image may embed its device tree, but a FIT which explicitly
names an FDT must not boot after that FDT fails to load or verify.
External FDT data is copied to its load address before verification,
so ignoring the error can leave an unverified device tree for U-Boot.

Keep support for U-Boot images without a separate FDT, but reject
failures for an explicitly requested FDT in both firmware and loadables.

Fixes: d879616e9e64 ("spl: fit: simplify logic for FDT loading for non-OS boots")
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/spl/spl_fit.c  | 16 +++++++++++++---
 test/image/spl_load.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f..4e47118c022 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -490,12 +490,17 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 	 */
 	image_info.load_addr = ALIGN(spl_image->load_addr + spl_image->size, 8);
 
+	/* The caller may ignore a missing FDT, so initialize the output. */
+	spl_image->fdt_addr = NULL;
+
 	/* Figure out which device tree the board wants to use */
 	node = spl_fit_get_image_node(ctx, FIT_FDT_PROP, index++);
 	if (node < 0) {
 		size_t size;
 
 		debug("%s: cannot find FDT node\n", __func__);
+		if (fdt_getprop(ctx->fit, ctx->conf_node, FIT_FDT_PROP, NULL))
+			return node;
 
 		/*
 		 * U-Boot did not find a device tree inside the FIT image. Use
@@ -896,6 +901,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	int ret;
 	int index = 0;
 	int firmware_node;
+	bool has_fdt;
 
 	ret = spl_simple_fit_read(&ctx, info, offset, fit);
 	if (ret < 0)
@@ -911,6 +917,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	if (ret < 0)
 		return ret;
 
+	has_fdt = fdt_getprop(ctx.fit, ctx.conf_node, FIT_FDT_PROP, NULL);
+
 	if (IS_ENABLED(CONFIG_SPL_FPGA))
 		spl_fit_load_fpga(&ctx, info, offset);
 
@@ -958,11 +966,11 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 	/*
 	 * Booting a next-stage U-Boot may require us to append the FDT.
-	 * We allow this to fail, as the U-Boot image might embed its FDT.
+	 * A U-Boot image may omit it when the FDT is embedded in the binary.
 	 */
 	if (os_takes_devicetree(spl_image->os)) {
 		ret = spl_fit_append_fdt(spl_image, info, offset, &ctx);
-		if (ret < 0 && spl_image->os != IH_OS_U_BOOT)
+		if (ret < 0 && (has_fdt || spl_image->os != IH_OS_U_BOOT))
 			return ret;
 	}
 
@@ -999,7 +1007,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			debug("Loadable is %s\n", genimg_get_os_name(os_type));
 
 		if (os_takes_devicetree(os_type)) {
-			spl_fit_append_fdt(&image_info, info, offset, &ctx);
+			ret = spl_fit_append_fdt(&image_info, info, offset, &ctx);
+			if (ret < 0 && has_fdt)
+				return ret;
 			spl_image->fdt_addr = image_info.fdt_addr;
 		}
 
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 334ec77b18e..166cf331194 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -367,6 +367,48 @@ SPL_IMG_TEST(spl_test_image, IMX8, 0);
 SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
 
+static int spl_test_fit_missing_fdt(struct unit_test_state *uts)
+{
+	struct spl_image_info expected = {
+		.name = "missing FDT",
+		.size = SPL_TEST_DATA_SIZE,
+	};
+	struct spl_image_info loaded = {};
+	struct spl_load_info load;
+	size_t size, offset;
+	void *image;
+	int node, ret;
+
+	if (!IS_ENABLED(CONFIG_SPL_LOAD_FIT))
+		return -EAGAIN;
+	size = create_image(NULL, FIT_INTERNAL, &expected, &offset);
+	image = calloc(1, size + 128);
+	ut_assertnonnull(image);
+	generate_data(image + offset, expected.size, expected.name);
+	if (create_image(image, FIT_INTERNAL, &expected, NULL) != size) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = fdt_open_into(image, image, size + 128);
+	if (ret)
+		goto out;
+	node = fdt_path_offset(image, "/configurations/config-1");
+	ret = fdt_setprop_string(image, node, FIT_FDT_PROP, "missing");
+	if (ret)
+		goto out;
+	spl_load_init(&load, spl_test_read, image, 1);
+	ret = spl_load_simple_fit(&loaded, &load, 0, image);
+	free(image);
+	ut_assert(ret < 0);
+	return 0;
+out:
+	free(image);
+	ut_assertok(ret);
+	return 0;
+}
+
+SPL_TEST(spl_test_fit_missing_fdt, 0);
+
 /*
  * Build a FIT with external data, overwrite one property of the image node
  * with a hostile value and check that loading fails with the expected error.

-- 
2.56.0

