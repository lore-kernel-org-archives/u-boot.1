Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60821C61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 15:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2363260626;
	Sat, 29 Aug 2026 15:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0HZh61EEpR1l; Sat, 29 Aug 2026 15:54:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788018880;
	bh=mLwugNA8RANpyh5iMjHoPYGybTzlW903UeoEXSmvSSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=005in2XEF4bL55/3Ioj1myB9qgw7PnCRCQTo+aPjdoa0BHAyr2H4Kk3cekPW1BVWJ
	 i/FaDV1jE9j8Ow2hVMSRj+t5ZnQZrDGzI5gK5QFHIZaZyqUTaLWQfBuDAL8lwfF1oT
	 nWOf7F+s012Z6LJgAX4E5yg5QIhleoXJgcAw3LihcHcvuIBuKytNuKJLMJ0pxHYZ1e
	 RKt/R44wjFwtyqcqhwL9Vj0NbUaBlcv9nvLa+QG4Dg5ImPMXtD2YlMEyUwhuFtZdN5
	 S+R+u2mZu3O3iDCiLMHmoFumWlytWegsbnMNjyHS1Tuv+GV3iD3JqNP2GYCR4Bouac
	 6+vpfIJuOcAYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B9C66060C;
	Sat, 29 Aug 2026 15:54:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78F75118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AB084070E
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZnWZLvD9D-I9 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 15:54:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Pif/zyNU
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89F01406FE
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:54:36 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6b13496112cso312966eaf.2
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788018876; x=1788623676;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mLwugNA8RANpyh5iMjHoPYGybTzlW903UeoEXSmvSSE=;
 b=Pif/zyNUKkablhRdyxhHS6cc7ZM9k6ep5SgjJukfODF2TgXR+7tST2pCJyc8vGEAc0
 ff8EkuefE/VVcYSIua6R/6uYTaQMDExRosrSJDSpt5z280pqo+YFa+2fuNIwBt0qDYjF
 xpE/LXo67ZEkPl852+CiZA0JOa0ht7MIF+k3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018876; x=1788623676;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mLwugNA8RANpyh5iMjHoPYGybTzlW903UeoEXSmvSSE=;
 b=sziYs05td6KoR1b53kjgXt+2GJhSGNeFqUZLiqlUVWVTDmsE9xsiuj/I6gksmyRcKh
 pqIYfk00PPxFzC99Oo5+ro35qzXmZcOHXTO8Zf6IfPq2I3GVRLkTvlZRFdHpd/pvqUKq
 36IZjQHskXWCcqIDPstS8RstE7qn59RoF28FDuph5LnMVT8JYnBhpAXapCBdfw0G0/0o
 wjmGf8y+uZ+OCB11kf7AzwiCB+qxNW/eZYJg+rf3HkvqvQ/47zpWbvG6LJd7zQDJxSDq
 4WU398pWgvLmaTE1PjkFmcfFV7xZtjF+V/JkhZeKU6Ym+Am70fCuQissO2SWqFfAnCl7
 jpzQ==
X-Gm-Message-State: AFuF++nMIob9kKFJTzPa00k2S0oYmjnImNLpzLzO1+7jRQ/6R2j/xsZn
 uKzZAVCWtg5iO6eqpmTA++30/c/zZxxfsaBfhpqg7MedjjQF14lUxpULsmBIQH6mbVnDzgakSnl
 V8BhACCKOmnzd
X-Gm-Gg: AR+sD13AAedSAxlJkH9PPLXLE52hEgrXvFFgOw/gymrqApsp5UaEirpmdA52RjK2Jy0
 PV6ULT/jqvw0hUb+ShCVtnWUPQmu0GPqocHDWdQYshleiJgp0M0XMBbPTEKndR0rf6er1invNEK
 +dY5F5BebIs1W61ubwsbTZLQXYoTVQlcRqdoh59chgMw1Z/eiOzncxs95DOfPPnxwYJqmogduFY
 PWvLXwt27HeBPpKVnOdQrijcyrE1F2YUBG5pVRdx8Yqv9rXzW/kOD4i2t3J24eGql0KKnFhh3sy
 0VjIKOdmiQfMTZAWRIROiR5tsNSvY8HHwPm0zPA2Ku6LnEb55kk1DHbC833HOccu0Zv7VDnyQo0
 DbLTZTYlYheYML3W5q2W6rCQOOMKvQKq8Ar6FSv/RRSE7vT1Kl+8JAXGAtsxjoZ+52tn6CFy49S
 qKT2i/dmYHbEYBUOHxF+pLTw3uV5qERi95VeOV9us1Rq2IZGDWZpy1q8BBXBDJzTnHEct58gUBl
 DqBDPsnrQnwAnruUAA8zo9oXwAxqHRVzlXb88Nd0ME9h70BePivRb4Aix5S8hE3w7JHCm+6R9Gw
 47qA5ICBmw==
X-Received: by 2002:a05:6820:e079:b0:6ae:9e00:c8ef with SMTP id
 006d021491bc7-6b1c65b117dmr11728436eaf.14.1788018876003; 
 Sat, 29 Aug 2026 08:54:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1ce2f7004sm4821786eaf.12.2026.08.29.08.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 08:54:35 -0700 (PDT)
Date: Sat, 29 Aug 2026 09:54:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 2/7] MAINTAINERS: tegra: Update and correct entries
Message-ID: <20260829155433.GO3959812@bill-the-cat>
References: <20260829015026.473134-1-trini@konsulko.com>
 <20260829015026.473134-3-trini@konsulko.com>
 <CAPVz0n2EQAiqCGeDGosfrytB6908iPfvAt4JwNHtua6QE_ETOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ANcYVOtuSO8KV+6e"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2EQAiqCGeDGosfrytB6908iPfvAt4JwNHtua6QE_ETOw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--ANcYVOtuSO8KV+6e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 06:13:27PM +0300, Svyatoslav Ryhel wrote:
> Hello Tom!
>=20
> =D1=81=D0=B1, 29 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 04=
:50 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Update the main MAINTAINERS entry for Tegra to make use of the "N:"
> > syntax to catch everything with tegra in the filename. This lets us
> > remove the incorrect board config header entries for a large number of
> > platforms while still having the used header files have a maintainer be
> > found. Furthermore, correct some platform MAINTAINERS files that other
> > obvious issues (such as .dtb rather than .dts in listings).
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Michal Simek <michal.simek@amd.com>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> >
> > This is slightly different than Michal's version because it adds the "N"
> > entry for Tegra overall and so catches include/configs/tegra.h which all
> > of the boards which had their include/configs/ line removed actually
> > use.
>=20
> That is smart. You don't need to replace device specific header with
> tegra.h in some files, you can just drop them. Thank you!

My thought process on keeping them was that if a change is made to the
header then all of the board maintainers should get cc'd in case the
change impacts them. I can drop them if you still prefer in v3 however.

--=20
Tom

--ANcYVOtuSO8KV+6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapMAuQAKCRAr4qD1Cr/k
CjvZAQCJE2VX/wuBfBCHGcndl2aHybDZC8dRKJDNm0Vata8NBwD/V71uwgen9R4H
1TdFsn+CyrXjY4WqWnP/+WnOnfKKWA4=
=0K7m
-----END PGP SIGNATURE-----

--ANcYVOtuSO8KV+6e--
