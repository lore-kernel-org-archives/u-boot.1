Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215ECCCA464
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 22:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 467EE4089A;
	Thu, 15 Oct 2026 22:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xgPM2Mbdtxwc; Thu, 15 Oct 2026 22:42:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1A9B340926
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792104166;
	b=C65o49QUwqxFWekd8d1wawKQlh6k/lF7tmHOJfDeOCvJLXE3v/cdH4bZuW9PlhdWo1QK
	 0B0yAMqq5bm2AMlRG1ac1RwIXTUmZmbuFMwpndEsT+fAOfk79Cwm9ceRzvwoeXPpNQf+n
	 ELYSR9hOVbt9gX9gyDxsi95VtFyE8u11aN1BUbAIrEnHztXebrbkDhW3TEd4dCnOwaDfN
	 3CXpOb/i7E9++wI81urNiVOvSQJUmflB/f5EnFnqpgHFISWCoh6saEEzdA4kwS5i1hKqc
	 gqPhyI1YmIdOQDlqwC2AsmNjIRR1fl1MD9WbPOuH1XeTp2u5OdNhXOy71nNj3kbUVTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792104166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xUSw+culf9GwuBi/izwFqJZUVXfab3Qa1laif3u7gGA=;
	b=SXTH9fY8yEmLCKCDNT7pqUKPeMPVo1nnwOLpeuatRgtCZfiUgXi2MYk+tlQur6aztohL
	 5Nmm/1ev/wBaqfLgaYsgXAQsgyeCjNDlRt3KI/d6FPuFssCuHyl5RGiQ7t/WJjS90pPRF
	 WhfBuAKDnYdUmwq8XDTt+WDu1Pfd75Hkz9I2o5naCgy9xf90oa0mZydBEB9IOnYPZou16
	 BZV19r5sa4x+LeXmtK1Nz5Bja6L6layOe/avusiAxsMhTVak+nTM7hFkY8ZKHEDzd7vbA
	 sBgBHskiz+LVsFiIDHf2GzaQsVkurqJJ6f7Ey8YSH+C6NfBqSpmcbYZpYn/BKkcXUIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792104166;
	bh=xUSw+culf9GwuBi/izwFqJZUVXfab3Qa1laif3u7gGA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T4al+xUZ5xsmWl+Ek8irNDjFMoPhKbR2vhl7KXVEb/ikA7o39MsJ7ebxtmAtw4SbP
	 GOuLSxqMSihFmF97MSObmahmVBuM4qOqRB8aY3xbMhyccySjBBt7QsLGE7CPIl6ubB
	 7vZyzv1VGMiurDLqsoCSxfeSZ+ISMdOOJbKRTIv+37YrrW0K+rP4CmgiZF517OIoSW
	 CnMRRtzbgoSgDXnezlwjpwfMbGBwr7ieNUr7ALoVNMtgW06bNQ+4a9AFNd6uxLB6Zi
	 7ZOEIe9NWMzNcIm64RYK8Y0uiokNcGv0WOZCu908I85ubuENJQ1b6gHUUPU7GGPqAF
	 WPJYdPf600pJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A9B340926;
	Thu, 15 Oct 2026 22:42:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBD9D362
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E969C60A97
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4gnJ5r6L1t5 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 22:42:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B557B60AC5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792104161;
 b=iMmG6HMZ8+BuGlREWmiYmp1Pds6YS2+nLJ2bwjecgQG6cL1l1tz7GaJ92tB4waNStopn
 PygqUAUN3U+IMlOwrd6oXhct/B/w07iu3Tiqdp3HFTFyv0lA6RD4a7GXQhWM62WcI5L+z
 bkc73EiCCmzkuz/zgBb4c5qKFITu2+64zc9I/K+vKPqvtNwugRvpbBaHcE6hwvKu3dStM
 +5gbVt6/9H+DJJwqoEaENpznyHiNVNQihd2w51s1jyNtzDIp2QZ++Rsr8lNRcRgAlKBQA
 uSyNRkthWqaU9RQAFk4FhpfQddGp7SYBhMmHMZjnXHn+GDM+Muy02yhl2BsT3ue2zKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792104161;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=xUSw+culf9GwuBi/izwFqJZUVXfab3Qa1laif3u7gGA=;
 b=WZlrtl16pbvaW//qNGjrEWQLNsE97YegO2cmPGm9T5lXAVVgpttGhwKmqj7k1hq04ZDM
 naahJ7R6ywT1SVhthfeouusjVYDHzYA1RBhLEoh2BTxANKrgso2LKPVh+ISWX0wkhZRIm
 NDXIxEZieecY7z4AuZwYc8jof2i4tmGIQSkESHmvd9OefFqdDIf8+kC9lg0BSfAkeIJ0F
 YKSpVI27RZdZ+stBBbuFJQLpWR5l+x2JnxOp94NtJCmOV3N/5sQdQri8LIBlcmi57Jk7j
 /hwbZ17Piz1YMY9iyLKCzG8ACjaVZN7bzS6KVkv9xgcvUL2iecEoVteSJlve1iT4fDw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b="L/XfIHES"; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=cddb=ig=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=L/XfIHES
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B557B60AC5
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 22:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1792104158;
 bh=xUSw+culf9GwuBi/izwFqJZUVXfab3Qa1laif3u7gGA=;
 b=L/XfIHES9IVl+nA+cdsdiykIyJIlwko4aumlRnEV5apPlurXM4W+pPUW+QG89G0ZaByEp1ac7
 y1CY4KylEzxt0Az0T5sVGaAKddpRiQdvStDBw/pKIMEjN7M18AZRdaaNUCG2QaoOXCSwRNYR585
 YfyrEnNCHuYPC/U1W4wHYna2fels1HAf/c+h7pKsBMJJE6sY9kIxnK5p7pGY95dOlMOa+4H8jB6
 2yq3ZhdIIi9cNMAQGrlMuFlKsdCarUQAP47olV9D/BkYAyS1ngzVW4wvk2jCi9977lMsIXHOdBo
 TINyecUfwynKtAPtswmfszT9S5S06atpPGOvY1uOAImA==
X-Forward-Email-ID: 6ad156d532553382725eab04
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/5] rockchip: Always init clocks in SPL build for RK35xx
Date: Thu, 15 Oct 2026 22:42:14 +0000
Message-ID: <20261015224222.1582607-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
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

The RK35xx clock drivers typically initialize a few clocks when probed, 
with some clocks only in SPL. However, the clock driver is only probed
on demand, so this initialization is fully skipped when there is no SPL
consumer requests a clock, e.g. when booting from RAM/USB.

Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
of boot device") all boot devices where typically probed, with a side
effect that clock driver likely also where probed, prior to the SPL
boot_from_devices() call.

This series flag RK35xx clock drivers to be probed after bind in SPL to
help ensure a deterministic probe and clock initialization behavior
prior to booting from devices.

This should help restore old behavior, e.g. that SPLL is initialized on
RK3588 and CPU core rate is initialized on RK3576 when booting from
RAM/USB.

The RK3506 clock driver is initializing a few clocks in bind() ops so
it is not affected, or rather it worked around similar issue for USB/RAM
boot using a slightly different approach.

The series may possibly depend on the series "rockchip: Miscellaneous
RK35xx clock fixes" [1] for a clean apply.

Changes in v3:
- Add an optional patch to delay ungate of PCIE30PHY_REF clocks
- Collect r-b tags

Changes in v2:
- Update cover letter and commit messages
- Collect r-b and t-b tags

[1] https://patch.msgid.link/20261011222930.1085075-1-jonas@kwiboo.se/

Jonas Karlman (5):
  clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks when PCI is enabled
  clk: rockchip: rk3568: Always initialize clocks in SPL
  clk: rockchip: rk3588: Always initialize clocks in SPL
  clk: rockchip: rk3576: Always initialize clocks in SPL
  clk: rockchip: rk3528: Always initialize clocks in SPL

 drivers/clk/rockchip/clk_rk3528.c |  4 ++++
 drivers/clk/rockchip/clk_rk3568.c | 19 +++++++++++++++----
 drivers/clk/rockchip/clk_rk3576.c |  4 ++++
 drivers/clk/rockchip/clk_rk3588.c | 14 ++++++++++++++
 4 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.55.0

