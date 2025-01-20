Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B11C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39041801CF;
	Mon, 20 Jan 2025 14:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VldHG0F0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C09AF80711; Mon, 20 Jan 2025 14:51:17 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3310C80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so3393319f8f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737381074; x=1737985874; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N4IqZWGohg131OczhUQvfFyOfVl02nOKO6yxrwTbcW4=;
 b=VldHG0F0DOsx9tbT9nYQeKp+ZWF6SepG9997iiLnK7VmUefxtbBOSbNZAGrg0Zqx3V
 k2+L0t+DKcC/IR7gWWqA/WDmHyTUTXUxqWYBu2xJ3Tpjm7AOAd3DLf1HUphbE9r9GziC
 eAxGkLpHH+scEeRwo+i2f+d4s30Q+WLUfSeB8wvVX2sCXY0wpIyoVpdi7XkFl8SjBEPO
 60kMlavDKOpgmqwUsPIuHZGAbLirrhGDldp5Gvz5pYI9w1gp7gyjHM4Zw2nKjShlIwr8
 mGyWaTbrO0/ki0mYeXLBmdxVUhY4jq/Eak6YSTl1UuFYGBWl1ODGJrMaVG1Fc5jc9SpL
 NJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737381074; x=1737985874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N4IqZWGohg131OczhUQvfFyOfVl02nOKO6yxrwTbcW4=;
 b=U2+NuvLtlLKcyLuwkQqg9WASUcogTXxz/wk/JVv3jkXKbnCr3epMUZveuZllOABOca
 HCzXP7d2CC7lzUXSlr4LIx6wtjtavt9C0/Hnkn8rdQFwM8bXGFYtTPVJJsLu9PVrrpGk
 oT37sbihnLR2UMtUVn641iwr6fQmJOZ0iGpH5kmoBsf7QYFt3JHkyTQ9zHQLQligWtF1
 5ggYM52lUdP7b0znpv7PnjkApR2U+9JqEsOYbvRxNoj51XNoN0ciaY4NAdbDPvpFzd7E
 BLiOB8236JL17RV0kMpN5t+ccc/cmb8AVXvlManAD0BxUA2sUFXRRdrJdP49V0zVzcUH
 23ig==
X-Gm-Message-State: AOJu0YysKDZ+svbG5Pj8BZ2WkYmp892MYwxfm23aqpmj42PDyLTrXmpx
 ZYsOYWI5VY2w9RJTtNVtlR38LaWE2HR5+LpGJlgXL4znPAiDVRObKChaWTDgFYuQ4YlJwi3YCF6
 5XMPLMDHk
X-Gm-Gg: ASbGnctm8bUqxfuq+WAzcOagk8T2hWtolRGMPwHs2/fhdqiXDbgL6ckX9zV8pIFFugz
 l8+NV9ZVa7wiCP0NAyIK9h36foj2wyIqgYUN4GTe9XiuxtPb1RFJ+ZMPsg7tnvGJEMcDk/4Gpjb
 L3BbrNMWsg+RT+ZlWXT7+n2jvB2yIAWZDLGM33gMTdifiGU+8vGcmEGpYg+20IIT5bk1O7t3PjZ
 dOXW0qoAW2bwaWbRpg3zjVmwTNPF44CMz5TQHZ7rG3uMeMqsvBW/NaTGdRLKIfLtRA4+KmyxzD/
 mBc=
X-Google-Smtp-Source: AGHT+IHc2eHb+/KAH0/PODsKrnU0nkDCd3UA2AfKBIKZP8Pz/HKuCUKiIhz8WYCV9/Lq8vGXco1CBw==
X-Received: by 2002:a05:6000:401f:b0:386:3711:ffa9 with SMTP id
 ffacd0b85a97d-38bec505c1dmr15433750f8f.16.1737381074442; 
 Mon, 20 Jan 2025 05:51:14 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9ae8:b2a8:a305:f9b4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c0f026c0sm108202225e9.0.2025.01.20.05.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 05:51:14 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [RFC PATCH 0/2] Coroutines
Date: Mon, 20 Jan 2025 14:50:42 +0100
Message-ID: <cover.1737380886.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series introduces a simple coroutines framework and uses it to
speed up the efi_init_obj_list() function. It is just an example to
trigger discussions; hopefully other places in U-Boot can benefit from
a similar treatment. Suggestions are welcome.

I came up with this idea after analyzing some profiling data (ftrace)
taken during the execution of the "printenv -e" command on a Kria KV260
board. When the command is first invoked, efi_init_obj_list() is called
which takes a significant amount of time (2.872 seconds). This time can
be split into 0.570 s for efi_disks_register(), 0.811 s for
efi_tcg2_register() and 1.418 s for efi_tcg2_do_initial_measurement().
All the other child functions are much quicker. Another interesting
observation is that a large part of the time is actually spent waiting
in __udelay(). More precisely:
- For efi_disks_register(): 421 ms / 570 ms = 73.8 % spent in __udelay()
- For efi_tcg2_register(): 805 ms / 811 ms = 99.1 % spent in __udelay()
- For efi_tcg2_do_initial_measurement(): 1395.025 ms / 1418.372 ms =
  98.3 % spent in __udelay()

Given the above data, it was reasonable to think that a nice speedup
could be obtained if these functions could somehow be run in parallel.
efi_tcg2_do_initial_measurement() unfortunately needs to be excluded
because it depends on the first two. But efi_disks_register() and
efi_tcg2_register() are clearly independant and are therefore good
candidates for concurrent execution.

So, I considered two options:
- Spin up a secondary core to take care of one function while the other
one runs on the main core
- Introduce some kind of software scheduling
I quickly ruled out the first one for several reasons: initializing a
secondary core is typically quite hardware-specific, it would not scale
well if more functions than available cores would need to be run in
parallel, it would make debugging harder etc.
Software scheduling however can be accomplished quite easily, especially
since we don't need to consider preemptive multitasking. Coroutines [1]
for example can perfectly do the job. They provide a way to save and
restore the execution context (registers and stack). Here is how it
look like:

static void do_some_work(int v)
{
	int i;
	
	for (i = 0; i < 5; i++) {
		printf("%d", v);
		/* Save context and resume main thread */
		co_yield();
	}
}

static void co1(void *arg)
{
	do_some_work(1);
	/* Mark coroutine as "done" and resume main thread */
	co_exit();
}

static void co2(void *arg)
{
	do_some_work(2);
	co_exit();
}

void main_thread(void)
{
	struct co *co1, *co2;

	co1 = co_create(co1, ...);
	co2 = co_create(co2, ...);

	do {
		printf("A");
		if (!co1->done) {
			/* Invoke or resume first coroutine */
			co_resume(co1);
		}
		printf("B");
		if (!cor21->done) {
			/* Invoke or resume second coroutine */
			co_resume(co2);
		}
	} while (!(co1->done && co2->done));

	/* At this point, co1 and co2 have both called co_exit() */
}

The above example would print: A1B2A1B2A1B2A1B2A1B2.

- The first commit introduces the coroutine framework, loosely based on
libaco [2]. The code was simplified and reformatted to better suit
U-Boot.
- The second commit modifies efi_init_obj_list() in order to turn
efi_disks_register() and efi_tcg2_register() into coroutines when
COROUTINES in enabled.

[1] https://en.wikipedia.org/wiki/Coroutine
[2] https://github.com/hnes/libaco/

Jerome Forissier (2):
  Introduce coroutines framework
  efi_loader: optimize efi_init_obj_list() with coroutines

 arch/arm/cpu/armv8/Makefile     |   1 +
 arch/arm/cpu/armv8/co_switch.S  |  35 +++++++
 arch/x86/cpu/i386/Makefile      |   1 +
 arch/x86/cpu/i386/co_switch.S   |  26 +++++
 arch/x86/cpu/x86_64/Makefile    |   2 +
 arch/x86/cpu/x86_64/co_switch.S |  26 +++++
 include/coroutines.h            | 151 +++++++++++++++++++++++++++
 lib/Kconfig                     |  10 ++
 lib/Makefile                    |   2 +
 lib/coroutines.c                | 176 ++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c      | 113 +++++++++++++++++++-
 lib/time.c                      |  14 ++-
 12 files changed, 552 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/co_switch.S
 create mode 100644 arch/x86/cpu/i386/co_switch.S
 create mode 100644 arch/x86/cpu/x86_64/co_switch.S
 create mode 100644 include/coroutines.h
 create mode 100644 lib/coroutines.c

-- 
2.43.0

