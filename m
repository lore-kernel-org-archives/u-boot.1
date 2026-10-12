Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7A0CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B131D60607;
	Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MuuQsCAHhAI9; Mon, 12 Oct 2026 11:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D66056060B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791803782;
	b=a+zm0s+hw7VZVTrbezath5LDClPYlSkUMiPl01AxS1lElxcSxbxjfCohssnz9OqKN3rL
	 43V8VHt23ZXqtu3+edjLLFFWyk7GFhueLAQLn+23CwNIAsVt136tvl30LsQt/WigXhjs+
	 rcEc5kMSOnnlN7V9IXjPXfwILqdDoiYw0Q+MBRWmVRpHiUuW7t0tKEfY6tc2tXfcG4KDj
	 noRVwfEMSFbHJi+JOsvv+Z6GsqAIA4t3LVe7L36Bpot5aIsKDYo1MUEvxZ59W4EO3PI1R
	 6USGO/+BYRwVc67T42Ba0CiezRpBNQdPx/Yd5evq6QtcT0NUzI2P3rsrhmXiFsuWGFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791803782;
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
	bh=bGFAQZE5UFl2pYI5vfjHAw396sE6xF9hao9jbPRP5no=;
	b=qfcCY4jMF3JM1X5HVRVGiG2eEwO9vaYd6A5+dBKHGSEtkSzfAYxiVqA9Upru8Sjj2OUF
	 Pwt4jXNv3jgbhUBIcZnTJcSenUB/92Vqii98kfBzWfqruDUb5G3Mt7WumzMKaNUHQ7hFp
	 xhQWfZdHpSumwq8NaDjceMl8PE2zVfl46Yzb8Z4aFu6FdkFbxRteINl9jYL9c+QtAiKHQ
	 a3ysoDi11r1RaDiSHg1BIf1RuMNkboO7bR1taLaeNHzGDvxsRA83tfDUVmuxWN4/jbGiJ
	 G1qGaVvMwHr+pdHHOp3nlo5f7VXfy3wy2bxrGkKt5pY5xmoEXTlkOnHG3nN6RqdUGGg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791803782;
	bh=bGFAQZE5UFl2pYI5vfjHAw396sE6xF9hao9jbPRP5no=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YippbI4UaFPhJq5HJRY6tidEUy6J9U/E9ZnApU6JFUkdDJWtAfwR7CgaJmSBpoboC
	 VW6paKPQaxSiKCOBvqWTr0xon2QoCmbXkLjoc5L+XdHkL+woeDTbT8C6f++7X+QlA8
	 qFUtxj5rzwphccVXyZqE7QkmWUmQpDFy71czjHcC8nMuF/he+SoJiTwIDXycuzuim2
	 s+PofVkvnSnovunBCD4+cUmcKHHzNMbGLkSLPAKyeODgEzeFhDcVGuwu4avohzMiRD
	 qnAuEOhlkFvBltMhbou4vpfq2e9It2cWRrPJtRym1/Ym7/4qzyHizmUCDvbSIxCd+S
	 eHmsFVgsFqkOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D66056060B;
	Mon, 12 Oct 2026 11:16:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0EEF179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6B1680CDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xp-ScbL8c5OG for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 11:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C109880CBD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791803780;
 b=a9xSq2FZm7pgjVIWajh30bnzLFUFuBhTI/d1PhrG9SeBC+L0bA3UZGqzBEkdU9MSOjyF
 O8r6vj2fWmpKciMvtLk+hVRMBioe6bFTqUcGD7qiXHMr2cnVD3ApopNrGpwupQ4KdZBAN
 Loj1AHXX2QHLEFzw7YyJoSDIWP5KsDzOIoiST7FztOhZ7qMi87VjPSUdam/qvcNEhIDuB
 SddxARhKObMv39jD4tydPSdU0iFGAvxWfCPcGJNgZfMHCwrWymfhhr6orcMTuYUhv8Rsn
 oZ5Eo2gqD1t8bwJn72S9NlNk9pL3a0k/7Ea+IqMlgW1MDU1GvzpeHc1PYqo0fstjusg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791803780;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=bGFAQZE5UFl2pYI5vfjHAw396sE6xF9hao9jbPRP5no=;
 b=NHDqSxTKJLRZtMs8KRFQjK/O/jSiTuNCacz3iu9PGed2IUXTaCVqglJg8njmXpmMwODe
 zbUxiTUwEFyeD/w6KrDLHXMGlmL/mBAYe/9w+B/1mR+jGm4d+mI5jQWDDylb1ExVJ3eI4
 xiBO58rZaWFtm6zZSZG70cPjQudVwm7kLamieQe9PYbrnhcoMREPaNybFwKWmfWe+HsT4
 l7SCWmdIX38gN9Ywp5b8ia3ViUcm6k7erh9puBa53v3I8DJUh79tvxgu2xLIpEBbXhPcq
 MqjUPgKfIdgUnUvi3UAI43e/p4fZuQS1hWQ+0wTNd4yaEiFtMO3x/P7QuhdnLb3XORg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=bJubFY6N; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=bJubFY6N
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C109880CBD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1791803778; bh=bGFAQZE5UFl2pYI5vfjHAw396sE6xF9hao9jbPRP5no=;
 b=bJubFY6Nt7wX8RnV19pi7ivUeENg9xqp7DFoVVQeE1dkM8PAEJiPicuPMtI95RZ7x/y81S3g/
 1uf9DOaM7blfGzv/45yfsBh9Zf0g1GHaE/0SxGXJ0okvfdmoO0yN/2dAtCJUCLWRt1kXlZkPJq7
 Ugb9AZMN/Q3uNQfKppnqwrKf1/xkrQaae/5oOV2sc4B/1MbFR8h9puMVbZ7n6scmpX96AwzI+XD
 C7aZdVKZCyK1ObJ+qzyogDKcddxgNc9SM+E8MRf0GTVp9Dz5ek+1vta3VYIiZ1qoRcBP3PRtqVe
 t2WneB80GzkQdA2jVptUNxr114MXDi3w+jrbUgOWmDYA==
X-Forward-Email-ID: 6accc181003f837f7de8eebd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 3/4] clk: rockchip: rk3576: Always initialize clocks in SPL
Date: Mon, 12 Oct 2026 11:15:48 +0000
Message-ID: <20261012111552.1173161-4-jonas@kwiboo.se>
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

The RK3576 clock driver configures the CPU PLLs and CPU clocks when
probed in SPL. However, the driver is only probed on demand, so this
configuration is skipped when no SPL consumer requests a clock, e.g.
when booting from RAM/USB.

Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
of boot device") all boot devices where typically probed, with a side
effect that clock driver likely also where probed, prior to the
boot_from_devices() call.

Flag the clock driver to be probed after bind in SPL to help ensure a
deterministic probe and clock configuration behavior prior to booting
from devices.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Alexey Charkov <alchark@flipper.net>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Update commit message
- Collect t-b and r-b tags
---
 drivers/clk/rockchip/clk_rk3576.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 75b705ffba2f..1988f0472dec 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -2526,6 +2526,10 @@ static int rk3576_clk_bind(struct udevice *dev)
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

