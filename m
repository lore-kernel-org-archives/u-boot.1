Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80A606A331
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vET6XXgS;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lNoNMq8B
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75E98605D6;
	Mon, 16 Nov 2026 22:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FptYcKt_if9e; Mon, 16 Nov 2026 22:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3C87606A2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868440;
	b=oI5W49gfnMYpj0Tnwq/eqr8hrIXYNzRYZmIdWKrxKYPY883B2PnZuHNCmMgRNwiun/xz
	 oSK10kL1KxU2VGY16JEjZrHqLG+JRp7KG8nbh8UBmPM7vxwpaPx6ciYz0bFFE965OaTLX
	 /GdqCkgMguvJf1lUOb7h+2fGkEA69lxSgJ8CsUgTPo4Zakrgtl2qmGIWZmfDLC9kLq1K/
	 QwtX3zLuxUcw8wU6oXZJ6DlaQiOlV0pJDALdIhrQAa7IBr+6HeaRcyJ1OPuUqqcKql2Oc
	 BhnSHooNJGZ2pQw1OMypXTbCXI5GQriDQbd49jHPtM5/7P0lojhv7MIRIEQ6u6P/wvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1qfA/4rukKlHCu2he7sH8LyRoWVqXH+ngF7mOB6AZEc=;
	b=bVTUn5ty8Wh7A21E+g97pDSfyl61NnfXhBsf8PrrNW7vkT+u+nrrMOmAm+/pbuxhFhWf
	 aNls2GY7p8wHFKXc84mXYGmSwwMpALkD39C0r1crR8+fdYcfQJMxOfyvsWXn2+zsm6nGa
	 q5wOMO1epgdKAKCcUEQH/qjzwdchKJw1WnSJ0A9wXv9wSb07Qnu0lu20oRDJuJ8ME0yWj
	 iL0Mfyo25+JP2lWFi0543YlGy7uxCDBE2VjkaYWMrB7m9PgpUI4vr8yGE5Wsj6SRQJ7jO
	 f1zZhod17oNuUCF5qG3PhrHquUknFVDF9FXoU3FsGswsMSI+hV5QmD3y8DNUfVfmIXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868440;
	bh=1qfA/4rukKlHCu2he7sH8LyRoWVqXH+ngF7mOB6AZEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vET6XXgSU95UgKyoNjEC8hwdWsBHqnXDgvcOjKtOtSny5ii5R4sIi3wD8OByn7E8f
	 TAnBvj+xjbRDypkpmvtMg9RAT0Bp1SY2bGhq0oUMtMoQiSOUKM1gi8xLVR0BgWt4vZ
	 Zipkv1+xQmYbP7XIDuWlNwu4D2u4agLu//tYRQBFzzYVQyQlF3IhdEIXFROvwhxVgG
	 5K7jGMNpIM7HQAwclZG/dIgtk71BmCkODzw5P4bFH0zry16Im9yXwUEoZWPcbKCwMK
	 ASnMkA8NjqQmeHNhsFDYXCzapnV3dlAre2qarReN7F+4bLbU9h231A2zTCUY4uyTmO
	 8dSAeeeBEEYNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3C87606A2;
	Mon, 16 Nov 2026 22:34:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B2A01E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D62F402CD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZquYz5xikMe for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 74A13402CA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lNoNMq8B
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 74A13402CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:33:55 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-55650fe1f0dso2522576b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868435; x=1795473235;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1qfA/4rukKlHCu2he7sH8LyRoWVqXH+ngF7mOB6AZEc=;
 b=lNoNMq8BzX1VT+MTKkkrxhiw5odwfiRWzJb7xkUABlodKiFnf6Vo+8iY60ca+dm+Qe
 7hw3b0SQaTNyVX+ZdEI2HmgG9N3ostHQ4gAyXrPgE5rxF/CBTNqYuZTyxhGhDwbBOpnJ
 eFRgqaN8HTZFtDhtsgs/mNC6c3Ea+fsOp/D+IaKNHEZ5SZLznczRSfOpziwSnTgVVaxY
 gJrt34lUr5hokvlLYdBW3vsacf8G6/hUTpZAHcJpc0gQD7/EfIqU1/mr2nmPtoWojhyi
 nN+WHLkDs/e0CD7HhBQHoY87OMxnigawaDyRtZ0vzhHMve+XJ6hpy41E3uQS9tbPzmCO
 x80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868435; x=1795473235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1qfA/4rukKlHCu2he7sH8LyRoWVqXH+ngF7mOB6AZEc=;
 b=IC6/JwuqRsgjnRsLUwDdzptb2jVS5y3SfcOhkYbLJLZRwwCqEYGaCoumJrQ3FsrvpK
 V9UT6gZ308XLJPwGpMbqfe+ltY4fhXWOelzHC0brkVvcM8Z4h5d0/CyyWVNiYR22EQ1T
 Sw8T/Bo2I7wmdiGV83R89vOaTVDy7Wf+BH35e1HtW6072ytnTzp4BWv545zorjWbNMYp
 t04pgdRRHFtH6LCT4DkJjcYlnxvMvTdrg50mXd62JE3PiEiwswhNQCCcvSehjf/nYr/3
 e5GTTYJZvJWki/YcJJvBXAm1HBUdawDRPBP+JFtykWR80Dti1M8SvrhQvUautUH8iGU1
 GHAg==
X-Gm-Message-State: APuU4Z8ggUryYesBiMadfktZPQHrk1Eqmu/QqmRVp7SFaJsaDPIEopW+
 NrKVQB06io+rcoIX2aWHTMsgkVg//L0tce8r7zhdBf01+R2DRWQeosF9b2a1ElMG+SA=
X-Gm-Gg: AYBFou1oARyat75CZzmKhkmgQPmdUzgiIuYzgZYzF7Jy2BYXP0ZqORgjVIJerN+rHzY
 v9+xZ7Lc8LBWsOLJ/IYSfCXWmyo9vks0w8Y6ovmiT1u/E12t+Ov6paJq6I8veLegN87r12Qo2og
 qUJSru4oKqrVRTH8JNO9GVomNOTR+xDTSpinuTe8NaynOFO3uLVCEVJTnbkzjrfsk1ajZtn6tJw
 RsyYZ1W/X3FJ8ac7YbhzrqkLbwSBXemDuQPdunbKaj3vMQj5nuaUTjPFIl7rfiXnjhnhFtW32DX
 ooQySWwgcff/N9QLj+rQni3BQl42gWkYnjUM+xbzJrVAfIDRoiPvqGDACTTcgfqRTMFuCn0+PPS
 9KHOGVfN5k80THWWOuLc+N1dfMO9WDlJq33gFNWtiDaAKIlvXDbArjor3Ta4nxEvbTNY0UwiQlq
 1qZzXVZmzMD3X8ycwwk4FIf3MZ6hG0cegopW8Do9A5YcL6DlIwA3ej39tHdiJpkZZRz2y+4SKbK
 usTjyMuAT3vDV0gL3ysYodzkSMD+eJI0GY1a2BQnWE3SFHEdXv2DYID/kqrBuBSvQWLw7UFQdPm
 nsSqfN129rAxg4vYCzxmbBmAtqe7H9at1zWm9mVo8qofetwbBJfO0Jw=
X-Received: by 2002:a05:6808:3012:b0:53b:87e5:8c9a with SMTP id
 5614622812f47-56e62c67730mr10752406b6e.17.1794868434955; 
 Mon, 16 Nov 2026 14:33:54 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:33:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 16:32:42 -0600
Subject: [PATCH v3 1/8] bloblist: limit BLOBLIST_PASSAGE_MANDATORY to
 U-Boot proper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-1-ca423d2d8038@baylibre.com>
References: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
In-Reply-To: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VqE1BWCkJNUcKjoNVLZ476zXRLGik3p1M/VoV2gl0cw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+4SXTrnkeZNntPG3pNfBh0yJ0Ojgj6HfPT7cf
 YQY1IkX2wSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuElxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ALTYH/RbbG2A805KMswgR7FLTSuJ0OXD4K3p3rMNBPv0
 eSpVevzG8ZDiI6kuFZOitIOf2BNSnoCtQzWsEehiJNe3IR5Wd/Xbp7fJ3LMfWOwVFoovCARpkAY
 OwnSP5YzcDFpklEi+ys+KErBqyYhOjBarrTh5qqAZUtsLIpaZb/2p+lkE+EaNx1qLSkutBKF5Iz
 RMPiQ91uwr15/ycXaHwl3W7TkXYMYBKXLvIJDgAbjZSd8ogTSPPpkvHjIXTeS+R5tC91YX7Cf7w
 BS6a5ss6FLCaCJJDbKV460YaYb0+vbf1KjFRE0c3oeHHjCWuNxAdljqdgyOidOFKb2Wft9Hg9cB
 CsrQ=
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

Check BLOBLIST_PASSAGE_MANDATORY with CONFIG_IS_ENABLED() so that it only
applies to U-Boot proper. It is part of the bloblist location choice for
U-Boot proper, which has no SPL counterpart, but IS_ENABLED() made SPL
require a devicetree in the incoming bloblist too. SPL uses its own
devicetree when the bloblist has none, even when U-Boot proper must get
its devicetree from the bloblist.

Without an incoming bloblist, SPL now tries to set up its own one, as it
does without BLOBLIST_PASSAGE_MANDATORY. This still fails unless
BLOBLIST_SIZE is set, which defaults to 0 with
BLOBLIST_PASSAGE_MANDATORY.

Fixes: 03a76b1a737f ("bloblist: kconfig for mandatory incoming standard passage")
Fixes: 179010694b30 ("lib/fdtdec.c: Disallow overriding BLOBLIST_PASSAGE_MANDATORY")
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/bloblist.c | 4 ++--
 lib/fdtdec.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 3804f061f87..85138fe83f3 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -613,7 +613,7 @@ bool bloblist_exists(void)
 	 * If Firmware Handoff is mandatory but no transfer list is
 	 * observed, report it as an error.
 	 */
-	if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
+	if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
 		return false;
 
 	/*
@@ -659,7 +659,7 @@ int bloblist_init(void)
 	 * If Firmware Handoff is mandatory but no transfer list has been
 	 * observed by fdtdec_setup, report it as an error.
 	 */
-	if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
+	if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
 		return -ENOENT;
 
 	/*
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index d25535bf36c..e0b0d4e927d 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1849,7 +1849,7 @@ int fdtdec_setup(void)
 	 * If we have bloblist being required to pass the FDT and we reach this
 	 * point, we have a problem and must exit.
 	 */
-	if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
+	if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY))
 		return ret;
 
 	/* Otherwise, the devicetree is typically appended to U-Boot */

-- 
2.53.0

