Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B302606A329
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zm903lr6;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=psZ+vK1s
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9142811DA;
	Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mn3Li3d26ZdP; Thu,  5 Nov 2026 23:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA27F811BE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922393;
	b=MG2oSdNl9PGHxyuIl4EUihJ14jyuN1Uq3ZU30B9MNbJDcsN/VFOl/pgFXgAXs+wlbfMJ
	 TO9nsTV6Pf9IBhEEygtYLwBaGaxMelCNbaXXMTrzuOc9/zBylcDm6+nI8u/6gYZckLwKH
	 IhXDsQ3itf1j+k+VVN1TaMBOxCln65CdTMmtKlyqI9sDO4/8E43QYaJ1Gnz7ITwuee3pD
	 BrBYdbhF8niVfrY7I2awSOagjLyHYwgZTg4gSl4hrFgQPK5WvSrsqA9RnZ+leVc54fSO0
	 d1jRN5mCckgcL9t52iPCXK1WOcNYb2PH2YicFcDzOzJxZ/8lz12GX3uAH/66if4VVVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HakYVTfsJxwOTuZayzzC9+HLqcUQzRbu3RxE6q8sSuY=;
	b=bgMbTPxV3eXcLHCQc1m4zGWCVaG5ASzJCySsmID/TA/IP+d3eH0GjynToPFdjwmLzTeU
	 +9VJVbFS9cJvpngyOmRANxp7c8UFXSTjSRf7S7z6HaNTDK52NwNS/WsAC+Ooo2oxPm/sl
	 MRaO1LmlnwWiHJzY2BdqYEn3t3PZLQf4DRsSzjKJrtbhgN856nC7rarKi0tZftnt3BN5s
	 NCMJhkQtjGnAnnCkT5vkTB/qGgaOy0UHiVCCXyc/EANUU4lVBgbGbMSzbo7iKBgX02Lxj
	 CpuObDxtbjuUa+LtxFZON0PUDDDVq9b1x8PrsOfm0eIsIv9KjO7B5HIcrJJPrmzKvRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922393;
	bh=HakYVTfsJxwOTuZayzzC9+HLqcUQzRbu3RxE6q8sSuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zm903lr6pNT6Z31uxHa3gG6r8zGEhOSZ+672XvsKoqYfFNsmriEi1NjNlYOTYXAlV
	 cKGg8d7Ta8R5PkKQjtXp4fWb1YOTXxYkJRsd+gOOKVMex40WWmDvm+NVpbO33z973L
	 aoI+skSRbUQ2YQYtz/HXsFbaOPDvRB1QuQNedJc7DS9hFEO4Wrm7fyltcDiKVlGNIQ
	 X9W0huGmIxXTNE6lJf/FOWC65OULga0KaA6vUZfGsf04SXbR2jdh5wSHxiZ/QTQpKJ
	 Qo791DdIi9IGXSOyu+T3veCkyPRZAls2SqJTaE7YyjVMCOf+kgLWvLjBFP+TVfI3NZ
	 fa7ZLrhbrXy4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA27F811BE;
	Thu,  5 Nov 2026 23:46:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB18595F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1376605DF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rCpnsM4UuwYy for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C422B6085B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=psZ+vK1s
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C422B6085B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:30 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-8470d7d430fso54640a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922389; x=1794527189;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HakYVTfsJxwOTuZayzzC9+HLqcUQzRbu3RxE6q8sSuY=;
 b=psZ+vK1suzy+ogy1gLICKPFHTxyNCZ4WpqvzH9r9zlwUqiEwOusGybDXsA40DhZpHS
 bie8L4AyEYaxEKPgJXycG9mGK8B+uo+p27hgp7xdLrDt5IPmQggMHgtsLQse5yQ8zyXl
 fEIPcuqjKIziVp84OpudxCWLoND1FZaddA1ep1RKuY24AUkI26JhdiSLgvz0WAfNYp4e
 apD/zI6UuQCLC0bFc8NVthKce9DqNGIBDIA/vkFX7GoxzUzKu4UtDXW1LMdFJLGjUnMP
 NoDgmR2LbQSnYgRLreVvMUcWr3dZUj6GJhm9sTOnZ0b4duGyzskNGLNDx18jqTqnFFTF
 3GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922389; x=1794527189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HakYVTfsJxwOTuZayzzC9+HLqcUQzRbu3RxE6q8sSuY=;
 b=BN7wbzIwHcLGJnA3gLcNcY4qi5JkgghWdRTv/nY2xTPTxPrYRFxOm0fWiUC8HDI5xt
 NIFHjxHS7gnKPReIoXH691rOyhxrdPEJj4YoUDYEVP5LFoXjXAk9TtRxT3qQk7z0WUje
 lbt21H3jxJDuKKDUIim/uSGpkgVkVUXYKD/sV8GvNOt4L+zkUwEu8VXnSM887jEHL+bD
 O+/tcclQh7syp1tGHUFDzkBO2GR8c+UCi1eDfA2d3FD8d41Ba07y5G99XAthAJi2CFAq
 mSPcKmPAQRwM8AZ4eYwuTqZbT82wvpVLy161yiejKsulmnA+21TcAuw71+JlhAbabzg6
 8/gw==
X-Gm-Message-State: APuU4Z8OWUuitrYFSmbmxAZHAjrCYJFbWSnsehuYdJboP/OZjASD2OGH
 LvM0QDDv0tOkXLjuZ9MRcCYiR+qju/P75yUkCNH8FtlwajmBmOavWDk1AjVU/NUIHmI=
X-Gm-Gg: AYBFou1KDZkXoOClvF5uYNeqppN5dZbQsaP5URjdXNNyfTExr758NxxyGG5NMDfEw8z
 kL3z94O9CidGlCu0NgwQbVE92ZoqETtZ3G80QkHIyDOetnuI69dq6ByHzd6Dy9W3P2I8po9JuWL
 QLur8q/WQyvTHzlbqW3LDjKkjBd6neSBV+aIaSM9n8Q4W8x4pUKxIdPqVnsct3eLBsGWIquIGnE
 6KzW5A4qq6JsUkwElCGAKDeeCTdQZd7X86pRPNJEq0ZCbjBFz8BYP5maBNaUvWQuVRNUQDlKWil
 5YD7O+rsx/1OZA+OC1wEdK0yHhoUJsHbEBpv0/O0HWWuiZ65XM5x92qDpPIh26kGGeZ4fD6k16w
 HZjPEHR7+bwN0zsDp4iR7j5sCc5eWXpMJi6lIaSUzCCqmX+EjdghcuEkeMNYK9TedjgP9hmoN5d
 5ndy7/tqoZ0FvZ5tw0Qy4gpmSSghrgpSlihw3B2yRHSx01qMfcNcACIxlCGHdhsAi4SC348bQhc
 lphMkgceOo8h22gYj0snY2/x1FclnH8laYwZ7m2dHPOIlPRhxCNrnUe77pNkS3dnrivZcm7zAW5
 0Cp0xkecctjhhXHoOhLFDvcwVpjKPGoSHQ==
X-Received: by 2002:a05:6830:2b27:b0:81f:92c9:1f80 with SMTP id
 46e09a7af769-85f1cf5e051mr1110596a34.16.1793922389434; 
 Thu, 05 Nov 2026 15:46:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 17:45:23 -0600
Subject: [PATCH v2 1/8] bloblist: limit BLOBLIST_PASSAGE_MANDATORY to
 U-Boot proper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-1-c168a7b4041c@baylibre.com>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=7q1RMaL1YAQmv3mNdeKx0ChQ+WHe97kh9km30xH6BFs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RUdFMJltVMLZl06MKd871jfhJoQM3ljYlE9R
 s7m8JVMMISJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VHRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsRgIAJc/O/mmhOMw0myoELZgIdXWPqem8dfP/xiK/Y2
 y4Bdl8XD4rJFtF0QUUu1sgfbI1uQf97AbqfqQgko7825ymTxrbSySMiUxXGDirLdP26zFmnTMPb
 5NSynbgliqIKpp+FPRpGIIm8ODdMcXRaicon6/Dq5X7xF63opGpnBu1ONXpiGThjutqvTOJ2vST
 5DcUpnHNK2FYh/xtRYZD4pmk2Wr47tSGG/Fx1sb6Pvsd70jXCbl7DzOG5qEX+1+a49LNxdoS8RQ
 88teIA6GAjiHCzR9ZwVRQ58v7+O+HxseJTmGY5UFA7dx/eIqz7iHLPvhZCXiQOLdkqhdgS1SV7m
 HfcM=
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

