Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425E5C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 20:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BECC82C65;
	Thu, 19 Jun 2025 22:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ur9xk2oA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C348782CCE; Thu, 19 Jun 2025 22:38:07 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC5C82BA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 22:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6099d89a19cso2455747a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750365485; x=1750970285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=c1KgIOGJBCa43lyFhnNPTwoymeS5guvihEe/cFklVpg=;
 b=Ur9xk2oAYqheYDWsIoaWFdXG54IjjYg2ijDcL+n8M/qMpQaoq0tK5t+8bAfneOKVVH
 azahssIePRM42tNlg/v5kr7YJhIdVCsE1uP9sy+P5CEl979vERWW3C6saoEiWWUrZGRM
 Xsz9hMUF5cIqNa+VE/k27e+sBnveWz+L6QCLJHAI6yS1w6/nHNWAWTrHJ/GQ5ZkimT0O
 G0b1/O9mB230LGAGw2+ruGSZFhKnGPYi/aeqz1vmO4NxcYPujxMR8w8bEgOrKAbeVJ3Y
 H+61p2z3g0xkiAcJrk30Tf7Euuio0sCum4v/LmLKiEply91k3q3mGyh9kYFcE6TMCTcJ
 GI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365485; x=1750970285;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c1KgIOGJBCa43lyFhnNPTwoymeS5guvihEe/cFklVpg=;
 b=di31hVWQnADnTfetVoFLx+eDmfWkzH1XJICVC+x1Ru1BU+ikSM0KktnVrkJzNLb4Wb
 Lbn2OdgHG8lyftYLDs9MCNlTaVUspWXX8YKVAJM8y8Wc9N/h24BzKPypr9W4GdM1g95R
 ToAE5afOrJ3GPVa14M8fv3l5Aq/NBb2FnEywhGbhHy5zeqVweDeWb2IeLhj/9oMtKtED
 uRN+sG/wPp00ggYKkiYwOE8+I3W4fvg0jH+thh87GTnDUmG0pSIm7BZIcx0NajvUqals
 J6nb/XOmDmQx63aogS0R8QeuVMDolcT7SI5qOHDZ/3RvJoyOOB9/SjymMSDGUp1/JxJD
 NQlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOuWq2jkodyULg3SJK8yAzFJQ8fX95k8Yu/5uk+51oCFB/8/PAh13okWx97LXRGCC5zWcrZLA=@lists.denx.de
X-Gm-Message-State: AOJu0YwHk2pskRra4FE2c3KKzRHjUaArXgnoAFMkbB8NUfn9Tskvxwvy
 SMMEPzDvKcKq8pcPDn5X3loy9i66ra2GLvn10l0M9379x4Do5o06CyYomeVpwbR5OPcxJkiN88A
 zs6YbpNmFjL22p6L7a1T2cFRxTUaVHEE=
X-Gm-Gg: ASbGncuMw6kX5bfS8T0Wp/6zhPcvtlsPBIvaeACusK0YBAcLtbG4sIpdz1iy1PP7tLW
 pi5yjY7QPUgftjpwbRtnWmI0mZZsiWh1VwtVYL5ubyi9dCusBvruG0i+vosG8P1wUVOTogQfOG6
 /xxI+YqhPG3ZLMcdwQ6OJMxM89Wd7TOtLOjBPT4WVYUAXf
X-Google-Smtp-Source: AGHT+IHANXM+JUYd+Xa39+x/hciGqeQfs8CTbxP1s5vXp4CsCcQlfcYB+WtoDQk6ct+UTt85RjbK1cWywhr1CZTpTv0=
X-Received: by 2002:a05:6402:5210:b0:601:dc49:a99f with SMTP id
 4fb4d7f45d1cf-60a1d167701mr310802a12.18.1750365484859; Thu, 19 Jun 2025
 13:38:04 -0700 (PDT)
MIME-Version: 1.0
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 19 Jun 2025 13:37:53 -0700
X-Gm-Features: AX0GCFsFdS55cBkrvmxMEdOYIsCjzKWnk3SoDFSfJqnPjTMOlLym6yRuMhrbZ94
Message-ID: <CAJaLiFwpdskG-eQjFKQseB3ResK=6Lt_RNRbXZTEFq7FYYSuAg@mail.gmail.com>
Subject: arm: mvebu: Kirkwood boards are broken by commit 6fe50e3
To: Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Jerome,

While fixing some ext4 file system problems on 2025.07-rc4, I ran into
a problem booting a few Kirkwood boards. kwboot loaded the u-boot
image,
and then u-boot execution was frozen without anything going to the
serial console. I did a bisect and found the commit that caused it.

https://github.com/trini/u-boot/commit/6fe50e39508043f386fc1bd40bbc02b8a75c1940

When I tried to reverse this commit, I had a build error like this
"{standard input}:24246: Error: selected processor does not support
`mrc p15,1,r3,c15,c1,0' in Thumb mode"

Currently, the only way to boot Kirkwood boards is to disable either
CONFIG_LTO or CONFIG_SYS_THUMB_BUILD or both.

I'm using the pogo_v4 and nsa325 boards as test beds. Please let me
know if I can help with testing to troubleshoot this regression.

All the best,
Tony
