Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38454606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tOxSyW/X;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Q10zhuzi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7332A40A88;
	Sat, 31 Oct 2026 14:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yj3mGben9LY8; Sat, 31 Oct 2026 14:18:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AFD67406AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793456319;
	b=eAZSQatl2CESru8aFWQ8Mp20MSm1BR6/sO5vYJFPK7y2kDKkSMS8KdqnQgefiVBRhhXF
	 OMpagltQ+sYHQaoCqZe6CsRMffEWyEvdPQikJVvnmffMmhWgg66Uebh5YR8g3G6KgkdA5
	 WKeFsBuQgyC8nrgkqjQUNg+MC17w7l/x6zKaxdMxRMS3Jhfoh6fd0hmHME8eMe4K8JhHJ
	 ESUtrxgfGaAxJAZWb2OeO03tyCOG1I4Ncs8d9mCVQsYIPbPDAFyhqzGZBG4RGO/dD6O2b
	 WawUNYu77ZGRQQf09NodN+zO0elTQPdLEDFd39N00LyX7wrQOqHKLYsu8KxjKe3DV4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793456319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dsBDzNJZUtfM6n3l5fpiGtBsH9lSHryNALS57U32rJ8=;
	b=ZGtcHB3/M3gswnk0K16UP023uvgTPL3TG7P249PAYDwhpRov0rUrkGXLDwMEnaTalKv9
	 hcjdhoLKG8TGy7RaMEly2M/QOfGnO5BsZp7VWeYf/AHzrpB2PtkhJNhkk549Xc99jIIZb
	 nyo03dsdaGPttilteFL1cppok0cgJr5TL8N+2f3FR4sPp09ec/zfm6tuEc+Loth/fCNzA
	 N6ZcVW+vWcm8qOJA9AoLjxfsDZaHp2YFWmiap1e4MNLyaNO4GNTShZgvB/en/7RxL3azU
	 R8YCqFmk3dSJELshWBgFn5hACZBtIGq/bRbO9so+47UvdMxhIYbvD4F8TplHOJPT3qg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793456319;
	bh=dsBDzNJZUtfM6n3l5fpiGtBsH9lSHryNALS57U32rJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tOxSyW/Xyr8MvHxY8Pm1FqLmep/K9c1HrHEEZ9yWRlFHLESOGaaBMm3oJAgIYHgik
	 KmxvRfuy/3zI0jn4chuwvLtRYN9QPMnfeQa21I+ZizyGIW7bo9tZIssMzIPIPrNm0b
	 MbcPTJiEbojaGQmln3pdQi+kkCwtCAf6oD+x0gegdeiytlV4CbxNBwMYLcF0R2ucvE
	 8roQ8CxdkBqev/9vT55yEWCoz6KaxnpXcy5RVMQ4LoWzpxoUI3JpQpQK1cMaesRWpf
	 MCy+/9Z8vs03T1nfoIfe6GFiB1y5kmnRfl5Rf7cidICVanopGINA1W0bTAXpVaAjBN
	 7HytI9gwwGg7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFD67406AB;
	Sat, 31 Oct 2026 14:18:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E05CD411
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C69E780DE2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:18:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26T4xNdjHe0J for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:18:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05FF980D00
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793456317;
 b=LVNGP0NvTtp5GAWAOfwtVgpdWsKgUSltPp020fmndFuj3TGjGetP+bB6LwqrCN/ngXRF
 gt+seJU0wyjygl24Nrfm5NdoXSYOsmkaBIRKWSrjHggQma9aR950kflnQtBoSg97WowO7
 4Mj2XmINew2MlZaGy5S3rO5mso8E391f7LoPwAPmP6nlWW+psmDKI5Dvwj+dcYMMUiYy5
 rDXwxEWSFQA871O4T4S9L629cgHgU09z3G9NZfwcN9e1ybQWvoXo6MK0tVMC/rlmpsFEs
 y1Zqq/rp80JpG7Qu2Sy4bgHSaMrs2JVcaHRDdwzXvdGp9ezHE+2EqpT4BqAsaP1pJSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793456317;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=dsBDzNJZUtfM6n3l5fpiGtBsH9lSHryNALS57U32rJ8=;
 b=Nx3fPJj0lTph7vsZsoy3jwXC9yZm3z4nR/BJQJaiyWwgHjs9cD2sU/zojSDn6StsFlON
 kKmhAsQ0RG/XWsR7gwXaioO8ZhjCRK8SCdS1fNYVIXuufsh/oMnjfkPVE/MhlRTw2F6ew
 9YV9wJED6nxtHsYgd0OAt9q0Jv3J5K7XWGFuI2ZxpZG6KnjVPMSK5UEOXbQ4x3IUdf/pp
 H5NmWxJBBCHTzTfu4BfTD1rgEeGZg50DHFHzddSQQiBhE49XihhMugSyugNZ0PB2YNQnE
 YbGw2FZqnj43ynMhtyQj4ZmkmFoIKcqQgNtcpnjLAFxkWFK8n5HyLxX3aINSHiXKxjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Q10zhuzi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Q10zhuzi
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05FF980D00
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:18:36 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-713e6ecf595so1591378eaf.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793456315; x=1794061115;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dsBDzNJZUtfM6n3l5fpiGtBsH9lSHryNALS57U32rJ8=;
 b=Q10zhuziALGDlVHxcxEIA/q/qxKUG+bDhZrHEXaUYklcvjeukDx72KSOz+vukIUvWE
 N39bMIQvEvIlHbkPWudfJHnujTT+3u0e0EDcRn1CCbJx+gQ8BaSCm15KTx8LxYB8Vq8b
 smYu4F4nVaTw9UMLuZEar1ecZkPMjHn41ndSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793456315; x=1794061115;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dsBDzNJZUtfM6n3l5fpiGtBsH9lSHryNALS57U32rJ8=;
 b=s5ohkkD0YVZBZ4gyOAOgcw9CugIYQDdn3OlJ7KyheweLJrkiJYFuqIiovr7zPO4orH
 s0vkCB6qNpXbDpq1jYCd0AerB4UuBpbRCdHbtJkrpajgK64xcmo/XHozs5Ai/dIQKYqc
 Zej9mfxHB+GxT2G7NTDW4furV+g+KdazKhZ/6g5FvEojY6uAvx4A38pcbq4thFPdhnjw
 xKAY7mdPbARaY81pDIPNKTYPxxg7JbZKL0mMA0VuwZ5u/0LlGBdOdRPuLYUFzX18I5b9
 JYivQCCiiY/+nqaVi9yjtp7IJvM8hz5ZBTXWhARPML/r1Z19CfGD+1QcoxF9grxNxgMg
 ra9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnHS5kQVlnDnh17WNin5RI4bCwZ5p2Bl7PiInvYe8FJcbEttDdGFOHGEZW/w8jPxkqnG6mqbM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKy8hJMmtdo0PSXDFagXRS90NVKY9e/cb8lKGmV4wObAieGtg8r
 Lo9JtRdcQytZdqtpMzMnsWIu7oDP8wTfiewLpSenS7k6e+qr42H05Oj/fjfqyejFUdv0zhMlOgB
 b1Jkg+2RLV4Bd
X-Gm-Gg: AYBFou0QTRKclJ4ly1vKVVGd5wRUaurtU2br3E7e9wE9S9nO34xcyXSlMOa7UPQkiGv
 TuMMHeW/OacnoIyQcEViUnW2bjktja4kQGskgI7y+tjaqrwnzvZciQ5wDvRuRGIiQoxVPkmaPKi
 xJzzR2Eqjff1bUDjBqpej3h5rkLMo3UejMYohEmmI2ZZpPrlSMJehFJ17HaMhGAt5xiwBB9taDt
 OwgSf5wpKZGg0liS7sf0EHm60PqFjzYuGK5zZsRR0BDjv9BGrj+DlSk/xODKBC+jlcUcvyPIUeJ
 +nXsu48jh2kApFqbUc/OsMcqNE915fb12mEPcdcEbbnFNXcvRmDvIUVKYOv1Q9sn0sx8ja1k+6D
 gIqgiSJ0CUshddBc6OxyROowOjux3ydQmrxHKNvsXbBCBE4dbzapt2SN2vt6XM5/uuleYdo4JxJ
 m14WAy4zNQpJfgJMgKhvbcmAYoksgThYS4bK6qmkb7FuSlap7AwKruJwoTbPPQlfjm6QFzRC+sf
 JwAND+05v0X5wm7wrGbe5TKQiDjFtMBS2VgnNnlykaeVfAFzNZuuLYX6SWCdtck3ozkF5hgLGTl
 4eaY47bMYZP5uCHiqkrnLMGCdEsLz/Sv75nmUh/0H7qdQxVVQJ8daCcGppA8GKRZUUxFYjjBsJl
 jDDRQbQABGZibylqVhbQ5WMDDD083NmhCs2Pd8oo3vZWdT2wUnJNw6tNzd82N08677rGeLP2Czy
 xpcugYbrRdl7Ixs6mC4SjXyWE/OMs0AS7x9CvonpUzxmELlyy7jb380w==
X-Received: by 2002:a4a:e909:0:b0:713:d536:1d33 with SMTP id
 006d021491bc7-714ddf80533mr4672680eaf.46.1793456315457; 
 Sat, 31 Oct 2026 07:18:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a921a60ea8sm2449118fac.15.2026.10.31.07.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:18:35 -0700 (PDT)
Date: Sat, 31 Oct 2026 08:18:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>
Cc: khaliforce <kforce@gmail.com>, Romain Beauxis <romain.beauxis@gmail.com>,
 u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
Message-ID: <20261031141832.GO3309461@bill-the-cat>
References: <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
 <489e6811-cb25-4085-8077-427100154182@nabladev.com>
 <20261011223137.GK769217@bill-the-cat>
 <c532672f-8ff7-4e80-8f78-0140bdcbd434@nabladev.com>
 <20261016000442.GG259661@bill-the-cat>
 <adb76f1c-cac1-4cee-9428-563e67c50d5c@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dhKifgEh1drpkmQo"
Content-Disposition: inline
In-Reply-To: <adb76f1c-cac1-4cee-9428-563e67c50d5c@nabladev.com>
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


--dhKifgEh1drpkmQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 07:38:46AM +0100, Marek Vasut wrote:
> On 10/16/26 2:04 AM, Tom Rini wrote:
> > On Thu, Oct 15, 2026 at 11:17:28PM +0200, Marek Vasut wrote:
> > > On 10/12/26 12:31 AM, Tom Rini wrote:
> > >=20
> > > [...]
> > >=20
> > > > > > I believe the answer there is that we have flags to handle this=
 problem
> > > > > > generically rather than hard-coding a call in every arch's
> > > > > > boot_prep_linux or similar like we had to with the old USB gadg=
et stack.
> > > > > This is shutting down host, not gadget. And I believe usb_stop() =
is
> > > > > necessary to correctly shut down the devices on the USB bus, whil=
e the
> > > > > DM_FLAG_ACTIVE_DMA flag is necessary to shut down the controller,=
 so both
> > > > > are needed.
> > > >=20
> > > > Host or gadget isn't the point here, it's that we used to hard-code=
 the
> > > > stop function call for the non-DM driver and now we have driver mod=
el
> > > > and flags. Everything should be able to properly unwind with flags =
being
> > > > set.
> > > So what needs to be tested is whether the flags are enough to properl=
y stop
> > > devices downstream of the controller, or whether we need something mo=
re,
> > > possibly equivalent of "usb stop" in the USB uclass pre_remove callba=
ck or
> > > some such thing.
> >=20
> > What more testing do we need at this point to see what
> > DM-related-unwinding that usb_stop does that isn't also covered by
> > adding this flag to the controllers that are missing it?
> Plug two or more hubs into each other and then into the controller, then
> connect at least one USB stick into each hub, start booting and see if th=
ose
> devices get removed in the correct order (stick furthest from the control=
ler
> first, nearest stick one before last, controller last). This is my concern
> here.

Thanks for elaborating.

--=20
Tom

--dhKifgEh1drpkmQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauX4uAAKCRAr4qD1Cr/k
CtTzAP9jiFdI5KYUR7S3upCwikA4I9n+nIA0H3Nqhec7nSCgPQEA22biWEcK885l
LXYhzW+sSuk1PuiRgEn1+Aru+RFTewc=
=lgry
-----END PGP SIGNATURE-----

--dhKifgEh1drpkmQo--
