Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470A8606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dmEzdq6Q;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V4rpS192
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 140B08153C;
	Thu, 12 Nov 2026 21:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyosRxDuzUGA; Thu, 12 Nov 2026 21:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84FE78184F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518209;
	b=Qr83AVVWjoq4JBnRc+zqInqMtIKFzGWB/+FowcNhHu117uupBf7RFsyVDxPHDZYRSyP7
	 nsr2rMseJR8G3dPD3Fj7BGRHm3u8lDzPkG5CwCW9QrcY5xHbPjUWBTw4xz/JRMBOmZV4O
	 4sBtNVtrfpS5//YoJ1jClGi5qvswAWLF8/SiebB03fTV+Iv2s44Yv7LzBIqzFB63zHdOq
	 HPOEMB0pr+jcGYpDsYY0XWbPLYob9KiYdjzrRkdac1xrNlqwDJxGzhZNJyfsv9p96QdD9
	 PM3cMBeCHNS4yC8bLwSz4gzSEQVlHLnB4yvZlvX2D+xE50mRrQ2QFTZ67EqpIAtAaVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Lcl3L6Z+1ndkmqbB0NjF7hXeRMchQEggZacH9KhB/U=;
	b=KNMK5BcJYxNC9PjmMQXwnMXjnC6mMqVOQPGUs1njRfnIocGM6d9iNEC98X2ja4ZACCQ1
	 tErY9xy85SYATVQb2AcvRNfUXQcZ3lywS2y5ZQBrtUjBn23cFVsQ3Jmyg1ge3+cWEvv8L
	 CcgyaZ58lkKD6GidhT20DV/MyPSyuLBOI71PmkJVpVu7v2MHbgP9L13EIjyv2Pp0qcWq6
	 utcczG/VC9Hi8/WGr79FBuVqSdOsZgOr468zdltHZwa1UkAc9Q43SmsMLYkZRNN+gqAgX
	 5QI9dSqSsLPbLYTdXIJlXL2ahk6cBzGMcRhxyVez7nvWGrGxICDJiVcZSm7irRk/nwQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=V4rpS192;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518209;
	bh=6Lcl3L6Z+1ndkmqbB0NjF7hXeRMchQEggZacH9KhB/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmEzdq6Qg7b345cI3JSY5sePVhUUv/7I/iacCunctfmJAskT2As5fi2zILXglIemd
	 DAfEqFj6IcYvs+Tx7b3N1z7HW86sbHxwvAG8Hvs3SYu4Z6mMgKABfSIK6twyAvOnzO
	 9v7MKeNmK8Ja8fyr1ng6wfRNoPef2pwYjA6KpvgzcpxX2XdDGS0U3ggTL2F/Isfg4J
	 3h5+9yVGlwqTkc9+QX2E7XnwHXZVpwr8jqemnU3C0kCWGE1zGHE+15mc0YxGT0QhMN
	 rXVcFNALnDPLtg8zBZ0Q4HZLj5WDXbcfSpMefYPY6D6uAWhyvDAvOUR1l58EboHKBn
	 But4MhIKash1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84FE78184F;
	Thu, 12 Nov 2026 21:16:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 723E62E5
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B1BC81761
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOsOHJ3W3vGj for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 954F181815
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=V4rpS192
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 954F181815
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:46 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-539a57a0b1fso94619b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518205; x=1795123005;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Lcl3L6Z+1ndkmqbB0NjF7hXeRMchQEggZacH9KhB/U=;
 b=V4rpS1923WUPlEb+ghGpiQxbpsLHtjeVn6VdWqJuDVCPugSWaek48B37jBJWNXxAiq
 Y4F42ACwjl1vJxgJ60flawX1X3WRSptZi1ZjFW/ETysoqbjL5pgvgLgS7YyvP6CewArJ
 k3J83GC6vJsOKe9NjSidzIQdp4onbkPyjbrdQrjej6yz4Mu5jqmMQOxY5sAFey6ooA0M
 h2h/D/xovEsDnN/9kCyP8Bv/Hd5e5yPmuni+OiYK5CFQqok7LflfIJvMuHOu0Q4PlV3U
 22rHnshl0SAV+KdciHwRFFZa8MttILQ5mVmpF/COv/7gbcmtBhPogKSHRqMISBBq+l2D
 tGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518205; x=1795123005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Lcl3L6Z+1ndkmqbB0NjF7hXeRMchQEggZacH9KhB/U=;
 b=fKJHgLXWkDjXpt3VfZTsnvj8/V5bALN5hX+U0/bOaj7gvEc7lrXVg0B2GLeSiWPgaZ
 M47rfWSXb+W7JPiboq0r/q4mbyPFbYicg59Fs8TWKH/F/fk0I9vrTb0jWByyh/SYc1O1
 dbcbscKyeUAkULeXujgX1ULctrS1C2abMzAmK7DtYdgJnrXGimpn3IURC901N3wUmPlB
 0KnWBPKM9gmp3O7XK202hFBNbT26gUSk8tL+BGFxC0hfPqpXISZrLmsjsCFDxKR1y13e
 89mEqR2JsUNueviaJ+UcXavIJOYTvjIREKqdNgEKrMKyeE3ZdV4i8wQ8UA/qTFd1WdAn
 /wCQ==
X-Gm-Message-State: APuU4Z/B1gqJTzkC4bxhJtK/9648yNWU/80BjwxpbgKyaguO28sFsbUt
 QEj6EXQNC15FjDjZh9Z2bhrjv90RO8N2kLD8oFxihp212Ta/MMVA0gwmxZb7EGgQiZg=
X-Gm-Gg: AYBFou0I+vA8TzIqEq2utRq1tSRqS1F7QFgwtehIGIjDXkEjlTahAx115dX606Pz/VQ
 AtD460OHWvOuIL9ASkavbVmNgrvbov80Tir8jKrBd6+Sz4H9Axq5Z62rSZezkt6swP/KGAPlIzu
 4I3V5u1g0B6T+eZ7tNa3XGo3kaQY+z61NAKq15csaYa0o7ttEy8rTwKE7Vr8ITJOTeV4lx8+4qw
 w2WH4vPjllj3roXy4FwVFgn4tIUwXKJdM8XJKVlzKxsYF21bO591VYM04fpvBE0/slxh/FH6jYo
 GuhdkOEbbb8/mB5gNI+JaYhgkMmuvu/5LWa4hcjcNDT4noMo3iB9PNbNFYKjEVnK4W9rZ9yE7Po
 CQ3GEfofbzQlBgAOrtZGBb8jLGGqpS5/QCTdBlwSmgknC/tJqBRw/MfsM4+dv4+QPWKSBfd7oTE
 TW5K7WBJjR+k/b5/BnmkuTVsBpR2blgwx8iMlIHk3T9MRO1FEf0qA245kh3r3q+s+L8Pvpkbugj
 7080oYOm4JldaX2oyRixFX/L/h5u8fJx0Xq9+SBxrwTDKuuSgk4GubW/gqW+1+1UaXaBouk2Qcv
 yqTABYFcW838/fNhwk/S/JR8fAp5TEuyPM038hO03BuCdtpoPCLXh50=
X-Received: by 2002:a05:6808:30a4:b0:568:1716:190b with SMTP id
 5614622812f47-56e63ba9823mr519641b6e.17.1794518205028; 
 Thu, 12 Nov 2026 13:16:45 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:15:04 -0600
Subject: [PATCH 09/10] board: mediatek: add a Genio boot images config fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-9-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=WK+tDJ6nY9j3KNJ4qT55RcA7ls1m5LD6j0kK8gTaWTs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9iyXKtu5SMTpCwz50/ZJGfQRUBcgbNtbYe4BZ
 CibZ92RJgCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYslxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AX+cH/1hQsojuHYZuTPX96JeQzFiUOP9nASIiLrTTC6g
 +TDGUZ+vloN/da3qbeULXRGZu/C3MPRXaGAYvM1034Wtpm1b13q3RpPFU00KWH4J0H97QFIOepD
 kjKuz7cgp2zJoY04jV5o6fFKrJ9XP/hsLyNZj1SW4lUeGr8ebkO7nd9Z6cnrA53LXnlsISueUpX
 EyvIVFfxXPhoifepO5CCik0fzr9dfgihY25W3IAOABednEoxIbblp9/jeHZrRl1bCYZocSp7YEG
 deAzfL69Qnrfvbc3FZxC6SI53U5Y815RyRHg2iujPEK6ZJagyjau/8Ou8Gg/as1QLoIUUUemYte
 dl7U=
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

Add a config fragment that enables building the complete firmware
images for the Genio EVKs, so that it can be given on the make command
line together with the board defconfig, for example:

  make mt8391_genio_720_evk_defconfig genio-boot-images.config

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS              | 2 ++
 board/mediatek/genio-boot-images.config | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 486fc67983f..25b12c5b2a7 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -6,6 +6,7 @@ F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
 F:	arch/arm/dts/mtk-genio-*-binman.dtsi
 F:	arch/arm/dts/mtk-genio-binman.dtsi
+F:	board/mediatek/genio-boot-images.config
 F:	board/mediatek/mt8189-genio-spl-ufs.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
@@ -34,6 +35,7 @@ F:	arch/arm/dts/mt8188-genio-binman.dts
 F:	arch/arm/dts/mt8370*
 F:	arch/arm/dts/mt8390*
 F:	arch/arm/dts/mtk-genio*
+F:	board/mediatek/genio-boot-images.config
 F:	configs/mt8188.config
 F:	configs/mt8370*
 F:	configs/mt8390*
diff --git a/board/mediatek/genio-boot-images.config b/board/mediatek/genio-boot-images.config
new file mode 100644
index 00000000000..4471532c928
--- /dev/null
+++ b/board/mediatek/genio-boot-images.config
@@ -0,0 +1,5 @@
+# Build the complete firmware images for the Genio EVKs with binman.
+# This needs external firmware: see doc/board/mediatek/ for the board.
+# Use with the board defconfig, for example:
+#   make mt8391_genio_720_evk_defconfig genio-boot-images.config
+CONFIG_MTK_GENIO_BOOT_IMAGES=y

-- 
2.53.0

