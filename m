Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7DCC44531
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 03:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B17A80DC2;
	Tue, 21 Jul 2026 03:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxM7j5QhQRNa; Tue, 21 Jul 2026 03:36:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E0CB80D7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784604975;
	bh=74bEwHwAyN6uoYTJchEYojV0/dG8QD0rmwmG55wIsu4=;
	h=To:Subject:Date:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=NTIBC7KXZXZ+E9zr37+VDbKnG78YRfLgbI5Qq0H4W9E1sZnDt/lUu6okx3uVQEPsg
	 rf/o72jLlgk5w+B7Zt4Kgk+TP9SkzS2fYXZU9OnTm03OWMPCgoOyVUOE5ExZQZu/1S
	 2+Po/SI46FPtYAi8WO5oQSp2xRfXl4LTd8CksJVpBk93AFrCvrP3GdUWKmpdywA3b8
	 q2BYVFthLD/DJ1d0kzMBXfRgjhE4ElVGN69WrL0tnOfcu36io8eoBhfCz6FElLpmRN
	 cxkja+mKSapl2IB38p1KJcOCm9HgE1/g+9xpg7ggOkRl7cgxUuDVpbIk+heZ5X3DOK
	 9XM1HoMBCeSVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E0CB80D7C;
	Tue, 21 Jul 2026 03:36:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FAEE96C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 952CC406F1;
 Tue, 21 Jul 2026 02:14:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21sqbXRgPDrD; Tue, 21 Jul 2026 02:14:38 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=gcbu-u-boot-users@m.gmane-mx.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B259540523
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B259540523
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B259540523
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:14:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADA65846A5; Tue, 21 Jul 2026 04:14:35 +0200 (CEST)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6725382991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 04:14:33 +0200 (CEST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1wm008-0001ex-NC
 for u-boot@lists.denx.de; Tue, 21 Jul 2026 04:14:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
Subject: Re: [PATCH 0/9] video: rockchip: VOP2 and HDMI output for RK3568
Date: Mon, 20 Jul 2026 22:14:26 -0400
Message-ID: <jwvldb5qej3.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <cover.1784424101.git.daniel@makrotopia.org>
 <jwvv7aasn6w.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:JxxkBNxWUv1rX5OXpXWgWRvmiqM=
In-Reply-To: <jwvv7aasn6w.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 (message from Stefan Monnier <monnier@iro.umontreal.ca> on Sun,
 19 Jul 2026 17:24:01 -0400)
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 21 Jul 2026 03:36:14 +0000
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gcbu-u-boot-users@m.gmane-mx.org
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
From: Stefan Monnier via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Monnier <monnier@iro.umontreal.ca>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

> But I still can't see anything on my display (and hitting any key on
> the USB keyboard did not elicit any response, the timer kept going).
> The serial-port output is appended (tho I cut out the DDR
> initialization part).
> Any idea what might be the problem?

I also tried it on a NanoPi R5S with the patch below:

    diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
    index c971f376b38..ed8d6187448 100644
    --- a/configs/nanopi-r5s-rk3568_defconfig
    +++ b/configs/nanopi-r5s-rk3568_defconfig
    @@ -55,6 +55,7 @@ CONFIG_RTL8169=y
     CONFIG_PHY_REALTEK=y
     CONFIG_NVME_PCI=y
     CONFIG_PCIE_DW_ROCKCHIP=y
    +CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
     CONFIG_PHY_ROCKCHIP_INNO_USB2=y
     CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
     CONFIG_SPL_PINCTRL=y
    @@ -79,4 +80,12 @@ CONFIG_SPL_USB_DWC3_GENERIC=y
     CONFIG_USB_GADGET=y
     CONFIG_USB_GADGET_DOWNLOAD=y
     CONFIG_USB_FUNCTION_ROCKUSB=y
    +CONFIG_USB_KEYBOARD=y
    +CONFIG_VIDEO=y
    +CONFIG_DISPLAY=y
    +CONFIG_VIDEO_ROCKCHIP=y
    +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
    +CONFIG_VIDEO_DT_SIMPLEFB=y
    +CONFIG_VIDEO_BRIDGE=y
    +CONFIG_VIDEO_REMOVE=y
     CONFIG_ERRNO_STR=y

and it 's partly successful but not quite:

- At boot, I get a U-Boot logo in the top-right corner of the screen.
  This apparently gets displayed during the whole time U-Boot is waiting
  for BOOTDELAY.
- Nothing else appears on screen (e.g. no text).
- Pressing keys on the keyboard seems to have no effect at all
  (including not stopping the boot after reaching BOOTDELAY).

I don't have a serial connection for that SBC, sadly, so I can't post
any further details.


=== Stefan

