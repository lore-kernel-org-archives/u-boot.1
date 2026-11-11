Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219D606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zis3X3Vi;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWmXjSwc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1B0E60E31;
	Wed, 11 Nov 2026 20:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-o0COs-6NCp; Wed, 11 Nov 2026 20:12:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEFFB60DFA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427921;
	b=IBOp14qNXkvxRsmMeuwixvLyv8G2xqP7XhHtKAGNRvhJ4sUBf716BjH07lk527MYAoPD
	 3qCovd3sLrP5pBwIaKdW9Wvc78YxODm5KpD/FWWTo+WCNTGLSMT/w/CyEWHiWkxlVBP/4
	 V4vwogt2FZZPbAPsoltlQOQbS1Y9+vBTpGsEqTAHHlxyBVzhtSDeDhjplSABNVMCqYR4l
	 z6N3DWkCXHs+UhDW0hlgxTOG5gFAuRyTM1E0CPdJGgzFYDrfbPh8/ftpJKP6Z5uatSQ/W
	 oNSjHLqhhZDZZbgRqVITQDdKGrB4oR9XRnBg+P6jCWqawk3sQizk8yR5UgmK/gttoGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EeZ0EW/Unuqg//s4JbXgXah8c8Qjfp8KAGiSa8wMAn0=;
	b=tfYM5Df5JQd7DnqDDEvZ7eaWn0KeD/TCkBIbKW3MEcRqEOSlNgIl7krnzWpfIjDKl7fm
	 xEPT9XfkxifLBisUrMnuWEEXCLkbkKj+R+dondbBn2PSjfKacrcP9rm0+99FlMt6RqY1h
	 sP85tvRbaumaFoOZDT4SbMoZCXZ9D1++k5tQUKgk/cCt6/VE2t3eO2LNEtd3OWj6Vgn2z
	 f273R/oH6FfNXPY/z5nEkY1PrCPbFkuFvxnyQC3EdQg87iexvDeNxhEqYHzzLqKq5wEDb
	 9Plv4pGINruINLE/exAv7TqlXslEvUOH8tIah55fv+qa2Hf2xFsUV4U5IwdktE7VUyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427921;
	bh=EeZ0EW/Unuqg//s4JbXgXah8c8Qjfp8KAGiSa8wMAn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zis3X3Vihsr6BVOMHKX7QXOZq2B8GlFF3CfvNMbj+LDqW0BDEVBx20qeWjQLe/0M+
	 X4Thynf1WDaPtrYkwxDtCZYY93F7Kppudn0Bc6Y7IKhWihDc7kpCnvfV+iP8Xn5UQR
	 thtuLvyxtgjsHztmLrXuQjWQsbSZ4vIPrOXKeRFKrNKgdFDml+p64xNmjfFciwg1cI
	 CxJ/Mc6tXGu1m1ql2ZXyCDouCo6wOt4o03VB9Cmj/ud8JRIUPkAoFEERC7mrAvhrK9
	 OyrOWs1gzbqJ5YnSIdorqe906lackohgbntLZ0tVJW0yLCfUbGqbPa+nIr/9xrGTMY
	 NiSBV2z/z2P1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEFFB60DFA;
	Wed, 11 Nov 2026 20:12:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E5852FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0646D403BB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KFc6BcCueJbr for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3B45B40336
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=MWmXjSwc
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B45B40336
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:43 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-85f39332862so1457592a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427903; x=1795032703;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EeZ0EW/Unuqg//s4JbXgXah8c8Qjfp8KAGiSa8wMAn0=;
 b=MWmXjSwcJMXPdE6kzA0gggL/fz9cw3Ic7gZiOonZKQhidewrNn55BOMvoVYo5EyhNi
 RoXbcQkU2FzQBcNjEVzjtbSVoz6LVyTXythY3aeY1eeoY/zyRrGDtPa8Ap9uyOWcGfuN
 tr50SCgDzFKXZnQFhA+Zfl5tuL/mUHSmU5Z9TAeafF74MiRB0hgCIFvcumKAgfABtuk/
 mPtX74p+RI/G4czFAAD3LT2Ay8NcHMqZ9iTkRGP1VYOdKKzg168Pvah55Nw+amGv9zJQ
 sHVK8K8qR80zoQXKRmE3RyWXSADoY+MfT3XwTvZnGy4DR2/H8kHYtAis/rDmiUVcGZrk
 T2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427903; x=1795032703;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EeZ0EW/Unuqg//s4JbXgXah8c8Qjfp8KAGiSa8wMAn0=;
 b=mVhUHH1rVczTeBE6ywdEsLIucBaUB3GPtMaDjDJlNv3qs2Lb2cVS/wc/E5lwx4W7Q5
 45rM3vm01UUahbJTUbt2RUZYg6q8/Daut+V5sYmc0bVE58VpRQX0ZPdI6hJRlcdvGgcx
 M8FunkRQQgrenBTFFbLs5Clvn4+Kc1YtYk3T70h165H6zFcahAFo9pSG05xKSBTDvwuf
 zhxiaZaZa38+XupK/Tvk+vlc1xusz6tXHAEiYWRcauKWfFFgy4KxBtJLorJzDfnF8aO7
 UgqHK0pVlfNPcM9hnoweGW2bAt5ILrxKlXyxDgzKvX5e++su+pMN2zIWZY98W0DuskMn
 GL8g==
X-Forwarded-Encrypted: i=1;
 AL+hErGF2gMgzI/xFWYkawDVtOcXgcgYbfHlwiMG02e0rtqUA2EUchJupHyoci69Zr3ek+9vdJPXc/s=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z80YgaoZCtJYxV65FNWWXLzlfxQ8x04qhkbrT31JrvODVTdN0sK
 Y7pktZhzClkaHnCOSW2jITr/uwkJst68zOsurCinr0C8WECXL5nSwW06
X-Gm-Gg: AYBFou3y219NFoifpF3GFfVP97FaqSp6A5VaAo0WcaItuhaJ1wzvs+lTZUfnYFCi260
 o/q+5qe5ObiEb8MTrOEj+WjTUCQRhAvuN4Rfd+AZIK8e4p6F/knUqkQnoVV84bp8ah8mWHYvt8t
 cSAAOA+5Cxbqr3EY8l5/mY9NlrfNXdiyYcDnE9ARHXzi9FuIVGZeeRwP8brqb9QNC+Qk2ltnHcF
 1vv0ReE4DtInaB0JUjnHFlhpb+ayHitsXwfuV5mD7bpvUttKIPuaUFV3kQxoE+iEbfSaq9Pfs/q
 PzFs0h/qDsZOudFzUW2xj1VbESPz5iR4wExsUBOsJLRx2Lkv3Wl0t4kIfcx9/i1Vhbl5bb5Y9wz
 1CUiVAO6cT+rNf+Tww4+ptru5eILIDQnAc4Lqu87Y2w+A1xGPZpSJsI6Qcf6qLGLQprmbfu8WUQ
 JAp9kXD4xMdOgFPXgdMXKrUwPuVJal7MwDhqaWCAXNRQ7xpCQ8uAnYIfA7Z60bgB6fesog6+Dxv
 uz6vWqCNCBOdMfdHXUcr3z/NqnRSzeNeHA0IkxT4gR+osHAxUhOo52IqDLM23HUftiG0owK0Q/F
 3pPuR6gjBlbdoqMB9gz17wWcLw/66sQ8QE4WJo7V9i7xBX4vJ4YlB/+JvA7mKvyVpyjhKsyg8TS
 lBS/9UxsTOfTojlU+tx0FLkKmPelOLM/ERC6Ps6n9NlK3s6287VPXL+OqjaXHu5JyHKSEq0sNF+
 mwhwmhBDqWp8ZMuyQCTZi94mdQLWE8nMEe+N+KeSaR4+UsP8LOUaI=
X-Received: by 2002:a05:6808:1512:b0:4fa:8d48:3a6a with SMTP id
 5614622812f47-56b961950c4mr2893076b6e.18.1794427902501; 
 Wed, 11 Nov 2026 12:11:42 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:42 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:26 -0700
Subject: [PATCH 19/19] test: net: exercise lwIP DHCPv6 lease and boot
 lifecycles
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-19-eb0ee8f8da1a@gmail.com>
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

Add DHCPv6 acquisition and boot-file replies to the sandbox peer. Cover
renewal, rebinding, withdrawal and expiry with shared IPv4 and link-local
traffic, cancelled reacquisition, DNS updates and reserved-memory
protection for HTTP downloads. Keep DHCP-managed lifetimes independent
of router advertisements.

Exercise boot-URL renewal during resolution, configuration-only DHCPv6
with unavailable DNS or unsupported protocols, bounded NoBinding recovery
and URI-like TFTP filenames. Reject overflowing URL ports while accepting
valid boundary values. Check HTTP filename replacement with slash-bearing
queries and fragments, empty paths, full URL overrides and the exact
output buffer limit.

Exercise Solicit retry limits with simulated time, including no-address
Advertises, failure statuses before and after SOL_MAX_RT, Rapid Commit
failure Replies and conflicting limits. Check rejection of malformed,
mismatched and out-of-range updates while retaining the default interval.

Reject unauthenticated HTTPS boot URLs containing HTTP URLs in their
paths or queries without issuing a cleartext request.

Cover replacement leases and DAD across interface close and reopen,
including duplicate detection, expiry, timeout and old-address socket
invalidation. Fail restoration through allocation and port-binding
errors, retain the shared interface for another client, and verify that
retry resumes both Renew and Rebind.

Verify that output-only netconsole services renewal and stops transmitting
after lease expiry without entering the startup preparation wait.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/lwip_ipv6.c | 1264 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1264 insertions(+)

diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
index 185f7aafb4d..d2a6a3089f6 100644
--- a/test/dm/lwip_ipv6.c
+++ b/test/dm/lwip_ipv6.c
@@ -29,6 +29,22 @@
 #include <dm/test.h>
 #include <test/ut.h>
 
+enum ip6_solmax_test {
+	IP6_SOLMAX_NORMAL,
+	IP6_SOLMAX_DEFAULT,
+	IP6_SOLMAX_EMPTY,
+	IP6_SOLMAX_STATUS_BEFORE,
+	IP6_SOLMAX_STATUS_AFTER,
+	IP6_SOLMAX_IA_STATUS,
+	IP6_SOLMAX_BAD_XID,
+	IP6_SOLMAX_BAD_CLIENT,
+	IP6_SOLMAX_TRUNCATED,
+	IP6_SOLMAX_TOO_LOW,
+	IP6_SOLMAX_TOO_HIGH,
+	IP6_SOLMAX_CONFLICT,
+	IP6_SOLMAX_COUNT,
+};
+
 struct ip6_test {
 	struct net_lwip_ctx net;
 	unsigned int dad;
@@ -45,6 +61,25 @@ struct ip6_test {
 	unsigned int dns4_queries;
 	bool drop_dns;
 	ip6_addr_t last_dns;
+	unsigned int dhcp_solicits;
+	unsigned int dhcp_requests;
+	unsigned int dhcp_declines;
+	unsigned int dhcp_renews;
+	unsigned int dhcp_rebinds;
+	u64 request_times[16];
+	u32 request_xids[16];
+	enum ip6_solmax_test solmax;
+	bool drop_requests;
+	bool request_no_binding;
+	bool drop_renew;
+	bool drop_rebind;
+	bool withdraw_lease;
+	bool no_binding;
+	bool bad_renew;
+	u32 lease_t1;
+	u32 lease_t2;
+	u32 lease_valid;
+	unsigned int dhcp_bad;
 	unsigned int http_requests;
 	unsigned int rpc_requests;
 	unsigned int sntp_requests;
@@ -52,12 +87,20 @@ struct ip6_test {
 	bool console_no_reply;
 	const char *http_host;
 	const char *http_target;
+	const char *boot_url;
+	const char *renew_boot_url;
+	const char *lease_dns;
+	const char *lease_addr;
+	const char *withdraw_addr;
+	bool withdraw_first;
 	const char *tftp_file;
 	bool unreachable;
 	bool listener;
 	bool listener_done;
 	u32 rdnss_lifetime;
+	bool rapid;
 	bool lease_conflict;
+	bool lease_ra;
 	bool conflict;
 	bool advertise;
 	bool cancel;
@@ -329,6 +372,12 @@ static int ip6_test_dns_reply(struct udevice *dev, struct ip6_hdr *ip)
 	u8 *query = (void *)((struct udp_hdr *)(ip + 1) + 1), reply[512];
 	int len;
 
+	if (test->renew_boot_url) {
+		test->boot_url = test->renew_boot_url;
+		test->renew_boot_url = NULL;
+		timer_test_add_offset(9000);
+		return 0;
+	}
 	if (test->drop_dns) {
 		test->dns_queries++;
 		timer_test_add_offset(11000);
@@ -380,6 +429,187 @@ static int ip6_test_ipv4(struct udevice *dev, void *packet, unsigned int len)
 	return 0;
 }
 
+static u8 *ip6_test_option(u8 *p, u16 code, const void *value, u16 len)
+{
+	put_unaligned_be16(code, p);
+	put_unaligned_be16(len, p + 2);
+	if (len)
+		memcpy(p + 4, value, len);
+	return p + 4 + len;
+}
+
+static int ip6_test_dhcp_reply(struct udevice *dev, struct ip6_hdr *ip)
+{
+	struct ip6_test *test = ((struct eth_sandbox_priv *)dev_get_priv(dev))->priv;
+	u8 *query = (void *)((struct udp_hdr *)(ip + 1) + 1);
+	u8 reply[1200], ia[68] = {}, *p = reply, *client_id = NULL;
+	const u8 *q = query + 4, *end = query + IP6H_PLEN(ip) - UDP_HLEN;
+	const u8 server[] = { 0, 3, 0, 1, 0, 1, 2, 3, 4, 5 };
+	const char *url = test->boot_url ?: "tftp://[fe80::2]/ipv6.bin";
+	ip6_addr_t addr;
+	u8 preference = 255;
+	u32 iaid = 0;
+	u16 ia_len = 40;
+	unsigned int bad_offset = 0;
+	int ret;
+
+	if (query[0] == 9) {
+		test->dhcp_declines++;
+		return 0;
+	}
+	if (query[0] != 1 && query[0] != 3 && query[0] != 5 && query[0] != 6)
+		return -EINVAL;
+	if (query[0] == 1) {
+		if (test->solmax && test->dhcp_solicits < ARRAY_SIZE(test->request_times)) {
+			test->request_times[test->dhcp_solicits] = get_timer_us(0);
+			test->request_xids[test->dhcp_solicits] =
+				get_unaligned_be32(query) & 0xffffff;
+		}
+		test->dhcp_solicits++;
+		if (test->solmax && test->dhcp_solicits == 10)
+			console_in_puts("\x03");
+		if (test->solmax && test->dhcp_solicits > 2)
+			return 0;
+	} else if (query[0] == 3) {
+		if (test->dhcp_requests < ARRAY_SIZE(test->request_times)) {
+			test->request_times[test->dhcp_requests] = get_timer_us(0);
+			test->request_xids[test->dhcp_requests] =
+				get_unaligned_be32(query) & 0xffffff;
+		}
+		test->dhcp_requests++;
+		if (test->drop_requests)
+			return 0;
+	} else if (query[0] == 5) {
+		test->dhcp_renews++;
+		if (test->drop_renew)
+			return 0;
+	} else {
+		test->dhcp_rebinds++;
+		if (test->drop_rebind)
+			return 0;
+	}
+	memcpy(p, query, 4);
+	*p = query[0] == 1 && !test->rapid ? 2 : 7;
+	p += 4;
+	while (q < end) {
+		u16 code, len;
+
+		if (end - q < 4)
+			return -EINVAL;
+		code = get_unaligned_be16(q);
+		len = get_unaligned_be16(q + 2);
+		if (len > end - q - 4)
+			return -EINVAL;
+		if (code == 1) {
+			client_id = p + 4;
+			p = ip6_test_option(p, 1, q + 4, len);
+		}
+		if (code == 2 && query[0] == 6)
+			return -EINVAL;
+		if (code == 3 && len >= 12)
+			iaid = get_unaligned_be32(q + 4);
+		q += 4 + len;
+	}
+	if (!client_id)
+		return -EINVAL;
+	p = ip6_test_option(p, 2, server, sizeof(server));
+	p = ip6_test_option(p, 7, &preference, 1);
+	put_unaligned_be32(iaid, ia);
+	if (test->solmax) {
+		u8 limit[4], status[] = { 0, 2 };
+		u32 seconds = 60;
+
+		if (test->solmax == IP6_SOLMAX_TOO_LOW)
+			seconds = 59;
+		else if (test->solmax == IP6_SOLMAX_TOO_HIGH)
+			seconds = 86401;
+		else if (test->solmax == IP6_SOLMAX_CONFLICT && test->dhcp_solicits == 2)
+			seconds = 120;
+		if (test->solmax == IP6_SOLMAX_STATUS_BEFORE)
+			p = ip6_test_option(p, 13, status, sizeof(status));
+		put_unaligned_be32(seconds, limit);
+		if (test->solmax != IP6_SOLMAX_DEFAULT)
+			p = ip6_test_option(p, 82, limit, sizeof(limit));
+		if (test->solmax == IP6_SOLMAX_STATUS_AFTER)
+			p = ip6_test_option(p, 13, status, sizeof(status));
+		if (test->solmax == IP6_SOLMAX_IA_STATUS) {
+			ip6_test_option(ia + 12, 13, status, sizeof(status));
+			p = ip6_test_option(p, 3, ia, 18);
+		}
+		if (test->solmax == IP6_SOLMAX_BAD_XID)
+			reply[3] ^= 1;
+		if (test->solmax == IP6_SOLMAX_BAD_CLIENT)
+			client_id[4] ^= 1;
+		if (test->solmax == IP6_SOLMAX_TRUNCATED)
+			*p++ = 0;
+		if (test->rapid)
+			p = ip6_test_option(p, 14, NULL, 0);
+		return ip6_test_udp(dev, ip, 547, reply, p - reply);
+	}
+	put_unaligned_be32(test->lease_t1, ia + 4);
+	put_unaligned_be32(test->lease_t2, ia + 8);
+	put_unaligned_be16(5, ia + 12);
+	put_unaligned_be16(24, ia + 14);
+	ip6addr_aton(test->lease_addr ?: "2001:db8:1::123", &addr);
+	memcpy(ia + 16, addr.addr, 16);
+	put_unaligned_be32(test->lease_valid ? test->lease_valid / 2 : 900, ia + 32);
+	put_unaligned_be32(test->lease_valid ?: 1800, ia + 36);
+	if (query[0] == 5 && test->withdraw_lease)
+		memset(ia + 32, 0, 8);
+	if (test->withdraw_addr) {
+		u8 *withdraw = ia + (test->withdraw_first ? 12 : 40);
+
+		if (test->withdraw_first)
+			memmove(ia + 40, ia + 12, 28);
+		memset(withdraw, 0, 28);
+		put_unaligned_be16(5, withdraw);
+		put_unaligned_be16(24, withdraw + 2);
+		ip6addr_aton(test->withdraw_addr, &addr);
+		memcpy(withdraw + 4, addr.addr, 16);
+		ia_len += 28;
+	}
+	bad_offset = p + 4 + 14 - reply;
+	if (((query[0] == 5 || query[0] == 6) && test->no_binding) ||
+	    (query[0] == 3 && test->request_no_binding)) {
+		put_unaligned_be16(13, ia + 12);
+		put_unaligned_be16(2, ia + 14);
+		put_unaligned_be16(3, ia + 16);
+		p = ip6_test_option(p, 3, ia, 18);
+	} else {
+		p = ip6_test_option(p, 3, ia, ia_len);
+	}
+	if (*url)
+		p = ip6_test_option(p, 59, url, strlen(url));
+	if (!test->lease_dns || *test->lease_dns) {
+		ip6addr_aton(test->lease_dns ?: "fe80::2", &addr);
+		p = ip6_test_option(p, 23, addr.addr, 16);
+	}
+	if (test->rapid)
+		p = ip6_test_option(p, 14, NULL, 0);
+	if (query[0] == 5 && test->bad_renew)
+		reply[3] ^= 1;
+	if (test->dhcp_bad) {
+		u8 bad[512];
+
+		memcpy(bad, reply, p - reply);
+		switch (test->dhcp_bad) {
+		case 1:
+			bad[3] ^= 1;
+			break;
+		case 2:
+			bad[client_id - reply + 4] ^= 1;
+			break;
+		case 3:
+			put_unaligned_be16(255, bad + bad_offset);
+			break;
+		}
+		ret = ip6_test_udp(dev, ip, 547, bad, p - reply);
+		if (ret)
+			return ret;
+	}
+	return ip6_test_udp(dev, ip, 547, reply, p - reply);
+}
+
 static int ip6_test_http_reply(struct udevice *dev, struct ip6_hdr *ip)
 {
 	struct ip6_test *test = ((struct eth_sandbox_priv *)dev_get_priv(dev))->priv;
@@ -521,6 +751,8 @@ static int ip6_test_tx(struct udevice *dev, void *packet, unsigned int len)
 		}
 		if (ntohs(udp->dest) == 53)
 			return ip6_test_dns_reply(dev, ip);
+		if (ntohs(udp->dest) == 547)
+			return ip6_test_dhcp_reply(dev, ip);
 		if (ntohs(udp->dest) == 111 || ntohs(udp->dest) == 4000 || ntohs(udp->dest) == 4001)
 			return ip6_test_rpc_reply(dev, ip);
 		if (ntohs(udp->dest) == 123)
@@ -558,6 +790,8 @@ static int ip6_test_tx(struct udevice *dev, void *packet, unsigned int len)
 			     !memcmp(&ns->target_address, "\x20\x01", 2)))
 				return ip6_test_na(dev, ns, &src, true);
 			timer_test_add_offset(1100);
+			if (test->lease_ra && !memcmp(&ns->target_address, "\x20\x01", 2))
+				return ip6_test_ra(dev);
 			return 0;
 		}
 		test->neighbors++;
@@ -1787,6 +2021,1036 @@ static int dm_test_lwip_ip6_rdnss_chain(struct unit_test_state *uts)
 DM_TEST(dm_test_lwip_ip6_rdnss_chain, UTF_SCAN_FDT);
 #endif
 
+#if CONFIG_IS_ENABLED(CMD_DHCP6)
+static void ip6_test_retry_tick(void *arg)
+{
+	timer_test_add_offset(1000);
+	sys_timeout(1, ip6_test_retry_tick, arg);
+}
+
+static int ip6_test_solmax(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ut_assertok(env_set("autoload", "no"));
+	for (unsigned int rapid = 0; rapid <= IS_ENABLED(CONFIG_DHCP6_RAPID_COMMIT); rapid++) {
+		for (test->solmax = IP6_SOLMAX_DEFAULT;
+		     test->solmax < IP6_SOLMAX_COUNT; test->solmax++) {
+			bool capped = test->solmax >= IP6_SOLMAX_EMPTY &&
+				      test->solmax <= IP6_SOLMAX_IA_STATUS;
+			u64 last_interval;
+			int ret;
+
+			/* Conflicting Advertises are not a Reply-selection policy. */
+			if (rapid && test->solmax == IP6_SOLMAX_CONFLICT)
+				continue;
+			test->rapid = rapid;
+			test->dhcp_solicits = 0;
+			test->dhcp_requests = 0;
+			console_record_reset();
+			clear_ctrlc();
+			sys_timeout(1, ip6_test_retry_tick, NULL);
+			ret = run_command("dhcp6", 0);
+			sys_untimeout(ip6_test_retry_tick, NULL);
+			ut_asserteq(CMD_RET_FAILURE, ret);
+			ut_asserteq(10, test->dhcp_solicits);
+			ut_asserteq(0, test->dhcp_requests);
+			ut_assertnull(env_get("ip6addr"));
+			ut_assertnull(netif_default);
+			for (unsigned int i = 1; i < test->dhcp_solicits; i++)
+				ut_asserteq(test->request_xids[0], test->request_xids[i]);
+			last_interval = test->request_times[9] - test->request_times[8];
+			if (capped) {
+				/* A 60-second cap allows 10% jitter and one timer tick. */
+				ut_assert(last_interval >= 54000000);
+				ut_assert(last_interval < 68000000);
+			} else {
+				/* The default must allow retries beyond the old 120-second cap. */
+				ut_assert(last_interval > 140000000);
+			}
+		}
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_solmax(struct unit_test_state *uts)
+{
+	/* Allow enough simulated time to observe ten exponential retries. */
+	if (CONFIG_NET_RETRY_COUNT < 200)
+		return -EAGAIN;
+	return ip6_test_run(uts, ip6_test_solmax);
+}
+DM_TEST(dm_test_lwip_ip6_solmax, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int ip6_test_dhcp_ports(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char *const ports[] = {
+		"", "0", "65536", "+69", "69junk", "4294967365",
+		"18446744073709551685", "99999999999999999999999999999999",
+	};
+	char url[128];
+
+	ut_assertok(env_set("autoload", "no"));
+	for (unsigned int i = 0; i < ARRAY_SIZE(ports); i++) {
+		ut_assertok(env_set("tftpdstp", "1069"));
+		snprintf(url, sizeof(url), "tftp://[fe80::2]:%s/ipv6.bin", ports[i]);
+		test->boot_url = url;
+		ut_asserteq(CMD_RET_FAILURE, run_command("dhcp6", 0));
+		ut_asserteq_str("1069", env_get("tftpdstp"));
+		ut_asserteq(0, test->requests);
+		ut_assertnull(netif_default);
+	}
+	test->boot_url = "tftp://[fe80::2]:00065535/ipv6.bin";
+	ut_assertok(run_command("dhcp6", 0));
+	ut_asserteq_str("65535", env_get("tftpdstp"));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_dhcp_ports(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_dhcp_ports);
+}
+DM_TEST(dm_test_lwip_ip6_dhcp_ports, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int ip6_test_dhcp_config(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char *const urls[] = {
+		"tftp://missing.test:1069/ipv6.bin",
+		"http://missing.test/ipv6.bin",
+		"https://missing.test/ipv6.bin",
+		"unsupported://missing.test/ipv6.bin",
+	};
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("autoload", "no"));
+	test->drop_dns = true;
+	for (unsigned int i = 0; i < ARRAY_SIZE(urls); i++) {
+		test->boot_url = urls[i];
+		ut_assertok(run_command("dhcp6", 0));
+		ut_asserteq_str("2001:DB8:1::123", env_get("ip6addr"));
+		ut_asserteq_str(i ? urls[i] : "ipv6.bin", env_get("bootfile"));
+		ut_asserteq(0, test->dns_queries);
+		ut_asserteq(0, test->requests);
+		ut_asserteq(0, test->http_requests);
+		ut_assertnull(netif_default);
+		if (!i) {
+			ut_asserteq_str("missing.test", env_get("serverip6"));
+			ut_asserteq_str("1069", env_get("tftpdstp"));
+		}
+	}
+	ut_assertok(env_set("autoload", "yes"));
+	ut_asserteq(CMD_RET_FAILURE, run_command("dhcp6 2100000", 0));
+	ut_asserteq(CMD_RET_FAILURE, run_command("dhcp6 2100000 override.bin", 0));
+	ut_asserteq(0, test->dns_queries);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_dhcp_config(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_dhcp_config);
+}
+DM_TEST(dm_test_lwip_ip6_dhcp_config, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int ip6_test_restore_failure(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("ipaddr", "192.0.2.10"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	test->lease_t1 = 20;
+	test->lease_t2 = 40;
+	test->lease_valid = 1000;
+	test->drop_renew = true;
+	for (unsigned int i = 0; i < 2; i++) {
+		struct net_lwip_ctx command = {};
+		struct udp_pcb *blocker = NULL;
+		unsigned int renews = test->dhcp_renews;
+		unsigned int rebinds = test->dhcp_rebinds;
+		int ret;
+
+		ut_assertok(run_command("dhcp6", 0));
+		ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+		ut_assertok(net_lwip_start(&command, NET_LWIP_ADDR_ENV_STRICT));
+		if (i) {
+			blocker = udp_new_ip_type(IPADDR_TYPE_V6);
+			ut_assertnonnull(blocker);
+			ut_asserteq(ERR_OK, udp_bind(blocker, IP6_ADDR_ANY, 546));
+		} else {
+			malloc_enable_testing(0);
+		}
+		ret = net_lwip_ip6_init(&command);
+		malloc_disable_testing();
+		net_lwip_stop(&command);
+		if (blocker)
+			udp_remove(blocker);
+		ut_asserteq(i ? -EADDRINUSE : -ENOMEM, ret);
+		ut_asserteq_ptr(test->net.netif, netif_default);
+		ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+		ut_assertok(net_lwip_poll());
+#if CONFIG_IS_ENABLED(CMD_PING)
+		ut_assertok(run_command("ping 192.0.2.2", 0));
+#endif
+		/* The keeper retains the same interface throughout failure and retry. */
+		ut_assertok(net_lwip_ip6_start(&test->net));
+		timer_test_add_offset(21000);
+		ut_assertok(net_lwip_poll());
+		ut_asserteq(renews + 1, test->dhcp_renews);
+		timer_test_add_offset(21000);
+		ut_assertok(net_lwip_poll());
+		ut_asserteq(rebinds + 1, test->dhcp_rebinds);
+		ut_assertok(net_lwip_poll());
+		ut_assert(ip6_addr_isvalid(netif_ip6_addr_state(test->net.netif, 1)));
+		net_lwip_stop(&test->net);
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_restore_failure(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_restore_failure);
+}
+DM_TEST(dm_test_lwip_ip6_restore_failure, UTF_SCAN_FDT);
+
+#if CONFIG_IS_ENABLED(DNS) && CONFIG_IS_ENABLED(CMD_TFTPBOOT)
+static int ip6_test_boot_url_renew(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char *const urls[] = {
+		"tftp://new-long.test/wrong.bin", "http://new.test/wrong.bin", "",
+	};
+	u8 *data = map_sysmem(0x2100000, 9);
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("autoload", "yes"));
+	ut_assertok(env_set("autostart", "no"));
+	test->lease_t1 = 8;
+	test->lease_t2 = 20;
+	test->lease_valid = 60;
+	test->tftp_file = "123:image";
+	for (unsigned int i = 0; i < ARRAY_SIZE(urls); i++) {
+		unsigned int renews = test->dhcp_renews;
+
+		for (unsigned int j = 0; j < 31; j++)
+			dns_tmr();
+		test->boot_url = "tftp://old.test/123%3Aimage";
+		test->renew_boot_url = urls[i];
+		ut_assertok(run_command("dhcp6 2100000", 0));
+		ut_assert(test->dhcp_renews > renews);
+		ut_asserteq_str("123:image", env_get("bootfile"));
+		ut_asserteq(i + 1, test->requests);
+		ut_asserteq(9, net_boot_file_size);
+		ut_asserteq_mem("ipv6-tftp", data, 9);
+	}
+	unmap_sysmem(data);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_boot_url_renew(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_boot_url_renew);
+}
+DM_TEST(dm_test_lwip_ip6_boot_url_renew, UTF_SCAN_FDT);
+#endif
+
+static int ip6_test_no_binding(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ut_assertok(env_set("autoload", "no"));
+	test->lease_t1 = 20;
+	test->lease_t2 = 40;
+	test->lease_valid = 3600;
+	for (unsigned int mode = 0; mode < 3; mode++) {
+		test->dhcp_requests = 0;
+		test->dhcp_rebinds = 0;
+		test->drop_requests = false;
+		test->request_no_binding = false;
+		ut_assertok(run_command("dhcp6", 0));
+		ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+		ut_assertok(net_lwip_ip6_start(&test->net));
+		test->drop_requests = mode != 2;
+		test->request_no_binding = mode == 2;
+		test->drop_renew = mode == 1;
+		test->no_binding = true;
+		timer_test_add_offset(mode == 1 ? 41000 : 21000);
+		ut_assertok(net_lwip_poll());
+		ut_assertok(net_lwip_poll());
+		for (unsigned int i = 0; i < 300; i++) {
+			timer_test_add_offset(1000);
+			ut_assertok(net_lwip_poll());
+		}
+		/* One initial Request and ten recovery transmissions, then failure. */
+		ut_asserteq(11, test->dhcp_requests);
+		ut_asserteq(mode == 1, test->dhcp_rebinds);
+		for (unsigned int i = 2; i < test->dhcp_requests; i++) {
+			ut_asserteq(test->request_xids[1], test->request_xids[i]);
+			ut_assert(test->request_times[i] - test->request_times[i - 1] <
+				  35000000);
+		}
+		ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+		ut_assertok(run_command("ping6 fe80::2", 0));
+		net_lwip_stop(&test->net);
+		/* Reopening the interface must not revive the unrecovered lease. */
+		ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+		ut_assertok(net_lwip_ip6_start(&test->net));
+		ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+		timer_test_add_offset(300000);
+		ut_assertok(net_lwip_poll());
+		ut_asserteq(11, test->dhcp_requests);
+		net_lwip_stop(&test->net);
+	}
+	test->drop_requests = false;
+	test->request_no_binding = false;
+	test->no_binding = false;
+	test->drop_renew = false;
+	ut_assertok(run_command("dhcp6", 0));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_no_binding(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_no_binding);
+}
+DM_TEST(dm_test_lwip_ip6_no_binding, UTF_SCAN_FDT);
+
+static int ip6_test_lease_ra(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip6_addr_t addr, remote;
+	u32 before, preferred;
+
+	test->lease_ra = true;
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ip6addr_aton("2001:db8:1::123", &addr);
+	ut_assertok(net_lwip_ip6_lease(&test->net, &addr, 5000, 10000));
+	for (unsigned int i = 0; i < 5; i++) {
+		timer_test_add_offset(1000);
+		ut_assertok(net_lwip_poll());
+	}
+	ut_assertok(net_lwip_ip6_lease_commit(&test->net));
+	ut_assert(netif_ip6_addr_valid_life(test->net.netif, 1) > 9900);
+	ut_assert(netif_ip6_addr_pref_life(test->net.netif, 1) > 4900);
+	net_lwip_stop(&test->net);
+	ut_assertok(env_set("ip6addr", NULL));
+
+	ut_assertok(env_set("autoload", "no"));
+	test->lease_t1 = 8000;
+	test->lease_t2 = 9000;
+	test->lease_valid = 10000;
+	ut_assertok(run_command("dhcp6", 0));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	before = netif_ip6_addr_valid_life(test->net.netif, 1);
+	preferred = netif_ip6_addr_pref_life(test->net.netif, 1);
+	ut_assertok(ip6_test_ra(test->net.dev));
+	ut_assertok(net_lwip_poll());
+	ut_assert(netif_ip6_addr_valid_life(test->net.netif, 1) >= before - 1);
+	ut_assert(netif_ip6_addr_pref_life(test->net.netif, 1) >= preferred - 1);
+	ip6addr_aton("2001:db8:2::2", &remote);
+	ut_asserteq_ptr(test->net.netif, nd6_find_route(&remote));
+	for (unsigned int i = 0; i < 7205; i++) {
+		timer_test_add_offset(1000);
+		ut_assertok(net_lwip_poll());
+	}
+	ut_assert(ip6_addr_isvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	ut_asserteq(0, test->dhcp_renews);
+
+	/* Router advertisements must not extend the DHCP lease either. */
+	test->drop_renew = true;
+	test->drop_rebind = true;
+	for (unsigned int i = 0; i < 2800; i++) {
+		before = netif_ip6_addr_valid_life(test->net.netif, 1);
+		preferred = netif_ip6_addr_pref_life(test->net.netif, 1);
+		if (!(i % 100))
+			ut_assertok(ip6_test_ra(test->net.dev));
+		timer_test_add_offset(1000);
+		ut_assertok(net_lwip_poll());
+		ut_assert(netif_ip6_addr_valid_life(test->net.netif, 1) <= before);
+		ut_assert(netif_ip6_addr_pref_life(test->net.netif, 1) <= preferred);
+	}
+	ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	ut_assert(test->dhcp_renews);
+	ut_assert(test->dhcp_rebinds);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_lease_ra(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_lease_ra);
+}
+DM_TEST(dm_test_lwip_ip6_lease_ra, UTF_SCAN_FDT);
+
+static int ip6_test_dhcp(struct unit_test_state *uts, struct ip6_test *test)
+{
+	void *data = map_sysmem(0x2100000, 9);
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("autostart", "no"));
+	for (unsigned int i = 0; i < 4; i++) {
+		test->dhcp_bad = i;
+		ut_assertok(env_set("ip6addr", NULL));
+		ut_assertok(run_command("dhcp6", 0));
+		ut_asserteq_str("2001:DB8:1::123", env_get("ip6addr"));
+		ut_asserteq_str("fe80::2", env_get("serverip6"));
+		ut_asserteq_str("ipv6.bin", env_get("bootfile"));
+		ut_asserteq(i + 1, test->dhcp_requests);
+		ut_assertnull(netif_default);
+	}
+	ut_assertok(env_set("ip6addr", NULL));
+	test->dhcp_bad = 0;
+	test->lease_conflict = true;
+	ut_asserteq(CMD_RET_FAILURE, run_command("dhcp6", 0));
+	ut_assertnull(env_get("ip6addr"));
+	ut_asserteq(1, test->dhcp_declines);
+	test->lease_conflict = false;
+#if CONFIG_IS_ENABLED(DHCP6_RAPID_COMMIT)
+	test->rapid = true;
+	ut_assertok(run_command("dhcp6", 0));
+	ut_asserteq(5, test->dhcp_requests);
+#endif
+#if CONFIG_IS_ENABLED(CMD_TFTPBOOT)
+	ut_assertok(env_set("ip6addr", NULL));
+	ut_assertok(env_set("autoload", "yes"));
+	ut_assertok(run_command("dhcp6 2100000", 0));
+	ut_asserteq(9, net_boot_file_size);
+	ut_asserteq_mem("ipv6-tftp", data, 9);
+	test->boot_url = "tftp://[fe80::2]/123%3Aimage";
+	test->tftp_file = "123:image";
+	ut_assertok(run_command("dhcp6 2100000", 0));
+	ut_asserteq_str(test->tftp_file, env_get("bootfile"));
+	ut_asserteq_mem("ipv6-tftp", data, 9);
+	test->boot_url = "tftp://[fe80::2]/http%3A//image";
+	test->tftp_file = "http://image";
+	ut_assertok(run_command("dhcp6 2100000", 0));
+	ut_asserteq_str(test->tftp_file, env_get("bootfile"));
+	ut_asserteq_mem("ipv6-tftp", data, 9);
+	test->tftp_file = "override.bin";
+	ut_assertok(env_set("serverip6", NULL));
+	ut_assertok(run_command("dhcp6 2100000 override.bin", 0));
+	ut_asserteq_str("fe80::2", env_get("serverip6"));
+	ut_asserteq_str(test->tftp_file, env_get("bootfile"));
+	ut_asserteq_mem("ipv6-tftp", data, 9);
+#endif
+	if (CONFIG_IS_ENABLED(WGET)) {
+		test->http_host = "Host: [fe80::2]:8080\r\n";
+		test->boot_url = "http://[fe80::2]:8080/ipv6.bin";
+		ut_assertok(env_set("autoload", "yes"));
+		ut_assertok(run_command("dhcp6 2100000", 0));
+		ut_asserteq_str(test->boot_url, env_get("bootfile"));
+		ut_asserteq(9, net_boot_file_size);
+		ut_asserteq_mem("ipv6-http", data, 9);
+		test->boot_url = "http://[fe80::2]:8080/images/ipv6.bin";
+		ut_assertok(run_command("dhcp6 2100000 override.bin", 0));
+		ut_asserteq_str("http://[fe80::2]:8080/images/override.bin", env_get("bootfile"));
+		ut_asserteq_mem("ipv6-http", data, 9);
+		ut_assertok(run_command("dhcp6 2100000 /override.bin", 0));
+		ut_asserteq_str("http://[fe80::2]:8080/override.bin", env_get("bootfile"));
+		ut_asserteq_mem("ipv6-http", data, 9);
+	}
+	ut_assertnull(netif_default);
+	unmap_sysmem(data);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_dhcp(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_dhcp);
+}
+DM_TEST(dm_test_lwip_ip6_dhcp, UTF_SCAN_FDT | UTF_CONSOLE);
+
+#if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+static int ip6_test_dhcp_https_scheme(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char *const urls[] = {
+		"https://[fe80::3]:8443/http://[fe80::2]:8080/ipv6.bin",
+		"https://[fe80::3]:8443/image?next=http://[fe80::2]:8080/ipv6.bin",
+	};
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("autoload", "yes"));
+	ut_assertok(env_set("autostart", "no"));
+	test->http_host = "Host: [fe80::2]:8080\r\n";
+	for (unsigned int i = 0; i < ARRAY_SIZE(urls); i++) {
+		int ret;
+
+		test->boot_url = urls[i];
+		ret = run_command("dhcp6 2100000", 0);
+		ut_asserteq(0, test->http_requests);
+		ut_asserteq(CMD_RET_FAILURE, ret);
+		ut_asserteq(i + 1, test->dhcp_requests);
+		ut_asserteq_str(urls[i], env_get("bootfile"));
+		ut_assertnull(netif_default);
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_dhcp_https_scheme(struct unit_test_state *uts)
+{
+	return ip6_test_https_run(uts, ip6_test_dhcp_https_scheme);
+}
+DM_TEST(dm_test_lwip_ip6_dhcp_https_scheme, UTF_SCAN_FDT | UTF_CONSOLE);
+#endif
+
+static int ip6_test_boot_override(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const struct {
+		const char *url;
+		const char *expected;
+	} cases[] = {
+		{ "http://[fe80::2]:8080/images/original.bin",
+		  "http://[fe80::2]:8080/images/override.bin" },
+		{ "http://[fe80::2]:8080/images/original.bin?path=/other/file",
+		  "http://[fe80::2]:8080/images/override.bin" },
+		{ "http://[fe80::2]:8080/images/original.bin#path/other/file",
+		  "http://[fe80::2]:8080/images/override.bin" },
+		{ "https://boot.test/images/original.bin?q=/other/#frag/file",
+		  "https://boot.test/images/override.bin" },
+		{ "https://boot.test?path=/other/file", "https://boot.test/override.bin" },
+		{ "https://boot.test#path/other/file", "https://boot.test/override.bin" },
+		{ "https://boot.test", "https://boot.test/override.bin" },
+	};
+	char url[512], filename[600];
+	size_t prefix;
+
+	ut_assertok(env_set("autoload", "no"));
+	for (unsigned int i = 0; i < ARRAY_SIZE(cases); i++) {
+		test->boot_url = cases[i].url;
+		ut_assertok(run_command("dhcp6 2100000 override.bin", 0));
+		ut_asserteq_str(cases[i].expected, env_get("bootfile"));
+	}
+	test->boot_url = cases[1].url;
+	ut_assertok(run_command("dhcp6 2100000 /override.bin", 0));
+	ut_asserteq_str("http://[fe80::2]:8080/override.bin", env_get("bootfile"));
+	ut_assertok(run_command("dhcp6 2100000 https://new.test/override.bin", 0));
+	ut_asserteq_str("https://new.test/override.bin", env_get("bootfile"));
+	ut_assertok(run_command("dhcp6 2100000", 0));
+	ut_asserteq_str(cases[1].url, env_get("bootfile"));
+
+	/* Accept the exact buffer limit, but reject one more filename byte. */
+	prefix = strlcpy(url, "http://boot.test/", sizeof(url));
+	memset(url + prefix, 'd', sizeof(url) - prefix - 3);
+	strcpy(url + sizeof(url) - 3, "/x");
+	prefix = sizeof(url) - 2;
+	memset(filename, 'f', 1023 - prefix);
+	filename[1023 - prefix] = 0;
+	test->boot_url = url;
+	ut_assertok(run_commandf("dhcp6 2100000 %s", filename));
+	ut_asserteq(1023, strlen(env_get("bootfile")));
+	ut_asserteq_mem(url, env_get("bootfile"), prefix);
+	filename[1023 - prefix] = 'f';
+	filename[1024 - prefix] = 0;
+	ut_asserteq(CMD_RET_FAILURE, run_commandf("dhcp6 2100000 %s", filename));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_boot_override(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_boot_override);
+}
+DM_TEST(dm_test_lwip_ip6_boot_override, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int ip6_test_renew(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ut_assertok(env_set("autoload", "no"));
+	test->lease_t1 = 20;
+	test->lease_t2 = 40;
+	test->lease_valid = 80;
+	ut_assertok(run_command("dhcp6", 0));
+	ut_assertnull(netif_default);
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ut_assert(!netif_ip6_addr_isstatic(test->net.netif, 1));
+	test->lease_dns = "fe80::3";
+	timer_test_add_offset(21000);
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(1, test->dhcp_renews);
+	ut_assertok(net_lwip_poll());
+	ut_assert(netif_ip6_addr_valid_life(test->net.netif, 1) > 70);
+	ut_asserteq_str("FE80::3", env_get("dnsip6"));
+#if CONFIG_IS_ENABLED(DNS)
+	ut_asserteq_str("FE80::3", ipaddr_ntoa(dns_getserver(0)));
+	for (unsigned int i = 0; i < 31; i++)
+		dns_tmr();
+	ut_assertok(run_command("dns renewed.test dnsresult -ipv6", 0));
+	ut_asserteq_str("FE80::3", ip6addr_ntoa(&test->last_dns));
+#endif
+
+	/* Wrong-XID replies must not postpone Rebind or expiry. */
+	test->bad_renew = true;
+	test->lease_dns = "fe80::4";
+	timer_test_add_offset(21000);
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(2, test->dhcp_renews);
+	ut_asserteq_str("FE80::3", env_get("dnsip6"));
+	timer_test_add_offset(21000);
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(1, test->dhcp_rebinds);
+	ut_assertok(net_lwip_poll());
+	ut_asserteq_str("FE80::4", env_get("dnsip6"));
+#if CONFIG_IS_ENABLED(DNS)
+	ut_asserteq_str("FE80::4", ipaddr_ntoa(dns_getserver(0)));
+#endif
+	test->bad_renew = false;
+	test->no_binding = true;
+	test->lease_dns = "";
+	timer_test_add_offset(21000);
+	ut_assertok(net_lwip_poll());
+	timer_test_add_offset(1100);
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(2, test->dhcp_requests);
+	ut_assertok(net_lwip_poll());
+	ut_assertnull(env_get("dnsip6"));
+	ut_assertnull(env_get("dnsip6_2"));
+#if CONFIG_IS_ENABLED(DNS)
+	ut_assert(ip_addr_isany(dns_getserver(0)));
+#endif
+
+	/* Lease age includes time spent with no active network command. */
+	net_lwip_stop(&test->net);
+	timer_test_add_offset(81000);
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	ut_assertok(run_command("ping6 fe80::2", 0));
+	net_lwip_stop(&test->net);
+	ut_assertok(env_set("ip6addr", NULL));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	net_lwip_stop(&test->net);
+
+	/* An explicit zero lifetime withdraws the current address. */
+	test->no_binding = false;
+	ut_assertok(run_command("dhcp6", 0));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	test->withdraw_lease = true;
+	timer_test_add_offset(21000);
+	ut_assertok(net_lwip_poll());
+	ut_assertok(net_lwip_poll());
+	ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_renew(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_renew);
+}
+DM_TEST(dm_test_lwip_ip6_renew, UTF_SCAN_FDT | UTF_CONSOLE);
+
+#if CONFIG_IS_ENABLED(NETCONSOLE)
+static int ip6_test_netconsole_lease(struct unit_test_state *uts, struct ip6_test *test)
+{
+	struct stdio_dev *nc = stdio_get_by_name("nc");
+	unsigned int before, renewed, after, renews;
+	ulong start, elapsed;
+	u32 remaining;
+	bool valid;
+
+	ut_assertnonnull(nc);
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("ncip", NULL));
+	ut_assertok(env_set("ncip6", "2001:db8:2::2"));
+	ut_assertok(env_set("ncinport", NULL));
+	ut_assertok(env_set("ncoutport", NULL));
+	test->console_no_reply = true;
+	test->lease_t1 = 20;
+	test->lease_t2 = 40;
+	test->lease_valid = 80;
+	test->advertise = true;
+	ut_assertok(run_command("dhcp6", 0));
+	ut_assertok(nc->start(nc));
+	test->advertise = false;
+	nc->puts(nc, "before renewal");
+	before = test->console_packets;
+	/* Output alone must service renewal and install the accepted reply. */
+	timer_test_add_offset(21000);
+	nc->puts(nc, "renew lease");
+	nc->puts(nc, "apply renewed lease");
+	renewed = test->console_packets;
+	renews = test->dhcp_renews;
+	remaining = netif_ip6_addr_valid_life(netif_default, 1);
+	test->drop_renew = true;
+	test->drop_rebind = true;
+	timer_test_add_offset(81000);
+	start = get_timer(0);
+	nc->puts(nc, "after lease expiry");
+	nc->puts(nc, "still after lease expiry");
+	elapsed = get_timer(start);
+	after = test->console_packets;
+	valid = ip6_addr_isvalid(netif_ip6_addr_state(netif_default, 1));
+	nc->stop(nc);
+
+	ut_asserteq(1, before);
+	ut_asserteq(before + 2, renewed);
+	ut_asserteq(1, renews);
+	ut_assert(remaining > 70);
+	ut_asserteq(renewed, after);
+	ut_assert(!valid);
+	ut_assert(elapsed < 1000);
+	ut_assertnull(netif_default);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_netconsole_lease(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_netconsole_lease);
+}
+DM_TEST(dm_test_lwip_ip6_netconsole_lease, UTF_SCAN_FDT | UTF_CONSOLE);
+#endif
+
+static void ip6_test_timer(void *arg)
+{
+	*(bool *)arg = true;
+}
+
+#if LWIP_TCP
+static void ip6_test_tcp_error(void *arg, err_t err)
+{
+	*(err_t *)arg = err;
+}
+#endif
+
+static int ip6_test_replacement_setup(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("ipaddr", "192.0.2.10"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	test->lease_t1 = 20;
+	test->lease_t2 = 40;
+	test->lease_valid = 3600;
+	test->lease_addr = NULL;
+	test->withdraw_addr = NULL;
+	test->no_binding = false;
+	test->drop_renew = false;
+	test->lease_conflict = false;
+	ut_assertok(run_command("dhcp6", 0));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	for (unsigned int i = 0; i < 5; i++) {
+		timer_test_add_offset(1000);
+		ut_assertok(net_lwip_poll());
+	}
+	ut_assert(ip6_addr_isvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	test->lease_addr = "2001:db8:1::456";
+	return 0;
+}
+
+/* Receive the reply, but leave installation and DAD to the next poll. */
+static int ip6_test_replacement_reply(struct unit_test_state *uts, struct ip6_test *test)
+{
+	unsigned int requests = test->dhcp_requests;
+	unsigned int renews = test->dhcp_renews;
+	unsigned int rebinds = test->dhcp_rebinds;
+
+	timer_test_add_offset(test->drop_renew ? 41000 : 21000);
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(renews + !test->drop_renew, test->dhcp_renews);
+	ut_asserteq(rebinds + test->drop_renew, test->dhcp_rebinds);
+	if (test->no_binding) {
+		for (unsigned int i = 0; i < 20 && test->dhcp_requests == requests; i++) {
+			timer_test_add_offset(100);
+			ut_assertok(net_lwip_poll());
+		}
+		ut_asserteq(requests + 1, test->dhcp_requests);
+	}
+	return 0;
+}
+
+static int ip6_test_replacement(struct unit_test_state *uts, struct ip6_test *test)
+{
+	struct net_lwip_ctx other = {};
+	ip6_addr_t expected;
+	ip4_addr_t ip4;
+
+	ip6addr_aton("2001:db8:1::456", &expected);
+	for (unsigned int mode = 0; mode < 4; mode++) {
+		struct udp_pcb *udp;
+		struct pbuf *packet;
+		ip_addr_t dest;
+		int send;
+#if LWIP_TCP
+		struct tcp_pcb *tcp;
+		err_t error = ERR_OK;
+#endif
+
+		ut_assertok(ip6_test_replacement_setup(uts, test));
+		ip4 = *netif_ip4_addr(test->net.netif);
+		/* Lease maintenance also runs with other runtime clients attached. */
+		ut_assertok(net_lwip_start(&other, NET_LWIP_ADDR_ENV_STRICT));
+		udp = udp_new_ip_type(IPADDR_TYPE_V6);
+		ut_assertnonnull(udp);
+		ut_asserteq(ERR_OK, udp_bind(udp, netif_ip_addr6(test->net.netif, 1), 0));
+		packet = pbuf_alloc(PBUF_TRANSPORT, 1, PBUF_RAM);
+		ut_assertnonnull(packet);
+		*(u8 *)packet->payload = 0;
+		ipaddr_aton("2001:db8:1::2", &dest);
+#if LWIP_TCP
+		tcp = tcp_new_ip_type(IPADDR_TYPE_V6);
+		ut_assertnonnull(tcp);
+		ut_asserteq(ERR_OK, tcp_bind(tcp, netif_ip_addr6(test->net.netif, 1), 0));
+		tcp_arg(tcp, &error);
+		tcp_err(tcp, ip6_test_tcp_error);
+#endif
+		test->no_binding = mode < 2;
+		test->drop_renew = mode & 1;
+		test->withdraw_addr = mode == 1 || mode == 2 ? "2001:db8:1::123" : NULL;
+		test->withdraw_first = mode == 1;
+		ut_assertok(ip6_test_replacement_reply(uts, test));
+		/* Only the DHCP state machine runs here: DAD has not run yet. */
+		net_lwip_dhcp6_poll();
+		send = udp_sendto_if(udp, packet, &dest, 1234, test->net.netif);
+		pbuf_free(packet);
+		udp_remove(udp);
+#if LWIP_TCP
+		if (error == ERR_OK) {
+			tcp_err(tcp, NULL);
+			tcp_abort(tcp);
+		}
+		ut_asserteq(ERR_ABRT, error);
+#endif
+		ut_asserteq(ERR_RTE, send);
+		ut_assert(ip6_addr_zoneless_eq(&expected, netif_ip6_addr(test->net.netif, 1)));
+		ut_assert(ip6_addr_istentative(netif_ip6_addr_state(test->net.netif, 1)));
+		ut_asserteq_str("2001:DB8:1::123", env_get("ip6addr"));
+		net_lwip_stop(&other);
+		if (mode == 1) {
+			/* A close during DAD must not restore the old published address. */
+			net_lwip_stop(&test->net);
+			ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+			ut_assertok(net_lwip_ip6_init(&test->net));
+			ut_assert(ip6_addr_zoneless_eq(&expected,
+						       netif_ip6_addr(test->net.netif, 1)));
+			ut_assert(ip6_addr_istentative(netif_ip6_addr_state(test->net.netif, 1)));
+		}
+		for (unsigned int i = 0; i < 5; i++) {
+			timer_test_add_offset(1000);
+			ut_assertok(net_lwip_poll());
+		}
+		ut_asserteq_str("2001:DB8:1::456", env_get("ip6addr"));
+		ut_assert(ip6_addr_isvalid(netif_ip6_addr_state(test->net.netif, 1)));
+		ut_assert(!netif_ip6_addr_isstatic(test->net.netif, 1));
+		ut_assertok(net_lwip_ip6_init(&test->net));
+		ut_assert(ip4_addr_cmp(&ip4, netif_ip4_addr(test->net.netif)));
+		ut_assertok(run_command("ping6 fe80::2", 0));
+#if CONFIG_IS_ENABLED(CMD_PING)
+		ut_assertok(run_command("ping 192.0.2.2", 0));
+#endif
+		net_lwip_stop(&test->net);
+		ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+		ut_assertok(net_lwip_ip6_start(&test->net));
+		ut_assert(ip6_addr_zoneless_eq(&expected, netif_ip6_addr(test->net.netif, 1)));
+		ut_assert(!netif_ip6_addr_isstatic(test->net.netif, 1));
+		net_lwip_stop(&test->net);
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_replacement(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_replacement);
+}
+DM_TEST(dm_test_lwip_ip6_replacement, UTF_SCAN_FDT);
+
+static int ip6_test_replacement_failure(struct unit_test_state *uts, struct ip6_test *test)
+{
+	ip6_addr_t expected;
+
+	ip6addr_aton("2001:db8:1::456", &expected);
+	for (unsigned int mode = 0; mode < 4; mode++) {
+		unsigned int declines = test->dhcp_declines;
+
+		ut_assertok(ip6_test_replacement_setup(uts, test));
+		test->no_binding = true;
+		ut_assertok(ip6_test_replacement_reply(uts, test));
+		if (!mode) {
+			/* A live interface has a usable source for Decline. */
+			ut_assert(ip6_addr_isvalid(netif_ip6_addr_state(test->net.netif, 0)));
+			net_lwip_dhcp6_poll();
+		} else {
+			/* Close before the accepted replacement has been installed. */
+			net_lwip_stop(&test->net);
+			ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+			ut_assertok(net_lwip_ip6_init(&test->net));
+		}
+		ut_assert(ip6_addr_zoneless_eq(&expected, netif_ip6_addr(test->net.netif, 1)));
+		ut_assert(ip6_addr_istentative(netif_ip6_addr_state(test->net.netif, 1)));
+		ut_asserteq_str("2001:DB8:1::123", env_get("ip6addr"));
+		if (!mode) {
+			test->lease_conflict = true;
+			for (unsigned int i = 0; i < 5; i++) {
+				timer_test_add_offset(1000);
+				ut_assertok(net_lwip_poll());
+			}
+		} else if (mode == 3) {
+			/* Do not send Decline while link-local DAD is still pending. */
+			ut_assert(ip6_addr_istentative(netif_ip6_addr_state(test->net.netif, 0)));
+			netif_ip6_addr_set_state(test->net.netif, 1, IP6_ADDR_DUPLICATED);
+			net_lwip_dhcp6_poll();
+		} else {
+			/* Expiry and DAD timeout both leave the candidate unusable. */
+			timer_test_add_offset(mode == 1 ? 3601000 : 16000);
+			net_lwip_dhcp6_poll();
+		}
+		ut_asserteq(declines + !mode, test->dhcp_declines);
+		ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+		ut_asserteq_str("2001:DB8:1::123", env_get("ip6addr"));
+		net_lwip_stop(&test->net);
+		ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+		ut_assertok(net_lwip_ip6_start(&test->net));
+		ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+		ut_assertok(run_command("ping6 fe80::2", 0));
+		net_lwip_stop(&test->net);
+	}
+	/* A failed explicit reacquisition must clear the old DHCP-owned value. */
+	test->cancel = true;
+	ut_asserteq(CMD_RET_FAILURE, run_command("dhcp6", 0));
+	ut_assertnull(env_get("ip6addr"));
+	return 0;
+}
+
+static int dm_test_lwip_ip6_replacement_failure(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_replacement_failure);
+}
+DM_TEST(dm_test_lwip_ip6_replacement_failure, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int ip6_test_expiry(struct unit_test_state *uts, struct ip6_test *test)
+{
+	struct udp_pcb *udp;
+	struct pbuf *packet;
+	ip_addr_t dest;
+	bool ran = false;
+	int poll, send;
+#if LWIP_TCP
+	struct tcp_pcb *tcp;
+	err_t error = ERR_OK;
+#endif
+
+	ut_assertok(env_set("autoload", "no"));
+	ut_assertok(env_set("ipaddr", "192.0.2.10"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	test->lease_valid = 80;
+	ut_assertok(run_command("dhcp6", 0));
+	ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+	ut_assertok(net_lwip_ip6_start(&test->net));
+	udp = udp_new_ip_type(IPADDR_TYPE_V6);
+	ut_assertnonnull(udp);
+	ut_asserteq(ERR_OK, udp_bind(udp, netif_ip_addr6(test->net.netif, 1), 0));
+	packet = pbuf_alloc(PBUF_TRANSPORT, 1, PBUF_RAM);
+	ut_assertnonnull(packet);
+	*(u8 *)packet->payload = 0;
+	ipaddr_aton("2001:db8:1::2", &dest);
+#if LWIP_TCP
+	tcp = tcp_new_ip_type(IPADDR_TYPE_V6);
+	ut_assertnonnull(tcp);
+	ut_asserteq(ERR_OK, tcp_bind(tcp, netif_ip_addr6(test->net.netif, 1), 0));
+	tcp_arg(tcp, &error);
+	tcp_err(tcp, ip6_test_tcp_error);
+#endif
+	sys_timeout(1, ip6_test_timer, &ran);
+	timer_test_add_offset(81000);
+	poll = net_lwip_poll();
+	sys_untimeout(ip6_test_timer, &ran);
+	send = udp_sendto_if(udp, packet, &dest, 1234, test->net.netif);
+	pbuf_free(packet);
+	udp_remove(udp);
+#if LWIP_TCP
+	if (error == ERR_OK) {
+		tcp_err(tcp, NULL);
+		tcp_abort(tcp);
+	}
+	ut_asserteq(ERR_ABRT, error);
+#endif
+	ut_assertok(poll);
+	ut_assert(ran);
+	ut_asserteq(ERR_RTE, send);
+	ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+	ut_assertok(net_lwip_poll());
+	ut_assertok(run_command("ping6 fe80::2", 0));
+#if CONFIG_IS_ENABLED(CMD_PING)
+	ut_assertok(run_command("ping 192.0.2.2", 0));
+#endif
+	return 0;
+}
+
+static int dm_test_lwip_ip6_expiry(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_expiry);
+}
+DM_TEST(dm_test_lwip_ip6_expiry, UTF_SCAN_FDT);
+
+static int ip6_test_reacquire(struct unit_test_state *uts, struct ip6_test *test)
+{
+	int ret;
+
+	ut_assertok(env_set("autoload", "no"));
+	test->lease_valid = 80;
+	for (unsigned int i = 0; i < 3; i++) {
+		ut_assertok(run_command("dhcp6", 0));
+		if (!i) {
+			timer_test_add_offset(81000);
+		} else {
+			ut_assertok(env_set("ip6addr", i == 1 ? "2001:db8:1::123/64" :
+					   "2001:db8:1::456/64"));
+		}
+		test->cancel = true;
+		ret = run_command("dhcp6", 0);
+		console_record_reset();
+		clear_ctrlc();
+		test->cancel = false;
+		ut_asserteq(CMD_RET_FAILURE, ret);
+		if (i == 2)
+			ut_asserteq_str("2001:db8:1::456/64", env_get("ip6addr"));
+		else
+			ut_assertnull(env_get("ip6addr"));
+		ut_assertok(net_lwip_start(&test->net, NET_LWIP_ADDR_ENV_STRICT));
+		ut_assertok(net_lwip_ip6_start(&test->net));
+		if (i != 2)
+			ut_assert(ip6_addr_isinvalid(netif_ip6_addr_state(test->net.netif, 1)));
+		net_lwip_stop(&test->net);
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_reacquire(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_reacquire);
+}
+DM_TEST(dm_test_lwip_ip6_reacquire, UTF_SCAN_FDT | UTF_CONSOLE);
+
+#if CONFIG_IS_ENABLED(WGET) && CONFIG_IS_ENABLED(LMB)
+static int ip6_test_boot_lmb(struct unit_test_state *uts, struct ip6_test *test)
+{
+	phys_addr_t load = 0x2100000;
+	u8 expected[9], *data = map_sysmem(load, sizeof(expected));
+	int direct, dhcp, freed;
+	bool changed;
+
+	ut_assertok(env_set("autoload", "yes"));
+	ut_assertok(env_set("autostart", "no"));
+	ut_assertok(lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &load, 4096, LMB_NOOVERWRITE));
+	memset(expected, 0xa5, sizeof(expected));
+	memcpy(data, expected, sizeof(expected));
+	test->http_host = "Host: [fe80::2]:8080\r\n";
+	test->boot_url = "http://[fe80::2]:8080/ipv6.bin";
+	direct = run_command("wget 2100000 http://[fe80::2]:8080/ipv6.bin", 0);
+	dhcp = run_command("dhcp6 2100000", 0);
+	changed = memcmp(data, expected, sizeof(expected));
+	freed = lmb_free(load, 4096, LMB_NOOVERWRITE);
+	unmap_sysmem(data);
+	ut_assertok(freed);
+	ut_asserteq(CMD_RET_FAILURE, direct);
+	ut_asserteq(CMD_RET_FAILURE, dhcp);
+	ut_assert(!changed);
+	ut_asserteq(0, net_boot_file_size);
+	ut_assertnull(netif_default);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_boot_lmb(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_boot_lmb);
+}
+DM_TEST(dm_test_lwip_ip6_boot_lmb, UTF_SCAN_FDT);
+#endif
+#endif
+
 static int dm_test_lwip_ip6_ping(struct unit_test_state *uts)
 {
 	return ip6_test_run(uts, ip6_test_ping);

-- 
2.53.0

