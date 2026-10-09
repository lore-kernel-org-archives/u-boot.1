Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F62ECA9EBE
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 21:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E23C281495;
	Fri,  9 Oct 2026 21:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ig2jrvcoL7RX; Fri,  9 Oct 2026 21:55:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4130F8149A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791582946;
	b=BnE8SEl56rlFSNqg2ZJ/EraS1/i/y0e3yly6spMor3LoaOZ56D7DlLYi3icEd9MfDJh9
	 RO9DLXjEUh9ahpEByKy6l3Lc4s7xEog1qsAvPC0jsmdaCs8LhhYoNzKRtc15SGTsOK5OV
	 ua73uH1mCsq/oSwJ4dcuj/KUv8dsa7axHdnT1wbUMVo9qxK8e2vdEHoYDjsPTw09fn7SI
	 JuGPH3OXNZPdRLgEE0rsHDkMZ+9Rw0Zrgj+MfaO5yQ9ehXvQtNpPGad+4FpKxa8zZiO7T
	 z4YTAZe1daNfFuU8j9atHwbAmhzT24DaBXCtrxe15R62Fi7WkkugqFjkr4EoOBRs4nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791582946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Y12FnbTApAASg72kV5UDtuu9E56ReIIH2RCaJwueWKQ=;
	b=LCJoTjs7opqFIX42IDCi8b8s7FplcO2JVvUFXTLq+EkvfagUtqA8sK63KRSut//8rczz
	 NVJVK5pSIRCpCCiqPokyrUOpy0LhEVGLBbQUoFgUE/kcn/S9KGb6swx2lA7u3vRU3cyXF
	 UC3HybUVcxpfQew6VYssE4zZZDfoOmuiTVeaeMh3/DhY0gpiFuwOCOHrfYMhLbzE1u/fF
	 I4zIYhCq4PtarSgmwFMNHOt//SWmdYkjFeIkb6Hv5v1pJM1b0VymG+JddNy6chJTVlwf9
	 34/jSQ2kNjizy8JGyPq/EA3YUK3QeF3RZcJd50SRNZCg5Zri1VlNzY65sRCZvLlgjLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791582946;
	bh=Y12FnbTApAASg72kV5UDtuu9E56ReIIH2RCaJwueWKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fcnsVihIZfwQRM4YxRsMM0yfQSzctKVNPPN7qdnMyx/QnP5zuKeL4uM/kRq6My6m0
	 XWowwaBVVUlGcdqEbXjJBUbRvkAwTmPkg4S4SsyPhsBS4K9V7saWXGqd2VVtltNxLl
	 j40aqJpG4NF2ajHxrEvBYNOG2KQiQ0yV/GNa0EqrljCDdyxjF7LYhu3w3f+mjlsmhh
	 +Y3aQehsm5UB/fPZCzXTeGixAKvEC4TBUdnofQeyaMlf9B7cfxmVleYtakT/3c12b0
	 06ofKrHW1/GKfBtFSf2NxYw8/FOPy/w+Uhwv5Nii+wIVrA70nffi+U7/JJSoqbItwJ
	 uARAbPnhg4/rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4130F8149A;
	Fri,  9 Oct 2026 21:55:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A381E317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 21:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 952AB4009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 21:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id neCahL2VUYp6 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 21:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C212340053
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791582945;
 b=ak1QtwslMapFGmerqoaKIEqYqFbmIUy2lhQnf+FFktpNqDEBdZ0QuNbofUN/hGutUMRk
 PX5FxYUMd2eys6d+C874DwVDcmv/AHSLGj5NmKFYNPKYEpfnm272UlyK0wcqsu3EeK1ET
 YleWLwVzQScD6EowL84eJMlhgnWRlKJszHInVCuytOzEuY2Ifvkym6DDvgeWdsYryoTNt
 /gWtbfthG4BDqRetWpT8gNIQxkwvR2KNlsG4hrVzGasDllq/zTdCFdmKRmu5ddR+HdE79
 mTdRgMVLkfKjgOvyDaps1A4iiwy/gmaUhgNvBAjEYmXRE0UwlUb25nU0rkE/AitCnUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791582945;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=Y12FnbTApAASg72kV5UDtuu9E56ReIIH2RCaJwueWKQ=;
 b=q/olfMVPcuBZvHLFJ1C8u57nMt5gZGYNDud3VBy5tIcM9l/xwZXa6Nk+LQEiBSZ7xQuL
 jJGOGnHzKc8UARWlSLyGOaNsvznh+I1wFg4/SFvQ0ab9GsIvfa1F9583iIRvO9YHvgM3P
 ckj4fHSSdWqk++Xts+2y2dGFzLU7+YGUP67f1azX5ajzKZhhO6QtmwyCn8jQ9+Yy5a4i5
 whYj/m73H3uheeb838SGdwqw6vDJtOUy/8FZ2zJFFCDgaOhaViMotvXDJc9F/JbGTRmCI
 gKG/i/IBj5HfH6qY4vok7WazyJhPY5b2JIhMjndrNGvx6sBso7o9URbIizFgSoyeUKA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uZZKRtXP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uZZKRtXP
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C212340053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 21:55:44 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-8258ac98bc2so201244a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 14:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791582943; x=1792187743;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y12FnbTApAASg72kV5UDtuu9E56ReIIH2RCaJwueWKQ=;
 b=uZZKRtXP39isjctlLXxLDF9uSl58bYNDYBGgX/M5kTtfkIITzeYJtTQxuCLbelFp0h
 r7IxhskcfGw9+534QcUZ8z97o+quztMsZQ+1v7k7zFCl+6s3aDczjlfIthmykxuRDDC8
 oFV3ACuwiD8qmQy1TE/XXo/MkoAnfE770LsPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791582943; x=1792187743;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y12FnbTApAASg72kV5UDtuu9E56ReIIH2RCaJwueWKQ=;
 b=RazqbUTOFHwSUykzexdgqXTOK7RU8EoyL1eVVkoEcKwL4IvDHXJ4yvg7P/KldgjkPP
 AtlsFKaCHenMfL/6clm2gQQDQrA95VW7PPvKdfskwzw4AaU/tcXWtoGbyDEIWnynjiID
 I7fWmprA7/qzx7Y1LLw3kg7Y4Ti4iTV8FeC9Xtn1ur8bfzT4VPdkqthpCkp/0XurQ4O+
 cn8aznDp7HJAdW1w+EbbD3Xm2h8TbeHKMdoTqTfIQ/4FX+7dw3uvCKKAbyitjJRslo/S
 nSbY2laqkEx24TsuQwh3s2S526sCWuUKFZCySDG4HZKfWMDm1u0hc/ZPdhXev9bKtJrW
 66mQ==
X-Gm-Message-State: AFuF++nMyJ2vxhTU4MbVlY9Kv3PPdeNFSmK0eELlakruQytKMg9SNv9A
 yC0YF33xJJxllxzeL6b3sN+qTL8c79dzcIIYeRmGiMGWMceeaKvjXczu8bGxkmm2l0w=
X-Gm-Gg: AYBFou0+xkbrpvOqwMMHM+lPYbQv5HTCebq6UjjVfZS++NZ1hXI7B86xGps7nqhAnIz
 WGmyA+LkduYeiGcYyLEF3/nNTjyKjBCvEePkl0E3+jPp9JO7xipVjyMT6huUmDKTRvrv157Xp2F
 wfANEJ1+B1ru9S1oJIGLjqUJlujPihqANOhE0dnWOSixMGIlZk83oCbvL8GWhaVCqxOrru/Niu6
 zo5vj4FZclr2oZs4oORwl9JMy1BKog+PWr0HDnWwTdBT1/VE2iKVlnMqse1RqMhvJTN5lDnBePN
 lSKzD563Jdf8mKWQeL24XYSglSTDqMzjyD7+amhgDey+Ua7LzLa5iJMJiwTbcyD8KoKgdljHYIQ
 QKNAGsu/m8Sle3Nq3dAiZYwtsvGlzVGPgFdsIWPYslzJMjrQAPUBDWthD4Dq2Sz1iC1TjHUNbTw
 FFIHHSJnQ+YcaYMtry7KFDbzzdVBel7bxUprv46dOZlbAGz2jhAvBfsXCGBGi1+fwxQ9N8asSHW
 EeZubdg7/KEQcceQDODRY+s3jzRowHcpVIYQ6LLOMWF0vKTnYSbH80CcDlI2rdN9u3sfb+mhaYA
 C7faSO9vIYZS2/a3DfU=
X-Received: by 2002:a4a:e848:0:b0:6d9:4c33:6504 with SMTP id
 006d021491bc7-6ef125fdb27mr2519184eaf.68.1791582943451; 
 Fri, 09 Oct 2026 14:55:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6eef6e22b46sm2984834eaf.0.2026.10.09.14.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 14:55:42 -0700 (PDT)
Date: Fri, 9 Oct 2026 15:55:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: u-boot@lists.u-boot-project.org,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Fabio Estevam <festevam@gmail.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Pengpeng Hou <hppiscas@163.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>, Vincent Jardin <vjardin@free.fr>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH 01/26] board: powerpc: Remove MPC8548CDS support
Message-ID: <20261009215538.GG769217@bill-the-cat>
References: <20261009193704.13061-1-brads@mainlining.org>
 <20261009193704.13061-2-brads@mainlining.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FZQigB2HlVRy3omn"
Content-Disposition: inline
In-Reply-To: <20261009193704.13061-2-brads@mainlining.org>
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


--FZQigB2HlVRy3omn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2026 at 07:36:39PM +0000, Bradley Morgan wrote:

> MPC8548 silicon is no longer manufactured, and the MPC8548CDS board is
> obsolete. Remove the board and its SoC support.
>=20
> Signed-off-by: Bradley Morgan <brads@mainlining.org>

So, globally. As has been discussed on IRC already, please take a more
neutral removal message in v2. The problem isn't that the boards aren't
manufactured, it's that (likely) they aren't being actively tested and
maintained in the community. We're fine with "obsolete" hardware if
someone is maintaining it. Also, please rework the CC list (outside the
cover letter) to include the listed board maintainers, and then only
people that have touched the relevant code recently, perhaps with a
manual audit or exclude some global or common files, when looking for
who else to CC. Thanks.

--=20
Tom

--FZQigB2HlVRy3omn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasli1gAKCRAr4qD1Cr/k
Cie3AP9KWG8zTI5UsK5ZRFzDDgqkfcbNad92p3kEcu17XjTTrgEAm0LEaIE9FY/U
SdaaVtEBZsRK5yF1EaqOYR64olLsAAs=
=OoiZ
-----END PGP SIGNATURE-----

--FZQigB2HlVRy3omn--
