Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB23CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67B9C80BCE;
	Mon, 28 Sep 2026 18:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKo95WsTakMt; Mon, 28 Sep 2026 18:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A5E3480B9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790621688;
	b=bUV9wscO3rLf2Q1o6M9z1gwyJKvFTmCgZNyfPI14pT+epRE8fRp1ZSmP0JK3IcfTORC0
	 RSSk4VkOqvmXp+vv+6HudBOWT17N+38fgxzvq7H7RpaDw0A4vgVuP/Wv04+3VKLVAH2Fr
	 TJxptUZm+5jIeRYC1x+DtiR1O65VuabbEBnonWADe0A/gMvn5PsTi5kenrIhRPHx9W6Ho
	 QRYlSmt0mA/8JzCkUDac1CGNaNcV/uowZGbn+nJurJtlr+Vww1xkPf0Bbxh7/orobUbkF
	 jSOft/vxRQ2SPsJMgLSWjkOrquHyJYJWlpnZaNRW0efihytqQjUZMWKi19+NSD+1Z1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790621688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w2CQHpPSwV8eCYFylmavgLWt9JMTgA5ExVwH0aS55Hg=;
	b=jKo+EfmB8+Hff4OdZyJ3PUATvVi/DUtSqd++ChUzHQ8JZlpv9B16h5euYlR8v5yGHl2W
	 0chE0Ljx0gijbDVcg2irgqFhFn78TjaTCPvAVdtPXE8ah9qeCxUKPBPGJrZVjp95MNOmK
	 mlT1MQWUgcEiO3ioh2ohM9zLvsKYRmCSv3TRbEiOo7H2myHLzz4ZzZDqJAEgKlU4wGg1o
	 jI3aXJU8cnymIayCqk+3qJ1ZAEgip2s2CRz8beLyXZamCPcvZUGAKPwFoIlnLn4eLPgsl
	 2Oqp1msLSJagSS6jboYq0eKKaL2aufZmo/sBymaOXG7IT0OUjN/q7kKV8zXBbsSloWQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=K9y54A9K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790621688;
	bh=w2CQHpPSwV8eCYFylmavgLWt9JMTgA5ExVwH0aS55Hg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oraw2lt3sVRkezs2WD210DJwxGtSZUFBddIPP/qMsi1o6IPBrwwZsnrGHHquV4eDZ
	 gSLUMn5AHzifQGRns51hKrfG4eZ9xAGnUnoVCR8bpSh7zfqrmNuljd8g7Pu/3tASsw
	 svw/lKeLPmQe6e3KS8NIxsChMMgmG7enAdhaquqYgsxaWxY9kDZ6fGJDsVw0/GVqnq
	 NjZ5V2IoCVTpgQlJeZpl2M9j+/jqpYaM2L8Y3VK9i7P/60BQha88L59S5B9QdYbTTr
	 q4D9cVp3E4xsOayIprLFO5Q20wFZHcYksYoMapm95KHIXTKJqoACXB+wIDZ52QdHIA
	 QP3thAQV9W+Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5E3480B9D;
	Mon, 28 Sep 2026 18:54:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B04743A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EB2D80AE3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIJmcn7JQfQ7 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:54:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D107B80B56
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790621687;
 b=dDUQNBOy9P7pUN3kcNAiGN9jaiSVtLxLkdRJ8nF6fPQgvpThPqTjmwI5FXNkU+aHn3l8
 HeHNGA0Nmyj2BWWIUUokm+RL1vJ26JT7e58Rgh8INwGHeRfvdkyOiBFrrR8zQzyKwiEuX
 IyvQuI3oMbTv6lM3stL3HtvzMEUgpwJpZ5529JeyZmXZfzakJ3mrgGdFIVrd4XnTHYb+9
 QYJr1eC4f/3HhpWJ72cwVV/87TWFkQbMYFQc9nfE77cAD/KCtRkKyhfCxakTAzp7gV9dm
 loazgdVXvEFHhnry3z89oCm6W5fjV8JrtgxRpfwghVODT/Id050flbqmnAqheETVaWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790621687;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID;
 bh=w2CQHpPSwV8eCYFylmavgLWt9JMTgA5ExVwH0aS55Hg=;
 b=JbSSbmGjO11FTnyMzj2CZp5rK5fQlmNv6wF6Uf15UyH4XoYNaYTjmCw0xA9pQo6YvttS
 5pi+oFiSGgeGiEGvj9UGBRPBobePhW3YG9KUZz6hhWbM/DIFCvHZFY4KSWmQTFFk/JLQe
 P4PjZyPaZw96/hmR+IV9eapErB6okXNZm6rOM1xbQLS5WgwTfR06PAJLx8YBr5ESs4kfg
 NJXfIhk40d8+hCeRO+3efq2QvRRulmOXF6+hqWGoJV4MQdt3r9Dae7bFKxS/5EKQHX7Dh
 5hdHDfHNniRWdV6oNyy5gZj10c5miquvzinalcjCloWyRZDrNjqWFwXkAW6kM/XreuA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=K9y54A9K; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=K9y54A9K
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D107B80B56
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:54:46 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4htr8M0HhSzMlsn;
 Mon, 28 Sep 2026 20:54:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790621683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=w2CQHpPSwV8eCYFylmavgLWt9JMTgA5ExVwH0aS55Hg=;
 b=K9y54A9KICF7kAHw6kwlSIV9iZi3mSMedG7pdTNIkStXDi9lGnYfLqDKekvBVGhg28gMJH
 O8b8c0LToXNgDTi4ZyKGWOtejwn4+PJwRm51L7cBjXOxkWBgYOPZB9fJ+EBaf3YvKs5tT0
 ixdoS75znm0QwRZSNNY+GHO+P2uFaRcWN+GLmgyANHBrsQPEbpPRmU+Lx+DvlWj8vOR7kN
 BP7RM8TfpLA//UkoiaEMnVDZlB0nSrxMMaZCbR9asQd/fyJaWpHC8qZGDV9GCtyWU24MZb
 g+ry1ENVoz4ujfGUwUat2qg7h3ZXJCivdzLRoRbZmgSrIM574TKm2ACqj8i+jw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] power: domain: renesas-r8a78000: Add SDK SCP 4.37 map
Date: Mon, 28 Sep 2026 20:54:30 +0200
Message-ID: <20260928185440.113788-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5rdhmx8myiatebgrjztaz4nteptche4y
X-MBO-RS-ID: daa2c8abb24ec116076
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

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.37.
Add SDK SCP 4.37 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/power/domain/renesas-r8a78000-power-domain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/domain/renesas-r8a78000-power-domain.c b/drivers/power/domain/renesas-r8a78000-power-domain.c
index 62b56fd8ae0..9b3205345a1 100644
--- a/drivers/power/domain/renesas-r8a78000-power-domain.c
+++ b/drivers/power/domain/renesas-r8a78000-power-domain.c
@@ -167,6 +167,7 @@ struct rst_map_in {
 #define GEN5_SCMI_SDK_4_31		0x010d0000
 #define GEN5_SCMI_SDK_4_32		0x010e0000
 #define GEN5_SCMI_SDK_4_36		0x01100000
+#define GEN5_SCMI_SDK_4_37		0x01120000
 
 static const struct rst_map_in gen5_rst_map_dt_sdk_4_28[] = {
 	{ SCP_RESET_DOMAIN_ID_UFS0, 202 },
@@ -222,7 +223,8 @@ static int gen5_reset_of_xlate(struct reset_ctl *reset_ctl,
 		map_size = ARRAY_SIZE(gen5_rst_map_dt_sdk_4_28);
 	} else if (priv->basever == GEN5_SCMI_SDK_4_31 ||
 		   priv->basever == GEN5_SCMI_SDK_4_32 ||
-		   priv->basever == GEN5_SCMI_SDK_4_36) {
+		   priv->basever == GEN5_SCMI_SDK_4_36 ||
+		   priv->basever == GEN5_SCMI_SDK_4_37) {
 		map = gen5_rst_map_dt_sdk_4_31;
 		map_size = ARRAY_SIZE(gen5_rst_map_dt_sdk_4_31);
 	} else {
-- 
2.53.0

