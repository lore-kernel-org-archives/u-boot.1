Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D913BC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC2280756;
	Fri, 14 Feb 2025 14:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gFLg7WmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF39C80C7E; Fri, 14 Feb 2025 14:46:52 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D78B806FE
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 14:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5de4d3bbc76so3340453a12.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 05:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739540810; x=1740145610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MS8sElT0ol9mirFZUQ7o/4Puh1j/VDoOzOalLIQooB4=;
 b=gFLg7WmJwpyWwgx+BkIuPUUNZPaL71YktWzsJjU2332oZ+fCdRnSGQTAwa07Ix/47J
 VuwZcs0I9rzEr5pTjUv2HGTfJbPCAPOyAz7wZv24zQP7ArTcobDhqzRMctcJWdnGFX91
 Ro97tEWBX3rky7TuXaRoiifQit8kE1NLLq3NkHwXdq8tqF/wU+xybp7XOEMXowFULi6e
 N2xxv+8u/pUPZ7bZT724Xlc824um0eRkGf4TGA2Lxb/XM6TwzpLG8ddEnwOHkcrSsyUp
 Ra6EMf0dG3u/pTooEe20Eq5B4LzLpN+3wATixfoc/n9E8B+jU6aANz19Cld2e+bqUUu7
 6OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739540810; x=1740145610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MS8sElT0ol9mirFZUQ7o/4Puh1j/VDoOzOalLIQooB4=;
 b=aX4qCdMA5F40fv5ppOP3DeqBKJbWwicI/H380yJJ615mHEFWEVpT1+lWW7USBiv6NT
 7zz4DUxqy1USnjCeiQm3/3KwMYpoPgNG9GVKGlAviMg+j+Ke+E/4IhEppfZK4H6MZG1b
 u89qslSPwkIgDPvNwxfvnmFEW1EdrKuqjLWPuqIGx2rftSQU3ga5W0SZzoEFmESwBCGh
 sCaBEgo/3A6yCX11PDu8LkzXMPQkLOLWfPZQzQAHWhecDIkfwGwSXfP0QRtLnmonnmah
 43QFQiLMb0yEEsh3I5mtyvv7Dk0FzuUBnGpzbGc56YZXcqwCWafEoJu8aQrp1Ti2geCC
 ksoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgTdgy3TLArz6LFxbQ9tKaFWwpa1mTo5Is4JISHi1LpWmpULj0n1WUglOys8CoP0CeDq5jwu4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5CraJHbDiQpnYt/3GH8X8N+K/UquYIRl8ZL8ClbXG6m9dOEUg
 a+q9kl9ISrD03uRzSu7nbIcqNpexfohGZiZyAuyDyRMsMeMrmdmi2bmEk8dy3KIgoBeWC1+GfPN
 TzBA=
X-Gm-Gg: ASbGncuzUuSKZmWzpHjxvKc5Wemr7Xjufde4H5ySNnwFzV7l93ZMfjeFDighGmgMX3q
 pyUkYVz2AyR2texA8mP+rTBL7SghZnhQyyIdLXJktE4GbmljEET3j/X1znHh2cad4f1pBqit45U
 zf9l5gPEqv23R1Ks09vlMzlPV7lLM+huaAEhqSF0J16LZ4bpipNR71VtPrARw4yFoc10HSYU0Aw
 Jp6QJXbmxrCHc3euYfcVU36PoTfBibURRTNq4f/nF2b4lU0f+0MSnyEhl6e2r0Zrlrx9ccAVYa2
 snPGpCajqkOSEPM7y/lG3nl/OToHnby2iLe8wNZgsVgHN9kTkkr59nUT9mpmTSIEh86lAQ==
X-Google-Smtp-Source: AGHT+IG70EF0RywbN9HPoLslJHXFMjtzJntI9Pd6uoIvU+G1OKBUOc14maa3p7jgepSB5mQDQFiXzw==
X-Received: by 2002:a17:907:86a4:b0:ab7:d87f:6662 with SMTP id
 a640c23a62f3a-ab7f34a6156mr1076623466b.52.1739540809968; 
 Fri, 14 Feb 2025 05:46:49 -0800 (PST)
Received: from localhost.localdomain (ppp176092155198.access.hol.gr.
 [176.92.155.198]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba53231f74sm349564866b.32.2025.02.14.05.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 05:46:49 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: remove comparisons to string literals from runtime
Date: Fri, 14 Feb 2025 15:46:45 +0200
Message-ID: <20250214134646.173034-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For EFI runtime services, we manage to preserve string literals
by placing the .efi_runtime section just before .data and preserving
it when marking the runtime memory by marking surrounding boottime
code as runtime. This is ok for now but will break if we update any
linker scripts and decouple .text and .runtime sections.

So let's define the strings we used to compare in the appropriate
section for runtime services

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_var_mem.c      | 3 ++-
 lib/efi_loader/efi_variable_tee.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index b265d95dd6ba..31180df9e3a0 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -19,6 +19,7 @@
  */
 static struct efi_var_file __efi_runtime_data *efi_var_buf;
 static struct efi_var_entry __efi_runtime_data *efi_current_var;
+static const u16 __efi_runtime_rodata vtf[] = u"VarToFile";
 
 /**
  * efi_var_mem_compare() - compare GUID and name with a variable
@@ -331,7 +332,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 	if (timep)
 		*timep = var->time;
 
-	if (!u16_strcmp(variable_name, u"VarToFile"))
+	if (!u16_strcmp(variable_name, vtf))
 		return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
 
 	old_size = *data_size;
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 0d090d051dd4..6a1fa39bb6f3 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -41,6 +41,7 @@ static u16 mm_sp_id;
 extern struct efi_var_file __efi_runtime_data *efi_var_buf;
 static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
 static efi_uintn_t max_payload_size;	/* func + data */
+static const u16 __efi_runtime_rodata pk[] = u"PK";
 
 struct mm_connection {
 	struct udevice *tee;
@@ -858,7 +859,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	if (alt_ret != EFI_SUCCESS)
 		goto out;
 
-	if (!u16_strcmp(variable_name, u"PK"))
+	if (!u16_strcmp(variable_name, pk))
 		alt_ret = efi_init_secure_state();
 out:
 	free(comm_buf);
-- 
2.47.2

