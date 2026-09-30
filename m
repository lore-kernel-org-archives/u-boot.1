Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C23CCA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 18:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22284811B5;
	Wed, 30 Sep 2026 18:46:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f2pb6tNiPix0; Wed, 30 Sep 2026 18:46:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 414C1811A9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790793999;
	b=PiirHoHyxhTTrwowIkCTSDqL3NjPVUUJlcToQz1zJMY+TCK3KZkH3F9vsH1lbEXzExIb
	 hELDIOret19ItLWKKYdHJKnd4dvCAANP1N3u4pfzXoEpgELSH7hgxIQY5SpL0LE1VNFie
	 v3W142B3bG/7Nln2uYdFyppiKpy3Mo+utu+ALNgb4wIlDGZWt9DU0DtfnoY5SCa1hk0Oc
	 /+Jk5iPVZOwcW2FAz4/KVzUkXSlyC+BrUiH5YEG6UpEZvDMHKz3szKWIPMn5XR8IPYjLj
	 4a+usgal6xj37I1+aF+7KOZArlzcZo6ihmj+t8LegRjY7gFQsJbPaTqKJnCSTvBAKdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790793999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3f+ew0J6KhIYQZxqTNkVCIQ5VKPQkg042+bASNaPt6Q=;
	b=WPchueAHPnxALThg5vLguzLPw3lD7KS+w7F1us8wcagOSA044BCl+cKp72lJxE9awysY
	 9aWpLjGpd2m5rqPrTGXFnKAtHsGVuqKJCLVBV7uotua9iboH8WT+r+I6jo++28yKPcYyx
	 PUHdjhm+ANoWmVMm4/m2It1NF7IfOraJDdgoX+ASL1g+3KYlBjS04dEs6oBiMXJQ/VumD
	 khStmsEkUFdLyAT4VXsZbfWJ0L3256pItUPT39fAZVgFgiVJ+Jradsxsm0HV2paQj1jvU
	 +/blbTBjhEnb4WgcFZzV9j+2j6t9+J3JyiREIGLaMSN5sN7iM1NgrHY71LIUW2JpFpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790793999;
	bh=3f+ew0J6KhIYQZxqTNkVCIQ5VKPQkg042+bASNaPt6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ODvPHX+4Mtq2CgsQDbGeswin0/iI+VVE88eVaNATXAsDFMUanUOArkBMB/7WLMkX9
	 upthEL5ahTmxSmHir2DikCWGet0Sn5y4+UCGNUkpqmZA5eXEzmQLJovm1Su2G8o6kf
	 4E3stNfUuOO+HXMNNxrElpixwdNg+48VB1CDT1qPMshGbcVKua5SaFMhNcvxCJBLze
	 2tE2rGQDjj6E8YhByCR9gMQ8QYz3EmxD1+nMOqaSsaNsqXIfJolkxMbhmCAoNf39NA
	 G7a4cQsxTzMecLvswzM8SYuCUlETkOe0GPXcQMnm1MKkxMs01+JqeynsMoT0hIRSoN
	 A6G+fohtte+Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 414C1811A9;
	Wed, 30 Sep 2026 18:46:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CDD53AC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EB4840474
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:46:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BNSO8kRjGS36 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 18:46:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 36D4D40462
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790793997;
 b=H24KgzUZ/li3U9rZjCK1vh6hDIOrFBisBKvwSJMrJYkivukmhi8VwOmiIXeNv9dB3tGh
 SWKY839VbdRkK4pbTg0UcrMBy08P9ssPGX3RLwxgqJ7MBv5agTN2WhhDFeleDu2O0AFu4
 c1/YWAd/g3SeBYnZoY2ORpWVoldl+DOMspa7hUBGepov1Fl2xKe7CRdLck1u5vFVRSjRu
 2R+vXpsrhlhfkv0xm12AxFgtEu8pVojEjF0hChfiz++UM7pav5ceyPVSFBYzWRapiu1ut
 W2ZEtUNCsLpsqU+nJC+QxJ2H+2fsD0zNMtPD8PtKJiy5XfwvYG+JfBxGASVMOYBM4NQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790793997;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=3f+ew0J6KhIYQZxqTNkVCIQ5VKPQkg042+bASNaPt6Q=;
 b=TpjIPxUn+bWUTNO5nF/7UoJOhQqHUMqxuk+DpmgXgeBmfZQZZ8T45YQy9MYTJahvsdJf
 uDlsgBBMONeOWr7ZymLxO7OvDF4iwJw3nUGK5TwdJMPwP1nLP5PBWl3zgpbjbVcGW3E7X
 EggYdBlw5Q4NroUjKmHVnDsuZDhlObVeCth/8ETqaR7fBBxmwffYe8OZ799tRK/5JSCB3
 oL51EnllDb3RjaYIjj2GLsnMnIdVyq0G9aVRqWtVDhzbACWYWP2CH25HAbOiP1/84eMQ2
 xHeqmKUDgLaFyGnGMRTfX1+axzXsRo//SIukrZzQfryv5F0v9U++cSAVosM7CTCpfpg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BrUU4Ldd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::2;
 helo=mail-oi2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BrUU4Ldd
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36D4D40462
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:46:36 +0000 (UTC)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4ab2d72ff13so2129861b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790793996; x=1791398796;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3f+ew0J6KhIYQZxqTNkVCIQ5VKPQkg042+bASNaPt6Q=;
 b=BrUU4Lddjv2CtERB67dyy2gjCKLEXS1DqL1xCpB56zd/ImTLzyuFezQnrV0g1WE7ud
 4CbVpZhekicaS+1HZlcv3WmQ5TZ9sU4A3KZmC+v77+f/nmIV7Jr5aJOMmuZMskRUxerE
 iM0yVBbcOcNpfH+KsAXOs4NihIPwbt89VwV38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790793996; x=1791398796;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3f+ew0J6KhIYQZxqTNkVCIQ5VKPQkg042+bASNaPt6Q=;
 b=uLShfPT7OYWy8Yn6PKzTuYpLGRuVmXFUHpXSVA0D93IT/CwUtOKvPHu82ExTJtz8JX
 7FUlpxr56JZYZvSCUSkyWfpTRjwmtSJsvHCRiqwa+6fSsMJaudGtLFI/pdyyGCe13tDA
 WjZDaZY7AdCTyc84dCQiM/2SCZhPWeOgi5QkT8PTXT776ZJ2wnrF6W3Yo4YjngZ0RAz5
 zH9mLy7F1/NjydcgTFzbqINV6tuaqBbDzBZ6Klh5CYZHh9LAmqxpxFyJZQsFdDUI78N9
 6k1irwF2jQtPK5TNvKkcIGSINtE5Rz92AvqM/nuOrrDUFAGhqHkZlMTGZ+VXtd5Y+Qac
 UB+g==
X-Gm-Message-State: AFuF++lBRprLz31Bv3UJwKuUu2Nff7uakXm1OFNuPW1bueJUOaxrHLkp
 G7QojCZwTT8RZpof3f1dxQLCbnDUxyMvceRl7dBu44jEHc8jvES7Yvt1MV1vrRcJ3NxWCspEUPa
 fLang5XP9AblEfC4=
X-Gm-Gg: AYBFou2NDAzmZebVBgmIojbsQijtMs0VD+LLnyYyHu/KVNozEvD+IdEVYI08uavB81b
 FaVmdKKzflrm1E1J8Os7AC/v2AJCCMTQoWlHBsyuF+BqA4/q6pwLvgSXGroZ0r1obozE8MJPrSz
 erMl9yztOl+oJSw657oM5hl0MyH042+dVIf0g+rkXhXHGCuT/FsJp8U8D1CEwzsw4VEOu2xVFmA
 CVjdM8XPXg7I11uIRc45DXVUF73AMy3l6VoYYT8TPIw6LubE4z8Ws9O//8xE4u3SNqmNI3NMEFQ
 bLACt2X1htrxaykhEiTjvEvu+gLKBdAILUJHTbL3DlgweBhkqUmTA38BUr+8KRxt2SgpCRDHLMM
 8Px120PgJGWHgrT2I3DMZBxz276vJfI+Zd0SaoR4RlRbdZSZWx375ekB0t3ByfUpqFln7/5Isqc
 DbfF4JNWPDv3FME1i6fkAU7b8aJ7xXx6I0ko7//SbJjRGKLW2xOf4JJuI5qHSxKM/ApzkQvKnb8
 7V1iIoYxw1XhPSyjK5w0rtKWARO+OEVjBao4nWBA2cIDUKPQbjz5hwpniu0DDpRV+w/OFcvUm9j
 oFadwajrOsmgfdh4+A==
X-Received: by 2002:a05:6808:17a3:b0:4ea:5e0e:7dab with SMTP id
 5614622812f47-4f1b9563224mr2251560b6e.37.1790793995646; 
 Wed, 30 Sep 2026 11:46:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f349b43165sm150212b6e.6.2026.09.30.11.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:46:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jan.kiszka@siemens.com, ravi@prevas.dk
In-Reply-To: <20260930105622.3740163-1-ilias.apalodimas@linaro.org>
References: <20260930105622.3740163-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for optee-next-30092026
Message-Id: <179079399453.487063.10769915599095928429.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 12:46:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 30 Sep 2026 13:56:22 +0300, Ilias Apalodimas wrote:

> The following changes since commit ad2b0f0ef2a2a6bae1896e493e98734e37a3f1eb:
> 
>   Merge patch series "dm: gpio: read GPIOs in of_to_plat(), request them in probe()" (2026-09-29 10:36:18 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git tags/optee-next-30092026
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


