Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE9FCA5FC5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FB3E8122D;
	Thu,  1 Oct 2026 01:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycsHELl6vmAH; Thu,  1 Oct 2026 01:30:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0F12A8121F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790818228;
	b=HmB/g/6NJgiPhyU3CPQp5yogiW7g5+UaZMTFf5QS2Zrjez4REtMwRD5rfql1aqFjsbXS
	 Ddp4xpLO8UbFTspFwvb/TUU/mLORuHrLafQh1nLcw+cVnqV1Lqsnf7n7SIM/fpUfMSZs/
	 jJ0qJ2eIttmlBPqRtCzzUtMyD9QHp1SWaqtp1BLmOnUjFpdiZXaE6mvS2e2pP4E9oduZp
	 t3Xzqx+1HL8qLv1XMfCjfcP/n5SFH0aB0hx1qsWr17Sup1KRYf57inxC5UVULewxOeRaP
	 CeE78o5Hjla7aRCZwCSdDZAroUWnz/wfdbyDbv+spwp/kSeYSwM9UqLcP6XanjN355Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790818228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oEJXfB/ZqaU1ai83GYLmYcDPU6ZIOoaoP9OmKqo2XoA=;
	b=Zz2KMq7ZRBAiEFfiEce1tCqsxiivPjgT2iUQfp1Gafatsb6wQ6NpamvloVIJLTs9/opo
	 vdF89bKwIEMFOxCKmPVFHjwlDTCUK0KkApg93WCHNjbNVbhRejpCQLUENyhaWoTjM+6aB
	 ihzA2WI1hyci8Y7JWcLI6tlDeajt+5LYxHIQ1z9quZGV/hGGGxrsQpyPoAWid/n/hw/Ry
	 ybRMlxAmPfjKk5ZebkjP+384ZMZgnLNS/LsalLIBMwaUHBbFT1DC/xp84NUJw9e1X6Cxm
	 2tLKIMDNALURR7hT416nY5w2frX4+rNTDVdzDryeajNQQtTH4ZThFR2FFDkKi7gj/ow==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790818228;
	bh=oEJXfB/ZqaU1ai83GYLmYcDPU6ZIOoaoP9OmKqo2XoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XEoJXbMoWPBYOIsbofNieUK5pCcaBfA8AFYWmcyruwAyMZ9ZZ352J9xvu+uGQrP5U
	 CTkaWjh3Qycbl3yMFxwbfXrOcGWeBz9JBoneoMRYAvy1U2/Nd7AyaQRvDQUrIrabib
	 Yhk/0yzmSx1BUqtCKKbAaWHqoF2dHderu8yHjZ6LocCMF+CxCK5HaDq4n5hsbWUyK4
	 CdbJPi+nW4qGYTSg6WR1cgz2LX0M0JXQWkCHuc7143O00QQ2xh8NqdnjwbiXk0fM6o
	 ZDgpzy4bRlmjy91zAZlx+IQ7x0M0BCse8AV0BBcTgftBQGZi6fBeHS+/lG0b0/KRPE
	 Xmo3Zv0prANCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F12A8121F;
	Thu,  1 Oct 2026 01:30:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C39E4C2
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5F1660B74
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U3ElSrznWb0Q for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4DF1060B62
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790818226;
 b=W+Oa50HG1CmxN60EnVgNAVkaeH/bXPdpwMqjcTmuqwR7HGVCEnjqI6Uh4qzWwcSAy39G
 EaIPNJrb6FJeI3JSCviOU0tRYLuXsgpTJsssTk9qfCl7a4WVuWvyNl7o7cGWV3J5A437f
 koPxEmfcOfeQuaEc1LfkT9Rs9LYUmX0iZk/yV0LxqdSp+OY0UUbwlOVL804ZL5iw2sh0I
 78PRFYs+V+csz2c5zO1FYXA/oAXQtpoFcfIY1PnlbbFvBOJLYln9t3kO2n5eLFkbvOskI
 a+YjdDLr6BkaXhDx/4w66RsQ2nFlTsfV52VSkdW2cKR3KuhYj1eJpsxGdgXQKlW29HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790818226;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=oEJXfB/ZqaU1ai83GYLmYcDPU6ZIOoaoP9OmKqo2XoA=;
 b=HIcGC3SsMstthYA71O4xCXMVFG0wo3cD+g9dkq6Fr23SFiweZ9hQtmRZj8e7R6Rg4nL9
 bkz20KKrwu1GW+CDinJg5faJ1qR3OKg2sPoeDcpooUvRe1icXRWQPGzS/zaGpZWJ29WQz
 6mAtw723Nq5IQhv1hWzIfbIttRnsy7bp6/1KhPI22/xeplsJPz16CkyJgeM0gmkPbQayv
 a6B1lPamT9s+xd0BBz/XVks/z5NqDXgmOOu59A5gEqq/CMIYyWydACykuf4saf5nn+ba0
 8ILg+qrh75KGc7dZS2ux9Bzq/vbGQzuSsLDWePBvLiPzUkBRRYTiuzcGKsjRBLHSjhw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=n8t41l51; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::f;
 helo=mail-pj2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=n8t41l51
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com
 [IPv6:2607:f8b0:4864:39::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DF1060B62
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:30:25 +0000 (UTC)
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2d91ede8035so50612325ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790818225; cv=none;
 d=google.com; s=arc-20260327;
 b=SgEZc0mG5j3JHqfQeENgO3GH5AjjyU+eg3MmooaPYvmsx6xKV1cz50GjpS8Cby1qw/
 IZaDbQbYC9QPRx/sqCSwGmffzEuJ+lFiQ3V/xCP+ppttgZ4LVhXnpgP1BS1uVbN/Ca7P
 Hg5W9KkvrcGWg4i6oJkLauqWIwfCq8Aodk0bhHQPZ7RSdfOuOtochbMxdMNdqgDVJzyQ
 8LMG03qycUw482eSZfc7WdFB6VTF1lJH4K55nWxL9OVT/kNfhBpYKc0Tj8AUeqD0cJPy
 9+Tw9JT9CWcVYgM0PcTyrEQsDHT0bRrF3SgwD4JH+Wap5FV4s/8qOHywYkrgqReekPKL
 K5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oEJXfB/ZqaU1ai83GYLmYcDPU6ZIOoaoP9OmKqo2XoA=;
 fh=79+CdTLYx7ni/A5DyRCtRXWEPRpGXVtLBCXzMNTx8TQ=;
 b=r1JsOciGfLQkq8zxespth5QXaZAeyK78qXOACNiU1tWzejM4OYqswOjQ9D29JXBrJP
 YOC/v3lYFWskac72DPv1kX/kedjXoe97srpBFjrlCt4AuaOzfgBcA6MSifW8k0fkxrcI
 NrsCFOLjbZU+7TV0Vz0ypAj9unDJdbjTytL5bIM6KdxQsLtf0ugbjsqML+rAxN9DDRmz
 GJI7eWxDQuJK4vkTOoNKT3uPBUgiQJy6Tf0qnC36T4oi9FR7eppPuVqvAmOT+1wU6qqw
 BavJEOHoXSHdjz+TBul0v/tPEoOwDy9pWpzkhzerr+7tPS0tieDOc0NlIcfoIBE0ppyi
 3hEA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790818225; x=1791423025;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oEJXfB/ZqaU1ai83GYLmYcDPU6ZIOoaoP9OmKqo2XoA=;
 b=n8t41l51QwIL/rZhXGKSKUGpAaCLl73ir1Q5CQeAYLL2afhFJLNoulU2say6EHBzMf
 pjUxh9Vt5jUnUCCxooycOtFvX0KtxI1fvG7XDvD4dm9C5Gc2S6LhvNiz+edaVeQ7T3hT
 EVwpMefdmNL2g7Vqw5KX7Tr5p6gvtrzj0mdWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790818225; x=1791423025;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oEJXfB/ZqaU1ai83GYLmYcDPU6ZIOoaoP9OmKqo2XoA=;
 b=Dm9R4Gw/kNpDr4G9+4Rk0rpCWsXPbuN1YXQVmsnnh2FjlwVr6CHRwZgsCo1WMQm+sj
 N/p6RP7ucnxvE/734EOCQ5hkxnKFxHLFIe3Z04VYJ4jZsojxm19LTYtuLZvyvz0+FeLA
 l4j+lEWVZ4re7iTzq5xcXbxmAaeNQm4d9rZnlQzmLkHJM2p1q/nugfesnATCYPDUD26J
 FePwpXzgAUmZUN7FrY4Vn00LTCb35OSYPC6/3er5Cws5Z8oM2Itvrqws7NMZomeUTowe
 CbpTXx0sXrR1NoH4qjMUkDDnZZqczITKwbxY9otNCr4D6lv2H9qea/a7zktXuwLYHrGF
 FQ8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7Gh/D1B/QNgYwczNXi0AFAzF0zAtZ2638/3bCnbUQ8aLP0CAPouXsI6Ht5xuBfvvaA7XYYg8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK33HmpYjmc+CfcFEXl2ortx2zafaJK497VZrpWWvHzxSZxCqku
 Hj+R4mrDKqSAdZhZOhwzSgNvHUxhbXOx5A3+J3Vb8qW0SmWZGkf+1sDQ1rBrRhapBahfrHpzSQi
 ac2VBS62rmtxy4R/dEiGoO7LVdHJDjuIf/VSrRbef
X-Gm-Gg: AYBFou33JDV0IPqzyaPrcVqaaOKejqm8nCNja5UqsRcFSOvcq4a8Hgl6+8nFmC6Cuk0
 97Eg9jva/XPm/+2IPPD0fsiqSlCqvvIOGG1DUHLSwkHxTK10P4RVOObgzAWU37Qh02/QPKiYfpU
 TbbYLDlXnAgcFWX3XF4Ia24TGE7gU+hyMa+1/L1msQc6xhZFNnLdXUWbxNJPkEodgcH3K0FROPw
 qjfw4TWdNIFImkJ1lYN0//32VpIokXu8bTWHagivH7Gg4YtZQ5DkduwmEB/MXM4ggaZXTvUj7me
 wlLBztgrtAGyFo+c/vDKmy/FIYyquVJQhf0LaS4dZwYKoQc4JYFWUbE0Yl87CcxYk8I=
X-Received: by 2002:a17:902:e88c:b0:2d1:134:b86e with SMTP id
 d9443c01a7336-2e2e48adf58mr25533735ad.2.1790818225180; Wed, 30 Sep 2026
 18:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
 <20260915184953.GA909517@bill-the-cat>
 <CAFLszTgwv8dDCbgfWHBhToR=e6NHW2FD5Lk7t1xbSte_4fdUBw@mail.gmail.com>
 <20260929004919.GA858934@bill-the-cat>
In-Reply-To: <20260929004919.GA858934@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:30:12 +0100
X-Gm-Features: AclHuK-bD1qBxK9HEhRMDrftgeqQIPmaV6JIAXe8hQgd30elnGWhil6krHxWKgo
Message-ID: <CAFLszTgZ+Z2LbgxqAV9OCM8vatC1SB6Rc1=ex__eC5VzgU-Zxw@mail.gmail.com>
Subject: Re: [PATCH] board_f: fix use of uninitialized variable in initf_upl()
To: Tom Rini <trini@konsulko.com>
Cc: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Tue, 29 Sept 2026 at 01:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Sep 28, 2026 at 08:39:37AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 15 Sept 2026 at 12:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Sep 01, 2026 at 03:50:35PM +0530, Naveen Kumar Chaudhary wrote:
> > > > If the malloc() for the UPL handoff structure failed, ret was checked
> > > > while still uninitialized, leading to undefined behavior: either a bogus
> > > > error code was returned or, if ret happened to be zero, gd_set_upl() was
> > > > called with a NULL pointer. Bail out with -ENOMEM on allocation failure
> > > > and only read ret after upl_read_handoff() has set it.
> > > >
> > > > Fixes: 0fc406ab20e ("upl: Plumb in universal payload to the init process")
> > > > Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> > >
> > > I've seen this a few times, I'm curious why you have 11 chars of the
> > > sha1 for the Fixes tag, and not 12?
> >
> > I probably copy it from the short log, which currently uses 11 -
> > sometimes I forget to look it up and add the extra digit...
>
> Why would the short log be 11 and not 12? That's what the kernel (and
> us...) moved to from 8 forever ago. But also, that was a question to
> Naveen...

For myself, I am not sure of the mechanism, I thought it was
automatic. I only see 11 chars in the short log.

Regards,
Simon
