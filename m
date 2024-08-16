Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860F4C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 19:39:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFD7688BF8;
	Fri, 16 Aug 2024 21:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="naM7UwBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A6388881; Fri, 16 Aug 2024 21:38:59 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BCE088BDA
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 21:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70945a007f0so1434346a34.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723837124; x=1724441924; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m8Vwy+21d8b8v6W8JeHg/Mz8of3ykf2D9lrDPSHXuxw=;
 b=naM7UwBriWf/YwxmKP82ksyY+yPHpXf/dGSLPK6Yvzh/5DYGX0NDEX72Ln9O59Ohvv
 uoiXZMRys4T9CjQ4n53CYr/xME1Sb+PzyUWnCzlM1Tq0u2DBJVpXxIEdP9OGnqOuMHCC
 nYFp5ic8+4zrXUiIPwN64S0ibT34266NDtNu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723837124; x=1724441924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8Vwy+21d8b8v6W8JeHg/Mz8of3ykf2D9lrDPSHXuxw=;
 b=o84UuT5juUC33HFBaB0Fv88p9lkvS2afi0XYMyXwxuFkf4mwUU3EyI2FEaJ45lfrp6
 aabHEmkEI24BkY/rhb0RqyxpZ9ku5afjO0bZI+ce+fGSDyx0v7rIpjxnVrWUQl4dI2ui
 rGsG+asy220V/+vCzaxeZVwMEqH6ZQtApUHJVSBlRhbo4W2GdvhpfegdNRP7wNJ4EZu7
 Hp+713DjosFrNaZian12jiN/AgOB75DEaw4vGL6rD0sSRGfckf6QVqvGw+fCJiCgJLp/
 GZabB/SbTUaU0qpZo2gyXizDH0c7n85Hgcw8LDcvSxeItU4sIMPW8Q4sfM0OkLchqvE9
 QuEQ==
X-Gm-Message-State: AOJu0YyyVgyCme0rbSqe32HBi8ruioxzmjYLr5QGO4vLPsZaTBBK6f15
 OuXGl22C3WqGJayiPRoNtJ7+t+aPz4CmI/my47sHhbxd7+hi/4XghVYPYYi1sZs=
X-Google-Smtp-Source: AGHT+IErMng4Zllw73EEDh6b1CokjX8Webe1NOtqDOZ4fmsQoDN7S6VI2jOF1ui5dfPETDPRvy1cJg==
X-Received: by 2002:a05:6830:2690:b0:709:2fa3:1329 with SMTP id
 46e09a7af769-70cac86af7amr4579964a34.18.1723837124418; 
 Fri, 16 Aug 2024 12:38:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca64b248fsm804878a34.32.2024.08.16.12.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 12:38:43 -0700 (PDT)
Date: Fri, 16 Aug 2024 13:38:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 19/32] sandbox: move the TCG event log to the start of
 ram memory
Message-ID: <20240816193840.GE1626301@bill-the-cat>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-20-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VS/jCm323wJEVzp7"
Content-Disposition: inline
In-Reply-To: <20240814110009.45310-20-sughosh.ganu@linaro.org>
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


--VS/jCm323wJEVzp7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 04:29:56PM +0530, Sughosh Ganu wrote:

> The TCG event log buffer is being set at the end of ram memory. This
> region of memory is to be reserved as LMB_NOMAP memory in the LMB
> memory map. The current location of this buffer overlaps with the
> memory region reserved for the U-Boot image, which is at the top of
> the usable memory. This worked earlier as the LMB memory map was not
> global but caller specific, but fails now because of the overlap.
>=20
> Move the TCG event log buffer to the start of the ram memory region
> instead. Move the location of the bloblist address up by 8KB to
> accomodate the event log buffer, and update the sandbox memory map

With checkpatch.pl we see this should be "accommodate".

--=20
Tom

--VS/jCm323wJEVzp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma/qrkACgkQFHw5/5Y0
tyxL1gv/YIH17d7vArEv0pEypMrf59IeRK2n7epzd6k7W2Ubk+z/I1glFiXqZPMO
72iM+YksjMcX/8X06qnz/4cM18J+uEseT9hpK/SKw0U6fMt6mJpIzc41CvVn0KrV
AaKBEMpUZ/KEDEPTK+RMs+EmMS3EOOd2/MDZ3N+JFSctgilve4qAoH0VFci1DZ5z
egIAiR1zIwvHueSxYDLGs5UMqMBhnTA8NYEpwl6jDn4yDTHm0NOpdb2xwLNYlS2b
UKjsW7kvt/abRmtmsR2DM60ZKXUOIqhJFJzAIEOBS0Ge5C6nPbfQMcCptLG8vMlJ
QcvR0xjsjcsalJzBMuFFOxiABeTBzeMDaHmsmE8kYerv62ANOhLVPkS8lWrdY66M
kjaY2xbulT7rG5A782vboi6dofd5/kNyph+9ovqajOPBetaPxYJ9XGW+OTbOH6ag
W5u/wf/y/u4ff2BTR8ML1ycp+kVbR13oEaS28hrpS59ddanJutx/q9KkMu1z158A
RwlAUNGM
=6yP0
-----END PGP SIGNATURE-----

--VS/jCm323wJEVzp7--
