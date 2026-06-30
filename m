Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A3FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A528484C;
	Tue, 30 Jun 2026 10:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="DDSVospM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2714848DC; Tue, 30 Jun 2026 10:51:18 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B6884844
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c12629c937eso258608366b.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782809476; cv=none;
 d=google.com; s=arc-20260327;
 b=TQvAgJMKBb9/+FzQBOdmIbePcB9Ze2+k+rAQjunHhf8O+yIbdp98ha6U6P8+6GFF2h
 e7gJkfzVDAmGOxhvUreL6mlve3Px/lLxTi2zi8S2KhJUkjqwGC4VeBb6mhMb73GdXHdZ
 IOP6/J0RX97+qo9ZHwlETPqmZl5Ajre1baqwm5nRZsgpbFRe1ejHOOpRzp/zzvtgqo3s
 CRCtGnqE9/YFdhawstUvRKk4Gaq6u3HqjZdJG5RNgWHDb/BU+CmV5e5I+Hk1r9vNF0mo
 pewQx77zbKtW/Of06+gvJJOu0BXFSsnebqbWoNZr2lAgMDGHr6QvCgVnQjMsnyeT2oyQ
 nO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9zhW3O6GS8rNfnZQJW2cDHgzisdZ3y6a9XH3IG5UGwE=;
 fh=v53ZZIAvm2EZ+6ChLA50dYy8FmAPMNBL+bPAYTs1/bQ=;
 b=c2PxgzOeXkmfYQGxElxguUgwNVFhVDvterD2YYc+wtUckpu9qTdkgcLBODfZoJ1Z5J
 xVoIwaIcz1L/WzxEAyuuiLbsvVWwi0kxITIR9HHlPHys7sEzsY/8hyxyOvV82E75+vye
 3grBmQbJKMjh2A7kTGpDkRyEhaal/3LCd+zB5VWmw6zwR8V8MOqMPfPf3LWxOYoALffg
 E1p51RzhAYMR45OXXxbCI4lzDlH4WYNWmZOZ90UchNcbT97z1QjMU0ElosKrNISVcF0t
 PVkC7khAKsEPpKrGY+beTtgcB1YDopZE9z+WwPwOoh8aucNhieueATt4FuenKNgZY4L0
 z7Lg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782809476; x=1783414276; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zhW3O6GS8rNfnZQJW2cDHgzisdZ3y6a9XH3IG5UGwE=;
 b=DDSVospMYkMRrAmp4j//ioH3SpNK6YQPxmARVa5qy+oZZH7+5/IHdFHkgq1vS5eBYR
 H2Pra8n33tNIgh3q1tcvZtZunW0EtZx0yPJlEnVDTVP3Vyy8lUmwUeBxJrGJlg8n+yYP
 PsGifj33HTwJAwXUV9GmHkN6/vs4AozISHTYUBh/SPvxFSiEv3H3aEIevgltq5vyR45W
 DzHmF7ISzIhWcvqv9Y5N/Soib1/ZSGrOfjXLx+SnEYhKOo/Pl8bPxvUaWKzHnoJX4PSK
 bKPf0NfKYFVVYWxbxXQhwlhqZyRTHXsnHYiKOVrArLQTStYb+FHFVK0/TmcXPeisD3Z4
 dk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782809476; x=1783414276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9zhW3O6GS8rNfnZQJW2cDHgzisdZ3y6a9XH3IG5UGwE=;
 b=l8K3IgHu6zvHc4hG68Qfj+f1bzHfTEOTG/f1A0LCJ96QcCv7f80zYGUSabVs5sbgBo
 C0/bpLF4lcXX6bsNJjLgOvpULx0txGBow8cQQLDDvEnIPZ9QnfgiAT+q4rFIwqsOTTsS
 WHFCJtq8LOBsQo5i8NslUMVUtNiFNUySy0q80fxkCpa3Dx4xWJG4FeO/01VSWS5CedLr
 teKbve7ScQa9UJ8dkp5wESukSUv9potvbbkANKEcL8z9HMihUTks2ZffHxYHZG2DSMPo
 AKci8RyO6xwWL3TtKKhAkrucTNUS9U/C14ydmHdq2Ei9CtlsD3uofG2db72hXePDvIlN
 xCMA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4RfFK/CU0myt+gWgOsQ5GrLTUlvofO/MA7rCtUYZ4257JEGytGC0bvCK+RygVggaoCFWjzwI=@lists.denx.de
X-Gm-Message-State: AOJu0Yys/FRZ/CUmD4XpHoANvvhsXTPJ21JcoSALSeMAbgoUnC4VejFZ
 mMbJPxK1K594a4ZSqknC/kid3EjiFY5G1TJwzSaki5jdoU/s3xcPgN9Yy2b1RXw5XnCgy/ZiOTr
 XkfRXgTEN3Fn2EOL6GcGDWduVcQ2tdVlJTx5wfS77ByJJrUSf4y5ZdeJaAg==
X-Gm-Gg: AfdE7cnpidBQPRYglrhceI35dFLvp2L8KAWNbc32cs0Z6EZhuP2XdzRzAHX3+XNELqy
 m7GVoSStSY00q65JhlgopO7hpupvNZKy1p5Z8QCQ5/hTzADC5oRX8oRHhxIzYpLrsDsWBrcu458
 coV0/fpbCtPBVQZcPVoe2l1iguEOAXt263tAlq1E2UXiaEgXMV+sIs3qDVdpWBzb3SeZqVrqsJt
 jv6mY95SWkTefyLMBKRMB2oQtPae7IU0u4vKvJdf2pLM8lBk3eno/Ck5pGtEmEq2iROVJkPXM6v
 MiTuabniSgCa4TlOA5z/hfrWpHc=
X-Received: by 2002:a17:906:c09a:b0:c12:4e0a:4587 with SMTP id
 a640c23a62f3a-c1287375cf6mr100284266b.49.1782809476056; Tue, 30 Jun 2026
 01:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-11-jens.wiklander@linaro.org>
 <1b7211dc-13bc-4cd0-8286-bc6fac941f74@nabladev.com>
In-Reply-To: <1b7211dc-13bc-4cd0-8286-bc6fac941f74@nabladev.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 30 Jun 2026 12:51:04 +0400
X-Gm-Features: AVVi8Cck2pHp9gUANDhmW03UZcKwKVoY-kTYl1NGpien7BxgrjbuWCaDjobtMbs
Message-ID: <CAKTNdwFsvJZHzv-ycQOX1RDuVpYH4_umkvU1W=Dyp15YFZ29iw@mail.gmail.com>
Subject: Re: [PATCH v4 10/64] usb: dwc3: import from kernel v4.7
To: Marek Vasut <marex@nabladev.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 30, 2026 at 12:48=E2=80=AFPM Marek Vasut <marex@nabladev.com> w=
rote:
>
> On 6/29/26 10:43 AM, Jens Wiklander wrote:
> > Sync Linux kernel dwc3 changes from v4.6 to v4.7.
> >
> > The following files are preserved accross the import:
> > Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> > dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> > dwc3-layerscape.c ti_usb_phy.c
> >
> > Skipping unused files:
> > debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> > dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.=
c
> > dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
> >
> > Note that this is a raw import and doesn't build.
> > A fixup commit at the end of the series fixes that.
> >
> > List of commits: git log --oneline v4.6..v4.7
> > Commits imported:
> > 0d064a7b9c43 Merge tag 'mfd-fixes-4.7.1' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/lee/mfd
> > 5baaf3b9efe1 usb: dwc3: st: Use explicit reset_control_get_exclusive() =
API
> > 4aa34ce3c1ee Merge tag 'mfd-fixes-4.7' of git://git.kernel.org/pub/scm/=
linux/kernel/git/lee/mfd
> > 002f17bc54ff usb: dwc3: st: Inform the reset framework that our reset l=
ine may be shared
> > 50c763f8c1ba usb: dwc3: Set the ClearPendIN bit on Clear Stall EP comma=
nd
> > 27a0faafdca5 usb: dwc3: st: Fix USB_DR_MODE_PERIPHERAL configuration.
> > 4879efb34f7d usb: dwc3: exynos: Fix deferred probing storm.
> > 973986126a41 usb: dwc3: gadget: fix mask and shift order in DWC3_DCFG_N=
UMP()
> > ce15bda10121 Merge tag 'usb-for-v4.7' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/balbi/usb into usb-next
> > 2a58f9c12bb3 usb: dwc3: gadget: disable automatic calculation of ACK TP=
 NUMP
> > 676e34974481 usb: dwc3: gadget: update DCFG.NumP to max burst size
> > 7b9cc7a2b101 usb: dwc3: gadget: give better command return code
> > ce046d323d74 usb: dwc3: pci: pass the platform device as a parameter to=
 dwc3_pci_quirks()
> > 474799f07376 usb: dwc3: pci: make build-in device properties available
> > ae4114137607 usb: dwc3: ep0: sanity check test mode selector
> > 69b4269eff5f Merge 4.6-rc5 into usb-next
> > 818ec3aba883 usb: dwc3: debugfs: dump out endpoint details
> > b058f3e8a399 usb: dwc3: core: add helper to extract trb type
> > cf6d867d3b57 usb: dwc3: core: add fifo space helper
> > 4e9f311833a9 usb: dwc3: make dwc3_debugfs_init return value be void
> > af566a0be6e4 usb: dwc3: omap: get rid of dma_status
> > 8e7046b71dae usb: dwc3: gadget: don't interrupt when chained
> > 052ba52efa17 usb: dwc3: gadget: remove newline from trace
> > 36b68aae8e39 usb: dwc3: gadget: use link TRB for all endpoint types
> > 4faf75504a7d usb: dwc3: gadget: move % operation to increment helpers
> > ef966b9d3353 usb: dwc3: gadget: add trb enqueue/dequeue helpers
> > 70fdb273db37 usb: dwc3: get rid of DWC3_TRB_MASK
> > c28f82595dde usb: dwc3: switch trb enqueue/dequeue and first_trb_index =
to u8
> > 5ef68c56e169 usb: dwc3: core: document struct dwc3_request
> > 53fd88189e08 usb: dwc3: gadget: rename busy/free_slot to trb_enqueue/de=
queue
> > 495dd5f78145 usb: dwc3: omap: drop dma_mask configuration
> > e58dd357741b usb: dwc3: add disable receiver detection in P3 quirk
> > c36d8e947a56 usb: dwc3: gadget: put link to U0 before Start Transfer
> > 218ef7b647e3 usb: dwc3: gadget: extract unlocked dwc3_gadget_wakeup()
> > 2b0f11df84bb usb: dwc3: gadget: clear SUSPHY bit before ep cmds
> > c0ca324d09a0 usb: dwc3: gadget: combine return points into a single one
> > dea520a4a283 usb: dwc3: gadget: pass ev_buff as cookie to irq handler
> > 696c8b128220 usb: dwc3: drop ev_buffs array
> > 660e9bde74d6 usb: dwc3: remove num_event_buffers
> > aa3342c8bb61 usb: dwc3: better name for our request management lists
> > 8495036e986b usb: dwc3: increase maximum number of TRBs per endpoint
> > ca4d44ea2a91 usb: dwc3: gadget: always enable CSP
> > bc5081617fae usb: dwc3: drop FIFO resizing logic
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Tested-by: Alexey Charkov <alchark@flipper.net>
> Was this really tested at this point, or is this TB for the entire series=
 ?

Only the series as a whole (and it was on a pre-rebase version from
some time ago). I don't think individual commits here are bisectable /
testable stand-alone, given that all the U-boot specific glue is only
re-added at the end.

Best regards,
Alexey
