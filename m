Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559A606A337
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a1aj+L0i;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IqdClOeg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3389B40A08;
	Thu, 26 Nov 2026 13:33:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5v8NSW8oVKwK; Thu, 26 Nov 2026 13:33:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 55A0740A0F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700029;
	b=tGcwxhB1OHLvVV4Ns8Bk7F/t5FzvuY4fWv6PHL/911KbQvJnl9RdMgf37dAsvmfOWtNJ
	 dFIAkpncjQJ+Xe4UQVvi2G2rQqClMvFcz7XVFuOe3uvbL55LFQnwhWbUeHrl1m451uNRF
	 Ryui3pJzi22itzeHZK9oZZbw/a5VgtzwHuNRDcFEGbDZuniKcsfHnQb9dXjxdjohBj2l2
	 nIs0tYUDJI1rkMU1nNjPXxhbBQL0y52EL4cO269dVbr0d/7Db0Xn3yhc8gyOcj841pOkE
	 cLMqTQNfpbaVR3AAJOebdNMK615UeF48OuAwrGhUeU3op5D6FyTR2lWzMkP65B8dtWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BFALUQV3ELCOrszT7PrWHgXcv/8MhHqsbk0B6fB7vN4=;
	b=WXkFGCn3dtno9vs+mez0DMTAS2QJaY5sg9t83JW1qsfgp5rdKZYeKHNVsyfu4dt+TgH5
	 72422RKRgCU1/zdhCQfbtFEb4x9Ep8Etk6NzHxBdRjmBrcjeFVdPDXerqooDGwpJXsHDF
	 fyNmuWw+5LtppjPZBeC1+52934Fil+Mayoqzg9n77y2gcz09vvLehVb+PjYBM9PqZyqlh
	 dTTtM85M35kT0b1P8Tc03Vv1Yky/OmjGRuwHjWuvx6ABeJ/NyhGC1bRd5kvLlENkX6WXo
	 QsEsjldiajWQ6QRGsBxMwr0blSsiRy3qqQdLwQUYqCiGfUCIttmo6cxaAV8maqYZNFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700029;
	bh=BFALUQV3ELCOrszT7PrWHgXcv/8MhHqsbk0B6fB7vN4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a1aj+L0iTgPlOJf6kY/QiK+5+CxdUtbdJkCRNKyWkKKkFXiOtVIzgJ4xfWX2tswnm
	 0eRUQSv3I9nfuSlxuOiwSqdgTdJ8QYyqmC1JzwjtuQrW0micR04gMvVQFcKgug5do5
	 eeB0iuiX7NGD9AVmDir/zV98Fht9wgRQKOXSXI40hHAEeuVV8Yp/4FBy2GBPT1rogr
	 0uCzJKs454yWavrJjnqj1/oRVV8JicHT2DeM2EWKDUUSUKCTlaqiUGQsnj00WqMKI/
	 ZVu8Es1Rpr+PNe2olUOtBW9+YHyQA0Ft5/dTjrbdC+1ZB+dypNrzUz1nqdBf90WPbf
	 RO9v/CpkbpZWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55A0740A0F;
	Thu, 26 Nov 2026 13:33:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CE6922B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EBC480FFA
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1DKljgb81XI9 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 304D1809C0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=IqdClOeg
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 304D1809C0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:42 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-85ac281604dso3328199a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676021; x=1796280821;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BFALUQV3ELCOrszT7PrWHgXcv/8MhHqsbk0B6fB7vN4=;
 b=IqdClOegrIRtkCnqB5HH/ENweNof0+irLtbAlW35cw4zzTkaJBNtRT1t6FwW2WNeZf
 tY0/zufwwljgOLTNMdcKASpIi3R8lIXB2LpfEx/2ksJsr91deNshIUTCbG3SrV63yyqQ
 idwRcgGPvpj3OO3xrQHygtNPqsJ4j/Cw7nGcknPns4eApeOE6/Qjw3WrK2vWC/L1D71Z
 GbnAGauLUvdV+j5urBcqb3pQIlm/KVxUZCH5A7zcicNXnIlYjFpUHeFCAWEBMwQNk+JR
 ki1F4K1ugeHEGDyBnd7Geyx8T4RpT8Ux59pqfkn9JI4SRoC34VZEhNuiSJPcUbAIqI7g
 D+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676021; x=1796280821;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BFALUQV3ELCOrszT7PrWHgXcv/8MhHqsbk0B6fB7vN4=;
 b=wzU6jufiDFtKJC8/CuWguH2/13HUVSfVe+u6dJvFAD8zyYSDGgQuEgUD71FHl/whf8
 TuXfE0InWLnrzK5JC3kb+av3EG7KuVGgB3AD+8bE0ktzGs14wVvvv4FtrFU7xqQMAn5T
 dYmwFfUHOemaC+TACb3b83adoQjEDWWLzOiEyx1stKo3YchNNebhG8QT2I5SUi0tVIjX
 daj/sITOasLTi9qK261gmL4aQ/3kTgPvCTKoqVuKsMie5frFp3g9ngGTwV7J2NTwQvqi
 TCtY8dPof4oXJOGyOmLYgQoOAdEIso7jHngYOEMMMG4HinWM1c+OTEkgBchl9RwIW36L
 zwjQ==
X-Gm-Message-State: APuU4Z83ERr+rQoWnqaXnuYmQTAkO2YnIllr3Y5BFdMzIzAJBr9cVbOG
 30KLZGl3R5VXqWV692t4SY4MUMqgmZxY8CeaYXwHVZ+XZhxDDoCZ2FVs
X-Gm-Gg: AZFdTZdxoLkq1y0ZqvKcj7VJSiYB6dSJBivImpsXcJ+eJIG7Bogx1wTeLd1v+WnJ3RK
 Fy0xe+BKi8lBIXSmJdgZYHMjrHcYlu+oFw/IMSu5WVH4TKg/S0o3n6sA6murE2AsMiY01ME4RiD
 AanfRCJj6uOLs78pPc0LKoh9VFc7tgx4ZRgsglErKTLk2galk4B4IkxwZdj0UuA5NO5MKZBFmRD
 w5gfwTSFDQ/qsfJcPu+KtSE6LWL49p50UkmuVZeNNqg9ASDTDJjytfBwsI7cbtvOQFtvQWIEQSw
 DqrOQsZqNv0npBbx2wMnlG7Br6wDEpdSdoREpz56NPPbhQ2a8SqWlbZIz86IsKLjVvRnA+JbvBe
 CZVFP+J6f1pyQmdhsvGZjwYKvjrKsoU6qkANA47M0BbKqbuqNubstP4EXHalQDR28jn28EOCd/j
 H6TcZLB8QmzRG8llk7FdnloGSRBxwtZ8mhEfkSbglEaV3+rHBohE4vrj3fkaO1YiVxnhdmvGSL+
 zxI5PxYKPVUYMxni8Wm3ZTzP7o3ulmV3mrVcQIRwvNhqdqmuSP0KIpBPCYlYoIboW0k/1W1PlSr
 P1TzEQDqjRVpzbdDjZ5YXiFt5AC5/QQk1nVyvH6gzEvIEhXp0lKITLt9txhPjVoLN/zb3ilN55J
 l1tjnsr6llRIh6Exnicv/ZzB0niLnYO27PUXq8tvOS92Ud74Mr6jCjsMHfWgfU+OrqIiIAzCiI8
 vCq9kYhRYAjbs9jM4N4K1ElyHZM/0A7yTdY3g5n+4JUxwEjbIeyEFAhK341eiGwyt8IV5U9PDR
X-Received: by 2002:a05:6830:924:b0:85f:31f:7643 with SMTP id
 46e09a7af769-863157cd696mr29706936a34.7.1795676021068; 
 Wed, 25 Nov 2026 22:53:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:06 -0700
Subject: [PATCH 17/19] net: ncsi: check the selected interface before probing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-17-63df291d9392@gmail.com>
References: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
In-Reply-To: <20261125-submit-lwip-network-boot-v1-v1-0-63df291d9392@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Piyush Paliwal <piyushthepal@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Peng Fan <peng.fan@nxp.com>, 
 Carlo Caione <ccaione@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alessandro Rubini <rubini@gnudd.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Romain Gantois <romain.gantois@bootlin.com>, kongchen <3305708832@qq.com>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Heiko Schocher <hs@nabladev.com>, 
 Francesco Valla <francesco@valla.it>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
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

With multiple Ethernet interfaces, net_loop() decides whether to probe
NC-SI before it selects the device named by ethact. It can start
discovery on an ordinary port, or skip discovery on a sideband port.
Its recursive call also starts a second Ethernet session and clears
the ping destination before the original command can use it.

Select the protocol after Ethernet startup and repeat the choice when a
retry rotates to another interface. Run discovery in the same loop:
on success, start the requested protocol on the configured interface;
on failure, use the normal retry and error paths. Reject an explicit
NC-SI command on a regular port or without an active PHY context.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/ncsi.c |  6 ++++
 net/net.c              | 55 ++++++++++++++++++++++------------
 test/dm/eth.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
index a1de438ffff..7857412248e 100644
--- a/drivers/net/phy/ncsi.c
+++ b/drivers/net/phy/ncsi.c
@@ -793,6 +793,12 @@ void ncsi_probe_packages(void)
 	struct ncsi_package *package;
 	unsigned int np, nc;
 
+	if (!ncsi_priv) {
+		printf("NCSI: no active interface\n");
+		net_set_state(NETLOOP_FAIL);
+		return;
+	}
+
 	switch (ncsi_priv->state) {
 	case NCSI_PROBE_PACKAGE_SP:
 		if (ncsi_priv->current_package == NCSI_PACKAGE_MAX)
diff --git a/net/net.c b/net/net.c
index 0fa6178023b..a249a674236 100644
--- a/net/net.c
+++ b/net/net.c
@@ -414,30 +414,20 @@ int net_init(void)
  *	Main network processing loop.
  */
 
-int net_loop(enum proto_t protocol)
+int net_loop(enum proto_t requested)
 {
-	int ret = -EINVAL;
 	enum net_loop_state prev_net_state = net_state;
-
-#if defined(CONFIG_CMD_PING)
-	if (protocol != PING)
-		net_ping_ip.s_addr = 0;
+	enum proto_t protocol = requested;
+#ifdef CONFIG_CMD_PING
+	struct in_addr ping_ip = net_ping_ip;
 #endif
+	int ret;
+
 	net_restarted = 0;
 	net_dev_exists = 0;
 	net_try_count = 1;
 	debug_cond(DEBUG_INT_STATE, "--- net_loop Entry\n");
 
-#ifdef CONFIG_PHY_NCSI
-	if (phy_interface_is_ncsi() && protocol != NCSI && !ncsi_active()) {
-		printf("%s: configuring NCSI first\n", __func__);
-		if (net_loop(NCSI) < 0)
-			return ret;
-		eth_init_state_only();
-		goto restart;
-	}
-#endif
-
 	bootstage_mark_name(BOOTSTAGE_ID_ETH_START, "eth_start");
 	net_init();
 	if (eth_is_on_demand_init()) {
@@ -449,7 +439,9 @@ int net_loop(enum proto_t protocol)
 			return ret;
 		}
 	} else {
-		eth_init_state_only();
+		ret = eth_init_state_only();
+		if (ret < 0)
+			return ret;
 	}
 
 restart:
@@ -464,11 +456,25 @@ restart:
 	 *	packets and timer events.
 	 */
 	debug_cond(DEBUG_INT_STATE, "--- net_loop Init\n");
-	net_init_loop();
+	ret = net_init_loop();
+	if (ret < 0)
+		goto done;
 
 	if (!test_eth_enabled())
 		return 0;
 
+#ifdef CONFIG_PHY_NCSI
+	/* A retry may have selected a different interface. */
+	protocol = requested;
+	if (protocol != NCSI && phy_interface_is_ncsi() && !ncsi_active()) {
+		printf("%s: configuring NCSI first\n", __func__);
+		protocol = NCSI;
+	}
+#endif
+#ifdef CONFIG_CMD_PING
+	net_ping_ip.s_addr = protocol == PING ? ping_ip.s_addr : 0;
+#endif
+
 	switch (net_check_prereq(protocol)) {
 	case 1:
 		/* network not configured */
@@ -580,7 +586,10 @@ restart:
 #endif
 #if defined(CONFIG_PHY_NCSI)
 		case NCSI:
-			ncsi_probe_packages();
+			if (phy_interface_is_ncsi())
+				ncsi_probe_packages();
+			else
+				net_set_state(NETLOOP_FAIL);
 			break;
 #endif
 		case RS:
@@ -678,7 +687,15 @@ restart:
 			goto restart;
 
 		case NETLOOP_SUCCESS:
+#ifdef CONFIG_PHY_NCSI
+			if (protocol == NCSI && !ncsi_active()) {
+				net_set_state(NETLOOP_CONTINUE);
+				continue;
+			}
+#endif
 			net_cleanup_loop();
+			if (protocol != requested)
+				goto restart;
 			if (net_boot_file_size > 0) {
 				printf("Bytes transferred = %u (%x hex)\n",
 				       net_boot_file_size, net_boot_file_size);
diff --git a/test/dm/eth.c b/test/dm/eth.c
index a5e98f2e81f..6159475d2f0 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -622,6 +622,87 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_eth_async_ping_reply, UTF_SCAN_FDT);
 
+#ifdef CONFIG_PHY_NCSI
+static int check_ncsi_selection(struct unit_test_state *uts,
+				struct udevice *ncsi_dev)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(ncsi_dev);
+	int starts = priv->start_count;
+
+	ut_assertok(env_set("ethact", "eth@10003000"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("ipaddr", "1.1.2.3"));
+
+	eth_set_dev(ncsi_dev);
+	ut_assert(net_loop(NCSI) < 0);
+
+	eth_set_dev(ncsi_dev);
+	net_ping_ip = string_to_ip("1.1.2.2");
+	ut_assertok(net_loop(PING));
+	ut_asserteq_str("eth@10003000", eth_get_name());
+	ut_asserteq(starts, priv->start_count);
+
+	/* No NC-SI controller answers on the first sandbox interface. */
+	ut_assertok(env_set("ethact", ncsi_dev->name));
+	net_ping_ip = string_to_ip("1.1.2.2");
+	ut_assert(net_loop(PING) < 0);
+	ut_asserteq(starts + 1, priv->start_count);
+
+	/* A retry on the ordinary interface must run the original protocol. */
+	ut_assertok(env_set("netretry", "once"));
+	ut_assertok(env_set("ethrotate", "yes"));
+	net_ping_ip = string_to_ip("1.1.2.2");
+	ut_assertok(net_loop(PING));
+	ut_asserteq_str("eth@10003000", eth_get_name());
+
+	return 0;
+}
+
+static int dm_test_eth_ncsi_select(struct unit_test_state *uts)
+{
+	static const char * const vars[] = { "ethact", "ethrotate", "ipaddr", "netretry" };
+	struct udevice *ncsi_dev, *old_dev = eth_get_dev();
+	struct in_addr old_ping_ip = net_ping_ip;
+	struct eth_pdata *pdata;
+	char *saved[ARRAY_SIZE(vars)] = {};
+	phy_interface_t old_interface;
+	int i, ret = -ENOMEM;
+
+	ut_assertok(uclass_get_device(UCLASS_ETH, 0, &ncsi_dev));
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto free_saved;
+		}
+	}
+
+	pdata = dev_get_plat(ncsi_dev);
+	old_interface = pdata->phy_interface;
+	pdata->phy_interface = PHY_INTERFACE_MODE_NCSI;
+	ret = check_ncsi_selection(uts, ncsi_dev);
+	eth_halt();
+	eth_set_dev(old_dev);
+	pdata->phy_interface = old_interface;
+	net_ping_ip = old_ping_ip;
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		if (env_set(vars[i], saved[i]))
+			ret = -EINVAL;
+free_saved:
+	while (i)
+		free(saved[--i]);
+	ut_assertok(ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_eth_ncsi_select, UTF_SCAN_FDT);
+
+#endif
+
 #if IS_ENABLED(CONFIG_CMD_DHCP6) && IS_ENABLED(CONFIG_IPV6)
 #define DHCP6_DUID_LL_LEN	10	/* type(2) + hw_type(2) + MAC(6) */
 static bool dhcp6_request_seen;

-- 
2.53.0

