Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52945C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 138C841197;
	Wed, 23 Sep 2026 21:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gBZeoXqwcdUX; Wed, 23 Sep 2026 21:08:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 63AA3411A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790197725;
	b=eYgDzIy2uAkUoziupVWbQZvvC4rqiuJ8eZ8hSGnVY63vU7B7evhWKwoVBitv1nnqZKZX
	 zHH7K8VI/UJoOev2oJ5f8rkjQhSew7dk4tVRGJYjR+dnFuiBqlWxw9P16x5viyyw3i1FP
	 ni+mssXDxd9+HV7Lqv0f9aONVyLuS4Xr21UtbwTadohyoYDpXRnShahhuHXNXP3kmbvcj
	 dJS/3nEh+befMHBr8WPvncaoossvGgBF7ld/SfQfe0qtk4tLcsYO1UwRIVAu4Yq5uwpM1
	 w2tHD71MpSujS0U/4cr4bZAbICbtX00HD22YspMo0krGhyOVFGGn3XoW+BWltEbDj0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790197725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xSdaOiahs5b3gU/6IZXeIE0qcOzsxQOmcU+kUr1L19c=;
	b=f4fDPgmm0vzoK9XgCYu4uGsRXw10hSGYHZb8cQlHVOBlIlNvT/rwCA664g6EGktbp89T
	 VLPyAf0wQwLhd22cgLq0rtTYeFnFr2qx8W74fyLof9/QIfiizmK0WHp+SJ4kpy5jC+tdI
	 3UUP21U0HyRduYLJ51sjGXgBuenDXhFd1sxBZgWNm1LEDjjBAXYUGH4jQ9BrJStnuNxlV
	 QPnjf22T3nzeiO25bKqNY2AIi8qb0AZ3FyrCA7L1cCs1mC/EQnJm+F5SJHCVhK+ErDbtq
	 W8OGwjykYL8V16x2YME/S3xq/qldHK/8WlOeAPxIB0DgtIW2B5r96A1d6wv4iweFRjA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790197725;
	bh=xSdaOiahs5b3gU/6IZXeIE0qcOzsxQOmcU+kUr1L19c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S+KC1qo/zEr9YXjIJ0NTiGXXjH/oTrMhcA3uG2w1PhfKJYVh5XXFiTJoulcR8NSUc
	 u6fD/kGXHsyHOZfhUay0Y0I9ay+rCrQT3MWjTC3kcHIxIwRfSXO4tdsPa2n/xXs6tN
	 mjmaIHMEhXMf0B/P5S8yJUak8oNcNFrwflwc4peq/XuiuOb6A4ao/5/R6WBIDuDKFu
	 4xlrflEot8CkE4WphKRrxynOASKGjU7mF4e8/bgtChO6d6bIi1xj84go4mLTzqlQhL
	 4Pi5Y9r2LpCGI72T/OKqIENPlniq1paUo/0iro0Mleb8dsRx3PEf9eeaRf1oETZtQH
	 QxpJmLBCRjDYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63AA3411A7;
	Wed, 23 Sep 2026 21:08:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ECA432F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E89E560BDE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8E9HFtZBPq8 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 42C8060BDC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790197723;
 b=UsPDsPiL+gylM5w2+GeHW/F8j9h2TPIzAdOVxKBWcmKJ1vGGPfYIG4Yqzn+wDMDBpwDg
 xkPJ4pIkpKMnCUHieIc0seBXYtbwRFGikBd5AjikbLY02Ccyt1u3cgI+TmmIfFtlrmWpA
 DPmy5jfptvlWMUxq7Hcd52KceXjjoFS6v8R3sQyHDHSroChNXWhIRzlTFf63usmK5KQY4
 Mx3HauqmrwNvngvmsf1jn4Xp294+2HN5MIOyFZWXuU2gmHC66aERsl1zjGno1fsZiSQhW
 i2gJvRs4y/oq/NS0YPP9m0D7oPowewHj57eORxIyKqNDhGRK1ZIFv4cmeit/oKNWsnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790197723;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=xSdaOiahs5b3gU/6IZXeIE0qcOzsxQOmcU+kUr1L19c=;
 b=lO14p2oCjBaadTaVQgRM8rP9r5AyXTs3Py13luuFEY170Tk0PfILVF1ElIBTeU72mdmt
 JQSo4qnDeJNrI1hIFiLO3cXyJ/djY1Ye829+NtoFPCQasN0K1c4VOiKjUihqrKh+wxXfG
 Uvg7VW5ZAt6uNJqVGbifkuc6JXHZBDCJfirZHBFdpu58y3FzoLDci+N8MErTr1OgDJlIb
 KuvYRQ2dXcU35xRES2ISAfIkQV12CiCL5Ot2Or6r9V54M4qr0vBA0+rmfy4JT8XUtJPGE
 uvvKfubk0K21TZdJCqWc5mIOz6/6zNBrgiCUITzFW+grMT64AaxVz1CA5ywCTlGX2wg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=macvvrIc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=macvvrIc
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42C8060BDC
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:08:42 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso1015128a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790197722; x=1790802522;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xSdaOiahs5b3gU/6IZXeIE0qcOzsxQOmcU+kUr1L19c=;
 b=macvvrIc3fKh/PHUOrBxfKMuP4KZ96qDVFzNmBe3NzxYnDSfLNgvBwGFwAVrKFLlho
 drDxCuo17L9VHyAVVV4/vMTSrfDwVFBK6wcjANxgHU+xFKjhByTlxrFtz/8JfQMGv0ph
 apPDSxuylaQ/LseGFJ2vxD1fToBM7PPedCk2HXYKAXfhfDyu4WDjQKOGaG6ChD4J79G/
 YmAlmx12fWDTnMheFwYFh/z2t6qbRLA41Y2eOgeZ4JFaJNKj4mEm48IzPziBlEnvJYK2
 AR05L/EHY+k+83TcyQqiIia56tQEXkOM3r69+hzAgiJS0iAXQyOQQtoSEshEc+GPs+r9
 9P4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197722; x=1790802522;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xSdaOiahs5b3gU/6IZXeIE0qcOzsxQOmcU+kUr1L19c=;
 b=Nmlne6V13YHfome0TUHieg8Z2pom3QDvEuszKKoQ2ioicaZCUAfwPO1LkK8T5R4Z6M
 aCZih22+oaqMVrBP3Nm1VlJL0XEx93NHtxvojNT3pV/gzdp8UPvAGogf9eoaz/y5YXH6
 1/TI9B0fitN5TvwG/SRMRY8bhoq2uyEtvn2hGi/l1rwyv0wu9+Rq1gHUKHBLxqI2xsD2
 sirrgHgXvF7sjiw/I2jODMPzEm018X4+KfEpmUJTlAIIMltSyGqVnIotuLc6gkBoAkC2
 TmmfQHc614yq7Fr1RvzfvPDdrTx/gUKSVD8us8qdydLdY/cNKQMkUW2s8WRLo8lN01+h
 iPCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9mCfWDrhwn84LAH9Qc2a4ms7MMqdK1q6CvA8n7cHojz6Oeb+01KV/e+4BmB0TvrMT7froJzs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k+8cK5ai9iqUztO3ff6mpn65GWzM06I98GU8THKlmEaX2V8oiV
 M+0p5TvemURJTH7BSNLdQ7TsHE4btSiTpp7sWqL/dnu6wJmdSTZaI3sK
X-Gm-Gg: AYBFou0sChMgP5BXuBJ+O/9iUpoSNR+EI6X9mIzMQLv+9PkHonUhjcBwDaiSDN40aXv
 hlIQvM1nsw5gE0Qt8P4dfO6GLVJWFLpU0MDs6Nr4v2mOQNNI0or4ShCHetv2mFViF1p+0LItY/Y
 b2mW54HYlRHajUt2NFGSABWB1VGfHDWiK74+X8MYOtopQvWbQSYKiVQ4A62PZlvTer/qFm5VHt8
 cnHM9Wtl8NdA+jbupOsToEPazgpFdxRqMQ5ff0+s8mJjss6OfCRfOd6h0imN5seRAOTsjxWFRWt
 5eG7KLGxW9F4jw+/NKzDfAiDKmLRNAwUl3Du+JgEQhUnhZPKAQOIkTSUO4Ph+10HIp60lDjVPyr
 fQgbfrR3WTJ5w+5TAydg1g0Y+Bs63ZVBOkVhPh2Zw1raN7OZYpis3OghIZPqYyUpn+Za7xok6VP
 FMpPWHDnMstCs4y0z3X7NQqD0u9aSP4ZMaDYyMpK1MjDC22o+KPd4pSUi5e16ATHOki34n/Fs=
X-Received: by 2002:a17:90a:d607:b0:39e:6c6a:656d with SMTP id
 98e67ed59e1d1-3a09896a58fmr293602a91.48.1790197722152; 
 Wed, 23 Sep 2026 14:08:42 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a097340eb3sm823497a91.12.2026.09.23.14.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:08:41 -0700 (PDT)
Date: Thu, 24 Sep 2026 05:08:38 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 5/6] test: 9p: Add test for 9P filesystem
Message-ID: <arQ_1vDTqU9d8uAT@google.com>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <20260829192119.2658328-6-visitorckw@gmail.com>
 <CAFLszTimE0ZxNpYPjxDZdOQD4=ordEzcwgpnoGihYBN499edpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTimE0ZxNpYPjxDZdOQD4=ordEzcwgpnoGihYBN499edpg@mail.gmail.com>
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

On Fri, Sep 11, 2026 at 05:44:10AM -0600, Simon Glass wrote:
> Hi Kuan-Wei,
> 
> On 2026-08-29T19:21:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > test: 9p: Add test for 9P filesystem
> >
> > Add automated pytest for the 9P filesystem testing directory listing
> > (ls) and file loading (load) over virtio-9p in QEMU ARM64. Also enable
> > the relevant configurations in qemu_arm64_defconfig.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> > configs/qemu_arm64_defconfig |  3 ++
> >  test/py/tests/test_9p.py     | 82 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 85 insertions(+)
> 
> I think I saw a change to the hooks for this, so I assume it passes OK.

Yes. I tested with:

gitlab-ci-local --variable TEST_PY_TEST_SPEC=test_fs_9p "qemu_arm64 test.py"

> 
> > diff --git a/test/py/tests/test_9p.py b/test/py/tests/test_9p.py
> > @@ -0,0 +1,82 @@
> > +    output = ubman.run_command(f"load 9p rootfs {addr:x} /non_existent_file_9p.txt")
> > +    assert "bytes read" not in output
> > +
> > +    output = ubman.run_command("ls 9p invalid_tag /")
> > +    assert test_file_name not in output
> 
> Both negative cases pass for the wrong reason if the command silently
> produces no output. Please assert on the expected error string (e.g.
> 'Failed to load' / 'No such device') rather than the absence of a
> success token, so a future regression that swallows errors still fails
> the test.
> 
Ack. Will do in v3.

Regards,
Kuan-Wei
