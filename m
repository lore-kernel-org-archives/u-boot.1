Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C16CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 14:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B1D83DDD;
	Mon, 24 Nov 2025 15:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TZgwcU0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A057C83DE4; Mon, 24 Nov 2025 15:17:47 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8380483DCB
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6da5e3353so3107989a34.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763993864; x=1764598664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fgekWoYPsb8J/Ozw9WMhKBBRYjW5fIg/uLGqKIYbpGQ=;
 b=TZgwcU0uyIiD4yNZq75P/JAuo8ptjAoL2YJuC8lX+vtCmxkdugxpXxsCBC1GKV/E6Z
 Sr6G2+/dCqYWKEDoHtqyBvglqMwrSX64H9cxmmzuOOhYst/P+AQSF2uoSLkxRiCE2K85
 y5G466w/42dWEzkGtwe10W4XvhIlwr17NQZD4Zc8ybF+zuR42K6IapSL0cXHVei/Ud6+
 UCE+K571c3+4SNY8fjABkhd9ZkvvnXXRQIX9sdOgxnpM6O8icV/Xf+uX6CbwB+4Rl3fF
 qJXvnnEnq/zaQKH/E/cF/efFVblgmg1A+7ClUn+uSVz2Ny3SmTCqat+Qv0cMRcgYmLw6
 gyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763993864; x=1764598664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgekWoYPsb8J/Ozw9WMhKBBRYjW5fIg/uLGqKIYbpGQ=;
 b=pnsdDXP/AL2LQTIVX+7/+BIOSwAAuXzNs6B41O0R7aQBIpGJbsVU/Y9w22vwDAwmiJ
 jFHC6Nvsj/kXo8GQ6CTgaBWPVUPUiMyro31X3DpD1Gyi/1wv3XY0qz6kkeMnHqbUawXV
 iOvzBdlO+//uHf0I7PcCfuIKlY4340C0/TJ3B3o295c/MIX641v9l9GPhT2TVzSvoWwN
 GzsKur71q9RoI2wMwuCvxxwVUy717qRkWHaJNYriDf0QWIcg9avdHE613gjMrAyqtnMp
 ytMCutotrNm0E48cjLZrlY4MUovY1N+bkup6X0gIP0yj0KDgBSFyY2TFW2/meJ4kprrZ
 XYgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXa+vUyKoYBoKS7ZhsMC21f3IGwigQFBdUjIUFyhcMS8xGxF86HZSMCtIY3FOSI0GFNlZ+kbM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3/PL3rXFPiG+vt6wsc1TSnEhk4yB2iHhMOH1BVCI0sq3HeYKV
 8q1s6fchLpy3x4OQ475smHbb+oT7WouSQSb5mKDwP5Fby6zvKMyriJKgkjbGxXxnOpG4M0yASEz
 TW2hVr6tP8HYGbhOZr/TNcxbxilMPqLedoH1P
X-Gm-Gg: ASbGnctYMhdg7Ymu+oTJE1zw71+lj+/Ne+XmaAhcZmoMi859A845rzvaZd96gDBIUio
 4hFo6cfUdtrdGaB4Cl9LVDQsHgx6ej1wlV6rAP1EeX5yMPIMc86Ew6Gb9ZJxfnqCvTSAGYgV9Ni
 kaYibkTV9iwZKnmS+rPafNp+7OoKyNfvprHQNSGXwT247snrD3kpXQC8DuSC8duldbi8xj8AYCw
 VNqLfADoeWN9AOAFXS+q2tNU17yVOUCx2jjGIKu8YsfdxWBG2QBXlniKVR9Oyh3j2wdusMD
X-Google-Smtp-Source: AGHT+IE1dXd3XbP2hWbOr7w9oqLlh7bi6lMLF8fqq2ZkoteKZXAWmkIGYB70E/9d98vMbHizUVz7+fdfvQeXgsUsL5E=
X-Received: by 2002:a9d:6148:0:b0:7c6:819d:bddd with SMTP id
 46e09a7af769-7c798d04506mr5525433a34.34.1763993864068; Mon, 24 Nov 2025
 06:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
 <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
In-Reply-To: <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 24 Nov 2025 22:17:33 +0800
X-Gm-Features: AWmQ_bnQy099N94CPSZvq7134patv1yogF1HJVuKg1lkMsg0RGzlWM5SmYpQrMw
Message-ID: <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> Device Tree is representation of the hardware. Is the watchdog present
> in hardware? Yes? Then status = "okay".
>
> Ideally, the board shouldn't fail if watchdog is enabled in DT but not
> the driver (and vice-versa).
>
> Do you know what the actual issue is? Why does it fail when watchdog is
> enabled in DT but not the driver?

Best guess watchdog timeout.
I have no clue but this is the case.
Otherwise it cannot explain why it is always at the point of message
check and fails.

If DT is enabled but not the driver then the driver is empty from first place.
AKA the watchdog never initializes proper cycling? (my assumption)
If the driver enables but DT does not then it simply disables during
probe or ops?
(also my assumption)

So simply said w/o the socfpga watchdog driver it is problematic I guess.
So always complying with the driver and leaving DTS to do the job is the
most stable case.

The above are not confirmed but actual hardware tests show this behavior.

Brian
