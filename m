Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EBF106703C
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 15:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7257B841E3;
	Thu, 12 Mar 2026 16:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i7T5NDby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9E184238; Thu, 12 Mar 2026 16:26:00 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0220483CEA
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 16:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-662abedbeb7so1842428a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329157; cv=none;
 d=google.com; s=arc-20240605;
 b=V0WWEDQ4Ay6dBLewCc06y6wGtKUA8Z8y0iGsTEoDwSdDhtqLa6gKP/s9QW7l5HhiVj
 HsyjuXyO00waBy7Gz0ezo1fxpnwfjEgCV/fctAfyn7P/4CMDnfrrGRWsyhrj5tFMbc30
 dB9puC7e0DZhngrCk5+Zi7Dv0ZJQpLV1fI7oZfC6aXcoUzXLZAcyUsNjhjo2xcm5dRHU
 WxHOVsROvl0o3FguvO1zCTEzLws14mYGlxo5TqZX97sIF+VEGl5H+TIPw7/VCjd5o2Qq
 XXJv0HeDMtTlcQ4q3cIuU8pfuBxbmbnzF7DglAVbqPur8D07vAbL5+kWv2g2wYHcgGoF
 g2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=CUbyf03gsz1RZOp49yxd7renhWAoSO8ofWkn4kWJcPw=;
 fh=D7AOROvy7Rgc9BQh1kvjt6k6KXiZakVVm/UKVpgBOGE=;
 b=R+L13/hxFHy6irCHJsg5A0b+17jaGk2/kBH1gWMkltYykVF9l5w050FSKExCDbkQ0Q
 teurn8ou/jc9hyObQhzfbTjmWolmhs6hKwyPxj9g659jrhHn0Mh+t6Almh/lCEZgCOFV
 hVtUCpyG/bWKX2qdBCutDUUx8kfWlEji4KjD3J6hq3uG+dB1jytAgrulFba5XWbduJa0
 eZNNhJYEIOxmxULmL21XFNGObozduzujV5uSNU04nYshaEIEZJ/DGX3Ys/cBIVAvi2ay
 hCLPAK50bkVohGN3Qz6UupVuZheO7ARygCNk2P/6NRSB92p61fySGB41XlkEpQM6xy4n
 7lTA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773329157; x=1773933957; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CUbyf03gsz1RZOp49yxd7renhWAoSO8ofWkn4kWJcPw=;
 b=i7T5NDbydYVx27yakyn2lvPnnVcE12XhWICOZFQ+eePcUndOFyqWdTQsdij8f5Ck9H
 7vb0/ivGOp0+DBEDQ2m3Wy4b3x8jdU14K+eAUcGFMD9lNy9MFT1DYbV6NaK198izuTwD
 g8OzXV9eX1zqvhayVJWkSp0tE2QRTbUrgnEVnSjigjhmBuf4SREINF8WkK5lqhQ9+KLp
 0/K2Zd29ymrG9Yna0lPos+tFBXmSFkN13hHRd99xjCQzZ6MfpqvYCw/rKvAFB4lL1e+s
 zjvt8qAqHJS/4MUK2cgHlPcaW1viqLqrFfTz2MJ9KGPyg0ZoyEx4336/g9x2+I8kvrCs
 xUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773329157; x=1773933957;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CUbyf03gsz1RZOp49yxd7renhWAoSO8ofWkn4kWJcPw=;
 b=Msadbwra/T93puVKu6DrA+Ur2Inob6VDLsuAnvpqQrmGIVRDnK6cPIYOGgjsIxg2x2
 oHgMFEYRCpSqY/QD/yaDUvkXHs3pWAk2HiYXs/b8QZhbBsY2FrUvO2Enm0FOZ9VW6kb5
 gzgn0Okh8qyKT8ub+TnNKU4ogRHwRbFkD0zmbruQO9ruVnlEyCmDFEqYX2Tx6gfA7sU7
 IiAEtx7BMxhFSxcoItrvEkv4vK6pVmqTQMXxhP4QG3+YEFiJZLXtDkLRJATxXzoocfGe
 6BVH5/rqtOKQL1Pfl3YTHF1FURt91dzQkWoNqVkS9DUeTXy6ZPkbjPy1ZDH7zOe+jlBt
 ckPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUD5ahIUcunJz31Ly1+S6Tdu5Qhu2T6WsRqfK7x/NJc9UqV37jPHAGRo0PljLK0/mtrlP8eYE=@lists.denx.de
X-Gm-Message-State: AOJu0YxKt9jtrxzbPMxrTTPNzJ5foirqSWmgaNgHONBXZE85k306Txje
 4B2n/Ahh6gYPWN0T9qokzJKx44XYOGIT9bqOxGJLSVjD0EPmnASsjxEc5il3xxvB33hiT9xoGpL
 1Z5JMvKutMsLYt4lfPkTO8iIlBQ8t3oI=
X-Gm-Gg: ATEYQzz9I8OJdeU9HWOpxQJ07a9ykZNYJtKy+EY0dOp12HGI/hVL0lFuM/sn7uNBEoT
 AHIR0skTEG8LvHxxXpd31T1oLDNkMncTkLqk1/Y8HuGOQDo/N0lmj09oWh6MlIE0TqkmDK1QyoV
 2qaq9NMpNnlJm3bCa3rIeh/oyc6jhp4YGE+AvY/aXhZfqSQ7pA84+kxn7pN3thBu1UaxPyjvX7q
 zS2VJhz9UN78bx9o4rgHfCDpdnAdqdczpwThF+jbBHjnHrkrLrZJUXb1HxpMCCXuWuDr1e/MMgR
 zk2oS/gfGupAENqzNWmxIO3kqE4FFQd+dx9sSEz+z1tYT8s+wLbEhtkjjpbq6mgsyiV3y/t72WZ
 ka20tAWKF0ziSDmq+cKTVT2xhcbsGNQh0Y6GT8R58V3rb9CRoFIYAT6b/iVJfbim4fhBSu+hGHD
 sd
X-Received: by 2002:a05:6402:4508:b0:661:cf1:9dd4 with SMTP id
 4fb4d7f45d1cf-66319de7239mr2528059a12.14.1773329157109; Thu, 12 Mar 2026
 08:25:57 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 12 Mar 2026 15:25:45 +0000
X-Gm-Features: AaiRm52zEhMD4iDN3FXYxdT1DPq92pLJfDkSqOGfKggskt_mF7PIOelCm220_t0
Message-ID: <CALeDE9MMW0L1xyWFW6Qdh+_XeVKrEK_1a2ju02E7=wy-YcCBtg@mail.gmail.com>
Subject: Pull request: rpi-2026.04
To: Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Tom,

Please pull the updates for the Raspberry Pi.

Updates for RPi for 2026.04-rc4:

- board/raspberrypi: add bcm2712d0-rpi-5-b for Raspberry Pi 5
- board/raspberrypi: add multi-FDT support
- rpi: pass the Video Core logs DT parameter through
- pinctrl: bcm283x: Fix GPIO pull state register values for BCM2711

The following changes since commit
ba7bf918dafcd093ad733b07ba490baeb20cf5da

https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
tags/rpi-2026.04-rc4
