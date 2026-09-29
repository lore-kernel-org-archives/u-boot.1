Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33279CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B59F8605E4;
	Tue, 29 Sep 2026 00:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVl8zATXNaHP; Tue, 29 Sep 2026 00:04:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 77131605E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640270;
	b=UPtBZzfpwPtbNYGLCmaAaKf9qd3wpYMl6ootIVCb7InyYPAX1WABILzUtSqPGSReaT6H
	 8ag6VCH5xR2byohzf9wXNI8qkyWBru/qawZskv/6Frf2JxCr7CIxbsuiWUrLf9SafChT5
	 5sTUv8+xjl8KJ1aVndI7M44c+IAgeKC48Q155OZM5AnPojGbythY2vfu8tOgUc3VvmBx9
	 moyxI5oH66Zr+sfjxHU3Bg3V4kBt5ZcJz2/BnrntQAQUA1bpG04q55sIunFMmFrb++lMz
	 tgix20btNZgbk8WBFfeeas07ijtcmHRQhbeHeyyhOo39a72nMJdfdPNlc6BrR6v/NRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640270;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GkHo7jrsogcc7dRBaZ/yNAh6vDJjTEWIhLdu2Idnr6Q=;
	b=IERkyFzpv3jPLvYF5AbtRkfDR8svUMJQC4yh98BM+SOXtxnKsnrwxmF57KcSRnd4xM4N
	 J4xIOwJP4kxJru4+6RE3ZEg6bcyvnugwmnfqtR4gxDgHFlzeyQj94xiCl0tKh39ax0o//
	 3TOY86drMpK/vmzkQaptNz5MHyDrOqRzqq8oRE870+Exb9A8Mm57nE5r/hpXCWKcPIAb6
	 Ik410RmCSQG7C5RAdTw9sp7ig3zEzdm9RcI7X5eBIruzhHQLWoilYviV6Aad7Kt60pFb3
	 4S9vUG1trNHd6LG+yrkK7H4ZylNrP8t24+wM2LEnrk7i1HdSyVZtKqHXzv3bch88j5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640270;
	bh=GkHo7jrsogcc7dRBaZ/yNAh6vDJjTEWIhLdu2Idnr6Q=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F7nrof17DCE2F2apSFipamOP5EoIaV1N1eLWmICI6JgM/qwg1uSkJLGUMkyF7hx5l
	 sZfFZX6hYircMPzg1CwE+ptlA3lVTj9pJn3D/QpDmTBsDUFmNvwl57cn60EK7HY4qw
	 X2+LsO4L0+aBHgZ0eTWH+ZhWFwUSVPea8UfX3cobpMNF2pjr5316iFiDMU8tUH/Cy7
	 Z4XDT29GbXH/jnxnvEqPiaXpwbWlisvqK6B7UW4cJptCLOkCnu9RArUWz0w6iU6v/Q
	 7G53hCI9WOshfjb99ni8IqVwZ5CtZxAISe3D8Ib0Hz/7kCqzmIKLfww24hU++Khj3+
	 EOHec2zm5qoFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77131605E7;
	Tue, 29 Sep 2026 00:04:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20707335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01A3480C13
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-CJMCJojsPg for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:04:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A19D180BD2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640267;
 b=BSuGrAHhiLRnNcLaTfltIet68Rr/7KBpNvzQdnKShrMAtOnQoEwm1+DrtV8OzkZW6ORx
 v8DkMWljAVlnEifs9CEs/HN8ydyu25ixyys9wjeq6NLDGmDM1XCsjrxVEjp7dNsHDVpH8
 CTi1uBzn3OvrJ/y+9VgbYvTfQUHuQ+SnGzpdn+eO/6aqVoSLKr8wBpjjXQbH2VD9lBJe/
 ut971jRC4pF1Q94xiJp8qU1vnrMzHTagEb31zMQusAdtPlM0LnGm1wJEEIFY7DUJYxhIQ
 w/wJLMuB7U5rhJL94hf2NGihIqCzf0mvaEbT9ocou+UX9GVjYmcIP5q3okAX+9WpdsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640267;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:MIME-Version:
 Content-Type:Content-Disposition;
 bh=GkHo7jrsogcc7dRBaZ/yNAh6vDJjTEWIhLdu2Idnr6Q=;
 b=Pt6GY3MIV8e7pdfEd+HH4C68JsoM9gsIWmZ163Gl7SuO7gXDM20yHoD68cz1UmRQWPr3
 ilrcyP4MN5Fx+6TFKW02faIQxpkoIS3R5qegLswcvxqoGS2DXvDkiZvlSxkAnuR+OzoL4
 unY/Cp/At3ZYh4BmkrvDLUeKWH6OhldShLjeCGu5rwOlfzTmDRoOVUwDsKORiTg8+b2AV
 RNt1nbzW3NKqekMm0jDbkXas2ozOdzrTHngEuz3++1aUrN1ubPjgLdLikNbWAMv+J6qNH
 nZUEGppNxi252sfH2U1PSVUlD5Tki+DSR+BeJ+YeX6lLTvUzP/dOHSD0Tx6MvuzWsAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A19D180BD2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:04:26 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLKV-000000001JD-3Z4v;
 Tue, 29 Sep 2026 00:04:19 +0000
Date: Tue, 29 Sep 2026 01:04:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 00/11] imagemap: fixes from the v1 review
Message-ID: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Simon Glass reviewed the v1 posting of the imagemap series
(cover.1787272661.git.daniel@makrotopia.org) after v2 had already been
applied, so his comments arrive against code that is now in next. This
series carries the correctness half of them; a second series follows
with the structural and cosmetic half.

Tested on sandbox: every commit builds, "ut imagemap" passes 13/13 and
survives "ut -r3", and a full test.py run shows the same 11 failures and
20 errors as unmodified next, all of them EFI-secboot tooling, ext4 and
config-rebuild tests unrelated to this code. Also built with
CONFIG_IMAGEMAP=n.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Daniel Golle (11):
  mtd: bind the block device without leaking on failure
  cmd: ubi: report a failed UBI block device bind
  cmd: ubi: unbind the block device when detaching UBI
  boot: imagemap: free the reservation a replaced record owned
  boot: imagemap: do not resize a region the caller owns
  boot: imagemap: read only the bytes an extend adds
  boot: fit: unmap the load address after a storage read
  boot: fit: keep the load message for RAM-backed images
  boot: bootm: release the imagemap on every failing exit
  test: boot: imagemap: detach UBI when the test is done
  test: boot: imagemap: reset driver-model state between tests

 boot/bootm.c            |  9 +++---
 boot/image-fit.c        |  7 +++--
 boot/imagemap.c         | 55 ++++++++++++++++++++++++---------
 cmd/ubi.c               | 67 +++++++++++++++++++++++++++--------------
 drivers/mtd/mtdcore.c   | 37 ++++++++++++++++-------
 drivers/mtd/ubi/block.c |  4 ++-
 include/ubi_uboot.h     |  4 +--
 test/boot/imagemap.c    | 36 ++++++++++++++--------
 8 files changed, 147 insertions(+), 72 deletions(-)


base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
-- 
2.55.0
