Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F4CC5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 15:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3BC340635;
	Wed, 19 Aug 2026 15:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cMCDwZmPz0LS; Wed, 19 Aug 2026 15:53:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787154817;
	bh=3Gy+YaZiH6SxeV0oBBm4HCXbA31plCAwqy6aB98tTG8=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ExmdfPSKo34Ifox3MYuDpWzeCTYnWy/XAGzRk+eP+i6fGSCjp92/9KpNkGB/wpAcM
	 LG2snMxZ2zgpBFgYyWKqBZKRXUvyQoOawqi6fYY7pzT7LuT023HZkt3lSZGjdU6N13
	 gMujM/kMtn5ehzK2sjJzfP9OWnWDDZvCxI9qqgObjbhOYV6Zbn/gj38eo59GDZCEvG
	 WRfSRMLrA9+ViPolfnj1E5UKb/2Ku2u1DQ3DhvgMdD4E0WWjIwPp90itaql+HwWpS3
	 mK30OHm4bNWWPUl+0TIU01pi+3hK1kHQo3K2sVMCdFPwK3kbrWzN+obPJmgsZRUBWY
	 DN5PQkKpEttCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01E88405B1;
	Wed, 19 Aug 2026 15:53:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03B0E1395
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFD97401EF
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eMt0O0s6q70 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 15:53:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eloxQ0rs
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D0114008B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 15:53:33 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-448a12ddfb4so489010fac.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787154812; x=1787759612;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Gy+YaZiH6SxeV0oBBm4HCXbA31plCAwqy6aB98tTG8=;
 b=eloxQ0rs4J+TRMKXeeGV6MdsTee8S6wsT4Y6lyD6QHhyKceMHGAAiVeZGYv/IzBOMD
 CUE54/yBSVjvuX5Yv4aavSN5PNF+hNM67dKp8/I+IO83vYBARON4zq60rEBDwEofEwu2
 pR8sROgHeMJ3C/c7pepdihvEOewvTteuMZAoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154812; x=1787759612;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Gy+YaZiH6SxeV0oBBm4HCXbA31plCAwqy6aB98tTG8=;
 b=ON53UDDExCzT+A3VWyjOcIWVeFtr0MUJE+GZNahpbj061XznHiiYv/MxVcSgRpny1c
 dqLExG33goKBLkQ9L6KweKa+STrV4ISVfVi48TImPAo9z/sW0IC+K7JJXWBZPrQZpERw
 WXejJJ7CsaTvrq0X0E8rIqNyCgXMz0065uKNzHexsiP0toOjDDEtHv8syzD7taUF8U8x
 phijGjuFGdytJuwW6o1mLZJcHL4FSPVZO3Pf1iCdg32xD/o2jBKMHVGWBoXpHkFGaxZB
 OwolIMY82+ouH2oh54reba3OAss8AiU6mu8dI0xEWsaVd5MTMrJsSKaxLwNcEi5cjLaR
 0Kkw==
X-Gm-Message-State: AFuF++lq/klhyYA4vKXI/8y8R7Hz4CwfF7O9+4sccjP4dlwnMXR81zhM
 AzX2jsVFZTFjTWAmydlfqFHlUaEkANLLvebjvCjqIq7HUHuJMHues/Oo4rzV0UVAfnZ6VFYGZVM
 8WjhFrFr2CR8sbuM=
X-Gm-Gg: AR+sD13WkjKoR2YaSalJxS0oJCWF1ACPp981DDCrXvbWg3sPE/eKHOQUWLHDDcxwL/I
 xl1efYc3X0h34v8ZA35lZ4gYJ8ppVDhrKLd8uAa8sqJ2DV4GgWJB7PMePF5zBTAR0xVLmfUbUyp
 nXdnCzQruW1FmMHzlm4LJABncvcnJVEeM922NRsO2sI9HDPycdk2MOBITsAISbA2CfJEYUXrJNO
 MY+iVY0/dp4r7Aqmdna3GBurOzMbae0S0tQk85tZGieDkYoyAflUxVd8atCqTVQDJSt8di3guzd
 eRQ4oCSxPFHoWZ2E60jhxz2JEl11K9M9fT7eS/tKMeunrHxkNVqS/a06naJymfjrAQAJ75ouRc0
 dRk7M+2No9wnCQH+ttvOADfvUTJn2HEXpJyXHUrEuduH5Pws8e/wp3jv7Pouf37ak1m3QcHOVNx
 ZZhj9HM9YNOZ4JTaHuXT5/5nZeJTqJxjpSLwnM6HLZEdxve/hsg5FCRn01PPo7FklkWrjVUxrBx
 r6dDKdP7r9GmeQdz86E8BZa4yvdW5UjJ+TmU3Da7bKttxUGAAnW0S3DJaMUChPlwYGdHhH2RnIX
 qeugc/kxTQ==
X-Received: by 2002:a05:6870:810b:b0:448:a0cf:5afd with SMTP id
 586e51a60fabf-462f632a5f0mr5610051fac.4.1787154812564; 
 Wed, 19 Aug 2026 08:53:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45f226904b6sm5486474fac.0.2026.08.19.08.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:53:31 -0700 (PDT)
Date: Wed, 19 Aug 2026 09:53:29 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org,
 u-boot-custodians@lists.u-boot-project.org
Subject: Re: [ANN] Further mailman updates
Message-ID: <20260819155329.GA1507897@bill-the-cat>
References: <20260813201711.GH3297518@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eycwMNbMOJCjLYZQ"
Content-Disposition: inline
In-Reply-To: <20260813201711.GH3297518@bill-the-cat>
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


--eycwMNbMOJCjLYZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 02:17:11PM -0600, Tom Rini wrote:

> Hey all,
>=20
> As some people have noticed, with the move to lists.u-boot-project.org
> (and OSU OSL hosting), there's been some behavior changes for how people
> who use an email provider with a DMARC policy set to reject (for when
> certain actions happen). This in turn lead to some rewrites, and then
> things like patchwork (now updated I think) or lore (is append-only) not
> seeing posts as expected (but seeing them as the email policy wanted
> them to be seen). The good news here is that we can get the lists
> changed to the same behavior we used to have (which also means that
> gmail might see us as spam more often, but... who knows). For the two
> low traffic list (board-maintainers, custodians) this change has been
> done now. For the main list itself, this should happen sometime Monday
> morning pacific, and monitored for problems.

A few updates. First, this has gone live now for the main mailing list
now. Second, after a report from E Shattow we found two other
configuration problems with the overall email policies, and they've now
also been resolved.

--=20
Tom

--eycwMNbMOJCjLYZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoXRdQAKCRAr4qD1Cr/k
CsAwAQDg2CapvvgpgOj03yXFFRKUkNayYpXyxzJGW/K9JQC7ogEArFr45EhQRw60
LZoD/75BbsH7H3/wAQCXYXK/e6GHTAw=
=fLZr
-----END PGP SIGNATURE-----

--eycwMNbMOJCjLYZQ--
