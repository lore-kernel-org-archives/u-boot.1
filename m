Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674D8CA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 19:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE1BC60887;
	Wed,  7 Oct 2026 19:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7lYbPSjfK0sw; Wed,  7 Oct 2026 19:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 223FE60873
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791399631;
	b=bFeubH1SVE8+/TOVlbheJfVpam0QHuPv4RTlDQ0ebOQr1CrfmNl0VAPk1IdfB6R234hS
	 NuSFumZwBGT2hEwSLBnWZK3vq9I7l4WoLvOLwa/PZYoo6ATpWnyB9rx3giw1yavA9vAB6
	 mrPo+yEro2pS5QZsNv082a5fFThfbJA+5+TQpiGbM5YkWlhWkFElbun32/UNw9r87FhUS
	 7cnyE5d1XVxNDExFpAg+4pG4YP0vWYsP6mU2vBTGuj9uskHDPIq0FqstLYTaiMVLyNzxl
	 Ttg1uCq1FTz7KeJRKWRPu2lDYXunBrBOEGHGht/SfO1ub4+1RbwICb+CrZzHzhyqwbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791399631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fQeVSQjdIGD6x3+h+Z8ZE5qTGFc6X5lgQYUVZ+k+tX8=;
	b=remL7+p9ERmNWTQfGUKn6PZTSH4H/181SwFntvO1cd8YN2q+iV17WImcq9mtP4WF6ma8
	 Pr0Y3+U7PE3/yaqYCN4dVrJqL24D6c9KGvpYLZV86sQJf65QbDHDuwvdU5GGC4N95vSd8
	 72wa7JYn41suKZdCgzrhaWs2VC7EIHr0dG00pijpJYA6hqTtehDM/hXzfMXGwFTNwgMPJ
	 d9yAcoYtFYh+ZmRBKN0d1UPvf5iyMRfG7ABRhEUJYTaGmG/Nn09DxoeDZAE4FI99GNZww
	 a3RWy+VOtN+2C0gdJhXXqER1xcn8pTc9s9vu/RHMUkI5IYfrlJW+moCM6GNdRkbG0jw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791399631;
	bh=fQeVSQjdIGD6x3+h+Z8ZE5qTGFc6X5lgQYUVZ+k+tX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RUgCMjWJFsojQ+bCMJyzGTvKlYNXY/TwL8VLapr9r8kdKW9CmbbUszutxYeC4W/Af
	 LIG/jElXEA+3Ud1DZOBAKBEA6vKBCIW9tc7rjGQ41Opl6V/XlR+X2JvK5d0a+z5Rpm
	 yEcrPoR5qyq7BKlrKDQFqMkn1AteYCXeeU59RPtvrvnwKFJcQnMv13PrNh8mU98uss
	 2Nm9L8iBJUd5GakZFtp8URSRzOds4g7VG4/HeaYLfPyYCENGGRHmaBBinfy1c6vJDQ
	 FudI7F7pNZHX37+JRsTF45dom3ahma/qlV5Oy/jx+78vIwo8022XfO5XUiNZbln9I/
	 OuBWBGqHoqIXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 223FE60873;
	Wed,  7 Oct 2026 19:00:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 939302B2
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7801181454
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:25:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wekj4AAX5asd for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 18:25:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 795BA81062
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791397554;
 b=fngXzgSd9yl+ysE0yWLxkRgKgbAeKVmGKTMnjJjo1F8s+/1fC3sLnFnOK88HVYrGyviy
 Nzh51ikMw1yUzYL90LM3Co3o59GMPblHsGnqVIeRU0mBn/p5Uns/TCKVSS+J4RnZ3payi
 JH52CJk+ULtYrgsvCCOQ9QAzerAf2R6JAIDWznJPy6CKJnB7GpHuzaMRVLieNNbH9w++R
 pm9Ie2sbj6bwxBySSNx4/89mkwoWeVKRiSU3h/dOpszGLR/CuU7Iii/sO46BGrChLnX0/
 6lPYioBG4pYnGX2pP8mi9OlIT1763iOdk46vMReaagx1UMI/zAzHFwtLC4Fs0qGVA+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791397554;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=fQeVSQjdIGD6x3+h+Z8ZE5qTGFc6X5lgQYUVZ+k+tX8=;
 b=B7TfmK9y93fwLJFkIen3dOrTU6Y03TZzuZT1b4yBGyZB+e6Q823jtwbYYXQ09rPcoP7h
 HEEhSyDamJGWwTfOtjmHGfPsxtk3wqFllZbJT2WS1cFKhk4NLf9sRWIlNi8YDVPgIAzZl
 EhHUK5r1SToDJ4bzqPVGNvuVuX4dhcvAr107AHWPn5Qgy8eCJLLGw8PUsWmezJj8FfP3e
 f/igAIal5GboUVpGhi+RvCIvxZrZ+VAxOXhzmBuReTHag7WD52hDHHQsOWL0/Yi3BS8fJ
 IYzduGB/t9mg6nQ4GNVw6Y2Buh6XVzgUYBckKVTD2ZqZ5urmD7AH1IJ0Q7RYfFrG8GA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Q5gHuiFe; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Q5gHuiFe
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 795BA81062
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 18:25:52 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-826f17cdc9cso1928315a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791397551; x=1792002351;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fQeVSQjdIGD6x3+h+Z8ZE5qTGFc6X5lgQYUVZ+k+tX8=;
 b=Q5gHuiFeDU1JrFSFE5wxmbHy/7p4JNGV1eTdiVbMrWgF0R8QAQxN/zon6RW3QhMVtr
 Jbf3IHE0ZwcaHP5XFEFacL6//I1UtZ7RathWbDu/kYR+ivgiz6B+/07tRKBX5PLVjlLc
 Zeyg5Cggjk7o8dMB2NtTv834aJ9y5p24Mn35M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397551; x=1792002351;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fQeVSQjdIGD6x3+h+Z8ZE5qTGFc6X5lgQYUVZ+k+tX8=;
 b=PxH78N2sf1e+ypGFwq+xKsOceZuwMTFN0DUhTpk1sSjmVi/hUOlge0LZG/n5hszum2
 DuONmdg31ZnfcOya0RlVUA/PjvCZyyF++uiiUhvH8bOODlQQbM0q26SQ2mk+GkKN8bvC
 GVb0eBIbMPVgJKgwBfyg9nxbzPKnUT1MM4eLlt5giUqNPN5kpxdt/heRBh12w55XMtdw
 Ak8oeSyhDtWv2RuBkG3Ip/pNGzCeA4vcoWsbX3NwH/6YhIryX5Le+o+4+HrthOlAup4l
 1gfozbW67TQsh964m221t5BLM9TPOewwrKqwsct8EAZB9Ok7F7CRFlFdliPA4qA+vE1w
 QNIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhZlt9kPKwjg5n8fIzt5QHwfROnExF/Mew0bZDH/JZW8mATN8C8glWHUyo+Ri8vU9hETUsnxE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nbtvLLf0PpRHpfUVOtvr3eeTi+X7bN/weUCujiY8NEDQQ8Q8ZE
 bJvFZXOqLpRnWFQZQd2wC3b8TLcbj3G0JH9qltjp+MffZsandeksm0Y50/Rh3d6DAVc=
X-Gm-Gg: AYBFou2TN43C1pzXqIRo0Zuk95lU11WpEIUIhasrvZTd9NclV6Hg78z6b43YhnyLVIE
 KaVXCmEBZP6/XNc11svb5YIzZOTRK0QosgSb+g9M2utFkh4ggvLRw4iJsHJcO1ATrbxJeI+YMzF
 qby8Al3aomwyU9QRhi6dcM2ss652U3KLv6TAUaDnjgbs2SQgsbYqnK5ZxSqxTV9QfZ2Sxd6uTAK
 n64Xw6VgUdMrbehzLNVoSkem3W9ckmR62EY/+24UeY4Xr9MTFxFeYUZHMwZsyJMIb9gApZ8G98m
 WdOfekHUNj65Mgj+vzggL6/ucj8I8fkthU4N5KcpRTbyfr9wtHnKj+pdMVYMbi7e4i6QyHvNzHt
 1Jsrty3KZbIapWvo/8t7K43J9pTTq1SjDujlGU1IDl6gzV4RPt4nmZ4iBMcVsoiJ1/8FPWMmy6X
 b/Qo/9eZCF2A2rO1Nq0ytn1o9wRbuSsIavf0wF1o5onPIpj9s4hS6cAabu7LSeO8KdCZKFj6J0j
 DoNO24YOspAbIFTtQfQjnn6dBTEhqjYBEhc1yj3dSd+GSlUTaRo5SM0ZjZ+rCU8Uu1I+3cVreY7
 BBqs8GcGIuW1cvQedXQ=
X-Received: by 2002:a05:6820:1995:b0:6e1:91a7:1a67 with SMTP id
 006d021491bc7-6e7a60b22eemr3115099eaf.38.1791397551175; 
 Wed, 07 Oct 2026 11:25:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e7941852f3sm2570739eaf.10.2026.10.07.11.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:25:50 -0700 (PDT)
Date: Wed, 7 Oct 2026 12:25:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Cole Munz <Munzzyy1@proton.me>
Cc: Simon Glass <sjg@chromium.org>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Francesco Valla <francesco@valla.it>,
 Anton Ivanov <anton@binarly.io>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 09/11] sandbox: spl: Enable zstd
Message-ID: <20261007182547.GC3079290@bill-the-cat>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-9-28e946f57357@flipper.net>
 <CAFLszTjYA8J4V1mEOAe9_0Wdv66y4iawoZWfbaOPMPteNXooyw@mail.gmail.com>
 <20261007171551.279289-1-Munzzyy1@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dJAwy9KTBjcI257/"
Content-Disposition: inline
In-Reply-To: <20261007171551.279289-1-Munzzyy1@proton.me>
X-Clacks-Overhead: GNU Terry Pratchett
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


--dJAwy9KTBjcI257/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2026 at 05:16:06PM +0000, Cole Munz wrote:
> Hi Simon,
>=20
> On Sat, 3 Oct 2026 at 14:41, Simon Glass <sjg@chromium.org> wrote:
> > FIT_INTERNAL_ZSTD and FIT_EXTERNAL_ZSTD cases with a canned blob
>=20
> I sent that pair on 21 September on top of this v2, plus a gzip pair:
> https://patch.msgid.link/cover.1790017078.git.Munzzyy1@proton.me
>=20
> The blob is picked by name in do_spl_test_load() and the zstd cases
> check CONFIG_SPL_ZSTD on their own. NOR only so far. I can add the SPI,
> NAND and net lines in a resend, or Alexey can fold it all into v3.

I'm not sure if there's value in repeating these tests on other
load-froms.

--=20
Tom

--dJAwy9KTBjcI257/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasaOqAAKCRAr4qD1Cr/k
Cm1XAP9Ojx2DjTBn0TpLg+EHFU1OyZEWIE8ASXx9NwEjBPTQGAD+N3eZYPYfzlt0
x5AKj3nqb2lgNBrvy9URn3np3IRnagM=
=KDIU
-----END PGP SIGNATURE-----

--dJAwy9KTBjcI257/--
