Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C35606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T0d6Gj3q;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=L1pWjBbc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A35E6090C;
	Thu, 12 Nov 2026 18:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7mOZ3uk0alI; Thu, 12 Nov 2026 18:02:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 68C83608E4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794506579;
	b=PjFV2/sB0d43leNbWK+268YQyBvZ1wF/g5CxshQb2yUlLFVUVm6aU4hFY32vwCUrY8Il
	 U5BcnHnXAbPG80PqMOAW+USx1weJQfxZNylgMgkJPhMAx9sVyFJi57ySoL1Pxrjqkvy+C
	 VoNnBZ8te0AENjUiKWmMhnuUg5K9Ojfg9S4ZiPxdPmrQnpvbQ9TWml4RDQv358uhrUi9F
	 CgLW9mhszvVC7ifLkJmjOVzayjzHfpD1QUA1DqFefZ78/vnUE1jL0O0NkezDjA3do3XUq
	 7rKIP623Z9uR9W0cjRPG3zzfAzVKQfs4tyPUR+JrGLK0C7S+gFpvjV/A/qVodk9iE5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794506579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DT4nkLMC9sPZx4CQ4ZHjFrVpPhSstRbdzfuxdSxZeNw=;
	b=eN4T4ZG8FVTeQ6CrRqKYXdEh3HZydyxDuhO4QmMj9Cp2cS3pxVzyeXkpL5QVJIiSt721
	 aWH4rjystFC7MctUxsW9uYRnTktKEKptHkG6Of3hHtflHfhS4CyOkU770dq38D+Crsp7s
	 qayTRuiSIdF7Mizfsxtkq2Svg2ck92nzB5WZS4B2AUCuO/vGBM+v5H+BfkmbnfUpGyvKW
	 xiWgQtZYuO8X+d8Ab2RUO9++cIK7caizIIXWZ3Mop3pg5jngsQJ5gABhScNbtODATxt4s
	 qGZ01xalxdmvueWjQwIfKArHCMMn7wHj6XTxKJo9iJqYUM0ro0j35FuxdQGM60Fq4Bw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794506579;
	bh=DT4nkLMC9sPZx4CQ4ZHjFrVpPhSstRbdzfuxdSxZeNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T0d6Gj3qj7f6m0LOG1L9mrDYl+PUteVKQEM4WwuKvs/Epo8+2IQA7znBiunvqjxi1
	 YrBmH+DDcQplXzCGV/ttzxiLPkXB1UAclauyjCVMeo5fdLmkNg5/trq/zc2PQV11hb
	 /gSgdtksrTctQjchfayYUd/H23jLZfcz67a78fal0s/UScagllajGGt7BRXMJD/wMH
	 AIUDbNC5wRP83XrlkEVxlIzKFRt+TP9bq+nhu3Izm/TJSYBHTbc8cHribL4mxR5evV
	 oodbYh7erYZ7HscJ4wEjivIiO7mqv31fjNV8fZvAR79ERe0rR2/RTMUyhs+wzB3yuY
	 ca5vITvvLClJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68C83608E4;
	Thu, 12 Nov 2026 18:02:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 596AE1370
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ACBE402C8
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHvq74FhPV2X for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 18:02:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F283401E2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::7;
 helo=mail-oo2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=L1pWjBbc
Received: from mail-oo2-x07.google.com (mail-oo2-x07.google.com
 [IPv6:2607:f8b0:4864:31::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F283401E2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 18:02:55 +0000 (UTC)
Received: by mail-oo2-x07.google.com with SMTP id
 46e09a7af769-861ab2b429bso13497a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794506574; x=1795111374;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DT4nkLMC9sPZx4CQ4ZHjFrVpPhSstRbdzfuxdSxZeNw=;
 b=L1pWjBbcaJnqWoZiXul3B3uuAfFnx78KUW47Z50af8//IEsUp8njkEuS+spe+bBxIV
 CiSBu9Ss70qk70ANt4NBWIPcAslUkYJa4h2XWjUoIoeCoYn58Pow3kKq+OQTKLxfZehG
 lUbRBhc39jcOZSeZY1j6BQGkF27r5nGfvvEig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506574; x=1795111374;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DT4nkLMC9sPZx4CQ4ZHjFrVpPhSstRbdzfuxdSxZeNw=;
 b=OWjd8F7WkqNsiups5NMBYoOrbwJiD4qVvqLgJST/frE40Qj24ghB3PZEaOQp9AKSt4
 VVHowx8z/JRUzI46oYfVr9nOvwCY/zGzUrDTF0vaMDHGU0qYuGh8lG+IJB8zwOTY/Guh
 hp76DgHXrpcKUw80FLKeR1dHWlAVRDkcuXaBH4J+Dn2uRIajUJQy7tBG/qx+QxBvDur4
 onyZAG4K1F43DEEVOq2U/IX8mCFUi2/IVyiCs2GDn/OpPSYUcca8W2vZ/0+MktUtb7NO
 UfuoaV541Pj8Fy0ZmL0u4fBgkYYklQJJxvAunNv+cqVYhbgcoLHu4y34+jIdYiT/mOHF
 Sl/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErESUnzVJIzl1MynG+zpmdXHiyCnEVKdAIbZXnHJDRGm5R25YsCgN2PD/deqG+TKMNYLbdepGG8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9rfrDHlQ7gzYqvM40N5/auUqolm0//HyRPhx2b38d7qe14+EQL
 QRzLFXJuEq0H0VVL9YeHUa7sQuQPSpvTGquTepoC+pATL4v1ydxgimDqFIm+O1cYCRqMF9lTyoC
 bZyF+FMYSLwvvxYA=
X-Gm-Gg: AYBFou1osiM0Yy92YDGCf/1Kk60+eNzmu/aOJ8WnmJ1/OTlvYuWRKxM80N1Ufh1e/pb
 1wrsreRlwb2GormPcCPRBimN3ituGibGhNWW3JmVnBoOxhWlt+uLLTjQKqxt+vZhBtjKuDx/y5f
 X6Z7fr5OZ5c/s/7O8w+CJMfdSBFTApTQebdn0ASuLNq/c2yp05aquOz4y3AVy41zGcJmanWUxP1
 ftd1BE7vcLIePmTpl4+OoBy26/Ya7apZXyBgd+LzGWr4nVjWE3IS2VwM2kHv9p0en2sC6NY+SGK
 MoKZ5cjy7L6xZX/KUvxG7cK6jfSXdrAktEdBlCWuHHD8WvHhp6oRUZcWlBV2CUzAOZ1yT3IOjSU
 x3vXS29j/tV1Yo45CMqkf9mPNTSdmdcoI/2b4TM0tokjOl4BWKPzaoPIbrt+MAmEtVtejxk3t/+
 CUp+0NGg+gF4fI6PHnfMzgtQ1zRCevwyZJzI5jZcjUGAjEgtYO0DcOwT17UlQpE7VVa0gru+gZL
 d5VbELZDKpDylQO6N7Pa4XF5JqWQucq33U8TTNvTBmqVccNpiCGl2UwkXMQtJ/XJxAQUZPcwArn
 WSa7X9g2XIJY8dpbShkplrTdbSceVVuPgFzpyUF7upltlgak5bTjXxmxMZ9feAxGOMosJ65wdQe
 rDH3duPIGkJvR4OP85Vt7lUd6BpFHFlfE8KLZTDqGYPRJnX+xEe9W2Cot7yitgievBB7AIK/yqJ
 vvilVewioQF3ql9UDU8x5C49M/QII5j93n2DIcva4Li17j5HeyV08m
X-Received: by 2002:a05:6820:1518:b0:719:204c:fade with SMTP id
 006d021491bc7-71ab3dd702emr81159eaf.3.1794506574393; 
 Thu, 12 Nov 2026 10:02:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae23024cc3sm6048354fac.11.2026.11.12.10.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:02:53 -0800 (PST)
Date: Thu, 12 Nov 2026 12:02:51 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [RFH] Writing a project Code of Conduct
Message-ID: <20261112180251.GF554944@bill-the-cat>
References: <20261103172036.GS3309461@bill-the-cat>
 <xhkdbcxsdvux2.fsf@mkorpers-koolstof.csb>
 <b415d946-eda6-4ac8-a8ec-4b00a379effb@gmx.de>
 <cae8d4f7-faa2-43d9-866a-cf2ee5d07efa@freeshell.de>
 <20261111151231.GD255403@bill-the-cat>
 <c634666c-88e3-452e-86f1-d4e1456d597b@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MdXY53NCbGp7Ab7w"
Content-Disposition: inline
In-Reply-To: <c634666c-88e3-452e-86f1-d4e1456d597b@freeshell.de>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--MdXY53NCbGp7Ab7w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 09:14:29PM -0800, E Shattow wrote:
>=20
>=20
> On 11/11/26 07:12, Tom Rini wrote:
> > On Tue, Nov 10, 2026 at 06:54:40PM -0800, E Shattow wrote:
> >> On 11/10/26 07:12, Heinrich Schuchardt wrote:
> >>> On 11/10/26 11:32, Mattijs Korpershoek wrote:
> >>>> Hi Tom,
> >>>>
> >>>> On Tue, Nov 03, 2026 at 11:20, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>>> Hey all,
> >>>>>
> >>>>> Getting back on track with project administrative tasks, one thing I
> >>>>> have talked about the project needing for some time is a code of
> >>>>> conduct. In my mind, the best starting point here is, are there cod=
e of
> >>>>> conducts in other projects that people use and they feel would be a=
 good
> >>>>> example for us to adopt? Thanks!
> >>>>
> >>>> Have you considered the Contributor Covenant Code of Conduct?
> >>>> That's the one Linux uses, see:
> >>>> https://docs.kernel.org/process/code-of-conduct.html
> >>>>
> >>>>>
> >>>>> --=A0
> >>>>> Tom
> >>>
> >>> https://policies.python.org/python.org/code-of-conduct/
> >>> is another reasonable code of conduct.
> >>>
> >>> Best regards
> >>>
> >>> Heinrich
> >>
> >> I observe copyright license violations as kind of status quo for
> >> embedded vendors taking U-Boot code and stuffing it into SoC BootROM
> >> without adhering to the copyright license terms. Writing down rules for
> >> social expectations is not on my radar until the legalese is well sort=
ed
> >> out for the code contributions. We must not set impossible expectations
> >> on top of undefined parameters.
> >=20
> > I see these as generally two separate issues. A code of conduct is to
> > help the community itself grow. It's not a "legal document" of some
> > sort. Copyright infringement is another matter and if you have specific
> > examples, we should have a separate conversation and involve SFC in it
> > as well.
> >=20
>=20
> Will do, thank you. I'm pretty sure it gets murky around "A.I." usage
> and expectation setting for contributors where copyright is assigned to
> companies;  enforcement of copyright is ultimately up to those companies
> then not in the interests of individuals. These are areas where I think
> a Code of Conduct needs to support a basis of expectation for any
> individual contributor's other ... expectations and behaviors. Does that
> make any sense?  To me it is just pointless to expect a decorum in
> participation if any contributing company is ripping off individual
> contributors (who might be obliged to endorse this because it is their
> employer).
>=20
> Then there's the discussion about whether we care or not. The "A.I.
> believers" might suggest that we're post-copyright now and let the LLM
> usage be directed as responsibly as possible but anyway let it have the
> leading role, as well as the leading role in review, and copyright or
> intellectual property concerns are just an antiquated inconvenience to
> be laundered by "the A.I." as a new original work even when trained on
> this vast amount of individual human and maybe regurgitated slop
> contributions... from what I've read U-Boot community has voiced that
> this is not acceptable. Well, when legal recourse is not well-defined,
> what social constructs could be stated to support the undefined legal
> basis of conduct?
>=20
> None of the above to any exclusion of discussion about the social
> constructs it's just not something I'm prepared to think about until the
> gritty basics are covered;  what's the motivation for instance with any
> A.I.-forward corporation to solicit against and enforce copyleft
> licenses laundered by their own tech at-scale.
>=20
> And yeah we should treat each-other as we would wish to be treated
> ourselves, use "denylist" clearer in meaning and byte shorter than
> "blacklist", etc. I'm not trying to opine that writing it down is good
> or bad it's just that I'm unwilling to participate in the social
> rules-making stuff until we see what the expectations are for code
> contribution itself a little better formalized. I don't expect that has
> changed much, there is not any proposal to assign copyright to an entity
> that would act on our behalf.

Thanks for explaining yourself a bit more. Within the realm of a code of
conduct, individuals that knowingly violated the license could be seen
to violate the code I think. It doesn't handle the billion to trillion
dollar companies that just ignore the license or don't bother even
approaching the spirit of it, let alone the letter of it. Which is why I
think it's worth setting up a code of conduct for the community. There
are problems we can't solve, but that shouldn't stop us from addressing
things we can.

--=20
Tom

--MdXY53NCbGp7Ab7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavX/RwAKCRAr4qD1Cr/k
CjaVAP9B8JBM5kX8gzRiyQCrgE5SGJtdmp0UdpUIY4mOiyOjtAD/QdjodjqAbncm
DpuW253BBRbLkxeA6fPruHyX+V4+jQo=
=L3ZT
-----END PGP SIGNATURE-----

--MdXY53NCbGp7Ab7w--
