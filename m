Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0C8C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 23:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7345483249;
	Tue, 22 Jul 2025 01:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YVmj7irk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D1D831E4; Tue, 22 Jul 2025 00:07:42 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE831830C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.bezairie@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6facf4d8ea8so37674806d6.0
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753135658; x=1753740458; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TsLbXaXd9ElChZB/4ar4i6PjnoeLHdJFadm02DeYuKA=;
 b=YVmj7irkUyMUDDsAgV7R17Pj+mz6ATbkIQmSczDw6Mid138mqWaUiQV0Burv4RyAH6
 1eYcYZxrdB27jj6qdh63WcNNqQQxD2Irr8+DfR+LPgRZKcR8jpyp/6nzai2xLhepfeet
 fsN8Lok4+agXYeq/E+SO6gvzpymZlJlJ7U0S96iRo9TrUmuuIua05XCous7iiL0VFQix
 64ftR0/NcRFW/OlCEaS6mTXe/nIJMySLAqc3kM2L7isGy75TSq7619yrBrbs2B+ZkdCc
 64ZB5EVXaWmKqwhE20yBB2/CwJGo+zShNMYv2GDeukhoEwoxkBKdgYxEjw1wCGUInqdW
 PkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753135658; x=1753740458;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TsLbXaXd9ElChZB/4ar4i6PjnoeLHdJFadm02DeYuKA=;
 b=MMxWpm+pVckeGW6MLuv19WmR0JbpGekVfwaWSh5CEsxLjsfzg+xXgFp6x/AOBbSb4Q
 JK/ZAO9Y8KqLsNLNIuggCasnp4esI9wadMICSnh7NGWsdXTdDZyfOQ+EBpNWABq1Rio1
 au0+d7GF40R2TZZBI1LEm/pkthW+3EyVnqk4G7co2lzQqqQBuStJUkjSmb85tmzQKvd8
 rQn03zOKY0BnocC5ooEQuUMv0j35KRrOf0lSbD/hY3q1mEAR0B9FuRtfwrqBUwAmdE2o
 j8AFcxC8HUZV2+DIbs7pgeelcf4s+gv6B/70Sa5iEfVUyCQ+CN7sFsSCGu1xXTzgbvTW
 f/nQ==
X-Gm-Message-State: AOJu0YwyMxpXf/Zr7zM9esMTJntDkqb/2mpNnaWRNLNIxFF40u0quJ9S
 Q1boMQ9NzoBCrnU7nfg9u/LDmoUHSTnogxrSAECLuoqA5mNzvnBrH/Dezk4+y4HdFaAzFUVEU6s
 JGYzP22w/KuL5FCLZJZqgXgE/3weGyHXTKkt87Mo=
X-Gm-Gg: ASbGnctQdrwFEdiWxsgD6C67UvRFPP3XAwIRIMBTt8F3nxBlYgnj3mLV7Ytvvux/Ywi
 O+XS44+iw3O6FriXmxzXSAL/Bw2h17coEI29qR9KKsJVaS9QDlxM3p9PyZkfC2enXGSogHWq5V2
 t5w9yZfTZq8winxda2V8tPBKXUzHn+3AiYhqfm453cE7ChSUJGEcUOMlN9DOw1Trwff2bsgJl0J
 45FnbZYKxV8vhD3NBvf6w0GF9k0TJZCsJepLw==
X-Google-Smtp-Source: AGHT+IGiAvTdDvHo0Mbt5BBi6VRsQRrLvl5v/tZi1vo5J+v34YmcwWN3xhm6NJtr+wwd+5Nqc57jYYNBmD/aje2pHEk=
X-Received: by 2002:a05:6214:4611:b0:704:9275:a7c7 with SMTP id
 6a1803df08f44-704f47fa191mr315521176d6.2.1753135658060; Mon, 21 Jul 2025
 15:07:38 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?SsOpcsOpbXkgQsOpemFpcmll?= <jeremy.bezairie@gmail.com>
Date: Mon, 21 Jul 2025 22:07:27 +0000
X-Gm-Features: Ac12FXx6aM0e-43BPTsXKwwllQJPIxy0S9oBo7OS4NQ3o6TojqVXbt9iV5uQvOY
Message-ID: <CAMdxF8AvrkcV=-PMZPQCUf1cB1qG-3yrk-y3eEL2=gTiF9p2iA@mail.gmail.com>
Subject: No eMMC over USB if no partition
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 22 Jul 2025 01:01:45 +0200
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

I already sent this email to x@xnux.eu ( https://xnux.eu/rk2aw/ , Author /
Distribution ) at 17/7/2025, still no answer.

Hi

My PinePhone Pro has rk2aw on the SPI, on PC I'm on Arch Linux KDE.

If its eMMC is empty (no partition, all partitions deleted by eMMC over
USB, KDE Partition Manager on PC), on the U-Boot menu (the 2. in
https://xnux.eu/rk2aw/ , How rk2aw works) if I select eMMC over USB , it
not works:

** Invalid partition 1 **
Couldn't find partition mmc 0

So I booted
https://github.com/manjaro-pinephone/plasma-mobile/releases/download/beta14/Manjaro-ARM-plasma-mobile-pinephonepro-beta14.img.xz
on a microSD card, Terminal:

sudo fdisk /dev/mmcblk2
n



w

to create a new empty partition on the eMMC, now eMMC over USB works...

Why should there be a partition?
Maybe can you update U-Boot (or rk2aw) to eMMC over USB an empty eMMC?

Thanks.
