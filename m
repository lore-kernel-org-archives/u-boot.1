Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01F8CA9EC5
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 00:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A98C080BE5;
	Tue, 13 Oct 2026 00:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SPphMxJVKA31; Tue, 13 Oct 2026 00:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6A3B80ABD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791850545;
	b=limDQnqz0AH+EWB7NH/TE3wsgwhzKB73aP+uT15lPT4yRyJBjfYleBsnslzTogbINpYp
	 owC6F2zTVWXQjG+PW9C+9GkpmpCK6V10JRf18tfqwVn79m5Y4/oGBceTu9NfvkkbF98pN
	 r5+XNmk01yddeQMBM4qnE36yC0Z/NKNN69kIq0NA5x9Jc1qdi+qUshPe80FjKcfvcmyLU
	 ULMHqP4hQ2vYJA1/R3RiCG+90TiPwxxoG3ShRb3dJDXITz/cQlJ3rdzv8E6gehi2Spcqh
	 QvcDq0Pcl17nyxa2AzJeqj2ThukptxCMF0DRW12p0oPVFqMvylDvjUYfuZhShpNJHIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791850545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XokeKmennbmb8XnznKNvsZKgWePyorL84YfehXSv+io=;
	b=jAonZBXSp4HNCcdYtBpNkqEmic/69DnsksYQEpujWrN0Zx9o7bW2+NE69fesCFhTBhtA
	 E/2CCZErcUrvSRyC+qSAjZ+aC7KxM3Ek5SUxFNZR1UMGgMpFxbKTChrxPt+rhEuFuciHF
	 asUsyBuMd4V7jlcDPcpL7eabvvM26luZc0Wcr6aSBTo/ykZAFGUA4yTRvanWCLqDu4lyq
	 +wO7sbfs3zrTnKZX14x1u4+lB/IuZCTn58TCuwY2iWTjzMkdE0tFExo2rD4Isic42RyJA
	 hsuTjYin2lBzkFkmkxhBT//7NF4U4q2e/BnYpxaaOuGdHb4fZZ2+OshKyxVQEjDMvmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791850545;
	bh=XokeKmennbmb8XnznKNvsZKgWePyorL84YfehXSv+io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eH65XDRj4YllBfAHJg7ZMZuEH2TdChEZ9zk7cSjYsQfJu7fJ3qKJu0hdn/XXUhhN+
	 8cOzo7N05W33akv2MywTr7tzUSHgyPvE2XaEGw5kM38S/PMaQ1wDoCernBcbrLpK47
	 NHvbE4HiV+fGcceepDOOVn1lHQHvoYVoVOQxYGoh+XwYU2ooXDdtPLxHDFhVqZlFkj
	 QZd4F37EZfA0RbLLIUz4AfkaVwnyJ1/yFmYYEAosXZTMRyNr2WRg7DMQm+K5zb+pZN
	 rY9wEEOzSAqHp59iWG8tax9UDGl6fZtUSnC55G17dEkNLMfxB8MBAmCciDTQksINaK
	 sf5V9a8r6p93g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6A3B80ABD;
	Tue, 13 Oct 2026 00:15:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 671EB1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CF73404FF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-7DbWikPJH1 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 00:15:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A5B7404F9
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791850543;
 b=QyU8Gna+x+zEBVV0waZWP5ePCAlXdFomQhwSo4XaC6Fhe2l1HrKRIwDn95Ti+poLShln
 acH+R9F7vxYVWtBcpBXjrLWznHG4TjubEGkGueGpg6JvbNTt+gGZgydGpja9iKAjSTEo0
 23g9tmyXopZX44E/USLn/Z30sOfhzPrziQY0l1SMBqoJunyT/dhqCxsz1e+fOAN0hf0fS
 2/hmNBPc3nmLgOU11is5ezDT3CY40Oj7L2WDUGMqPlygKTSDstl4nX5RGB65p0Hyz09XG
 drb/fLyxKSZS/5NKSgA2o5GtaXeQkv/PPUzEbVqqUTTmCJX45uNijugWzn9MqQD4rFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791850543;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=XokeKmennbmb8XnznKNvsZKgWePyorL84YfehXSv+io=;
 b=O37GE+fQvkI+RurGiTyaORueHkStYAQ6luRIgr+xRjyXMFShxM2p5TgJ+WM+APb0nfK8
 6dcxAI97xWFy/Jt4N84reGz4GOkCszdH8lh+6HSlbislTH/oiv+h+461A6chWpUniZWeF
 ppvLVaEVfYEkTzxmqcqq78n709hJ4YpTCq477GLpa8JxA4T8+JJSiYYVDuOBovlSWTSSU
 nO3kjdb92+zyuQrkwfhhcqenRUQLyb411eqZtduvsu1b7FuH1DmSp8CRZK0OP77AFtu3J
 AF3uDka5+JATiZP8lKDUT+1WgQOCy1fBHf/SYGozlS7Ca2osfy6W6w5FuQyU/1twm9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WLaw3zOP; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WLaw3zOP
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A5B7404F9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:15:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 629A1600D4;
 Tue, 13 Oct 2026 00:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843291F0089B;
 Tue, 13 Oct 2026 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791850541;
 bh=XokeKmennbmb8XnznKNvsZKgWePyorL84YfehXSv+io=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WLaw3zOPCYa+cF17Hi3QIa5HW5Ux0K/TcV6//gvtLHZzdswU9gUfCJ0+ApRxnpri0
 DGr0MTLR8eBWMLD+Ua8x3QuU37G9AjAMU414MEVfHANfGLIn3b2XajwH5Ogu/wj1CZ
 PF7LoS3Wp3FWBnFg12c3jF+a9oOzXJQBt11uq9CK+3zoyemCH3Sx4Uo8JGSBRyMlxw
 ONaO1q2y7qT8YB/uzUTH+gh1rFzrrMCA3dkrRWt4plAfcoNhZQqMZR6jVlMvdFFqEl
 50MXB8teuqHfDDTuh6S7GRm7QmEw7mzc0lyLAEVbQKQNTVEG8eCYORXgvXOc97ylDV
 RLmqrST8N4ANQ==
Date: Tue, 13 Oct 2026 00:15:38 +0000
From: Yixun Lan <dlan@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>,
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Message-ID: <20261013001538-GKL26088@kernel.org>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <CANAwSgSSbmQu0jzJQW1-4ZBSxUXnBD87svNa+fqyiEwF6JhYDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgSSbmQu0jzJQW1-4ZBSxUXnBD87svNa+fqyiEwF6JhYDg@mail.gmail.com>
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

Hi Anand Moon,

On 21:37 Mon 12 Oct     , Anand Moon wrote:
> Hi Zixian, Tanmay,
> 
> On Mon, 12 Oct 2026 at 18:49, Zixian Zeng <sycamoremoon376@gmail.com> wrote:
> >
...
> > On the pinctrl side I had already run the SPL with standalone
> > CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> > mmc1_uhs_cfg plus their pin groups. I confirmed that
> > pinctrl_select_state() return successfully. The multi-block read still
> > failed the same way with the rail at 1.8V.
> >
> > Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> > in pmic_init() may need to be modified.
> >
> > Thanks for your suggestions and guidance.
> >
> I have also made some changes related to SPL GPIO and pinctrl support.
> On the Banana Pi BPI-F3, the MMC controller uses the following
> regulator references,
> which are not currently configured in `k1-musepi-pro-u-boot.dtsi`:
> vmmc-supply = <&buck4>;
> vqmmc-supply = <&aldo1>;
> 
> To address this, I updated `k1-bananapi-f3-u-boot.dtsi` to include the
> required regulator
> configuration and make it available during SPL initialization.
> 
> Could you review these changes and assess whether they can be integrated
> into the mainline U-Boot code? I would also appreciate feedback on any
> changes needed
> to make the implementation suitable for upstream submission.
Hey, I'm confused, are you trying to prepare a patch here? I thought
it's Dave Klotz who would do this, let's not hijack this thread but
coordinate together, and please be patient, give Dave some time to
respond.. I think what Zexian done here is trying to investigate and
test the patches..

> [1] https://gist.github.com/moonlinux/2ae03be59f263b0797acb138bed226b5
> 
No, It's not a proper way for people to review and comment..

-- 
Yixun Lan (dlan)
