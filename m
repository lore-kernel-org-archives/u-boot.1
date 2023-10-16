Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B284CDB47E
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 02:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919AF85DFA;
	Mon, 16 Oct 2023 04:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jpi65VU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAD680844; Mon, 16 Oct 2023 04:00:07 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8991803AC
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 03:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2739c8862d2so634980a91.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697421587; x=1698026387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OD7D32/M0SW0aRE0i5J5dzB/Q6RndyejK4Bc1il350=;
 b=jpi65VU37f/+TtXqzdJt262fFHuJSEN3bAbJJj8Pb6DyNxQEFjql00rFefiOwoQNiK
 HZ8YpebHYY1BxQoKg4URNZz1VOqCs/PD9FxphQKxtpitOMA/pW+XpxoYmNLESMrIGuLp
 tlseA3ovRxWoE3UmnhRKfnrwcjY2S85LVesEMytfDPwp8jFuQBNYOHA0P6GyL6GNUvIa
 SkSKkW/fzwr/Om1xXJoH8FQKsrsPi93fc0pUAfMTH56wZYefJS/mBHGlCASPG7PqgQ2s
 uzF1A2zyXIJqsf1fnNF/cYD6GycCEILznGljHHMbQwio2HecOKHxH1WkZkVl32xkn1Jq
 y5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697421587; x=1698026387;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0OD7D32/M0SW0aRE0i5J5dzB/Q6RndyejK4Bc1il350=;
 b=UQ9BFdi0EQBH5wdLL/P8AeWgHhLlqsPxwPcOItlbTzkQYaHYiaBge34jb4KMdkiF5b
 /5lyLAyu5WR3aZ51Oo/iuqlD7DjqvLJXJZ1/7ddEuCRs4FtUmrzpSsoDLO9Qs2swSWps
 3UrRD1qJ5907tUWWPCGSglYcVTWLAH7tJaXUaVYwQfAZDWoGyv1Ll07R6KS+JpJ5q7rb
 j0juj2IH7huJh0+Hz/+Zv9nXXMGAmHZW+Yw9OXZCRv3VqOy9lfVITo8NBb3VO3Advtpk
 DJam240ZjOpbeT7LYKlfbdOb++jE+PY2lSn0UrZYZGfikVeM1RzGIjpqMwRumgPZ0rxL
 6qRw==
X-Gm-Message-State: AOJu0Yw90lwmcDeBG1dgvYT8mfqMAokLdL5XQuJUg17mD5igkyJgDXCa
 oLLzdrLtIVOncdgLTlhkKQt4DA==
X-Google-Smtp-Source: AGHT+IHRp3MRXQdRV2RMVz7+hqjeyxDBJI3bTVj1VEL6SkyXBgl96mjqx0UwFR+5gPVkwxcdhaxpFw==
X-Received: by 2002:a05:6a00:398c:b0:68a:6cbe:35a7 with SMTP id
 fi12-20020a056a00398c00b0068a6cbe35a7mr37225201pfb.2.1697421587287; 
 Sun, 15 Oct 2023 18:59:47 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:4c30:a6e6:b316:7d31])
 by smtp.gmail.com with ESMTPSA id
 f8-20020aa79688000000b00690b8961bf4sm4987236pfk.146.2023.10.15.18.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 18:59:46 -0700 (PDT)
Date: Mon, 16 Oct 2023 10:59:43 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] test: dm: add SCMI power domain protocol test
Message-ID: <ZSyZD3Rac4Qzklq/@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Tom Rini <trini@konsulko.com>, sjg@chromium.org,
 etienne.carriere@st.com, u-boot@lists.denx.de
References: <20230926070043.738340-1-takahiro.akashi@linaro.org>
 <20230926070043.738340-5-takahiro.akashi@linaro.org>
 <20231014012048.GA2472471@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/g/eX4lwY8E1OSSF"
Content-Disposition: inline
In-Reply-To: <20231014012048.GA2472471@bill-the-cat>
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


--/g/eX4lwY8E1OSSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On Fri, Oct 13, 2023 at 09:20:48PM -0400, Tom Rini wrote:
> On Tue, Sep 26, 2023 at 04:00:43PM +0900, AKASHI Takahiro wrote:
>=20
> > This ut has tests for the SCMI power domain protocol as well as DM
> > interfaces for power domain devices.
> >=20
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >  test/dm/scmi.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 106 insertions(+), 1 deletion(-)
>=20
> With v6 of the required series there is no scmi command, so, how do we
> test this support now?

Well, "ut dm scmi_power_domains" does test the code at function level
(both for SCMI protocol APIs and DM's power_domain_*() interfaces).

That said, prior to v6, we needed to adjust the output from "smci info"
command and hence "ut dm scmi_cmd" test because it, more specifically base
protocol's DISCOVER_LIST_PROTOCOLS, tries to enumerate available protocols
including power domain protocol.

With v6, we can simply remove the first hunk in this commit.
I will submit a new version with this change.

Thanks,
-Takahiro Akashi

>=20
> --=20
> Tom



--/g/eX4lwY8E1OSSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEjc56F+RxEkavfJvIJ6vpGq1myG0FAmUsmQUACgkQJ6vpGq1m
yG0CcQf/aY/X/FJVa1BqO6wQ3cf54nzjN2ubKEn9EW2EVaFng5sFn3rw4LfIVg4q
8Gtv4iM+dpNmKDVY2Jd56vEY94Qp1mUpMZ25Okffy5ZJ12+VKPsDlsxLeEj3TWt0
BBMHrjGc0upa7yi5A1cjkL59XSCvKbs9rGX1+dmZNdfGKEhavAL65LFJF9NAmhfP
b/BAhmvKV22Tf7H0lB5KkpH5cimZElc03wRmHD3DFKdCDqHzs75NOEU883iSg3vk
d+qNCRzndziGunZL7VbkyOFUsPortSV13cfYlmVUD783bZaO27UVkR+Poot1YDm8
sPf/kRMQBfY44uB4DnOG7a8aV2RsTA==
=3F1R
-----END PGP SIGNATURE-----

--/g/eX4lwY8E1OSSF--
