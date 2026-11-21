Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5B606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hN208Ycw;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f/bja40L
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E78D06073D;
	Sat, 21 Nov 2026 13:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SnDDXwoCFNYV; Sat, 21 Nov 2026 13:15:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 284606073F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266907;
	b=YxFJi31du9eHT+6gcOqGVMDiFcAPaEHuTi9t83a3Va2CjBt8zSV2D4qwZb27kBi9r1Hp
	 TK38x4hb0iBNCGtVYaaphiaFBJywtVbktCZt5WYVgSMsSW5IK7ke02AjFEApPi8p+5G5M
	 Qw0VmnKOzCSJQEVEHJWDpaDW1jSSzqEV/Y9cPDllCIH8pu7gElJjM3ONO4owuIPNm3Ixk
	 xGWeCSh9sytsJ8XcN2pCNNFve5QnwiTWD1WAYcQFQ5RjiuyE/DDRv9ppoIus38Rv/vy2a
	 hHmEmcd3bWR6KtDHFvATC8o2+Ndn/TnhAmZRGvnt0b8iZH8wt0NEw+H9dsUuYaIt9sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266907;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	b=kXv1ZsppvI2e4fQOX0seHmG4NnR//XV4dO79GqL/ia936QpbOrJ8l1ZUdF5aJ8MRXCRV
	 +4lXbL4Iwp6DgYBM9v8VZP3zhNE2W8QJpWmTsI43wCJW7YfpFjyE6gIq5eYLK13UfYpE7
	 2ElRPst2L8/k1it8TaiFciM4lsdKvhuTY+D+LKJmpzUwYzymWueSc8rYk5iEBNS4nV1Co
	 wP0Xzyg4CNdUltFx98RjNZEC6bPMD1t9DlONAQSmFqM3TnK6INd879+uGs6T+0MLG12Bz
	 lZipVIvaHlraYcXjGMfZIZD34oKjf89lLwSy2AqJQwv7vCarH+OwktIfWZxRUJzz3XQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266907;
	bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hN208YcwhIsRaj7JjpTNK3QO4D26k5Qhg5ID+TCfwJ4GGwLlvSzBlrmwa+ZrSS/EE
	 05EwzP6xgg6FlpqcuA9StISPI3PAd08QuzaUH8v0kPAhbc0udzenFKcUgkkiUhkXHW
	 sYZsWMaEYHNlvk1CFZsZW1qaHjm6wqUe8lM1RHYGInZx66ydZrxvWvJQ9XFgIGuJ3k
	 h8ezpqCV8maMIQSCfo6zaUgvmfiD07dB6TCSXijZoMyF3whAnLjfZBqvrNqnVOtN/1
	 nq2XiWAtMOUhtYnjZqIE2xlO7J6yVUiogidCnT+Viu7aur2E8gx5junm5uB8PQOH3D
	 uQ9pdaf6rjVGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 284606073F;
	Sat, 21 Nov 2026 13:15:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9126A15D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 77F3581403
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XA6DBAceiit6 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E3B581404
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=f/bja40L
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E3B581404
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:55:45 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c506187deb9so30276166b.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262143; x=1795866943;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=f/bja40LkbgPhgJi5ad5Ju3mRppLtljB8ExB0EHuyFO3IAzp+4iD0f67/D9rrMUwKB
 2m8kat/79Lwg9IPJ5YKrLCXElT24mweagFJQNPMtchs1clU1hfIAfgXK6TExbXsmsByN
 HsCMpvvx8vhHWCUWIoL7tkKEkLcylJJgZZazOAgW2TZ0s57IxDt2Ty8/wPp2SZCplE0l
 LWNbhOjkctqxaLz9+K6+e2H32OXbysa4obf+AR2+KmJR/WBo8Sj/vOMUO59cYgj/kgCV
 PX06nQEpNqjPAo01vk/ipQZtZ4zohCZzxbdgTLyIjO9ZK/Y+vUIDrCwviuzgufivTRSy
 tcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262143; x=1795866943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T+tlimA3RMLnpdLyxNIk8nPlCVrdAhOF5LzuNtE7mY4=;
 b=XUjwlhCKC/u8WKn0ItKNlO3M76UiOO08Fc2BQeHr2B4cRb/RrcFvNbEEcO7UsPahQq
 gU1KMijepiJy1ebQQN8iZFVppMVajxoNNiuCxlEXaxOK8vPSkwbsUGBAvDtH+9N9TGI7
 c4J/u4tvXsTd827GTvDDdkcCYVlV6NmdtvZOhOcPujCc5ipv52A+sKVT5rfom9QPkQ15
 ce/+OK7qWc/BppUoqgLMNeTQIwe1CdHnHzmbb7W7dwc9EbfUHBJnABMqok7BJmY1Zukp
 1GncdgOkzCNQ5f1pgWkDC+PJzqVBiuzbpALCnBf3dgPCjIcfgI8IMGZoNBA5PrMnHInO
 +0JA==
X-Gm-Message-State: APuU4Z8HIWZXpziOvD7h6SifIi3G7e+LKLfH222e3Qf0r895dlLFNZNj
 KNNBGNyj3b46D1mfhBbnW/euD/dShJ4ufD0FxdtsCEg+1Nd4RMEOGQPuK0NATzkqxBTbIj/Vtxv
 XNCFk
X-Gm-Gg: AZFdTZetyWD1q7sZuCMu8TZN6p2HJgvTjBUxbZs4W5NSmoucXy+37pT83ZQPFvYbE0j
 MciPS7cGD1RiNxc5Y4NVUSVmA4H2qd/LbMoMjgtpke2UrXxAGKLtBC0C5APojHDYlvhWmbQjzyb
 rzTjwWTdnvJxX3oMgQuMRromY4aJCx3V8Z315+gIBVJ4dEBHTkLwCJHINfQMCGrqgjPhmgDyyYc
 C+7p+4SRm3aTL4aguSp7gkDpBTyRSaaIi9uqbsQAm+EipCCE+t9YIsSgRaAWy1uQKXE39R2kxF1
 VhZTJUrIUU6i49w3gdEVZpDqwObICLDMQhUfJks8Q5cXRATKoAGe5cI2zf4nj1sv9HgwpPJ60n5
 38QP1vYTotBsZOg5VOzTn3Na8458+p6bV/r56a0SytY9o+TZEiJVozAO60omyp1MRQaID9QVvaJ
 7giqbwb56i4VfjJOpTCIZvf2IgB80NpEWxWA4HITvb38mxsJEcH0td+AYhpbWspHdfOXjvpfX12
 KPPGoOvJOxznhbbPBFyWaRRAcTq7Ed/gTLt4Rg4VVK+Dz+5Iw/c//hAD2EvO3DNOr8P/Xcbnt4s
 dgtM2jfjcfXM/khIcT/kz2rNe178xeCvOZT3q8NbORierCcW9EEIOX4r9R3iR4sz+rghthumExc
 9zrI87DzUUA==
X-Received: by 2002:a17:906:26c5:b0:c51:3b84:6fb8 with SMTP id
 a640c23a62f3a-c513b84886cmr456260566b.4.1795262143286; 
 Sat, 21 Nov 2026 03:55:43 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm194960466b.17.2026.11.21.03.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:55:42 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 29/31] usb: mtu3: set endpoint capabilities
Date: Sat, 21 Nov 2026 12:53:33 +0100
Message-ID: <20261121115335.548142-30-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mtu3 already uses usb_ep_set_maxpacket_limit(), so only the caps field is
missing. Without it usb_gadget_ep_match_desc() finds no endpoint after
the dwc3 resync.

Set the capabilities like the kernel driver does.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/mtu3/mtu3_gadget.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index da633faae7b2..f209bf47d073 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -591,10 +591,20 @@ static void init_hw_ep(struct mtu3 *mtu, struct mtu3_ep *mep,
 	/* initialize maxpacket as SS */
 	if (!epnum) {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_HS_MAXP);
+		mep->ep.caps.type_control = 1;
+		mep->ep.caps.dir_in = 1;
+		mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep0_ops;
 		mtu->g.ep0 = &mep->ep;
 	} else {
 		usb_ep_set_maxpacket_limit(&mep->ep, USB_SS_MAXP);
+		mep->ep.caps.type_iso = 1;
+		mep->ep.caps.type_bulk = 1;
+		mep->ep.caps.type_int = 1;
+		if (is_in)
+			mep->ep.caps.dir_in = 1;
+		else
+			mep->ep.caps.dir_out = 1;
 		mep->ep.ops = &mtu3_ep_ops;
 		list_add_tail(&mep->ep.ep_list, &mtu->g.ep_list);
 	}
-- 
2.53.0

