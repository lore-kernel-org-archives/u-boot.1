Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B3606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nGmqY3KP;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YrEff0S5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A08540AF7;
	Wed, 11 Nov 2026 23:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SVW1rvwacHUa; Wed, 11 Nov 2026 23:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD4704081E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794438788;
	b=mKomSMNaPajKUF7e1sn49y+tanWKwK/DjhNKXXI895+wNo4sAKTNNGkNZ7OXqbogXC7p
	 kP/sCRQhGwktXEOgYJiu/Tfh2fPfC0gJ9wzw1oKQBkvppCK+5/xh8wYOEpM8menCoy07L
	 oZ0vyJqlZ04An0jooWV3wEG1b11d5O44EngB7WW+JcR8nBET5QvM8z1TsH8+YDq5vlEVW
	 wdGuZcVwO9J0zWgefu+22TTFXJVoetf6veIgtS1arU++WGsCVIzoXs+H6rx66JTXg9Kk8
	 lH9P/e4AvYL//7jv19Zt0rbHDX64W4X0E7GuOdykyBikMz/92VD1W4fKmPJb/KP2aNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794438788;
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
	bh=GsX7TKSZBYrnppzhZ1w5LkV5NodRKc8DwDk8lNhWJQI=;
	b=fUvws+gM3zR8Np4DLO4hTqfVdgoscXGoWQ2bGM3792Fjw5F6TsV1OdevrrQLTeHAFRY4
	 bsuFUP3YR2oQ6WVAdpuQiN8mI/H9OYYz23vwk8l6R1V2Tu3Ye/9v6V+RsWKgEUJU0gJ3D
	 +Stj+aTLooIceeOz/qP36tSv2iX3w12y8O3IRsJUTcDLwJ+wJBVX7KP1bNHlJ2IwR2gYi
	 pxw+5G+ENajDd3z5ZlB7SJ/JAY6EFHtTf6aq2A10Us2LZxVlCwYe0v9PXbnYO22n0moQI
	 QUmwYKIjRvg4QH03T3DvGc295Y123SyJbsSUHSUS0fnUhuWOd6PysY8JbLAS1uJNKaw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YrEff0S5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794438788;
	bh=GsX7TKSZBYrnppzhZ1w5LkV5NodRKc8DwDk8lNhWJQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nGmqY3KPfQ+6uTlENBiMBnkLWOMB/a7OhP1kEB8000BXW3GOFf3WH7320FJp8ulYO
	 8vevRp2by+WSbwnoxflm4zsAsYK0pwXxkOGK5w5wJh3BRvRt2ngD/eOoGX3FBJDFa6
	 sMU+uuBOT0yY+qN9wAkmmCaX35adB8Ce6yYVUxNf6I82hzIZDsKZxaKgaxo2oeAgSC
	 dMnD15PYUlBsv757/u3s0I2aEJQIj+O0CEvIZqgLCE50PUUcYI4bzwbeTVjzgvj46L
	 2DiPAHqnzRouXgG6F7kmribFD5Hp/m1xCy8ov9VwqDc+WyAwCeKHZrh7b7K9xd5fqB
	 +snCxUAC5Fncg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD4704081E;
	Wed, 11 Nov 2026 23:13:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EB9F2FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A3364081E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4llNTAx-9mK for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 23:13:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8CBE40603
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=33c1=jb=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YrEff0S5
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8CBE40603
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1794438786; bh=GsX7TKSZBYrnppzhZ1w5LkV5NodRKc8DwDk8lNhWJQI=;
 b=YrEff0S5PIVJeWx6rAC/o5X2V7Ik+GV0qeq+lUpRFO13KfFL9nPpe9NhQc+5kL3QuWdIoBIOv
 0zfz9E9lnoSdvkUDHCXhUa41QnRaWRjuG15292seUTUWIDyUZe7mhUkgEwrlMpVanmfJ9S2S/ID
 kJ1G/Psf+WtMp3TG5h+sqkh4smHiNUrG4UUQjNkZRQ8zFk5ejYn1hyaAwYpzXEM3QVas2649D2E
 XO8iMk7/uZbldjki6GOKhAQMj/3DnWxacZzn4cRH1EUX8vKr1ACVezuWR4KTvHibwyxD0omH16J
 QyEKawuMoBNFhyowCoHtFap+0hV6nBsOOAQhSnUW52JA==
X-Forward-Email-ID: 6af4f67cf53292d6859f336d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.18
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@edgeble.ai>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 1/8] clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
Date: Wed, 11 Nov 2026 23:12:42 +0000
Message-ID: <20261111231251.160051-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111231251.160051-1-jonas@kwiboo.se>
References: <20261111231251.160051-1-jonas@kwiboo.se>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the GPLL rate instead of using a hardcoded 100 MHz parent rate when
GPLL is parent of the CLK_TSADC clock.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v3:
- No change
Changes in v2:
- Split from "rk3588: Fix trivial clock configuration errors"
- Add fixes tag
---
 drivers/clk/rockchip/clk_rk3588.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 5c3b0988e6a7..58d407a12e20 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -655,7 +655,7 @@ static ulong rk3588_adc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
 		if (sel == CLK_TSADC_SEL_24M)
 			prate = OSC_HZ;
 		else
-			prate = 100 * MHz;
+			prate = priv->gpll_hz;
 		return DIV_TO_RATE(prate, div);
 	default:
 		return -ENOENT;
-- 
2.56.1

