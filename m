Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD356606A332
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qIdKcswY;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QoorWGi1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AAD14093B;
	Thu, 22 Oct 2026 09:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RwbjBmQeJg74; Thu, 22 Oct 2026 09:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E190D408DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792661191;
	b=XafC8iKiICeD5M701qVuBJYKiRxy9L4hCN2Swmin9P205cQGcv/O2yjucKCX5fA54LGa
	 Felt/2qjaa2agOIps8+71pH9fWYodD8r8jaNgyOPwyn1plIVSPStbk/hMKNgtwL8Q3QSE
	 HMyhuPP2WubiLTdfYnbfr9CEe9OPMjXvFG9IKakO2QEmowz4llvgMP/7VCQAOFQbt2YCA
	 aHMnQlVFRT9vh+SywI2AopeRYrWnacjMlwGKkZYLWATeQxEWHrqYzBSqB8EPj24v63PbC
	 bFZATNff3RkddxmvSPX03djG02nkluvfZXLCrhbWbtsrxk4hIO/+ssn2NpFBegs8Lgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792661191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EQ53Y5+yAUfTNGeuW97ms0/PR/x8Ipjhw+TlLS6Grl0=;
	b=HRK8xf6MsczqCTwDt5+jwYEHfH9i91gEJENfJhid4HqhQsCxFV/ywINecioiV0TAZt8J
	 2H9joSvzmjePjU9YuRYtfL3TNiIirOd81HXZNpO4RDPv4skk/bKNBa+VV7ztXIEvzNObU
	 4Ey9tZbgqqY7lQpktaE0rUgdSXhzof6BRWNC/GxLLGt/v6oBxzShsPaUPus5Dltz2qwQY
	 YD9s3eoT4jQc3cC7/RLN4j8AmPRLO3z9vyUoGpRpHam7AluPlQQG+QcwMn1Jup4gyS8C0
	 geaKd7i1JrDI1mTLNqMKJi91ot+hxzTPgKUE1eRMFlavtXwSJRTq3Y0P8v/YaozlqDA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792661191;
	bh=EQ53Y5+yAUfTNGeuW97ms0/PR/x8Ipjhw+TlLS6Grl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qIdKcswY9EpSpEIjQ+Z2LCn4pZs2TmpbQEvtG/7qpxEnagmPGgKMhSt1TjN+odIEL
	 djxz/WCyrSyD/ASn78tIbZ/OSl5Ya/RwHHpYkxZb/CoyIiLhAoSOmgQIm1PxwQUdda
	 TjjUancuNPa6bXc46zpum7Uz/OwiqtYXba1BvOTTc/Mpuf95KeirFjUp9Ty6BUL4eX
	 cIL3fRBbIMsLg4CWQTpE7dwGheoxtDuH3nGOuvYtUNKsPORWKr1jZ22jFOvwqmNMK7
	 XHVxjwAB2cMuseKLdLNJpr12xO6OuAVB6zw43slG6a9/LgwgWZsR9OX0zXbxlGm2TC
	 KeGSWhio8oJsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E190D408DE;
	Thu, 22 Oct 2026 09:26:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BD32371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59E58401A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mnmhVaSUDaSd for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 09:26:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C374C40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792661186;
 b=md6Q9vSBjbLv9ChQHxpXApwzaPSswFVDJkL+JDBmoSjyH6cDSJQuEsCmT1g6HlQdqBIO
 i4HbtztraYrFhAv4OCrRZtgqcBfhL3spRyNacYO/MBXfdBDqXi+9b7QmcjZRfspppr73S
 KigJrpJr8hJoBxEYX2R9xsIJG+EQh/JWnqdFjGNXgx0n5u507TTpzhBJ+mud89TeedU69
 0cL2NvXTkwnwJ4oskMectAmRvIS2A8OQQwZGslNHXAgXfJ+zeo1abXCy+kGcnDhYXmryn
 32t/h6skVHJ9qPD6qchGN7M8h/VAUSp3W/2o7pmMvK3aMu8F6XgXSSmDmnbs8Fr9BAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792661186;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=EQ53Y5+yAUfTNGeuW97ms0/PR/x8Ipjhw+TlLS6Grl0=;
 b=jTmad8IJEgoEJCpKK5qd50l21uXwjssuxGphgAuKZt9ju9AndMD6ZjY0shCL7hRgckTV
 mhEBe8sxbZem2L9d9DNXjhH1XnZiTN57UUgIpLZMx6b6UGuE99Brk9XiVFCloKuhbLfxV
 hpr1OskVuYQeBx1aIhRpqM+GV5JXIx/QxhZGeQ86YfN78DqLqf1I1XF7bfn2jTtAoAqoQ
 80r1EIcqD3A4C9Z6BoQkaiMhYBkxd2s8swa6tTuWH9zEZBdey6ztFXIFgMguqJZCftXSc
 4qJJgP2x1Z13vEUV2PVOkTWGOGSvbok3o/UYrRYSCAfcJPBB4kTcsEZPja+sU/JanBg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QoorWGi1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QoorWGi1
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C374C40050
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:26:25 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1124008f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792661183; x=1793265983;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EQ53Y5+yAUfTNGeuW97ms0/PR/x8Ipjhw+TlLS6Grl0=;
 b=QoorWGi1oGIjis+jp+Hqasidd4mcQmp+oKNYssoNsQG48PRDFDXscXl4jUnhenPNA5
 ekUq6yCcX87E+2iW/0WDJXVyxueKsRB/rLeFGOnannFnyBWTSeP+yY6xikV0detmYbaE
 7TFOstvk10nSLJzjKfAejjrcEjuCZUAu74lN/dbyXwPussU1qYpNKkuK8rAdwJNM35bE
 +dOkegAV6E3jnD8W8BT027r98T0ci+BrkfbK8LYmE53cuM+rMjFMifOO0jDIY3jfeln4
 hz48gQr6vrIXlSarw3848NoxEOV540E6GQNkl47am8k6yzlBHVDX+4Sj6LPuNzvgY09r
 +0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661183; x=1793265983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EQ53Y5+yAUfTNGeuW97ms0/PR/x8Ipjhw+TlLS6Grl0=;
 b=xyKBGk1w6HGey6is0Qp8DxMan76MIeZUpkfS58qUqlhhZPiSK5W6ZrZM6rzUOcbDjH
 M7tuWrEmAtBUt6wWshbQ1vlWHfWl8eNC+7xBz4Imk/psR4riKKpiMWw3RJls/817wskc
 g7+BdqR+Q6Y/p0ZpOioZa4ghfuXXz5o2LmZCLFCAAUka3747PW3xtb+8FmPbvxDzl/XN
 J42GDLtu/kNhlQRq+8RR07/34kq/MCOFOMowrF991n4VtirInZm0Exw0omq45XwobGnx
 XxHBmWzXo0YM1gUvK9RjomB4ebiJGd/4qJ2P5VM86eaIWiLBDP4AQTgxVFE1o8GlHGCu
 Nqdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTxZw8fI1q4WbRNDN1o+U0x6sNEF3UWVQC/dlnfReRnbrnb5iCyepvVNeilW1R7ZZ01WssC1E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLg7kSa+zumJh6rgy7SX33YS6dLlv7CteIQkiHqD4d1OFRXoLlo
 9Mxdy4EdeVaeTrLEE1PAxOF3Sq9dyf4zJEUB+jhC49X9uMDtImujgOOa4FO7Yq+rKR9GNVBRbSh
 8T6CY
X-Gm-Gg: AYBFou3bYVlplyvLJMRDeeepyG4/MbhBGFyQtVLjQfVq4OPs7WI42hC7qAZOJaCaa3h
 fJTkrWsBcqvToBHw93/lnCJsAL9NXz6lqu3KAKRNsmLppFleFBWLTSZbPYY91dahWKWWoSTeMWW
 mTzDbHvwHmMkfrPSo0E3yxkz1PnIt1VcU8zbz+tWbs/C73sCvEzCmh1aCUB1/WmyNS8xqEE4gru
 0UrDpiHaR7e6eKzOqKn7dlA8qDXgfUXDM9wckFgk+l5T51EWqOWdrCZJ3pEXFIIIbaadyNECqAa
 Kn4cUyBEsKiwL/b78/qQdEI39i8BSHHNAXH8NmkABWsGGmF0Sd3u4NoyXwQwoquY0h3OfDNeRwG
 fjaovgwY2VF7NhbKUIKVoalYqS+7sjcsWmqNsBpHJqQyfqz00fC9quXPCA9nCI1mkOuThyv1Z2r
 yhkkNCeFneQQUNhCDkz7xFEhBE8fibAEjBDMNUguP9l/nvnKYuwvLaB0mz0V7I0SRZlkPphukTm
 nq9dNNzLKL5tmjj0LojjMhUWIBTMVE+xkOR5UZ306eVEOTK8iqmRQXHWgYZ9KCv0OEhdftd09V7
 +1rwTsaa9EbFCZJzqecFGrUl1UnJ1NUhLShkq73Gn1iYMnLUTOXrgUYT8+5S+qpX5GOiUg==
X-Received: by 2002:a05:6000:2612:b0:48b:11df:c496 with SMTP id
 ffacd0b85a97d-48e264e2ee4mr9780699f8f.28.1792661183224; 
 Thu, 22 Oct 2026 02:26:23 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-21-165-229.retail.telecomitalia.it. [79.21.165.229])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583522esm11426793f8f.35.2026.10.22.02.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:26:22 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 11:26:15 +0200
Subject: [PATCH v5 1/4] arm: mediatek: enable SPL fastboot DAs on Genio 510
 and 700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-mt8390-da-v5-1-58982fe11312@baylibre.com>
References: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 arch/arm/mach-mediatek/Makefile                    |  1 +
 arch/arm/mach-mediatek/download_agent.c            | 70 ++++++++++++++++++++++
 board/mediatek/MAINTAINERS                         | 12 ++--
 common/spl/Kconfig                                 |  2 +-
 configs/mt8370-genio-da-spl-fastboot.config        | 21 +++++++
 configs/mt8370-genio-da.config                     | 12 ++++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
 14 files changed, 227 insertions(+), 9 deletions(-)

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
index 35f748a70d6..4139e9cf11f 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
+obj-$(CONFIG_$(PHASE_)MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) += download_agent.o
 
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

