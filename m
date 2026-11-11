Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9667606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cIK7Di1X;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=baIUEscG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9963260DF7;
	Wed, 11 Nov 2026 20:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYaZyJUMOrWZ; Wed, 11 Nov 2026 20:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B7B2A60E24
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427917;
	b=KU3t/nKa6TcaOA45DyChFsenDfgfGFnvTM5gOTETzxabQ4cHOy1KJ+XYi9+dq8cBZuDl
	 3c8U38JTV/UvJ1gdERx3/PLoVi2qfmErJTiuu9NT0juhgXwsccN2Fm6YEohJkGNK1lhG0
	 wZLzQPPr/n70zh/9R/Hf4kKXJgKfWsM3X+LF/HJt7nP3XIJEJElHI7EXD/mgeyeWEQ5oI
	 NN9gCGA0EN2MVlfjWwKiv1vyut812H4hvDd3WJXXjWFBsbz8ldL9HqcvVFW5IXxCg4Gy2
	 BbRJR5zO3iMgJXGNVyG3P6l5w661q6xh16UKUfclbcKvy07+tGpGZbhCoQ+oQD/RKlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lYe/4JsxfyD1Y6fk1FiF+2wApJ/3kJ5hPsWINUdoZfI=;
	b=nooFymFYv1mWcBl/Xm0FgAQZCAQDWXaxA/vHUe/IhtDFejGn5NGpckdUjlicHINEqZ8S
	 xby47PPjezfHJY6y0V44vaLe2QU07FE3+dLzKk7HVY47eLiud6kKHnNBkEiS4m1ZuVo4S
	 2iBgf8wQH1OR7eizj3mN3Df8tIvxQNm4xCGXORdUU93IfvfZ0vUxSULmbopVzaDp3RsMW
	 vR78gm4u5utot9QKqiymysoRmywvXMXucN3Sbx297dMFZCVqmTxIeArg8CoDG/jRbRru0
	 Ix1vESIayvR4xWvGpM3/RDhgeddPJDxr/oZSNFF9vAWWXWQFbaI9UeVZtrvfHvP4HHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427917;
	bh=lYe/4JsxfyD1Y6fk1FiF+2wApJ/3kJ5hPsWINUdoZfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIK7Di1XeiUPoHJBenoeDGtQ+kTrgsNORDZxXVta3Uks7/2Cl3x2a8khJxwACJVy6
	 eXlvQRMkbWngoTRhnvJOQ+9g6lQ/fI51AotJQZ1P+a7bA9GRI/hp20GiQAPsFHHRC0
	 M32fA1exSqvp/MeDdWPu0SN3PECuZJ83KMSbhV32jp2mU312kh5US2y0pLZM03hPaR
	 kVyjB27XYfPlN1igyOh9l/AJu9wh+b9CjSfagtE5t6vStSbtieDASAiu7A12Gkzq04
	 9+jhpkozAgO4chLqkNH9xtKtvIdQdc5C3NwdSi73qrLroaRUOcDyEf5e5eq4RPyrgd
	 n353I7QB102/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7B2A60E24;
	Wed, 11 Nov 2026 20:11:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C2DB2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D8514099C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6X_PoCe6M8w for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EB6240DB7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=baIUEscG
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EB6240DB7
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:41 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4c5d8c7f326so1399415b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427900; x=1795032700;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYe/4JsxfyD1Y6fk1FiF+2wApJ/3kJ5hPsWINUdoZfI=;
 b=baIUEscGlciJXt2qDNVq0lZxZAfQgMGq2mFdPBW5ypCH/8udWJ/DixD3KIa2p7Z93t
 rMgpzm4pJLqAU7aSd7EH9GhqN2Ilk48Tm8Ea9q6Y46T4nH8QY+3hCDM01enMoCJ/7ASj
 NftAUMRn2cY0A5qD19AhGIfacMzaAl3YPG6VBvq3ChXouVTCeO0D5bLdgXpgKgFYqTY+
 weTFbRFsBLJYpApZNLpl9fZ7tGmXByImEhs6GATVl6mTzZLzNVEfl3bXLbMFk/ZtUR6q
 9DLL8pEJsxqXcD+tmkpxBGHzQZtUH1liHF/Xxbfd9ep62eSSApMgOYBVNSfBaP5kYwg8
 eMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427900; x=1795032700;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lYe/4JsxfyD1Y6fk1FiF+2wApJ/3kJ5hPsWINUdoZfI=;
 b=06nNDiCzM0HVxSku27sK5/tRCUxDrhd6hgkKpaW+bAVhPSCgI4D9sEhCDvXihmx4V4
 n/CQPr3coOa28dnkBL8yXJdr8FXLpc+RFRjDs1cJpOd9o7oA8F+AsHcJ/HY6gBB3Y7ZQ
 SATL+P4aCiMN3gyyNxcycxd1ZkxML5qjBeQpbuWnxgCa+7Pk6z9NXswGgUCNyFf83lEg
 ffAXhXLTeMcHuJwKT9e9KQ0XCqsfBCbnIRI8QhWVTOOyWf3ZwTAB3/hUadixsFuqa5Oq
 bJGNasoiTELIh10ZjRzfygbmnvmNauYbwKG50BSu39L1emclUUqy3tU5PfWjfR91Yfhc
 AUJw==
X-Forwarded-Encrypted: i=1;
 AL+hErFvluzSZvJSAKQEXVBcWZ0FlalQtsNDN8QvrgIl4fYlY+IEI3jWWEwhAjgmuvKntSbkViCjrwg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z93XJkS4/UQ58+tyaECyMKo6DwEY0ggizkHmMKfBb2qundHQ3Iq
 4wQCNE1JK4+1vRxBCyI6C50ODqPSdTDvd9zAEuhmoh7BVIDK4U/UmLNA
X-Gm-Gg: AYBFou1E2K6NRSVH9nRGmE/2V1lBxiKiuXYTX+boVuhQzD0u/Rnl1EVcXvXmQaP4dPy
 /w8q8tKYctFTzIDdrBeQzdhlLhemLHnT52eqm2nDvIiV0hcII/d7AOKl6AS4yJb+lRPwfyyrSxO
 3AUTkbQImg0LSbpYGsFPc+SByr2RK2ey3PZzVlmJmqn/JIjDGkbowkKJT0bqaoF42iNzOWZFsIX
 5dODNA07s/V5UO8Kg5VhENTxp7tHrV3H1MSa2h3Xs3cRwzhJl6t8S9nhdfv55Ib0o/5ae1aEKMG
 q8fl+ykvt+vERrW/BO74Kz162sMaRswWdPf1m6/PYCibUibl72epHAFWJHaC761XEOFjvQ51Qct
 QpHPX8j6sTEtKLnNzbYNYlCUAB/fksb2KHG+FNoYtFg0eiFDKj/vInt5vqTSg+wbHzMczaacaIW
 i8oQ0ktekjWBJ4c6Sz5OG4cnPcjlAfQdTDlovE4K29JUOlHI+JXC8qXuNWlvPW27GAaB0JAqipZ
 gq2eZX39H8pxeHOzW8ZVxVIkMvJu8Fu3LR09AFO67LxnRqwVmYOjXlxacPLmCFfFB+FYK4r+YOm
 udyaWBYdoLWK9t+mtMxmBlKfBFCq4w+embBZ/BplbLUW+6qVOhRBcXmfjCBs1KINxhcc4M6VvkX
 2uQ3N18kWny7ab1VR2x2zMtIUp4Wv1nJ7S4XhjNqvFATQQWA3BVBs83/DcmfkVFcshVhDEYwY7t
 dR9MSfoHR2sqOru8YjQZ5mLm5J6M5MHn+BbH9a2j9u9sgte/SDvbY=
X-Received: by 2002:a05:6808:f13:b0:567:cac4:f1c3 with SMTP id
 5614622812f47-56b9628f6demr2934344b6e.23.1794427899433; 
 Wed, 11 Nov 2026 12:11:39 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:24 -0700
Subject: [PATCH 17/19] test: net: exercise lwIP IPv6 addressing and DNS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-17-eb0ee8f8da1a@gmail.com>
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

Add a sandbox IPv6 peer for neighbor and router discovery, duplicate
address detection and DNS. Check shared IPv4 traffic, static prefix
boundaries, address-specific DAD conflicts and resolver readiness.

Exercise RDNSS backup selection after expiry and withdrawal, multi-server
options in chained buffers, reordered updates, single-server refreshes
and replacement of a full server table. Check that temporary or
same-address DNS overrides preserve lifetime ownership, including an
advertisement arriving before resolver refresh.

Exercise address, route, prefix and RDNSS expiry after gaps in polling,
including readiness and resolver checks before polling resumes. Preserve
static and infinite lifetimes and keep lifetime catch-up independent of
DAD progression. Verify refresh after an idle interval and final release.

Reject malformed IPv6 groups and overflowing decimal prefix lengths
while accepting valid boundary values.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/Makefile    |    3 +
 test/dm/lwip.c      |   26 ++
 test/dm/lwip_ipv6.c | 1116 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1145 insertions(+)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 112326c85bb..2ebebbc7483 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -55,6 +55,9 @@ endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_PROT_UDP_LWIP),yy)
 obj-y += lwip.o
 endif
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_PING6),yy)
+obj-y += lwip_ipv6.o
+endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_DHCP),yy)
 obj-y += lwip_dhcp.o
 obj-y += lwip_dhcp_options.o
diff --git a/test/dm/lwip.c b/test/dm/lwip.c
index d152294d6f8..f5932a0ef97 100644
--- a/test/dm/lwip.c
+++ b/test/dm/lwip.c
@@ -42,6 +42,32 @@ struct lwip_test_recv_ctx {
 	int nested_poll_ret;
 };
 
+static int dm_test_lwip_decimal(struct unit_test_state *uts)
+{
+	static const char *const invalid[] = {
+		"", "-1", "+1", " 1", "1 ", "1x", "65536", "4294967365",
+		"18446744073709551685", "99999999999999999999999999999999999",
+	};
+	const char *padded = "0000000000000000000000065535";
+	unsigned int value = 123;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(invalid); i++) {
+		ut_asserteq(-EINVAL, net_lwip_parse_decimal(invalid[i], strlen(invalid[i]),
+							    U16_MAX, &value));
+		ut_asserteq(123, value);
+	}
+	ut_assertok(net_lwip_parse_decimal("0", 1, 0, &value));
+	ut_asserteq(0, value);
+	ut_asserteq(-EINVAL, net_lwip_parse_decimal("1", 1, 0, &value));
+	ut_assertok(net_lwip_parse_decimal(padded, strlen(padded), U16_MAX, &value));
+	ut_asserteq(U16_MAX, value);
+	ut_assertok(net_lwip_parse_decimal("4294967295/", 10, U32_MAX, &value));
+	ut_asserteq(U32_MAX, value);
+	ut_asserteq(-EINVAL, net_lwip_parse_decimal("4294967296", 10, U32_MAX, &value));
+	return 0;
+}
+DM_TEST(dm_test_lwip_decimal, 0);
+
 #if CONFIG_IS_ENABLED(PROT_DNS_LWIP)
 struct lwip_test_dns_ctx {
 	unsigned int callbacks;
diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
new file mode 100644
index 00000000000..d82b936a96c
--- /dev/null
+++ b/test/dm/lwip_ipv6.c
@@ -0,0 +1,1116 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <env.h>
+#include <image.h>
+#include <lmb.h>
+#include <malloc.h>
+#include <lwip/inet_chksum.h>
+#include <lwip/ip6.h>
+#include <lwip/nd6.h>
+#include <lwip/dns.h>
+#include <lwip/timeouts.h>
+#include <lwip/tcp.h>
+#include <lwip/udp.h>
+#include <lwip-hooks.h>
+#include <lwip/priv/nd6_priv.h>
+#include <lwip/prot/icmp6.h>
+#include <lwip/prot/nd6.h>
+#include <lwip/prot/udp.h>
+#include <mapmem.h>
+#include <net.h>
+#include <stdio_dev.h>
+#include <time.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+struct ip6_test {
+	struct net_lwip_ctx net;
+	unsigned int dad;
+	unsigned int neighbors;
+	ip6_addr_t last_neighbor;
+	unsigned int solicitations;
+	unsigned int echoes;
+	unsigned int bad_checksums;
+	unsigned int corrupt;
+	unsigned int dns_queries;
+	unsigned int dns4_queries;
+	bool drop_dns;
+	ip6_addr_t last_dns;
+	u32 rdnss_lifetime;
+	bool lease_conflict;
+	bool conflict;
+	bool advertise;
+	bool cancel;
+};
+
+static u16 ip6_test_checksum(struct ip6_hdr *ip, void *data, unsigned int len)
+{
+	struct pbuf p = { .payload = data, .len = len, .tot_len = len };
+	ip6_addr_t src, dst;
+
+	ip6_addr_copy_from_packed(src, ip->src);
+	ip6_addr_copy_from_packed(dst, ip->dest);
+	return ip6_chksum_pseudo(&p, IP6H_NEXTH(ip), len, &src, &dst);
+}
+
+static int ip6_test_reply(struct udevice *dev, const ip6_addr_t *src,
+			  const ip6_addr_t *dst, const void *payload, unsigned int len,
+			  u8 proto, bool bad_checksum)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct ethernet_hdr *eth;
+	struct icmp6_hdr *icmp;
+	struct udp_hdr *udp;
+	struct ip6_hdr *ip;
+	unsigned int size = ETHER_HDR_SIZE + IP6_HLEN + len;
+
+	if (priv->recv_packets >= PKTBUFSRX || size > PKTSIZE_ALIGN)
+		return -ENOSPC;
+	eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	memset(eth, 0, size);
+	memcpy(eth->et_dest, pdata->enetaddr, ARP_HLEN);
+	memcpy(eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth->et_protlen = htons(0x86dd);
+	ip = (void *)(eth + 1);
+	IP6H_VTCFL_SET(ip, 6, 0, 0);
+	IP6H_PLEN_SET(ip, len);
+	IP6H_NEXTH_SET(ip, proto);
+	IP6H_HOPLIM_SET(ip, 255);
+	ip6_addr_copy_to_packed(ip->src, *src);
+	ip6_addr_copy_to_packed(ip->dest, *dst);
+	icmp = (void *)(ip + 1);
+	memcpy(icmp, payload, len);
+	if (proto == IP6_NEXTH_UDP) {
+		udp = (void *)icmp;
+		udp->chksum = 0;
+		udp->chksum = ip6_test_checksum(ip, udp, len);
+		if (!udp->chksum)
+			udp->chksum = 0xffff;
+	} else if (proto == IP6_NEXTH_TCP) {
+		put_unaligned(0, (u16 *)((u8 *)icmp + 16));
+		put_unaligned(ip6_test_checksum(ip, icmp, len), (u16 *)((u8 *)icmp + 16));
+	} else {
+		icmp->chksum = 0;
+		icmp->chksum = ip6_test_checksum(ip, icmp, len);
+		if (bad_checksum)
+			icmp->chksum ^= htons(1);
+	}
+	priv->recv_packet_length[priv->recv_packets++] = size;
+
+	return 0;
+}
+
+static int ip6_test_na(struct udevice *dev, struct ns_header *ns,
+		       const ip6_addr_t *dest, bool dad)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct {
+		struct na_header na;
+		struct lladdr_option ll;
+	} reply = {};
+	ip6_addr_t src, dst = *dest;
+
+	ip6_addr_copy_from_packed(src, ns->target_address);
+	if (dad)
+		ip6addr_aton("ff02::1", &dst);
+	reply.na.type = ICMP6_TYPE_NA;
+	reply.na.flags = ND6_FLAG_OVERRIDE | (dad ? 0 : ND6_FLAG_SOLICITED);
+	reply.na.target_address = ns->target_address;
+	reply.ll.type = ND6_OPTION_TYPE_TARGET_LLADDR;
+	reply.ll.length = 1;
+	memcpy(reply.ll.addr, priv->fake_host_hwaddr, ARP_HLEN);
+
+	return ip6_test_reply(dev, &src, &dst, &reply, sizeof(reply), IP6_NEXTH_ICMP6, false);
+}
+
+static int ip6_test_ra_lifetimes(struct udevice *dev, u32 valid, u32 preferred)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct {
+		struct ra_header ra;
+		struct prefix_option prefix;
+		struct lladdr_option ll;
+		struct rdnss_option dns;
+	} reply = {};
+	ip6_addr_t src, dst, prefix;
+
+	ip6addr_aton("fe80::1", &src);
+	ip6addr_aton("ff02::1", &dst);
+	ip6addr_aton("2001:db8:1::", &prefix);
+	reply.ra.type = ICMP6_TYPE_RA;
+	reply.ra.current_hop_limit = 64;
+	reply.ra.router_lifetime = htons(1800);
+	reply.prefix.type = ND6_OPTION_TYPE_PREFIX_INFO;
+	reply.prefix.length = 4;
+	reply.prefix.prefix_length = 64;
+	reply.prefix.flags = ND6_PREFIX_FLAG_ON_LINK | ND6_PREFIX_FLAG_AUTONOMOUS;
+	reply.prefix.valid_lifetime = htonl(valid);
+	reply.prefix.preferred_lifetime = htonl(preferred);
+	ip6_addr_copy_to_packed(reply.prefix.prefix, prefix);
+	reply.ll.type = ND6_OPTION_TYPE_SOURCE_LLADDR;
+	reply.ll.length = 1;
+	memcpy(reply.ll.addr, priv->fake_host_hwaddr, ARP_HLEN);
+	reply.dns.type = ND6_OPTION_TYPE_RDNSS;
+	reply.dns.length = 3;
+	reply.dns.lifetime = htonl(((struct ip6_test *)priv->priv)->rdnss_lifetime);
+	ip6_addr_copy_to_packed(reply.dns.rdnss_address[0], src);
+
+	return ip6_test_reply(dev, &src, &dst, &reply, sizeof(reply), IP6_NEXTH_ICMP6, false);
+}
+
+static int ip6_test_ra(struct udevice *dev)
+{
+	return ip6_test_ra_lifetimes(dev, 1800, 900);
+}
+
+static int ip6_test_udp(struct udevice *dev, struct ip6_hdr *ip, u16 port,
+			const void *data, unsigned int len)
+{
+	u8 packet[1200];
+	struct udp_hdr *udp = (void *)packet, *request = (void *)(ip + 1);
+	ip6_addr_t src, dst;
+
+	if (len > sizeof(packet) - sizeof(*udp))
+		return -ENOSPC;
+	udp->src = htons(port);
+	udp->dest = request->src;
+	udp->len = htons(sizeof(*udp) + len);
+	memcpy(udp + 1, data, len);
+	ip6_addr_copy_from_packed(src, ip->dest);
+	if (ip6_addr_ismulticast(&src))
+		ip6addr_aton("fe80::2", &src);
+	ip6_addr_copy_from_packed(dst, ip->src);
+	return ip6_test_reply(dev, &src, &dst, packet, sizeof(*udp) + len, IP6_NEXTH_UDP, false);
+}
+
+static int ip6_test_dns_answer(struct ip6_test *test, const u8 *query,
+			       unsigned int len, u8 *reply, size_t size)
+{
+	ip6_addr_t addr;
+	u8 *answer;
+
+	if (len < 16 || len > size - 28)
+		return -EINVAL;
+	/* These tests explicitly select AAAA and IN. */
+	if (get_unaligned_be16(query + len - 4) != 28 || get_unaligned_be16(query + len - 2) != 1)
+		return -EINVAL;
+	test->dns_queries++;
+	memcpy(reply, query, len);
+	put_unaligned_be16(0x8180, reply + 2);
+	put_unaligned_be16(1, reply + 6);
+	answer = reply + len;
+	put_unaligned_be16(0xc00c, answer);
+	put_unaligned_be16(28, answer + 2);
+	put_unaligned_be16(1, answer + 4);
+	put_unaligned_be32(30, answer + 6);
+	put_unaligned_be16(16, answer + 10);
+	ip6addr_aton("fe80::2", &addr);
+	memcpy(answer + 12, addr.addr, 16);
+	return len + 28;
+}
+
+static int ip6_test_dns_reply(struct udevice *dev, struct ip6_hdr *ip)
+{
+	struct ip6_test *test = ((struct eth_sandbox_priv *)dev_get_priv(dev))->priv;
+	u8 *query = (void *)((struct udp_hdr *)(ip + 1) + 1), reply[512];
+	int len;
+
+	if (test->drop_dns) {
+		test->dns_queries++;
+		timer_test_add_offset(11000);
+		return 0;
+	}
+	ip6_addr_copy_from_packed(test->last_dns, ip->dest);
+	len = ip6_test_dns_answer(test, query, IP6H_PLEN(ip) - UDP_HLEN,
+				  reply, sizeof(reply));
+	return len < 0 ? len : ip6_test_udp(dev, ip, 53, reply, len);
+}
+
+static int ip6_test_ipv4(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ip6_test *test = priv->priv;
+	struct ethernet_hdr *eth = packet, *reply_eth;
+	struct ip_udp_hdr *ip = (void *)(eth + 1), *reply_ip;
+	int size;
+
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len) ||
+	    !sandbox_eth_ping_req_to_reply(dev, packet, len))
+		return 0;
+	if (ntohs(eth->et_protlen) != PROT_IP || len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE ||
+	    ip->ip_hl_v != 0x45 || ip->ip_p != IPPROTO_UDP || ntohs(ip->udp_dst) != 53)
+		return 0;
+	if (priv->recv_packets >= PKTBUFSRX || ntohs(ip->udp_len) < UDP_HDR_SIZE ||
+	    ntohs(ip->udp_len) > len - ETHER_HDR_SIZE - IP_HDR_SIZE)
+		return -EINVAL;
+	reply_eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	reply_ip = (void *)(reply_eth + 1);
+	size = ip6_test_dns_answer(test, (void *)(ip + 1), ntohs(ip->udp_len) - UDP_HDR_SIZE,
+				   (void *)(reply_ip + 1), 512);
+	if (size < 0)
+		return size;
+	memcpy(reply_eth, eth, ETHER_HDR_SIZE + IP_UDP_HDR_SIZE);
+	memcpy(reply_eth->et_dest, eth->et_src, ARP_HLEN);
+	memcpy(reply_eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	reply_ip->ip_src = ip->ip_dst;
+	reply_ip->ip_dst = ip->ip_src;
+	reply_ip->ip_len = htons(IP_UDP_HDR_SIZE + size);
+	reply_ip->ip_sum = 0;
+	reply_ip->ip_sum = compute_ip_checksum(reply_ip, IP_HDR_SIZE);
+	reply_ip->udp_src = ip->udp_dst;
+	reply_ip->udp_dst = ip->udp_src;
+	reply_ip->udp_len = htons(UDP_HDR_SIZE + size);
+	reply_ip->udp_xsum = 0;
+	priv->recv_packet_length[priv->recv_packets++] = ETHER_HDR_SIZE + IP_UDP_HDR_SIZE + size;
+	test->dns4_queries++;
+	return 0;
+}
+
+static int ip6_test_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ip6_test *test = priv->priv;
+	struct ethernet_hdr *eth = packet;
+	struct ip6_hdr *ip = (void *)(eth + 1);
+	struct icmp6_echo_hdr echo;
+	struct ns_header *ns;
+	ip6_addr_t src, dst;
+	unsigned int plen;
+	u8 *icmp = (void *)(ip + 1);
+
+	if (len < ETHER_HDR_SIZE)
+		return 0;
+	if (ntohs(eth->et_protlen) != 0x86dd)
+		return ip6_test_ipv4(dev, packet, len);
+	if (len < ETHER_HDR_SIZE + IP6_HLEN)
+		return 0;
+	if (IP6H_NEXTH(ip) == IP6_NEXTH_UDP) {
+		struct udp_hdr *udp = (void *)(ip + 1);
+
+		if (IP6H_PLEN(ip) < UDP_HLEN || len < ETHER_HDR_SIZE + IP6_HLEN + IP6H_PLEN(ip))
+			return -EINVAL;
+		if (ntohs(udp->dest) == 53)
+			return ip6_test_dns_reply(dev, ip);
+		return 0;
+	}
+	if (IP6H_NEXTH(ip) != IP6_NEXTH_ICMP6)
+		return 0;
+	plen = IP6H_PLEN(ip);
+	if (plen < sizeof(struct icmp6_hdr) || len < ETHER_HDR_SIZE + IP6_HLEN + plen)
+		return -EINVAL;
+	if (ip6_test_checksum(ip, icmp, plen))
+		test->bad_checksums++;
+	ip6_addr_copy_from_packed(src, ip->src);
+	ip6_addr_copy_from_packed(dst, ip->dest);
+	switch (*icmp) {
+	case ICMP6_TYPE_NS:
+		if (plen < sizeof(*ns))
+			return -EINVAL;
+		ns = (void *)icmp;
+		if (ip6_addr_isany(&src)) {
+			test->dad++;
+			if (test->cancel)
+				console_in_puts("\x03");
+			if (test->conflict ||
+			    (test->lease_conflict &&
+			     !memcmp(&ns->target_address, "\x20\x01", 2)))
+				return ip6_test_na(dev, ns, &src, true);
+			timer_test_add_offset(1100);
+			return 0;
+		}
+		test->neighbors++;
+		ip6_addr_copy_from_packed(test->last_neighbor, ns->target_address);
+		return ip6_test_na(dev, ns, &src, false);
+	case ICMP6_TYPE_RS:
+		test->solicitations++;
+		if (test->advertise)
+			return ip6_test_ra(dev);
+		return 0;
+	case ICMP6_TYPE_EREQ:
+		test->echoes++;
+		if (plen != sizeof(echo))
+			return -EINVAL;
+		memcpy(&echo, icmp, sizeof(echo));
+		echo.type = ICMP6_TYPE_EREP;
+		if (test->echoes == 1) {
+			if (test->corrupt == 2)
+				echo.type = ICMP6_TYPE_EREQ;
+			if (test->corrupt == 3)
+				echo.seqno ^= htons(1);
+		}
+		return ip6_test_reply(dev, &dst, &src, &echo, sizeof(echo),
+				     IP6_NEXTH_ICMP6, test->echoes == 1 && test->corrupt == 1);
+	default:
+		return 0;
+	}
+}
+
+static int ip6_test_config(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char * const invalid[] = {
+		"::", "::1", "ff02::1", "1.2.3.4", "2001:db8::1/129",
+		"2001:db8::1/", "2001:db8::1/-1", "2001:db8::1/+1",
+		"2001:db8::1/64junk", "2001:db8::1%et0", "2001:db8::1junk",
+		"2001:db8::1::2", "2001:db8::12345", "::ffff:c000:201",
+		"2001:db8:0:0:0:0:0:1:", ":2001:db8:0:0:0:0:0:1", "2001:db8:1",
+		"2001:db8:0:0:0:0:1:", ":2001:db8:0:0:0:0:1", "2001:db8:::1",
+		"2001:db8:0:0:0:0:0:1::", "::2001:db8:0:0:0:0:0:1",
+		"2001:db8::10/18446744073709551680", "2001:db8::10/4294967360",
+	};
+	static const char *const valid[] = {
+		"2001:db8:0:0:0:0:0:1", "2001:db8::1", "2001:db8:0:0:0:0:1::",
+		"::2001:db8:0:0:0:0:1", "2001::", "2001:0:0:0:0:0:0:0",
+	};
+	struct net_lwip_ctx other = {};
+	ip6_addr_t expected;
+	ip4_addr_t ip4;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(valid); i++)
+		ut_assertok(net_lwip_ip6_aton(valid[i], &expected));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	ip4 = *netif_ip4_addr(test->net.netif);
+	for (i = 0; i < ARRAY_SIZE(invalid); i++) {
+		ut_assertok(env_set("ip6addr", invalid[i]));
+		ut_asserteq(-EINVAL, net_lwip_ip6_init(&test->net));
+		ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 0)));
+		ut_assert(ip4_addr_cmp(&ip4, netif_ip4_addr(test->net.netif)));
+	}
+	ut_assertok(env_set("ip6addr", "2001:db8:1::10/00064"));
+	ut_assertok(env_set("gatewayip6", "ff02::1"));
+	ut_asserteq(-EINVAL, net_lwip_ip6_init(&test->net));
+	ut_assertok(env_set("gatewayip6", "fe80::1"));
+	ut_assertok(net_lwip_ip6_init(&test->net));
+	ip6addr_aton("2001:db8:1::10", &expected);
+	ut_assert(ip6_addr_zoneless_eq(&expected, netif_ip6_addr(test->net.netif, 1)));
+	ut_asserteq(IP6_ADDR_TENTATIVE, netif_ip6_addr_state(test->net.netif, 1));
+	ut_assertok(net_lwip_ip6_init(&test->net));
+	ut_assertok(env_set("ip6addr", "2001:db8:1::11"));
+	ut_asserteq(-EBUSY, net_lwip_ip6_init(&test->net));
+	ut_assert(ip6_addr_zoneless_eq(&expected, netif_ip6_addr(test->net.netif, 1)));
+	ut_assertok(net_lwip_start(&other, NET_LWIP_ADDR_ENV_STRICT));
+	net_lwip_stop(&other);
+	ut_assert(ip4_addr_cmp(&ip4, netif_ip4_addr(test->net.netif)));
+	net_lwip_stop(&test->net);
+	ut_assertnull(netif_default);
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	ut_assertok(net_lwip_ip6_init(&test->net));
+	ip6addr_aton("2001:db8:1::11", &expected);
+	ut_assert(ip6_addr_zoneless_eq(&expected, netif_ip6_addr(test->net.netif, 1)));
+
+	return 0;
+}
+
+static int ip6_test_ping(struct unit_test_state *uts, struct ip6_test *test)
+{
+	unsigned int i;
+
+	/* A corrupt reply must not complete a command; a later reply can. */
+	for (i = 0; i < 4; i++) {
+		test->echoes = 0;
+		test->corrupt = i;
+		ut_assertok(run_command("ping6 fe80::2", 0));
+		ut_asserteq(i ? 2 : 1, test->echoes);
+		ut_assertnull(netif_default);
+	}
+	ut_assert(test->dad >= 4);
+	ut_assert(test->neighbors >= 4);
+	ut_asserteq(0, test->bad_checksums);
+	test->corrupt = 0;
+	ut_assertok(env_set("ip6addr", "2001:db8:1::10/64"));
+	ut_assertok(run_command("ping6 2001:db8:1::2", 0));
+	ut_assertok(env_set("gatewayip6", "fe80::1"));
+	ut_assertok(run_command("ping6 2001:db8:2::2", 0));
+	ut_assertnull(netif_default);
+
+	return 0;
+}
+
+static int ip6_test_dad(struct unit_test_state *uts, struct ip6_test *test)
+{
+	test->conflict = true;
+	ut_asserteq(CMD_RET_FAILURE, run_command("ping6 fe80::2", 0));
+	ut_asserteq(0, test->echoes);
+	ut_assert(test->dad);
+	ut_assertnull(netif_default);
+	test->conflict = false;
+	test->cancel = true;
+	ut_asserteq(CMD_RET_FAILURE, run_command("ping6 fe80::2", 0));
+	ut_asserteq(0, test->echoes);
+	ut_assertnull(netif_default);
+	ut_asserteq(0, test->bad_checksums);
+
+	return 0;
+}
+
+static int ip6_test_dad_scope(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip_addr_t dest;
+	ip6_addr_t alternate;
+
+	ut_assertok(env_set("ip6addr", "2001:db8:1::10/64"));
+	test->lease_conflict = true;
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ut_assert(ip6_addr_isduplicated(netif_ip6_addr_state(test->net.netif, 1)));
+	ut_assertok(run_command("ping6 fe80::2", 0));
+	ipaddr_aton("2001:db8:1::2", &dest);
+	ut_asserteq(-EADDRINUSE, net_lwip_ip6_ready(&test->net, &dest));
+
+	/* An independently configured address can still serve global traffic. */
+	test->lease_conflict = false;
+	ip6addr_aton("2001:db8:1::20", &alternate);
+	netif_ip6_addr_set(test->net.netif, 2, &alternate);
+	netif_ip6_addr_set_state(test->net.netif, 2, IP6_ADDR_TENTATIVE);
+	ut_assertok(run_command("ping6 2001:db8:1::2", 0));
+	ut_assert(ip6_addr_isvalid(netif_ip6_addr_state(test->net.netif, 2)));
+	ipaddr_aton("2001:db8:2::2", &dest);
+	ut_asserteq(-EAGAIN, net_lwip_ip6_ready(&test->net, &dest));
+	ut_asserteq(2, test->echoes);
+	ut_asserteq(0, test->bad_checksums);
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY)
+static void ip6_test_age(unsigned int seconds)
+{
+	timer_test_add_offset(seconds * 1000);
+	net_lwip_ip6_update_lifetimes();
+}
+
+static int ip6_test_slaac(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip_addr_t dest;
+	u32 before;
+
+	test->advertise = true;
+	ut_assertok(run_command("ping6 2001:db8:2::2", 0));
+	ut_assert(test->solicitations);
+	ut_assert(test->dad >= 2);
+	ut_asserteq(1, test->echoes);
+	ut_asserteq(0, test->bad_checksums);
+	ut_assertnull(netif_default);
+	/* Removal must discard the learned address, prefix and default router. */
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_FLEXIBLE));
+	ut_assertok(net_lwip_ip6_init(&test->net));
+	ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	ipaddr_aton("2001:db8:2::2", &dest);
+	ut_assertok(net_lwip_prepare_addr(&test->net, &dest));
+	ip6_test_age(5);
+	before = netif_ip6_addr_valid_life(test->net.netif, 1);
+	ut_assertok(ip6_test_ra(test->net.dev));
+	ut_assertok(net_lwip_poll());
+	ut_assert(netif_ip6_addr_valid_life(test->net.netif, 1) > before);
+
+	return 0;
+}
+
+static int ip6_test_lifetimes(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip_addr_t dest;
+	u32 before;
+	u8 state;
+	unsigned int dad;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	test->advertise = true;
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ipaddr_aton("2001:db8:2::2", &dest);
+	ut_assertok(net_lwip_prepare_addr(&test->net, &dest));
+	test->advertise = false;
+	before = netif_ip6_addr_valid_life(test->net.netif, 1);
+	/* Readiness must age retained state even before the next poll. */
+	timer_test_add_offset(901000);
+	ut_assertok(net_lwip_ip6_ready(&test->net, &dest));
+	ut_asserteq(IP6_ADDR_DEPRECATED, netif_ip6_addr_state(test->net.netif, 1));
+	ut_assert(netif_ip6_addr_valid_life(test->net.netif, 1) <= before - 901);
+	timer_test_add_offset(900000);
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(-EAGAIN, net_lwip_ip6_ready(&test->net, &dest));
+	ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	ut_assertnull(nd6_find_route(ip_2_ip6(&dest)));
+	for (unsigned int i = 0; i < LWIP_ND6_NUM_PREFIXES; i++)
+		ut_assert(prefix_list[i].netif != test->net.netif);
+
+	/* A fresh advertisement is not aged by the preceding idle interval. */
+	timer_test_add_offset(1801000);
+	ut_assertok(ip6_test_ra_lifetimes(test->net.dev, U32_MAX, U32_MAX));
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(IP6_ADDR_LIFE_INFINITE, netif_ip6_addr_valid_life(test->net.netif, 1));
+	state = netif_ip6_addr_state(test->net.netif, 1);
+	ut_assert(ip6_addr_istentative(state));
+	dad = test->dad;
+	ip6_test_age(600);
+	/* Lifetime catch-up must neither send probes nor advance DAD. */
+	ut_asserteq(dad, test->dad);
+	ut_asserteq(state, netif_ip6_addr_state(test->net.netif, 1));
+	ut_asserteq(IP6_ADDR_LIFE_INFINITE, netif_ip6_addr_valid_life(test->net.netif, 1));
+	ut_asserteq(IP6_ADDR_LIFE_INFINITE, netif_ip6_addr_pref_life(test->net.netif, 1));
+	ut_assertok(net_lwip_prepare_addr(&test->net, &dest));
+	ip6_test_age(1801);
+	ut_assert(ip6_addr_isvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	ut_assertnull(nd6_find_route(ip_2_ip6(&dest)));
+	ipaddr_aton("2001:db8:1::2", &dest);
+	ut_assertok(net_lwip_ip6_ready(&test->net, &dest));
+
+	net_lwip_stop(&test->net);
+	ut_assertok(env_set("ip6addr", "2001:db8:1::10"));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_prepare_addr(&test->net, &dest));
+	ip6_test_age(1801);
+	ut_assertok(net_lwip_ip6_ready(&test->net, &dest));
+	ut_assert(netif_ip6_addr_isstatic(test->net.netif, 1));
+	ut_assert(ip6_addr_isvalid(netif_ip6_addr_state(test->net.netif, 0)));
+	net_lwip_stop(&test->net);
+	ut_assertok(env_set("ip6addr", NULL));
+	timer_test_add_offset(1801000);
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_init(&test->net));
+	ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	return 0;
+}
+#endif
+
+static int ip6_test_run(struct unit_test_state *uts,
+			int (*check)(struct unit_test_state *, struct ip6_test *))
+{
+	static const char * const names[] = {
+		"ethact", "ethrotate", "netretry", "ip6addr", "gatewayip6",
+		"ipaddr", "netmask", "serverip6", "filesize", "fileaddr",
+		"dnsip", "dnsip2", "dnsip6", "dnsip6_2", "dnsresult",
+		"autoload", "autostart", "bootfile", "pxe_configfile", "tftpdstp",
+		"ncip", "ncip6", "ncinport", "ncoutport", "ntpserverip",
+		"tftpsrcp", "tftpblocksize", "tftpwindowsize", "tftptimeout",
+		"tftptimeoutcountmax",
+	};
+	struct ip6_test test = {};
+#if CONFIG_IS_ENABLED(WGET)
+	struct wget_http_info *http_info = wget_info;
+#endif
+	ulong load_addr = image_load_addr;
+	u32 size = net_boot_file_size;
+	char *saved[ARRAY_SIZE(names)];
+	unsigned int i;
+	int ret, ctrlc_state;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		const char *value = env_get(names[i]);
+
+		saved[i] = value ? strdup(value) : NULL;
+		if (value && !saved[i]) {
+			while (i)
+				free(saved[--i]);
+			return -ENOMEM;
+		}
+	}
+	env_set("ethact", "eth@10002000");
+	env_set("ethrotate", "no");
+	env_set("netretry", "no");
+	env_set("ip6addr", NULL);
+	env_set("gatewayip6", NULL);
+	env_set("dnsip", NULL);
+	env_set("dnsip2", NULL);
+	env_set("dnsip6", NULL);
+	env_set("dnsip6_2", NULL);
+	env_set("tftpdstp", NULL);
+	env_set("tftpsrcp", NULL);
+	env_set("tftpblocksize", NULL);
+	env_set("tftpwindowsize", NULL);
+	env_set("tftptimeout", NULL);
+	env_set("tftptimeoutcountmax", NULL);
+	sandbox_eth_set_priv(0, &test);
+	sandbox_eth_set_tx_handler(0, ip6_test_tx);
+	ctrlc_state = disable_ctrlc(0);
+	ret = check(uts, &test);
+	disable_ctrlc(ctrlc_state);
+	clear_ctrlc();
+#if CONFIG_IS_ENABLED(WGET)
+	wget_info = http_info;
+#endif
+	image_load_addr = load_addr;
+	net_boot_file_size = size;
+	net_lwip_stop(&test.net);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		env_set(names[i], saved[i]);
+		free(saved[i]);
+	}
+	return ret;
+}
+
+static int dm_test_lwip_ip6_config(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_config);
+}
+DM_TEST(dm_test_lwip_ip6_config, UTF_SCAN_FDT);
+
+static int ip6_test_prefix(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip6_addr_t addr, dest, gateway;
+	char text[64];
+
+	ip6addr_aton("2001:db8:1::10", &addr);
+	for (unsigned int bits = 0; bits <= 128; bits++) {
+		snprintf(text, sizeof(text), "2001:db8:1::10/%u", bits);
+		ut_assertok(env_set("ip6addr", text));
+		ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_FLEXIBLE));
+		ut_assertok(net_lwip_ip6_init(&test->net));
+		ut_assert(net_lwip_ip6_static_prefix(test->net.netif, 1, &addr));
+		if (bits) {
+			ip6_addr_copy(dest, addr);
+			((u8 *)dest.addr)[(bits - 1) / 8] ^= BIT(7 - (bits - 1) % 8);
+			ut_assert(!net_lwip_ip6_static_prefix(test->net.netif, 1, &dest));
+		}
+		if (bits < 128) {
+			ip6_addr_copy(dest, addr);
+			((u8 *)dest.addr)[bits / 8] ^= BIT(7 - bits % 8);
+			ut_assert(net_lwip_ip6_static_prefix(test->net.netif, 1, &dest));
+		}
+		net_lwip_stop(&test->net);
+	}
+	ut_assertok(env_set("ip6addr", "2001:db8:1::10/48"));
+	ut_assertok(run_command("ping6 2001:db8:1:ffff::2", 0));
+	ip6addr_aton("2001:db8:1:ffff::2", &dest);
+	ut_assert(ip6_addr_zoneless_eq(&dest, &test->last_neighbor));
+	ut_assertok(env_set("ip6addr", "2001:db8:1::10/120"));
+	ut_assertok(env_set("gatewayip6", "fe80::1"));
+	ut_assertok(run_command("ping6 2001:db8:1::110", 0));
+	ip6addr_aton("fe80::1", &gateway);
+	ut_assert(ip6_addr_zoneless_eq(&gateway, &test->last_neighbor));
+	ut_assertnull(netif_default);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_prefix(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_prefix);
+}
+DM_TEST(dm_test_lwip_ip6_prefix, UTF_SCAN_FDT);
+
+#if CONFIG_IS_ENABLED(DNS)
+static int ip6_test_dns(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ulong start;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("dnsip6", "fe80::2"));
+	ut_assertok(run_command("dns ipv6.test dnsresult -ipv6", 0));
+	ut_asserteq_str("FE80::2", env_get("dnsresult"));
+	ut_assertok(run_command("ping6 ping.test", 0));
+	ut_asserteq(2, test->dns_queries);
+	ut_asserteq(1, test->echoes);
+	ut_assertnull(netif_default);
+
+	/* An unavailable IPv6 backup must not delay a usable IPv4 primary. */
+	ut_assertok(env_set("ipaddr", "192.0.2.10"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	ut_assertok(env_set("dnsip", "192.0.2.53"));
+	ut_assertok(env_set("dnsip6", "2001:db8:2::53"));
+	start = get_timer(0);
+	ut_assertok(run_command("dns mixed.test dnsresult -ipv6", 0));
+	ut_assert(get_timer(start) < 5000);
+	ut_asserteq_str("FE80::2", env_get("dnsresult"));
+	ut_asserteq(1, test->dns4_queries);
+	ut_assertnull(netif_default);
+
+	/* Also skip an unready primary in favor of a usable same-family backup. */
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("dnsip", NULL));
+	ut_assertok(env_set("dnsip6_2", "fe80::3"));
+	ut_assertok(run_command("dns backup.test dnsresult -ipv6", 0));
+	ut_asserteq_str("FE80::3", ip6addr_ntoa(&test->last_dns));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_dns(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_dns);
+}
+DM_TEST(dm_test_lwip_ip6_dns, UTF_SCAN_FDT);
+#endif
+
+#if CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY) && CONFIG_IS_ENABLED(DNS)
+static int ip6_test_rdnss(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip_addr_t addr;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	test->advertise = true;
+	test->rdnss_lifetime = 10;
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	/* Complete DAD's simulated time jumps before counting DNS queries. */
+	ipaddr_aton("2001:db8:2::2", &addr);
+	ut_assertok(net_lwip_prepare_addr(&test->net, &addr));
+	for (unsigned int i = 0; i < 31; i++)
+		dns_tmr();
+	ut_assertok(net_lwip_resolve(&test->net, "rdnss.test", &addr, IPADDR_TYPE_V6));
+	ut_asserteq(1, test->dns_queries);
+	ip6_test_age(11);
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+	ut_assertok(env_set("dnsip6", "fe80::3"));
+	ut_assertok(net_lwip_dns_init(&test->net));
+	ut_assertok(ip6_test_ra(test->net.dev));
+	ut_assertok(net_lwip_poll());
+	ipaddr_aton("fe80::3", &addr);
+	ut_assert(ip6_addr_zoneless_eq(ip_2_ip6(&addr), ip_2_ip6(dns_getserver(0))));
+	net_lwip_stop(&test->net);
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_rdnss(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_rdnss);
+}
+DM_TEST(dm_test_lwip_ip6_rdnss, UTF_SCAN_FDT);
+
+static int ip6_test_rdnss_advertise(struct udevice *dev, const char *first_addr,
+				    u32 first, const char *second_addr, u32 second)
+{
+	struct {
+		struct ra_header ra;
+		struct rdnss_option dns[2];
+	} reply = {};
+	ip6_addr_t src, dst, addr;
+	unsigned int count = second_addr ? 2 : 1;
+
+	ip6addr_aton("fe80::1", &src);
+	ip6addr_aton("ff02::1", &dst);
+	reply.ra.type = ICMP6_TYPE_RA;
+	reply.ra.router_lifetime = htons(1800);
+	for (unsigned int i = 0; i < count; i++) {
+		reply.dns[i].type = ND6_OPTION_TYPE_RDNSS;
+		reply.dns[i].length = sizeof(reply.dns[i]) / 8;
+		reply.dns[i].lifetime = htonl(i ? second : first);
+		ip6addr_aton(i ? second_addr : first_addr, &addr);
+		ip6_addr_copy_to_packed(reply.dns[i].rdnss_address[0], addr);
+	}
+	return ip6_test_reply(dev, &src, &dst, &reply,
+			      sizeof(reply.ra) + count * sizeof(reply.dns[0]),
+			      IP6_NEXTH_ICMP6, false);
+}
+
+static int ip6_test_rdnss_servers(struct udevice *dev, u32 first, u32 second,
+				  unsigned int count)
+{
+	return ip6_test_rdnss_advertise(dev, "fe80::2", first,
+				       count == 2 ? "fe80::3" : NULL, second);
+}
+
+static int ip6_test_rdnss_identity(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ut_asserteq(-ENOENT, net_lwip_dns_refresh(&test->net));
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 100, 100, 2));
+	ut_assertok(net_lwip_poll());
+
+	/* Refreshing the backup alone must not create a duplicate primary. */
+	ut_assertok(ip6_test_rdnss_advertise(test->net.dev, "fe80::3", 1, NULL, 0));
+	ut_assertok(net_lwip_poll());
+	ut_asserteq_str("FE80::2", ipaddr_ntoa(dns_getserver(0)));
+	ut_asserteq_str("FE80::3", ipaddr_ntoa(dns_getserver(1)));
+	ip6_test_age(1);
+	ut_asserteq_str("FE80::2", ipaddr_ntoa(dns_getserver(0)));
+	ut_assert(ip_addr_isany(dns_getserver(1)));
+
+	/* Reordered advertisements update the lifetimes by address. */
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 100, 100, 2));
+	ut_assertok(net_lwip_poll());
+	ut_assertok(ip6_test_rdnss_advertise(test->net.dev, "fe80::3", 2, "fe80::2", 1));
+	ut_assertok(net_lwip_poll());
+	ip6_test_age(1);
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+	ut_asserteq_str("FE80::3", ipaddr_ntoa(dns_getserver(1)));
+	ip6_test_age(1);
+	ut_assert(ip_addr_isany(dns_getserver(1)));
+
+	/* A new address replaces the entry that would expire first. */
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 100, 10, 2));
+	ut_assertok(net_lwip_poll());
+	ut_assertok(ip6_test_rdnss_advertise(test->net.dev, "fe80::4", 50, NULL, 0));
+	ut_assertok(net_lwip_poll());
+	ut_asserteq_str("FE80::2", ipaddr_ntoa(dns_getserver(0)));
+	ut_asserteq_str("FE80::4", ipaddr_ntoa(dns_getserver(1)));
+	ut_assertok(ip6_test_rdnss_advertise(test->net.dev, "fe80::4", 0, NULL, 0));
+	ut_assertok(net_lwip_poll());
+	ut_assert(ip_addr_isany(dns_getserver(1)));
+	ut_asserteq_str("FE80::2", ipaddr_ntoa(dns_getserver(0)));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_rdnss_identity(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_rdnss_identity);
+}
+DM_TEST(dm_test_lwip_ip6_rdnss_identity, UTF_SCAN_FDT);
+
+static int ip6_test_rdnss_idle(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip_addr_t addr;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ut_asserteq(-ENOENT, net_lwip_dns_refresh(&test->net));
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 5, 0, 1));
+	ut_assertok(net_lwip_poll());
+	ut_assert(!ip_addr_isany(dns_getserver(0)));
+	timer_test_add_offset(6000);
+	ut_assertok(net_lwip_poll());
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+
+	/* Expire the primary during DNS setup, before it can send a query. */
+	for (unsigned int i = 0; i < 31; i++)
+		dns_tmr();
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 5, U32_MAX, 2));
+	ut_assertok(net_lwip_poll());
+	timer_test_add_offset(6000);
+	ut_assertok(net_lwip_resolve(&test->net, "idle-rdnss.test", &addr, IPADDR_TYPE_V6));
+	ut_assert(test->dns_queries);
+	ut_asserteq_str("FE80::3", ip6addr_ntoa(&test->last_dns));
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+	ip6_test_age(1801);
+	ut_asserteq_str("FE80::3", ipaddr_ntoa(dns_getserver(1)));
+
+	/* Refresh after an idle interval, then explicitly withdraw it. */
+	timer_test_add_offset(6000);
+	ut_assertok(ip6_test_rdnss_advertise(test->net.dev, "fe80::3", 5, NULL, 0));
+	ut_assertok(net_lwip_poll());
+	ut_asserteq_str("FE80::3", ipaddr_ntoa(dns_getserver(1)));
+	ip6_test_age(4);
+	ut_asserteq_str("FE80::3", ipaddr_ntoa(dns_getserver(1)));
+	ut_assertok(ip6_test_rdnss_advertise(test->net.dev, "fe80::3", 0, NULL, 0));
+	ut_assertok(net_lwip_poll());
+	ut_assert(ip_addr_isany(dns_getserver(1)));
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, U32_MAX, 0, 1));
+	ut_assertok(net_lwip_poll());
+	net_lwip_stop(&test->net);
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+	ut_assert(ip_addr_isany(dns_getserver(1)));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_rdnss_idle(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_rdnss_idle);
+}
+DM_TEST(dm_test_lwip_ip6_rdnss_idle, UTF_SCAN_FDT);
+
+static int ip6_test_rdnss_backup(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip_addr_t addr;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ut_asserteq(-ENOENT, net_lwip_dns_refresh(&test->net));
+	for (unsigned int i = 0; i < 31; i++)
+		dns_tmr();
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 1, 100, 2));
+	ut_assertok(net_lwip_poll());
+	ip6_test_age(1);
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+	ut_assert(!ip_addr_isany(dns_getserver(1)));
+	ut_assertok(net_lwip_poll());
+	ut_assertok(net_lwip_resolve(&test->net, "rdnss-expiry.test", &addr, IPADDR_TYPE_V6));
+	ut_asserteq_str("FE80::3", ip6addr_ntoa(&test->last_dns));
+	ut_asserteq(1, test->dns_queries);
+	ip6_test_age(100);
+	ut_assert(ip_addr_isany(dns_getserver(1)));
+
+	/* A zero-lifetime advertisement must leave the other server usable too. */
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 100, 100, 2));
+	ut_assertok(net_lwip_poll());
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 0, 0, 1));
+	ut_assertok(net_lwip_poll());
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+	ut_assert(!ip_addr_isany(dns_getserver(1)));
+	ut_assertok(net_lwip_resolve(&test->net, "rdnss-withdraw.test", &addr, IPADDR_TYPE_V6));
+	ut_asserteq_str("FE80::3", ip6addr_ntoa(&test->last_dns));
+	ut_asserteq(2, test->dns_queries);
+	net_lwip_stop(&test->net);
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+	ut_assert(ip_addr_isany(dns_getserver(1)));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_rdnss_backup(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_rdnss_backup);
+}
+DM_TEST(dm_test_lwip_ip6_rdnss_backup, UTF_SCAN_FDT);
+
+static int ip6_test_rdnss_override(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char *const servers[] = { "fe80::2", "fe80::9" };
+	ip_addr_t expected;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ut_asserteq(-ENOENT, net_lwip_dns_refresh(&test->net));
+	ut_assertok(ip6_test_rdnss_servers(test->net.dev, 5, 0, 1));
+	ut_assertok(net_lwip_poll());
+	ut_assert(!ip_addr_isany(dns_getserver(0)));
+
+	/* An override not yet installed must not cancel the learned lifetime. */
+	ut_assertok(env_set("dnsip6", "fe80::9"));
+	ip6_test_age(1);
+	ut_assertok(env_set("dnsip6", NULL));
+	ip6_test_age(5);
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(servers); i++) {
+		ut_assertok(ip6_test_rdnss_servers(test->net.dev, 5, 0, 1));
+		ut_assertok(net_lwip_poll());
+		ut_assertok(env_set("dnsip6", servers[i]));
+		ut_assertok(net_lwip_dns_refresh(&test->net));
+		ipaddr_aton(servers[i], &expected);
+		ip6_addr_assign_zone(ip_2_ip6(&expected), IP6_UNKNOWN, test->net.netif);
+
+		/* Explicit settings survive the old lifetime, even at the same address. */
+		ip6_test_age(6);
+		ut_assert(ip_addr_cmp(&expected, dns_getserver(0)));
+		ut_assertok(env_set("dnsip6", NULL));
+		ut_asserteq(-ENOENT, net_lwip_dns_refresh(&test->net));
+		ut_assert(ip_addr_isany(dns_getserver(0)));
+
+		/* RDNSS may arrive before the first refresh after removing an override. */
+		ut_assertok(env_set("dnsip6", servers[i]));
+		ut_assertok(net_lwip_dns_refresh(&test->net));
+		ut_assertok(env_set("dnsip6", NULL));
+		ut_assertok(ip6_test_rdnss_servers(test->net.dev, 5, 0, 1));
+		ut_assertok(net_lwip_poll());
+		ut_asserteq(-ENOENT, net_lwip_dns_refresh(&test->net));
+		ut_asserteq_str("FE80::2", ipaddr_ntoa(dns_getserver(0)));
+		ut_assert(ip_addr_isany(dns_getserver(1)));
+		ip6_test_age(6);
+		ut_assert(ip_addr_isany(dns_getserver(0)));
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_rdnss_override(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_rdnss_override);
+}
+DM_TEST(dm_test_lwip_ip6_rdnss_override, UTF_SCAN_FDT);
+
+static int ip6_test_rdnss_chain(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const u8 invalid_lengths[] = { 1, 4, 7 };
+	struct {
+		struct ra_header ra;
+		struct rdnss_option dns;
+		ip6_addr_p_t extra;
+	} reply = {};
+	struct eth_sandbox_priv *priv;
+	struct pbuf *head, *tail;
+	ip6_addr_t src, dst, server;
+	unsigned int first = ETHER_HDR_SIZE + IP6_HLEN + sizeof(reply.ra);
+	unsigned int len;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ut_asserteq(-ENOENT, net_lwip_dns_refresh(&test->net));
+	ip6addr_aton("fe80::1", &src);
+	ip6addr_aton("ff02::1", &dst);
+	reply.ra.type = ICMP6_TYPE_RA;
+	reply.ra.router_lifetime = htons(1800);
+	reply.dns.type = ND6_OPTION_TYPE_RDNSS;
+	reply.dns.length = (sizeof(reply.dns) + sizeof(reply.extra)) / 8;
+	reply.dns.lifetime = htonl(100);
+	ip6addr_aton("fe80::2", &server);
+	ip6_addr_copy_to_packed(reply.dns.rdnss_address[0], server);
+	ip6addr_aton("fe80::3", &server);
+	ip6_addr_copy_to_packed(reply.extra, server);
+	ut_assertok(ip6_test_reply(test->net.dev, &src, &dst, &reply, sizeof(reply),
+				 IP6_NEXTH_ICMP6, false));
+	ut_assertok(net_lwip_poll());
+	ut_assert(!ip_addr_isany(dns_getserver(0)));
+	ut_assert(!ip_addr_isany(dns_getserver(1)));
+	dns_setserver(0, NULL);
+	dns_setserver(1, NULL);
+
+	/* Deliver identical packet bytes with the RDNSS option in a second pbuf. */
+	ut_assertok(ip6_test_reply(test->net.dev, &src, &dst, &reply, sizeof(reply),
+				 IP6_NEXTH_ICMP6, false));
+	priv = dev_get_priv(test->net.dev);
+	ut_asserteq(1, priv->recv_packets);
+	len = priv->recv_packet_length[0];
+	head = pbuf_alloc(PBUF_RAW, first, PBUF_RAM);
+	ut_assertnonnull(head);
+	tail = pbuf_alloc(PBUF_RAW, len - first, PBUF_RAM);
+	if (!tail)
+		pbuf_free(head);
+	ut_assertnonnull(tail);
+	ut_asserteq(ERR_OK, pbuf_take(head, priv->recv_packet_buffer[0], first));
+	ut_asserteq(ERR_OK, pbuf_take(tail, priv->recv_packet_buffer[0] + first, len - first));
+	pbuf_cat(head, tail);
+	priv->recv_packets = 0;
+	ut_asserteq(ERR_OK, test->net.netif->input(head, test->net.netif));
+	ut_asserteq_str("FE80::2", ipaddr_ntoa(dns_getserver(0)));
+	ut_asserteq_str("FE80::3", ipaddr_ntoa(dns_getserver(1)));
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(invalid_lengths); i++) {
+		dns_setserver(0, NULL);
+		dns_setserver(1, NULL);
+		reply.dns.length = invalid_lengths[i];
+		ut_assertok(ip6_test_reply(test->net.dev, &src, &dst, &reply, sizeof(reply),
+					 IP6_NEXTH_ICMP6, false));
+		ut_assertok(net_lwip_poll());
+		ut_assert(ip_addr_isany(dns_getserver(0)));
+		ut_assert(ip_addr_isany(dns_getserver(1)));
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_rdnss_chain(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_rdnss_chain);
+}
+DM_TEST(dm_test_lwip_ip6_rdnss_chain, UTF_SCAN_FDT);
+#endif
+
+static int dm_test_lwip_ip6_ping(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_ping);
+}
+DM_TEST(dm_test_lwip_ip6_ping, UTF_SCAN_FDT);
+
+static int dm_test_lwip_ip6_dad(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_dad);
+}
+DM_TEST(dm_test_lwip_ip6_dad, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int dm_test_lwip_ip6_dad_scope(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_dad_scope);
+}
+DM_TEST(dm_test_lwip_ip6_dad_scope, UTF_SCAN_FDT);
+
+#if CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY)
+static int dm_test_lwip_ip6_slaac(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_slaac);
+}
+DM_TEST(dm_test_lwip_ip6_slaac, UTF_SCAN_FDT);
+
+static int dm_test_lwip_ip6_lifetimes(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_lifetimes);
+}
+DM_TEST(dm_test_lwip_ip6_lifetimes, UTF_SCAN_FDT);
+#endif

-- 
2.53.0

