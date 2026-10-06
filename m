Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54C1CA6004
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00F3160818;
	Tue,  6 Oct 2026 15:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6XzvNhg2m57; Tue,  6 Oct 2026 15:11:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9ED01607DC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299498;
	b=AsZWxiHYcl16jhF0FeTuB4toIdVWZS10MRC45R8dVyeH9r9YraxFS8Wsr5BsPgEfuYVo
	 Segg+PKkOIKOMqSdFWCmMoTCFyLxyyyTaCPEMFavYefXLeB+Hn3oPxfb0v9+zsfIW/HnY
	 AQbSAbf36KtAn7QLP7AmZb2K5+A3ac2hBuMD+3XoR5VdlZ3MLqTQEiDfXXC20qPprSeyc
	 0YGS5q0+6jSy6tmgkKfuXZzLu9bydb/cmJIzTJHK5JaPsMy110Lgf7f/L1vcE2nIh3VcQ
	 nX5Sy2DlzYGI1ciDtQfJVYRmGLOK+ovBgM0y+Eh3/bEsOG5p6iCW8TKwBfp5FIgvm1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Q9DcSjRxqozxv6f1YGP/lbI8KPhPlls0CW5Iv+NhZvg=;
	b=CHpJ3ccW2h4YVKqHM2oU+OgIZ7HgcHyGKXbqfkBuZVY26bLgLwfMuMyTVDpSEbMcGje7
	 Vw+a/yfhN76yGV7awmcG2EbAucXsDF6vYrBUb2PoV7QI4e1bsZpI7wxQCjUHCLo/JIJKP
	 LYxLh4RKUlx9byu834cs3YldqabpmrvM6PNqY0MQiE8V8JAWkCdg7ttOb2wywf5usiniT
	 6zUzpgQLb5nPwpm1TXUmYrfsqPeIryfu1HJiFzJFNYAYyoEk0ub33BBew0H6MggIUyBJc
	 KDrnLSRB2UbfRHEE99o7YmATKKc3Phl5vWHX2JnV2oqDdEDOzUhb4USsUAjXGdwNHrg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DADfs8cl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791299498;
	bh=Q9DcSjRxqozxv6f1YGP/lbI8KPhPlls0CW5Iv+NhZvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nXqphcmlzM1hh8QI+vYxSPjqSrtL0ivAHV9cPxVH635prfBjA1s6N3CJ4G+iWJWWg
	 en1XqgGfCehS39YryScoKfksrItdTGJlB6enwNgVRUJRQebQdfrs0FTcAKhHBXzoQ4
	 ggy8txxzG/IHOm1ekqAEuECGPUU9kB/Bu/W6Rp+BgUBA1Sg4jzZ+Nz05xPx+nNwaFO
	 o7bAOPOh84UahuLiRBNNecRFzsBMdbIZ1+JG2oxHVi3lhJewW40dA1UgzTLxFeJTAF
	 0FBHjyIxjm4zHT9CBLo0CyD61N9PlMdNQ+kMxnahy8ItdLMWE6CcHFktTH02kyqKwH
	 kQGJSkKfw+yGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ED01607DC;
	Tue,  6 Oct 2026 15:11:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F374D75
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D92E5607CA
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id luqtY7K5H_Xb for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:02:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6903B607E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791298920;
 b=cXV34jZlj9eF99fvGdTNUyEs7XVqT2SBUwKycaJCueN26Pt5rG7JigIoBXssuy3UzSCP
 m+sbGLaSSyLdlI1HOUMzQPElzUQTBrSh5LhFIDzniXAN/GWrgySCHYEi/0+hVk8k97Bo/
 /A6/wB0h/kUKgc45M3Psay3vcSVhclEGfTPyrNy3+lXOM8GbYtTXWr5qXJQOw+51UL/2m
 T8VvT2HzgIgmVUMCNblcZbuZaC5FjL0G/5+LHhf5m5hmP8jmFLyHb9vOWPqVx4TEI1M8v
 HSGmgYWuhxk62TisN/nxCsUBI6R7C3ppfegeG0WiooJlfAxtw2xel3wbHoyQ2i+T+xQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791298920;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=Q9DcSjRxqozxv6f1YGP/lbI8KPhPlls0CW5Iv+NhZvg=;
 b=ljUgz+gT+dhw6qoaDv/1Ci+OHOvy5u9STzeLXk4UGUuU0lEa2T5jImSYaWJ9OocNzb1G
 bAXbo3d+ZQcqFLUoAp9AUH2VuZ6YKSA6O7N0ygoCa5DK6hDhtO6x3vevrDkO2qiU2tH4X
 JDjHHZ6y8KwmbodZ+4cgQOS/XRY1O0LfENzcNZeKoSWvKPWhLSHHoyRZEbMqkNy1Ag044
 gux4SgeRMANc8Su5fMYGgPHcGLvQ2IuNxOgUi4DzlRbrYuv/pyEJqhpUAp8mWQ5f16KJ5
 vRRkPwbjaek8+axnHLW/4qbSBQA3Jf1BOqz/cLKCeFPnMNldFfKkyrSjdAIWz0jHiSw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DADfs8cl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DADfs8cl
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6903B607E9
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:02:00 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so8010095e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791298918; x=1791903718;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q9DcSjRxqozxv6f1YGP/lbI8KPhPlls0CW5Iv+NhZvg=;
 b=DADfs8clqI5uefsk48xBnz8U1D/WBMjkNTsiH2mcztN0pvDvSrfHCL2kufLZcnXeaz
 jnUQGJKmFKRmz6W+DOTxrX4uREzJmjpc2tlYAi+xB+MkRHsxB9SetcubKdcoqRUofEvQ
 AYAyDBlM0lYtd6+cHo7e+uKH1BXH5bOGTzzWqej9fSOLyw1PIumgl91uN0ZCWBVxrhvM
 xuOP/gpvAyBtLiL+xZdN/C9DUqANtFX+W/Yb+JbKllwmK9RSUOeV0yQYere9AoTrVp73
 uO7OxwjV13+3MFQYMZ03halAhTGchaTKh33WS9tMjKYMRi2U7XsnyPMNT+n03sIi530X
 KAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791298918; x=1791903718;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q9DcSjRxqozxv6f1YGP/lbI8KPhPlls0CW5Iv+NhZvg=;
 b=1ctZRkDoIVfVXUJv2K1Q+SZEFEU7x9c4sBp7wynjaj28yvLYzD89Qq8U1ZqxBMJnsR
 DywFlgVVZhi98Rp0gl5CPIwvEdGJ9AkukAnoSHu0IYZ/MeBHlJeic7F3hlazTRa4CXvL
 i8mFAT+m6MvzUDbXAwC4dle/+PdfUf6+EalFPOcN2k6AT9+UfvDs4DujNUSz9VKBmi0d
 HuPffP1AalHgBiZ7xBXEE/fcyVNMc1JN43JtaJ/k60QXSMIRf5/53LV6/uTcyikDs2AI
 u+5lLUryKOnHawRZh9vVFXjfCqu+ApAL3pNw4ATKTs3MqHYXLgy/vT5rblTyzh4YTVIB
 NbWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+Y0Jrn8w5QuFm69lenA9h90KXDpMrNIcltOCVtk43Gf5vNtAzgPhxgom7/RWT8xMilE2pVa0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l4odnerE9KaiPYJwFtBHT5FRz9RqLtcf/ALHmUoHAqPaIuDaeg
 qN6bCGD5e9e9x6bW2FNOypYETdXr978pyYHQzPn5ORkTXcrKZRV3hJHYKp95fIirwTE=
X-Gm-Gg: AYBFou2RS0GrGmc6sE10LlRERrwmESyLslC0/e6aEIqBKx0AkAtRpQVBEmnrSJVYmjX
 3M/DY/XwIhl5oHuAFkgCZZV4Q8jDV2bK8zYH7jll9v31BPKpxNavt8RXJPcJT2ftAHGV/8qV9Ka
 zNmU7zZpQcc7MDMat0B2e2fE4lyu1R71eWD36jZLC2dLvs6nqTmvfO1P/4MIelvGEV9aCCDJB5L
 FHMbJbMbwfDhj7wFF0xYZUQilp5/iYbfP7UbjF/kIakU/MZdQDfLrg5EpK5VeFEot0r1UruMGuP
 6SStLpVYlyzb9kC6J9rG6IsSUe6fdKDYBYlADngDV/kbQVpf8AFw+XRIPhWj7LszOohH7EuRGQl
 77OSp7ccATKgyacbcSu/IqYH4cYHyI7mCD8qCnHMF25NkauqDbmrMFwFTvlenM5f7SaX6l2jXfq
 dbDQUmNTqHNWAzpUyyqZlpEGMo+QriBJzemUcRQnzR82r/Y44T8vBYsuhxhqpEQ7i5LTVZjvnIE
 JrViAbyZgQylZNaBUYdMIk9ovjqsCn/cDynX/wyfz4VFJ9YpBhtruvJOlddR9V8ySak/VL4auzI
 1bIq872DrzgT
X-Received: by 2002:a05:600c:3510:b0:49f:ffdc:939d with SMTP id
 5b1f17b1804b1-4a17b536662mr27384935e9.9.1791298917864; 
 Tue, 06 Oct 2026 08:01:57 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm357622075e9.4.2026.10.06.08.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:01:55 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 06 Oct 2026 17:01:46 +0200
Subject: [PATCH v4 2/5] arm: mediatek: enable SPL fastboot DAs on Genio 510
 and 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-ccaione-upstream-mt8390-da-v4-2-63d7d124780f@baylibre.com>
References: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
In-Reply-To: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>
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

From: Julien Masson <jmasson@baylibre.com>

Genio 510 and 700 need a way to provision blank eMMC and recover from
unusable boot firmware without relying on the installed bootloader. Add
a BootROM-loaded fastboot agent that also prepares the eMMC boot
settings so newly flashed firmware can boot.

U-Boot proper is preferred when the complete agent fits BootROM's SRAM
download area before DRAM initialization. Provide the SPL alternative
for tighter payload budgets, avoiding the space required by BL31 and
U-Boot proper. An external DDR loader is still required.

DA authentication belongs to the BootROM download flow, so provisioning
agents must not require the keys used to sign normal storage images.
Sparse flashing needs a 16 MiB heap to accommodate the writer's 8 MiB
buffer alongside fastboot state.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  4 ++
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           | 61 +++++++++++++++++++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  4 ++
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       | 14 +++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  3 +-
 arch/arm/mach-mediatek/Kconfig                     | 28 +++++++++
 arch/arm/mach-mediatek/Makefile                    |  3 +
 arch/arm/mach-mediatek/download_agent.c            | 70 ++++++++++++++++++++++
 board/mediatek/MAINTAINERS                         | 12 ++--
 common/spl/Kconfig                                 |  2 +-
 configs/mt8370-genio-da-spl-fastboot.config        | 21 +++++++
 configs/mt8370-genio-da.config                     | 12 ++++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
 14 files changed, 229 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 10b9a142f37..2ee7fb1f40c 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -14,3 +14,7 @@
 #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
 #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
 #endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mt8370-genio-da-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
new file mode 100644
index 00000000000..f37ec34b0f0
--- /dev/null
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+/*
+ * Download agents (DAs) run from RAM to provision or recover eMMC.
+ * Both variants expose USB0 as a peripheral and leave unused USB
+ * controllers disabled, independently of the normal boot USB setup.
+ */
+
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-da-binman-u-boot.dtsi"
+
+&ssusb0 {
+	dr_mode = "peripheral";
+};
+
+&ssusb1 {
+	status = "disabled";
+};
+
+&ssusb2 {
+	status = "disabled";
+};
+
+/* Only the SPL fastboot variant needs these USB dependencies in SPL. */
+#ifdef CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+&pericfg_ao {
+	bootph-pre-ram;
+};
+
+&ssusb0 {
+	bootph-pre-ram;
+};
+
+&u3phy0 {
+	bootph-pre-ram;
+};
+
+&u2port0 {
+	bootph-pre-ram;
+};
+
+&usb_default_pins {
+	bootph-pre-ram;
+
+	pins-iddig {
+		bootph-pre-ram;
+	};
+
+	pins-valid {
+		bootph-pre-ram;
+	};
+
+	pins-vbus {
+		bootph-pre-ram;
+	};
+};
+#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 6230b016ca0..4fedbda9b3f 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -14,3 +14,7 @@
 #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
 #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
 #endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mt8370-genio-da-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
new file mode 100644
index 00000000000..eb956c91a80
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&binman {
+	da: da {
+		filename = "da.bin";
+		pad-byte = <0>;
+
+#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+	};
+};
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
index 2dd13d261a0..8c676a6e05e 100644
--- a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
@@ -12,7 +12,8 @@ ddr-loader {
 	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
 };
 
-#ifdef CONFIG_SPL_FIT_SIGNATURE
+/* DA authentication is handled by the BootROM download tooling. */
+#if defined(CONFIG_SPL_FIT_SIGNATURE) && !defined(CONFIG_MTK_BROM_DOWNLOAD_AGENT)
 u-boot-spl {
 	type = "section";
 	size = <CONFIG_SPL_MAX_SIZE>;
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index e572cfe8571..8b2534a19fc 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -249,6 +249,34 @@ config MTK_GENIO_BL31_LOAD_ADDR
 
 endif
 
+config MTK_BROM_DOWNLOAD_AGENT
+	bool
+	depends on TARGET_MT8188 && SPL
+	select BINMAN
+	select MTK_GENIO_IMAGE_CONTRACT
+
+choice
+	prompt "MediaTek BootROM download agent"
+	optional
+	depends on TARGET_MT8188 && SPL && SUPPORT_EMMC_BOOT
+	depends on !MTK_GENIO_BOOT_IMAGES
+	help
+	  Select where to run fastboot after the BootROM downloads the agent
+	  into RAM. Leave this disabled for normal storage boot.
+	  Download agents cannot also build the normal storage-boot images.
+
+config SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT
+	bool "Run download-agent fastboot from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	select MTK_BROM_DOWNLOAD_AGENT
+	select SPL_BOARD_INIT
+	help
+	  Build an SPL which enters USB fastboot after the MediaTek BootROM
+	  downloads it into RAM. The download agent also configures the eMMC
+	  boot partition so that a newly flashed board can boot normally.
+
+endchoice
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..e052fbda73e 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,6 +4,9 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
+ifdef CONFIG_XPL_BUILD
+obj-$(CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT)	+= download_agent.o
+endif
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/download_agent.c b/arch/arm/mach-mediatek/download_agent.c
new file mode 100644
index 00000000000..da17fb4b309
--- /dev/null
+++ b/arch/arm/mach-mediatek/download_agent.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <dm/uclass.h>
+#include <fastboot.h>
+#include <mmc.h>
+#include <spl.h>
+#include <stdio.h>
+#include <linux/errno.h>
+
+static int mtk_mmc_boot_prepare(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	int ret;
+
+	/* No storage loader has run yet, so probe the device here. */
+	ret = uclass_get_device_by_seq(UCLASS_MMC,
+				       CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV), &dev);
+	if (ret) {
+		printf("Cannot load MMC device: %d\n", ret);
+		return ret;
+	}
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	ret = mmc_init(mmc);
+	if (ret) {
+		printf("MMC init failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable BOOT1 and boot acknowledgment for normal BootROM startup. */
+	ret = mmc_set_part_conf(mmc, 1, 1, 0);
+	if (ret)
+		printf("Cannot configure the eMMC boot partition: %d\n", ret);
+
+	/* Reset to x1 SDR, backward-compatible timing for each boot. */
+	ret = mmc_set_boot_bus_width(mmc, 0, 0, 0);
+	if (ret)
+		printf("Cannot configure the eMMC boot bus: %d\n", ret);
+
+	/* This permanently enables the reset pin; it cannot be undone. */
+	if (!mmc->ext_csd[EXT_CSD_RST_N_FUNCTION]) {
+		ret = mmc_set_rst_n_function(mmc, 1);
+		if (ret)
+			printf("Cannot enable the eMMC reset function: %d\n", ret);
+	}
+
+	return 0;
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	ret = mtk_mmc_boot_prepare();
+	if (ret)
+		printf("MMC boot preparation failed: %d\n", ret);
+
+	puts("Waiting for fastboot commands...\n");
+	ret = fastboot_usb_run(0, NULL, 0);
+	if (ret)
+		printf("Fastboot failed: %d\n", ret);
+}
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 20befdba0e2..696b87c1524 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -18,14 +18,12 @@ MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
-F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
-F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
-F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
-F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
-F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
+F:	arch/arm/dts/mt8370*
+F:	arch/arm/dts/mt8390*
+F:	arch/arm/dts/mtk-genio*
 F:	configs/mt8188.config
-F:	configs/mt8370_genio_510_evk_defconfig
-F:	configs/mt8390_genio_700_evk_defconfig
+F:	configs/mt8370*
+F:	configs/mt8390*
 F:	doc/board/mediatek/mt8188-genio-evk.rst
 
 MT8195/MT8395
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4930ecb0861..fb8bbbd2f5c 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -194,7 +194,7 @@ config SPL_SHOW_ERRORS
 config SPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in SPL"
 	depends on SPL_FRAMEWORK && BINMAN
-	default n if MTK_GENIO_BOOT_IMAGES
+	default n if MTK_GENIO_IMAGE_CONTRACT
 	default y
 	help
 	  This enables use of symbols in SPL which refer to other entries in
diff --git a/configs/mt8370-genio-da-spl-fastboot.config b/configs/mt8370-genio-da-spl-fastboot.config
new file mode 100644
index 00000000000..a1c7d8d3d8e
--- /dev/null
+++ b/configs/mt8370-genio-da-spl-fastboot.config
@@ -0,0 +1,21 @@
+#include <configs/mt8370-genio-da.config>
+
+CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT=y
+# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
+# dlmalloc also caps individual SPL allocations at SYS_MALLOC_LEN.
+CONFIG_SYS_MALLOC_LEN=0x1000000
+# Resume from the user-area FIT after fastboot continue.
+CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=y
+CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=0
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_USB_MTU3=y
+CONFIG_SPL_FASTBOOT=y
+CONFIG_SPL_FASTBOOT_REBOOT=y
+CONFIG_SPL_FASTBOOT_FLASH_MMC=y
+CONFIG_SPL_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_SPL_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_SPL_FASTBOOT_MMC_USER_SUPPORT=y
diff --git a/configs/mt8370-genio-da.config b/configs/mt8370-genio-da.config
new file mode 100644
index 00000000000..46cb42b37ba
--- /dev/null
+++ b/configs/mt8370-genio-da.config
@@ -0,0 +1,12 @@
+# USB identity and transfer buffer shared by both download-agent modes.
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_MTU3=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
+CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
+CONFIG_FASTBOOT_BUF_ADDR=0x65000000
+CONFIG_FASTBOOT_BUF_SIZE=0x15000000
diff --git a/configs/mt8370_genio_510_evk_da_spl_defconfig b/configs/mt8370_genio_510_evk_da_spl_defconfig
new file mode 100644
index 00000000000..bb537616b53
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_spl_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8370-genio-da-spl-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_spl_defconfig b/configs/mt8390_genio_700_evk_da_spl_defconfig
new file mode 100644
index 00000000000..7f1ba02c6e7
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_spl_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8370-genio-da-spl-fastboot.config>

-- 
2.56.0

