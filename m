Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04B7CCF2C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:01:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77466814A1;
	Fri, 16 Oct 2026 21:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBjWFBY9uT_0; Fri, 16 Oct 2026 21:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 964D981467
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792184500;
	b=FkEC3zPgHRjB2UMpuIG4xwcbT+wyBZyzb+KFrDY3D1FoNp+gmExkmGB9pXCr2pc6h9bC
	 EM5eW1VMpQQuSTtJ5ECrIbAg8LqNq/Zft+cl8WS7SnNjS3+4o34zgVAz8oMxXoWleQeau
	 s2ZO+t8lRr5q824nELdMa5DgfhagbDOxmJ0kIhrk1pZvUGD9pREuU7B/noaBYq5hxbv8Q
	 pNqmK+6qrl5/Fd1wWjqv+UQVpv55X3rvdnQVA+sNskzoygtevrEnW30OyKeJGXCqJ4SD9
	 HwXAGPX0sGavYG53/JFyPvSY8lL2LqVzCX7u4NmApAgTViPWAuBSCIkyIWguxy2rC3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792184500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=iab4nmXQGy5sfV3Rw4Ca3QF9MDGj2hwb3L9IDlYU488=;
	b=njghluJfs+kLVAj6ZASkDqueM73OHuHUvIqRZGg3/PjK5Z141D1co8nFfGZF4Ch2dmFX
	 NhVcXor+kBBr4upXrhHo3BgAFqXINfy0QI5yVtFKufivNvUeV/ZXg4lqm2hBlosugd1Nn
	 JnUsIf+G9la7PH2PFMFfxgu0dbWmCghxJKBYCfZLzfo0+E5Y924IJiaHNzf41Qy4Ne9xM
	 T82vUtrpNRyQ04CMLQAL+uX6+CXCHyge4plNQE1i+bJ7tGQTKnGD3zI3MO+1lPmR7hcUO
	 A1WnIN53WYO+aEp3sEG+2rHb9UhP6IwsUuI5YsmEQp3yOZfg4Q6O94WTU+xiMkWUTQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792184500;
	bh=iab4nmXQGy5sfV3Rw4Ca3QF9MDGj2hwb3L9IDlYU488=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=06hf5sDaUIbvKxV9u4XMM2PPKLGfyDEX7UAq5La8qV2EqYxNd4y9BvsqcNDC6B2r1
	 OPrtXzGaP6SCsPgMmO1leBl5G75mVoZ8JuEPacq8/pSl4iPQY3lSfV4AQbu4lKWU1e
	 7lq7IDHG2G8nTCFFpcMclvxos766OJb1GEqoAFY4zxL2sEzqGCUoXBRXRwSifFBDPX
	 HOUZacwDzoU2JuqXDzJVFk1admTneG8DmO1NPeXgP3tlbYukSR6B60yy6h2OrExtdo
	 qRuAbHFx3QZ/2YpALTBRzWnE0ACoL5cnVqbqnfEinMmN4pIzbET3OkZ6GecFsX46pE
	 3LGxv3yL/ZgVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 964D981467;
	Fri, 16 Oct 2026 21:01:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F341C75
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E561440B59
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1y7bzf9p6cZJ for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 20:14:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1FD5640A76
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792181645;
 b=UPqsTMM7kn7/X9nXuyxQwnK9guwH5rTSfFW0YjrHwyH8PkHnQLy/jM9kKB0O9A1Qr4js
 Oo0EAeb8qrWRchkoILzspNC/hScdYXjcLl9i9Gjl7Dc5+hAYa5lVjCrN6YEDDZ8nfbCA7
 DHmzBGpIXLwbRB8akgjY/NwWwKdL9Kdpnorm29gsDw6Lzgbaomj3YlZCvIdhUGSNITaD9
 ux7NfDQ+ibsGYA9SZtYesIfNeJ/ApTZPI7v8+K1j3ILmjgMLHDeF2SrfKCgFR3Njuiqqw
 ELxdqMYECo+JDfBpXSiUkMoT4zD60zvJbx0EHhSf2KGBIX7fcyO3fzIClvtxW8xga6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792181645;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=iab4nmXQGy5sfV3Rw4Ca3QF9MDGj2hwb3L9IDlYU488=;
 b=cZzHAIiTRjt7Sr11nGvRmL2Lci1fJ9rmjd9W/iJVyjhH84gEXbZ+xdfke+HpTBGmE+Jb
 EUTvucfKTCna56dXJgr38C1/iiojqsUpIPwXglJaWCC0ccUUcPnabOL30926WF0XneTEy
 i01ZvKzJC7GMTR/yfOgZeQMrVjpvzCGqJCLzr8FXJI296fWc7/qjA/UnpFlA6ql66pP/r
 aa91J+zRLPgdRCJ+It2yoTZkHTp+uVI+ubpqdZ6Znyo0y7D1JfN/trf/ho7657VUA88bP
 qQpOpBz0Uo+IqhITmw+k//t4siSeYTibwlTeOzgNJnTPAiLq943V2x8nt/bhoAD0SBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q9BuEhfi; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q9BuEhfi
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FD5640A76
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 20:14:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A8ABE60A55;
 Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 578D5C2BCF5;
 Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792181642;
 bh=hrtwK3lU8ABH5ZhZcGsal6sAcR5gH+HvHB8ZoRQcDWc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=q9BuEhfi3/AD0guQYyrKQNOEuMy4YpDzgil7BOsTdqj0ohHC5dJQwyPdTmVyNHh0Z
 Y7nUAvXCbdeNaZfrhSIcyh7qgm5vgBS26UfSfp/hyW76M9RjdhxWtEE8Oh7DrHwZ5s
 uywoQC4TPBq2n/NKFeOk1PoIjQyDxNUojV90h9cTh+DkrgOfPlVZVwTzCJAFecz7Tm
 CRA3Fc18gPw8JeepBhsG22G28NNrXBk24Q6kjszjFHtGQY76Oa61n9zCHmpzubp1n6
 bEW8gu/weYw6u1RlB9EsTrHNMat7DWKk+FGyKBLxTG1HvU/bv9HlIGjl+bZV5OOWOC
 z8J98pwCwYLlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 37CCFCCF2C6;
 Fri, 16 Oct 2026 20:14:02 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 16 Oct 2026 22:13:51 +0200
Subject: [PATCH 2/2] clk: qcom: sdm845: add GCC_QUPV3_WRAP0_S4_CLK case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-sdm845-qupv3-s4-v1-2-672e9be21fd2@protonmail.com>
References: <20261016-b4-sdm845-qupv3-s4-v1-0-672e9be21fd2@protonmail.com>
In-Reply-To: <20261016-b4-sdm845-qupv3-s4-v1-0-672e9be21fd2@protonmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org, 
 u-boot-qcom@groups.io
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, David Wronek <david.wronek@mainlining.org>, 
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792181640; l=1943;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=f/ZVYYX99vkm0yr1LN794ymXRles7Exb/TzmXveMDL4=;
 b=P+5kD+RjwjaIz9cEd9kCRMdDgRgeCdB8Wh+ypzPKcWxji5XCSQKsSoHxeNsaXgvVXrVHJF3r2
 PKzrLX2f5NhDVLWIDbPCdqob0A2pOj0/x7Ar2+CfdB2rw/zCrQ6z5sY
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 21:01:33 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

sdm845_clk_set_rate() handles the UART9 and SDCC2 clocks but not the
QUP0 SE4 SPI clock.

Add a GCC_QUPV3_WRAP0_S4_CLK case using the standard wrap0_s0
frequency table.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/clk/qcom/clock-sdm845.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index c9a057cf6f9..b2fb44083bf 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -18,6 +18,7 @@
 
 #include "clock-qcom.h"
 
+#define SE4_SPI_APPS_CMD_RCGR	0x174f4
 #define SE9_UART_APPS_CMD_RCGR	0x18148
 
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf018
@@ -77,7 +78,7 @@ static ulong sdm670_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_SDCC1_APPS_CLK:
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
-				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	default:
 		return 0;
@@ -95,10 +96,15 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, SE9_UART_APPS_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
+	case GCC_QUPV3_WRAP0_S4_CLK: /* QUP0 SE4 SPI */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SE4_SPI_APPS_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
 	case GCC_SDCC2_APPS_CLK:
 		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, SDCC2_APPS_CLK_CMD_RCGR,
-				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
 		return freq->freq;
 	default:
 		return 0;

-- 
2.55.0


