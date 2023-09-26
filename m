Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DA5E7F143
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 22:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3919486A24;
	Wed, 27 Sep 2023 00:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RgQSXH9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46922803AB; Wed, 27 Sep 2023 00:36:50 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF33D86C13
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 00:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marietto2008@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9ad8bf9bfabso1244121366b.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695767807; x=1696372607; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Yh4ez99QxLTszp3mXsJoCKW19FXKJXM1UdYMm10D0d8=;
 b=RgQSXH9gT2i57aJ0zrNdzwbC1p8U/+PvIbxqwNj7hm0+CgEs1vuRPv08is2mGmTPU9
 rJ4wlC5pvMbu1ofMRIWaaNnnUCT03ETLQW7oADDx3WKIW1QtMuKicgLPXokn/7nGX3Zu
 WeHxlgKLk9gE++mXpa7i7u3DKa4mAnHINxhuMlRkSWt//BuZQ/o2JtdlDS3LlSkMb+qZ
 uLesWz9qAwmTXx956UJodI4ZrBFzM5jLiPSjgOOk2cZl2D8c6vaYYy4cU9K0oHnUEYQR
 vMgdUO1YuJ0AKJS4o2y+MTPt8kacvLRnzvULl+Ly0s9fFPS5lnkzH/Pa8YuO1KfvXWqF
 yIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695767807; x=1696372607;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yh4ez99QxLTszp3mXsJoCKW19FXKJXM1UdYMm10D0d8=;
 b=OGMfqqW2VJ78mLojlXZ3KobE1GzvTqgtDLkJ1A5R2YEuwB67ekZ8PGHvFc0EEEuy0g
 A4GxQhLBuqg3lv4BFRhYeQXTsv/NcmMiwhe3c/FYk7ZCToHvnLN3y2anY4XzSH/6Hwyb
 GpvC2uLDmNWgpa1LiPJw53282mT1gAOem1ykP+S0KtfVPoSXFlsYNxdKYWAfAT7+LnKP
 5L03Rhf+tPGTXHCr3sy1UArGuFnePbI4KFqGHIBAcXIc6CZHoYZWjpG9Z3CZ7mq3Mcda
 oPWqGRDLC/Vp1nA/mQ6BaLWKBnwU7n25gF6IZ3d/BpIcGn82zPIRATZ2QHdm+jx4UlJH
 fpYA==
X-Gm-Message-State: AOJu0Yy+bRmfLaYX/ZLDyU2CaFfhs1deVIWnz7ADyJYUv56qt1P5kcN9
 zBzFdMEKB/FxlbzKmzoUO2LFMyO4LHhN+3Tm+2Cae2wTcwQ=
X-Google-Smtp-Source: AGHT+IEHc2rGGcxSUmROZ9GSVh9jBM/LKtfmH6LNtmqxDan2jo2T7TYmigT9wjPPx0EqJNVKVxdE7FU7DFGNkLYFzxo=
X-Received: by 2002:a17:907:75ef:b0:9a4:88af:b7b with SMTP id
 jz15-20020a17090775ef00b009a488af0b7bmr58083ejc.62.1695767806967; Tue, 26 Sep
 2023 15:36:46 -0700 (PDT)
MIME-Version: 1.0
From: Mario Marietto <marietto2008@gmail.com>
Date: Wed, 27 Sep 2023 00:36:10 +0200
Message-ID: <CA+1FSijMa3_B6uU7CP6ggKBPWbY3j+7=xDM_8emdH0ZZ+=FsoA@mail.gmail.com>
Subject: OF: fdt: Ignoring memory range 0x40000000 - 0x80000000
To: u-boot@lists.denx.de
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

Hello.

The project that I've been working on since 2 years is to enable KVM (with
the support of libvirt and virt-manager) on a recent version of Linux and
of its kernel on the old but still nice ARM Chromebook model xe303c12. My
goal is to virtualize FreeBSD 13.2 for armV7. I've almost completed the
project. At today I'm using Ubuntu 22.04 (but it works also with Devuan 5)
; KVM is enabled ; libvirt 9.7.0 and virt-manager are working great. And
I've almost been able to virtualize FreeBSD. Almost because I've found a
problem that I need to fix or the whole project will die. Ubuntu recognizes
only 1 GB of memory free,but the ARM Chromebook has 2 GB of memory soldered
to the mobo. So,1 GB of memory has been lost during the transition from the
first project I tried to enable KVM with an old kernel (and ubuntu)
version,that you can find here :


http://www.virtualopensystems.com/en/solutions/guides/kvm-on-chromebook/#setting-up-the-boot-medium


and my project,which uses a more recent kernel version (5.4) and ubuntu
version (22.04). I think that when I have recompiled the kernel,I've lost
some kernel entries that are enabled on the 3.13 kernel used by the
developers at the Virtual Open System. Well,I have no idea about which
entries my kernel config are missing.

I have checked the available memory for the OS giving the command :


# free -m


If I don't recover 1 GB of memory,I can't virtualize FreeBSD,because only 1
GB is a very small amount of memory to be able to run the host and the
guest OS.

So,can someone help me to find which kernel entries I should add to have
all the 2 GB of memory available ?

Virtual Open System offers it's own kernel config file,that I have saved
here :


https://pastebin.ubuntu.com/p/j4B54TChKD/


using their kernel config file I see that I have a total of 2 GB of memory
available (I spend 400 mb to load Linux,so only 600 remains ; it's not
good. In Fact I get a lot of qemu crashes), but If I use my config file the
OS starts with only 1 GB.


I want also share two kernel config files :

1) the kernel 3.13 dmesg log file where 2 GB is recognized,here :

https://pastebin.ubuntu.com/p/gsw9SM4zY3/

2) the kernel 5.4 dmesg log file where only 1 GB is recognized,here :

https://pastebin.ubuntu.com/p/W6Mgj4jGg2/


I've compared the dmesg logs (kernel 3.13 vs kernel 5.4 config files) and I
think this is the reason why I have only 1 GB of memory available :

* OF: fdt: Ignoring memory range 0x40000000 - 0x80000000*

This line is not present on the kernel 3.13 dmesg log file,but it is on the
kernel 5.4 dmesg log file. The dtb file generation seems involved. What do
you think ?

I'm trying to understand what to do to fix this problem. Can you give me
some suggestions ? thanks

-- 
Mario.
