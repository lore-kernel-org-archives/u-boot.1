Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB670C79FA1
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 08:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7F0840B79;
	Fri, 11 Sep 2026 08:28:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z33JWeXTxylI; Fri, 11 Sep 2026 08:28:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 109D240B6F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789115295;
	b=CZxGLTDEF2q9KFrGNX/OUIShPCPfFP8+TYhhmqcZfZsE0etOORT69bGTCrrz+OwTUnGr
	 CRsg0SoHQhDsjf/OTGu1yCHIW44QjP1rpS00Qia/qKU3volNQScYzYwYZknizeuhnH/7h
	 7wasKlL4XOYjfDNPg0t0jlGmRWA/wZ19sMcxQ8Az/rsGxdfZYrUWciy5XRnRMA67x/EbI
	 tAC0d+Q8U+8MUjSQ548HR1/T/OmBdLUUAEvkSMr9k1IR8eJscQ37ecrdirBzvbCQOnP+U
	 /CZEGAKIEjieJc7Z2wCLHtrWNgkVJ93M5Y7Er1lJMNR5NxxMdUUy9xi5BLiqmbZS0Bg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789115295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Nj/0Ldrb4xdwjth9ZNlCH77gITItwDSGKTN39s8piNU=;
	b=UoMntIBH4S+GSkAq8GtdRWdq7+xgxbfr3otiS01boO8CGWEDsKUIsj9Y2Jiqglf1z03j
	 N24XW3hHC03ZBXW4huXtl6wlhWdXB7fjEudlsSPNzS+sLILtuMiNnFGY/H/DIAJBzPEzB
	 eyuMcG7DSRnGX2UkN1r9rGWrHs5TTk7nrAO7EQcmk4etHYlz7HU2IUjgaWuGIEeiMIoSc
	 s91fIEOpXmKM2EXe/qEuWE+PshaxfoQAn7qHT4t2XLFM4UwZdD+XR0oi0RyI6sTkgh0YA
	 m7GI5R7NxYUcwS2sM/gb77Uo5rw5Sy5ZrIbLFRqWAfiFM5WUNpndNFHLYhJcDsoRPSw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b="ppGr/tly";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789115295;
	bh=Nj/0Ldrb4xdwjth9ZNlCH77gITItwDSGKTN39s8piNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zP/lUkPIDBuokerRmEn/xFVp/baTGrq/vpbVpTjWtKs8lCv4qEHCJ3YJfmM8AV1rA
	 K5d1l8H2jLSgb0b9GfEAPS+YflD/S516rCzZ2wgSOhJ7MRhZMyELjJaj2BoRVzBEwv
	 eaBwyCRQBTnU33Wh5jxQfi4eBEUwlHMKDCII10JPx2G392e7iaqi0MXMB30agm7Qd6
	 PUGDMVUdn1kxgNcldYmEjvy0eHUIXqmyYVu+sqdx3OnNyBZTwChVaCeFVVkwXIhAmu
	 8CX05hHGv9Kn5zX/PjnrycX8SReyPWzjYRgaKyP/V1mnqyd4c8LfhwzMOFsNbVTPsP
	 TAItXvK7E30Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 109D240B6F;
	Fri, 11 Sep 2026 08:28:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C6B2493
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 08:28:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E21140B6F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 08:28:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id chJ6ZGFbjLf8 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 08:28:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0522940B30
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789115291;
 b=nf3SFadVHLzZV/smvD0lhtklKIZPzxyUvG5EP+CgZDY0T8COKFH7y9qDm4Yz5pjqX5jy
 FNORa+w9G4kXvn1JFf7yLirLI8BtvNGyZtE/sYYK8bNdo0Lo6PdfZpalNQOYRTvTLaPw9
 a4VjCGz/YmPMAAql80JsF/T06tEG+VeTsggY9E+FusrJ3p8DReFolIGz9u1kh1MtiofzK
 zlBExAlQRF2NKUgnOgD/Pn5ssRTUmUDWx60qntnLqDH4W/7AikCB19KgDiqNx3xgHSwSi
 5nkwKRU8Nx/kwWJFMoTKVyxFBzn4bgbkPxSCo4pdRMuY3Oeg09VKv1yN8HtxILzoI7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789115291;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=Nj/0Ldrb4xdwjth9ZNlCH77gITItwDSGKTN39s8piNU=;
 b=A8UmD9uEibbaZ4KMxC7bwkcqfQsU6C3hRJpgt9YWfR6+ToV8zJquwEWi8Es5kj3W1nu8
 5brTq9dOUJP055y7kYL4a29Fnmsd4rrN8iTK0v5l25zzRdgzB8g3RatBhCHyB7Mp4A5EY
 rh5zVEdETu4yna1Ehvtrs90f7gLjlM6Oy+zX6UU3cQzmwpl2cKlsTat2J4KPLVReqGQK+
 x8B5+hIxc1UsVLD6iPF/LDrqEh1jFLVbGrsi4HvUzNrtqT38NiHdFr3Xzk81GLQAVsYD2
 E6y3OypiLs+T7oteCv1XlJZ2qYzplBCaCKRYXRsKTyeZAYU0GBdkWajwoU9rP14Pc8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="ppGr/tly"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=ppGr/tly
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0522940B30
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 08:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789115277; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NKyD+Ez/JtE563tOvwlzuzFXHwgSle0rb9JIOhntuIZhRku8OoxVdGoUjxHMobkMNL9BdvRnZ0bqCVwVKWTbiDL2VkeVUy2ySb92TVISmhq5zgNZVJEGIdbAD9ojjZ3J+SvkS6NNRByGkY8O+AvqWiz4FdCgP5VferJxq7fpYQE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789115277;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Nj/0Ldrb4xdwjth9ZNlCH77gITItwDSGKTN39s8piNU=; 
 b=beFvNv3pAgJVpBRTliZ7AOXAWzIJ/CDj5eb1HCPWcvypFsgT0rIIo6Y19uuhQeM/zIiHqnZ2MZpkpqiLXEg6OdZ5HA3lD6C6TlsWJj6F4TRWeSRkySxPlEBx6EmiU6E7EuIgiZRE7CXoPo1eBPkSindIpyokwLlozdBE1GUvIN4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789115277; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=Nj/0Ldrb4xdwjth9ZNlCH77gITItwDSGKTN39s8piNU=;
 b=ppGr/tlyY4y2Mqnl7sWjtqWbFRqbrDsgvcI1giaqHIPE1+i2b5SIcQef8/xJsSzx
 SppsUIGy1tUCCa8AeG5KcBt88Xrm7zGCgLa9Uowba8Dw02LYLF6+XJLLbmzee9bhElt
 BHlSq0wl3UK2m6mn3NPJ6ieymAXGq1GFKRVj8f7M=
Received: by mx.zohomail.com with SMTPS id 1789115274118487.52625488461;
 Fri, 11 Sep 2026 01:27:54 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:27:43 +0000
From: Yao Zi <me@ziyao.cc>
To: Nikita Shubin <nikita.shubin@maquefel.me>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v4 2/2] riscv: =?utf-8?Q?timer?=
 =?utf-8?Q?=3A_Enable_early_timer_for_M=E2=80=91mode?=
Message-ID: <aqO7f1ON6WhT-EPH@pie>
References: <20260911-riscv_fix_early_timer_mmode-v4-0-87a7b5abf958@maquefel.me>
 <20260911-riscv_fix_early_timer_mmode-v4-2-87a7b5abf958@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-riscv_fix_early_timer_mmode-v4-2-87a7b5abf958@maquefel.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.97.79
X-ZohoMailClient: External
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

On Fri, Sep 11, 2026 at 10:14:06AM +0300, Nikita Shubin wrote:
> The generic RISC-V timer driver currently defines
> timer_early_get_count() only when CONFIG_IS_ENABLED(RISCV_SMODE),
> even though reading the TIME CSR is not inherently limited
> to S‑mode; it works in M‑mode as well when the CSR is implemented
> in hardware (e.g., with the Zicntr extension).
> 
> Moreover, timer_early_get_rate() is missing entirely for M‑mode,
> causing early timer functions to be unavailable on such systems.
> 
> Fix this by:
> - Moving timer_early_get_count() out of the RISCV_SMODE guard
>   so it is always available when CONFIG_TIMER_EARLY is set.
> - Adding M‑mode support to timer_early_get_rate(), returning
>   RISCV_MMODE_TIMER_FREQ when running in M‑mode
>   and RISCV_SMODE_TIMER_FREQ in S‑mode.
> 
> This is also necessary because several functions
> (e.g., net_random_ethaddr() via get_ticks()) rely on
> timer_early_get_count() even if CONFIG_TIMER_EARLY is not
> enabled.

Is this description correct? net_random_ethaddr() does invoke
get_ticks(), but the latter only delegates the work to
timer_early_get_count() when CONFIG_TIMER_EARLY is enabled and gd->timer
hasn't been initialized,

	uint64_t notrace get_ticks(void)
	{
		u64 count;
		int ret;

		if (!gd->timer) {
			int ret;

			if (IS_ENABLED(CONFIG_TIMER_EARLY))
				return timer_early_get_count();
	...


> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Otherwise this patch looks good to me.

Best regards,
Yao Zi
