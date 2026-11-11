Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D20606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WDahFeJL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aWi0Usvx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD32740DCC;
	Wed, 11 Nov 2026 20:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y990jsf5Lx68; Wed, 11 Nov 2026 20:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A40E040DC1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427904;
	b=awJ+nEoTvN7p1sKIIfi3aPKirKbGWkfC2UwqRKMxfWUzg34ssOmHjeiUi9ddzjZ2mJp/
	 N1b2e1AB0MkwjtzPJbJE7p5av2MDDMOcN0LfsKQLn88dbXjAlkaGHRXYFyVMQOj+0MYw4
	 nNJZDTECV9DT/6uETbxRWCts/Choug5SykoCRKNQ71rKOzC6DWNGRKkykMVFJ/x+FdrTM
	 3lB4GtL55zL5xAk7ROqm+Aa9rznaig4Z/3nGdcZAHo9u4DE2zUbuNstCZIydQBVS27sgq
	 tmm1vrSL2rNAjI9dWITjn3Edy5O1NSSyWHF+mU7LKbB/P85kO8WeyhYULaOTvg4r+HA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HnTZZcGL0yyaHJ6LKYegB8BiURaFbqB3gkaPj/5zUHE=;
	b=fPmKDB6PY53bwg9tbCKh2xsQdoT/DMenE0vLxG6/1UYs7IC2FNvSA7Jro18p3YVywIBe
	 Xcl317C/1mn0PHhOPAIHWjpgmQi08bKm6kqKiBIjqBRZazMyC0lqhz9NZycpca6dbVXTj
	 /7+7Wi/LdwHlEZ40zrRZ9QEyAm3INR9b687gheNig/atMwbOHedryD2E975PKibKtS1Is
	 q13AeI+KpMgdQvfl9mMxA/fONQOCh4iAsnSkAtS4l2jdCeRahOxej86HLzwEOsU/3Q1b6
	 yq/lO7GdfBWPsvUQgWYobih6PSFCIh6QoYLQnnQBobUu4nUMBqypLnb/LDrRS6FHqjg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427904;
	bh=HnTZZcGL0yyaHJ6LKYegB8BiURaFbqB3gkaPj/5zUHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WDahFeJLlXbNVTFGA4MatZCiRjJ7tDmo+HYgvVTrPjb2rXFvRRTANbVZz6RI0+qqY
	 l52g2dW5QJNLXOw1tBco99tQISzT07n0xTpyFv+73wzj4aOiAxFy9INtkHPMYI5fcV
	 zidhfkg6+VWsaAVBUUbbjqpoPwVd9fg72Ew8olfOpJrbsd1nUU6JHReo+QxcwCAeX1
	 xzrW8UfiGtKSqC+wXVyIAN4LHMsYkJKFYkClUcZ9wZVaappFHEyc0pLRR3sguW0plD
	 9y8yhxxPidpQ6Mj/inpXbypoV6NXjdB4GGqJ7FGmkEXUmb4QF2mQ64RAa/EHQtbKgg
	 /TJE47JjD1yNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A40E040DC1;
	Wed, 11 Nov 2026 20:11:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 34AC8335
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3234D403D0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lczHC7kYxy2Z for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 61A5E40336
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=aWi0Usvx
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61A5E40336
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:32 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4e4a4d77e5bso130079b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427892; x=1795032692;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HnTZZcGL0yyaHJ6LKYegB8BiURaFbqB3gkaPj/5zUHE=;
 b=aWi0Usvxw0dz9Tmu5zeTHHuwprbLNPLTQdfsPXCkzxQHCM6EXYB0QE4/2Rlmb1jMZ0
 lhP+6vX42UwBplWqURkjrlF3B7pQ2+S+PURGesKoTSM86hLHsjIZ34lVD9BM65TnOIjB
 b7meJQrWoyjS2ipMqpdFyXRo/I48iAYjrTstkp9yLUfjWM1boR7RE4Xk7gnasViCQ/tS
 5VS7tg0524an3IPFgUBjhyYhN0rdkjNpu+fhirUVOyTJKqdPlOV2gt/mOPnVbRZqmTa0
 VKdtxNUReQgMuKdHXZxJtNMnJh/gzhC6/b2gcjNCGQhEuAj5IS7W4e+5lTqZ5IO44RmA
 3cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427892; x=1795032692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HnTZZcGL0yyaHJ6LKYegB8BiURaFbqB3gkaPj/5zUHE=;
 b=IPaX08qSViCR2wgk8M6mBfmcYS00XPOX+3yvVE/xcvduQnnzC4YNeSlsEHeKaFrFUQ
 NvOjZc4vXe+Gc0k6le/tMZZmG8jzocyCTWAlVJx01dPbxzlwggr1dgP6qtEySxWzQezp
 Tt+OB0z+KxSypr0ao+MwcjS7WqF1PHc5j96YXLBZK+5IdvE5zmTvbMqlSj9oeu9wApwn
 xZeYWNu4pWjdamMe9P5JMIkDt5vuD/kBGl4T/8m3dwaovpQGUcrBW7tjYgX0qLptIaeD
 6/g/eMwObByYeY7b/7NIF7TRChq1oNw1l33Dp2nR4UuMyu6SsmYgSUo+EsIoBDRyT8JO
 p2qw==
X-Forwarded-Encrypted: i=1;
 AL+hErHUSmjLjrC4LmDJsOJl6rcYN0pW+H2TWKQ3vWUVMPh2ggLvN8b5cqZKbzYfkfgiD1xPg5JeCTw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9X81zPbWNUUOyWCHS0+qYnTNo3mSmC31Q4qiqyUfhK1uxdPcR0
 adQHi5ePBtvAtQWxSJxFFFbLJDqP6fc5dP0lilkPGrKkPaxDY6gw/kdW
X-Gm-Gg: AYBFou2d9AuoBt/CqglypO94O41mujnCbLJy68ohmnojMNYnU4pV/K29LTLKXHxWHuU
 rKlhu+1V8DipTawH0mcQ8JDDatTwTtVviv/KFPz7CVhzGAS5ag91hpD/q69SAD/MAVlrOPnPsjR
 bA7LuHw2zSGZm8FpLCULWawOyMoz2uiHuHjVfWJ6xrG8TG8cbh9g68mt4bRXvlO4PxKzrvV/RtW
 wz+mSeK8doZQs+1BLK31D4jA1hPG93jHYFb8CxQ4bFzAKVxqph+evWbdJRsd2VbSDMJGkWaXtCB
 ukYmWgz799PQ/Kf5KNMBO9vRzVvTGZplmKgQvHZui/Xooz2qQ95V5L/s+PLBx3yZmHreykODNrW
 h1d2aNNjOrufPEVF4Ah6sOgaQQEqFprZ/AI6UMOMG0ewH8oHfFsDPoJZpJGtFTc1jdZoFtu58s1
 IV7mLSibt3XLGYylA98U6aSZjmIDLVpNA6tPNZuYrykYHaIwsbd9Y0by3umFcox2xaJ0VZSxSuD
 FYWWzcRXkh62NyiMZM5OohgHL7f8qfQBm8Wu6YgjK7gqJOKcSSi7QApXgJCh4GabFEuBDn+pSpH
 5j7OzM+ZlZwGLlIgUN321htqhjrPXnBMSUfJyba5M0IS+ZaHdOX+JL9SoAq4Ot4893l+VbMYr0V
 W2i0xedu600zxCiM0VcvNQm5hQj0zxhzDk/nC3Dejnzb3RO9IdR2cdQsOZ2pvblCSlMhodymWKI
 6VcYJ2kJ+iGG5UIh02LzIr0sb79uWCOu0kP8Wc
X-Received: by 2002:a05:6808:5142:b0:564:3e9e:b498 with SMTP id
 5614622812f47-56cd673bd8bmr426911b6e.22.1794427891758; 
 Wed, 11 Nov 2026 12:11:31 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:31 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:18 -0700
Subject: [PATCH 11/19] net: lwip: report IPv6 TFTP port-unreachable errors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-11-eb0ee8f8da1a@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Forward checksum-validated ICMPv6 destination-unreachable messages to
the U-Boot error handler. Match the quoted IPv6 source and UDP tuple
against the active TFTP transfer so a closed server port fails promptly
instead of timing out.

Read quotations across pbuf boundaries and ignore malformed or unrelated
packets. Retain the existing configurable ICMP diagnostics for IPv6.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/core/ipv6/icmp6.c |  9 +++++++++
 lib/lwip/u-boot/lwip-hooks.h        |  5 +++++
 net/lwip/icmp_unreach.c             | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/lib/lwip/lwip/src/core/ipv6/icmp6.c b/lib/lwip/lwip/src/core/ipv6/icmp6.c
index ed0bd7b748a..40b9c5966aa 100644
--- a/lib/lwip/lwip/src/core/ipv6/icmp6.c
+++ b/lib/lwip/lwip/src/core/ipv6/icmp6.c
@@ -57,6 +57,10 @@
 
 #include <string.h>
 
+#ifdef LWIP_HOOK_FILENAME
+#include LWIP_HOOK_FILENAME
+#endif
+
 #if !LWIP_ICMP6_DATASIZE || (LWIP_ICMP6_DATASIZE > (IP6_MIN_MTU_LENGTH - IP6_HLEN - ICMP6_HLEN))
 #undef LWIP_ICMP6_DATASIZE
 #define LWIP_ICMP6_DATASIZE   (IP6_MIN_MTU_LENGTH - IP6_HLEN - ICMP6_HLEN)
@@ -113,6 +117,11 @@ icmp6_input(struct pbuf *p, struct netif *inp)
 #endif /* CHECKSUM_CHECK_ICMP6 */
 
   switch (icmp6hdr->type) {
+  case ICMP6_TYPE_DUR:
+#ifdef LWIP_HOOK_ICMP6_DEST_UNREACH
+    LWIP_HOOK_ICMP6_DEST_UNREACH(icmp6hdr->code, p);
+#endif
+    break;
   case ICMP6_TYPE_NA: /* Neighbor advertisement */
   case ICMP6_TYPE_NS: /* Neighbor solicitation */
   case ICMP6_TYPE_RA: /* Router advertisement */
diff --git a/lib/lwip/u-boot/lwip-hooks.h b/lib/lwip/u-boot/lwip-hooks.h
index a4a22bdaf04..11f6dd4a71c 100644
--- a/lib/lwip/u-boot/lwip-hooks.h
+++ b/lib/lwip/u-boot/lwip-hooks.h
@@ -23,6 +23,11 @@ int net_lwip_ip6_static_prefix(struct netif *netif, unsigned int index,
 const ip6_addr_t *net_lwip_ip6_gateway(struct netif *netif,
 				       const ip6_addr_t *dest);
 #define LWIP_HOOK_ND6_GET_GW net_lwip_ip6_gateway
+#ifdef CONFIG_PROT_ICMP_LWIP
+struct pbuf;
+void net_lwip_icmp6_dest_unreach(unsigned int code, struct pbuf *p);
+#define LWIP_HOOK_ICMP6_DEST_UNREACH net_lwip_icmp6_dest_unreach
+#endif
 #if LWIP_ND6_RDNSS_MAX_DNS_SERVERS
 int net_lwip_rdnss_accept(struct netif *netif);
 #define LWIP_HOOK_ND6_RDNSS_ACCEPT net_lwip_rdnss_accept
diff --git a/net/lwip/icmp_unreach.c b/net/lwip/icmp_unreach.c
index 05749664c46..0c4428dc9fe 100644
--- a/net/lwip/icmp_unreach.c
+++ b/net/lwip/icmp_unreach.c
@@ -8,6 +8,8 @@
 #include <lwip/ip4_addr.h>
 #include <lwip/pbuf.h>
 #include <lwip/prot/ip4.h>
+#include <lwip/prot/ip6.h>
+#include <lwip/prot/icmp6.h>
 #include <lwip/prot/udp.h>
 
 static void tftp_port_unreachable(struct pbuf *p, u16 offset)
@@ -74,3 +76,34 @@ void net_lwip_icmp_dest_unreach(int code, struct pbuf *p)
 	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT) && code == ICMP_DUR_PORT)
 		tftp_port_unreachable(p, IPH_HL_BYTES(iphdr) + sizeof(struct icmp_hdr));
 }
+
+#if CONFIG_IS_ENABLED(IPV6)
+void net_lwip_icmp6_dest_unreach(unsigned int code, struct pbuf *p)
+{
+	struct ip6_hdr quoted;
+	struct udp_hdr udp;
+	ip6_addr_t local;
+	ip_addr_t peer;
+	u16 offset = sizeof(struct icmp6_hdr);
+
+	if (IS_ENABLED(CONFIG_LWIP_ICMP_SHOW_UNREACH))
+		printf("ICMPv6 destination unreachable (code %u) from %s\n",
+		       code, ip6addr_ntoa(ip6_current_src_addr()));
+	if (!IS_ENABLED(CONFIG_CMD_TFTPBOOT) || code != ICMP6_DUR_PORT)
+		return;
+	/* Our UDP requests have no extension headers. Ignore other quotations. */
+	if (pbuf_copy_partial(p, &quoted, sizeof(quoted), offset) != sizeof(quoted) ||
+	    IP6H_V(&quoted) != 6 || IP6H_NEXTH(&quoted) != IP6_NEXTH_UDP ||
+	    IP6H_PLEN(&quoted) < UDP_HLEN)
+		return;
+	if (pbuf_copy_partial(p, &udp, sizeof(udp), offset + IP6_HLEN) != sizeof(udp) ||
+	    lwip_ntohs(udp.len) < UDP_HLEN)
+		return;
+	ip6_addr_copy_from_packed(local, quoted.src);
+	if (!ip6_addr_zoneless_eq(&local, ip6_current_dest_addr()))
+		return;
+	ip_addr_copy_from_ip6_packed(peer, quoted.dest);
+	ip6_addr_assign_zone(ip_2_ip6(&peer), IP6_UNICAST, ip_current_netif());
+	tftp_handle_port_unreachable(&peer, lwip_ntohs(udp.src), lwip_ntohs(udp.dest));
+}
+#endif

-- 
2.53.0

