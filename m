Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC10606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qFkLvtYc;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tx1olvnN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D041440998;
	Wed, 11 Nov 2026 20:11:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XjPhyihlmjrX; Wed, 11 Nov 2026 20:11:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1800F40920
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427894;
	b=WhMEWCAF8ug9JlJSnGhlv2UTx8tFzfHpmLGF3SQEZaFS5vNPEgZBP5+QXIeM/unMQHtO
	 BOcyXaaEGcz2RJ9nogUyVKdmwF1KJPvdBL7EVAMiBeYPh/haIKBr3PsBVE7FgrgvvPJsp
	 q/eHQR3HB5nLe6JvMOo2Z2AKS4JVT3zBr4U+D4SjpV0iK0Zu3WSRMrjApwvMeWV29j12N
	 Ra6Vtmo9SE1jihI1n2sI/Jg+Q9NO+3MQEM88nzoA3Ny3j3K60IfUJA2Bxw+xCE6pL93o6
	 9HNIVqLjCtqOLWDcpvzgzilI+vTqLFqDGKbUy+RfFXCfj/I8AVJNdkK5rrMUZ9WtEng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=teIpf8GoXSZD+6zgtOZkGuF0UESxiD5SBVt1V4XegYc=;
	b=fsU+RepNuqGaS4gSLQ15Q5CQLsJZpb2iGqQjg6sbiJSl1/4WIGWUpiTYC/yOhgaLevOy
	 tnUSIUYRLl01/4bi63DDIfK+nu6LqyvBLUQb9S7xDYFF6yd/gJjcyfIdDwYFNxCTTGMVj
	 G1+u9SpR6jzCOhjmQQG7+CCFE/900FaC4XNx5X7C+XRgep1DrIuMohBXJc4XjKOHnXHcr
	 Fg+u7pgXIQNjXVSLX42MMTf0XpMS0sQPVFLPLUsSsV/c3Ypa3+yozF6nKLbp3BkM3aW9i
	 9jqnnRiMeut3/Q8YjUbveklEVjc02NbpotOdYXUQ6rsyth0suB/TO2PAsuSDR0yT+XA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427894;
	bh=teIpf8GoXSZD+6zgtOZkGuF0UESxiD5SBVt1V4XegYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qFkLvtYczOiUTTp+9KYp93wVVYW2Ncdvzdac5aSZ9VAImjud5LdnLdyM8g9vj9gd1
	 IozlucmW4VB8WsKQUx0XqP/Es9EhuZDjXX3YUwc2xt19NNH1SItpxbV9nBJDmDnwlW
	 6PmR+qpcrLr06mYDTkfQ6KrMTJL/TmiBWZkeAxoiQaOo8IGYHmDjCQVWXuM8+uZGvA
	 QwK26j7eH7ob2UOuCyqnjiyGoMxpWJR5UJwTDVyUYDCdqLAYWQBoGGmQkC1guIb2jP
	 Xy2kdyQoxSJcpN3+DIfYuFMAnD9s9jRA0QUenQIeYj7+ommEynO5E2IMq32b6EAsvL
	 rftnzwPv3RyEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1800F40920;
	Wed, 11 Nov 2026 20:11:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 78EC4EC3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46D1260DD1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aQPVaIXhf_4q for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 357FA60DD8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Tx1olvnN
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 357FA60DD8
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:24 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4ad4072943dso1264864fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427883; x=1795032683;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=teIpf8GoXSZD+6zgtOZkGuF0UESxiD5SBVt1V4XegYc=;
 b=Tx1olvnNth/GA4iL9cf83iIRZm/5GPfkMmqbo5GUOK0LBjNaDHzaQl5kx/5BggyjzM
 7SdhRYUFkMDlelCIEKNiWPCMrWawz07yLsS7BA1OrcRRD16xLx52Wr8mT6TDmPUABL1W
 87WJT9mTPWNQKeEmacaCAnZq3PRgTLpBr8in+jwl1W6AITD0rETmgUcXjZF1jpBi8Ee8
 EuCa1cdxxDdnjOxOStTBe2f5Y7VTgS4jb5IYWldIYhuYR3BsUp3n3nWHClUeLbePihH2
 xH/nljDU0gxfQMWCWDHZq+5xaDcCVWroq+YiF1A6WvNy0kJOUzvdmDY1nHvcDr17ZrB8
 0Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427883; x=1795032683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=teIpf8GoXSZD+6zgtOZkGuF0UESxiD5SBVt1V4XegYc=;
 b=Y04QoaU4maQs6dpg3hJ30Mym5AtnRXcFGFVr9VF2n47QkMztX8vZJ0Hmo5WFcrlpDl
 b8/2T66oizrMh4kIl0GJ01SMRq6ydPLi+PAjSLaTNCY5rmk0dTWRMiTx51KYh2WbdT2k
 m/U8qg+itM+5vdok4RSXPMDFvylYyyIYFgeJF/K0s2BPrdNMPvu48OIOvgUvH8EpRGao
 0HL6kJr+88ik3ww/JxRH/ws4LC4o2k6GXlYqR9V10o7b4M6xHYkg4lmz/CnvZqV/SI4o
 YI6U/ti2orFCoK+PZIcnhiuUpyQtGv/xg2biw4IyqT7uS4zL/jkwKR6Q/ChJy8GiTHuT
 rI6w==
X-Forwarded-Encrypted: i=1;
 AL+hErHBfPS39Y9S015cZWy1L8AZz+y/YbZqFo1AGbsvkZNx1Vt5OypVM6Jyz8xRWTVMlkO/fbzjr5E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9lzqqrmZQZ6t5w3QIF4ARP0eXmgdHPduJIswts+7k1upN04Nc9
 3bFhRFuHLIviIuVX7+/LKVk+nSTN7LYecDNN/aLXbfsKcFDdISRhzwft
X-Gm-Gg: AYBFou2MYHLJMTTrpOW+BpLVS9l/V+KEXG2SYXGCbDN0N0gFwL3ez/NTGW5xPl+pLin
 jFw3DXiREmlpdHR1XGMQhh7M9HQ28uT/NnAUE0uGJWdTTAj/RhA9YdH9KRjOpe9T82Jg/gzIDyk
 16U//WMQv26WA1fpTj0PwBIf+NDlVPIKyQxYWW/bphATNc3e6m15WTNs5qlE/dWLxp/XRjMItRx
 vJKPAUC44251G3R+NB2z/OGhHnks/8mrQD57tQgl3EaAEiAFsUm7cJaaGk8k60iJ9nki77a/QYp
 7w89CjjqRGpKK9skqta4K6BRb23cOM3nRP7sku6RyIgHvEmC+oFAT+o8wfPH/rpZledmZmUz3+C
 ozlyBBHAF5h1M8Nr8jqdpcl4Uvk9FaQVFBrytQTGFyh2UJA4JJ1oqgNJJj/8EceOoYZWM5UTl02
 tK6S0YRTqz7Ax3P8e/Wa0NpjFTFtEwAE4lSuAfIpdWE2aenH2yMc2M37xyA7lAUyVjJi5vocfNN
 TZOoAHONyzYWGfrgSqiOg0amspyR7GfcpTctPl8cChUc5w8GQsWjt+sf0jdxlLBiab/xSedZqWg
 K3MLxbtnIKRJgFOpdFovAHVwp5qUkuxiqx784dTAbW79V04br1oVb4Qk50+lAiv+nuOZOz1h1zf
 iMRCpGdL4X5hmXgHaXyK26Q/UDLz8eph5dKBz9Vhwf2XjNFXKdExHuiFioawkUHUazlBKu+wR/Q
 1M3E7+7I5A8f+VvXxqeXHG7voUqkd7DPOupwVZJKrqkovLOje4YQQT37/IuJRL2DDf+Ad518Kz
X-Received: by 2002:a05:6808:c1b2:b0:568:66c5:2ad with SMTP id
 5614622812f47-56b96bec3d4mr3123863b6e.34.1794427883331; 
 Wed, 11 Nov 2026 12:11:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:22 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:12 -0700
Subject: [PATCH 05/19] net: lwip: prepare address users for dual-stack builds
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-5-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the generic address helpers for the NTP server check and the DHCP
policy test. With both IP families enabled, ip_addr_t stores the address
in a tagged union rather than a single addr member.

Use the value form of the netconsole destination setter to avoid the
always-true pointer check in the dual-stack macro.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/lwip/sntp.c               | 2 +-
 drivers/net/netconsole-lwip.c | 2 +-
 test/dm/lwip_dhcp_policy.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
index d941060cd5c..25b76f58b06 100644
--- a/cmd/lwip/sntp.c
+++ b/cmd/lwip/sntp.c
@@ -47,7 +47,7 @@ static bool ntp_server_known(void)
 	for (i = 0; i < SNTP_MAX_SERVERS; i++) {
 		const ip_addr_t *ip = sntp_getserver(i);
 
-		if (ip && ip->addr)
+		if (ip && !ip_addr_isany(ip))
 			return true;
 	}
 
diff --git a/drivers/net/netconsole-lwip.c b/drivers/net/netconsole-lwip.c
index af2d591610e..87a42e5dfaa 100644
--- a/drivers/net/netconsole-lwip.c
+++ b/drivers/net/netconsole-lwip.c
@@ -177,7 +177,7 @@ void nc_transport_send(const char *buf, int len)
 	if (err != ERR_OK)
 		goto out;
 
-	ip_addr_set_ip4_u32(&dest, nc_settings.ip.s_addr);
+	ip_addr_set_ip4_u32_val(dest, nc_settings.ip.s_addr);
 	err = udp_sendto_if(nc_pcb, p, &dest, nc_settings.out_port,
 			    nc_net.netif);
 	if (err == ERR_OK &&
diff --git a/test/dm/lwip_dhcp_policy.c b/test/dm/lwip_dhcp_policy.c
index 1e55a0c097a..88f63bc2ec3 100644
--- a/test/dm/lwip_dhcp_policy.c
+++ b/test/dm/lwip_dhcp_policy.c
@@ -78,7 +78,7 @@ static int dhcp_policy_tx(struct udevice *dev, void *packet, unsigned int len)
 	dhcp = netif_dhcp_data(netif_default);
 	ip4addr_aton("1.1.2.3", &dhcp->offered_ip_addr);
 	ip4addr_aton("255.255.255.0", &dhcp->offered_sn_mask);
-	ip4addr_aton("1.1.2.2", &dhcp->server_ip_addr);
+	ipaddr_aton("1.1.2.2", &dhcp->server_ip_addr);
 	netif_set_addr(netif_default, &dhcp->offered_ip_addr,
 		       &dhcp->offered_sn_mask, &dhcp->offered_gw_addr);
 	dhcp->state = DHCP_STATE_BOUND;

-- 
2.53.0

