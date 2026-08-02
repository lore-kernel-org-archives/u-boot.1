Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB059C55174
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 21:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A57F405E9;
	Sun,  2 Aug 2026 21:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B7wd8Clt7xpL; Sun,  2 Aug 2026 21:45:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52E6C405E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785707133;
	bh=NLc8IM97MEwiv8v37K9p7+LWcMsSkJQnyhKUK5NY2nE=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=dNkXdeOQ4E7Yz7HSRCO51uIMwuVa1sWHImhn9PIcMLdqIFodMyXMr8emOGmC+SN+u
	 4g+Y8CteXxjsTjR4Ew1heyx1Du5lNuwaaoqxO6E2MHt2ssqLZ0uwR8/V2NYzLZXGWo
	 Rafk36H2aXp+yd/UyyREbyCrGmvxVZAD3MFwr2c3NdSZXEjTpdd4LzVzAbcQj5njhc
	 F1h5ockLXyLQaoGTICSELnQeyJJPCmZZimvS+PmodXucAtuWLU/Lqbld/Wv1c7vLgC
	 oNOQvlEFwDeS1YUOfCQHYLfNvkOe6901e+59S6mxII8lw5dGkTbsnGynnp1Cm0wTWO
	 0CIHOI3WtYxgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52E6C405E5;
	Sun,  2 Aug 2026 21:45:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 75B6626C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66F38400B4
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J0UilMwmzvNl for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 21:45:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+usb@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 613A24006F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 613A24006F
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 613A24006F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:45:31 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hCtdj0KPTz8v0Z;
 Sun, 02 Aug 2026 23:45:29 +0200 (CEST)
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Carlo Caione <ccaione@baylibre.com>
Subject: [PULL] u-boot-usb/main
Date: Sun,  2 Aug 2026 23:44:40 +0200
Message-ID: <20260802214510.158272-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 93b33b4142cb938a5c0
X-MBO-RS-META: uw47g8jopmk8h3ucxf9agenicmjuane3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785707129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NLc8IM97MEwiv8v37K9p7+LWcMsSkJQnyhKUK5NY2nE=;
 b=X33CrAnMU1ic2q9SgA8pOwQ6L8A7dbE18c/dsP8XVLWkZl29oE0Wo5HZJyTkbug/tqZ6Yg
 4gOeSFudi9nJsUoFw5A3rWQLhtn0X6zLFNXBxJy3Dbzqb8KrxNX7srgKRVxVGnPPUxiq/o
 8zg+thYLa6DgBUqxdy6MuDMbo+HgPRWw3/+cg6Lzu+0jie5+rbFiDJVIOvKDAKBBVtuno2
 TuaJ5ptxUBDjiab/5Rooq550wGB0OMsnt3Sl/N7dqRBrKwtE7+UEqun2Tyyoy4AlBSI4Ku
 PDQh1OVoCqKkOx5wOao6aWrhuf82pw60CjDj70MRQwMeDh/33yAoWvprNSeogQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785707126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NLc8IM97MEwiv8v37K9p7+LWcMsSkJQnyhKUK5NY2nE=;
 b=jvJnLO7wj06tTKHJdBCVo7saqsl/MG5/7FJKWHv9/72mrOAN/YKCDqtmEcmXwIR7LyQ1d1
 hujo0RjXuRH+/i0iBNvQCXvUUPdMgrlIv1ExF82IuTnYLamJV5++TCQTjSu2WsrTZNrtLk
 d03ZaOlzGZ2x7WmH5vbVAKkoZ+gvH4c8m4yBzHPng+NDBUlk8IzRbQqB8dQEMRWcK6hN+8
 bnp1dVTThUbbf/xPUY4Rbv7AWviIRxGQJONaAdtVRHWeqQUR1Pni+P2mkLw/MOUSZsA63D
 MpqsysKmswYuP/3JdM+WeuDfZywXAwCG6IKGbAKubwx4yU6c87BXpf9a+xbmiw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=X33CrAnM; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jvJnLO7w
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

Singular Cadence controller bugfix.

The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:

  Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main

for you to fetch changes up to 9879c40f6d010f7d019dcbf8b76d5642e40567c4:

  usb: mtu3: wait for TX FIFO to drain before disconnect (2026-08-02 22:13:19 +0200)

----------------------------------------------------------------
Carlo Caione (1):
      usb: mtu3: wait for TX FIFO to drain before disconnect

 drivers/usb/mtu3/mtu3.h        |  2 +-
 drivers/usb/mtu3/mtu3_core.c   | 42 +++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/mtu3/mtu3_gadget.c |  5 +++--
 3 files changed, 45 insertions(+), 4 deletions(-)
