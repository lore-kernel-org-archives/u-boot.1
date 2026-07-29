Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E471C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 15:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCEEF80C81;
	Wed, 29 Jul 2026 15:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xTi-xw379S1; Wed, 29 Jul 2026 15:58:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF0E980B39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785340723;
	bh=5HsEGzXzYkaUIcTW+IbHlQNVl7X9SYA1uohkDe4e/zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K78V/Go4vPY9MelTQhHjst0DMNqm7FCdCTv1RLwpkdc5qdISGei+L4A4W0CE1VU3K
	 7ztmIvvIw0l+hRqsLv4BjbE5/H4HYdfaNqKpyAekw8GkXq3Prw3Ls5sfwWduESzjpK
	 yDGn1xdE5O1KrCw9O6VLFPpWfcmVxB0FXq7A7d3XscZWkIZzd3Rv+er3AGOEhNxyoo
	 fl3d+pWTeUC7UwVLtkVOm+wzMVfN/zW6OsqhNhy374XinH6LgxacD03XM/9Q1p+7eP
	 tujbyypOw62V77HwtHPkQlrpzSW7WerpMlcn3VFuVJHEEkYfHUmHBuwuSi3k/zhrXT
	 tpYVYlLx2EoIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF0E980B39;
	Wed, 29 Jul 2026 15:58:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F9B8788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2165C80C81
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:58:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYa1ane9bgNM for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 15:58:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 230D580B39
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 230D580B39
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 230D580B39
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 15:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785340707; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WMvxDFlpDXgFPffHMyppZsFtRpSGDaLjhdDy45QOeN803wrru8/768WgipDigTu6gRV3kCHyOUzoC3AEpHMJ7OVDMMEbv52A8//jPnDqcawLgoOKMbUmn2LTfPFj+2lUzGXI5nOlvXvpldv9ppoQfi90MDDNxVRNG0omD0OzbGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785340707;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5HsEGzXzYkaUIcTW+IbHlQNVl7X9SYA1uohkDe4e/zs=; 
 b=P41CsXm7zc5C8UupxPd475/xwPomkkkass7cvpkJtxf207nTgX9W6+A1mDEvRABi3Qgfpl//oo+8F/xF489lyKWovGS1CkZiwnxFQeq6tmY31PLwOgWsF0Oba/zdIQuS9bziI4EWDLCnTfxYuvjE2RM4w2WYHKiz4SLmC7/nhPs=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
Received: by mx.zohomail.com with SMTPS id 1785340701692939.8638733419027;
 Wed, 29 Jul 2026 08:58:21 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:58:02 +0000
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
Message-ID: <amojCjayE5-wI7iT@pie>
References: <20260727-m4-v6-0-2f58566d48ca@riscstar.com>
 <20260727-m4-v6-6-2f58566d48ca@riscstar.com> <amdGSBKT4iRzuh1P@pie>
 <CAH22mJz64S5_em=D0zvt1uUaGpymAb1Ss5uiB5OkutpRcU=6Og@mail.gmail.com>
 <ameQUN3zlD0Ei8Jm@pie>
 <CAH22mJyMqTgRLqyfVZGgSHHNK7XnBTnrkY-R1ix5DN+oiBDEbg@mail.gmail.com>
 <amhyAULw9Wovuo3z@pie>
 <CAH22mJyyExBuUrDNgRg=WU4f6RkN7M0QhtuUAgXiUf8b84TaCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH22mJyyExBuUrDNgRg=WU4f6RkN7M0QhtuUAgXiUf8b84TaCQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.322.57
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785340707; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=5HsEGzXzYkaUIcTW+IbHlQNVl7X9SYA1uohkDe4e/zs=;
 b=FtXgFdbjWENSmnNUYFcxPUpuTu8KFULIXL5TWyUZsZweU/SNNG6lqdY8MJui/gWw
 LzMaYhD5gbamnYSo3f9uOSyufDZ15uiR1Z74pETYi6aKUcQqZ5BbhxYGxpL7pussPFY
 SHKd/Rh3xqwVgfhXZfhGz3ZZGadOspCdBI1zi7gk=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=FtXgFdbj
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

On Wed, Jul 29, 2026 at 10:05:14PM +0800, Eric Chung wrote:
> On Tue, Jul 28, 2026 at 5:11 PM Yao Zi <me@ziyao.cc> wrote:
> >
> > On Tue, Jul 28, 2026 at 09:04:52AM +0800, Eric Chung wrote:
> > > On Tue, Jul 28, 2026 at 1:08 AM Yao Zi <me@ziyao.cc> wrote:
> > > >
> > > > On Mon, Jul 27, 2026 at 09:08:52PM +0800, Eric Chung wrote:
> > > > > Hi Yao,
> > > > >
> > > > > I'm not familiar with the policy for syncing DTS files from the Linux upstream.
> > > > > Could you clarify how this script works?
> > > > >
> > > > > Does it sync all DTS files from Linux upstream at once, or is it
> > > > > possible to sync
> > > > > only the Spacemit DTS file?
> > > >
> > > > update-subtree.sh cherry-picks a commit from the upstream, or
> > > > merge an upstream tag into the subtree. Cherry-picking SD-related
> > > > commits from Linux upstream suits for your case.
> > > >
> > > > > If I choose to sync only the Spacemit DTS file and include it in my patch set,
> > > > > would that cause conflicts later when others try to sync all DTS files?
> > > >
> > > > Tom synchronizes the dts subtree with Linux upstream irregularly, there
> > > > should be no conflict or relatively small ones if you cherry-pick the
> > > > changes, while adding downstream nodes in *-u-boot.dtsi might suffer
> > > > from duplication, too, during synchronization.
> > > >
> > >
> > > The process is a bit complex. Since my main issue is that the DTS
> > > files are out of
> > > date, would it be simpler if I just copy the relevant Spacemit DTS
> > > files directly
> > > from the Linux upstream into the dts/upstream folder?
> >
> > The answer is simply no.
> >
> 
> OK. I'll keep using my own overlay DTS file.
> I tried upstream DTS file. It only gave me more bugs. I could switch to
> upstream DTS file when Tom syncs it.

So first of all, please note switching to upstream devicetree doesn't
mean you must remove all the dts overlays, you could keep small pieces
like these adding bootph-pre-ram properties, which are
bootloader-specific and might not get upstreamed in a short period.

And I noticed there have been quite a lot code in the overlays, like the
PMIC code, thus changes to overlays might be huge when cherry-picking,
if it's the case, this patch is then acceptable, but please mention it
in the commit message.

But, if switching to the devicetree with cherry-picked patches for MMC
leads to bugs, there are likely ABI compatibility issues in your driver,
which would persist even after the synchronization with upstream v7.2
tag. Please fix them. From the very start, it's agreed compatibility
with Linux devicetree ABI is important[1].

So here's my NAK for this series, including v7 of it.

Thanks,
Yao Zi

[1]: https://lore.kernel.org/all/20260429-glare-anybody-16c98d01184e@spud/

> > > > > Best Regards
> > > > > Eric
> >
> > Regards,
> > Yao Zi
> >
> > > > By the way, please avoid top-posting if possible.
> > > >
> > > > Thanks,
> > > > Yao Zi
> > > >
> > > > > On Mon, Jul 27, 2026 at 7:52 PM Yao Zi <me@ziyao.cc> wrote:
> > > > > >
> > > > > > On Mon, Jul 27, 2026 at 02:59:08PM +0800, Eric Chung wrote:
> > > > > > > Add the SDH0 controller node and its pinctrl groups to the u-boot
> > > > > > > overlay. The upstream DTS only contains the eMMC node; the SD card
> > > > > > > controller (sdhci@d4280000) and its MMC1 pinctrl configuration are
> > > > > > > missing. Place the new node inside the storage-bus via path-based
> > > > > > > merge so it inherits the dma-ranges from the parent bus.
> > > > > > >
> > > > > > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > > > > >
> > > > > > Please cherry-pick upstream devicetree changes from Linux upstream with
> > > > > > tools/update-subtree.sh instead of adding our own copies. Changes for
> > > > > > k1-bananapi-f3 and k1-muse-pi-pro have both landed in Linux v7.2.
> > > > > >
> > > > > > Best regards,
> > > > > > Yao Zi
> > > > > >
> > > > > > > ---
> > > > > > > v5:
> > > > > > > - Append power source field on eMMC/SD pinctrl.
> > > > > > > v3:
> > > > > > > - Fix SD pinctrl as uhs.
> > > > > > > v2:
> > > > > > > - Use vmmc-supply as vqmmc-supply on SD node.
> > > > > > > - Add alias of mmc0 and mmc1.
> > > > > > > ---
> > > > > > >  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 91 ++++++++++++++++++++++++++++++-
> > > > > > >  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 86 ++++++++++++++++++++++++++++-
> > > > > > >  2 files changed, 173 insertions(+), 4 deletions(-)
