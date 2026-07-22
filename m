Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6833AC44536
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36B1640AB6;
	Thu, 23 Jul 2026 00:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tm8bDG9D17so; Thu, 23 Jul 2026 00:52:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F38340A36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767958;
	bh=oQauo5a1uNBPLOX8Y6JfjWl2kNMZnEUyjqQRMXtftRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kHJsBuqtFaafPbkl6ZAuRlBh5sZ8nsjIdM6Vsvx1EPLTSN51WB5DsKul7uIEmUorH
	 PsQzdBAuP2xRlDc1eichgY45JCc0yE7D9JrAT2Nc5aVyECMyDNT/qaik3TETJg99vA
	 /WHPK/nAiHuRUYGOOpJQEka46SlOCoWxflFqSxC01r6xpL8bVFVD28ofKM5iNWVVNR
	 V3vkOx2EPkNWVBCwZhYtNFeB5TWU5vP0kmMncS6arzgdhAgTw5vF7zlGkFKLT3/d79
	 YWTn+eXrzP2IO0x3+9pwONJtrxmO4YzCl3axz8vPNrDYJNXi6pia4aa57UK55683Vw
	 Ru82ojU9FQ3ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F38340A36;
	Thu, 23 Jul 2026 00:52:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 658BE390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57A4E4087F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yy3HgXPhcWkN for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 19:01:39 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E8C694087A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8C694087A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8C694087A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:01:38 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E042848BA; Wed, 22 Jul 2026 21:01:36 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B313F83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 21:01:33 +0200 (CEST)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a38e51ae95so4059360eaf.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784746892; x=1785351692;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oQauo5a1uNBPLOX8Y6JfjWl2kNMZnEUyjqQRMXtftRg=;
 b=bdd7yft95JGqYgjoXFX6y3dFf4Ly/Tys6cJ/xzhVFZh94ofXGuUGK73gt/rwHoF6kB
 GdnES2+c1xjg4AdhSYfiRDSo2QMXWe2GWhfQTlehGMs65QddCki2683f087PbcO5cAUU
 R0+jlEUkFvMVupaNkSbEBtu1zl63cRRup9VNps0CWgsde3x4l1RUjjhvl8N8IxXA3c+9
 siWe+MzH6ao3OEfLBmJcw8neUTeA5sZbUM6u/iovbHovxclBa+3o8nED6NIewuLAKxus
 bTviOvzrO6EHqhnS4QjqX6bjI58p9p+YpuZ98j5SkSwithIRiEQClFiLiduyrecP77PL
 xyoA==
X-Gm-Message-State: AOJu0YzUotMlcgP+FPrN8pI/FVQWNEGohQtIqA6sxcvtxygMMozQ9GMS
 6ikk6X8gaAOzhAW/XewXIUN2if0EuNgkKic6gbLgWE6p2Yy678QN3jEBW3bohXVzrnU=
X-Gm-Gg: AR+sD13ntgPdkpJEatyDJ5D/2vnApE+3yO+R0MMwEv61kZocqQgi+V0mp99whMlotXJ
 bW/J5dgfDdSIwjQZx4mAQ4M5uhLi6aHtjkRm/4Au8oPUe/XptkZ+iPEFeCsMoEaijr3QIxgsz7/
 NnVtt6AV9H5fLg8hzLHfCk2dj0BEiamSC4J57QvBjxjnTusxIEMZbpRqoMjNUQxvAs8eQjzG286
 Mbiz+szqWoM+95lLvqnovhPKoIiy0L4m6Bp1njp+AGQ++F9HuKMoFoKdIZpouRYSWlcGx67RTvZ
 1qixqo0McbyXMBPPYnF9eHNS6Aw9MheOi9n7RbVkHwe9oILROr7JNPZU0FuMYymrnlypI8N654+
 TXyQWfW0i6yWEDZDxT4Nx5dHfTAMlQkLLmuGgvzmuXgdyXrbX7JVzCEzFEQl1OCsTuh0SuxhPZ+
 YPm3hOog==
X-Received: by 2002:a05:6820:4b8d:b0:6a3:17b4:7a80 with SMTP id
 006d021491bc7-6a536864c13mr11897063eaf.45.1784746892262; 
 Wed, 22 Jul 2026 12:01:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45766f16dfcsm2652569fac.7.2026.07.22.12.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 12:01:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
References: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
Subject: Re: [PATCH v2 00/14] power: domain: mediatek: refactor driver and
 add MT8188 support
Message-Id: <178474688005.3352940.7743931999082573740.b4-ty@b4>
Date: Wed, 22 Jul 2026 14:01:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=AXmDLRdjodn/zZsDxbDCt52OL3hO0zRwq6M8ssQcGDU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqYRODOOVbv9qZ+wknmN6f5qbR2KmVTSMGmOlUu
 ULEdTDI/qSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamETgxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuKoH/08qz1JX1locEA45Am6crgSWawNR9ylQcN4Oqlo
 E4JY8x2L7Jdbp64q2+z3td39iJbOH0WdbgaRJV4Z9ykDM4ilNFVTF098BBATBf9sRkszSiYUvI0
 mTcKSVjlpTbMBNm6A/mEzfM+u9ukn1gLN8cVZNIZ8kk+ixMLXFJDuyt1qEwr/M7rJwxviE1f7Yq
 j6juCnDTAPrAXiJrDHtUYK5M/egDMYurqMngtpHKhzTm+l7+f2HrrVCuKGCdUz394YLW1wDsdWf
 bef0qUNVj1NucUpsh4AlQTVClDe/vXOvldKKi9evAE3rrubwrTM4L24eSS4f2eD3HsbrUERr0ip
 Velw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784746892; x=1785351692; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oQauo5a1uNBPLOX8Y6JfjWl2kNMZnEUyjqQRMXtftRg=;
 b=T+nVpQLnzZybUrOACpAuU4TMdYNDIyCNxYBTVOeXShekTt4inMBT1oVTrW+uouqHAz
 tr5HlpRnaQAnV479z5mG1PJEbvU4usaTo70KS8PS6RiKOoSUBZOgrEI5fOJx11g21/2L
 upSuBEdWtE2WolhUzqfKBWEJkjRn2DfGvq6yF23nimNRVMUKAdzdAJ0RaC6DBRCIVc5i
 n5icUzVaoyRksj3XYSJaLA4BAd0jbz2+27cZVANtrz6LT//UqiVjav59T+Y/FhR6RXME
 13BcKYFB8QCnZ7mUYhCC2SDD9gLqj8j4s8IqqT9OAjKk3z50Abl+U85p0vzLSgW8XkAE
 VFcA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=T+nVpQLn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="T+nVpQLn"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 09 Jul 2026 14:58:06 +0200, Julien Stephan wrote:
> power: domain: mediatek: refactor driver and add MT8188 support
> 
> This series adds power domain support for the MediaTek MT8188 SoC, used
> by the Genio 510 (mt8370) and Genio 700 (mt8390) EVKs.
> 
> The existing MediaTek scpsys power domain driver is a single file
> driver, that supports MT7622/MT7623/MT7629 SoCs.
> MT8188 is much more complex and adding it to the current driver will
> make it really big and difficult to maintain.
> 
> [...]

Applied to mediatek-for-main, thanks!

[01/14] power: domain: keep Makefile and Kconfig sorted
        commit: 88364c9ebff3f51ad6e547fb4828d16ffb3f9bd6
[02/14] configs: mediatek: drop unused CONFIG_MTK_POWER_DOMAIN
        commit: 76e2f6f221b68e22b36bbac1c2ef5e4986c9dc45
[03/14] power: domain: mediatek: use MT7622 naming instead of MT7629
        commit: 0b4bfb0c97915b9af20ca2911b11b6d4a4bba420
[04/14] power: domain: mediatek: use MT2701 naming instead of MT7623
        commit: bd1621d61a798ecb8a1d8d778acbafb0a9a0a6fa
[05/14] power: domain: mediatek: remove enum scp_domain_type
        commit: 89e39800f5f5b790766a6399c55a2be7ea1e0b3a
[06/14] power: domain: mediatek: prefix internal identifiers with mtk_
        commit: f68a654213bf60c87e7aadca588efb3021c85563
[07/14] power: domain: mediatek: constify scp_domain_data instances
        commit: e4f5c25c430712172a761b1ea9417fe9de055585
[08/14] power: domain: mediatek: split into per-SoC drivers
        commit: 04175690d649a1dd03307cb9163d2570ac86fcb5
[09/14] power: domain: mediatek: wrap domain tables in struct scp_soc_data
        commit: 5543aafa390b956f8098f5093a6bebb547a8a4ef
[10/14] power: domain: mediatek: rename mtk_power_domain_probe to mtk_scpsys_probe
        commit: 0d12605d9794f1526b987aec79e9a5a3ec7b61f4
[11/14] power: domain: mediatek: rename struct mtk_scp_domain to mtk_scpsys
        commit: 7a82edf4c0f42bbbe8e6853d5b150eb3c2a71de0
[12/14] power: domain: mediatek: add support for the power-controller model
        commit: a81e1f8a7cf2aae4304b74b818c8da90bec1c02e
[13/14] power: domain: mediatek: add MT8188 power domain driver
        commit: 6c04714f5523a1495c724818b3e8333bc1ed6901
[14/14] configs: mediatek: enable MT8188 power domain
        commit: d0c49353a648e135f269a2953dc9326505ba87de

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

