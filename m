Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E754606A326
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MGUdRrE2;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqhFtrqe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77BA26078D;
	Mon, 23 Nov 2026 19:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ig6l1sgNMSd; Mon, 23 Nov 2026 19:54:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4BAE46069E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795463643;
	b=DrskyeBJYomwv4rgps7Ajt0Zie2if3pppybe4FelFsMMKUGiikRtBzyGkkZkKb4eecDe
	 cqm7HbYwT/7KqwHBJhBDLNZ3WH5WV/RKKaVy4CdJAh39T/UFElZYFY/c7iOPqm4jPu1EB
	 k5Y7AXGwpBVOAWPr0qsYQVGzy7U8+5BvGpSUwZUXG6snyjIDYOIlh2yplrp4TQ9TIhtuJ
	 HZFmCwpawT+ndkSIP47QO8QuCw1Q6rltHT8tpXhLF2jd7Vz49dZ0C5ScVVp6Rh/LOjt9N
	 Dhb/TyRyAPOG2VTor2l4KXNFY1TCIe++N4UVlh/MekYM7xPALaZBVtBVUhGpJY1TVpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795463643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KTl0MI5/x6KPOWQu3vy6FNuFxUtykUrFNdMKU2aN9no=;
	b=rDCq+/pRL9wl7q8TFQoIaaAcUySsZgsko/xQLKAEK/fZViVhwQ776g0KvWrKcbvszXsV
	 WJ+wcc2O2ruNb7a5U0V7GIrK8yeUuV8IOyB8k4ivrySR00J0OuRk0rCo3yG3iQkx+ALHk
	 bLAlZjXfRla9FvPhwPtbJM8BZn5cMF7TjE35DaZkHzvi+92DRljKZK9BAnKqw4ukG4kIU
	 gUw6gWxP9FG3v8zFHY/2uknuEafGM+kPUsWtZLqpf48TaVk6LRmqno/1JugHLbqUoZbmP
	 pp4T/4jUwGQkVgzUiz7yHiIumZhjAf7WeM5Ei3qZV4CxzTR2vVXmmivCgGPX7rQbeEw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795463643;
	bh=KTl0MI5/x6KPOWQu3vy6FNuFxUtykUrFNdMKU2aN9no=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MGUdRrE2vFcrqe0RMYsTtKgTfTAtMHRzCCBIUC4NaRDi/DkxvdVCltwaM5HmTyTkJ
	 wFGvktQF5MdrW1t0eumyad+niApJe59/dHA5NaXVdnCG9XYl4O6pCVNQrxuW9skuf5
	 D68iByPMej03EgsXZFL5xxGGD2tEUQdiE1MROJFV4opjIVTD0z4Rk4FdNT3o0kNdYj
	 z8npbZpyMCquMO1wOm+keuVCSxWUqpYzGGbq0Tq1oSjTNlZl0XzDi7SLOK7SVal5Fy
	 vfTF6X9FaYHkLvvLPuJj/BO/9DGRszvPOh8TERTCFScavhMNy4FFayiicWQIoCumv/
	 goFaZ5wvRRYkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BAE46069E;
	Mon, 23 Nov 2026 19:54:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 038F2715
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA27840093
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VFoKU2AlIXNj for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:54:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 305DC40081
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=CqhFtrqe
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 305DC40081
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:53:59 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-862b76e3c8cso1699087a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795463638; x=1796068438;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KTl0MI5/x6KPOWQu3vy6FNuFxUtykUrFNdMKU2aN9no=;
 b=CqhFtrqeON9H+Oh3Gqvvc7H+hJ/QwzsJCCicgoYysVAAOo8T6BgdI5Guk4fQsloury
 w+SmbioOxD0v5qZmSM0R99S40VzOSMoe0fSujFHlJAk8/yaMqC7iTXYlcZR+Ne8y6BHX
 t4YDTwbVO4UBAB72ah2GTx8b5IqOgt1/B6+83OpJ1JOiAzSPnPsio8XDhEInXWn2y84U
 XVnUKiwYsljqGkGuhdFQMkDZ3JIDo7CkzcjiYgc55Us2T6L0UdJryWlG3Ad49nsICkUW
 c59RLhm8JZHyUjkWDLuKH64ml40RYZ7PA+wS+ohc2XjeP3CX68enlJgcyqFLJIySlCWv
 r6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795463638; x=1796068438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KTl0MI5/x6KPOWQu3vy6FNuFxUtykUrFNdMKU2aN9no=;
 b=BKloitLUKsFnysApQGsvjjh9Ihlo0yqhSvZT7K+COd0LqmrtpfXUggHejosslBintn
 GlNBFZ1P9tJJIMZRtF4RPZgvwcrEzGBbFVUM31n3xBvFhIuUkRmysC5HpCNSucPD/Gl1
 W/FO6lFp0jeXK9lDUWi69822FwwC+DyvmXHQluUXCtJSgSRPfn0D+9jNHhZOHx4mAP5u
 /vl4zbGBsPKsbXJBDKSmxKOHdbJAPCg03OUxYblaNCkLayZUx8X9PDXrrAvJAqe9YlD0
 beH+oucIVYOS43cNxNuAqwEWo7qXPW0B5dfbjlfFKBWvaInhWps/LauWwBgesC3dRqBA
 H0Bg==
X-Forwarded-Encrypted: i=1;
 AL+hErFFx2GwDe6ACYf3P7S54zap44UKx9N1VlBymo0U7q37RqqSGrkx140oAVN2SbzxR1uFeCulctw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9lFPaRJup6x8CSZI0xx5hSUXpxiqiZGMJGsn9SX8J6w5vTWypi
 0Og4IJaC/yEx7CSNbXAhpemTW+oPILlpOTAcI3OD1i5BGV+HoayiSOVX
X-Gm-Gg: AZFdTZcLm9LvL0rahyAs+VHOgHiGnv8VsapVmlx8yoc2bLLxIQHc+QxJF2T9DVoYc9W
 qJoEoOnz7odXKaCF5p4rPfY3+ipkgvTvjpL1FnnZAIlDXTAwxzGILZyr9gVosonsMgFWbTIb3d0
 xKxjFCKphOM2SPZeF91FrnQChv57wSJTjSIXqMJx2cX4WPn9t+/abJN2oaJkaT/OIqaS6uf/8ej
 Za2iztO01nmAkpd9pOxrkrzpiMTQIgof4Vvvq/85zqewkK4IF0e7OGVq8b/zdWRTgmKSstTVSHN
 rOD+AM+ax/56csf9ZbM2gj92LLHRDUCKQcI4SrkXTlT4aF9epzCmGYr3OGlUIk1SWRBfXf89OQK
 3JaCojC2/1HwecRqiyxslI+YLKmPGSb/hN6Be7Tos+zTCMSBTN8nEmieD9jzG3Le4aWDzroL99e
 ix3Lx4F9nqKX2Sg4UlbxYerZYFs5HzCmunqFnxR8ewCN1RYuZrC1PGqDtef4USZpjKySYwnOSyi
 AF0t4jWEpMvZHbIDqxGbGdmVfB4dcRmrHu3MZsGtYIiW5aWf8vSNrzbh1cjY5OFj2mV0tGFQRJ2
 TWshDi6mShU/CwY1iZTmcW5Aw0V81AeEbLgvDEArXbZKpQ569DAu30XB/JqDfyWtcj+J1r4uaUM
 2yKAynaYA1rjwffsuNHNpiznT8VOMRQ9c7ZsgGUeeU/JH3bnKyeEqnHHGngIRBxecS/zUi1xXx/
 sqE3IKmWNpnkertkANIa+Udh5qXS6eBmoDd07qE9c041tmqqDu7cMb
X-Received: by 2002:a05:6808:244d:b0:572:5621:e58d with SMTP id
 5614622812f47-57a0c5bfb4amr13787607b6e.61.1795463638263; 
 Mon, 23 Nov 2026 11:53:58 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm10307575b6e.3.2026.11.23.11.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:53:57 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 23 Nov 2026 12:53:53 -0700
Subject: [PATCH 1/2] net: ftgmac100: zero-pad short transmit frames
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-submit-lwip-ftgmac100-v1-v1-1-6b34bebaa2de@gmail.com>
References: <20261123-submit-lwip-ftgmac100-v1-v1-0-6b34bebaa2de@gmail.com>
In-Reply-To: <20261123-submit-lwip-ftgmac100-v1-v1-0-6b34bebaa2de@gmail.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Macpaul Lin <macpaul@andestech.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Jacky Chou <jacky_chou@aspeedtech.com>, 
 James Hilliard <james.hilliard1@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When sending a short frame, such as an ARP request, the MAC needs
60 bytes before appending the FCS. The driver increases the DMA length
to 60 without providing the extra bytes, so it transmits data past the
end of the packet as Ethernet padding.

Copy short frames into an aligned buffer and zero the remaining bytes.
A single buffer per MAC is enough: send waits for the descriptor before
advancing the ring, and checks ownership before reusing it on a retry.
Transmit full-sized frames directly from the caller’s buffer as before.

Fixes: b3dbf4a51f38 ("ftgmac100: support of gigabit eth ftgmac100")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ftgmac100.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c
index 5e74f976999..782aad4b0fe 100644
--- a/drivers/net/ftgmac100.c
+++ b/drivers/net/ftgmac100.c
@@ -89,6 +89,7 @@ union ftgmac100_dma_addr {
  * @clks: The bulk of clocks assigned to the device in the DT
  * @rxdes0_edorr_mask: The bit number identifying the end of the RX ring buffer
  * @txdes0_edotr_mask: The bit number identifying the end of the TX ring buffer
+ * @tx_pad: DMA buffer for frames shorter than the Ethernet minimum
  */
 struct ftgmac100_data {
 	struct ftgmac100 *iobase;
@@ -114,6 +115,7 @@ struct ftgmac100_data {
 	u32 rgmii_tx_delay;
 	u32 rgmii_rx_delay;
 	bool has_rgmii_delay;
+	u8 tx_pad[ETH_ZLEN] __aligned(ARCH_DMA_MINALIGN);
 };
 
 /*
@@ -552,7 +554,14 @@ static int ftgmac100_send(struct udevice *dev, void *packet, int length)
 
 	debug("%s(%p, %x)\n", __func__, packet, length);
 
-	length = (length < ETH_ZLEN) ? ETH_ZLEN : length;
+	if (length <= 0)
+		return -EINVAL;
+	if (length < ETH_ZLEN) {
+		memcpy(priv->tx_pad, packet, length);
+		memset(priv->tx_pad + length, 0, ETH_ZLEN - length);
+		packet = priv->tx_pad;
+		length = ETH_ZLEN;
+	}
 
 	dma_addr.addr = (dma_addr_t)packet;
 	curr_des->txdes2 = FIELD_PREP(FTGMAC100_TXDES2_TXBUF_BADR_HI, dma_addr.hi);

-- 
2.53.0

