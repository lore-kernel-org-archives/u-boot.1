Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB1606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mQG4+ADR;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=HL5NmpxI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BEFF40A23;
	Sat, 21 Nov 2026 12:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VPNxB7fA0XTl; Sat, 21 Nov 2026 12:35:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B288640A7F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264512;
	b=jfAaixAnkkMeORELzE6j24yiv2TwoFfWkhXXDUrBNq11pV/UU2qHbEsrQr7QkmVD1IYg
	 r6QIO/13VJm8Fas2ulQdlV2JdlckCp2Hd9wK0MT/LCpNcthMkgOJYgQaBt/o91nzL3Ud4
	 JK1U8skK0EcUKT9PBweJ6Epija/kA/OJ6mkQvNCQnhC8Qkzoe5yosN1zV00yOK3hJulJB
	 d28bh4p9XXlBTkAbxou2pUEo30E7VR/f1EGGUc0s0jOTJKFSMPFnNut5OWe7RKc0F+f9W
	 uYkwaGWZsWTpnsOxAKXKIvTlX9JmdDu3jvmuOqE1Yn29K5Cix8kmeCq8hu2UQs8tazA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264512;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qLISP+/iq6kAnrc9D4/TphEpOmCIgBsQUO47DNu6QdE=;
	b=eeBr5+dk1yKG7D1lur5RbnyEwbyQ+R68RvpwY2JsrOtOlz1H4bPRI0GeglBcBeFNiSBP
	 yU97K8CTW9PEIqlBD3pyLnYorrplKuRDVdQmnI6IgbLWkD7I6qO6HTcGGkMKP0hjUPAIB
	 5kuC94syvGrbVsva7vi1WkdeT1j5xUMCZ6MKCrtxPfoDei8AInEDznaQDBaFw0kTOomz/
	 f6Oq8fb+xUTfkYzLk4G5kFZR5jRJmDupyjvXAal/42N+BLbzx/k9JcE2HhWyLtRuB3fyV
	 KOYy+aBnDPYIsz/a8vYGRT/XuBHDEcVr3wnzufwiGD0a9chGMO17pVIyadSWd/A7MHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264512;
	bh=qLISP+/iq6kAnrc9D4/TphEpOmCIgBsQUO47DNu6QdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQG4+ADRGkU1YHYHvXFYikn900dfrDoQmSttfEO//o6dT6wHo9r7vnVAajJpRacog
	 rPdU7tsmYsC24QB+HNilR4HA4xfSE10CU69NAH0dp3TEJL1afqsY+nVQ0Q2YIHIaJJ
	 1cWYfb7hK9bCMW7sze1tltLB3AicN27saBxMNcZ8gH4hCYOJI/FwOIGjjgCBsJGyBQ
	 +aqgAYtE5IjhsM95ufDttTXFDcD67IHkpUQFAdbAsvuNDAgpk+QFjYClHFvGxvJGEO
	 L4vAT9cFX31Umh9LNzwB2CG6ABtdG8ARiW4oYEX2Bllx5ndg9pRUSPo1R5wgpLVOs2
	 nK13/vJ4hnq/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B288640A7F;
	Sat, 21 Nov 2026 12:35:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C176D759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3A1640070
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gV4fISdv4I3p for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A5DC840012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=HL5NmpxI
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5DC840012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:06 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so1532188f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264504; x=1795869304;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qLISP+/iq6kAnrc9D4/TphEpOmCIgBsQUO47DNu6QdE=;
 b=HL5NmpxI0WQIHJJYmZYjth4SI6PrAC7/y4IBpOcViWGGU3mLDqDsvBPKKuy0WKiwLS
 NXwzhpM9+sf9M0SDKV7hY0OjIbGAFH8a0YA/uO12Wq2KHXpQMgXKPbrk/J+Gheo8+/BV
 oDxe2Qzv1U0XllyjeehP0uTdVbIWf3E/3FNZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264504; x=1795869304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qLISP+/iq6kAnrc9D4/TphEpOmCIgBsQUO47DNu6QdE=;
 b=TuNHyYaIR0Mme1UMOK331bFYV5e7yCtUGvUMvrsg+y7AnLYlWBKt5LVf2T6V6IUBJM
 Ia6ntPl37STHUut7j1LejAQ46tyQgfQONFKuis4d/e9vWDc/Fl83yaG9lTuGltGajxII
 +wW9wxFC9/SQTz/gJ9BSMK91DHmpxb1JI9UMolUNvg3k9ATo87JpgLdsohZLcnDZoNvT
 o4tA5Xnivtv6LOMXHQ1yDoFxuuxP/cOp43396dLXUSS8zc9VwIB0QD83I6pHeXkgab9i
 yUR377dN1yPl25yy0v5Nb7t/73nbDwSJiPvPgUcWqBytpc9hXuyp5QYhufWL1lS3aHuH
 QHWw==
X-Gm-Message-State: APuU4Z9Rm4Ikwmk/E3OlljC+yqXNlvZ/mDJLebcdrNibNmB+WFPnJd4C
 8OBxkh7gKCSRCVsklcM37mzws9x1P+L9ZjkallB/nBYTN5Duz1DQswhCAg/oUWJltU8m6hfmWes
 GgRNA
X-Gm-Gg: AZFdTZdI5egkessPoKrifh5lM9AG6zfJDX1cod931uWZGLY9vXy1yIfCh9J/AMDFyj7
 XWbFTk8GOi9x54WzHmHFbS0YW3yR7A0Gs7tqF0f4ih2QsO5KYMBcjeREJz04OaLfhkS/0Atp5E6
 Ts9p/60nyvQ13yrVYHpdosSMTxZMDcLhRqtXWMstFLWXDeZdLuvaeDDO2mAntFuqhs1dbuMw617
 pa605205r11ognawJL+/CGF3Fo/A/TsaufOil4wASXtkPl+wvUEpsGsP2x6RT7aoZwB7VXJEk2L
 cvrWNWTgu5tJ5I3l73LL42XCJQWNzYKBX5p4WU7RBbxtQo8u0DtnQvd8Vo1YoM38fLSUHc8S6z/
 GKj3qWI/ad+uw49RwqhUX0MSLZgsTuS8TzIG/59xI8ZkIVBVXFwOxiRA71LhmWO/0yQjBTecvMy
 C2sNFADzHAeMkpI94kUjPP/+ALcejLl5I0a92pK834sg0y3tGD0YAWx23diRpPKAshxx+EvXfJz
 dRJprlBQkTVhB1bN5YdS6XPt+LyXluv2gw1TiAM2T1jM9pUJnmNbGMg+bOeC9692iVqAe3OUI+0
 FBYtijXjaw1KmfHe+7Iyx9hPoNfvjzQdfes+OrtKHTJx4ts/kcTJjx2Mbxf51Z/kjFGSL0MvmuE
 5HKbuYM93J43mGUKoTEoDI6oq1eB/JZT6v+Toc4I4xLasKDgOTL50ZlRmKA7nbf9QHjMngn82uc
 wOqGfdf+0Bnp8Dxs8RwcmwFtXTY2Y=
X-Received: by 2002:a5d:6f07:0:b0:4af:7577:65c0 with SMTP id
 ffacd0b85a97d-4af75776767mr2475102f8f.5.1795264504320; 
 Sat, 21 Nov 2026 04:35:04 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:03 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/25] clk: implement CLK_OPS_PARENT_ENABLE and
 CLK_SET_RATE_UNGATE
Date: Sat, 21 Nov 2026 13:33:54 +0100
Message-ID: <20261121123451.2471185-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Michael Trimarchi <michael@amarulasolutions.com>

In Linux, CLK_OPS_PARENT_ENABLE marks the clocks whose parents must be
running while they are reparented or their rate is changed, such as the
i.MX8M composite clocks, and CLK_SET_RATE_UNGATE the clocks which must
be enabled while their rate is changed.

Support both flags in clk_set_rate() and clk_set_parent(), reading them
from the private clock like the other CCF flags.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Rebase on top of the parent enabling now done by clk_set_parent()
- Read the flags from the private clock
- Add CLK_SET_RATE_UNGATE support
- Treat an error pointer returned by clk_get_parent() as no parent
- Reword subject and commit message

 drivers/clk/clk-uclass.c | 49 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index c503f6733907..4f7830a5c9c8 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -598,7 +598,9 @@ static void clk_clean_rate_cache(struct clk *clk)
 ulong clk_set_rate(struct clk *clk, ulong rate)
 {
 	const struct clk_ops *ops;
+	struct clk *pclk = NULL;
 	struct clk *clkp;
+	ulong ret;
 
 	debug("%s(clk=%p, rate=%lu)\n", __func__, clk, rate);
 	if (!clk_valid(clk))
@@ -625,13 +627,42 @@ ulong clk_set_rate(struct clk *clk, ulong rate)
 	/* Clean up cached rates for us and all child clocks */
 	clk_clean_rate_cache(clkp);
 
-	return ops->set_rate(clk, rate);
+	if (clkp->flags & CLK_SET_RATE_UNGATE) {
+		ret = clk_enable(clk);
+		if (ret)
+			return ret;
+	}
+
+	if (clkp->flags & CLK_OPS_PARENT_ENABLE) {
+		pclk = clk_get_parent(clk);
+		if (IS_ERR(pclk))
+			pclk = NULL;
+
+		if (pclk) {
+			ret = clk_enable(pclk);
+			if (ret)
+				goto out;
+		}
+	}
+
+	ret = ops->set_rate(clk, rate);
+
+	if (pclk)
+		clk_disable(pclk);
+
+out:
+	if (clkp->flags & CLK_SET_RATE_UNGATE)
+		clk_disable(clk);
+
+	return ret;
 }
 
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	const struct clk_ops *ops;
 	struct clk *old_parent = NULL;
+	struct clk *clkp;
+	bool parents_enable;
 	int ret;
 
 	debug("%s(clk=%p, parent=%p)\n", __func__, clk, parent);
@@ -642,6 +673,9 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!ops->set_parent)
 		return -ENOSYS;
 
+	clk_get_priv(clk, &clkp);
+	parents_enable = clkp->flags & CLK_OPS_PARENT_ENABLE;
+
 	if (CONFIG_IS_ENABLED(CLK_CCF)) {
 		old_parent = clk_get_parent(clk);
 		if (IS_ERR(old_parent))
@@ -656,10 +690,23 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 		}
 	}
 
+	/* Both the old and the new parent must be running while switching */
+	if (parents_enable) {
+		if (old_parent)
+			clk_enable(old_parent);
+		clk_enable(parent);
+	}
+
 	ret = ops->set_parent(clk, parent);
 	if (!ret && CONFIG_IS_ENABLED(CLK_CCF))
 		ret = device_reparent(clk->dev, parent->dev);
 
+	if (parents_enable) {
+		clk_disable(parent);
+		if (old_parent)
+			clk_disable(old_parent);
+	}
+
 	if (ret) {
 		if (clk->enable_count)
 			clk_disable(parent);
-- 
2.43.0

