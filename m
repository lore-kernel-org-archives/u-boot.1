Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A38606A695
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ANNEXrcI;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=keiOHRlG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 711AB60778;
	Fri, 20 Nov 2026 22:50:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0zR_2tJLT9n7; Fri, 20 Nov 2026 22:50:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D026C60698
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795215004;
	b=dPPtP6u99wCK3rLCFa5hQn2O0QEZQORdsWVQoA9XekRQ7b6zsOw/L/cX8zmpcbM23pbE
	 cGL4P8d2pJCxccJY/B5J0E+X4v8zAE/8IQsScwim0U5nRc5U/T+/sJf+lw4XBzmtC0f/2
	 xu0bZO+egRS38b34/StM6DIOVtY5B8lfJS340fj2KnLbt+iqtqadnTheiv7DwGzRn9pbq
	 sF94SH47wXji9UKCjYhRa4Sv88sAJPQBTVcmXXgrZ42lm4+DMvxfDngUhBb/1Pj/SDnJL
	 mlZWXIZuiGozYtH2orTUyGrbMdUvp8gIt+ENYRbq7l6tckHbZ0YIuTNxkpMl87dfefA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795215004;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HI1zma7frLSQmO+5fGUUaUOPsXsH2FoZsPAxFKbOZqQ=;
	b=Dm1Y9lzn0PSUe72ImoDQDMNa2XbjyAdNz5ZGzDXjDAtXFx2+pdB5sfUujgzNUx4ReNhW
	 FeIphYxg4dbRNK1N9n3jhTd3f0QPScHvplIfpCprOB5et3dPSB5LodyKV52hPSTgncq2T
	 wiNkTkm2K8V85b72dVoDF0Aqbj5cFZpws3j7jItEkRhERD9EmXUmCPyeAl/hnJ0vbBYlj
	 DLXmGwA4lrUHkbTkT/vQMBh9P7e1em9bQugvRVeyLO0bIa6Ijz64jl2WtfGyorZ9+blZ6
	 Dvtcs/8M0H1/98Na15AbvIY5OCo3LytA8VjP+uQ7+q7iGDwF4NuqfSHKugviQ+Y6/jg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=keiOHRlG;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795215003;
	bh=HI1zma7frLSQmO+5fGUUaUOPsXsH2FoZsPAxFKbOZqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ANNEXrcI8nrj6wAL3bJ0CnqZ6jkFkAvTwB/5mY79HpfYPGtsMrTgsYuJlvEhoQnhZ
	 9K0WUvAnQqBcBSIHgXrSJosov12zOX+vf+EcLSc7ykJHozpk3XuSmB+anT/ocIQfRD
	 f4f/5lHZJmlz/R+ocT3W3VtsGG5KvBdcCrJyhIWS7BzzmzQCuFVI4g5LqzCCS7bYE9
	 E7iaK8J44ujDMujnkLWcRXcgMbGlVZhiYA+KKUlqkXykO+Edhoyx2IkbSu/b6unMOi
	 f8wvK9ZnEUm1d4Feu32xP+UTFhrXIcCLoFyj8PsPwd0Go61m8gy41SqVW40/BF+lTe
	 a1JsSqaFcf6Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D026C60698;
	Fri, 20 Nov 2026 22:50:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E6EB9C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6ED6F60698
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:50:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YCPe_vGy-JzQ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:50:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08AA360618
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=keiOHRlG
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08AA360618
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:50:00 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-862df509d48so1039514a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795214999; x=1795819799;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HI1zma7frLSQmO+5fGUUaUOPsXsH2FoZsPAxFKbOZqQ=;
 b=keiOHRlG856AJIR4qGjYazj5c6IcY597CyiRlqYSpd6urh+7gDiEesFD35DxLLEi5y
 WQMPOrch5zxw5ufvObkmw78e9+Ny1q6SfJCINPXAaQMH3AffcIB8wCS+74IL/Nej7UoK
 pS9pVVLDBHsCqh4dq4h4Trlt7jN5GQAsKi3Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795214999; x=1795819799;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HI1zma7frLSQmO+5fGUUaUOPsXsH2FoZsPAxFKbOZqQ=;
 b=Nwd6uzK8KoYLN8vMEdFZHLi6yy0lc5n+NGfyLzYcMxNk6hGc2AIEkiT5w9SusE0hhr
 poU7Aq2ZD6RfLVTZQbljjntuNTf4mMqu38noBE2fmv33JvGTx8RZI8zXAB/psgsRDqGQ
 cCadPQG/Lk6s0BoWNTCfisB8KLCjEUhVyDhvqs5FW1C31Ef5GG6Qd7DCiaY4YQJYXXWw
 ip30yKIWB0FmM7QIw8xsrF4iPQzecPiJaz4aJdwWBUiHUEzBP1nF5t74a/jraHxeR82M
 EAaAISg4w1RmYx1G7GwKkPVHMn01W03eNHfCUl8BSzDZQbbq+Fxv5NOE4rBiA8mkvpKw
 kk5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGWMlGVyqvc8myWnxJwO0x1SPvxZpW821vr2haD8YH5LXFxNOg6Arg4rShxJCr/sqXv+kjCwnM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z82VQ3KEHMIDwiLBGBwudum8A44JllavLqtp8uynPEG4kNHL6IJ
 8lZdyjrSEd83PmfPZehOlhC38r4u9i+OYXcxNHafcC44bED4ZXbUPmp0bKNhAIXGeXo=
X-Gm-Gg: AYBFou3amZsDCsGMykJLXCk8ND9WanX08EObn6Pnr9X1fqXTVUG1u/7sw0cT9Ct8dYb
 vqHlEQA8Bw6reKrcTtNwwHxnzejm717YREZX4JQnX8CPG94XtRtZGm1Tvsfum6ZEEyODzpvE/Cd
 +UVQkNS5lBTO3a+zc+b2AlnMM6ZALPqmZ4SwaSmYh4/PGlIGV1q7S0yHIxUcLgopep+2KgiC6+N
 Rouxc5S3je/SQBqV2G7a3aCz2wg9lGeJCzSghhaCVjoLM5bH256S+FsZCNEWIX4hH/cd3fulvvZ
 QefiPpEpeGnJS8Ei2qrLpZgJm1N39hsjZmjzKAKqBF5ayJSYK2m/8zh8fPiIE5/jjtO/vxEt4F3
 wxFmj6TN8HDX0fPjNNc7n7wfF31WyOQDBVq42odv9DGC+3xDIsQ7T/No2I+vo3wpEdpOQwDjPBc
 HJ1vwoDDfekQSQqIHzi8U4wi6YmSboMzzw8PMACnozT4YoXWe+yvSbx0IIprWk0p97piX8T+RHB
 s1VpSLYTjz9D0QDwkqd4fxHu+OEhJAQ7qDddG+up/SM+VWULaV0b4bA2itK18NSJMw5CkLnQGXq
 O+H3aGWc1FuqW6OdUaqal3EO65zPc2P/TOrtQtrU5K4uuhoJvMcA4Y5raSV+Gtzl9/lK8SQsHk2
 EG8ReOkOeDSPALDFiUvwsqcZ2x3FlylHUn6iseOyI6YRF9ZxjBoKfRk6ALqlaCpolpVMvTyl6TW
 AU/qKDxfIjMg4JQevdLP40toMK8tzadAk=
X-Received: by 2002:a05:6830:6413:b0:862:c617:3f42 with SMTP id
 46e09a7af769-86315633593mr3986932a34.9.1795214999294; 
 Fri, 20 Nov 2026 14:49:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168bdaf7sm3175221a34.5.2026.11.20.14.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:49:58 -0800 (PST)
Date: Fri, 20 Nov 2026 16:49:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
Message-ID: <20261120224956.GG3176972@bill-the-cat>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
 <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <83adafeb-674b-4e2f-96c9-b8eb7694dc0a@cherry.de>
 <avT2W0RNmRp9tSat@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <159ee406-e78f-4ae9-a1cc-0a0e7b7c72b2@cherry.de>
 <awC1OVSjsbliQASr@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QNT42XIH1zO/CMRJ"
Content-Disposition: inline
In-Reply-To: <awC1OVSjsbliQASr@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
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


--QNT42XIH1zO/CMRJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 02:01:45PM -0700, Eddie Kovsky wrote:
> On 11/17/26, Quentin Schulz wrote:
> > Hi Eddie,
> >=20
> > On 11/12/26 12:12 AM, Eddie Kovsky wrote:
> > > On 11/11/26, Quentin Schulz wrote:
> > > > Hi Eddie,
> > > >=20
> > > > On 11/5/26 5:56 PM, Eddie Kovsky wrote:
> > > > > On 10/30/26, Quentin Schulz wrote:
> > > > > > Hi Eddie,
> > > > > >=20
> > > > > > On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> > > > > > > The Engine API has been deprecated since the release of OpenS=
SL 3.0. End
> > > > > > > users have been advised to migrate to the new Provider interf=
ace.
> > > > > > > Several distributions have already removed support for engine=
s, which is
> > > > > > > preventing U-Boot from being compiled in those environments.
> > > > > > >=20
> > > > > > > This series adds support for the OpenSSL Provider API while c=
ontinuing
> > > > > > > to support the existing Engine API on distros shipping older =
releases of
> > > > > > > OpenSSL. Build dependencies for local development and CI are =
also
> > > > > > > updated, while the final patch adds support for using hardwar=
e tokens
> > > > > > > with the Provider API.
> > > > > > >=20
> > > > > > > The changes have been tested with the FIT signature verificat=
ion vboot
> > > > > > > tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1.=
 All 37
> > > > > > > tests pass with both the legacy Engine library installed and =
with the
> > > > > > > Provider API.
> > > > > > >=20
> > > > > >=20
> > > > > > I'm NACKing this series quickly because we are having pressure =
=66rom multiple
> > > > > > projects and Tom would like to see this fixed ASAP, and this ve=
rsion here
> > > > > > should not be merged. From a cursory look a lot of feedback was=
 ignored,
> > > > > > possibly because I did too many rounds of reviews and it got di=
fficult to
> > > > > > follow. I'll therefore spend time next week to collect the revi=
ews I made on
> > > > > > v4 and that sill apply and post them condensed on this thread.
> > > > > >=20
> > > > > > Please, we just need to fix the build issue for 2027.01. We don=
't need
> > > > > > providers in 2027.01, just the ability to build on OpenSSL 4 an=
d on distros
> > > > > > with OpenSSL3 with engines disabled, without breaking OpenSSL e=
ngine support
> > > > > > for other cases. If you get a patch to fix this, please send it=
 whenever you
> > > > > > can, I'll still collect the reviews from v4 and post it here. I=
f you're not
> > > > > > interested in doing that, lemme know and I'll take over this pa=
rt and you
> > > > > > can always test the patch(es) if you want to.
> > > > > >=20
> > > > > > Cheers,
> > > > > > Quentin
> > > > > >=20
> > > > >=20
> > > > > Hi Quentin
> > > > >=20
> > > > > I designed this change from the very beginning to maintain the ex=
isting
> > > > > code base and preserve backward compatibility for users of older =
OpenSSL
> > > > > releases who are still using the Engine API. We cannot add suppor=
t for
> > > > > OpenSSL 3 or later without moving to the Provider API because of =
the way
> > > > > the OpenSSL project has changed their interface.
> > > > >=20
> > > >=20
> > > > That's not true, as already said in v4[1]. We currently support Ope=
nSSL 3
> > > > and engines, and we actually test this in CI. You can test locally =
by
> > > > running the following commands from your U-Boot git repo:
> > > >=20
> > > > podman run -it --rm --security-opt label=3Ddisable
> > > > --userns=3Dkeep-id:uid=3D1001,gid=3D1001 -w $PWD -v $PWD:$PWD
> > > > docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
> > > > python3 -m venv /tmp/venv;
> > > > . /tmp/venv/bin/activate;
> > > > pip install -r test/py/requirements.txt -r tools/binman/requirement=
s.txt -r
> > > > tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.=
txt -r
> > > > scripts/dtc/pylibfdt/requirements.txt;
> > > > export UBOOT_TRAVIS_BUILD_DIR=3D/tmp/tools-only;
> > > > export PYTHONPATH=3D"${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt=
";
> > > > export PATH=3D"${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
> > > > ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --boa=
rd
> > > > tools-only;
> > > > export TOOLPATH=3D"--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --too=
lpath
> > > > /opt/coreboot";
> > > > ./tools/binman/binman ${TOOLPATH} tool -f missing;
> > > > for test in testFitSignEngineSimple testFitSignPKCS11Simple
> > > > testFitSignPKCS11Object; do ./tools/binman/binman ${TOOLPATH} test =
$test;
> > > > done
> > > >=20
> > > > You'll see all engine tests pass.
> > > >=20
> > >=20
> > > I assume you are referring to my second sentence "We cannot add suppo=
rt for
> > > OpenSSL 3 or later without moving to the Provider API ..." I can see =
how
> > > that wording could be confusing.
> > >=20
> > > OpenSSL 3 deprecated the Engine API but did not remove it. The Engine
> > > code is still present but not callable in v3 because the header files
> > > were removed to help prepare users to migrate to the new Provider API.
> >=20
> > The above is incorrect but has been discussed by Peter in a different t=
hread
> > so I won't reiterate here.
> >=20
> > > And OpenSSL 4, which is gaining more adoption, removes the Engine API
> > > code entirely and only makes the Provider interface available.
> > >=20
> > > Some distros, like Fedora, added an optional package to put the header
> > > files back alongside OpenSSL 3 so that projects (like U-Boot) which
> > > hadn't migrated to the new API would still build using Engines. I don=
't
> > > know what the base image of your container is or what release of Open=
SSL
> > > it's using, but it's likely doing something similar to keep the symbo=
ls
> >=20
> > Once you know where to look, it's easy (I discovered this a few years a=
go
> > and I'm not sure many people know about it): https://hub.docker.com/lay=
ers/trini/u-boot-gitlab-ci-runner/noble-20260113-23Jan2026/images/sha256-d5=
a14e5c0350a602e7730c9b3d85369b01dc940cd906900074e706c6d2018f91
> > lists the image layers and you can see 24.04 is used. You can also get =
this
> > information locally with:
> >=20
> > podman inspect
> > docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
> >=20
> > Fortunately, you don't even need to go that far, you can simply look ho=
w Tom
> > builds it, by looking at tools/docker/Dockerfile where you can see the =
FROM
> > points to ubuntu:noble-20251013 (aka Ubuntu 24.04).
> >=20
> > Running the container will happily tell you which version of OpenSSL is=
 in
> > there:
> >=20
> > $ podman run -it --rm --security-opt label=3Ddisable
> > --userns=3Dkeep-id:uid=3D1001,gid=3D1001 -w $PWD -v $PWD:$PWD
> > docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026 openssl
> > version
> > OpenSSL 3.0.13 30 Jan 2024 (Library: OpenSSL 3.0.13 30 Jan 2024)
> >=20
> > > available. But as it stands right now, U-Boot will not compile in
> > > any environment that does not provide a bridge back to the Engine API.
> > >=20
> >=20
> > That's not true, CI passes fine with the binman tests to check you can =
sign
> > FIT images with mkimage. See the logs I provided in my previous mail.
> >=20
> > > I've found that the fastest test of which API is available in a
> > > particular environment is to (optionally) sprinkle some printfs
> > > throughout the lib/rsa/rsa-sign.c and then build the tools target. Th=
e build
> > > will succeed if the headers are available, but quickly fail otherwise:
> > >=20
> > >      =E2=9D=AF make tools
> > >      --->8
> > >      In file included from tools/generated/lib/rsa/rsa-sign.c:1:
> > >      ./tools/../lib/rsa/rsa-sign.c: In function =E2=80=98rsa_engine_g=
et_pub_key=E2=80=99:
> > >      ./tools/../lib/rsa/rsa-sign.c:115:9: warning: =E2=80=98ENGINE_ge=
t_id=E2=80=99 is deprecated: ENGINE_get_id API symbol is removed. Define OP=
ENSSL_ENGINE_STUBS to mask linker errors. [-Wdeprecated-declarations]
> > >      115 |         engine_id =3D ENGINE_get_id(engine);
> > >          |         ^~~~~~~~~
> > >=20
> > >      --->8
> > >      /usr/bin/ld.bfd: tools/generated/lib/rsa/rsa-sign.o: in function=
 `rsa_engine_init.constprop.0':
> > >      rsa-sign.c:(.text+0x15): undefined reference to `ENGINE_load_bui=
ltin_engines'
> > >=20
> > > To fix this build problem in an environment where the Engine API is n=
ot
> > > available (even if OpenSSL 3 is) we need to call the Provider API to
> > > replace the equivalent functionality. There is not another fix to the
> >=20
> > The equivalent functionality would be to use the Provider API to call
> > OpenSSL engines via org.openssl.engine: prefix, otherwise you need to u=
se a
> > Provider, and that is not equivalent functionality. We do not want to
> > support OpenSSL engines via the Provider API so the Provider API should=
 only
> > be used for supporting providers, which we don't need to fix the build =
issue
> > against OpenSSL 4.x and OpenSSL 3.x on some distros (at least Fedora 44=
).
> >=20
> > > build failure unless you want to make a declaration that U-Boot is
> > > pinned to the Engine API as a build dependency.
> > >=20
> >=20
> > These are the possible scenarios.
> >=20
> > - OpenSSL 1.x without actual engine support. Typically, LibreSSL suppor=
t.
> > I'm assuming this works but I have not tested it. I believe they (Libre=
SSL)
> > have stubs that do nothing (or fail) when calling the engine API but I'=
m not
> > sure. Considering OpenSSL 1.0.2 documentation mentions engine, I'm bett=
ing
> > the whole of OpenSSL 1.x supports engines.
> > - OpenSSL 1.x supports the Engine API. Engine support currently works. =
Must
> > still work after your patch.
> > - Vanilla OpenSSL 3.x without the hack Fedora 44 is doing. Engine suppo=
rt
> > currently works. Must still work after your patch.
> > - Fedora's OpenSSL 3.x hack. Engine support removed (and I'll note again
> > that technically it is *NOT* removed but rather hidden or made cumberso=
me if
> > you wil: they have just removed the ability to build engines locally by
> > default, but you can very well use packaged engines in Fedora 44 without
> > openssl-devel-engine). Build failure. Must build after your patch. Loss=
 of
> > ability to sign with a hardware token is fine, as it's already the curr=
ent
> > state. There's no need to support providers as that's totally unrelated=
 to
> > the build issue.
> > - OpenSSL 4.x. Build failure. Must build after your patch. Inability to=
 sign
> > with a hardware token is fine, as it's never been supported with that
> > version of OpenSSL. There's no need to support providers as that's tota=
lly
> > unrelated to the build issue.
> >=20
> > You only need to remove engine support for the last two scenarios, simp=
ly
> > because it's broken. We are not losing features or functionality, it ne=
ver
> > worked in the first place! However, you need to keep engine support for=
 the
> > two before that (and I don't know the state about the first one but peo=
ple
> > would have complained already if that was an issue since it's been a lo=
ng
> > long time (many more years than when Fedora 44 shipped their hack :) )).
> > Provider API will be used for provider support, but we don't need this =
now.
> >=20
> > Your patch is breaking scenario 3.
> >=20
>=20
> This is an upstream API change (and not a Fedora specific issue) that is
> effecting U-Boot users right now. That impact is only going to grow as
> OpenSSL 4 sees wider adoption.
>=20
> But it has become clear to me that there is no version of this patch
> that will actually satisfy the U-Boot community. Therefore I will not be
> spending any more time working on it.
>=20

I feel bad it's come to this Eddie, but I think Quentin has been clearly
describing the problems with your approach, and not pointing it as a
Fedora-specific issue.

--=20
Tom

--QNT42XIH1zO/CMRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawDOjAAKCRAr4qD1Cr/k
Cq3/AQC+n9Am8D4rjkgKZPTYKQWa9drdWUmOzREfKalYWMRSRwD/WlsWm7BT/jRS
fZ2r5uvppDFJSaNTzPt8CoOz3pm9bAw=
=rD5O
-----END PGP SIGNATURE-----

--QNT42XIH1zO/CMRJ--
