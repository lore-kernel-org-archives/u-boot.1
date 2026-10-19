Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CDDCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D61980F19;
	Mon, 19 Oct 2026 11:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EnGrdbho5GFa; Mon, 19 Oct 2026 11:28:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76B2080F21
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792409293;
	b=ZlsWLmjvtvw2HApPrc09n9nUWQOn6OqENMz3cPhakMFduSlSrrpPpKXo99GJsMripkUn
	 na51rCapQcee7avdIilFcltHtKLXbfHE7Al+IhfRrcYqWKkFPxowfPQYcQ0djBk5msOyJ
	 wtY++oiQaxP+e2KSoWRZnY8vGC9sls1NDTfz96+llJT/w9lpcAfxgQVOJYBmUdL/P5nXx
	 SmaDxNXe3LwmVwerJ6R3WOXjmizhDfCTk9HshxGXtJvJBEwdcBWL6QwaJ//NpVKA8Dll6
	 aSMdXLWUINvkYNiNmwdxTKzXH1/0SqplK1v0+LpCG7H34QFdW3GH/tG5DRduJDSSODg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792409293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Content-Language:From:Autocrypt:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HdOVFOx3qfNTGI5BPMhMsFLf8fMtob3MtI9pOMh163Q=;
	b=UiOkq6+Oo0OEV+AFDnqsKyydcvQQLi59ERsMexsIEjK9xBJZ/MM/EwIYis03T/O5wRqJ
	 ciY5dt9HczAxsJfHybITdcBtiNh9ttnRGwyyc3V8usHDhheILr+o7tflIFzlQjOgUkBeX
	 50O0Zj66vuyi9uqtq44mdWekIPnfTbjb1hpl9Q4fbPQorEcxiB4Ve9DC+Aje8p8aBBFTc
	 SkP5+e+RcEl0JUKNsTKXQ/qy4p98whAwuipa1GQQAAEfIEu9HAtwa4CabaBP9sV6u9Bm8
	 lQ+O80mvxPcsEwFn1MdHLU41WAFLocYtfPf/r33Q2oVoLm4Mwkzh5Z1B5ohQOqFoztQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792409293;
	bh=HdOVFOx3qfNTGI5BPMhMsFLf8fMtob3MtI9pOMh163Q=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jbnNRGTSs7nKjJterEp7sy68FJ7J+NtcqeqD6cKBHjttKosV8YzeykJ5FgZKBacrr
	 QJYSPe7zpWcnRhd3XJzRhIw+TYnAFMmwki3iFeXKFq9VQ6Yy8bMO+R2K4soEie42jh
	 35R5/xeju3CdaBsVZn1AL8HlStx1BeqGPW0dzxolxF0Zu/w6Vg9m31nZcqUwb9Df6x
	 cugzUcTaINGtOWqvM3cqKIAm1M4QXnP8GEIYEE6OCV4ptRkxN8HvRlGB8FyxLlb5l6
	 fHskVDvWtu2cSs42b9Ay3LWN28yYcunIcvY3/tDi90YCmpDsXN2s9+7P7KP5yzuZ4G
	 9IxXsVMGDPOgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76B2080F21;
	Mon, 19 Oct 2026 11:28:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9D6F263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F5EF40080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:28:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FjXUkoCcBjjP for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:28:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C28F240079
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792409292;
 b=ryz0JCbaisKtc5OmCl15RuRbUELjt6MdrTGzreprNOxBHeKoLdlp2N67UzGlv55NdzqI
 GKK5EA45tIvFSCBlPpxZpKCDx5o3NeV70Bt4Okz48BfkDH0/OLOzK5uaPllHymNHs7Cl7
 eO4Kyi47SqR2HAxm1scM84R2ZlMWnvuFt4YJxGxohknZ8CvNf9s4UlEjXih67ogPfqEau
 +dz+e9NXzWJRy/g9NxF46/3s5C3obGH1lbongAr3+oQdU6IFX/bX8VC6/cXmiu0ohXEt9
 xfqHiioUVmlSkVyyDjSz3LadEA6jwQbyoBTG5+wBQwRk9nHM/Lt57XfYHtgF4LqUhyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792409292;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:To:Content-Language:From:Autocrypt:
 Subject:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
 X-Spam-Flag:UI-OutboundReport;
 bh=HdOVFOx3qfNTGI5BPMhMsFLf8fMtob3MtI9pOMh163Q=;
 b=Vizu9mpiE7ybTR44+Bl3qC7bk1QTJGG1dwFP6f4VftJyEJW+WupmsZ3QNiJGzMVBwsNq
 ypX2wTzk35UKJb2aC08dUexU/P+tfkPI2NvMn26zGi56ljnT0QUKFNb8dRSeUbBxBz62P
 c/kzuQr1GrkY0qVW1v1leB5DUZ15vRiL5uUw8eYPukbkCxP5aXFq6B148GP2Lu0whHrwt
 Ey4A+qteymvbqfx1Ag8SXa7I1oyxTsNeaWHRbMPR+cYueJQcwtsFvQaki7fnlSLu06Hzr
 c7Unn0dx0r46GTCfcrRkxooO5CpobdA4Luotz7b3uAdZjm6csWFsKLvtg3oiSmctqtg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b="Keo6G6a/"; 
 arc=none smtp.remote-ip=212.227.17.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=fiona.klute@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=Keo6G6a/
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C28F240079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792409285; x=1793014085; i=fiona.klute@gmx.de;
 bh=HdOVFOx3qfNTGI5BPMhMsFLf8fMtob3MtI9pOMh163Q=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Keo6G6a/WVLHhZVaTXiqb4lg2Z4dKiAYfenjlEFOuQtaz7t7ri4or6q4ZAHsL9I7
 HKwo+oaqAum0aUAcOb9m7i7g4Dxs0zSZ6XddsgJmnXCxV/UgZeb8PqESpvRv7IDdO
 k6jUtEU9N/8uiEtomQjbcgJvKiKJMyi6y4HXsQodYeXneIwCcR/Pc29lBElp1NRiA
 wgWXbynCtnE/JByvEzWBRiqdNYmwS9vBGxsMSQvMKPbNFRyL+7R1+5xwBTXPdSy80
 9ppdnPno/oFPz2vPngPgH9OK93Ir/fU4jd3XlNN8nyRkWgk3Dae4rkJNvcDPuUJ3G
 UZK6zHnqSXGkj8QOgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1wlcZp1bb6-00Zf4d; Mon, 19
 Oct 2026 13:28:05 +0200
Message-ID: <f23265e6-5dff-414e-94ec-ab7312a0e1dd@gmx.de>
Date: Mon, 19 Oct 2026 13:28:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
Subject: Security: "Permit write access only to listed variables" restricts
 only environment loading
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:st5MHOLQpAaxydy2QjAOFt3TRVcmfQ3vqYgee1TInhOMO3EgD4J
 /nSlDdJ903uHWuqFqrJSbiCqxLScAc+NwJ/A3nK9wijTn+0Vzztkj+8WXJ1ioDZ9rvD+Sfb
 UklDPn9suIC0wcdNDDvFn50nplkfusZ4/2V7kta0iRpc7WdeFOOndsAa2vcno9nxO0tTdRN
 YQjQK3CFDXCe9yBmDHbDA==
UI-OutboundReport: notjunk:1;M01:P0:DAfoUplI6lE=;uuAAzkAYXOdFJKZIZoDceOAfBO2
 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
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

Hi everyone!

The kconfig description of CONFIG_ENV_WRITEABLE_LIST says:

> If defined, only environment variables which explicitly set the 'w'
> writeable flag can be written and modified at runtime. No variables
> can be otherwise created, written or imported into the environment.

This does not match actual behavior, "env set" and "env import" can=20
modify variables as usual. The only thing that is blocked is loading=20
variables without the "writable" flag from stored environment on boot=20
(and "env load" based on what I see in the code, but I didn't test it).

As far as I can see, the issue has existed since the option was added in=
=20
commit d045cbacf2529266bb312add023e12c0d400bf67 ("env: Add support for=20
explicit write access list"), where the commit message explicitly states
"env import" and "env set" would be blocked.

I consider this a security issue because preventing modifications that=20
would circumvent security measures seems to be the whole point of=20
CONFIG_ENV_WRITEABLE_LIST, and it only does a small part of what it's=20
documented as doing. For my current setup restricting what can be=20
changed in stored environment is enough, so I don't have a strong=20
opinion on whether description or code need to be fixed.

Best regards,
Fiona

