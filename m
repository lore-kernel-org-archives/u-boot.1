Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D11606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R3X0sGKI;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=2glxWoLX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C318E4061D;
	Tue, 27 Oct 2026 14:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mpmHLVwoLdrT; Tue, 27 Oct 2026 14:17:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2C9984063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793110637;
	b=BW0gYQ85EFQ2jEqLJ2e54jvAaUEKLQEvD7bGUTGfskJgcIquviuvt5HqPz4Xg9uVbcNu
	 K8PlCWNo4Rzs8JOd0iSmE7nAziEUaxxkkz+GVEvEIn526riQwETC1TsIip6KaOaHl5MYy
	 0klS716+g1EAAa6/S9ABrVmiWE7+oWrqnI5eLCpw4ivYLQYchKASSDhbwUyujuC7NhoKt
	 xx2DffdyFo6GtlSQf1+NrDLBHj2Y+8OOvbi1sQY5+LlPpf+Q95ZRx5/2UNSXEagqoaDiM
	 7P0Z5JCDQ+F7vRuq5P9IbHT5k2GLPdtzAlhgCY/mp8K7lRan5Qg4CX7Hx9FGUHZv/Qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793110637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hsM50ASdsisSfoNI/d+a4iFqFAHmoEg1htdrJ3G9oQI=;
	b=qkA6A3AQvCweBOH0KqjahrhYlf5MoA5vs4cq7DINTs/2e0cX+0Xe+FsD8AjpJTHjdgda
	 nYskU3KCaZzQc4WdQUq1EoNC8AfgyeaKyuWqRy9HyaPLhJKI2dq6lP+2nHPpQZ+MW2YCD
	 zOQU6I5l40k3zkwhZDj8zmGMgM+2FKvVwSYBvDYyq+Z74tym2meEfie9SBb1YGnzc0aPO
	 79wXEcLI2IPVwI2XH/8VVE7TLgQRUsNtG6X63CoauUVJWue6ie4qLO+C8ypuW8CGyA8Hn
	 cFx/A4n36iEtvfPVNlwI/Njsrw5GVXid3wnXIWxdL7bjNHdRl/GAmsSSWQyDIy9/2CA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793110637;
	bh=hsM50ASdsisSfoNI/d+a4iFqFAHmoEg1htdrJ3G9oQI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R3X0sGKICs/pgFbVc/Lsu8896mfZkI8cpag0WI8H+JBeOtz7Da4SVHHcQzN1Ax/Vx
	 ZOqm3CD5nmqb3BVxTKSvQ4A/yYHFIyXkP6xo8Fe26/m+0PRelVafa/voXlDAWabEOw
	 4NI9CdXOow4fmOWcb6HvimCHuFzG7FQE2Ca33K7W7pKbD0FtZKYvLjmUCw5Gi2vO36
	 f9XLcXgbcF29atQANcas1ydJuObxRf198P75SZaYpj2aEJaqXKHpBSMx2KtsV59l9m
	 AUTmSDr+Tw3lrVdeUBdA9egPfIsLGRJSh7rGdTcyMDrzAB9exWlHp+U2+AiCzW1V8Q
	 GPf4lGu2y40Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C9984063A;
	Tue, 27 Oct 2026 14:17:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18606A32
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F30BF6078A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0KMtiSETqitK for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 341D160768
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793110630;
 b=fd2gor6IRXigqxMJyLJkXTdSb50keJe5j/Tj3eRB6xqOnVzC//Qx3UFtHTzGdK6hrkxa
 2htJhf+m6ycQHdPnSrZpZB7hCCfvQHfXZsvV0HndVAnQKwjRB6vw2YYxk59q9mOld01vU
 HNc+pg93EyfSFBOorSX5oqp6fZsB4Scm+c37pDunp49hiOSvDBVUnfEZSLbwFv8v6rwy+
 CeADtbaMZCzdnbj2g8/JKWr9l6ItEIxh4/YLMF+UH0wb3Z9QQWqIHHeVX3e0eY4/8hDtK
 61tU4esHyuTR7aG0XFWB35bwO8w+Y/Ghvrc1BdtVc9Hxv4Bjf4to9N4drwFM/vrICVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793110630;
 h=Received-SPF:From:DKIM-Signature:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=hsM50ASdsisSfoNI/d+a4iFqFAHmoEg1htdrJ3G9oQI=;
 b=QMMp8tQGLQLes/1xykrnIGM+vk8a2LI2OQCkI8jCKYc2m/uFnuHJBX2Wv9GgHEvLJ1/W
 h8GffPgOvXDUR5f18VkQGu6rdXL6l1cn+UAYHFC/v74cgoirLlDtA3HJ7VnEAWkD/DwoO
 2J4twJG5ArscdxwKlwTJMEmPkZa1ZXHr5LMNLlly3aOiL1tQkdYOa1nRP/yi4KeBiXdo6
 Jp1RLZrS0uBzepWRX2rS/aLIEo6xVlIQ6k7AA8l2ySXJKP9QraBcLpRMOIAWuMrIQZpug
 eTEDZxoSNA73H1PQQCOjFTp3K7x84Y2ZT/p8cqwQiSwT43VxWZ8CrJ+GPIb3XGX4Gxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=2glxWoLX; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=2glxWoLX
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 341D160768
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:09 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793110625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hsM50ASdsisSfoNI/d+a4iFqFAHmoEg1htdrJ3G9oQI=;
 b=2glxWoLX9qBLocVNYdqqcSq2lvY33lxi1zOF1/4sNNm3iRRxVZQW8+XlaHK9cdoGY0TRf2
 Ss/5xQHA0DeWrxTeYzxVj8PLB/LvfulJn0NBzWStceSoFdlD3tDEYc1fnELx1NVm1iZ1Ey
 F4bmYUBZ9FpPn8QR07HdCLyg8AbCToP559G7BYM6sfp0rlZmEcemtB7yO1eUqtM+Lm4+AW
 QKJoEpt2GhGQjfb9nFnFCNYjfsr/JA8RKZGb8ORy38u4VUg5rUGMmVdPdz0RFGOQfNfwT2
 OqbY5QW0X9NuGfXJloq1OLv9CAE753zrEvuShiuWPOzk78XnEu7AB73/Zp726w==
Subject: [PATCH 0/2] blk: Fix duplicate partition devices after re-probing
 a block device
Date: Tue, 27 Oct 2026 15:16:37 +0100
Message-Id: <20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrE2iXSCuIhbTGgxS0iIScXfF8
 i3+vyCwFw5QJRd4PiTI4iJUmoAdyPWM0kaDznSuMl2gmSdcyW+4OyOuRc4NlZ0iW1qCWK2eOzm
 /Y938DrsZ2W7vBu77AcOHqbhzAAAA
X-Change-ID: 20261027-blk-part-unbind-e6ba8f1ac8ca
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=vUPZfdfSzNCZVIXiE4uz1GZwBm0mUyZGXKWQYQNrYyo=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevBpoSL0oYccisW8SqHNHvyXN6fEn91gdaTh+c6GjoV7
 5/z5JDuKGVhEONikBVTZJHit3htaxbrI3+sOgpmDisTyBAGLk4BmMhqAUaG5VfP3sh6cT0kLd04
 /+1Wdy2W/m3zZspuSq3TTzHfkHrnBiPD7fdfI1j15nB0znp4paXwSuiXjjf7Fz73D5qtfuqg5xt
 rbgA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The partition devices that blk_post_probe() binds for a block device
are not unbound when the block device is removed. When it is probed
again, a second set of partition devices is bound, and the EFI disk
code fails to add the stale ones:

  Adding partition for mmc@42860000.blk:1 failed
  switch to partitions #0, ERROR

This was seen on an i.MX93 board where a single failed read during the
first probe of the SD card made the card unusable for the rest of the
boot.

Patch 1 unbinds the partition devices in the pre_remove hook of the
block uclass. Patch 2 adds a sandbox test for it.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Frieder Schrempf (2):
      blk: Unbind partition devices when removing a block device
      test: blk: Check that partition devices are unbound on remove

 drivers/block/blk-uclass.c | 22 ++++++++++++++++
 test/dm/blk.c              | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20261027-blk-part-unbind-e6ba8f1ac8ca

Best regards,
--  
Frieder Schrempf <frieder.schrempf@kontron.de>

