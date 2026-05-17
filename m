Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032A2CD4F3C
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4806E845E3;
	Sun, 17 May 2026 21:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YclUz37s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C3D08460E; Sun, 17 May 2026 21:13:56 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2518D83EF9
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=electronicconsult1@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5a4113ab355so1941467e87.1
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 12:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779045233; cv=none;
 d=google.com; s=arc-20240605;
 b=YrMrU+1tdiVHymuzCcq9IP00Vp1VPYHG1erWqstQVFym4yPX/loFOaE+b4hB6fB9Hy
 +HH/brYKRnCHfbqHh+OTc8ytVOzkbhvFzSD9DvT3cApm7QJofR54WpJqEFd+Es3HB3R7
 Y+DPIqvJhxoSZpZdii2ToMTA3WjQSFYeoqEgqEAhuLmH01BDLFko6SqM6F+lF222ZZTF
 GG9QhtIrfKosDOt9Nj93UqvVLS+Kx7mxqMjp3kYqpx/r4FokBy0RvrLNwcbL7C9eLY5Z
 Wc3eq/9Y6X167CF3ZZWwQBdjuP7Q5Pd+K0HfrckzfCoKn3EafqFv24qUg++GAwpFBGIF
 /MaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=1t1WRcHak5iKjv2RpJ6BXqA81PxixQRDc0EQ/733X7k=;
 fh=l90yqdaRHtFzXWlMYUxpS/f7fFA1obgYwGbMnmGJsWw=;
 b=VfoOInoEsyVRXiONNg4k8bWxaNVJM0te4HH979eJn8u5d8nrBnyubwCWVjzIWPfoy5
 TYP6uRG///AvwfDshObMBKEff5W+l/kcQf0BlNRPCD5OWnGZm2NP5PvHIUYmkjobe53r
 Y/V998/zCVx2lBsdLpRo/ym3WhOXUQvv+irNKriGtLZbBL9GV00b1TOZ6aK7Ws4vmQ7S
 GOJ0GEUFb4afcQVHc6WbmGVhMIAMJoK5fR3Lg9TkXTKDgkX/DJP6paMplCXAuzl+Icc/
 WBMENqWwjmhMxF0EYz8gyZi74ecsTb8skOz/Agz9svWesNOmt2TKRwvCVjSBYy661Bz1
 rj9g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779045233; x=1779650033; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1t1WRcHak5iKjv2RpJ6BXqA81PxixQRDc0EQ/733X7k=;
 b=YclUz37sPorUUyRqXPGkfy0Pkps3Lw5zilc2m7ClGDzZgMbfNW3dtL9NR+bZqzMY70
 N/eDb3aIv25s0rgTYva3HcX1HYFBg2+zvDv+1pVzF+HW/EGTd+QKnboWBxGtL+rNHsdA
 WiXaYKlZqd8eRSTfaS6dHq7jtR5QN7sNIWqkQdY/MciqrP9MNotchRbx/uSpjm1JbyCN
 cLHdsRb+QDqX+uxN0uBJWo07Cl1CODqmWZnpgoumM5Yemrbx7N7Iep7QhtmAl2J78lX/
 SvWqnLWgloKrt4Y81hHYbsSADe6mKOLNov5R7RMBTw6Bz9CEU6Ah9JPD80UwcgY/Tevr
 KnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779045233; x=1779650033;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1t1WRcHak5iKjv2RpJ6BXqA81PxixQRDc0EQ/733X7k=;
 b=TDbBIUnPpfLiboq2JnnhHw5yaKdoUWp5IZzGo3k/w/gCdafeImK+FBF1o6yoCvl0+S
 wruvD9gK5Y+oo1lIjZHSW2aK3Dzubi8qj7dWJHik2gNRqAGFC+OWM9JcI6yRumJZ5Spm
 OsrAmvf+qMDDuarBzHvqnH/fU9Nx9NwGyEmI4pbeC2TDRkVPPU3/1nj8xBzw+HSAW1yT
 pcUgttfp2nHgpHeFNbq6d1N/CMt5O2n7WC4PSywd1L0gRVmXwOf5hpvvjpewxdisQqGh
 8TBPQo3qPw+Scm7ThR0zWuEkP0aCy2vSECPzYryVYNvQfkvt8OlcHwsaFE4Di+SnhwQq
 BXqw==
X-Gm-Message-State: AOJu0YzlTi0v5Gh6QnpKVb4E7iFDTRDBZbGNxg9sRNMYF9DBIdoizqBU
 At+skSjgFPRUclyYwfmdHr0bRVgiVdB+F4vJAmZsuqnmMQQWsKex8y+MTlfm8zf1q7Rs9u7vRB2
 Rl6zLsDR6v4kBqO0N0Ma8dmnj3Hnesj2S4QC3fzg=
X-Gm-Gg: Acq92OFxSLGkkQmbnmGD581BpB/ksL0LjKxMdjfNSUf1unF/dgxvkqTcm+ANahz3jGX
 Utqnsu0m1W7eKo50w1OuskHijvhF95RUTrieKF6IlhnketQX5pZmzvrXGCHpR7r3tMT+1JvUQoX
 OF/ydh+g+41FiPxiwXL6n4BP9X+O2zxvjbl9XzfdOQVoADsxAaTnA5csb7dsAgnf3Qec9FBgF1a
 0ezPJnkFg9N5DPiepoD64hq4Xp8RoTiT3aoR8ruj92NqKXB+a75eE8OtUsXecDsFefFaINxYf13
 /lmA5ZaF5BPvms7eEEPWXjJOwIibpJZeCI0Yzr26z8Z6kN0u
X-Received: by 2002:a05:6512:33d2:b0:5a8:afc8:c37 with SMTP id
 2adb3069b0e04-5aa0e60128emr3421804e87.4.1779045233120; Sun, 17 May 2026
 12:13:53 -0700 (PDT)
MIME-Version: 1.0
From: "Owen O'Hehir" <electronicconsult1@gmail.com>
Date: Sun, 17 May 2026 20:13:42 +0100
X-Gm-Features: AVHnY4KZN7lI3TvUMaMx2QQEJHGGqykUlabjB3d6Vf1Us55s4v4S08tYbkW6jI8
Message-ID: <CAGUWaEFQMDnX=gHbRWQiDuh=OWsr9BnUksscNQ9=y1kLsAQZ8A@mail.gmail.com>
Subject: =?UTF-8?Q?RK3506B=3A_FW=5FDDR_secure=2Dregion_enforcement_=E2=80=94_what_d?=
 =?UTF-8?Q?oes_the_vendor_TEE_do=3F?=
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
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

Hello Jonas,

I noticed your recent work on the RK3506. I've been working on
replacing the closed `rk3506_tee` blob on an RK3506B (Luckfox Lyra
Ultra) with an upstream from-source OP-TEE build & made some decent
progress but one part that I'm stuck on is DDR firewall (FW_DDR, base
`0xff5f0000`) locking the secure DRAM region against the non-secure
CPU master. I believe you skipped the secure world element  but I
wonder would you have any ideas?

So far I can:
- program the region-map + CON + per-master (MST) registers and can
read them back,
- reproduce the exact register/value/ordering sequence that the vendor
secure firmware uses.

I've verified
- With the same idbloader/SPL (mainline-style U-Boot  `arch_cpu_init`,
which only does the MST grants), the vendor TEE enforces but my OP-TEE
does not, NS still reads/writes the region.
- The SGRF slave-security set is identical between the two.

So there appears to be a precondition outside the FW_DDR register
block that is set by the vendor secure firmware's broader init that
makes region checks actually apply to the A7 NS master.

If you or anyone has any pointers to the FW_DDR register summary or
how to set this it would be gratefully appreciated!

Regards,

Owen
