Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B19ECA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 16:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A23FC607C9;
	Tue,  6 Oct 2026 16:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2Ld0GVHmtuf; Tue,  6 Oct 2026 16:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1AC86060A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302839;
	b=aHqpjY78U4/DeZbFLORPNfB7vCk62VYa3VBd+ubq4Lm6Ji3QB74T1gJrvqbcXBL2WTtc
	 9s8OjLLSF2+DGiGkEYhBXDVp8c20DiPq0v1hkKYIVRccTxM/ObsFoRfwf+66lRcF9rLWl
	 wRit5SaQZZE7a2t+WTF/Ykh2sk1ucNz57HpMHy1tH7h7kugXGVaRPKk5JhPJeuVASwdBN
	 fDdF6mIIxuMpOz0JHXvCgi3GPktAZPU9zra4c1EIjwAQCskI1Tt+ffCERWIZViJPX3Fkc
	 OaDtF6mgn3Zju/kzqDFbB7nBBc1LhMHl3UvcPUMRniyMgfPTZEyPsWl4WIphNyUd/2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qOgDvGA7NSdOuw4F/zcRAP1Ryhe1QIZVGTLEAcXWjg4=;
	b=IqsiG4AXPsDe2sPT2NCtrFcEIbO221P7SQRDi1uhO6FSrkGJAFKHb+0+so0q7FgQ5M93
	 oX65NQPMezeH7/aoDAXJt09sEQ0xCEsMW15zFyWimHUwO1ciuZnD7tpUiV1WKivHmyM9f
	 3P36kESKaHEdQuj6Aho2MjC/hIrOwO+NeacwKhQpw/sdCPIpcF03lvSnTPx9Yo7hzgd91
	 PopDad/BUOtTmgsb4/i7DTVQcdRQuphZMigRod7HEc09EoPIaNK/i1vG7OmAQrl5CI2+8
	 stxQZs9xkyhb/yUWTP5DakCISZOPkliD5eRO5YnioP3kdK8TdrjzaIY1Yj/GVLPKWiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302839;
	bh=qOgDvGA7NSdOuw4F/zcRAP1Ryhe1QIZVGTLEAcXWjg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zfx01e4RMzAXPeadkU9fsAddDExb+oHVtiRV7EYWENpHts+lUjtuTxKJ0g31vHhHn
	 hcIGSViY3IGV4F9eGpmlTvmxMkZamAuQsdg7IJKtRHKbRJg/fBl6Rzx0UqRcIFspwL
	 YWodxiRcG9w15TQJjLS62QGTF5+Y1tyibd81vqrNnnCMWuW4EBwDO870YRDNtznlOA
	 +8tbhp6nvIqbkwkInUFpwC8RnD9cAEtgcG+yfGTo6Yt7AnnikgjsRS87wSVlc0jcEI
	 c5avSdyY1oZ//Cei5EwY0L0u69r+/7iT/nxgLEpWE8miB10CKGPXr8nQGH/y+Pk/3O
	 OIWOnbNZIq1Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1AC86060A;
	Tue,  6 Oct 2026 16:07:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EE08732F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E009540274
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nHHoWaABfl_A for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:58:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 501C240296
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791302318;
 b=TfIIGT4MOEd+/dZI590E+aBTZ3kaYgPPd9Uk/KFUtgHodqw2h9vq1l3Gou+ci8C1KP+h
 ATxDHpTG3ziZlbePClmSaky9R5drNsqfn8ccHXx4cwSZBEBvqwp3wysFcGXjPI+KKpIJ6
 N6FHOLDeAnwBqjL/Vi04VCUcD01uBFIDA6FPqyZNCWHN/dvyhKe4EOMjX6kyMuv8HFMnY
 sMFg0vV4MIH7D9bAwM8MSdN4gtp1rJu5V23JrlbTRyUaKXNRod2GJz/KHPSUQs0EqX7jD
 dXOkoAtqi1BYNZ4ssuO9RHlVtqxRWTc2UQrhBlYyoKKJimCAuXj0JsbS08BbuUG8VdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791302318;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qOgDvGA7NSdOuw4F/zcRAP1Ryhe1QIZVGTLEAcXWjg4=;
 b=KtUtlhPXVnvKpsEH1A69jUOFYetDqcE0CKfa7ZCGiD0kbs5apc70eJNzUBcMX1iluC5U
 +lKTAN32kD44ffF45yYE6vI3W5vY48MYw6cOwDXYKcLshXFmd3ut3Xhy1q1cBDvfeXM4K
 HphdHz8UjdApBDXloY2kI2d1TbKBI6StJJhBjE6iKV1x2z5vIa49xzc8lmokBYIr3ctGW
 OAKb92KHnEbUM6KHYnrELL3m7OwFeAUtbYnqB7Fg6aYP9LmvcLKxjTbmBS+kEXnyA8Oh/
 Y9Xi+dXNsreNYz/0I/5DkR+0ku1zXIazR1MR1jeS6WIh6J46OSQOXrcXTxuDn1P3Csg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KHEZt4ro; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=kforce@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KHEZt4ro
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 501C240296
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:58:38 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so723674a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791302317; x=1791907117;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qOgDvGA7NSdOuw4F/zcRAP1Ryhe1QIZVGTLEAcXWjg4=;
 b=KHEZt4roWlxEsWYfDPZ12/RiNg/ElVunjKu2dDIPj0ZUED60HS3FEbblYOgjpbLl/H
 oXExczuzlmbfOzy5sKAmk0f702TNh+AiHw8XpQjVhXu8v//SUlQUfcVMI4xTr1g9Vwj/
 1wRzMwKuOygncG8DQsTGY+HKhF/rCQqz34b2SgktLXdogAGE41dLyq6IFvt09VJj1roW
 L2lX/Ly3NzezvjtgkBRH9OMQ+8/I0bHQYDoscD2a28wITSnvt4bBWYTPrxwldQsdgyzb
 agiz0jYAtYR4+cTHjdwEy/b3E/J9Hqy+4TieLreNkwi2vrgNS8vre92p6J9T8IrY84Wu
 f1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791302317; x=1791907117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qOgDvGA7NSdOuw4F/zcRAP1Ryhe1QIZVGTLEAcXWjg4=;
 b=qXjD27d3IG0jVtEpkOgngBVyC4PUuw9uyu7QWHTCS20qm7/At7Dibg57hCQsrAnZEX
 ErrVe9t1f842x5fG+v9p/oL7JfQaT+PEFZwgWWIl1uUCKLGPfnAkQQr7UxCLzotKJzmc
 gvtP8hWLbobpKZ7fp5//ytEL+/flGPEye63+hdZyY4tKzaeuDm42S4HFZFP9NLfCha+n
 QtT+Hc3dsziN5mjl6Cnhq++bJ8y2+dkevQdMehSj1vhC+6f5Ic4a5CoEURIBfh2e+gJl
 2bPjmSkCsN2dyhXZHAUIp8aU+nhXSaBTMLf+OdTZYpTHbtMA0dPtdpSAXYnslwgXKnFR
 mfTA==
X-Gm-Message-State: AFq9FYLczqJNW8ui/MPzpXKrmaKBz9umTDnqeqWbpFpGw630pUV3jCLB
 Fd5wei7202jDanUopv93/j4tEmMXgYu48F5cmnBoiavt02alLc8kBGJp4/Z6+vFlT4w=
X-Gm-Gg: AYBFou2jvLXIFCb0R+7rs7ucBlLCOQNk6r2anYwJhCSVcHZyfyZdjxDhqxrjrGO2xex
 CL59C65+ywhBeCSAAIco3vnlQLH42TgkO/Z7IkP5GijgIUZj/WVguf4qf7w4rZkYrNgz2iACqg0
 DNpjNnpla6qTXtcPxh/2UuxOrB7W9WQC8GLDFCLZaGBpy7Z7fEH++6CVQOmnBf/n9I6UlhUgPTz
 24aV/zBshQw28pjA4DpI8B5IwJwG+OU1Cz1ve6ax/GCvmRFNZlP6WHc7QZrOO2TwL/GFJY099tA
 aX+8kKboDSBa1nr9jvatnNNysKytTw/AhBSMivQ3Ke/4f03x4Tf2Cc/NnIdjVJWuQB3uFcbQ8mm
 +gPYGd3azeE9ABToWs4CnZ8fciEr88Wqj4JgIy4Xr1slTa/2y+MZ+Ez3//4F0KjumS0ZOZ0e2vf
 J4YRGrifdn4+EpO68Yar23BGnQRUfHtBVHsVmShOwDGkxtEpMVw0oFFI463bJwnAmlunm8nDt5k
 w+m7sxSnDBjMg53IqBPJHSDeKyeC4uf6g1qCraLsPluhwivZaNP6KYFSppMkqUClVEk
X-Received: by 2002:a17:90b:1d47:b0:3a0:9640:802c with SMTP id
 98e67ed59e1d1-3a8726b1f96mr1185639a91.3.1791302317367; 
 Tue, 06 Oct 2026 08:58:37 -0700 (PDT)
Received: from myosdev ([121.165.170.166]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a89b603d64sm32837a91.12.2026.10.06.08.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:58:36 -0700 (PDT)
From: khaliforce <kforce@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Date: Wed,  7 Oct 2026 00:58:33 +0900
Message-ID: <20261006155833.68374-1-kforce@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
not set DM_FLAG_ACTIVE_DMA. Their controllers can remain active
when U-Boot hands control to the operating system.

An active controller may continue DMA after the operating system
starts reusing U-Boot memory. In particular, OHCI may continue
accessing its HCCA.

Set DM_FLAG_ACTIVE_DMA on both drivers so their existing remove
callbacks stop the controllers during OS preparation.

Signed-off-by: khaliforce <kforce@gmail.com>
---
Changes in v2:
- Use DM_FLAG_ACTIVE_DMA as suggested by Neil Armstrong.

Retested on MangoPi MQ Pro with the downstream D1 port based on
U-Boot v2026.10 and Linux 6.1:
- Read a 64 GB FAT32 USB device in U-Boot.
- Verified a 4096-byte read against Linux using CRC32.
- Booted Linux without running "usb stop".
- Confirmed USB reads, Wi-Fi and SSH after the handoff.
- Observed no panic, Bad page or failed services.

Standalone builds pass for RISC-V64, ARM64 and ARM32 on upstream
main. RISC-V64 QEMU boots. Checkpatch reports no errors or warnings.

 drivers/usb/host/ehci-generic.c | 2 +-
 drivers/usb/host/ohci-generic.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
index 1ae3619ce25..57f1bcbd9c0 100644
--- a/drivers/usb/host/ehci-generic.c
+++ b/drivers/usb/host/ehci-generic.c
@@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) = {
 	.remove = ehci_usb_remove,
 	.ops	= &ehci_usb_ops,
 	.priv_auto	= sizeof(struct generic_ehci),
-	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index cc44226f5e0..7493750f8d1 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -110,5 +110,6 @@ U_BOOT_DRIVER(ohci_generic) = {
 	.remove = ohci_usb_remove,
 	.ops	= &ohci_usb_ops,
 	.priv_auto	= sizeof(struct generic_ohci),
-	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+	/* Stop HCCA DMA before Linux reuses the controller memory. */
+	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
 };
