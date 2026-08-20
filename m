Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AF4C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 11:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2899B80CBD;
	Thu, 20 Aug 2026 11:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4gSizli_YXU; Thu, 20 Aug 2026 11:52:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787226736;
	bh=w91h6pLMlXuK7tlD/1+cQCMgnBHcpyn80WxUd81NwXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t3Zg6Kshsd9b3JE/BsKyRZsy6jmJNtML1NYMPl22SnDQVJ1/Hs+0R/kUaGOSkPoDz
	 MH9SXlcNKRui0ezLw+bL7fCbcKDXDU0Yt2eUVPFE3megKdFzvPyppbKOO9C61IDpzV
	 D6PbWXqtGTwOxKrU7gwDkCxtSGBxj7cq2MqZO11UVySLkNqGLe/VSIgeobEkygdUh1
	 oAopGrjl55ImQ1DbNQ9dthrFg99PXMrpfNabsU5T0caSeZFv+RjZRhJLmAjTwUGXHV
	 TwXYOJa91EDf36tCAivHFTsJIVPPvxWSy7lLeX+GDzlRvXkgKgc5Cr8x7jFuCdBWPB
	 SF74+yGrC0kLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CCB780BBC;
	Thu, 20 Aug 2026 11:52:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 54B6A1395
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40F29400A1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wz6zGcXsSRFZ for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 11:52:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=OwPdv8zL
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D3C440082
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:52:13 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-902e4af2d9dso5880576d6.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 04:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226732; cv=none;
 d=google.com; s=arc-20260327;
 b=G/aGCe/mkkd3URKOe6hpvh1lXEnJLdZFDMROO7rdxk3g5VNMdbsIKN0NUQZq1BPsq9
 PLfiOdaI4TTsQ8zconOSnBQJvIwFgE3kqq329l72wP6qfMyIA4W21gNBuZDTFdQEr4QV
 zZ+Y+qOAZ8/Yj7g9+089JZR70xaC6GyFvTgVwwFaS889v+81s2KcvKrF5qE/9ops+/Qx
 2rgdj8DnJUYxvlGK4k+h9ONUsIttsn+IeDSyX6+qxSBlt7/+RvB7hRp9ciniEoN8KtRC
 FoPF7FoieuJ2nxBSUsWWWfJiiDDbZvhCE0LlpsAEL5sFR5ki0Gc3Av1Mr5W6x9VLBA9v
 NyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w91h6pLMlXuK7tlD/1+cQCMgnBHcpyn80WxUd81NwXg=;
 fh=WetTzq2xTDX5h60waVCMlF8+Q239zw5nKngPEmXaato=;
 b=FVdi0bOLSs225P2k2DZbnPu9RVR9KBnv2Va4tlPYLfNmBwWrEYH2OZGctULzGCJ3E4
 Av1uws7j01pe6wPPhQ4S7f+XL1Lqh1elJc/6pzkZUo+ptlgPzjMpCA1pzKl3toW/tFXr
 Rm6phjE3EqC99IndJY5yQ1oM0sAgHYLPcqoYClcbcbztRLOU45Uc0uqtiRy/Gm9LTTa4
 Trs7XaChW7/KmAokh/ggmKJeV1lgfzOEacj4QRW8a7OFZpGrG9RAA5HYafSSE9t4CP7s
 djZjVtzcQCTo5TUkXosawjKl/SGXjf6WBOZHJIRQTwKEa7ZDKKXU7pubnxu1yDjYZ8u/
 lyxQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787226732; x=1787831532;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w91h6pLMlXuK7tlD/1+cQCMgnBHcpyn80WxUd81NwXg=;
 b=OwPdv8zLbKGv0IEssbD5sSrB2DfIAK6DA5/sDX9lAF7zyQaybZtV8X+DITd4WFP4cD
 /0OpCuL6I+PHremE1dhGRnpBWb9PaJmBBOGmKlWR6XOIHY/IEfPfxA5UVUsRKAb5UgPX
 IgAAVmVc3uW6qajpgkoR/8kmqia2PHRMXjLZc7WoEAJ9oRYxr5D+G/abHHsldmm8nt2I
 S6Z2vpm9vZ7vCJNtCTK1/1WF35Mo1JPmVLiw1K8uXfyBJtkUH2yXvXKBVreE0qUyi3bw
 wEr7FriW1Jo+tNdCZxQ6vw1iZwrE9W3NnxnJ8BiAcybTlUrMu+eSAR15kdS+1snWJyoC
 I5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787226732; x=1787831532;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w91h6pLMlXuK7tlD/1+cQCMgnBHcpyn80WxUd81NwXg=;
 b=EIR/dJbQDZe+X5q3zST4IDhWyQ16WbmOpFnibIIdim05ZFucA9PL4WZxsUI6oM1NCY
 ZmMgubznv99GSakVUv9+iSP4p1i2gO8GM2vCqQsgVD+EWNXgBS9ULPM70UaPc9Uny8tp
 fbMPuFOXue/HSP3+IQMBmYtElMABkfj2bDJa8DqRms109BvmRXeU6m6w5LbVGPVd7+Ap
 fYUiL+B9UvPXYMgQcmN3ItRlGEURtHD7lclqqRmwfYhSs++VOEZk23DD/0TTn+vKungW
 IMQf4IOOxFATBswART4yccUo01Ao0uGVSVMqQphyevk35FCajAgWw/WS/Pp6NEN5z+lr
 OyFA==
X-Gm-Message-State: AFuF++nH5ZFdyAKoQU1rX9uS0kZ0gH8nN8/cEVD/vP9DWPz9IgMR2qjV
 UybCUxrL3P/irNFAy1RJnW7lNF4g9ZBnitG2gpBC4KbWucnIH6ZisguQP7Z2yeIxydjmsT1kxyW
 1QBc6IaulYadMEO2ZDqigU4IKcAKZztI=
X-Gm-Gg: AR+sD11yqnPUv24FDqeQO8sXlbDViY0vwk1I9WeOU1RAfqpjKpXaXi2LuHItwsrXIeT
 YKIkYeuju4OZj/Q1yYBvNXh6olRQ2i8rkLvVgqC/5hmKMhup5PH9r+vfYE3TfaafXnUEfP1ofSE
 tZFguOsXmIiRVnICSIMoTupfA6o++HbLHPNCUBbzuZEYenW+cefElRTFh+WsvAsD1tmE+nBr7Ru
 7psrFccE/mLiaFPlACublF03N1yaodUdJ5FCHpbd/HeJyTfVO7MiwEIbg9yV+3NVw+UMnU1nQLH
 5132CEzg5Rh9DCxMm3hDLMtxLMvovpuW7cmmy8Dna5lqUcipXy1M++sgkN964WneYGshFJN7+gk
 0TiCmfAkohfZYqoqgJroXNHxSZPQcL1KNHhdGmWVyhYxcRuP7k6zv5bkUTrHmlhPrtH9pu18Axq
 OhBs+wc2J1lYqJb6av1bbx72bD/3iYZwLM8Nicu5o=
X-Received: by 2002:a05:6214:2608:b0:90c:6948:9191 with SMTP id
 6a1803df08f44-90c6abb7db1mr56062476d6.12.1787226732203; Thu, 20 Aug 2026
 04:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260817153144.1951036-1-vjardin@free.fr>
 <CALeDE9OTtd7Oy7sVKsdukfnwdrV3Sg5d1F34muBQgZdsOaMoKA@mail.gmail.com>
 <aoM6i7TKGcfAydpp@L30177.local>
In-Reply-To: <aoM6i7TKGcfAydpp@L30177.local>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 20 Aug 2026 12:51:57 +0100
X-Gm-Features: AcwNN1Xw-ue_eUQSHEsgKbLYFnfHY_Q14oGZ33JmsNxYcmc1yhzzcI3lE8aEdEE
Message-ID: <CALeDE9OSFs=3WkKFh6tBa0VHdVAvKSL=-XktBQHwbTd-vefwiw@mail.gmail.com>
Subject: Re: [PATCH v1 00/23] board: nxp: add the Free Mobile Nodebox v3 CPU
 Module (LX2160A)
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Wasim Khan <wasim.khan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Vincent,

> > > This series adds the Free Mobile Nodebox v3 CPU Module, an NXP
> > > LX2160A based board (16x Cortex-A72, DPAA2). U-Boot is the BL33
> > > payload of TF-A: BL2 trains the DDR, BL31 hands over, and U-Boot
> > > boots a FIT image (kernel + MC firmware + DPC/DPL) from a single
> > > FlexSPI NOR. The module plugs onto several carrier boards (NBV30,
> > > NBV32, etc.) that share one kernel image but differ in their device
> > > tree and DPAA2 data path.
> >
> > Why just FIT and not UEFI?
>
> Because this layerscape platform shall not support UEFI by design.

Really? I have a clearfog LX2 platform that boots and runs with UEFI
just fine. Generally this is where the Linux ecosystem is going so for
a new board going upstream I would expect it to at least be an option.

> > > The port is modelled on the LX2160ARDB / QDS boards and lives next
> > > to them under board/nxp/lx2160a/, reusing their SoC level code.
> > > Board specific behaviour is wired through EVENT_SPY hooks rather
> > > than weak symbol overrides, and the dependencies each hook needs
> > > are forced on by hidden default-y Kconfig bools under
> > > `if TARGET_NBXV3`, so a hook cannot silently turn into a no-op.
> > >
> > > The series is in three stages:
> > >
> > >  1. Base port and documentation (patches 1-2): TARGET_NBXV3, the
> > >     defconfig, a minimal device tree, the MAINTAINERS entry, the
> > >     Ethernet wiring file and doc/board/nxp/nbxv3.rst.
> > >
> > >  2. Board code (patches 3-9): DPAA2 Ethernet on DPMAC17 through the
> > >     RTL8211FD PHY; the +0V8_VDD core rail (MPS MPQ8785 PMBus
> > >     regulator snapshot, PMBus PSU snapshot, VID fuse driven voltage
> > >     trim through UCLASS_REGULATOR); the ${carrier} selection that
> > >     lets one FIT carry a DPC/DPL/DTB set per carrier; the ZL30733 /
> > >     ZL30643 DPLL traces; the +3V3_FAN rail hook.
> > >
> > >  3. Build and device tree settings (patches 10-23): one small
> > >     commit per peripheral or features, each enabling its DT nodes and
> > >     defconfig symbols.
> >
> > The device tree should be sent upstream to the Linux kernel and then I
> > think most of 10-23 should be compacted to a single patch.
>
> I get your point of Linux first and uboot policy, however, this board
> follow the legacy support of other NXP's lx2160/layerscape boards. For
> example,
>
>  arch/arm/dts/fsl-lx2160a-rdb.dts
>  arch/arm/dts/fsl-lx2160a-qds.dts
>  arch/arm/dts/fsl-lx2162a-qds.dts

There's a number of fsl-lx216x boards with upstream linux DTs.

> and LX2160A defconfigs currently use CONFIG_DEFAULT_DEVICE_TREE without
> CONFIG_OF_UPSTREAM.

But those boards still have upstream device trees.

> Moreover, per https://docs.u-boot.org/en/latest/develop/devicetree/control.html,
> "Configuration" section: it says that SoC/board maintainers are encouraged to
> migrate to dts/upstream/, but also says that when dts/upstream/ has not yet
> received the device tree for newly added board support, one option is to add it as:
>   arch/<arch>/dts/<name>.dts
> with CONFIG_OF_UPSTREAM disabled.

Even boards that don't use OF_UPSTREAM because of outlying deltas
still typically have their DTs upstream and there's syncs between
them. see the lists archives over the years for numerous examples.

So yes, board maintainers are encouraged to migrate to upstream, but
you've missed my point generally. Boards are generally required to
have an upstream DT even if in U-Boot they don't use the OF_UPSTREAM
infrastructure. That is to ensure that the DT has some level of review
and sanity and isn't just thrown over the fence. Hence why I asked.

> So how would it be acceptable to have fsl-lx2160a-nbxv3.dts under arch/arm/dts/,
> consistently with the existing LX2160A boards and the option described in the
> U-Boot documentation?

No, please get review of the DT upstream even if you end up putting it
in arch/arm/dts/ to ensure we end up with something that is
maintainable.

> Should those patches 10-23 be 1 commit, I can squash them too: I wanted to record
> the logics of each feature sets.
>
> Best regards,
>   Vincent
