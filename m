Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBF7C79F87
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4CA340BD8;
	Fri,  4 Sep 2026 19:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCrcC2Zuub2v; Fri,  4 Sep 2026 19:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 849FA40BC1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549983;
	b=kws3x5+dCXEANbsdsZ2YntRYOq5JJfD23V0dr0H39DK4amxHqWz3Q5jpk5C5RRvsrPFy
	 QtBqb+Ywg5oYf6AfOdjiJLiZreGm9XPNeMqUQBco1fftcE9Bz8VSrILr6yWuX5Yh9Q2eH
	 sdyYp++umgpji9vpz2kRzTojLlv3HL0Etj9vPqVWj20b3DnVoCT6Ip2ehfuZ9CEPUC7GP
	 i0Xut9PP5MEW0UjzyaHMP73pfnrdbQUw9GYYFneJzskVT6WPyQGBAV9pL4D+0k9P8b/tX
	 OLnXpl3lqdELxbCAfVhgTRePlNtalebbTPWTmRhqPjyT+f6IzvrgXtSvKYPyww9DWgA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788549983;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yjv9Uf25JmSsL8WOqW4h/hjn2ch/sEG4WtQ5VYQNQ14=;
	b=UfxQ3yoDpOTE9En6sX98cb8ve05pIaXaqskH1nl4AVIaOTUBoVUQPu8TgCrxlx/hG0K4
	 TaCtN+UodRohmKN3mAWKBVBB1Yq27LkYIP2Q/V7qUGmIRVLiAZgvTHxkiDSUq+bF0EJAI
	 rf1x/vNrvjR5UH7xcn0FPpNEZn/eqp4OFnGKGUvJOMJpdojHepICIWrtaoLZv9F9aI+Yp
	 C4N2zySwU5uDXQJ8+/CKJgORDvd4U+0ZmlYwY056SdLDr1R0xEtQs41GCbikbKAIcWUhK
	 oGTKMZhfb75EStxQ+h9TSNH+5sg7nBiOdeegHYQzIS9TVxqQZBUnwAuUOKTIZv18F2g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788549983;
	bh=yjv9Uf25JmSsL8WOqW4h/hjn2ch/sEG4WtQ5VYQNQ14=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=noREIDvQX/Se04q7Sb0P46e4FWV3eJv62NoXg83ZzIUULANQV6pVPw/19+DnqnG4I
	 MBBaCfTbQn32gsrhqRWJvrbp5j1l9zUSXvEcG+1uKGjZSnANvHsa3QDfu9NK8j1XDi
	 ifXzHW8H1Rof7UKRQg8VmxQfMlVQjpACt/2Cm3B53NYm31JsbKUtYvSUWCE1RWz7QD
	 j4/WuaMFxfoLWduycM5AsYnreTApjT8BjWKYkKJPct1y1wNmAIFhvYwD5YKmYl2TEI
	 C2dMPgVR1fpq0zfTgxiUQoal1GSBW3g4rgIuBStj/qPpMrc+WufSySlv+PLJb+9y2Z
	 2OT1knMH0Idew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 849FA40BC1;
	Fri,  4 Sep 2026 19:26:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 62FB39CF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 17:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54DA840082
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 17:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6rzcPVV7E9I for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 17:12:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1558140077
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788541969;
 b=PXnIRM0j+AQIvRMWBWZR9Ldrn5L3apcqxhenPk09670SFHUukd97X4Z/627QPk1n7W7Q
 B2xu32TZ18te5u/+VhtIinWES3o9vW7M3HXn6//R4tltX91xiQn3uoUez7cjbsA+M2yIL
 Lk/AGjrQ85DKDFfDG0go8KIYubLC4m8oflHY1v4k8bb+MR3YeduhRnpcgAlM4K0+ZLQya
 Bp52ybagv8KVQ0dEI9ZGnpuHrDP7n0gbBmMs2Ga1WM6w03Br4QhzZy0dolLmVO5iwuruW
 kbD80zFDV5E4sdXBuQEN4W0mC5HiLwzg0k5hdiJgayLRazjazHVERmMb+okHG8URuiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788541969;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=yjv9Uf25JmSsL8WOqW4h/hjn2ch/sEG4WtQ5VYQNQ14=;
 b=F9tJ1DPMNcXRkJW3omcv5yUdasrM5aKuIglxL6PfeX4xhDMTUD7/EZsSEEqYEcFtZrxe
 kt06GPVdQiIW7MZ/wIbYmXhR+cPAq5FR2KVPspuzfpBzJrwKfFR2Y4Mk4KL4Dtcl4pRLw
 2tUpImeVM6LLOlIuYe7OYWpvk27VhpfMN34PAw6goJjDJTIcZuajiEC3sGDyNl39okOXd
 6O72ZzxT9k76bumabnd48eRhKHZ/xsU47Du0RYUFerdzS5+fhqHuX2GUw8diPsOLRBqUD
 UGd3DgnPv5qwqzJXZuNFYE+UbCvmP7DbVT0LDYdtG4zJ+lHWefhUpnrWYYix1UcQVdA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=userdevice.net; 
 dkim=pass header.d=userdevice.net header.i=@userdevice.net header.a=rsa-sha256
 header.s=google header.b=CbD2Pf0y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=levi@userdevice.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=userdevice.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=userdevice.net header.i=@userdevice.net
 header.a=rsa-sha256 header.s=google header.b=CbD2Pf0y
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1558140077
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 17:12:47 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so199324366b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 10:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788541966; cv=none;
 d=google.com; s=arc-20260327;
 b=lyiSk+nZOlYMMbE/TKi+2d1ckiLjFOwQ38o75QiQJWuee/9n74pzMaqY8zzNpo1Ccy
 WOOsdJTpKAfRWXfhOi0XOwGyPLspf4A0ISlMdyQ/UF1w1dVcMYUJeHVe32NAZyCTnpmQ
 JGh1G4vBdILh+hqbGpxc8eniYn3l8SJGijaAYmPCzpsFl/8YuigvME87mr7zNxIIQ/Pk
 KFdrVevBjGla+ehGhODo94d/duGZ5XcrUydeNDu4d+lI4TybUao2kpdYUn66dy4ZJE38
 OR51cZtkv/mk9BCuUBce+3oRL4tvSoepBphdPqmMrnohxODBz2/7wRKWVbQtjaNP7iBu
 W3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=yjv9Uf25JmSsL8WOqW4h/hjn2ch/sEG4WtQ5VYQNQ14=;
 fh=03fjx7lGdrN+1rNXDhBpycUtlL+1mr7ebaYELAjiLuw=;
 b=k4e0n0CCl38xTsgj3m/n2/L/gEz9hr8PGhq7u34sS5EnESeH91gZikN+056Y6Sy9Q2
 vQHPzdr+6W6qvx5b0SFolsb/Ds47+aOjq9fiLF9gmbTwqImoYTcW9gOWcLEzbJAMILMy
 GziKvsLocelJ3YezKApH6OiftY3XCuce1cMuESOIOTHzG6eAW/dCjVJ7fAfX3uVrr1kB
 3ivT3dRc99gFC1xw89xauJEp9ByIF1zR/hFtuQQZVSZ6utUHBQU6ej03bIGiUo87UI3X
 rUPQ/aBNhkMApfGhmHWqpRf/eGhWecsl2pk/f923IFNKIUPo2SwJ6ygqM6VrTZW/fSAa
 WhSA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=userdevice.net; s=google; t=1788541966; x=1789146766;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yjv9Uf25JmSsL8WOqW4h/hjn2ch/sEG4WtQ5VYQNQ14=;
 b=CbD2Pf0ykowzv4G3UcAHiq9wNk/W/yt9fkDBNh1yLrNphw+AKi4xRS6BKTV2xc/3iK
 +ATJZ5kWA51Sp4OkHAu1M7U/wjh2vJEBgzt6Zr3QPKyp4VWDpa9yljLaelyv9hiNlLWL
 4TfxffaLJf2UlBOKt8LDzJKMnmFpYlFLKlHwRhKpuUv6I1NlohaTI0sAfoNinK2tYsnh
 i3WArckdNXSFvzK9G2A3swl0i6AS4gwcn1O0pdzym/10vvpHPfQ/fWSF9zqU4DrNTF6B
 DLbQz8xwayBQf2GeSoylGDNk8gtWChNLwxOCnek7CvBgJ6GnxFTVwnVSuwemcOcneseS
 gSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788541966; x=1789146766;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yjv9Uf25JmSsL8WOqW4h/hjn2ch/sEG4WtQ5VYQNQ14=;
 b=U7onacVqqrVb5cfCwN8p2W4fkr4WY0bz9feGRxbkORZo/2iIgRBBfsawTUJIGpRuUm
 aUxWMOQ+7am/9zuvbPtiI1xkk/7LIIVILZLxee/9mVA+Q+/9ovAz7cFW/D69RjyWuOD3
 gSzUApx1NNWi1+CtzkyXsXP6/SgKBK4oAIf0WsGsi98zDj50AjzemvBQpYUrhoAq2TKp
 pthRicAoA6sT32MtHEN1jexxDCCxZD/zVfkWJ2jwmN2lLmAV2vY+enMGIn1jmsbXHXmI
 r5qbArq4Ye7xi3HQFDS4TWOByQKi48UQJ2pj8SXVzvuZAYK8sitDK9tLi0l6JFQA6tYC
 9GVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdJtLdORzw/xCnoqaE3EXzp35Q2WpNndTALQWKa1V6HX3ve1+nKqoPND9G76+DNzVqEikMHNI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lKC0m6BeVDRJjyXPuZRiP3MwS4BTC4qdYip+uvJZJLYTaLAI7X
 g9VNVJ/vfYpJoJl7/fn0/rbOBfb3a+OH94yeetbeo8rlqN3L2xp2IwdFb9ZpWX8Y9/Mqed3pIMQ
 W8jN3U7898nLutf2vRwFl5qTl65O1aLuBiOPwkfGImg==
X-Gm-Gg: AYBFou3Dcw6eMrLPKaniH9NlzG9i1BOzCjtZ7pwANJG9WRgJBJQFpvrJl2cs0G+s0QJ
 o06magZwSTcUdLofZX6ncW2bwAE8P3WW+DcJ3w+FqF7EIOhmhKmiVnj4W/o4EywVYuMnN4YT3cA
 I9X3Q21N742XwS1mU2Se5eO2Pcde2b5ZN07JlbWFby0N2y9lRlPD6b8UZhEvR3YNAMDPltpohgj
 gRWZ0bx2LijRZD5j8/IdUIhpalAAIY3VFSNZQFzHAh6fAz7GFoXPbl0BrnA+sxt/XpfhGjxdvYt
 C8bXCB5Esj34ScR0IhFb7rg7P4U88h5IjykQECs+UGWsv7u1O7mapZE=
X-Received: by 2002:a17:907:e1cd:20b0:c26:227f:5f7 with SMTP id
 a640c23a62f3a-c26227f2e6amr52871266b.46.1788541965537; Fri, 04 Sep 2026
 10:12:45 -0700 (PDT)
MIME-Version: 1.0
From: Levi Tomes <levi@userdevice.net>
Date: Fri, 4 Sep 2026 12:12:33 -0500
X-Gm-Features: AcwNN1W6j-vwwI-0Jl4h1L0tksJiRV59BMSPLKNspVhQ9NkqKd8ReUTAauwKpc0
Message-ID: <CAG7BTaqzj4Z=LM8E6U+e8Rz531Pf0BvFEB8nnSWvz9BE2e3tRw@mail.gmail.com>
Subject: [PATCH] usb: gadget: dwc2_udc_otg: translate DMA addresses via
 dev_phys_to_bus()
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 04 Sep 2026 19:26:11 +0000
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

The bcm283x phys_to_bus() helper applies the 0xC0000000 VideoCore alias
unconditionally. On BCM2712 the OTG controller sits under the axi bus
with identity dma-ranges, so the alias points DMA at nothing and the
host sees 'device descriptor read/64, error -71' during enumeration.
Use the DT-aware dev_phys_to_bus() like macb/sdhci/nvme already do; on
BCM2711 the soc node's dma-ranges still yields the alias.

Tested on a Raspberry Pi CM5 Lite (BCM2712): the CDC-ACM gadget
enumerates and works as a U-Boot console. Also tested on a Compute
Module 4 (BCM2711) to confirm no regression: the gadget still
enumerates cleanly there.

This is my first contribution to u-boot, let me know if I am not following
process and I can adjust. My hope would be to do any testing you
need on this patch so it can land, and I can stop patching 20 machines
 in my talos cluster with my own sketchy patch.

Signed-off-by: Levi Tomes <levi@userdevice.net>
---

Notes for reviewers.

How this was tested:

 - BCM2712 (CM5 Lite): with the fix, the CDC-ACM gadget enumerates on
   the OTG port and serves a working U-Boot console. Without it,
   enumeration fails with "device descriptor read/64, error -71" as
   described above.

 - BCM2711 (CM4): regression check. U-Boot built from rpi_4_defconfig
   plus USB_GADGET_DWC2_OTG/USB_FUNCTION_ACM, loaded over USB with
   rpiboot; the gadget enumerates cleanly (0525:a4a7, cdc_acm bound, no
   descriptor errors). rpi_4_defconfig also builds clean with the
   change.

Note on the BCM2712 side: Raspberry Pi 5 / CM5 support is not upstream
yet, so that testing used an out-of-tree Pi5 patch stack. The change
itself is independent of Pi5 support -- it only swaps phys_to_bus() for
the DT-aware dev_phys_to_bus() in the dwc2 gadget, the same pattern
macb, sdhci and nvme already use.

 drivers/usb/gadget/dwc2_udc_otg.c          | 10 ++++++++++
 drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 14 ++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c
b/drivers/usb/gadget/dwc2_udc_otg.c
index e475b14b9a..3835244cca 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -168,6 +168,15 @@ __weak void otg_phy_off(struct dwc2_udc *dev) {}

 /***********************************************************/

+/* udevice of the probed controller, for DT-aware DMA address translation */
+static struct udevice *dwc2_udc_udev;
+static inline unsigned long dwc2_phys_to_bus(unsigned long addr)
+{
+ if (dwc2_udc_udev)
+ return dev_phys_to_bus(dwc2_udc_udev, addr);
+ return phys_to_bus(addr);
+}
+
 #include "dwc2_udc_otg_xfer_dma.c"

 /*
@@ -1073,6 +1082,7 @@ static int dwc2_udc_otg_clk_init(struct udevice *dev,

 static int dwc2_udc_otg_probe(struct udevice *dev)
 {
+ dwc2_udc_udev = dev;
  struct dwc2_plat_otg_data *plat = dev_get_plat(dev);
  struct dwc2_priv_data *priv = dev_get_priv(dev);
  struct dwc2_core_regs *usbotg_reg =
diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
index 5a7f50ebaa..04c0485ae9 100644
--- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
+++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
@@ -31,7 +31,7 @@ int clear_feature_flag;

 static inline void dwc2_udc_ep0_zlp(struct dwc2_udc *dev)
 {
- writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
+ writel(dwc2_phys_to_bus((unsigned long)usb_ctrl_dma_addr),
        &reg->device_regs.in_endp[EP0_CON].diepdma);
  writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1),
&reg->device_regs.in_endp[EP0_CON].dieptsiz);

@@ -49,7 +49,7 @@ static void dwc2_udc_pre_setup(void)

  writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) | sizeof(struct usb_ctrlrequest),
        &reg->device_regs.out_endp[EP0_CON].doeptsiz);
- writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
+ writel(dwc2_phys_to_bus((unsigned long)usb_ctrl_dma_addr),
        &reg->device_regs.out_endp[EP0_CON].doepdma);

  setbits_le32(&reg->device_regs.out_endp[EP0_CON].doepctl, DXEPCTL_EPENA);
@@ -72,7 +72,7 @@ static inline void dwc2_ep0_complete_out(void)

  writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) | sizeof(struct usb_ctrlrequest),
        &reg->device_regs.out_endp[EP0_CON].doeptsiz);
- writel(phys_to_bus((unsigned long)usb_ctrl_dma_addr),
+ writel(dwc2_phys_to_bus((unsigned long)usb_ctrl_dma_addr),
        &reg->device_regs.out_endp[EP0_CON].doepdma);

  setbits_le32(&reg->device_regs.out_endp[EP0_CON].doepctl,
DXEPCTL_EPENA | DXEPCTL_CNAK);
@@ -107,7 +107,8 @@ static int setdma_rx(struct dwc2_ep *ep, struct
dwc2_request *req)
  (unsigned long) ep->dma_buf +
  ROUND(ep->len, CONFIG_SYS_CACHELINE_SIZE));

- writel(phys_to_bus((unsigned long)ep->dma_buf),
&reg->device_regs.out_endp[ep_num].doepdma);
+ writel(dwc2_phys_to_bus((unsigned long)ep->dma_buf),
+       &reg->device_regs.out_endp[ep_num].doepdma);
  writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, pktcnt) |
        FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, length),
        &reg->device_regs.out_endp[ep_num].doeptsiz);
@@ -152,7 +153,8 @@ static int setdma_tx(struct dwc2_ep *ep, struct
dwc2_request *req)
  /* Flush the endpoint's Tx FIFO */
  dwc2_flush_tx_fifo(reg, ep->fifo_num);

- writel(phys_to_bus((unsigned long)ep->dma_buf),
&reg->device_regs.in_endp[ep_num].diepdma);
+ writel(dwc2_phys_to_bus((unsigned long)ep->dma_buf),
+       &reg->device_regs.in_endp[ep_num].diepdma);
  writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, pktcnt) |
        FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, length),
        &reg->device_regs.in_endp[ep_num].dieptsiz);
@@ -913,7 +915,7 @@ static int dwc2_udc_get_status(struct dwc2_udc *dev,
    (unsigned long) usb_ctrl +
    ROUND(sizeof(g_status), CONFIG_SYS_CACHELINE_SIZE));

- writel(phys_to_bus(usb_ctrl_dma_addr),
&reg->device_regs.in_endp[EP0_CON].diepdma);
+ writel(dwc2_phys_to_bus(usb_ctrl_dma_addr),
&reg->device_regs.in_endp[EP0_CON].diepdma);
  writel(FIELD_PREP(DXEPTSIZ_PKTCNT_MASK, 1) |
FIELD_PREP(DXEPTSIZ_XFERSIZE_MASK, 2),
        &reg->device_regs.in_endp[EP0_CON].dieptsiz);

-- 
2.54.0
