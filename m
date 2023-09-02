Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0720C71153
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 11:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC9181FA8;
	Sat,  2 Sep 2023 13:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ssKVbjzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2720E8468A; Sat,  2 Sep 2023 13:35:27 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50DEC81970
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 13:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tosainu.maple@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bf04263dc8so2318292a34.3
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693654523; x=1694259323; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=K65dyfTuDd64QpzQ9yamgpvCApEPtP9Yq14bqQb9cy8=;
 b=ssKVbjzmJS39dmTmbAtDb6Fr59Tjqc8qsQjshAOzWKPQgp+nTbiUGiaPbtTNDWXIRA
 NWcdIL+SEQG8nv5zRBclhuTbehYqL5n3MpBaE6vmcraUsSNQDCt5oRFJJknFC0/EPV21
 iqbdNmaEIP7XOcyCnYhjLXve5q6QtEZVXNbh2SbCiWA7Ia8x3QCAUpjZT2byCif8zPVC
 g13F6h7ZEGfE9FxO2Bbi8URN2OAz1i2H9pqsqCtP4WJoztmgXfh4c830vYIdBkVL04EW
 jCRyBrYE6Qhoz/loSbNm4tUhHG5sgPvuNDT7a6RyC0OtNJthCxxFutxQth7+opuoUtNj
 m9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693654523; x=1694259323;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K65dyfTuDd64QpzQ9yamgpvCApEPtP9Yq14bqQb9cy8=;
 b=IWfEnqLpJYgNVcSTwW5ddlUoRF8hxONcQDcaJxINwOCr7LoDotyd9HF9Lo16+nrlCK
 F8ikAOXLt21cZMaXhCgZg0eehOKCn37QLk6vZylgIHK5WoYumIAqytbspCIHDnbAlI08
 yHmyEA0S48J8+d1Utvpb10XJPuvKEu1vrDzBpoS0lAk8VJgSNLAf1cOfifiL2hAN5KAM
 YR1KT4PJmX0p7XLxoB2sFXHks2af9lZtNdIid0/OJ4wv8bVBMiBl5gfFInXbss8mUda4
 QmNKhnCSmRrPdbGuBK8MK97oBMmU0FwlHrl1brhAfKyCYURlDtmqX4K1vLenMvfD28dF
 qe6A==
X-Gm-Message-State: AOJu0YwSPXCO80Nsn8wyQrUSK5r76/3kW8Ubtm0PMlcu3AB2yZ32h1PN
 vOhLRJa+KuhhdPxlrpBWb9XZgORlTPRscc71HcSw/NLlO2s=
X-Google-Smtp-Source: AGHT+IGvYmq6JdrHHqSs14qg98vZCpjzPA7YWeYbOfSlh5klOZR7YpiOHInUCVBlEzwt2kUoLQZ66dhLz/3Ka3doDXU=
X-Received: by 2002:a05:6358:249f:b0:135:89d6:22e9 with SMTP id
 m31-20020a056358249f00b0013589d622e9mr5489189rwc.13.1693654522610; Sat, 02
 Sep 2023 04:35:22 -0700 (PDT)
MIME-Version: 1.0
From: Kenta Sato <tosainu.maple@gmail.com>
Date: Sat, 2 Sep 2023 20:35:06 +0900
Message-ID: <CAF1eZtvEmjZohyJfa=Jm=Dm76bhkayKk_tzTMM8ooQUQ-OL0CA@mail.gmail.com>
Subject: Issue with mmc_power_on() and reference counter of regulator
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 02 Sep 2023 13:38:12 +0200
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

I am using the FriendlyElec NanoPi R4S board.
When I updated U-Boot to a recent version (0fe0395922), it failed to
boot from MMC. Here is the log:

================================
U-Boot TPL 2023.10-rc3 (Sep 02 2023 - 08:21:08)
lpddr4_set_rate: change freq to 400MHz 0, 1
Channel 0: LPDDR4, 400MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
Channel 1: LPDDR4, 400MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
256B stride
lpddr4_set_rate: change freq to 800MHz 1, 0
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2023.10-rc3 (Sep 02 2023 - 08:21:08 +0000)
Trying to boot from MMC1
spl_load_fit_image: Skip load 'atf-5': image size is 0!
NOTICE:  BL31: v2.9(release):
NOTICE:  BL31: Built : 08:19:59, Sep  2 2023


U-Boot 2023.10-rc3 (Sep 02 2023 - 08:21:08 +0000)

SoC: Rockchip rk3399
Reset cause: POR
Model: FriendlyElec NanoPi R4S
DRAM:  4 GiB (effective 3.9 GiB)
PMIC:  RK808
Core:  264 devices, 23 uclasses, devicetree: separate
MMC:   mmc@fe320000: 1
Loading Environment from nowhere... OK
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: FriendlyElec NanoPi R4S
Net:
Error: ethernet@fe300000 address not set.
No ethernet found.

Hit any key to stop autoboot:  0
Error enabling VMMC supply : -114
Error enabling VMMC supply : -114
Error enabling VMMC supply : -114
Error enabling VMMC supply : -114
Error enabling VMMC supply : -114
Error enabling VMMC supply : -114
================================

Does anyone know how to fix the issue?

I looked into commit logs and the mailing list so far, and I found the
below commit that adds the reference counter to the regulator. I could
remove the above error by reverting this change. Of course, it should
not be the proper way.
Maybe we could replace regulator_set_enable() in mmc_power_on() by
regulator_set_enable_if_allowed(). However, I have no confidence about
it as I'm not familiar with the U-Boot source code.

================================
commit 4fcba5d556b4224ad65a249801e4c9594d1054e8
Author: Eugen Hristev <eugen.hristev@collabora.com>
Date:   Wed Apr 19 16:45:24 2023 +0300

    regulator: implement basic reference counter

    Some devices share a regulator supply, when the first one will request
    regulator disable, the second device will have it's supply cut off before
    graciously shutting down. Hence there will be timeouts and other failed
    operations.
    Implement a reference counter mechanism similar with what is done in
    Linux, to keep track of enable and disable requests, and only disable the
    regulator when the last of the consumers has requested shutdown.

    Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
    Reviewed-by: Simon Glass <sjg@chromium.org>
    Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
================================

Any help would be greatly appreciated.
Thank you!

Kenta Sato
