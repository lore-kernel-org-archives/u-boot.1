Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B50FCA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 19:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 128C680A76;
	Mon, 28 Sep 2026 19:25:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_heWRxvEl_m; Mon, 28 Sep 2026 19:25:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4569A80963
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790623549;
	b=Je0ZZE0y5ogSBF9TclkncEct9Q+e1PxdZhyL9ON4i6Wh8CH2GOeORlPpEOCq9UWhFtFc
	 NGDuDvOLJJKCopRidIT5ERNwKXiptl1NG1hWeTc7ge4bvggMHNcTQwYPLNKLGwohztUww
	 m4ElzjiTMull0GjituNzo90CI39IyvQUoP7psgJS/dQhb29UOunFs934tgdIfdI3/kPsd
	 dBNFRNPCsZIISm19OwGTow1zBsXb8XxmLnyPc1XAVRfsdIgqdpqj50RFP7e9p7/kIIGLr
	 43LcqpfE+GopQqXI0xgszoJ60y0WOYwPcgH72ycSwHvWSl7UxVJecMKfME2cpWLptSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790623549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SNrDhtlmlRRHF11/sLSsbqKh0u3Krde2xn5eKsnC7Jo=;
	b=qbhscYDKn8/g00a37MBkp9e/OJwcnERW+BmWAWrEkLqADC53xmr4dsp/6fk6W4PAzyc5
	 iSu7tkx56IXKEacmIw1aN28OlZiDsN8TZAaxUtU1aySvQEXn0ZE6XRZA59rR8w0J4O1Uk
	 Xuu2M0EsbUctjR9obWvlp/P/A3qLsrRQw/JSVkkG1RDKmVWQ1e8PsOWoKYnj/kIIWAth1
	 Bmi89Kcxlkh/7QkozKbmcWMxycdK0Iel1hxPCpfFugPiNxz5ksArf9TtYWxxLF/k1hlDp
	 YRYssta+H7A7db13xTcnASGWDJ+VGgvfGFbvxmMqXcL91L/a1g0Aks9U1UiQXGyVuaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=kgbRydb6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790623549;
	bh=SNrDhtlmlRRHF11/sLSsbqKh0u3Krde2xn5eKsnC7Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p9Y/q1TiQBL3wDBvy5VETU86f16CcMENBIk3kJugoLrL4DG9GJrJ8UM+VzvKxLSJK
	 PDR0W5hbu9obnI4+fHSF//NDp47bEsno068NHgW43Wrp7GtE6QdKBmr+oDEzifcEa1
	 MUujcPzZRS8eEY49coa0TFDHhomMnEYR8BTNn2GUDX88r4Rvg6TatczGiaZMeabwPZ
	 Ka/i2F00bjnWfcGshVs8iMZBPrNIPkT/lGIOChVnUy/lPgyYqqCyffPs0GZd27TRHb
	 oFjzkLsQg9TIDyPPEmdodiFdRF79dNSvnTKOcJqnRcEVMZg8lOkUUUxQqH+0kH6n8F
	 L0sJqYFrepXdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4569A80963;
	Mon, 28 Sep 2026 19:25:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D95147
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4E0680963
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VLQDkALsPNgZ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 19:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EF3EF80960
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790623547;
 b=WJVzTB8yNgNgaexl22qwM4OoNevHi5zkLDBqDpoLnCmLhCILDtD9QIPAh4lLDsIfd7ms
 Br2osTaSUqB88yoaqIERPPWpRRrL2p5sGomtRXYAs1ocIu+gXIw6OzwoIqErrrLsUcLYD
 9qVZ3s1HXcxo10CB+44N5rA68u8J7uo/HE5e+oRBSWlBzZZwAsPxO8Uurdpqb8b6zwLh5
 PBYGU6NVTkQqkMZsKp3rCzjdeU3M+Yu1Lfk1vvBjspF9r4Y+ErPRiA825HW48hJdkkKYA
 KxlZY1/El5CmEiPCGgQDB8VohocqfhtzirH+oTzCJMfCf/C9hprpzSVH8IzALZyEn9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790623547;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=SNrDhtlmlRRHF11/sLSsbqKh0u3Krde2xn5eKsnC7Jo=;
 b=WZGvrfXpoXgiIbpKlfugyaM5icfyk0+pdiqRbqkoXuwm5hZvnkIgzZxLg8lZdK6npnmn
 eHYwpLuEImkG55Bgb8gYACIUn4zThf+DN2rpeMoP1u4HTi97a5N2URjvoYu64JILXcBSY
 08jh8BBEyZhPcAZrb1IPUTCTjUJba7jA5AsWV+HKuyXokrEnK/8HczF1gm4nxgkt0F3Jo
 3AaGZWBFXniTM7NrzksVDX0FT4T0h0JXGz5ZwGV48dh/GNFmPHWS+McrlFRgSuQKwRjzH
 p33zKmeiGQO1Pd+/taCvalC2CjbZ9SEpeXEM+2vPZAF3JeTrLN5Uqus034KEj/KOUyg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kgbRydb6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kgbRydb6
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF3EF80960
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 19:25:46 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-81b46bc1282so668508a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790623545; x=1791228345;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SNrDhtlmlRRHF11/sLSsbqKh0u3Krde2xn5eKsnC7Jo=;
 b=kgbRydb6w8Jsv+93X2nalprN4/KgUP6IQ0N0OB3n7IDcbidXYcNTLy1u7PTPdRpprN
 qoDXiZOQt32j1clN9uEUlwnP/QRU1KgiqsHGWsr7YCVfZlak9NudzMmOGNQshcMtNEs5
 eaSnKQAv+1eyTqxp6NQnYQERJkIJMEH10FGZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790623545; x=1791228345;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SNrDhtlmlRRHF11/sLSsbqKh0u3Krde2xn5eKsnC7Jo=;
 b=pr5gKoAipxWsEDtyVyHwScHIx92RpCd7MV7Yp5z2NthEmWQcnIvcLLxka5VVYnr5Sq
 NULdUgsI8rJhmwosDZdWMJeptQnb2lnv6RJ1t9SXF7bmZ3IgrIwb3/RDLNlG/qNfarNr
 gupTt5fHttmY/gtrTpZVvnHgSM9BWnoUxTtIj6SksNcmSHGdGJwEUNXf07vuqWvnGokg
 uSaBDWwLLREGZXWcpHQ+7v712tJaez5rNVxv3S93yjeUP0Pfbg+2NbAEEPGAsQ5fVwCV
 DevDpCRAyWSePShhS0sqVnUDELvh02WP9v9hlkdaSy4GmgKZMPelQfEqA1tszPQQbBs3
 QY8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8XC2uLlJXxbEDzPEM2nM2Jb150OPnSpvRtXdFz/b+wOgy0WNqCqfQ95LEk9BcVKeH9DU07gA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mxHMkkG1fWdSMf2pR6BS6sFw3Dl2MnGn3mI7h8NPs+RdMjjbY9
 t5VMI3WBNW5FKeEZWqzbp6Fpi/Fu4oMN+03smGxxIc3DIexRRSw7N6BdwZ03WxMSbAE=
X-Gm-Gg: AYBFou34GJW67GUJZ6yYxkoXHiz0NhuXOemXRU7Wv7mK1hMHJBzEI92M1QApiC2FDPn
 +dRZjtynUz3rRV8wLAYDVzNbialxujVQZtJ45iVTpBelGgS/TpfS9PEMI/x9YsQvkZOc91iYytb
 JxSkxNMB4Y9rqvy4m5pON97oID9qDRov7jldpafVssBtz+RAj6o5qFvvwy+H8VEXay9ezSAQDSm
 zd15Z4sR+wp42RKoQ59O7YolDrQEDnnszoEMUPBi3oLhW8yexEhNPNK+LioQEmK41hBLCOYpZtQ
 rk20T/eKzNJwaC/drHbbod9O3BbdE1GCiAmsXmCc2XNru92J1rYsS7VnEF4SIz36xri+3IpxZYF
 DIKE/3z+5uiUn8KJzcplJYS/a9/j0GpHK8qkbk2fuafv1adHYfjj1gC2DjzCHwFF+1gakFKWy0H
 CSSEgScIDxGbleR35i12DW6TJjPyvRTUdo5BKYXQafodWYn+buYH6Eeo6723B1bOOC9su6K9ryY
 9buYaOdyTJamZGE4Ho4SHHXQmSfe8bPIWDLzi2a1GmWj+UJqCCnlrIRf8/wop4VYtiokNd5rgui
 p6vQ2SR7BgJw8ZNu1Ef9+KrXYRTqkAA=
X-Received: by 2002:a05:6808:1a1a:b0:4c9:6b4d:f2f2 with SMTP id
 5614622812f47-4dc640ac175mr9640465b6e.39.1790623545246; 
 Mon, 28 Sep 2026 12:25:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ebbd4522e3sm2564714b6e.18.2026.09.28.12.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:25:44 -0700 (PDT)
Date: Mon, 28 Sep 2026 13:25:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Romain Beauxis <romain.beauxis@gmail.com>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
Message-ID: <20260928192542.GA4035470@bill-the-cat>
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S7HMkld7fHZEvief"
Content-Disposition: inline
In-Reply-To: <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
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


--S7HMkld7fHZEvief
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:59:23PM +0200, Marek Vasut wrote:
> On 9/11/26 10:32 PM, Romain Beauxis wrote:
> > Neither bootm nor EFI ExitBootServices() stops USB controllers
> > explicitly. Both only remove devices whose driver sets
> > DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
> > controller brought up by "usb start", e.g. from preboot for a USB
> > keyboard, is handed to the OS still running.
> >=20
> > Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff. This
> > is the path "usb stop" already takes: the xHCI is reset, its PHYs are
> > shut down and its clocks and resets are released. Child devices such as
> > hubs, storage and keyboards are removed first, and a controller already
> > stopped by "usb stop" is skipped. xhci-pci has done the same since
> > commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
> > have ohci-da8xx and the cdns3 wrappers.
> >=20
> > On Apple silicon machines the running controller is user visible: Linux
> > does not enumerate a USB device attached to a Type-C port at boot until
> > it is unplugged and plugged back in.
> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is that
> not sufficient to tear the controllers down before booting Linux ?

Jumping back up to this part of the thread. I believe the answer is that
it is only enough once we set DM_FLAG_OS_PREPARE so that we know to find
and tear this down. Without digging through all of the discussions of
the other places we've used this flag to fix a problem like this over
the years, I believe it's a feature not a bug of how we do things that
we need this flag.

--=20
Tom

--S7HMkld7fHZEvief
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarq/MgAKCRAr4qD1Cr/k
Cs4FAQDJ6wrUFTVTOWhKN1QNXBhGGL+8EClvkkHShO7eaYdx9QD/Tc3R9Sw8IiQD
ScC0eHOYoiMPkiYLqi4+RidXJMVu8AI=
=g9wb
-----END PGP SIGNATURE-----

--S7HMkld7fHZEvief--
