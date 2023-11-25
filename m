Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4484FC4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 22:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA94B871DF;
	Sat, 25 Nov 2023 23:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RgYhNtJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3303A8708D; Sat, 25 Nov 2023 23:38:15 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DD2871E9
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 23:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77d8d1b7952so40752685a.2
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 14:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700951892; x=1701556692; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HEHCcM8ph15F2KeJ/vWV5EYr8VpjrqSEXMSLMvDdAWA=;
 b=RgYhNtJThTPUfOPXl+ICDEEObcAMU4g+49yqOgzp2e6YWSAKhE+X8sdNE/FK+jvSYV
 jB56zf79ifcfxDc2HPNfVvy0zoQfEAJ1KsAPcTMKt5yl81pKSrryHZ7ZKgEMPaeu6yOS
 0hQRC8tRu4uIoC4XuFCeTV2M7pM/OKNjyw8yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700951892; x=1701556692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEHCcM8ph15F2KeJ/vWV5EYr8VpjrqSEXMSLMvDdAWA=;
 b=eBN7asmgmmugt89YJrLw6p7XJ8tDpowg5B1XWCcMksOUtqTeqxDN+f7iipZplKxMzM
 ztZpmKnvWuHjsmYGEqy4WCyhs3Eiv8wif3oLx4XvqPxvFL9kq/gatWgNO8P5aSkxLodI
 KSZ7LaaLgTKLGSgCjnvDegLBhJsblccGpkiKyjFL5LcVeuyha2uVPRW7pE0C4SXlpWoY
 iZ5TyDUiKUhfjXLl7tVnVDIis14AHzD1P79A9fBgx7vXmApSTxk2Dc5mSNZCl0nXEWEc
 H0FhKBkzNkZaCCsXG3IA8HT58kRmw/QbQYtone31FBsBcsVl+C3jUJVJbOK/q+xaDMm9
 mnxg==
X-Gm-Message-State: AOJu0Yw8I7JuGkwtUj8UmPIx90fmCLeXbapFXTk0BY7QMxmXY6T3G3a+
 FtiAHPPCXaLt2MT+yGLBIXen3BWDlbutUj9JLWXpCA==
X-Google-Smtp-Source: AGHT+IEqoyjH9/9RqkDRBEsDOq2mhgiS5OQxYL8qyF658cAGK7w/m2bCSQ6Ipbu/M63itW/MwVSM+Q==
X-Received: by 2002:a05:620a:4d81:b0:77d:91f8:ad2f with SMTP id
 uw1-20020a05620a4d8100b0077d91f8ad2fmr2045658qkn.51.1700951891843; 
 Sat, 25 Nov 2023 14:38:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-18aa-0515-8718-e379.res6.spectrum.com.
 [2603:6081:7b00:6400:18aa:515:8718:e379])
 by smtp.gmail.com with ESMTPSA id
 pf18-20020a05620a859200b0077d7cfde46csm1843604qkn.106.2023.11.25.14.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Nov 2023 14:38:11 -0800 (PST)
Date: Sat, 25 Nov 2023 17:38:09 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sergey Temerkhanov <s.temerkhanov@gmail.com>
Subject: Re: [PATCH] boards: Disable NET on platforms without NETDEVICES
Message-ID: <20231125223809.GW2513409@bill-the-cat>
References: <20231117154757.777827-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P73E20iMdScM9N5N"
Content-Disposition: inline
In-Reply-To: <20231117154757.777827-1-trini@konsulko.com>
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


--P73E20iMdScM9N5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 10:47:57AM -0500, Tom Rini wrote:

> None of these platforms enabled a networking devices, and disabled
> CMD_NET. Given that we used to gate network support on CMD_NET rather
> than NET, we disable CONFIG_NET on these platforms now.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--P73E20iMdScM9N5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVid1EACgkQFHw5/5Y0
tyzbdgwAgyPe6ZK7LpQGNv5vtTr+RNC3Ki1Z+PJZkdAaOIAKN0+xODD3o2NlA+Rj
pZtHgPDKd0vvlEntkwKFZUkPELAgBOhegWBHxPqJ3b18idPy+kr3idy2Q0fjuxJb
VTk44IdQAl5uRbyh+ucPhbl1WNX6+bU2kRhbeEF4pB6ZLmmrcVqBDu5Ajn8GbCfP
9Sd2S8MJ5Em/YC9Tyd42RgptNcJXbXQzjKN3wtZVzpLb+w55RZrHLL1LBZuHJu0Y
6AkuT9nmk4yXjf7mib8vrVVQSZImNIAJBTfJ+Z8kISNycpZg2fvnwZLIjYuB3ETW
dHZLg8rg+ymsUzaubGw7yKUKXk5hRe0/bKNwxae2XhQW30u7XTYxmDX8rVRyZf7e
MLplstXduY8jqIcTd1dhYbqBH5pfLckIsx5CCSR0TO4tHh304Oq+S0eWcEW0IxMj
R3KSSqGz2kM6q9kjytOAIGflWfDjNJqvdyIP2eEe4aOe0hPzgKFzTZBk2DFqP+fS
z579r5hY
=u9Da
-----END PGP SIGNATURE-----

--P73E20iMdScM9N5N--
