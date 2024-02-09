Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE54FC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 10:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264AB87E41;
	Fri,  9 Feb 2024 11:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M5/LQCVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8E0287E58; Fri,  9 Feb 2024 11:15:11 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF53487E40
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 11:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33b49debd3bso181761f8f.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 02:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707473708; x=1708078508; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l81KpgJyKVRXm8UEhLd7CGfEud10LGlVyATpxrozPqs=;
 b=M5/LQCVMOdd9JgE6iC6imEmpOH1KT1jBQpK/XjMc7gq3Fvy5liub12ogPMMHDNDtkQ
 Yn+P+RRW1dXW9iPnITc0tReJUf/TtTKMWI3moLCwL+2AhmGa3NtvM6BPaniqUVsGEPVn
 L0blF/dbM6LXgMAVutajK7ZEXfM19LUEDmjEml/NRD/KFBH/CfSmIjgZAKjPcaY8amam
 iiPoDoFFYvF5BLzl6sZPwA2xj7D/8V5MzlYgUMUH6f013vB+s4apv7F+xB4JEdwwzCrE
 S7IMUk7ZI/qPolB4ivWWgpTmpBAnSWpW0UKravmTBLK9TmTSYjsVdve3MQ2amIinGsl4
 Kzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707473708; x=1708078508;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l81KpgJyKVRXm8UEhLd7CGfEud10LGlVyATpxrozPqs=;
 b=r8Xyf1jVz40yKauq+z1gHaTDTyXwvnozvQsciMZZzv/iq4BeU81vY/1tzmDJg4Ro/n
 /5UyYjZY0szQjpIQKpNEQ6NxSAjfkWJcBxm8/w/WuDll1t5v09sb3pWFjRqlK3KtlY3L
 m7V9bJY30x3NcUQnQJ4PGu+EhGFP01TvFem/po/ssfKIaFYc6nO3KlfVOEJS+gzy/9C0
 0CWr5RdossZEs4X28d9l3hiQ1NpMzgaU0Uks+SxLbe2dSO5hP1HvqfHzyoRsUOrUzWWY
 Ty9JltoZIiqKt2i1AmWpS+OKfec0AkUWkg+Vq1SDcU/uL2119dB3E1o0CAWLebU/7scW
 3pCg==
X-Gm-Message-State: AOJu0Ywek2zWey+W7IyjK531Wk9/ncJO0dxDaNPWIU1HZFGQQ6ZGXI6c
 rtEt8vSFDflS+02UvdZKUnSsDwQdRElIHk03s9ziaiNw0UODtRha2o9U3uoxz/X8CqqxAp/615U
 KmFGBCBQ2TMQE+YiMK6L3c/toN89fzOH80AWlV6me
X-Google-Smtp-Source: AGHT+IF6Ytk7xGanyQvai9oqP4g5a6pa53U1RyqLznecIkj3B67GfDl4zeAPjLp61OnOsGRCorCmTTAjztdcaODxyag=
X-Received: by 2002:a05:600c:22d6:b0:410:6e5f:90ad with SMTP id
 22-20020a05600c22d600b004106e5f90admr759072wmg.0.1707473707976; Fri, 09 Feb
 2024 02:15:07 -0800 (PST)
MIME-Version: 1.0
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Fri, 9 Feb 2024 11:14:56 +0100
Message-ID: <CAByghJb633bMqVhQ+zFzU-tR_hM88EFFhr7mXhj6nWDUhHhHYw@mail.gmail.com>
Subject: [AVB/AB] Overhaul plans
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi everyone,

I'm currently planning a big overhaul of the current implementation of
AVB/AB in U-Boot during the 2024 year, which I have barely touched since
2019. I used to believe that it was stillborn, but looks like it's
being actively used
now by some SoC vendors and Google folks [1][2].

This is what I have in my todo list:
* Backport latest libavb from AOSP upstream and add support for
   Verified Boot 1.3.0 version
* Sync include/android_bootloader_message.h with AOSP upstream
* Check and backport fixes for AVB in AOSP U-Boot fork if needed [1]
* Get acquainted with a current state of A/B support in AOSP and
   backport all needed changes
* Re-factor libavb, switch to U-Boot existing implementation of
   rsa/sha256/sha512
* Add SHA512 implementation that leverage ARMv8 CE
   (pull it from Linux)
* Enable hw acceleration of SHA256/SHA512 that supports ARMv8
   Crypto Extensions to speed up verification process on ARMv8-based boards.
* AVB support for NAND storage

If someone is already working on anything from the above list -
please feel free to reach out to me, so we can avoid duplication of effort.

Any comments/suggestions are welcome! Thanks!

[1] https://android.googlesource.com/platform/external/u-boot
[2] https://source.android.com/docs/devices/cuttlefish/bootloader-dev
[3] https://android.googlesource.com/platform/bootable/recovery/+/main/bootloader_message/include/bootloader_message/bootloader_message.h

--
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
