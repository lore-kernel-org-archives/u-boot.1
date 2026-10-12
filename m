Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90A2CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 11:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CEF480CBD;
	Mon, 12 Oct 2026 11:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qgqO3Aeur2oF; Mon, 12 Oct 2026 11:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C7F0C80CDC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791803784;
	b=Qe0Bao9NKsOm+Vpf4TmiCIH64DDBOFWZwL4NeDRf1HlzaA70B+lNLUOyKGQ5TbrSju+I
	 nTIq+r27GdY+mnS8QR6et0Q1Mx7M34EXU/xp65UiOmZ6lT2K3z97+BhR7+e3Y19O7PMGN
	 WTkM6wj/kJ2Z6zmf9V4FXuFu9OOHI/jKEoZ0blc7RDZQxTLvM2jCi1i3NPc6C34rPF7yD
	 3xYBK9g4ikWuu05SHrgwXAeCQWZl1TbVTkqWtr1sOKYptB9X/3H6Rk7TyT6j8MnvhDTsi
	 tn5LKODWBsAESMTOftljtXOZa6PiB60U5NJ+O9b9BZMNOelP9jI2gALdSDFOeX2vFpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791803784;
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
	bh=FiBal8oyQXuEzxQstlbf3bvfoeqKD2UTBLMFxLTNrLg=;
	b=f1hyRSdj38edrRpWwjYskOJAq3FQfNthQCKHqDkvxWqHPY3JtwvLSj9R81qFJu66lrrx
	 5d/0UA1GTYkWv8iW796p+OersMcfxgYrgiM4DmcKc9lleOgLfvoV7zS7IN/VKzUNLVjYA
	 KLUvhNLdJ9plJbTGWi4UY34e5r3wWBNeM5btnnuYSuMnpCxdk1J6XjlYAVonPoNw3L4a4
	 snKlu8md6Ku7Fm9g66/xYJfZ5cqfFKVzFH1e2JokINTGXwwfM3GPjnP1yM1QmzxYa6L2H
	 hUb2C48B8sSw0JTSH1ZrAXGfICRYoG8GLYNpuENyutiYno8SGPlBv/FuAkmokGIWTGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=v+RK31Dy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791803783;
	bh=FiBal8oyQXuEzxQstlbf3bvfoeqKD2UTBLMFxLTNrLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y4JMlD3oOwMvrViRNibpqfvm6FSw8icVrCm2nZVZ2+I9+l0gKWtCeygt+akvRO79n
	 akblJ0h4n3f9g95rmNKwlEht5k0Ff4vvbUEsTZXwF2CuEZQFbgxC5DAaaVoxs3h8eD
	 B+4jGBqHzXJ/dXm3cFqwBbHD/1v3uKoOp8pzDHY0bNVTwfugj33qR9phMJEcUpfMj0
	 H6x79X/fGkLgSR7td8c8niMaZZJyc5d/Wl7/Z1Z8DnugE5tHkmGcBXDlY9LCACHaDP
	 2WZD+3+4J5RnvKiHVwW7i6ycYnS5pUra33x6hZekjiop86eaVHNWMkL8QOIBqgua+q
	 rKfpvMk46/5Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7F0C80CDC;
	Mon, 12 Oct 2026 11:16:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BD88F9CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A313E80D02
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_3AoPcxZGtp for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D56CD80CDC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791803782;
 b=bUy1WQZ4QAFzNmxrM4fOlsquj8e8I2baTmmbvhKopLLN1iM88Eq19qQHtv+7+7vryK+Q
 UQImZKPk7qr50rSWd/E1Fv5KXNbwhcB9tSfzSixwIbi4dZ8cZ0r06JlGQ6RuEulXma2Nq
 RdXltxpcjKKmqUTBRlDo5sWt5CQG+nnhloUSob7s5si30FuoHYSySMcTaVkaRR5n2E2Sn
 uoNy3OZc/h7y47XpL7XMk+v+GhZWyGUStc7tGJtPdNl+x0A83VToUtowWsvJgn22zvRao
 KCHn+5/r5A8rNEPHHEyctiLi3oy7jhcvv9GPKtUv3gWVs901OmAlPmwLqT9AEgAPaTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791803782;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=FiBal8oyQXuEzxQstlbf3bvfoeqKD2UTBLMFxLTNrLg=;
 b=rfNA+9T/PYaZyP0rKZOj9R5zBr0ZpVFrFFxObI9iEBYzfIf8q+xIpGWn868llHgIwL1H
 laRfU/aX6Z/QWNFpYRYgZz398YGU8NFSoSFqumd01es98oqFiobvPQKTiDsPSaaN6YrlO
 dJW1nJEpjSMGBAU/VUKvVNJM11770TYlGhgh0hXWH5p8hsCnmcX34w6BnHCTTYvf2bc6a
 Lkj8VgrqVQtZSqhjegAl3/DNrdkj/YZSqFJefPg8wfDJuEekD6odmJ1+oKchDt+XjFlzT
 B83hSEpQ9i+JA5nkJto9k072o7M8Dzs+AXCzaG2g7R1nWPzxCjyYL8yfOCQk+7nZ0pw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=v+RK31Dy; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=v+RK31Dy
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D56CD80CDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791803777; bh=FiBal8oyQXuEzxQstlbf3bvfoeqKD2UTBLMFxLTNrLg=;
 b=v+RK31Dyz3abnElLqbeBGIM5MGJ1/1NXfkNZDVH/U4pzpvIfdbHjp+uRWOwhblD5vqfyDP8lB
 mw3+6Vz2bNR2KrWB7XpWFnUGUkBGcvBxD1Sd4oeMoHEHzt7670f/gixuiDoPbWmyhRFm187Q0XE
 mZ5BUjoqU6h+YVoAE7N74j0bFOcADND6DcGP+0mtqtK+omEUUwc0FovYrdJdIaeqA94jO5b0VOy
 dGxPLYtjk8etXc9BjGGTXZ87Wkvf7//neFocfsAVbw+ZZB7ABlPINwdYsUD1sxBQovrXep8Eul2
 FU+Ox0mKmmPqwWiOEg1XtQTQKm/QjjDwlongb9SQHoQg==
X-Forward-Email-ID: 6accc17d003f837f7de8ee87
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/4] clk: rockchip: rk3568: Always initialize clocks in SPL
Date: Mon, 12 Oct 2026 11:15:46 +0000
Message-ID: <20261012111552.1173161-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012111552.1173161-1-jonas@kwiboo.se>
References: <20261012111552.1173161-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The RK3568 clock driver initializes ACLK_BUS to 150 MHz when probed in
SPL. However, the driver is only probed on demand, so this
initialization is skipped when no SPL consumer requests a clock, e.g.
when booting from RAM/USB.

Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
of boot device") all boot devices where typically probed, with a side
effect that clock driver likely also where probed, prior to the
boot_from_devices() call.

Flag the clock driver to be probed after bind in SPL to help ensure a
deterministic probe and clock initialization behavior prior to booting
from devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Update commit message
- Collect r-b tag
---
 drivers/clk/rockchip/clk_rk3568.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 9f3e9322161e..5a05f1b4de00 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -2934,6 +2934,10 @@ static int rk3568_clk_bind(struct udevice *dev)
 	struct udevice *sys_child;
 	struct sysreset_reg *priv;
 
+	/* Ensure clocks are initialized after bind in SPL build */
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
 	/* The reset driver does not have a device node, so bind it here */
 	ret = device_bind_driver(dev, "rockchip_sysreset", "sysreset",
 				 &sys_child);
-- 
2.55.0

