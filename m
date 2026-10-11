Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EF4CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 17:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C10A04069A;
	Sun, 11 Oct 2026 17:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jli_NNTMZyPr; Sun, 11 Oct 2026 17:23:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E921C40698
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791739391;
	b=pjSpGwQ2aultXCd/kFq+BIJv4NiZsRXRzAriAG/UrtzvhOG/sDBhnRju/HMXqpyYqg7u
	 eEAkmmRZgFEgMnUWoyA6gOw3SJs8fpi9JfgaETJEglyxuxZ8QLvvvaeHzAAfuhaS7gT92
	 RAiViKu8dJGiCGGNOjB/L0MWKlqHj4sdXZOBUIrUhxLJOmOL9q8Deme6rwDkcTUH2aL0I
	 a4wNneT3qbHM7TDR2fO2Dnp/6FcQqcv+1lj2PBCMn/gjwDIsbHDXU2OebxgtahUpUtKDR
	 xDRPo2F9XqcwLzUWMLnNxlSkFlX5I+x4b4OqmBvdTqc+uOC+Ryr8VBNPBYvlgJut/3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791739391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Oh5rA/FS2LMH4njDVlA2ZlVgKCFiabpcDnWCnoPip2M=;
	b=tEFncj5IR1E9b7qEWWUCYT3UUlTyshyCqcRxwnsvV/iSizJrYqRN9fATT+Ih7bIcNzge
	 gBiZlw7/quxKxUR7LeederIzB4kpzT0rbRCN6R829cO8Qytid23S6t1ErLKzKIbz0HCwx
	 r7MjO7BZD0clx5gLFYtf7VBjPbtOg6wnf1NA575Wdw6vH9ENL/kPVWpKypIonu30K5bnf
	 /zPDTYw3VlTN16ZyzRJMV1TiFJMUjNpauWt9PA9mrjYMc3jpdAV+LQfi9C/KnT1o+kbd7
	 8FDwcZ7mPgl3wDbSvKrYVWPr0jijj+wGbVBYtmC62eP4os7jAWpr24ZI1DU3UlK0LQQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791739391;
	bh=Oh5rA/FS2LMH4njDVlA2ZlVgKCFiabpcDnWCnoPip2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oLd6nxo3BUxFAGBG4yN3s+eIpYmwaJjig313T9cvFKYGQWSlBipU1fPgeo8hExnLi
	 PojyvrSVZGdHRUN3nwazzUo6yqLxFbxyckcWrc7BgLuvttq6MBWbDqDyZZfXhrVBwa
	 qrW/DrfU5A1jy/GTkmHs2aYLhz4H15YN7MEMq93P+XUecM80DtoyGLDHhHFHoT+Avw
	 1QV8bjVk5EbSjU6IGIeSx1J5BNQr9ylLOkjuCZfl2PUZd8bA4wDYDYqSDng2AjSCg+
	 dIDs+3uBAyppnDkmmAUK5Kjs2sa0wrWEpxZZEa8jJVq2sZQo4/Py3KuwyRf7fMUiWZ
	 5pYONOFxUqEcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E921C40698;
	Sun, 11 Oct 2026 17:23:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C04E194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61ADC605F9
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KpcgW_JlPu6z for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 15:23:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67DBB605CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791732189;
 b=UxRvFN6YzbTW67iMl84ES5Qbc3aF42XZizaaXROYP056ucwAfTM8alD6uQx1K7QQ3zM5
 Xr8eMz+v70OyYJkdvPzs2L2V3OChnW41AZa28bKyLjI2u3nXzds2unYugFi53oeEILkVQ
 ajyJeCRS2HfssEeTjbHHGVMTFdrNQ0mr5uEQf1WE8XT0tI2Wrs8azrAkZMMl+6nz1eNDK
 GrHkzNa1QC1E1jmxxcwb0mkD0nL+xGdF02OmUgaI4MB3S7O58BjahHgqbO/sY+r3l834F
 uMFLLMfHDsNJtW2o/PdLDfnQfC5Ix+oa3UwTkw4Tee1042EhsGn6cvFmGRY8QNG4nlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791732189;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Oh5rA/FS2LMH4njDVlA2ZlVgKCFiabpcDnWCnoPip2M=;
 b=sDZmLrEa9d6gxDgUeLZ97i9g0wTakfirFW84iQ3/4dtntZldUDdmdtSZ6pZQQrJ31L4y
 ySMWj1rXQ9GHe+X5r0H+DKGM4fX1BNDJ1Uyfv2f62Xsb+wHYqWenZ/H6HTlvP6xvQ1RKt
 nXfMyzBbaopFGhtu7lppr4qjBzEk9aPQtoc8cILmjahjSbqprSqmXOU24v7So/oTJyyZ/
 Ig6N23vbfSTwwvAaEctOq0DlOG9pbFogB8YGhiG+Y9Fm08d608lMzvqeHp1k+H1tlAO60
 wXWQP9LsNfzTk8iU1m17EVlEbF4yiPWizd5CR1To409vIEUFp996S/Q20DNxlSnWjNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=kH5cAQ5z; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=kH5cAQ5z
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67DBB605CF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:08 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D66E3F197
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791732186;
 bh=Oh5rA/FS2LMH4njDVlA2ZlVgKCFiabpcDnWCnoPip2M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kH5cAQ5zGuDwUz5BCQuFq8icvx3c/P2sV8bahFV/nxIKg6Z3k4Ql6EVfVbyhqPc9s
 8or+/Dmwo+riPC8gHaWK8B+DBPTbhg423/gCe4eFnLsV0w+OXsRl6OWBdU6Q7jt1fd
 JjKrVs27/LOhB06WYLBa6uh4MCXB/uFL/BRZ8mfFrgNo61k5AkHmSV6GJfP3VaW4mp
 3XIXRyHjqH0UnvFG/VHbPWWZTWG2a5Q0m62JtjMyzEDZ64ibZtWP6hCgKDDioY8tEc
 QoXksYOVWPjXfZELaEWIc0eMHFKwKlLYcfz+hcKZXc4ZtY7PEkCClQnN+uX6W34ZzE
 se2ezZLhfmPRF5s6A3P9E2yExoMaFPEWXDXJZsxrV0tvBCuWqZv2oP02MtPvD3w3SG
 B6huIyvInjH4oGzn88vTRRahZEO1X+PDUrphosuiOpPe3kE+j5KrcjYm0nBux5aDlV
 dtBAobaJ65t+22v2J+ovjHt6gYwChOYKAtg5QzFD3BcJdKbKhoDcH08IgLQdHoJJGu
 5q/fBix9lylDd+qQ4B8j7D5qkqxPEouty5VO4US9Ks2Fnllv50HICPQTV6IY3Qsapn
 K+9q9FaL8BNXwi1bNoaaxfljexuhvZSnMTABKd0iAEg8uoDF5bQZK5GqBPspGZL7wP
 bIk3mYG/24iY6Mn3hys0o7Gc=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e818ca61bfso11444365ad.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791732185; x=1792336985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oh5rA/FS2LMH4njDVlA2ZlVgKCFiabpcDnWCnoPip2M=;
 b=wcT6mgsPbYUSoA4f51lD2fiWVszjPNDAVyP8Cgv1rhqfyWoOb2JpqrFTMG3deEEGTI
 Sv5Hz2hjzN15dEQdUdEJuKIMFFjWS2BDpXgyd5tmb9Hk+zSdz/yRHSIIUJ7ROZOunC1x
 mcnyoQ9tfQv1J6Wc5ibMrX0EO5z40xrGz3qL84wc/x+FewkYFm7xQJc0XabVDt1wesYI
 E0YZ2PD2VuiUp2jq9+ebFlO9nLVDPEzQUvY9XOio5cVJzkCD3Gu96kOWCbx2Xafh7P5c
 bH9oLmQSK3L6Z7xdTgH0F3O49BsAOnpT+yd8Z85rFKmPorLiLkGXOavzY3QjeG8Sa7eG
 2f8A==
X-Gm-Message-State: AFq9FYK0KnYys6IQwx5ZRuCt/Tnfg0/J1mFiROYXYs5OuOvK4NjjLrUC
 Tcw7ytcImqCrgUTceT0BMbiDP2JrHin+utGqJS+rq6DkiEGTNPMaxlVYeVUjWtO8GoPiR1I6dBH
 fwGE3HqLKWpCa2LjmZO4Yjj7dlpJG4AtsSUQaX9XZTWGTu7+vcfG7jZPlU23Oe59khhn9+zwbIC
 XBpneWzLknxdi1SapNTA==
X-Gm-Gg: AYBFou1UACa781f4ladVcys95b1WNxIWrZeA6+/eow6qjxdLZd/EYsc8mRPAEskRRES
 G3wjAKiSx3OgmApnwuuCBpcc734W+9V+Fnv3eSe6n528Koba+/ABuPGcRRHZ7zXHgeYQig6LudK
 onF95q7TP7TsLiLIpvV70IRU/vlbMwEuInRjBacLymhiMKKtgDDQHYCDVG9xaYSjV9odSi07rfY
 cFP9sOj99/DcAPJnldlIuvqCcmb2QMAOltCcBn7IbrjrK0gbXjei5a/cZ2HLIDCse6w9pS4jjuW
 5zKHDCxZdoEOWMdOWrcSo53u/zpq1IyPnPWx7YRF5+VvU3jl92ACqzA2DLIvpzQI1hIZg2zmcqW
 88WvrTDhqAjMQjlKj7dqQsMjxsqR2pq9VXWOxSSNj9PfjrABWEF8p4Klm/3CJ7aPh0MC//g==
X-Received: by 2002:a17:902:d50a:b0:2e2:bfe8:aa7e with SMTP id
 d9443c01a7336-2e84280afa4mr60098105ad.7.1791732184676; 
 Sun, 11 Oct 2026 08:23:04 -0700 (PDT)
X-Received: by 2002:a17:902:d50a:b0:2e2:bfe8:aa7e with SMTP id
 d9443c01a7336-2e84280afa4mr60097985ad.7.1791732184161; 
 Sun, 11 Oct 2026 08:23:04 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b5fd2sm33300445ad.50.2026.10.11.08.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:23:03 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>,
 Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v1 3/5] test: boot: check the length of the external data
 properties
Date: Sun, 11 Oct 2026 15:21:15 +0000
Message-ID: <20261011152235.8842-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011152235.8842-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Oct 2026 17:23:03 +0000
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

Build a minimal FIT with libfdt and check that
fit_image_get_data_offset(), fit_image_get_data_position() and
fit_image_get_data_size() return -EINVAL for an empty property and for
one of two cells instead of reading them, while a single cell is still
read and a missing property still gives -ENOENT.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/boot/image.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/test/boot/image.c b/test/boot/image.c
index 2c6d9dcbc22..235053afede 100644
--- a/test/boot/image.c
+++ b/test/boot/image.c
@@ -6,6 +6,7 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <errno.h>
 #include <image.h>
 #include <test/ut.h>
 #include <linux/libfdt.h>
@@ -78,6 +79,49 @@ static int test_fit_conf_find_compat(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(test_fit_conf_find_compat, 0);
 
+/* Test that external data properties must be exactly one cell long */
+static int test_fit_image_ext_data_len(struct unit_test_state *uts)
+{
+	static const struct {
+		const char *name;
+		int (*get)(const void *fit, int noffset, u32 *val);
+	} props[] = {
+		{ FIT_DATA_OFFSET_PROP, fit_image_get_data_offset },
+		{ FIT_DATA_POSITION_PROP, fit_image_get_data_position },
+		{ FIT_DATA_SIZE_PROP, fit_image_get_data_size },
+	};
+	fdt32_t cells[] = { cpu_to_fdt32(0x100), cpu_to_fdt32(0x200) };
+	int images, node, i;
+	char fit[512];
+	u32 val;
+
+	ut_assertok(fdt_create_empty_tree(fit, sizeof(fit)));
+	images = fdt_add_subnode(fit, 0, "images");
+	ut_assert(images >= 0);
+	node = fdt_add_subnode(fit, images, "kernel");
+	ut_assert(node >= 0);
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		ut_asserteq(-ENOENT, props[i].get(fit, node, &val));
+
+		/* an empty or a two-cell property must not be read */
+		ut_assertok(fdt_setprop_empty(fit, node, props[i].name));
+		ut_asserteq(-EINVAL, props[i].get(fit, node, &val));
+		ut_assertok(fdt_setprop(fit, node, props[i].name, cells,
+					sizeof(cells)));
+		ut_asserteq(-EINVAL, props[i].get(fit, node, &val));
+
+		/* a single cell is read */
+		ut_assertok(fdt_setprop(fit, node, props[i].name, cells,
+					sizeof(cells[0])));
+		ut_assertok(props[i].get(fit, node, &val));
+		ut_asserteq(0x100, val);
+	}
+
+	return 0;
+}
+BOOTSTD_TEST(test_fit_image_ext_data_len, 0);
+
 /* Test of image phase */
 static int test_image_phase(struct unit_test_state *uts)
 {
-- 
2.43.0

