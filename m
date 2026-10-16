Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63058CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE83381469;
	Fri, 16 Oct 2026 09:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 72RB-9DvO8ls; Fri, 16 Oct 2026 09:06:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E69E81460
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792141593;
	b=B2nL6RYtaSGDltZmasX8vR8YoNpzeBeGdhUH0YZrn5xuQkWwUgOnOjHtaqNlB4cs2R/j
	 q20mYC9ZKJVMLOnFyd7pwvFzmRRYMu8n3+XIIlxisOsXEgMdTLjyuWz6hV7GIy/JjbjAn
	 zs3h61bvvPhvrkbAtpTPZewlfMKS+cmNemHd2WhkB+nKXzySQLwNo9RgxfgpA9mvEpDQA
	 MB+Tg3vCaxYEpl5ZrYOah2WVBJzm4jiP2QdMJKmmtOCXRglNCWBW/cv44780N+PIsU/IQ
	 cfK4yQaICNzXnrmuDeSlAEG7QAcuhj6+rLbTuwFdUbUitYCQNFT/+l/9wa9NvQ4HABw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792141593;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0CYP5ayXJj9BBoEdvx4FbCsFhdNIep9pXHpo2/Db8pY=;
	b=hR7j5lKChfyLWPBRPDXisf2FoeFWC+X9DbMR77WJpUp2xIg5WJdq1za6qDh95GJhwuIT
	 Lec/Nqs/CjwBWkqDkq4HBkYLAIGGhD/+jJ3idtNCkVlBEeBzeIx6K0wz3oQ6CqZ4G6m6D
	 L2hGRRlpJNICjJhGq116m9cMfRRxNe1T4MSIA4ksoX9q8zn2OWk8g8XtRIWcFTbwahDPg
	 /eyfVIUHp07XSMT48l3ZXV/Sg79mvrns2r4kBU+bb/qCZU9by9hpViHPxa55ljzH4JpiH
	 cc0hLWSIFdZ5MbNhkpXIHK6Fs0/dkE4LZuA7OKdmTk2UrylX73VJvXk+9IEhrvHQS3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792141593;
	bh=0CYP5ayXJj9BBoEdvx4FbCsFhdNIep9pXHpo2/Db8pY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W7tV14zWQhGgFStQc4FhecN1H8195OGOGI7OlQkkIF5v+N180NHYyiQelOMDcruAZ
	 xb4M1u5L4PcWSTpeTd9qkHJESZLl0k8dCBeG0VEeBEsXFcDkgn4O0ECP9MtII5YbWA
	 5Ez/XRavoczlCP5RLPI2NGAhTRDlHzwQsyOiunQhU4XnivfAKJuS7IY+NTtQDfldoe
	 yCcP/2SX2o0ClzwANu9rAYJXlWmvpnAYxpvf0tunOxt0fqy78wuRUb1mHIUjES4PVG
	 ZAMh55588qt0KYr2xHEHA6bcrNnskdpi/S0stJEYVDEG0iFUdn/uFpIUvtZXt5Eume
	 B8/KWIwG0/s+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E69E81460;
	Fri, 16 Oct 2026 09:06:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B06B79D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40E6E409EC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 91doDUmyS6qd for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4638409E5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792141589;
 b=oSPDd93obSNc7sT/o/notc1f7wkhingDAeXPSNtnevlwlrs3XA0VcqeTx1CkYJVt9l8L
 R7pfoULuDXvSh+hTTwu6sYxT+5SjZsT2AtzU4IUJqsJ4+nNS/rM+HLYCOdWAIOTrr3P2X
 nVg0RUmxmpbPZuj0Uth9z8h4ENT2OXITlrqHL/TQDJ3WLRyERe2T/i7dUDBKrObi35Nu5
 SpuyE/fCH8vekrHbyDXlzs24rjn/xujVMaWcbLmS/TREmGNNpc6TJPKZLVjOnlFxQFybN
 C9xwKafgrzt4hnSSwIxWycudoYV14hBO8FtUfU4OZSuSXv0zYj1sbLj0CzQ5Zx0DsrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792141589;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=0CYP5ayXJj9BBoEdvx4FbCsFhdNIep9pXHpo2/Db8pY=;
 b=S+Kmz64E6xqWBJrMjldlwnQrUOguYTJzJ8hScablqJDrmZST0B3/LrFjbWL7iE8boYYg
 rCNP9lzORjoA2XTE5N/g9U7YdxjQjtaIKRwM1ovtabv++7EcwwLmRtdzix0EK3Z6J26TN
 oYKKqNOjI1m0AF1ztXxM9RXQqgFsJznavqBFApT5qszncnL7YJiLSnUaN0svLtdublg2c
 iumk0wMCZbrdDDqoeUaNLMZLXOpf5P6h34S9yJj4rgcr+HkOPYgCOstVLkoTf+44qxP7Q
 TfXCPHBXt7UOpHN2OC2WyrGmHCAGCJg1twHlsWrMs/PtLXUNBzz7Zz7wmsYTKhnw46w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="O9/bwybR"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=O9/bwybR
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4638409E5
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:06:26 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so52511915e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792141584; x=1792746384;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0CYP5ayXJj9BBoEdvx4FbCsFhdNIep9pXHpo2/Db8pY=;
 b=O9/bwybRx15ETwxb64dYOx2LtwdlD/dCxVqWVNUFW4M94Mx1QRNiUptBQpowgqSxjc
 R5Mx/6FSbszFI1agWUeBX1OWE1PwGPm+yqgYAxCF8MohLbBAUZTws1oJWMXUEWC12PH3
 ijocVF+qrGOT/fDnkLUgSSr7zQ/Zxi/Feau2FN4IE56AoXnhzA+Rdgi/9oywjup1XF8P
 uMHY4veaAVR2pk0t72hcsbnV7YOlFGijG2m9HntfMd5BH2NZG6lEXR4obGVoTNW6t01o
 Q/fTIcjPZ8qW8RJVbeZI3GeIXCWwb6r9dj1XmzmKvhvipXcdwJFgnPjUEk+8Fk7jcCIy
 HwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792141584; x=1792746384;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0CYP5ayXJj9BBoEdvx4FbCsFhdNIep9pXHpo2/Db8pY=;
 b=OkWgiH1lUAABM0EPAEPJ5SANc+QUnlK0hzXSA9C9Ucqp6yTcHXQqOA++C9CgadGvJo
 yfWKOf4IhL1W2+ooiB0lW87X4ixM8fxNY1tPof+W8Y9BZT4T4uCRadt38JEWaUKWmc4D
 vPpSq+Lk2wJiZFPPvgb0gXnRlp2ABhyLs8bj7qvqxlYBkY7Wp3OiXC+G/6LPDzYkDu17
 eE3//Z+7fmzdHK+Xpe/sg2czZKt76AOLpICxcsYuFvmQyyQqXCZtQTQJp7Nq1H6xXXPB
 e+AFr5RiCfpE2NTYtGb85IHJ68OdyrlF+OQUt3nNIm4iZo7w8nkVcpDTuS5Teqg9Wput
 kOeg==
X-Gm-Message-State: AFq9FYJkLtYu2aYYhWuXaJY+IXtJVwe3ezu3T8pzvxHW6xJvFdOHFKSU
 Q8oFZGcGZyP5KCz8H5/uPy4Hozk8x1WatgduFOArZ3trem7QoyZAjI1DA7iO1F2NSD6E2fnGrRP
 mrN8r
X-Gm-Gg: AYBFou0YP6O5uLrD47X8fid7VMubBHyXPk8bY5D5dJZ3W9ecstMvRqB6zoegK3MaWiN
 WVD7714T4hw2+QiVmGBGBzmsLr2/cCOO8WwD0j8D8CbjikmmlRCdgB4Cln0Fw2h2PQetXysb7+/
 Jm7+f1ljv8GLT1PZZ/azWa1Suz5z/S177yenBBIXbWBU1QbGN/PZNVfWe/AGj+uMwNmkg+UuWmZ
 kffAx+yOlqwsBF8LYX4tLovZu6M1hDrLyrBLhxmcjMasBZEDGu6G/ZFKd0rS0rZJwUvL6bcn6Ol
 SurbsDmhi7WaSPG7lneYodhyVC7f9REqhb9VVxIUHaAKbHideSAFtN07amQdM/UXJqOUehg5Dts
 vBrrXN2hCjiJY/FMGfL4fOZomGQHCm4TRxZ+tPL0v612EWYX6KFyOyBB1xD7GGCgpZvv52xwpVl
 4yyJEeNYLK3IisGqZ04AOPAGnzPiIRvJdr9XiaMHlS3p1kAmwWUz6JvpeicZlFcKEuAm7j9ZnB2
 wLIXXIrhnZbUjE=
X-Received: by 2002:a05:600c:34c4:b0:4a1:b027:99dc with SMTP id
 5b1f17b1804b1-4a1b027a161mr216894755e9.18.1792141584313; 
 Fri, 16 Oct 2026 02:06:24 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm121287685e9.0.2026.10.16.02.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:06:23 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 0/5] K3: wait for TIFS init before CTRL_MMR unlock
Date: Fri, 16 Oct 2026 11:05:51 +0200
Message-Id: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO/o0WoC/52OTQ6CMBBGr0K6dkxbfhRX3sOwaMsgo9KSFgiEc
 HcL3sDdvOTle7OygJ4wsFuyMo8TBXI2gjwlzLTKPhGojswklwUvZQrTfoHgYHEeYHA9GVBdIaE
 NEBAammG0H2fe4JVBEHlTqyzLZX5BFkd7j1E5go/qx2HULzTDXtmNlsLg/HJ8NInd+zs+CRCQc
 l7Xumxyjde7VsuHtMezcR2rtm37Aj/bhGoBAQAA
X-Change-ID: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=msp@baylibre.com;
 h=from:subject:message-id; bh=8kW4VN+2iDBqjG5lxMsyxjYDogJu+W5/2LSYU3Eo1RM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyLLz6GJE0518wVfTJWIHf7xe7HTbpu0c/C9C7VcKZ/6
 dJjylHumMjCIMbFYCmmyNKZGJr2X37nseRFyzbDzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 QIaOEQMXpwBMdQsPwz9zy5i0SxVLp3XLb5JcajV/SeEf7aRDTdG/l/mEFF2Sce9h+M1avWvl2fB
 rj7ks1rx5bOkRt/bCwawlWoIzuS7eOZdwkZ8XAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Hi,

this series uses a TIFS barrier before doing the ctrl_mmr_unlock(). This
specific implementation works for the platforms where TIFS is already
running at this point. Note that other K3 platforms may have the same
problem, but for these this implementation is not straight forward.

This series is only tested on am625 HS-SE. I don't have any other HS-SE
boards.

Best,
Markus

---
Changes in v2:
- Create a common helper k3_sysfw_wait_ready() to make the purpose of
  the get_ti_sci_handle() clear.
- Extend the series to the other SoCs with the same boot process: am62a7,
  am62p5 and j722s.
- Link to v1: https://patch.msgid.link/20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Daniel Schultz <d.schultz@phytec.de>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Aristo Chen <aristo.chen@canonical.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

---
Markus Schneider-Pargmann (5):
      arm: mach-k3: common: add helper to wait for TIFS initialization
      arm: mach-k3: am625: Wait for TIFS initialization
      arm: mach-k3: am62a7: Wait for TIFS initialization
      arm: mach-k3: am62p5: Wait for TIFS initialization
      arm: mach-k3: j722s: Wait for TIFS initialization

 arch/arm/mach-k3/am62ax/am62a7_init.c |  5 +++--
 arch/arm/mach-k3/am62px/am62p5_init.c |  5 +++--
 arch/arm/mach-k3/am62x/am625_init.c   |  5 +++--
 arch/arm/mach-k3/common.c             | 10 ++++++++++
 arch/arm/mach-k3/common.h             |  1 +
 arch/arm/mach-k3/j722s/j722s_init.c   |  5 +++--
 6 files changed, 23 insertions(+), 8 deletions(-)
---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
change-id: 20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-15fda445257e

Best regards,
--  
Markus Schneider-Pargmann <msp@baylibre.com>

