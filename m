Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C1606A338
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZuNcp7I9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JfdChct+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCCEE60AAD;
	Thu, 26 Nov 2026 13:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id leejnKj9EXCn; Thu, 26 Nov 2026 13:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E023460A92
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700031;
	b=Ofl9kDrjeLzLF1kynb/pzayx+D6udu8zfnbFDMav77r/RM5k0wPnwNZ3+Fi/tHVCt0mU
	 qlgmEE67nx7GEf5QO7WSTEE2VZ6Bqc+6hJa39rJ3R7LK49cr/TmtgoR3kXh9UH9zuX7JV
	 spgfKBTgbntvKbm3SdbPnovAqFGQwI3XDEhF3h46foo1fgAqGhFaWizNcQ5hgk4fJbkZW
	 pYMOV375aNfIAsIOpGwVTsYNojza7OGj36qFIpZXkt03PSmyBhNc7jdY9vtjv0t1FiJ9/
	 m+EUsw5NgLFO8ZTTLkzqeEen6JiJfIfmp1vSAAErlCSasQpMBPQX1fWntxRj2NTaQ0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fj14GqQPvA/K7BkK3W/9Vgbo9WhDP5tz+kMIhHRUXaQ=;
	b=F9m47txqS7+Hwly1R6ktnWk2ITq0cceNAR3VPlSGkO3CFsH0RCkEhUY2S5mCPf+O4oBo
	 M1JQUGsw0TjtmRHyVLbV9h4mnAxldMiWVw124TI4TmyfEBXmJRYfVYXlWoY1KM9i2F3xN
	 EJvHQqZnDYtl8ZDTBct66br3vSA+lbvHVdVVq+lHL2kwAhXQofkxuyq60jQ7XvSOCOSZe
	 +MfYQOStZlwXSRLMSuQuywHADy7Tu+RD0yeny2hle64gAig85bEmKlcNVASLcaneCD1BB
	 jvvWH0uyjs1u/Ayl36yUqIfpUC1D2ivn1d6D+dXFvyhhJ1wevuRyuRqawpSEliU+Wfw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700031;
	bh=fj14GqQPvA/K7BkK3W/9Vgbo9WhDP5tz+kMIhHRUXaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZuNcp7I958fejMHTg0eAMRDwLP3vcFSXPM7Seom+cdwsQui6Aq1k6gbBxC99KUPAa
	 3mp1KG10197spomfXyAHzCSlgNTyRLzI1GpADWim7LtfX0TytBpR/FXxWBDvXR3K8X
	 ohLJU7li78YBa3i5gUOQOFRxUK77VGdLthjXiQbRCGIJPvXLNQ1jv/yQxuHmxkdkrU
	 RhQPwWvaXa1f29hFH6555I+9Jn8oH5pyCqqQdwjQROlGMfBquMokMhFRlo9OjFuHBT
	 f54VZidhgzaRjG9YPBooyISECv8WO+YEzyLmlDfgXpL2dzUOtryJvbYouchJtwFALA
	 sjN35+20X4esg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E023460A92;
	Thu, 26 Nov 2026 13:33:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BD9E260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1FEE81005
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w8mOwpzjVJG3 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:53:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7382981004
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=JfdChct+
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7382981004
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:53:44 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-8631e07b756so3703063a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795676023; x=1796280823;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fj14GqQPvA/K7BkK3W/9Vgbo9WhDP5tz+kMIhHRUXaQ=;
 b=JfdChct+oZq671EL0Y8sy8ZEz3fpXXN+bRT/VzRawSlqy65/h50hQVumK4QejL33j8
 EoH3KGIBiFVgYeNakLauw6GEX6rbGR1wuDKztX4Dx5rs5JU4d37Zo8Thq80Mj8VUFt0q
 aXPRpGWdsGVKJ4Dazaj+YtBhptco1T15/crsuG4oz14jjq/Z+wNwsEyQyu0u6HqIQeV+
 Qw31EiVXrq2rfYJ4PxVK+YzZ4VlRekK0jmccLt4GNIK6hLe9EMQxHViNfH8RMoISjgwG
 gsN/SKVPDtrT/2TKdFJ0/TKaYekiq+9/NHaaMVuFp3dErk9ms63in2Z/kpUjD+KRPS0o
 m1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676023; x=1796280823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fj14GqQPvA/K7BkK3W/9Vgbo9WhDP5tz+kMIhHRUXaQ=;
 b=fyz8el2BHg/Kmy983i7Bhugq6OQdigPPDUJGEkMsb4JDdZusjFUYfrYCONM+CCJAzt
 6M9nSFHz/41wpFT3R+gz2uPCWNAIzyztm3JVtCsa1BBVYoniP5BJX/t1GTWbEeNeMm02
 /mM5MB49s10Kr5L9b3GvQKVOVx6SvbnzoWTztSo/c4knTBiG71t7HXOYB5JBYD3DYIPc
 XvqbNkXCO6fqs6MDB1Pws5bWIhPVsp1+WA+olo410zhP3y+/VAjkL5aHdvKvZOLxmAoY
 l7P5wSrzSZJvB0SV1f7klBQWdUua+NGxoap6zSsT3BShN5t0liuSHFHAXCO7Ll4L01uE
 Sk1g==
X-Gm-Message-State: APuU4Z9dZCub6rwWwXSi/DRL8b9FsfAq8MR/KgQXrCDUNWwcFn9CeGBM
 v2PBOo8h8gWBUbi/gy8VJEKeNcze2xWxpCJjMNFLA8oY3RxSJla/i2QL
X-Gm-Gg: AZFdTZfLEKJQI5QMoIfIWc2nE8pw3m9UOI56BUtlrtSPdkBqzizi/9IIAOelmwiTy1I
 xdPa/kJeuAqOnKu36MX2+nVSyCBHPhe4L/K5zedP83Eq6gUtpMFdYUcUUFYqHZxTM1XHeHdy9af
 6jdKqEhWIsMI4fqu1dP1VA1vuD+lLJ+/6I2un5ne7vtaHCcDHDzC7qKeCW8tNum7Zh4Cv19cU5P
 rSCEuW/FlsawkAMjf58qD+GSUqLJ5njBY1Ahsu+LvC7JfIXgXQXAxd6Jj/jdz1ZHeNkxTDXHo5o
 MaaQzJeadHopJcjf2MQdEJl2MqJ9G+n/8eFF4MtcQKC+6RhZ/fM/Cd8eXaZeWjOcZ+ATPKOieRV
 Lj39D8/G7GXHpeOpKfNHu+JFopV/f/0jrk4spRpVIS8BdhLOpu+57r3vk9CremTjKgjEMmsVhyk
 pvFitPoR5kcN/w60INWYdfrvUli/fYwHVPJp7dLzw13cg3pj2/XnAID8/xoOT3hc4BYIRR0128x
 PPdynbkz3EWhcvRfer3IMfUbK3Tn8nTaN3gPe85kcEjCTIOm2sQ80gAUv2SSWLSexWCsdnE1Grf
 Ss6NWqDdsVHQKZSvn0k+tjcy9ax9ffITpqTTi0a+JIg0laC5UQfomrTUyu+jLHtdGAhg1VYn3I0
 xyqWrFy5EXyB6g5Xq/L7JUgRyp9C1zIYc/++v7nAoYZ9fKC5xZ6DAowlIRZj2i47wurW5PoMsfF
 QkdSWslOAit3TQB2xdocGcc+hTpoz5a+bz50W0s9F3bKBfthqI6co=
X-Received: by 2002:a05:6830:4103:b0:862:7ba1:9b35 with SMTP id
 46e09a7af769-8631597709bmr24800622a34.11.1795676023317; 
 Wed, 25 Nov 2026 22:53:43 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm31041a34.21.2026.11.25.22.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:53:42 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 25 Nov 2026 23:53:07 -0700
Subject: [PATCH 18/19] net: ncsi: track the outstanding management command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-submit-lwip-network-boot-v1-v1-18-63df291d9392@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If the controller stops replying while a channel is being enabled,
NC-SI can report success and let an IP client use an unconfigured
channel. The timeout drops the last pending request, which the state
machine mistakes for successful completion.

Record each command's ID, type and channel and advance only on its
matching reply. Wrap from 0xff to 1 because zero is reserved for
asynchronous events. Check the received length before reading the response
payload or checksum. Report timeouts and send or allocation failures.
Send management frames from a DMA-aligned buffer, as required by MACs
that pass the packet buffer directly to hardware.

Select the active PHY at startup and release its discovery state at
shutdown. Keep the package and channel selected by discovery through
configuration. If link status succeeds but a later capability query
times out, discovery advances but leaves the earlier has_link bit set.
Rescanning those flags can select the timed-out channel instead of the
channel whose probe completed.

Exercise discovery with a sandbox controller that checks command IDs
and buffer alignment. Verify that a ping does not transmit IP traffic
until the channel has been enabled.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/ncsi.c | 243 ++++++++++++++++++++++++++-----------------------
 include/net/ncsi.h     |   3 +-
 net/net.c              |   2 +-
 test/dm/Makefile       |   3 +
 test/dm/ncsi.c         | 141 ++++++++++++++++++++++++++++
 5 files changed, 273 insertions(+), 119 deletions(-)

diff --git a/drivers/net/phy/ncsi.c b/drivers/net/phy/ncsi.c
index 7857412248e..5cc183b88f8 100644
--- a/drivers/net/phy/ncsi.c
+++ b/drivers/net/phy/ncsi.c
@@ -7,6 +7,7 @@
 
 #include <log.h>
 #include <malloc.h>
+#include <memalign.h>
 #include <phy.h>
 #include <net.h>
 #include <net/ncsi.h>
@@ -76,8 +77,10 @@ struct ncsi {
 	} state;
 
 	unsigned int	pending_requests;
-	unsigned int	requests[256];
-	unsigned int	last_request;
+	u8		last_request;
+	u8		expected_type;
+	u8		expected_channel;
+	int		result;
 
 	unsigned int	current_package;
 	unsigned int	current_channel;
@@ -86,7 +89,7 @@ struct ncsi {
 	struct ncsi_package	*packages;
 };
 
-struct ncsi *ncsi_priv;
+static struct ncsi *ncsi_priv;
 
 bool ncsi_active(void)
 {
@@ -98,13 +101,37 @@ bool ncsi_active(void)
 	np = ncsi_priv->current_package;
 	nc = ncsi_priv->current_channel;
 
-	if (ncsi_priv->state != NCSI_CONFIG)
+	if (ncsi_priv->state != NCSI_CONFIG || ncsi_priv->result)
 		return false;
 
-	return np < NCSI_PACKAGE_MAX && nc < NCSI_CHANNEL_MAX &&
+	return np < ncsi_priv->n_packages && nc < ncsi_priv->packages[np].n_channels &&
 		ncsi_priv->packages[np].channels[nc].has_link;
 }
 
+static void ncsi_complete(int result)
+{
+	ncsi_priv->result = result;
+	ncsi_priv->pending_requests = 0;
+	net_set_timeout_handler(0, NULL);
+	net_set_state(result ? NETLOOP_FAIL : NETLOOP_SUCCESS);
+}
+
+static void ncsi_reset_probe(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ncsi_priv->n_packages; i++)
+		free(ncsi_priv->packages[i].channels);
+	free(ncsi_priv->packages);
+	ncsi_priv->packages = NULL;
+	ncsi_priv->n_packages = 0;
+	ncsi_priv->current_package = NCSI_PACKAGE_MAX;
+	ncsi_priv->current_channel = NCSI_CHANNEL_MAX;
+	ncsi_priv->pending_requests = 0;
+	ncsi_priv->result = -EINPROGRESS;
+	ncsi_priv->state = NCSI_PROBE_PACKAGE_SP;
+}
+
 static unsigned int cmd_payload(int cmd)
 {
 	switch (cmd) {
@@ -183,8 +210,7 @@ static u32 ncsi_calculate_checksum(unsigned char *data, int len)
 static int ncsi_validate_rsp(struct ncsi_rsp_pkt *pkt, int payload)
 {
 	struct ncsi_rsp_pkt_hdr *hdr = &pkt->rsp;
-	u32 checksum, c_offset;
-	__be32 pchecksum;
+	u32 checksum, c_offset, pchecksum;
 
 	if (hdr->common.revision != 1) {
 		printf("NCSI: 0x%02x response has unsupported revision 0x%x\n",
@@ -202,7 +228,7 @@ static int ncsi_validate_rsp(struct ncsi_rsp_pkt *pkt, int payload)
 
 	if (ntohs(hdr->common.length) != payload) {
 		printf("NCSI: 0x%02x response has incorrect length %d\n",
-		       hdr->common.type, hdr->common.length);
+		       hdr->common.type, ntohs(hdr->common.length));
 		return -1;
 	}
 
@@ -341,7 +367,7 @@ static void ncsi_rsp_gls(struct ncsi_rsp_pkt *pkt)
 	}
 
 	ncsi_priv->packages[np].channels[nc].has_link =
-					!!(get_unaligned_be32(&gls->status));
+					!!(get_unaligned_be32(&gls->status) & BIT(0));
 
 	if (ncsi_priv->state == NCSI_PROBE_CHANNEL)
 		ncsi_send_command(np, nc, NCSI_PKT_CMD_GVI, NULL, 0, true);
@@ -351,6 +377,7 @@ static void ncsi_rsp_cis(struct ncsi_rsp_pkt *pkt)
 {
 	struct ncsi_rsp_pkt_hdr *rsp = (struct ncsi_rsp_pkt_hdr *)pkt;
 	struct ncsi_package *package;
+	struct ncsi_channel *channels;
 	unsigned int np, nc;
 
 	np = NCSI_PACKAGE_INDEX(rsp->common.channel);
@@ -363,28 +390,22 @@ static void ncsi_rsp_cis(struct ncsi_rsp_pkt *pkt)
 
 	package = &ncsi_priv->packages[np];
 
-	if (nc < package->n_channels) {
-		/*
-		 * This is fine in general but in the current design we
-		 * don't send CIS commands to known channels.
-		 */
-		debug("NCSI: Duplicate channel 0x%02x\n", nc);
-		return;
-	}
-
-	package->channels = realloc(package->channels,
-				    sizeof(struct ncsi_channel) *
-				    (package->n_channels + 1));
-	if (!package->channels) {
-		printf("NCSI: Could not allocate memory for new channel\n");
-		return;
+	if (nc >= package->n_channels) {
+		channels = realloc(package->channels, sizeof(*channels) * (nc + 1));
+		if (!channels) {
+			ncsi_complete(-ENOMEM);
+			return;
+		}
+		memset(channels + package->n_channels, 0,
+		       (nc + 1 - package->n_channels) * sizeof(*channels));
+		package->channels = channels;
+		package->n_channels = nc + 1;
 	}
 
 	debug("NCSI: New channel 0x%02x\n", nc);
 
 	package->channels[nc].id = nc;
 	package->channels[nc].has_link = false;
-	package->n_channels++;
 
 	ncsi_send_gls(np, nc);
 }
@@ -404,6 +425,7 @@ static void ncsi_rsp_dp(struct ncsi_rsp_pkt *pkt)
 static void ncsi_rsp_sp(struct ncsi_rsp_pkt *pkt)
 {
 	struct ncsi_rsp_pkt_hdr *rsp = (struct ncsi_rsp_pkt_hdr *)pkt;
+	struct ncsi_package *packages;
 	unsigned int np;
 
 	np = NCSI_PACKAGE_INDEX(rsp->common.channel);
@@ -416,18 +438,16 @@ static void ncsi_rsp_sp(struct ncsi_rsp_pkt *pkt)
 
 	debug("NCSI: adding new package %d\n", np);
 
-	ncsi_priv->packages = realloc(ncsi_priv->packages,
-				      sizeof(struct ncsi_package) *
-				      (ncsi_priv->n_packages + 1));
-	if (!ncsi_priv->packages) {
-		printf("NCSI: could not allocate memory for new package\n");
+	packages = realloc(ncsi_priv->packages, sizeof(*packages) * (np + 1));
+	if (!packages) {
+		ncsi_complete(-ENOMEM);
 		return;
 	}
-
+	memset(packages + ncsi_priv->n_packages, 0,
+	       (np + 1 - ncsi_priv->n_packages) * sizeof(*packages));
+	ncsi_priv->packages = packages;
 	ncsi_priv->packages[np].id = np;
-	ncsi_priv->packages[np].n_channels = 0;
-	ncsi_priv->packages[np].channels = NULL;
-	ncsi_priv->n_packages++;
+	ncsi_priv->n_packages = np + 1;
 }
 
 static void ncsi_update_state(struct ncsi_rsp_pkt_hdr *nh)
@@ -452,7 +472,7 @@ static void ncsi_update_state(struct ncsi_rsp_pkt_hdr *nh)
 		} else {
 			if (!ncsi_priv->n_packages) {
 				printf("NCSI: no packages found\n");
-				net_set_state(NETLOOP_FAIL);
+				ncsi_complete(-ENODEV);
 				return;
 			}
 			printf("NCSI: probing channels\n");
@@ -466,9 +486,9 @@ static void ncsi_update_state(struct ncsi_rsp_pkt_hdr *nh)
 			ncsi_priv->state = NCSI_PROBE_CHANNEL;
 			return ncsi_probe_packages();
 		}
-		printf("NCSI: failed to select package 0x%0x2 or timeout\n",
+		printf("NCSI: failed to select package 0x%02x or timeout\n",
 		       ncsi_priv->current_package);
-		net_set_state(NETLOOP_FAIL);
+		ncsi_complete(-ENODEV);
 		break;
 	case NCSI_PROBE_CHANNEL:
 		// TODO only does package 0 for now
@@ -477,7 +497,8 @@ static void ncsi_update_state(struct ncsi_rsp_pkt_hdr *nh)
 			nc = ncsi_priv->current_channel;
 
 			/* Configure first channel that has link */
-			if (ncsi_priv->packages[np].channels[nc].has_link) {
+			if (nc < ncsi_priv->packages[np].n_channels &&
+			    ncsi_priv->packages[np].channels[nc].has_link && !timeout) {
 				ncsi_priv->state = NCSI_CONFIG;
 			} else if (ncsi_priv->current_channel + 1 <
 				   NCSI_CHANNEL_MAX) {
@@ -485,24 +506,24 @@ static void ncsi_update_state(struct ncsi_rsp_pkt_hdr *nh)
 			} else {
 				// XXX As above only package 0
 				printf("NCSI: no channel found with link\n");
-				net_set_state(NETLOOP_FAIL);
+				ncsi_complete(-ENETDOWN);
 				return;
 			}
 			return ncsi_probe_packages();
 		}
 		break;
 	case NCSI_CONFIG:
-		if (ncsi_priv->pending_requests == 0) {
-			printf("NCSI: configuration done!\n");
-			net_set_state(NETLOOP_SUCCESS);
-		} else if (timeout) {
+		if (timeout) {
 			printf("NCSI: timeout during configure\n");
-			net_set_state(NETLOOP_FAIL);
+			ncsi_complete(-ETIMEDOUT);
+		} else if (ncsi_priv->pending_requests == 0) {
+			printf("NCSI: configuration done!\n");
+			ncsi_complete(0);
 		}
 		break;
 	default:
 		printf("NCSI: something went very wrong, nevermind\n");
-		net_set_state(NETLOOP_FAIL);
+		ncsi_complete(-EINVAL);
 		break;
 	}
 }
@@ -523,11 +544,15 @@ static int ncsi_send_command(unsigned int np, unsigned int nc, unsigned int cmd,
 	int eth_hdr_size;
 	u32 checksum;
 	uchar *pkt, *start;
-	int final_len;
+	int final_len, ret;
 
-	pkt = calloc(1, PKTSIZE_ALIGN + PKTALIGN);
-	if (!pkt)
+	pkt = malloc_cache_aligned(PKTSIZE_ALIGN);
+	if (!pkt) {
+		if (wait)
+			ncsi_complete(-ENOMEM);
 		return -ENOMEM;
+	}
+	memset(pkt, 0, PKTSIZE_ALIGN);
 	start = pkt;
 
 	eth_hdr_size = net_set_ether(pkt, net_bcast_ethaddr, PROT_NCSI);
@@ -537,8 +562,10 @@ static int ncsi_send_command(unsigned int np, unsigned int nc, unsigned int cmd,
 	hdr = (struct ncsi_pkt_hdr *)pkt;
 	hdr->mc_id = 0;
 	hdr->revision = NCSI_PKT_REVISION;
-	hdr->id = ++ncsi_priv->last_request;
-	ncsi_priv->requests[ncsi_priv->last_request] = 1;
+	/* Instance ID zero is reserved for asynchronous events. */
+	if (!++ncsi_priv->last_request)
+		ncsi_priv->last_request = 1;
+	hdr->id = ncsi_priv->last_request;
 	hdr->type = cmd;
 	hdr->channel = NCSI_TO_CHANNEL(np, nc);
 	hdr->length = htons(len);
@@ -553,6 +580,8 @@ static int ncsi_send_command(unsigned int np, unsigned int nc, unsigned int cmd,
 	put_unaligned_be32(checksum, pchecksum);
 
 	if (wait) {
+		ncsi_priv->expected_type = cmd + 0x80;
+		ncsi_priv->expected_channel = hdr->channel;
 		net_set_timeout_handler(1000UL, ncsi_timeout_handler);
 		ncsi_priv->pending_requests++;
 	}
@@ -562,17 +591,18 @@ static int ncsi_send_command(unsigned int np, unsigned int nc, unsigned int cmd,
 	/* frame header, packet header, payload, checksum */
 	final_len = eth_hdr_size + sizeof(struct ncsi_cmd_pkt_hdr) + len + 4;
 
-	net_send_packet(start, final_len);
+	ret = eth_send(start, final_len);
 	free(start);
-	return 0;
+	if (ret < 0 && wait)
+		ncsi_complete(ret);
+	return ret < 0 ? ret : 0;
 }
 
-static void ncsi_handle_aen(struct ip_udp_hdr *ip, unsigned int len)
+static void ncsi_handle_aen(void *data, unsigned int len)
 {
-	struct ncsi_aen_pkt_hdr *hdr = (struct ncsi_aen_pkt_hdr *)ip;
-	int payload, i;
-	__be32 pchecksum;
-	u32 checksum;
+	struct ncsi_aen_pkt_hdr *hdr = data;
+	int payload;
+	u32 pchecksum, checksum;
 
 	switch (hdr->type) {
 	case NCSI_PKT_AEN_LSC:
@@ -599,9 +629,9 @@ static void ncsi_handle_aen(struct ip_udp_hdr *ip, unsigned int len)
 		return;
 	}
 
-	if (ntohs(hdr->common.length) != payload) {
+	if (ntohs(hdr->common.length) != payload || len < sizeof(*hdr) + payload) {
 		printf("NCSI: 0x%02x response has incorrect length %d\n",
-		       hdr->common.type, hdr->common.length);
+		       hdr->common.type, ntohs(hdr->common.length));
 		return;
 	}
 
@@ -617,39 +647,32 @@ static void ncsi_handle_aen(struct ip_udp_hdr *ip, unsigned int len)
 	}
 
 	/* Link or configuration lost - just redo the discovery process */
-	ncsi_priv->state = NCSI_PROBE_PACKAGE_SP;
-	for (i = 0; i < ncsi_priv->n_packages; i++) {
-		free(ncsi_priv->packages[i].channels);
-		ncsi_priv->packages[i].channels = NULL;
-	}
-	free(ncsi_priv->packages);
-	ncsi_priv->packages = NULL;
-	ncsi_priv->n_packages = 0;
-
-	ncsi_priv->current_package = NCSI_PACKAGE_MAX;
-	ncsi_priv->current_channel = NCSI_CHANNEL_MAX;
-
+	ncsi_reset_probe();
 	ncsi_probe_packages();
 }
 
-void ncsi_receive(struct ethernet_hdr *et, struct ip_udp_hdr *ip,
-		  unsigned int len)
+void ncsi_receive(void *data, unsigned int len)
 {
-	struct ncsi_rsp_pkt *pkt = (struct ncsi_rsp_pkt *)ip;
+	struct ncsi_rsp_pkt *pkt = data;
 	struct ncsi_rsp_pkt_hdr *nh = (struct ncsi_rsp_pkt_hdr *)&pkt->rsp;
 	void (*handler)(struct ncsi_rsp_pkt *pkt) = NULL;
 	unsigned short payload;
 
-	if (ncsi_priv->pending_requests)
-		ncsi_priv->pending_requests--;
+	if (!ncsi_priv)
+		return;
 
 	if (len < sizeof(struct ncsi_rsp_pkt_hdr)) {
 		printf("NCSI: undersized packet: %u bytes\n", len);
-		goto out;
+		return;
 	}
 
 	if (nh->common.type == NCSI_PKT_AEN)
-		return ncsi_handle_aen(ip, len);
+		return ncsi_handle_aen(data, len);
+
+	if (!ncsi_priv->pending_requests || nh->common.id != ncsi_priv->last_request ||
+	    nh->common.type != ncsi_priv->expected_type ||
+	    nh->common.channel != ncsi_priv->expected_channel)
+		return;
 
 	switch (nh->common.type) {
 	case NCSI_PKT_RSP_SP:
@@ -699,19 +722,20 @@ void ncsi_receive(struct ethernet_hdr *et, struct ip_udp_hdr *ip,
 	default:
 		printf("NCSI: unsupported packet type 0x%02x\n",
 		       nh->common.type);
-		goto out;
+		return;
 	}
 
-	if (ncsi_validate_rsp(pkt, payload) != 0) {
+	if (len < sizeof(*nh) + payload || ncsi_validate_rsp(pkt, payload)) {
 		printf("NCSI: discarding invalid packet of type 0x%02x\n",
 		       nh->common.type);
-		goto out;
+		return;
 	}
 
+	ncsi_priv->pending_requests--;
 	if (handler)
 		handler(pkt);
-out:
-	ncsi_update_state(nh);
+	if (ncsi_priv->result == -EINPROGRESS)
+		ncsi_update_state(nh);
 }
 
 static void ncsi_send_sp(unsigned int np)
@@ -773,6 +797,7 @@ static void ncsi_send_sma(unsigned int np, unsigned int nc)
 	addr = eth_get_ethaddr();
 	if (!addr) {
 		printf("NCSI: no MAC address configured\n");
+		ncsi_complete(-EADDRNOTAVAIL);
 		return;
 	}
 
@@ -790,9 +815,6 @@ static void ncsi_send_sma(unsigned int np, unsigned int nc)
 
 void ncsi_probe_packages(void)
 {
-	struct ncsi_package *package;
-	unsigned int np, nc;
-
 	if (!ncsi_priv) {
 		printf("NCSI: no active interface\n");
 		net_set_state(NETLOOP_FAIL);
@@ -820,24 +842,8 @@ void ncsi_probe_packages(void)
 			      ncsi_priv->current_channel);
 		break;
 	case NCSI_CONFIG:
-		for (np = 0; np < ncsi_priv->n_packages; np++) {
-			package = &ncsi_priv->packages[np];
-			for (nc = 0; nc < package->n_channels; nc++)
-				if (package->channels[nc].has_link)
-					break;
-			if (nc < package->n_channels)
-				break;
-		}
-		if (np == ncsi_priv->n_packages) {
-			printf("NCSI: no link available\n");
-			return;
-		}
-
-		printf("NCSI: configuring channel %d\n", nc);
-		ncsi_priv->current_package = np;
-		ncsi_priv->current_channel = nc;
-		/* Kicks off rest of configure chain */
-		ncsi_send_sma(np, nc);
+		printf("NCSI: configuring channel %u\n", ncsi_priv->current_channel);
+		ncsi_send_sma(ncsi_priv->current_package, ncsi_priv->current_channel);
 		break;
 	default:
 		printf("NCSI: unknown state 0x%x\n", ncsi_priv->state);
@@ -853,8 +859,6 @@ int ncsi_probe(struct phy_device *phydev)
 		memset(phydev->priv, 0, sizeof(struct ncsi));
 	}
 
-	ncsi_priv = phydev->priv;
-
 	return 0;
 }
 
@@ -866,27 +870,34 @@ int ncsi_startup(struct phy_device *phydev)
 	/* Normal phy reset is N/A */
 	phydev->flags |= PHY_FLAG_BROKEN_RESET;
 
-	/* Set initial probe state */
-	ncsi_priv->state = NCSI_PROBE_PACKAGE_SP;
-
-	/* No active package/channel yet */
-	ncsi_priv->current_package = NCSI_PACKAGE_MAX;
-	ncsi_priv->current_channel = NCSI_CHANNEL_MAX;
-
 	/* Pretend link works so the MAC driver sets final bits up */
 	phydev->link = true;
 
 	/* Set ncsi_priv so we can use it when called from net_loop() */
 	ncsi_priv = phydev->priv;
+	ncsi_reset_probe();
 
 	return 0;
 }
 
 int ncsi_shutdown(struct phy_device *phydev)
 {
-	printf("NCSI: Disabling package %d\n", ncsi_priv->current_package);
-	ncsi_send_dp(ncsi_priv->current_package);
-	return 0;
+	int ret = 0;
+
+	if (!ncsi_priv || ncsi_priv != phydev->priv)
+		return 0;
+#if CONFIG_IS_ENABLED(NET_LEGACY)
+	if (ncsi_priv->pending_requests)
+		net_set_timeout_handler(0, NULL);
+#endif
+	if (ncsi_priv->current_package < ncsi_priv->n_packages) {
+		printf("NCSI: Disabling package %d\n", ncsi_priv->current_package);
+		ret = ncsi_send_command(ncsi_priv->current_package, NCSI_RESERVED_CHANNEL,
+					NCSI_PKT_CMD_DP, NULL, 0, false);
+	}
+	ncsi_reset_probe();
+	ncsi_priv = NULL;
+	return ret;
 }
 
 U_BOOT_PHY_DRIVER(ncsi) = {
diff --git a/include/net/ncsi.h b/include/net/ncsi.h
index 7aec457562d..42405992da3 100644
--- a/include/net/ncsi.h
+++ b/include/net/ncsi.h
@@ -8,6 +8,5 @@
 #include <phy.h>
 
 bool ncsi_active(void);
-void ncsi_receive(struct ethernet_hdr *et, struct ip_udp_hdr *ip,
-		  unsigned int len);
+void ncsi_receive(void *data, unsigned int len);
 void ncsi_probe_packages(void);
diff --git a/net/net.c b/net/net.c
index a249a674236..30ce04893be 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1450,7 +1450,7 @@ void net_process_received_packet(uchar *in_packet, int len)
 #endif
 #ifdef CONFIG_PHY_NCSI
 	case PROT_NCSI:
-		ncsi_receive(et, ip, len);
+		ncsi_receive(ip, len);
 		break;
 #endif
 	}
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 5448be2267a..c926ec3958f 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -73,6 +73,9 @@ endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_RARP),yy)
 obj-y += lwip_rarp.o
 endif
+ifeq ($(CONFIG_CMD_PING),y)
+obj-$(CONFIG_PHY_NCSI) += ncsi.o
+endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_TFTPBOOT),yy)
 obj-y += lwip_tftp.o
 obj-y += lwip_net_loop.o
diff --git a/test/dm/ncsi.c b/test/dm/ncsi.c
new file mode 100644
index 00000000000..58776851857
--- /dev/null
+++ b/test/dm/ncsi.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <net.h>
+#include <time.h>
+#include <asm/eth.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <net/ncsi.h>
+#include <net/ncsi-pkt.h>
+#include <test/ut.h>
+#include "lwip_test.h"
+
+struct ncsi_peer {
+	bool ping;
+	bool enabled;
+	bool early_tx;
+	u8 last_id;
+};
+
+static int ncsi_test_tx(struct udevice *dev, void *packet, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ncsi_peer *peer = priv->priv;
+	struct ncsi_pkt_hdr hdr;
+	int n = priv->recv_packets;
+	unsigned int payload = 4;
+	u8 *out;
+
+	if (get_unaligned_be16(packet + 2 * ETH_ALEN) != PROT_NCSI) {
+		if (!peer->enabled)
+			peer->early_tx = true;
+		if (!sandbox_eth_ping_req_to_reply(dev, packet, len))
+			peer->ping = true;
+		else
+			sandbox_eth_arp_req_to_reply(dev, packet, len);
+		return 0;
+	}
+	if (!IS_ALIGNED((uintptr_t)packet, PKTALIGN))
+		return -EINVAL;
+	memcpy(&hdr, packet + ETHER_HDR_SIZE, sizeof(hdr));
+	if (hdr.id != (peer->last_id == U8_MAX ? 1 : peer->last_id + 1))
+		return -EINVAL;
+	peer->last_id = hdr.id;
+	/* Only package 0 exists. */
+	if (hdr.channel >> 5) {
+		timer_test_add_offset(1001);
+		return 0;
+	}
+	if (n >= PKTBUFSRX)
+		return -ENOSPC;
+	switch (hdr.type) {
+	case NCSI_PKT_CMD_GLS:
+		payload = 16;
+		break;
+	case NCSI_PKT_CMD_GVI:
+		payload = 40;
+		break;
+	case NCSI_PKT_CMD_GC:
+		payload = 32;
+		break;
+	case NCSI_PKT_CMD_EC:
+		peer->enabled = true;
+		break;
+	}
+	out = priv->recv_packet_buffer[n];
+	memset(out, 0, ETHER_HDR_SIZE + sizeof(hdr) + payload + sizeof(u32));
+	memcpy(out, packet + ETH_ALEN, ETH_ALEN);
+	memcpy(out + ETH_ALEN, priv->fake_host_hwaddr, ETH_ALEN);
+	put_unaligned_be16(PROT_NCSI, out + 2 * ETH_ALEN);
+	hdr.type += 0x80;
+	hdr.length = htons(payload);
+	memcpy(out + ETHER_HDR_SIZE, &hdr, sizeof(hdr));
+	if (hdr.type == NCSI_PKT_RSP_GLS)
+		put_unaligned_be32(1, out + ETHER_HDR_SIZE + sizeof(hdr) + 4);
+	if (hdr.type == NCSI_PKT_RSP_GC)
+		put_unaligned_be32(BIT(NCSI_PKT_AEN_CR), out + ETHER_HDR_SIZE +
+				   offsetof(struct ncsi_rsp_gc_pkt, aen_cap));
+	priv->recv_packet_length[n] = ETHER_HDR_SIZE + sizeof(hdr) + payload + sizeof(u32);
+	priv->recv_packets++;
+	return 0;
+}
+
+static int ncsi_run(struct unit_test_state *uts, struct phy_device *phy,
+		    struct ncsi_peer *peer)
+{
+	struct in_addr saved = net_ping_ip;
+	int ret;
+
+	ut_assertok(phy_startup(phy));
+	net_ping_ip = string_to_ip("192.0.2.2");
+	ret = net_loop(PING);
+	net_ping_ip = saved;
+	ut_assertok(ret);
+	ut_assert(peer->ping);
+	ut_assert(!peer->early_tx);
+
+	return 0;
+}
+
+static int ncsi_check(struct unit_test_state *uts)
+{
+	struct udevice *old = eth_get_dev(), *dev;
+	struct ncsi_peer peer = {};
+	struct eth_pdata *pdata;
+	struct phy_device *phy;
+	phy_interface_t saved;
+	int ret;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ethrotate", "no"));
+	ut_assertok(env_set("netretry", "no"));
+	ut_assertok(env_set("ipaddr", "192.0.2.1"));
+	ut_assertok(uclass_get_device_by_seq(UCLASS_ETH, 0, &dev));
+	phy = phy_device_create(NULL, 0, PHY_NCSI_ID, false);
+	ut_assertnonnull(phy);
+	pdata = dev_get_plat(dev);
+	saved = pdata->phy_interface;
+	pdata->phy_interface = PHY_INTERFACE_MODE_NCSI;
+	sandbox_eth_set_priv(0, &peer);
+	sandbox_eth_set_tx_handler(0, ncsi_test_tx);
+	ret = ncsi_run(uts, phy, &peer);
+	phy_shutdown(phy);
+	free(phy->priv);
+	free(phy);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+	pdata->phy_interface = saved;
+	eth_set_dev(old);
+
+	return ret;
+}
+
+static int dm_test_eth_ncsi(struct unit_test_state *uts)
+{
+	const char *const names[] = { "ethact", "ethrotate", "netretry", "ipaddr" };
+
+	return lwip_test_with_env(uts, names, ARRAY_SIZE(names), ncsi_check);
+}
+
+DM_TEST(dm_test_eth_ncsi, UTF_SCAN_FDT);

-- 
2.53.0

