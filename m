Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B147CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 13:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C14E60796;
	Tue,  6 Oct 2026 13:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbH8xUuxkmEL; Tue,  6 Oct 2026 13:00:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 92A7F607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791291633;
	b=fjFEVCco8TUMqPP7g3mI9jr77fUpcBnXRZn08Hp03bMs756xZ83SwbAE/r9bydCPQ5hU
	 wxsZxvijN4WghAz3Lf3hJhoID3rtOMSvS8Jkg+akB+FtyWIAwJStH1xRx9t85qGHHv4mY
	 FXM8yQWfjhNuV6UIqWoZhxwSmtkim6iR6VlDdrItmlT/T+UVmmr19hEQkYkmZYzIRBDdj
	 uXPaSB+0A/MqZu9YvvIBO0pUi2rT6a+gcIWFqG9s8PwSdj8kDd6rfHTkInNankTHIdWmO
	 qD+UsrU+UXAyQ7YK4v1Hifwf0674RO84tF23RndYQ39/6Kre8zrIHUXe0L7hbW1Y8qQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791291633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iIyDBgNH9Zqe9TzVtrNgr2hOxY0YXFeCMNhzrMW1OGw=;
	b=aZ/xcu67vcLHO9bX8t0xR9K7vhYodqvIBRulT/EH6ojk18yhzUI/MQc0AeHFTx5qgDeQ
	 7O2h1dj/R/sj8c24yhWGJxb+H445gDR3H0sODTWKLXWSr7/Bs/rfQQFO0hb5u4LEzQMeI
	 z/HR9I8/e3qiQNhV0Z614WFGXOCdUMq9M8023tO6pl7/eq+I0EeCZtW1oRxhJARILSesX
	 hJG7rzLI8lfe9IpJwbicKp5Tx18W2WPV9z0ewQeGrUyIvbDX713si5nlo9eUIGU3OXp3R
	 uMUGAY0TscA8MzV77h98kR8P1xZgSF9RpNewlLYxNyN9DmzAhS344InGv67v/m5qBow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791291633;
	bh=iIyDBgNH9Zqe9TzVtrNgr2hOxY0YXFeCMNhzrMW1OGw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=L9H3lY03iYj144S8PARzazEv1YbhG7lFaM6xDqFzMypOHrI6W5jpi3q5cDm1/nCuH
	 RtxmU31AKNcc1i/fWy6ZzTxe2mRSgz/WIFoH//kM9H5QE2bvrc/Y9F0sVIXwgO9brs
	 /nq8LPFt0UlGXDMiLjLFeegyPu1blcvUysYC2iVeoWO28xCHJCLtlF4L4VuESwnfH5
	 6/YrCbrPwvsrsDE3lO0VGc3BZyfroPbHwVPjSibjKIRA0n2TLlp44GEaXgS11nJNBB
	 ZyLmj+tOm3OPEKiVhXmvpcbqNDhe+QsYdxrXJZdW1oii8/ZMNSKzBd9eMT+u73Sz5c
	 JIM9NrPdFxxhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92A7F607A0;
	Tue,  6 Oct 2026 13:00:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7AF222B
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDDDB4021E
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kWI_oGg_Yo6I for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 11:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3CBCB400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791285243;
 b=LxdVH+rNZ0VfFw1G+wAy3PuCmnj9otgl3q4qSJi71lnVgyOPiUWgildHy9vfrUCS+Ypb
 YjdRA07mCca0I0sPFsL94WH+ElT6KzDWnPVAYyB26yq0MnvocEKRU/C3S4BNnnqeEbd7l
 0gJFGE/XNErZh4KdyCQFsm8P6Cp98eMKObvATWnN3uyfTfRdc0so2KSu5ihz1bvyHtuic
 2cIN60kGkQJc4Bie+5C03qReWVjP1rBnJh+HRHWuJxWs7Sx5xgJqVutq+NWDifUiuNtVK
 GO2Vt3A7KbSecGAP+4AdskrVFh3Deh+Q1RNgg8FF8VLPvfQI86s/INtcbyu1OIstcSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791285243;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=iIyDBgNH9Zqe9TzVtrNgr2hOxY0YXFeCMNhzrMW1OGw=;
 b=JhwtEZ7Btz6Za35ifHZeauSvw2l2CA1etHBJxSXyRDJUZLEoAoV49Q06YzOtUEjviplm
 iZEqOn8b4sMJAdNr3muo+yW0HALA8XVc5OjZ+j8ga/UWk/i7n702MwOo0rZZb40HZCDmp
 rCa71BSe5zxPgMpzsKAQn93FfckUvMotCEMBH+XCe/fjEGaLEXUFUQoUieZcLMz2Srjx+
 sdHNy+lgRAQa44R+Cp2sOhcwJSLSPrKI7sa37bk/nEZLBPtUsfYa5Dr23MHsbNuJ5/xBg
 rS6ezbepCG8Bq8uh6jDX6ruvc5F5iZiagBJ1ESeJCtu2J4NruJrSkNw6L9OhU5sdDOw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mxN2y2VH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=kforce@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mxN2y2VH
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CBCB400B5
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:14:01 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3a865731ee4so437568a91.2
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 04:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791285241; x=1791890041;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iIyDBgNH9Zqe9TzVtrNgr2hOxY0YXFeCMNhzrMW1OGw=;
 b=mxN2y2VH3ApnRRFJaOKSyFSctLBixr5eSSIpQDxAYp1SVt+2iZDXkk5Gi2gR5SZEdT
 7BHz8lbxWE2z3PMaQzI0Yldu1M9TV4s+xGEbO1zvHFFMRg3LFnL6M5XLy7/pDLGLQOlZ
 8hAFj9qx3SQNxooO/aAvrRhMXlgbuqCDnmOGnJNMqrtHAYnWJ7TvDCfneXWreW7FMIf2
 iDWWIbKEF71AJ6cgcbJH4PSp1eSG30uxqK4J1rao/R1yYeJrKf5GulNYAF7GkQSrA/d+
 hUWVx49WOHmeaVgBtPiZ8v6m6u3L+pbd1N+GUmNfC6KYJA1DmY08pBfoXKZ0daDV8CUH
 oF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791285241; x=1791890041;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iIyDBgNH9Zqe9TzVtrNgr2hOxY0YXFeCMNhzrMW1OGw=;
 b=CvtGLMJle3O+lznavkrbPy7IxgN/gyZQRFDghGY+WeVhNFNzAYWx8VyfT/dceQlDou
 deXFtDrrgpmufr2iJIjOxk7hOY0LohO3s1r2oxbv7ldxbvbMIobjh+maIEOVjTHEvuUq
 rKE26rmWR7jTvYFcWjFjEu1DLZwILUqmASheLtn792CXqpz/87daB9SCpW450agB7khv
 e2Aun+Gj3+gw9srCUEMg3uiK2QVa4vufJnCeOeA9580gRnhWuafKW4nABp3TdYJaLBYM
 PnLH2kK8qs9aHePizb6zoO8jUcso+/857p32ZhYrbaHo5rYFzsFKI208w4VIC/S5lHGA
 8HrQ==
X-Gm-Message-State: AFq9FYIf/dLzaxsXufP6cj86ImbpMsTosYnmC/b0BzA8dk1PJs2zpGiE
 IXLXtcqanL7YwdgAQmhh+daGU68gDULHdSddaKnihBMoBU8Xl9nmCgwkm9z1F7zKpZ8=
X-Gm-Gg: AYBFou2pqZwOTB4vUr6hm+r087DgIi6VaoKIst0dOFelqNWEpjLh9cVszeKb7u+1uBP
 KfNWS2iOnzeFV3uDLBxOfHXq8knxS8hFrrommyGEUzdUx0DqckJOhvOQkuzngmMTJosD8aOsBp1
 sDVXGEX53nSYOBHjacbu03IKOuSw4g78Mb8jNdKdLtY9Yate+C/ASrGaLNXL2WT00N4HFnPJ6fZ
 1iTp/mh1j7W1CdtyuH1kxOC/g+jIm/kOLK7W+vQSR3sOKPfvydsY1+sugaXBn/5zbpa16KoyZiE
 W2E8SBsGuCEwYL+pTo8bWfOD2W+jgoX7s3pRH2TWF0ETvvHe7ieEXoDA/puXtT7GXyme9rq144G
 8fWePDjOe24yQVl9XvClGxqQ7E/Zyy0a7DvWxeDiCA2uNKVWDExfklco2eXbSSDG7wZlgCW/EQK
 vrSEWFVreubjNjZ4MgAOzq+bH5wcITHHs7FKE9EVT05TVSr0mCBotkx9Nv7qiPEZfcWo3eLnXdD
 cdLiw2ayKkqDCvNgm00sZjpEZLzEqB93wrMS67rR62S2S90ApvVq1VKAWdXWTyVv6p9
X-Received: by 2002:a17:90b:4e83:b0:3a8:32f2:f4d1 with SMTP id
 98e67ed59e1d1-3a832f2f66cmr3519988a91.39.1791285241054; 
 Tue, 06 Oct 2026 04:14:01 -0700 (PDT)
Received: from myosdev ([121.165.170.166]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a85afe9ef9sm3707046a91.12.2026.10.06.04.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 04:14:00 -0700 (PDT)
From: khaliforce <kforce@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: stop generic OHCI and EHCI at OS handoff
Date: Tue,  6 Oct 2026 20:13:57 +0900
Message-ID: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Oct 2026 13:00:03 +0000
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

The generic OHCI and EHCI drivers provide remove callbacks, but do
not set DM_FLAG_OS_PREPARE. Consequently, their controllers can
remain active when U-Boot hands control to the operating system.

An active controller may continue DMA after the operating system
starts reusing memory previously occupied by U-Boot. In particular,
OHCI may continue accessing its HCCA.

Set DM_FLAG_OS_PREPARE on both drivers so that their existing remove
callbacks stop the controllers during OS preparation.

Signed-off-by: khaliforce <kforce@gmail.com>
---
Tested on a MangoPi MQ Pro with U-Boot v2026.10 and Linux 6.1:

- Started USB and accessed a 64 GB FAT32 USB storage device.
- Read 4096 bytes in U-Boot and verified that their CRC32 matched
  the same data read under Linux.
- Booted Linux without manually running "usb stop".
- Confirmed USB storage access and Wi-Fi/SSH after the handoff.
- Observed no panic or Bad page errors in the kernel log.

The hardware test used the downstream D1/MangoPi port.

The standalone patch also builds on current upstream main for
RISC-V64, ARM64 and ARM32. Checkpatch reports no errors or warnings.

 drivers/usb/host/ehci-generic.c | 2 +-
 drivers/usb/host/ohci-generic.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
index 1ae3619ce25..8075fb069f1 100644
--- a/drivers/usb/host/ehci-generic.c
+++ b/drivers/usb/host/ehci-generic.c
@@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) = {
 	.remove = ehci_usb_remove,
 	.ops	= &ehci_usb_ops,
 	.priv_auto	= sizeof(struct generic_ehci),
-	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
 };
diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index cc44226f5e0..6cc26e2d3c0 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -110,5 +110,6 @@ U_BOOT_DRIVER(ohci_generic) = {
 	.remove = ohci_usb_remove,
 	.ops	= &ohci_usb_ops,
 	.priv_auto	= sizeof(struct generic_ohci),
-	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+	/* Stop HCCA DMA before Linux reuses the controller memory. */
+	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_OS_PREPARE,
 };
