Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08ADC79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FBF140435;
	Wed,  9 Sep 2026 12:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZ-kM1Iui-cT; Wed,  9 Sep 2026 12:45:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 485C34071C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957951;
	b=XnaSovql1wK8AZo477xuIlZ/22HGw+v7E6aaEiEHPmyA/xqBiUcXLC9iG7jvRWsDWEM3
	 49OSTMOa/QlB/FM9HDIDkAYJUmTHUkS/Gb0SJGJ5Oq8R9bu4I8Aih0TOqjrXNjIPJ6i1k
	 PN0pXKREuHQyLQZRdQ8ApJubjMLh17PGl6AWH1lJZ7Q63M2V+dvMxmT4Kr4u6pvbzLCnI
	 u+guVNJYtR1TLPJVH1N02oaDp5QRLnfbOJjxWtzqq9NpFypqmq+EvvRt91LJSdAavGbuE
	 yv31TYGlOx4Kbb3HbArDvwdeBCLZbjY2TFuvcN/HTPXad1jNpTjzOJHkwfNJ7CfRcZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f8aNpCaC7Z8IbIY5/oYGcN3E9D42CwUakPPxJtZCDM8=;
	b=MTTL9ccXKTwjI19r/cxNBYiR649ZixCMzK7XAyEcuywOQITCNMiMIBvQWDKwpCKGHduw
	 F3DVdLIFHeWOg8VANpEUrw8oK6MXjRfrN5Q2oc4nq4bSnsheE7wr+nvxrYtD7sufMrltH
	 iTp7ZyJAvggvrDQ8h8zxomUm9IhWj/bc2UX7Qiiy9z/Ute2uOsdQFdv0z9W+flHnh7AHC
	 EsKCIcGN60CExgONWcYCXP5bJVj2edv2NXporDhLiH5c2JxumOFP9AbXw1CYf4aPgAFrH
	 zolTF83fPDIeX+d78IBT1OgmQlhzrS6ApBEFl37kM6PXyXUgNstkagrI9K6vverduww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957951;
	bh=f8aNpCaC7Z8IbIY5/oYGcN3E9D42CwUakPPxJtZCDM8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GznpkPX7rMyFSlSUpcIUQIehppY5LnaAyfXkITqM6lQa9B7Np00pvd3JX8dkPe8xw
	 Y687iF+MuaKmrE2dJYPKfluebzpoCddK3+upPbqZq9J+caHkDfR9ikHdK1clUPyiY1
	 wAA2JSSVDb6JPy+1mZXmwwscaf4TToialjctDZn0HOE8Ra/hhcO85/OdjiM3+0p5s4
	 YAnh4MK3segbtDfX4Zg1xiF6Re0FcQLnu8Z1AgbxZCDJjkm07MJLY9j0+9dA7H3LMH
	 AvrGhG7j28jP4BdOGfkmEW6/qhZA0NXJSeStMed/vUqV3LSTcRs/+d/kRsp4iY6WBQ
	 Mb/UQf6kL71sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 485C34071C;
	Wed,  9 Sep 2026 12:45:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FD7A3AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1233B400AA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Utyy6n7m71xc for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7CF7040055
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943872;
 b=Rjklx1R/EJ4xy5I5GsmrRXMEsGvblrZpk+tbANoExfVHPtYYEO2AmJMFZ/4+x2jm5lBy
 J0d7M+xmaZu1ktAZz7OMwgmIdf8WmBEReM6ekiHGMfA6E89F+b0rvriVE60y+bspSC3sp
 XYgznxfncsCYoLwjk3Xmp6bu/gtBfQvKOhTWU40rCaFuLoki5oOfrlYUdR0Tsz4pnrBBC
 Hy1DVM4ed8Dg+LrlH23jpKOjcYPueBgKXy+VJjPmHEHqsCKJ+CpF7g2uI0oHmdyl21HWO
 eO1T7tQLDgUI7CWQjuGDhuWrNg8lImNxgbuAY6pLSbVHffTf2cROtnXk72w1WblJuPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943872;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=f8aNpCaC7Z8IbIY5/oYGcN3E9D42CwUakPPxJtZCDM8=;
 b=RGYmRzeMCD+K6wZf2EdpReBxBflIk7QLiC9wm7MKqR5mH115W9HAbk/IkyoKylpKgi0K
 /iZn51qBcon6r1Lev6FWfGKiWIr4fqoIEkk5I8CtF9ntiiWuG780uG8kbvKgX9FZkHAvF
 G4WuG+BrSnSr6+TF0Xvo4+mzcwphS9zV3R8pQfedJMNBVGfqxZ3I/F79SFQmUeVVBsCq0
 DEb67z/Cieb8kZYw22z57GalUmkqoKc0y2/a1LPzwXab7UTLeyWzmhTS78Dtu3DTE3cgO
 RNhxGtokDf1lep2IP+87CnHZ79+GpZzxVFT3AwG8BHQZW9ohhzfqObFZqvbNitTwpuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ee6HNXK7; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ee6HNXK7
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CF7040055
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:09 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254c50ff6fso68888266b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943868; x=1789548668;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f8aNpCaC7Z8IbIY5/oYGcN3E9D42CwUakPPxJtZCDM8=;
 b=ee6HNXK7+4bOFvwm1FAT04lB7MgjFE+taBndGJUMKtu01LAn0JuMoZKsNxXZxJnReG
 6akDhRkH1Nw0jNfbLYTJAh6VS08fB+u2dN4jo2yCHVxUQnhpOECNa3xBWJ4zZOcMsTF+
 +Hw2EkIej8V5IPC9bQA2vU8M7IDzn9N7MRwLdeV4qxTajKoca6GPZlzhRRDwpsuE2Wqt
 qf5rfp8/bBorWuPOpXJ7fwCKF/Uu9zXutTEwp31pi7tVkODverQHsvk4waljYP6ZlenQ
 Lbqty4gBwFyWRP/OoGpBKWP1EWTrPpi0lrwpGZOfsAGPmaXzQAOV6rRPufvqJ2Zn1fUs
 ZKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943868; x=1789548668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f8aNpCaC7Z8IbIY5/oYGcN3E9D42CwUakPPxJtZCDM8=;
 b=DHHYrFGJyYPSvo6Nfem53CQgVSESGrUeviZ/r6BytcV7GMwwPVwwR0fPpC4gPpSLAH
 MCRkUhQa1KuHOur47eIhldKy8tMeo/u0dVfVlTwrUvMu9gPHmPnhS498cwdy/gZf1onh
 U27NLpFqQ75rfPa0YHScmaazvJ/GLF9tQpvI5pDm8hZ8aAj3/AKF/nS7q0Ztvl8dI43S
 7vW9Emix2Y/XfL8NvjegKeAVTqWoEHZkHDsSvIPed1oESsSSwj/ETSLPOcBAkwO5bG/+
 lcnhoUFXEPiC1HQLpAXpM2hyW6ZniagZ9M9zs4yeUhAJnhx+ZSBRGyGlsZHsJ6VQoISd
 WzWA==
X-Gm-Message-State: AFuF++nkg20t0nqukfE3VI8Ukp4xNzmxiXAgr35yYW8/RFdUdeddpyV0
 sBz7y6hRyIfuP16sOk91+iJEOmFwgsQtHTi6bNmQ9TRjh5K6aY5gNDrH1wMxkRsyjrBCqmrU9Ti
 RaNhW
X-Gm-Gg: AYBFou3vOvYZRXPqfgy6HpaQBDnvaUCV4tKtyl0ogqxAeAG8JDzz9G8tfJn6nTWr6O7
 ndYZrlrSuWmwPIkMs45nEiCnyRGIIkbJ11ux60Z4wuUJhrhwmzRnFlEmoKytHFvEGEhEW7+butd
 KGqk7SlubUIsrDY5qhF7sTAKe0Mxis0H5L9V/CNc0gi2NN0f71OovQUa9O+Wz3ViA4Ws9J5Alq5
 FS7YKjVcJdcFx+jrq+/zkpqYKokizKcoRRFJ2gseUPQciZBBoMLPfoeMIHOzkBHmLgVhM/beluU
 XiAwxKbpPaKBwWVPJDuW0msubAyN9+VoWfij5DAIu9pJfoH6P8UntBg4bNGkSVUEAxeepBJUp6A
 7Dg8TkACuqAnma8weSIPuLBtpb3Zp/cnTVCLammCYz5qrDIgz97fPkPaVZiQsE8UowMq0Cz3Lf3
 OJ5qZzRj65jckCPXZHo61/k4WflljrFPiHX+FWO1jKd4qWnNah0RelISjHll6zNDca4uFI9XIQD
 fJVYrX56h06g4LHNv7cQ8k7wpzxl91H
X-Received: by 2002:a17:907:e85:b0:c29:3d25:15fa with SMTP id
 a640c23a62f3a-c293d252168mr7368066b.2.1788943867745; 
 Wed, 09 Sep 2026 01:51:07 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c292c14c6a8sm90988566b.47.2026.09.09.01.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:51:07 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v8 00/25] usb: dwc3: part 2, make the resynced code work
Date: Wed,  9 Sep 2026 10:49:50 +0200
Message-ID: <20260909085015.2480097-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi,

This is part two of two. It applies on top of part one [5], which resets
the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
the build for every board that enables DWC3. This part adds back the
U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
builds and the gadget works again. It builds on Jerome's work [2].

The two parts have to go in together.

Part one is unchanged since v7, so I did not resend it. All 63 patches
there have a Reviewed-by from Mattijs.

The resynced epautoconf matches endpoints on their caps field instead of
on their name. Five UDC drivers never filled that in, so each one gets a
patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
and mtu3. With those and dwc2, every UDC driver in the tree sets caps.

Build tested one board per driver: every DWC3 glue layer in the tree,
dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
musb-new and mtu3. 17 boards in total.

DFU and ums are tested on hardware on BeagleBoard-X15. Anshul tested DFU
and ums on AM62p and BeaglePlay. ci_udc is tested on an i.MX93 board with
ums. The rest is build tested only.

One thing is still open. Anshul sees a single "unknown endpoint event 0"
line on AM62p during enumeration. It is there with and without the cache
patch, and the transfers work anyway. I do not see it on X15, and we do
not know yet if it is older than this series.

The branch has both parts [4].

[1] v5: https://lore.kernel.org/u-boot/20260716134305.614278-1-anders.roxell@linaro.org/
[2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[3] dwc2 prep: https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org/
[4] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v8
[5] part one: https://lore.kernel.org/u-boot/20260824152734.159794-1-anders.roxell@linaro.org/
    subject: [PATCH v7 00/63] usb: dwc3: part 1, reset and import from
    Linux v6.16
[6] v7 part two: https://lore.kernel.org/u-boot/20260824154133.217744-1-anders.roxell@linaro.org/

v7 -> v8:
- New patch, "usb: dwc3: gadget: flush and invalidate cache around
  transfers". The resync dropped the cache maintenance for the normal
  endpoints, so ums did not work. Anshul found it on AM62p and
  BeaglePlay, and we both tested the fix.
- "make gadget and ep0 build in u-boot" no longer comments out the two
  wmb() in dwc3 gadget.c. u-boot has wmb() in asm/io.h.
- Part one is untouched.

v6 -> v7:
- Split the series in two. Tom asked for this, so review and iteration
  gets easier. Part one is the reset and the imports, part two makes it
  work.
- v6 never reached the list in full. My send died in the middle, so the
  cover letter and the last patches went missing.

Older changes are listed in v7 [6] and v5 [1].

Cheers,
Anders

Anders Roxell (25):
  dm: add helpers needed by the resynced DWC3 code
  usb: phy: add the usb_phy helpers needed by the resynced DWC3 code
  usb: gadget: adapt the gadget API after the resync
  usb: gadget: udc: make udc-core build in u-boot
  usb: dwc3: make the core driver build in u-boot
  usb: dwc3: bring back the samsung usb phy driver
  usb: dwc3: make gadget and ep0 build in u-boot
  usb: gadget: udc: enable async callbacks on bind
  usb: dwc3: ep0: flush and invalidate cache around ep0 transfers
  usb: dwc3: gadget: flush and invalidate cache around transfers
  usb: dwc3: make the am62 glue build in u-boot
  usb: gadget: ci_udc: move to the udc-core registration
  usb: gadget: ci_udc: set endpoint capabilities
  usb: gadget: dwc2_udc_otg: fix up after the resync
  usb: gadget: fix up the function drivers after the resync
  usb: gadget: fix up the last UDC drivers after the resync
  usb: gadget: atmel_usba_udc: set endpoint capabilities
  usb: gadget: at91_udc: register with udc-core
  usb: gadget: at91_udc: set endpoint capabilities
  usb: musb-new: fix up after the resync
  usb: musb-new: set endpoint capabilities
  usb: mtu3: fix up after the resync
  usb: mtu3: set endpoint capabilities
  usb: host: xhci: fix up after the resync
  usb: cdns3: fix up after the resync

 drivers/usb/cdns3/ep0.c                |    8 +-
 drivers/usb/dwc3/Makefile              |   16 +-
 drivers/usb/dwc3/core.c                | 1761 ++++++------------------
 drivers/usb/dwc3/core.h                |   39 +-
 drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  117 +-
 drivers/usb/dwc3/gadget.c              |  724 ++--------
 drivers/usb/dwc3/gadget.h              |    4 +-
 drivers/usb/dwc3/io.h                  |   36 +-
 drivers/usb/dwc3/samsung_usb_phy.c     |   77 ++
 drivers/usb/dwc3/ti_usb_phy.c          |    2 -
 drivers/usb/gadget/at91_udc.c          |   83 +-
 drivers/usb/gadget/atmel_usba_udc.c    |  114 +-
 drivers/usb/gadget/ci_udc.c            |   86 +-
 drivers/usb/gadget/composite.c         |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c      |   86 +-
 drivers/usb/gadget/epautoconf.c        |    2 -
 drivers/usb/gadget/ether.c             |   21 +-
 drivers/usb/gadget/f_acm.c             |   20 +-
 drivers/usb/gadget/f_fastboot.c        |   10 +-
 drivers/usb/gadget/f_mass_storage.c    |    5 +-
 drivers/usb/gadget/f_rockusb.c         |   11 +-
 drivers/usb/gadget/f_sdp.c             |   12 +-
 drivers/usb/gadget/f_thor.c            |   19 +-
 drivers/usb/gadget/udc/Makefile        |    1 +
 drivers/usb/gadget/udc/udc-core.c      |  933 ++-----------
 drivers/usb/host/xhci-dwc3.c           |    4 +-
 drivers/usb/mtu3/mtu3_gadget.c         |   10 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
 drivers/usb/musb-new/musb_gadget.c     |   21 +-
 drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
 drivers/usb/musb-new/musb_uboot.c      |   39 -
 include/dm/device_compat.h             |   13 +
 include/dm/read.h                      |   51 +
 include/linux/compat.h                 |   15 +
 include/linux/usb/ch9.h                |   25 +-
 include/linux/usb/gadget.h             |  529 ++-----
 include/linux/usb/phy.h                |   56 +
 39 files changed, 1413 insertions(+), 4005 deletions(-)
 create mode 100644 drivers/usb/dwc3/samsung_usb_phy.c

-- 
2.53.0

