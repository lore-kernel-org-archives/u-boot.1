Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25F4C25B5F
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 14:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EDB887D4;
	Fri, 10 May 2024 16:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tMyWmFWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D44887DF; Fri, 10 May 2024 16:23:39 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 589988860C
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 16:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-43df23e034cso17687001cf.0
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715351016; x=1715955816; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RZOqU/9rYJlDYczUmmAhMJpZ43+gaR+JVqm4hjAg2yQ=;
 b=tMyWmFWvtAxo8bHK4CwKwOeFTPbojWyK6H2/lpm3CWt7xy6J9v9DJISHLNo/QgJ1VE
 /eDFzqvQ8ewANPYRWNV4oIlIF8+QXjKrLrIv1dOlxpDm6mD69TAYbCEyx+101YD+d9Pd
 Q0AcLkdXe8bVz1Cnnc4q3fDsr3Xmn37qc5xvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715351016; x=1715955816;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZOqU/9rYJlDYczUmmAhMJpZ43+gaR+JVqm4hjAg2yQ=;
 b=ehKrbUIGMEzZdnYTsaIigRWdWb2UFmY60t/WXmdUEFhzwPbP26IighO5nsz5Q2ETam
 j8uxhHMmvKTu2p8hZTmQCOkPiCuhQAc6CWIXzWJyg0IqQvdeJnKCPB3vJPzKZXYaAlgQ
 sCTiTQxxVuOeFKY428njZoaaEDumGsTINbkubMfcxfOcLRK5kFOc4v00kwoq6HQKSqaG
 6Ovg4+fk2gX5r2j4adrSpACa1jNflQ/q87qBtrwunQUfHsm9Y3JmImUwWWshJ3k/cpyI
 9Qd9aBnBOtKyFbYegaaF5kHolJNd2HLAC+W5Fx41XAREdDN3enr+1E7UO+VJB+DtSrSc
 NU4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXnGGHXOVq+3NtTrEzMsT0bnB0Jr1vw5AZpT5OXVVHLBaN3thUmp6D2V1q/6ZD2UW3TCaJC/BZ+A57n/RJamx5JkUfvQ==
X-Gm-Message-State: AOJu0YxOROmOS0FE/9S3++4mZG2j8TLuHvRCOa/bL4Mfad2nHN/EpXuc
 pxp2reRZ63zXYsQLEjVyFOeF0tIBkNSK1xU8V67xtE3ApL5HCrkWurAZSH6RSKI=
X-Google-Smtp-Source: AGHT+IFGD0Ukr8WZFjBzqINr3mC17ChK6YKQNKShxn/+BaxcBdYKYFIS9u1VNYgfqpI7PXLkoEDK5Q==
X-Received: by 2002:a05:622a:394:b0:43a:fbe3:c2ea with SMTP id
 d75a77b69052e-43dec297879mr29442491cf.21.1715351016131; 
 Fri, 10 May 2024 07:23:36 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43dfa7c0c1esm14804011cf.34.2024.05.10.07.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:23:35 -0700 (PDT)
Date: Fri, 10 May 2024 08:23:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 John Crispin <john@phrozen.org>, u-boot@lists.denx.de
Subject: Re: [RFC] pci: mediatek: add PCIe controller support for Filogic
Message-ID: <20240510142331.GU2568172@bill-the-cat>
References: <20240412141051.23943-1-linux@fw-web.de>
 <trinity-564944df-1cc6-48ba-8661-ece741792f3d-1715342246700@3c-app-gmx-bs34>
 <20240510130819.GR2568172@bill-the-cat>
 <B563AF62-EB8D-41D9-A5B2-E0E6D561FAC2@public-files.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="78rHKz/1bExiHGIb"
Content-Disposition: inline
In-Reply-To: <B563AF62-EB8D-41D9-A5B2-E0E6D561FAC2@public-files.de>
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


--78rHKz/1bExiHGIb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 04:07:07PM +0200, Frank Wunderlich wrote:
> Am 10. Mai 2024 15:08:19 MESZ schrieb Tom Rini <trini@konsulko.com>:
> >On Fri, May 10, 2024 at 01:57:26PM +0200, Frank Wunderlich wrote:
> >
> >> a gentle ping...any comments?
> >
> >Seems fine?
>=20
> > Can we switch to OF_UPSTREAM first however?
>=20
> Pulling mediatek devicetrees from linux will afaik break network in
> uboot for mt7622,7623,mt7986 and mt7988 bananapi boards because switch
> (mt753x) binding is different to linux.

That needs to be fixed, in U-Boot then. We should not forever diverge
here, that was not the intent.

--=20
Tom

--78rHKz/1bExiHGIb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+LeAACgkQFHw5/5Y0
tywNTgv8DT1PnBYAbWt+FYjveXiSsy3cC5ngtuKLbYAKXQA9SmDvXo96/2TSBDz6
av0WUZ9xLQTbrkMUxFQyrAie7MyN6LlDeTrPVZhdRaSjugRQAox69TFJ0c2wj9Pa
qQmNqI5pQ1gjbhGUZktWwHdn75O3gpNn5roSB073iHh00b9AvMNctFrisgZNyflS
0wm85JCe1lxHMtsDrPQwZOTKHrp7qQpFkgehnz4MlUnYtjcT5VYNt13UIna3LHxP
pKPLama7t2tOLR1aRH+N7P87xCjLofpvoIb4HYJGcwHiqVVeZwd+P5lFqN869GNh
0M+0ZOnGTOxOCcQifZ+ChyB5/KE8lOzhc61LwHUB/Y42i/zgfTbZPxB3jwqWIDVB
6GijtNTaIXaaV5wRLeqbUsqrewTqaiywmLQ6EoIrSraP7cgFlsGGDv9S0azzlmMv
xSAHhEE/vub6MSgNK9kNXOUKFW2O8b9VIzfdG53iUVkVxmdgWJRBxpJawf5KFu5m
pFQnzc3F
=OKvs
-----END PGP SIGNATURE-----

--78rHKz/1bExiHGIb--
