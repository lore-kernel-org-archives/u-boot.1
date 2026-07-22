Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C59C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 19:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D699780FFE;
	Wed, 22 Jul 2026 19:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y40ntzmdTVIn; Wed, 22 Jul 2026 19:46:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0C4680FEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784749590;
	bh=f5VIaS6s3wdWDyudyel4WMcymf4llakcnq2NUP0BpQE=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=i268Zjmtxc7UQebnB6jwvLuH8CFh+bej1loS+RFWmy226PYP7SuJm974Zd2EtwCqD
	 yPOwORR0TIQLbyb0Djj9oIfMcWwlALCO7h/PRaacWEtL9mAJCI5OIzVY1gfHJtpzNX
	 d3NgfoFPhSPk/XTvqcNxCB4Rk1R2oNKGRisJjYa/47RaL5XeStro31moAyuwOZdMoa
	 Xcas2878WSnhmm8EUSUEe4PRzWf3nAGR7COtz0LXgYh6ut97F/snxbU28xJrAMtWbn
	 yVvzqduVjt70B2DDKVEtExkcUwLOyj4BS8fD9QnGw/uBItgkg1hE9moHjRUEMPGZo6
	 13tYBCtgICwqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0C4680FEF;
	Wed, 22 Jul 2026 19:46:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D682390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4306380FEF
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdfBnSwkjD4R for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 19:46:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+usb@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 73EAB80FB0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 73EAB80FB0
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73EAB80FB0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:27 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h54WN5R2yz8tZw;
 Wed, 22 Jul 2026 21:46:24 +0200 (CEST)
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PULL] u-boot-usb/main
Date: Wed, 22 Jul 2026 21:45:45 +0200
Message-ID: <20260722194611.54206-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a9805529ac94f67847a
X-MBO-RS-META: gsk63pdsukomn3f4qjp8n3tfqhxzanss
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784749584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f5VIaS6s3wdWDyudyel4WMcymf4llakcnq2NUP0BpQE=;
 b=p3CLYseWgkqalwVYNHa53bZdFe7s90KRkC76j6WvDYTD0fm4vb9x2gywZv0LqN42D6pTfa
 4r6PCqg21p6ObFW7+9Y1bEfnIf/Rxocj1/Pv+A7j0ja8y8mm1gxnbp0p3uMBrJtpT6FAeI
 OIhNkPrp51W9Fzaqazonbkg7PpfobdOhXMOfsTGDUHmboznv9rx52+QsqMG6JdsKhvh3TL
 cUcpGU/HGsfRTtIHzue00tFPTovdRU1I37J6fFHb3+F/pj8hI1jBbRS3SGHObbHrTlARmi
 ZGLDQRMy2y3VV/vzp086zy1eLODW6O54uH8UHoRUPeGS1nW/lHhl4HAOhPrzYA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784749582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f5VIaS6s3wdWDyudyel4WMcymf4llakcnq2NUP0BpQE=;
 b=nfCkhWmErMvgCqrEnFrEjaosc1bRrtcybeuBHEzVfBkdZWOT7ai1xbY7r9c3DjDFoxCqt5
 lb5Y5vhCRS3dfJN5wu+9wy9PkSLleU0P6RkFE4rAOZ1qB/Vh7ihScXV1iZVeEqKrS2liFi
 sjmOIfQX56pWjgpH/eYYca9g8hQ67Zhcri3RDpjspJDrBEtn4Qtz8RdjZMsp0x4aO8bYl0
 k/R9ysAl84ZJr8/YpZoO3b7cLWywGgEy1DiwBZGSvIg7/8ALXELc9DFTvO7GvRmTGOKIB1
 SnxbkgJnX/0ipJULl8nq+KFA1alH7eP3xtQLuSDNYhW0Tyt+aDhPady2cxWeTQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=p3CLYseW; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=nfCkhWmE
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+usb@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The following changes since commit 042e45e026c77227319a426940577856ffe62e7b:

  global: Switch from source.denx.de to git.u-boot-project.org (2026-07-20 11:13:21 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main

for you to fetch changes up to d8f9c5595a824f08bc712e999eed9cb456b25efe:

  usb: xhci-dwc3: Call xhci_deregister() before asserting reset (2026-07-21 05:19:06 +0200)

----------------------------------------------------------------
Boon Khai Ng (1):
      usb: xhci-dwc3: Call xhci_deregister() before asserting reset

 drivers/usb/host/xhci-dwc3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
