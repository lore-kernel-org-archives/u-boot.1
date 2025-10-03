Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0980BCCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 837DE8386F;
	Fri,  3 Oct 2025 22:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A8Hwr7fm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDB98386F; Fri,  3 Oct 2025 22:19:54 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FFA83826
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-911520e43edso111056239f.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759522790; x=1760127590; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bzW13syzouCQ+QhYu7UAU0gg3FDBN9r6oy9JL+gU1TY=;
 b=A8Hwr7fm2JipCOzrMZeMvEqCO5biXZZ8zXxWXx7OxMM8mTEt57VsMm6keAOVjqoOKJ
 MO2zKx5kHp17miiEAX7QgGtegOCPki9Kpb+4RScso1RVjEK85rhv8EV915ki2qLp1tSt
 OQ2pe9Ydar+Ozr5c0A4eY354y2/MAjzqMGYAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759522790; x=1760127590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzW13syzouCQ+QhYu7UAU0gg3FDBN9r6oy9JL+gU1TY=;
 b=QhOEgtllVFrdvcA7IV0mi+MH3ZvUnwp/vpxPzdSmGnExRWQsPcXyVG+XfTmyGPSQPF
 6BnVIPRXM7XJfkFXnCqk2delkhVd+WdbPsPJGLG9E2gdQ3a1fyHpMa0xvHcl3fW/iCd4
 pfObiD2F0BtE9W9pxcQ1d5mgpEX4MF/uKue5K9zD06WU0z6hAuaSDN4o37xD/NQtVOlj
 npSaOv4GmItd/ptNWUoXLPgKUHvPd5dhhYhLQYNnzKV/6FWWGdsxGaLkQA4wt21+3GpM
 U2Lqjt2q0gOi3fdGZYRGdiiam2ZmQU9abzKIxRqdguhqDwQt9E1GRUzwGQHMXZvLo7tJ
 VOlA==
X-Gm-Message-State: AOJu0Yzcw15fNssWf9iv9olbyD3N6+vGylKRMqEbp7JEZP6TF4RmjRw+
 Chm5uyybHfaumvTVLbp7Ig70YG4f//mvyrKN8wx2m4NAsA7CoBpPLCRmt1l14y0aonY=
X-Gm-Gg: ASbGncvI5jMYV33lASFZxvOKIJuzUZ9KREQhFdumoAsjqFhhMmdAcRMEv36EQ26L4q1
 K3Xz0o+R7TxGkZqEPCdP51bBxSU35Z1iIYtHMu7uXDh2IBcnzUF/nvKpr2fXmu1aEGRelIR/rSU
 Po2mJiLdLwDP99d9ixISHDHrttxA6GiYhAC2etRKqW9n9472Z8sOGXtJV4rqrsQgM6r34MegsLu
 66uBtuNXcC9I2EiBhj3AzzjtCL6kUSPjmE9Agh3ErZkp6IT1Kvs3k1aHFtcoLezETfjdUWNRr9R
 G5eG8jsGOuvcqxIT3UqMxAMjxWIXYsphUONe8gDrnChGwsFH33p6GYnxUPmEdInkMm2SbJn3q1L
 MV2ADiEBaY8m3vg/krigyUfgmxJMc8eANdcBVrys1X7K/uCxIhhLZgaH0k9ERrqJo5nNxPYOMfE
 cA6ZGMbUKBIw==
X-Google-Smtp-Source: AGHT+IGHcjJothVxRynfEmv5QiwGkaVmC1V7BBai5I/TS7Nr1Zp9oKs/ETWG/4Jc2EWRKC0CKw0/NA==
X-Received: by 2002:a05:6e02:148b:b0:42e:7a9d:f5ee with SMTP id
 e9e14a558f8ab-42e7ad86603mr54831665ab.15.1759522790522; 
 Fri, 03 Oct 2025 13:19:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b215dd6sm24630865ab.14.2025.10.03.13.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:19:49 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:19:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 3/5] configs: select CMD_BLOBLIST for Firmware Handoff
 testing
Message-ID: <20251003201947.GV6093@bill-the-cat>
References: <20251003192222.767882-1-raymond.mao@linaro.org>
 <20251003192222.767882-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Emil/7bTDZLmYe4+"
Content-Disposition: inline
In-Reply-To: <20251003192222.767882-4-raymond.mao@linaro.org>
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


--Emil/7bTDZLmYe4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 12:22:17PM -0700, Raymond Mao wrote:

> Firmware Handoff tests will leverage the same board type 'qemu_arm64'
> with a new board ID 'fw_handoff_tfa_optee', thus select CMD_BLOBLIST
> in qemu_arm64_defconfig for running the test.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Emil/7bTDZLmYe4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOAv4wAKCRAr4qD1Cr/k
CnPIAP9qwGgGiXBpJ0pQ4HYrkHMMiHiCv5LtDoWcmanoCHvQtgEA4orthZdHyeDb
4GEVsAQEVaDO+xA+G5UK5Upv1rLnzQQ=
=7qPP
-----END PGP SIGNATURE-----

--Emil/7bTDZLmYe4+--
