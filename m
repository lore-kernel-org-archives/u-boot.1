Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440C1C61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5546606F8;
	Tue, 25 Aug 2026 17:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q6jxL4Ss0h9Y; Tue, 25 Aug 2026 17:35:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787679315;
	bh=6EeroGkQofDJCFcZrJbj7j5pXL4dc/ACvrzvTq3ei1c=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BaDCNPkeOFyYVyKvStaCoPnmEGsJBQqWQgEbFbxDQDm1+CO6b0PwAAsNd4WgrAuv6
	 ljq8F8dArX5dI3wHexMLKqJErxsOx/wnClFVRYVXg4m31vjzzWi4r1QutRl5jdB1rL
	 Z/7Y0v9qLjd9oSoWC893mVYFv9lj4uM78X1zVJfo2iPQ0fldeNc1DOkNAZx6Od41wS
	 Pw3Dc4OMOTNKLE3pk5UjU/reSEuAQe0k+7lR7QvV4hqjcrcrxMQLMEQ2PjkUi8KXBY
	 6JG/gPIoZvx3PZ4J4q20Zi6O+oveUAmU8k9YK2NWr4eRIsH8y3GrJoqNVDFEFqxVYx
	 VEDqHjQrUhF9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91AFB606E5;
	Tue, 25 Aug 2026 17:35:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC6AB23E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2ECE40542
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YEOHUXz_PzWt for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:35:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b0hSRpIj
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F04154054D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:35:11 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso37218a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787679310; x=1788284110;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6EeroGkQofDJCFcZrJbj7j5pXL4dc/ACvrzvTq3ei1c=;
 b=b0hSRpIjmiXJO27bYF4MgqE/RqSm8eXE2JVh1j+rG3MPenVctn/scOphVPLH3Xx8Ha
 8aM+2M9pPUkKZNXvO562vB+AdEhP+qPkU/wZSdu/gF8SsWgsrHs6kSuMtXe8b4dfuiWj
 aGIbVlVaErtgeN3ikgFh4Y+V62Cs8lhKzibeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787679310; x=1788284110;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6EeroGkQofDJCFcZrJbj7j5pXL4dc/ACvrzvTq3ei1c=;
 b=KALkZ5oORF8BIgixqSDFZmpJEH/5cfdVYJUSEndfDTAthArMipfYlzJ/kjAK5iAofs
 Zpm0JprFBBec/Vkj7Px9/EPufZMgu7+dHHMK0MeE7Zq8o8fPViCEI59tjvhvQujwvYYD
 yMQUyNUWjfht3l6HUS+yUl7fVS+cVDHvm8r37qHQkUYrhcCSSYg1RgMkzWN5HAVsgP85
 dh5ifhfRy970YfGWo3aI4qhb9ReMt96+fUwJd4iTnav/SjflMJLRLLtteb0qjvJ46TaC
 XXAlash9ekoMdNywiDF65kZkjPgqYUVv9dsMaPGi0xtdhUMsKYMusF/XQJw8wvT7dbPs
 Luwg==
X-Gm-Message-State: AFuF++lb/ovk2nxHWFE8/U3QQe/kIGd7d6l81ujnJzovC7kZXFNFiv0T
 B3cF3td35HLdqs+MB2QLhwWig7hO5vFhdJBwgHJlx2FXQwSt2M+Ahly/MVXhbhRWhaTpocHT9eb
 WTpat1cBsWiVZ
X-Gm-Gg: AR+sD13zAOESHc5vcpl6WSQRQLnAmp4HST8ryvuwFCQQqHXYKhZQ6cLsv3PCMegmILL
 JrrWtW9VFZvRKuHcreC+1s5bUskQwhceRlVKNIvLC4OmzG1xItd9C+wbOe50e+TaP7iKTLyCu0+
 OJHBquaMjF5Jy+HXqHU08mCDWAYlOfeUuVxHq8EDsZgGA3lkTMBXocLyuG9XjwvLnN7ugj+CfBQ
 caf0n1DeNeOyhXErftQjwI1IOOsNSXI4tl0liC0Ao0ao4YakMgYdxYuq8G5gdzSF4J95Bklqh5W
 QPm5kRd328ZXhd8QuL2j5lhauiTYRVlnlSOlAo6g0EODWHA4CiJt8Y1lx+Y99ZWhhKycRpzI9sN
 Ako9THqMO7yaPzpDeuOSFdkjob/3ArPRN49v44O+cE5wlGg0jBm+4F+LXNeagyhuBGJyt6Z5wha
 0iAdrpNGqP2OaOBiEcX6bEz1+HmpQNKDP/M++aJHXvLhKhttdmqN6wltxBV/qr2NH2DNkfifnFO
 g/1LPPv/omxUxO8ODdgFBA1u40XG81w5BkMvLwGAeEEgliTAIjE8vt0QQV2UNqRaSHch2+GvAzT
 gQilfP7D/g==
X-Received: by 2002:a05:6830:258c:b0:7f4:c062:7b45 with SMTP id
 46e09a7af769-7f4c4b41f76mr375663a34.1.1787679310520; 
 Tue, 25 Aug 2026 10:35:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c420c31asm149550a34.1.2026.08.25.10.35.09
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:35:09 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:35:07 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: Updated next branch to v7.2-dts tag
Message-ID: <20260825173507.GX523975@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FD4IHsDc6UQH6nWH"
Content-Disposition: inline
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


--FD4IHsDc6UQH6nWH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As per the subject, I've now updated the next branch to the v7.2-dts
tag.

--=20
Tom

--FD4IHsDc6UQH6nWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao3SRwAKCRAr4qD1Cr/k
Cj1HAQCzKwdXc7Ag3xC2qhl8xHKPzfZP/thNAnj95kqddAiwQAEAhkB4q03LShHf
5k2WLUVGZDM7V0t0Ac9Bd/h6u8p/VAk=
=m/3b
-----END PGP SIGNATURE-----

--FD4IHsDc6UQH6nWH--
