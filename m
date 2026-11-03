Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E4606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=df8UxOIR;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qEKftbkO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C867A60859;
	Tue,  3 Nov 2026 15:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQHt_LbJ62_A; Tue,  3 Nov 2026 15:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 054556082E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720851;
	b=EG2BCU1ePJ3CoKmaYpa64eT9OnY8zqa4JvaJdBaP1rmwaLxcwQSKU5ip3Bh3wdiK9+vt
	 RJqxdujMeyE2ghKb2/trqSVRwi1EwFpliiSvt19x+WUGKPJNUkFRv6yCcW0Km7Rm1cs+/
	 s1D+cvVbA5VMZPfNWBlJVjcq/0I1ykgsTpBgbqGhWq6ir5/GMBlmbmJ9RMOQ9VVagIoF4
	 JrqEamdDHSSSi6qjFCdhggBRA4KOGbsc4Qgz5nQ7j5AbaVZg6XQ+oyZR5UQDFxwC8cz+j
	 j1dCiF3JO1tc8Zk+dwWHUeb/OuUXcCA2xPvhpskSy/sspuZtfT5+Fgy/DI8zmeLIsNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720851;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9uBlrnHvSzwUsAQSJ7fL8VC2QObSpAkahumML3uhZxQ=;
	b=gjiobZk++mZEoZbb4Ay5QnNmM+nGnFmI7dzCXexAMNqWbeUANl+aKi+3nkcWiVwuadEB
	 M4ba8bdKwXxYdBraq/aRb/krygZuWRQ2X2OoAGNtXLd4ftXJ2yCuH6m18gQ5ptF+PbMdB
	 64zxWJuDutfn8EQGlxlYNoKmIiArC7fOVo8o8sazH9X63F/Rr5E0tcKQ1i7tX7BcMoit+
	 //0FsYt12eIRTrJC38zUy1R0FU+3KSbtH6FCA6hTH+5u0XWqzE2b6+baZvrVDsb0hGJv+
	 i75fSjY6ityfyBucQdx3ioFS8CqNWWKegjElOM/KTWtrdrEI1cn6dEEASLApDhbF6Wg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720851;
	bh=9uBlrnHvSzwUsAQSJ7fL8VC2QObSpAkahumML3uhZxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=df8UxOIRQ6hlu24c277w9Z5Z6r7uXEAo0rOAid7SpwLlK7pktFKJqgZ9JKHrf9byW
	 izu6VoXTDOG/Tdgsji2c0exaMUx1lrwO0FjqYsQACqF2NZCPxIlpuCiby7shTXw0a/
	 zUbyM6HG0WhhWV/pPAOPJYoW7afWOU1oupo/64+zdGYGmuZvoacJjsEn/ZPSHCzVpw
	 x/gDGhgpZo9/m78bbpzSddAFmPFL3Ukl8+AX4O/QzWMQ38CaU7JqcfQEi8CiHeJeex
	 xeO9ttC4Gw+PAtTTE5Sg6S9v2PznKotbbW+e9TbTeB2SqUPlQzB8ZRB1b2vGC9jKsn
	 zbZcLJtqpizRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 054556082E;
	Tue,  3 Nov 2026 15:47:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ADD01A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9384C400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRwVTPuISkQg for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:47:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DAE3340068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720849;
 b=ixPIrzFreFftQ43otMkbvY8eGqKRbqIFclItyqJ/GY9fDuAaG8PVUh4yE7rLSktMEun0
 bsLRs7TiycRDqf/GOim30fVtDYUThbWp+Nmod8hrjf3ES28QgK6DgeZtfdTXyk7TJ270/
 2v3JVP+lLx2FRMYKGIcH5OXO3zP1DCFFUnM+095UiSWysSGZyrACip4I0uY4O3oSLzBlF
 ZTx6tpyNq+vjwpdDCa2R1BwphKE46K/L5JZcXqrqOf1iNbxdWZqoeJ7tL79PFJ2OrPl79
 3GpmCqDrFMEG8kcDu524LfvIJVEHTbDb/K9qnNTgy+OPkZIvFn+TFmP9y4vNGus+K9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720849;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=9uBlrnHvSzwUsAQSJ7fL8VC2QObSpAkahumML3uhZxQ=;
 b=emMGXJ4TcpQ1+8M4lU3zORc9pEZPECk+leVi9EfxapI+YIJUqKx13cCmw4QZICzFLcwO
 X2+ABm2ySY9OcZYbCczGE+iymaE/CzsngSWqh53KHThVL4vb5eNo8SPVGTOZqcCzbQoy8
 xw0Jo8LDsjI8TP/IonLjfWAecRtOyPD11bYOxxDjwiJfIGvU4acbuU8cv15hvI+CEdsk8
 P7Rgj0D8InFTzSTnCiD8anzReqN5ZSPiK59Hsle+HLzcuaHZk0HlqxNnFdSJm+RfWA5+G
 uXRz3IBi7bq/MC3zRitSZOXrfTnTc7t1wFl+xiOYmePSvGSF1FdTdOMGRh2PafG2k7Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qEKftbkO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qEKftbkO
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAE3340068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:47:28 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-823e4047037so3172035a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793720847; x=1794325647;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9uBlrnHvSzwUsAQSJ7fL8VC2QObSpAkahumML3uhZxQ=;
 b=qEKftbkOaxCxKklsGX4B8uNnqgOpnMujUREjQ2IcOdPT4j4kctgIBl+UntzFbOueYa
 DizDxGT3y0A2fHtYqdiwaEq7hc3wbzhlllolSCoStykxX7wfDilIouGRcL5Sc8GI+nNl
 hmmecVnzBeU7XmlnRdsP47ctjtigKJQNZgsmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720847; x=1794325647;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9uBlrnHvSzwUsAQSJ7fL8VC2QObSpAkahumML3uhZxQ=;
 b=h4ru8XfUiIoona/FH1NmJZAZWF1GYiXpvoIWdSmaNllpPZsVOsCwjg+rxuKt4BputZ
 BajXzCPMuJGf1lgYklTTgLMfABnwBcipoZTCDub/hntDx9RBetagIhC6PMl6hy/kXUKm
 Sz8MvMhswFIN5io1yzYcL+XaaUIF67iI0reW3XY+JiJt3sKCyyDaXdg9ZXz6ZT35p1kh
 bR0xQQ2kzMOmk5SmAVjF588Omro7/qADr7HY+FwSWp7RCKdBspi/XIvgD+bquCkoywYB
 aVifpaZbe02JuOlCv5R8+nv4vq4NK0/Xu9M4xo6wEX5l9rlcsCEMli4wAHT9zBJ4Pht+
 HcXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4XjiCUGSXoxKM7jJLFhYyOlVdz5rwVglaI/TaCr4SwsEaaB5dHTFIvbUVkO66f/HfZLPRj1Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+OxuhfQtmiLXlaIz1embTiiOqSV5WK9Pz1516wL5Mbwo+aBaBV
 pS1BS97yQqsi6Em0kz/cwlhSxnInHRXt80Mf3pNHCrDmQhJNrVRj0r3birr0sns5lEk=
X-Gm-Gg: AYBFou2o7HQGoyNFgzm71MWST+fq8kKHKe+JLdem74Q0Nzt+UpLnst5R+ZGowlHWOjs
 w7diVrDQx1U5zBe8X2U6i/qd8KKsAeiA5uIhss/FL+WM0iUG8Ml+hXdEyKiPuR8tHXUxlK6hqIh
 rN/6VvbO4+Ck2DOiJjVEEVuZO5nbHhODZ71U6V+4zmU/+dwZ8MGHke57CZKinxYvjXp/C7SzGzW
 hppR6fNKneRwJIxprG7GKUpGS+IozRQYrS2aZwlocgGNE4lZyXlmah59048ybQX9X4YYGIHocQM
 RB7PDB0OhMDUDwrWJhyW8C8beKg0WauLrJkgtTvwZj+ffadg0HKB679cHsQvea4GtPttmHDQKvD
 UB37rWR6wQuqZ4sGhwWqcSeqAuaHQcum0pRz/dhurzRTMaphtLoE1Hr1arMFz2GnwUV0jbpp7I/
 8j8DWEQT0XjPLKeCpXvNlapM10YV2Sh3cgOmPplmTMEBKokVAmlsEIhzwKx9uH7aDNMoXaYExAo
 1o1qTQFRIW40de5L8JtP1Q4pRR5C77kafxETsov/3dm+2jt36HFf4iI9lTNC3j2BusT7njffavy
 XPtP4PNbAJFBq6vfI61mnEH/Npv4yGDhu+wu5wEqyvpiFs67cEuU/sWGfnfDXqWy30dOM3L3Axh
 dtWY4H/ONZTPE4KCBYJX0vPJM2gEdgxNMTiHhdZg6MGMbp+jY4IqRhzgiXDGdlINrRTkNho2oqB
 rbahXF4sJr7s5vmjzksKUnr3Kvqgkp/C4=
X-Received: by 2002:a05:6830:4c05:b0:844:4959:e855 with SMTP id
 46e09a7af769-85d3636d94emr10138433a34.6.1793720847187; 
 Tue, 03 Nov 2026 07:47:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d355201f7sm11588637a34.23.2026.11.03.07.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:47:26 -0800 (PST)
Date: Tue, 3 Nov 2026 09:47:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3 2/4] configs: add qcom_sm8550_defconfig and
 debug fragment
Message-ID: <20261103154724.GR3309461@bill-the-cat>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
 <20261102-ipq5210-v3-2-aacf3930848b@oss.qualcomm.com>
 <20261102172155.GE3309461@bill-the-cat>
 <aumczyxGU6jw/IiJ@hu-varada-blr.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i3I9Z1kyoUs4wq19"
Content-Disposition: inline
In-Reply-To: <aumczyxGU6jw/IiJ@hu-varada-blr.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--i3I9Z1kyoUs4wq19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 02:05:27PM +0530, Varadarajan Narayanan wrote:
> On Mon, Nov 02, 2026 at 11:21:55AM -0600, Tom Rini wrote:
> > On Mon, Nov 02, 2026 at 11:22:27AM +0530, Varadarajan Narayanan wrote:
> >
> > > Add a defconfig for running on sm8550 as the first stage bootloader a=
nd
> > > associated debug config fragment.
> > >
> > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualc=
omm.com>
> > > ---
> > >  configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defc=
onfig
> > > new file mode 100644
> > > index 00000000000..40f7c857007
> > > --- /dev/null
> > > +++ b/configs/qcom_sm8550_defconfig
> > > @@ -0,0 +1,16 @@
> > > +# Configuration for building U-Boot to be flashed
> > > +# to the uefi partition of QCM6490 dev boards with
> > > +# the "Linux Embedded" partition layout (which have
> > > +# a dedicated "uefi" partition for edk2/U-Boot)
> > > +
> > > +#include "qcom_defconfig"
> > > +
> > > +# Otherwise buildman thinks this isn't an ARM platform
> > > +CONFIG_ARM=3Dy
> > > +
> > > +# Address where U-Boot will be loaded
> > > +CONFIG_TEXT_BASE=3D0xa7000000
> > > +CONFIG_REMAKE_ELF=3Dy
> > > +
> > > +CONFIG_DEFAULT_DEVICE_TREE=3D"qcom/sm8550-hdk"
> > > +CONFIG_QCOM_GENERATE_MBN=3Dy
> >
> > Commit message doesn't match the contents,
>=20
> Will fix the commit message.
>=20
> > and maybe this should be done similar to some of the tegra platforms
> > where it's just and only a fooboard.config and documentation update
> > rather than a full defconfig.
>=20
> Added a full defconfig since the script needs CONFIG_TEXT_BASE of every S=
oC
> in the MbnData table.

Sorry, which script?

--=20
Tom

--i3I9Z1kyoUs4wq19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauoCDAAKCRAr4qD1Cr/k
Ck1rAQCT5/AIBOM2tokW+0TqvYihM3Otgw6pTJiaLWagG9Rm/QEA1BYYXd/SO/Kk
ZVGdkk3fm/1tH02YZ4KWcvSHR9BILws=
=RdKZ
-----END PGP SIGNATURE-----

--i3I9Z1kyoUs4wq19--
