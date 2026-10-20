Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF4D606A33C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BgHcSGgR;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=mLPeg6fZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C53E4087B;
	Tue, 20 Oct 2026 16:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVHcEMsK-UCK; Tue, 20 Oct 2026 16:57:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ABCE340688
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515460;
	b=T1g/GamsLuSPWK2AkF6MzdKl6P+z+k/rXC2ieUOxZSJ6WwHmpuza5I3QTQC4C43yE5uR
	 ImNkD8rDgxHmR/srUpSR8KkXk3mh2lmmhyz0v3vANdZ+1fJ0p5f46tML37eHsMkpyGWLK
	 eW89or58q2kBjuNPcLNtA7fl8fHV9smxZ4rF2rmN8LS4dwL8LVBYQLk1kCPYmQBRywRBg
	 0WpG6qsroUF4fahx/oAJNQNYstJ4CSjybcYXaDS3bv3xTyE/jLkUEt1OipLFQkisLa8BS
	 dFKuurdXX8vMFgacUhhlCOpjrNzwItwqFNw7KIkcih6p+wJIKqSHO2nfWjK6fV02X1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792515460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Azaes9GHIrO+s0FjEbl/PvHqZRoVOJlBnBrXm9IIxGI=;
	b=F47Uf4cvWD06O/UFb80Kmkztnobo8hrZMg0v0DRzHQarqVY/5nQHANIsZUP/kAkbNPXA
	 aPThlwZMKk0tcZHJfvimHlnKoEgK6zFGLnTQxykX0FqudM3nYAtTdMNevdl6kj54WoFZA
	 VNk4Pk9X5VoRtj9NYT8oBeJjbaZ/e916EG8aC0By359oZ5AG7JAhB0cr1cvmifUm9j8Pv
	 7SSyBieusWkSt49aE25darPfBj5VsV6UD74fNONokLrPjk/DiTSjPAK2hJpLVCDtxg4Kp
	 xjClRytBb06LoYV0OUz+mCwiZoZz1Xrf5Fz2OfKOhxX+DstQTajtpAtIwOEUUud7bNQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792515460;
	bh=Azaes9GHIrO+s0FjEbl/PvHqZRoVOJlBnBrXm9IIxGI=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BgHcSGgREVLujVK9O9FGoHdnJ38SzFqWurggQ27kwAte1zg7TanUg4ebraKZl5cUZ
	 jGwNes3wCfL5iyUYUgfbV8d/Ar4bwzcXxhLMp42OhwCoQp5GO/0C8EpvlHNJowMD/q
	 vyElynfNS3/2Si2LDTa9EjmXwoeC9TnQuIi8Hg0GWDRcHAtk86SlsYqQL8luVsydzE
	 nPxp3SrwedCWwULon9Jc9LV2/umz+OJU1eGqf2AOBzTz07B5thGaMN5tc/1kLAiTiz
	 VNAKQJRTYYUNz6PnfFaoIjvYKtuJ8EZRxs2X6qKUOyOd9xzKgA6j8ISiPHjM/BqMux
	 qsczDfnMnoJzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABCE340688;
	Tue, 20 Oct 2026 16:57:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF1B0930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0337607B8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6yiuBO1pMAi for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:57:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2635D6078A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792515458;
 b=NEfYIT4ztArQiyrNDwHJEq9f67zds5OvIq1LskvGX/Yh4mDQMVPpK12hnACDKuUFwfUV
 tH4LY1My23tg1CVSRGaiS+hoETR4No+181Ucn0gVvNw9pVtjXK4bM7VK3CMHyIOIEO3+Z
 xF74gU5MXEy+M8+VWj/vTBBtFxYR/+Dq7OsSSg0zhmV7C8ExXDpIVR4zETJqLZWG0f1EN
 4xH6rMZWGcgvY0m6p34sBtvZxIhp6mT30W3ecggHJA2hdqL7pQYFeZvY0GOaH18WEBONz
 mjrpObuv3EdlsUPvOVVRGNGbnx0RyoqaSEs2e4WRZ/4sa4oeXQRm7sjTf4AowsUnUTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792515458;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Subject:
 Message-ID:MIME-Version:Content-Type:Content-Disposition:
 X-Clacks-Overhead;
 bh=Azaes9GHIrO+s0FjEbl/PvHqZRoVOJlBnBrXm9IIxGI=;
 b=YokK1X+HiOLuulhzUjuI+10hAgQ10gaFaaJIEm+bRKA9KZti3nZkx6eXtZqoM6ozo3Bh
 RDWfLvEFvlsdPgcQoPN1xjccj2Vuv/ZXhrenrIW3cmQRCEQhbH66hbB+tFjIwXJcGbXpm
 6kTMB8RmkM++0Nrf0oTeH43CNMZwguTQopLjLO4LkU3+p7Rnv7fW2ITyxR3wRKLTHJVaW
 ZfW/eqdQzoAlE7hgOySrxw65ReN7sAnSk2u/SVfYD/xMP2ile/o+AI+I1AtMOXQZWADGi
 gElR/r69+GKuQaVf8YKiPLuexf1AhvrmpYvFeQ0/dVagnNyDPpgqyXpCZz+YmHXayKg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mLPeg6fZ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mLPeg6fZ
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2635D6078A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:57:37 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6faddda49e7so3008689eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792515456; x=1793120256;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Azaes9GHIrO+s0FjEbl/PvHqZRoVOJlBnBrXm9IIxGI=;
 b=mLPeg6fZYhdFPUV0PPkKGgSBBFryysCKVm2B9M8Mgw0DHeKeBDh2xzAqcpenczshK7
 emrJw2Ilb2Gp5sMCeGjRAujLeKMGCTzDFg2zya+MxD7i4TbxNmAlgrrgLpAWfpM6gWnB
 8R/dRRkKlguOOqE5ydUUgcmhU782xddRSIDUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792515456; x=1793120256;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Azaes9GHIrO+s0FjEbl/PvHqZRoVOJlBnBrXm9IIxGI=;
 b=B5yejlDSI6RyezW6+81B7LXMT21pd4L0uUtjFjivlKrae1P70ZYulhIBG+g2an0KnT
 neamdZ6++5Gzevunv6QYinYv5ekIY99yAoxRRCSTOcIS4vsllvyaOQnBSWJYIc4j5jxH
 Bc2/h+TAs0izpTWOk++uHYdhQIvkOjGr/dNL5PLuJfLHzxXiSXAbFwUWOzazI3M0P4Qp
 kNU6+JVLYnjnrmLeaYgHbwq86XCg0mQ9U48AiZtpcCc0H/yDoigoKTDgma0/MKrp7MpU
 QnUaXj8/MlfDiyIEvM8MZBpIiUbDvC1O7FViLcn3loIplJhRxeKNYGwYd9qU9WiCAC8n
 ltCg==
X-Gm-Message-State: AFq9FYI5HffnROIqzarOTL0rtnJFkj2ikYh/pZTpqvRqTynUmfbnHLCM
 2ajuBYeMv6l2DeoKH8dceN1dszHgaaPc+R+jqTvziZZQnWvPlQ33DshCkCGcJ+uOdi34v04wggH
 iDYC6STW6sJ0k
X-Gm-Gg: AYBFou1ZKOV0lTDaQlzBmp4BC8u7D00Pxv+PoAay346TEYBMl4mtJ8G0gjQkgDyzEs+
 7fNt5DOAIcOhLKf2T9Oqgxy/0IT/9qNUiogs0ZaFAUXdfiFHgE9HtHGPmCNKuMd6kawFsjcHeWh
 vR4jopWZ5Bk6oPzi/Z2+uMD487ij9iTLcqRqu3j3UUNeFeKfX3my8WJK9j3kaJW0Q8y1fGhyTIf
 Iiwd4w3KP0Tq5YOMoIq/Zzvv/iOzSAZTFG1G38ayyB3d14vH37Mdccp78tl52/IlIZ5ZVB6XTwt
 bXDwkKNxasKe32Lhfg3U/kzYuGOoC7E0ManN0gS17iCr7ZhRnE+4rPVcdoqaSOIWaCN6BSqwd9f
 3MH0zV8aU5LWb5MfVdZ0TnK7bVLheDwJ1N+hl0Tn0+Lv1C+Or3vtvxy79mFPcsqdQyCsx7e/3Oc
 y1JGzF+EcfgwuY1L8YjqaXm88QEfWrTo31PnTU09C75vX/GB9/FoyoNK0AkEwhvBZ+P/+DCnpu+
 Z/CI8fJzwD2s5etOqmytciUr+v41ubDJfWiF4TH8iM1k05Xab/1Qq5Pr5k3gjOfIusdnp/DlQVG
 VPutS9OfO1RhZwkNUpQ=
X-Received: by 2002:a05:6820:1608:b0:6b7:46fc:1e6 with SMTP id
 006d021491bc7-70357898ab8mr8871591eaf.69.1792515456597; 
 Tue, 20 Oct 2026 09:57:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d622c09bsm836fac.17.2026.10.20.09.57.35
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:57:36 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:57:34 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [ANN] Update to v7.3-dts complete
Message-ID: <20261020165734.GI720525@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KNvOm6/iIvnVhE9o"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--KNvOm6/iIvnVhE9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Just letting everyone know that I've updated the main branch to the
v7.3-dts tag in devicetree-rebasing now.

--=20
Tom

--KNvOm6/iIvnVhE9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatedegAKCRAr4qD1Cr/k
CrTaAQDOdtd7pCGIOPus1n2yAeYL97rtaMpkspJtaKBBUYJDrwD/QaDOMUMsZpuM
tI14duk6b4bzsNYt27aJasbl5sG0PAk=
=DGU/
-----END PGP SIGNATURE-----

--KNvOm6/iIvnVhE9o--
