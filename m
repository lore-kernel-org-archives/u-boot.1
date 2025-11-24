Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65BFCFD360
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 22:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D0283EF5;
	Mon, 24 Nov 2025 23:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="heHZcoS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0172983F00; Mon, 24 Nov 2025 23:25:28 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A7583EE8
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c7aee74dceso458987a34.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 14:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764023124; x=1764627924; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DBLz9avz3yru1xckhK5SxWQcC8TCI/GihsARTXSat+s=;
 b=heHZcoS99TE5nm1KMd1kPl0pXmoi1e8/hfAnlKzAKBRSful4olrpQRTG+ZI6AfSnrD
 B8GBgTSJlW43KEJuqoIQg+CIRUiTFyHXPcGqfYxb3h8zZAGDS3iHblAbgHU1i7HO6ck2
 HR/BuWF4jkvFSHDQEs3cBjsOVfS059q6X1mYe7nyLpabbnppFT8lh1zChlumr1XRU0Sd
 PmdoPzJUQXKMqzUf4BQSL5Enmyrg66u2zs5KFf+wxHd+EsKQBnAnatVWdd3kYvhLo9hU
 U0ejTgcMEBLi1iFXgL9k5k9HePKvpfVKFVYvNPy3OjQa1uoCYnBK7gRsL2w+xXJfe7hZ
 xfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764023124; x=1764627924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBLz9avz3yru1xckhK5SxWQcC8TCI/GihsARTXSat+s=;
 b=k1kxOH9tAl4VFyeoejOYoQhsMiPK5blHi7/XM8dQWIhYWvV4rkxXQuM01o8CElLc22
 VvK+kso+4eviYwzOj8OBPn3iSXIVNRa74JVO8gmWlKPf8JGhLXTrzSAd4GKcU+GyjlVv
 cJg3icP4Sq10G+oVFC78mVhq1LwFFGN9GBllLeOTKco5cdoWWXieOqVwbUF09QDnJDjg
 RHhQvfRMkSz28mezU1+AuexGprL2Xyi437abzQr3QjXECBmRGPvnZoOnf7PoHBoXnJgn
 /WNQTgS2DqYuEIKpAeIHHDLn4OiwwRdcXTAv0NQraOlN2xNj2vn4DiF8dBv7sioyMCgS
 xO6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZEUClJF16KO5txljWKwtb79NsPNAGmOsMB5fEZBXZ43nUejmLzkFHdZi6KyrRTDoKKN7LlCY=@lists.denx.de
X-Gm-Message-State: AOJu0YxzcjOSGobP/lARvh4xqgftixHzUIBx3nqovOHDofeYcp8g0yBA
 JpNSnUXxTjtLF/6X4zPh4+hKL33loiXzyP2VgHVNZiCw7oA6xNLpLry84B7mSjl4vA8gbP8M8S4
 DwCOS1TZi5qMHRjgVWZRAofjPG2gORLo=
X-Gm-Gg: ASbGncvoLufgGweA4Y3XmzfjQRkD1lVTb36/IUb8Dd9CdU9xZGGFAvq1uw9ytjbrO9C
 fYmLVgGICrocRs/7c1ZAEOGG856AGKnEiFOvuIuWme8aqAb+VfL8JB/mBGUUBHESfei3RwwN7Z8
 cbp4u5D5lHPkg+NH9ph/jYkAb8p5yYbgGShLjO6knPTovYo7vTDBExgUYo8riJXQ+rKHlWpf3cJ
 X/rfG/8b1pBIaYW0qi7eS9j9UIxopx6qcf2LJ7gbMZofNiIYilCMOHsMz1F5GLDEa7/Vu99
X-Google-Smtp-Source: AGHT+IFjrxlV7bAgRKFSR3B0H7Gip15JMWi3FWWOYfu4XOvt6tqKblTa3YAeOpFK5i0m0PAwzKiQXIlpeekfBvIJuBs=
X-Received: by 2002:a05:6830:922:b0:78e:a394:ca24 with SMTP id
 46e09a7af769-7c798f7fe84mr7676376a34.8.1764023124242; Mon, 24 Nov 2025
 14:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
 <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
 <CAN7C2SBU1xozPwfRG_tdcqos4jDZRm-qzXR5MEVTG7jXebp_7Q@mail.gmail.com>
 <20251114173535.GD6688@bill-the-cat>
 <9cc70ebc-2391-407c-97c0-78c687dc7915@altera.com>
 <e2557c4f-19b8-45b9-b956-a8131271c7a6@siemens.com>
In-Reply-To: <e2557c4f-19b8-45b9-b956-a8131271c7a6@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 06:25:13 +0800
X-Gm-Features: AWmQ_bkn_GcE_HSr2sErF9Xtdzwd7mI5ge3zrKcWXWL0yTtZ8lDbu4SkDr0HKQ0
Message-ID: <CAN7C2SDc9uQO40+hR-tsTW490sCMUAsLsb_52a3kvHqiDOLtYg@mail.gmail.com>
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
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

> I'm all for finding the best technical solution in the end, but I wonder
> if we can at least come to an intermediate solution for the upcoming
> release so that folks do not need to carry too many extra patches in
> their pipelines (https://patchwork.kernel.org/project/cip-dev/patch/cf43e9da3cfc59771e801d3215d3b3794f3602a8.1763446144.git.jan.kiszka@siemens.com/)

I am not sure why point to patch v4 but I did provide the final path
version that T.F. should be ok with.
https://patchwork.ozlabs.org/project/uboot/patch/20251114160423.1518-1-briansune@gmail.com/

What this delay is that there are several feature coverage on the same file.
Meanwhile, there are several similar patches pushed and T.F. action time
is a bit slow.

The very first patch was almost two months ago.
https://patchwork.ozlabs.org/project/uboot/patch/20251019092341.1158-1-briansune@gmail.com/

So I had no clue why that huge delay. BTW it is supposed to revert
that pointed out patch to easily fix things.

Brian
