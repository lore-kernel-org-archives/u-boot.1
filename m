Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D7C606D831
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ag2fPb89;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VX4vCLbo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EDED40954;
	Wed,  4 Nov 2026 19:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kRMYVKY-AGZs; Wed,  4 Nov 2026 19:57:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 676094093C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793822260;
	b=exQ/RwqZoyILiP74h7Nl42TbEesiZb0dl/JmMN3VGkt976L38ImOhn7EXnyykd6vZaxj
	 W+vo3KgL+0WHyzHvEXB3YOTqdq3gzkGQhHiXM/9lHxc+hYU2bnPxbZEsuS/yKXG6lLb/2
	 4C8Mrc1pseZmF270mID1Jkl5mMdPqg6SimJxXIC60njoIdeLniPPIntlG7LfFEab506u5
	 Gv2l83uEoUvQDhhWVnfV3lTfaCx6cupMbx3Iz+ECv9qxuf+bk2DpVmrryEAuU32MtAf+t
	 IbhlBCf8gfFZ8gF9q2QVUjm0roLjfm4p4k6M5zXhoFDlYzfsAvgIR7n2T2b3pT9vnYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793822260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=msh1X9W4Mj8qpN0x257boBiXmDx+FnFgyr6K8vG3ZfQ=;
	b=kUJ6+iQ/9l/e0xKpYYE861hXm3N6gNnQ1nfFIzXu7Eb0KTS65NFjvz5w8yt/UBFDdexx
	 +dZJ0jGjv8KhBOHU0PwvUzM/sAhgz8ivTPg7REqro9qHjTY1iLhQHWk6/irJHMLiixTBm
	 6q33iDAMCVVW7vkz36rXwgONSIbNAW5qTeA34PigUwWh23DuCfm2Y3WDYqM9sYtjbaVmE
	 /9E3u4Clf87J3Z8VsReHIw76H16t++gecEkY3FMkpRyZNQlHpi5kmXQsUKKtXPUe5BZVC
	 oKpACH4+/Ta1rFpys10bqaTKVgGunPAbT27U6+qIT3ugJ5ZiQIz0b2KwBD635JDWTCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VX4vCLbo;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793822260;
	bh=msh1X9W4Mj8qpN0x257boBiXmDx+FnFgyr6K8vG3ZfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ag2fPb895GHxpTJJT8Em6jkiYOT1BzrJnI8XK3pBXtUngCmSMSfdkG09ALW9a5uBI
	 ntSMwQDKL9Zb3F7W437OKL+3VPBIsWAKSLUv1YHO9+W0lDNZpifYyxkaGPFwIthgSE
	 ZxwBMR+CSGACwxVZHMwgG6QGKNb24dkGcrYzD4OOeq9YNY5WKvbR5Rk5UVip2g93L6
	 PLMNIFOHjgwjg9eC1JJ8L8Inu7WEwlS7QYTjr7l2VHEGa2glIXMBuizXCgeUfbnyQQ
	 eFnvEfck5lhA1+fwqOFBk3mtfTJEvHnzDQ4XIbx7IWjFvaOQKKn/4z4JRCdeu9iHlp
	 3NrBFRCjQs+dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 676094093C;
	Wed,  4 Nov 2026 19:57:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A1959177B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92A864093C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hSWoTYwH7Wcw for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 19:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5F1C40885
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VX4vCLbo
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5F1C40885
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:57:38 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-84d5e56f876so724907a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 11:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793822257; x=1794427057;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=msh1X9W4Mj8qpN0x257boBiXmDx+FnFgyr6K8vG3ZfQ=;
 b=VX4vCLboHAUTMYkLPKXkuCtNJ7AUJ3aE/LWQiw1N2HCANOcx6s89ZLwJB/AvwilPyX
 zqQcv1n6DuW9BsRqz2aWo+srt8jYflKpJ3dpno9UEDFDcllf5QVNLIJnEOM72Zca8FRv
 So2u+Cj00i+2ICDKUz9k6s7IbaGti4MyjQmU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793822257; x=1794427057;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=msh1X9W4Mj8qpN0x257boBiXmDx+FnFgyr6K8vG3ZfQ=;
 b=A2aJlyTMy4drwVLVIgc14boz4Vz8a/Q3gcjXfH5E+gAk596VPau1shXguziZIq8wXI
 hVPZps3LCP+ND5FAptOIZ2pN5xfotq1VrQ1iU3h42bR0UjlfIvOCYgfLRNc+KWRZ4xur
 V+sao0C0dLVLpPEY/gN55z95uki06QTWfz7BVDLc8mpEMLA5njhFratEaxtP8pUj0JUy
 YJFjttod+svGuXqktCMqUeyiowbg6FqUPza49FqcEb7k32OMTNuGEZ2PYZp9/7tia33h
 fXD5fBMVPmtBqzZIpoKv8AGuFEGrgXQESQQ84mqsXDoF7yqzMOwGQ5ky9xjbCrqjBSlR
 dLlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwftbn1XYQMpShZNN0aep/brfb/3TXOnYx1BOOuAz6fppfph6DocOvKZSwn+yjxRvbylFvG2QA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z94O6acPeUNNBBQiqaj84Q5Hw6yj51actRoN+wNTJoTJyO2oYCI
 36h9IwyBtHyiV4NggVNBa9HvhwhwFLYs55BlTVNFLNpk4g0gcKrklnZaZzmAkEnSz5s=
X-Gm-Gg: AYBFou30muCQMOXKnkGbJstIyCvXCxDAzGg+7tcTQVcfQNGG/5w+xcTo2+DdG2us7mQ
 RiZJCY45HWh9/elkr9kgIZIQ2s4X2wcgR/e0CwOWiKHPrdGq0R+gdPKxikqs9m8qYR+WuwzSBGu
 LudS6iNRDk4Og95088JXMOgTMSu8L+94JyR6latBHtQEhvuURKwuZhlw0KeNb7yDEywL57zSBn7
 UgQPuHVtkN/cwimKWFW3Cey+0Z0WwB6b8uJCjsIdS/gweLev6NyIlBINmlnYaC05J11yfblN4P3
 bcQ13QDx69pbb9ENsZ2ioCySQH4/krogIIGLXCl1iLDXc2gfoVDDQ9c7CEZbE8KWFm9KRMBzc5S
 zJlT9MdcFJfQfCtJ6olJUNE/eV38tQ0krtOaGFdfOOC9+wZARVGrPRdBJemkJ4bADrq8dJmOGrq
 sMMVVUq6MrgNeedYPajdiC/erTQ27U1EWgzWUnZ4a4PXNwKLJQN6zvRYHN0xJ//VqiBNkug9JsG
 RQIuDxLtHeGV7NzIFOgOCQYQJ95arv3b1lg+NdLgOrs2cPqVibgD9Yh4pBfyddW1366VfMbmu3h
 +9VSGsge2VKCGxago9TEvvP0gRuxpCFlnGamfiVek00hdlMYBC9eMRBpfGT/6lqUd3hkWtURFrk
 84iubmvW0l7ZbaIS01eeE3g3HQ8yKR4joX+UZ/KMj4anCS3IQp5Mr5AVpToIcKC5t3m+PouocuC
 1GdLQVkl17SOa0N778AIX8jHqtZIN2tw==
X-Received: by 2002:a05:6830:43a9:b0:85a:e0c5:dc91 with SMTP id
 46e09a7af769-85d363c506amr13795736a34.16.1793822256997; 
 Wed, 04 Nov 2026 11:57:36 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3a1da87sm2688100a34.3.2026.11.04.11.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:57:36 -0800 (PST)
Date: Wed, 4 Nov 2026 13:57:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] dm: core: Unlink the device when bind fails without
 DM_DEVICE_REMOVE
Message-ID: <20261104195734.GF1164024@bill-the-cat>
References: <20261026030925.1002846-1-oss.patchbox@gmail.com>
 <20261103193614.1250525-1-oss.patchbox@gmail.com>
 <20261103202219.GB785819@bill-the-cat>
 <CAGG=RgBCeZca+58O1qsK2_tj3MZNVdZEw29WEA9SG5BVwXCKXw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="13OaUjDENIJCUfGC"
Content-Disposition: inline
In-Reply-To: <CAGG=RgBCeZca+58O1qsK2_tj3MZNVdZEw29WEA9SG5BVwXCKXw@mail.gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--13OaUjDENIJCUfGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 05:44:09PM -0500, Yuho Choi wrote:
> On Tue, 3 Nov 2026 at 15:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > We're sensitive in SPL to size growth and it's ~500 boards that have
> > SPL_DM=3Dy SPL_DM_DEVICE_REMOVE=3Dn. There's also the expectation that =
in
> > SPL things may not always be as robust, since it's going for just enough
> > to get U-Boot itself running. So what was the real case that v1 didn't
> > solve again exactly? Or was it just a code-cleanup that Simon was asking
> > for? Thanks.
>=20
> Hi Tom,
>=20
> I appreciate your review.
>=20
> Yes, v2 is just the clean-up Simon asked for. v1 and v2 behave the
> same: both take the device off the uclass and sibling lists
> unconditionally. v2 only calls uclass_unbind_device() instead of
> open-coding the list_del().
>=20
> I also don't have a real SPL case. I found it during ongoing research,
> through static analysis and code inspection, not from a failure on a
> board. The only reproduction I have is sandbox U-Boot proper built
> with DM_DEVICE_REMOVE disabled, with the multimatch-test node
> in test.dts.
>=20
> I didn't weigh the size cost against the number of SPL boards it
> affects. Rebuilding xilinx_zynq_virt, SPL grows by 58 bytes with v1
> and by 64 bytes of text with v2, so the 70 in my note was off.
>=20
> If that is not worth it for SPL, I'm fine with dropping the patch.

Thanks, I think we'll just defer this then until / unless someone runs
in to this as a problem on real hardware.

--=20
Tom

--13OaUjDENIJCUfGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauuOJgAKCRAr4qD1Cr/k
CgaFAPoDkRravyzpdeSubnq/Z3YJrF/jy7UkbgW+mJ/a1tswaQD+P9sq3QqNTl/X
qd7Lr4WhxJq89Lv71ju/CQ3xI9yZzgU=
=pS/d
-----END PGP SIGNATURE-----

--13OaUjDENIJCUfGC--
