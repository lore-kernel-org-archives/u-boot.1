Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45066C55196
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 18:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E558060648;
	Mon,  3 Aug 2026 18:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mg1gyR2hsC2c; Mon,  3 Aug 2026 18:48:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9252260698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785782935;
	bh=1CsJNSSzVs1loRdP4nO91e7klb/Ju+pDW5xQbrot0J8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WWDvCNjvnmvuSJYPbfMIq9eTrkIU/K/MNfk6w0B9AGIWpNk31qEWluVJA1w1jeEDq
	 iDIC9gb1LSQDFLRgdYJqgcWZ8ZZMetOSkA7+izxwIJ89UZzo+QQe7bFCcPcVt6iXp3
	 gqMS/rstROfw0Reld3obKT6/wguj2PSIjUD08faj7L0AkdB/9F0CqgyYrcZcEI6BI2
	 6wwXDpO6XrS+cptf5Q4AdzOIK1xn5wT7jYA7rpS1Tk+le9yp/WKTZxi75KP0bBNGnp
	 Y1XwqJ9JAbCQbAPJ7UYd7M3mfLbBX8KuqeoYkSHKj3znJ58DoepW2lIyul2pWZFfnb
	 rJL3nXnhVEfsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9252260698;
	Mon,  3 Aug 2026 18:48:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC14D2CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D57D360698
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:48:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5OqNc5CPFFn for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 18:48:52 +0000 (UTC)
X-Greylist: delayed 325 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 03 Aug 2026 18:48:51 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8ACC060648
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ACC060648
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eb25=f5=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8ACC060648
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 18:48:51 +0000 (UTC)
X-Forward-Email-ID: 6a70e1460b3ab441388a8940
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] rockchip: rk3576: Disable force_jtag by default
Date: Mon,  3 Aug 2026 18:43:11 +0000
Message-ID: <20260803184314.2240153-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785782930;
 bh=1CsJNSSzVs1loRdP4nO91e7klb/Ju+pDW5xQbrot0J8=;
 b=nWbF0OuJhsbE6WqoRFgTjWWg9EF5R32DZnt9/9QQBeA+BLX4+Tio3dTfiMVtqqrqNQFZrCjJ7
 I+4SUbGeNUseW9UUXioBEUSHahhTB+veczk7ME29AwI3/t8nrpQG0oUIb9vkn1SYucjnughN0kz
 135N+Jsd99BwUfUCW/ekqBhMghhArHXz+j1chjSZdCVbL64hDesrnO8LwEMI+gyLEXDWzorcCL5
 8Twfu+tH7YEqGXez0h5JaZkoTSZ4O7YdN9NJ9ETDbfVog+uK4MiV8EyRT19aJZxGJ1J/Tj/Toch
 wHHAzQ18JG4/EGBlVoyq5wRvYerPx/YQbaUT3GTVKQKw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=nWbF0OuJ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series import linux/hw_bitfield.h from Linux and disables the
force_jtag flag by default on RK3576.

Changes in v2:
- Import linux/hw_bitfield.h from Linux
- Define TOP_IOC_FORCE_JTAG and use FIELD_PREP_WM16
- Collect r-b tag

Jonas Karlman (2):
  include: linux: Import hw_bitfield.h from Linux v6.18
  rockchip: rk3576: Disable force_jtag by default

 arch/arm/mach-rockchip/rk3576/rk3576.c | 12 ++++-
 include/linux/hw_bitfield.h            | 61 ++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/hw_bitfield.h

-- 
2.54.0

