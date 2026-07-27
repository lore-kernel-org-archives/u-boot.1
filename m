Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF008C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AB7C6073A;
	Mon, 27 Jul 2026 17:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cKnVNdfWMgh7; Mon, 27 Jul 2026 17:08:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19441606EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785172081;
	bh=DaHUvmPe2et4E0UabXOzoo+LVnbAKwPLotVtH3d2Dj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=znY/KBP5DNZwCXsKaq2yep5iCouErU1x/cITKEmMhXWp0+dABavJslxadfibhwA7r
	 zY5ikAUL7wYR2TA2f++I/N9VTVPdZz/1PcOjNd3hPxkAYuvhX/e5b5vE7G5x45MAmk
	 06XZ5LioST1jzvh+Rt2H+kWUgtc1FzZSIXVax3dEWsYHEqSbphM/IIW/b0DxNhVPmb
	 3hImi+A/JAuz7mPp3ecjqMPknuf6BzKPfsA58dBRwFtCQz7Nv9X+y52BPFQsiFElfL
	 LC1E5SOoOnlIDz1ekB6VCVTVKnCHLvMyr/Ea/d4S0J326Gu3Lzx3z9RnH+3QlC4xSG
	 fdW7veCtOXOng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19441606EF;
	Mon, 27 Jul 2026 17:08:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78EDD39E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F3E0400AC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:08:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XodTgsV9Okmn for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:07:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 575C940055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 575C940055
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 575C940055
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785172063; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aBWHSIvObidKYTiRDdu5XwUbq1EXsBh7++Fd/5yLWdbvwIHcpjQnUq50BuCQuKqpK4eCmsXRpw0NYCG8zBhj4HoNAseJoNEU3q9HPgn8S/DVorx8dijWZyhQg42KLiwZwU3WLWkR2j/Z5sQAUDL/IW98B3lMWpsgf3Y1PwnD51w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785172063;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DaHUvmPe2et4E0UabXOzoo+LVnbAKwPLotVtH3d2Dj4=; 
 b=It8Njo3d+Cgv+QNBdxV9lk69BDyOtk214+VFfbUWmoJi27jbE6jT1MrmweHzKdpEKk8rGdhY7Sr0ppj1HDXnJyuXZBgbt5gPfnEHITjFUnRXoExB85B2EYiWxMtDhv4woAk0cHyDHMd2mKPPhzlWToXF+OHt5oryMeD3mndbz5c=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785172059341288.149333284249;
 Mon, 27 Jul 2026 10:07:39 -0700 (PDT)
Date: Mon, 27 Jul 2026 17:07:28 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Subject: Re: [PATCH v6 06/11] dts: k1: add SD card support in u-boot overlay
Message-ID: <ameQUN3zlD0Ei8Jm@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-6-2f58566d48ca@riscstar.com> <amdGSBKT4iRzuh1P@pie>
 <CAH22mJz64S5_em=D0zvt1uUaGpymAb1Ss5uiB5OkutpRcU=6Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJz64S5_em=D0zvt1uUaGpymAb1Ss5uiB5OkutpRcU=6Og@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.167.77
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785172063; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=DaHUvmPe2et4E0UabXOzoo+LVnbAKwPLotVtH3d2Dj4=;
 b=Ektocp/BHQqVlo/S4rMmSnhBu6q+QQNzvaSbzZDFwHxTCeR999PUxiTh/V6YVHN7
 Ie+KuNfKH6cXZe7gnG3mqhvrB6UBK9UpJy4ljbqbiApoECgqngEMRFTP/1rNP5wQOKw
 bWbrw5DG+QA41CbDgB9BW4JhTZwmnnNR/m5d0Hnk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Ektocp/B
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 27, 2026 at 09:08:52PM +0800, Eric Chung wrote:
> Hi Yao,
> 
> I'm not familiar with the policy for syncing DTS files from the Linux upstream.
> Could you clarify how this script works?
> 
> Does it sync all DTS files from Linux upstream at once, or is it
> possible to sync
> only the Spacemit DTS file?

update-subtree.sh cherry-picks a commit from the upstream, or
merge an upstream tag into the subtree. Cherry-picking SD-related
commits from Linux upstream suits for your case.

> If I choose to sync only the Spacemit DTS file and include it in my patch set,
> would that cause conflicts later when others try to sync all DTS files?

Tom synchronizes the dts subtree with Linux upstream irregularly, there
should be no conflict or relatively small ones if you cherry-pick the
changes, while adding downstream nodes in *-u-boot.dtsi might suffer
from duplication, too, during synchronization.

> Best Regards
> Eric

By the way, please avoid top-posting if possible.

Thanks,
Yao Zi

> On Mon, Jul 27, 2026 at 7:52 PM Yao Zi <me@ziyao.cc> wrote:
> >
> > On Mon, Jul 27, 2026 at 02:59:08PM +0800, Eric Chung wrote:
> > > Add the SDH0 controller node and its pinctrl groups to the u-boot
> > > overlay. The upstream DTS only contains the eMMC node; the SD card
> > > controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
> > > missing. Place the new node inside the storage-bus via path-based
> > > merge so it inherits the dma-ranges from the parent bus.
> > >
> > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> >
> > Please cherry-pick upstream devicetree changes from Linux upstream with
> > tools/update-subtree.sh instead of adding our own copies. Changes for
> > k1-bananapi-f3 and k1-muse-pi-pro have both landed in Linux v7.2.
> >
> > Best regards,
> > Yao Zi
> >
> > > ---
> > > v5:
> > > - Append power source field on eMMC/SD pinctrl.
> > > v3:
> > > - Fix SD pinctrl as uhs.
> > > v2:
> > > - Use vmmc-supply as vqmmc-supply on SD node.
> > > - Add alias of mmc0 and mmc1.
> > > ---
> > >  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 91 ++++++++++++++++++++++++++++++-
> > >  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 86 ++++++++++++++++++++++++++++-
> > >  2 files changed, 173 insertions(+), 4 deletions(-)
