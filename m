Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3098CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 16:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 801D280E7B;
	Mon, 28 Sep 2026 16:29:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UPMxb4u6J1Kc; Mon, 28 Sep 2026 16:29:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B8FD580E84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790612958;
	b=bSEicwkaTnnCFiykre40PqFevpJB86l0RJpt77GThGyEKoVtsnI0mciYX6k7m4qmpduJ
	 MGCCqaPrVoDihIfntNbRsrWetBlHD/rDHYJGEegpYQlViceVqzDxCUgJcKIqo35I4F64H
	 5YFhGc1vldDl1/pIrcIoSPraFtL622GjSQzIpnxfIq28XjVzbZ/wobap3ZX0zEb6ghAtG
	 lTIhb8L8JebwVAz3sg/0qXgbf1+auNHUb5zAtKMLoBORCXU7PFA8UTgDmyyF2Z6ecmcp3
	 Xl+VJSwh5+ogxd/448ZTTo3UqeHR+qPvHDBQXl0cBwdlnAinfn5Sdo/d8PxnxzT62aA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790612958;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x8hiItQy/lSh9x0fC0v00F3zJ2xPBR6YCZujyYB7Lmo=;
	b=ZYXiDoaBvjzG1Aa2djfkvoFjLjfDRvMGTGS+cb93e7RO/1hg9vgxCoBGWpCHD9RokA9u
	 5uh4ha5M2wXaWjydEg9rIfnM96Y2qg8ZiQe6VUOqwKRzknLvJxHeMLc/cykOWXKMx8iR3
	 0kd3Jhnh73WmgP9xOxYdljSm5I5KNk+fQLaJ1vb/J9W/jsYZI7oSLcgIFZtEmz+M+QlOx
	 jFY6eL2MY2JyKJQPAmE0L6x8/WjqwgT8aMErdbkaCIH4fxautalXPGn9QbYdyXcPNcDk6
	 r7/t/7ruGXHlongWz1B/lDqEwTTrm4QxGb5+QAEbojRvSOpED1erQ0sHRMVKjWOr/cw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790612958;
	bh=x8hiItQy/lSh9x0fC0v00F3zJ2xPBR6YCZujyYB7Lmo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QE441vUNAQI4UJjE/rdKpxhTPlQjMVKZU8lMyTmuEh2hMySi2j3E+MV7/mZ/wPHrq
	 wwey/60x3bpg/TyEAxStwfRzswM+nMY+hL5PbBpn0/XTX0CsqD1QkslsG1I5VY1ssB
	 Oe5b++PE4/sr0HKEJ1RRs29qndkpHqMhIrXOFCsLo7xCF+4vQZm/WU6EYU4rlti3Cc
	 2bSPputPdRo3KZN1FirDZfr70qw0TZticPobj+FEdXWvZVFR7vmfLvL0iLwqDGzN5f
	 CosM90zHXEVN25LAo8oDIVSpkEp7ZUXfPkuBcdf5+CW/HI8nDIlh+Ir3+d2Wzr9740
	 eE6ewWmoM4Svg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8FD580E84;
	Mon, 28 Sep 2026 16:29:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BBD63D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D58F406AC
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2D2ZR_Aj5UqV for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 16:29:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D71AA406A7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790612956;
 b=c5jw5tv01R/vj3DKHvecGAjb/CbaebHM+ayI+NevI7URq+0kZUTk0bT/Mzqo4shstoaG
 R/T+h9ypz4f6hr8uQE6TtQ/anAU0UZSJ7YNaMJ3ljA27PojfHEM20Q/vLwR9EZ3/4Buhq
 7ztrKKxTowjRojUAwT8RbM0a5AJ+bguMTqjHszFmH/LTuYlan4b1GDoCL/x+TYOBTUmnm
 0uI3JRrUjy0qrAxJnme+Rb0O/nly+UN57H/t8c1/+sb2v1NEhg4xlNdXXnYYnF8pB+Fwb
 ACXTInSKNAo2Hcd3VEEc21sBIO2InkIpDsS8QXbCOZqZVsYu6TAaFRHsKtaceFAYqFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790612956;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=x8hiItQy/lSh9x0fC0v00F3zJ2xPBR6YCZujyYB7Lmo=;
 b=Ot0VA9iOc5HYt2aAUt3SHiuRuUELsduR5vMRwwSmA2rE2DhnJ7bkrzeFO1jlpUCThsAl
 xCfclOr2h1tP2vjJieD1cqYljfE1Yp6N+mCQVHBBhXLArNIaKEvwUacmBvVCO7E2ugjET
 FoN+1cS1Tr67rhai5oktDySFK4RnUviG/IttipCVlGb4y2aZUBTMpPKlnU7Fw+CHwjoHU
 CEjwzKvBv+U4MH41uN/vTf3BdmdOb9r7DiSU06XfY03vSYPmSjcLFsF7PC59Q6PEhGPBv
 zkOxn/KWv+6qnET6baBhdefex5Il2O/eo1R0EP4bLUORzJiq8wOLtNSPpTxNogkvg7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=gEXMlyMk; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=gEXMlyMk
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D71AA406A7
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id C0BB5B00576;
 Mon, 28 Sep 2026 18:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790612953;
 bh=tdvxleiPXPGG0pLTNOphf8YJ6iechdfQ1XAnAr7vKSA=;
 h=From:To:Cc:Subject:Date:From;
 b=gEXMlyMkYOVfMRBNBxJL8RkOZA5UKE8XDVbi185pageiDI+3adkK1aMIgbMuf81qs
 UTgBTAa5fUIHaBfQd+ZiwlMpJWJL8PEzo7pPFnb9l5I4PkwcB97wV31YctLNkdKg49
 5nuAaVZWI2FYLjrB44SWQwv9LQiRYrfOMK3av11LeY+IzXZ2LwvbIsDYpmGMF+Ubjb
 Y0UkEQ4XhyQdcBuaqjH/ObrC7En+UjlOOszH2eEgY1H08EK5LMJBazlLX2TbAxvMLa
 wix2L0n+KCP758oVLp0CMHa0z0PoJm/LZsLl71mcuQ3S+6Jgi9yEWbexFedhrBMkyR
 wZ21t+Ox6t/3w==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 0/4] pmbus: read back the VOUT_COMMAND setpoint,
 fix the nbxv3 VID handoff
Date: Mon, 28 Sep 2026 18:29:00 +0200
Message-ID: <20260928162904.1143614-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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


On nbxv3 the VID handoff compared READ_VOUT with the fused core
voltage and raised VOUT_COMMAND by the difference. READ_VOUT sits
below the setpoint by the load line (droop) the MPQ8646 applies from
its NVM, so a module fused 0x14 (850 mV) got 875.8 mV: the core ran
above its fused voltage.

The handoff has to compare and verify the setpoint instead. PMBus
exposes it as VOUT_COMMAND, which regulator_get_value() does not
return:

- patch 1 makes the exported PMBus regulator helpers check that the
  device is a PMBus regulator
- patch 2 adds pmbus_regulator_read_vout_command()
- patch 3 tests it on sandbox, the patch 1 check included
- patch 4 makes the nbxv3 handoff write the fused table value as is
  and verify it through VOUT_COMMAND.


Vincent Jardin (4):
  power: regulator: pmbus: check the device in the exported helpers
  power: regulator: pmbus: read back the VOUT_COMMAND setpoint
  test: dm: pmbus: test pmbus_regulator_read_vout_command()
  board: nbxv3: VID handoff writes table value, no droop compensation

 board/nxp/lx2160a/nbxv3/vid_handoff.c  | 77 ++++++++++----------------
 drivers/power/regulator/pmbus_helper.c | 64 +++++++++++++++++----
 include/pmbus.h                        | 14 +++++
 test/dm/pmbus.c                        | 41 ++++++++++++++
 4 files changed, 137 insertions(+), 59 deletions(-)

---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
branch: for-upstream/pmbus-vout-command-v1

-- 
2.43.0

