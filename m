Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333C9C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB9F04082F;
	Mon, 17 Aug 2026 18:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ENJ9ykFEeY-c; Mon, 17 Aug 2026 18:27:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6267B40826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786991261;
	bh=WpkoLpElAfhUXcpB3iux1Ia/Sk8svPcJMIbnt0FaziM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kCr6/ndOiqbjmnZBaow8o8b629pb/u/O0I5iYZSAEBYTjeuI+CzDGMHqnh3Lvcz+B
	 NBgfg7SobHJvWa56WPEAzfyKX+8gEtpQWsED4b8aWiRXyf4lGuX9lrc46AsR9FyOF/
	 6Mwz7UuHGnjq9uVdIn2eo8nd3qX8GEDLLDX/dusM4sw4QPSnR/vkz40crEXFNWpbY/
	 1St/6lRXKkvMmTWdYHx/UN+s1Fm0yDCBO+0clQGNMmOixwqp+GRw9WVW7URTNfTx2N
	 OPY+JiBNTCFhBTfmG6qqKD0fjYoUlDmkXUDi+lP8an+N4p7RbYi+L5bZfMTBvoyiRD
	 lkxFAIC2VAzxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6267B40826;
	Mon, 17 Aug 2026 18:27:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5804F334
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49A006081A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FegDinwLtqra for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 18:27:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6385B60820
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6385B60820
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cWxLnJVI
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6385B60820
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 18:27:39 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso2567037a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786991258; x=1787596058;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WpkoLpElAfhUXcpB3iux1Ia/Sk8svPcJMIbnt0FaziM=;
 b=cWxLnJVIjkaUDTn9xkgVKn1GhLRUlj2cGbDpnF8pXah5WLxp2LTNi/nvTH5HiLpyHm
 fi6iopDuB1ILM3NvZ5YUJJvni3OqKhY/OHrTrk1cysOz+ppjezzHGFC6e94Z3Utx7nbc
 NUOWPT2LDKqe4V8YF8EZR0PKMokhMjE3ClatQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786991258; x=1787596058;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WpkoLpElAfhUXcpB3iux1Ia/Sk8svPcJMIbnt0FaziM=;
 b=V+MJG9txKz0pPBRLJZgYXRoMd5zV7e0h3bxQO6uA9f+vej54MjFhKjBn0wP3jjAwp7
 L5lEfW7YTPk0qxNyaS2rFRB8aEIa8IuCh4xrPglW2aiyH6FL+OwrC+j7y/9Ebceu+ew6
 JUqLtX7HzKlnnunzFQrrI+xREuY0/2scO/YbFWt6p8K38I3fr3Wr7T6xViAA0Mt1GdMo
 KuC1Z0+ZXh8oNlGPb3IP3K/kaS1iRqcHEuEFbIzha4xgD2LNlq+/lTyZHeQiZowhbKNR
 j3rvzCvYTER9YpPJ6j/Z0VziLDC6oEigxBvENB4NrSOSBDKmjQNUezNjJEOwJBfxX+32
 jwCw==
X-Gm-Message-State: AOJu0YwaueSEqn2+/Oxr3Mr59iF8W3dHJmeYty2qXZqtvsllSNMKnFm8
 EMCDh7T5PIZzeKQ1WvfQaSwGnqnZUWn546pm0GzrM47ECrqFibLuHl6JHXd5BTrZiJw=
X-Gm-Gg: AR+sD131Db2vsGqFDGbBn79RlGybm9v6XMixYjTm+DS7dTtyUzfYYiG2AFGfsKNdwC0
 svGL1m0EGQaEPdV62elFwFqgHeo8DqpzZ029GDr5BskwINf0fzELFo1cMHRafjTYJLtgvBWoOjU
 VnES2FpYiglVF2L3TZx2JKshqApbZuIkNbO9IoGswDfcFY8zW/wZDIUGBlLwDGwMKxFpq+Sj4H2
 PRkmIJRUOB04wfk2w1xIliReJSb852xsonkG1PVzeIU0mXm/xFyvEBmseyl63HBm/54akeRrBHn
 +G5LxVE7qy0Ae3qtJjM8/PeFTWrMaMMg42Vxw+w1KIzXagrvOT2t5MSYHseFjQOLbcyizoubnTl
 iCB2LOD2ihDTEVa+kU0VCvnhJbg1XMFNDLel5h4aAGNQhFKC1bIdj5OZYiMr/OpIbVlR9exBnUj
 hz1Y1QyMfD+7dQqtqSgjhpi5O5DcGA5cKJG+UrYTyqD1o7pwqQ2gZbY7sO4Tx9AbGDvnQui2MQ8
 L5DfELmupavb6vNs4Y+5XLqbDWyBCKdLlmFgwg7UgHnm9LsF7/ZVhqb6d26HcbUMD2mDBq59H9K
 GJI/9v6t11Y=
X-Received: by 2002:a05:6830:6687:b0:7e6:e1d2:3bd0 with SMTP id
 46e09a7af769-7f423e93218mr2774700a34.10.1786991258291; 
 Mon, 17 Aug 2026 11:27:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f41c0f35a3sm2032764a34.21.2026.08.17.11.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:27:37 -0700 (PDT)
Date: Mon, 17 Aug 2026 12:27:35 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Brian Sune <briansune@gmail.com>, Tze Yee Ng <tzeyee.ng@altera.com>,
 Peng Fan <peng.fan@nxp.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Subject: Re: [GIT PULL] SoCFPGA updates for next (2026-08-17)
Message-ID: <20260817182735.GQ3297518@bill-the-cat>
References: <cfa5d305-908e-4ab5-8725-47f287fb5e54@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UfcfYuKcvlKtO8wA"
Content-Disposition: inline
In-Reply-To: <cfa5d305-908e-4ab5-8725-47f287fb5e54@altera.com>
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


--UfcfYuKcvlKtO8wA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:29:50AM +0800, Chee, Tien Fong wrote:
> Hi Tom,
>=20
> Please pull the following SoCFPGA updates for next.
>=20
> The following changes since commit 527115ef6783cec49e5610c523c124b3990113=
61:
>=20
>   pylibfdt: Replace removed SWIG Python 2 compatibility macros (2026-08-13
> 10:12:41 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
> tags/u-boot-socfpga-next-20260817

Can you please put this on git.u-boot-project.org? The denx gitlab is
unresponsive at this point for me, thanks.

--=20
Tom

--UfcfYuKcvlKtO8wA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoNShwAKCRAr4qD1Cr/k
CpOJAP994tgIlvxqCobT/3x4P8yyJN/g0fhhVBRH/3I/lzK9kgEAk5HlzsSj2rQu
S3okSQgOBT6Jd/augRlR1J9Lv5XGcgk=
=C4im
-----END PGP SIGNATURE-----

--UfcfYuKcvlKtO8wA--
