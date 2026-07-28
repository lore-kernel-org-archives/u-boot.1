Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9CBC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25BA160887;
	Tue, 28 Jul 2026 13:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xvstcc3MUXsl; Tue, 28 Jul 2026 13:00:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 079A76089A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243614;
	bh=sxXNM6GvqRDPVE6nMT7RctCbhj5aWoqu0KrCIIoqh+c=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cxFRFIYOd90VPMRPVNS80Y4ChGD5IC9MXD/hFNOTXXm+so4A04GfkuUJjrqWHhrxE
	 jUzQd8eKf7/Gi83A2cj/gKN7kU+ai7uKonhyYBDSgwqOXBDTMHsaT9+GWLxIZ6f8hS
	 LgINF7jy7fp4lA8k8lAx0sl1HToKLVACnvw5ocqSYVa3BicjSJuMBb0Fsc5xNZe/AA
	 A9Ms+Jrbg4kKYGaCeFNzxBhIFc0j8TO1KLJ28X1KFj3GxCW/v2tcxPQWoY+MZM7iQe
	 Yvvt/833E03AwSDxlNpXpTCllXHrb8YR4gfCGzX/8ZKc7ZPxH+t0qKr29yw6u6JkZt
	 ArhNgoPzc8PnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 079A76089A;
	Tue, 28 Jul 2026 13:00:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 307743B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 16A6C40260
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIZsN3Q8xbhG for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 07:43:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=shahriyar@byteray.co.uk;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 270074004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 270074004B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 270074004B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:43:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B61884974; Tue, 28 Jul 2026 09:43:16 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F30A82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 09:43:14 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so351114466b.0
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 00:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224594; x=1785829394;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sxXNM6GvqRDPVE6nMT7RctCbhj5aWoqu0KrCIIoqh+c=;
 b=FkWCwb+tuCp7eUxX9gQ5XrOUWCmVBc+YsZvsPmtZkW1xCsNZkjgPd+iVLy5ytEo+Jb
 gonx+GV4+JhvTyle1UF9A5rluJ4Ze7uNLN5AuyBUhzO0EvHzSFJrv+NnBUjRbDt0Lb2w
 dW+RMJoO4oibdqid4G7/pis9pCaUcdg0ZxHwEZnrjzkb8bGC9QqBs/TH5LUrjSIKPWwx
 68ro2UVz9D7loEoepFSggtNdIc4i0IfpCU1GsY/qPrp/qO7l3pOEtrPbDL3TQoqa3gCx
 zGsN352dlfBxEgyMh0Dfmg5OFnthJ65zK9RYgIKDeJd1vHx3u7HkLoXMwvi7uY0nDukG
 8WCA==
X-Gm-Message-State: AOJu0Yzt9/PIYjjUHIopdCB2UX7xwRKQYD3VWq8Xed8xxItnCwDXXnUU
 zFYHWj+OVrmpR+F5fdw5fQhd7Zw+aSmJj9JCFMIybAYFZxZQ0MQ3eB5wavRIkIqTX0E=
X-Gm-Gg: AR+sD11H1wRSnCZG5VxHFl0gX2tPE2jB2uM6eIxBDNIdN1AEIDtaKeM1Kj7pXoPSw7r
 PTJ40FlFk1vnC7CnE/pZUtY4+7w72WvKmeh4ejbdLFoh91jIwVtkm5ScwZlQ1DKUUQ8df/Xx9Qx
 i3kX0OaoEMJj52BLqUsJDkkXW1Bfh3A7Oe4X0GmFL1hOzz5tOtPQyGLfU4PZz5+YfKUWC+96EdS
 HHmwAqNhv4V+Ie66GLI8ipUOCq8Qm0hTnmu6ZYPuKzqD2z2UZ9xqmm5ZsKfr9qcQxoYZat3Oe4R
 PNRHO32LNmwthi3sdVXk0A1P2TLICDOFJ2l2QLGC1ljBPozQmqnl25eC9UlHuoieYCHITyBK2Xy
 3MYT/nkCh76QVXJQMws/Cdz+EmU0XoU/I0s0/Z1Jz9zokIxGPMsJJhYlD1RgyfS+ykKq++1tfLb
 H4kI6DrP87x7at7HmbfiPMbV/9beyt0Fb2I3wTCcFFQk+J/3CqEmhbpZkki7QlSl5eAqg=
X-Received: by 2002:a17:906:6a1e:b0:c1c:1e8d:f8e8 with SMTP id
 a640c23a62f3a-c1f727bc91dmr53047066b.56.1785224593854; 
 Tue, 28 Jul 2026 00:43:13 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90205sm725093766b.33.2026.07.28.00.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:43:13 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v2 0/2] video: bmp: fix out-of-bounds write in the RLE8 decoder
Date: Tue, 28 Jul 2026 09:43:02 +0200
Message-Id: <20260728-video-oob-fix-v2-0-97162af76510@byteray.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIZdaGoC/3WNwQ6CMBBEf4Xs2SWlQqGe/A/DAcoiqwklLTQSw
 r9b8OzxTWbebODJMXm4JRs4CuzZjhHkJQEzNOOTkLvIIIVUopQSA3dk0doWe/6g0iZvSqmrItM
 QN5OjGJ++R/1jv7QvMvMhORoD+9m69TwM2dH75w4ZCuyUzq+9qkpTiHu7zuSaNTU2Xd5Q7/v+B
 VhVzDjAAAAA
X-Change-ID: 20260722-video-oob-fix-69c4a7298519
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Wayen Yan <win847@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785224594; x=1785829394;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sxXNM6GvqRDPVE6nMT7RctCbhj5aWoqu0KrCIIoqh+c=;
 b=SLIXaGdmT1V6JNn7QsAVO1uCLLwe3p82jZoMzGSk7jPsvI7vCtNhRMsuqvLfjIqmN8
 bpreyvzN+BUAfPzyFc/g/JbHeZ9QP7iHmP9Z7x0NrMFtZINJHSPRAP9f05IUWVGGSsUq
 DN0KLWFSRtyBkkbhrTYpB8sB8eEvp0kVGakaewkOkI2b9FuD1bCY5+GIydOmPw1Fdu4/
 8xsdHWqfVbsP3LuCNwB53xCRAHNBkw5u46yjJfu+X2jqgnrvrFuXLKzYpy9kDAevrl++
 L4TqO/eBO3hOtlR/Wmrc1xWZbpqAnMbmy4vwAdhSx8xMUANiJys21GMHgJs1k+R8fR6A
 IscQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=none
 smtp.mailfrom=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=SLIXaGdm
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=shahriyar@byteray.co.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.b="SLIXaGdm"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This fixes an out-of-bounds write in the RLE8 BMP decoder and adds a
regression test.

video_display_rle8_bitmap() lets the framebuffer cursor drift below the
start of the framebuffer via repeated End-Of-Line escapes, so a crafted
image displayed from the splash-screen or PXE-menu path (loaded from
removable media or over TFTP) writes before the framebuffer. Patch 1
bounds each run and rejects such an image with -EINVAL; patch 2 adds a DM
test for it.

Based on v2026.07 (fdfe2ec48d5c).

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
Changes in v2:
- Use my real name in the From and Signed-off-by

---
Shahriyar Jalayeri (2):
      video: bmp: bound RLE8 decode writes to the framebuffer
      test: video: add regression test for RLE8 bmp overflow

 drivers/video/video_bmp.c | 26 +++++++++++++++++-------
 test/dm/video.c           | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 7 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260722-video-oob-fix-69c4a7298519

Best regards,
--  
Shahriyar Jalayeri <shahriyar@byteray.co.uk>

