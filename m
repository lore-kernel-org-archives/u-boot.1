Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E31C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 17:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC78B87674;
	Fri, 27 Oct 2023 19:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Td9FZACZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2507487678; Fri, 27 Oct 2023 19:22:44 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD3C87671
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 19:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66cfc96f475so15684246d6.3
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698427360; x=1699032160; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C0AodciCtfUJmBkFVQsPAOukB/5k1PMiRw9eKdbcFyY=;
 b=Td9FZACZtQFmh8P1Z2sgcWjw2N3bhRvYcWicw3B/OzB+TnSyVKmP7LM5FCsUUc1zMg
 QxYosH4Nq6Z76s/1eMlfbd/+J5Orodu+GUZkYq0YIRtrm5QtI9zYupqbPcHyJT6mMess
 VMSYOeA7/MSfXe4lm5yKBvogalC/jBQsBPGBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698427360; x=1699032160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0AodciCtfUJmBkFVQsPAOukB/5k1PMiRw9eKdbcFyY=;
 b=vF/suGNBtE7bzIOZ6rZkeyRAsuE9nnaPGaEDzg8NPnERmvVrkVzZAwyILkIQklzwD3
 7y/LT3bLBRhvpseES02yiCR9QMpWPBqORe/jV0mEQIr9wEomCJ9BHmtq5cc3hvtWpVqW
 TkgrveD33WCQJ9x2m5O4tTi2ZwWeB/aqDel+rbvBQUriCaAgaDlPuzhS5JvDjIVAElbf
 mgRMqPef2VUTAdaCNpsMVLwKCPVXjqcxdlefQ+2kDae5m1P7+UH7avWCAkSmVsScX0wZ
 oLB+RpZfE21h0zlLFQuurOY9/x/T5Tf7IF9hHb9hlhhXlnDKJVBXhbo5ug+FInxoW/gt
 PO5w==
X-Gm-Message-State: AOJu0YyT2d2sUxXWSFibdfvz8ybWVbtiyhAhF/lX8/Bx0Qv6zu5n/DRb
 w77R7wfKi9cLylsKfECU8jFh5Q==
X-Google-Smtp-Source: AGHT+IGbxueMxzI0j3LjvOwF0MXMLOSYod4PO/nZjAHL28tQ92E7m3+t2G/UPB8DfipSM2JFKnTZHA==
X-Received: by 2002:ad4:5c6c:0:b0:65b:1594:264e with SMTP id
 i12-20020ad45c6c000000b0065b1594264emr3739189qvh.51.1698427360393; 
 Fri, 27 Oct 2023 10:22:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 mn6-20020a0562145ec600b0065b29403540sm770066qvb.127.2023.10.27.10.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 10:22:39 -0700 (PDT)
Date: Fri, 27 Oct 2023 13:22:37 -0400
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>
Cc: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Will Deacon <willdeacon@google.com>, Ye Li <ye.li@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>, Alistair Delva <adelva@google.com>
Subject: Re: [PATCH 0/3] Revert HAFDBS changes
Message-ID: <20231027172237.GB496310@bill-the-cat>
References: <20231027002409.430285-1-judge.packham@gmail.com>
 <20231027094947.bhtwngq26e3loya5@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qk0klUi2v4O/qMon"
Content-Disposition: inline
In-Reply-To: <20231027094947.bhtwngq26e3loya5@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--qk0klUi2v4O/qMon
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 10:49:47AM +0100, Pierre-Cl=E9ment Tosi wrote:
> Hi Chris,
>=20
> On Fri, Oct 27, 2023 at 01:23:51PM +1300, Chris Packham wrote:
> > As discussed this series reverts the HAFDBS changes that caused an issue
> > on AC5/AC5X. I think there are some improvements that can be made to the
> > initial memory map for the AC5/AC5X but so far nothing I've found makes
> > it compatible with the HAFDBS changes.
>=20
> Would you mind briefly explaining what those issues are and/or point me t=
o the
> discussion where it was decided to revert these patches?
>=20
> The feature is quite useful for users of CONFIG_CMO_BY_VA_ONLY, to speed =
up the
> boot sequence: instead of reverting these patches altogether, would a rea=
sonable
> alternative be to put them behind a build option?
>=20
> Also, could you confirm that the "initial memory map" you are referring t=
o above
> only describes actual memory as, IIRC, some boards were using mappings **=
much**
> larger than their DRAM address space?

The most details are in this thread:
https://lore.kernel.org/u-boot/CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=3DJ0oHyv=
N75bTaCUw@mail.gmail.com/
with some follow-up in:
https://lore.kernel.org/u-boot/CAFOYHZB7jJWwD24oWzx6u55w2whHYjK56f=3DQyN0LW=
U4Z8dSP+Q@mail.gmail.com/

--=20
Tom

--qk0klUi2v4O/qMon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU78doACgkQFHw5/5Y0
tyxuNgv/RzNwZ2Uq7vmXP066CScRfA2+Ej/wPMUISCtJbRiSokhVrETuplR6xMOM
roW6ldLSiQgqsWUpyquaQYyFc8F5PSKmmne9CujDF1C5VyNc3cbHJz0VuWd7XWuJ
LAfen65lcAAPp1CBD4iKuk6LNSrJ8xXmjEaJe10PRQBiLEDONhKaTiZ6k9XpoEB6
MCMjsSsKxfAW3rPUe9RRY814T+JXHtuiGap23xLT4Xo8vLJz9EkKKEqr4a6jdthW
X4n4CrdDkq4GZ/Ukoj8LWX5WGQR3Ce7xRHN62BgCQCwx8X5Z0gldrc6w0urhrHiQ
mw/1CEmi40wT9e0jX7yKeIZjRdUIng70u1jjdpzH530KpF2UizZMBLPIY4uxWoG8
6ezl4n9aaBYjMSC/J1a5Dk6Moa2LOs4umOH45fstW8Uba3WV6KHY2lHHD0gJOCV5
/osVPFlgKDTGUOwQv8j1SFKZUVDNAErmBwP6DRqcV5unqd+ASm3Lc0nn0P5DvlYh
jMa8laY+
=QYaV
-----END PGP SIGNATURE-----

--qk0klUi2v4O/qMon--
