Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE7DCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10CFF6110D;
	Fri, 16 Oct 2026 13:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8vjVTfU-CqWb; Fri, 16 Oct 2026 13:24:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A175561007
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157046;
	b=Xg5kwKRse6Q+gLkroiZAyg7wnneuRvxSYuJzHaUpe3pW4AYUu5ynAXCR9SiHw7Y0hscP
	 AySS912nVbWVCAatgBp3J2vzuJ1q9Rjuy2heFpHZ41Yz6idHMnLaNWFcbBgQ4dI+P4Uqy
	 zCv7sgJ9mTI1oL0viFi1Vwb8Cyh9WZqw5RX55rOUEdTae4BzL5jHMMssROktVwwRwrdjc
	 y48rdsAVf454usPrjScKddWbfqgGNj2LgNupBLm+/IkzXlWqhj6hSG5RHkGvEgGxbyP3g
	 gWqejZ0zotkeVOzp6OZbdWr/LWWGUOK0mIBdO3d8gB0UpYKPFWjheLWKvO5nQaxSi0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a4eknaMH9D33LW7NGjGIHpn9fA5MTVUP+KOvPiAYieQ=;
	b=YdrRYS47IC9ObfaEy2yEyjsP3nuktQgAsVDHaWovlXxRwPLkQUKI9IVqdwMp3GxkIbFg
	 WmJlI14vYydqqKrLDAOyROcGyvOi6PBB8qpVCtGs3nu/DwV7yM+ZSyQs1oI067SOgdcff
	 +/b4DIH7RFIF5J/+CBTuVGGHNWA0TZE8jgIYyHGi4+RXrYl058NtkzP/dKEqFbrvrGgS8
	 GsuCVs2HIV9kkt6HdTgoTxOYoYnlQlHAx+f0G4LxRcvcvbmGgUROLG9/Wa1e+nL+aFwZT
	 EmtuXXSKVDN2WMyS5y/OJL/YATCGeZNB3p8oZahrzBp25zPAFLLn2Qzgvh8oEy2Bo0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157046;
	bh=a4eknaMH9D33LW7NGjGIHpn9fA5MTVUP+KOvPiAYieQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MtiCFg4g9BxE2Om/EQxNGVT5wEm4MmrT+ybvla6Xt5v/mV0z6wlZ1LLF40H6SfYeA
	 30HNmsU4W+iK3F4ZZRFAUIJV59AJewjWNcaA0ECiaB17Ud7g/8NgQ4Yc81WTSnvCF9
	 bXVk4IVlaoiu634xOCD3cXBaRURD8uDIHowJhlDtVN+P/2JwvqzQnbKik6NuaWw0Ei
	 pQcrmElIGZ5jFvlXI/LAurrG/sovK83b2jIe9SZXc63xoKwtSbGIAGA1+llEOrcN/A
	 SfZKaXv3o8VGqyTImTJC7ssDCXG9x7yYO3J0HOynHjD46HX3vtDjRo2OzQsgJgqhyS
	 SJPd25+SyvSQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A175561007;
	Fri, 16 Oct 2026 13:24:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D0B0263
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72C2440974
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHwZ-sdr9K6w for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:18:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0745C4096F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792138683;
 b=h8L0ExwY/cI6tGhVu51Sa7Nj/WTypwF2netBn+nWIaIlk6+8Puk+Tg4I0JQodyxcSvGh
 oOoCKKl7Z5hP3Oxf3267NO9/zyH6xjxhN6MtLWmbpE/H6MSLuKyrCzEMllHzQcsIZAmQy
 qe7dzSJozU0QnGtKm9KtpE01yFlzyI1mVUatFA6C1tXHNX83wAPUrjUcyOCDaUd9DTbzD
 Y+2JokNvt0pBqGsRr1SFGr403fYsZkyrZTMSTPYl8L6p8F3pjJiJ22BkU6t6cFvceJapg
 4uqineUUl1SaKbH2+xekEF6N5i2tFjfyy92872CBZ1pGW6z+f3yisWlEbAY58wGI5ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792138683;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=a4eknaMH9D33LW7NGjGIHpn9fA5MTVUP+KOvPiAYieQ=;
 b=ClxffQz+cOOSO7GWu2+xhDdJrMPzwLnrUnDce/y8rmKtyDmH2gH26JYHEHXpXIyFc5MC
 8SUIbbWRkWV2F2rvQTcquJflYBbHXHne3CNqsOSw5y+qfIHc2xNB+VHfjd0bhzP0rC4bt
 QnTa5ORsfZWuwTCEvpx95HYY62Xt0RyaVBXJ7zI73Vzfa44w17482WUdbnJNbVfZXw0Fl
 ksR0ApjW7lmhiNQS/qiJd/3urv42HLmnRjyNaO1CQd9uQ9qDzl/CCpjPXeZBq8IBMmIAk
 F8hqDtC48hxkGcOdVxj1Hv6f0YW/hDIVnEez5roRSUSnugZ+PTl4DrUk6wWVHIYPGCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=cht65Zqx; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=cht65Zqx
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0745C4096F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:02 +0000 (UTC)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F363240302
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792138681;
 bh=a4eknaMH9D33LW7NGjGIHpn9fA5MTVUP+KOvPiAYieQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=cht65Zqxoco3I8pd2Dsg9yiK2VOlfxbMqL3cRIcPvC2npVGfYdz17C25+i5tV89a1
 D8HvBoTccnimP9MMEjwQKis9wIe8upQFL+nv/HFG3XfEDhJ/RuUTXa1lHO7Bvvt1qm
 tOQL5uQ/avu/lJejwtsUTQZW1OKN4syBFYjehoCidc1t9MefTEgMmeMaZr2s6S5H4V
 5kMp5xPTMhczqO8MvWN6JF5CRQqJjbWY7dXITWQySpTJiOFQLzy4e9XGqznX0/WMhj
 j2ASSA933OIdoHTQAF9Uwh9VhsByeJbOhMlNTdmBFjpnozaRdMKdTxkqR2V+5Mb20c
 NV/xLd+IIrvwgAcRc0/hWntyq91AnfgPJSpEzo5b4HUfTAQiRvW51GKcJ0a1Xex529
 DAb8J2/vSz7NuWD56QswvUpg2CFh33TulJ0/MJJMLLWgALwRwI5lnVH2Eaq5yZMqTM
 65Qg8CX/vJKv2hJdpG996rCONTbxCOV29rSMnm0eIOVUPGvW5MaEW1rH/7ORpr8H21
 5OgYfxwC7482hVsBPSTFJJd1DdBhhYRssmV1IAi8LqYstpN0jrG7nXHONZdGHZkjM1
 a+Y56QcZ7LiGgMzRdioVaNXEvV4+4MLTbf7TAY32L/NyLlmH/tF6v5DekTpljkp0Jq
 Basm8WQPVWTvVIKuHrMT3r5s=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab9850456aso3651321a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792138679; x=1792743479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a4eknaMH9D33LW7NGjGIHpn9fA5MTVUP+KOvPiAYieQ=;
 b=GUi8hvilVmnUfyADpW1RWvZvPlfaNF0ifrS5YSTVVt/1pwY1VkhCc1TZLorRxoJebA
 aM4Er4sQFS/uzaGZ7NIrUKWRJBNsv9eYnDR5bsQAjG2DlT0uAREN4UVlB8KQMhtb9C8J
 bx1s8wHMDfXlDQih5/dQOlTne0sctI814TXPz1cyqNilgURvzThgDXk97EsCM/Fa0uis
 56FcFXWP6IOZAQJ34n4014RSaBaaNHe3NDwYH+qz894f02gSF6N7k0FmnzlICq1bPJja
 K25NalRL7gfjCKytLVWBwXw5RobCKhrpprwQ6INue8GS1StJD0/nBRTRmdPoVLJDLqMu
 5ajg==
X-Gm-Message-State: AFq9FYItNPM5qr6C/ND7eF+AaAvE3al7UokiIjGCtI07B89TE+JJrwA8
 9jlyM7iBoDZ84n/ZbBoc+Joiy9FS20L6Kuj8vd94qvo7STKV08Dy2/onTVqWZcD81ZYImljNm6L
 XTkJUgYHDp4/BJRVNI4bv11O0OMiQL2J/t2qSNRX2hB0cEpAtqNMHpElZJhsO/8YX80krBkH92E
 s09icPHwyJT4EVUIhnNw==
X-Gm-Gg: AYBFou2LO33XppYXqbyhgLlQ6tuwQf0XMPHQtPi25dNtZJL1n4NowwM2iJwbyAgoR9S
 LkkJsiZ3yMRF0TPohkcptaCCHejdnohmTXa5Gxe9bp/N7wkw03oaSc0QgcdstZ8sswURUJFbvqw
 YFCMnDI08YCzccvMn/Z5dT4TRmymkYOTWU8X9XvghQFqEHT47IraP7Hsp40Zy1ZQi2FAiIHvyLj
 hcPeIsDADf0BQ5mfgSv2+z09X4kWyzSlhWdxWmirIuctygLYlHwsN1ES47M93Ap7DG2ycpG0keN
 hLRSSadMZM8sVNM3JZzvvS6+EZfNeD14SwFKK98qRunghCCBkzz+N6Rvbb84qoqMme0Ynte0LJv
 eJHoeMORFtOCtcpsQLy1JiluaZlkH9++OD3g4eySl3SoxBQol4cYYfsXfbJ/Dp0Frpg==
X-Received: by 2002:a17:90b:3d92:b0:3ac:9669:845f with SMTP id
 98e67ed59e1d1-3ac966986b0mr5203866a91.41.1792138679000; 
 Fri, 16 Oct 2026 01:17:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3d92:b0:3ac:9669:845f with SMTP id
 98e67ed59e1d1-3ac966986b0mr5203855a91.41.1792138678635; 
 Fri, 16 Oct 2026 01:17:58 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm9149405a91.9.2026.10.16.01.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:17:56 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>,
 Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 3/5] test: boot: check the length of the external data
 properties
Date: Fri, 16 Oct 2026 08:16:25 +0000
Message-ID: <20261016081719.814357-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016081719.814357-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261016081719.814357-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: no code changes, collected Reviewed-by

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

