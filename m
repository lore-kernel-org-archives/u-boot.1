Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3595EC982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 09:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D5FB607DE;
	Wed, 23 Sep 2026 09:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7uBYXcAByNUS; Wed, 23 Sep 2026 09:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B6A91606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790156108;
	b=Cvltu6D2Ue4Rhn17H5HAXS4A6dNcLPFEKeRvpzOVyEl2A0b0uyNfijmrrXilwSZbhvZ2
	 Rv/H2RngY6Zb/85qpz1E6RN8nIajjPEjIrh7Q/yMTIQejGKQvIbY6v/3357ShI1xOdG8x
	 A2nQW86XYE0bZTmkx7zbWgttxW00UJPWv7caz46i38G8jT14+tmupfV/cmr0OuIBXhvlI
	 CwlFqAcCjaLENnwQjMgcs/8ywmx3mbGlvY+S1U6B+0WwUKOmtz86KmfxmSvBznnfljUCa
	 uqxR5OU5BG3R6Y+yOQLqss+m0obEdy6cWhUws1w1lnD/ZPjU3W8AUxsrtZO7Z3wS7cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790156108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9WgpHdJRdQK3IRrTzd/Q+VQ6N8VI4jkfl5z/Mlgz2EA=;
	b=VrkKnlMnpOJ5kqlf4a6nyqtx/IwckzzrbOlxvQpOxIKWFM9fItbk0TCrvFWQ4DWE6OPY
	 MIYfnt2hhxSeE2ENA0+XgXtNCvqEiX+Wo/vG0NcKdJsPUeBzlBfLKqYueeTCPFueDCwoe
	 oxIhFlGI5fE85zwyEdd9BGpuqvFIvZM2+NMPo0jW+c5kjyTr98xTQAlVcxc3M2v5IYi6L
	 4O+F9yQ8Qfzvz1dY44EsrNavHHqy97qNy3A8vWE1e1N4edWpNAmZaM14YJEmcjpL14aXd
	 DchbVswzc0uDUcHLetTAxOM7pJ0WoIiSnZPOkwk/hFP4npH3LMvZnWdNAbU7+/WHf4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790156108;
	bh=9WgpHdJRdQK3IRrTzd/Q+VQ6N8VI4jkfl5z/Mlgz2EA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fIqu0vkHLTqsuA7AqnnFeQULKh2zLlONdU/mqjAYZm426z3zWFy59YKbUaIiV4le
	 or2y2pFARuzn4bx6wq8P7i3y6o6m460TO3DSL34Q7NnhdQgprCEmi+fJmiLq31bc2G
	 ilomLrDBtvkPcGb9PSsze05RHLo9fOcXxvfY90NlkqUb2gh0au9FVbqGbMvnd/6bRe
	 CAq3cxS1gfb9X7zUupeh6lYdCG/Tl48BWBk1PaGQDRse8JZMp20Wf37W26E+JQRDQ2
	 A3fnZI55/5ITODU/SpaJIO0Jsl14H1knB5xlSgPtS7zJarpYPA6f/1E8egeuzIrIto
	 DGutpMgjFnCgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6A91606B6;
	Wed, 23 Sep 2026 09:35:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9333194
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F66B400DB
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TN_jrKNQOHGw for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 09:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0A2F1400D2
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790156106;
 b=S+6EzYmDQIfsN524aC1/PPnH59qlidx82snTtKSBR6YJfLYtzZ93fIfwoWvPVW6vxYeE
 /BEnxPTtBzuDowe6TXVivuZVvZKFrYLmzXro5gO8apmg1MCq8vhCuhgHl/rYFZH9sNJoX
 sVP3ZmPHutStiwhyANt3NNJnHgpZ3GNtItoLm7s/4hSN/KApuRpIaQ7S7vyKGYC5vxNRE
 n+/uXCAr81hx6HKZFBtxRpnP0MIu5o3FNyo/ULwrRH1+U7c/yV0y/Zf3/MH1n9XRsR2x0
 pzx0+CFoEhOHJwIRLU3Vfa9KR7o/3dLj2miykeOC2NGZtUX+UnF844GMswLwo9moEMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790156106;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=9WgpHdJRdQK3IRrTzd/Q+VQ6N8VI4jkfl5z/Mlgz2EA=;
 b=qKtWNFEXHMsr2/qO4uZOoGzDeFZsRxP+wBxZKQMUZwD0ujxLxh60NCQeQTdsRnpV6wqf
 HW+ra7iariRVVkfuVviAt+EOtVaWGAYMPZMTOdGFe1rm6LCOS1/5irLX3IO+LjzQiq0ZY
 7gMkjl5gQQCTl3AxnL78cXfWgQrD3hj0OitaA9MCUBimoG0pQB8rESUquwIoUrcDLcgOs
 SnT0Kya5a43wo0hTcxbGVw8DcbgQE0wBfzb2/HZ9Hx/4Z9X2zPXaaNWw4UIfK1Zs6pfeO
 iAqm/fjh6PARTZ6OSSMkW0w0TOcHDOcD1aWCNyp7hZdWJeQGgc2L24kTw6k1uf5bc6A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bFqeoeQJ; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bFqeoeQJ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A2F1400D2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 09:35:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 836CE601FB;
 Wed, 23 Sep 2026 09:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A541F00893;
 Wed, 23 Sep 2026 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790156102;
 bh=9WgpHdJRdQK3IRrTzd/Q+VQ6N8VI4jkfl5z/Mlgz2EA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bFqeoeQJ5gf5tSEN2GjLR77sbUEUo1GjzPAAfTyMvSj76EyrparHJoF7Q7OXHpMSo
 lmmzFD6NLGrfpu1xsmtUld1T9GeO4FnOSyfYX69zE5jkk3UvZiiQkl0shJVe15TpIT
 HbKsCMXbM6zk59AukUgJN9iKQ8aAJM6JsR8UziyF+AGYxcCSaknyRgOr3bb3pREtLP
 jby9s+KEcFSxTwRbF338lJE2KI5usSwHwAnUcYNuaAnTlr8+DqY0nCx3qsDCaa/r0F
 g4RDDJpKPzJdC3davHMWXtFWZNO0b9Yy4xT+b9O/Fxlre5h+3dBBse3iZ1OJifZSi8
 QNyUPDs/1lTCw==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 23 Sep 2026 09:34:24 +0000
Subject: [PATCH v2 1/8] clk: spacemit: ccu_mix: fix inverted condition in
 ccu_mix_trigger_fc()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-01-k3-clock-reset-support-v2-1-6ec0abb1c7b5@kernel.org>
References: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
In-Reply-To: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=dlan@kernel.org;
 h=from:subject:message-id; bh=6b0z52n/W0GMXn6vksZC3wPCqgn1ZBxSy4MBhqdVo28=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs50my/IKWcGbIb61ywH7j363CgTEw8c3JW66j
 G7iXP4/QseJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarOdJhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1brw//buhRBuis6WZ0Fk93zqkUCzsXQdb40fkoBal1tMjqURug8785UlbFP
 l28Edebi2rLztVH3KD9yN56W5I0PFdIp32B7VRCkMePI4OYNO5iw8Nk48x8cCl/+puoIqLfnd30
 pCdQwD2E1xA1nH3NIFIdZavKIFEZ/zchmB1pRT1OZ1zhVDNX3PUMHZrhu+ZSwSNakXVsTTsi1Cg
 aNnF6t0FIR5nGn/pb3CObmnoDpW6qNUw2mVv0gitQkyWYYkI95q8BoytUQnKfhJVEvuPSPRF2+9
 +6P+m7v7xG6ILwTmHtq9oNZMlr1ICninwTX6n2uzB1E4MnQt2P2IQen+Lp15Mj7RFeJX6z3oUsn
 oi6RvuzEb/qU3NnXkF+ggnmUx+7EfX+g7zlZsQrRVhWglcUJZjJu2hE171UK3h575N4aWKo9+Gx
 SSDJLUNsyT9zAvAtx87kkfmtP+kEp+RZSvkjA+7TDu6B+idMPXq0ZYFR+seoBi93pHEPJsIc02z
 KjZl+J17HdRvcYVjkPL3b8JV6qCD8dUxXfokvazTHARaCUAvPes6xfdjs5oRIKGd/WbYIPg5CCb
 4cAOcBGGE+XtaXeFwzdTjojiqyukhCUFOoKStR4h2iaQFEuKyLo4ZUBmPanQdwvpHTSXvJRgBMD
 tf2gKV6C4vg2kyL4VuU/ESSoha7dCU=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Based on upstream commit:
  54e97360b44b ("clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()")

Fix inverted condition that skips frequency change trigger,
causing kernel panics during cpufreq scaling.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/clk_mix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.c
index a1158512a92..45bf2c72375 100644
--- a/drivers/clk/spacemit/clk_mix.c
+++ b/drivers/clk/spacemit/clk_mix.c
@@ -78,7 +78,7 @@ static int ccu_mix_trigger_fc(struct clk *clk)
 	struct ccu_common *common = clk_to_ccu_common(clk);
 	unsigned int val;
 
-	if (common->reg_fc)
+	if (!common->reg_fc)
 		return 0;
 
 	ccu_update(common, fc, common->mask_fc, common->mask_fc);

-- 
2.55.0

