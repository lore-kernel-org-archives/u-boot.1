Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC49606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=khQTEcff;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hgxP+YGA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B1CC812CB;
	Sat,  7 Nov 2026 12:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dHM5CTsPgrDe; Sat,  7 Nov 2026 12:49:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B462812CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055792;
	b=jBp6MFRv3MwiO7vwIFpbDL97gK92YD7QWPfFoUK4ZiuwMeGSKz3wmuJOJ6Gxpea8TpVi
	 w9OzYl5yAV13j+ykG+yiiL+M07mM7F5h36uygk1dHispm14pIzrr6p0BD6fr+ykk2ArUQ
	 BNMFTWq7cUjdfPU0coLqye0k+sST45phb71dWFMPzhlyLUCmnAKReao1EYEQ7k6FCNNny
	 lw71RctV9o4SvUqu0bHV+xBIzStk8vwTZo1MbvZI4ZFl4Ci+GWMPqNOXycHfRN+cJIxVI
	 AcSd3cBEEJYX850jZ34RpNdW7B56kURL0x4iVdFjYd3tgPIIWPpK0mHQxM1TwhqYIFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TU2t33EGiqp/LjXehRHFlNroU8sFwni/riOs5yClKlw=;
	b=QHGhXmgEMvTMC/qXOvYROg7YWa3eZ6zAPXt+UaBBdIa3r9AojlQKjSbaAy/PRuM7phkz
	 czGY+rJJiKkmD5iG6B+KnNe7plMOtQxFHXczI55GQj/4C3/76Ck3+kZjZtV+N6RDWUa4e
	 f174tvE6GHxfgTrCSfi7XVAVLlnCbF4iDKitxYOD+iB4GsyYq0qi4V9Qeb1BSPuYBIDw+
	 veXbAGSfvoEgTaBw3Glq5THt82uONSAdnWJgK64s1ysuB8Pc3k4klgGdK134jJZAPx0Nc
	 WoFHxGp1f2ht2d3/MP+mthKfvbv+cli0ITMu+z9bsX8qL4UzWuYHsGKeZvfHsl3Dhgw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055792;
	bh=TU2t33EGiqp/LjXehRHFlNroU8sFwni/riOs5yClKlw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=khQTEcffoWrOOsONE511m0lufiOZuXbasGVem80eqNaMwT8buqeIaRVOE4dvke5q0
	 J7vJgOdq8ea69xkK/y7RxtdenuindvtcvyM5W0HG8q5xQD7wifzZSgLOPCZAZHzaG5
	 Z8ALfssPYOs1c6EgUUyxWCcbn77t6k575QMoElV/W+iMUQs4how6f7uKeU8FB3gnCd
	 DuC75fsEes7KRxJ88S0JOHLWiiyF/2EPgjhVVd1a9ux4ZDkiqm2RCsJ1S/2fY+pep2
	 ETTst5LCd33bjitaXTYcr6Ix2etgH2RdRbSP2j9vFbL1YSC2HBnh0gz80rZg3QkCgE
	 fJV0qUSfwpaRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B462812CF;
	Sat,  7 Nov 2026 12:49:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2065431F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 069064005F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MG3iqCSxnXKS for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:22:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 66A2D40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hgxP+YGA
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66A2D40042
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:32 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6aa046a99c6so244877a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036150; x=1794640950;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TU2t33EGiqp/LjXehRHFlNroU8sFwni/riOs5yClKlw=;
 b=hgxP+YGAelwWmbrq8Tnu9hBqlECeQNmWE/ezsnRCAf1BeGjAnJgLFFyCn1X+auxnzr
 Gm6YOeEGX+V85//oTKmTWYfupAU9LPaY2T8Y2Wd4Fc1U0BmxUpxSz7yVhOKLPVoC7mQT
 EPiqgAPXq3AcCGxPe5YDhCk0n4Genk7bnNR0xmbCr1STElJv5EEF+xnLRzGk7o2XH9ea
 Eqv0PBytV9dM/8xUFj3HbHvidaW3Px10c3tQBlxOUm8pSu2cqU4KTKtZG00aRerEonlc
 LGriHuu6CSU7zsxtKCBYaWf6DpebqNwa9ycuoDF9BYw8l4Vt/OMoRjMa2aLDtR03YYXi
 kNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036150; x=1794640950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TU2t33EGiqp/LjXehRHFlNroU8sFwni/riOs5yClKlw=;
 b=Hclnhok1+40YM3p534E0E4ToYh4Ngb43HnAWfs6vf+3gf2zGBe654cjivCZPLlhoeA
 quhzqFJJysWp5VB+UjlaXEptFyxE+tsK5JrRsj5ujnWDbsE6T5lFMXtiYmK/08A7ZfBT
 cR6xO3fsTZ5sZtiXXcHXCZkZ2nl0E3TWVrTIelokozKjKOsaJPzsH/rVuT2W1AZ+KIVE
 Bzz0c0VcYFOX7GyoTETZuBPnJdFzCOeV/+ucqUMxyk3qt7yTVK7X1mLSMTKp86MGmkGw
 39Q0/xAp2mKhmSrO982UU9pyzmGNBAnGQTxtGedEZ0C1imv20gtgr1YESMZ6eEPI/UfW
 OeNg==
X-Gm-Message-State: APuU4Z+O+/j5TyWVO2KbZjwvrzMDxtJPR5DLjl0OYZ2JNvwg//nL/LjM
 pi1ZgYBAM6K6f/JB5cK7db52z6Wf4yPdA8fzBTKx46tKq8uo6ZOWdZCVqHzaz8JhesliFNsckXF
 ar6zI
X-Gm-Gg: AYBFou13o5O9iJ1+5gbTDWffdPep/6GAjOBvLQdeU9ouR8YpF/yBOf7/k9CzKX8orRA
 Pyj/KfsRJosISrlYQqtM9l6l+oTydLiY7wtcg9o76jRNkotMLBohD6wgqt68W6l/V8QxcEifKZj
 5midHlP4iuZaH65dvW0i8CTvVn51NBvDgNBiRTS5KRSdnY3iXuNRj6SOHCaGSVxqiaXWqM6eOY0
 ff42FhVDxrsJMv6gAQzVZoZAY00Dcs50egb2hzkaJ2w6ddXTyMQsOYbCG2/KuIoE8Ipbx+NOFkV
 nicnH6VFcoWueSVQkhe52/0Zs+8JrhQUAsttE/BV5FIt/GTOR9WXBLVEZfwEd+xhTS6a4UBZHEI
 dYeK9QXexXTBrjT5UQqXxx2Jj2YUC07W/DvAk2VC3oPkUPtFpEWl+L4GWfegZ0hZR105+k0HJNE
 zt2dRazzTmHOTej+lzFCLWoQhfnwlLTLv5y1MQbrInHloJ8v/LzilC3CQpSWIFCVdvJG9QevkVk
 Q6572/H12nLKYZCbEU6vrbcMHofh0qnsWnCg/Tn15XvSe3Yn6U5ldICy+V/UaV0ggH9ZqsEDVlV
 bNUfAYmlruMBWPcW5coq1CY+dqWXeHG9MvocmU8iWiGTERn0QsI40GlGe8PHhZzNNj6KuDGisTL
 RUaxwa0wYmQ==
X-Received: by 2002:a17:906:941:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c4d34fd3a8fmr398649366b.1.1794036150396; 
 Fri, 06 Nov 2026 23:22:30 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356eae34sm132640566b.85.2026.11.06.23.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:22:29 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 00/30] usb: dwc3: part 2, make the resynced code work
Date: Sat,  7 Nov 2026 08:21:54 +0100
Message-ID: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This is part two of two. It applies on top of part one [1], which resets
the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
the build for every board that enables DWC3. This part adds back the
U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
builds and the gadget works again. It builds on Jerome's work [2].

The two parts have to go in together. Part one did not change, so I do
not resend it. The v10 patches [1] still apply on ab4dc5aacf95.

The resynced epautoconf matches endpoints on their caps field instead of
on their name. Five UDC drivers never filled that in, so each one gets a
patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
and mtu3. With those and dwc2, every UDC driver in the tree sets caps.

Build tested one board per driver: every DWC3 glue layer in the tree,
dwc3 on riscv (spacemit_k1), RK3588 and RK3399, dwc2 with and without
DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc with SPL SDP, musb-new
on sunxi and in the am335x_evm SPL, and mtu3. 24 boards, no warnings.

Ilias found a few bisect gaps, so I built eight of the boards at every
patch. Gadget configs build again from patch 20, the other UDC drivers
from their own fixup patch.

Tested on hardware with v10, per vendor:

- AMD/Xilinx: Love tested and sent a Tested-by.
- TI: DFU and ums on BeagleBoard-X15 (me), and on AM62p and BeaglePlay
  (Anshul).
- NXP: ci_udc with ums on an i.MX93 board (me).
- Amlogic: gadget and host on Khadas VIM3 (Mattijs).
- Rockchip: host on RK3399 Puma, same as master (Quentin). RK3588
  Tiger had two regressions, see below.

Tested on hardware with v11:

- NXP: ci_udc with ums on i.MX93, chainloaded from the vendor U-Boot.
  Three ums rounds, the host read 64 MiB each time. It needs usbotg1 in
  peripheral mode.
- TI: dwc3 ums on BeagleBoard-X15, the host enumerates it at high
  speed. That is where I found the event buffer bug in patch 15.
- Rockchip: host on RK3399 Puma and RK3588 Tiger (Quentin). The two
  Tiger regressions from v10 are gone, and he sent a Tested-by:

  Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma usbdrd_dwc3_1
  Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger usb_host1_xhci + usb_host2_xhci
- Rockchip: host and gadget on RK3576, a Flipper One and an RK3576 EVB1
  (Alexey). No regressions against master, and he sent a Tested-by:

  Tested-by: Alexey Charkov <alchark@flipper.net> # Rockchip RK3576

The rest is build tested only.

One thing is still open.

Anshul sees a single "unknown endpoint event 0" line on AM62p during
enumeration. I got the same line on the X15 from the event buffer bug
that patch 15 fixes. I think it is the same on AM62p, but I have not
tested it.

The branch has both parts [3].

[1] part one, subject: [PATCH v10 00/63] usb: dwc3: part 1, reset and
    import from Linux v6.16
[2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[3] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v11
[4] v10 part two: https://lore.kernel.org/u-boot/20261028141554.3073545-1-anders.roxell@linaro.org/

v10 -> v11:
- Rebased on ab4dc5aacf95.
- dm helpers: device_property_count_u32() returns the count, so the
  INCR burst is set again. dev_err_probe() prints one line. Dropped the
  unused of_node and property helpers. Kept Mattijs' Reviewed-by.
  (Ilias)
- udc-core: folded in "enable async callbacks on bind" and the
  epautoconf.c include fix, so dwc3 enumerates at every commit. (Ilias)
- udc-core: IS_ENABLED(CONFIG_XPL_BUILD) instead of #ifndef
  CONFIG_SPL_BUILD. (Ilias)
- xhci-dwc3: the rename is before the dwc3 core patches, so DWC3 and
  XHCI_DWC3 link together again. Dropped the stale
  dwc3_core_soft_reset() prototype. (Ilias)
- at91_udc: the local register functions go away in the patch that
  registers with udc-core. (Ilias)
- io.h/Makefile: the message says what changed, the kernel glue comment
  is gone. (Ilias)
- core: use dwc3_core_is_valid(), and leave GSBUSCFG0 REQINFO alone like
  Linux. (Ilias)
- core: count the ports without xhci_resources. Host-only cores failed
  with -ENOMEM. (Ilias)
- core: no DT read through a NULL udevice from dwc3_uboot_init().
  (Ilias)
- core: drop dwc3_clk_disable(), the glue owns the clocks. (Ilias)
- core: free evt and evt->cache, they leaked without DEVRES. (Ilias)
- core: bring back the 100ms wait after soft reset (SC7280) and
  RUN_STOP on exit (K2). (Ilias)
- core: new patch 15, flush the event buffer after allocation. Without
  it dwc3 read old heap data as events. Found on the X15.
- gadget: keep the pullups_connected check, so a second pullup(1) does
  not reset the controller. (Ilias)
- gadget: dma_unmap_single() instead of dma_map_single() on unmap.
  Dropped the extra invalidate in giveback. (Ilias)
- gadget: flush the whole trb ring on endpoint enable, drop an unused
  variable and fix a comment. (Ilias)
- f_sdp: full speed uses the full speed descriptors again. (Ilias)
- atmel_usba_udc and musb-new: register with udc-core without
  DM_USB_GADGET too. (Ilias)
- ci_udc: give the controller back on udc_stop(). usb reset left freed
  data behind before. (Ilias)
- dwc2_udc_otg: add the gadget to udc-core only once, and only without
  DM_USB_GADGET. (Ilias)

Older changes are listed in v10 [4].

Cheers,
Anders

Anders Roxell (30):
  x86: asm: io.h: add rmb() and wmb()
  dm: add helpers needed by the resynced DWC3 code
  phy: cadence: use reset_control_assert() from reset.h
  usb: phy: add the usb_phy helpers needed by the resynced DWC3 code
  usb: gadget: adapt the gadget API after the resync
  usb: gadget: udc: make udc-core build in U-Boot
  usb: host: xhci: fix up after the resync
  usb: dwc3: core: remove the code U-Boot does not use
  usb: dwc3: core: bring back the U-Boot entry points
  usb: dwc3: core: adapt to the U-Boot APIs
  usb: dwc3: adapt io.h, the Makefile and the TI glue
  usb: dwc3: make gadget and ep0 build in U-Boot
  usb: dwc3: ep0: flush and invalidate cache around ep0 transfers
  usb: dwc3: gadget: flush and invalidate cache around transfers
  usb: dwc3: core: flush the event buffer after allocation
  usb: dwc3: make the am62 glue build in U-Boot
  usb: gadget: ci_udc: move to the udc-core registration
  usb: gadget: ci_udc: set endpoint capabilities
  usb: gadget: dwc2_udc_otg: fix up after the resync
  usb: gadget: fix up the function drivers after the resync
  usb: gadget: at91_udc: register with udc-core
  usb: gadget: atmel_usba_udc: fix up after the resync
  usb: gadget: atmel_usba_udc: set endpoint capabilities
  usb: gadget: at91_udc: set endpoint capabilities
  usb: musb-new: fix up after the resync
  usb: musb-new: set endpoint capabilities
  usb: mtu3: fix up after the resync
  usb: mtu3: set endpoint capabilities
  usb: cdns3: fix up after the resync
  usb: dwc3: enable SUSPHY again after xhci is registered

 arch/x86/include/asm/io.h                 |    2 +
 drivers/phy/cadence/phy-cadence-sierra.c  |   18 -
 drivers/phy/cadence/phy-cadence-torrent.c |    2 -
 drivers/usb/cdns3/ep0.c                   |    8 +-
 drivers/usb/dwc3/Makefile                 |   11 +-
 drivers/usb/dwc3/core.c                   | 1779 +++++----------------
 drivers/usb/dwc3/core.h                   |   41 +-
 drivers/usb/dwc3/dwc3-am62.c              |  424 +----
 drivers/usb/dwc3/dwc3-generic.c           |    8 +-
 drivers/usb/dwc3/dwc3-layerscape.c        |    8 +-
 drivers/usb/dwc3/dwc3-omap.c              |    2 -
 drivers/usb/dwc3/ep0.c                    |  117 +-
 drivers/usb/dwc3/gadget.c                 |  727 ++-------
 drivers/usb/dwc3/gadget.h                 |    4 +-
 drivers/usb/dwc3/io.h                     |   36 +-
 drivers/usb/dwc3/ti_usb_phy.c             |    2 -
 drivers/usb/gadget/at91_udc.c             |   83 +-
 drivers/usb/gadget/atmel_usba_udc.c       |  106 +-
 drivers/usb/gadget/ci_udc.c               |   92 +-
 drivers/usb/gadget/composite.c            |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c         |   89 +-
 drivers/usb/gadget/epautoconf.c           |    2 -
 drivers/usb/gadget/ether.c                |   21 +-
 drivers/usb/gadget/f_acm.c                |   20 +-
 drivers/usb/gadget/f_fastboot.c           |   10 +-
 drivers/usb/gadget/f_mass_storage.c       |    5 +-
 drivers/usb/gadget/f_rockusb.c            |   11 +-
 drivers/usb/gadget/f_sdp.c                |   12 +-
 drivers/usb/gadget/f_thor.c               |   19 +-
 drivers/usb/gadget/udc/Makefile           |    1 +
 drivers/usb/gadget/udc/udc-core.c         |  931 ++---------
 drivers/usb/host/xhci-dwc3.c              |    4 +-
 drivers/usb/mtu3/mtu3_gadget.c            |   10 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c        |   16 +-
 drivers/usb/musb-new/musb_gadget.c        |   21 +-
 drivers/usb/musb-new/musb_gadget_ep0.c    |   24 +-
 drivers/usb/musb-new/musb_uboot.c         |   51 +-
 include/dm/device_compat.h                |   11 +
 include/dm/read.h                         |   43 +
 include/linux/usb/ch9.h                   |   25 +-
 include/linux/usb/dwc3.h                  |    1 -
 include/linux/usb/gadget.h                |  529 ++----
 include/linux/usb/phy.h                   |   57 +
 include/reset.h                           |   16 +
 44 files changed, 1383 insertions(+), 4018 deletions(-)

-- 
2.53.0

