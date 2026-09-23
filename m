Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DEFC982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 08:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 430A340698;
	Wed, 23 Sep 2026 08:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eh-r2alcV6x4; Wed, 23 Sep 2026 08:46:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 922BE406A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790153208;
	b=lIHjd9ldiL5fFjwGLoZr3Uczj9LrkRm6m6kudR7gyOhousNA9ZKRxttugfuQo0ellc4V
	 OiPNg+rqj0mjzM5YnNkkc+qgcSgRtTf1ywkEAjyhKSydRNVUggYGQ9RnWpT+Yvtpz6DC9
	 cHwkN28KIpyAVfg7m+TouzVXQNKqUCxG/e2jbCmSdCGh4OsPc0FKf6hjBw48oKYkvnP6f
	 12TLeOwy0r56sKzf2KEk3W+PEZZiUvhlK+QMOqa0GH1/HLQ/MQdWyBFXzy+9wWGzvNB2+
	 tEaX9/ZFdAAJ6KP0QewD17LqJDBdW80DdlkLemNWLvfShuFHGPF46QfzPLkd0nOFW9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790153208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7u9bl1K8HraDMAZQ76QLtPPRDYpI1alO0DRshqlBAaQ=;
	b=rB7mWZRhIhMJ5zqezuTjDwGu+uIwvS6ALrio/ry2xt9Z1s6Z83OlHx6iCUu8rdVMM66G
	 BjAJ/+8EDnnmJZDZZGH8uwrGHB3aNxFeIqN1JIzwiYSDK3Z10Mvj4u59+/ciMlQkdWzLI
	 KrVF/1kU43k7JRvgDobO/JExeoN4RiUnsm6WFQwD9F+lSWHeBYlJ4k6enYlybbvZv2WHp
	 488LP163jY1dmYbNvD60DbgQt2yFH6quBxN3Ub0b3p3rPyeUVv+b4NwOdIgGXTXUwZbKp
	 ayjVWKwbctLMPHVLtzPDnCUcS8lmVnJGpn+UmHSEsPIAEGaoxT2S1Qw7dPRTjzbN2WA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxvFdCXK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790153208;
	bh=7u9bl1K8HraDMAZQ76QLtPPRDYpI1alO0DRshqlBAaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wk7bIIUcI2AFppmzvSQCs9y9Bc+s41DueBnt0RbGDwMVVvykDCP0YPkYHqH62+zSA
	 gvYGL3AIUZHYNNZAxVE9+W4gSJt0RrS4HFdiXJAKdgMil7lU+cOpjYTWO3/BYNr6rp
	 dDYe7ZMxy7BpSOVCWQO+9uqLPuqAZ6bR9pGgp1OKosmT09Sh+6jytLSxcdabtzuMPL
	 Xu9fKSncUPotCyMO+VfKDBUYrF7nKHgX5PV1Hljzfd6IyYipG3zFo0EcdlgLBgkEbm
	 RvP91Rty5DfZgIoWzjfsBFoCEEIMlDbdmseF/QHEMvICsR/CY6WOk1xNT+2Ir2fFZE
	 yBnATxiAHa1Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 922BE406A1;
	Wed, 23 Sep 2026 08:46:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 672EC12C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58DB5406A1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QdQkiYajC4S for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 08:46:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5704A40698
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790153206;
 b=B8lL5EUL3eXV75cfUjAXz1zkkFGJQEnY+OF3R/s1S8mkWufQxFEdx0bAoqD9NJhpPceF
 +Z6k6Z+DGFSp7xqNVgtGoTqJkC7mI/zpd2lmwf6Q9eKZlmGJU5s2b2BhVCElgTjLG284O
 b24dcEFbp1W14FzS2O7FR9FKo65HYxwst8TNveXlH43YYlfpXpRoh8PXpby/inPQM6lsG
 6GOY1FnylsLnPCSnI7GpvGaDO9qNUi5D5M53gk01vzmKvD2Nz20vwCY4TsMGHyq2DCL2K
 CcAcggZcK4ZE9krj2eUu2WUfLbKEck0RDYAD/T8FJil2TYjhIn9O+3kK9/yku/2o8yA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790153206;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=7u9bl1K8HraDMAZQ76QLtPPRDYpI1alO0DRshqlBAaQ=;
 b=Aib+dpOw57GC8ZU611gUVQGIppX2Ap3YIBwTlCCe8VB7vJYZFcgvxSC+uHc7CkDdiaz8
 WglhhQZeFOPEiP35+qWVAE1pxa8eepW/6U1Hato5pMN5XUe30rA17e3XXcnsWqV8RRHeX
 vVmwOTaxZ8QfGZwrHOktQZt2w6OlO/lNIDKR0PSEJw5f57uQx2rovsNxw74sJdp9SLYCF
 PB515/Zv6gYwZlxaRy6O6zHjaAhkM1y40R2/FN2oM/uD64gpMYzYo/ZWeqeTlpc3/npQg
 m0qHbtoE+2yY8OOZsTmTyMekCc9psrgS5MUqinCD2G+MKQuqo5YXM+dFNnULK8lupIA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RxvFdCXK; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RxvFdCXK
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5704A40698
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 08:46:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24BDE40AB2;
 Wed, 23 Sep 2026 08:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8195E1F000FF;
 Wed, 23 Sep 2026 08:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790153205;
 bh=7u9bl1K8HraDMAZQ76QLtPPRDYpI1alO0DRshqlBAaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RxvFdCXKk3Rg+prdh66Y/G1TsADz5Nc2wmRBFG9Aj+DdOUN6exouQLYrxMab5wrLa
 9ujEY14c7URYT57d2NJbtYn8JmzwXAlwRy/wpKp2vnnji1720omwbNeIOEvNAGNOjp
 sHLUMyGSeXWxFGv7TvBUT+m6BfBd1Gu8vNDSQoyWp/JfReYpAkTjltav/YjK8wH3eV
 6RIdnzy+UZCtNGyJbK+O2k21BYEIKDnPTL115RF5G8o9Tx+dNM67mkwVgvCsHo0W6Z
 O97SwbW6Xt81b44oZ7YR4eByYVxr7qlrqdhJCBPS7Ne/H7mW6Chto35VSP7AN9OaIa
 0Zkss3t3UaM3A==
Date: Wed, 23 Sep 2026 08:46:41 +0000
From: Yixun Lan <dlan@kernel.org>
To: Bo Gan <ganboing@gmail.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Eric Chung <eric.chung@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/2] pinctrl: spacemit: k3: add K3 pin support
Message-ID: <20260923084641-GKC353745@kernel.org>
References: <20260820-01-k3-pinctrl-support-v1-0-b54a2450c895@kernel.org>
 <20260820-01-k3-pinctrl-support-v1-2-b54a2450c895@kernel.org>
 <bca35d47-5cae-4f2b-a03c-f18e310e7361@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bca35d47-5cae-4f2b-a03c-f18e310e7361@gmail.com>
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

Hi Bo Gan,

On 14:55 Thu 27 Aug     , Bo Gan wrote:
> Hi Yixun,
> 
> On 8/20/26 06:01, Yixun Lan wrote:
> > Based on upstream Linux:
> >    7412311c4655 ("pinctrl: spacemit: k3: add initial pin support")
> >    3f20bdf71518 ("pinctrl: spacemit: k3: adjust drive strength and schmitter trigger")
> > 
> > K3 uses a different pin-to-register mapping than K1, so add a
> > K3-specific pin_to_reg path and pin/IO power-domain tables. Drive
> > strength expands to 4 bits with larger mA tables, and the shared
> > pinctrl data gains per-SoC drive_mask and drive-strength tables so
> > K1 and K3 can live in the same driver.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >   drivers/pinctrl/spacemit/Kconfig      |   4 +-
> >   drivers/pinctrl/spacemit/pinctrl-k1.c | 291 ++++++++++++++++++++++++++++++----
> >   2 files changed, 259 insertions(+), 36 deletions(-)
> > 
...
> > @@ -704,12 +700,239 @@ static const struct spacemit_pinctrl_data k1_pinctrl_data = {
> >   	.get_functions	= k1_get_functions,
> >   	.get_io_type	= k1_get_io_type,
> >   	.pin_to_io_pd_offset = spacemit_k1_pin_to_io_pd_offset,
> > +	.drive_mask	= PAD_DRIVE_K1,
> > +	.ds_1v8_tbl	= spacemit_ds_1v8_tbl,
> > +	.ds_1v8_tbl_num	= ARRAY_SIZE(spacemit_ds_1v8_tbl),
> > +	.ds_3v3_tbl	= spacemit_ds_3v3_tbl,
> > +	.ds_3v3_tbl_num	= ARRAY_SIZE(spacemit_ds_3v3_tbl),
> > +};
> > +
> 
> Can the following table be simplified using static function and switch
> cases? As your other series mentioned, the SPL has very strict size limit,
> so we'd better not define this huge data array.
> 
While actually looking into the implemenation, I end at giving up to
optimize it by using static function, it's much hard than I expected..
the io pin's information is per pin bias, and io voltage is dynamically
parsed from the DT property, which mean we actually need to allocate
each instance for all pins..

The optimization implenmation isn't critical, so I will leave it
unchanged for next version..

> > +static struct spacemit_pin_io k3_io_pins[] = {
> > +	{ 0, IO_TYPE_EXTERNAL, 0, },
> > +	{ 1, IO_TYPE_EXTERNAL, 0, },
> > +	{ 2, IO_TYPE_EXTERNAL, 0, },
> > +	{ 3, IO_TYPE_EXTERNAL, 0, },
> > +	{ 4, IO_TYPE_EXTERNAL, 0, },
> > +	{ 5, IO_TYPE_EXTERNAL, 0, },
....

-- 
Yixun Lan (dlan)
