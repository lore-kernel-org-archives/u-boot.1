Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D806CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 11:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DC9E405AC;
	Mon, 12 Oct 2026 11:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-Jg3i_rRhfx; Mon, 12 Oct 2026 11:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4A34440593
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791803780;
	b=fXH3je1H+TI/rsszRgzx5m46X/p+5RFC8jROkrJU4utwh9ttB2T6oWeM+VZ++HSM5r91
	 UN76iL1O0sYCAgCDSJqH2MlWpQqVW9zHD1xEyzjBkAxfQJurZI70vNlRiMCoJr5MSupXO
	 RRIuKdE3ESwfy0O+hd6d8dv43/AW2pB8jwbntM9kp9J9dlmTRtHDvIh5TU7HsJ9/n6GMj
	 kEx43BXeCOli+c1kEG/UCB+TpzHsCQCJ1TSFjPvQNwQAuyiQNI2gk2OCAaPX9OyMwZyfw
	 pnIu5L34E8Wt9gt8q2854UYRUJfkuQd0I4U+2+BDQKSeu9VPfeq2xbHJT7suNohdsqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791803780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Kb3Hab31bpzDgPW/RHbjG6IL/FLCq+RBGcpMGHDy2RA=;
	b=Bk67nlVqswSoEugRI5jMP0YqFujScCuLhkbhDbV0lS4yYlws/uZHOtv9UW4P9JCmxSKk
	 qvkyPtO8HWLu+eUmEaIJNv3NifoIChPT05jvuMJ1Xznd7hGL66zvadpK4thGkCZ45lggJ
	 KQLn4rJEj328p4BTvettMOUNcxbWkZWPBqiM/rydEVMfphAVczb0p+1hp01YEyWudXCzG
	 67rwq9oxr1vSFh+t7kIp4m/4hd8SD6N4HSWh1KApf+q18ch81g//iCwjFDpB5c9WIOGdk
	 FMLvM0PJOSuCQOF3jJInQKJ+Mj7rjDtTXSu/e44F5EDCTRGO2hrjpoj+EOoEC18LSEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791803780;
	bh=Kb3Hab31bpzDgPW/RHbjG6IL/FLCq+RBGcpMGHDy2RA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tvYCj+YDxDDtw+5uUnRmGc66dXS5uWLan7CQl87sTO8ujyOlpZZEFO4AkQMwwJ8i0
	 H7mIs/UcUWZeV37HbSMEKb2MJbBV0XfmIMZUl6KkTHDOZWOA5n4l7EUscsMRE2bDOU
	 wsddnntFns2r+n220ieqUrI1HclRDoU5F9q20fUArLwjRjnQ1o/FKneM0B/aHQDQ80
	 0C+Wkmn7UxaDyRtvEz8Cz4AtO5N6nJ/xLbwOmQh6+Grq/6zVSvCbvG6Dt/V6iIuI/d
	 fjTyxJkM06vLwPpoxcu3x7MqaGXikT3e6LS9b6TZ9d//lYwxIbtisT72ZOndNpZtB+
	 Qm/oeZmBBnl2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A34440593;
	Mon, 12 Oct 2026 11:16:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2609A9CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17CCE80CDC
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i55l4CQuP-8a for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 11:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5EFED80CBD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791803777;
 b=HFWy2z/uAMppJ3KUkGUmhkBp73BdEpWBKlavcleYGVwSjZUR3DMh3oEwqpXCOb5S+sL2
 Es8VIm3O9BFjMyEyHRRfRDH0zmrx+/sm/I6ccBDfm+JIqlZG+UybzQqU/nuWMJERX2IYb
 T7d4CCSm2NacchWR0GtApe6vyg2acMYNpXA++WtfssJH+OC6dfIgtUX6kwONZMGeFpZVe
 fuYE1eVOJPjkVXMlVSQWlcIx4PYU8H9HJ9rKf6YFjW4bL6ljkYnMf1nc3HiGfJIgd/oHM
 YXSYU7xnQpsco4G2AQR0VcPitOJUgyJO2rFGU34mvl1x2/V05nOOn2mjvgT8Xl7YVHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791803777;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=Kb3Hab31bpzDgPW/RHbjG6IL/FLCq+RBGcpMGHDy2RA=;
 b=XKqoAJNGafjtthcdi9r1liwp7eqOaLA8jOqp/4R1klVPJoJe0rIAWBIHmwjT6KtHNdFf
 VzEAondJ/1crKc1L+e8cPdJG8S6oeOcNapzjhSV5L9Ww9kXp5ENBkTDtfBBrZLhicRfGN
 xiCJwX8Wtl4FcOYLryz/+/TBLaGo5nav5Rbm8MHVKBVmxsDwrzxM3ytMA0KGvhYKQNkAn
 xYPqIA/SpchrJU7JVMIcm/zhqaPM2K3fqODhGwa20UNKJkBM+n5movjjJj5fCdmGbLNlg
 rouMHPr628fVhEQ5AFhHPqN6IrAf5Q4pp12DYRGFTFUIkx/DIdmV0zohL9hwP7MyNTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b="av+/5UCI"; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ecf=ic=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=av+/5UCI
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EFED80CBD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1791803774;
 bh=Kb3Hab31bpzDgPW/RHbjG6IL/FLCq+RBGcpMGHDy2RA=;
 b=av+/5UCIb0hdczYhkcI5SmVElH6TAyBt8AESTn4N3oOakmaSCJuJ63Leln+Y/CUjosifBPER5
 5VYGzpJ7b6gQ9m8i4/Nk46vbwEUgtkBxStZ+qcmZCOOkiCdrl/AhekJ6iYwmBnTTKlu4SLvH1xk
 AE0uW5FGP3Kck2FjwGR9D0hYe88Njl32xWMes2WLRGnkzreuEt9poy7V9OBl/GkJHJoe+yao4Je
 cbVzvM8CitQdff5kLURt5jGwQF1s6ENoxKkihSBkyUsTda8ZAauTQ/6DogBYDxfLSN3CqOINmZJ
 tfzgQXgw9HX1tiNoiAY+CwotvG6Dbar8/IfsDzsQKSnw==
X-Forward-Email-ID: 6accc17b003f837f7de8ee6a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/4] rockchip: Always init clocks in SPL build for RK35xx
Date: Mon, 12 Oct 2026 11:15:45 +0000
Message-ID: <20261012111552.1173161-1-jonas@kwiboo.se>
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

The RK35xx clock drivers typically initializes a few clocks when probed, 
with some clocks only in SPL. However, the clock driver is only probed
on demand, so this initialization is fully skipped when no SPL consumer
requests a clock, e.g. when booting from RAM/USB.

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

The series may possible depend on the series "rockchip: Miscellaneous
RK35xx clock fixes" [1] for a clean apply.

Changes in v2:
- Update cover letter and commit messages
- Collect r-b and t-b tags

[1] https://patch.msgid.link/20261011222930.1085075-1-jonas@kwiboo.se/

Jonas Karlman (4):
  clk: rockchip: rk3568: Always initialize clocks in SPL
  clk: rockchip: rk3588: Always initialize clocks in SPL
  clk: rockchip: rk3576: Always initialize clocks in SPL
  clk: rockchip: rk3528: Always initialize clocks in SPL

 drivers/clk/rockchip/clk_rk3528.c |  4 ++++
 drivers/clk/rockchip/clk_rk3568.c |  4 ++++
 drivers/clk/rockchip/clk_rk3576.c |  4 ++++
 drivers/clk/rockchip/clk_rk3588.c | 14 ++++++++++++++
 4 files changed, 26 insertions(+)

-- 
2.55.0

