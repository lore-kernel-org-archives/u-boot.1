Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE76AC55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 17:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2239A40A6B;
	Thu, 30 Jul 2026 17:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KGxqqh24megQ; Thu, 30 Jul 2026 17:26:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29B4F4086A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785432403;
	bh=MH5kcT1e1aH60fcfLeoNc2+xV12n1lzW/O2f8kKiM8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0RRliiFmglHZ5Iy5fI94BklfBWkCRS8oD863czXRz/H2M9qANK0t71z4OGlNO7ekY
	 lkWpiQyaOEG0vID3LbDmvmRUUt3QPXA2d7/B15PxvztE9vIOhmJylaAd/ev5IPJVoI
	 n+HDH3bBHxpuXX3hEHUCdi+USEn2/MumP/fHFskK/BFEyp/4DJ9Yzo+ccuMEnxEVZi
	 U+Ka1CIccnVqY7z2Jg/Ams1LWu87Talt7ohHyKXEaOjuMh3irMEqCU01b17PfVRUnV
	 mB1z/1VQTaRh/esYiZwI+bIz/MgZmcJNnVb4+P//xYPiDfWE8nMlOkX64CHRtOFR22
	 VAbQhyQTMj75g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29B4F4086A;
	Thu, 30 Jul 2026 17:26:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04BDF352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAC4060A55
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nV9fibqtVLJk for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 17:26:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2615E60A54
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2615E60A54
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2615E60A54
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:26:41 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6aae90e595fso1128581eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 10:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785432400; x=1786037200;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MH5kcT1e1aH60fcfLeoNc2+xV12n1lzW/O2f8kKiM8Q=;
 b=MzkI2PbRtZLYMik68i/DxtPE30ldAKE4bOhqswn+7MEOm2WeQGwDK6+caMTntzlhN+
 ChsoP58Bs8ih1lsv+MuJ3/Pz0wfX9PIeDoSkF6Hr4Uc6FqimVX4L3kTKwILE5hlLxX5/
 qDDhyQ0TAJL/jFuch1ubVAmZJoyIaqcHf3+puHAkf7fan7YBUVPpkrUaOQKAd0/nAWZH
 Rbt2RvjJafebRFFVjQ4mtJiQgzT8KmO/CxsB7ddA0vBNqCvPIRU/06gJDJyK/YeOKKf/
 bGNRDeA2PhwhiCqf82phnWAUDDk9A4fXUq1yNvT2V9kSZ3W2N8gKE5TEHMge50f9ZYNk
 aGLw==
X-Gm-Message-State: AOJu0YwqJBAkQsteK+TrkegSkIGJOqYO5uMxAjKJI9ScSSRaSbZ2vYiH
 b5Dev8hnKzGBSWxuYNgzkxRKHF2JdvflnB0PEWQqW+G0EcZDhs59WDIvho8zPtwNmuU=
X-Gm-Gg: AR+sD10LN806nhkmYM5bK0RETddPX0dDJj9py9P9lfcyYqlPAMx0PeGFQ1WzAeN0msj
 5LC8AlHpqxTfjsjAywDEsVFN2BszfY0IZT48TLFhd7oq+wpy4oTAGT+8iaU9bdExhnO8DLnf0K6
 i8Ck0mJtcKcySy7L/lrK0ZRAV5gc7fZ92Q/yNIOcsAX8o/LleN3B2tgGTUszR0baprPGRjSwPPe
 KjMLVynx6bZfbHP7en/OLyv56LdtE7hT+2/mtK5ZzeoceZU3m8Uj2Bft8fumQ2fxnRFU2WqhOc2
 tvizx9+Q/KJvBI1ADhNm/yuwKpmMKTUgXdeehMsIZT1gkdl+f/vhxX4Wb+MrNrs1I/keq6q2KXl
 gGLJWP6pCnIv6pFl9cl0CKnvDIqD9ptfUK3pC7hkiNgYN7zAQCAs2sUHdc9Ip3YnD78bGcQzjWY
 VCKke0oZIU1S8t4SleWODEn3RQ3Db7jxUem+oGwi2+8NogqM7bVWfcf6UA+d98P/nT4L/0sA4cK
 zYg8sY8bKjnVztT0VthkJ6lO9aDk4aQZQrywIOoi3qLIQsVqpTR+3h4FppYKv+kZROp0aE1sfGz
 FBjYc00aSj0=
X-Received: by 2002:a05:6820:a0e:b0:6aa:2fbf:bf67 with SMTP id
 006d021491bc7-6acbc12d878mr2144897eaf.47.1785432399989; 
 Thu, 30 Jul 2026 10:26:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458c2a64dd2sm2584911fac.18.2026.07.30.10.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:26:38 -0700 (PDT)
Date: Thu, 30 Jul 2026 11:26:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 1/2] cmd: allow bootd without bootm
Message-ID: <20260730172635.GG1773261@bill-the-cat>
References: <20260730155119.3328020-1-mehmet.fide@gmail.com>
 <20260730155119.3328020-2-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6t52Okf6nIwWLJX+"
Content-Disposition: inline
In-Reply-To: <20260730155119.3328020-2-mehmet.fide@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785432400; x=1786037200;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MH5kcT1e1aH60fcfLeoNc2+xV12n1lzW/O2f8kKiM8Q=;
 b=oe7GAsaf6Oc+onpQ675p5XilF51+XkGkUb0UdZHagi3A48WOuz0WZY/KrahufPtVZF
 teOI0L48QjeIYyb9YuCQvb3zOlocL4zRijBz2NEI6bxmZNY3OSHRvLXpDNkXLpC3LTxU
 Y+dUa0DBb2pD89mPeo3K9J0IAqFYO2G6M4wUs=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oe7GAsaf
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--6t52Okf6nIwWLJX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 05:51:18PM +0200, Mehmet Fide wrote:

> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>=20
> do_bootd() runs the "bootcmd" environment variable through run_command()
> and does nothing else. It uses no bootm functionality, and neither does
> the "bootd" recursion guard in cmd_process(). doc/usage/cmd/bootd.rst
> documents it that way, with an example that sets bootcmd to
> "echo Hello World".
>=20
> Commit 1fd04cf46baf ("cmd: Correct dependencies for CMD_BOOTD") made
> CMD_BOOTD depend on CMD_BOOTM because the build fails otherwise:
> common/command.c is compiled unconditionally and references do_bootd(),
> whose definition sits in cmd/bootm.c, which is only compiled when
> CMD_BOOTM=3Dy. The dependency therefore describes where the code lives
> rather than what it needs, and the boards that disable CMD_BOOTM
> (colibri_vf, iot_devkit, mx6memcal and r8a78000_ironhide_cm33) cannot
> offer "boot" or "bootd" at all, although the implementation would work
> there.
>=20
> Move do_bootd() and its two command registrations into cmd/bootd.c,
> compiled from CMD_BOOTD, and drop the artificial dependency. To leave
> every board in tree unchanged, CMD_BOOTD now defaults to y only when
> CMD_BOOTM is enabled, which is precisely the set of boards that have it
> today. Boards without bootm can enable it deliberately.
>=20
> Tested on sandbox: bootd, the "boot" alias, the return value taken from
> a failing bootcmd and the recursion guard all behave as before. Also
> tested on a Colibri VF50 (vf610) board built with CMD_BOOTM=3Dn and
> CMD_BOOTD=3Dy, a combination that could not be selected before: "boot" and
> "bootd" run bootcmd and bring up the OS, and a bootcmd of "false"
> returns 1. A colibri_vf_defconfig build with CMD_BOOTD left off is byte
> identical to the previous one apart from the version string; enabling
> CMD_BOOTD costs 272 bytes.
>=20
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6t52Okf6nIwWLJX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamuJQgAKCRAr4qD1Cr/k
Cp+sAPkBX0wOgiWssF0r9fPd6F4hc0uMbmXsyf18QZL4X4kXkAEA1wdMzyHKhEzf
X6lCHfTbhD0fOJHJo5Q5Ml3zaEUhvwU=
=5qYV
-----END PGP SIGNATURE-----

--6t52Okf6nIwWLJX+--
