Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426F3CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B10280DF9;
	Mon, 19 Oct 2026 13:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RNBGASEYb9Rs; Mon, 19 Oct 2026 13:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 58DAD80DDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416609;
	b=lNx155cDEU4SyX63kVmb3suB8mE62Ku20NQKHm1bU5QP6PtObubGKYvUZQJRcesmvP15
	 ndoKtT4lbr6Dsm11WwtG8S6StijgI8BKwM9brY7xbgVvymjQqbjAF4HvpRXUhuXQ5//KP
	 FTDPuAYuakK/Wp+QHWKBNUt1cSeZtzuXyJETIVQHOPPcmTL0lzY6XxErAtNzUTj8C6ke6
	 ahm4v/KKpe+X+/F0W436jikjpea3sIF8rILdOUtYaEmd3LsnH1Gq5Rj0p32MDD/JjtuzO
	 Bv/P9rL13h7Qm70q+XET0KyA8IFnDFPK7f2cqIKlvew0NI7nF695zRMgQ6yyXKFU7cA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416609;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TRbNUa+HNMd+ZL0PI29dGVGrqGphFRL5kqSJ91Yw7O4=;
	b=H8DjCH7J+bM53ww+D/d8HwCQbsNi0oMg8mTAn714Hhb0RV4aPsH7IvkippZTdmcAnPky
	 QI3kZ629VM6jiXvdePpGRfjrxl5xRkSZ5t4xGzsuORFTNF1HNcIO2CDk2sgF8cjbNPmSO
	 MBQaHuLbV0wu8JUnya5D2N9XXA0eir8NxT7MG3ASxY5KApsggLaTu8pF/Enq+37/8Cr3U
	 HKH+nGWCTkeIaT3urK9st+IvVTTBlswFmUMpsFKNBvN+dSrm5mEf1M6FBy0XAGBewDQKn
	 8i9XAo+VbR29N9arCz/ciuCr1aokN9K/ifcxKUPJFuTC1CLolooAmmyRi3n6C7Gtl7A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416609;
	bh=TRbNUa+HNMd+ZL0PI29dGVGrqGphFRL5kqSJ91Yw7O4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LaLuXSkfn+pDB+Ka+UcPknzpw9zIL1MySRRV5lqCBge7Vcs/3TGA5kDNSso0i8x6Q
	 WiWMNJHrA2+0Qj2AKY4c1pu4nFhXkMnbIOCHstxm9ewBN/PyPkLBbsRZ1S8Hh24oHP
	 iiNx+cVBk23iJ9llpcVAndzTIYnQp2rXNZlIPJLM3tqnr8Vqr0LXf/i+25xsFNCzFx
	 G9sO+C0lsq5/mnzDizYfQiVKiRapT5HcJ6fqLBBWFKJQxM5/L3w2mL8aMy/fxaXC7d
	 ZraOABQsUBB5SCJ37SShzNcz+8l0kXfUWHzOX88LZY9CuWfsIeby1rtCpgvfrQrFqc
	 DpPCkJfvFRnHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58DAD80DDB;
	Mon, 19 Oct 2026 13:30:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DC2771AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE0504014E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7l-IYbnMoKKB for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2D5D44010C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416607;
 b=nJq4fK4he7lwBNmECvVMcY8zNiKIWNG3tzhMcH+1PG74t6Tj7e71nuDJkJyqSynB/mqQ
 dH2yYZuPeK2Qvcwfs6HMLAKp5yOq+Pe8QskYwRyMEpGButgKCy606Tr1QjQFjChwWsjih
 TneIfUUJe1cmZl+4qRpL5pJMBYAh3UlDxjR/JZToCZWIOotVtilJsDPqf+El5jjKrDh/r
 c4sAOwQB/+ovnxMV4KsXzFFeRPtnQb4EuAGrWbPO4xFsddXITgI6MnAKB796FX/HsYeCC
 E7hy8SMiE42peqYB1yhPSE5/4TvOgCq6SrNaVdf+kdNPH8UjDzG83NeAWU3h92HCNsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416607;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=TRbNUa+HNMd+ZL0PI29dGVGrqGphFRL5kqSJ91Yw7O4=;
 b=dXyFwZr1J0n4nzlHo9mwkxDPX+BSUj3lbtERcUJ7j6MpLEEtLJ+GU/LopW8PnP5NAeHH
 0QyYvYpC+N71kSYwL6d0FATRzRw4j2xgi5KQFeprIBxjYdr9NkqiMgluA0SI7wL23NUDR
 MRmjDlod2KNS/Uev5ooFRUdfb7v9vbHEGp7pab+MINkYTjoAuOXeO8tybpuRF74DLMb8d
 GSilu+SNWywyHT00Ibq5TcC2SHt2QB2xnBIKSS8v87YMzP/Wh3Maud2DfTK38Ehht+U/r
 D9YST6SwtcrwWKjHid9GOTJheSn+8bCL2LOoI4yXnP+Cee1OqddZ1o3AuuU27XcdYxg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PhbWpbgc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PhbWpbgc
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D5D44010C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:30:06 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cd61a2dfd7aso562153a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416606; cv=none;
 d=google.com; s=arc-20260327;
 b=oV/P5zhbVrXcOQy7SMnUOfD+wIz+UUh+7Ne2HOrYNgZeJ+1O7U7+UywlfXmspb89P0
 YM22apRlA9yfJ8vrZAwnuND18jwNV8izXkb5xmpouiOwOtsDSOQ176M1JHkV+m4G1YGU
 yThzchbkJ8ZIJBHilTnIDB+kAaa6/Lrl7FtaDYS9d0/FNqcU1dx+lp75y+RwMB5Cfmax
 PARwEcvgXiPsEkISP0bFeuRilulZjXzdvwX18jM8lh5ZiaYVIr1JvKGfsZADDsTwJ0+z
 44PQmNBG66YQwNu5r249Jywu9/Ai0IZ1xc29F0db8YnJBAlV0JqAqX8tVm1/YZFD85mD
 gUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=TRbNUa+HNMd+ZL0PI29dGVGrqGphFRL5kqSJ91Yw7O4=;
 fh=O6yyDpq51zTRjYTvyWS96c+vjtmCfJXCgqOToRtEnC0=;
 b=gC9Jf109QvwsKlXWmfoqYU3a/DuCF8BJNR/Xs7DJIEhahW/nDK9zrPYJGErxpxPwrM
 AHZdiS3DYXv04cWn9eVG3OgV8LdH6Hu6IrYKrdiXffTatcWTsyVZDLqd8NUfv5YzzkCS
 Z9vGgigESxNOFztSzDaBMnGrrB7TXxiSs+Rv1SYfCURr2pjIVTUK//W1TxvEromzdiME
 VKc0F1WwYjTKAi2nSr7GwaruNTIbBNk4J7HNPuh5muVjAQjjgn8uZyCjyWdHUTgZzSHO
 /NdnqMNV9cvGZ4lmnCpOKU4GhGmMSJwPYGkXiFWVcXm2i3ZY67AD3B1s50YReXdFgKlU
 +yWg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416606; x=1793021406;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TRbNUa+HNMd+ZL0PI29dGVGrqGphFRL5kqSJ91Yw7O4=;
 b=PhbWpbgcAddXoekhbJGaYbStEiEX6iEH6MVQZkR6+DevGSqny3iwHHE2b1ULViOU51
 XR0ZM8YmZI43zWBkjA44Ox4p/+t8fB5CoAEDV3bIU84Hs+GIP+JA4mcTRtnkt4ysVNSm
 2vQk91G9xd8ohXHJDD5AtGEynFfELfD/YQ4nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416606; x=1793021406;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TRbNUa+HNMd+ZL0PI29dGVGrqGphFRL5kqSJ91Yw7O4=;
 b=R8BoWli1c3TPkYerDkO/XM7IrBasyFLzq7pW0aU0yHU8IlyYqZUlljew010QwPScB+
 04G8rGtbc1l6OBIYhzKeNwxOw/7Pb454ut6xU/dT2WncZVqtRMlrK18lfiihhp4kFLCp
 OaKiwMxqTxsS1gIcLFS3VOEptueq3252oovedBuetH8DS953PA1JwKl2NcKMUrxQ3Opx
 6aiMiqRT0EfC5fE58NOXwwqD3S1ThbEkMvfcO9jGuTNWNAlz/AfYlspLXwYUpFGVy0GD
 iOwWCTtI2Z7CaV/VQTQwwu8bwd4xL8CiXGaCeNuIRzuwAtUl5UEGJlxveis24M/hu4hP
 fwSw==
X-Gm-Message-State: AFq9FYJht2qGIQsfJz2PiXy5eIOP2Z0vQxhFPuNx9zMboYJNhiU57bnz
 Hh6xg9pyg+IPig7LgpiM/BmeDznKhh4pNi3PfzQqR0SutStaUSPJKhACYCIie6BcgQaRludZooL
 lAazImfbeBK6ww5UoFE+RAdY74MgIjsayEuSdYXKA
X-Gm-Gg: AYBFou21sW93B3FFM2FdKoeIdF3Uwkgq5u35URCOvoPMItM16x2Ra5NWUVGU1Km3Fhq
 cKW9hJ6zvR3DkkpjWISvqyvplOjQBSUYHVegzt2BbYcwXwP90/VfY0ngQrg5ptzNAkUANvEzKJD
 LdQsE9w69QIJZ3HT4n4sfHLhRArruXU9BmSS5zTjmGAuGIFfTe3Rfj+XaITEZS2ymBVq0EqJ5fD
 fiFUlhE4b//Q2pd7zeqsyshZ/PXL5lI1siRgU1ynWPsXqSNpBu7ZCq5CxQUjpL5uU1GCcV70MEj
 cnbjnrKzrNl4fdgmYEuwOvhqKpqVp8uV9POML714fLOc2ICoPU8Wyg==
X-Received: by 2002:a17:90b:4f4c:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3acef518c17mr6797642a91.39.1792416605876; Mon, 19 Oct 2026
 06:30:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:30:02 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:38:52 -0700
MIME-Version: 1.0
In-Reply-To: <20261016081719.814357-6-aristo.chen@canonical.com>
References: <20261016081719.814357-1-aristo.chen@canonical.com>
 <20261016081719.814357-6-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:30:02 -0700
X-Gm-Features: AclHuK9uMDpWTzEOslsGmEHd5c91MwwkrRH6cXW1du1ADipWCXjYA4VllNPR0jE
Message-ID: <CAFLszTh3eFvnrje4y30KyvfttH390i9u=wr=rcvcgeNq1=bsGA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] test: py: cover invalid external data properties
 in fit_import_data()
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 anton@binarly.io, pranavkasthuri@gmail.com
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

On 2026-10-16T08:16:23, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: py: cover invalid external data properties in fit_import_data()
>
> Build an external-data FIT, then point one image's data-offset far past
> the end of the file and, separately, make its data-size run a few bytes
> past the end, re-processing the result with mkimage -F each time. Both
> must be rejected with a diagnostic naming that image. Previously the
> first crashed mkimage and the second silently imported the bytes beyond
> the end of the file as image data.
>
> Also check that a FIT whose images are all empty, which mkimage -E -p
> writes with data-position past the end of the file, still re-processes,
> since an empty region has nothing to read.
>
> Finally, check that a data-offset or data-size that is not exactly one
> cell is skipped like a missing property, so that mkimage finds no data
> for the image and fails. fdtdec_get_int() already ignored an empty
> property, so that case covers the length check the import now relies on
> in the accessors. A property of two cells used to be imported from its
> first cell, so that <0 0> made the image use another image's data or
> left it empty.
>
> While at it, correct the comment in
> test_fit_import_data_missing_offset(), which said that the hashing stage
> reports the skipped image. mkimage stops before that stage, in the
> cipher pass, which runs first and fetches the data of every image.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
>  test/py/tests/test_fit_import_data.py | 96 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
