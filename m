Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C1ECA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 12:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE3AF607C8;
	Tue,  6 Oct 2026 12:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dy8t1dCMCeyI; Tue,  6 Oct 2026 12:33:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D5904607BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791290028;
	b=c5NXsH53hN8PJL9PFG+dlKBHTFr/xNexkYxL3U7VwayItT2enD9lK2LlVnq9rJZv7GLe
	 0360D0F7UC4udwiWhoVHz1IPCuGJ72HtEAwOtR6HUDJwfaSmidB0WwWdcZsyGleXE3bHw
	 QyzOExRh/4OY3dbXTLfJC+VtBMhrtFzMuGZThAWJ7SbOMhpKRoHnEggitS3m/8Wf+9Vxm
	 x/Tq8gSaY8dl8eTIdc8ipT6tJlJesdlKjl1xSV1M/NY1hVOMngEulQmCVvA7a3KfGPdkg
	 27Btr+61pyazO9YeFl6Nno/oYtp7jRLc0UujRG2ySmMs0xoiuKfq4EWx3pJ0HQgpjdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791290028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JIpivnpPkLwQvSSqR4JSzhCTYpE47Z8DVcGmZRM3bws=;
	b=fsmC0sd+6oFiOaMAEVwzq952vcEH6+oF6cg0vNs4w3JGnYuFrTr6boX18bUiCYrFhTW7
	 rhjubno9cxt9SccwoqJvO5kln8AuyFGt2OGq98NVOj7S/9zdUeYmKSwgIwTUag3gxB7TH
	 HPQlrvqTo1PcPNYqP4765nP96V//uG5U7MACAQ0bmEYmOyCB/H+MFjPHE+Rs649C0TlS1
	 GiNp5S3fJDafa74hGmA1VUH5zCsfWiBmtprPCSy2B6RjsWBUat/zgX4CIi8H3S3Ui1LED
	 DEK3GZHLp8dJnYqoumQJXa4AgFoPcxD9P9KoP5A/SFz2ih+wSfZTioLXsdPVEN94l5g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791290027;
	bh=JIpivnpPkLwQvSSqR4JSzhCTYpE47Z8DVcGmZRM3bws=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+08HkvJqKOMPIjDguMxQNsh3OfwoLNbqKrG9YA8I3LRSNdJx1KETH4dP0IYHW1GM
	 55l7Zzr7GXnEfwGdN9vSApsvQ3pTPfmzblgf1Xq6lC73l+gX8NHQhADVtj7k0CdnS0
	 38OrU6aXa02BPGLgeai0fGA4h/izNXqQuv6YeiFhoRCx5e+/xA0k8hQWygUkd9z9TP
	 4w5KejVg01T0JsxqOMF2mRpV01gz8MZPSjI4TpIFbSlNgAiOhIC/Oqv57WPPv7L4M/
	 xks1Q6x814ilf9bXL5ny7nDm4liZw1Y6ZxejW0+iFBcApSS2C5HYpmTtMsPmeuf/lJ
	 h3tjEDBpUjuiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5904607BD;
	Tue,  6 Oct 2026 12:33:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30FFC282
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E8B6405CB
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHEKFEIQmC8v for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 12:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 47A67405CD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791289921;
 b=eMwu/netoYt2gbndDogHJadMgYIM3ERDgEVjoBfh/5mSLRpQl0umXtfR/io73cmi2LF/
 ZM53vUC9qA7zdOs98Bjqx3ZFpOP+glEoxWv4p829Zg6rsZyCuD/KE3GGywgeNWn97RZ3h
 IxnyM3foAujgn9gvzGhrkffXc7vXhfoUcOg+4/856S+P9xRaS4rXa8Y3my0p5dAue1QtW
 k6eEIO1BHattVNx9LT0maUdsSq3ebPDK5pGTsUa5wxvCJXrqo8E2YPDBvASeQWh7gsaMf
 JcEIsx4pn03Yv/efCKIURcU59cpTGBFGDUGl/SDBRIdKITxGTFi0qHdpP6QGD2z1TDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791289921;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=JIpivnpPkLwQvSSqR4JSzhCTYpE47Z8DVcGmZRM3bws=;
 b=NbDj3Xb8vGnv+nT6gHR+H5+WfOX1NdwraTitjkauONvytb2XXGRyEZesvkGExxUuFuTm
 A7w7z0m1w1OFmTfdXBKhDVTZmttvon4jrYV+ZE6bjjBdmJBaJtz0YyVfwNJu34sPYDk4d
 G2ycnOiR+HJBpSffjau8NXHHiHdLQpM4a6ZmJtKby0e/CLfGC4AjE0YV9AG7OKY6E6cBQ
 p9i92L3ZCj+x62Li65B5VklKIZFF3/9skWFPJhblaW+Ph6oLcouFWZk1GYbbUMsMvMMFv
 wxKUkefQqFChone3LFUmsVp+rRvGHGx7AuNyciPi7lbEPBfY9hOOhETPW/HJvJ5bveQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=nptpQEFB; 
 arc=none smtp.remote-ip=109.224.244.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.123;
 helo=mail-244123.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=nptpQEFB
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch
 [109.224.244.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47A67405CD
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791289918; x=1791549118;
 bh=JIpivnpPkLwQvSSqR4JSzhCTYpE47Z8DVcGmZRM3bws=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=nptpQEFBawtjZcPtSw4dodRr1BhLWv/L5o6WDuzmpQwehyOV9FFBjk1UM1ur3yxUk
 brvssQF91w2qWkVHyqRdFsw0CvMKg41vtZW4MlvJyNPidCvqai/dBkU4BugpfUfz3J
 giFd75OBpnIgsfwGTWQq9KMgwC4G+Dlc81rAIomxu6BsObNsca4Kf7Me54PGNTXjwj
 CnR/73KvhoKUo7Xqjx828ow6IAZ1wRlg2XUYtHsQhsvcSCOjR30bJ40p8HTLFTGvJh
 fXLG7/zcRSBjt/aI4Wl3l3/1qkeAkNxnGGtP5kOXMDnJpRGnX2YTGkjgVUM8dNZBhV
 P4utTxAHTi56w==
Date: Tue, 06 Oct 2026 12:31:54 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH v2 0/2] usb: add K1 USB2 PHY and generic DWC3 support
Message-ID: <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
In-Reply-To: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: bf6b15b63c436c02e73802db95c95e238c57a985
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

The patches apply to next at bd2f5794 and to current next
(ed869863c7e2), after the posted combo PHY series [1].
They also apply with the pending DWC3 resync [2], which does not
change dwc3-generic.c. The existing DWC3 flat-node users keep their
original rk_ops entries.

[1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633775.h=
tml
[2] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/633722.h=
tml

A targeted RISC-V build on current next (ed869863c7e2), with the
posted combo PHY prerequisites and these two patches, compiles the K1
USB2 PHY and generic DWC3 objects without compiler warnings. The
configuration checks pass.

Complete R2S and RV2 firmware builds on current next (ed869863c7e2),
with the maintained K1 prerequisites and these two patches, also pass,
and the compiled generic DWC3 objects retain rk_ops.

With that firmware on both boards, seven 64 MiB raw/FAT read pairs
pass SHA-256 and byte comparison at 5 Gb/s, including reads after each
of three USB resets and after a stop/start cycle. Automatic USB EFI
selection and boot of the USB-loaded FreeBSD kernel with the board's
native root also pass. Cold-boot, full USB-root and sustained testing
remain open.

Changes in v2:
- Drop the rk_ops rename from patch 2/2, as requested by Marek Vasut.
  Add only the spacemit,k1-dwc3 compatible entry using the existing rk_ops.
- Patch 1/2 is unchanged.

Dave Klotz (2):
  phy: spacemit: add K1 USB 2.0 PHY driver
  usb: dwc3: generic: add SpacemiT K1 support

 MAINTAINERS                        |   1 +
 drivers/phy/spacemit/Kconfig        |   9 ++
 drivers/phy/spacemit/Makefile       |   1 +
 drivers/phy/spacemit/phy-k1-usb2.c  | 173 +++++++++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-generic.c     |   1 +
 5 files changed, 185 insertions(+)

