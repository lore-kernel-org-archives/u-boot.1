Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C6606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q0EAxkLD;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=adqg7o5+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8781D40591;
	Tue, 27 Oct 2026 22:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id joMA8Gy_HIDj; Tue, 27 Oct 2026 22:48:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0F3C4058B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793141282;
	b=Ez4WaAomsRVXqTHuhzzAo2uyA1OKjQL3CDqPceoE0/v7Mvddo3RiYh3VMzaJt+iEmnGg
	 W6fFnjSogc6Tp6cX2iDYvB+klg5cZowsxbnjF4jbYzvPdRDnTv5TObkOcLBPM4M4x/wTC
	 VtZ3GjQdtvzKQqEEubtAy6CleAxmvdxAOXnIJ3wl4Npsli5CcTtHdwQCrFHs4fRR8UXFa
	 MCoFnHWC420sl7TrEg+ywKuN0v5Hmg9FW85fP3GIp4gtSWmFOr+7YxzVmwL9Vhi+ev681
	 mo9vc53iLoWl9VksrJt8GjYkrchcFvUNROT2YBPphJj/j9za5HKwVXZcZdjhcbYNi8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793141282;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vIr/QCC1u8+EfEPQLeZatA+ooNiev/79t9O368AId6c=;
	b=Qal6tD5/qiy8jpMHvS2/Iq2A+mMXFG7vv6QDyV9+zUc/rCWYS3Vx+CunBgZHGNKi6J77
	 KiVQgsYdk5HkN+Hs1LBm5+Ff+PVlIWjWhy+5swWoheiq80JCrhwthzmPYJVbOFniOGM4o
	 wdHKpt6WqYY9vNUaOKGTvrh9uaN9Z3UeeBdsuSESWOzU4zn1ih+W9yq14B5zuhSk95NKB
	 gMjwf2+lRRCJx5oUKjatbXx/wjrnbL+u4FgSfZ2Z9Yr/PbfCp7I1k1DTPL0gCy0mo6p0I
	 fAyiME6GOZ4A1ALlu/Gc0V5jwQds0Mv/uJ55whCgk8mzDUM0FM/xYP2/rNnv75GBaXg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=adqg7o5+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793141281;
	bh=vIr/QCC1u8+EfEPQLeZatA+ooNiev/79t9O368AId6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q0EAxkLD7JD2gl8wTzVdT+GbYl7iKQVCkWlmp/TBkx4f0oIWvvWYRkGG04dEPtj6b
	 wPQ+eC89akKvfDixb36WV2qmzSlIpOaBuNWtfUteP55AWCGbAktcjUAt0cVz+P43Vv
	 r5u8/NbGwej4kB9b/f43PlXuVFDg4IWLiwBalnwGxeWllFyRahkP/9ieaf0HhmZeyv
	 H8gAqPMEPik5HYf6p0sjCTHQ9U97jpTa3QUGnlkeQQuhjENxMZoLcsiA9BfxUKyyMG
	 vUHw81CKK2DFhnKpbQVEcpOpx3LWVGjFu4qCRryvlDojKZ1m2M26AwI3DbR7KilkDH
	 0ung+XgcZU6eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0F3C4058B;
	Tue, 27 Oct 2026 22:48:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95F2F529
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 879084058B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L8-uHA-A0DC5 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 22:47:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88CA740589
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793141275;
 b=U5sJOTBy3bbhhT6GjDR4IJK+2Q8X5gm6urlSOA/dattUGnlM4Fp0v+A0pZabfhghmiFq
 BKZAWs2YHWVT6uNz5HkTAweJIvLNEnNYRWgJO6QFOFBUj6xfX2vCUNXccw5tMSBf4Mi1S
 k653k3FfZJi1DaR6zW8xVYLXJioMoAXFcfljoa7M7zN60OiWINguKkrkARdp9d49lFFDf
 HDlLJ04Xr4o7qWM7i5bYHCY7w3QYw8+s6yMLG5hvs48phYWOXY8UT8mDjQJhvNUpvU+vI
 9zbMXLQfdowXgRWg0nSw4zPu0QZUHG6zQZf0PgVG3gwPZhFdxt4ibmG5NJfK/jtQM5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793141275;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=vIr/QCC1u8+EfEPQLeZatA+ooNiev/79t9O368AId6c=;
 b=LMbBbwgtSpdVhppUGTbykUkUkitRF/9m/QII12lHuJZ3x4pzz9fTqqyF4EMa+RtgAfEa
 rdSUiA8Zt20FP8/G1rED9qVFdGArRGlOkvp21y/uXJfc30ruD+6cuUU8fpJmmgSk2VGHG
 G8x3oTsLbpdN6MjOGzf1ptKT5N34mxqBtc8eyuVFOLgXHHOr+u/P8eVoASgUl1pKNqX+L
 VTL83e64dz3cBVbRcE3qe8Wonk/7bszaz0yWaHN1e7j1n2fW6sCkz8KqIxLmF9c6J1hyR
 8AYkKwqF5LA2T2K4LqzD6nCI9s647NSRQ8xb44SBw0L3UkVXj6soao8g1YhBQyH2E3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=adqg7o5+; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=248a=is=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=adqg7o5+
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88CA740589
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1793141274; bh=vIr/QCC1u8+EfEPQLeZatA+ooNiev/79t9O368AId6c=;
 b=adqg7o5+fC88jXfeTc1QMYt+iy5fF6O33RYJVlYJdwOw6hr5dMx08JmhhDnR4qEhOrr2bxTdP
 AW9z6hXuN3eWOa+zWVW8q9byZAgvgmoDrueEkDhLCJLjYqmVZOONnq3zHuIXfYZFLRQcEgRkB7u
 BwRy/3fSFmMyq7CQGrB2v622zC5uILNP06EXOavwApZANQxTiwsJnvOxbxvJcBDDVwQiTc65DJl
 uQRgrGtyG9IfaffSoyE/oHXihFdRjh9fmg8fsylRoCTfUlBm8+mSX47PenyXhZga5PqygGZC2ww
 PMSHdiw5duporBDoFAu8HnjryOoj9r+QOTpIy6TUlrBQ==
X-Forward-Email-ID: 6ae12a1861225291cb468a4b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 2/7] clk: rockchip: rk3528: Remove unnecessary
 clk_set_defaults() call
Date: Tue, 27 Oct 2026 22:47:33 +0000
Message-ID: <20261027224742.2527550-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027224742.2527550-1-jonas@kwiboo.se>
References: <20261027224742.2527550-1-jonas@kwiboo.se>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit fd1ba2965244 ("drivers: clk: Fix using assigned-clocks in the
node of the clock it sets up"), first included in v2020.01-rc2, added
a clock-uclass post_probe() hook that applies clock controllers own
assigned clocks.

Remove the redundant clk_set_defaults() call from the RK3528 clock
driver probe() ops. Also remove the unused sync_kernel field that only
recorded whether assigned clocks had been applied.

Fixes: 5a7a856b132f ("clk: rockchip: Add support for RK3528")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 arch/arm/include/asm/arch-rockchip/cru_rk3528.h |  1 -
 drivers/clk/rockchip/clk_rk3528.c               | 16 +---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3528.h b/arch/arm/include/asm/arch-rockchip/cru_rk3528.h
index b4020958a046..64af04b0a97e 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3528.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3528.h
@@ -35,7 +35,6 @@ struct rk3528_clk_priv {
 	unsigned long armclk_hz;
 	unsigned long armclk_enter_hz;
 	unsigned long armclk_init_hz;
-	bool sync_kernel;
 };
 
 struct rk3528_pll {
diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 976ef0e0a919..ee4284d65d03 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1602,8 +1602,6 @@ static int rk3528_clk_init(struct rk3528_clk_priv *priv)
 {
 	int ret;
 
-	priv->sync_kernel = false;
-
 #ifdef CONFIG_XPL_BUILD
 	/*
 	 * BOOTROM:
@@ -1684,20 +1682,8 @@ static int rk3528_clk_init(struct rk3528_clk_priv *priv)
 static int rk3528_clk_probe(struct udevice *dev)
 {
 	struct rk3528_clk_priv *priv = dev_get_priv(dev);
-	int ret;
-
-	ret = rk3528_clk_init(priv);
-	if (ret)
-		return ret;
 
-	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-	ret = clk_set_defaults(dev, 1);
-	if (ret)
-		debug("%s clk_set_defaults failed %d\n", __func__, ret);
-	else
-		priv->sync_kernel = true;
-
-	return 0;
+	return rk3528_clk_init(priv);
 }
 
 static int rk3528_clk_ofdata_to_platdata(struct udevice *dev)
-- 
2.56.0

