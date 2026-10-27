Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADB606A322
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=USZHu+54;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZUIXlqE3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C66DE80F90;
	Tue, 27 Oct 2026 16:25:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GekdiOtmniPO; Tue, 27 Oct 2026 16:25:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FA6380DE3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793118336;
	b=HAjJATujySm2mztWLV+lVwBHaTsrv41RaHa3+gQSTXMw+trnYqhobSF7LW0CEOAyAmyf
	 0qhtSTrT8MNTgPUOT2+1YCUPnvkufjod4rqdf3NVsqAqUc7wyqzLodj/MX9K6bSHnkcjH
	 n2HTRt0ZxHUeL5NYPh4Dyh4mL0Mi36ViQTrj2QZtsqHGeRNMKioUQ57HqfdxujtRD7pAd
	 MK/tWI7s5+3q+wRtqr5ulGiJRTkVIeuCbfm2VU0g4P4xFYgzYKIao2B55kpKnYLLIeDXe
	 wCon4Jm2Pf+8rTyTtXwbWfdouUD1/ALJywpSXCSzQcyamNL1ZJmzFLbXyUDYBSAnvog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793118336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f/UrpqpExRlwoBn8CVgQLWLkwB+x7CeRxf0DLKvX9tA=;
	b=jj8aRQiliPE+deNDk4O5Cn5RzDjca1m1qzuraHC3Mrtr+R3O46zVk+ry5nYvHZJf/Uvu
	 6hUNvII5nJRyAKhFK1Q7WjqyBeHekfAmdXk0HYGSMpulBePcFRIv3fYrja5eIBKtWrt8B
	 a7WkybVt3xZXTGokq6BKXtkEbpE7fX5UiRTrlLAWJYAyNdyfi3TE+qleqfPs0+QbVYZgn
	 NMtzjgmxS4+oZv9zOPuXJbozF/5goKEHea5Vk1f+8hdeDyGd7pl6CM7XGA2GweKbJW7eA
	 f4Y8GBlrVY6GT7jKYK0tIOfwEG8Uji3gw6vR3Owwe26fPmAh9gEjSz0c2OHCxVDW7mQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZUIXlqE3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793118336;
	bh=f/UrpqpExRlwoBn8CVgQLWLkwB+x7CeRxf0DLKvX9tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=USZHu+54p1GCrcCaSirwXPWSijwPtolB7IY14oLTvK1B98wD8itv9FV1W8a++KGHv
	 b3Dx1Tj2he6x8gyw2DMKPZRLeoXfWHJ30B/EaE9M+cIDu50MyQW/SM/aR/tXLyXoON
	 lxFkGQJmrJMsia1ujQ3rhNAl3ZiEOXKG5C+x2hehK/U0tT+EPsI2tIftei/uzTRNFu
	 7x2hgrRUvpoURmFQ1oo2rM71P+j3OjrzsxrwgBVbissPmGQAuUPyO88hp6sJprbxek
	 k2MppD/Z35DtaRD58O7hkWxeY7y4EsKQ9GASFVfcFlbnpRCc64srvR0oJQeyLKOmHa
	 l+uZqlwYHjjRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FA6380DE3;
	Tue, 27 Oct 2026 16:25:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84D732F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 769CD80DE3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:25:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2oxbGQ8IW9NQ for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:25:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6D6680AA1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793118334;
 b=lCPFwAsLGhWRu+dD5QTEyzI+hogGx1gKMmnIRRCXZecNFtmLTlmVJaY2AeEsfaJGu/+S
 qWuS3a4i9Q/X+a2gjZHsAfkt73PpXtQnxZFmRisV+3FZY8QFsemkm4qq3zQ66lg6L5Vc/
 mQxhFvRSRv6twnrs7XuDbWxea+TX72Epv+Cftb2SwcGjobRQvFeEuQ5j3o7jsepQNNRIl
 lqzsOpzKGpBl+I651wuK169m1fvrzICfJbTnvbBbM9Ssg9IAQRCxqy0VU2Yh21jn6IxjZ
 iMagB1r7Ktbax2vnVhe1fRHmT7WNxqRqUz8awaiQi3rXhEH5egrZryRSQoi+Dsh9ShQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793118334;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=f/UrpqpExRlwoBn8CVgQLWLkwB+x7CeRxf0DLKvX9tA=;
 b=LhbUOnvOcs00/nO9kRU5VtmkMHUV2I3DL/uorNLe1E9cV3QUiP96PFGGbpqDMvNaOonK
 iyOHd9FWluwIdEKJx05UVOO5z9mw4tBPbdECaoGsJDzzq6uYLoQ6OX6aXeAJAeEHSpB5e
 mebIgIh8xxZNg9OEsVUPSpFr0WKGscKh6ra4nPxWslPyi62S+MRg18eJfB7bvgqA4Koe6
 /+eQFSoK+L0z5yTEUmiU/7Zo0oiNb85Nzhw6UOcxq/jpkcMx8hz33iMOwvaOua5XacNw/
 d2Qnk0OrzMcVpYOHitKZwR4w54g81PgILGPpGBTf8w6F9cUx+zPBwDyHp81zYbNnsaA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZUIXlqE3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZUIXlqE3
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6D6680AA1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:25:34 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6dd059478dcso104083eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793118333; x=1793723133;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f/UrpqpExRlwoBn8CVgQLWLkwB+x7CeRxf0DLKvX9tA=;
 b=ZUIXlqE3BM0iQ70sq45sRFVEP8sR5IRjuRKZyAVTN7GZ6vQPfNHq+wsPJQ8P9g590l
 vKRHrw+u/4miGfH6j4a4LaWF4l8IJtE7zFfoQTdjBK4vlyfTORQcfvH/nxFMHV52fkBc
 nEZbxYaYGNsRwc4tBxXrtRY0aegg7Fq1Y86NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793118333; x=1793723133;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f/UrpqpExRlwoBn8CVgQLWLkwB+x7CeRxf0DLKvX9tA=;
 b=wZ6Su6cWJkIzsaNviB1XhVJLfT6hmDh0+IicT1RXdVUIujTMb0fGUDcYzsp2IsFm1f
 iXY9UQdbw/bG54xaqTVgCoiLl4JnvzrNi8rGXFLXjoIvk0nH4b0aWXAna5jkS9xTJBlM
 R/3JB21ZYYjz7V7d6soAquB0DL/mnGXNNG64yzKfTtP48D+oL8MsMj7gEkcFiX5EmeLz
 IkxyKt3T8MMtDaQH2f8aLH+s4wvF2+Px641xatnk6bYXNmL34Dm90bGIwZ1x+lcsL0hQ
 AIQ/c86rzuhNt84wUijKod/L05iQbMukYDc611O/cyhsu03U7b4cAR7lXBtjUtBcvGmO
 tGnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTRvBLCqfgNDqBQ+KrJ7Ij7KYipU/962qMSRLy5VCWZxAwCU5cBlY/Lg3FAqu2q4RyNvH++go=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKU+HVSZ/0S7lN1ejVdnAeTx9f0pNaJNuYPO7cU0lSVrOT7eGUw
 WbAkuWuLOWzkkrL1gWHYzP/HVGp3wJ0pexV9vuagmZuqmSUrKnwT0iy2CelEJRRd2o4=
X-Gm-Gg: AYBFou1gR9tWcmdn5sCfbQjg+YcjQ2O7/X0oBw/ouIemyaPgPzihHF2WjHP1+AR8A3s
 m2557TiIL7Amo/uTJQpdGP+ikk2RkWD4sZseL+2TfL3plloySIT2uESGoIHlGLHP5QyXKSpn6G0
 ec5DZEcdbsDfTBLTC0eFrOUQucpRplf7i8fiMWfRNODb3XTcdE3TNreaJUY4sOOYDkxnzjqtwxu
 6UgOZbPekhYAr77GwF0f8GzZ4yCjafrKjlguJDG9X8zhb4Tf+3nSIf4+n6nfTbHKfzdVR2R6XLB
 m4x8wHgi1PsSV5p7h/JZA5ZHzhJXwNysUwXKsIbAitsa6ecYKrXR4ciFW8M4m/K53D9k8FurXzh
 eViywcw5yZWARafws5Sfzyjuj9OJUJX8VjC3ELnzQ/ttF7LpTdu+aZ9CaChkJ0/IbD/I83palJj
 z9OfoRkNpbOBBy3n3Yme8XpPBVaARfJyA9XcAuQsW5ei150R+tYYlTdCrdlinHNiDH2nmeIRDdY
 mZw1tnFFxXzgimrC5I27XFImkEkNgucn6LkGL8QqXXc++Tz2dLGh0xdXGoeY/eudgBa1rl8LSel
 m3+cf5E8oDlVkagoCjykl45VGEqEWZFaWtH2kpMxFBSU1dDdc/y/tEmfff0BR+kz+LrP8/1qTbc
 UgGQCAsD/7zr1231A0rQeEF8DXt6PI1alPbFl8IIl05e+p9+5snm1ThGNphE88IBmvSti1YC1z3
 2Lxuu0v47o+MdynrBULbdEZm6HLQBnnlU=
X-Received: by 2002:a05:6820:1687:b0:6d8:1b5b:3a7d with SMTP id
 006d021491bc7-70ba0e119d1mr6019757eaf.22.1793118333372; 
 Tue, 27 Oct 2026 09:25:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b74c0a38sm467564fac.1.2026.10.27.09.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:25:32 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:25:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Cole Munz <Munzzyy1@proton.me>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Carlo Caione <ccaione@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel@sholland.org>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 Siu Ming Tong <smtong@axiado.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20261027162530.GC2177077@bill-the-cat>
References: <20261027012709.GA2177077@bill-the-cat>
 <CAKTNdwFp68LxY2BrghRCH=kCcRf6Z4Q_v4zXAPgM-VFB4QbxwQ@mail.gmail.com>
 <55c90ac4-1730-4089-b9a0-95de861c13ea@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7MwqUtj7UMyvmkr0"
Content-Disposition: inline
In-Reply-To: <55c90ac4-1730-4089-b9a0-95de861c13ea@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--7MwqUtj7UMyvmkr0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 08:51:18AM +0100, Heinrich Schuchardt wrote:
> On 10/27/26 08:19, Alexey Charkov wrote:
> > Hi Tom,
> >=20
> > I've checked 661173 and it looks like a false positive - but one that
> > is likely to reappear going forward.
> >=20
> > On Tue, Oct 27, 2026 at 5:27=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >=20
> > > Here's the latest report. Since it says 20 out of 25, I downloaded a
> > > report as well and the 5 not listed here are:
> > [...]
> > > CID 661173, String not null terminated, boot/bootmeth_bls.c,bls_boot
> > >=20
> > > CID 661173: (#1 of 1): String not null terminated (STRING_NULL)
> > > 7. string_null: Passing unterminated string label->name to parse_labe=
l_keys, which expects a null-terminated string.[show details]
> > > 309        ret =3D parse_label_keys(&body, &scratch, label, true);
> > > 310        if (ret < 0)
> >=20
> > The string it complains about arrives via memdup_nul(), which does (in
> > lib/string.c:357-358):
> >=20
> >          dst[len] =3D '\0';
> >          return memcpy(dst, src, len);
> >=20
> > Apparently Coverity misses the assignment of the terminator which
> > precedes the memcpy call and flags the string as unterminated. Shall
> > we swap the order of those two operations to keep Coverity happy going
> > forward? The behavior doesn't change either way, although directly
> > returning the memcpy result (as it is done currently) looks a bit
> > neater to me.
> >=20
> > Best regards,
> > Alexey
>=20
> Hello Alexey,
>=20
> I marked the Coverity ID as false positive. I am not sure if Coverity wou=
ld
> understand a changed sequence. A tail call results in shorter binary code
> length. I would keep it.

That's how we should handle it yes, mark it false positive in Coverity.
Thanks Heinrich!

--=20
Tom

--7MwqUtj7UMyvmkr0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauDQdQAKCRAr4qD1Cr/k
CswDAQCAU/I4v9itEbQc1Pp0r6P4HuChZUgUKt96KRvDujY02gEAp3yn6S+Wjesc
EwEJDoY2JV2YYcx2oH1abpHtM8on1wo=
=+ZjE
-----END PGP SIGNATURE-----

--7MwqUtj7UMyvmkr0--
