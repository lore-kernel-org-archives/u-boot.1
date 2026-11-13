Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182C606A334
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HPtDyjWd;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=N1LFQFyx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E87428132E;
	Fri, 13 Nov 2026 21:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhJR0hoTbk1r; Fri, 13 Nov 2026 21:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33BC881763
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794606945;
	b=o1//7ZU9cLZ0VE6JddEezGAvUYQ369bYfRt5+KkdndCFMPZ9teAbzl2sp5N5Ty+JU0ZI
	 5Sh85oPqBDH9L4aR74iACQdaMD0OBe9DgWs6wrW4/OfiVqRuluRIKTOJsGB41/yhqjllq
	 ENEXYAVUN0B3FlydtibpMf1/Q7IRWWhiMrdsv3Zc20RSItSIkEDi5jeevhhCea7361WOc
	 AMrdCKLl8P24QoK68H8fHui15DyFq5Q55dWLqT4b9SaiW9uft7ICeLMpvyI1OZGP5PMik
	 /4EHWzhFeY1F1UVb/NwtRSEie42NZ3xoMUWwQMdUrbJU4rvEUuAjI+zNAJ9bo5cpNzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794606945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NxqZQSe8aBL+YSLbzbHhCAocJiSSTsIzbf2MOma4EDo=;
	b=A9Yg1SSW5mzRPhPRPIgjSJPjABad5Aura/vTBloZdLsmdvAf3TJkey6TXh5/uGtRFl1i
	 kVPduR0j6z6rGAwiewoh/0s1VqKejZLt3yZit+x403x0suE4uD8WduKh5WYoePLwZDOA4
	 4LnimFsKRFe8+eZ/vwiM8mBh3tJFx7DbIklpM1+BI86qbf2SydMoZE+Hvz7tjV7wCLO+d
	 gifewYrHZkzCXXNFHRiB/7iTZ3ZNppjoHDfkLmeAMLmvNTHRXU4wWprFpKJgzmoDBGjqq
	 A2dLOLzntyPJOMm//Cdn2+3uPSxuBNabUzJb48rmu8s+ZOMCfluWGdj1b9nHMkiu2iQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794606945;
	bh=NxqZQSe8aBL+YSLbzbHhCAocJiSSTsIzbf2MOma4EDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HPtDyjWd25K/XQXS2sMC76n2ZtMgZgwxd22xY6sutobfnORb06/kz1kgFyaTMtg2B
	 Id7F6aH/Zw5tmh080cNOwAireOw3Qh7WuW7SCnin/61c16ExTLWWVmAApbCisyTmcR
	 rQAr2iQLDVhineDg/4naHe5gga7eZhf+mZdD3LO6cGZxh7K8aaAc9/f2xHLSiCp6I6
	 BJo68NY7kxoHXuic/hQ7rD+AmaVMGgeIOUIbQ9+ZBHsnM/Q8ARoAbxPvb111rfquBD
	 GbxF+h3+qReDdsDgfoMU1NMGUUXPwUbExpU1IYHde7L6NKZ3XXV8S+emrXLL5ELydR
	 SZjw8Q1FVAIcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33BC881763;
	Fri, 13 Nov 2026 21:55:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A7D2260
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 21:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E989D40DA6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 21:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7dR2RDXd7A7P for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 21:55:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B0A540DA3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N1LFQFyx
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B0A540DA3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 21:55:42 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7f84a55e31aso1678929a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794606942; x=1795211742;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NxqZQSe8aBL+YSLbzbHhCAocJiSSTsIzbf2MOma4EDo=;
 b=N1LFQFyxUqdT6IQMDJ3Ij7+0rK00KqLkINJK5SL850G4dpBJusNoygg4/MUxNGNxzU
 o6vIP6/nz7KjDW+NJmGiCmur/kYtcxZ4tfnsfuI2mfv8TQjF8098HY92yJUElEv0FWgW
 lAOqcE8gLUwHekJ359dkugtvf129xDcHNo/PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794606942; x=1795211742;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NxqZQSe8aBL+YSLbzbHhCAocJiSSTsIzbf2MOma4EDo=;
 b=1Ck6F02zRXXvzwjOLSQfW3fu6rzip/YkY3O2pEOvSo+tiLg0aweL0D1+cnHS0Fknt8
 ZEM+RwMizvsNTb+sOKHVKZ50SYOYvlMvteeEdeRqI2oUnbQONwEz30kP9sqyrpPgJNl2
 aJwF3cT9X/B6kCOmBWogzmElEu7TgClIaDYQUFpQIbKWMs0AIrzh5gbxAejFnWlGihsp
 ctQGBp0G9/G3iCQQnsuQPKLyKboauL+9a8vd6j9ZX2ue/t0QgKI9q6a642WL9BLUof1f
 vVo4+v0a8sFOMuq9oKRBfF/249tJXcrGAaXLW9ZE3baV0Cq1J+/uS9fyI3gyY/I3AZAQ
 aXig==
X-Gm-Message-State: APuU4Z/E8id8HmK/N8A1sVZCVS9DULQ7e4foLbUeiMCBFFC0DBXahQHY
 6kG5Spca0gLnXbksvy8Pq1805mxdy9ZbQNE4W3T9ENoUZB6L6/69rpabyNcBgJaaQoE=
X-Gm-Gg: AYBFou105R1OKGP+e5FIg5L3/hsRreXP/cpO+4UkyJMBZoA6aMHGcS5pMz2fwWTiAOP
 zVFnEPTRNleUMIroV7uwVLZUzCtS6dkNW+SpsRlag3KzZabeM5jzEEnguK29mJQFVmhy3vZjnms
 0EBbikTB28Jf5QKnboT5geJa4iCJ05YOrxBbKT+L3dfCDdjX84EQH4kjn8+FYBx7txCIL+20XwC
 +R7DkuCufE+YKFTllyFTYHSKKfu1ametVPnzQWH+9tPxsAq+NOWFs/ITWDodbVZ9ZG8TSMxXR3Z
 rf8g0i29WgmOiIDY5xlOJbUTuEut+5Rfpho7oKMOHQIQeQK/qtczn1kN78Saw4IKiGC9W9XY3S+
 H3fVVkm74gtfvJNi2ZvL2t1g9Ct4wtLxTEp+c3aFfJKZ1z9WaOPKGqt6OpnkNOGUqzTNNLm0OUN
 24842r7LHgmvQQFQ55fRzsdvOi4JpU98Pg2M9CFiVK6B7YBAzyK234L02D/Aa+7+fcvwGTt7vut
 6zNjeKPv6CpbxsxHzxgOeLHqZksL48IPLpEGu1UaV4NtoWVNlSLOOMXRdePB3n1e39g912hZo9F
 0WX7tp4EP81+WX94spMIbb2RffD1Yi7SmeIKmRMQvS8Z2V6EKyFda+V6foEuGZxZqT2GgnU9crN
 T1ZMreOwQfZysUT6XH0AZlGxNCE+0Puj4fG5CCjq06zg0Ppc7PsxPRUIPLWZxLgNrySkzjbVYEB
 GsPdq9RseirjXcZEGjGGJ8mW0ptNPCo88=
X-Received: by 2002:a05:6830:640e:b0:82a:bf47:a080 with SMTP id
 46e09a7af769-862898b702cmr3766190a34.27.1794606941713; 
 Fri, 13 Nov 2026 13:55:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862a0c3eae5sm454878a34.14.2026.11.13.13.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 13:55:41 -0800 (PST)
Date: Fri, 13 Nov 2026 15:55:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Conor Dooley <conor@kernel.org>, Peng Fan <peng.fan@oss.nxp.com>,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/8] Add support for RPMI to U-Boot
Message-ID: <20261113215538.GR554944@bill-the-cat>
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
 <20261113194911.GP554944@bill-the-cat>
 <avdtFdcuCvG6YE7f@MON-LT-C78453.mchp-main.com>
 <20261113202447.GQ554944@bill-the-cat>
 <aveC8cmCelxC0Hvi@MON-LT-C78453.mchp-main.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qhXjW8YtYYmT8sCk"
Content-Disposition: inline
In-Reply-To: <aveC8cmCelxC0Hvi@MON-LT-C78453.mchp-main.com>
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


--qhXjW8YtYYmT8sCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 04:36:49PM -0500, Charles Perry wrote:
> On Fri, Nov 13, 2026 at 02:24:47PM -0600, Tom Rini wrote:
> > On Fri, Nov 13, 2026 at 03:03:33PM -0500, Charles Perry wrote:
> > > >=20
> > > > Once QEMU is updated, do you plan to update / add more tests, so th=
at we
> > > > can run those tests, and presumably have more comprehensive testing=
, in
> > > > CI? Thanks.
> > >=20
> > > That might not be possible because I need a special patch on top of
> > > Subrahmanya's series to add the clock service and some phony clocks. =
This
> > > clock service isn't going to be upstreamed to QEMU because it's somew=
hat
> > > useless outside of testing.
> > >=20
> > > For CI testing, the path forward would be the sandbox mode that I add=
ed.
> > > The only drawback to this sandbox mode is that it will NOT test the t=
ransport
> > > layers, only the services.
> > >=20
> > > QEMU is nice because it does test both transport layers and the servi=
ces
> > > themselves with librpmi and OpenSBI (but I need the special clock pat=
ch,
> > > and we also need to build OpenSBI).
> > >=20
> > > I'm open to any suggestions that would improve testing and CI.
> >=20
> > If you take a look at tools/docker/Dockerfile you can see how we build
> > QEMU (and some other tooling) today, for CI needs. A question I have now
> > is, is there value in U-Boot testing the transport layer, or not?
> >=20
>=20
> Ok, thanks. I'll look into that.
>=20
> For sure testing the transport layer will have some benefit. I think the
> plan should be to have a QEMU test that checks if the firmware driver can
> probe successfully. There are a few messages sent between the U-Boot driv=
er
> and librpmi/OpenSBI on probe. That would gives us some confidence that the
> transport layer works.
>=20
> We could even test the poweroff/reset commands since this is in
> Subrahmanya's upstream patchset. Although that would only test the M-mode
> (shared memory) driver as for S-mode poweroff/reset uses standard SBI eca=
lls
> and not the MPXY ecalls.
>=20
> And then for testing all the services implemented on top of the transport
> layer, the sandbox mode (not QEMU) would be the way to go.

Having this as some future test plans sounds good to me.

--=20
Tom

--qhXjW8YtYYmT8sCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaveHUgAKCRAr4qD1Cr/k
CuMdAQDcBXwL0OfGvPJKt4INBm/8DD0197Shygfzk3ArQ/SsRgD/ZD4CE9WaGvjF
bniaF8jaiVCYmvGexmMNNcjtJoq5LwM=
=e/g0
-----END PGP SIGNATURE-----

--qhXjW8YtYYmT8sCk--
