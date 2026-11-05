Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC9606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FKykDf8s;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ZcNuHYwS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E4E54087C;
	Thu,  5 Nov 2026 17:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vOT3upQJtO_3; Thu,  5 Nov 2026 17:22:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E04E840875
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793899341;
	b=Z3etsUi0TSIsy5yofdPROR6dfVNs3PTdAmHKBzLM08cfj+AKy5DEbNyL1sZjzmWibB8j
	 /RY00eQB7sSFL1pCxvMiX5fs1CcZShfNlaLik1Hx/uZgEfpVdTKWpbnc73wCHj6aujTor
	 M72DganywRS8uD4HcVA+QafJZgYcQcud0PXgVrz0ZmkqyRc8A6uRS//0Hn6b4OwndwwEu
	 TmyIh8mbvydyJN3Tss/q3FsiXYSjVie0iwHbJ1zcRcqQ2JrA63ksN4AxLdITsPX1TJp0m
	 m/V4+MeXJHYQ+emT5uHbxcdR0W9AXRwMvvVpP8ARlH4LHfVuExutMWPI1C1dfnQOeGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793899341;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hgk/yhoJgu0tmuf00TvEORPPhrPRdvOylGshrprMRTg=;
	b=IgcIvs53ZGiHEtCDV41vC8+HEJvt2gLfb3FNPuUNdHtluOrRBM6YTNG3wQWjUIYZIhb3
	 RcixtvOAgcpkcIODzoMPxBccAS75xBHMjqpbCEf0J0Ikbx3fzb4KjzCBkpsAvbXh46zGv
	 u0iOyxSaFqLNiCD2kgh2Pkst1A6jzULe0croir/SIZWQqCTWdakkdwnR3Bo/f+dWD1jji
	 c5wtIF1xJt8Ti+s0p8j2hyAu2ZozIy9SSVdNV9e+oaIhIXgLz6CDNcb9K3AbvwEO4nHaG
	 K/Xrwp1AS7XVaRWAneInksAuoACRzb1TxP1Wiy0Qm66iYk5Ye97Sngs6zq4WTQ/ODsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=ZcNuHYwS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793899341;
	bh=hgk/yhoJgu0tmuf00TvEORPPhrPRdvOylGshrprMRTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FKykDf8sYQiEvBy1Bi1e813TAftFHIXrbRRsse+F7HGIZi7tvHUVkE3OMMDYvjj6c
	 5EE7r+gqKWNV+SbnWQTkLB5hgSi1DtTLI9xvsM5GtrAtqGYZugeeQRgIO5a37JmbSN
	 jXKe3UVAHt3R09h17cMUoA2F5tcKQYEA3vfcnd70J3amHLQ+MmZb2FkMTvIGOg9zdx
	 vkfahxn4XXLqfrmLRt1cNrqXhk/yKcVmIrPMJDgHyivy2xpq7A9Xde4QFwNQ1jg6Kk
	 qXJfQKawJOm2q+RGiqeltJQ7ZjDkqhGHgKTCp46CQYdu+wNVU/ndQHM5b/7RtUO0Ri
	 VUd7Sup+Tlpog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E04E840875;
	Thu,  5 Nov 2026 17:22:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00D9137B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E634C40875
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PCSSMp6qyUGn for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F1A7C40870
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=ZcNuHYwS
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1A7C40870
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793899314;
 bh=hgk/yhoJgu0tmuf00TvEORPPhrPRdvOylGshrprMRTg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZcNuHYwSj0pRMcZJOrkW9qk1w943T8iCsVZCd6fc/EDBcbLGkkP02vHR5LihR9cst
 ZtfB8RlqaFW6c3TsK8yVTXTBq3oZiNhCbOgC4RIIJA9aSjVowO2Pxg9cZn1nU4sWy7
 WVwsuIJgIv9dY1GgyVVaoO6071uFMErib+nXzB1x9mOcpBrdw80hyMjwtotP1iIodM
 I3D+8dSsz+GjUUmqCg+LqkVtal0CPkV6YKgU13EJAxtvSRxpXBOQ47DqC4yH3BPZl/
 cVnCWH7pxtoIxUIIr4AO1PGxPKP/cGYzPxXLQfKjkXlHqdyXBT9n3TUC/LsDJ9fRvi
 VRJ6POV+aCeUA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 29905B221B6D;
 Thu,  5 Nov 2026 18:21:52 +0100 (CET)
Message-ID: <5c0a33af-44ed-4074-9911-51d20455da1e@freeshell.de>
Date: Thu, 5 Nov 2026 09:21:45 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: spl: Add BOOT_DEVICE_UFS
To: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>
References: <20261009215008.2796804-1-urvashi.sharma@oss.qualcomm.com>
 <ab9ae53b-1939-4a68-8af0-b7b17709bded@freeshell.de>
 <CAJM1RwOUkgmJWN5aSnbbjtUKoGEb=CPUPU2hw8RAD0=k5-q=3w@mail.gmail.com>
 <20261105171427.1438009-1-urvashi.sharma@oss.qualcomm.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261105171427.1438009-1-urvashi.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Urvashi,

On 11/5/26 09:14, Urvashi Sharma wrote:
> Hi E,
> 
> Gentle reminder on this patch. Please let me know your thoughts on my
> earlier reply when you get a chance.
> 
> Thanks,
> Urvashi

I think it's fine to describe BOOT_DEVICE_NONE with a comment

BOOT_DEVICE_NONE /* sentinel */

...with the meaning that it will always be the last item when more enums
are added, although I would want to hear from more experienced
programmers about this.

notably there's no BOOT_DEVICE_UART, no BOOT_DEVICE_FASTBOOT... I am not
confident to know if this is correct or not to have BOOT_DEVICE_NONE as
the sentinel without being assigned an explicit value.

-E
