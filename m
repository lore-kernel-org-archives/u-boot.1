Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C5CC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E7184B3A;
	Thu,  9 Jul 2026 03:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sIi33bC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4653684AB5; Thu,  9 Jul 2026 01:16:22 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9399C84A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 01:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigheadrodeo@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4513435cdd2so114550fac.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 16:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783552578; cv=none;
 d=google.com; s=arc-20260327;
 b=mLAe0JErIDwZ9zce2ZS3sBp9gKgq6UMwHJ1KLfQSq1THHbwyIxQ50ys/W3rHQ1G6Cv
 XHG9r5EZVTyXj3sAADWQ8IDVRZcd1p0xjp5CgP0jaMSC/kycq/7rj5r7BnIcaQCLeDiF
 IVeu5RPKcPmYErD/l0XWDx0DOlU/Och3Rs4klmy2lc99/58M/YQXQg0OSnIaMNfagbxU
 jpIaPgNDTNToHFqE3eipdwzoBWvM37j+lHthqPRiRfrRv1ZUfE8l9KTGRGoIC0N+AYv/
 q5FsY0IXtCCNTL/qC7+8WmNsxITmxZPFyWI7p0C4rcgWUXRkiOv4266CeFdBpZxjMA/P
 JemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=hyMAZp1qWqsXinTP/Y7SOCyM6xZkIrgTkN0wSd6+scI=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=ewvFOWo9COwCxugwGFYEM1ipJ5TYpcCyceU4BM1oVkAYsJbENma3DITcUCG2uoq2Lf
 VNJgF5nQWglru2OSLCXkLfMd5UmslLdToyeE64NJL7QfigXMOEYQVADqAQgzPV7SIRJ6
 ggvuEo/dXcuo5P/DXmXi0c45kK6kuxB6Fv4pGSYf03CpjNPFsOPV7U9V+4OAtvFI+Fy+
 LqGQXru2a6fGBsWunoYX3M0lWjR9Kx43ZdsdhOKlY9nXuKewyLHWrOuVaoAIeGZCJsb6
 u2wIA5gM8/gW1zQ4KFXZJQoIkf97970iWL/m7vm2QVAmKhuyqLzsxUPesz61JsfBYr9V
 3Wag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783552578; x=1784157378; darn=lists.denx.de;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hyMAZp1qWqsXinTP/Y7SOCyM6xZkIrgTkN0wSd6+scI=;
 b=sIi33bC4JT/nwBNOmAdEkqjmKPA5ocbdB+EvFxGZSGp7L3mL3sWzqwYLAyT3KPH4X3
 g3eJfMh27nAFwiSQn1BSNyhVFDAOAv0mA+o5u27TcoZd4rFiZBKES0bZ2hylLl41XbB3
 lgF5ISZUPJSTzQShIYI213PBGILdI88EQe75efwGKQvkyM+UdV8mAat816dnIA3/fj+e
 qesXOFy3yuL2sydlNQOZ6uDz2bvDtxk2VxuYgNf8Xz+qVbMKtoe5sTVlsACqBiNfm5o1
 N2kDMbRobWxJlHiKNe3KkgoW5WQ5i+vl6TxhrsdF1WhMVaJLqrOPf3Kv2Wg/LDn8IiDq
 eslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783552578; x=1784157378;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hyMAZp1qWqsXinTP/Y7SOCyM6xZkIrgTkN0wSd6+scI=;
 b=dd1y1m1/gcptYZpVXlqpN2Zdipt7RUHDCSolOoNOTwua+cZcCKs0zHnZF3N7fzOVnE
 qgPw24zPgjh2b6sde0xwYCOetMDEGoxlQ4hMUH1X3v3zuwuTsCurkvxLLBNTKefeYwtC
 X9O6vK0zgw9tYcU7wpzKJihBNJVf7LoXTSB93g9ogOfRgeG7kMi6BEfwHWS5pUaF2RbE
 K+Gii4b3I3OKqx+TgC4uAuw2qgJCst3xggRpmREXsAyQJqdvmoyZNy/pjIs0SGxfnwxG
 Fh0MBqfg5vESDS0Qg6M0ly4aI1u0fX/dutowxVKjfzwcV/uqLCH/yXx44E5ATaPH01Wd
 9M6Q==
X-Gm-Message-State: AOJu0YyJou0lplnQxmEiXsve9zSLLBPmY/BZs5Pu0UP3xz/yzF5qROPL
 Bcm0SpKeHMhdErQScoo+JVfnkNGCV1DhA9J1uv14BB70fQjj/6d9sbQllQdxd5WPskBJyDXLTyH
 bxTHoINXaA0MMmsSbMHs2raUd6uTm3+VMwtl/
X-Gm-Gg: AfdE7cn+Yinra5AGOu4i0vog56a2blVsrhGIRFW4jQk/gSiHYn5M5f0/qGmvIkINU/8
 4giagae2Sr5C/xoGdzJqSHXwc169ZbS76px1LQuVv7nv8TtWSDqUL9tAy9RYgkbZTkFhOWNMo/B
 Ws7KPJ0kce/UI+GJFyZlunED8IlzUi+N9nIN4SoGYso+vFHMBEtTByUzRct9xBJmRORjE3NjjqD
 SLFKZj7d2JqYdwzld1By2jLToqIZCxi1WTy8A8zsgYIEM6dcLvdbFGC8zrz8esjLnfJi9KuT+us
 MypWPikSu0owHZu2LIQz2vP9Sf7kIpbrhKcvqP9WLg==
X-Received: by 2002:a05:6870:353:b0:43d:20f3:bc86 with SMTP id
 586e51a60fabf-45162e3bd7bmr2763873fac.0.1783552578156; Wed, 08 Jul 2026
 16:16:18 -0700 (PDT)
MIME-Version: 1.0
From: Lucas <bigheadrodeo@gmail.com>
Date: Wed, 8 Jul 2026 19:16:06 -0400
X-Gm-Features: AVVi8Ccd_flsnV0yQfjy5QrP2kkHbmRCeaYukZIDg7ge_mex86TtYbT85Ye-MbM
Message-ID: <CADt8U2LFgohjjFX8oQs2bM_2qfsWKgsvnO3HFSh-E0Q1wLEEvA@mail.gmail.com>
Subject: Bug? SATA hard drives do not boot on Hardkernel Odroid HC4 (Amlogic
 S905X3)
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:32 +0200
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

I am trying to use the odroid HC4 with Armbian Linux and two 3.5 inch SATA
HDDs physically inserted. I believe I have traced a bug to uboot code at
the start of the boot process.

The issue is documented here:
https://github.com/armbian/build/issues/9532

I have two versions of Armbian, one works and one doesn't:
Armbian_26.5.1_Odroidhc4_trixie_current_6.18.33_minimal.img.xz - fails
Armbian_25.8.1_Odroidhc4_bookworm_current_6.12.41_minimal.img.xz - works

Both versions boot fine with no HDDs inserted. Some SATA devices boot fine.
These are powerful WD Red enterprise drives. When I interrupt boot by
pressing any key, I can run `scsi scan` and `boot` and have it boot
successfully on both versions. I also see HDMI visual artifacts during the
scsi scan sequence (the text becomes garbled on a few lines) that always
means the boot will be successful.

I tried compiling edits to /boot/boot.cmd. These edits did persist (I saw
my echo commands) but did not fix the problem. There is part of the boot
sequence that happens before the compiled boot.cmd runs.

I tried setting preboot flags without recompilation, but can't figure out
if this is supported on Armbian / HC4.

I believe this preboot portion is controlled by uboot.

I made some edits to the armbian code and ran a `compile.sh` command that
seems to create a new uboot. I wrote that to the SD card and the board no
longer boots with that card.

In order to diagnose further, I could use some help confirming that this
portion of boot is controlled by uboot.
