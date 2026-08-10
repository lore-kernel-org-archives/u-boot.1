Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEC0C5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 21:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 847C980CC3;
	Mon, 10 Aug 2026 21:15:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEf_G0HLLnts; Mon, 10 Aug 2026 21:15:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74B6580C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786396536;
	bh=Y4HcaViFAPlMEitkNa4CDDqitykHvC0dXQ1LjV9xjMU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oWpDf6yUmCk73cJ9i5oBqzRoUJK/GIQC/RPEjFqW6Nquj4WGSznXadOSoAyaBiS02
	 /u/tUNb4Pj//ko83DtJsKweKgv557mjtjiPomqL80zrShj+bF4fzybbq+PQn7zQIU6
	 tV/hwzkafeCHT7TzYXaJqCZ5AD572ewLF5RvtYnEHbi+Jj05jK5VXbSiHMrttlCA0S
	 H2TRUPsCJ1Ed3CsYHy5VzrtsY8XuoOMdq+nF73smcQzmOZtYMJHkOVBpD8m95IdHHQ
	 KbewcsOgEnstALsjqdTRqIYdouMiFbwYETL7MtrY8IVwR9pYrlPERbbVcv+kpbssOU
	 4RVZnZFXlVY7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74B6580C44;
	Mon, 10 Aug 2026 21:15:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FB591AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45A7B406BF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:15:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xXHZa17WbywT for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 21:15:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=63b0=ge=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 208494064E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 208494064E
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 208494064E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:15:33 +0000 (UTC)
X-Forward-Email-ID: 6a7a3f22d9b5f16e05c7a091
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v2] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
Date: Mon, 10 Aug 2026 21:14:04 +0000
Message-ID: <20260810211405.2837550-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1786396533;
 bh=Y4HcaViFAPlMEitkNa4CDDqitykHvC0dXQ1LjV9xjMU=;
 b=daFQfvNUFRWQJogXK34WM+Os10RoBLiuiE2N0fE2y0EKQkQUtmo1LTdkwsBV5jCR+mIdWw4zO
 JD5tm4YUTIurhuMVKjooJ3KlFXQ95iR+sp/VYymIzZ8FQn9BngcVvgG8IdgRpNj8vp+h7FKrltP
 rbnRenbu67Sbd4cjKOlBOPoYdhonIMZVNUgLk7Vjdf0k8sQ8ETXnYL9YNESF9OChfD3rqjbAmvL
 QRVE6yxrE/Kn0Hcu29/r4cYX40xSSz9LSu/1LoF8YXhV3ozIcTwwjay3kK61eACTxEVpMLPCcYy
 2GNwuiYH1jmdcvMr4Bk6u58bGTrWxDx8jpyzHpTdVaLg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=daFQfvNU
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

The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.

SRAM addressing only seems to use 14 bits, meaning that reading from
0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.

Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
reserved region for its global data, malloc area and runtime stack.

TPL on PX30/RK3326 does not have any use for the malloc area, the
generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.

Current memory layout possibly looks something like:

  [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
    [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
      [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (unused)
      [0xff0e08c0, 0xff0e09f0)     304 bytes  global data
      [0xff0e08c0]                            stack pointer
    [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
      [0xff0e1000, 0xff0e3800)      10 KiB    code
      [0xff0e3800, 0xff0e3848)      72 bytes  BSS

Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
to 0x0 to avoid overflowing global data and stack into BootROM reserved
region.

After those changes the memory layout looks something like:

  [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
    [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
    [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
      [0xff0e1000, 0xff0e3800)      10 KiB    code
      [0xff0e3800, 0xff0e3848)      72 bytes  BSS
      [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
      [0xff0e3ed0]                            stack pointer
        [0xff0e3848, 0xff0e3ed0)  1672 bytes  stack area

With these changes the TPL_MAX_SIZE can safely be extended to 11 KiB,
leaving enough for the stack to grow down around 648 bytes before it
starts to overlap into TPL or BSS.

And with all changes the memory layout looks something like:

  [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
    [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
    [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
      [0xff0e1000, 0xff0e3c00)      11 KiB    code
      [0xff0e3c00, 0xff0e3c48)      72 bytes  BSS
      [0xff0e3ed0, 0xff0e4000)     304 bytes  global data
      [0xff0e3ed0]                            stack pointer
        [0xff0e3c48, 0xff0e3ed0)   648 bytes  stack area

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
The overflow/wrapping was runtime validated on a RK3326 ODROID-GO Super
by printing out content of [0xff0e0000, 0xff0e5000] and comparing the
initial 4 KiB with the 16-20 KiB and the data matched 1:1.

Changes in v2:
- Mention BSS in commit message
- Update spelling in commit message
- Collect r-b tag

With the patch "global_data: Only include driver model fields when DM is
enabled" [1], the stack area can grow down an additional 48 bytes before
it starts to overlap into TPL or BSS.

[1] https://patch.msgid.link/20260810204828.2836359-1-jonas@kwiboo.se/
---
 arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
 common/spl/Kconfig.tpl              | 2 +-
 tools/rkcommon.c                    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index adba1b49a52b..cc0632cf7b2d 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -81,10 +81,10 @@ config TPL_TEXT_BASE
 	default 0xff0e1000
 
 config TPL_STACK
-	default 0xff0e4fff
+	default 0xff0e4000
 
 config TPL_SYS_MALLOC_F_LEN
-	default 0x600
+	default 0x0
 
 config DEBUG_UART_CHANNEL
 	int "Mux channel to use for debug UART2/UART3"
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index a535b61ecd35..cdb9cb188c7c 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -129,7 +129,7 @@ config TPL_MAX_SIZE
 	default 0x2e000 if ROCKCHIP_RK3399
 	default 0x8000 if ROCKCHIP_RK3288 || ROCKCHIP_RV1126
 	default 0x7000 if ROCKCHIP_RK322X || ROCKCHIP_RK3328 || ROCKCHIP_RK3368
-	default 0x2800 if ROCKCHIP_PX30
+	default 0x2c00 if ROCKCHIP_PX30
 	default 0x0
 	help
 	  The maximum size (in bytes) of the TPL stage.
diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index b39777fc0607..872fc21c039d 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -137,7 +137,7 @@ struct spl_info {
 };
 
 static struct spl_info spl_infos[] = {
-	{ "px30", "RK33", 0x2800, false, RK_HEADER_V1 },
+	{ "px30", "RK33", 0x2c00, false, RK_HEADER_V1 },
 	{ "rk3036", "RK30", 0x1000, false, RK_HEADER_V1 },
 	{ "rk3066", "RK30", 0x8000 - 0x800, true, RK_HEADER_V1 },
 	{ "rk3128", "RK31", 0x1800, false, RK_HEADER_V1 },
-- 
2.54.0

