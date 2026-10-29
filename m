Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E756606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QNif06Rv;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=L/mHIdzW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1369780D8F;
	Thu, 29 Oct 2026 17:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WsXj1fTXEwvx; Thu, 29 Oct 2026 17:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E6D8E80D1D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295029;
	b=OvQV+GNvARlPneq+xrYBlo5xXC3YhIQoSdl1hZt2grbhHJCoTMLme8pB2sjPcPLoOZAY
	 1y8PYqzpFIU8mTIcGoHGqib7NxjhMAif/d1wK9JJh1A/fES4km8j00vIOSNJHdVWHWTVS
	 IHUAuRBRl7KYkBYPv14PRdp5R9kN9JvEFBoTtSYez4qOG8AgPAw3FydlsWxxoYctAZ8iL
	 KfB8LlxiPGEG7wYu0jiNmpxSbmXLGI5y5QGlOxrWn+UCACvSVaCy3IvGWFPrSb2RG2V2G
	 Ip/TfrxeeJ3Ayf8VigN78TgRxoCdcYSEVdgzL+XgWYc3BbTh8t7iB2qJCtp9c8BpcgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=h9zCdIw2qh/+H9pbESJq3EHA+3u63P3Kjpivpl1EV7E=;
	b=NEcwSHiVSVL1dCvrvC2xtBS1E/x1UIUau2uHD0WCPYT1RzMfFW0FZ29c9VRvxDrNYre5
	 x4+tlcqTSuRRKhYpIduXSZEmp45ctlv5iI6SbxWY2uVzgnsXrg5ZkRPtTjo/R8BMfhAZk
	 W/DuJXtul0puqic8woA3r1WC13syLmTi1oQsw3QGRniDEBM7RsJXidYUQbQCSQP3+zE21
	 WE9Op3xm+BTU8MnFeS2BKPJaQX/x203TprGZeEntwt5BLnpdzi2c/JsiKJQcJatSNngKN
	 LSOW7rGdnBNftaC0gDlKziHqGXiB8O1JyJLDAA6kcD/120Gq3mZU7puxAtxyUHwApKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295029;
	bh=h9zCdIw2qh/+H9pbESJq3EHA+3u63P3Kjpivpl1EV7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QNif06RveBoPzxs6n3KBOqFb0Gz2NRm1/OE9/FVil9JVgqDKOT4zMA5nlEIhYHy6A
	 cxprg0MQ7x/npZ3zL6NdKTyX8+z56Wwbt86fatGUXSPoaACjHHGdRrg0fqomvAB9Jg
	 n5S+XscP0SBDDoKwMQNd4Izf/n0OGKdRq4YI0OEKeUSz7qSF07OAeFtsg2lpCC0Eda
	 tDYqExGH3zSbVaf/21cDl8WHn92UH7Kz1zuD4N5JMgdwmXbMfgf9PKLVJhepyZORew
	 p4ZNSX+gZV62ybuELSgo7tl7uLJGMr70q48vbgerblSNZeZMncdX96QoOcx+fdf4+X
	 3zwtHk9sdGxMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6D8E80D1D;
	Thu, 29 Oct 2026 17:30:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 832331DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7508A60A5D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KxuqjS4Nqftm for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5ECF460679
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295026;
 b=ZN1ya+dQPA2pjYMjYzGNu5eyb9hCWNIvfh0ZkHsn/k3yw5rBzcHby9y36VCMRMKd6koK
 arpTz25BmmckyxmHk1A4LlovQOaWI0B6efuzVPZj3L+UOXoFe6TGxnOvJ4ZJobqZUad/g
 D4c2HwgZ2s74V/hLudpGXQwLBhbvjeI45/14U57CB6XuYP3pgzZ70wwjpOTHtD4/cTAsn
 V+zAhACwmshlDxcpAs6OoDLmxC3vx46c5z+OXexyFtRF0dxOYiZzreALam1GGHv3GTuzJ
 Ay8JjcN4E8597krQIHXgB5ipVQi5vRTD/qeKyYXZvb+BKEuvenf8BeI8lOwNE/Kk4fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295026;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=h9zCdIw2qh/+H9pbESJq3EHA+3u63P3Kjpivpl1EV7E=;
 b=cinjWzhbPw9ZbuRG/hkXNodM0iPo3i7D3fl834DFpqERg/ka8QCkp7tpLLdPDq2ZrJFP
 gZSifKdYfHoBI9SctN3E9eSDJMstJs4d9Yb0u8fEZWBCmYlvs0MUA3awIS3imsbiP/Zd9
 NtkD1D0Im8haO+gxmTTD4uzApvMXnPsje7bXj4/G4giXWg6Vh9jK3zAU8xjPTIsDaJfTv
 T/2pHLVBCAvlkxL92ebHA/uOLRHLv9zwU+kkwZ8Bc+vxenyIGH8fE3OkMWwzrTKIHG1l1
 UiQcwhruihYCU6MPSiwD0hxARy2v/6gfcqUQW7Hpzc2GAGSIqQ49qBNFWIhG3MykYPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="L/mHIdzW"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::1;
 helo=mail-oo2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=L/mHIdzW
Received: from mail-oo2-x01.google.com (mail-oo2-x01.google.com
 [IPv6:2607:f8b0:4864:31::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5ECF460679
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:30:25 +0000 (UTC)
Received: by mail-oo2-x01.google.com with SMTP id
 006d021491bc7-703c8927a65so1084924eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793295025; x=1793899825;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h9zCdIw2qh/+H9pbESJq3EHA+3u63P3Kjpivpl1EV7E=;
 b=L/mHIdzWTZ/2UmbRONTwOKdz4+BMx3r3c6VRB5Q7bRVngfsy1t/Pv9cSDKM1lglzCB
 okJmte4fiKyDVsF+5PcBrPE/MrkETBRyaWzVgXIqJPzMIzV2O4jD+XLWku2hnWvouqw7
 UXkLDKaEeljJFScI4zJiORZ6udyJ//SDurWDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295025; x=1793899825;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h9zCdIw2qh/+H9pbESJq3EHA+3u63P3Kjpivpl1EV7E=;
 b=2pbTeaANtnyRWIfNHVGHCZ4mfsAg7jUqtYKVSY0MxVr25w5DuFSP0PQalwzh7Bt++T
 /G+KbYqoHqHr1PljqbyvU9fj81HataVOp5asm/MYsZGfolSblvIL/Y7d0og592p1sYb9
 AbqQldoGh7XbBXdR5kgYFO78lgoo6YNt4fkrJq52IFxDYGyape4iMeLy0ZVs1HRyejgT
 fCwg5H9ukfC6wEOxK0pz1hnPNbzOLKdlqCm84HscP2KLbc7AWcbfB4UC5zimY9xgW2OF
 DF53cfe4hGuTKvfsAVrL7yHRaVJ+sOkNFq1BQfN2vNkbFkDkxItoJs80spWz2a9so7w7
 XfQQ==
X-Gm-Message-State: AFq9FYLJQwfqE2t2WQV/SxQ3ncCKrBcnzHXsskHaufosMassFfeHzZRf
 12buaObHEJnPGKBPnEGPAcP1dfNttxaIRwOeApI3qj/R+ojVKeRTfPFVlJ7EEnoThPw=
X-Gm-Gg: AYBFou1VhbEgIGxV0cBzwVrYM96tcVrbwsXMGv7dUT+0lAz+eg0424OA9/+/yU4uWpr
 6VqfmxaS58KIF0KklhktjuO9rIHvdAumErxFNPkU3+qeqcGs87n8isprbQYzQO+y7fWnSbk3vfm
 Ywe220xeTNKlFJbz4w+VQDsOhD9uMqCTQwlSsc1A9nuy0T0kalBK6LZ/7F949NT+vERoWCpXuKY
 FqZ5/DgMb8xxftHjfIX/2OX9gZ9honu2a4coIpZwZVWKHsyZG3dSg8boo5K8RMyqgEq/EOHTNbT
 padmGkdxnkvPs7lPgNsSmMLweGQdYnSeQ7xIqMYF6Nc9g8CmqYFDTVhTfF/fVJvyoQ2lxt790YV
 8JqokDG6HSCa2UhOtzM4IxfkDqQrqO13Bobf1Vu7Kr+kYKmt9nIlvs9u/Hb7xyIWez64S0Qfh0Y
 guQGhrXwzFlV1P0RMoJIa5ZcI5IIDE2e60evhnpzOQgYYh0DAqp8FyXcYw85n+Nl//Ih85zkiHW
 IjZh0FcjPmoLv8201Fr1CcPl//JASQTI6eFv6FJtHNTD8V5d9X4EtoeEdGRXg46XmYfGPexV2jC
 EzJyiGD9R60MYY2p4cfs1g78JYtZSE3zu+j1rIXa5Wqwpa3Fcb6YkooAoDVoQLjHC2HzN1FHi+V
 01Qg9REAwFjX/AJByHP2hF7wo8bB/GtNWhrrYIArsUHhy9SV0vRxCJYIQ1GOm2ckL101o1CNQR6
 atUmKzFVayP6ddZ8YAuhPrTKMbS3kvgEY=
X-Received: by 2002:a05:6820:1608:b0:708:a0da:e54b with SMTP id
 006d021491bc7-713eaf5af6dmr4393898eaf.13.1793295024806; 
 Thu, 29 Oct 2026 10:30:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545bfebsm72719a34.4.2026.10.29.10.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:30:24 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:30:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] macOS improvements
Message-ID: <20261029173022.GC3011578@bill-the-cat>
References: <20261028121258.572-1-pepe.schlehofer@gmail.com>
 <20261028181244.GD2677024@bill-the-cat>
 <CABPHAJweoMq-H+yQV_vzhbEx1=RXcYxxqz=_qoHPqKtV3ncWQg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="if6KwE378DwbNRL5"
Content-Disposition: inline
In-Reply-To: <CABPHAJweoMq-H+yQV_vzhbEx1=RXcYxxqz=_qoHPqKtV3ncWQg@mail.gmail.com>
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


--if6KwE378DwbNRL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 07:36:22PM +0100, Josef Schlehofer wrote:

> No, the issue should be there with macos-14 too. You just don't hit it
> because tools-only_defconfig doesn't build the two things that break:
>=20
> a) kwboot is only built with CONFIG_ARCH_MVEBU or CONFIG_ARCH_KIRKWOOD,
>    and tools-only_defconfig has neither.
>=20
> b) The same goes for crc8.c. It's only used by gen_ethaddr_crc, which
>    needs CONFIG_CMD_NET, and that's not enabled in tools-only_defconfig
>    either.
>=20
> I hit both with HOST_TOOLS_ALL=3Dy, which turns these on.
>=20
> To be honest, I haven't tried macos-14.

Ah, OK. Would you mind testing your series on top of
https://patchwork.ozlabs.org/project/uboot/patch/20261028222745.2775066-1-t=
rini@konsulko.com/
And then a follow-up to your current series to make that test we have
build more, so we would have caught this? Thanks!

--=20
Tom

--if6KwE378DwbNRL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauOCrQAKCRAr4qD1Cr/k
CooSAPkBlOJ5Pz4edEa4J2hhE0wfvQ65Ex/yg05xlKmQHgcPRgD/dgqbeIwvRp5/
lSRWPT32CXn/HF+2iIX0KcLP11fQJgA=
=kb8V
-----END PGP SIGNATURE-----

--if6KwE378DwbNRL5--
