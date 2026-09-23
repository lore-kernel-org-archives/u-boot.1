Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A72C9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 17:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1CCB4064E;
	Wed, 23 Sep 2026 17:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9VdCsbiJA50n; Wed, 23 Sep 2026 17:03:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A5288405D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790183027;
	b=g66AzKR/7jpDWx6AFHtrAgArQbTmTOMrAWrsXSYCqRItG3K1ZQB5texVrjHOI3ywXxOE
	 uPYsW3S8t+48O6E09P5jmL2BaX7xNbs/1o748EAN0XJJi0yl6A6qOngN8zpF8Ucp+Wmym
	 7Y4MR0PwdqeGzc9+zZF+zJ2tFSUlGwDRk4LoWB9aWpveLTqDOqnnK1bfU0A92DO8SLPyM
	 HNz918jUKtbIDVUJicLIZv9r8B5/PPX98v8piFIImbqJ7b/JOS/TG6TaK7dIiZDCjfaee
	 uqx3rakpz9VOUSnJLyEBIOC7U+RN806c791v4u4wnjTO5jl+p8AWwqF9EIJ2kHjp+gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790183027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ubQJ/f+07F+aTemzTZrOIG9KyuFCxYIhhMY0aZGgB30=;
	b=JEjiQC81TOzDpaq3E6RdYDOuTfeL763pQRBAJei/t6UK29DymaGyuemiX/TTcXcCQHtN
	 PbWKcCf8PvHzXKxzJn4XCbbeEkmq4KFDHdPyXul5Oxd7G+Ha90PV7YO9WuHBGySHS7jxX
	 bf6cSqeMdUyqYD+szhAXY6fDurw0ZLA6RK8HB7BEo8zYe498eqFdTOpN5/ZYVNwcIgURi
	 DKwwM8jQkxNR+tYR8cyHdrZ8BylGIWTDKgwF39lhYZVjfQkaSvfJ10CPf+BKCx6nlDKAD
	 MEOUrknX9ayE8ztQqsmdoobOuezDbqprJBQ2IMyI4ystYcq3U8OSDyF9KUbrhBAIoSA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790183027;
	bh=ubQJ/f+07F+aTemzTZrOIG9KyuFCxYIhhMY0aZGgB30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C5SZhliYxN7M2fQlh9QKQQqQusXKRQsfM1MxP6hGQTY4Xg9qI4uSgCQwM+fHfK8wX
	 r7zv6v9EZqnh5Vtwa3ceHUHeZRLH9J72hvZCW1aJBvO+EQ6glTUQU/UH28bdzbSi0A
	 9h/1WtW8w2F1xiUS8x6+flaRi/6hlzQZoSXrKye9N/J0Nqwcj6vceWOkYMHxLcdUTJ
	 x5JEyHM9ttJHYg+XoYkZ6fvgTFtMxoodfzGtxMQC/CszpcC73v6TSOMeKlR8dujtFh
	 mNYhCouqczrjKJaUehqZbBfPtZeSMyMudQs7Z5EIDoLI+fjDwAcOq3maT21cIiuXo7
	 niniCpACMabDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5288405D9;
	Wed, 23 Sep 2026 17:03:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F7D413B
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1572C80CD4
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:47:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6r2Jn-gwWDcf for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 15:46:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C86AE80C86
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790178419;
 b=gJBRxn+acDd5QlbJwg3VOsYatuNxlUNP5E/VmUWLppN/r3CGY7I8EHaeJVECvo+eX6yV
 yn3FlXGfgC6LpwMGsl7bkUXLahEjzj+jeYoHYLNiBJNxzNz4rlTPfsl6yjEIerZbrOqrY
 tzWAxWsMHnz7RMv4ppnsC7OddI2aoEa5j71L94Y6DSkPiQrkc8Xjdo2zNkXaaTJ6kZpsW
 WLWcRY2PAlWeAR3fpro3sTIFleUJ2TitxCtkbpE5IXfUrV750JutiC8RsHMFKcZVL7Y9g
 XSC4JMxF7K3roIR06VEF904s5rUMqTvLeBH5E+JwuN6Nlwpuik4MhAFiYbJ6k74wgtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790178419;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=ubQJ/f+07F+aTemzTZrOIG9KyuFCxYIhhMY0aZGgB30=;
 b=HHjaWbvPQZ5HOwvQKKwD6JbLwKuSypAG89Q9ZmWmtCKDOuGDQIbIUFCFbsZh0wXjCeRs
 IDJw14065ID7PYsb8UiFwx5jcfzRNMXuWQR/l2JYBoTMnbgWuknOzFizklo0Nv12wOvgA
 iclheik7vuaM4QpIzR3510EcM+CYf45eGyon8rqWNPx616AEiqLhLFDER1BDN7mDuCwfP
 vNthKbZRXKMHqTh2CHBeJ99lkjFDX2ryw6yLXpavGMJeLmbfpuSJ8eBzUAOgiefQfuLM8
 XKZ1TGXbqJ8sr55LCl4aOlLcccBHFpnRrmyyipgVLMG+7tacjmolrgHmTD66/4FDOaA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=TDNVNmv1; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=TDNVNmv1
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C86AE80C86
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:58 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AC283F780
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790178416;
 bh=ubQJ/f+07F+aTemzTZrOIG9KyuFCxYIhhMY0aZGgB30=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TDNVNmv1XA6yJ8cD2ESLAjRmjOCN3DFJfhlW8O1k2/b2hI5fNgK7jWUzA35Zjx1FH
 tWoXqrnsWEHF4glbBeZfpOgVqkz/kQhMi/uHJdVrVfF0K1BvI005q1f7k9C+LZBEuJ
 O/lK/URCBaqwQVVU6IbX/SYXdzmpwnAiDuO5+6rahAT/Qg4+aad/DvUmaR8ISdcj0p
 n3l0qsYbz/VLj+hU9AAkCrmF8lLzbuDV85DVjFYRD69wbCiEDAdfXAMEnd3I6wQAHj
 Hcp3nb5IQucU+D8r/zvQIxo/HmM6oSeOlQjpwdjQ9Xx+OQTx59P+F5El1UvPmQGc8f
 OlYTA3QvNx4nNMVhH1JGkugPiPNuoontmaWzXRhwxJ+ziabGa4ukliQTVsqBZcvNHU
 uPrVasMlLwC5ztfYqYn6ALRzqqEW072q9iQkJ/UaNO0jsIYwaUZQIDQoWOP2OPk5jE
 xiLCfRBJ4blGZH19m72FTw7g/1Me7fh2lkxKhDQyCmnjrAUzpe8LeEkUA0p3p4Y4oF
 ZPkFjJCstv03hdlfoZa+Zd1C80qA9/JCQIks3QtMQVqWuVHeF5vgltfQJqFEQB9ncT
 H95GxPl9cfx/wezjil8msUwGv+6Ut+cS3t3bOKkvEoIhdmiHnMPSd+ofjQoXeVFAq9
 ii8RjKqSPFPzn5GDbN5Zzn10=
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-458326d2d9aso1983780fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178415; x=1790783215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ubQJ/f+07F+aTemzTZrOIG9KyuFCxYIhhMY0aZGgB30=;
 b=bmeT+G+fs5K38fYvlIDdORt5xIdOj+DrHuACG0+hit+v6BCOPOtrKftMsLf5sPREpY
 M0pi/MDTyy/0JsrqadXkQ5uJ3HTLEIs1VPpx/MGV8Do0KpLBbPIQ36lATDqwhiuhSAyr
 DuyjBmhmatq8xD4gObU290xhF25RH9l399wFrugW0KMzOQdOi9iSQrb5r97yMWfhqFK3
 DBupw6JdH3p47jiyb2QImKAhTK2J0MKcphE/jPJw3bYgEhtwSOdeY+5O7AGfXgi3ePr7
 owPDmiC3KJuwCfqQxo8EYbCce6HYwTXZdO2HY+AYC76Vj0LcVMTC2wjQVRDKUNVagDGI
 VEmg==
X-Gm-Message-State: AFuF++nG1wQEi3HtQYK4g6qf8HHAkMdR1/VBjzDW+fUaQUGzDyWS4huH
 PrfGe0TljmmjS1trb76CSoFboAKsN4qPVnuXY6k+1xAeMibBX1c0wuczz8Il9oDkuvSgHlZEUpm
 f4q+rE5nUktw6RI5hEneVy+dwN5o3kHR4AQ603sybOLJf+3jDb/+hrqgKeUCMg+lFNBbHpF0HoG
 HK3wKPwikN/YKZ9T5QGA==
X-Gm-Gg: AYBFou0+MPeZoCi3usxbFKwnpP/LkHRWBeEGsUZNw9y+EsyNcwiIgfAObv0FkG4r8zN
 vKMDJpqssJzr7IwJ7WwNAZkt3XmvaTEDEllKsdXXvcgt9UmnpeXdL/PMx0Fpj9cCLnd51Wsg0Yd
 oGQRHBuNQdBP6lyJDjyKeHCEVyNCjTZ2Ix6sWQwFi7fcpgwxV5BM3jUc77p/fnTIyDKeTEX/LqC
 IIKpb54IIWpc8RvXkt5z7bzDyz8zIqCqFfrbVBfAoOtDPiCTFJ/WEhT5nmLfuX5KKlBVfY8rshl
 gTS1UKmqSBqO8mrrF6LQEsV6DKMN57eSSqz/XpUwZISQavR7x+vb9reyggoZgQgRPSOBH8udQvO
 iUxYFtsAxb1Ja66ECYI/M32fj6OqpIffrMvnHY34dm8fdzLOBGdD+GlXIZc6K+gh5WnWnBBgZeD
 jqlw==
X-Received: by 2002:a05:6870:e9a5:b0:475:e2e9:4f59 with SMTP id
 586e51a60fabf-4908b9505f0mr2857316fac.39.1790178414990; 
 Wed, 23 Sep 2026 08:46:54 -0700 (PDT)
X-Received: by 2002:a05:6870:e9a5:b0:475:e2e9:4f59 with SMTP id
 586e51a60fabf-4908b9505f0mr2857289fac.39.1790178414593; 
 Wed, 23 Sep 2026 08:46:54 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4908e665df5sm2103963fac.10.2026.09.23.08.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:46:54 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anton Ivanov <anton@binarly.io>
Subject: [PATCH v1 2/3] boot: fit: use constants for FIT property names
Date: Wed, 23 Sep 2026 15:45:12 +0000
Message-ID: <20260923154610.339153-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923154610.339153-1-aristo.chen@canonical.com>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 17:03:42 +0000
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

Commit 634dcda25924 ("boot/fit: use constants for property strings")
switched boot/common_fit.c and boot/image-fit.c to the property name
constants in include/image.h, but a few literals are left in boot/:

- fdt_offset() in boot_fit.c reads "data-offset" and "data-size" from
  the FDT image node; use FIT_DATA_OFFSET_PROP and FIT_DATA_SIZE_PROP.
- boot_get_fpga() reads the "compatible" property of the FPGA image
  node. Commit 3059eb0c27dd ("boot/fit: declare (and use) new constant
  for conf's compatible prop") added FIT_COMPAT_PROP and noted that FPGA
  image nodes carry the same property; use it there too.
- fit_image_load_storage() looks up the dm-verity subnode by a literal
  name; use FIT_VERITY_NODENAME like the rest of the dm-verity code.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/boot_fit.c    | 4 ++--
 boot/image-board.c | 3 ++-
 boot/image-fit.c   | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/boot/boot_fit.c b/boot/boot_fit.c
index 4dcaf95c6ae..aa867fe823f 100644
--- a/boot/boot_fit.c
+++ b/boot/boot_fit.c
@@ -41,12 +41,12 @@ static int fdt_offset(const void *fit)
 		return -EINVAL;
 	}
 
-	fdt_offset = fdt_getprop_u32(fit, fdt_node, "data-offset");
+	fdt_offset = fdt_getprop_u32(fit, fdt_node, FIT_DATA_OFFSET_PROP);
 
 	if (fdt_offset == FDT_ERROR)
 		return -ENOENT;
 
-	fdt_len = fdt_getprop_u32(fit, fdt_node, "data-size");
+	fdt_len = fdt_getprop_u32(fit, fdt_node, FIT_DATA_SIZE_PROP);
 
 	if (fdt_len < 0)
 		return fdt_len;
diff --git a/boot/image-board.c b/boot/image-board.c
index 67938fdd200..7602f5bfaaa 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -685,7 +685,8 @@ int boot_get_fpga(struct bootm_headers *images)
 		}
 
 		conf_noffset = fit_image_get_node(buf, uname);
-		compatible = fdt_getprop(buf, conf_noffset, "compatible", NULL);
+		compatible = fdt_getprop(buf, conf_noffset, FIT_COMPAT_PROP,
+					 NULL);
 		if (!compatible) {
 			printf("'fpga' image without 'compatible' property\n");
 		} else {
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 60e47db5fb0..e173108033b 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2196,7 +2196,8 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
 
 		if (!fit_image_get_type(fit, noffset, &img_type) &&
 		    img_type == IH_TYPE_FILESYSTEM &&
-		    fdt_subnode_offset(fit, noffset, "dm-verity") >= 0) {
+		    fdt_subnode_offset(fit, noffset,
+				       FIT_VERITY_NODENAME) >= 0) {
 			fit_image_print(fit, noffset, "   ");
 			*datap = 0;
 			*lenp = 0;
-- 
2.43.0

