Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98362CA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F658606F4;
	Tue, 29 Sep 2026 00:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLjG4fGrCfO3; Tue, 29 Sep 2026 00:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2B1D66071E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641319;
	b=VQ/KJ3u+N+3sYlPkg0v54W2jLxVQCcIrLsjLmvPbvgV3NQq05diefl+QMt8B46JxkPNQ
	 MxTTKXcXdA6OwYBCb1bOO00ZGKgWDvgGEpsAs8pqTUKNiYdr8akeqKwshKpxoHTrsxUeD
	 RV3/ruwQr8mGIidnPY2VgZE+3HYJiOzszW0YJCghSXFICI+69P+iaCPUFX58G+Rl6QnbI
	 9Yd7u1PJcZcKyx5+e91LThBQcrvWv0cEekU7S6rhQV4k879/fMLDpEEQY7daE16xzYuMQ
	 o7rx+2TQlIKjf/Q3qySQcNjQuqYD/fmkyhJGaVW+XQVSIzaTOBTlYsO1ITNBGr5FqRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LZi58tnRfnCHkKZuFrCfNvHF5gxo99/i0cfZGYYzYv4=;
	b=qERkldD32OFLL8A6UvfYo7vJrG8l8G6i0uzOwDN3dBjikpGXWRRDXKKR9qVTBgCME5N9
	 1UsYpsUawqW7txSJe/lODCWji6+rv1hrqBa49xULi7MHNT3ke3lWUd0kArsEbZoqGl94y
	 dI9ig3qKbQX0uzfy+D41EAuqvWJptnL8hQ2zetcS8G7Xxjp3uBH/qQK810yprOZ49YDLM
	 UjZJEQsBJ0hQ1IKyejPNnjnNe5NY/dUl554vS1pT0TY5WtOFUZEiFliMNqlXOfiEWJyAj
	 xZO+oX0vsTrMXKSg4JUYUvg5oKE3A1su5dQujIlx+wE2mEuV9wFXcOktkBpFJO/QfGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641319;
	bh=LZi58tnRfnCHkKZuFrCfNvHF5gxo99/i0cfZGYYzYv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pbtEZR3XT6dpqivzpFqdGTIy2mqEnvCS2/mOSQ7htAEPWV9Lh3/vLgNJYIf+wzi+K
	 7jBr7A4FL86xSvffIidj6uJtBsLXUk3PHD7K04K4YCSQYlAUoM9StYCQVarlkDNE/3
	 WzzTQYzLILRgZY7wPBTudbzaPSLqQvDEjyrngYDMzNgd2sG7Udy2aSxuvXGEQRZodS
	 PcGqqTBt2oPY01DCGRLjh66M8s9qO8Rg02N9Tvz/f8btbMPlEdWbxGqN9W77xC4GfD
	 TdUFNcwi1wQ/IqQV38CNcATao1t6VMBXvH0di59x1E4rDulhBotpy1Ii1/pT90FCuy
	 15AwTBAqRGgQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B1D66071E;
	Tue, 29 Sep 2026 00:21:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84E7F335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A6C780C1C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3Qk1PkS-qtU for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:21:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 80EF480C16
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641316;
 b=P8tplFOh1+xkpjE21PCYWA3X0EmOEcxRSSitL7A8cZkXEeheFFPe7PUy3GNmLono/ejL
 w9U1vMoZMoBLJlgmz9tFOKFqX/jV4wwGEcI7bIJCBVksMZRiA5muBwW5pbciyCyapNOiK
 8VTw99rlmYqmzBy7fiVvzhn+OH5Tq6myMjZXazT9sVzNF1GrJLdK9MOop0kFiuwihYvSD
 gL0hcVb0Wi966fAY7ADeFrLbc9xKWJkDl/vJVoirSKsbGCdrQQ056uPHkYXg1qDJQCOn4
 Th9RFQSlB/MT3iKc/c57opJhZrpbrhGDU1MZkbDmIde2q/V9tM1gIXVVLlfV1zDEcuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641316;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=LZi58tnRfnCHkKZuFrCfNvHF5gxo99/i0cfZGYYzYv4=;
 b=VSgKnoUoSKRIRgPrVHCaOxDFVZC2bpKi0qpTezSPlPabWltZYAr9mfOOtsjXG105cET/
 bgmzVlHJQebUbEOjZM+08lyu2p71dbkYaIWQWdV+ueq42hlnf1ZTc4uqA0D3RJnwZyKf0
 X1ST79hUBwa/eag1WubjvQlBWPqEUwPeULMtWZrnc6WlcMaNAIitJTTrX2dHXS1jmEKyH
 /wJlhDcNoAj4dxeZbYTdLQ372yowmIQT7WHcxsAlm4JbTGH3BprSXvAxYVNTyGjL/l+Zc
 WK6QOJfEzvr3KVTqkXqCMuqwHuKw0KVEeMviWVo82jrw5WxIdYDf3MS68+NeMpxwB1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jFzuUnRq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jFzuUnRq
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80EF480C16
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:21:56 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-80a71781323so2190879a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790641315; x=1791246115;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LZi58tnRfnCHkKZuFrCfNvHF5gxo99/i0cfZGYYzYv4=;
 b=jFzuUnRqeTAyk5xop88Wiy8uN7USvaf5f8h/bQ5JEhRddl1F17CiuF00KNhZpE4fMM
 QuLp86yw7Lly7cUnOVx0tDKsSjUJk5B47PCldesVTaIX84ZxkAFKM60UGy/8m2E97lGJ
 eXz51m/RfBQ8ceY7wYSuYk3VfR6iSGp2tV5XJsq+IJYqI94Nd0lv5yYRKgGxh3IogbkN
 Z/n+QKMGhvg7WsfnHK+zbfL6WNcX4RuuuQKumeYtepKcjNS1MAHmbqWnkGyJo04TXIGv
 CbxymEL8p+rHFMClXYArxeTQLTTSSKnroHWTgzON7Y7rOBv5nTPI+PNK+cyH8AlHZh2e
 IuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641315; x=1791246115;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZi58tnRfnCHkKZuFrCfNvHF5gxo99/i0cfZGYYzYv4=;
 b=KMe9ba77AwOCbTatKLhJqa+XGi2s47gREbaoJhSDUlIL4HRpBQ8TY+6lzLaa3KEJly
 1SYWDaJeAY4aN+rXdKuvjMN1MdhUw0T9BGWayzwy+/UOO6khNk7zp9Ae9s5GoLaKIY3t
 6x8uCDFhqrPdEQERbfr4p96NOL63hjzz7gpKk75YtNEfMYIgLfLQVh2nM5nQxNUjrEsd
 edyyIvZI3TKbPk6l0JpdhSHAaFy2FB4RQ6Vmy4GUxMkTsMH/EwLwlbptLjWRFJCHUyG+
 0VTNQ/Afde62foAM8qM9SqwxxVY0xKAWhVEvFYK1+hpRhOdiNjAzXbOx/bcjncvGJcUy
 D/jQ==
X-Gm-Message-State: AFuF++nEqy/ZDeQ6iPYk/KWs5KF6Q2X8dBMXwx7a9ZIZAhGP4dkxc+hE
 Ycuu3nmvFxTbIXgiBm/u4w+tQIgjvTqKVMbJlFNgoiffbeP7urFr/Wh1
X-Gm-Gg: AYBFou1Fc7yRlI+M/VoUtq9qexsCtaqf9O0IN8+jGZ3JSCRfBq18P/Q/Zp250WQ1l3g
 XOBIOurM4wdu/ssIzFtTjSbIoX2xuX16/V8VsbDRlzFVQ9gWlTBe8P06MlVIsMkvRV9ybNHQlK4
 PpqwyvC6tjtmgcztUokTQEyP9REJgWPoc2MCVYS3Rp+/zd2qSz+JHthaLFqxxOL51CQq+2iJvT+
 8x1LbszA2IM9pLO1z2GyQRX5doyFAdd1ZcVgmM++MEDybREMjSXYs/GM2cNYWvbdRltuwMdoAuI
 2RoPeB5dRzVnPUD1UxO9SR9tCRdNtqF00H9HKGQYNrFn8Q+FfFK/i+8rKn9VJUA9iabr2TjLSt4
 5Sr2ecsi9o31nYyK+GXtiRphP4C3srUV4dXHfBO0B1r57pAgtp07+4F9SLzL3Ta8p/cDam1vXSj
 WCxCnDZsICH3UXTRWTMs2RyNJr/0jxMNb6ckV3dWqlLcz1VUk0F0/AA7tS/W6E803SBWm5dgZxz
 XHPqJwk1hhr5Pdyv2SU6cLIluDguP6VgR68ApaNaxedQDMdndtVtzMqOWwutLnUiVhu8rRGQ++f
 Qql2b19F067lWXaGH4OUJebpLHZS2G1Ec67Lvpu/a78QxPvYzIaB+NFzL/fpDiOchuykgnF3twe
 qbpqIlGUJXGUcolNrS8Nt
X-Received: by 2002:a05:6820:4df2:b0:6da:e0c:c3b9 with SMTP id
 006d021491bc7-6da0e0cd102mr2454280eaf.58.1790641315157; 
 Mon, 28 Sep 2026 17:21:55 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-494877590e5sm8175688fac.13.2026.09.28.17.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 28 Sep 2026 18:21:40 -0600
Subject: [PATCH 03/20] net: lwip: finish DHCP before starting autoload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-lwip-dhcp-v1-v1-3-2060c7365b0c@gmail.com>
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

A DHCP runtime attachment owns address configuration and cannot coexist
with the strict attachment used by TFTP and NFS. Stop DHCP and detach
its runtime before starting the requested download. Honor autoload even
without command arguments, keep lease-only requests download-free, and
reject unavailable protocols explicitly.

Select explicit filenames ahead of the offered filename, retain the
environment default when the offer has none, and discard stale gateway
and TFTP-server overrides on a new lease. Do not start a download if
polling or publishing the lease fails.

Use the advertised boot server for NFS autoload too, without
overwriting an explicit NFS server or persisting the temporary download
override.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 net/lwip/dhcp.c | 118 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 36 deletions(-)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 0494e3981d5..411f0e68d75 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -16,12 +16,7 @@
 
 #define DHCP_TIMEOUT_MS 10000
 
-#ifdef CONFIG_CMD_TFTPBOOT
-/* Boot file obtained from DHCP (if present) */
-static char boot_file_name[DHCP_BOOT_FILE_LEN];
-#endif
-
-static int dhcp_loop(struct net_lwip_ctx *net)
+static int dhcp_loop(struct net_lwip_ctx *net, bool explicit_file)
 {
 	char ipstr[] = "ipaddr\0\0\0";
 	char maskstr[] = "netmask\0\0\0";
@@ -52,7 +47,8 @@ static int dhcp_loop(struct net_lwip_ctx *net)
 
 	/* Wait for DHCP to complete */
 	do {
-		net_lwip_poll();
+		if (net_lwip_poll() < 0)
+			return CMD_RET_FAILURE;
 		bound = dhcp_supplied_address(net->netif);
 		if (bound)
 			break;
@@ -68,7 +64,11 @@ static int dhcp_loop(struct net_lwip_ctx *net)
 
 	dhcp = netif_dhcp_data(net->netif);
 
-	env_set("bootfile", dhcp->boot_file_name);
+	if (!explicit_file && dhcp->boot_file_name[0])
+		copy_filename(net_boot_file_name, dhcp->boot_file_name,
+			      sizeof(net_boot_file_name));
+	if (*net_boot_file_name && env_set("bootfile", net_boot_file_name))
+		return CMD_RET_FAILURE;
 
 	if (idx > 0) {
 		sprintf(ipstr, "ipaddr%d", idx);
@@ -78,23 +78,18 @@ static int dhcp_loop(struct net_lwip_ctx *net)
 		net_ip.s_addr = ip_addr_get_ip4_u32(&dhcp->offered_ip_addr);
 	}
 
-	env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr));
-	env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask));
-	env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
-	if (!ip4_addr_isany(&dhcp->offered_gw_addr))
-		env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr));
-	if (!ip4_addr_isany(&dhcp->offered_si_addr) &&
-	    !ip4_addr_eq(&dhcp->offered_si_addr, &dhcp->server_ip_addr))
-		env_set("tftpserverip", ip4addr_ntoa(&dhcp->offered_si_addr));
+	if (env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr)) ||
+	    env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask)) ||
+	    env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr)) ||
+	    env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr)) ||
+	    env_set("tftpserverip", ip4_addr_isany(&dhcp->offered_si_addr) ?
+		    NULL : ip4addr_ntoa(&dhcp->offered_si_addr)))
+		return CMD_RET_FAILURE;
 
 #ifdef CONFIG_PROT_DNS_LWIP
-	env_set("dnsip", ip4addr_ntoa(dns_getserver(0)));
-	env_set("dnsip2", ip4addr_ntoa(dns_getserver(1)));
-#endif
-#ifdef CONFIG_CMD_TFTPBOOT
-	if (dhcp->boot_file_name[0] != '\0')
-		strncpy(boot_file_name, dhcp->boot_file_name,
-			sizeof(boot_file_name));
+	if (env_set("dnsip", ip4addr_ntoa(dns_getserver(0))) ||
+	    env_set("dnsip2", ip4addr_ntoa(dns_getserver(1))))
+		return CMD_RET_FAILURE;
 #endif
 	if (CONFIG_IS_ENABLED(CMD_SNTP)) {
 		ntpserverip = sntp_getserver(1);
@@ -108,28 +103,64 @@ static int dhcp_loop(struct net_lwip_ctx *net)
 	return CMD_RET_SUCCESS;
 }
 
-int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int dhcp_nfs_autoload(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
 {
-	struct net_lwip_ctx net = {};
+	const char *server = env_get("tftpserverip");
 	int ret;
 
-	if (net_lwip_start(&net, NET_LWIP_ADDR_NONE))
+	/*
+	 * DHCP's siaddr is a boot server, not necessarily the address server
+	 * stored in serverip. Supply it only for this download, preserving an
+	 * explicit nfsserverip and the NFS command's filename-prefix priority.
+	 */
+	if (!server || env_get("nfsserverip"))
+		return do_nfs(cmdtp, flag, argc, argv);
+	if (env_set("nfsserverip", server))
+		return CMD_RET_FAILURE;
+	ret = do_nfs(cmdtp, flag, argc, argv);
+	if (env_set("nfsserverip", NULL))
 		return CMD_RET_FAILURE;
 
-	ret = dhcp_loop(&net);
-	if (ret)
-		goto out;
+	return ret;
+}
 
-	if (argc > 1) {
-		struct cmd_tbl cmdtp = {};
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct net_lwip_ctx net = {};
+	const char *autoload;
+	const char *filename = NULL;
+	ulong addr;
+	char *end;
+	int ret;
 
-		ret = do_tftpb(&cmdtp, 0, argc, argv);
-		goto out;
+	switch (argc) {
+	case 1:
+		break;
+	case 2:
+		hextoul(argv[1], &end);
+		if (end == argv[1] || *end)
+			filename = argv[1];
+		break;
+	case 3:
+		if (strict_strtoul(argv[1], 16, &addr))
+			return CMD_RET_USAGE;
+		filename = argv[2];
+		break;
+	default:
+		return CMD_RET_USAGE;
 	}
+	copy_filename(net_boot_file_name, filename ?: env_get("bootfile"),
+		      sizeof(net_boot_file_name));
 
-	ret = CMD_RET_SUCCESS;
+	if (net_lwip_start(&net, NET_LWIP_ADDR_NONE))
+		return CMD_RET_FAILURE;
 
-out:
+	ret = dhcp_loop(&net, !!filename);
+	/*
+	 * A download needs strict addressing, incompatible with DHCP's
+	 * address-less runtime attachment. Retire DHCP before handing off.
+	 */
 	if (net.netif) {
 		if (dhcp_supplied_address(net.netif))
 			dhcp_stop_without_release(net.netif);
@@ -139,5 +170,20 @@ out:
 	}
 	net_lwip_stop(&net);
 
-	return ret;
+	if (ret)
+		return ret;
+	autoload = env_get("autoload");
+	if (autoload && !strcmp(autoload, "NFS")) {
+		if (IS_ENABLED(CONFIG_CMD_NFS))
+			return dhcp_nfs_autoload(cmdtp, flag, argc, argv);
+		log_err("Cannot autoload with NFS: command is disabled\n");
+		return CMD_RET_FAILURE;
+	}
+	if (env_get_yesno("autoload") == 0)
+		return CMD_RET_SUCCESS;
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT))
+		return do_tftpb(cmdtp, flag, argc, argv);
+	log_err("Cannot autoload with TFTP: command is disabled\n");
+
+	return CMD_RET_FAILURE;
 }

-- 
2.53.0

