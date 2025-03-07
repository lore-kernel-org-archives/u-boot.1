Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF6BC28B23
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 19:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18ABF808A2;
	Fri,  7 Mar 2025 20:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sgj9fgrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B312980F6B; Fri,  7 Mar 2025 20:09:52 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DFDB80E94
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 20:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6f768e9be1aso36800647b3.0
 for <u-boot@lists.denx.de>; Fri, 07 Mar 2025 11:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741374589; x=1741979389; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m1nuRv9ruOyDC1ZQnSz0gtsXSjxZ0B8YxoD+pp9PMOs=;
 b=Sgj9fgrlfGB2KuHjuy0GqqGu59z+wYram+bS5EKSHJFDgrouqdEXz4IJlyNO8OizEv
 hFcEF0/wtPfO6xNKOMlWRDhgOpn6QGaEQU6uecgtEA/DWH0zk4Au8Z9U0ep1Xz+yZnd1
 kWwrF1fexUb5iNhQ383K9wdjs4na+8AwOFSeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374589; x=1741979389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1nuRv9ruOyDC1ZQnSz0gtsXSjxZ0B8YxoD+pp9PMOs=;
 b=uCN9gE2Q2bgBP+ZLfltpbhOCudwrpi1wK4FHpI3b8mFpr/kE5IVFDA9KQbZyATTOjf
 2EN1UaEms0jZ++4Ibi5K1JPBt1YSJCSsg2IrgJDucmYiEidjs4+TQn2qt7ti2xO7/bjV
 3GgA4YAyxHcBt1vCdpZFP46oB1aAybZzEer4yhlDBLfvsDs3aKs0xrE5N091xwGE+cJi
 0eLCIJOvd6P82PfFzN3O+DvKheN3f49ElXCnZgR6LajlPthTLRRK8EBFHlLlaV4oVlPY
 nt5jGkYTlMBSgOL++OxsMYmcEvdB3OML23tBHQn7Cws1d13efI9zsr4yruNa+w1mjFd4
 n+Kg==
X-Gm-Message-State: AOJu0YwbQ8bBOS+b206RKLbySuc/z+kgN7tjNaWdwWGP4AlVu3bPljkl
 3c0InbFHnvh4MUcg6b5meN18rd08Opu4mgMfeUp6PupGkLpfVbVx34M9l27Kvjg=
X-Gm-Gg: ASbGncvkrCPkfSNSL5FsQmENvLtsZZF+DbHvwh+0LDDPDN1yzBonNnXzeFtIUy2nAYb
 BpBCI3ggdlvvg3ufbFX7XYYE8Q5LTT8xM8pyL1lO7bpUU1yxc6jI7XqySCA7IaegJLPNalA4Rs1
 IgNJ5cSvvaIW1ZtT4qJjAOwtGKcwrAY4U95TZcFGVQqyWb7qKPlRLPwvAIHhW1lTBiLfJXW4dDb
 UY3RxLHc7uESQWooRO6k+cQavR0dncuJlqmD2vaeb+r6xuwFyIzkOoaKXy5vVvL8aGUcfzdEbJn
 TNd3V4I3ypHWGFMVRRvJ7VAUmXpZ0vU5AuYGUrU1Nq49BQ==
X-Google-Smtp-Source: AGHT+IFk4OXLLL6GKw7R/TFEUpZWDHA0s+Ssz2/grqIndtpfwJalBignXp0r7lbIdof/DyyfJkyAFQ==
X-Received: by 2002:a05:690c:3702:b0:6fe:c4bd:e2ca with SMTP id
 00721157ae682-6fecf852a41mr10130667b3.14.1741374589360; 
 Fri, 07 Mar 2025 11:09:49 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fecf93ee62sm749297b3.9.2025.03.07.11.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 11:09:48 -0800 (PST)
Date: Fri, 7 Mar 2025 13:09:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 30/47] test/py: Add a helper to send characters
Message-ID: <20250307190946.GU2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250306160428.3041057-31-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qLwJOYykj9Iq0Chk"
Content-Disposition: inline
In-Reply-To: <20250306160428.3041057-31-sjg@chromium.org>
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


--qLwJOYykj9Iq0Chk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:03:57AM -0700, Simon Glass wrote:

> The existing run_command() method is not great for sending things other
> than U-Boot commands. Add a helper for sending arbitrary strings as well
> as control characters.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This seems fine so:

Reviewed-by: Tom Rini <trini@konsulko.com>

And so that it doesn't get lost nor expand this series more, an issue to
cleanup the existing users that would benefit from the "send" macro
would be good.

--=20
Tom

--qLwJOYykj9Iq0Chk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLRHoACgkQFHw5/5Y0
tyz77wv/ZuuKOf+VWfHTL9/5edqus7VEK8BRr9GsCVNDSPTeLpgl3seWQeBcVtS4
WTSdCFCG+oM7eMZq0bovL1h9aVq6AWDnFcPZOt7cMWMol/D399tKKX25e6dym+Ri
brB4v7FKuKFMToqYXutPIlT4pEgZwuryySe5sXXxNEBPWPyQ/0OZN2Lnm8Iw+rMN
DyVvwUQ+g28DHAMap1en0HVshOLhy09W2O+HpdHIXerOi7EPXDLL7UC/wgRZM1BK
P1t4hgh6Xtui1jDFXyK7h8j4FtyQmgGu6aU/JIgdpGM8Zg6u1vk0PfcrAhpaLfD1
RRiJod6L78V8PO/LfGJzcdhpzGPR0X/ZRRJ7JtdHfXvt0iY6F8rzS/FBzDWquBuX
svogUJZ+uoN32+KfFVW87Ps6S7fsqVFZ3C1zGhZGKjBAGH80FqMGyKvXpldwJInb
1HOfi6GO0OEPN9iUoz/FiFYZfGhOmZQs2sFpwY+XrYWJPDFENVh1xTGe67kKZBlj
i5NiCbRa
=TzQ/
-----END PGP SIGNATURE-----

--qLwJOYykj9Iq0Chk--
