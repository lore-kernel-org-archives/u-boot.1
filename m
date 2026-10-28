Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360E606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 00:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tZ7KsnHY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rd8ZcyPH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E53CF40596;
	Wed, 28 Oct 2026 00:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrmC68UfK1kB; Wed, 28 Oct 2026 00:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE8F840575
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793148955;
	b=SXMDxDSUx5D1VV3kavC+F8KpluLIo+oYjD8iyqRCxJuipt/dZ+zZQxzyB+9zZo3XCb+R
	 m2sMNnFIxZOm76LIKJLlY8hnq3Uk0rGPhm0USaQgKfI19rf2pi0Q1r70Bp8VEbGFewZyC
	 plpa2FYFAJFA9UkYIww9Oj2PEqGAnmYK308x4SI25ofkuFmVfwAAmojq9pegyd55DiONv
	 GsdyzIigWvIYxqn0dxMxKnhQOhMOaKfis9BTWslBaComN52lSkeJwFJC1EWh5EuuPLkOp
	 dzHpF+R9GNuS06K0Ad+wZmrLTXTLPd8CiJarF5ZIYfedxfqYi1hjcuIyohPYk1fzrmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793148955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3yIIkxNSBX5eiIu1iptSGXm5lNmJ26ajDzCsDdqUhxw=;
	b=WraxpZOQWUZzC+C/UxXGuCL8zCxmVyqs+Seq5XbiGEKKT7NcSpwUIhBYZumrWBbcSssd
	 6JjEoopWzwI37zZqAhxfddXBWjVB/7P4hTO/icCefeQ6lHyWqtTjYKAYHiPfYITB0X2Yt
	 9jZ02O6jwu+LQskWcMiOzF+TgYkcQ4CVSeam76hT0lqFYdJw0hixgPEwZKxray0AZ9McC
	 1F7nCU4M74cVBu6QVq2ZLclvtEyDOcvv2+dnWwy9ou+PQJ3I6YYILvgQhKIuTS4sPvXUR
	 KrglIHoCI95FRK5ljreoJw9sFVec6/xSniY97pZcPta340eNeaUrjAZIBaVuKq4/GvA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793148955;
	bh=3yIIkxNSBX5eiIu1iptSGXm5lNmJ26ajDzCsDdqUhxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tZ7KsnHYfU3hNcWtwWx+93w3kujc7cg4ivJzF0wRi81bTwnEIO9IsP/7iFvhoQKW+
	 qQssiVUxdBh93jCXj52nRko4e4XiateEmdIWyua6ODNzVs7VJlJs1mWf5naECiDu2B
	 49RGOQU/t2QttnY9tBy0TkpgFwqpXxxFONBuY2vCMdj6B1W2ZT9HaGWiqJ8nBjqK8X
	 Jxd+FhNi2axo5Fq/oO5b2vwItI0TUvv+H8ztI0pyUgvQmOc1kblb/OlRqwVYNBN8BZ
	 3ZfqvDurn728ut58XQlx2wAKP6J7pLj3T48hKzNKdtdyJAJdVF6ZkHp4EotYYBpadX
	 mCBjbeKo3Mopw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE8F840575;
	Wed, 28 Oct 2026 00:55:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2294D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7C5E80C2D
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7i-mJXirojh for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 00:55:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62E6980C26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793148953;
 b=E1HrSZvfIEmFVSVoSAxL3Ldm/yddry9AkRiGC9swBjdCY0SRjJ0MwpeZNJ1CmHqU9pdn
 SaviDHNEHAcPEo8TS/a0Pd2uTB8ekAEQcq55kHzdqwtE/IdvpaaC9fO+znj2Q5y7matEH
 RvezGmmJpRvU+yGEWnfxLdhTI3DMTlkj+JMEaxPOwfbmG05+tGvKzyJ0lj8Y4uq/K9FEv
 DWqHTqETtkLFfgk0WSlSR1tnTGsK8M8vht//1xcHVtZay48eVu406JiHYxUVUQI6rZtYt
 Q7+IHXq7VblWsLGTaqJAL+QpTehgsyco6XKDXXRqFjtm1JWIt9WqpE8h0FCW3Ipop1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793148953;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
 X-Virus-Status;
 bh=3yIIkxNSBX5eiIu1iptSGXm5lNmJ26ajDzCsDdqUhxw=;
 b=Gnagnwif7CZmTeqCTkDhFAtUZcEByUlFi+sgChHcc4JDqPZX9JSOII5LmvdogehNzyai
 8peP1W9W2aOtAq1chJOxs+z3pGrUu87P5nI4xoC17ULs9j3E966z3BoE+WcABYuw1TV0D
 EP4NdsV0pI4X3iENzvvV8mQM8HCXNDr517RzAeTq9sxQwNH/2Mr2D79L70bv+nRB6bmZj
 38j3jcZ2cn3Ee0ySGQbersRQWLH36grue4RsovzI6iiYWBjZAASqJzdcDgAfRHg9+r7+L
 vVUGCG7w6GgRodsFMHec8tB6GMtFJ0N4Er1fTHFsUgszA/CoSTb4AYE2kOBy8SXcFLw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Rd8ZcyPH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Rd8ZcyPH
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62E6980C26
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:55:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142B884119; Wed, 28 Oct 2026 01:55:50 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0003783108
 for <u-boot@lists.denx.de>; Wed, 28 Oct 2026 01:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8ac4806e210so3797447b3.1
 for <u-boot@lists.denx.de>; Tue, 27 Oct 2026 17:55:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793148941; cv=none;
 d=google.com; s=arc-20260327;
 b=qfilzMor8am18eaWKJSDD3/4Ki4oEq9uJPt4WrJgfA7FyLGiKgOLQfTySL5ED3x7gi
 aRWjvDVrKsr06bg2DPFOLtdnpTq1sJQknODFgQ2SG/PNmM1SiO92f7PqmTZTImLvWali
 e6WtlHWwEDEEQvKyQhQ3d8GVPqZ83ZJSUBNB1iOeQFiLfOv9M0dirAqBTJn6rOaE7HlV
 nvgi4ZdUT4t6Gizby7HAjjz33CNJNCr4F2qp9738NkPmS3F27KDQpLOb3w13+hM7b1Rt
 K77FweDqXKv6jrBCZa7sIFsxPDi+FLOcJeeRQMDyEdx2aMN1aiYjXKLKEUt3DMLjOKFq
 1RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3yIIkxNSBX5eiIu1iptSGXm5lNmJ26ajDzCsDdqUhxw=;
 fh=Q/JN1eYAOTFBlQnszEtBfqi886lYs0IPVb7+1WJIwTs=;
 b=RSAJ/RvwIpdl+B8LQ4HEKR4xmwPC27Z1eK5futUyGDu2YX355V03FiXo61XR6dedae
 Qx61T1jd8iW0YUlFomkJCLcmhNc5UEtpwjuj0jl4oK1HyvVZmZaO9gj3LhhXf+p2WU58
 IY60xupo0blDyf9NRfbI7SSpq8+zpCdgb3l4wmNzqJ3gc6fC7pYGXz9x2vlm3943qDK0
 v2qqSaOJQwYWLrGFuIuD2+QGKx5gwDifSCpiEV8IbeJvFJRtNTaOToPKk7oWoXZDZrJR
 kcC3eeUov4/1cET5Aebgu/VMTok1wkHliR3ngvfW1BG5vqFcWyxya1prbnjrBWBXdhV6
 2epg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793148941; x=1793753741; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3yIIkxNSBX5eiIu1iptSGXm5lNmJ26ajDzCsDdqUhxw=;
 b=Rd8ZcyPHJkxAjCAe02o9KCAdpGiKpYJAoEf57SIA5Q9lddhh+gtMnWKnH77zmAZX95
 qxu+ME+mLyNkfapd945Q64VP16W5kZ6CfxaIHkvAlzeA9hpMJw/IcwTBlTkdf766332T
 JgQwwaSI0qfQukdWT3V97SGiorAZEIi+fy0ww192CjOhpz51xhjoJiy2z6e6+BRoBEx5
 LyVPe/nS1IDNdouHGg9BhwsPPrLWqlU7/ZkvHPOuvlZpM2iZ24oYgbj+B186sQqCK30p
 nk94+2vfY2LFXnd8Q/UFL85ivUnHvB3OaqlXkipZTrlTpTi2ILrui/l8sGW039HlkwR8
 a4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793148941; x=1793753741;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3yIIkxNSBX5eiIu1iptSGXm5lNmJ26ajDzCsDdqUhxw=;
 b=PQ1TqMzvUX+kmwrej62+QMneiUeeK8LxevUGEyjrhMdhmtu3XJ0knfVz1MCFP38n9L
 9adety+IkoHuFij+Yf/Paa5sAhoXlYUzi+mv36VoVREnvuJCVCQxkRlEwlG6LNteObCF
 dpRvRbbf4js1czjMlXKsiVkg0slGkJqyeqe/d/m38Sc3lORgomUdLe/FS9Z1pPzSJwly
 uLkQkNrxWC/HmB8uQhb0xS0mwNDxmbzUU4byJqlPqqErgh38zvNRE7f8KGFEZ0Kt+TEc
 Gfc4ivmB78MwFXKQ5WfIpRy654psXXbqRQiBi3EkJkzjfp+2Y1TTRXgGzjFWXE1mYLM0
 HlYQ==
X-Gm-Message-State: AFq9FYIEqxs4oQGBkXmB9LjXTTf+KkWnjP8UEib6+wiTHAf4cBYvgxqe
 Q881frI253AZ7s5JmpO5HROa6UgqHDHj8EqnVXB7OX7VI0n6nq9ek2+c0hYavhHBpXXfIwNGmPY
 pbe9Dd+GlxAxvegxWAk/NoETP5wr3nUzTlpv8tHLs3Q==
X-Gm-Gg: AYBFou33t4SnTMH6FMPJUzCqV7stORAy90nHNnNMMa9vk35u87W9Zq3Zh3TXBmIXHqp
 jNiqwHn9ZbDVvkRH8SgEXwtw+wFdQwmMh9PPeEZOU+ryB/iT6Zh2Q2gPtXc386QC7ClzmHEceJX
 kJWtwpyNDr1HY1EyRE4bcokIXGKqsxOzLnb1KjIVFsPqYVQe85ea6DQS7ROyM5f1OZVbvRdjI6Z
 1xEr+0OuuBMeG+klApDVyIAv+0nRV0Wp5zjWmaWOMw48T6aIvExse359fb8qMT05k2bRO2Ie2Wm
 buQOI1yq0bwx1Uc71UANmm+ZNLI8Y2TYeoYolv1cM5C1ML2zDzqiBYZf5uYs7ofcKAeMBhr3q0b
 I+2pK6ADPacOu/mNEyZj7wwtOcReySNbA5va8cRtTBc6l7EE2ytGDbEHRbPTFe+mq1bwEfmOW
X-Received: by 2002:a05:690c:8683:10b0:8b0:dc6f:40d0 with SMTP id
 00721157ae682-8b1b5c6c21amr4738847b3.21.1793148940641; Tue, 27 Oct 2026
 17:55:40 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016-qemu-x86-pflash-v3-0-068014a671f3@elliotjb.com>
 <20261016-qemu-x86-pflash-v3-4-068014a671f3@elliotjb.com>
In-Reply-To: <20261016-qemu-x86-pflash-v3-4-068014a671f3@elliotjb.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 28 Oct 2026 08:55:26 +0800
X-Gm-Features: AclHuK9k8HfzRDbeS_AfVJa8BVC1BCUCR9bg7zlELi9OFcUQF856SsKCkWYLiGE
Message-ID: <CAEUhbmUVmnQB=osPuc1CfDPRU37WTEAYJiw5sTb5EgZkem-XrA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] docs: emulation: Add qemu-x86 documentation for
 running as flash binary
To: Elliot Berman <elliotjb@elliotjb.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Alexander Graf <agraf@csgraf.de>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

On Sat, Oct 17, 2026 at 5:19=E2=80=AFAM Elliot Berman <elliotjb@elliotjb.co=
m> wrote:
>
> Provide guidance for testing capsule updates on x86/x86_64.
>
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
> ---
>  doc/board/emulation/qemu-x86.rst | 39 ++++++++++++++++++++++++++++++++++=
+++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-=
x86.rst
> index c604e42990e..d40cc500994 100644
> --- a/doc/board/emulation/qemu-x86.rst
> +++ b/doc/board/emulation/qemu-x86.rst
> @@ -113,17 +113,52 @@ sure the specified CPU supports 64-bit like '-cpu c=
ore2duo'. Conversely
>  '-cpu pentium' won't work for obvious reasons that the processor only
>  supports 32-bit.
>
> +Running as flash binary
> +-----------------------
> +
> +Running U-Boot from emulated flash lets QEMU write a new image back to t=
he ROM.
> +This allows EFI capsule updates to be tested. To create a U-Boot binary =
that can
> +accept capsule updates, build qemu-x86_64_defconfig or qemu-x86_defconfi=
g with::
> +
> +   CONFIG_EFI_CAPSULE_ON_DISK=3Dy
> +   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=3Dy

On x86, the linking of u-boot.rom failed due to address overlap (with
gcc 15.2 on Ubuntu 26.04)

  LD      u-boot
/usr/bin/x86_64-linux-gnu-ld.bfd: section .rel.dyn VMA wraps around
address space
/usr/bin/x86_64-linux-gnu-ld.bfd: section .start16 LMA
[fffff800,fffff86f] overlaps section .rel.dyn LMA [fffdfd78,00000c37]
make: *** [Makefile:2131: u-boot] Err

> +
> +See :ref:`uefi_capsule_update_ref` for the full set of capsule options a=
nd the
> +general update procedure.
> +
> +Instead of the '-bios' option, attach u-boot.rom as writable pflash with
> +readonly=3Dfalse. For 64-bit U-Boot::
> +
> +   $ qemu-system-x86_64 -nographic \
> +     -drive if=3Dpflash,format=3Draw,file=3Dpath/to/u-boot.rom,readonly=
=3Doff
> +
> +For 32-bit U-Boot::
> +
> +   $ qemu-system-i386 -nographic \
> +     -drive if=3Dpflash,format=3Draw,file=3Dpath/to/u-boot.rom,readonly=
=3Doff
> +
> +Generate a capsule with mkeficapsule::
> +
> +   $ mkeficapsule --index 1 --guid 5bb9ce0d-a389-456f-83a8-2bdfb8ad01a1 =
\
> +       u-boot.rom uboot.capsule    # qemu-x86_64

Please use u-boot.capsule as the file name.

With gcc 15.2 on Ubuntu 26.04, the generated x86_64 uboot.capsule is
about 2.1MiB, which slightly exceeds the SYS_MALLOC_LEN.

as the malloc(file_size) in efi_capsule_read_file() reads the whole
file at once by allocating the size of the capsule file.

> +   $ mkeficapsule --index 1 --guid 8dfcd6f5-42fe-44c6-a8ae-637da61b6b95 =
\
> +       u-boot.rom uboot.capsule    # qemu-x86
> +
> +Place the capsule under '\EFI\UpdateCapsule' on the EFI system partition=
 and
> +reboot to apply it; see :ref:`uefi_capsule_update_ref` for the OsIndicat=
ions and
> +authentication details.
> +
>  Booting distros
>  ---------------
>
>  It is possible to install and boot a standard Linux distribution using
>  qemu-x86_64 by setting up a root disk::
>
> -   qemu-img create root.img 10G
> +   $ qemu-img create root.img 10G
>
>  then using the installer to install. For example, with Ubuntu 2023.04::
>
> -   qemu-system-x86_64 -m 8G -smp 4 -bios /tmp/b/qemu-x86_64/u-boot.rom \
> +   $ qemu-system-x86_64 -m 8G -smp 4 -bios /tmp/b/qemu-x86_64/u-boot.rom=
 \
>       -drive file=3Droot.img,if=3Dvirtio,driver=3Draw \
>       -drive file=3Dubuntu-23.04-desktop-amd64.iso,if=3Dvirtio,driver=3Dr=
aw
>
>

Regards,
Bin
