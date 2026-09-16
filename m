Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A50C88E75
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 00:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46D7080D4A;
	Wed, 16 Sep 2026 00:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EqkERuLoRH_q; Wed, 16 Sep 2026 00:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2110E80D16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789519501;
	b=QN+bK1tZQtwgj5JAg5y57nVczd13CCK/jLcvgtnTUpViFVSN7mhWB57PMXQT3YYdsSop
	 59bvE6kDtWC592WG52mNoIda7ixJ1X4wP7ckhYHFQ+u1pwFOFKrXT955zjcFdDpVp4naj
	 mABGyHWX5ePVmTUUQQGzQN3WY5AyUoUXoNG/OVZN5S7rGZv+FZfHdM3GettSP9AaTlTte
	 /I2eVyfvL9/e+ikZEyyS0123nDnhJxI/KoD1xa/UkfjNj7s4IQe6LH+whLNcTlUJjEJqT
	 xqN6m7v9vLEw7XSy514VPBoILCxAJjn6o+2ZZkHloPCJmSUPHzu21bqB93RZv+Pj8Lg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789519501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hlOqtDktFefZjfTlEVIMB172qvUCBTrDaqIE3bMM7+4=;
	b=LBJlxL3XIBrDg/wKfnotMwqPIIB4HNe8eO/mjepUcNOU8l3zatkKqHXpoDbEO0Jw/s/5
	 k5rdTXslJokY3OyUE5pJeI2buaCuQMuZMHj26uXaNVyqMpVZtavLItaOV3RIlMGGwPXgg
	 Qs2pcmxh0cc5I+a0chRy0Q3xSFkrBBtTthbi5AOYR53M4j90yuTiYY3qw5DHslY1rE8Ih
	 1AdrrZXsUzgZzbmhSplbo5k9qEkTTfzoZG3DCjCfApiY75MBwThKtDHjFDpW49ruZrofm
	 7F1RyDhf7FoYBNAjprWnpSGHmWYbJfKYxZLEjmBmwZZvPqepf9VeUM01EjY0T/vTUwA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789519501;
	bh=hlOqtDktFefZjfTlEVIMB172qvUCBTrDaqIE3bMM7+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zLI8bIBsiNNsTIfUKl2mitn4Fy2aVZ/A+oo7SY6rZJpN5CJBFb4T4c0+xiHufkQUe
	 uge230AEgfq6WMNSLmnyP0q14aylnSYZmdRuOuGG7GFU3N/egURVyw0pcTuAt9AV5X
	 wgQi01W4oj5ruBIFdBohWDYSaXxowNvsViD5sC4TTaLZ0a+nHipA2Hg5X3bBb1KZVV
	 GYwpgfygwiVdPmii9djo54AU6xGihNBpWeCWIkRP1RQEzk0wVM92v854rDi+Y8Rm63
	 eDfGPQsDuKCm+ux8RNkSllCZLMwnlw3ZRUdU119+sMkonKwVX+sD01ASrRQ6Ey+Qnd
	 x5GIw/h/3cUMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2110E80D16;
	Wed, 16 Sep 2026 00:45:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 893312E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 00:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79757607B0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 00:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W0Y8EY4YX94F for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 00:44:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 19B1760756
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789519499;
 b=IlrePjaMbX1DBslFaAaB/1huLNe8eX3izQYWgqdFKGWtGfMgt90uaR7zzV85zmwbXaWW
 +R+g6+IMqrgG3//kPK8Gf7VgH9mqsTHZ6kt5ylRzkVPJx4DMcPqXD+u6PwPjD1pNtJSYz
 uHsf6Xn8CsnNRLkJjbh4eSaGikE3lMoeAGHd4Edm0R+mxTE3LqHntqL/qIuUo+fS7oJIw
 iKtM26DTbs22IfqVa+fQL2dn2XT6notUeCz5StjTk0S2jFTJoOiuCevuA8LkF2ZQaL7NG
 10d4Hb7l8heK7uMOIrt0VA7Im+0G+wTnsEOXE9Qq9gatq2ZxTW8lEjIIcsybC2xkHig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789519499;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=hlOqtDktFefZjfTlEVIMB172qvUCBTrDaqIE3bMM7+4=;
 b=ZSVhRXyNIv9ijK8xExkpSujwluybOuRz6su6uUSt6ZJfHkrtQ30byIKASmjXFcDYMbFL
 2ehOBuHFfJWhPw5NmsO2A1KD90V9Q5ZqHUslqQLPTIWHvMZhOurlup29TJPqwEH6HB7me
 1wBcwpxhvJkiibCKDh0yG+ILZkc6WT1PWtKb+TMKH2Y/0zSOeBZuE5T8P8XXt3oau0rJ+
 MwwkgKSKKf7jmD2vKfQSh46AGpcLvyliybvZawd3P+MFdSjtnUF7gnBgQnPDE2Lm4sjcX
 +2p89alEN38xn8pBpdhUyZO42nn2Asv/JKZIOGdZMUHWlsgw54CcFONIgtV231DnVdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=o8l0bdAK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=o8l0bdAK
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19B1760756
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 00:44:58 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-6713d20d375so374106d50.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 17:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789519497; cv=none;
 d=google.com; s=arc-20260327;
 b=Y5qkOEzeLO0z7y6q5BVaAiti2Y7xWcYsoftd5UDMUAaalmL4tzZAA4dMwnlIcaWOZe
 I/GLnFw3yqQt5hli/j8KWR7ONU8cDOSlOCqOvmqTgG0mu/3XxJsJUBRY5CvIdHXyaJCm
 Mcp5ar9rgpaViMMQI7WB+s2kOvpfdDcuDVps53dwWNC1OYv/nUez9GnSPftNZhYzJT8q
 RBhV2qfiA8pBXIh8Pql737B9uJDep1ORbMN9iyVQuxWaq7eh4eJp1Z2fXecU9mG3NIS8
 WduzIM/g7LQeoEeKMTMSOeCyaPL9XB16PjrV0AvNIeDaw4KKEwn29IcZeT3J7bX1mAVP
 eiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hlOqtDktFefZjfTlEVIMB172qvUCBTrDaqIE3bMM7+4=;
 fh=BbhoBUpTEcIj3ymmnWVrseU3OyNwqaqsvA00m59U+x8=;
 b=jaR/bYXgwNVNUEDLntsQf3ccZyq9dQNfqw7E/sSXbJdQKya/M7ZxcpWAtd/VomkURf
 kSbni81f972b3AABiiSwuem5vm3ypfhPII1VvTCIqLNHZRfnzfG9P4uESPpWge6Bj6/5
 w5//DlqSAfMyipahpIvCvI6tUDFj2FALru7it9WKdUho/udEuxjqRtkbX5NsqOBYItbo
 8ir5SVtKPhiQ2HoxD0pwubRfSxlHszw6WaV971eqTEa4/Rz0u2CRlbg+XRXv5lOXhDZF
 hBBqfuPd1sv8HVr4G6/qmBfOx1PFullf2rb7KxMagDlJgmQUx+DoBs0jiLQ99KyKkTuJ
 we0w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789519497; x=1790124297;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hlOqtDktFefZjfTlEVIMB172qvUCBTrDaqIE3bMM7+4=;
 b=o8l0bdAKL9dX+4+MJe5/FlZeNdglZXFW4GDEG/7huqXY/djjIyYYzAgMAteIyqWKkB
 m79ujQov0niijy8iwSiVdwi6c+RbRCnt6n/tCBKgyeSp8Vo62Dp7B0RHQJgTdYDdN1we
 23eMwsAkKf+R+qdJoEN3hfjnocJS3H/wyz79oejUe13DYJ3hlFNmL4qr6tyAV/Oi60wF
 l5fvrDAcKDw36H5KpLjGGUqlVWSYXeRg7xFvsb+qCpdttqET7XoCIbsq2/aworZBvusR
 VPZjNMkF3iyULva1ybZDVslQCWIiuDPIe+g7z2kR2DS74Cuic4AWjbIOijraM51n3ueW
 Vdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789519497; x=1790124297;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hlOqtDktFefZjfTlEVIMB172qvUCBTrDaqIE3bMM7+4=;
 b=2frPUOqwHRMZPNPGUytgUnaTzgvudTy/+BFnlGYRTUXXGPBxXB/T47yLGHUMoL3YlO
 Sabwjn1MeXq8FL+UY65eBRDj63dIYaqW32g3dvSoOddXw/IK9dPQBKUoE+s+2DZJTjNh
 4/MH2DXppnzRts83sM03Ad628WVWHKSxoQUc/3egvIEa8uHwI+suUs3Gz6fdpXP4mEwd
 IuqP+09B42CInO5WOsIbjtn0zZLFMRCqaETCciZAvx25y6noj7zDXLUT2B921GI6txLG
 3B2mFXvNbnxTwgZMRnQQnag1dsPe2w1p+EfPd9VqJMEomP6C4asC6cUjGK6Qk/Pk6+DJ
 pKFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtZrGgxur5NNRRr5yz+gZV2mZoGI6O8kJahEG0TCr/xYI8YcvbEBYZ+OpScc0y2n89cYEvJoc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ki6/e+TC84wTRb3PrCcJe289hrjOhVok8aHGuDt3ZVueXsXtLU
 wmXYm5INUGYiwWBVva9DS3th0LEj2onBmK+x6oIxGikpXKUaZ1J9RyG9tma78yPeobGQ4sLY13M
 9PgmTRFH2PoLzawNzS/FDIl7atKy64Gk=
X-Gm-Gg: AYBFou3xNuyxOgwgLw+nheiauJgnqhV1jFfOmpSv4FhEzsfkTRhP8zpwljMGYYxtG0M
 rkVgTnmPT/6+3vuFfkTl6HqTTxjVt5eiRqhzXnYq7lQB3BlaOQaAHkk1gG2RYJVxKX54xOMUsYn
 eKjmypcFFgt1pa3ow2ZNCmdEHGXZordavZzC5YbmzEOyOWyoWECN6rGjC49VUtzEH/pn41NxZZF
 evle94bdYPrwbjfNGs+iCJjB1oe8uRJq/8oKfBlulNLMyMvZ+mkekz119P6J7U1NeOkTOpX/NLt
 TQXWTx6+cYgZgOes3GQMz8IEj6GZ2bekAEn5WHEYmO4SK695sLtHQ+BSO5no2MK1dGQbPpB+Yb/
 nOtxuR79ZbX77hxmowTuYt2NAYqwJZI2bqUfyRzvab/NthLQxHIYi/8WPtFiaBBV+JUDKd/W46+
 PYOUPSVd8=
X-Received: by 2002:a05:690e:4005:b0:671:4b17:bfee with SMTP id
 956f58d0204a3-671631d72dbmr284830d50.1.1789519497313; Tue, 15 Sep 2026
 17:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
 <20260914173412.GD1764417@bill-the-cat>
 <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
 <CA+pz=k+SnTLkKyj3uYy4L=wM93tSOD7q=Z_sFmdLQ9xScsGK9Q@mail.gmail.com>
 <20260915154140.GA858934@bill-the-cat>
 <0ec38395-d0a4-42d0-a3b0-0e98412c18eb@siemens.com>
 <20260915195033.GC858934@bill-the-cat>
In-Reply-To: <20260915195033.GC858934@bill-the-cat>
From: Eva Crystal <0xiviel@gmail.com>
Date: Wed, 16 Sep 2026 12:44:45 +1200
X-Gm-Features: AcwNN1XQwAc--IvfeUoacUmCeqBI7SedBOw6Ehm76B2Mqn8LtEMEnVyHLyBX8mw
Message-ID: <CA+pz=k+EdBCCyna52pyygJXFW+nrBS7v2iRRw1yeQZAW6SLqcw@mail.gmail.com>
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
To: Tom Rini <trini@konsulko.com>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.u-boot-project.org
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

Tom asked me to base my image-gate series on v9, so I tried it. Two
findings, both about v9 rather than my patches.

v9 does not apply to current main (a44f46af0a). 1/8 is already
upstream and 2/8-5/8 apply with -3, but 6/8 conflicts in
fit_all_image_verify():

  <<<<<<< HEAD
                if (!fit_image_verify(fit, noffset))
                        return 0;
                printf("\n");
  =3D=3D=3D=3D=3D=3D=3D
                        if (!fit_image_verify(fit, noffset))
                                return 0;
                        printf("OK\n");
                }

Cause is 2c9b117aa4 ("boot/fit: use fdt_for_each_subnode() in
image-fit.c", 2026-05-08), which dropped a nesting level. v9 was
written against the older form. 7/8 and 8/8 are untested behind it.

So: Tom, which base do you want for mine? Rebasing onto v9's own base
commit moves me back onto the July tag, which is not submittable
against main. I would rather wait for a v10 on current main than post
a resolution of someone else's series.

One other thing, Ludwig. v9's "restore debug message instead of error"
walks the missing /signature report on the config gate back to
debug(). My image-gate patch moves the same condition the other way,
to log_warning() at default loglevel. No code conflict - different
functions - but landed together the tree has two adjacent gates
reading the same node, one silent and one not. With
FIT_REQUIRE_CONFIG_SIGS=3Dy yours returns -EPERM having printed nothing.
Happy to align with whatever you settled on; I just do not want the
two to read as an accident.

Eva Crystal (0xiviel)
XSource Security
https://xsourcesec.com

On Wed, Sep 16, 2026 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Sep 15, 2026 at 07:18:15PM +0200, Ludwig Nussel wrote:
> > On 9/15/26 17:41, Tom Rini wrote:
> > > On Tue, Sep 15, 2026 at 08:45:23PM +1200, Eva Crystal wrote:
> > > > Thanks Ludwig - I hadn't referenced your series in my cover letter,
> > > > and I should have.
> > > >
> > > > v8 4/8 does close the configuration side: fit_config_verify_require=
d_keys()
> > > > gains FIT_REQUIRE_CONFIG_SIGS and fails closed when no keys with
> > > > required=3D'conf' are present.
> > > >
> > > > The case I reported is the other gate. fit_image_verify_required_si=
gs()
> > > > looks up the /signature node in the control DTB and, when it is mis=
sing,
> > > > sets *no_sigsp =3D 1 and returns 0 with only a debug() message. Eve=
ry caller
> > > > then treats the image as not requiring signatures, so nothing downs=
tream
> > > > can fail. As far as I can see from your v8 hunks that path is uncha=
nged.
> > > >
> > > > Two things follow:
> > > >
> > > > - I picked FIT_REQUIRE_CONFIG_SIGS for my Kconfig symbol, which col=
lides
> > > >    with yours. I'll rename mine to FIT_REQUIRE_IMAGE_SIGS (plus the=
 SPL
> > > >    variant), default off, since the two gates have different blast =
radius.
> > > >
> > > > - Jonas raised on 4/8 that Rockchip uses FIT_SIGNATURE for image in=
tegrity
> > > >    only, not signed configurations. An image-side required-signatur=
e gate
> > > >    hits that setup directly, which is the other reason to keep it a=
 separate
> > > >    symbol that is off by default.
> > > >
> > > > I'll rebase on top of your series and resend once v8 lands, rather =
than
> > > > adding a patch to a series that already carries review tags.
> > > >
> > > > Tom, shout if you'd rather see it folded in instead.
> > >
> > > Since Ludwig is already working in this area, I'd like his thoughts o=
n
> > > the issue / solution, and if it would make more sense to fold this in=
 to
> > > his series or not. Thanks.
> >
> > I didn't touch the image path at all indeed. So perfect if Eva takes ca=
re of
> > that. My series already contains too many things and had too many
> > iterations. I fear that expanding the scope would delay acceptance furt=
her.
>
> OK, thanks. Eva, go ahead and just make yours based on top of Ludwig's
> v9 (the changes for v10 shouldn't matter).
>
> --
> Tom
