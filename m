Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6D3FB5EA6
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 02:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7992883EEF;
	Tue, 17 Mar 2026 03:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MIoGmCFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D141083F00; Tue, 17 Mar 2026 03:08:08 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A0D83642
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 03:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a1273de95aso7755413e87.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773713286; cv=none;
 d=google.com; s=arc-20240605;
 b=BamEiedoy8mHPtZ2KHi5lqucZH7dOlbkWsLOpJsYDo5AABvtI7y06ZiaXdfraLwxV5
 W5zlwvceagH85WsT/O8mIyKHUPmkdAH9tCVxaluM6660kV5w3P3tPEBx3WS7FJa3cMR0
 uXSnlxT1sj5kNzz7JOCJzIep6gzE0BmzH7z8B2HJLauDbi8CeS9KSa1tTpdF7FdbMNoi
 pQYqgMY+LeV7Xse+5Qfs+NvZ0qpmxTcrWrSsg3S91YwR7RYus+sKTMBYKkbPhAD0Qf3x
 tUgteZBL/oBCyEvl7OwEX++aM7l4ZVpOUVjllIQ5CE6Z6zhrj+22kJ7GxVcFAO6Z0L1Z
 XRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=4KTbDEw1khjpzcEROR/5AGHOeihdqYKuJA7eCvBnbzU=;
 fh=aKblNjVg1Hrq9Sakr0z8H9o7dEEpNpZA3HjdzfVVm/c=;
 b=Vv13JfElL+7m5XR0LLUDPq2KO2rQDvfmt8Ow7mapVNTjpArTieuJioMjQH8FHHE8Fw
 ui2R2xVZ68NTs34ndRmxIkIDa/X26Ch28mvhRVkHiWCQqlAnsOgZnIy1cJpR7+Q8RC7U
 5+nNACVNOYhTm5TeVmiIoqv3zlXfPky06AVyjR3iYsDxJTIG40WJxLqiJyKlMYvSkd5z
 7KEoqmC24nXdTsWVELjSIfyuU16W8BqIJMzV3B62I8CaUnt3qHIOF8LrzaMtLkaSXmEl
 tl0E8SdfFG8iPLz2cUw9FB5idEUeLCvpy6WTLNF8rcOOvaAjnou20TQHsZS2uno9gL5Z
 KBHA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773713286; x=1774318086; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4KTbDEw1khjpzcEROR/5AGHOeihdqYKuJA7eCvBnbzU=;
 b=MIoGmCFhdfEPfBDX/G+P9YmN+KsJeCk8f9QS2dOo8ean1cQHlyhKbCTYTXzFLWJEqP
 9o0zDwgQYhYdj8o5c4UB4zYTXlH+9LpiJiVXPOqn1NYCrEy3qX34FKl0t7SvegjN9STp
 3S1RPMfWxCbKciYFNx3VO6ENEnbTru2t8WhhwUpkjFxTRitfnmjb12KdFQZnhcu+jRhc
 /zmTVjuLAqopU5jSuEgijfEEXrBRrB9jiGYPrdN8EV5ot7boOfmd1PmarN3A0ITFFlhi
 opU3FXAgpmDlSMpNilKNxjUqGM6M+/Mj3eAeySnjErCoK6DzpLsGiMxgqSCSwETN+XJL
 2ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773713286; x=1774318086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KTbDEw1khjpzcEROR/5AGHOeihdqYKuJA7eCvBnbzU=;
 b=ZTNdz/gCMRnpFkc5urzX+qA212LcSIPkDQwYWEwLMC5kg7kcCNYkbJZGrC/JNK7hVa
 ZEiWcAP9NHK9JIeZOdYi81IJTQ2sg+6RVla71JkJkjAz1DWmXzoLrrwAwKh3eDZTo8DX
 ZGI4KUzkbTCBtp526KdVMN5pBlrbnAgl7Ai9OduowWfLWXabEJIm4aO5Ehd6VBCOmR48
 v2BCSItGYEZ3Z9NLYLhJYrqisohU12kgjgaKlGrhWa3ppXucq+h73gxuYSZIhkCzFzir
 RMB2EY7K+j5zoWBklrD1pmfs2YQ+ZwwNRQ//rz4XZlFvC1oD+q9N9llVZAd85VZL9Wfc
 NVaA==
X-Gm-Message-State: AOJu0Yye7RYTfepW7VxXaDnm2UeUyHDSlSvLkFPInmRk5elBnUCQo8P3
 UOo4OVO6QmX7Tkt+yvW9r/q8RtIxb/LFSiDBo8GFK5o0d/h7N9x+psdO27GMIIgh1bqRjgeRTAn
 mX4/TycpvOAYx0J2nMx5uvLHd4XJ4rsE=
X-Gm-Gg: ATEYQzzTlw4SvthxSqSOmHRMHD+ThKvMvkfDZu2l9ApW32fWdJxZ+d8g6LP6yZhG3DJ
 NqpFOQYM1zHSFBQ3mUaIf1wtkLJlcUHA787WXFzCFlPsC41VipBCb3OGRwPMMcLKr/me9Y1vx9h
 GTYCsB3lAiKFPgPDOhVcsjEZPeLf94uGNFwQDqGsqT0oUUko0R8UD4C13PR2VITr+xby6Z2wR7e
 SAHox9OKxD19PxtCDlu/H/yD3gss+J+I4WCnJC7Gk3tfCHKtAM2+GCBdVovdXCzpZGIjONPXPJ3
 rCnGV38QWZlXMMdChs5gDlKD7zLkyFP9+T0Qa69J1uIrSt69BSkAt/Nd7RDIZcoKmkcpRy0c
X-Received: by 2002:a05:6512:60e:10b0:5a1:2cbb:a780 with SMTP id
 2adb3069b0e04-5a162af1a54mr3719450e87.15.1773713285525; Mon, 16 Mar 2026
 19:08:05 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 Mar 2026 23:07:54 -0300
X-Gm-Features: AaiRm52yBRb5K6vchVNUX0OLr2PwSETBNyAPzjFp64WcstWkPoIsc21232XIylA
Message-ID: <CAOMZO5D3yqFaDgriO2x3fnCrwGm0oV-chLsy3eOR2O3yg_MvNw@mail.gmail.com>
Subject: OPTEE on i.MX8MP
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Ye Li <ye.li@nxp.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

I'm trying to boot the imx8mp-evk board with Optee support.

TF-A v2.14
make -j12 CROSS_COMPILE=3Daarch64-linux-gnu- PLAT=3Dimx8mp SPD=3Dopteed bl3=
1

Optee-OS 4.9.0
make -j12 CROSS_COMPILE=3Daarch64-linux-gnu- O=3Dout/arm PLATFORM=3Dimx-mx8=
mpevk

Then I copied the bl31.bin and tee.bin to the U-Boot directory:

U-Boot SPL 2026.04-rc4-00006-geefb822fb574 (Mar 16 2026 - 22:51:05 -0300)
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x8000, =EF=BF=BD
U-Boot SPL 2026.04-rc4-00006-geefb822fb574 (Mar 16 2026 - 22:53:30 -0300)
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x8000, pagesize 0x200, ivt offset 0x0
load_simple_fit: Skip load 'tee': image size is 0!
***************************** Tee image is not found
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.14.0(release):sandbox/v2.14
NOTICE:  BL31: Built : 22:19:21, Mar 16 2026
ERROR:   Error initializing runtime service opteed_fast


U-Boot 2026.04-rc4-00006-geefb822fb574 (Mar 16 2026 - 22:53:30 -0300)

CPU:   NXP i.MX8MP[8] Rev1.0 A53 at 1200 MHz
Model: NXP i.MX8MPlus EVK board
DRAM:  6 GiB
optee optee: OP-TEE api uid mismatch  ************************* UID mismatc=
h
....

Any ideas as to why Optee fails?

Does anyone have Optee working on imx8mp?

Thanks,

Fabio Estevam
