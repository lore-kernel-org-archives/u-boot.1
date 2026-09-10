Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACD0C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38EF16087A;
	Thu, 10 Sep 2026 12:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQ4QmLtEZOrG; Thu, 10 Sep 2026 12:23:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7357E608AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789043037;
	b=Rc4dwV/sSv7CCnS5dWhLm0GKUWGuvASYqIBztVNKV0ewVmXt19o1zEUUaGoIZF94lOuE
	 FHulKnbfrHNuTqmcjheF/8LXZkRXhgCX0PaHinkeuZmZgW3SsuyFzWCNN7WJlq3QrKP24
	 78cCCoLDsdYvSUL2zqgtiR3/N11qWYnJxpK9lAmqF46Tfnfpv/SVBAHagYyg7T5gg4yGj
	 4Ht91Zbs/sy7zFuwhpnIil6xDa+n1IVZHpFkibvjRCNazImvlXI2DzmixPZgvUxht+Me6
	 RyuHwC/Dj05dfuZ3qu6KcWTVPHizkFjGDjTKkj2ud7c1wDdVOZy3vgyrTuFebXfS2Cg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789043037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
	 X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y2nlc3bO4SBvtDu+nJlU3jydQdawmIuPggybW6eILCA=;
	b=HkSEW/PJUxas4EgYpTE2AC810FD+auFrfq8G+IByLQfvzu+N15fEwQGRKo/dkV5fLJpT
	 UOdeyeztBz756l4S1Zq6ITYH4ZiWyBRrRJx/N82dO9c4J5D/dOaDf7pX0eOg6Y6ermi4e
	 gJaSI9ruvfihPMY1qjTuS3Y0xJ1ETttz6r0gOYQ9wtMYJMueICfsdQk0za47EQGH5JCeY
	 vNenZ1rd/4yhhaoz1b1xTiHmgOUdKVAXAYisvu/MEovE0P+DAN3/SfYPtLndCGRFlYGCV
	 3n6YAHw8U5YGhhNOrrDIKVBuYz8FEE2rctESs3CPZSN7jcM6Z96P8Wd4kSBb6NEZxyQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789043037;
	bh=y2nlc3bO4SBvtDu+nJlU3jydQdawmIuPggybW6eILCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bJQDzdbSA8B+CyyLb2/KB2+EyQIE/shxuDjrnzpXfp5/jN0/Iq2gz9UvA1keDwa1+
	 riUJNxO1N+ghyqY8ygTdaJUHKzpDgUe+p+L7J61+D9orDDeRAG3JRzrQg9KA1Mq8Vz
	 f7jb2JZKg4VV18a0F6cdDs5OhhLPyw9nvQtWF1BRMceuNwM4oeH7tPnWI7d4VOiCss
	 Z71w9dnlm+0fkHctO+xSd0ciDyZ7bd3d2ZTaka4xA/AKxK+PsB+dwPwD2szKJfvtvL
	 6yTZoVwlZmfDdPqQSoo4weq+bPdftmaeJlKifZgTKG1YilUx/99Wr6xB5aahsbwDVD
	 0z32u2RLaK6Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7357E608AA;
	Thu, 10 Sep 2026 12:23:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58849769
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D44A80F82
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oUiTwt19zd6W for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:23:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4B2A780F79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789043035;
 b=ARl0/92Sh2cRmO9nnGECoccpI1M0kNLO84UAqLtCIy8Q3slDZ6VzATKgsY3RwL/b4ryR
 1gyWIFJI03mqTrAo0eR7+DtVIQOTSM+Vw1qJeA+Brvj8jRXo49KyYfx9FIOpDOpQD0TBa
 sTICLsguF/SX6hXoQhK5ee7n5l+Hb66raaaplFzPBgQCiRBP+bgCwiOHk6biJ7D0lYVW+
 GzxzUHlLD8yxOmMf54E6+beunHETExseE7jpRhLbN6lfQNxgXrFE7evV8JPVqZc0wNG5Q
 O/nUFccFMI7DwRCAx9DhoGe6BvqCZ/k7cRYGoUO373eiUJYQUDYRg+OAN45gNGDFA1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789043035;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=y2nlc3bO4SBvtDu+nJlU3jydQdawmIuPggybW6eILCA=;
 b=SsrFmf+dBf90VBNip1x7nkAFzkM6/vcjHRI56dMmvKBKXIikBpkzbJ5nUKWIYxJJ3lbR
 SXV8LqBTb8Xamy9UlV/hzRzd4ydhKqvhR9tnnQsD/DHRouJmmXNl9THFQIzeSVrvE13ZN
 FTTV9zE6Im5R/AB97e9suTJpKd2ZuLI/qV6D78UrRApMQLWp9QOYd+J9qs5RpxN9nIL6N
 ekiSrNkNOYvGu9nJKbycsUW6VR6d/xijePy7KmT2pT0dksfBAc4UdvZJ0pmKDyOm7pXdf
 HhQdHs+wpxZHsIEnYMEMEp/2bJVceTNOl5Ey9knKvVNp7JMNaFi+JZ5HOHTxavb2ROA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="Mrmspe/L"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Mrmspe/L
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B2A780F79
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789043026; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Iy67KaLlaaAP3cDMU+6/Be5ECME95piwNrSFUW5eXbh5iJ4xve0c1RaTtmwEL4SaL8sFG/kIA+mOg8SEY+F1hdlU1ltQ2TfmcX2MA1NE3oTHHl1QzYxeZJjTW0CHSEOAbCFkE5dwUhmzvDet2jVfxNI72+3gTxaEF4yM4SUcchc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789043026;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=y2nlc3bO4SBvtDu+nJlU3jydQdawmIuPggybW6eILCA=; 
 b=dbs7UQZ3B7ZEKK320zEi/lHabGP9k9v7xmOtT9M0AHcXpgIHSveJq9uREHLJwcc2XPtQxvikFDRZoEgy1RBznJ+oJi/RWbCR0Sn52zX5ERF3RHNh+R7DbuHm7vT3Cp7/IJyawNmYqTrt7rde57NQA8+CjYeS49l7MxRN+GeZB30=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789043026; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=y2nlc3bO4SBvtDu+nJlU3jydQdawmIuPggybW6eILCA=;
 b=Mrmspe/LNqerPLFvfgXxDTDOihWsCBSXF76mQS8dTwKIUC3Rs+1fosMJYlj+jS0E
 CaN4VMIwJPiqrzbTwHxf70HsJbQTdHxedVVDVNnNrp5815wCwxQk/lluLqHAUlABmka
 K+6ARmjFeyKBe/V3UXG9+XLM4MUfQyfDVQZQVDNA=
Received: by mx.zohomail.com with SMTPS id 1789043023974119.5905404678715;
 Thu, 10 Sep 2026 05:23:43 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:23:39 +0000
From: Yao Zi <me@ziyao.cc>
To: Nikita Shubin <nikita.shubin@maquefel.me>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 1/2] riscv: =?utf-8?Q?timer?=
 =?utf-8?Q?=3A_Enable_early_timer_for_M=E2=80=91mode?=
Message-ID: <aqKhS6_w0Fqt8vsV@pie>
References: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
 <20260909-riscv_fix_early_timer_mmode-v2-1-563bff2a50c5@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-riscv_fix_early_timer_mmode-v2-1-563bff2a50c5@maquefel.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.29.40
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

Hi Nikita,

Sorry for sending out this review late. My system crashed earlier this
day and I forgot this mail in the draft folder.

On Wed, Sep 09, 2026 at 09:30:59AM +0300, Nikita Shubin wrote:
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
>   and RISCV_SMODE_TIMER_FREQ   in S‑mode.
> 
> This is also necessary because several functions
> (e.g., net_random_ethaddr() via get_ticks()) rely on
> timer_early_get_count() even if CONFIG_TIMER_EARLY is not
> enabled.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/timer/Kconfig       | 13 +++++++++++--
>  drivers/timer/riscv_timer.c | 12 +++++++++---
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
> index 500a25638a9..12c194ff74a 100644
> --- a/drivers/timer/Kconfig
> +++ b/drivers/timer/Kconfig
> @@ -227,8 +227,17 @@ config RISCV_TIMER
>  	bool "RISC-V timer support"
>  	depends on TIMER && RISCV
>  	help
> -	  Select this to enable support for a generic RISC-V S-Mode timer
> -	  driver.
> +	  Enable support for the generic RISC-V timer driver using the TIME CSR.
> +
> +	  This driver works in S-mode and also in M-mode if the TIME CSR is
> +	  implemented in hardware (e.g., when the Zicntr extension is present).
> +	  In M-mode, the timer frequency must be provided via the macro
> +	  RISCV_MMODE_TIMER_FREQ; in S-mode, use RISCV_SMODE_TIMER_FREQ.

This doesn't seem correct. These two constants are only used for the
early timer implementation, and the non-early one looks up the rate from
FDT blob (/cpus/timebase-frequency).

> +	  On platforms that also enable CLINT/ACLINT MTIMER, both drivers
> +	  may provide early timer functions and cause linking conflicts. Ensure
> +	  that only one of them is selected, or adjust the configuration to avoid
> +	  duplicate symbols.

Won't this issue fixed by PATCH 2? And I think this paragraph is too
detailed to be included in the Kconfig help.

Regards,
Yao Zi
