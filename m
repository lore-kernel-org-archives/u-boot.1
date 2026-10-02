Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064A4CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2175813DC;
	Fri,  2 Oct 2026 21:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id idlogO3d9VQW; Fri,  2 Oct 2026 21:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1431D813BD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976831;
	b=e11BISqAVLfCzsxLr8ssy/rppoA4EE/4E2ICDVY6ixk6i5VZky4sIXxBbrvfzQ94RpD1
	 T6VYCpYloHX1SdLjvxLLJ05cCYy7GNZvUlDOl4cej9MakXZDaswjN5Jfj6sBB6n5ullKC
	 75QbAzIHkLbGbFRA/ka7XrSVXABElcEu4yI3oKULFVRuOf0A47+RccZnsITV4/YiOpqD5
	 Bm2pL1ahHVsiqrugRZy+KzG5jX4RXEpbtFIm5oC+r09EzvX2TgtpYgAjGpVyWeloGgSRX
	 fJlCSuaEmTIT+3AwL7CjOR9JJRp3M4F4gbe5lO2h4J+o0RdGKvzTGT9MI0d43KJoNAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4eW/Fzrzh36AMPLdivggoi0NeFvh4Q6EMfVH6BKG9NU=;
	b=eXRUVAysvT8V4xvNvLUnZDzSO1TbmBztk2luz/xt59beyfN255RJdF2+t+l7BfGMxyWn
	 dB3/FWAOSO3xoq1rB7MiZqG15/+lh8zxnU1I8WHTWXFT1vqR6Ne6zbPndozYDZJoAT/qW
	 qXAuXgSNRE5edaKqPlU0wZIuozx0O8hfC9qxFWSqniV0mY94YvPyhlXu8IziyB7xlov48
	 DbfosC1OnIi5vG2coYMSDu2wh2YQUCbx9zb+84fZ2KObEaOEYTmzcmx3CczCFF9dgZF72
	 yrnkVWTu1jxjyV95iYg7hvO9jvgey0n3P8q42Vc+N/F0YQwXAjXpbZEyNsATiqilrnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976831;
	bh=4eW/Fzrzh36AMPLdivggoi0NeFvh4Q6EMfVH6BKG9NU=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qSyfVzaYxgZ2nPtnBB7JtV9vbNldJpaORTmbQKzT1oriCnc+IW/wG9wz3eNQ1ecgp
	 eFvXzz/N4QD0eGaBL1kvQ87XIiNGY+nJ6Tyeag6tTxWeb38i2WnxpeeWcBsm6j3vJS
	 1nTwy75AazDs2rFTA6bQ3Z8Ee37Rki+mEKqD0UnDSBBbp77mx3cpQO8sINthh2ZRxS
	 8hvqnoxmAi5aYlUL5nIZFp7CM52IW0vri/IhUPPtSsLVb5X5BoEZtStPMMeQI6gIyT
	 82Tal1QqSurG1iit8XWVZUZu2LjUI/+VlZsBWErXFLfHlmATtQe5JMYVIUHpuxrMSx
	 i+hjs4uXfIuNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1431D813BD;
	Fri,  2 Oct 2026 21:33:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 453D134D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36FC640590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rIRrlWTjw1XM for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:33:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E19E040585
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976785;
 b=YI4Mzy8ecw41wv0BoeOqXSz5dvIEEX8NOHPnYyKgmUeso7TKlIt8NyKSIRFRvGkKyehu
 xcufYakeBObAujXePADsrgqyKvFMvdusb6Fsz5P4BwAw6k36ij09aHZHAYCaNYe9pFx1o
 vs6UF5FV2XIxBZWtIMULrNJvhrDA/CHg/B4BhQD/ZBzR1S8I3hLaLvYPoR+k86zRbLaco
 bneoOd3/Yd77UuBML5+pJ/+W9AIAj6Fj4YdNVfy9CBJPqmG3thytGZKVTz+O2/Abugoyb
 b91CuFumCeH43w+FTYJWBRho6ARW7Rba+wtohjTYr+UQyhzSKrZsPSSCLXhRqsNse5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976785;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=4eW/Fzrzh36AMPLdivggoi0NeFvh4Q6EMfVH6BKG9NU=;
 b=HCki1dW+wi6s+EF1J/a5MTHGVKJ5n/PykICrGa69QZRlJpUld5MAY3TIspnhcIkPyW/B
 EibNdzjtpXrBo3wzBs1j3Jpm7I4w/0JZR9j3+/k2OBVXV5rLFBCmPokJRvvGR90D9OveE
 JZJ3Q5CtUFLksxxiJz3s5+fghUb0u9wq7y0VY2bQcBa4dmtRa9Ele5sTtAd4K63uVJbuJ
 qPex82OMpna21AokiVtKWKeluTHL3AY9wNaftXY4aWimqY+n3sD6sVvjhUDVy0ObkDnXZ
 xprk877su+PIzIvfV4uSkaA7JSPDqDNEVe8ZJ8hyVEuv7yXgDMUQHRM3+iv1O5cWqKQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=Bw5ATOBf; 
 arc=none smtp.remote-ip=185.70.43.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.16;
 helo=mail-4316.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=Bw5ATOBf
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E19E040585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976782; x=1791235982;
 bh=4eW/Fzrzh36AMPLdivggoi0NeFvh4Q6EMfVH6BKG9NU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Bw5ATOBfQoEzIcWYjHkTFkh5+JTGP93mN5XZsoT2PCEK7auJqUIhcDWUUlYe2a9rQ
 mhJQ3I8zhegE/Pfy9+Hy6VstJ/SMuHUSfaO8k/gXA2KNzOj4wrhI63kBEk4W75cDZ2
 X3NuB88iJiwcvi05CvTZr6+u+v1X/chhmB5LlObJSKS/cpGf80+Woi23ggh+1c6NGo
 ZCPsu8jkAtNiW3yvTUZxbBAhovNmCYz4kxr22CaVZxN9N//8D7U2EEX5Bl1yoddxCl
 jjgnQ7jfkwpGmySqvMLPfGeSRNnNMX4Nr8umoYGgJ7uUs9D4o511lI4wOxL3c7Op4a
 AZQ+UEnd28A8w==
Date: Fri, 02 Oct 2026 21:32:56 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
Subject: [PATCH RESEND 0/2] spacemit: k1: SPL robustness for boards without a
 PMIC or SPI NOR
Message-ID: <cover.1790976767.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 27d65c509f4c63dac9049cb25b8f59463422e7e3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:33:50 +0000
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

Resent: the first posting's cover letter went out with the same
Message-ID as the cover letter of "pci: spacemit: fixes for the K1 PCIe
host driver", so this series threaded under that one. No changes.

Two small SPL changes for K1 boards that do not look like the BPI-F3
and MusePi Pro:

1. pmic_init() and nor_early_init() panic when the device tree gives
   the SPL no PMIC or no SPI controller. A board that boots from eMMC or
   microSD with its rails already up (the OrangePi R2S and RV2) stops
   there. Log it and carry on.
2. Provide board_boot_order(): the device the BootROM booted from, as
   detected now, then the other MMC controller and SPI NOR, so an
   unexpected BootROM path still finds U-Boot.

Tested on an OrangePi RV2 booting from microSD (no SPI controller in
the SPL): "No SPI controller", then the SPL loads U-Boot from the card
through the detected MMC2. The fallback order was not exercised, since
the detection was right.

Dave Klotz (2):
  spacemit: k1: do not require a PMIC or an SPI controller in SPL
  spacemit: k1: fall back to the other boot devices in SPL

 board/spacemit/k1/spl.c | 48 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)


base-commit: a000f2af240eaa996cec92f8d44bad96fdf3f898
--=20
2.55.0


