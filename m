Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05384C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 19:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E52580C8F;
	Tue, 18 Feb 2025 20:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ue4y0zLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57B8580C98; Tue, 18 Feb 2025 20:41:36 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55F580BA8
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 20:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fc0bd358ccso11881959a91.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 11:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739907692; x=1740512492; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ya7Dg6ykA7J1FP9WLxDzZzFqrtZCRz/3OvN3BX/wjA8=;
 b=ue4y0zLYrwtOn5tL4lTzk0VkIK6T27cIBT10wx96YPE5YTqv60Nm8wxw2coeM1TggA
 SxQKRRFoO7LO8Eah5o+nMhc/US0V3K9i08z2p1IujV2owbTG6kgUjHq7JpeTj891+XPt
 yqQj9tKp8hEGBUDC5ME4pxa7FEKdy75Xla9R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739907692; x=1740512492;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ya7Dg6ykA7J1FP9WLxDzZzFqrtZCRz/3OvN3BX/wjA8=;
 b=CHgSmA4TaRamWdcyXugEDVzc4qsOl3/lmHTKL489WTeOo1XaWw1h4qDu8QWel9oZV4
 YwiOMjK7ffk5+h4B22ARNcM7RrVc5cdmRbMzi+tNwFn++bWuYqp18E7Fj85ildI4+FU0
 9252AWOKhQoq77hWaagSfXLzxCavv/glidsgxsrQC9yEr87qAlixZ3bXPiTF5juNaKk2
 uelkPNn+DQ6iswWmSqSe9v5YaqL7k4JUlPiS50gt/oJoGdIJE6KKIn2GUGSyaECF4Phr
 OkMeL55MVqWfniMdPcNeFBUChvU4oHz0doFjE7WYIPKN6ORyx18du0ZFE5o4xPEAgP7D
 f7Iw==
X-Gm-Message-State: AOJu0YyaIEr3IrueIQfZfmD1gIR8rOny8KXmkFHk0r/UhokEFvxTaS+r
 0VOrFtx19IIJlMAo6ApPeHAZ1mYW/zpdckjqYIh6Pq67xV0MiqEMGxwZ/tCFjL3ndtlqg9P++/g
 B
X-Gm-Gg: ASbGnctBSLhagqIomKI51F4U8FY2husgBoTTNEGNxbxAdnn8tUy3twbNDTysFndpcVI
 ffktPDLi+Mhg2LwLJqh14/NeXMsB0fQiJt2atpvuoWGrk/gMI4F1DGcPcsnBVp3/YZFCYHmUhQg
 BrU0ghuiycyimZaplv8/p/XgylJgp0+ovdPW0EO0lMSMzl63cID/tjq0OV9l91ipRFwLq4IIzyh
 HStGEbZ2saOWVnG5DVckKtGioNuaoH58d+9S+h2mClx1uwTF5lqmwuVaMNk5DB6afIT28ywSsa3
 6Jf9FLsyyxIbUw==
X-Google-Smtp-Source: AGHT+IFlBTpROl0abBYEOCtcDe3+cy/hNCfUHCherX3th9ySBtKVhJ0slsBrkeG7yR/YVYlcELGqpg==
X-Received: by 2002:aa7:8893:0:b0:730:a40f:e6dc with SMTP id
 d2e1a72fcca58-732618f3469mr24025505b3a.23.1739907692040; 
 Tue, 18 Feb 2025 11:41:32 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324273ca16sm10569289b3a.119.2025.02.18.11.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 11:41:31 -0800 (PST)
Date: Tue, 18 Feb 2025 13:41:28 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 u-boot-custodians@lists.denx.de
Subject: Reminder: Next U-Boot community meeting 25 February 2025 (-0600)
Message-ID: <20250218194128.GJ1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="spg4YLpYqz/Sn030"
Content-Disposition: inline
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


--spg4YLpYqz/Sn030
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

This is a reminder that in one week we'll have the next U-Boot community
meeting. The calendar link is:
https://calendar.google.com/calendar/u/0/event?eid=3DN280N2tlcXE3aDVtbjlicn=
Nkcm82YnA1bDBfMjAyNTAyMjVUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwNmE4M2RlNGRhNTk3N=
DVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc

The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
February 25th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

--=20
Tom

--spg4YLpYqz/Sn030
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme04mgACgkQFHw5/5Y0
tyxBFgv/bm/DNWArH8G/4yprXvwmFYEyXlPKQ7PNAtY9cvidAHN3DnR6JXeIWfW6
Qz6h4gsmWHkWRt+s4MLzr2y5obfsy6C2M7mJ1giuYBBB+iBzWUcLDMJNe9PTfVP9
WR5JOMWi1ZUaxDVOW3eGmE1JUcpQIwVto9jLPfEEFFT3tAjJQY93HHXNrbnFiNCM
ZNPwZ0478viS1JluGN58adtC+Jqdb1ASga56mO8bw/dfTQ5gGH0Ls0aSEgifChLO
1ujaiG4QaYiaFh3+6QzdXukGMGbNm3R4pm4IKEpoOjtd1f0vyzDP2LSOW04DcZMI
YSA3ixdcX2Phm9goWu9m5Ij4Yi9hr9AtIZSZiJQd3N0KnxJnrBMN7sSJ0M5xcl1y
hLqEQwGx9iFM8lTwNQN/wOFMbWYV+nBUOQa6fiF54UPP9AQCrRE7kCiu7yzU0QR+
1oXe9n20nyg3zTM1PGwwvb+4E31d9GIOhTAN5Lri8y43Z38QqWRakxaa9OfMrchw
o/Lh1aF+
=Cf3n
-----END PGP SIGNATURE-----

--spg4YLpYqz/Sn030--
