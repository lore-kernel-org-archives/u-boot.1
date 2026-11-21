Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CC606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dNGPFISB;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dJtwll4O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5C3E606B0;
	Sat, 21 Nov 2026 13:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kPfN_WVch036; Sat, 21 Nov 2026 13:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64D126066A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266850;
	b=Zh9KQAkR1w64T9/0pkytcDwCozhQFA6QcGlspr1jmYxjEoAGqnVwpCRkueycotoOKCdh
	 yoHlU1MZ+5H+XK753q88BXERoB60YKLYg8lV7w/cFBCKht4jnGtNP+nwZgUFl94eWMtgQ
	 qz9Mis5+lYqWtJ9j+wVFGtlQvoIfcU+ApDbs2ube+waftl9CHqsep2CwYBj3VOmrJgD+X
	 iWr68IzjxqSY7B3ZDa7nlre9nBCq+lptzDFJH0hpT2tU8w1KaqenYg7RsSh4RGcyRvpIe
	 wPsxTulUft0lOdozmu4X5HlNbo3QNMkBK49dwbf1SuqQU3idIKoo+m2F/+3J0bIdYkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qOxJ8x6YAOfCqI/Z8imrK6PNLbhfOnrL6j4ftRqeQYI=;
	b=Vo6TkcrNubM5L543hk780WXk7cOslrlcFbQUhC/z9eS5gvCka6zI823SXPXCqL+LxiEe
	 FokxNC2SgXVq0cl2poB7MpXaJ91A+A2Hpw0iv55LE+buK1tOpRNY6fYbgs4KbDMacJpTl
	 5W+gosAZ5pT6A9KNkh0b+0IyoqDR9ZXUwFA7OYoqNGXMsFP2j9y40E4atRvEXatomq+6M
	 64OseFvxMwYyjAVJLXJpr4fLPhBRWErRUjxgH21GtBYChX9MlMLkHwthlqIUdgefyP3lB
	 yTIeuV/gaBycH+jbaUxfNmpGOtJEwEKFmAnVDGyu8BkxpRU+sAZZbKEvNjmS/LUCnHA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dJtwll4O;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266850;
	bh=qOxJ8x6YAOfCqI/Z8imrK6PNLbhfOnrL6j4ftRqeQYI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dNGPFISB013Kbrkr/v9i1+mXom+wZRkc9UXGwTen5msl3HjEF9kt1+khCOuc0iWfz
	 3H0YCsr2+LJ5yYD4uC0ikL2dv7tCO6QI2suBTqYv29Oyj7p5+thUYA2FsyrvrHEQxy
	 bV4hRN3IA+SUG5doMlw0cimaBlxW/iApffZ5dZlNKxgvoETDNQNywKt8zNccCld7JV
	 b7yml8M1QiVShRTy0labJQKfR768+FPJr5H1aG4Mvc3VEjEa8mJBnIVBvk7NX/RFP/
	 UngD4vgWaGSnXKDtAFTMdLUQCKXE56ua+t4TW41G1OxaLNA+ujpjjuAsUwn6zWczAk
	 SZd1xqhN03Wcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64D126066A;
	Sat, 21 Nov 2026 13:14:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF177465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0BDB6065A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Czh5ujhiSP6H for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 06DCC60623
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dJtwll4O
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06DCC60623
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:51 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6ba863fc3e7so166a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262029; x=1795866829;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qOxJ8x6YAOfCqI/Z8imrK6PNLbhfOnrL6j4ftRqeQYI=;
 b=dJtwll4O+9gvTsL8JrJqS95WEHsp5i0s+4AwsFtIvrHV8bBK/T3W9ug0TzH+p8EQMf
 wiAHgBOQNef2rud2JsFypArEnpcH4KK+G9tM0kvEaF2d1uvdWTQS4VdA9zUM7T/hamwE
 Tse1B51vtjqJaLC8G9g5GYAGYCRwLOiggvE+ukd2ZXbcfSvnzUqKW6FzC0/pxC+5oj9S
 4iSnyzZHogks9R/KLgnn4du4bgBnEfXTZQ5CCvaAzNyRwgMZgc+qhCv042QylUgTu1N2
 U+ncqJLAPZ5eHUxXGrWR1LqKdjtrzBZ8879y2Lz0GbSlHG/D5Tgc64XNWRwpiSf1TIMR
 Hhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262029; x=1795866829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qOxJ8x6YAOfCqI/Z8imrK6PNLbhfOnrL6j4ftRqeQYI=;
 b=oCaWbIYUdM6MJNYOAo1+otftL864wrPC+sdf8F6Hv0vaapC0J3lpZzdq4E0lNSNSXg
 gbX3dYai3cfXdthC//DSCygKqERIk189CPBkXSUVvzhPlct2PxtRfH8A4CPs9Hz5uorX
 V111nsp4S0M0T06tQSIVI1unrBjVk5EYUC7oLM8Lvr5z4OIGGlGHvOPXTVFg3EX7tRFQ
 Pos/biWIz+ErwYw1+NuhPZ2FO6sVYoFDhR00iOHJpTTc97JxIc+QVK519sQfpDpvYUEo
 ApFqikf+exp3Ch4stgtPRoNToJJjIs1bit/HDbbWlwHMMHov0JPRx0AfPTekbR+JN2ZP
 5nUw==
X-Gm-Message-State: APuU4Z9wxpoWH/3N1cVFGqffoWBKoX3hiQ4PqIypgQsRy74vMnsgEW/A
 Q5wTkWRvzqUyucP1hq85s/EJzhh83eniibryqt2man4ThnGWLWLROZYXI3iKrRqk9iuZmgwUqNY
 Bg3rt
X-Gm-Gg: AZFdTZdvAhRLxdYKqYu88QRzeCVQ1aXBUcDJvOQjxz2vzMjW2R+tNGEay2njOrMKxER
 B4XGi9DjbSHzhA7eAL/QUXnLoSsUNI5EYEcmwG8B8/PGZbY651GrVe2heI/FrD8ChjD/VEOcgsf
 fVFm4X/yShuyHYemPvcwahsEuaboh8sOUqHaXpcIopxJ/A9z/qO9KslM0SYfPedLjMQu+uL+khT
 gBAXJmPeH2ztznNf43IXAtYcnU/APm6BrNrIzQOx2Scj8FisGLf0wMFyRg+YtNzZ43KA0Hr61MC
 6WDEzsIdOvZvhbXRvVQcGARgVCKnGRHtsvUjV1xiDLasuL4Bp85eEjZCZ2SCK6i97L0XAMNRQS/
 CMfKtNeoQuCxeYp3fshFtli6esa9TDigMa1m/dhgsjGFIWwCJpGT7itboN8P5fTyipAVji57Mq/
 4Bxy+AVdNbBY1u3i9en/keq3MlefoV2Y1xINwzNz12jVZyZFD+TijGAB20k6DE48+tY9Ls44OWn
 8JdjwLHvDCEN6Ug/Uk0rq5ZjURax1FVE+gqVHyq8LSejfcPesaLwvYWwV2sJdQM9Fhdz7g0rk8a
 TCw1tyqGqHsNxpmJL8MhQE/N4pIMOGBa9Yc8uQpotnRtQK4iXDIsyhwV0YwkCVKVOHSVmBESYHw
 vxI7so7f1iw==
X-Received: by 2002:a05:6402:90d:b0:6b7:dace:635d with SMTP id
 4fb4d7f45d1cf-6ba37ac9214mr5093298a12.0.1795262028518; 
 Sat, 21 Nov 2026 03:53:48 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cbeb0sm2366040a12.10.2026.11.21.03.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:53:48 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v12 00/31] usb: dwc3: part 2, make the resynced code work
Date: Sat, 21 Nov 2026 12:53:04 +0100
Message-ID: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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

The two parts have to go in together, on top of next (794978160561).
Part one did not change, so I do not resend it. The v10 patches [1]
still apply on next.

The resynced epautoconf matches endpoints on their caps field instead of
on their name. Five UDC drivers never filled that in, so each one gets a
patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
and mtu3. With those and dwc2, every UDC driver in the tree sets caps.

Build tested one board per driver: every DWC3 glue layer in the tree,
dwc3 on riscv (spacemit_k1), RK3588 and RK3399, dwc2 with and without
DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc with SPL SDP, musb-new
on sunxi and in the am335x_evm SPL, and mtu3. 24 boards, no warnings.

Ilias found a few bisect gaps, so I built eight of the boards at every
patch. Gadget configs build again from patch 21, the other UDC drivers
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
  speed. That is where I found the event buffer bug in patch 16.
- Rockchip: host on RK3399 Puma and RK3588 Tiger (Quentin). The two
  Tiger regressions from v10 are gone, and he sent a Tested-by:

  Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3399 Puma usbdrd_dwc3_1
  Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger usb_host1_xhci + usb_host2_xhci
- Rockchip: host and gadget on RK3576, a Flipper One and an RK3576 EVB1
  (Alexey). No regressions against master, and he sent a Tested-by:

  Tested-by: Alexey Charkov <alchark@flipper.net> # Rockchip RK3576

v12 only has the review fixes below, and they do not change what the
code does. So the v11 hardware tests above still hold. I also ran
dwc3 ums on BeagleBoard-X15 with v12. The host enumerates it at high
speed, and what it reads back matches what U-Boot wrote to the card.
ci_udc ums on i.MX93, chainloaded like for v11, works too.

One thing is still open.

Anshul sees a single "unknown endpoint event 0" line on AM62p during
enumeration. I got the same line on the X15 from the event buffer bug
that patch 16 fixes. I think it is the same on AM62p, but I have not
tested it.

The branch has both parts [3].

[1] part one, subject: [PATCH v10 00/63] usb: dwc3: part 1, reset and
    import from Linux v6.16
[2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[3] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v12
[4] v11 part two: https://lore.kernel.org/u-boot/20261107072224.3492260-1-anders.roxell@linaro.org/

v11 -> v12:
- Rebased on next (794978160561) for v2027.04.
- dm helpers: kerneldoc for dev_count_u32(), and no parentheses around
  the return value in device_property_present(). (Marek)
- reset: new patch 3. reset_control_assert() and
  reset_control_deassert() were in the dm helpers patch. Now they have
  their own patch with kerneldoc. They still return 0 for a NULL reset
  like in Linux, because dwc3 calls reset_control_assert() with
  dwc->reset NULL. (Marek)
- core: dwc->dev is a struct udevice also without DM_USB, so the casts
  on the devm calls are gone. (Marek)
- udc-core: the usb_gadget_udc_bringup() comment is kerneldoc now.
- gadget: ep0_trb_addr is cast to unsigned long * for
  dma_alloc_coherent(), not long *.
- musb-new: no casts on bdata in musb_register(), it is a void pointer.

Older changes are listed in v11 [4].

Cheers,
Anders

Anders Roxell (31):
  x86: asm: io.h: add rmb() and wmb()
  dm: add helpers needed by the resynced DWC3 code
  reset: add reset_control_assert() and reset_control_deassert()
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
 drivers/usb/dwc3/core.c                   | 1773 +++++----------------
 drivers/usb/dwc3/core.h                   |   39 +-
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
 drivers/usb/gadget/udc/udc-core.c         |  935 ++---------
 drivers/usb/host/xhci-dwc3.c              |    4 +-
 drivers/usb/mtu3/mtu3_gadget.c            |   10 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c        |   16 +-
 drivers/usb/musb-new/musb_gadget.c        |   21 +-
 drivers/usb/musb-new/musb_gadget_ep0.c    |   24 +-
 drivers/usb/musb-new/musb_uboot.c         |   53 +-
 include/dm/device_compat.h                |   11 +
 include/dm/read.h                         |   51 +
 include/linux/usb/ch9.h                   |   25 +-
 include/linux/usb/dwc3.h                  |    1 -
 include/linux/usb/gadget.h                |  529 ++----
 include/linux/usb/phy.h                   |   57 +
 include/reset.h                           |   32 +
 44 files changed, 1405 insertions(+), 4018 deletions(-)

-- 
2.53.0

