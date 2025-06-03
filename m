Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50C4C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E7781E25;
	Tue,  3 Jun 2025 16:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KYi3gsKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E610580AE1; Tue,  3 Jun 2025 16:05:13 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A107A81E25
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-407a5b577f8so631072b6e.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748959510; x=1749564310; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SJ0PgeygVDC9hGLdXlfPfUoWmn1E2ZBPY/tUZ/TAJdI=;
 b=KYi3gsKJWfEUM7tIUGgs0I2eB4Zk0WB7dR4xJMUS2HxqoMBRM5pUbSfKaEfRbQIlG4
 h06HGgPzRN2l49IyKoEWgEsrOs/+3CkkUz8lnJ190Bcsi6U6J69ykTJO//sZdQrEmLQB
 nqmnL/LcvfbiUBapIR2w75m7w6HugISMlJAFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748959510; x=1749564310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJ0PgeygVDC9hGLdXlfPfUoWmn1E2ZBPY/tUZ/TAJdI=;
 b=LxVx2cOF7Aq1H1dD756ogalYuf8s179G4x2LsDn3jON2jT1A4V/VYK53bHK/rz1F9D
 uhFAbjRgT7BxA0VsmgwiCQW+zqS2/+Sn3cZ5v/1RUVclK6Rf4L8wBTJ3UbfxuDcpdeUR
 H896+aP8XyPPynphOZ8nU5qnXiJOj/MWAW3FxzkZGOwHfJlsPJF7U8WLLqF497GmRxuD
 gcSuPHkZMlMWVBjMSHlbhp1uKI95gEfyko6AsU7m6AbxIfhJkImHrXRFczKGid6WC3H4
 6TUMP4zuwLA1vKs9wlaC4SCVNIJbXYW9NUA2iNh8KtT2hST5MSyQeNuQNVnwiyvjMv17
 s0OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzZ9iWOWgTQp6gD5vMA04UCxG/Fot8ZLTs0XGgfr+F+61rjfXRnHwF8mB1ca1HSz3UQMU7YEs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv3QHoP+45k82zmT2jpcWbaWR/DlP0ttx9bW0CmP94+RFwkZuN
 c+9SA4/nq5qS/bf0xtxMczfJxbIkTcLlrbd7aYDFIWN/btA96F+MUjPei7soGGpE/Qo=
X-Gm-Gg: ASbGncvHZcaXvhYwZS9qongQ/4Ax+stqBwsGjZ60L9j4PMeIW0DfhViJi3O69UIErIm
 vgAzrZ0q36S3b9CjzAbSMbwCsbCp55q+7qhUGKBERupnlrllJ74mlRVCYagW89rweYnpoJxyqIh
 b00u2cW2nOgmcQH+vx/6to2otCqExXXvekXIG5Mcsdpx06om8ZKYnpbjC7PnVSYUvTKCaSTae7X
 tym8czQChaxbB+KDXZNtkH1FDf6aJQQH6Jg94ler2ZwMxivElKW1HcPtTBLvMWuPvAdbKybQGGg
 jUgR2ZKiazYwrpA40wTeCd9Iw5o4nlpViXKsfJLlailNqsNwh/NtSFqB1BNpWFTBPUFIxY1uvKA
 0Z9EZKNf0Wx8O
X-Google-Smtp-Source: AGHT+IGycH6q5XgKCBt689Xe4rr04KgGERjOYmmiQONq6sSK7njVRv+EdajVrmbdwpVASrBGGq0SJQ==
X-Received: by 2002:a05:6808:1b8b:b0:408:e05e:fb47 with SMTP id
 5614622812f47-408e05effc4mr3118126b6e.13.1748959510310; 
 Tue, 03 Jun 2025 07:05:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c6fbf5sm1894463eaf.10.2025.06.03.07.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:05:09 -0700 (PDT)
Date: Tue, 3 Jun 2025 08:05:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/3] net: extract function net_sntp_set_rtc() from
 sntp_handler()
Message-ID: <20250603140507.GB1382132@bill-the-cat>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
 <20250521151516.16729-2-jerome.forissier@linaro.org>
 <EC613C0A-90A2-4F7E-A9BE-4598BEF2023E@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ROn3BGF6YipfjOPR"
Content-Disposition: inline
In-Reply-To: <EC613C0A-90A2-4F7E-A9BE-4598BEF2023E@gmx.de>
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


--ROn3BGF6YipfjOPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 11:13:39PM +0200, Heinrich Schuchardt wrote:
> Am 21. Mai 2025 17:14:41 MESZ schrieb Jerome Forissier <jerome.forissier@=
linaro.org>:
> >Extract the code that sets the RTC clock from sntp_handler() in
> >net/sntp.c and make it a new function net_sntp_set_rtc() in
> >net/net-common.c. This will allow re-use with NET_LWIP.
> >
> >Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >---
> >
> > include/net-common.h |  2 ++
> > net/net-common.c     | 28 ++++++++++++++++++++++++++++
> > net/sntp.c           | 23 +++--------------------
> > 3 files changed, 33 insertions(+), 20 deletions(-)
> >
> >diff --git a/include/net-common.h b/include/net-common.h
> >index e536968a92b..a021bf503ff 100644
> >--- a/include/net-common.h
> >+++ b/include/net-common.h
> >@@ -586,4 +586,6 @@ extern struct wget_http_info default_wget_info;
> > extern struct wget_http_info *wget_info;
> > int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info=
);
> >=20
> >+void net_sntp_set_rtc(u32 seconds);
> >+
> > #endif /* __NET_COMMON_H__ */
> >diff --git a/net/net-common.c b/net/net-common.c
> >index e01b0da7d7b..30d04323d4a 100644
> >--- a/net/net-common.c
> >+++ b/net/net-common.c
> >@@ -1,5 +1,9 @@
> > // SPDX-License-Identifier: GPL-2.0
> >+
> >+#include <dm/uclass.h>
> > #include <net-common.h>
> >+#include <linux/time.h>
> >+#include <rtc.h>
> >=20
> > void copy_filename(char *dst, const char *src, int size)
> > {
> >@@ -25,3 +29,27 @@ int wget_request(ulong dst_addr, char *uri, struct wg=
et_http_info *info)
> > 	wget_info =3D info ? info : &default_wget_info;
> > 	return wget_do_request(dst_addr, uri);
> > }
> >+
> >+void net_sntp_set_rtc(u32 seconds)
> >+{
> >+	struct rtc_time tm;
> >+#ifdef CONFIG_DM_RTC
>=20
> Are there really RTC drivers that have not been converted to the driver m=
odel. If yes, shouldn't we drop these?
=20
It looks like all RTC drivers are converted (and there's no 'RTC' config
option). I think just openpiton_riscv64_spl needs to be converted (or
just config options switched) so that SPL_RTC can go away as a symbol
and SPL_DM_RTC (and SPL_DM) is required if we need an RTC in SPL.

--=20
Tom

--ROn3BGF6YipfjOPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/ARAACgkQFHw5/5Y0
tyxTAAwApOMMHInUTtvT/8X7oCGfLMx42X8KVNIZ2x16Wdt7hyDZQwJ2Gbyfqy/Q
m98NucnGS0XMwfRo8krmpfPXhPNszGxRlsywe/X2ZBPV+Ktk2A6VZjlwvcbnFtrg
1vv1CgzTAJ4kM6LZwAXo6h3340L8Tai/jvTEkyPdIHZQZvmHQJwNPgwwUpCvWa0n
4xYNHUEOCHdSoyyuV8WWivzBjWcxxU9joNx27UwH5QuRk+YSyUryuqSk/5Nfn3VL
isopwHBu5bVh1QUdQCor7l5g0HzCXD862VmMV0696pmHp1L0kqPJ2nhDMtYGtYzi
mCLoZfxxw22AB5AJOdDI+3WdqVEkvl5NrkSRTFSQV2lrPSEIZR8AxZ6aQCzVg+J5
2/ID6rCC9x+181vJCLqtQsq5zB8Kbj/c1EcxkHE3nG8IqcuGqWlL9mC+RoJWbRUp
gLLxYtT6Yn38/oCyY2a9XW7QwNRwwrZNEXYEDEH770MnG4chrfZrp8h1OiNsn6P6
HWmiijzL
=Yeja
-----END PGP SIGNATURE-----

--ROn3BGF6YipfjOPR--
