Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5BA606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B4ZJ3oFB;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qw+yvY0+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AE8860642;
	Mon,  2 Nov 2026 21:19:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgVTlFbXnILE; Mon,  2 Nov 2026 21:19:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 802BD6060B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793654370;
	b=C/rXN1qMim3wAyj5iBkZugWWjDaCmGnalj2U85/rbcIqeuEBPR7y0Qas25lpNpnPg1T3
	 nfd6XKozk4IspLKt4Ndr9b/3jUEnbKRT3joFrjkuRUBP/WTCj8MVMc7jF6FwVijHV8uOd
	 5SV7Ufyfe+CLGvwbI0bB93de49NeRLTYs4x6nOlRY6uty0vK2g/OeD9gz7zMXUizpQ2/Z
	 Pb3z+A+Uq6JX1xwo05aAO9TiPOmXIAyP9IJsGs4a07xQ+QD3MZSyVKLSbe2cHPAi7SQfx
	 p+rnwEG1mwM2rTjBtx4sD6do31bKJovnHMYh7MwmWrdGf9L18hoOC9Fx2QAo+obzNzw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793654370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dLyxCag23u7xSJdSU5zN/+6Q1pkJ1IVLj/S6M72X9/w=;
	b=JXWRADG5168kHF261SXtVtkPRcfVRvFPaFa7IBdbSZQoPNhfHq8fnqlz11Kre7k+kVCn
	 E8/WFHYdVdhyh5tIWOPiRvB7FF8FR0hridoBfr99ZSl8VeGyAC0+AcyEhRS+PuY72njVY
	 acr/O7ui9cbqB6Vw6GF9efq7rOdGJow7zm5OScjp8UsSi+rkE9ArMrLhQkhDK+XCl14rJ
	 Xt6+epSoIcyGuZOz9kDmZWfwOB/z51BDDf+7LywIAnb8YOrJtNMGF1zqYdmNTIEdyVayv
	 kwmetlLX9i1zU0GiZlIcANPtdJfzACHscqc8uFBTWkIMvIoPLQyYcDC+R3ImzglIUfw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qw+yvY0+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793654370;
	bh=dLyxCag23u7xSJdSU5zN/+6Q1pkJ1IVLj/S6M72X9/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B4ZJ3oFB5hjJFP04hkaGrPznlIUc04sfiDkrXvZoNnCtPK1NJO4DxhkWFZvwGSnJ6
	 TTa7gB3LfjAs4ifqbA3Vw7OGPXWGvYAI/8zl/x78cxxvkSQhHwL3KMfit9ByRCB7Wr
	 Xl/EouSK6WyHEIH9op0qPYhJri8KZdeHLy99cUpOzFLttyVA7KgBKQSWSnVzg38KbY
	 qlyRVbLVR4dq1+gHzXOJCkqmNGpnwFYrAUddQvrC9uE27h7ny8NjPQS1mz/golO/5K
	 QeShMb3xb3k6CDFN3D7Be6kjRCEVhCdPUgx8FZtWVOepfao/UgklXnkg+Q/ZXVNaYm
	 jfF3QIF+YSJAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 802BD6060B;
	Mon,  2 Nov 2026 21:19:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CB8FC323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 21:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B15606060B
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 21:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XvclkiVis7m for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 21:19:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DF3E46060A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::2d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793654368;
 b=VElo6s9rwUmOD6AGhukdP/u8aHB5cW0QnstyDhmB233uYXTXuAlSleQzWSqH3raLE45r
 OzP0/1NJCOvKRi42DfRZjUWWvdYgmRq2Yszo1hDNPKa5bGPtQo0YxqJtY/iX/IaT4x/Qk
 zphtFu+rbYiy/0Dt5UxLxwk2Ans90JlYgolYDM6pZZZJqJJFw3UPN8TQeKOSTtoTTiXwt
 +xVZ+WguGLozwHTm6VbSkNXTruzqbNTCxPXhMxbrgtdwAoWHnYM4pl13RPDDeeefCzyJx
 SikQ8MtyeJfldaz+XXeHjeMplIo3iRWVWmLeVf8iyFmJNB8CejpABe9D8NNZ+bWViHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793654368;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=dLyxCag23u7xSJdSU5zN/+6Q1pkJ1IVLj/S6M72X9/w=;
 b=mGwDLOLbMtC3+rxWITQ7iAM5rX9hy9QotbslqIl35Rp+ZHwTRMqE9jWCilSY6gO3blvN
 8xbQoFdW6zezaShZ9ca7iQwpqstfx83xcgUFIpxbRDX0dMpRJhC0Aus8FuZaagfxQitx+
 ZjRKQqt/jmGqy+wfYzSNDZL1RM2fUTyPtbzOyf9Pz0tnPru1ijjEi2oxmD2b0NPevo5JG
 3GRjrca4bwzvb7/1vB2x5q05FqpA+07qzibgN1HFpMYzpWZglmnG7bpCuugQIgR7OJPSr
 sJdUgKu3hEFNrmJ5MJvadyKHPAJRTkBuFoNCTnHGsL4jcJPA0axswZ3JrbPpREBH+dA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qw+yvY0+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qw+yvY0+
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DF3E46060A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 21:19:27 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-48ed188ee81so1773059fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 13:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793654366; cv=none;
 d=google.com; s=arc-20260327;
 b=SLIQa6vIwOT36/RZEiCJAViYKBjrZyMvSi/9zsebW7/gKGSh34AOwCflAB14apoKbp
 CiZiYBkIjoMgImnIjn5wrPxuSvjyejPu+hlZfgLB43esiiGbCxHe3suXNou0tu1U0AqD
 IM7y5UJMYRo2n42IILxqi6O4qGg5WQdXNcSCqq6ss/FzagVAzvso4Z5hfA18ZpjpPllL
 CKabPzJwzUcWCQUU8CtTcj0Tsd7qlblgn87GXyj1RQcfp/SCIiFWy0EuwIdKslEqpxqX
 muX3q+2PEHJBYk1fwO/h9ttnudWGTqOpDYYhYo/8PlQGm15smz8BbI3Cxw8+BFVA9DkW
 t53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dLyxCag23u7xSJdSU5zN/+6Q1pkJ1IVLj/S6M72X9/w=;
 fh=lDezZ0s84rBnfYz79nzyXVc8ZhijTkHaeBuZe9Bti5Q=;
 b=B57qTghwBqezJcSU+zh0kaW9OxzOlKnr88Eef6W7gB39OHZP5BfwHDqlcVrsqXc7U2
 Dcsfhi4ROyNsYEL5VfN1M0LTxHHTm0rxVU6EesCcqhw6VaOGIeiKUSck79LeQlZwXLx6
 9FbTRbyK5zLut6d09nLixBO4VeYea3VbrefwBxamv7DpYiEGa/HF65+OOFlqnL1ks/+f
 nxCvbHg+r4AREOL7/DzWH6+QKRj/GuVWcPdo12DkIQq5w5kvLAjkaCGsUsFiROpzj7fg
 4p9YfpCFT8kreQHt5y8WuVMdpeJ41mSrk/Xqjg/v7adB/OLwcQAysMRxGraidccS91Zm
 UfhA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793654366; x=1794259166;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dLyxCag23u7xSJdSU5zN/+6Q1pkJ1IVLj/S6M72X9/w=;
 b=qw+yvY0+CngD0lHibBbu6qpx1jqLk5v4PF/nFHYbcUJkl65h9hfNcsQ5rg/UyMmzVr
 cDMPizshtdiGZRG7L6fDwfC+D0f+KihMZJNbtLwroq2i7yD77PT3upT02ZpLeZgtrzc6
 I3A4ZbFbieVVzZ58mdH+MGJnDUMhpa02DIAmuEPkCS54/nxvzzGRw8EWxrnJp10iAzva
 lXYg8uGc8SBAC/pp1wi65NnOS3O1PpnuYov9G7bWoNakG6kU9DB6QRFjq+okwuFXkDIL
 GHAz9h9HtYj9TU1to8k2RDRU/LimAFCOBn1CmK5q+FpWKD3pkG+NnOoDX6VZ6ck/rn3X
 FcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793654366; x=1794259166;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dLyxCag23u7xSJdSU5zN/+6Q1pkJ1IVLj/S6M72X9/w=;
 b=lRJaTMGJblqiUTBW0pK1re635yXWJA1zWjLXibEx0VoIV2zjGZNo2uYeRMNHP/j8OS
 NtgKTBTExWslMlAtzgETIOkxLDYEquZJy1s7EVbOlVNaM3ncvkv9fcru+izWVehftIJj
 mQBgc/5VGFV/PnPEBhv/IA5w40tXqHfQkNNBhYQt1r/1Qzvu+ABBkrikidF0ozW+cSx4
 F948hLxDZPh/ETStD77942zbECiL/T6aDvma/+3irnd10VOE2OTrh+A6OPg9WCzmKq0G
 iNzD82b8+T0zVy+Ct9JtbvpaH2cNY/ONIq073Eg+lZlV1ymu6CiAG4uhFiWtlktRBfXW
 sGMg==
X-Gm-Message-State: AFq9FYJNSJEwMl4197Op3ebo8gq/RuojkBZvvTowVxg9QGAT65I/DFH6
 QcYGZiTYWeC/+7tL1eqEqomE+xVd10f4GvAqpiofJyd2GyYIycu1n6w+4V3XNvkXbgCqbEAQBnN
 lmHhwEBMIV172l2xVDH65J7tSu795rPg=
X-Gm-Gg: AYBFou0k/zUhGHoJ3NUFreGe3R53kS+z//GcXp+Awh9+vIb/BBMArtKAunR18CNexgG
 lsARbcWeus3WllvqIE+Bd1UNI3pRN1DbMzw4MxKti14gPKjFS0naV1r6/lM3VY5qW+8QtcRfHew
 MTN4BBnw/ZtAH8S9XlcrktzkqnmX5oYEX0LXeM+Lgbzm6hkzz8cO+S+MXzkW8mwLSON8hb4GhTt
 nQbjjLNK/06zDpel3oTj8zo2Lapmy+nEqoEb2Zt8taflGdGbd0v9gQzLaiLzIpTHKh2mXjH+/w1
 Rp0FlrVqf58dM48tDVtChtx7w2wnJV8X+MTZxRCbddCEiA/uXAZr9nNSjd982xHM66E1QDFvwRG
 VPiE+pd6adisUh6y5F3+YJlgfiHwiAAvSKlTETz23hGz5Frxz2BerBZvF+FzDOtjWgrKJ
X-Received: by 2002:a05:6870:bacd:b0:4a2:4e0c:593d with SMTP id
 586e51a60fabf-4a907705590mr6985074fac.31.1793654366251; Mon, 02 Nov 2026
 13:19:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029173443.1495866-1-maxin.john@gmail.com>
 <20261029173443.1495866-3-maxin.john@gmail.com>
 <CAFLszTjZ1XXUYvNoUrBo4ny+dFKP=0=q_xcOobs3D0Lsqdi0AA@mail.gmail.com>
In-Reply-To: <CAFLszTjZ1XXUYvNoUrBo4ny+dFKP=0=q_xcOobs3D0Lsqdi0AA@mail.gmail.com>
From: Maxin John <maxin.john@gmail.com>
Date: Mon, 2 Nov 2026 23:19:14 +0200
X-Gm-Features: AclHuK8xpXfWa6x5C0n_3VoaDpYTi24U4pN32ObtGJ50QvLvNLZ_qrezgnaSZ0U
Message-ID: <CAMhs6YzVkpL7JsGmqsVLm4nw9dsUgyrWJGWemjjS7OeDZR9RQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: cmd: add tests for the binop command
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On Sat, Oct 31, 2026 at 4:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Maxin,
>
> On 2026-10-29T17:34:37+11:00, Maxin John <maxin.john@gmail.com> wrote:
> > test: cmd: add tests for the binop command
> >
> > binop has had no tests so far. Add some, so that bugs like the heap
> > overrun are caught in CI.
> >
> > Each operation (xor, or, and) is run on hex strings, env vars or
> > memory, with the result going to an env var, memory or the console.
> >
> > The tests also check that:
> > - short inputs are zero-padded
> > - console output wraps after 16 bytes
> > - bad counts, operators, addresses or hex strings are rejected
> >   without touching the destination
> >
> > There is also a test for the heap overrun.
> >
> > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> >
> >  test/cmd/Makefile |   1 +
> >  test/cmd/binop.c  | 192 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 193 insertions(+)
>
> > diff --git a/test/cmd/binop.c b/test/cmd/binop.c
> > @@ -0,0 +1,192 @@
> > +     /* Output wraps after 16 bytes */
> > +     ut_assertok(run_command("binop xor 17 000102030405060708090a0b0c0=
d0e0f10 00",
> > +                             0));
> > +     ut_assert_nextline("00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e =
0f ");
> > +     ut_assert_nextline("10 ");
> > +     ut_assert_console_end();
>
> Please can you add a case with a count of exactly 16? With the current
> loop, i =3D=3D 15 outputs a newline and the final puts('\n') outputs
> another, so the user sees a blank line after the data. If that is
> intended, a test should pin it down. Otherwise it is worth fixing in
> the binop clean-up patch, since this is the edge case most likely to
> go wrong.

Thanks for the review. I have addressed this in v3 of binop clean-up patch.
Also added a test for exactly 16 bytes to check the extra newline.

> > diff --git a/test/cmd/binop.c b/test/cmd/binop.c
> > @@ -0,0 +1,192 @@
> > +static int cmd_test_binop_invalid(struct unit_test_state *uts)
> > +{
> > +     /* Failed operations must not change binop_out */
> > +     ut_assertok(env_set("binop_out", "deadbeef"));
> > +
> > +     /* Literal hex string: too long, odd length, not hex */
> > +     ut_asserteq(1, run_command("binop xor 2 010203 01 binop_out", 0))=
;
>
> run_command() returns 1 for every failure, including a usage error, so
> these checks cannot tell which validation rejected the input. For
> example, if '*nope' were later accepted as address 0 and the command
> failed for some other reason, the test would still pass. It would be
> worth making this a UTF_CONSOLE test and checking the error message
> (or the usage text) after each command, as other tests in test/cmd do.
> What do you think?

You are right. Updated the binop tests in v2 based on this suggestion.

> Regards,
> Simon

Thanks & Regards,
Maxin
