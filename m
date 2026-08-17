Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89DAC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D658406FB;
	Mon, 17 Aug 2026 16:45:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHI5cgCO3GAB; Mon, 17 Aug 2026 16:45:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6E4BF40768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786985114;
	bh=Sw0fsLLVRaufNPimll40Ec7H9nkM3tf0/KuJwcOzeFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bxrVQFHCqIO621TnHLZI96qmdGwR4CclcLh0bDfARD/oK+orAnYmTIaIs5NbxF5fH
	 8lMjZizNDwW7UmDQaWMT8LXrNjIryYLBIfaUkRBhxFex1MVJjpkIO2OoYhkNWiLrzl
	 pFK11EMHT3Rrw0UdP1MkUGKo0R3ZlDbYZd66YXVRMl40Za0Xbz+Z59tpVW7MugfeEG
	 RWPwr2gRn6qYpbvwAcoLGExy0DCSxwh2MSmQspjcHQ9I3DvCMl4dCQ0cxlIf9YelUK
	 sG4kRO+fYt6Oip5JrorP/sWvV900tlM7lhLubMpg3fi+NTH5CsEj2CuGRmaESK5A/o
	 mdDppeq+hLrJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E4BF40768;
	Mon, 17 Aug 2026 16:45:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3274E334
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:45:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2414780E55
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:45:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ig61-9-c6n9n for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:45:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E8C6C80F6A
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8C6C80F6A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=vAlHIJzq
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8C6C80F6A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:45:11 +0000 (UTC)
Received: from L30177.local (unknown [78.240.182.195])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id D62FFB0054C;
 Mon, 17 Aug 2026 18:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786985108;
 bh=sT+Qh9xAr9qrL5x78149NibbSOUN8kuQwtM5GcJb/Uk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vAlHIJzqrFEl34OCOiH2MhhSYzK/NswX6TT+tj2tPLjHIvZViJhaieZnNhimMOY+J
 QFrLZBVcLwTHZOcjvWfb3K3Mj87fT2vdpZWlCA6J7OUWdHT90JzQCyeAhcx8kbiapC
 qwEGkKINsIbbOdarnlatSICno/gnJgU6RUIyMaiUxnuQRlNliz6Xj4wwvpg5QTm7RK
 VgU2qftzkyV0SvStegcP5oFY9ZVPOjeQGJrcRPojPTQJFTRe29WFfd6KjsIPzfopI0
 RBbaS+Md5NaylvtDbezQlLFl/dqem2fFc0+t6nCyGpQDLdcrhiRyKnscZUiXBd8pLi
 Qbs6ESuUEFGAg==
Date: Mon, 17 Aug 2026 18:44:59 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v1 00/23] board: nxp: add the Free Mobile Nodebox v3 CPU
 Module (LX2160A)
Message-ID: <aoM6i7TKGcfAydpp@L30177.local>
References: <20260817153144.1951036-1-vjardin@free.fr>
 <CALeDE9OTtd7Oy7sVKsdukfnwdrV3Sg5d1F34muBQgZdsOaMoKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALeDE9OTtd7Oy7sVKsdukfnwdrV3Sg5d1F34muBQgZdsOaMoKA@mail.gmail.com>
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

Hi Peter,

Thanks for the feedbacks, see below.

Le 17/08/26 17:01, Peter Robinson a écrit :
> On Mon, 17 Aug 2026 at 16:32, Vincent Jardin <vjardin@free.fr> wrote:
> >
> >
> > This series adds the Free Mobile Nodebox v3 CPU Module, an NXP
> > LX2160A based board (16x Cortex-A72, DPAA2). U-Boot is the BL33
> > payload of TF-A: BL2 trains the DDR, BL31 hands over, and U-Boot
> > boots a FIT image (kernel + MC firmware + DPC/DPL) from a single
> > FlexSPI NOR. The module plugs onto several carrier boards (NBV30,
> > NBV32, etc.) that share one kernel image but differ in their device
> > tree and DPAA2 data path.
> 
> Why just FIT and not UEFI?

Because this layerscape platform shall not support UEFI by design.

> > The port is modelled on the LX2160ARDB / QDS boards and lives next
> > to them under board/nxp/lx2160a/, reusing their SoC level code.
> > Board specific behaviour is wired through EVENT_SPY hooks rather
> > than weak symbol overrides, and the dependencies each hook needs
> > are forced on by hidden default-y Kconfig bools under
> > `if TARGET_NBXV3`, so a hook cannot silently turn into a no-op.
> >
> > The series is in three stages:
> >
> >  1. Base port and documentation (patches 1-2): TARGET_NBXV3, the
> >     defconfig, a minimal device tree, the MAINTAINERS entry, the
> >     Ethernet wiring file and doc/board/nxp/nbxv3.rst.
> >
> >  2. Board code (patches 3-9): DPAA2 Ethernet on DPMAC17 through the
> >     RTL8211FD PHY; the +0V8_VDD core rail (MPS MPQ8785 PMBus
> >     regulator snapshot, PMBus PSU snapshot, VID fuse driven voltage
> >     trim through UCLASS_REGULATOR); the ${carrier} selection that
> >     lets one FIT carry a DPC/DPL/DTB set per carrier; the ZL30733 /
> >     ZL30643 DPLL traces; the +3V3_FAN rail hook.
> >
> >  3. Build and device tree settings (patches 10-23): one small
> >     commit per peripheral or features, each enabling its DT nodes and
> >     defconfig symbols.
> 
> The device tree should be sent upstream to the Linux kernel and then I
> think most of 10-23 should be compacted to a single patch.

I get your point of Linux first and uboot policy, however, this board
follow the legacy support of other NXP's lx2160/layerscape boards. For
example,

 arch/arm/dts/fsl-lx2160a-rdb.dts
 arch/arm/dts/fsl-lx2160a-qds.dts
 arch/arm/dts/fsl-lx2162a-qds.dts
  ...

and LX2160A defconfigs currently use CONFIG_DEFAULT_DEVICE_TREE without
CONFIG_OF_UPSTREAM.

Moreover, per https://docs.u-boot.org/en/latest/develop/devicetree/control.html,
"Configuration" section: it says that SoC/board maintainers are encouraged to
migrate to dts/upstream/, but also says that when dts/upstream/ has not yet
received the device tree for newly added board support, one option is to add it as:
  arch/<arch>/dts/<name>.dts
with CONFIG_OF_UPSTREAM disabled.

So how would it be acceptable to have fsl-lx2160a-nbxv3.dts under arch/arm/dts/,
consistently with the existing LX2160A boards and the option described in the
U-Boot documentation?

Should those patches 10-23 be 1 commit, I can squash them too: I wanted to record
the logics of each feature sets.

Best regards,
  Vincent
