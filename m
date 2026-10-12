Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DF2CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 935FB80D09;
	Mon, 12 Oct 2026 09:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-_9A3qRQ1sI; Mon, 12 Oct 2026 09:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C634880D02
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791797700;
	b=Q7S41+dYIKLKaJi+Xoj3teh8BYE3b8EBz4XxkkZ78NYdNXSAaKoWJbliyiO+yfSJFkgy
	 Ln725puHmQcgy17noFUQRmxFOPPcrlSujVaakf0RNFXZHY2s8etPMawS3UrQZ101Viors
	 BqgaoaSp3Nwaq5zQNqUCG8UPE5OTWWCv01Pg/hA8ZMeUXtsxTvN3DGqeeWc1iAK1v4FTW
	 YsNNuPCHlxY+5HsFg/FSXO0C+7JuLa/Fz8x7oBNg8LGWcLeqBrwKaKRM/5r44++6Htqsi
	 ilnwcUQyB8E7LPmu9FakVlD0PpJD5Zkzb5Nto0wwIOHvapy0CcHudAAxoi/n3jS/srQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791797700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=7hAx4ANKG1JGzZY08PPtm1mKgaP+WCoo3G42SoIyjcQ=;
	b=NYTysMIE1sp+l3MT4405+DVUBTkahelH44tPyvkD1Mxfej/oxQla6WNbtvYWK5e9psvV
	 uSqOWQkRNRu3vCgrZ3c0VCrvJOvEu7tgmcuPyeX8ohgiH+EL/yy6ZUe2O9HnogcQ2m4/+
	 qSfIgZEIQP7KA0VxzATXw+AMhaPqUPLAI/UlUB0UPC4440Q3QpqwfVSHzLmRtKig8kSMD
	 aODgTT6dFv6QloCyZTaVSltrh6srouicMFwxJJKM9Qk6aXOwGrHvvrLCKmfcOB0dHSY3f
	 TRwcOnAffqmmkfsgA+sxV0NhUeL+QHvIE5LRds6awpdcM0Vrsw5p6j4nMkMBMvOSoag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791797699;
	bh=7hAx4ANKG1JGzZY08PPtm1mKgaP+WCoo3G42SoIyjcQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=UvaO45KZ6XE+E/p2/XjoA7H3A7D8U6HWMRsRmW7fVIUXNsiYCSeKY422lKlmZ2Z1n
	 J/K+NJ4MWwIYzq6Dfmtj8o/PgcqiICfjwFPCy2b9rImEuBZ/N9Qy5Py7ukkh5kJ6hJ
	 GJnRBywzWmyHO6UUD6cmZmZ51Dh9Os4E37pZhXcFnibKwCUDM+sosumzYGOKu1NTJB
	 8BkQifuPeisXEKYls8VeQVuXb3ph8UfZWGsdblNYdUM6LjHivrxIfmCwRIZIUVltAT
	 wJxoT3vNy/iRsYm+GGqP7XcXmDqiuWy5MIY/JEdl6Nv90e3PlIVp18x/WhjSDbpXDH
	 nhVLL9IAZE6RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C634880D02;
	Mon, 12 Oct 2026 09:34:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D8FF21DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA8CB405D0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bo959rH_NlN3 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 06:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E769405CF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791788146;
 b=PjvAc04361dQB6Ja/HPMKm/HFAEOWxdE39LFpkfxVvmfLnXjLNxltj1cA2SDd+797h5p
 wi2HXfLclLpzd686QqBxcAExFkOHiRMfSssN1DgFD8Pwr3u6cko38+DJJdv1YaNLnwzbk
 GEwKhOMW1uAktQiv9N8jw3vRNZKkLcP8/zStwvO0HwMuZJ9JdMUh6V/YZpcma7V8oNE6C
 XMPxrrG8pWsag7RIimcs1WWJ1P+X1dMISgiep8HWSQ/JHEK2g5DKTzfVfe/RHyLaJ/u+J
 YpKbHQT4McnW/ZNaRUtK+2hXcvNDiNeKPqk2AFhLvR78MoCvsPnp5W+naxEffBTsL9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791788146;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=7hAx4ANKG1JGzZY08PPtm1mKgaP+WCoo3G42SoIyjcQ=;
 b=YgiRKXECDgp5gqmQxOls/+nHGJ4q31GkXhm5CgPwWsFLiNNEVsuwlYgGslDHvAHwzo8O
 0CR718WAR6ZEB6ClI6dj/Enm0/ppdyhUeB0tPqRYuJVz9dK601KZzhBc6an+Y/klVGqC3
 wdAvtkZl8Hrq2RKjmR1CRI7PR4lOOp2RL0N/fEyIstiHyJ4DaxFc7TU4XiGJQ/sF3stvp
 5MFyWs03ps0a5ji1Y90nXP50oBk7xpGxFua8eTEgWxSu5AJGricX/hgkTBHCh5/VnyzNC
 6u4lAF2BGKe++yT66ns/0YhRcIIANZWfF6ckNS9xTGSh/Vnh5AA/k9ZKRrtgbpcLkig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=T9f1xT5W; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=T9f1xT5W
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E769405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A658641F97;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87A09C2BCC7;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791788144;
 bh=gzXn0YnkdiKTMTOZ+nkQExFtxEAE2L23nlurQLNfx0g=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=T9f1xT5WSwWIjvsSPWHgHvqLmzcMskWt+hBFRpcPN7CGQgUDPJMAldXZ/BuoPeDZk
 QZzwGH6syfqK1BrYgqsD0+EXbB85ddL+c2utV+ly76J88KujBDdcLxUYgQk/jAMHnt
 87s2sBljpUPGJelnCknKkvEM8tm1up8xqb5nDbw95+ZKcn6UrvDO6b4JyWJh9jtvnm
 +j4zxbAErjMP7lhMF3EdR0VmMfUDCjA5fad3OdbUqlZ0puJwMnOpPXToy87IoppGiI
 NxYI8or2oXwnECladfildi/RpiZyUMcUw6ItP49RhCJ+qjCmgFbvTWDsnddDLPxnAa
 7HN4W2XBWYllQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 62171CA9ED1;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Subject: [PATCH 0/2] rockchip: rk3528: Add FriendlyElec NanoPi R28S
Date: Mon, 12 Oct 2026 14:55:41 +0800
Message-Id: <20261012-nanopi-r28s-v1-0-042d62597829@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDWZ1k/EVcSiajAWJR1EIu6uW
 H6L9y4QCkwCdXJBoIOFFx+h0wTcZP1IivtoMGhKjdoob/2ysgqmEoW2d4iYDXleQCzWQAOf361
 pf8vezeS2dwH3/QDjXs9SbwAAAA==
X-Change-ID: 20261012-nanopi-r28s-0adc0003f445
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946;
 i=HystericalDragons@proton.me; h=from:subject:message-id;
 bh=gzXn0YnkdiKTMTOZ+nkQExFtxEAE2L23nlurQLNfx0g=;
 b=owGbwMvMwCUmepz3XUtTHjvjabUkhqwzLfmH3aaXvj30+frjCt6LyzfacN3ap8XD2W3Omraji
 O/a5xt3O0pZGMS4GGTFFFlkN1VHCq2KnlnEInUcZg4rE8gQBi5OAZiITjQjw/p3/39Yfg5eZ/Rq
 Q+KFBwdUdrDkbRZ0Ctq7e1H95W/HV/oxMuxPnvVldcHV1Te11E6suVypenDRFOlbLIt+igb8OPp
 BspgfAA==
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=1DB27B5912AA5B9972041AC715C70DEE84826E07
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/default
 with auth_id=1004
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailman-Approved-At: Mon, 12 Oct 2026 09:34:57 +0000
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
Reply-To: HystericalDragons@proton.me
Errors-To: u-boot-bounces@lists.u-boot-project.org

The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
based on the Rockchip RK3528 SoC. It shares most of its design with the
NanoPi Zero2.

The Linux devicetree for the board has been applied to the Rockchip
tree for v7.4, together with a patch that splits the parts shared with
the NanoPi Zero2 into a common rk3528-nanopi.dtsi:

  fdb087806e80 ("arm64: dts: rockchip: Split out the common NanoPi RK3528 parts")
  c1e23f3425c4 ("arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R28S")

These are not yet available in devicetree-rebasing, so this series only
contains the U-Boot side for review for now. Patch 2 does not build
until the R28S devicetree is in dts/upstream. Once both commits are in
devicetree-rebasing, I will pick them into dts/upstream with
tools/update-subtree.sh and add them at the start of the next version.

Patch 1 moves the U-Boot specific parts of the NanoPi Zero2 into a
common rk3528-nanopi-u-boot.dtsi, following the split in Linux. The
NanoPi Zero2 u-boot.dtb is identical before and after this patch.

Both nanopi-r28s-rk3528 and nanopi-zero2-rk3528 were build-tested with
the devicetree files from v7.4-armsoc/dts64 copied into dts/upstream.

---
安容 (2):
      rockchip: rk3528: Split out common NanoPi u-boot.dtsi
      board: rockchip: Add FriendlyElec NanoPi R28S

 arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi  |  3 ++
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi       | 11 +++++
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 10 +----
 arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  7 +++
 configs/nanopi-r28s-rk3528_defconfig         | 65 ++++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 6 files changed, 88 insertions(+), 9 deletions(-)
---
base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
change-id: 20261012-nanopi-r28s-0adc0003f445

Best regards,
--  
安容 <HystericalDragons@proton.me>


