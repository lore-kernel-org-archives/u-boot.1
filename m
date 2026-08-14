Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890ACC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:30:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FF8340C9C;
	Fri, 14 Aug 2026 18:30:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KvwaCqmiv9W1; Fri, 14 Aug 2026 18:30:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F1AE40CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732219;
	bh=uOkr/CjFobiYR7e5BtdhNDLouaWmQD+LadnrHSxyOYg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OEn677/tl+plIO4Rlt2d2znSPA5ee6SakvTcLv5eVna27tggYsx6C3DJh2/cPdNVa
	 gGKbzGJFcAr6L0Wc/PDGxNBhdmlmbqazrl5XrI3HHHpuFTDBydnALwvPf619mFfhZ+
	 NMjkNntN8kOhphClGtM0hsrttFBWcFdgySdMcgUFcJSjUyb3E3t5V1Cl8syeWS3A/n
	 3uFeaKhKwzQFMiPoEvAwYev4l5B14mpB9YQfl410x127CICjj8rCGN8Bt1YuWhd1HD
	 eDWDmoRq1+yPNWXPMwiXbEPCyoUBU5D6rgVata0rmRGCchO2Hqws2r58el8HR4G4iv
	 9ewlgxvwzAfzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F1AE40CDC;
	Fri, 14 Aug 2026 18:30:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B50593DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AA2B812E7
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXaN2QIIZMvw for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:30:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72c; helo=mail-qk1-x72c.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 77CC781011
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77CC781011
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wB3f6PxI
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77CC781011
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:16 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-93695893ac1so98434085a.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732215; x=1787337015;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uOkr/CjFobiYR7e5BtdhNDLouaWmQD+LadnrHSxyOYg=;
 b=wB3f6PxIvhoet+SOe7u3sCRzvZq8lZofWNX802nWMFI+fQsN39AmvgBqAg9REobXDD
 oafKH+p75syiV0r2Xt42zKwqasKPOYIBTmY1AkdkWorSUaFLcXnmeaU/UFAjLR5HvZk8
 0t2GrfUW/qXuQJGknoY+MWreyl+cW7pEv5QDlGHljoR82uJLy4S5cm6B1m0zwMoG3xf6
 MBgiW/4W5tqOwCelVyquA+wP5+kJk7/hMOvKc9jPDjiLS/IAnEBEyeMXrtzZfKGOfbAG
 LcYoL1E05yddH8/t+jQgqTgu48LEATJARCofeY1KN8YEX/+FAfovG5LDxdJ+HzoG80nx
 dEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732215; x=1787337015;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uOkr/CjFobiYR7e5BtdhNDLouaWmQD+LadnrHSxyOYg=;
 b=qm8/XmlAd9uTsb2Z3gUVCrHfidshCBmcdCJEsyKQGWMTUYE8YiCoA4ckzHJ3WckPfu
 mHQ/Rg+04xDgOJFxGaEHJ8gu+77rPc1/VFjPHkz78h5JSKJDhsM/4i4GoLGNbon3CEDi
 ++qEBA9mInaK0p6sp3TmYGYFV2dULYpWDxSizeRJTZbrfZFmMKV7F4NIVAU2UI0DfPh/
 WeifYuHFSUn6HuO2rLkanZouMqq4kmNtGc9EzMwwobOvawmu3Q0ecr68uEVaXuWIdWw8
 5lHPKzsSQtTp8YEKXRRDFQsVf/6vnkHxs8tt6Z76FNq41NAZ22GM1qTHsKKVgp+OXI6u
 2ZRw==
X-Gm-Message-State: AOJu0YyXMAtwVcERWeGcy8wPdJ6L7AXPAvvbLarCeaPEvNHoHirw/Rdh
 ueUVqnRuyCnHHALmsvhXuRfh84gb2U1cJr1BBW5chbbliQwjqIj0zMfy9WB/ISUCTWg=
X-Gm-Gg: AR+sD120ScZJt55Aky33hvfYcruQGlUCPgdlk0kwYke/eHTPp76GfbJdLVECliz8aUO
 6DKO7pR5H5gmhzhcLCSakCl2tFVOBV52ZdJENnl/9oXSdklsx42gKkQu5w9RoHZCjqd9YrenFvV
 +mTcoxV6Yb5euLAloWeK5GN+WdqSNqmF+9cT77AcfzjO3nB78fib9GZuEOcsjC0iGc5LTAYj4O/
 zkcLzCLDmlHKWt+c73eYkU0Z8OrsutXZ+Yu5o8lp8FpEEXw6dB8DlvqEcHRD4tboJ22p43XhAW/
 Ulq2xIJ8DJbM/HtSA+TViTpbomD3ajxsgOZwOPZ9Z+hSPrWB1fArpNDAdm9qAs98lPyGQf6dZDA
 RMcHVYmD/gi09+kq0P3M8EO5siH/wM9qW4kDoHxKNmTG7Bk+4AfDJeU5C+SKEbLRrejPup3/86A
 r6mU82OQH6/vBi6FYHk59T1bTtajsJCU5OG9pLNnnxqLckL01gpBouCdkIKLdhsA0PMKkzTg72j
 hMXcZep14CpX3Rh5QR92DrfcWZNLEuXBItOC1QzD3tPnF3/4PolRTgz
X-Received: by 2002:a05:620a:8017:b0:92e:683f:48e2 with SMTP id
 af79cd13be357-936d2391333mr774960685a.32.1786732215219; 
 Fri, 14 Aug 2026 11:30:15 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24d0b5sm324606285a.45.2026.08.14.11.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:30:14 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v2 0/3] net: add RZ/N1 ethernet drivers
Date: Fri, 14 Aug 2026 14:30:11 -0400
Message-Id: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALNef2oC/yXMQQ5AMBBA0avIrE0yrRBxFbGoGoxFSYsIcXfF8
 i3+vyCwFw5QJRd43iXI7CJ0moAdjRsYpYsGTbqgUin0p1P4ChWh4xUNlWRNT3lW5BCzxXMvx7e
 sm99haye26/uB+34AQ3jR+3QAAAA=
X-Change-ID: 20260811-rzn1-2026-10-net-a080caf05365
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732214; l=1544;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=X3QXythJDAyn3wUuR0fANaVWzZsSxI5HHd+nwYV78zY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QALqExk2/9WQzUfCK/TWctgDgcVZboADN6yAmOGglNrNVskXROZVp6njmDQMDFRjYzHazJFNYj9
 GyoC35f3RSQQ=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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

The Reneas RZ/N1 contains two GMAC supported by Designware driver.
An additional compatible string is needed for this.

One of the GMAC is routed to an internal 5-port switch, which needs a
new driver (A5PSW). This driver is adapted from Linux but simplified,
only implementing basic port-based switching, not full DSA.

The second GMAC, as well as the downstream switch ports, are routed
through media converter blocks (MII/GMII/RGMII). A new driver (MIIC) is
needed to configure speed/duplex for the converters.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- split out of the series "Renesas RZ/N1 additional drivers"
  https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-5-af2ce80db9d8@linaro.org/
  https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-6-af2ce80db9d8@linaro.org/
  https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-7-af2ce80db9d8@linaro.org/

---
Ralph Siemsen (3):
      net: add r9a06g032 A5PSW switch driver
      net: add r9a06g032 MIIC driver
      net: designware: add r9a06g032 compatible

 drivers/net/Kconfig      |  12 ++
 drivers/net/Makefile     |   2 +
 drivers/net/designware.c |   1 +
 drivers/net/rzn1_a5psw.c | 377 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/rzn1_miic.c  | 193 ++++++++++++++++++++++++
 5 files changed, 585 insertions(+)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-rzn1-2026-10-net-a080caf05365

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

