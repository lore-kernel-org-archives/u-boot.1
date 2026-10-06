Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9996CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 05:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82EF960652;
	Tue,  6 Oct 2026 05:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 31nnCPvtKpKu; Tue,  6 Oct 2026 05:34:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 290D460645
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791264861;
	b=j0Z+hdJz2StOAyY9mzRH/lTkz44YNE8xVBQx2lDC1uIad7A/fjv4uI+uVjLnekHjov9c
	 bNFt7OZd/Vc2MEenOGzkTSjbHxfp3QKhneOGtICsBEYEiUvo9Hi/qB4wJddh92g0edtvZ
	 Ys61ouDS4GzMn1xQE2Ax13ogNBI8qOZ4N2uLm59003fxx9qtzr/Be/lhXoNbG5G+1BA0R
	 Wozkpj2e9gE8XfJiNdcIRxR6wPZweFWDmK3qRyyIcJjO5MG15eHRRjQbpBp4Az9Vj0bPx
	 prHOqvYvTtWv+PT3ixMTUO6tzVZ22G2l8NLtvgxe73wP0H/c08XPzOmvSTS3R07GY3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791264861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iAGHeZnx/Hpk7lcvY6NwpmnCAU74Cwa00KwVqUDvBxY=;
	b=R+20JzmG8XXmvgnmDdaZCzsV9VVDmnHoh2cOmWbO6s3di+CjhVitXXA4/KDXG5kKh0K2
	 6KDyGJrdaQ1qM99mqvjnU1jg8HDDqmXuFG+seYMQ0gbUdv4lKwFk4FOALxAht5m0pmsj2
	 xNE9itiavii87kKj0QqIZOj2bOESdKElYW41LnO+hpxy15xRDzg/su7OCQkVKn4VFH5j+
	 FL7eJM9beCH28Z8ZWRQLsCd4BOTTE9O3TR4aj09ccyqJFMX6xm4Kjq/8mt6+l5S9maYr4
	 Ks+wOuH4cSshFUuhrWcv1ZfwIN/pS3pWXM+w1mh1Kb2TmO2kumPhzbleHd5Cfb53uZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791264861;
	bh=iAGHeZnx/Hpk7lcvY6NwpmnCAU74Cwa00KwVqUDvBxY=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0CRkX5LQr2QEvT8A64gUE6tzbSkJgKypoSosPhu23waHcMoen5rFkzfL1WRpChipP
	 bcZ5eLhspP94379w96rNndJ/cmn+bvC/LxNdXO61yHNNEpJwTaKo/fnRBfilgoU8Rq
	 VbFsOuLfR62wbodIZVSZuBQRqWU+cl9/cpnnw2LgOy5LdzMmiwPEgb1xq3A5pJ1tuG
	 E9C7NOd4aX4IHOJL3lXCqcXPsNTJ4VbFbbT5sldRvsS8NoHADgBRXk6QcQ55fDChoM
	 F231BXJOF3hsxf81BCPd0DV9cg/XUaAYttHKJgiQd+ntECv23PgTI8e+YVn53kpCBc
	 WbpPYLFXfjmbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 290D460645;
	Tue,  6 Oct 2026 05:34:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 53F8D34E
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45638400D6
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id luiozTDUyvER for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 04:28:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C1A124009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791260921;
 b=IkFoyfOUAy7ghAbnxumjbBPHPhlfotpU+fgxpxax1yv3UYMOVxEw7z5sxOZu1rrhcaau
 1xTNBCvBIGxC3KySRPWV7qAd32rs1mD2bKxq/GxVhuiNwWRv119Gbp3AK1hVJUsHLtpTb
 U72YX2SVzVNOmWT7goIAN3zsXnqNdIMZIDxFhDWj07DiexWP3vg82W15+zKzw9njrcETM
 WWc5AK3oZU4I1JgJd4xFPC1yTAZdlxw0pahBRNNdt9uxVgQOZtCSB6o9ILqXMPOL+5gVV
 ncttH3NniIX9UOmlqLfuGEW100xeDDPFUXeLG41LzS3ozlGrn3vbLyiGyf5CBWwsjGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791260921;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=iAGHeZnx/Hpk7lcvY6NwpmnCAU74Cwa00KwVqUDvBxY=;
 b=okfZddrdO6iu8ybw+HirwYw5t2PT215XlNbR2ZY6rZezeh3fV4gagA37sKSOP2niEQcJ
 iTpFp6uQuYasAspOtlWxC6yY7rvgr4ort8vW/AZOPyyUgj1L72kyPF4xx1RDcjwFCrmvl
 K6uhGWxWpxOV/MMR3lyDXxN1/gPl+zcoW1CY6zb2mAHfGznE50h27ROztTuvW9/BjrKeq
 qOIVP6ZQLSPYrXIADyXSLJ2MvTNw9jwsGnF6C86AVlWwAVWTXyka7T2UkFdc9AHPrxlrC
 IGOKZE62F34Z9uD/cj7MP1R2YVeyTVDm9sjx9rH6LY4p3slG9u/EBcTR5QBC6WU0m7w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=OvjC0V0L; 
 arc=none smtp.remote-ip=109.224.244.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.18;
 helo=mail-24418.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=OvjC0V0L
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1A124009D
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791260918; x=1791520118;
 bh=iAGHeZnx/Hpk7lcvY6NwpmnCAU74Cwa00KwVqUDvBxY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=OvjC0V0L6t9kfp7tDDcC37kZu7b+uh6sJcLpGTffHRbPnsi3QgyuGRacBLLsqK81q
 ghRaLN7iDaTBZ3ujeD2oOGZgZwWBNSIFg1z9C/zffSlM/fAzicHcJRhBq58ehzdAVM
 TUgL/ZbitVugFS9lvlabNKs2pLw1FuSDVQ/3QVrnznsfDM99370d/3jkW9UDNHkPmc
 OUMDpAoj2Hyd+DPDznWyaoBOhCPfONhsrZlGDVpNCSdYUZPmOM9dbYXLLnu3UMyA6h
 QwQ6BpsoHffxUb89QYKpCw2II4FSbyhm+7TuwUMZPN5WxoDib4VQ8bvl634FCo6r2w
 UK9NY0uodf5zA==
Date: Tue, 06 Oct 2026 04:28:31 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 0/2] usb: add K1 USB2 PHY and generic DWC3 support
Message-ID: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: ead022199fcf269146057f513111af1664825856
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This series adds USB host support for the SpacemiT K1: a driver for
the K1's USB 2.0 (UTMI) PHY, and a flat-node entry for the SoC's DWC3
controller in dwc3-generic, which already handles clocks, resets, PHYs
and the host child for other flat-node SoCs. No K1-specific glue is
needed. USB 3 additionally needs the posted combo PHY series [1].

The patches apply to next at bd2f5794 and to current next (ed869863).
dwc3-generic.c is not touched by the pending DWC3 resync [2], so they
apply there too; the test builds below carried that resync (v9).

Tested on the OrangePi R2S and RV2 on October 5 with next bd2f5794, the
posted K1 clock, MMC, PHY, PCIe and SPL fixes, the DWC3 resync v9 and
these two patches (plus local hub-scan logging and an xHCI stop-path
change that are under separate review and do not change enumeration):

- R2S: a USB 3.0 stick on the root port enumerates at 5 Gb/s. Each
  check is two 64 MiB raw reads into differently prefilled buffers,
  byte compare and SHA-256 against a FAT copy of the same data; the
  initial three pairs, then one pair after each of three 'usb reset'
  and after 'usb stop' / 'usb start', all passed at 5 Gb/s with no
  host-halt warning.
- RV2: the same stick behind a Genesys USB 3 hub; same checks, same
  results. In an earlier run the stick once failed to re-enumerate
  after the second and third 'usb reset'; that did not reproduce with
  hub scan logging enabled and is being looked at in the generic hub
  scan separately. It is not specific to these two patches.
- On both boards the FreeBSD EFI loader read from the stick selects its
  own partition unaided and boots the kernel on the stick with the
  board's native root (eMMC on R2S, NVMe on RV2).

Sandbox builds and the existing DWC3 flat-node users are unaffected.

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633775.h=
tml
[2] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633722.h=
tml

Dave Klotz (2):
  phy: spacemit: add K1 USB 2.0 PHY driver
  usb: dwc3: generic: add SpacemiT K1 support

 MAINTAINERS                        |   1 +
 drivers/phy/spacemit/Kconfig       |   9 ++
 drivers/phy/spacemit/Makefile      |   1 +
 drivers/phy/spacemit/phy-k1-usb2.c | 173 +++++++++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-generic.c    |  13 +--
 5 files changed, 191 insertions(+), 6 deletions(-)

