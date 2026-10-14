Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E208CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA5D6605DB;
	Wed, 14 Oct 2026 14:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_LGg8CxDDHu; Wed, 14 Oct 2026 14:01:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC4E460684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791986491;
	b=EuX3kPjTuCvVEkF/kBfCLb+IHc1T+PNULDLUntWIEZsUC18luFbqvctM5iKJP5l9aJjF
	 F0R8m0F7dszTu54CmGc4tR9RnPNxCqTHU0s4xIsXMmqV8WdX1cP7k4nT+o8kChb6QP3BI
	 DjV42TChFDlsIujADV/sVQQNBIa4IQOMiLk8rQxGx0jdonw1oLS+QIhF7NAy3qKIsZ5Za
	 6KzPSTFdhVDPtil1OTQTFRdwkxMfng0LCA8I6PaslKq1mht7VL1h+o4NXQICUhDKhTqmC
	 2bX9k7Y9YtIcIdBro04IJ3RKP+yRMBGVNVG4mo80xAjAaCWm8urIzH5hYXjTF4Aq0wQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791986491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RHD6tp/oXcC1A3WKxHucV3/BpyQMVK4gho4KHSXRf9I=;
	b=RorALDnYDkPTyDuXCQVSw74WWOMI0ci+7AZbmBSR47DRUVI+x9bNC+Fv5S7wdUsad7yv
	 EqheVwjViyRfIse2y9mHV9nMfsfIyzCkNNhllVoU+s7YIJlEbj4pZPwqKB8aJT2Zbn6WM
	 IJmp+RTLiY4MILfP/uwGyNu/UqAlU7BeuB3F2lxdazhWleZ2Z2pJ1dVjoCD28ffnedVd7
	 Zzo4llkoxZ6d1bzWhbUX5PK4N3tg28aaLGaoXyqOCZtWuWf5ZT0v6KlxtUfvBgfjJI0GR
	 lKyRgQ7JaRPS6kSnHnpxqDE3p1P+S7cYns4K6/uftOsqXnX8zAa/8S1TEqGfi59FSGw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RHCn4TEx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791986491;
	bh=RHD6tp/oXcC1A3WKxHucV3/BpyQMVK4gho4KHSXRf9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FjdzqgKYMab33uTtQMbB6CL8jKAt4GAj+571DHwbPguF/U4NmXo+1DSMVlHjvoma1
	 gvRV9JTDgbdH4JCviactyoQ6e3OQj7Gs8JtaPNxpdrLChM+DoUvBlYy9IF8MYwe4a2
	 k81R+3+xDw01ne0zlFcxJn5WlceCyLqiK52Z+DKG1HxqnMNUFZ2R5eVPwCAcZ/P4+L
	 Yecrz2U6lUBMq8ftnD3JPvrDKwGFtDzQ8RwwZHTBv0jknnjk0vZfe9X8YNhHQ1LEY5
	 iuVDYbfX6heuYt7aqvlflkg4z8BLTq7nAUNdywszF9vvdli3a6al5QppXdny5+zZqn
	 yshBYiqBFziSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC4E460684;
	Wed, 14 Oct 2026 14:01:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE5AF1518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFB1860684
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:01:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKnVn_aW6RHY for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:01:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3794605DB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791986488;
 b=SqSiycrC2qapCqUpiWHVFaUxiXbS9FzAYqFrm8bs0pamCDLwHlElReGnvxCBwmmp89eP
 X3baktlF83EY9NR1Jmk2WxRh0PQFH2TiH4QjFyDYcTtA43Lg0Ru9SEgiL/7/+xXaAXwsK
 l/no1tS0liY4/fgy/Wtix8IYnBooNqSDS+4NJiJolp5bEbjlwYd24ts9h5AKr3KRtD/2w
 /qJyaPL42oRaqncRt2EbQG9Yn4VUUO3WffDtG5othLMf6YkjJ+d/q/RHaJIKa0qoOXHo9
 NewAc+PwVMMbkHOFyebiOdjfHgdhMPa2HLsCkdxZymgO5fdWEmrdAcLX9iqydyoxYgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791986488;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=RHD6tp/oXcC1A3WKxHucV3/BpyQMVK4gho4KHSXRf9I=;
 b=NYu0POXY7KfjIVgp4JwbGB/sXotsAzH4y0rDFp/sGN8CWZN2nvIE6zN/I9DGfxby7ke+
 KlTeRuu0BiVGze/Z/6xVCdEVvl7b2hOfD5D9oYYbyxaGdnhtAHiEfHYYj7C2p8IdvU039
 LplYex3AjVpfgTgJwSDtKuJsjvK3MffAUlLVLJVJuxGUY9Ty5rZRGfTtWMHmNnPFdcWEL
 ALTEzfdKYdIaa52nVsYjfn/+WDDTK7OQUcKlTtcQEXKZBLsdu5lDj/jFl8IzzaHg8tOZw
 eP/G8DEL9TRA3N14uO8W+qAEAz9F36CVQe+2QHQB6d2gIoTdlN83mJAgQfA0bn4fxlw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RHCn4TEx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RHCn4TEx
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3794605DB
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:01:27 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7f48c750afcso675562a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791986486; x=1792591286;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RHD6tp/oXcC1A3WKxHucV3/BpyQMVK4gho4KHSXRf9I=;
 b=RHCn4TExZU+VXnDDFkHURiVHmXYUx1I4yXAr4ihVHZYyhFjW+mEu3X4lnZ8GnmmesV
 c1aX4HiMuSv1CEw2Z3rAZr1MXfpP2OqQiR02tpbZS9P3cROhCD/4ZBRUylIg5lRVOAfk
 Nc/axlBtXztwSrfrDWCS2BuuxeD7fPkHahEtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791986486; x=1792591286;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RHD6tp/oXcC1A3WKxHucV3/BpyQMVK4gho4KHSXRf9I=;
 b=vKRDye81XhAsFuREZMXpVwbAhmb5sV7dNtkxWoW4A/jSE6hpqGrkpDQgl2d0UiSyw4
 pdJRW/Mj79AnyuEdblLmMYZSpTGPRbgJOV/rnYuRghYbsGoZiMNN9hbEUtXeh5aqVYTx
 yF4oaIFyUrp+zbAFqFeCyb41q5P3gKkOkpAQI2U95DXl3UbAOTMxwMFSRcqEv0hGLHro
 YcvRlzdug2I5BJw2hOPmzewg6UQI8tN9NIBDC5QopLC+iU/1hteXSMPczCsco9ql7mhd
 QnYKo9pdQgspE6tGYFPya5eQ85FXhKLLjiV9ZmcskiPFTagWCYuRj12QWZYX9h+4GAw1
 awCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOqJG1SW3pa/GO1b/FTSgr/5k/g9Mfl8ki5z+J18SiqgufhnT6bpJEzMZYwszHF8oujAzmffg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLgUhNkjGcuLN2xoPH5HHsn5q5aJzRNziWSYzB2dKYmZAMmTsDf
 LsnynhBjBAuFcBJRRRSFCYgxyvkhTHfDuLP9XT9d6kMIssgF3vRTk0V35hmWdSjzPvY=
X-Gm-Gg: AYBFou1hGa9mO+HMLMhcGY1oBeMmF3EGY5OUBhpJlHj6jmrOE0B2ew8b+ZJ6jqzdXQ5
 zzG0kcT3u3XeVYIi1FAYj2WS/+BfUG2csradILJscluwB9buvKqqb8AKOJ18gMYp1xwBquWCVUY
 UXKwHhQMA+oSF0fbUFuu/pH/qcgZzW8aRBPHrFr+coeprjyy4SN+S8fX2ob11Ayl/Z5uaa5FbNn
 KyV47VdBUeJa36M+hD1Ig+KKzdlV4gol7B2j87MgRZZt5aStL6RgVL843+z/pWSxf6vnfkL+TPo
 +IKTTn02m8gNm0LBCBOfMF7Wgom/R/DeYQcWlRthVtS3Ap0R+/KaN6YXdmUNcAl3imdnPhv+SK7
 5YGP1YEG0KRa55arJC0J1zDec5yftDWG7POhM0OysRL4+WVfA72N6rgqCEYLwPjPZ0bN6xXKV3e
 L1zi/677jlZrQw9BquyDAB6gVjvs04wvA6YInqn9O1oIhDLhy/LX09Mobqd8NocdOV9d3+PJnah
 qFDZ9D8BeMfdQ1QV04IneBcCEU10LSf7ens91umIAO6PpfAyDqwAr11aKw2szKJMI3ceR5luMTL
 wNWDPjd10HZigqFiaSKmAEoA1DUReA==
X-Received: by 2002:a05:6830:6a13:b0:824:5be1:f47b with SMTP id
 46e09a7af769-83097c6b534mr15360117a34.26.1791986485975; 
 Wed, 14 Oct 2026 07:01:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83038f822dcsm14702883a34.10.2026.10.14.07.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:01:24 -0700 (PDT)
Date: Wed, 14 Oct 2026 08:01:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Rahul Pathak <rahul.pathak@oss.qualcomm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Paul Walmsley <pjw@kernel.org>, Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Conor Dooley <conor@kernel.org>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Charles Perry <charles.perry@microchip.com>,
 Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
Message-ID: <20261014140121.GH4042005@bill-the-cat>
References: <20260902141744.2422566-1-charles.perry@microchip.com>
 <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
 <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
 <a83ccf7e-87ee-4c78-80d9-86dc0b246491@amd.com>
 <442ea702-451e-435a-8b04-543750e929e6@canonical.com>
 <99875a68-fe25-4fd6-b02a-7bb71c24fe0a@amd.com>
 <CAFR3w36KKkJioAmZPeXBwDEErn9kPPv9FQ8QUY7EthY1+KxdGQ@mail.gmail.com>
 <cd00079f-7134-47dd-a41f-48218c5a867e@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/f+nQ49xS4+7rDTB"
Content-Disposition: inline
In-Reply-To: <cd00079f-7134-47dd-a41f-48218c5a867e@amd.com>
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


--/f+nQ49xS4+7rDTB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 02:15:19PM +0200, Michal Simek wrote:
> Hi,
>=20
> On 10/14/26 10:12, Rahul Pathak wrote:
> > Hi Michal,
> >=20
> > It is not correct to say that SCMI already exists and so RPMI is not
> > needed. If you read the RPMI specification you will find that the two
> > differ significantly. I don't mean overlapping names, but how things
> > are defined and implemented in the spec. Compare the transport,
> > compare the defined messages.
> >=20
> > RPMI defines many service groups that have no counterpart in SCMI like
> > System MSI/System IRQ, TEE, RAS Agent, Management Mode, CPPC,
> > Logging, Request Forward and others. Together they cover use cases
> > ranging from typical systems to confidential computing and
> > virtualization, all in one specification.
> >=20
> > There is also a difference in governance, which is visible from the
> > licences of the two specifications.
> >=20
> > RPMI is under CC-BY 4 license which allows anyone to adapt it and share
> > modified versions with attribution, and changes are developed in
> > the open under RISC-V International. The development does not happen
> > behind closed door but rather any indivudial/organization can also take=
 part in
> > the discussions.
>=20
> I don't think license is an argument here because someone decided not to
> talk to ARM about it. Based on my information none really talked to ARM to
> change that license for SCMI (if that was an issue) or move it to neutral
> place.
> I have already talked to ARM about it.
>=20
> > I think open source projects always give users/vendors freedom
> > to use any protocol which suits their platform. It must not be dictated
> > that everyone must stick to one interface.  As Heinrich pointed out tha=
t U-Boot
> > already supports alternatives for various things and
> > Linux and OpenSBI already support RPMI. Adding RPMI support to U-Boot
> > does not take anything away from SCMI.
> >=20
> > Platforms that use SCMI can continue to do so, and platforms
> > built on RPMI get the support they need.
> >=20
> > So RPMI is not another interface that does the same thing. It is a
> > broader specification, developed openly by the community that uses
> > it in which you and anyone can also take part.
>=20
> It wasn't my cover letter which described
> "The goals and purpose of RPMI are similar to ARM's SCMI."
>=20
> I am just saying that it looks like that you are creating parallel firmwa=
re
> interface instead of extending/reusing existing one without really even
> trying to talk to other vendors. I would prefer if we can work together on
> one spec and extend it to cover both architectures.
>=20
> When you have heterogeneous systems where you have mix of ARM and RISC-V
> cores make no sense to have SCMI and RPMI servers both running to serve t=
he
> same purpose.

I believe we have ended up in an "either/or" situation. It would have
been great if N years ago, SCMI was adopted for RISC-V. I hope one or
the other, and not a 3rd one, is adopted for new architectures (looking
at loongarch...). But for today, I think U-Boot will need to follow
along with what the kernel has already been doing and have RPMI for the
RISC-V platforms which don't use SCMI.

--=20
Tom

--/f+nQ49xS4+7rDTB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCas+LLgAKCRAr4qD1Cr/k
ChmjAQDFc6WlVThNfOcsOJ6zQ67J8X0DOC9dYrcPLbSfwOny+QD/cM/lYPhqbhrr
I6yMn9rsj03MuzhI8FepFyH+DvaajQw=
=B9GX
-----END PGP SIGNATURE-----

--/f+nQ49xS4+7rDTB--
