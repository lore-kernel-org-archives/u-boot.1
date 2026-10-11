Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42B2CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0F6A606E5;
	Sun, 11 Oct 2026 22:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cy-cSsH0j_np; Sun, 11 Oct 2026 22:31:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F3DA86062A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757884;
	b=gf07eTc/7UmppT+6ZSALW0StjrefKN++T6tuVAvCoqKqYRqrXDgZ1s7wMNsZ+lvDn/2V
	 jOBzTLSK57xt/osAROccX/ya6ZA5pSL2X6jyIHJuJgWOw86kAxQjMK1MsFmYUjOIHNit9
	 hWFxO6V36aPjsG47oORVKKFRXFiOkxtXqlbaUsgLoU5AyzpoVMRtzU9cWAkRhkVR5WY5+
	 VNRIuXBwOayqqme+rmHLH9dmj/ROTeqYYxkF+sLeWfn7ym3MwTSYY4jZTRu9Gr3wtFgFz
	 T3QbR5y7NiN4OZ9q33nGV1Bww74te9Mk5xVw/4k4H/MLCU5VVkAznLQTCx6qfyysZAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eGZgyisT0wwNZPF1VQP9kZSz3y6nArOwjaV+n/MpzIc=;
	b=Asf1QZ1wxLBFmIzNY0bcEm1mmer8NReynmbn7C3GTUAtTB8o4+ootZo4SpVoTaYGM48y
	 8mFH+5k/sOjOu4Nc5UWA08h9293MqEjdu7Es3jH1hvjZk6YcwgUIG54VFg+OY8ygNmKYC
	 hdQXinugBZtDcpb2x8A1f703dNehzt7KBIpA4rmJ7tUxHJMxrwA8iZwSQ7KRsv3t142RW
	 EUVQ4ZlKraQpQPLXdv3geAV/boUokOhe0GjA11eHqRbMW8oOawtXFhQKOL7++i+JrnlFU
	 Hn0O7doWMPIVQUzUWamx+N/PV5Gyuaay6DXCksjBsuXzOvlZ996TCxCAtSYo4femgQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757884;
	bh=eGZgyisT0wwNZPF1VQP9kZSz3y6nArOwjaV+n/MpzIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E/g0ziFcdUL/G+gIj04IHsRDmFb0LGfvlxPzXQh17M7uSiUUoIFJ6hIwVs5SIBE7g
	 Q+dhSTkq7G4M3MzvhYRAmD+hHzKUk06Nd5z68kkZVbCZ+XjQIoK29rY0UlpGn0AZjI
	 8NTBFLQ+aLgxKt3/hoTMV5JTgU/S/HkjXgGPohJ4Cu6bREbAroHco9/HpZSwNt6mkx
	 xGKBKLlOfhR4dJeV/CTJf1yBIg5hjYptpKeL1mZ9PYZiWYLMwFuCETLwtZmcD147sO
	 4QBc0FmjjL/EVAbIkEyozNZzAAYb5OKBckOl58b8SCnH78MCGGEGiHsQbq3Q3OFrYC
	 zhA0eXMRN7NWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3DA86062A;
	Sun, 11 Oct 2026 22:31:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E5C875
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FCB080CA2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yvLqYm-ALyJ9 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 817F480CFE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757880;
 b=q5Om4Cqep/g1Ud/h3NZHrtKpWG6R39qDk3sb8FAE04Xuln8FTWVaAkwxKi+zTNU53WXv
 +03EQNzvFiJR3+DUFhsjn36OwTHGARUaWVTkuD7db8GUS5l+qv0YqtHJrhLzv46n5wDXq
 1ZZhr+Lx+E+xpBS4TBPdSfVgPE9QKDc9tw8ZVO/zTs5Pb42rioS5+AWNkvISoKPscR3Ka
 pXnS0ozU77S32nAwK8DPfP+/93klwdkQm/K8RY6WvB8NXUCnK0j7kK0rdnI8iaTFc/Bm1
 UTBAyvTwQCAiuqcnq0TWHx+60AV06sywHEt9e3M66letyel+7MvlDeGFek1H9qT+6Yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757880;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=eGZgyisT0wwNZPF1VQP9kZSz3y6nArOwjaV+n/MpzIc=;
 b=PbmwHSgwBSOSarddIHX+kwUy4ZNYlBd9cvBJlFPFRu1B+1LlVBMMdsz3lbpWyM7s/bTt
 ecqZimAWw7ZCvZALq3P7wMwn6dLxFkc/6+VtwfKsdopHbVQ0Hb+tq+TbY5BLgPzCdWY5D
 lTC1wmzTjLg8NYA7P4UMgXDp132XiNb13ZEdorSnUt7kPQZ9hMKlCYD49ZL6zWtLfts7C
 /kfsF6bR1nd1+I4AEEL9EW0nnkYSz4H/1HsMDUnben5Q+Vq6UGr09VGQgTx/gMFIKF4ob
 Lvb9v1IXjDnQzZftNpCWgqUfEdsf80P/7Jm1xljPe7cVAM3ZhfAQtX0rW17GV3EEz2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Hh8uvZtt; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Hh8uvZtt
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 817F480CFE
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791757879; bh=eGZgyisT0wwNZPF1VQP9kZSz3y6nArOwjaV+n/MpzIc=;
 b=Hh8uvZttVvFx0foiJzJNkB/222MsSmg21DSPzj2x8CMIr7fJg2N+YMK3Skl2qo+sVXHoNpQuC
 mdMzsXGg9ROtNTerESkziS2R334bv22QzpNARtSofOqaN8KDU/15alIlTKf2SfyEhXpthhyARwm
 ka1Yktu010oghkN9V0CBlupOZh1JbfMCaCfwtgJJfijdnj4Q0GM9jJT70+YxBVxncxi4aaB4t9b
 dmvfyt3STaqLwGUu+f9IpQRaH20oeEf3omLgHfCYfjpdc8Aa1H7wh4mDYcfS6NAUSa91Db7wzFP
 pmss7dgIv0omRMlqnM0pTWlXi1ApEmr/tqT3wCgqdR6g==
X-Forward-Email-ID: 6acc0e374548822a24c175b6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 29/37] clk: rockchip: rk3576: Group LPLL register macro
 with CCI macros
Date: Sun, 11 Oct 2026 22:29:04 +0000
Message-ID: <20261011222930.1085075-30-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011222930.1085075-1-jonas@kwiboo.se>
References: <20261011222930.1085075-1-jonas@kwiboo.se>
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

Move the RK3576_LPLL_CON macro alongside the other CCI CRU register
macros for consistency.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split from "rk3576: Fix trivial clock configuration errors"
---
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index 12257797445e..41e225245843 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -136,6 +136,7 @@ struct pll_rate_table {
 #define RK3576_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x800)
 #define RK3576_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0xa00)
 
+#define RK3576_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE)
 #define RK3576_CCI_CLKSEL_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x300)
 #define RK3576_CCI_CLKGATE_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x800)
 #define RK3576_CCI_SOFTRST_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0xa00)
@@ -143,7 +144,6 @@ struct pll_rate_table {
 #define RK3576_BIGCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x300)
 #define RK3576_BIGCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0x800)
 #define RK3576_BIGCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_BIGCORE_CRU_BASE + 0xa00)
-#define RK3576_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE)
 #define RK3576_LITCORE_CLKSEL_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x300)
 #define RK3576_LITCORE_CLKGATE_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0x800)
 #define RK3576_LITCORE_SOFTRST_CON(x)	((x) * 0x4 + RK3576_LITCORE_CRU_BASE + 0xa00)
-- 
2.55.0

