Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C6606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VSTs+9Xg;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=X63ALfQY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5054407FF;
	Wed, 11 Nov 2026 23:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rkPqeW8Hbayi; Wed, 11 Nov 2026 23:13:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DCFB40884
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438802;
	b=fhl3u778tZQFizIPBgxnhq8hruUxL4EN57rVFfIIJG/am+8rcNNKrnE/rgcz30KCPNEY
	 tvQAX4mzH07JqJIQtSOe8FRnn28vVmZUJCVbpyU1n/0iy/mk2rnsYPgqXANApR0gLg++C
	 ZrWkfNCN+uyFSsfym4pSn+aXIqwEoLvmW3qip0pN+mK2+8joX5kdM0IwWvQ3J6UdiTy5M
	 y5EItAzQOI2lM/So6hwA56i8NqGQIceH22/YbSnUS6ALM0VQzACspMcsoMoNQIVbfonrK
	 Vjr6YE7EoiCgxQDlPymr1OlgGN2uTbOjnWqjMVYZWtlJNcj5/1ZDtV3F9y9xLITkbhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438802;
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
	bh=9IlsS9W4Q/gpn2QbrVMSegHpBB1fIoGy5DlnixYJtFA=;
	b=UoD2XusAhAtgUWys0KXVagVbGtWdgFS4giO6wBYLDeu1zT3GUIKQx1qJKqB8Kg1Wijxj
	 q5VE8eg31nOUKjrBXv9X0BxOwevadTsgBAdelBCVu1sZJNB1wpvu0Zq1Uvc3lZbkrupor
	 uXTTOfw0rPpsyF0CRZNm2eYth/jF+ZN7yemONyxXHQK8bmEaExQwv31bZowJfvOWydbSn
	 HQWLVe3YGVpcTSO3254jGuiKZvw9zuWew3QbhuoZ+aOSn5z5GZ6IE5hsS5hx94tuDmGuV
	 zoWX5o/KnKJl3irFJpiQVD3pLqUaaJAIhz9Q4r1HYQvB1smO6cWMug9kHWzomsFLTsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=X63ALfQY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438802;
	bh=9IlsS9W4Q/gpn2QbrVMSegHpBB1fIoGy5DlnixYJtFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VSTs+9Xg2C7EUA+nhebxultulb3j6tdrPQ7NNA1GtnZwcN4FjxQ60wPiv7z+ZFMPI
	 2BhNPpgxTqO6MxPE1AjmV8vXEDfMfRLcmWPRWOmzBO1+xViMKWuSDUtT6NlFKv68dJ
	 oAK5auHTypxeMe4PtlTCNcYJ2ogEq3428RFZ/526KOHx2TMSTcJPMmJzNYOic/R3Lb
	 jiQ11Yomw0vHacA5oGLcKiy+s4oStCRcJUiu6HWy4jPMoCKrwxyVKLZVr0k5h7zEiu
	 tcW75I9Vx1uZgNUc1wH0wjcubDmbHgIsheDVaGQGdzcdUcmw+xpHXlza98Gj8Oqgwy
	 J6YxAVdxh7gUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DCFB40884;
	Wed, 11 Nov 2026 23:13:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1E412FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6B3940D12
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7AvfSoY6V1xW for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A92C40884
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=X63ALfQY
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A92C40884
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794438799; bh=9IlsS9W4Q/gpn2QbrVMSegHpBB1fIoGy5DlnixYJtFA=;
 b=X63ALfQYdrJXubov20J2gr9d8H/LPCqCPFeJS1s/cU3LZ1A0TRGgxY8OdvmxcHiUEzi5tRH7B
 3OSNg3RPc8Ry9SwYszT4NUpc8tLRdszvYjFJdDTndMPAwdwSqBnWh5Aft0GkJ2LWwAkkaWA4mvT
 uUUCFO4dl6SuKKEyRVR/82V3QSSyJhoIy/XnNio3YiX+JX2QVxUauEPByHzIvO3/e0YMIoO2aVI
 r5R5MDqzppOVdo7DAZ4qRuqsoRysQU6JucvHnqC2nWLtZ6XVx4CbV0K9D7vb0CARBAnUxlrNddE
 MtocCnp7FK+bw7HTJ8sn4uIbl3lnGS4V5PzjDKXDhPMQ==
X-Forward-Email-ID: 6af4f68cf53292d6859f33ee
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 6/8] clk: rockchip: rk3588: Rename PPLL register macro
Date: Wed, 11 Nov 2026 23:12:47 +0000
Message-ID: <20261111231251.160051-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111231251.160051-1-jonas@kwiboo.se>
References: <20261111231251.160051-1-jonas@kwiboo.se>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PPLL registers belong to the PHP CRU, rather than the PMU CRU.
Rename the register macro and update the PPLL entry to reflect this.

Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
- Add fixes tag
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 2 +-
 drivers/clk/rockchip/clk_rk3588.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index c83010e518ee..39295adeb38a 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -126,10 +126,10 @@ struct pll_rate_table {
 #define RK3588_SDMMC_CON0		0xC30
 #define RK3588_SDMMC_CON1		0xC34
 
+#define RK3588_PHP_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
 #define RK3588_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x800)
 #define RK3588_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0xa00)
 
-#define RK3588_PMU_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
 #define RK3588_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x300)
 #define RK3588_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x800)
 #define RK3588_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0xa00)
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index de435f7d0ec0..fb218ff995cd 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -61,7 +61,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
 		     RK3588_MODE_CON0, 2, 15, 0, rk3588_pll_rates),
 	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
-	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
+	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
 		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
 		     rk3588_pll_rates),
 #ifdef CONFIG_XPL_BUILD
-- 
2.56.1

