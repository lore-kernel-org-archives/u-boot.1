Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24953606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r8+D+WnA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=inXcyLsM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE6F26081D;
	Thu, 22 Oct 2026 07:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r39OdMbGZmOB; Thu, 22 Oct 2026 07:27:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3857760884
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792654070;
	b=LXWJtceOiuN8gpswopLegbj/6z18MCQ+jF/RsgX6maHPv+mpJPBsTfYw+TxrAJkATX4D
	 J9EDDQYGnOHna4Pv8yfCtCqNJi4zVqsxBdacpm6HREN3ksRR+OllPzf2esgrjYxEiJRkI
	 HitOVBEempHMXi1B+Y83JgLugKurwqVcmxRoxRvxUh8cp63VqPhljCc88k1o8kLQGnhDF
	 rVelOgZB9rYymRBNA081NY1+dhHuKMrSpvxFyfa1ntFEXVRMek2JeQfhFT81JTkTT8xr6
	 ML3MpXii1IBjD28HuB9im4p/iHePSst9K0hNzzO2CI73K25BlwIhIQARy7BTCZeBaMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792654070;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rLGAFJrmgyiuq06UVBRxIZyX8aiEHrvmEjnTnEmt/hM=;
	b=TuNSsf19aHTINpoONik2oxIeueuZP0FoATUGoThQ+R9e8friDMtWrpVcxlgPm04nDIX2
	 5DVnw0BZdWTMdQWbQUcTHebw5bA7htiw5FTuBnhdjNPPXAjAODo8F/O4I77vhv2eEXyp7
	 0UrwLyS7jcqR8RxOoDd7a7NX4Ad5tfb/tmaUsnVRH/g1rmM3XexCnzy9hMTJcD+FDW6yr
	 mlTEXtg6OoHmgTHnDnW8N0h7GkRUy+u7PCpIcAuro3oHMudC/Un+oK4nOkCkw3ZiESpLr
	 efI473XO8DXhQfYPuqRnb2HFxNHuBSPLR89oLBz7P3SbeU5obXEPJ2tMHHz4HRVam/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=inXcyLsM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792654070;
	bh=rLGAFJrmgyiuq06UVBRxIZyX8aiEHrvmEjnTnEmt/hM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r8+D+WnACFE3CK7V3GPuop+kHInkslKF5SKETuC2eJxPx5qZalp1O49grjwNRHoSX
	 VCX4BKG9BNnrel2K6vfkVgJ7mnWoOc319PNd9H3SWokyIFs9+Gp3r8RatQuwzqoCRR
	 HxHotPbTGGh5fwBxaLua38HtJb3tbAOes5TOzjLub6XkKvKrHIFjivVUXF0RE0WMOa
	 LgST3Y7E+aq5/ickgKacAmokL0Sm5qubbhmbL8ajHffBV9/ZpCu9Et3kXOjh73xLNb
	 x1LDP3uMQUMIVrb7tW+N+6rhF2i6ZPHCbCVELUtTmjFVBh0Np7DMrYegwZjccl4DXa
	 XEfnj4FjZPsZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3857760884;
	Thu, 22 Oct 2026 07:27:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AB9B1184
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5079A607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLmbnF23cqlY for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 792A1605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652594;
 b=q+g2VNVG7znOEqZLMVWat7kmMe/krq6br/AkCJ3MoQIERnHESoPQcXmjDtq+eV6Mcad0
 eBSlnTBlpg7eqyraxGKHCoop04pHdi4TO8aZxKv1OqWavy6Y6+e3VSvOF8qO+3aI2Ab3y
 MQ2PV31c6hp7iDoZdjsldWSZ3PLCaNHeiV3hdDdy59k8OubPEIe7Zy+oLf6rJE/IzEzBL
 xA8Wnkg9xYIChs7/Qd1WJgVjtutjnSNnHdcD85wFY8V5GSMCxxC3LVuB2UEZYZ6h7dEHQ
 nWk6cj2O4bVsm+/2fM2cV6ZwoZMJ9fjQn3h/bzHGBuwg09jvDi8hCiweKCCA/HayhRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652594;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=rLGAFJrmgyiuq06UVBRxIZyX8aiEHrvmEjnTnEmt/hM=;
 b=jkqzmhbrR9l2PcE+1NzN5V4bbUTH95c9XtYyrof+zvACD3cqegxpp6oXWc/rgI4FVPYe
 5dxL5sfPsUqj1TJFOBCw7NKUVaQcKfxte1HmFFS0aMhwqScCV9UAu3yzHmCknOAVcUxPZ
 ikC2bUzmP5vmNBk82fSHLAsYTVyIS5pxcXQYQj1jEbgSvfWDAfYIssrsKDkIVI6VOLHij
 rIxThCeLb9B4VK0iE9oY72Hr5VflcS8kLD0IPzmO9a7fQ6QMmyDZgWgwiVQUpEUcZGnBY
 afSxtmEIibMepmGQOxnENSlPD6tjpzf7/EvL8o9hcGcmlmv9JL+yvoEE8f6HBoy7G0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=inXcyLsM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sn125164@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=inXcyLsM
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 792A1605EA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:03:14 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b21cf1a580so1558309a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652592; x=1793257392;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rLGAFJrmgyiuq06UVBRxIZyX8aiEHrvmEjnTnEmt/hM=;
 b=inXcyLsMCmNacZyBp94fV3KW2+kWUjNaVLUmzzlZfwb5IPiUSiU6cAk4aEHstOqFmF
 Z2quRruj3Kco57FPHAbM5bnZqgUS1yuyiKn7/P1GPKAJM/Kn7EmX1vjr9GZEf9spcbVy
 bqDvheiGcKiYMhu+6i3zUHlTIde9bkfimRZtdRpoMqKzFrJigOkpDJ0A9sngPsq1s1H1
 OXUJCY1i44lib9Ryfe0YHRX/AwLiTL9cXqzPIJLx+IIV1Hpr+4t03ADBCzeeCfVo35qM
 O0Suib/SVzjrL0ICEaR0tcTe+C8L+7qYWYmGiPO5Y9MZCg4jHvFqqPAeIGYl2CQSxTK4
 wN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652592; x=1793257392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rLGAFJrmgyiuq06UVBRxIZyX8aiEHrvmEjnTnEmt/hM=;
 b=bSKTPEiyFk9k2WrV7+2XWjacrRpWuce31R0qxiHsFCiBiOH9qrotXVexPnXphZcRgs
 AaAWGJJwgisXY1onBkhib0+Gk3L/1OjaxcdJPrhn3pPGda9b4VYaPiVgECjbeAXQhWnY
 vLxQsJfvnw/1aL45Yl+kStOzryqJHxlqPbXR3nVYLWBjsVSm8y4FqD5wtGPBhwU7P1wa
 ARLOJxGjTTTUn5NJuT7ZJgPAwwL4et5jt2unMz9tH3B2HPMl2CUN/RM11Ihq3VZkH+Dj
 KnCXwIhXu6VkubLFpq38iIwRDom9GsqbOkHFuQmdPCzfW+xpSFPmkszVw1ERvbViCLnD
 DioA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWwzuv6r9nFmy1qT0r6Pfo/xBqGPFzG4jVaefVesxvGWDCi4QjtBsKxn1o6o9ZCzPpHwZZsDk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLW1Bsad/LEphqdEQXt1NQ5nUpdHt6VYFA5Ln9XGnJpK5A7Oe7Q
 pOEs8oSWkhE6gSezAh94JDVffatwoPEUzMOb0JJKntOP8quDxXSTzUd+
X-Gm-Gg: AYBFou0brB3EFN3yNqYZZppsWwhkbcohNZmfseSMorYLTEyujL01XmtMZtT2YucEX0t
 5bhbefcKXe5+8dkqKD+s6a1t9cWsqE5eElFz4pMLhzyC2rCT7BiuJs37JyX3o0c26UsmsmvyPuZ
 Fw88Hs6ntrrvYPHWKpPmlcOE0ya5LsTB/e1QqxcNOf/jiVXyobbczwVLzSm1zQ0odf2whMEYIyu
 8dZxuGvd1teLifjgUyi6GRtFTsh5iCuyr7GhuE/uELUyJlMSlKy+YsRHgYpuDD/Qepg/E4SQvCq
 y4Y/aN5UwtlNzAEy8+kpVGGn08gOUS0pywoBMD05Ic6FVdcOyzIunIueR3RIMMmUEndOrAz5sEQ
 YpODDmB8tsRo5n1zmJkXBX8MR9wNoJNR3XzQpwZex5K1nieWsfudCA2SvA0xKPMAMQH2pWxM/Es
 H7lBHxYITAaQUuKXK2URy/q4ELhcEHcSjOOgzj5xxJD60XOvFAOz4JgM/jcNYyXW0nxikz784HZ
 qBlhbSnUGG1hyyhn2c7VTvKd19hmv0grsJ4KOGf1BgnLWe6SndvHn35a0cgjsK1TR7zN12gGT1t
 CIi8Un66PRgh0Jx2Wur7ob6hRrpRA0ar5/5Lh5aoCEAn5NQwekkScfo89VCC/NJQKX+8RJ1Q
X-Received: by 2002:a05:6402:4406:b0:6b3:e0f8:4016 with SMTP id
 4fb4d7f45d1cf-6b408dae445mr3749425a12.6.1792652591979; 
 Thu, 22 Oct 2026 00:03:11 -0700 (PDT)
Received: from nixos-macbook.taile68cd7.ts.net
 (20-144-89-188.ftth.glasoperator.nl. [188.89.144.20])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b402f2c2dfsm1518409a12.1.2026.10.22.00.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:03:11 -0700 (PDT)
From: Jacob Procee <sn125164@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Bin Meng <bmeng.cn@gmail.com>
Cc: Jacob Procee <sn125164@gmail.com>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
Date: Thu, 22 Oct 2026 09:02:10 +0200
Message-ID: <20261022070211.128370-1-sn125164@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 07:27:42 +0000
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xhci-dwc3 is not removed before U-Boot hands over to the OS, so the
controller keeps running after ExitBootServices or bootm. If a device
was enumerated by "usb start" (for example by the default preboot
command for USB keyboards), the controller keeps polling it.

On Apple Silicon machines (tested on a MacBook Pro M1 Pro, J314s), a
USB device that is connected while U-Boot runs is then not detected by
Linux until it is unplugged and plugged back in. Running "usb stop"
before booting avoids this.

Add DM_FLAG_OS_PREPARE so the controller is removed before the
handover, as was done for xhci-pci in commit e3bbc1f74e05 ("usb:
xhci-pci: Add DM_FLAG_OS_PREPARE flag").

Signed-off-by: Jacob Procee <sn125164@gmail.com>
---
 drivers/usb/host/xhci-dwc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 3504a7cf4..92b311d42 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -256,6 +256,6 @@ U_BOOT_DRIVER(xhci_dwc3) = {
 	.ops = &xhci_usb_ops,
 	.priv_auto	= sizeof(struct xhci_ctrl),
 	.plat_auto	= sizeof(struct xhci_dwc3_plat),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_OS_PREPARE | DM_FLAG_ALLOC_PRIV_DMA,
 };
 #endif
-- 
2.55.0

