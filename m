Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F68606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eXpzsKlD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvoHR1SJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6173C60673;
	Mon, 23 Nov 2026 16:59:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s10LD4ZM1ipI; Mon, 23 Nov 2026 16:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 245BB606D5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795453146;
	b=M+80QZzWGNaFSrWfRMrLmXc/+GdvTSFDGyI2CTNtYVp+9Zb+brDC1InlhFne2Uc4evwJ
	 ZUCaGtXveWa5hr2y5w8BsE8FYfX6JY8lSvxBnqhE+o15FZP0sWrhKEdgFbxY2LenvfA9W
	 cT+BmCo3eWpa3EbHAS83bg0+HU4dI489Kdu2/yx84w/MDgYKDqlQjvkkIH/i/iGtOnsNN
	 Ahm+RVcGr0z49HgWl7eWyO8pHj59+6WBg4Ysvl67RgA8y1R4n1G2dLJ82ckuvkcNh1356
	 vHbl84x0HNGBfkkHDU7qyF96u0UZ6NLQxeImANxS7L/m6b3arshrXnXSvHQttbHGk0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795453146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TNB8OLTLesVekGXUd3e8PJp6ntTCBpb7JZyovOiMrGc=;
	b=e3opyWNMdrIEjxmpRU8blB16x6m3ob5JbmJUG052sK2QupLwKe1l8rLGHRs4j4xuij9F
	 SNZrziaaWPHz2BHLx7ua/cbB7Gz+yi+Dxoq818/XfzpTMdxuTuQ3gh4SGUxb8ribSRF7r
	 Uyt+knRpXsqtioRnIcncwHxI3lS6/f1YRoMPtep67wcNrfBiO3Q/nHU5MjTQMXeuGFeXI
	 fI6icmU/AMTBPtpgQBLDYz1ik9jsIQvWvGGOErsiUcbo+XdjBMg2it3+Sg30E/NUi4OI8
	 uJNhQWqrxchn6Lyn2GUhD723WNheXORJPUtSNQt1nKNHq4/vK+lv7yaJUx4eemuFMug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BvoHR1SJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795453146;
	bh=TNB8OLTLesVekGXUd3e8PJp6ntTCBpb7JZyovOiMrGc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eXpzsKlDZZ4xLSVlm6S1HDiEI8PqE3f7kvmWV5HSvE/Mf/WQMx9zl5FURnQSqswrW
	 DM2g2eEZzW1LxUGFcdQBJxKxmaUOG4CSzkiRvtWVcrqRM2R+Txfb/D6hmudsIhfonL
	 wwjLeSbnKrHvI/xj9yHgf64GnVRuFAtAUMB4RemPyA4iMYbFLWhEcVox8l3Fo/lbBD
	 YfWSXF81VSe/ixeLCbFtwSnpLIgP3ubGkxGk8cmLkfCObsum54wl9GTCD8lA8P3NIQ
	 FeffcLI1ob4+efFctBzkVszgdNZO3pLa4ZKlAZMVVcxSZkKuEEAwSG2qdnP7NQQ6fd
	 tmBKtowMjAAxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 245BB606D5;
	Mon, 23 Nov 2026 16:59:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41F1B499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EE48606D5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:59:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3wjoIDPfHt3 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 16:59:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C37E860673
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=BvoHR1SJ
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C37E860673
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:59:03 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-716c0217635so4270129eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795453142; x=1796057942;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TNB8OLTLesVekGXUd3e8PJp6ntTCBpb7JZyovOiMrGc=;
 b=BvoHR1SJ1FvRUKYHJnNC29RCd87YSwlqhTHy2pvbDfROSuqbdzVDXQAAvj0jfQ3NDk
 X0u0nVrWRWxU7acKH79ZoAIIXWSw9VASvqzXtdn5u4JY3wQBqo17N5gbFRJYj6GIlESy
 17QU5Kcde8QWSIs2k6xpzTrAHb4TZaYDvuOjg2ath/5Ri3A1y8cAQ08bxuMHWALErUwJ
 DGJ9V58/Rc1Zs38OSJGpxnLebFAwDlaT4XKYLfOqwj7R8r16e7OSwqEPdLd7DYJVwghg
 51z419RZDYBu0fsxR8tboFr1DVVW/5bvv6x7jvl0fOP6zTRYt2UregOWsQ4275gZTj8R
 q5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795453142; x=1796057942;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TNB8OLTLesVekGXUd3e8PJp6ntTCBpb7JZyovOiMrGc=;
 b=n+CQUiS0iU6ZUeTWfmHKEN5C9Hq4IbUcUhIxGVNh6rIqwjXqYOWKyp2eXAstRz1nv6
 Hug0Odbz7m5/tG/DLUptdvhQ+kf6LkOhKXjckr6UET5GK6LO81c4dhvk08u07nDdK0ss
 d0CUKfQTGrleomV5unmqSnjWhvpsZMkATY45udwp8IAjC8uSTAP8G8E7RnKRugSjonOD
 WahVi2rbOAv4qUhzR8SMl5BkChAVLPw1Y4Q1Y8pK78ILd7NYAwO/hD/FJzvx+BF3efzE
 O8kU+6RHHcmuMY/dLUldiNKEv9Z5lxg95Cubc02Lf3eU5uxyYqlw1MLyPW9biNPOij+o
 4yOA==
X-Gm-Message-State: APuU4Z+/RBdi6g/4dlXNqLikxi7BQDA2zLz3fHiY7jrkEu8qizs4tku0
 lOgYsJskFsSpjkjfKd3dx5yysXih5VIYmauEktQhpYtGdSR6d58JRd/O
X-Gm-Gg: AZFdTZfKqfQm59RhxEcsuk7sBXRL686iPH64O9wPCIgProouzYk7GfxYrrnJoJo7TQA
 /Xzg+yXay6qQ2N+t5yNyITNQgnKoVrcsEhhXqwNf/y9bPk8xbgBWaoJmMEWXLtIbo7J/3au/qu3
 +ZyE/2eTq/jSEFNfLpeYOfGBsQRp3jzFlE559jyW7AvDrUBst97KeGUUsW5C7Tg19gS9VX9jWXo
 TOGCuMdCy3Lrb+AM1SAbyWG9giT2X+rugY2fI17UmYymGYDxrUsX8jdxqDw3QChghq72cEVONKr
 WAPvPgX/Jie1hxWSBZSioFZaQRszeo+AQvvK2hzY9IWYN1d0bSe3Lc6x4t41vIQiErpb18mMxHH
 1oHeczURpgBgUi9r2VqicCmdrxaP5qtvkU6SVzH2q+05Y8QwZIxOlR6RPnUvmua088/e4E4tyEM
 UnG7/rR59MWN90EhGdxUwKGjDMbXb8H13+23Req8gD8IaV6taNYimx3jfcVWhZ6en4ULPY+CI3b
 OAYS0LUr9nXNNl6i7d9whWLlRbiCgPyl1NaZTDqWVdkq9wsLPWt92FkVys/sF7yQVoNctimMkE7
 Ge27CWIIt0uDyhPZWNmU7JC9q29xjkjxczckd4HSDSGj5q3M8117U8n6eccxplC/huJxI2jJLgH
 yJAkwy0r6oSRihQHm9N7HvK310sSJRMKofDS8EC/PSAL83jYspt5MATf5xk1pOC2d07Mu3uQP0p
 HSLdcSJrRZgEKtGTFObFxMlQUgVTpGO04L07BpVW/1IMxKgidX8CU=
X-Received: by 2002:a05:6820:4cc8:b0:71a:ea4b:a2b6 with SMTP id
 006d021491bc7-71b327a345cmr9986297eaf.53.1795453142147; 
 Mon, 23 Nov 2026 08:59:02 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd3008160dsm11465168fac.16.2026.11.23.08.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:59:01 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 09:58:49 -0700
Subject: [PATCH] net: lwip: accept IPv6 literals with a dotted IPv4 tail
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-submit-lwip-ipv6-dotted-tail-v1-v1-1-1356075a38fb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQ6CMAyA4VchPduETlODr2I8AKtag7BsZZoQ3
 p2Jx//y/QskiSoJLtUCUbImncYSdKigf7bjQ1B9aXC1YyJ3xDR3bzUcPhpQQ2b0k5l4tFYHzIQ
 dk5zOdcMNOyhKiHLX73643v5diJf09mNhXTeCnvAYgwAAAA==
X-Change-ID: 20261123-submit-lwip-ipv6-dotted-tail-v1-b61e47096962
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Setting ip6addr to 2001:db8::192.0.2.1 fails even though it names
the same address as 2001:db8::c000:201. The U-Boot validator only
accepts hexadecimal groups, and lwIP's parser only recognizes a
dotted tail with certain colon counts.

Decode the final four decimal octets as the last two IPv6 groups and
apply the existing address checks to the binary result. Use the same
parsing for numeric destinations and DNS servers, and check the address
length separately from any prefix on ip6addr.

Reported-by: Jerome Forissier <jerome.forissier@arm.com>
Closes: https://lore.kernel.org/r/e4e021c4-af32-48fd-9891-454f36ba0242@arm.com/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Follow-up to the applied lwIP IPv6 networking series.
---
 include/net-lwip.h  |  1 +
 net/lwip/dns.c      |  7 +---
 net/lwip/net-lwip.c | 97 +++++++++++++++++++++++++++++++++++++++++------------
 test/dm/lwip_ipv6.c | 25 ++++++++++++--
 4 files changed, 100 insertions(+), 30 deletions(-)

diff --git a/include/net-lwip.h b/include/net-lwip.h
index 2f66732fd85..41db8abfda6 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -82,6 +82,7 @@ void net_lwip_stop(struct net_lwip_ctx *ctx);
 int net_lwip_restart(struct net_lwip_ctx *ctx);
 int net_lwip_refresh(struct net_lwip_ctx *ctx);
 int net_lwip_poll(void);
+bool net_lwip_parse_ip(const char *text, ip_addr_t *addr);
 int net_lwip_resolve(struct net_lwip_ctx *ctx, const char *name,
 		     ip_addr_t *addr, u8 type);
 int net_lwip_prepare_addr(struct net_lwip_ctx *ctx, ip_addr_t *addr);
diff --git a/net/lwip/dns.c b/net/lwip/dns.c
index 9c3e8a851f2..df542e312ea 100644
--- a/net/lwip/dns.c
+++ b/net/lwip/dns.c
@@ -85,13 +85,8 @@ int net_lwip_dns_refresh(struct net_lwip_ctx *net)
 		if (!value || !*value)
 			continue;
 		configured++;
-		if (!ipaddr_aton(value, &servers[count]) || ip_addr_isany(&servers[count]))
+		if (!net_lwip_parse_ip(value, &servers[count]) || ip_addr_isany(&servers[count]))
 			return -EINVAL;
-#if CONFIG_IS_ENABLED(IPV6)
-		if (IP_IS_V6(&servers[count]) &&
-		    net_lwip_ip6_aton(value, ip_2_ip6(&servers[count])))
-			return -EINVAL;
-#endif
 		ret = dns_server_ready(net, &servers[count]);
 		if (ret) {
 			pending |= ret == -EAGAIN;
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 726731bc2fa..8c592d3e72f 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -403,43 +403,88 @@ void net_lwip_ip6_update_lifetimes(void)
 	nd6_age_lifetimes(min_t(u64, elapsed, U32_MAX));
 }
 
+static int parse_ip4_tail(const char *p, u8 *bytes)
+{
+	for (int i = 0; i < 4; i++) {
+		const char *start = p;
+		unsigned int value;
+
+		while (isdigit(*p))
+			p++;
+		if ((p - start > 1 && *start == '0') ||
+		    net_lwip_parse_decimal(start, p - start, 255, &value))
+			return -EINVAL;
+		bytes[i] = value;
+		if (i != 3 && *p++ != '.')
+			return -EINVAL;
+	}
+
+	return *p ? -EINVAL : 0;
+}
+
 int net_lwip_ip6_aton(const char *text, ip6_addr_t *addr)
 {
 	const char *p = text;
-	unsigned int groups = 0;
-	bool compressed = false;
+	__be16 words[8];
+	int nr = 0, gap = -1;
 
-	/* Validate groups and compression before using lwIP's permissive parser. */
 	if (*p == ':') {
 		if (*++p != ':')
 			return -EINVAL;
-		compressed = true;
+		gap = 0;
 		p++;
 	}
 	while (*p) {
 		const char *start = p;
+		unsigned int value = 0;
 
-		while (isxdigit(*p))
-			p++;
-		if (p == start || p - start > 4 || ++groups > 8)
+		if (nr == ARRAY_SIZE(words))
 			return -EINVAL;
+		while (isxdigit(*p)) {
+			if (p - start == 4)
+				return -EINVAL;
+			value = (value << 4) | hex_to_bin(*p++);
+		}
+		if (*p == '.') {
+			u8 bytes[4];
+
+			/* A final dotted quad occupies two 16-bit groups. */
+			if (nr + 2 > ARRAY_SIZE(words) || parse_ip4_tail(start, bytes))
+				return -EINVAL;
+			words[nr] = htons((bytes[0] << 8) | bytes[1]);
+			words[nr + 1] = htons((bytes[2] << 8) | bytes[3]);
+			nr += 2;
+			break;
+		}
+		if (p == start)
+			return -EINVAL;
+		words[nr++] = htons(value);
 		if (!*p)
 			break;
 		if (*p++ != ':')
 			return -EINVAL;
 		if (*p == ':') {
-			if (compressed)
+			if (gap >= 0)
 				return -EINVAL;
-			compressed = true;
+			gap = nr;
 			p++;
 		} else if (!*p) {
 			return -EINVAL;
 		}
 	}
-	if (compressed ? groups >= 8 : groups != 8)
+	if (gap >= 0) {
+		int zeros = ARRAY_SIZE(words) - nr;
+
+		if (!zeros)
+			return -EINVAL;
+		memmove(words + gap + zeros, words + gap, (nr - gap) * sizeof(*words));
+		memset(words + gap, 0, zeros * sizeof(*words));
+	} else if (nr != ARRAY_SIZE(words)) {
 		return -EINVAL;
-	if (!ip6addr_aton(text, addr) || ip6_addr_isany(addr) ||
-	    ip6_addr_ismulticast(addr) || ip6_addr_isloopback(addr) ||
+	}
+	memcpy(addr->addr, words, sizeof(words));
+	ip6_addr_clear_zone(addr);
+	if (ip6_addr_isany(addr) || ip6_addr_ismulticast(addr) || ip6_addr_isloopback(addr) ||
 	    ip6_addr_isipv4mappedipv6(addr) || ip6_addr_isipv4compat(addr))
 		return -EINVAL;
 
@@ -450,7 +495,8 @@ static int net_lwip_ip6_env(const char *name, ip6_addr_t *addr, unsigned int *pr
 {
 	const char *value = env_get(name);
 	char text[IP6ADDR_STRLEN_MAX];
-	char *slash;
+	const char *slash;
+	size_t len;
 	unsigned int bits;
 
 	ip6_addr_set_zero(addr);
@@ -458,15 +504,17 @@ static int net_lwip_ip6_env(const char *name, ip6_addr_t *addr, unsigned int *pr
 		*prefix = 64;
 	if (!value || !*value)
 		return 0;
-	if (strlcpy(text, value, sizeof(text)) >= sizeof(text))
+	slash = strchr(value, '/');
+	len = slash ? slash - value : strlen(value);
+	if (len >= sizeof(text))
 		goto invalid;
-	slash = strchr(text, '/');
+	memcpy(text, value, len);
+	text[len] = '\0';
 	if (slash) {
 		if (!prefix || net_lwip_parse_decimal(slash + 1, strlen(slash + 1),
 						      128, &bits))
 			goto invalid;
 		*prefix = bits;
-		*slash = '\0';
 	}
 	if (net_lwip_ip6_aton(text, addr))
 		goto invalid;
@@ -1063,16 +1111,23 @@ int net_lwip_poll(void)
 	return ret;
 }
 
+bool net_lwip_parse_ip(const char *text, ip_addr_t *addr)
+{
+#if CONFIG_IS_ENABLED(IPV6)
+	if (strchr(text, ':')) {
+		IP_SET_TYPE_VAL(*addr, IPADDR_TYPE_V6);
+		return !net_lwip_ip6_aton(text, ip_2_ip6(addr));
+	}
+#endif
+	return ipaddr_aton(text, addr);
+}
+
 int net_lwip_resolve(struct net_lwip_ctx *ctx, const char *name,
 		     ip_addr_t *addr, u8 type)
 {
-	if (ipaddr_aton(name, addr)) {
+	if (net_lwip_parse_ip(name, addr)) {
 		if (type != IPADDR_TYPE_ANY && IP_GET_TYPE(addr) != type)
 			return -EAFNOSUPPORT;
-#if CONFIG_IS_ENABLED(IPV6)
-		if (IP_IS_V6(addr))
-			return net_lwip_ip6_aton(name, ip_2_ip6(addr));
-#endif
 		return 0;
 	}
 	/* A malformed address is not a DNS hostname. */
diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
index bd68ac0e356..813a4b284be 100644
--- a/test/dm/lwip_ipv6.c
+++ b/test/dm/lwip_ipv6.c
@@ -832,19 +832,38 @@ static int ip6_test_config(struct unit_test_state *uts, struct ip6_test *test)
 		"2001:db8:0:0:0:0:1:", ":2001:db8:0:0:0:0:1", "2001:db8:::1",
 		"2001:db8:0:0:0:0:0:1::", "::2001:db8:0:0:0:0:0:1",
 		"2001:db8::10/18446744073709551680", "2001:db8::10/4294967360",
+		"::ffff:192.0.2.1", "::192.0.2.1", "ff02::192.0.2.1",
+		"2001:db8::192.0.2", "2001:db8::192..2.1", "2001:db8::192.00.2.1",
+		"2001:db8::192.0.2.256", "2001:db8::192.0.2.1:2", "2001:db8::192.0.2.1x",
+		"1:2:3:4:5:192.0.2.1", "1:2:3:4:5:6::192.0.2.1", "1:2:3:4:5:6:7:192.0.2.1",
 	};
 	static const char *const valid[] = {
 		"2001:db8:0:0:0:0:0:1", "2001:db8::1", "2001:db8:0:0:0:0:1::",
 		"::2001:db8:0:0:0:0:1", "2001::", "2001:0:0:0:0:0:0:0",
 	};
+	static const struct {
+		const char *mixed, *hex;
+	} literals[] = {
+		{ "2001:db8::192.0.2.1", "2001:db8::c000:201" },
+		{ "2001::abcd:0.0.0.0", "2001::abcd:0:0" },
+		{ "1:2:3:4:5:6:255.0.0.255", "1:2:3:4:5:6:ff00:ff" },
+	};
 	struct net_lwip_ctx other = {};
 	ip6_addr_t expected;
+	ip_addr_t addr;
 	ip4_addr_t ip4;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(valid); i++)
 		ut_assertok(net_lwip_ip6_aton(valid[i], &expected));
 	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	for (i = 0; i < ARRAY_SIZE(literals); i++) {
+		ut_assert(ip6addr_aton(literals[i].hex, &expected));
+		ut_assertok(net_lwip_resolve(&test->net, literals[i].mixed, &addr,
+					     IPADDR_TYPE_ANY));
+		ut_assert(IP_IS_V6(&addr));
+		ut_assert(ip6_addr_zoneless_eq(&expected, ip_2_ip6(&addr)));
+	}
 	ip4 = *netif_ip4_addr(test->net.netif);
 	for (i = 0; i < ARRAY_SIZE(invalid); i++) {
 		ut_assertok(env_set("ip6addr", invalid[i]));
@@ -852,12 +871,12 @@ static int ip6_test_config(struct unit_test_state *uts, struct ip6_test *test)
 		ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 0)));
 		ut_assert(ip4_addr_cmp(&ip4, netif_ip4_addr(test->net.netif)));
 	}
-	ut_assertok(env_set("ip6addr", "2001:db8:1::10/00064"));
+	ut_assertok(env_set("ip6addr", "2001:0db8:1234:5678:9abc:def0:192.168.100.200/00064"));
 	ut_assertok(env_set("gatewayip6", "ff02::1"));
 	ut_asserteq(-EINVAL, net_lwip_ip6_init(&test->net));
 	ut_assertok(env_set("gatewayip6", "fe80::1"));
 	ut_assertok(net_lwip_ip6_init(&test->net));
-	ip6addr_aton("2001:db8:1::10", &expected);
+	ip6addr_aton("2001:db8:1234:5678:9abc:def0:c0a8:64c8", &expected);
 	ut_assert(ip6_addr_zoneless_eq(&expected, netif_ip6_addr(test->net.netif, 1)));
 	ut_asserteq(IP6_ADDR_TENTATIVE, netif_ip6_addr_state(test->net.netif, 1));
 	ut_assertok(net_lwip_ip6_init(&test->net));
@@ -1379,7 +1398,7 @@ static int ip6_test_dns(struct unit_test_state *uts, struct ip6_test *test)
 	ulong start;
 
 	ut_assertok(env_set("ipaddr", NULL));
-	ut_assertok(env_set("dnsip6", "fe80::2"));
+	ut_assertok(env_set("dnsip6", "fe80::0.0.0.2"));
 	ut_assertok(run_command("dns ipv6.test dnsresult -ipv6", 0));
 	ut_asserteq_str("FE80::2", env_get("dnsresult"));
 	ut_assertok(run_command("ping6 ping.test", 0));

---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-lwip-ipv6-dotted-tail-v1-b61e47096962

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

