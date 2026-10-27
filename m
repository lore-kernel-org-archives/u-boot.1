Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C64606A32A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dlilizmo;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ZP3lPEsp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E0D780CF1;
	Tue, 27 Oct 2026 22:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5hqY_Qy2vQRL; Tue, 27 Oct 2026 22:48:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B596680D39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793141290;
	b=KoALs5vq8wZsdRYL8GtWDfn6sbzjfFW+wcaiKaAZd3MJvRQtYddgxus6JpjBR7jRwlhE
	 2paJ+GdPCLQEwmT1LBYmLjohTj+EqsrXBNVmTKH3fkDnfT1ZpETppdi0Xn+gcePmt8rXO
	 TazqbjiHMQxXoSZLZRqIVDJnEcgg68u5Mo+FKJF20V42EjLql8NzNiDevpYb/oayYkvl2
	 n3/2rHw29zTIMJ3l9OuQ5dUjM6+s0ClZ6oR8d3YOFeHJrk0jJv9IAjldS87NrKBCirUsn
	 OP7Y6GzV/PUQao/pKtwPX4Qh0hICRF8FvxSZ4SO0XUWWOPYAtRsf+el0lXJe0oON/2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793141290;
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
	bh=w2da2uf7cxpOmTLXXcwS4Ykf4Netq0M9kR31YtFTu5Q=;
	b=Gw8aMtYGtT4ZBOCEqVyPRJ2UYu1EnO4EXFVpl7q4tXrj4TASMOjvjHui0s0TWKqLR4So
	 FcMRSdH8ylLPuuqoeo/i4mH5T8Q/mPwFCttXbryxhGY0HlL3CvsBPacctdNnSo/X8uVFG
	 qQX5c1Qu37xiu3sbnFeEFjsGLOK5rmPMSE8ay4BAk63cCIdxOIPHqmf3ilBBSzvqeK+7L
	 cZpPsMQ0XOAc4JsEy/sAVtJsbJqOsbwSoroDwEReae1iULGvDUz8T+7vaqCkpCo0OwlsU
	 kektpXxxzQfD5iHSUF+KbqkZv2XMN9cNiMNByWo7WTQihoZXY3mRFC55YBraLajxW6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793141290;
	bh=w2da2uf7cxpOmTLXXcwS4Ykf4Netq0M9kR31YtFTu5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dlilizmo08j+oz/DBdQKFsnJWZ+psZXUZeyhtejwlqhMmi1fsyLw0czZcAn7DHt//
	 eHZmQP7IUSftjZp8K+Unp4LNnelD/FswNWIS8aiCC3HZMh4J3JxQ/9OrFZombdngn4
	 kywbQ1drGI/MPvlH3fVXhIwxpVp57ByZiiLk917Ed/Q5QIM23FhtANJKxlnB81KnTs
	 THZY7THiYYFRip8uq7GuiEmM+e0Si0B47p1N5Qb30LOTN5g6C1yxM+UdLYuvkRpIR+
	 XjpasRiXBrPh+075H0RRANcA97xYRHVd4KrAYs3/aCvnnFiEXyr89ZuZWK9uB3OMzF
	 +jbOuUykBncNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B596680D39;
	Tue, 27 Oct 2026 22:48:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B841235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DE604059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xEtY-w1L0ZSa for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 22:48:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A2D24058C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793141285;
 b=NWeqYI2Vrwlxmd7GqTjP3IVTjZSrOaY9hj063/3RKky/j/okgMJ+DM1rfrdTdPZgWLeB
 hkFtFlfB0xDMhi+IhH5AnUG4yzd7e67gnBIarXWtehIvoUOmVz4wPlGRRML70hypfRVur
 0QTiK5WdsdGaXVoF+iJp5uMmaIIRUiARxuf/cPUiCE6oR63Z8EWOqIrW9nVRemqgQly9T
 FHFerrZ+VfZQAS1hoqxT5RsDengCDqYP5Lr+yi2jqGZxB6K0EcEptQHCRplOh5kPOiX/i
 bEgUdPuMduT8YsMO1qq6IiV1DunRQLmtenm211SWnBYTWtY2HqbFj3zqw99MSrFY7pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793141285;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=w2da2uf7cxpOmTLXXcwS4Ykf4Netq0M9kR31YtFTu5Q=;
 b=BG28TVzxHb9qs8/10sETtxxFeLvMod6VEnIkgYIJUGGjS1UDbumTpQTZHKwbzoZZD6bV
 fTL63YYGbGHbDIDkrrMWl5bpPGY/U3NR/yzBLQ3fe/fGES29Y6FBrDGDL0boy+fkJztLJ
 492vvombHrAL2yy/y4AOe3KCKIL2DOQtyTpEWmijwoMLRXOtssd2hvWd7wMuR9G4KZyvD
 pLPeS8NmIvmnTw+VGrsvh3Tbcz+AO6CgN7JijMBYudsERdS01CDW8FMbJLEcfgZjqgUUR
 o9SAwVdJjSvkMzJB7rrUrraQKQIPhKc519wtSWX0GMvsK93ZVtKCNQuMeQ+uHi/N3DQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=ZP3lPEsp; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=248a=is=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ZP3lPEsp
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A2D24058C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1793141284; bh=w2da2uf7cxpOmTLXXcwS4Ykf4Netq0M9kR31YtFTu5Q=;
 b=ZP3lPEspcEbDPcEqbVgbPoThNWW7q8KbM09YUTLBaty5gTLichGiimr9H4CfqI207ggbht5ED
 Ay9ftprBnBfna8Fof84FmakgDbJFv3eUEw8Su5CxPCxZ7Wv1fTqOfSGugPaDTCNo1/2PCcC3muj
 gtyLRjkN5bYUbO6SduGc6TmJ+GbaFgXHBAxLHoLstq09E0dM4hDphj6CxQhmieLvDoDKbbLxTVy
 TohXDVU38NyOwxi3CYAjEjUxNcxq0CN+9mkmZUWXqyQX5kPo8QLBom/Zuw7uZ4oDDZKv1VwpTvW
 rJ7sRAdz0UfzpQfBG2qhMIEJ41iVuun0uNX/uYQ4CmBg==
X-Forward-Email-ID: 6ae12a2361225291cb468acc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Andy Yan <andy.yan@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 7/7] clk: rockchip: rk3308: Remove unnecessary
 clk_set_defaults() call
Date: Tue, 27 Oct 2026 22:47:38 +0000
Message-ID: <20261027224742.2527550-8-jonas@kwiboo.se>
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

Remove the redundant clk_set_defaults() call from the RK3308 clock
driver probe() ops.

The clock-uclass post_probe() hook does not treat errors as a hard
failure, so this introduce an acceptable change in behavior.

Fixes: fe9efbca7b99 ("rockchip: clk: Add clk driver for rk3308")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/clk/rockchip/clk_rk3308.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index 97043b8693c0..605566f71981 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -1162,16 +1162,9 @@ static void rk3308_clk_init(struct udevice *dev)
 
 static int rk3308_clk_probe(struct udevice *dev)
 {
-	int ret;
-
 	rk3308_clk_init(dev);
 
-	/* Process 'assigned-{clocks/clock-parents/clock-rates}' properties */
-	ret = clk_set_defaults(dev, CLK_DEFAULTS_POST);
-	if (ret)
-		debug("%s clk_set_defaults failed %d\n", __func__, ret);
-
-	return ret;
+	return 0;
 }
 
 static int rk3308_clk_of_to_plat(struct udevice *dev)
-- 
2.56.0

