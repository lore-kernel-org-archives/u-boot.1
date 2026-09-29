Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90B2CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DAA960767;
	Tue, 29 Sep 2026 00:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHJkmvPCDG8Y; Tue, 29 Sep 2026 00:22:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BB4CE60771
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641355;
	b=sg7km0BNby97r+Eb2/SpZdHGhqnZRR1tqt63YiYMa8BRwMvOeizsTNmSpzhxoRCJjwkq
	 /q1o6LhxKpeKtQS87CUq1o3+5U+V/X816XPEHW2H9GVagB+CR+Zh7to0bNoImijzxFxWX
	 evIxGY7zP1C9jSep6ttScLaXu63gzV7weZlJClTGj8rivytPupaWWsjNOoUBHrHsMXbIN
	 WoaZcfHFXOfFCfEn4YuQ2/jD118iYDKrI40wDqghY25jztBpqk8qPLLfUjTZb5pvYKKtS
	 028Ld5ar4F3vgD5cduSVmrDKuhLWOERjP2wCxUaR+KlVQ7IKDSKDYjrC0y5jKU/jJcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641355;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=noWvD+DG4keVCJmHpBiE4K9DAukw6Wjcc2FCWkxwBmM=;
	b=ff5x8Z2nloOO4T/ZaSM4rxLW5OUnL9EGdPTxlEJ4P00KABTnnu0lfZpqEil0b6EUsfUH
	 zzTTZWqxqKFAXT9+enHvoJI0TcDXIwTqlFTRvQEgZZvQBxOVg6AuWSemZ+SFRyDFs9XMp
	 PSrQ8Bg5Bb91k14FzQKZrKnbFhpmqVt5BgtV2qFQ/NwM5L8wTsAKjzrV8hLF6YrREJETu
	 yWjm81GJlV1saCMQcprAUiehWBUAtoIQnAKQwulsPkmPUnznRHWe1cMhGLEAAzUO86bO7
	 rZdoQb8YPILdADBOPVE/4AjykE0HRBrBOz7H7m5X3ybLlsnhv0rBnJ/8qaOMTzPPVig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="SlvlUQf/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641355;
	bh=noWvD+DG4keVCJmHpBiE4K9DAukw6Wjcc2FCWkxwBmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=THuIZLT3TKE07hfhofg6VoRgsk+uWv3c1fKzwOUzz3KnPzS3t/WIenyFY+UswWHLn
	 2DwEk47fLiWjynZq1h6CfnAYY6Tru9IVutZR1zKZUZdhv2sr6g7IXcm5S62TtNbGs0
	 wzrzww/NPHvENHAPFtdLZ6v3ERBkep9gEJNWUyCeO0MVBFCMgnUFRRt7HGqWCo4tAR
	 esKT7LfZJm1W91ZiHB4Or0/n38RkeOzIUUpmgjlPgFT0QLqfNfOixLwK8mWqR5LPTW
	 am85ahbXSuj7tOQKOzH33v1N/6/wnQsHfSFUadlRgPVm+bf5ODxosIUFhPwbElr9lP
	 kcONlnevBSzPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB4CE60771;
	Tue, 29 Sep 2026 00:22:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E57DE61
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C77306077A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aep9RfvQe5QN for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:22:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A0A046076F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641347;
 b=Ji8frz/cjtHKIoCThqML7bx4JdYA0L+++rDnnj6f1bXZLQGco7iAe1w1j2Qj5Uzxh1w8
 pPRC9zl/Cohs6iz2kySy5XqTt81iyxz4DWM0j7UMQNlxFdYi2LRnPFHo73aA8hLa2M3b/
 UtAhzKeKgInH7wZtqakZ0Dq9JGoac7VA4JGfMLmv2aQVU0w1rrPrXtlA6bra+4ymjW5+U
 AmJRfKfX6fF7fuB7iCEuZ0FXExBnn6/GawxvkoEPNuGQ9TK/7rA9qhRCZtRzgukAjPd7Q
 7xPhlXRhzUgHsiQ0uMs9bVo5t8smF8BXGyEvnmgnmHRCbByLyVm0eyM00SElAeYkl8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641347;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=noWvD+DG4keVCJmHpBiE4K9DAukw6Wjcc2FCWkxwBmM=;
 b=Iqhs43mqfnlZkmb95inoxFN/7vlpuAJ3++aQYWqyHcEpeWe8bIazrlBuXzSKOMRMzVpM
 jj07s4ysHSh2LJcpkZ/4lqtFS1t+8Wx9DRG2htOKml2YyS+/GY99jSniklT48eZS6c3uR
 +Bz1dtdboRjdpFamcJMwsOhZY+xLG2nQHtrEkmwyzfmEAAmG6B6h83LzxCBxdxQYRFtV6
 y6sRgP5zqEoKM2J+uRiAS+/QVy4K77UfYPeNXEiqmnEm19E6C8Y58k26DAB8fNQV3Bcrx
 H15ESBAqhgUuaOafgO2QYGcjVfKaoSimaKQqJHeyOvwLqfBmlHJ80EdIkrMrSxMIsVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="SlvlUQf/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SlvlUQf/
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0A046076F
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:22:26 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-7fcb425fb68so2192833a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641345; x=1791246145;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=noWvD+DG4keVCJmHpBiE4K9DAukw6Wjcc2FCWkxwBmM=;
 b=SlvlUQf/QYh/cqKSuBNTq6bte9j7HJOvRRXPlZXEhNGeilkDBNpOYyeruaZulsD3es
 /sr2xt6KRLvI/29BSCjqTqkpyZskeqxD4cbxaXMS9eR+j3WjO5QeWDUECHoq+deBo1cB
 wxYio0DVOK7pus5EyyrZPl60LliYuqT16hQRtFYd+PWg65tfya2YgBRPkNrIvIhZshXX
 y/NMgz0yJdh/BSwAdV9kWH18nKOn585qXuev/Cix7zBZSZD5vR1WZoX/DnIv8MeU8piC
 1IbVWfxjv4o/wikPu9NihUOB7qvFCVmJgAvzQ9+4H/hUb4NtifCLjo7/UpDmbo5/9xzK
 zyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641345; x=1791246145;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=noWvD+DG4keVCJmHpBiE4K9DAukw6Wjcc2FCWkxwBmM=;
 b=PuWtdR9g6OCy8YB57GneJsP7i6CPu3Til3/l50KSQZVnm40DA1eRnvyJVZb18LW320
 OmIkiCd+JAkEJu8tmUSwNIteC8HeGAFc55oYefEcf5y2DE9j17GqxQtt4Xl9NwrGd8Pf
 gakUnQnAnSjIktc2OL9GBJTfs9/mwJjx0j4LkW+BI++Z8N1/GlZi8vcocA4Z6h7eqFkz
 9DSkvXk7VQx9gSSDBgJbmzCNOjrA8K+29s1//9mviodpoLYs94/CL7F4I4ZWXIRLL7Rp
 7mKdggma6hWQB36Yf5PaGM3G80LgfCLibjBmyg4d1aA8OBDLHNJevS0cxTtd1tglAt0y
 Ovzw==
X-Gm-Message-State: AFuF++lRgN7Tz+wzOQhhXwOv9TWVzVBrhxBoTD1dP9Y3jUoWfU0g0P+S
 c3O0gIolxavmekbV1CPpCLNz+p5D4HBdFdsbqYL1amFQ2yiF9E2fV55Z
X-Gm-Gg: AYBFou23g0Zun0Y2x6c898e/sbnTnIzwWnyy0SPhqBiaz+WpkdWHsS6Dx7L0UHER7W9
 +mep3GQX2VQhogOTBeijm7iiuhRSDF4vaNmfYRuYVeqV8ZiXCM824eClKc0pTNmneANHYiMjEa6
 nvuMrMGuynm//xjdB762o/belAjlGJ5tykTGXv6h+0T/6/gg1Y7tYeb2eCrE5+bg6WUbonOc/MT
 Mt5/K9x9WdckTqxFJ/Hm3Iz32sjNIVOesN4phC6x1pkg2IcaHFUZbDi669PUjEuqk3EAtJyCDhb
 oU5QuVMBugGzuLODup5J2S39ZxEwfbDnfmEGuIveDQdLwTZwVGmO4pqUt1Xao1Rp54taYmr/Vcl
 KBp5Mm0d5p+VX4a1blWk8hUYM5jrPeOVpp92juBNX2wChXP9b0Lac/y660w+ABF/yfRLyDE5+09
 1A+EQZwB/Je7/QfnIGu7zjJQIGKeOBLs8z2dqOlPN+oQWKZiV4x7PyUpiIHlBNM6wtPTkB7tbHJ
 dep2qVyXPw81HMeLUUp9/o6+bLNWuaQsEemKLO7e9aGWDYh7P1hWORITeXfx05/GI0J8K0KA/HL
 GuArvO6purIMciVyqUfej9OuoInaRXlq8hZpZWOqV2t4qoyxlerhZeePuJFVXuAUYWb+69EY+VH
 J0nWFWLAq/Ft8o+xvuTHE
X-Received: by 2002:a4a:ee19:0:b0:6b7:8415:d78c with SMTP id
 006d021491bc7-6d4410d949amr14293852eaf.55.1790641345219; 
 Mon, 28 Sep 2026 17:22:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:22:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:55 -0600
Subject: [PATCH 18/20] net: lwip: separate DHCP exchange from boot
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-18-2060c7365b0c@gmail.com>
References: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
In-Reply-To: <20260928-lwip-dhcp-v1-v1-0-2060c7365b0c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peter Robinson <pbrobinson@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Heiko Schocher <hs@nabladev.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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

Collect the accepted address configuration independently of the lwIP
DHCP state, then publish it through a common helper. Keep the current
DHCP behavior, including clearing absent gateway information and
honoring boot-server preferences and explicit filenames.

Separate retransmission interval calculation from the DHCP callback
too. These helpers let a standalone BOOTP client reuse configuration
publication and backoff without depending on the DHCP lease state
machine.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/dhcp.c | 94 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 31 deletions(-)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 8898fa4efd8..3486a94084b 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -25,6 +25,16 @@
 #define DHCP_TIMEOUT_MS ((3ULL + 5ULL * CONFIG_NET_RETRY_COUNT) * 1000)
 #define DHCP_RETRANSMIT_MAX_MS (U16_MAX * DHCP_FINE_TIMER_MSECS)
 
+struct bootp_config {
+	ip4_addr_t ip;
+	ip4_addr_t netmask;
+	ip4_addr_t gateway;
+	ip4_addr_t server;
+	ip4_addr_t next_server;
+	bool have_netmask;
+	bool have_gateway;
+};
+
 struct dhcp_boot_data {
 	char hostname[256];
 	char rootpath[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];
@@ -53,6 +63,7 @@ struct dhcp_efi_cache {
 
 struct dhcp_options {
 	struct netif *netif;
+	struct bootp_config config;
 	ulong start;
 	ulong timeout;
 	u32 retransmit_init;
@@ -106,10 +117,8 @@ static int dhcp_parse_number(const char *str, uint base, ulong limit, ulong *res
 	return 0;
 }
 
-/* The core rounds the result up to its fine timer interval. */
-u32_t net_lwip_dhcp_timeout(u8_t tries)
+static u32 bootp_timeout(struct dhcp_options *options, u8 tries)
 {
-	struct dhcp_options *options = active_options;
 	u32 timeout;
 	unsigned int i;
 	s64 jitter;
@@ -127,6 +136,12 @@ u32_t net_lwip_dhcp_timeout(u8_t tries)
 	return clamp_t(s64, timeout + jitter, 1, options->retransmit_max);
 }
 
+/* The core rounds the result up to its fine timer interval. */
+u32_t net_lwip_dhcp_timeout(u8_t tries)
+{
+	return bootp_timeout(active_options, tries);
+}
+
 static int dhcp_timing_options(struct dhcp_options *options)
 {
 	static const char * const names[] = {
@@ -556,8 +571,9 @@ static int dhcp_boot_env(struct dhcp_boot_data *data)
 	return CMD_RET_SUCCESS;
 }
 
-static int dhcp_server_env(struct dhcp *dhcp, struct dhcp_options *options)
+static int dhcp_server_env(struct dhcp_options *options)
 {
+	struct bootp_config *config = &options->config;
 	const char *server = env_get("serverip");
 	ip4_addr_t addr;
 
@@ -571,17 +587,47 @@ static int dhcp_server_env(struct dhcp *dhcp, struct dhcp_options *options)
 		return env_set("serverip", ip4addr_ntoa(&options->proxy_server)) ||
 			env_set("tftpserverip", ip4addr_ntoa(&options->proxy_server));
 
-	return env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr)) ||
-		env_set("tftpserverip", ip4_addr_isany(&dhcp->offered_si_addr) ?
-			NULL : ip4addr_ntoa(&dhcp->offered_si_addr));
+	return env_set("serverip", ip4addr_ntoa(&config->server)) ||
+		env_set("tftpserverip", ip4_addr_isany(&config->next_server) ?
+			NULL : ip4addr_ntoa(&config->next_server));
 }
 
-static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
-		     struct dhcp_options *options)
+static int bootp_store_config(struct net_lwip_ctx *net, bool explicit_file,
+			      struct dhcp_options *options)
 {
+	struct bootp_config *config = &options->config;
 	char ipstr[] = "ipaddr\0\0\0";
 	char maskstr[] = "netmask\0\0\0";
 	char gwstr[] = "gatewayip\0\0\0";
+	int idx = dev_seq(net->dev);
+
+	if (!explicit_file && options->reply.bootfile[0])
+		copy_filename(net_boot_file_name, options->reply.bootfile,
+			      sizeof(net_boot_file_name));
+	if (*net_boot_file_name && env_set("bootfile", net_boot_file_name))
+		return CMD_RET_FAILURE;
+
+	if (idx > 0) {
+		sprintf(ipstr, "ipaddr%d", idx);
+		sprintf(maskstr, "netmask%d", idx);
+		sprintf(gwstr, "gatewayip%d", idx);
+	} else {
+		net_ip.s_addr = ip4_addr_get_u32(&config->ip);
+	}
+
+	if (env_set(ipstr, ip4addr_ntoa(&config->ip)) ||
+	    (config->have_netmask && env_set(maskstr, ip4addr_ntoa(&config->netmask))) ||
+	    (config->have_gateway && env_set(gwstr, ip4addr_ntoa(&config->gateway))) ||
+	    dhcp_server_env(options))
+		return CMD_RET_FAILURE;
+
+	return dhcp_boot_env(&options->reply);
+}
+
+static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
+		     struct dhcp_options *options)
+{
+	struct bootp_config *config = &options->config;
 	unsigned long start;
 	unsigned long proxy_start = 0;
 	struct dhcp *dhcp;
@@ -648,28 +694,14 @@ static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file,
 			strlcpy(reply->pxe_config, proxy->pxe_config, sizeof(reply->pxe_config));
 	}
 
-	/* The core's file field also reflects replies it subsequently ignores. */
-	if (!explicit_file && options->reply.bootfile[0])
-		copy_filename(net_boot_file_name, options->reply.bootfile,
-			      sizeof(net_boot_file_name));
-	if (*net_boot_file_name && env_set("bootfile", net_boot_file_name))
-		return CMD_RET_FAILURE;
-
-	if (idx > 0) {
-		sprintf(ipstr, "ipaddr%d", idx);
-		sprintf(maskstr, "netmask%d", idx);
-		sprintf(gwstr, "gatewayip%d", idx);
-	} else {
-		net_ip.s_addr = ip_addr_get_ip4_u32(&dhcp->offered_ip_addr);
-	}
-
-	if (env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr)) ||
-	    env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask)) ||
-	    env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr)) ||
-	    dhcp_server_env(dhcp, options))
-		return CMD_RET_FAILURE;
-
-	if (dhcp_boot_env(&options->reply))
+	config->ip = dhcp->offered_ip_addr;
+	config->netmask = dhcp->offered_sn_mask;
+	config->gateway = dhcp->offered_gw_addr;
+	config->server = *ip_2_ip4(&dhcp->server_ip_addr);
+	config->next_server = dhcp->offered_si_addr;
+	config->have_netmask = true;
+	config->have_gateway = true;
+	if (bootp_store_config(net, explicit_file, options))
 		return CMD_RET_FAILURE;
 
 	if (CONFIG_IS_ENABLED(EFI_LOADER)) {

-- 
2.53.0

