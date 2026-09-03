Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15476C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6EB980CCE;
	Thu,  3 Sep 2026 14:41:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vyk3vYeJdrtk; Thu,  3 Sep 2026 14:41:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E3BEA80EF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446485;
	b=aMSLcW5FdSsP1mKjU5mYGfdK5+5oQHQxsN5ne4Y11CUVd32NRjuUdNyNJGE9YgIbeD1t
	 /p+mFoUrj3b4Du3oAid73QPoqHUwryaVrrIRX0KC0qkoeqY+A+5k+LdKlSxTjYt5zyONt
	 uN9e0WS4fIbe6C0Irt/Pv1Kwh3CifEsIP5fgqmTF4iAOCl+i+tlvizdsz2B5JWs1gWTe+
	 lrBzyx/BaDYW/KVRbG5RuVlBD+5X5ONKvPjuLr6oQc3CsUON6VW0Y9WNRCK5WzxDwNSdX
	 eBLmme++9q7Eruo7yHp+n/6/RxieQoewMcJOpVjtCg5RafhMer/62/uOEvB9QRgFDPQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788446485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=is+IypN1Wns9ggVCURUjv4l2ms6bQS7qh+C3oJUZ/JI=;
	b=GhuJ/ww6w5c8UfROwYaRsF7citQ+3UmdRH5hSBSvMZjmAWdVLpwxuEjs+3CJm8rHeqJN
	 udOdcqYWGwATU9mdLX4wlUn7zSip3HAdzb10smWaHt2AA8MzoBMkEV5IZa4MzGcsQTBlj
	 EbbuxZBj6lz7ttOrphPoODav00QPatUGSzzdHVyuJXPpTzqoj2SCyJBnLAv5kIscW7eZi
	 2JAbbmMupOe3ZZkHZSdTj/6X/5nbHF8zJC3o8v8K90KJRS9QfUeOxcU+LQp9Ex7d0Nw90
	 shZpNJS92Ckj3jpGT/gNXa5Y0ikVu46JBRpE29HU99kCNjj6pWUrjT27ewEjfEG8Fdg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VgjYuJCO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788446485;
	bh=is+IypN1Wns9ggVCURUjv4l2ms6bQS7qh+C3oJUZ/JI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R9yfuz9ZZEvfqwJVsLXT4rKoPxzrX8dbkbLzlTMzr1ZaUz1vE7GaA/xNe3WYcM3qU
	 P9NjrWY9mjyoGZhQWOUrOL4s3hpUxslR6AjHTZg/igctohXXESk5xZ76yJQSaT/xp5
	 /ThxOZdYxLlgNszAaB9K8UOMIdcunppJFz2oS3QA3Py9mBf2RZVW5ZtlhJ2oAOfDQ6
	 O4wAShI08lLFAERt5H55GwOvoNIgDqTOJU848hsDhwG7KN4hLx9PlP29l901nXTaqK
	 yq/EMjcF1tkEtXoDiC27pbjsGbn8Va6gGtUtSEP7ZUFtz6QVH/790W1mMreaZLdbph
	 PD6YO86FqwROQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3BEA80EF0;
	Thu,  3 Sep 2026 14:41:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7786E2FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F87B80EF0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:41:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K0DvkSbKwb0s for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:41:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 788EB80CCE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a34"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788446482;
 b=YVjrE4O+mMhVbmgj4qcB8fEje2iuZd3+AlJH6EY+ROQ70mCpOke4HmYr4jIKEI7u3ndY
 CIrjVNx5v+vIVGiqlQE95+PIeG6nztEyy0jyApiy3P7hYp1ylu9swaXghRENIW+Ks5ufO
 OvE1r8+2Ymguni+CxjStmpEDT9QZurO1cCmqL+zDqIuvA5Lm9HuHqNRhznc4zxslX2AKS
 9Kwz9lZXm5MU440BwFZM9SpF01/pEc28d0is4V49OTmQibC24voRKBwXsA+yQBvYsMiLP
 r1PgcZGTZwXptoOJlFwz7wo6TVfjkofzuTtgFCg2wby6aJmgtsQBwXrBBoax5WLTbkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446482;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=is+IypN1Wns9ggVCURUjv4l2ms6bQS7qh+C3oJUZ/JI=;
 b=iI3aTLZe9De9wXPhQh9+TSQe/ohZTQGXmimBbaQrvWE+mNDaQLggX1X3rmRBUuYU/DF5
 hIK/nQWWHfpEBgp1+iD2YePLWOQFJ949tkkja/OGKNzlipxuxoznERkTFqkAUXuKLBil5
 rbU19FzltMCr0nxZuUjnn2xEBb1hnZRLVgz6X2svll/5+sTYa/42OY1Y6s7BKoiPxclA7
 f8VG3/Inat2JlTT+k5qMlBY9l/fXh2JA7tL2gZvj9aT60fDN/LS7eEamKf6eL63s1ocQS
 CIiNi5vNcA3V6swNRDBRTz5MiHdcjsXB4r19bFlZ/Bwm6SFhzFYjymHMaiwObtV3OwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VgjYuJCO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::a34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VgjYuJCO
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 788EB80CCE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:41:20 +0000 (UTC)
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5c7afda4515so1418248e0c.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446479; cv=none;
 d=google.com; s=arc-20260327;
 b=IRCd16HSLDZLspJjbsI/M7gFHCCL+O3VEKCm8h6DRWdlBbyX3BIuVV8/gb5z5oAEpv
 +ztmNVL8vSFy8qY8e7adhIyHautSsGoVvl/fDLnO4uMnoHRd5P/KwF3zv0Xx1cjJcsuj
 klGrkzAgW+a+DhrjKA/wwnNwk7Yib3GwkDd6wIegQayWfABU/Tnk2bBnGlV8F0XqXeIr
 Cdq43qpL+blJ/gO8F2IZ68nEf0SsQBs3ybCA36r6erRB9n+ZEcQdIaTSGeJIZGT30ow2
 oYX7LP9i3GJotnjwXwVaIlh7xfylxj15mFuUJpXIhxbqPfvUFRbjJ1/nX/OqjU8JSDey
 CTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=is+IypN1Wns9ggVCURUjv4l2ms6bQS7qh+C3oJUZ/JI=;
 fh=emGS4jH0dISXUsg+hojZJqnekEefDmWwSY/7m5+irxU=;
 b=gLE6i7DG9KaGiRMvkxLZjEUC5ULIgRyVLmpA0MTRZvt2lJaVniSsqvbtN4SAw6Oxv3
 Wn1vqpR4kQx8YyemVDycJeM9v3tsfLdGwQ95ic1G1zKDAqqWGYm5rPYp1pPOfaB9kj58
 US0SPS7OTRxBic6eoHg6CSBpf9UJUXbSM0SVAYN06vy3l8k7CsNkcSrIDmIHQs+RWCEp
 CQpfIxmVtMakoBqX24xBEpksy/jjlBMzC8bNn3++7gNUqkZj8/GbQWvyoQJoMIPRsEyu
 Mkz8QwLB3w1VO9oH448gApTQ8yp0wy28IsdPl4Q408ZzOQ2M7E6+tibG8q1s+K4q0+U0
 n3HQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788446479; x=1789051279;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=is+IypN1Wns9ggVCURUjv4l2ms6bQS7qh+C3oJUZ/JI=;
 b=VgjYuJCOP60idXcCgr9YpKtL9f0SShcWQ4Sf/LXfDiwOqTel18nvrXopE1m3ujvdvB
 FYOQtUhknMCrP4UoYi5ulbzWswiAMzT4W/nCVc2JOkG0szWYuvdlv85G5HfrXUqv75no
 OwNWOXIk7Uustg6CeBd7mUgkS5xA5T61UmLyqkxoXssqvJOVq5ga9huDCQKv+tf9Bt5w
 f7F6N4bf7P5HWb/Mi25jB+KDm4L43KOgFqfQSeA9Ukw9CKie/wKzWuHzgXLSBEnMaR4Q
 UWOFHKIREyOGkZ97CNN2pECo3dps9wS/b4e7q9bfwWbINQ6ELmEo0d1xT+sz0eOL8/NA
 NGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446479; x=1789051279;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=is+IypN1Wns9ggVCURUjv4l2ms6bQS7qh+C3oJUZ/JI=;
 b=f+nOWqm4dIfRFIk6V8WuKvkEpUjN9uX3LFwt9/dFCNegiGvWYwZvrJW5PnL7ciOB7K
 EWd/IX91Yq6olMd2Y7e9pLMYlRlfEBe+C4Aqf29ejCPK9VdEk8RXMuKdWXSbObP5x86A
 Ez6C1vnfJ6snviTz14t2eYCixaK2fB8JDC+E2Vnqn3wZhwHJtOIYSkuVkRWGB3f75kXa
 bA5cipxQND2JTZEWfd1AzhCwmq8eaOtr49seB0VroJziuEg+uO7clKzb16dkf16nHmYj
 u6XVuukocBuS3gdTFXGMQVb9Gc7sQRhDyy0LIR3iGhcJs45cc1pdg1ZQOeA9/OzfwHIl
 cOrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDltqn+rst8SUJMniGP6SBLkv3nCjK+12JpS9fqOX7gPRSny3A2CmTfHIC9TK5eNVy0QWF9wY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mYsejQqctot9QV+sU1De/AqzO/Xu4iv03r9VnDwzDjzkjyqpOj
 j1yk2ajnCP/PbsZlqlB59hVpqVHqagtYH2bwa2YATlRwBnd/0cUDondg32fLWqMblpZ3TySCjLS
 bCNwXSBc4CWzBd9UL3+iuVUTupe+8mls=
X-Gm-Gg: AYBFou0J+wipZamPi00LNiv7MR0FpujuqoVBlrgtf/sZEjlE0rLhYSPGGX3yoO3wgLE
 ca0gYFV3JWno2+RvTYQYerFnzN2jfhMvmdmvNnkuKExYajggBAPaUn8K8eqf2ct0eXLGZBhkbvm
 S49YEQ9Yq/+PNqthbwx7wLxL3t7BYoGK1G9BABxbh4DiIbGh1R3BVdVb1ReqXRIasFPkX1Vpv+6
 h5RyubSxcgW7mlx9/sRDIhPtwZ3kkPp384yUbozYnB6iRG9hIbjcDAWdIAeLFuyUm0Oy5Tpq87D
 zl4dPHNOk2IVdYJV2OY9uE9XJlmpXtKWsuLMH++c3Tt+QRs=
X-Received: by 2002:a05:6102:2d0e:b0:782:de7b:eead with SMTP id
 ada2fe7eead31-78a1f15745bmr4085927137.1.1788446478875; Thu, 03 Sep 2026
 07:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
 <20260903081705.12894-16-philippe.reynes@softathome.com>
In-Reply-To: <20260903081705.12894-16-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 3 Sep 2026 10:41:05 -0400
X-Gm-Features: AcwNN1ViDCslDeR5aCgQVByKuBTo-rYfeLZ8sa16qVC2x1KLFzpUekmot5gcVkc
Message-ID: <CAMDkj5zTGvbZBCL4TmLzA-Lq_VgSRwqKijE8Rm8Op+ZyZ75MdA@mail.gmail.com>
Subject: Re: [PATCH v9 15/15] test: py: vboot: add test for global signature
 with ecdsa
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
> As now u-boot supports pre-load header with ecdsa, we
> add some tests to vboot with ecdsa pre-load header.
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
>  test/py/tests/test_vboot.py                   |  3 +++
>  .../tests/vboot/sandbox-binman-ecdsa256.dts   | 24 +++++++++++++++++
>  .../tests/vboot/sandbox-binman-ecdsa384.dts   | 24 +++++++++++++++++
>  .../tests/vboot/sandbox-binman-ecdsa521.dts   | 24 +++++++++++++++++
>  .../vboot/sandbox-u-boot-global-ecdsa256.dts  | 27 +++++++++++++++++++
>  .../vboot/sandbox-u-boot-global-ecdsa384.dts  | 27 +++++++++++++++++++
>  .../vboot/sandbox-u-boot-global-ecdsa521.dts  | 27 +++++++++++++++++++
>  7 files changed, 156 insertions(+)
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
>  create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dt=
s
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dt=
s
>  create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dt=
s
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks!
Regards,
Raymond

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index e3996486ab6..ed7e6bb33d2 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -102,6 +102,9 @@ TESTDATA_IN =3D [
>      ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, =
True, False],
>      ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, F=
alse, True],
>      ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, =
False, False, True],
> +    ['sha256-global-sign-ecdsa256', 'sha256', '-ecdsa256', '', '', False=
, False, False, True],
> +    ['sha256-global-sign-ecdsa384', 'sha256', '-ecdsa384', '', '', False=
, False, False, True],
> +    ['sha256-global-sign-ecdsa521', 'sha256', '-ecdsa521', '', '', False=
, False, False, True],
>  ]
>
>  # Mark all but the first test as slow, so they are not run with '-k not =
slow'
> diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa256.dts b/test/py/te=
sts/vboot/sandbox-binman-ecdsa256.dts
> new file mode 100644
> index 00000000000..0e84b81078b
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-binman-ecdsa256.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               filename =3D "sandbox.img";
> +
> +               pre-load {
> +                        content =3D <&image>;
> +                        algo-name =3D "sha256,ecdsa256";
> +                        key-name =3D "dev.pem";
> +                        header-size =3D <4096>;
> +                        version =3D <1>;
> +               };
> +
> +               image: blob-ext {
> +                        filename =3D "test.fit";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa384.dts b/test/py/te=
sts/vboot/sandbox-binman-ecdsa384.dts
> new file mode 100644
> index 00000000000..56faf67fe57
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-binman-ecdsa384.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               filename =3D "sandbox.img";
> +
> +               pre-load {
> +                        content =3D <&image>;
> +                        algo-name =3D "sha256,ecdsa384";
> +                        key-name =3D "dev.pem";
> +                        header-size =3D <4096>;
> +                        version =3D <1>;
> +               };
> +
> +               image: blob-ext {
> +                        filename =3D "test.fit";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-binman-ecdsa521.dts b/test/py/te=
sts/vboot/sandbox-binman-ecdsa521.dts
> new file mode 100644
> index 00000000000..8e2fc3de31d
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-binman-ecdsa521.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               filename =3D "sandbox.img";
> +
> +               pre-load {
> +                        content =3D <&image>;
> +                        algo-name =3D "sha256,ecdsa521";
> +                        key-name =3D "dev.pem";
> +                        header-size =3D <4096>;
> +                        version =3D <1>;
> +               };
> +
> +               image: blob-ext {
> +                        filename =3D "test.fit";
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts b/tes=
t/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
> new file mode 100644
> index 00000000000..f15ada3987c
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       model =3D "Sandbox Verified Boot Test";
> +       compatible =3D "sandbox";
> +
> +       binman {
> +       };
> +
> +       reset@0 {
> +               compatible =3D "sandbox,reset";
> +       };
> +
> +       image {
> +               pre-load {
> +                       sig {
> +                               algo-name =3D "sha256,ecdsa256";
> +                               signature-size =3D <64>;
> +                               mandatory =3D "yes";
> +
> +                               key-name =3D "dev";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts b/tes=
t/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
> new file mode 100644
> index 00000000000..24540ace249
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       model =3D "Sandbox Verified Boot Test";
> +       compatible =3D "sandbox";
> +
> +       binman {
> +       };
> +
> +       reset@0 {
> +               compatible =3D "sandbox,reset";
> +       };
> +
> +       image {
> +               pre-load {
> +                       sig {
> +                               algo-name =3D "sha256,ecdsa384";
> +                               signature-size =3D <96>;
> +                               mandatory =3D "yes";
> +
> +                               key-name =3D "dev";
> +                       };
> +               };
> +       };
> +};
> diff --git a/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts b/tes=
t/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
> new file mode 100644
> index 00000000000..72fa3b2c790
> --- /dev/null
> +++ b/test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       model =3D "Sandbox Verified Boot Test";
> +       compatible =3D "sandbox";
> +
> +       binman {
> +       };
> +
> +       reset@0 {
> +               compatible =3D "sandbox,reset";
> +       };
> +
> +       image {
> +               pre-load {
> +                       sig {
> +                               algo-name =3D "sha256,ecdsa521";
> +                               signature-size =3D <132>;
> +                               mandatory =3D "yes";
> +
> +                               key-name =3D "dev";
> +                       };
> +               };
> +       };
> +};
> --
> 2.43.0
>
