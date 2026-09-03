Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD86C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52D8C80CCE;
	Thu,  3 Sep 2026 14:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c98IRXCO79cF; Thu,  3 Sep 2026 14:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 709AF80EF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446427;
	b=ZUsTrGqKjgfLLHrvREu7DEL94GwXaTPUOijpiwy0e1lzhEPLpeDZDPK8I9D5iV/E0xvW
	 +854r+LSlXGf9v7X3MuAdkz+piYhBlZXqHGolT+RiDy/73Lx3ibbH2UM67T1YsE2SzwZa
	 hMJFOfBAo3QkcS5n56mJJh/Ep8PZjqzZIO/FIC6BQbM7VFYgiyawNqInMoNXDDvIcI0j7
	 yl2Lpy2Dj9CciKfAD943JrjUTDiR2j/D24AjyNKQNcspqnPTWl5mmgBXPlYrdpN3vVo7w
	 mknWFCZYvyAl7P7qBF8w0sG3ht6RUpiU61lCD9M6PeR+f25HID0zTb6zlPjuomwvzFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VQmI3jE8Z4C+j/KpKIb1GD2TPhBq0msnQSqfFkR4Eh0=;
	b=VSD9i4OIl3syZIPpECnMTKioNats0Xnb2CsYkUfp61CANj4gvbgJjDA0Jex2tf8FUyAE
	 UiDtAUeY1wPGo8pzY/kxMQQVq2ZMgQqb5GBf+BHMW3M0oyQIA1yLUkY/Ho7Ja3mPypxuR
	 MAx7iLueW2cxbtBCxLT1nd44SniEuYPtW/dBTopubfqbN7uNqH0YDJogi0KdLLXzBP/oR
	 SsJz6aNZurJrhi/V3TmrIL9QVZpjgyHxOz29OGKaJH/N1rVmKkEUHoOLnzeJFkKBXtLhP
	 obvEoRrD5sR0rMNnWJlwSIkTNWb55IChekXt+XuS0qD1fUusInTCmMWlqdiZGKG4CXA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446427;
	bh=VQmI3jE8Z4C+j/KpKIb1GD2TPhBq0msnQSqfFkR4Eh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZAfKMy8blT1NImo8aqZTZ0QhUX/B4hL8d6vKuhcp+J3I86+NTcR5FZgutvJorJfV
	 5rs1oA3reGm2JMA2UvaDjl/cwRfTl4Zk/x8j/+rGzuW6UzjIvNJNzCXNUqfsC4Ev1C
	 jzGUAGsWjWvPP96PrWbT1Lvxt2lyxQGk3aoPQ49w8mw/imi8Bh2N1p/DZiZQfSe7y2
	 UDfvXrkovUu34DIR0MGAQqbeRiQe7WQgAmERn/UFOR2rhcrptCCk/FVEYy93YJr93w
	 y8Dzy7PjgZk54KxCEQipTy5+cUM9P0kOEgmibFPMxOAhSEiYnjpxuiCF/MH0G6jGyh
	 IHaMrrIsxlUxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 709AF80EF0;
	Thu,  3 Sep 2026 14:40:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78EB2498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F35E4046C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8RLRfnE6O4l9 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 80CE440469
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e31"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446425;
 b=fIkwHEaO/Q+/sZTrauPCe+gQUPznH/3dLHp7yh4f/uizDqHykE9XiWwJgpXbOXcTQqtj
 BgQe5u2JXpKZH7t7gd/B1UJ9ILpAX8vtawtVbDamoxBQXBEgTr3WV9Z/5kTaJyCnU1APh
 CA3EsL2mfwHkyLAc3KY8Q+mDgMKYUjvDObv2D+AcNHM8tESAMlkIGzzu3SvRaIVHDuJLW
 S3NuRR4/KyMk1tZ49enKJncpmJn3JlH5dmajSqoCFs+4DYa0dU5ddBNw4IMkeJR+cUMGk
 1+P1HW5FOEjvdOEn1PwRqW7udQQJRuPZtZMEOkwYCTB9TF7PPgNTmoiSySiym6wPoTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446425;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=VQmI3jE8Z4C+j/KpKIb1GD2TPhBq0msnQSqfFkR4Eh0=;
 b=OYZ6ERW1UNxcUt2CEGw+h1y/UKSi0Yy0JaB1KyQuEWlF/CGIFHrr09CQMcBB/duWxfDT
 Yu1H/fgZ6W+hyqYGqEJHcatu1kpJCAAO4FBo2mYm6L344LtPXYQ3pkA9BhsKmU9N2qFFI
 4kau12lJ9JYdWtnhAEgTq9L0lReMSF9geP7Ig0zR/+14Tpz6hxXeC4QD4OwKKWyRqqstz
 hKKp+isSZBUUPrCS9HPkKR6xtIxnuRb8KbvPNGWx5zV3lkGX8RgiRrGiGG8PnAFdOAwNw
 a1/K7v4IzKXtvMsBcAaWASDrGk2gO7FuWYWBVZcXVyBLDwxeyq01rnlhKsoz5J2ZPVg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X7Q1wmxc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::e31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e31; helo=mail-vs1-xe31.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X7Q1wmxc
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80CE440469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:40:25 +0000 (UTC)
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-777ae5e5caeso943709137.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446424; cv=none;
 d=google.com; s=arc-20260327;
 b=Jkj6SwiYv7hNuOtAedZm+pVAh3HMPNdBclWugN6ZSV5Xh9qJTKWkTPM1RH2vq7tx+y
 iVQ4l6jP9Cy+aC5dXk7CxcwZ4IXML++RuR94AmNG/jSADyMJ0MFV2ey1E+4H+p4G/6aI
 Sy860Wt1FShi9t/cQAhoOYiOoPaggrSxAvXOHOqwlevpofZazaa+ka7EOHItVH5kOgLS
 QBeO190Q4S5jDnjiogV0Oj05z81TnvTrH1JAWKBsv7zH4AntmvxJhoGy0tyzF4mwp35h
 tUTzWJr1Uphy/Xv3G331pefUJeV4Yluoag/nWmFCXeXq0SdYKx9IGgf5EVpf3n3gvDL6
 C/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VQmI3jE8Z4C+j/KpKIb1GD2TPhBq0msnQSqfFkR4Eh0=;
 fh=j1+3ncv9EdyjLkLf3b38nnV/W2KSGkrnyRbGhzSUWiE=;
 b=DdPr2d3H0LmbCC5pnc4D+1DwhaX+zGVgsVW3fplkVF+ZajYgpDw2+C2PnifjeZChpF
 CnssRdWJeFiH90tTC+JfNn7iA/TWtWZMvi2nKaM3SHRf+sqYqE0KpV9O1+EGE0J1Z8ji
 OZgETvtzz4b6ZPU1JA0mCuRPZV9TCWfy9PxwUTPfibVufpyKMXF7krkUB5L2I/SlQBGR
 R+GxE1hOMyF5LY6lGliHbX1Dy1tRCSqRNcaOklN2hlKt+OM2oWWLI0QJm2KpaoBNSwkE
 /zAzts3BrzuMYj8lrSGusCxKcCTjWSkmitcXgg1075v8rsXH0NpOw2Hoo6N9ShcCuf7+
 n3SA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788446424; x=1789051224;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VQmI3jE8Z4C+j/KpKIb1GD2TPhBq0msnQSqfFkR4Eh0=;
 b=X7Q1wmxcGIUSp+2teJlvv0UtDXd2hN2ZKE62nJ8IPlq0ePqAwFsPDulGdVfufNP4r6
 wC8JSuW+Wr+nQ0YPkQnZeLy+8Kv9SEFquLGVMIFRg3kOZg20o+FnXCLpxv8hQjN2FmZN
 ldec35wrdVWAgnosM/rVrkoAXxSHrmnfUeeyM/gNHE+GMDd6NsMXlWMPI+Whti4BNBAe
 e1cncmZNcn8xvZjE+wYDAoXnAJv+D5tS9laAIpEs4YR6IiE9c7lYjB+i10lBNDX6YGgB
 EtJvqAlBDbvoc9RghSIcor+YeE0ZckdyXKdPgAsvhWEJ2ZVvyTwUqs1kvIHtUqAFVfaY
 JEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446424; x=1789051224;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VQmI3jE8Z4C+j/KpKIb1GD2TPhBq0msnQSqfFkR4Eh0=;
 b=m/oGERNqgkMbstSR07b5W12+MXcUiy4lX1oiUN6Zodhlp5tFv2abYO2c7zWsJULhFn
 Q54ow4mQoTJQWesS4Ik18FnNbFvSfLhNKWhftgWl+ihrAZ/ecbvjQIu6nCzD8gWHu5+J
 ptT4SK+ONiY7sMKolBGPdvcTOTLZ2eG3hV/NIRvUUKieTQauK0gmgWdquVdOFeLI0t/G
 ycSUBVCEImC1xuzbh9C8drnvpKfKagQT2U/CMozWkKlyG9RSXWgGXHjjFURua8kq10bo
 Z9kH2+qYUjKBVN3ppKOOKuFJWJktTRHrC14IW17TRG6IyRmhhS63rXcQZLRYyfxKrMp9
 7EjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhUZxUz7J4ojsRSqFrervtmO7cpsnHiT5/V8hK8zRUx9MPhLL1s9nMiw5kmzMweLG9Nut07/4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++klZ6fKDwJjBR6lyr+nq61fsoJ7+7RDd2UDBgMhilVGjFeFQI/V
 BeTCtzq3moOvoynoZmo5yHTT1xjKoq5BaQU2Yvlvz2HV3DgjeA9LQrZjD61THo8HQ1UZS3ZecY4
 TSfHZBCVoC2vB46Cpnl4Qv5RaZO5R08I=
X-Gm-Gg: AYBFou3eQ+G5PZjFtmgl87mO0dJiNhhw3EhyHUQ1DpXgeFALlmJhK09xNXAvDi/E5xl
 8vA16eOSvVJAz7wUCT/5fAlENbb+dRipBNiHK81IxffUzkv5tWQnXKg5jzZYLD+su8HL5pq2nVG
 Mnxnm6UBFdaSQ96zy4pxt3jOoiuTK5eaueKrXJUlD/iE5mEmOdJ+BQM1agj2erWaEzwezeujsK8
 ks/ctHRKFD2eL1fJPB5mWZUkLSAOq9Xx0AEFqJfbCon214xan7gRBi5k9NCWaS2833JMDnug2EG
 kzGEJeyLLcqTVUmcADXARSM0j2hl0pdhYlIBZjkBkakPmrzbNll/2tUgt4s=
X-Received: by 2002:a05:6102:148c:b0:785:e069:6c5 with SMTP id
 ada2fe7eead31-78a1f34b35amr4241942137.8.1788446419251; Thu, 03 Sep 2026
 07:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-15-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-15-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:40:05 -0400
X-Gm-Features: AcwNN1XkVCH5cC72BSiX_90V0L6F8dBBkYyi6ag-EhehS_MzEAABeF_37Hzb3vw
Message-ID: <CAMDkj5zedYza4qwymiDxOQZywugFwv6kTDRBmVbDyOy5eqL_-A@mail.gmail.com>
Subject: Re: [PATCH v9 14/15] test: py: vboot: prepare test for global
 signature with ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Philippe,

On Thu, Sep 3, 2026 at 4:17=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> The vboot tests only consider rsa for test with global signature.
> To prepare the integration of test with ecdsa test, the signature
> algo is now explicit.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - no change
> v5:
> - no change
> v6:
> - no change
> v7:
> - no change
> v8:
> - no change
> v9:
> - no change
>
>  test/py/tests/test_vboot.py                          | 12 ++++++------
>  ...binman-pss.dts =3D> sandbox-binman-rsa2048-pss.dts} |  0
>  ...sandbox-binman.dts =3D> sandbox-binman-rsa2048.dts} |  0
>  ...pss.dts =3D> sandbox-u-boot-global-rsa2048-pss.dts} |  0
>  ...-global.dts =3D> sandbox-u-boot-global-rsa2048.dts} |  0
>  5 files changed, 6 insertions(+), 6 deletions(-)
>  rename test/py/tests/vboot/{sandbox-binman-pss.dts =3D> sandbox-binman-r=
sa2048-pss.dts} (100%)
>  rename test/py/tests/vboot/{sandbox-binman.dts =3D> sandbox-binman-rsa20=
48.dts} (100%)
>  rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts =3D> sandbox-u=
-boot-global-rsa2048-pss.dts} (100%)
>  rename test/py/tests/vboot/{sandbox-u-boot-global.dts =3D> sandbox-u-boo=
t-global-rsa2048.dts} (100%)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index 89876ff030a..e3996486ab6 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -536,7 +536,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, paddi=
ng, sign_options, required,
>                            dtb)
>          run_bootm(sha_algo, 'multi required key', '', False)
>
> -    def test_global_sign(sha_algo, padding, sign_options):
> +    def test_global_sign(sha_algo, sig_algo, padding, sign_options):
>          """Test global image signature with the given hash algorithm and=
 padding.
>
>          Args:
> @@ -545,14 +545,14 @@ def test_vboot(ubman, name, sha_algo, sig_algo, pad=
ding, sign_options, required,
>                      rsa signature algorithm.
>          """
>
> -        dtb =3D '%ssandbox-u-boot-global%s.dtb' % (tmpdir, padding)
> +        dtb =3D '%ssandbox-u-boot-global%s%s.dtb' % (tmpdir, sig_algo, p=
adding)
>          ubman.config.dtb =3D dtb
>
>          # Compile our device tree files for kernel and U-Boot. These are
>          # regenerated here since mkimage will modify them (by adding a
>          # public key) below.
>          dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
> -        dtc_options('sandbox-u-boot-global%s.dts' % padding, '-p 1024')
> +        dtc_options('sandbox-u-boot-global%s%s.dts' % (sig_algo, padding=
), '-p 1024')
>
>          # Build the FIT with dev key (keys NOT required). This adds the
>          # signature into sandbox-u-boot.dtb, NOT marked 'required'.
> @@ -561,11 +561,11 @@ def test_vboot(ubman, name, sha_algo, sig_algo, pad=
ding, sign_options, required,
>
>          # Build the dtb for binman that define the pre-load header
>          # with the global sigature.
> -        dtc('sandbox-binman%s.dts' % padding, ubman, dtc_args, datadir, =
tmpdir, dtb)
> +        dtc('sandbox-binman%s%s.dts' % (sig_algo, padding), ubman, dtc_a=
rgs, datadir, tmpdir, dtb)
>
>          # Run binman to create the final image with the not signed fit
>          # and the pre-load header that contains the global signature.
> -        run_binman('sandbox-binman%s.dtb' % padding)
> +        run_binman('sandbox-binman%s%s.dtb' % (sig_algo, padding))
>
>          # Check that the signature is correctly verified by u-boot
>          run_bootm(sha_algo, 'global image signature',
> @@ -615,7 +615,7 @@ def test_vboot(ubman, name, sha_algo, sig_algo, paddi=
ng, sign_options, required,
>      try:
>          ubman.config.dtb =3D dtb
>          if global_sign:
> -            test_global_sign(sha_algo, padding, sign_options)
> +            test_global_sign(sha_algo, sig_algo, padding, sign_options)
>          elif required:
>              test_required_key(sha_algo, sig_algo, padding, sign_options)
>          else:
> diff --git a/test/py/tests/vboot/sandbox-binman-pss.dts b/test/py/tests/v=
boot/sandbox-binman-rsa2048-pss.dts
> similarity index 100%
> rename from test/py/tests/vboot/sandbox-binman-pss.dts
> rename to test/py/tests/vboot/sandbox-binman-rsa2048-pss.dts
> diff --git a/test/py/tests/vboot/sandbox-binman.dts b/test/py/tests/vboot=
/sandbox-binman-rsa2048.dts
> similarity index 100%
> rename from test/py/tests/vboot/sandbox-binman.dts
> rename to test/py/tests/vboot/sandbox-binman-rsa2048.dts
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global-pss.dts b/test/py/=
tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
> similarity index 100%
> rename from test/py/tests/vboot/sandbox-u-boot-global-pss.dts
> rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048-pss.dts
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global.dts b/test/py/test=
s/vboot/sandbox-u-boot-global-rsa2048.dts
> similarity index 100%
> rename from test/py/tests/vboot/sandbox-u-boot-global.dts
> rename to test/py/tests/vboot/sandbox-u-boot-global-rsa2048.dts
> --
> 2.43.0
>
