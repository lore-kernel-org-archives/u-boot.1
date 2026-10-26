Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0C606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V+MIZV3K;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=a4W9UIbQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F217460635;
	Mon, 26 Oct 2026 18:30:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CEbd6FrtDSde; Mon, 26 Oct 2026 18:30:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D10726063A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793039419;
	b=AK56N0q6DzBdAylHgdKSOEoO4eyw9OpGBOq5mL0zUmXEvUO2lOd6YKuJ81IR4DrWvBru
	 xMbHQcgmNl6fSfExuEHf7YdUrEYiRwfJh469V6hNikKU5J9uuLAOuJD8D2xhKer4U9lDF
	 myAGAUl5JnORLx1kbstU4De1EiWOUlwPv2rFgqJLpPv4unG467NzSg5VFJuGtN8+MT7G3
	 jdXezCsHdgj0kRdsN7x3T/lDcbbe12eCDWb+tE2aSs4uxYghqsQOugDmD2JMlzNbVKhH0
	 6sZnr7/ZvxY00HPXNFckDJ2+AVLrBJNh6x+0TcfPyvWUOOoKTeLTEEALCak4C0PCekQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793039419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xZj55QiBO6+8XB+xOIiACEfjUTF5bW/7jLBbKMGhuVM=;
	b=VBfB7CULhO880UFVuL5uNWkT4JVmEB/c00MhsPvU1aMjZWhtSGfKEuaBPI8tcncA2wh1
	 Dx12iKCa8EAllx65BHemqbXzJegw3ZYDbN6eUDGi10pdcYl28m57BOdNv4AXgZmyjSDg1
	 kIz5Ay/a1bis8ewEzF/K7+6p2gZl1ilTT+rlsGC3G2MwStvkSuYPTauIWtDaTkJ4cHSzV
	 UueYpb0fNzVBMDnD5moai382E98V49eVxstaq1V9hwNh1BL7mdw91ppqUTGRbXG6RaFct
	 KlwV7BXHX+aaYnVudekE9pnrbfAdwOtqh5qtpFQWMEpfS9duG5WdyjqAGWFrY+bImmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793039418;
	bh=xZj55QiBO6+8XB+xOIiACEfjUTF5bW/7jLBbKMGhuVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V+MIZV3KEoPh/NreV7srOjZRZkNGmrafWHYVj6mIsy8L15tNOg5ocrNkvjjW0Pp5h
	 fqNb3uk5dKTFUZXLWC8EaWonqTjzsEZ5xknljO3bbe53A7qkFWdFRt6Dat92ia2iVP
	 dTDt7n5jA08GhPmVd5P2F3mluBdcAi77QRAuzI5i5lRLgfbK0XfUNCydc7vZQWFfjF
	 EDRqqqzGS0JwBt4+g1y8onF+qE8dlKLuV36iGheFiOs0hnEYuTi1F5c3+dQlxDsFXu
	 EdYUFkg0KnUZJ//FZF9UcbcowsZP1iMYFRkhvaDvcLZFo0bVE/ivKivSK7v1M+Lss9
	 P3a0Anjx0Tt/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D10726063A;
	Mon, 26 Oct 2026 18:30:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7A474BC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:30:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D44080D0B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:30:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HLL4fS7NoPa for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 18:30:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9110780ED8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793039415;
 b=FjLDoXYvb1ky1uOGZimzs1AKO1HcPm+k0z5uQS6oWIHANTITx60KerNrk2nHWttLcSFS
 opWRMM36BV0Kic4SnH3+EdSYkj8kUuDbv6XHNr6oIMg5QLRBmT6KkflO+7hfnMcCE0/tX
 mWtxBAJ1aaHQCXNEFplOU02o+irGLjIIWY+q4u7LdQrqJxgx+HwbjumwFPsj5SiS0Io9P
 obyDU1slgYxrFWA4fO0kq45crlVwS8kwGSXIKj9qbuM7V9UhRGZQZk/UELjjmT30xhSRF
 T/CsZuC4Iu0x92oTb9btml4QkZAiIGiyHmB6PVvk77M7Wb2DU7NnW3qJTlEjFB/oWJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793039415;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=xZj55QiBO6+8XB+xOIiACEfjUTF5bW/7jLBbKMGhuVM=;
 b=TPHaHvhWDOTnS6LzCjfKf5imTk+Q82owoecbgtANl9XUFU3CJHHtDh1lT8D4178Wqnlp
 sHxig9ltnliXGHAvzQ2P25qWQ8BUUiRPnQeRnp9VnO6uN9bUonKSc+5q6T4guxgMbPqDF
 IQhRVfh6udhUxq/pplX6xHWuZls791oVqz/i/5o101i1lcU5POC6Sgj7xFTkYv/WThJa9
 58YsQTnMJR1u3yE97kH0HgTgTefGvu57tRmp1C1Tp6FF98qEJq3BO5FsgW0UM0i7lyn3J
 z42O3Q0ysRvzA0fXMYD5dJxt44wjDhsMTZ8iiDdEiLOheW3S2OS0yZb3Lk/YRH5yeqw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a4W9UIbQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a4W9UIbQ
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9110780ED8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 18:30:14 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 006d021491bc7-70dae1276d8so565752eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793039414; x=1793644214;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xZj55QiBO6+8XB+xOIiACEfjUTF5bW/7jLBbKMGhuVM=;
 b=a4W9UIbQp/hJJBztrW8N5tOwJIJNwsZEj5xIVOAlR8CgOUuD1PsGwtDAr2tPswy3+Y
 RYC5FFOV6NJB+uc2eM0EdxFl7h1Qx751WIot7IhC91hZdobwLh9S7R2JPjbhmXeZjWbr
 k6AHK7etNwKwJ9aikG+b95XcDL+Eg3DfPUvCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793039414; x=1793644214;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xZj55QiBO6+8XB+xOIiACEfjUTF5bW/7jLBbKMGhuVM=;
 b=Y9YTfS0bGvPXokwmcKJYMbY62GoVSJqKPbZzb3gXoMJzj6lmFF0jIbIzOnKb9wqFwy
 d0YNu8jvpxuDES31P8dRKPliG3l9/SymcomM34+aB67Nh4mCexQtPQb7z5iCOEPb2iC4
 wbrnLc3mkb33a03XpOW/n+7Yd94e0QqOY2LdKy/mmafdnXNwrah4ot0gLSH4TQSTe/h6
 VOcpcc+NTmAG3UJmCWuwBHqaFtS6pADr0iGjvp2fFkbNCrpHXxO89VXIPt7QuhjHR1KG
 RW3i992Up3FzE9k08zZtPgJW3gTG9glEk8rDcl2W1LbtYFQWKdjGuDUXFzsOxYemNzCW
 Jssw==
X-Forwarded-Encrypted: i=1;
 AKwUvBybAUoh5w8ZauGB1lEmr/90N6TPaoQWDilf02s9PU98NfHWTI262HEBScHwz6uLfZDPwKkcxqA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKa3ePFoBqg7e1rBdY3qjQXf6W6f/lllKlts1syf8pAxlW/fRZl
 k8rSRx7KDddEIuSNXIrdCk3/fJrT/BfOUFwk/vGVoEDljvGiz8HrThNobtfBXrQ29ME=
X-Gm-Gg: AYBFou0csP/+3fz6+utVeNEr4Epf66Nx2I2fh75bsFDwvChJDL3Sd62rVy/d/vxr59F
 TegGlQZpicRPG87A4BIMla54apezK1AAEkZxR/X8Ro3PQ4QNePAvY+xUfVMwQvsBOfFCJ1JxVVe
 sDIy4mIxo2mlPgTsfa1yoXBDL5+AlwlDVq0DU/ARJiDxHuQOC+CJkI057ef7SyOsD6FrlvdA1+k
 wEc/mfQNNWbCV+FanM1GWhl59gBoKl4VYwOUOAIdd7vOKL66g1Y8xWD1AleKu0RKlXCr9HYwaoO
 RrAy49yhTnsO5veQ0z7FfnkLrlGrK+mec+ivJohCPOYXF99Fdg4haIkRhbDeic+WsRatHu6sg3R
 +zHvDVVZnexhQb9kMmm7qgCCUXDSw7ejsFg0L1K7E4mNgcSLRLFzY2yZ2aiMIDhQNkmbtXxEI78
 HqOpvwqJTuaIRxi+rYztnbqgKGUXwgNdnvM81E6sfQUsCi6h/4IE2K+ve1X/z/WBcauBSL7uWPK
 V6AhAWZ4vgGcR7ULujhTdupzBPMM/anw8g70sv5gzJ/DDBfYNL15MwptFSDxnOroTdOXNYxLWo7
 W9+EXuc2LOmPWvQOpFUKwuC1/kec6lRof9790a66CJAIbwlMUjZkePhaMYS+jxiBCiyD0aFAUTq
 9WVg0H10mosj/UWKgI+SN6wcIpQG4N8VVANFIbJOTJ9H6nBCeik0CzXCsprWMhbX8ypyfNNmgHk
 uf5J8=
X-Received: by 2002:a05:6820:740b:b0:6cd:3fdb:fa6a with SMTP id
 006d021491bc7-70ba0f580e0mr3205340eaf.85.1793039413646; 
 Mon, 26 Oct 2026 11:30:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb074fb6sm9108197a34.12.2026.10.26.11.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 11:30:12 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:30:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <20261026183010.GI646438@bill-the-cat>
References: <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
 <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <0CEEE153-769E-4B60-9CAA-3FEF80E4A659@mainlining.org>
 <DC081BDC-A313-4635-B013-88FCABE9C4FE@mainlining.org>
 <20261026172332.GE646438@bill-the-cat>
 <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FWTuYqwruf1UldrP"
Content-Disposition: inline
In-Reply-To: <73CBF7FF-A606-4531-BDD9-33DB5FDBE774@mainlining.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--FWTuYqwruf1UldrP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 05:27:05PM +0000, Bradley Morgan wrote:
> On 26 October 2026 17:23:32 GMT, Tom Rini <trini@konsulko.com> wrote:
> >On Mon, Oct 26, 2026 at 05:00:19PM +0000, Bradley Morgan wrote:
> >> On 26 October 2026 16:58:47 GMT, Bradley Morgan <brads@mainlining.org>
> >> wrote:
> >> >On 26 October 2026 16:55:09 GMT, Tomas Alvarez Vanoli
> >> ><tomas.alvarez-vanoli@hitachienergy.com> wrote:
> >> >>>>
> >> >>>>Hi all,
> >> >>>>
> >> >>>>Just a data point from a user: we are using U-Boot on a T1040 (Qor=
IQ
> >/
> >> >>>>mpc85xx) in a product, and we intend to keep up with mainline as
> >much
> >> >as
> >> >>>>we can. We'd appreciate PowerPC support staying in tree, and we're
> >> >happy
> >> >>>>to test patches on T1040 hardware and report back.
> >> >>>>We run u-boot in 32-bit mode (not sure if it is possible to use
> >64-bit)
> >> >>>>and
> >> >>>>linux in 64-bit.
> >> >>>>I am in the process of bringing it up to our 2025.07 branch and
> >> >>>>potentially
> >> >>>>mainlining as much as possible. We have some remnants of it under
> >> >>>>`board/keymile/kmcent2`.
> >> >>>
> >> >>>Would T1042D4RDB affect you?
> >> >>
> >> >>Not directly from what I see in the code, as long as the shared code
> >with
> >> >>ARCH_T1040 is kept. Sorry for the false alarm, just wanted to report
> >that
> >> >>there are dozens of us using powerpc :)
> >> >
> >> >What you could do if you would like is to test the whole series to see
> >if
> >> >it unaffected you.
> >> >
> >> >
> >> >Btw tom I had a idea: you merge Vincent's bug fix and my maintainers
> >> >patch,you make a PowerPC custodian tree, and I handle the series and
> >the
> >> >naks and stuff and the comments.
> >>=20
> >> and btw yes I'll make the pr with the finished patches so you can merge
> >> them cleanly
> >
> >Trees are relatively cheap, but I'm not sure we need another one either
> >for the subset of formerly-Freescale and not-QorIQ PowerPC parts. Since
> >I added you to the fsl-qoriq tree, you can also just pick up the
> >outstanding fixes and your maintainer patches (and leave dropping stuff
> >for now, as this series shows today we're just getting people having a
> >chance to see and reply to this stuff) and send me a PR. Thanks.
>=20
> Hi, sorry, I didn't clarify enough, so I had a chat for some people from
> the open src firmware slack, yes?
>=20
> And here is their answer=20
>=20
> "Ah, Peng Fan maintains the FSL QoriQ tree:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq
>=20
> That is the vendor one though.
> So yea, I'd go with a general PowerPC tree.
>=20
> Also because QoriQ is both Arm and PPC series. :sweat_smile:"
>=20
> And even my slopper suggests the tree, for sanity purposes :D

Fine, trees are still cheap. There's u-boot-ppc now. But please keep in
mind everything else I said, thanks.

--=20
Tom

--FWTuYqwruf1UldrP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat+cLwAKCRAr4qD1Cr/k
CiPBAQCxYcxYOuzD/pGQIG1iBbrj2T6kvGXDdVaaJVFbmiv1sgD+LuCVGn8HwNxx
wWV1WQl6XczqXIdG2QlJOKMzIh3V1wY=
=eIL7
-----END PGP SIGNATURE-----

--FWTuYqwruf1UldrP--
