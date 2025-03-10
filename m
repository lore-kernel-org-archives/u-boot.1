Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4708CC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 23:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B14806D8;
	Tue, 11 Mar 2025 00:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cdWMhCeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4279E807D9; Tue, 11 Mar 2025 00:46:58 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12622801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 00:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22548a28d0cso25728525ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 16:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741650414; x=1742255214; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p1xBRFwkiJsRPC4G1/KRb0fDlllPyJvcEb8FtmA98+4=;
 b=cdWMhCeuzWVW4ZKt9Wxk+ZH0hc9Qf4HbOEPslaQxfZrw2WtnQgVaz9KSlwDZHronF4
 z9z4T5dgZeQT5aiNXZn5JGZX99VBij6jjDeaJuiWdTeFySFlXd7ChAmnFaEmpg73aS8w
 SAUp4CVZzBDXhJsW8fuORVOJivttW+wynuqzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741650414; x=1742255214;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p1xBRFwkiJsRPC4G1/KRb0fDlllPyJvcEb8FtmA98+4=;
 b=uNh3LqTbQWrY0kxmCbLbI/BxPzi1qWXYIVEMQEj0xuhHPF8kqBd5YlApYWRX7vz6YH
 79M8N9xwQspmmdKNaGNMG+Evoxi3AH/tFAV3+FSWvaigp5UsWfOmvR1tS6ZJbaBltOkc
 VURe3ydtnD51XF5DL7OiJuc7MjB1vEp3AWO26diP36j2ShqZJK0shWcQxC8ZlHSciKW2
 1o1AJQWoxS7Y09w4qGpQMK4jRadIz9uJr93L09W81OUAyMWV8E/GpplaeS+gIQu5pflu
 0wV/f0++/Ite2hbRowdkpj2SnSEcYLj1XWf8kVPW5RJntWO4TkH2cQMo8JaEl8GpLlTp
 S/IQ==
X-Gm-Message-State: AOJu0YzfHP5Lf3JrEFSSosP1d7PZ6qSW3KpjYkELTtkV42vIV7kkfZ+j
 p8nBbqmhorF2cZJRC0mRsJxYbvaqrKmpjddFeSj0OqnymIR7/GAZJs6krgIkPLgH/N11c0+adwr
 0
X-Gm-Gg: ASbGncswb3oci9nBjfri0QPY9r9+pSc5SH+hzKetRVKjmhDlFJM85I6np48pUGiv2UZ
 ky0OQB098YryoypcSnIWOuYAYiwQO9tj7MGcCk1vx1kUSnYZjCx7TK9kVGUi1HLzOU1pMkDRUjL
 r8Jbgu6LAwRM5eViIl2BJvHedShZDWYG2SSWhajnmV8J4mHGZv2+YUlR0pBPdzxE6N7Jr/uV3+W
 INqBahmnSgZstq+DcHFF4+fq4no/KaSkRHs3YWTkiWuQKQS9UYkbjWVVIs0oTqz9hZUeSb+wMGi
 Y3Hd++16iX3fArW5LC7V3GAcpu5LaO/Rd3j6S6IH8C4rqg==
X-Google-Smtp-Source: AGHT+IE+aDvk8guyQmQsD05NX44v0Jg2BpkCq9MUVN8aLWj5NINXEvSvfEPnjPHY20CLJbUGbN+ZGQ==
X-Received: by 2002:a17:903:32ce:b0:220:e655:d77 with SMTP id
 d9443c01a7336-22428bded56mr249493225ad.36.1741650414480; 
 Mon, 10 Mar 2025 16:46:54 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a925ddsm84802175ad.203.2025.03.10.16.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 16:46:53 -0700 (PDT)
Date: Mon, 10 Mar 2025 17:46:51 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Merge of v2025.04-rc4 in to next
Message-ID: <20250310234651.GQ2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZW9gc+gBt22fIpSp"
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


--ZW9gc+gBt22fIpSp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Attempting to merge v2025.04-rc4 in to -next fails on two files. One of
which is common/miiphyutil.c and is easily solved (miiphy_init() goes
away) and then lib/efi_loader/efi_net.c. The latter I need help with,
ideally one of you, as you understand the code in question, sends me the
merged file off-list and I'll drop that in, or points me at a tree with
the merge done and I'll work it out from there. Thanks!

--=20
Tom

--ZW9gc+gBt22fIpSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPeeQACgkQFHw5/5Y0
tywXbAv+Ie4zHWWbtYX8R6OiBICTbqBSxoANLfvKL8CR0hqapG/OGH2ETQtIL0vP
NW3Ic3QN5GMI48Obbr8g2rc3rZkmFZDdd+Ec+LdCXeyQZ+niw8gSJCQytkhX+svH
2Ce+YXkFpO21NMpC2IQ7qBvgFlfqov1odaMB1/vv76exOx6HyjAvP0H4YXgTE5b4
jQf+crE7d0UKmvtPz37Iay+jzJx6G/yGaKM1GSf9ncuPACnQVHJ+W5t0wAEWK6Yc
BTUxU7E/D0HSvYQvfahuPl2OQQt8vLatkXf4SLTpIILmQeh1EReE137JTIAqPNpK
7l5gYKYG3n0Qj/jTw/fUOZH8/1FVFtEWW+DwU68MFnE3l5OnkiZwSo4aPpwC05ll
HJ0mdFMEcI7BEALzc5kgaR/8RXWkLRkeew5OF06Utn+zU9nANp2BJFUuSPczEwZK
S064zrD7bwDVOXrInsd9PiiSCMGl/Odziz6Wmvw5EA2CYyr0W0iGfP/kVHOih4Xm
ssvgG8ue
=c6sv
-----END PGP SIGNATURE-----

--ZW9gc+gBt22fIpSp--
