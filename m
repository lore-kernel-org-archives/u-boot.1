Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8BD606A31B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WgVfl1XV;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CvR8xzVC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6397C606E7;
	Tue,  3 Nov 2026 21:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFzpmpvsCWLk; Tue,  3 Nov 2026 21:26:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F421606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741208;
	b=XQTz+N5YmaHQ13sMmv2hCKcCdHasgop9tchLzzXZwA8ibJext+FpOAuF83lQ8LVfCoez
	 Ta/8Zaixn2jq75aiIWtB4+RcoHWIn9sHIZYzXA96+bmr3SUwxJ+PyPBPcbCONsL7+1OjM
	 6CrrMfyWTDmtKNGg1FFj9gZSOhWQFOrOMs0svUCXMwpROFaP5PM3N1MlVaPQSKbMR9J6R
	 MM8LrYmIlQpM0UQ7SYA4/GrB98JHyCpuDzqxCYz/eKvCe4w6HC0tPZHOJlAwGJrLFw3tA
	 SVhbpVlrtdfUdwn1zSrDP+aPd3v9atsNQerG64x2nfAEGroHuGNNU4eFuR7J/r4An1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
	b=ZFt1+0kc+btEWpMg5oYvaligderBiBSHer5ldasDGWcTAIm9+sgn3/akXA6l0gWyx4Hi
	 h/NybDrd+6KnYNqfDqSo9n6xEvZ7ympmhUTuMA/5E3rRQ8y3Eb43Bvc3/j9GygiX5/BBx
	 5MplnEgLfv34OEt2QaBH+DM6AtEiKdQEcRRCk4Ph08IngZEDhYlcQMVpsejgoQ0m9srAO
	 UWsl3D6a7IL8HYhnO8P2qnKmryp2xf7Cs1IoF6G0X1bL/g1t7RHdk25RZTyVZWHfqP4dr
	 DL/aeRqlNpKC6HQbVDQIUuKjAa2Cp+ZDfkmxrmhUVds15DuvhiTqxy2DVyzh9CaJ50g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741208;
	bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgVfl1XVpPGNCaNV14A6yQmh7Y/fGJJkotw5xFb5PEEkgxvZ7mGcKkDVLTuxtbKtI
	 NdNT1b92UkE83jigmarw4zGsUHqZSSCzPoR5tYKaJsRhTh4MFFITsmMgz+8947ZULQ
	 0faXAGFqUtM8f/upHS2U0DhPDqV2VDRiEDECQyvNf147I5dvmMw515EAq476sJm2Ny
	 WldpxN1mu7ORprE/yychMlWtK0v5/VqMplQg+p2ziZ56j2Ju0047I4YbeSvVTvjbml
	 fZbmSDsoa4BJwypSyze31ylQnj+rL/2/l2CQ3QwtxlVm+Dp19f9QJH86jdwkHVMJnK
	 PTAUWDuNT1rhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F421606E1;
	Tue,  3 Nov 2026 21:26:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95696235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9326340566
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8f1pRRNToqGh for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A51D840515
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741202;
 b=EWiNwmVlSFSFacIawQaIma/MW7eKMDpfpPi2XPpXMLEA/U0a4KdKiGiSveL4e77PryZb
 WMFJ751bChcNbk4OtuYE35zj8Q3DarxIp6EIQb5piYZ0U2NCw0ra6Qv20539P2zikb3VT
 0kTCJmCZQACYaoJDlvCr4SSE+mlz9vGBnvoOa4VmZeC+jAvhX8VvVXu9xSGHF1tTNf4Iz
 iNGV7qAF1xVXgOI3lFO3+TFUPb+50s5UT8DbQZX8449hBuMozSmDaXw4mL2vEdGL8WdeC
 OOXY0rVDujqVqA+vsCOPa7uSLamd9VKfD9UeOM4gdb94+ee3Cn1HoBS7Z5caQK4wjsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741202;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
 b=MwclY81J0bKZ4r350poAYybIyJdG5IQr9GE13nRzGMXD1aoCVSIZRf5t+HqE/VL9IMCM
 5+k7ug9ALud0yLQawNMWo3RQIApkDOUI/tJj6TlOkqHjRjYOumTjYkWr3Re4WUC143hIJ
 h01VeHMSDVsMi7rFhPE8uiPh0CeDW7Ew4/RNuwPp8rir3XtomsmF4RbHvUyrZI/bPydny
 Cx/rBjPtKPf13mPZxqgxW2vdqQtHJZ4OUU2seeBNkT85lUaqtgMYxCrMXncGzrKMfr0u5
 Q6dKHAnFXubodyC8nNwlZQ2U78Fzd0tLkGahMnQsJcE8ihwy67m6ZyUNsFOq6HBMCFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=CvR8xzVC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CvR8xzVC
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A51D840515
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:26:42 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-82109f51565so1637a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741201; x=1794346001;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
 b=CvR8xzVCWj6XmM0w36Mg20nQreH1HxVH7561IOQgoewnjvr4/PLkThE6q5i4G5cU7z
 MWpdDE/uhgtRHx9t+UD3Q+9+wLOZVk0ILBUYuSpOZbP1vLS3nUcKrfvqMzUSuxR0wbUR
 Xfyg7UegjaOuaHdW3720YdbblZCRdMFqcZgrXE8OujlECk61YtMwM+SCZBNaz8ILrLwl
 duE8sVV2o0uR119pPgOBZq2lGP8Or43JHDT9U+h4lxIs+XgXbOrAj/D3H1Xx4OoVE6l8
 iaCfY9YZIkl0aMjUMzCh6S8Rt+YUfodAm1b3Q9wlMBoDGhM+l//TsO4loD7eoZuRUCiI
 JXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741201; x=1794346001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uZWPalTZW+6ecAqniACcrq/BHlCMFkHEslDdWDdY7lU=;
 b=Rzz5D9sozlwzG5l33UcooTv3oyA1xAsD+Dyz9lfrn6sdHMTRxGdnklnP78mEPNVDoQ
 bbttQ9vMwugiwapP4Xw0Tc/O5rAtPClxu2SRRnTv6aZ+meKetymeDZNqu9+/vVN/S12r
 +st3UPww3aBsA3cp4e+7D0AK6NPeaMwsL3CTHwG81HmIlTItnzqkhXsERvVScLnKqus4
 M0t5i3s16mU4lGvKLCjot5npcpTNeMXRaVJrKSrdZPgIertkTecrJl2yzQbrv5rLl18v
 NtT4XBDIvqVU10ey0cEPaTmeH3sMWGnQDF7T7Wds4Q0cjTXSby1dMslrseoa8Hl1Qxf6
 kifA==
X-Gm-Message-State: APuU4Z+Ne9+vl1uOCd+oIS1lH701O1GKOjJiqYgBdKbTq2KEVDikoh0S
 Cf4SfVl4WbItz10EOXmiuBGtShyV+NhimXvSeg9iTjM9cwEd1aD4vjAU1cuZBsf0efY=
X-Gm-Gg: AYBFou0BYrAx9IMMXv+2pkUJ/lown0CGlCrDnP8TfgRlVOMzVA3/ZsA55SqNOVoFjKQ
 lbnDSLDPJS47MZ8tyNISiz4WGD8ijSg0CdOf5zsPXy9qbkI+34sfiTcMdaPgYLWqXry7u+M3l3P
 F/nOpawaJvE/N8kQNM/B7ELFb8do6APfNh63nHAqstnYZVWcsXrdNulmsflSBK8q4driN4K/Qqw
 5hz55WtmCO19NhPYDkX4LjA1vtuGlyUiH85C0XsK4kKOwh8s2O2bsrnzYum3l1ZR5l04hozbT4d
 b5r+ZftXe5idJIOWE8ZxgK0WrJJkd+QqcuExC3Njqc1EdbUnfqRP4K4t5h/3WdCEFCE/fx0t+W0
 T45ozkRxHReeTbA7KcxDv6g/d6KflboL+Wd5SVSrkIPI8nZ7JjksRkqW+APHF/EcLOCFiMk9GWp
 GUg1Us108EPVTS/WTflw279pdUms5/EpqHUAUaPjjlRw74xFNmoGIQesamzaOgLFxHpmRFmjlqr
 htBN6X1GKfPKshl18orRtDPAUBuInMywNlCumUeylM3tZQSsGsdV2D1w9nczEUWUgJULQ2H3sdl
 8/iqzl3s+2O52FdrBFRXg2v5o0H3vEp6
X-Received: by 2002:a05:6830:3e01:b0:830:43b8:72c4 with SMTP id
 46e09a7af769-85d365c5b70mr10581127a34.23.1793741201133; 
 Tue, 03 Nov 2026 13:26:41 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d5c1:c80:22dd:8a48])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3de203dsm289371a34.6.2026.11.03.13.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:26:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 03 Nov 2026 15:26:01 -0600
Subject: [PATCH 2/4] arm: add xferlist_to_boot_arg()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-spl-bloblist-pass-regs-v1-2-bbbbb7e65fdd@baylibre.com>
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
In-Reply-To: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2570; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=icF+Wc/p+Kf2Z2Bn8mW4RGAgkBrKyogzSsHa5yGFJEc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq6lF54l1Bw/FmQpMSMGD0ZOuGB7LqPA2994Zpa
 yzZtdHVwaKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaupReRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AAywH/3RKiRxIl/tUvu0d73ogikuFOb5fO9SlsWC7E6c
 +Zq42p7pw//8Qq1JXGRN3b3gDKGYjFRsIzQfnwh3sBsqavfrPCJhMZ3YcAdGYUMdUD+dSDIFXIW
 tPSsVeXLS+hGRS/7CeBX6mXUl9dY/zaaAxuLDshOkclRbqEk2dOMep6X6rrQ1S6kwGj3lqFheYn
 652NjeTTRdfryno9iwRLK51NHaASICFkDyAAGzfOfkNVykd/raeHoOSINk/4n1JoD+D5A7NKH3x
 CAqMIC1fuAMKdc82Uv+YvNX5kU2woetXfbzzWVNvFRS6sknLA5iqG63BikUQwcKKJtUb3MsgTlx
 Xi9w=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add xferlist_to_boot_arg() to fill in the arguments for the first four
registers of the next stage, so that the bloblist can be passed on with
the register conventions of the Firmware Handoff spec. It is the
counterpart of xferlist_from_boot_arg().

Add a weak default in common/bloblist.c, which returns -ENOSYS, and the
ARM version in arch/arm/lib/xferlist.c, so that other architectures can
add their own later. The ARM version uses the AArch64 or AArch32 register
layout from the spec.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/lib/xferlist.c | 23 +++++++++++++++++++++++
 common/bloblist.c       |  8 ++++++++
 include/bloblist.h      | 11 +++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
index 6425936d354..260e7f14dda 100644
--- a/arch/arm/lib/xferlist.c
+++ b/arch/arm/lib/xferlist.c
@@ -21,3 +21,26 @@ int xferlist_from_boot_arg(ulong *addr)
 
 	return 0;
 }
+
+int xferlist_to_boot_arg(ulong *args)
+{
+	ulong fdt, sig, xlist;
+	int ret;
+
+	ret = bloblist_get_reg_conv(&fdt, &sig, &xlist);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		args[0] = fdt;
+		args[1] = sig;
+		args[2] = 0;
+	} else {
+		args[0] = 0;
+		args[1] = sig;
+		args[2] = fdt;
+	}
+	args[3] = xlist;
+
+	return 0;
+}
diff --git a/common/bloblist.c b/common/bloblist.c
index 4269a49ef99..d649311ed74 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -578,6 +578,14 @@ int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
 	return -ENOENT;
 }
 
+/*
+ * Weak default function for passing the bloblist in the boot args.
+ */
+int __weak xferlist_to_boot_arg(ulong __always_unused *args)
+{
+	return -ENOSYS;
+}
+
 bool bloblist_exists(void)
 {
 	int ret;
diff --git a/include/bloblist.h b/include/bloblist.h
index cdb5764cf55..f143c7cf03c 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -560,4 +560,15 @@ int bloblist_get_reg_conv(ulong *rfdt, ulong *rsig, ulong *xlist);
  */
 int xferlist_from_boot_arg(ulong *addr);
 
+/**
+ * xferlist_to_boot_arg() - Get the boot args for passing on the bloblist
+ *
+ * Fills in the arguments for the first four registers of the next stage
+ * according to the register conventions of the Firmware Handoff spec.
+ *
+ * @args: Returns the four register values, in register order
+ * Return: 0 if OK, -ENOSYS if not supported, else on error
+ */
+int xferlist_to_boot_arg(ulong *args);
+
 #endif /* __BLOBLIST_H */

-- 
2.53.0

