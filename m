Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D13C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 13:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0729460842;
	Wed, 23 Sep 2026 13:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FwWczHPzi_EQ; Wed, 23 Sep 2026 13:23:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E3A2C607F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790169827;
	b=TpHfoedQ8pGrGprsHLXbMqZw6RKybedCLaW3+TN19sil/gxN7pEpGUmh/E6+LB2/EzIb
	 jPARwnxf4USVB4KIE7UKteqFDjax7H71Lb4/bqpu83nHcWYahdt9Na0L5/NQwEGZH6RMl
	 FDezIzewoDukll79b43jDz6pxwMgOCWYvWga/lBlGPl8sCLyrTD8e6IKb8eb3LowG+gbs
	 /ySh+0KkfxOIFyPkiQR95RL3nWmnbyrM+9ZT4dxcGXic39oQTeR0bwox/4EsBb2cDJRl8
	 SiQvQcfo8ESvRdsK4TODZZlxzD2OTl47UFl6Jv1KpxVHnx3sBbet5ZtShpzpafTdXyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790169827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=onyXDLGM/CCuElI4DgoxVELnpiCqeWY1U9SE4BlL8aA=;
	b=o9h3eNP8lcETaA6CiJP77kBSTFCpwl5shh+T4mnj4RehbKXNiCLFSaBSkpLo84yjKZQ5
	 R9onnfdXHv/lFz1AbWigaYBFmgeG2c76BtMKJzMtcb96Domco2FoGBfSdeXyW2oXbkhTV
	 SBTH47CjcFZr17+NJROlWgDao9hOt4zxaMFnMkSqp4iphublAnADbHZVEJrKx+3YopP8f
	 snUJjJQbewEcALtpZ2FQq5txcxo+6IgVCkDS5kpN3rc7ArcM160NVPY6Cg/9vKho9MA2z
	 +uMYhoYGKgoUnyC3fBa5ZGZQaMHiwtitbobWQlJmzl7eQAmeJL5fpRqDJ+LBk9Jl5QQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790169827;
	bh=onyXDLGM/CCuElI4DgoxVELnpiCqeWY1U9SE4BlL8aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iC2QqAUpXtNIGLnikl/qczZ6xSomiNTJTfm01nLqEV5sTHhg0kJFipoA/sSmL5WHQ
	 Pygj4y5VswVu+zTxJf2qhvpyyuMsKKy5v8a7NUXYGyCzyu7FPKzSgo2Twp7Q6FcBMg
	 zFosEhXptevvepywVjBocnQVOhhRu1JyAWCrkxPYrlzjQootFNmLKynqmbJpn5Rtpo
	 uyhfM1WTzOaAMadKtuQOwdZzuDdIHDQ5HH6J8NTf8KnmysFwKDICIHYJAX9acl1Rd7
	 CFVca8VDc1OWHl+zZjH+9myOIn1mlBJfzioToY3UP5n+e9rEKfps+RfKjPbVJhFT2o
	 UcShHhazCgZBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3A2C607F5;
	Wed, 23 Sep 2026 13:23:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E90B3334
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF6D64035D
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uG36NevSMSeE for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:23:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1B39A40076
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790169824;
 b=rv/i6bNxh7EgEfSaYqFRpfDXdJdds6Hq3dSnummBSTxOgAnZBI1EAiiJUyRg4gH/CaAf
 JXSenZx8eXpozL9aCczsNYzos1iSaQSkiqI2+7fHdXIQZq9ixUnMZzvIQA2v930Bt1B8D
 eOXzuUF5gl/pAL+DbHmR/oVWW5vJ+JOCpbvIhyJD4nHqCUM0rIR6VtLWYV9wpFayoc+nv
 8RXFjlYb231KWnMJSbV2+nPrE/RhKhh6PKuZfGv/+tHi9OP584kxxAOLmJflag7c8cqjE
 DADIzWnP4tNpphsIeH+m+zFnUWg+kR+GFNWWc4xqYCweDP+MXurTjF2atuXWpPadcbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790169824;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=onyXDLGM/CCuElI4DgoxVELnpiCqeWY1U9SE4BlL8aA=;
 b=Aqvp1Xqmr23+6rFja60gSQldnsq5myltz23Va/nXq0R07edRN3VTRQKC3T8xt59ofkaR
 xO2rrfhg8K018C1Nb6vswWON3Ltc0KjKTLpBjbkdW+pNhqjpcRhp2FszMT/g+rysccv9e
 GLZqhi+EoX7j6ZBkQyvj4eLz4jYbQVi9WIWXwVVZAyCJP2bFFK2Ma16n42c4Ps2uE0Qny
 UZZhVO+AbSumHQcG4ubnMJ+fkTvnOh/V36pDaEZAxKwHLgC/Sm+hzIJGaja7DAn5GoyM9
 6iz0uvVzf/Sq5dmvExCo/i6BrCZ17dPlSJO6QNw/z6OXuGvGtY8IK/e7pVr2mRVN3ng==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="SFIU7xz/"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SFIU7xz/
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B39A40076
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:23:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 76B05400DD;
 Wed, 23 Sep 2026 13:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBEF1F000FF;
 Wed, 23 Sep 2026 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790169822;
 bh=onyXDLGM/CCuElI4DgoxVELnpiCqeWY1U9SE4BlL8aA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SFIU7xz/bVGmgCpF/h3sONp7/ln0T7ab1NuR96Q7kgKDFeKzf9F9TOxZtsmpmb8mB
 FEbBCUvy3FRMY92GX8Cjf/0/vEsmTEhDhwfuYT7i5tt/MUDOez6VwxYXu2MkSqbnOu
 rMBFYMTZUnMMOTPkiVAk3SQ6nTD9rrAkcPGX0GE9WKDJYU/G0Lv1wCuhTVZhivqxpr
 U8Z2sKK/P6+KFezaCm4RIPpHws8tLVHhLuf/gIlkveMPx+4WU88rpiA1lKsvJ5gHko
 kTcA9CGGOIEmnHsGqzaAkQjuOQ6cocRzJ1p6S/fB5w2FvFKGIiJ8ngoqqZOrBPBT6F
 +1pytC+viPZOw==
Date: Wed, 23 Sep 2026 13:23:39 +0000
From: Yixun Lan <dlan@kernel.org>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>,
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v13 2/7] mmc: k1: add sdhci platform driver
Message-ID: <20260923132339-GKE353745@kernel.org>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
 <20260912-m4-v13-2-71043b29630f@riscstar.com>
 <20260916124016-GKA292047@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916124016-GKA292047@kernel.org>
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

Hi Peng Fan, Jaehoon Chung,

On 12:40 Wed 16 Sep     , Yixun Lan wrote:
> Hi Peng Fan, Jaehoon Chung,
> 
> On 20:36 Sat 12 Sep     , Eric Chung wrote:
> > Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> > implements the necessary platform-specific operations for the SDHCI
> > controller, enabling MMC/SD card functionality on K1-based platforms.
> > 
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > 
> > ---
> > v13:
> > - Sync definition values from upstream mmc driver.
> > v9:
> > - Disable CMD18 (multiple-block read) for SD cards in SPL.
> > v6:
> > - Remove ".data = 0" in spacemit_sdhci_ids[].
> > v5:
> > - Remove MMC_CAP_CMD23 as the CMD23 support is now a separate series.
> > - Use tabs for macro definition alignment.
> > - Use read_poll_timeout().
> > - Set pinctrl state based on selected timing mode.
> > - Add the definition of SDHC_DLL_REG1_HS400_VAL.
> > - Remove the condition based on quirks.
> > v4:
> > - Add bulk release operations on reset and clock.
> > v3:
> > - Enable CMD23 in capability.
> > v2:
> > - Enable ADMA mode support.
> > - Use CMD23 for multi-block read/write.
> > - Move ASR/AIB register into pinctrl driver.
> > - Correct pinctrl state from "fast" to "uhs".
> > - Migrate tuning support from the spacemit linux driver.
> > ---
> >  drivers/mmc/Kconfig          |   7 +
> >  drivers/mmc/Makefile         |   1 +
> >  drivers/mmc/spacemit_sdhci.c | 684 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 692 insertions(+)
> > 
> 
> Ping mmc maintainer for this patch, would it be Ok if I take this patch via
> spacemit's custodian tree [1], if yes, then I'd like to grant an Acked-by
> 
> Or, if you guys prefer to take it with mmc tree, then I could handle the rest..
> 
> Btw, FYI, I've already pushed for CI testing which looks good [2]
> 
Ping again, otherwise I'd go ahead and proceed via spacemit custodian
tree

> Thank you
> 
> Link: https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.git [1]
> Link: https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1284 [2] 
> 

-- 
Yixun Lan (dlan)
