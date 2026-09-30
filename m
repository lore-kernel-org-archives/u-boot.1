Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDE0CA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29F3E80DC2;
	Thu,  1 Oct 2026 01:47:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QFBdSZIz5Oxa; Thu,  1 Oct 2026 01:47:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5F4D380AE3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790819236;
	b=B3fYWNRorrFDGQUrZs4iyuP9FeadIr9INOJw1WF7atvHbIUqdjDt4kC2pkTrm5dD3tPO
	 JJEPyDnRjt1lHQkQowhirdIL/XcufZBiQYCmpTZdjegUn3StAP6kcyn3AhvqIro8ig+TF
	 r3Kcw0gzol961d3JzeQYRET2b+tmb18REPc0rWpi1VEGMp22Dj6xdDdA/Z5+Bkbpg7UB/
	 UpOttw70ff1iFhhkymcVX+8mijeRDAPuMZvHD+JRZspoZAk42NPxsboKC2S21VpW46NOb
	 iGbEJcXPICkprSiuRtx2hdVWMD7DpbI8MY6Lg2sCEh3DTDHOcv2s/X4kWb9eArb/6FQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790819236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Pvf/jf5Af+zi+9uvvo0bnUiqRNXFgdaG0XVysbHkR44=;
	b=cGrewCWXQrbFKuMUb/Jj60hBMav3nXvOzNmrRGETvNLRL3O+XmOcALf6T09pYlCydeVY
	 83GiIf8AQJISKfJUk0i14TVAqAigg4kWK7e/Ixu9tMh96IFrUsl/ZNW0UncQz2nW8FcOe
	 sgrswab4YFiH5D8hObXSpDfkWhcZ3W2rSeY4OZA6yoWonn4pgG+NVW5hObQF80YZZ0t1z
	 aVAT9PEKWdyUs+Td03UAvIgueyIQCR/m8QqltPnJ40PMR5uaCHzPqA8m4bqMEv1mZnk9C
	 XFtMFdX0G5JycNrKIlmPqAz2ASjlbKvozZ2nd0eFPzmtED57bFINzSCj9la5kiKGeaQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TaXKmDnj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790819236;
	bh=Pvf/jf5Af+zi+9uvvo0bnUiqRNXFgdaG0XVysbHkR44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDR+4v2gt78H+Ure0T0T6QEGcuVJIZQIfJI9YKFfltpVbgbxF2Wqtz4LMfO6SyOF7
	 5SttcrtRGtYK8rIzQpdqwXJY7UNZNre1AVXc42ZGf5Nkg5qYGWvRQIaC/q5TTltLjl
	 EG0zU6su9QG1BQvJnijeYQQwVz/bZLtYkPipgXv40voYE/9aMRM0WNMFDcQv8PqtP0
	 4YKe0DeR8bY0J+MLUiFvnA+/s9WUH43JBPO/o/JUrCUtW2m3KHjE51Ek3gBhcENntv
	 ZmPd/6D40OYVOERYcUZ/zncAxJRHcY2qOhHN6XT3nazLJCNpVEIpZ0FlZnPvSZgkVA
	 C7Ed4ppxkZiEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F4D380AE3;
	Thu,  1 Oct 2026 01:47:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A7DE4C2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 22:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8031D81164
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 22:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tBXz2Gxvhybi for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 22:29:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ADAF381139
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790807344;
 b=CWGJm/u2bKH6QiX3a61s7YPdR/kVPKMWxsvwXQiPFTlOQPt2M6demlMxIgh8z1dPJltg
 152iaGJSo7h6R5qtnJr/Q531mLngbT5/9zGn3idDr9XjCIUHSqtmlkw2QEEazUi5jjrBG
 rvG2URoRnkINYNRv6u6dceQyaWwEMyPcojt+UCiZSZZQadiKYTUO03hF1kdJ3GEZa228X
 437wIsCYGsC4HAP064u3LFgP94y90ECKu5AgIYG1zMWi1CA5tEy/bdPq90K1MMfE9Kw4f
 h7OrjdwS9Fmm1Cz2X/nDY5Dpm4RtiWbLPwmQCcrXNCox4iOP0FoCQsd2ZZQd/W1kPCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790807344;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Pvf/jf5Af+zi+9uvvo0bnUiqRNXFgdaG0XVysbHkR44=;
 b=RgnsGJHRqcZ569/RtbP0EKgd9aTJFEPGgifC6bvfqEd4zRS4GGn9XYyKm+A/dsboI1oF
 z6aMped/NXF6AEU2bBR6H2kvyvATv99oEMEG7huH8eZKWa+S9IUVKjfj7hMQ8oSsb8+PL
 FdyLCb70dUJSvUl7J+FAfDZECXbl9qfzEyy2l6y5Ga5PhDRB5cNaCpf63ovIeggIqFdL0
 RQjybnF6zbfSsx8TelDfG5rU5FO1SPhE+pUxanEUxq5dVEy5CzEE8aY+zHxX0krfrkOOg
 NvKkE52V+hSvClmdmrwhJjP32RVwKUXszbciedVzzQvvFBzdet5Nsl7j/wsfeWyGetA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TaXKmDnj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::d;
 helo=mail-yx2-x0d.google.com; envelope-from=m.legenovic@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TaXKmDnj
Received: from mail-yx2-x0d.google.com (mail-yx2-x0d.google.com
 [IPv6:2607:f8b0:4864:41::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADAF381139
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 22:29:04 +0000 (UTC)
Received: by mail-yx2-x0d.google.com with SMTP id
 956f58d0204a3-675711754ccso1739342d50.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 15:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790807343; cv=none;
 d=google.com; s=arc-20260327;
 b=srX5hMDMlx9qjgubgxBjf513bilgwvTO62Lzu5fqzmDeovP9nNhn+osyMn6lEbXH+S
 kBFlk18GtEZv6665VK4MGysazk/m4VOIjxfdBmwL25zg4fALgX5oGPNNTGSjE2NrOHic
 fiaP6OJl8qD3rSWPq3FK6Iv/HyLhv4pWnQ2IohJgUQ5BzBThqTuTtYY7gq37947uBuVf
 Mdi5BcGNf4J7GG6R1+KxtAbz/bXP9Z5H05vXPyAzx5XPzVopJT7Y0pCS1UIKiOiNbbUy
 pt8P3SXLq1y8lpO9ZavP+mnyfTQmDK85RPgLSHd0WsIUtv9Av276nr4DWORzWDJU5Cc+
 isaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pvf/jf5Af+zi+9uvvo0bnUiqRNXFgdaG0XVysbHkR44=;
 fh=mpPB3DSsbuRQ8J6bhuqWHO1+dotwjP7/nN6AT1eMQ0I=;
 b=g4WTrd5Mtv9NhKyx/M3R9nJp3BQRSU6HRhjYr9JC/S62VhHmc9PoW0Ote+SCQegPkJ
 XaFio1HLQMUEc4wcn1NcEMZx15O3+ub333igCa11irxQwc8cRPCbT+/GoUgQEvni5xZG
 csJlLurRhjF4RrdjWMx886XxULFwfRjkoaDSW41HH9dlufscTuYe+L5vQ49wL1WzsaZO
 +1qc0EvlxqQtDmG08Xh68nrxv1mA/gvwvqKc9pFuVJymW1hHj4CPS/Evc80CPNERE4gi
 62AtBCGiIEafmxftzYhrPHLL4PwNeZsA6TurYTocytl4IuYH8aXKc9qxL2pfGd7NafYU
 MXQA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790807343; x=1791412143;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pvf/jf5Af+zi+9uvvo0bnUiqRNXFgdaG0XVysbHkR44=;
 b=TaXKmDnj9zj2zwNZoQ23hZXkiN4Q/F8rfuuCkI8Mg7Nugi3/g9dgEMfjJpgM7REjTI
 33H5jP4Djg+YcZTpwtuklp0DD5dFWnPuXeuhZ+RCTXkrjOh0P0hanUdZw8Aq6ebj7iFO
 7bnVVOFmWbhtwsfqNQRqgeQyc6uby9Gjl4My4I36CtqY2TuQMmz5x7nQCjtsE1amF8eo
 CgDHNdl6/LoxJpKMXi5JxwvjdWxrtzsatpTJ9sXuC+pgozB4xKMhccr6rCfvcqd9Z5YH
 RbvWh8bFJHwBr9dsQM9kCG4KF9hwhRorsRnF0mN3zEOoZUIWnGq5gHKjcddM5GYwjDvW
 4rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790807343; x=1791412143;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pvf/jf5Af+zi+9uvvo0bnUiqRNXFgdaG0XVysbHkR44=;
 b=jXC9vCVgg5ZYMy0Q/r25Hv64+QeK80XtI3jumuXAFJQ2XjpXZxDmbD3wfQBfXKb9yg
 aWyRfQwX0AWs4lX69ki2LchdPk2DuGq5dUMEEZEqTGUESctk0+KAtA5DGHwpmWRa+vb8
 //lXqFfxTNjbxEcQm0I7F9IUKuhUaVTvkm48OBDWGk4sokWNHJpzT882+ee9kKGgfsJ7
 jYbJ08U9NVIgBrNEfw1Pn2DVgEK5glmUTLTu3ovf61yP5Bn9P4tuaXymwv3LbCsaR1qc
 sPVy3rVXm3x6xL4LO5nnFgT0UY5JPTvQcwrP+ZX8UfpCNn/3Cp8EG7SQPfribd/wLxOL
 SPqA==
X-Gm-Message-State: AFq9FYKqakpkYb7IhVGYm/EdHemn77fNMx4Mm5tH8w+2njJJWumuDQLU
 9pIQvcwHux87SXA4u6KE3/70rOBQCeSf3unP5jZqZ0yEVyKrwPQWCd36csXTg6Q1Eu5OLzJxN84
 ZViYM12PNtbukWSBWCEun9jU7+i9lH3udDcNcOvk=
X-Gm-Gg: AYBFou1Nto2qmm9OFUx2Z9eKW2Z+giYH/X1aKks+BPExlDQlbMVXb3/fkEeIxKKvNnK
 Gl5xtafrC7shIX2v9nCOHZJwMk0U/vED/AclHPabG9dfdurqu7KNNZVfgWYMUvYPBNwyWHpK95w
 gajXBtZ4HdIVHM1uBtjzLSws2pX/GaG57ac++IqyirSl/n4Ah3dIqCpQoymh/+c5ZKIvF6C8Y8x
 OPhGjiNt9MK8iuSsrlWo+vak6MWxnJ3rHRgT01vPuqTVfMKBmXSxDE+YEIxpOk/10n3x7Wj7OQO
 aXbuG6CqeP8Gd/cNJpi+VJIFGtT2qLyy3bC9BMN3HKq9A0jnCuAxxA==
X-Received: by 2002:a05:690c:d87:b0:845:1064:5c03 with SMTP id
 00721157ae682-8ac9228638dmr12261567b3.23.1790807342687; Wed, 30 Sep 2026
 15:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
In-Reply-To: <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
From: Milivoje Legenovic <m.legenovic@gmail.com>
Date: Thu, 1 Oct 2026 00:28:50 +0200
X-Gm-Features: AclHuK9uSXdL_9kieQla5ELf1UtA9tWNev19O0VIHj99e9a8vUry2J-1XAV5zTc
Message-ID: <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 01 Oct 2026 01:47:14 +0000
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

Hello everyone,

Here are the details of my analysis:
The commit that introduced the change in behavior in version 2026.01
is this one:

commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
Author: Adriana Nicolae <adriana@arista.com>
Date:   Thu Nov 27 08:28:34 2025 -0800

    boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots

    The Linux kernel can discover SMBIOS tables through two primary methods=
:
    1. Via EFI tables, when using EFI boot;
    2. Via the 'smbios3-entrypoint' property in the /chosen node of the
    device tree.
...

I found this out by comparing the device tree from a working version,
decompiled using

sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts

and difference was in /chosen node:

chosen {
        u-boot,version =3D
"2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
        linux,initrd-end =3D <0x00 0xecbffca5>;
        bootargs =3D ...
        smbios3-entrypoint =3D <0x00 0xedf47000>;
        kaslr-seed =3D <0x00 0x00>;
        linux,initrd-start =3D <0x00 0xeb519000>;
        stdout-path =3D "serial2:1500000n8";
};

In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
searched for this term in git history and found the commit mentioned
above.
With git show I saw what activates this, and made a patch in armbian
build system to disable it and confirm it fixes the problem. And it
fixed it.

Here is also where kernel hangs for 60 seconds (always at the same place):

[   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
[   78.137967] Freeing initrd memory: 23448K
[   78.165027] probe of leds returned 0 after 63677665 usecs
[   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 after
63684076 usecs

As you can see, I was only able to find the cause, but that=E2=80=99s the
extent of my expertise.

At first, I wanted to sort out the problem with a patch in the Armbian
build project, but then I thought: "Why not sort it out at source?"

Cheers,
Milivoje

On Mon, Sep 28, 2026 at 4:37=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Fri, 25 Sept 2026 at 18:59, Milivoje Legenovic <m.legenovic@gmail.com>=
 wrote:
> >
> > After upgrading u-boot in Armbian for the Odroid M2 board from
> > version v2025.10 to a higher version (it doesn=E2=80=99t matter which o=
ne),
> > the board does boot, but the boot process halts for 60 seconds,
> > and only continues once this time has elapsed. Debugging via a
> > UART cable showed that u-boot hands control over to the kernel,
> > and then freezes there. The only difference compared to v2025.10
> > was the SMBIOS table. After disabling this configuration option
> > everything worked perfectly.
> >
> > Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
> > ---
> >  configs/odroid-m2-rk3588s_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But I agree it would be useful to know why the kernel can hang in this
> way (I didn't even know it looked at SMBIOS tables!)
>
> - Simon
