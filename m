Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536ADCCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E7F83835;
	Fri,  3 Oct 2025 22:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n0pIlHx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB528384C; Fri,  3 Oct 2025 22:13:39 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E466B83826
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8ca2e53c37bso239443239f.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759522415; x=1760127215; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5upVql5m0YezRHsf9y2xMSDSgbQkh+tqQxss+XFIcKY=;
 b=n0pIlHx1S4iHvDKRiFumiDy0NFExK+NbbQvnNb5tMOf/Xq/5mbgpJ9TkTBKgC1Q3GE
 ZdZtnmQjBkdZpToQpHqCnBxfYoQrv+GSS2mtY0d8lOI73jG+12d+O8nNMb7BNlEgOl5o
 HAjzeDBJdAyVg0tKKwdPXchF8OzdW7c3Vq+fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759522415; x=1760127215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5upVql5m0YezRHsf9y2xMSDSgbQkh+tqQxss+XFIcKY=;
 b=A5cFc82PKj/fRmKW+uox3m+g1NMeowVlS1G6bWJUhwbHd5lHwALVJhwLztO1fUzrFH
 gJCaniGHVGGQb8tSuY3Vlco2uJAJexWTUyRx0yP32D80TGfhXm+oG82wjWx2y8LzBnVH
 rmptdfRhSOBLcVLaNG7cjl898Hn/lyFNyOI4hZiN2+XU8KJySnIERzX3zmqlZqDlcWG4
 GA5Qk4mOrwlXAGimAhGsFvrrxlqFuXlwpNujl5OxhjFmSjZAZ69RVJ9HDaIgQ+jPVcnZ
 v6ns7eBFYRPL4LqwJsDlAH5zsP2lNUL6/UOXFsvycnerbloDQMQ/SEshj8telrcKG5M1
 yUzA==
X-Gm-Message-State: AOJu0YxdIpIOUdSiGmw9c2ZOYCElF1jJ1jHVW8BmUZJLkSMr4sGWRggm
 jgREj61YeuNTB82iwrAnQAAnn57tWGcfEYUNHyEYw/5sgMyCefgz2DOrlVEULRgeEcE=
X-Gm-Gg: ASbGncsktgKcu2/4kvTZF295j7xQhZe2dWwhqNG9a4g0NlPuCzSxsN6KUU+kMXNZhVR
 22H87Gec/Qk/hfJ7rvzYhNkRs3xop3iM0gBPgrX/Dr8d7FNse+V3/FNmoNyyZMuwF9+lNNUMB9h
 o0S0rcrayMFes0SdeyqZOhbXohCsknbKfZlpMoqL1F894fasO595WAaTF46HpJhwLdXOQSEBnmF
 HTgn5e4D18W+RF+b6wVg0sVYhy62JVuIzwNX0aTepzai4PsqPTe24LuBl8WvPModtZdwAzgsaVY
 CJWU+wSEt6YcOmezrCcugHy8AsF80ziF96UKH3b5OBvAbREDBabTmDV6vyr58YqMIDLbDmq2aEF
 pgoW0lsR/5EeOYETadP1hts1ZP6/KeBu7pmc2tPQgaJW+Lr9DMQNjwTx+mt04lWl3nvqjI4GK6S
 g/9H2uKXRIIg==
X-Google-Smtp-Source: AGHT+IE7Ba8/h4WqfDCYEQKWlZCPuPKW7B5MaE5KRwDTkGa34rt9yF0py4km9Gc++/uZ6477ycYZiQ==
X-Received: by 2002:a05:6602:740e:b0:937:6516:62e9 with SMTP id
 ca18e2360f4ac-93b96a4fba2mr547681839f.9.1759522415004; 
 Fri, 03 Oct 2025 13:13:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7d81bf16sm212986939f.4.2025.10.03.13.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:13:33 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:13:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 0/5] Enable Firmware Handoff CI test on qemu_arm64
Message-ID: <20251003201331.GS6093@bill-the-cat>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CzmM1i1Hche/ycWq"
Content-Disposition: inline
In-Reply-To: <20251003192222.767882-1-raymond.mao@linaro.org>
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


--CzmM1i1Hche/ycWq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 12:22:14PM -0700, Raymond Mao wrote:

> This patch series enable Firmware Handoff [1] CI tests on qemu_arm64 by:
> 1. fetch MbedTLS (v3.6), OP-TEE (v4.7.0) and TF-A (v2.13.0);
> 2. build bl1 and fip with both Firmware Handoff and Measured Boot
>    enabled;
> 3. pytest to validate the Firmware Handoff feature via bloblist by
>    checking the existence of expected FDT nodes and TPM events generated
>    and handed over from TF-A/OP-TEE.
>=20
> Pre-requisite u-boot-test-hooks patches [2] are required.
>=20
> [1] https://github.com/FirmwareHandoff/firmware_handoff
> [2] https://lore.kernel.org/u-boot/20251003191918.767698-1-raymond.mao@li=
naro.org/T/#t

Generally, the changes look good, thanks! Specifically, did you trigger
a CI run where you pointed Azure at a fork of u-boot-test-hooks with
your changes? I'm a little concerned about the fiptool change and I
don't see a CI run where qemu_arm64_optee.. was triggered, only:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D12044&view=3Dr=
esults
where it's not. Thanks!

--=20
Tom

--CzmM1i1Hche/ycWq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOAuZwAKCRAr4qD1Cr/k
CihIAQCMZMjrAuzmJelaTvJnZSLHbydQVH7PsO7yc5dOHgVCsAEA51k8wkuVrDkk
hcxB+v9W8SAlkjU2M2zxUvK3Jrh8+wg=
=MnQd
-----END PGP SIGNATURE-----

--CzmM1i1Hche/ycWq--
