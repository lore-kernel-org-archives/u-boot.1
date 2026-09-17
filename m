Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB04C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 18:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62D6B60B8E;
	Thu, 17 Sep 2026 18:30:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FYSnH2jW3dnF; Thu, 17 Sep 2026 18:30:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 57C6360B7D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789669843;
	b=nazXFwAC574JPrwJdzs4fy+Iunw6SG8m+euZ7ngQvRq+fUc4AYMl3jXZDw1+XwC41kAj
	 OY0EZ4RQ+mWu65Lrl0l9E+p75APXQAN7Lw1oa5G7eR+9M/NB7ymLLYwsv3FfYS8adHpC7
	 ysjFRKIB5NymPlWthrKFibMcudPhnVb2480JmIlQZBC/vEQORsYvQkLCFq5FC0KvVnmjf
	 Ox4i1AQflqS6sRhAbKYAW/HhqjaVuu4LkRhL91ekemfc3IUseoxLh9UQqeasqy6q3BKD/
	 FCWfMgSMfZ7kYTNpZ2dVzyUhpxjMZsi5BvgpBOi3CYo++kH2/TQuaJRXWhFBVSWBnKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789669843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Z9g3pN0QP9xW5qNW+kj325pTApAf2aQc5AUlp4LbSKw=;
	b=NROk1+6O7fZFaSBczC7xh1qbGS6ofvrXc73q+PtEF+UVdBnSvlL5RAAiOZfneqekVFYq
	 tkSi1UOn5ESFBFQhnxbQuQ05DCtnNzlf+eSM17HwCfhLGEsDcLmTQPTZfSVs5fMb07sVn
	 SG9XsNZDl7RjtnxW2Awqe8DKyp80hNgqOffivkFa8sO41tcVBlQJXQJy/TPAyTnzYEEVU
	 9p1620D7zrw9OPoypOcb55umiu0uLCzIAZwsokOfBcscKj54Fpg8tn7Lsozzem/YZ014I
	 2sIRC573u3dmLa2PYL7bppNpPteKAUqL1JEugotNU9VvkojES5EWs+qfz9+l3rY1O2Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789669843;
	bh=Z9g3pN0QP9xW5qNW+kj325pTApAf2aQc5AUlp4LbSKw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IqKEIGInCZ5xCu8v4pWqLGVGotwOivUt82FL5/NmI79CKP9cuV8OFNP8ZAKUezvIH
	 fNQkJIuePLYzi8UxFGyuj0vcvYii6SvugTVGWPrxKg2OZtRLb/rnotmZPt82AgLFg5
	 eyhVR57DLT9qFT4Rakm4ue3qhY1F+xyPuBIHOBL5l6xHbDcObkNX84wv3tqu2DBwJs
	 qfMwNN1Uix9z89/Yk+JbQrbGRG5iDn1F+mDw8iUgnSK/1PpqeSs1tu/wXCYNXGq2BG
	 iU/GcERPptiaCNHN34lOVjjsBQjfCekFH9xs4jQ8m5z/Mm+D+DYB5JzvxU66zoTxKt
	 1nbBqVHCCe9og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57C6360B7D;
	Thu, 17 Sep 2026 18:30:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A6D1213D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 18:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C5F0810F1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 18:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvviUJYE6gxI for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 18:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A578481090
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789669840;
 b=IyvIFajE3i0f06T391Cocsu9jA6M8YR+FbSXq42hccnnshNd4s7fiQ71Wcc+9c89V5wR
 dAXam4PH3bDkZHfdeGKALtZuRLgU3evLdNkQaqLA7Kam0Ua4skJtJDSF0SaKw0YzH/GVg
 ICnPEJ/GzDNEvz93HiCkcSV0pEsVvc6EofyPfBMBW2UAMC87nmVg7ImWbRndEZo8z7TH4
 alHOHpJQe6gWtRMJnpDtsoSKqHm1S6J5Y7HouTxYBiKovrC6Pw1WAlb0W9xg2mHKokH0v
 qBkrCLR9CQWCuHcmFvapwKJBrypHVkB9/l7lknxAeWCagqyvUrcsuKPr6+oMbELwtHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789669840;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-ID:X-MBO-RS-META:X-Rspamd-Queue-Id;
 bh=Z9g3pN0QP9xW5qNW+kj325pTApAf2aQc5AUlp4LbSKw=;
 b=QKxtLrzHuZqD1tLI66H/KyDfSLWJlfq1esRSjlH78gGGMHbmfpWF07Gd5Rciim18AugH
 gNOJs3NXl0JSzigya/Jd+89oEWdHDKmDYneU+XL5F0UsFsUH2Acl2JF4+dp8qA3H3qo3r
 0gh5R9cayCX0/L7wqY5CRo5HXFgEIYwncyDT08XH8CKUn+yIr4WSeF6Lf3L0MIphxBhT/
 gfG9JbvZ7E9e+wOCGYU6goHbJhlDkicIxzEhd/dEQrFA/MZu2EtrIJtkoEk63XSFC2lMz
 giPYe//vkwe+uhh4IlcmlnyoiP0P50+yaX02YAT0U46i39k/GwR/kR3Ar9ngtHxAq1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=IhHivegr; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=knjLJbjp; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=IhHivegr; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=knjLJbjp
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A578481090
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 18:30:38 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hm47b5YsZz8vQG;
 Thu, 17 Sep 2026 20:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789669835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z9g3pN0QP9xW5qNW+kj325pTApAf2aQc5AUlp4LbSKw=;
 b=IhHivegrI+hb+RKMS5DCsfHBAjZstxchPZ4GirNIhiae5mO0DNIM+odJ0lqHilVXjHHtrY
 30twMp/uHJmSEmq/AzOjJp7RLOMa0eiZkQC4QLCPsv2bZm1B3BOYqd5/C832HasusSlVTh
 XhI1jqsWMK3ao7Z68Coznft0Ap93OqgcL6MCq/KVFX+1UYr2IbWCv7IGJ5lJRmYfhbcd03
 e/FGMiuoL81BsG8I4iaUMt2v1p4lucIk/gHEY2nwmmERefp3BfXlg3vxgfwNF3iG7JQpWA
 BK4/GiopnHjpiPMn+Z2mEzq6sYn0SAsLZdll9BT5kb0wC9nexs0Tp2Sz875VMQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=knjLJbjp;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789669833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z9g3pN0QP9xW5qNW+kj325pTApAf2aQc5AUlp4LbSKw=;
 b=knjLJbjp3x3xjDhiCThUMOtG3gERQ18kBqYUIKme3XZ4fmLCkrYoaQyr+ppJj3YUoSRAuz
 Iu7wK4Vbxg+XopPmnpqDB+q0M20Hyb737tqi7RcuopFkjhb3UcsFcvL/CtM8Ht5tWmsFcq
 NTvlhZDtMQHimkcJvqhstvpnq/zz9fHLXM/fiMycIQR8e4cOawr7LtC8mFF+4Snl35Fy3k
 oOKcAhyyokEjg3O52iRMzj9V9N3mE8UnNaEjjuP08051BfIRy0Y61kX9d/jmGlfayX9nmL
 C0IQWrKN82umyqV1Uul+9NzGRUOzYqxUvYe4lahB4Tf3chvh9TNnf194EwLWiw==
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PULL] u-boot-sh/main
Date: Thu, 17 Sep 2026 20:28:44 +0200
Message-ID: <20260917183012.552719-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5badd71444d7b973d0b
X-MBO-RS-META: kc4gha9wxxz7rd1y45jp563jfj7izt5e
X-Rspamd-Queue-Id: 4hm47b5YsZz8vQG
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

Versaclock5 driver fix, trivial R-Car Gen5 clean ups and FFA command enablement.

The following changes since commit 444aca6d1439e4c4b9955171a7f45c053b540f69:

  Merge tag 'u-boot-dfu-20260914' of https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (2026-09-16 08:56:49 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to ad8c22034441ec42913539116d08dcbd1c3f570d:

  clk: versaclock: Fix incorrect error check in versaclock_probe() (2026-09-17 16:22:45 +0200)

----------------------------------------------------------------
Kuan-Wei Chiu (1):
      clk: versaclock: Fix incorrect error check in versaclock_probe()

Marek Vasut (4):
      arm: renesas: Drop SYS_ARCH_TIMER on R-Car R8A78000 X5H Cortex-M33 RSIP
      arm64: renesas: Drop CNTP from Renesas R-Car Gen5 common code
      arm64: renesas: Drop empty board_early_init_f() from Renesas R-Car Gen5 common code
      arm64: renesas: Enable FFA on Renesas R-Car X5H R8A78000

 .../arm/mach-renesas/include/mach/rcar-gen5-base.h |  5 -----
 board/renesas/common/gen5-common.c                 | 25 ----------------------
 configs/r8a78000_ironhide_cm33_defconfig           |  1 -
 configs/r8a78000_ironhide_defconfig                |  2 ++
 configs/renesas_rcar5.config                       |  1 +
 drivers/clk/clk_versaclock.c                       |  2 +-
 6 files changed, 4 insertions(+), 32 deletions(-)
