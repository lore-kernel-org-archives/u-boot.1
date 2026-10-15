Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D85ECC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 760B481231;
	Thu, 15 Oct 2026 14:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gwyNjfbnAihW; Thu, 15 Oct 2026 14:30:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7063811DA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074641;
	b=rR/eS20zKX6uejdpGkS3smLHnogla1vmlA+ZGNaOpnthS3wBtqsRfjOPSkr4FlJLYHvm
	 Qn8g3UyNepJjehy80yj9n6jvOBlJEIth4WCyXKfYFsKhE/J3u4Q7zChMKuHvqzZ/o5j1G
	 g5l+B8qUdyMwqrzsjyudrZsCQSmJXFvzGJ0Kk67DPC3mAQdH9lvGJYWF4XtB290MAF4kV
	 8orDA+6ma9DS6MPOXN1H6t7iFCTTRMitAZfqq9QpADSKYosCvgj41xj2tLoPcGZd8iJWj
	 RXzVuTiPqJOJkhZdF+KwB9W0Tsn9yi9y0oGwAjf57VU9H7HexOFXv1V0ixWwvJOC/Mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792074641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MNuicVuV8oBH+CASXSxeNape4RZrz0I0XpfVURWkhiI=;
	b=ZniKrfQwMDCJ652Y7XByVBm+yHuNg2IxWIuUbEencMS6mOL86KMBKBVI5LLbGb2gsoAH
	 lZkSq7almnRMWpFSq8QFjTFX+DcxR1xCPFOcqt4VmqzBkjGsC0XRKTlyeDQe0bfDh4JZE
	 EWh7bfs2Lgp8Rs8D2e6BrXyEnDW5sHTpe7+pq7AHzjqzNVmH9feG1TElFzlD/FZPagAP9
	 OFZl3W7xLvgVtYhDsRl1lRMp3zRuPe4aWxTPDWRlQa7OJICuxjQuOnQUT/AdgE50L0Sj5
	 J8CRvVQrBlhfkKZlh1fwfsQpMnuQIaM3LY4PqmJRdG6JINn/i1d7KfhgRDUexNKORzQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=fris.de;
	dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=LPDFjccM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792074641;
	bh=MNuicVuV8oBH+CASXSxeNape4RZrz0I0XpfVURWkhiI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pz98F4xDxSrEEMoN1yBD/3OBvpqxn3YppfLu01we5DHSW1/NyDYd2yJ9C3QaiW1zN
	 P86cO4MZo+TI9njBpyM4is78Fn9cFdWtIgbD7lWxe/yTK+V2ULr8BR0L1xkOMaWQKT
	 frMAKGW2f5mXSzp9+Ks6kI1cy57jhnlPfkVSGtct/51t85ZjLdzLKcHqOnSvsn5PVr
	 6zdAW/Ks5pzO9HYF66tZlzb9H+kKB5WhTc9nMXfqzVCrCql1bqGuNf+dFh7+9C3+Co
	 jtmPSJ48LqLy3SOZHvw80pUaGT9rTM++mILfwDy+MCiO6poKOHBjxuq7MoVWHaz6Zm
	 o6AHx9wYd2big==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7063811DA;
	Thu, 15 Oct 2026 14:30:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18EBCE4D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B478810E2
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tUm0K0H0odDO for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64723811D1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792074638;
 b=f2r+g9Wb0rxlY4HBGiQuwMoxI/w5FYYiVDgmviisVPRJB5/CdW/OcWAotcueYdi1ya6l
 t9R6RdIATnU7iRjblU6tmDCMbx/v38Fp0xmeGv1O3/QGZyYVSAas9zC6vbeXqbIOD5v41
 RNghv9lmgnUSkmeSY71HCZ3MtVga2HGsk8z1LN6Ul2yegnofJk0KJCqung35xMFYcmFcB
 D4yFbapQGZnXlm1F4LX7viqy11bc+Z9/hvFXJ1I/QA+s3+teJsTkwtUw5uHB5frj4BAQc
 J7An5hBA5TqTGLekEJNOMVAL09DCYUKG39+AeTPeqg3k9MNRf3xarZGxlhqLu0zTCgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074638;
 h=Received-SPF:From:DKIM-Signature:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=MNuicVuV8oBH+CASXSxeNape4RZrz0I0XpfVURWkhiI=;
 b=d3tBbp6dafybtHywq416i1H+nmbG4n3oIUYFIvhXY2xpcIds/F3d0YY9tBbV0+lM3stM
 fJrQSPFJIohTJpEgeVq8nMpOq5ZnHhqgg+Ojb0D7lgEBPxJsk324lj294pg2RAC7rtAnG
 aiNfn5WxhOifi0iQ0P1aH8j4Vqnx//UiaNCYcwrtwDpNh/gzIHKtusb/Ul8c1fyPg5qxy
 sha9BLCwcYfbZOyYi/DDZ21imkQLULxcXhYX/5JQdY61gS2ASY1Ba+OVj8/l9JzFuUgCc
 lIbrThhSZy+eQ3PPeImyq1YuJZjEXkUUCqr/KsvbW9Qq186bfSt0YIZ1qmIA1MpD1vg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=LPDFjccM; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=LPDFjccM
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64723811D1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:30:36 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1792074318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MNuicVuV8oBH+CASXSxeNape4RZrz0I0XpfVURWkhiI=;
 b=LPDFjccM08cA8HrXJLi5nJEUR+AP6w5PeUTYfoJuzTW7O3o+Tm8//VEfPabMLfF+MxU93C
 EBQnF7ev7iJzlB4Ub41xeNx7V1JyP0XMSbyfxUaeBMPdoeSIKf/hz2tz0UG9iDOCEPrr+6
 NJSpLZCpMqiWk5pAfYs4pKKi6wEzIvrNKXKEhRsjf18fIRuTAWQFljLXQZfQUZkV90ZWgl
 MFELy37fYdZ7IN8vAp9QdTDl8vMvj9WmR0WTWClnu+5uzpgVNK7Pu4uBZbsTYP+h9Znprh
 x0UX/lsJWH9LITjGaEGLEJRZ4tKv0WNXLW8jmhiS06Rlf/S2RDT0n7ScToPp6Q==
Subject: [PATCH 0/3] ddr: imx: Fix repeating ddr_init() on i.MX8MM/MN/MP
Date: Thu, 15 Oct 2026 16:24:46 +0200
Message-Id: <20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBAF0KuUWTvQFCPBq4iLmPzoCIkySUuh9
 O5GXb7N26hCBZXOw0aKRaq8Soc5DBQevtzBErtpGqeTGY3lBN9mBWcvhSWvLnOMygop0thFc7Q
 JyQUbqR9vRZL191+uf9f59kRo35T2/QN2dm0xgQAAAA==
X-Change-ID: 20261015-feature-main-imx8m-ddr-reinit-8d145fef8c5d
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=GssyV8cJwlII794vEja06Bb//u2uS8RnBUFtSAQRFDU=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevCI5vG3CWaa9Objnrn+Ta8cf1uuPuoT4wuk8rZiwq3y
 7jfbPnUUcrCIMbFICumyCLFb/Ha1izWR/5YdRTMHFYmkCEMXJwCMJHigwz/87Xbdyrrlp6pYuNO
 YfdfNDMmQc3BJGbmCtZEtYodgn9DGBl6fkjcPH4u9UZEdItq7dHl8+97vBf0OHNpSvDlS8v+X/D
 jAQA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
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

Some boards probe their DDR configuration by calling ddr_init() several
times with different timings until one of them works, e.g. the Kontron
SL i.MX8MM and OSM-S i.MX8MP. This only works reliably as long as the
previous training run failed. If it succeeded, the DDRMIX is left in a
state that the power up procedure in ddr_init() doesn't expect: the DDRC
is in normal operating mode and the PHY keeps the results of the last
training run. The next ddr_init() then reports success, but the DRAM is
not functional. Depending on the SoC, accesses either fail or freeze the
system.

The OSM-S i.MX8MP board code contains a workaround for this that was
found by trial and error: a short additional size check before the
second ddr_init() call. It doesn't fix the root cause, and other boards
run into the same problem as soon as their probing tries a configuration
that trains successfully on the wrong DDR. This happens for example when
adding a 4GB single rank configuration to the SL i.MX8MM probing, which
also trains successfully on the 1GB variant.

This series fixes the issue by bringing the DDRMIX back to its power-on
state before ddr_init() is repeated. The DRAM traffic is stopped, the
DDRMIX resets are asserted and the DDRMIX power domain is power cycled
through the GPC. Asserting the resets alone is not sufficient. The
power down sequence follows dram_enter_retention() in TF-A.

Patch 1 fixes the GPC registers used by the existing power up procedure
on i.MX8MP, which uses a different GPC layout than the other i.MX8M
SoCs. This is a prerequisite for powering up the DDRMIX again after it
has been turned off.

Patch 2 adds the DDRMIX reset for i.MX8MM, i.MX8MN and i.MX8MP. The
i.MX8MQ has a second DDR domain and is left unchanged.

Patch 3 removes the now obsolete workaround from the OSM-S i.MX8MP board
code.

Tested on a Kontron OSM-S i.MX8MP with 4GB LPDDR4, which first trains
the 8GB configuration successfully and then repeats ddr_init() with the
4GB configuration. Without this series and without the workaround the
board freezes, with this series the 4GB are detected and pass a memory
test above the 4GB boundary.

Also tested on a Kontron SL i.MX8MM with 1GB LPDDR4 to make sure the DDR
probing there keeps working.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Frieder Schrempf (3):
      ddr: imx: Use the correct GPC registers for the i.MX8MP DDRMIX
      ddr: imx: Recreate the power-on state before repeating ddr_init()
      imx: kontron-osm-s-mx8mp: Remove DDR reinit workaround

 arch/arm/include/asm/arch-imx8m/imx-regs.h |  10 ++
 board/kontron/osm-s-mx8mp/spl.c            |  14 ---
 drivers/ddr/imx/imx8m/ddr_init.c           | 189 ++++++++++++++++++++++++++++-
 3 files changed, 197 insertions(+), 16 deletions(-)
---
base-commit: 65a7532545336e4b73e049a69436e255da7df961
change-id: 20261015-feature-main-imx8m-ddr-reinit-8d145fef8c5d

Best regards,
--  
Frieder Schrempf <frieder.schrempf@kontron.de>

