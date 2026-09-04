Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6A3C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 20:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C838560BB1;
	Fri,  4 Sep 2026 20:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id frMx8T_OzFUJ; Fri,  4 Sep 2026 20:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CAB7F60B8A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788555127;
	b=DRbSuxZQECupx2FUCSx0hOr9ZNgduZU1mWaRv+7DG2xqoW1VYtxEPA8rUWeItHuH+e/M
	 0AYaarqGiMMcRi1muMAvNTlFtOto3DiEmQooqM7cnNbqrDDzXFbgw+1Ia3aSXd+fJPcbu
	 /xp5CPB/VZ3V7vtf9zc27To0evhZ4qWfureG1PWx/TUlMEacuxh7U6IOnZruN93s4mV3y
	 NelAJzJ5E0qaC9kN0BpgtEQWyEiN6o0oH69wEreYF6U1DZalIt5eJpy/6lte7p9TrwSOd
	 dmIKAAv4jsrKKJjBHN+UXXJX0guU7yH0rMuhOAiFA7ld0Fle9lRoXYPP/mpetbahnZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788555127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6GQcHgR85XdlVHpXTOOmvcdOAAPtunBQvPqpohTbcTc=;
	b=KY8wqn+n5aU2a6XpMo4q91zft9q64qMO8nMsAZGKAGiVTtzPQSlK+AQCChCjJMR5sg5+
	 wf/w4xI9vq/ryFkAnm5tcpdDH8FiigF3axkWidcVPADpfd+YM3yD8n9vgHg3VOa9WTr2H
	 fIeCsRjOjUl2hGSvxEdjVbrs1tPVPyQwyOjHLOSWGXchCG0BLDEsZsWFXyjjZLA37rXwh
	 GbFbIoAAlpbextBrE9B0Y/+RtPjrbrdKbNGviKo3nzS3O7KoTR/mkIMgSdbGZ1IYjhqVj
	 UCaxULcMW/mGIFdGG0kAm5mQulHuFCFdu9guOE+2VdNO9S+6XKS6e5myICqy05Ukanw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788555126;
	bh=6GQcHgR85XdlVHpXTOOmvcdOAAPtunBQvPqpohTbcTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=02n7r/pbUUnh61dzt2/cWK2LBvuAbE+AAm1pDbpig3fr8X37QDw+h1e9ZQYPyQGRp
	 yfXE7hgj42m7gyW2WYnlT2xTkh5Aaf5OtP/Rw/z+v0siXVmbMEqzZZgWBNmvIyr/6b
	 vNgW2oLom9bxYOxalPhxtTww8a2hRon601Ayg6xztBKU+3ZuEMcmWreTAuAD1V48tH
	 okqVpNO322CnOrocwqNEMdkoVXjCEe2L+fZwCsgx5uhyPXvHjDpfBpqLOk+IMGJ10P
	 breWPANzJ88cmh2IPPC2WMLiVdI+vfVQkNvHyQ35JG9h/uGWoxSy9TG1tZ0wXApNGp
	 7QC1AF+86V3vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAB7F60B8A;
	Fri,  4 Sep 2026 20:52:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F12A1136A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEC3840B8E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0HCDOMzADGfd for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 20:52:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 444D840B80
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788555125;
 b=HzTJ5UnksOHhGIsoR93qtrZ39QnzqF2F+Imm4Vi6bkggtT1CFn0nWUBmPL4BuPWiihE1
 k7cYLNeH+ebxJLq5jKZecNbDnXlX8iXdXqDANqelN4yno0qGpSJQQ4KVLxlLhmd1N1SLx
 qLYeDuqje+UbtToNUGWHl6uVxQfDi5hS0C/2QEYm4P7quQlwJN9h9V0Oysgxn8Pf9RkMA
 Zs7QKJkWEa2fqf3G/KSFCnOUvFtDJNUJu4WrovQ6660eg89qLq/7tSTJPNGGvSwI4bolB
 qyNgHwTX/tb2Gx9V2yYrs2Anz1o6KHjNUYuIjD10n4mBDtEJvaLuBjV/aXLb9GTrgEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788555125;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=6GQcHgR85XdlVHpXTOOmvcdOAAPtunBQvPqpohTbcTc=;
 b=F/F55yaZg9S3E+dsQf4LSk00oHMIWACXUpbRuQeFGao4yDw45xkqcfe2sHCsj3lL6KNK
 DjVTOmakNLLFMKzfyzpgP59omg+cUEAxDcjUo18X9ALAgklOXr8uib3tg6zt9scEIVJ8b
 2GTmIJgaBrkdzAcSwRIhORsNNnQyuAh6HeyMhNtJDArsBVnL0TZob3CRwGF9Uo9bGWvwU
 FSTZuXqzbKPgWyMHeAbF4qzUldzreGV/vBv3OfS5/UT3wNHhdBv3GDbrn5zwVpXRKabip
 OYnXJMNT/Vfjf8DOzXxsiztCySyu8Ic/hcCmhmC4FfvzXuQi+0IF+u3fR8A1X0Y80Jw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="fU9si/dV"; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fU9si/dV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 444D840B80
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 20:52:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 667AF60209;
 Fri,  4 Sep 2026 20:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEBD1F00A3D;
 Fri,  4 Sep 2026 20:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788555123;
 bh=6GQcHgR85XdlVHpXTOOmvcdOAAPtunBQvPqpohTbcTc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fU9si/dVdej8WMy/sABljKGhehyDdd9jeXzw0BEoItdKMY40wA8R3QfCR0rpmxnNO
 uCRlf4b906O3gHpjUSoBTYXzN7wZ9rd8R4lOx2klnL8ckPdNg9fWELfRvnbcLXrqpp
 DKpzolsh8zZU/BtjLaA8eDKg+/JQmjv6YoyBADtOzrzYBJD3jzSn4z2cvgBcVO2YeU
 vEUe71vc6wrdAdFGhTiI0CqYGvtKY5PSGcWErOhnYwzWWEk7gn2pLMNsoz8RIupKQE
 P2slcOJmv6KoR6YLOhdzYU6ny5/5Q2YudCCd50u0OaPcGewBk0p0gz2iK+qjKcuBXI
 W+ZLYoloFauiA==
Date: Fri, 4 Sep 2026 20:52:00 +0000
From: Yixun Lan <dlan@kernel.org>
To: Tim Ouyang <tim609@andestech.com>
Cc: u-boot@lists.u-boot-project.org, spacemit@lists.linux.dev,
 u-boot-spacemit@groups.io, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@flipper.net>, oyst.lnx@gmail.com
Subject: Re: [PATCH 6/8] clk: spacemit: k3: reduce clock tree for SPL build
Message-ID: <20260904205200-GKB53903@kernel.org>
References: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
 <20260825-01-k3-clock-reset-support-v1-6-c430253e759c@kernel.org>
 <shthcaz5wjcp2vwd2c2i74axiayf4zhlgsoq5fbswofld5poq4@znfx5b2yby2t>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <shthcaz5wjcp2vwd2c2i74axiayf4zhlgsoq5fbswofld5poq4@znfx5b2yby2t>
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

Hi Tim,

On 17:55 Wed 02 Sep     , Tim Ouyang wrote:
> On Tue, Aug 25, 2026 at 04:24:16AM +0000, Yixun Lan wrote:
> > Due to SPL image running in a memory space constraint SRAM environment,
> > so reduce the whole clock tree a bit to make it fit for final runtime
> > requirement, only a subset clock tree is registered, which includes UART,
> > SDHCI, I2C (TWSI), and their PLL/MPMU/APMU/APBC ancestors; while the
> > full clock tree is retained in non-SPL build.
> >
> > Where surviving SPL CCU definitions reference parent clocks outside
> > that subset tree, it will use "clock-dummy" as name of clock parent to
> > ensure the framework still successfully resolves the parent clock lookup.
> >
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> 
> [...]
> 
> >  /* APMU clocks start */
> > +#if IS_ENABLED(CONFIG_SPL_BUILD)
> > +static const char * const axi_clk_parents[] = {
> > +       "pll1_d8_307p2", "pll1_d6_409p6",
> > +};
> > +CCU_MUX_DIV_FC_DEFINE(CLK_APMU_AXICLK, axi_clk, axi_clk,
> > +                     axi_clk_parents, ARRAY_SIZE(axi_clk_parents),
> > +                     APMU_ACLK_CLK_CTRL, APMU_ACLK_CLK_CTRL, 1, 2,
> > +                     BIT(4), 0, 1, 0);
> > +#else
> >  static const char * const axi_clk_parents[] = {
> >         "pll1_d8_307p2", "pll1_d6_409p6",
> >  };
> 
> The SPL clock subset does not seem to include all the clocks described
> in the commit message. For example, the SDH0/1/2 clocks are excluded
> from the SPL build.
> 
> Is this intentional?

You right, but I will update the commit message instead of changing the code.

The lastest dts in u-boot next branch just synced with upstream kernel v7.2
 which doesn't include SDHCI support (need to wait for v7.3), also the SDHCI
for SPL support still needs some testing, so I will postpone it in later patches

-- 
Yixun Lan (dlan)
