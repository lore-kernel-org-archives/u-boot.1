Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B861E6ADCB
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 22:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53E7E89893;
	Fri, 22 Nov 2024 23:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MCpWfBil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E05089836; Fri, 22 Nov 2024 22:56:18 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7630D89265
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 22:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alansbor@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so45760301fa.0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732312574; x=1732917374; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=R59ah33mPtSiDcZGqTTu9hJXlFfjhGDvEwi62fN1/q0=;
 b=MCpWfBilBx5a2DgCLEPFnXRIHc4pQeuzHw4bAA8cpaEHZHiHElnaXy6gpePYaiQSPR
 jGRkk5VWw1rElRmqbHQNJf8G108IP32ubCS51qHpxCZJy3Y8AB8AOT3WkPccP8SPaBWW
 /NW9AdbfV0deZpz9wkmp8+hzS5EvQSMWq+RhBeF3gjT6yKheCvTWlNYTnM8E34P/s3xN
 AqT7WqPwUO8R8RkWVsSTcOQsXV3IBUkKWCwxWgNUi3kULv88TT+WapoOffCVuCLffz1d
 zcjb9NN51vSoXfvaMGe/PR1IkxKN0QzyOZaH7Ya2MlXCuIgJyrGxQTNERI6rvfSp61j7
 +WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732312574; x=1732917374;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R59ah33mPtSiDcZGqTTu9hJXlFfjhGDvEwi62fN1/q0=;
 b=T4Tkf0HwKLCcBaZTJ2w5rXsHc28fjwI6fwYzck4rhhZT8j6TVp+VTAjTaihA2cLBJJ
 HqhCLAFfdovTFLFQ4/kYH4gmGdLmzPMrPB12fD4oIrcA5X9zIw0yOa+nZXilojhI2Vzb
 Re8xmoZSzLOPIQPY9yWeYYCxhafKwyRcAdGnliCCmymn6v5WRQ/cdmV6fjwwxw+u8JwM
 4kFLs60QICYQapUoiDiR3ZDh43E01tUajJMh2ALo/4C5U2R66PMpbjwcyTIKwVQMD+oF
 eIM/i0LHVdnaJ+CDsVN3QCigpOAcVa4Vxqpy2K/pzh6ELQi4tmizY/IC5iAGUYNTqyJx
 5htw==
X-Gm-Message-State: AOJu0YwW9JSR0hBM/NvJhDJfetuM+S0peVAy1DuX/RShMJ10hqoVJINd
 bik43prj/wayC6bavygau1K82GfgocFKoU+j5O/fCVB3N9G4rTN5avhNk98DFTUUhjot/8F6Awo
 6IdOfvoQ7fBCAwq9XcisL5InbFgsAowdH
X-Gm-Gg: ASbGncvnxl6tG/HiZ1N1Fl3y3n7v69Vha3HrdJj83mBpTAJFIk55c54ZRU788sKyem7
 DbMTZ8bRXCfz67nX5Wb+EecTUZiT6gpHG
X-Google-Smtp-Source: AGHT+IH5lo+O+m/sJd4kgz/g4cEbzgyJ/cNzgYyQP+1n6eVA5TF0npLpyu+cpReydY7Ix3A5FhLzJb/vQnVYEhtZOKQ=
X-Received: by 2002:a05:6512:3da2:b0:53d:a504:9334 with SMTP id
 2adb3069b0e04-53dd39a4e1amr3284872e87.44.1732312574117; Fri, 22 Nov 2024
 13:56:14 -0800 (PST)
MIME-Version: 1.0
From: Alan Gold <alansbor@gmail.com>
Date: Sat, 23 Nov 2024 00:56:03 +0300
Message-ID: <CAC5F8-u4d94T39J+7US0vh98Ut4QEVGtsPgQXT9btBZL7bn+FQ@mail.gmail.com>
Subject: U-boot TM7621A MEMPLL 3PLL mode calibration fail
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 22 Nov 2024 23:24:50 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Report about my problem.

Bodhi said to send my report to this address

main topic thread here

https://forum.openwrt.org/t/u-boot-tm7621a-mempll-3pll-mode-calibration-fail/216299

Thanks a lot guys!!!

Alan

===================================================================

     		MT7621   stage1 code Mar 12 2015 14:43:30 (ASIC)

     		CPU=500000000 HZ BUS=125000000 HZ

==================================================================

Change MPLL source from XTAL to CR...

do MEMPLL setting..

MEMPLL Config : 0x31000000

3PLL mode + External loopback

=== XTAL-40Mhz === DDR-800Mhz ===

PLL3 FB_DL: 0x14, 1/0 = 609/415 51000000

MEMPLL 3PLL mode calibration fail

do DDR setting..[01F40000]

Apply DDR2 Setting...(use default AC)

          0    8   16   24   32   40   48   56   64   72   80   88
96  104  112  120

      --------------------------------------------------------------------------------

0000:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0001:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0002:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0003:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0004:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0005:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0006:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    1    1

0007:|    0    0    0    0    0    0    0    1    1    1    1    1
1    1    1    1

0008:|    1    1    1    1    1    1    1    1    1    1    1    1
1    1    0    0

0009:|    1    1    1    1    1    1    0    0    0    0    0    0
0    0    0    0

000A:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

000B:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

000C:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

000D:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

000E:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

000F:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0010:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0011:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0012:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0013:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0014:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0015:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0016:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0017:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0018:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

0019:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

001A:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

001B:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

001C:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

001D:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

001E:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

001F:|    0    0    0    0    0    0    0    0    0    0    0    0
0    0    0    0

DRAMC_DQSCTL1[0e0]=1A000000

DRAMC_DQSGCTL[124]=80000000

rank 0 coarse = 8

rank 0 fine = 56

B:|    0    0    0    0    1    1    1    0    0    0    0    0    0
 0    0    0

opt_dle value:5

DRAMC_DDR2CTL[07c]=40001253

DRAMC_PADCTL4[0e4]=00000005

DRAMC_DQIDLY1[210]=00000000

DRAMC_DQIDLY2[214]=00000000

DRAMC_DQIDLY3[218]=00000000

DRAMC_DQIDLY4[21c]=00000000

DRAMC_R0DELDLY[018]=00000000

==================================================================

		RX	DQS perbit delay software calibration

==================================================================

1.0-15 bit dq delay value

==================================================================

bit|     0  1  2  3  4  5  6  7  8  9

--------------------------------------

0 |    0 0 0 0 0 0 0 0 0 0

10 |    0 0 0 0 0 0

--------------------------------------

==================================================================

2.dqs window

x=pass dqs delay value (min~max)center

y=0-7bit DQ of every group

input delay:DQS0 =0 DQS1 = 0

==================================================================

bit	DQS0	 bit      DQS1

0  (-1~-1)0  8  (-1~-1)0

1  (-1~-1)0  9  (-1~-1)0

2  (-1~-1)0  10  (-1~-1)0

3  (-1~-1)0  11  (-1~-1)0

4  (-1~-1)0  12  (-1~-1)0

5  (-1~-1)0  13  (-1~-1)0

6  (-1~-1)0  14  (-1~-1)0

7  (-1~-1)0  15  (-1~-1)0

==================================================================

3.dq delay value last

==================================================================

bit|    0  1  2  3  4  5  6  7  8   9

--------------------------------------

0 |    0 0 0 0 0 0 0 0 0 0

10 |    0 0 0 0 0 0

==================================================================

==================================================================

     TX  perbyte calibration

==================================================================

DQS loop = 15, cmp_err_1 = ffffffff

DQS loop = 14, cmp_err_1 = ffffffff

DQS loop = 13, cmp_err_1 = ffffffff

DQS loop = 12, cmp_err_1 = ffffffff

DQS loop = 11, cmp_err_1 = ffffffff

DQS loop = 10, cmp_err_1 = ffffffff

DQS loop = 9, cmp_err_1 = ffffffff

DQS loop = 8, cmp_err_1 = ffffffff

DQS loop = 7, cmp_err_1 = ffffffff

DQS loop = 6, cmp_err_1 = ffffffff

DQS loop = 5, cmp_err_1 = ffffffff

DQS loop = 4, cmp_err_1 = ffffffff

DQS loop = 3, cmp_err_1 = ffffffff

DQS loop = 2, cmp_err_1 = ffffffff

DQS loop = 1, cmp_err_1 = ffffffff

DQS loop = 0, cmp_err_1 = ffffffff

DQ loop=15, cmp_err_1 = ffffffff

DQ loop=14, cmp_err_1 = ffffffff

DQ loop=13, cmp_err_1 = ffffffff

DQ loop=12, cmp_err_1 = ffffffff

DQ loop=11, cmp_err_1 = ffffffff

DQ loop=10, cmp_err_1 = ffffffff

DQ loop=9, cmp_err_1 = ffffffff

DQ loop=8, cmp_err_1 = ffffffff

DQ loop=7, cmp_err_1 = ffffffff

DQ loop=6, cmp_err_1 = ffffffff

DQ loop=5, cmp_err_1 = ffffffff

DQ loop=4, cmp_err_1 = ffffffff

DQ loop=3, cmp_err_1 = ffffffff

DQ loop=2, cmp_err_1 = ffffffff

DQ loop=1, cmp_err_1 = ffffffff

DQ loop=0, cmp_err_1 = ffffffff

byte:0, (DQS,DQ)=(8,8)

byte:1, (DQS,DQ)=(8,8)

DRAMC_DQODLY1[200]=88888888

DRAMC_DQODLY2[204]=88888888

20,data:88

[EMI] DRAMC calibration passed


===================================================================

     		MT7621   stage1 code done

     		CPU=500000000 HZ BUS=125000000 HZ

===================================================================


--
Alan
