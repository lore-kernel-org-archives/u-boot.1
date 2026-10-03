Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3161ECA5FED
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 15:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CE0940E01;
	Sat,  3 Oct 2026 15:20:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfRbQC-7np6C; Sat,  3 Oct 2026 15:20:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 51C6940DEC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791040812;
	b=luzBvsfbN5vrWW9vcRYLlrONuQGpY9l53SJSmFrzK2x2bBytrv1L/6Ayydm/8tCTpZIb
	 aXsmLfBGCYBiFs0+T6zhBmDd2WZ8ROJxvhOmDJEGOPp9vgPY94W6EdPmvZ7TDHO6LdzkE
	 WSH8zdaoN/zyZGfYN8aw//trMXxTkByc3GvhbTdWcukUWMYAQ1WaRdXmGtnEVlZfhEFRz
	 COEOdSpwX9aFuVq07L2dIhCqrE7EX9rN4HNO4AsnARrvNEm35Q47JhPmn4agpKRVPc5Q/
	 tB+Swrt/bDccfyKVUMmzA9PgYynF5Y6hUf/GA+dUEAH1a/3A/rkB/yywr2bvyICxdnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791040812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fXGcaOCpdGW7d0uMZGFYTmV27UHNAikfWO2XtLgqEN8=;
	b=nU/xE5k9Olq3p5Ln4v6yOWo4q1NtAKETzc1P4I+rF8brKh3ftwIsLt4nhbk42d2HZ2Sg
	 2yjyt2iIqpm/tOEqmph+aIPflaJ3eh7+M3S35c5YMsvV9haOk5PvIDPlmGN5/zZwSdFnl
	 Ng0rBmNS5msgbgr0hi5Ri0sQhESKp5bhRjMW+vL1xmYJdzVgWc2rAt2FjJep7Vh8PrUXE
	 5vrcV37lF1Hi1sNIxyyWcyFt/xPU7Ls0YlXH+zr/jWj7tKjv3SBMlbplXDV3B6EnHf2aI
	 Kft9m7H8g9T15OjOlHOk8NfqLbsg3tPO6WHLpTzx1KVaDcIQtGtEXiFVAa/ky9guxAw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791040812;
	bh=fXGcaOCpdGW7d0uMZGFYTmV27UHNAikfWO2XtLgqEN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H6HcPYDisrxqHVcdaiXDVEd/yTktWHmRX3dBQT72sPOU2p6XAJiH1/66aj9C2vcxc
	 a/cYl8drwSUh4+w/pNkrBdHDPV7fZ27L9Esi+/Yj7nRsSHkOx/iA49diVP+FWRMFdp
	 J4Bcie0396DC8W8Fm7TyKhgrEaz2NEECJNpHG3vYGhapSCmdiVGrnVn3w1puYGGLbM
	 IezHf6117pmpz+KCyXcZDfs3FZFEniD2AcGCz69pSlycihl086Rx2L3zsUP2VGsyuJ
	 RLchI1INBLevJPMUH+8CfjaWAqAfcKeNq7Gg2+KwvPynNDWum5KSPoQ/3ciFx0LYYD
	 GJM/QkZq4O4uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51C6940DEC;
	Sat,  3 Oct 2026 15:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C3B5435
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1C93400CB
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXmRYYhbdRkU for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:45:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D9E88400AD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791038717;
 b=Ty0WDq+N0HpPuvPbFWPDhVxmrwjo43/4TGqRqb/QIrvHymwE1U1+Tws0C6t0u5vDbCOJ
 CITH+SCfOV37yx+8fnQjxR/osN3MXwSgntlaPcWDw0cpUuH9jpqNDI5onZnAsQIiuEk3E
 xA93Hb/+w2NYAPD3qNUbRhaF2nqADbTcCd+jVJ2pTVMkDm/+/UUiK0jEuOoyba0Cr2e5b
 6SADQSAtoHxLQf5ghERxlgCn0Uo1ucYB+NnEpPVqRFIlNbNORWL2jRP8P0FaJG1Y+btCv
 6nyG5EN6sOpod/gH5Sj5ZIOqv1zYuIdH70OcXOnU+eAku73I3uN2IzSQXcETaAdrGYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791038717;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=fXGcaOCpdGW7d0uMZGFYTmV27UHNAikfWO2XtLgqEN8=;
 b=BL9Tnr0c5Zrl1NsxcFxnhYJsqh8EJsJt6aaG/Mr3OGgFYZprX2Ft8/miaOq5qHwSXH9x
 pubS087uwrK0GSuiwOuYYNY0TTnEAwPwud7cXlDXDe5d3FBeumbOmyfhgAtxTICO0Jn84
 Vq8TNBaBMonsOAR1JVThOHDYZuE+onVN41XgK3QgVUQWl4fqPUyGuLcx+op8nlDpth87/
 cyAgsR72AWXIcnjilI5O6S2jXKhpaeY9akgRtNswaMyt+rV6wIiBH3gLpobHcmoQpg6Jg
 T1Wm8yahC4yXDa5W9KmE5o1d3ePayP33uL3wREtElFPCDShT5stdRMF/gx8nvjCw/vw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=g0zXNjIV; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=g0zXNjIV
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9E88400AD
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:45:15 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a1681949b8so3198065e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791038713; x=1791643513;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fXGcaOCpdGW7d0uMZGFYTmV27UHNAikfWO2XtLgqEN8=;
 b=g0zXNjIVPJDF3c4QsrjXO8aBIhjp5ayBjT0kfIWtHsh5O7U7PmBqDL1K8L42HgPQKq
 PEvrXHh/sQ+lckejzSsOWnaEawBCWuaITY5/80XLx9vzGsZnmqfnRWOW8NvMn6mh2x1n
 XF9t40a7Yy3ifjxuD7gPprzTGSjwpHvQJz/z8GFVpSl+DiJABvkeANDS4SpSdSfXOUX3
 SfY4ePRb8fMER8Q7rbTzytFHq7+GxILluN4zdRAK2ihk0hy4dG6pPh12nx+RUD+fx8J9
 +oW0q8t/Jf7bhNtgeyCi++dGqLFwtOQe1Qk+7N7iHMg4x5ctttBURXv9ec+Ns7LoALuA
 Rl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791038713; x=1791643513;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fXGcaOCpdGW7d0uMZGFYTmV27UHNAikfWO2XtLgqEN8=;
 b=R3p5aa+24uUWdviTfcYR9Jbg28D0IP2vzvDfdNxiObWJu/FcL51YytYP4Cr3qg96eZ
 ATzj9p8O/pHYxL1PXTIyGumE6ckUdWHHMFRewNAJnc7WOxRDwv4MULxvN1/SrQHC8uhe
 SbmvMrDkqBt1ezhwki/uZs+mbJs3aea4GB0/rJ5/RQzyXbrt3UoM61m4wBUB80ZBkQiy
 z7Irwm/Pt3lF+vgzvymduyzborUR1j5eqLaDjOKdQTe+8C6Rx+FZezERP4usZkNJ++OO
 LUeoXQLpLjrM96ms/w6IupjFF4Ybif+yvfH/p6bZq8+h4dDOJs0VjeZ/XXc9SBzBY8dX
 ZdtQ==
X-Gm-Message-State: AFuF++laxyAITMeHzrK0Nb2dh65oiE+7sT1B3aEihYEhpQopk6NlvIja
 VZx7a5UsZ3IVkGV2PJz7t0JcrgU6FF2gH8n7cLVCTSTKDrHtwC9EAuyWlRRTgw==
X-Gm-Gg: AYBFou2ZN2ZrdjyT5xpzR1sgPnjy2Mu5xeks/xl29zW1MaOprHy672X5ldvVVNbx1cQ
 KPF4jUTyZNAYkWg4ih7p1lfuOFGGC0fNsPSyscwWivFpiRd7CUHcIZLKCzJkb/UbhTh1jPr0XFu
 tabgfJxtYBwZlw3+prSqsNHAO5ncGRHy9rjnQ/ir04asX7APttk14R7XfbqsZ7iAx9gK2JzSU0X
 DjsNTDtrTfEaG6KqumQ4OLL1ojWnt4U9ZEU+lpyMCf1Wudz9sFgzIrMCxI+ZbhQtgSQqjTWSf7L
 tLWFwIG45ePLkXaJfqZhVcF9u0QEq5PFFpac2zmEBp4ZLdhLQj6Vqo0rzColta6uaH/NlM3PGFB
 wviXiKZ4gz1iVW01/dAIQ8un27wpeN0OTu5jev4+iuUS3xZMyTjtsKCNuRDAr4Bh84Nq5qgBvzj
 R1JZj/zECb/tauP5HW5AB9PWfwq7VzkQSaOczAaztUgZXJnGOsdV76NrBQpnC4K7Q6UrzRu1im1
 hIsjZwYY1KRRdmWEM9uFbzSV32tD6yKrmJ0sTA+0wBjzGrsHcho5/PfSdPgTVNfzsVxiPivwD5S
 NL7Btaxt6eaKDVw=
X-Received: by 2002:a05:600c:620c:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-4a027583fb0mr99969515e9.20.1791038713395; 
 Sat, 03 Oct 2026 07:45:13 -0700 (PDT)
Received: from lap.lan (xdsl-31-165-251-31.adslplus.ch. [31.165.251.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280bfafasm186553995e9.8.2026.10.03.07.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 07:45:12 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v7 1/3] test: dm: sf: Get the emulator attached to the flash
 slave
Date: Sat,  3 Oct 2026 16:45:05 +0200
Message-ID: <4dbafdd2d36c3f504ea48815ef847c5835639db8.1791038319.git.joaofl@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791038319.git.joaofl@gmail.com>
References: <cover.1791038319.git.joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Oct 2026 15:20:08 +0000
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

dm_test_spi_flash() picks up its SPI emulator with
uclass_first_device_err(UCLASS_SPI_EMUL), which assumes the sandbox SPI
flash emulator is the only device in that uclass. That holds today only
because the flash emulator is bound lazily, on the first transfer.

As soon as a second SPI emulator is described in the device tree it is
bound during the devicetree scan and so comes first in the uclass. The
test then hands a foreign device to sandbox_sf_set_block_protect(),
which casts its private data to struct sandbox_spi_flash and writes
past the end of it, corrupting the heap.

Ask for the emulator attached to this particular slave instead, which
is what the test means, and which stays correct however many SPI
emulators exist.

Signed-off-by: João Loureiro <joaofl@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 test/dm/sf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/test/dm/sf.c b/test/dm/sf.c
index 3684d021709..0ec02ac694b 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -50,8 +50,13 @@ static int dm_test_spi_flash(struct unit_test_state *uts)
 	ut_assertok(spi_flash_read_dm(dev, 0, size, dst));
 	ut_asserteq_mem(src, dst, size);
 
-	/* Try the write-protect stuff */
-	ut_assertok(uclass_first_device_err(UCLASS_SPI_EMUL, &emul));
+	/*
+	 * Try the write-protect stuff. Ask for the emulator attached to this
+	 * particular slave rather than the first one in the uclass, since
+	 * other SPI emulators may be present.
+	 */
+	ut_assertok(sandbox_spi_get_emul(state_get_current(), dev->parent, dev,
+					 &emul));
 	ut_asserteq(0, spl_flash_get_sw_write_prot(dev));
 	sandbox_sf_set_block_protect(emul, 1);
 	ut_asserteq(1, spl_flash_get_sw_write_prot(dev));
-- 
2.55.0

