Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F1ACA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4249F6080A;
	Thu,  1 Oct 2026 20:51:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycVI1uZK99HB; Thu,  1 Oct 2026 20:51:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 844F1607F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887908;
	b=gy4WDG/1IkeAMWhW+EZqlQoVYAWCx8Vzy5mtbVWB70pHN2bgHyyw00I+B3f5nx9UWh8X
	 nwMpvbfrQvgTJlutKCeV7xak9bMTzUemCgy4USHf8PbO8Bd8tDxz3hz5eIKdNVhpACTIX
	 QVhD86H8EleVw4pNXKKzjSQW0L0vOkx1YaknvnIDHCEvdixrudKD1aP0MCzDKZM8oigYX
	 y3HbIGrKi7XsgfZQxI3qK4qynFtBEqoQMFtmrrQ9l/RmxTDNgQyicvKgVTElgWJPbAKMi
	 Mf+LtH56VDAAzn2y4E3u23CjKNsaI40axC1mQi8yHJo6oczcWrE1lq3KjtGozbqxAAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NrIgwFXcgNy8qej8JztaU0D3VzDephfzIM9V31gWw+Y=;
	b=CLeSc/clIrQeFXd966IHMuC64UO/qFzMTBWDGGDDJ/tSM68dhwsfLpGXYng4adxYx+b/
	 UggfGH9vVHlekYdnV0pxmOL2yUIRlOG2i0v69XzXkfO3nOOQ0ACWBsoKxKn5SRUgtWLEK
	 qaKGaogXuLcarSwXacpFUJ9kZYNUnbnB1gj7VaTWBX+HrBTlsjejNc4odjcRLKpdEqjUN
	 Sd1V1Ksgoa+oTq8C4FSPfyt3X988glLsTtYz65hzFjxRO36X34/Nyjt/PiTIGibmuXiuE
	 9wXAVktOLTE+iJBT/mwwR6EHp/OkQe1TKZ3UBQ53F4HzsrUKIGvP9XZMJWz7PVaeOjg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=puxa0SVQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887908;
	bh=NrIgwFXcgNy8qej8JztaU0D3VzDephfzIM9V31gWw+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l10i5RF94ceMtxYXP0qcKFvxxUbKcGwwH4E3+ZMAJG8In7pSni+RtVaohDSaSlznq
	 mqg0Ll9wgldNLJKgboq4Uk5ybIQyz9xoRYRieQK8ffTxM58acL3HmJjsJZlx5Fog9Y
	 9WkPHycPjZuJKaiInGZrWoT+UUGqRQA/kISCRZ52uPmnT2LprjPWAh6r8ccY7/OkIv
	 UQLQIgoPniCCpVNtCxwWsCjSVqLRgjNSgcoeQ9sRgWIuE6ms5mynCnQR5a/YHMCYVd
	 HJwUv+l8TseSO5BkGx7y5uZ/25s1kxQwUD9WhvmUXevmgI5mSEOzC63fapUi1UvNgy
	 sNaYD7gwyIfBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 844F1607F8;
	Thu,  1 Oct 2026 20:51:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78C50282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E872607F8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id borHiyk02NsF for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:51:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ABFE1607E3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887906;
 b=l6meF/9b64uhju8ny9LyWwlmm4Ofha3dJLPsywnZIn72Axr7PTYAwo4gKrrTSl6Bo3rr
 WBRJn5S6uRKeURwU7p0ch7GvHk7JSyjjFerVPmDjGY0MMAbMeul7o/srn0NdzYxcM46/3
 rkzAtdjMzdWHrpulOS30XbcLOZjDq2Lcccec+aC8WYVzw9OmxAsZTBRPQ5QIfOGQszFo9
 /RW8m/DUG29vYV5eI6xSlGRy7KtnIHmpqgBJLQNskC2522OqeP42VxFQTzzfRNUL0M0EQ
 FBt1mrhePwyPKXD04GnjdKedb93g5xJfBgQdO1TjvXE/QRLjaKUbDk+D0DZ5LEika+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887906;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NrIgwFXcgNy8qej8JztaU0D3VzDephfzIM9V31gWw+Y=;
 b=DAWiSZMH4OIJLvWC9KR3T0i3F8bkw967EOixtSLBz7PgCMxiOxGgbtqR/Tj78dIVaBqu
 7pFpv4iybA6pgfuzSu0IDBm/mck2UZmGgFiIjSfp9h01ht6WkUJt4FeF2ANdeWRK6noF6
 ioQ3pt/K09i6tsaRvK5FFMYRI42ixrghIuy/JxS/IWae72NsRtVGKK2aTSNX7JMINPhdj
 mg3YbNySJMzctey37kVnD70Hp/t3uQe7Tq/yYvAKW0CECe5CP+T2A5tVfXf4m/lWW573I
 JMqEBMb1N4WHT+wx4B93lVGgNau97oRF7Yf8Er3Oz7gUmpSN7rP/wX9nTVJsq+Bl14w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=puxa0SVQ; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=puxa0SVQ
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABFE1607E3
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 83C2FB00563;
 Thu,  1 Oct 2026 22:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887905;
 bh=mrFw6n997vBbHy5N45+v2aooTNDleRTMq3ruLKXnDos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=puxa0SVQwepSm3wstFhwCV0ngldvn6u3p0lalGZw9zREq7rveGatYDynhEZIbsrUz
 GTeJNVNG7eH4m77Z5KnNFP7dyYSj6gP/d5Dqxu3HnMwDChJ6Pq1vHuDhoAqTDjHhIf
 3JisaY3H4mLXzpPTG5WSoMj9PpBRyaPLtNpDjjEAMbNYdMKFVjYkLFxRW1OKnnPKbi
 x0WfDPrHTSIyTN3gqa1gTSnbeWo9RnkHDA6dssbYz+XR/dAIusmZ+NsWVgXJcYaqLm
 7ObZM71EvMy0ZKrzMfivvv3m1l0bgOomW/CF8fvwF9Ko+d+xPVpoTnpbh7i2DDerIy
 3996R+wFZIwgw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 11/13] board: lx2160a: serdes: add serdes1:100g4x10g
Date: Thu,  1 Oct 2026 22:47:28 +0200
Message-ID: <20261001204731.1774613-12-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204731.1774613-1-vjardin@free.fr>
References: <20261001204731.1774613-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add the SD1 mode that keeps dpmac.2 as 100GE on LNA-LND and makes
LNE-LNH four XFI ports, dpmac.3-6.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v4)

Changes in v4:
- Was on v3 with 4/5, now let's add an entry of the mode table

 board/nxp/lx2160a/serdes_split.c | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 479e4789eaf..ea7a745c31b 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -630,6 +630,55 @@ static int sd1_enter_40g4x10g(unsigned long base)
 	return err ? err : ret;
 }
 
+/*
+ * 1x100GE + 4x10G: dpmac.2 stays 100GE on LNA-LND at 25.78125 Gbaud on PLLF,
+ * and LNE-LNH become four XFI ports, dpmac.3-6, at 10.3125 Gbaud on PLLS.
+ *
+ * Note: it is the only mode that runs SD1 on both PLLs Slow and Fast !
+ */
+#define M100G_PCCE		SPLIT_PCCE	/* E100Gb kept (lanes 0-3) */
+
+static bool sd1_is_100g4x10g(unsigned long base)
+{
+	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
+	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
+
+	return PCCE_E100GB_CFG(pcce) != 0 && PCCE_E100GA_CFG(pcce) == 0 &&
+	       (pccc & 0xffff) == 0x9999;
+}
+
+static int sd1_enter_100g4x10g(unsigned long base)
+{
+	unsigned long lanes = SD1_LNE_LNH;
+	int m, keep, ret, err;
+
+	keep = sd1_port_master(base, SD1_LNA_LND);
+	if (keep < 0)
+		return -EINVAL;
+
+	ret = sd1_plls_up(base);
+	if (ret)
+		return ret;
+
+	/* Halt only the port that moves. */
+	ret = sd1_halt_port(base, lanes);
+	if (ret == -EINVAL)
+		return ret;
+
+	for_each_set_bit(m, &lanes, SRDS_LANES) {
+		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), XFI_GCR0);
+		out_le32((void __iomem *)SRDS_LNmTGCR0(base, m), SLOW_LANE_GCR);
+		out_le32((void __iomem *)SRDS_LNmRGCR0(base, m), SLOW_LANE_GCR);
+	}
+
+	out_le32((void __iomem *)SRDS_PCCE(base), M100G_PCCE);
+	out_le32((void __iomem *)SRDS_PCCC(base), XFI_PCCC);
+
+	err = sd1_reset_both(base, keep);
+
+	return err ? err : ret;
+}
+
 static const struct sd1_mode sd1_modes[] = {
 	{
 		.name = "2x100g",
@@ -657,6 +706,13 @@ static const struct sd1_mode sd1_modes[] = {
 		.is_active = sd1_is_40g4x10g,
 		.enter = sd1_enter_40g4x10g,
 	},
+	{
+		.name = "100g4x10g",
+		.desc = "1x 100GE + 4x 10G",
+		.from = "2x100g",
+		.is_active = sd1_is_100g4x10g,
+		.enter = sd1_enter_100g4x10g,
+	},
 };
 
 static const struct sd1_mode *sd1_mode_find(const char *name, size_t len)
-- 
2.43.0

