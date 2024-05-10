Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483D0C25B5F
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 13:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B8A88194;
	Fri, 10 May 2024 15:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WwBsIZv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EAF884C7; Fri, 10 May 2024 15:08:26 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7CAC88194
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 15:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-792b8d98a56so175557285a.2
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715346503; x=1715951303; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CLojNXgKAtru/O9GNy35xBj2KcZjQ/oT7za8YnQJl4I=;
 b=WwBsIZv+dTBmoFPf15HRSofXadv0xIZZl8PdSxlczjLrK4WFe/4dcd3rVRttZ+Ts+K
 PTaJk7wRVNKEgCechasrmRARVvWcnAMXqHh9UbG2beW94BTRrkLMf/w6/zr063uBeLuF
 KMatL04Ys0ZzrCEY6nTX2azHf3OZ4wD5QCbdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715346503; x=1715951303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLojNXgKAtru/O9GNy35xBj2KcZjQ/oT7za8YnQJl4I=;
 b=rV71+cs9RVV/GAZaysrSrTUZNDs8Btn0JQCVdSHhLDZbVMsRy/HzFtRkjTMXIjRzXV
 32QmQNT4X4ppCmFV7l/Vg6YvdZBRZsRGKnuAnVIn54acG9tmnlmO/nEH4tNDPeBjCU/U
 rxm2dL7AMVMalctzoUG4oPzLxzrQVDTm9Z+zu+jP5cct2QZKvzxKhOe3Gbm+ZDpgiG8g
 XaC5x/pHH+YGV6ILDNbapXtQLu9JytP+qcRXHVbjy5JzH9R6bs2po/mB/r3q5d+LmbxM
 DBSODL3h8zaBMBT9b2I0vmEuADOO7pY/RVY/SW1XJcTSM+lEbXwreYXCST8WsgNK/92l
 KKbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiRvbXVL6wrecqLs+wRknoiA7C4PvUe25b14gtTFgizmlz2v5U6fIQiXeLuT1WfwznjR29cPcsHgUHGQicTCfXWyi/lA==
X-Gm-Message-State: AOJu0YwTmwEfR53Vlp67FklG/48kDIF6K0dF40WbtVEllaYtjy5gX1ZD
 YgnEfsZ+GjNxfg67QURhAvLosdthCDM2hQKLMms7SmpnGOmD6PoIxruoOznYfHQ=
X-Google-Smtp-Source: AGHT+IHG1q0ywUqyTptgr2b8xsoPKPgcAO9dl+B65/Pv3wWMAXNp105XeDWn/3M5K5mfSolU60Bp8Q==
X-Received: by 2002:a05:6214:5881:b0:6a0:b2fa:71e9 with SMTP id
 6a1803df08f44-6a168276d38mr25188386d6.61.1715346503427; 
 Fri, 10 May 2024 06:08:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1ccc6esm17028366d6.103.2024.05.10.06.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 06:08:22 -0700 (PDT)
Date: Fri, 10 May 2024 07:08:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 John Crispin <john@phrozen.org>, u-boot@lists.denx.de
Subject: Re: [RFC] pci: mediatek: add PCIe controller support for Filogic
Message-ID: <20240510130819.GR2568172@bill-the-cat>
References: <20240412141051.23943-1-linux@fw-web.de>
 <trinity-564944df-1cc6-48ba-8661-ece741792f3d-1715342246700@3c-app-gmx-bs34>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u/uNgEqisQvVtL/2"
Content-Disposition: inline
In-Reply-To: <trinity-564944df-1cc6-48ba-8661-ece741792f3d-1715342246700@3c-app-gmx-bs34>
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


--u/uNgEqisQvVtL/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 01:57:26PM +0200, Frank Wunderlich wrote:

> a gentle ping...any comments?

Seems fine? Can we switch to OF_UPSTREAM first however?

--=20
Tom

--u/uNgEqisQvVtL/2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+HEAACgkQFHw5/5Y0
tyxpkAwAs85gEtm5q52IOOIF15pOuyR880WqzoMYlVdrCRybmVioatoNxhKE3nAB
d39JqHYpP85bB7MxlHLczFq1liSlG1bmzaPX3DdGuympFqccGkEb5X9WQsFq5MzP
4az/ZOCEIIuRDvWQ0vQkgznu02JlzxK1RAo9zfmV5GZlYaLmSxoCQloyoevlGzyV
roVLnrUAQKY5stCAEizYZGS+Q0Hw5fKJocVCzEXKMZfhdh4W16WPfGjk/2sq/mmy
ITN4qY5UUnL+6clyW7k1K4OAskIRA/Fg7ZnEylT2VTLfn7w5ZMUHDAr+6x1+vuPs
yHQy959YfzaoDEynDuOerAkX06/EGDqP8s+5n362wpcCSuqgyvR/iERsq9vRhPPa
OvRKT7y/dzhRPSpmgo5Tl7h7bfhuIY9F/jqQqvkBKDtLkKMjeV7YEjGc8r9dPzFF
7Y800rTl9dZcnWgEJxwxnCSzlf90Wd4tnHyjuyi7QVlPt7edlUr34i6QYWBgnthd
R0AmxpC9
=twA0
-----END PGP SIGNATURE-----

--u/uNgEqisQvVtL/2--
