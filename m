Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271EACD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FC483FF5;
	Thu, 11 Jun 2026 16:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RhKrmNeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD918407D; Thu, 11 Jun 2026 16:05:15 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4E483FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6e2d54d3dso4321318a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781186712; x=1781791512; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nzQJOOkRcrJOK5YH3CrLM6HgCYfLJDMm7yKdhzdKI+U=;
 b=RhKrmNeq3Ni6I9XHQzRBPZyek8QRcNzhPAGSRWU95Pr18zMBA2t7P7wh1Wcewxb9jK
 JeHs72hUgz2jGsQMmQSATztszvMpdwg8mwM34uGf39GpD9Jb+dt6CxVBX6lx664UqJ34
 gcXTpdC3LAk++zjbpFMIKVTlyuvIttCTb76Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781186712; x=1781791512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nzQJOOkRcrJOK5YH3CrLM6HgCYfLJDMm7yKdhzdKI+U=;
 b=V8IxkVTidbWc3CgO6YQH67ZRhgFHD3lr5uYeA5yiL1TYalX5RnnSSnqz/cPYVhqAKr
 dsegh2uRUPpiVCEIOf+FZ7D0SxlgbMdSi4zv0WE01XU6mebTebWHy3TKuvHDlqllnsii
 TXQoE6STxxMgr6ulHtB9uTxqiVw5oykBViDiJuQdlSFeC8k0rMRtLFg/Nxw4FFxUMwdz
 2qo/EOCrI1t/bA/yQMfTSPV5i3BDedZbcY6QZ3pt2SM5D6cfc5BlyMwG17qIYMcEx384
 srZEjnEF1/2g6dwbeRa85Crj1Hi28iDO0jZwQScw6SJZpCfx2pr+piFip+OjnTTaylNJ
 8Mkw==
X-Gm-Message-State: AOJu0Yy4n1vnCWWRFJyA+ifTY8W2EO0D0BSPbS30sXInwVjHRZ2SIXHo
 eGdqI0hYEAKcYP5wlu9pd1BEbdSRTdy268v389cL3SJ97PRvEpDPlRRDVE9Juw9Hlhpt+Bq7CrX
 KKdjLMvo=
X-Gm-Gg: Acq92OF0s7JUZwper2EMTe16Tgji77a4My7N5uwIOqzfWvTA2tQfEp6dJGo3vwewjuH
 q9eplIY47xqKt8GoR1xon8A5F153rF5oQMDkCak844uodkT7WzdPNhkGkvVmawUNdKDBGIBF6DB
 SafDp8dOBKj7oXY5bh2qidDp06e7BLR4xmsMpWiHydZyCH4kTedP0MKOPUABuPy/BRKej8BCjzu
 tl4LFPBfffOkZRoyNWVUsYET5p8qpNXrOMMZH3eHJNtndxbDgXBtubVfAeKmpY22sUZjD/vDGpw
 dRPpBHo7RdDnzpsD1btbz6RI3nQXqdQ67oMQ/NuHTznh2+d7oZKBCNda/fowYzQ1R2P9HgmYsVk
 fnEDT5s0S8W+NJR0RzT3HigCU3BKYSI1Ui5W55o/giQK47Qo3bIpH1EwS0g+hNs6SOPNweut/mN
 TOeZlBq022q7W738KgzNh0EeMEzDPKjG2ija0XUBz6+Vm6q4Lkew2Pq8cGv1G9bReX+wLJdt40A
 pJSpyL2iA+GzeiYeyBSMiCLzjgPufhH1k9V5WjCSGKeIherUkjCMQbwxB8=
X-Received: by 2002:a05:6830:648c:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7e7735b0511mr2139158a34.24.1781186711890; 
 Thu, 11 Jun 2026 07:05:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774989169sm1321193a34.3.2026.06.11.07.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:05:11 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:05:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Robin Trost <Robin.Trost@syss.de>
Cc: u-boot@lists.denx.de
Subject: Re: Fwd: SySS Responsible Disclosure Policy - U-Boot vulnerabilities
Message-ID: <20260611140508.GJ382693@bill-the-cat>
References: <a19a63a0-c654-4c71-88af-3b868da3deed@syss.de>
 <e46d45fe-a917-4252-864e-deb431b88270@syss.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="czvS0RJ3zyWwsudJ"
Content-Disposition: inline
In-Reply-To: <e46d45fe-a917-4252-864e-deb431b88270@syss.de>
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


--czvS0RJ3zyWwsudJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 08:33:49AM +0200, Robin Trost wrote:

> Hi Tom,
>=20
> I've just seen that my mail regarding some vulnerabilities I identified
> within u-boot was rejected from your mail provider.
>=20
> Therefore I just forwarded you the mail (without the advisories attached).
> The identified vulnerabilities are:
>=20
> - SYSS-2026-038: Arbitrary OOB Heap Write (NAND)
> - SYSS-2026-039: Arbitrary OOB Heap Write / Integer Underflow (RSA Public
> Key Parsing)
> - SYSS-2026-040: Arbitrary OOB Heap Write (Ext4)
> - SYSS-2026-041: Arbitrary OOB Heap Read (Ext4)
>=20
> If you would like to have further information (or the attached advisories
> files, including reproducer scripts), let me know.

Hi, please see https://docs.u-boot.org/en/latest/develop/security.html
and
https://docs.u-boot-project.org/en/latest/develop/sending_patches.html,
and so please start separate emails to the list, and CC the relevant
maintainers for each, in order to make sure the community is aware of
them and that if you're unable to work on the issues as well someone
else can. Thanks!

--=20
Tom

--czvS0RJ3zyWwsudJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCairAlAAKCRAr4qD1Cr/k
Cp7lAQClZOPaB/3qDhwoW+XWrm0KzxPJYoUwU1R0t8NcJ1khpwEA0Fcd6s3u8Hic
hNZD9mnMfjzY93bbGTsSALy0XPSSEQk=
=qntM
-----END PGP SIGNATURE-----

--czvS0RJ3zyWwsudJ--
