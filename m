Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873C8E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AF680207;
	Tue, 10 Dec 2024 23:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Jzxes2lk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076FA8020D; Tue, 10 Dec 2024 23:24:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C4480202
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=db8b=TE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1733869429;
 bh=h4ebvxSHeH+LgSnhgQGBIkcSEbozdt5l8kxQSpdrpOY=;
 b=Jzxes2lk8+cCmnPMemJnyU5eF+EgDxzF4v37ORmSwmsqNEkCwJQ8R9Qq/KtJVTrSXsGWpE4y6
 UuoPsw+4V+67iJJu28PhF1879qaeLlZqRHuAqUZ3MOgATPawDzCdmwEw67qq1lgk4QuauZ5QkLH
 DO4P8roW+Jq1hFDTo5Jq2o4J6rRAsGqlRII0OUOFEwTj4+GkoBHx8aguIITlgAxruEt9Q5BipcL
 /YCJA/B2qjizQNXIzLd023qIOZpQPk+Jce8w3ufbIEwN84tsf2+l0EPyXY9YWx/sSNG6LH6Oi6j
 buJK4L0t7dUAabkr/aBS3D0wGV06OjCCyqKjFte5CcVg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: Add initial RK3582 support
Date: Tue, 10 Dec 2024 22:23:34 +0000
Message-ID: <20241210222341.3537543-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6758bf74b234f44256187c9d
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series add initial support for RK3582 support. The RK3582 is a
variant of the RK3588S with a few ip blocks disabled. What blocks are
disabled/non-working is indicated by the ip-state in OTP.

Compared to the vendor U-Boot variant, this mark cpu and gpu with
status=fail instead of removing nodes during DT fixup. Linux skip cpu
cores marked as failed staring from v5.17-rc1, however the GIC driver
will generate a harmless WARN_ON that safely can be ignored. A patch for
Linux will be sent to skip the WARN_ON for failed/disabled cpu cores.

This depends on the patch "rockchip: rk3588: Implement checkboard() to
print SoC variant" [1] for a clean apply.

[1] https://patchwork.ozlabs.org/patch/2009181/

Jonas Karlman (2):
  rockchip: Add initial RK3582 support
  rockchip: rk3588-generic: Enable support for RK3582

 arch/arm/mach-rockchip/rk3588/rk3588.c | 128 +++++++++++++++++++++++++
 configs/generic-rk3588_defconfig       |   1 +
 2 files changed, 129 insertions(+)

-- 
2.47.1

