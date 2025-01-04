Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAB6E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 01:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565B6802EF;
	Sat,  4 Jan 2025 02:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kzo+8YVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2FF8034E; Sat,  4 Jan 2025 02:55:00 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3035801A0
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 02:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa692211331so2421986666b.1
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 17:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735955697; x=1736560497; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mqkMxgZsrEQ0zshC+MIMTgaMtxDaJKYcuHJcDxXZhdQ=;
 b=kzo+8YVMBo6F44h+/2H/iSw+Aknx+on1Gf96IbTg0R3EXq/b5uy05YKIfAZuaSWYPh
 jYovZ9wuKOncVefR4ml+Taa4qRyn+eK/dDhbzKK6YPGLp2AXZh5W3R+PQyw690T7wVsZ
 zmNVPCTZzHkBsLfBE1nrqeUpJf8cy3KXAVRSh7z7dpUaUbILhZMmGs1hQyycI1qWu1i9
 hNmkuHoEVYwlazm/dsE/9f0mhDjHXLggVr4HsESlC2Cs8/Dbr67HpwCoeCWmSAwNGgH+
 GdNOMZF/Id+lq+wb3jhXDTMLTaW/oTQsrCioPuXYVTg01L4FrmBtlz1fWNp7It77MefT
 RmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735955697; x=1736560497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mqkMxgZsrEQ0zshC+MIMTgaMtxDaJKYcuHJcDxXZhdQ=;
 b=Io6+go+R2QTHcAv6752p8Fsk4eoIjpKZoupHobZxt60qrkdHMgDq8/XqPZmaO9id5k
 5p8zN6KbqnUI/VDu+4BPoqjnAOnTz7mWphknV2s8mukuPQ4qsBW7+uM+wmDQvpp5me7G
 MM2LhStKM8eetazfwaixeZ233Fgq1KbQW/qwyQmkp293xaF9LyDspLp+/+DF+YRSrq0V
 D1Wi27obioTkLyqDuVJ2zc3cmcyHKFag6RuACz61woxBtW3VKivajxGvCYHFjwvVqmg8
 8/nzbnY2byrbk8AwWLE9LSwxzbvTERL9MSbBGMN+JF6Em750XezyEYAtvemavddOhto1
 KIiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPGWoDT4eSN1inPShZJ8WOLRboXJ/PsChOljrIPTiT883Gd6Iz1SB5eBw6lvPZ2yEaF2mf/Wg=@lists.denx.de
X-Gm-Message-State: AOJu0YyAWb0fOj1QDI9Y9pUsF83CDlLSiZbN/Nct6J9tQyTDkmG7rUY5
 4N/i3Rarkas7pSMygH9FqJS/V7Rgtvs11HBh8rjmgaFXgvECwT/DnRGHnUoCzro=
X-Gm-Gg: ASbGncsZ/utlnhbz7VNOBXo4X1YXYJagofB2D5tC2V2hSOn1ptI8FqsbOFTn6G1NiNO
 LsetIdfPLM6NJGcb5TMjv8nyCaSZjYjDbLcXeGne73bXkPMQMvM5aiCm/CZrcPdYoJ4CQPDj+eT
 WcPzd58kapv2JBvpXQZ5L2yuQ6JO83QE8zyekyyxEiszrOCBY+J+9piek5pPXMNi+crvl96s02T
 Buovd3T99e5WMENIhesokQf436kyEFElQr/DhTRnn4cQ3at8SjuvR0G2R3zl1pLswbgppfXphQT
 6qEymGhK/TfzY35psf5FQ6yd3VXquQDxKpP0kTA=
X-Google-Smtp-Source: AGHT+IGcumLasylZujgUaZUENg7jZeZi8yejmp8alfUiGmpnJF0X4hT0KG6dC66K6tXiPdnll9XHXA==
X-Received: by 2002:a17:907:7f20:b0:aaf:1f6:7423 with SMTP id
 a640c23a62f3a-aaf01f674b7mr3414627866b.18.1735955697150; 
 Fri, 03 Jan 2025 17:54:57 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f06deb8sm1937783266b.190.2025.01.03.17.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 17:54:55 -0800 (PST)
Message-ID: <b77c543c-56e1-42e7-a0ab-874921049873@linaro.org>
Date: Sat, 4 Jan 2025 02:54:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] board_init_r(): use static calls
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <cover.1735896540.git.jerome.forissier@linaro.org>
 <c86ca0914ab1496a7f63371e47f36f2109d7d97a.1735896540.git.jerome.forissier@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <c86ca0914ab1496a7f63371e47f36f2109d7d97a.1735896540.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 03/01/2025 12:13, Jerome Forissier wrote:
> Replace the init_sequence_r function array by direct calls.
> bloat-o-meter stats before/after on u-boot.bin for configuration
> xilinx_zynqmp_kria_defconfig are the following:
> 
> - With LTO:
> add/remove: 87/128 grow/shrink: 8/23 up/down: 19743/-20923 (-1180)
> Total: Before=1067882, After=1066702, chg -0.11%
> 
> - Without LTO:
> add/remove: 0/23 grow/shrink: 2/0 up/down: 795/-1112 (-317)
> Total: Before=1119494, After=1119177, chg -0.03%
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---

[...]

> +	INITCALL(stdio_add_devices);
> +	INITCALL(jumptable_init);
> +	CONFIG_IS_ENABLED(API, (INITCALL(api_init);))
> +	INITCALL(console_init_r);	/* fully init console as a device */
> +	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO_LATE,
> +			  (INITCALL(console_announce_r);
> +			   INITCALL(show_board_info);))

Not that the array was extremely readable, but I think this is
significantly worse. Particularly as my IDE will no longer grey-out
sections for config options which are disabled.

I would honestly rather still see pre-processor #if's here, or at least
something better than this semicolon-in-macro stuff.

Kind regards,
>  	/* miscellaneous arch-dependent init */
> -	CONFIG_IS_ENABLED(ARCH_MISC_INIT, (arch_misc_init,))
> +	CONFIG_IS_ENABLED(ARCH_MISC_INIT, (INITCALL(arch_misc_init);))
>  	/* miscellaneous platform-dependent init */
> -	CONFIG_IS_ENABLED(MISC_INIT_R, (misc_init_r,))
> -	INIT_FUNC_WATCHDOG_RESET
> -	CONFIG_IS_ENABLED(CMD_KGDB, (kgdb_init,))
> -	interrupt_init,
> +	CONFIG_IS_ENABLED(MISC_INIT_R, (INITCALL(misc_init_r);))
> +	WATCHDOG_RESET();
> +	CONFIG_IS_ENABLED(CMD_KGDB, (INITCALL(kgdb_init);))
> +	INITCALL(interrupt_init);
>  #if defined(CONFIG_MICROBLAZE) || defined(CONFIG_M68K)
> -	timer_init,		/* initialize timer */
> +	INITCALL(timer_init);		/* initialize timer */
>  #endif
> -	initr_status_led,
> -	initr_boot_led_blink,
> +	INITCALL(initr_status_led);
> +	INITCALL(initr_boot_led_blink);
>  	/* PPC has a udelay(20) here dating from 2002. Why? */
> -	CONFIG_IS_ENABLED(BOARD_LATE_INIT, (board_late_init,))
> -	CONFIG_IS_ENABLED(BITBANGMII, (bb_miiphy_init,))
> -	CONFIG_IS_ENABLED(PCI_ENDPOINT, (pci_ep_init,))
> -	CONFIG_IS_ENABLED(CMD_NET, (INIT_FUNC_WATCHDOG_RESET initr_net,))
> -	CONFIG_IS_ENABLED(POST, (initr_post,))
> -	INIT_FUNC_WATCHDOG_RESET
> -	INITCALL_EVENT(EVT_LAST_STAGE_INIT),
> +	CONFIG_IS_ENABLED(BOARD_LATE_INIT, (INITCALL(board_late_init);))
> +	CONFIG_IS_ENABLED(BITBANGMII, (INITCALL(bb_miiphy_init);))
> +	CONFIG_IS_ENABLED(PCI_ENDPOINT, (INITCALL(pci_ep_init);))
> +	CONFIG_IS_ENABLED(CMD_NET, (WATCHDOG_RESET(); INITCALL(initr_net);))
> +	CONFIG_IS_ENABLED(POST, (INITCALL(initr_post);))
> +	WATCHDOG_RESET();
> +	INITCALL_EVT(EVT_LAST_STAGE_INIT);
>  #if defined(CFG_PRAM)
> -	initr_mem,
> +	INITCALL(initr_mem);
>  #endif
> -	initr_boot_led_on,
> -	run_main_loop,
> -};
> +	INITCALL(initr_boot_led_on);
> +	INITCALL(run_main_loop);
> +}
>  
>  void board_init_r(gd_t *new_gd, ulong dest_addr)
>  {
> @@ -734,8 +740,7 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
>  #endif
>  	gd->flags &= ~GD_FLG_LOG_READY;
>  
> -	if (initcall_run_list(init_sequence_r))
> -		hang();
> +	initcall_run_r();
>  
>  	/* NOTREACHED - run_main_loop() does not return */
>  	hang();
> diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
> index 44239da5280..1b072df73b6 100644
> --- a/test/py/tests/test_trace.py
> +++ b/test/py/tests/test_trace.py
> @@ -201,7 +201,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
>      # Then look for this:
>      #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.006 us   |      }
>      # Then check for this:
> -    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    calc_reloc_ofs();
> +    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    event_init();
>  
>      expected_indent = None
>      found_start = False
> @@ -224,8 +224,8 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
>                  found_end = True
>  
>      # The next function after initf_bootstage() exits should be
> -    # initcall_is_event()
> -    assert upto == 'calc_reloc_ofs()'
> +    # event_init()
> +    assert upto == 'event_init()'
>  
>      # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
>      # time
> @@ -274,7 +274,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
>      # We expect dm_timer_init() to be called twice: once before relocation and
>      # once after
>      look1 = 'initf_dm;dm_timer_init 1'
> -    look2 = 'board_init_r;initcall_run_list;initr_dm_devices;dm_timer_init 1'
> +    look2 = 'board_init_r;initcall_run_r;initr_dm_devices;dm_timer_init 1'
>      found = 0
>      with open(trace_fg, 'r') as fd:
>          for line in fd:

-- 
// Caleb (they/them)

