Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE075D42B80
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E837789443;
	Tue, 12 Nov 2024 14:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xsyc0zcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4864A893BC; Tue, 12 Nov 2024 11:30:42 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2710588F8E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppeter.bme@gmail.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-50d2d300718so2237614e0c.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731407438; x=1732012238; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KBbi/1JBrbGkST2lbPcryotxl3NYHcjs9ULVT1aNsOA=;
 b=Xsyc0zcN/9FvL/GhVKDnUuIK14zrGUsuv0ZDX+Ux9gm/65qHW2g4cCs5ySdfDFyYO6
 7OQXQbLJubDoG+MTBYnv4FwJQHB8Q7B4uAOgcZZKg+R/FQW67I+ArM59N9USRmulQ50v
 yi4SIwVroB8qvnDeM5wFvZLyfNjlW7r0ZpaRfIjY7GLHKC2z2gwrtc2BYrdAxot3fRTr
 6JPS582OQC6MOlZ8fGtYN/uyiZZHLTGML0HWcwQpBkXkEdAfizIhKW5gBTshY01H2Eyf
 78U7YZi0vofeJNfKHX9sPsf/s1W/mZul+7hrFFqwDMFOoX7WzVQCjWMnYIBvzn5WdCM5
 CZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731407438; x=1732012238;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KBbi/1JBrbGkST2lbPcryotxl3NYHcjs9ULVT1aNsOA=;
 b=c8SlWXRIpI2uojDBx4pyJyI6tJbE5nWhFDfbJ4bWFoH0Fb+YcHhf/JVg6gmzfnxxcl
 C/Z1o0MSEFmPVQV/un7C5QTGXVncqM2RoMGF9Z5abrHb52XxDRJgvl13Yy8QVHB0BKz9
 SN+aOgta/GK4a0csEblh8adUnw3v0IJUk3pmzM9lPUqh3AW1nH24cu1CKO3jeEbPMZf6
 5QjLzB0Fulab8R3pXYguIZOqy91BB7iFw7SrqhatjNHZB5ku6hrD3YLLRKfV/xA1CwyI
 dark0tzVNbfO5edtRvAdCXx3B9QJlhwQKkZsJeddFD+3a3DvcJfcfQfKssQ82dfv0omq
 WX+w==
X-Gm-Message-State: AOJu0YxaQWsOyf/DonyaWpzfeTPZ6b6/sGacW4z8dTmigGZPoAhh86LR
 YtkCjLStB0Kffa5d8W/54GA7bLpI4DI5bNmJEalcFrzrye+rDN4nrkhLd4xqR/F4WAvkTQY88QC
 V08C21iKcBcu5Mcm8FWCLAYqcmiFcOM92fYdF/Q==
X-Google-Smtp-Source: AGHT+IE0SYxnHDEtNgLVUcq37cu1uoztEJqG00VmeaL0YQ5ZTnKsctpjNDWcJrZSHGfVMFr+RqxZG16NpAvXE/uI6/k=
X-Received: by 2002:a05:6122:3c48:b0:50c:79a4:c25 with SMTP id
 71dfb90a1353d-51401e960b4mr13590372e0c.8.1731407437671; Tue, 12 Nov 2024
 02:30:37 -0800 (PST)
MIME-Version: 1.0
From: Peter Polgar <ppeter.bme@gmail.com>
Date: Tue, 12 Nov 2024 11:30:27 +0100
Message-ID: <CAF2BDb-Nus00P3peuPnbtadzhWDvdK9C4R+5zHxsGGimMn_YPg@mail.gmail.com>
Subject: Adding cross compile for armv7 to docs
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 12 Nov 2024 14:42:04 +0100
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

Hi,

I have recently built U-Boot for an armv7 board (OrangePi PC). It took me
some googling to find the dependencies needed to cross compile on Ubuntu.
I am thinking about adding the info to the documentation here:
https://github.com/u-boot/u-boot/blob/master/doc/build/gcc.rst#debian-based

I have a few questions though:
Can I send a PR now or should I wait for the next merge window?
Is it ok to commit to github.com or should it go to source.denx.de instead?

Thanks,
Peter
