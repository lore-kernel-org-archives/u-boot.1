Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EC606A321
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nb8ArpU3;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rfW4B1A9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6592B80BDB;
	Mon, 23 Nov 2026 22:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKsKNhuQaqKw; Mon, 23 Nov 2026 22:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B0ED80ACC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795472241;
	b=Eex8xaRvuXq08oek4pL29ky6LdP1/Inx5lrHpirjy53v/EticjWgooQIxF+itEwyD0kT
	 Pdn6RDsLJFpjalPLaKG6Irz+8u5QDvE98oc2SNVApBWvJoHk3bDl/R7SGQfV87hYHpY0d
	 FqYwrxj0C6YqZyWgoCijpMrivHkUr87Qok6F+182FVH8r64a7X4ki3gzQujGDNZ2NWzk9
	 2qXS0O2LWRHGotOPJz5ffbXXGHgyFj+Agd53eHnfDiFzEs7vZ4leRPDb/PrOQRcpTXgkm
	 a3oonqBxuBhofvyxHDMYoe3kz+kd+b5Zh1CelUS7k3TYCFqzyrW01E6tTpleYNK8eww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795472241;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qbG+U+9vP2DMMXhk4p9LZzoBTCX2xPjUGHmAOnLfwgM=;
	b=Ue+va0PmJyGjjcncVNHwXr5D1fzXIvFqNxw1rsL+In6LYvuxf3pbumFwwwdV/bWobDCk
	 4fehslJkqT8Wgi17bDidukd6VGDh0jn+YRpzZCPpqJ609sN8zNUmEEO41Xqei1AjeI6fA
	 U7zxXh4mqK5WMfl3go6HY8QJhOmStzDBQceM1t70BR9EMssbHV27Lszaeuq3dJosDmoof
	 w/lqkxtB2kdORGgnnj0D16jHN9G4Vwkt6H+iPaCh/CvIQrnSsG657VJsOpRzudz8k2hRx
	 HwSrMleaQmAImGzB0V0W8bQiIs+NKwODM/ZuJ98KhVclJYkDrvSewqTk5v2FpqYjg+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795472241;
	bh=qbG+U+9vP2DMMXhk4p9LZzoBTCX2xPjUGHmAOnLfwgM=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nb8ArpU3LnVBoFo3Ghs0LwgDifpiz2LqW2Xi2mrLC1Cb/AtDnvPWWeEReaEghoPFP
	 o1rpcyJtax2N1l2PeeLiijkyUNzSXP7XTwVSEabgqrtR82Hjp9/4CsYOcJ17e3/W/p
	 UU/KDvfc2RFdYSMi4SMwEyCadbPfqbGvv5p7vbqjkCRHKaBV73UTrY2QAN5rI2Nul9
	 adQqvK61y4KWekUOiFztPmScfdMbnkzAdbuklTCfm4dvdaNwuBPYqnUgYU4AGCpzxz
	 /0VD17QYo0swyPp01aidq3F9QqWAqTqfslyJrc4MXYKnAQ6SfHYyb2NMU+7HCGxfep
	 0VhESeW0jrbfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B0ED80ACC;
	Mon, 23 Nov 2026 22:17:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86A5C499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C6D140200
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:17:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RA7QVyWHFlE4 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 22:17:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 70E8340024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rfW4B1A9
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70E8340024
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:17:18 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4ad587ba293so2238959fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795472238; x=1796077038;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qbG+U+9vP2DMMXhk4p9LZzoBTCX2xPjUGHmAOnLfwgM=;
 b=rfW4B1A90LWwFLasmfReTNUo8wE8QY33bOTcMsFvcSEzZn4CKtlZK6d0/QcD/1A9DN
 Gvqn9G/uQqxlPwEumD1CmwRTM1TZr8T51pWBcRJYWNQmKUpSNMQW/1wq+8q97OifI12g
 wVKe0akHSiAkLX36QvamFgFMDgzV1Wfib5QL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795472238; x=1796077038;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qbG+U+9vP2DMMXhk4p9LZzoBTCX2xPjUGHmAOnLfwgM=;
 b=1BLoZjQomnq4hUO7npL3tCAW1JahH5kzABHrh/DeUrY5qOXJzMaDZLTqdq866ihJdq
 VDq1gx2EDeUerdMekh1WLZ7tlLKZzMdU6iugaWRvVLZ/2VImPXnhtwMeo47U12MoncNN
 mGGO+vVTDDu4A7NW9Y+b0QwZtj+xsVNZUorEuyevTjtyJeDKnsegxCp1EU/Rsh+FheZN
 qYKfI8VBgUyloUoWSUZy6bV5Zg6EG9jKiDHwiy6LtxjnPmfZIiAZHhpntgJBDH4pbzkg
 bpqv59SYhqiyMKkuEFB9Hk/H+w9909Y5s6Q/5eatKbPeIj6o0mQyZnnvtUFsZtCIelcN
 EGAQ==
X-Gm-Message-State: APuU4Z/1GIgnwVTsH40n1oOZ+GeLx/J/CLcx0Z5usK3qRHRmV6qy1JQi
 wIBg5FtnNFiKRHDsaBkn4+j3gjrc7SfWKV5uBU/wYEKbi+33QcVxc/dSaRjnTKKXqwpRM+cVMpI
 6ugtiqky5FmbH
X-Gm-Gg: AZFdTZcNXW7K7UuOWArBB/QAXWU8lVf1J7IedbyQH2bEwphfb/Jw4bcLUraj+dGJjLw
 5DFu3mQIF/gKBypW3cc4ut1hBHh9tJPTU095dZTcCoqvlMtA2e5UB6lpk9thzUKxkPlyONysusa
 /0+0oTHIlYJDkhHVnKHuPRbl5oz6ppeqzOpo3JowGC6VGTF8Oc0Ftl0RUN4pJKM/syBkgRE7N3R
 cNFT92oPBRgPKCWN+1O4m2hw1yUC9yLp8ANRNImwV9IctJs2lLqWVB8ItCJ1PEqB6Jx//j5XH7t
 JBcdXlKJ22gq33Li05uRIGPLtpdAwu96ZjPkQgBmhfKjgDgH8S3fQq1n05aqeu8YUIW22KSXhu/
 Hd+HLRoNlIq62ldypu6/bwxRlONW3ECFW1kp/eSiSKEODDUIwQ2CGiyuhLyAVchilPsOJrpRrLi
 E2ucisItRGXjujXYNcG2hN9beNhlkAAoOgBKeOmTImmQ+wXPpniJID/ie3ZTkPIqNfMSNVSj5pQ
 1dRbBrcMTjlrL6nFUE6tzwSCFPC2ujzW2tEvYFUEtW0SBmGy1c1XTRjhNSU+u5idfqoK0YajsW7
 j5S61qnLBcSpaT7+W2mXLQb/t9q7MNu2/HbboqnTRcbkPAYmn2FFk71f4tkGAeaNC4BqmuP2KMB
 oMs3nERnOK1rFHvysEhKe5fN68yxxw4qdSxwE3r8VRNsAix0LjefOEDmRr8UlPvkp3cyyyN+hOw
 w3xbHCXtH+DACvCfS4onBg4mHWPspT6hQ=
X-Received: by 2002:a05:6870:8087:b0:4ad:5e50:9ab3 with SMTP id
 586e51a60fabf-4bc829914afmr12571741fac.21.1795472237855; 
 Mon, 23 Nov 2026 14:17:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5edc52aasm13303377fac.4.2026.11.23.14.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:17:17 -0800 (PST)
Date: Mon, 23 Nov 2026 16:17:15 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2027.01-rc3 released
Message-ID: <20261123221715.GP3176972@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rre1wPOgIe2vM34o"
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--rre1wPOgIe2vM34o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and I have tagged and pushed things out. I'll update
the next branch and push that as well shortly.

In the last release email I asked for help on a code of conduct and also
forming a Technical Steering Committee. I appreciate the feedback we've
gotten thus far on a code of conduct and I suspect the next steps are
figuring out how to answer the harder questions about enforcement. As
for the TSC, I'm hoping for more feedback still. Please see the threads
at:
Code of Conduct:
https://lore.kernel.org/u-boot/20261103172036.GS3309461@bill-the-cat/

Technical Steering Committee:
https://lore.kernel.org/u-boot/20261103172044.GT3309461@bill-the-cat/

I think at this point I can say that my queue is in good shape for
things that are going to the main branch for this release and I'm mainly
pushing things to next. This also means that at this point I am
expecting pull requests to also contain only fixes.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DNjh0Zm=
kzajgyNnZtM3FvMmM1azkzOTAxdXJfMjAyNjEwMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
The meeting details itself are:
November 24th, 2026. 9am (GMT -06:00)

Video call link: https://meet.google.com/hir-pkrc-ngg
Dial: (US) +1 636-707-2454 PIN: 996 784 524#
More phone numbers: https://tel.meet/hir-pkrc-ngg?pin=3D1444832752708

In terms of a rough changelog:
- Platform updates for Qualcomm, airoha, Renesas R-Car, i.MX, TI K3,
  RISC-V, AMD Xilinx.
- Fixes in our networking, DFU, UBI, documentation, USB, i2c, bloblist /
  transferlist, and EFI loader subsystems / drivers.
- We've specifically re-synced lwIP with their version 2.2.1 tag.
- Assorted correctness fixes for imagemap support, RAUC and bootsd, host
  tools on macOS, and pstore support.

I continue to plan to do an rc release every two weeks and the final
release will be 04 January 2027.

Thanks all!

--=20
Tom

--rre1wPOgIe2vM34o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawS7awAKCRAr4qD1Cr/k
Ct2KAQD9VNGPaSlnNjLe4ZwRwQ5QNp+S+0BFq8YvQNXzMN2RyAEAz67TKbJTXXB5
saHcRx3t9UEUAV0sTL64IOQZUhV90AU=
=7wfQ
-----END PGP SIGNATURE-----

--rre1wPOgIe2vM34o--
