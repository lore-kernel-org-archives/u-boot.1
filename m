Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92FBCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F2C480DAE;
	Wed, 14 Oct 2026 14:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qZ8d5sYQ0dmi; Wed, 14 Oct 2026 14:08:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C376180E05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791986894;
	b=f4bSPqE9/pXEFDwlEqXtGK/CI4m5L11C9ZUds9KDoK2CM03BanjadBB41Q0eOCkhRk5P
	 1xBZWF8ai9W7Ozu+PgQ65qTMM7QYipaQGVvJYmUy9RLJHqh5GNs7S2fD7rK2dUFUFqhTP
	 iX3ytU3TkOL2QF0f1jISf0taSZ+szWel9RyujrpB+gvecg7jdcO8aWIXyhsdg67DZYYwH
	 ZiKav+ngWEnTs1J2E9PK+CFuBKQ+LFIB+lKkRz68k8+559Ar4tw2hju7ysozSRrHebe8E
	 0CevZ7yO2NVD8PrRANUe15YdxEuuSgm27VJgGdqF4sxHoGdCIivsIQnpaX6HuZEsaUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791986894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=N1JZn7xdIE6suZ2ZQrUsyHVy2PAMwWbLPAfmJRLQZE4=;
	b=bo1YW5TlK6hM9ghQcGkeLxPpyB6E4h83GknhhyPCKW3I+PBIdxn7Kr1yvY8a06Tf4t5O
	 y2Mqqd2VOg0OenGUIsRHSaezGmp790tt/YrgURe9DcXbsbZ3yYQN9eabuWrhi66Rfp181
	 c5T446ndlnnb1UgGfYvnQl7sfyVqcyl929CGUDwhUeXAr1vNz6jNQ+EkTgoEx2f5428bT
	 BsQx0D+fHWJhNm/6W3FvAaY/iATJparaRJVQUTTaLZmOk0SOJo78LDjIj2fgDC1RbXN9Z
	 0ceBIVv5r9har2J/o9ZuYH3GWeymI6SDR+guh7uYaDk3lbyhtgqe7eeRWmMnejLXXUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791986894;
	bh=N1JZn7xdIE6suZ2ZQrUsyHVy2PAMwWbLPAfmJRLQZE4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QVpExb2txrY20beK1xQ4kizcqssu5AOOBvDRJ0tTqM+12DLxCtGsVy2d7I02KxusH
	 QQyUa7+omL7worpnrxKmOxiaB4Ni+S3KDIBNuEgHklmwjX6KS3thHerqxl3ZrIg4mX
	 /zYv1M7saRuekoOfbRIjQ9LxWBbDIwdT7swu1C46DGi6XSnlY4cC9bISVuHZaEs/xl
	 a/xHzStjEyMDFxNsOdP0Ryfb+LBL1AzlvoSlTAI0VKGoMHNa+Ej/iF5I/MJQNvrDIP
	 m+YEsIupRc2UxzkRn1BPPkNNXGSDN+hj+l/kWM0/+q4HrDUGX3T2OTj5U2X9vaBDcx
	 Xi4xBawKT5GKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C376180E05;
	Wed, 14 Oct 2026 14:08:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DEF841BF9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4F95400F9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJNiIH7mEKGA for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:08:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 87162400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791986892;
 b=ERzBDd4JMWxabYf43KlJIkh3CQfttDwuR9AzGDd7vmn/opnD2DKlbGGFOnjWbXPUWPCj
 KJ6cCdI1QJe7e2bCc5+SrPYB741g0UidYhHZgM4ZcTczuBQQX49MZSgUJ9/Zl/qR9Bdvp
 P/YgyQGsIyAFAa6cp7qoYIO7YCUmaWd+eezLk8oSXk225uJoq6Rasv2dnj9JVJAJ5ndHy
 bOop2MyWvr+IeOx5AUL2KioEAhrnskYxs9kzYs1WXEawWknFLdRpTu0gIQFRvdFl83fYu
 mgD1U1ADGBV4fZSCoVddg9/3J3mC8PbTV5m54r2X5i5gAKZrba0gR2Gz8UdwVwFo8rA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791986892;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=N1JZn7xdIE6suZ2ZQrUsyHVy2PAMwWbLPAfmJRLQZE4=;
 b=VkvnC94aP7RMDYEJ3ZPvltLL4WoMRWnkTMp9Y0FtVKBHE5j+fX5uZJCASae9sks5t0G1
 xvRHGHG/2ebZZPQsKOJdaSvJkKl+p28XTRoKy3oE5ajD3YecD4jhiKCgIzMC78Eo1GBWb
 QmlpWY6yE4LGuzoKOlwmXV21qm3NftqPjrthKdGt2LpOVeK5jSjuBZOQ3th5AtfYoWS4E
 oR9seWn8R+8294q4tEVcUhQoGNc9GBLzF1iXSsX0/iGKbhuwmQBuW9l9vv2NyBVKK74vz
 NxXk5uOBfCOoyL4X+YDhwGXS6+zzniTy5KQnUYERZRffGpSdyUj7wjCMtjSya2KC1hw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=P+uIdgS+; 
 arc=none smtp.remote-ip=68.232.153.233
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 14 Oct 2026 14:08:11 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=P+uIdgS+
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87162400B4
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791986892; x=1823522892;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ovhDyfRPp+CchXOsvpZzh7UEhPoxAUz2kjVc0si28uk=;
 b=P+uIdgS+F3ekkPSjw+55N2sA1wGVZ4DTp2Qw73D+fE7zTsBZZhCdWzJc
 QEidSPp4b9h505bhBroR3GJ/21IXLKlGLpqsPnO89ja+dUK0gMUnK7Vyr
 2m0OCQA2XQD2/SpARg5+4FZECw+3e8vvg9MnfrSyndE9MnskY5XWtRGfE
 cbWlKhGwkzrdPnhIQHccgJrLQeCXLrHLiqD3vKk+YtcukQ1BaR8lzsu6B
 qEoNDMkw8nM91y5XNWEZV/fabGOHLuC8cJh8sppge+sI/8TWGTWs75DSK
 IekxTVjXrPzzxEcoleqZ2XPHjSXR65pPFvBnZnPpf5ANtcQzAi0hEijqq w==;
X-CSE-ConnectionGUID: 6t21Jyx+T7KBgP10TkzhhA==
X-CSE-MsgGUID: wAQLirFqQ4ez0EbRkQZB/g==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; d="scan'208";a="296447796"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:07:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 07:07:06 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:07:03 -0700
Date: Wed, 14 Oct 2026 10:07:01 -0400
From: Charles Perry <charles.perry@microchip.com>
To: Michal Simek <michal.simek@amd.com>
CC: Rahul Pathak <rahul.pathak@oss.qualcomm.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>, Paul Walmsley <pjw@kernel.org>, "Rahul
 Pathak" <rahul@summations.net>, Anup Patel <anup@brainfault.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, Romain Caritey <romain.caritey@microchip.com>, "Mame
 Maria Mbaye" <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Conor Dooley <conor@kernel.org>, Yao Zi <me@ziyao.cc>, Peng Fan
 <peng.fan@oss.nxp.com>, Charles Perry <charles.perry@microchip.com>, "Michal
 Simek" <monstr@monstr.eu>
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
Message-ID: <as-MhVGpQ9FA9LGf@MON-LT-C78453.mchp-main.com>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
 <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
 <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
 <a83ccf7e-87ee-4c78-80d9-86dc0b246491@amd.com>
 <442ea702-451e-435a-8b04-543750e929e6@canonical.com>
 <99875a68-fe25-4fd6-b02a-7bb71c24fe0a@amd.com>
 <CAFR3w36KKkJioAmZPeXBwDEErn9kPPv9FQ8QUY7EthY1+KxdGQ@mail.gmail.com>
 <cd00079f-7134-47dd-a41f-48218c5a867e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd00079f-7134-47dd-a41f-48218c5a867e@amd.com>
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

On Wed, Oct 14, 2026 at 02:15:19PM +0200, Michal Simek wrote:
> Hi,
> 
> On 10/14/26 10:12, Rahul Pathak wrote:
> > Hi Michal,
> > 
> > It is not correct to say that SCMI already exists and so RPMI is not
> > needed. If you read the RPMI specification you will find that the two
> > differ significantly. I don't mean overlapping names, but how things
> > are defined and implemented in the spec. Compare the transport,
> > compare the defined messages.
> > 
> > RPMI defines many service groups that have no counterpart in SCMI like
> > System MSI/System IRQ, TEE, RAS Agent, Management Mode, CPPC,
> > Logging, Request Forward and others. Together they cover use cases
> > ranging from typical systems to confidential computing and
> > virtualization, all in one specification.
> > 
> > There is also a difference in governance, which is visible from the
> > licences of the two specifications.
> > 
> > RPMI is under CC-BY 4 license which allows anyone to adapt it and share
> > modified versions with attribution, and changes are developed in
> > the open under RISC-V International. The development does not happen
> > behind closed door but rather any indivudial/organization can also take part in
> > the discussions.
> 
> I don't think license is an argument here because someone decided not to
> talk to ARM about it. Based on my information none really talked to ARM to
> change that license for SCMI (if that was an issue) or move it to neutral
> place.
> I have already talked to ARM about it.
> 
> > I think open source projects always give users/vendors freedom
> > to use any protocol which suits their platform. It must not be dictated
> > that everyone must stick to one interface.  As Heinrich pointed out that U-Boot
> > already supports alternatives for various things and
> > Linux and OpenSBI already support RPMI. Adding RPMI support to U-Boot
> > does not take anything away from SCMI.
> > 
> > Platforms that use SCMI can continue to do so, and platforms
> > built on RPMI get the support they need.
> > 
> > So RPMI is not another interface that does the same thing. It is a
> > broader specification, developed openly by the community that uses
> > it in which you and anyone can also take part.
> 
> It wasn't my cover letter which described
> "The goals and purpose of RPMI are similar to ARM's SCMI."

I can change that part a bit.

I do think it's good to mention SCMI at least once because it will give
some anchoring to readers new to RPMI.

Thanks,
Charles

> 
> I am just saying that it looks like that you are creating parallel firmware
> interface instead of extending/reusing existing one without really even
> trying to talk to other vendors. I would prefer if we can work together on
> one spec and extend it to cover both architectures.
> 
> When you have heterogeneous systems where you have mix of ARM and RISC-V
> cores make no sense to have SCMI and RPMI servers both running to serve the
> same purpose.
> 
> Thanks,
> Michal
> 
> 
> 
> 
> 
