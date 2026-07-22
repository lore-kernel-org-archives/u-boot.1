Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FF1C44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C07F040A78;
	Thu, 23 Jul 2026 00:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id alOvVK9Xs-Lf; Thu, 23 Jul 2026 00:53:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 105F240ABD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767969;
	bh=yKqL1/yAfSur02A2BoLcjFomomGJr3ojsaEA0mue5w8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZtfY0alyTdQ/bekQtVhTVrIGP6A4hvCYa/85d29+pVmq/bT48tJnniy30EoM67kgK
	 42Ngb67+hvRDPziLgPEg5TqQOgaKz8GK4lqBuQHL2NhMjNsxrT2zOR1Ms95hhEy+qe
	 Vec/nCLkqbzfDDON+csHTIBWDzPOpNP8TyWM6msQGkGM5/mAcaQS/kcFIpOGMl8KIq
	 orKcYdrMPAp0hajMIPypSnbiEHxYugrPKIOC1pSo7PadaLcuSbkTW6So4Yw3Gq11m+
	 MhzLd9t+XCIZch02IQrcZTrs7Tx9g78kVNvtEn9wvNfm+I7mYwOnuJGY3dD0CM03+f
	 jmFJh+QjjF1ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 105F240ABD;
	Thu, 23 Jul 2026 00:52:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1326C313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04BB340057
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJjaDshOkZzJ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 18:59:13 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jeremy.bezairie@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B6EEF40056
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6EEF40056
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6EEF40056
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:59:12 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90FEC848BA; Wed, 22 Jul 2026 20:59:10 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075DF83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 20:59:08 +0200 (CEST)
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8efcfdb2b43so129408156d6.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784746747; cv=none;
 d=google.com; s=arc-20260327;
 b=lAHjck4WWI5fwkBFWqyyKndXPJgWvSeLVxGf2LdesBx74fxcvqUTTjn4cH6zUI9dhd
 uYJ4RazxJ51L9Ip4DHfkXdoZiCwF6u61VDfEyvnOFeGIxSjd2TnmKoU+ObNDvQ4+PCA6
 lILhRv7sqpZ8RtOA94rnFqg1KRKkb8qLV/cJ9DMKiuEbQv3JPWjj/Tm+bnclAAfkHmp6
 r+3S1ePxBaNBDYiXSLJjbzR2FMkdFytsxNsrxrH++7KmpjWFrwVBrJfttVX41spzA5bk
 XXpEoSlPzaEBRSrvfb41xFWcfrVb1koO3PqtXbebEkKp4VDZeH8jf6Mvh2A7wG54/Jqz
 2GfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QDtwSKo43s2onJfKunGfYgQeVsF1sZQ8V2ynN79gp7I=;
 fh=+6qlcApFAuRBtMtxf2g/FYYcKNS/xsDFYX5vTyW+ySs=;
 b=FaVGCtQLUPykYJEP1djpCHZlhzfig2R7+nDXICz0qnvww/To14Jdyxrj5P/UBcdjSw
 XssyJBL+0mRhxbvQosidxHf6OlAzjFBhLjObRGDp/xFMlnbxWnEwKtTqZvCZ73s9x85X
 SXGM5CgkNR2ZSE88LbksI9sop+OmwyRghb8B9/xfL538hC+FRvxk6PfivR0lJiNnK0eE
 8balCQ+YGiNx84BE56gweA826L0eGlpKZ8tBHOYH4XsMOZ5AKvaO8xnhOf4Y3t+aQBIe
 KKLFYFIDyfT1EIyy29coc5KqQtOXP21rlwnRO6kU8rb5/rkA/g8i0ikoLhYLyLD0/Rt1
 USzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784746747; x=1785351547;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QDtwSKo43s2onJfKunGfYgQeVsF1sZQ8V2ynN79gp7I=;
 b=gaJKabXt3FsDzhLX/fTfl5nuPETNmWJ5P9PkCGF79qTGEzgoMT+xObcwHEDH73ZFCw
 qsZ6praH+DOzo4KQh9UyDs4oE3U/lS5uV5ZFTy1jDEq4TTg7e1Hb1eIgl/Xps3YOpMok
 e0V//UGQveXwGCki0He+d5UZhiTRV62V28UX4qtcC0VdWpRSY2kK6vMwyS8q/3fErPYW
 EKIRCROqWcCoV8fZVJMxWXNmBzDv5kOY1QPF/8Aog7awwsV+0RYWTfQRAhNYmveBABUo
 gykP0Od7XGBaTRCpj1Pdi0ML6676TTf1i2d5FhOif6DbKQskMGQ8tFpjNRsWgaYjPaTV
 OIEA==
X-Gm-Message-State: AOJu0Ywtez76PVMTqZzg2RVrlhwd0SEJ8PuLVhm67464IGunw/+tCEzu
 HtTrefA/1Iv8ep0zGl1djO5r/QRiW+fr4CAt/STfJjKRS4h2grKLXjUGHVv+f+ZDwuui9LilqdZ
 SAgD27Fm8d0FXqGPHk6kimNx918x1fNCtYGjzUuKN+sio
X-Gm-Gg: AR+sD11DHcUzbZ2et1RFLxJz3amJlfcDa/SpHe+HiKlmEm1p+SGKaXjzJD2ROcUoHe4
 s1J9HmxnrvfD4YeoYNhb5Nlkth9yq6f/0MaO4TOou6sVQYHA7kU0SWCftrabpAJDC3jqTB1a0qU
 yeEbMIBRLaLlXZW/MLtF1kufVvKpQgaUnP4IBEU/zJbF9hT9PUqZTdZGXy8q+KGr3AbkhwbR7jb
 9u0AT50azM2/yIoUPDOdZZcHgRvprPgylqPh0f7hii1QGFwx7oFxGKImkcTpkriQDJHlDgM12q6
 ilIGa3vJFCXCchNSGWAIEovshBx3rNEpdDHHcKzXdJdnfpETl0X9JHaCY3aOYiTidILR4bog90k
 =
X-Received: by 2002:a05:6214:ac8:b0:8f2:1d56:3e8c with SMTP id
 6a1803df08f44-907ca2e89e5mr1491596d6.29.1784746746629; Wed, 22 Jul 2026
 11:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdxF8BDNszU-UY9V+_dQq68pZSFu3Z+vUsgkWe8G4rDZMGoZQ@mail.gmail.com>
 <CALeDE9MuF-=COmGEa1FfH1M4asrZOzbmGiYvpQn+x7DCNSgPFA@mail.gmail.com>
In-Reply-To: <CALeDE9MuF-=COmGEa1FfH1M4asrZOzbmGiYvpQn+x7DCNSgPFA@mail.gmail.com>
From: =?UTF-8?B?SsOpcsOpbXkgQsOpemFpcmll?= <jeremy.bezairie@gmail.com>
Date: Wed, 22 Jul 2026 18:58:55 +0000
X-Gm-Features: AUfX_mzbbtqZdEUlpFiB2jUAyyhNeqyMo4mdaCTaP6siO6ril7trBdOWE4qa7rE
Message-ID: <CAMdxF8AZuJpaTWB3n7icPJcmUrU+oQKAk3RcLy4mZkL2RQwQ0Q@mail.gmail.com>
Subject: Re: Fairphone 5, microSD card support?
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784746747; x=1785351547; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QDtwSKo43s2onJfKunGfYgQeVsF1sZQ8V2ynN79gp7I=;
 b=slG/J5CTvPF6rRNn/ZXL5bYF1q29U5w2eFTeeqD1HnAUf8SCdqxFRHigWIpLUESrye
 d3Z3orktDrGIqjWP2WKnr6i7Ch72rQBlT9TCPjR0mv+a0MJdGXve9oWxb77eBSNiCfNg
 50lfZbr4BPxdj92W2fZAW75HIq7gfp/R+dVgw5Z5QZHko3kN7DdMAor3ej2ksBmFTAA5
 JqpJal45kMUQQ+2cRNHLMV5jmpPsnIdr4fPaHResXTbAmD8rGijY38C18rqQeC4aAqFE
 yGEXAD0hOHSfjl+UABlmb77PFcJc1YsZPC0JTHVHyIKMv1kHcKzllBAaZkMM7e8BOpmi
 KVQQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=slG/J5CT
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jeremy.bezairie@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="slG/J5CT"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

After my email I asked Luca Weiss aka Z3ntu
https://wiki.postmarketos.org/wiki/Fairphone_5_(fairphone-fp5)#Contributors
: https://app.element.io/#/room/!ZSzxwGCgzGABqLTMaa:matrix.org , then in
general
https://matrix.to/#/!ApMpwNlRBMeVuZJISw:postmarketos.org/$L-m53VLN6Abln4Z3t=
wGXJc5ZRIkH75U3YlEqDqE6HjI?via=3Dpostmarketos.org&via=3Dmatrix.org&via=3Dno=
va.astraltech.org

Summary:
https://matrix.to/#/!ApMpwNlRBMeVuZJISw:postmarketos.org/$4tGQ3QXrxRAl8N332=
kMmM9sJp6ku4ctpOgpFPNqI4So?via=3Dpostmarketos.org&via=3Dmatrix.org&via=3Dno=
va.astraltech.org
https://matrix.to/#/!ApMpwNlRBMeVuZJISw:postmarketos.org/$LV1-x8golvuZ4b1fC=
kZ-8T5S2e_WrAyrWWv6JJDs73w?via=3Dpostmarketos.org&via=3Dmatrix.org&via=3Dno=
va.astraltech.org

On Wed, 22 Jul 2026 at 15:21, Peter Robinson <pbrobinson@gmail.com> wrote:

> Hi J=C3=A9r=C3=A9my,
>
> > https://catacombing.org/builder , selecting Fairphone 5 then Build Imag=
e
> > brings to
> >
> https://gitlab.postmarketos.org/tauchgang/u-boot/-/jobs/1548118/artifacts=
/raw/binaries/u-boot-fairphone-fp5.img
> > (it's
> > not the latest...).
> >
> > The latest
> >
> https://gitlab.postmarketos.org/tauchgang/u-boot/-/jobs/1607429/artifacts=
/raw/binaries/u-boot-fairphone-fp5.img
> > ,
> > according to what is displayed on my Fairphone 5, seems not to support
> the
> > microSD card, no USB mass storage it, no boot it.
> >
> > So is it possible to add microSD card support for the Fairphone 5, &/or
> USB
> > drive?
>
> As far as I can see the U-Boot support for the FP5 isn't upstream so
> this is likely not the best place to ask (and maybe why no one else
> replied). The underlying qcm6490 SoC is supported so it's not an
> impossible task. But to answer you're question with the current status
> quo you'll need to reach out to whoever or what ever project maintains
> the fork.
>
> Peter
>
