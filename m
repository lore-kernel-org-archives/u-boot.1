Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC287C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72350606D4;
	Mon,  3 Aug 2026 19:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjLYVNi2ifwR; Mon,  3 Aug 2026 19:09:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1D4D6066F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784199;
	bh=S8x4Jhgi7DgPgzKajaHinh08DaXpyoAHacI4VwvSXt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kx7x1h9M4hLwk/xFxURYdueF3bdPUumQwEO9VSBC6/DP3L8DF1wOZ82dHVpTfPJAU
	 9KI9G02V0n7BEE1KaDDfAxW0Q5CeawzIuFVCmovF66kEQu9LTpvFIRgp7ytFOxygri
	 REGWPebEzDqYekpskkhhungPGE+nP6tpeqaHS14+sqkOv0DyZyrzJbMfseM6rPBaPB
	 HggyAMxa81SI/7K1EomCW93i769j7uaGN6r8Op/pC2sadKlEfYn5aHRi0PwVVy12ce
	 mYhG01V8kFPHPgfRBs/ARO8Fp5vdsBEiYi3CrYExhL/nZJf/+1Y3fU6KAP6LtqyQLU
	 Mm9psQUMluMXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1D4D6066F;
	Mon,  3 Aug 2026 19:09:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41C3E296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2807280B23
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7lkE1vQj66T for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:09:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a02:6ea0:d71e::9;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DE5E880B03
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE5E880B03
Received: from smtp.forwardemail.net (smtp.forwardemail.net
 [IPv6:2a02:6ea0:d71e::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE5E880B03
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:09:54 +0000 (UTC)
X-Forward-Email-ID: 6a70e780ae1ce3dd2fb7e55a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/6] rockchip: rk3506: Imply OF_UPSTREAM
Date: Mon,  3 Aug 2026 19:09:39 +0000
Message-ID: <20260803190946.2259514-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803190946.2259514-1-jonas@kwiboo.se>
References: <20260803190946.2259514-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785784194; bh=S8x4Jhgi7DgPgzKajaHinh08DaXpyoAHacI4VwvSXt4=;
 b=GVzWpIiq2gtvW2qhl1/nS7bh7jZupX4HrUuN0g18zdKyBQzDWC1OxWGKouYTp0k1z7rqe3vzm
 m2n01CaLb2FVR4c5RB4/hi9jvofF5kSbD5E0oC8MxYfZtb9AnmxeoT2S/zD8zqpXU94agbi0XYs
 D2qutGbcKpK2Og2MNsvZvjseyay7Tyn6+eNq6H5si6J/xFkd+ql1jb3YedOmaL1O0FDkmguNVSx
 9u+4fiMTg1vYrs3IkL5ZFmIm30mMYA0SD1mltlv4hDG6MDfpa6Kk6NhWWTuSLvH7EZopFfxppb1
 BmQwzeFhMa4KVqzfT36DBz0VcBHgOnZxNzgXQDZ3fVig==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=GVzWpIiq
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

The Rockchip platform typically require new board targets to use
OF_UPSTREAM and board device trees from dts/upstream.

Imply OF_UPSTREAM at SoC level for RK3506.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e7..f60da2f41f24 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -341,6 +341,7 @@ config ROCKCHIP_RK3506
 	imply MISC_INIT_R
 	imply OF_LIBFDT_OVERLAY
 	imply OF_LIVE
+	imply OF_UPSTREAM
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR
-- 
2.54.0

