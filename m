Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2E6CD98E3
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 01:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD6F86B57;
	Wed, 11 Oct 2023 03:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q6M5hZyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F7586B57; Wed, 11 Oct 2023 03:36:22 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09ABB86B29
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 03:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6a4ff9d7e86so582824b3a.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 18:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696988175; x=1697592975; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ei/A8ik6V6Khlc+e6DtwgpayIVZ+GnKEweusD1afJIU=;
 b=Q6M5hZyLtv6to+hd7jN2sKDZ3l1yhk7w8C2b2vDFzijNF8HTsiDjlNAuzXgMa8/gFX
 lw2Mp6MtfOGCYb7qdZ/ig3kqH379LoSv33x3TIFSKHViudDB4sysR5OvT30xL832iKPk
 wFJU5fL0lKO6REJJJtpQ8Vlwcys1nqbGYDr0fWLZThjtbXj/MJjzwhB8tcoi+aud6b/y
 RhGh8UNy+AuvKqR883Ye9pJM+/L0zBX30selwj+qAR6JrmKZbzHwqJt7fh7sA3ApMwFk
 nlxps2oahdecbmsLgnxxpYaiM1Sa0y3Pvjhzk241mxZdgt1OsvU+HEskxJjXUKtQLWpG
 qtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696988175; x=1697592975;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ei/A8ik6V6Khlc+e6DtwgpayIVZ+GnKEweusD1afJIU=;
 b=gny4dVfUQWeEi/YlRdqt7lKZAO08MClraDlIBiRE3iZ26FMmhPPNsCvxwUnhR8wYjM
 Ymel7TscZ+DzxMVPuTr6o+dcCZZUPoaTKMuaitwbqlMAhf1Ym1Jd48sJto/o7wcH3m2A
 bXyAhBKGw1UGqIz//Uu3uyD1EnIMkW9dOg/s3xazW94ZfmY8oPehLZCb6qOpRXTn4cE2
 URoTSye3gl3vAdr91hS7pbd+2ghduySsA1kymZNwUm9fQcJEBFP+QZqR1qIumjDuVdyc
 tAb7ns7xxaP9NhR5Bq7c3QX40okrvtajwziMitEHyBR8VeoZswYfAnXgYbPyoPDzIT8G
 c5zg==
X-Gm-Message-State: AOJu0YzbAeDsL88lHByB+7sZ7rNHrA99cMPJVWh2TLU8sASAgik0fPVK
 u8XHPv8WKC4ZsE6ggBQMMgPN5g==
X-Google-Smtp-Source: AGHT+IGiudG9xoQ5Y704w1rrMrezaE/QNtihqwJBNJmofMjIBv3qsAqO10MrBMjJNSZOyi14O0Ncbg==
X-Received: by 2002:a17:902:ce84:b0:1c3:a4f2:7c99 with SMTP id
 f4-20020a170902ce8400b001c3a4f27c99mr22400012plg.4.1696988175033; 
 Tue, 10 Oct 2023 18:36:15 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:5c6c:b11a:476c:8ebb])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170902c21100b001bbc8d65de0sm2281577pll.67.2023.10.10.18.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 18:36:14 -0700 (PDT)
Date: Wed, 11 Oct 2023 10:36:11 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 00/16] firmware: scmi: add SCMI base protocol support
Message-ID: <ZSX8CzGFs9+kv1vE@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, sjg@chromium.org,
 etienne.carriere@st.com, u-boot@lists.denx.de
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20231010141909.GA5325@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4xBxWpTGpQZ82Hg+"
Content-Disposition: inline
In-Reply-To: <20231010141909.GA5325@bill-the-cat>
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


--4xBxWpTGpQZ82Hg+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On Tue, Oct 10, 2023 at 10:19:09AM -0400, Tom Rini wrote:
> On Tue, Sep 26, 2023 at 03:57:34PM +0900, AKASHI Takahiro wrote:
>=20
> > This patch series allows users to access SCMI base protocol provided by
> > SCMI server (platform). It will also be utilized in separate patches
> > in the future to add sanity/validity checks for other protocols.
> > See SCMI specification document v3.2 beta[1] for more details about SCMI
> > base protocol.
> >=20
> > What is currently not implemented is
> > - SCMI_BASE_NOTIFY_ERRORS command and notification callback mechanism
> >=20
> > This feature won't be very useful in the current U-Boot environment.
> >=20
> > [1] https://developer.arm.com/documentation/den0056/e/?lang=3Den
> >=20
> >=20
> > Test
> > =3D=3D=3D=3D
> > The patch series was tested on the following platforms:
> > * sandbox
> > * qemu-arm64 with OPTEE as SCMI server
>=20
> I have two problems.  The first is that for sandbox, this series is not
> bisectable as a commits fail to build due to needing a definition in the
> test before it's added:
> /home/uboot/work/u-boot/u-boot/test/dm/scmi.c: In function 'dm_test_scmi_=
clocks':
> /home/uboot/work/u-boot/u-boot/test/dm/scmi.c:117:21: warning: implicit d=
eclaration of function 'scmi_get_protocol' [-Wimplicit-function-declaration]
>   117 |         clock_dev =3D scmi_get_protocol(agent_dev, SCMI_PROTOCOL_=
ID_CLOCK);
>       |                     ^~~~~~~~~~~~~~~~~

[snip]

Ah, I didn't notice this dependency.
I will fix it by re-ordering the commits.

> Second, the series causes this failure:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> _______________________________ test_ut[ut_dm_dm_test_scmi_cmd] _________=
______________________
> test/py/u_boot_spawn.py:195: in expect
>     c =3D os.read(self.fd, 1024).decode(errors=3D'replace')
> E   OSError: [Errno 5] Input/output error
>=20
> During handling of the above exception, another exception occurred:
> test/py/tests/test_ut.py:497: in test_ut
>     output =3D u_boot_console.run_command('ut ' + ut_subtest)
> test/py/u_boot_console_base.py:266: in run_command
>     m =3D self.p.expect([self.prompt_compiled] + self.bad_patterns)
> test/py/u_boot_spawn.py:204: in expect
>     raise ValueError('U-Boot exited with %s' % info)
> E   ValueError: U-Boot exited with signal 11 (SIGSEGV)
> ------------------------------------ Captured stdout call ---------------=
----------------------
> =3D> ut dm dm_test_scmi_cmd
> Test: dm_test_scmi_cmd: scmi.c
> SCMI device: scmi
>   protocol version: 0x20000
>   # of agents: 2
>       0: platform
>     > 1: OSPM
>   # of protocols: 3
>       Clock management
>       Reset domain management
>       Voltage domain management
>   vendor: U-Boot
>   sub vendor: Sandbox
>   impl version: 0x1
> Denying access to device:0 failed (-13)
> Denying access to protocol:0x14 on device:0 failed (-13)
> Reset failed (-13)
> Test: dm_test_scmi_cmd: scmi.c (flat tree)
> SCMI device: ?n
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> FAILED test/py/tests/test_ut.py::test_ut[ut_dm_dm_test_scmi_cmd] - ValueE=
rror: U-Boot exited...

This seems to happen in the case of "flat tree", but
I cannot reproduce it in my local environment with
  $ pytest test/py/tests/test_ut.py -bd sandbox -k scmi_cmd ...

> Which I believe CI will also produce, once the issue with htmldocs is
> fixed.  I can't bisect it exactly as the failure shows up once the new
> test is added.

Anyhow, "scmi" command is more or less a debug tool for my development.
All the functionality provided by this patch set is tested at "function"
level with "ut dm scmi_base" and the command is *not* needed.
To avoid increasing the maintenance cost, I will drop the command
(patch #14-#16) in the next version.

Thanks,
-Takahiro Akashi


>=20
> --=20
> Tom



--4xBxWpTGpQZ82Hg+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEjc56F+RxEkavfJvIJ6vpGq1myG0FAmUl/AYACgkQJ6vpGq1m
yG3rxgf9H3mpCOZsHrwDaUghHLN2G05wc0kG3JeM/zO+kLhHhPUhi1DbkBPoLST9
yGX3emA0cYBAYwEvQZXez0kVUSPefshJyMnLsrBg7kOEUi98NhFGDIKiKPOqZ0M7
pTce7ZlFDROJHKPbuIiUUb/en6whjZVnX2aiEb056gOEQm6wV1HmZucxeUnrITuH
SXAb0dKMnh1PQB+S6+kKQHdQ2BuKbOZTKMYh3UtlA0d75Lg56x7tBazSL7K56f6z
8LFy7CfUXSXy0JKvTmxOcvCGWsPSo11BHASZ8a0ytg0fDBPQqnqxT1QDEq+TA7pq
NdcygFaH64/pZz0qPkZpcLcHYceHpQ==
=IV1z
-----END PGP SIGNATURE-----

--4xBxWpTGpQZ82Hg+--
