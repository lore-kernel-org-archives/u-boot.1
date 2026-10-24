Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98FE606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wN9Y05Fo;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=p+ZT2gCC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91FAE81762;
	Sat, 24 Oct 2026 14:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OUvPHSw44Loc; Sat, 24 Oct 2026 14:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5F1981765
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792853253;
	b=DW9ko/R5R4PyjECsUIgXwdPhTS+Ql98HeMQ42zIuWLFWiFRewl6EtoNWG74CW4OemX0w
	 t1Ma0rSabkntgkKXGMzllWvDaK3EDB3ZsRz68Jv1OeNDyNNujiJQQHmEsUAsB1EWjBkq8
	 S0Rlv+WbUSu0J5HvHWjyZoZENQXFkBMixS4aqmlKVfES1ipLRLg+Gmn+nMpM5U1ulNJbK
	 chGGWJeh71DUc7EFJVQd58U6VF4wgIiWvZ3mtqDZem0y9PdtuzDef1qRWH8tCWmsVTrXH
	 HCPFVi08RfP3mk+oh+WN2KOM7SogFE9qjBf44Kgxz6SUQOeROdTmc+5J/eTJU2A11WQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792853253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RxOqnGYHhoikl+/PxYkGD49N/tLXoVDMcOXic5722g8=;
	b=BrSZgJV8ftLxlfShUPUBdAzlo+8wf/3mVBg3MEephs1q6/rfwNcjVX7UujGaAhdaQ8Es
	 t32jBQIpa+hfW5HccrBD/DPdYbYpwe86JzR4ecrATWa82yi2TKyy9U6IurSwAFcDXtctE
	 8WgKh4Pl0w/gG3f87xSyCeVlx+2KBp9nGxy2mu7jC4FPUgGwTPtbF/2WuPZufCRLrznsb
	 1X0XKSVV2PyiOo74V0H8viEJDZGkUm6lBZSZGeQjMHrwyvaH5eakFbhOsP4sK+f9O66+V
	 ctpfB7n6BImtAOATYJCfUJ/bxqnNvmGUyhvmQmqOF4oPT6PkL4xXjAHUWZhBdTHH2yQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=p+ZT2gCC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792853253;
	bh=RxOqnGYHhoikl+/PxYkGD49N/tLXoVDMcOXic5722g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wN9Y05FoKBGIMmaB/quFz2zThREsOKwK+D6DcJcu9xzIWmH50LrW1iVoLLxTHTjcJ
	 5G09/M8S9op6QiBptFnEHI41ukP8lm48ipZvOX0GgkpTwAlCaq2PgUp6LxaKaFmKaf
	 464HsSnwzNTFz/t7G+ux+pjsVpN8nmUOxPobJWTeD7ztMqtqgBQUS/g1efUVyuJkmI
	 kbtZbfsxbFwNxcKePiianaULHwqFybLbwjRnJTwc7Cd/uGV1QdhD8FB8wtSi2hhtFq
	 Agj3fZCfUWeO1osSLr7GVQ4Rt2SbuVuJbWdGKjVUx0SJ5x0VSoBYc4N0RylNEOPwSW
	 EUWIxKrjwIMDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5F1981765;
	Sat, 24 Oct 2026 14:47:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5482279
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AAD3781786
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:47:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0E0caNSqzvw2 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 14:47:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D585F8174D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792853251;
 b=KTKG1OEITzVvhOuDD08QNNGaZc+SQspq+L6V038qCxWvsZeIsqD1OBrZtYqsy8tqK9Gm
 kKAaxDIfjzIsf4+zdV4rPiDMMBjo7YOYp0a+ClrjjwPbKwC5WZc7uqFW2SG1cqCspV0M1
 XUEZARCBdBumqPFCid9nDcAlYd1DMWOCmJ7n7zpWerTw6jhQ8AkoO8kAw1iWE70GAvo0A
 qWytKTKCp+P2LCneuvTb3vm89qQWrUVVjQVOiYpP+3X1JqSGdPgAxU3L8bJXv1Zq0ay90
 7cj7rmvLOF2VMDV0ReoNqBjd78wcIup+fjRJ2WpPEIw+xtiUny2U3PFI4Ewt/GFloZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792853251;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=RxOqnGYHhoikl+/PxYkGD49N/tLXoVDMcOXic5722g8=;
 b=VLShnMTQVVSW2H8fr8Fn53uyvO1qlylLN9IfOxU2hPkc4AZKKwUZgtQaq01K9UCNdMQo
 VKSHINDodCYVE5suRGaX7GbckG6rEsoPJ+esbWJ4j7/7mvln8QiOgJSUEeQQk8icElJqb
 GVqnWAM1iGX0MvBCijFPbvMQg1T9xrC8pdpmGy6sR5/PyyFTfE/kFQwC6rcxeJtQjyzot
 cuI+AuZizao98DZkWOxIPcv7c8RM20Q5EjiWpBO1sSbm2UR3TS0gYgzi+/gXd6L3XBPZD
 PPIpFLtyNAHCBi8ZMYx8CMI5jzSbqeJgGu0PHdTJpou10BmuOfyYLBVV2vMM+Ns9pcw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=p+ZT2gCC; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=p+ZT2gCC
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D585F8174D
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:47:30 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4a6fb4040cfso516223fac.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792853249; x=1793458049;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RxOqnGYHhoikl+/PxYkGD49N/tLXoVDMcOXic5722g8=;
 b=p+ZT2gCC1gp4/O40o6O7sPclGIK2DCLmwROzAuEUiK4A0zDGtRB104qi5epqR0rJdo
 QTxfsYfyGmvHnO7+y373wQvOHCbM5IYP3I5P9bdLxViXJyx6g2LDPpspFi/FK57SPc7g
 deDYeDU3/FLJSsT90xRaSk0VvLo2B6b4gewlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792853249; x=1793458049;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RxOqnGYHhoikl+/PxYkGD49N/tLXoVDMcOXic5722g8=;
 b=bXqRHy/iyeUqIN45JG86Hmv2+iXq9Pits4/ZZHGi10IX/evS0OkHvPfVzcZb7k0WkI
 /HpjZ75lnn3tls6ZBeddUyvENfkmds5YJ0V70hMYrCVWP06F3JB0BY8sYG7ivUOJG/6X
 Bliryq389seRVuo2cM1d/MyZx25Phj1WY+zvYqCH8oYCRMFjL25OjMhuKCtSqy+32cCX
 e9yce2djpiFyV9tNR54Q3k4aVFS9h4NhlLzsxLqlINkCdm6y2JPXnPOsVkD72leieHJc
 ObaTip+HhtOQJgVJbrCxntqr3BnzN+GMk/ZJstej+BybZPbUzdPYVe9EOQ4xQOKLnGYX
 FOjg==
X-Gm-Message-State: AFq9FYIqHU7+GipvK84K8jbjLR2jCDn/bb8dCjb7OB0R/qsFz2jjJcHO
 bPuylnGa2FBTQVqM8iK/T1oxCtQwzr9H6W29UJGxFy16d/0+QnR/OPWskVjNLzZQD/u4zRx1CD8
 x3l/+i7Fygeb9
X-Gm-Gg: AYBFou01Asik0/KWuXPt7V7Ty7wp/fWwqzWLVoc7z5DzLs4m3kWMcC8u7PsIjM1l7V5
 4REnJWykxr5s1H6SsT/SwW6weO4qgugYzwr0r7a/BpMfTJmPtlnTcKNPh6tBV/Q7lcMID1bUA/h
 lE/e7KABIiqXJuQCCBSjzI8Zz2kr+xulwztAt/AAs4AjEn9Be3OopIVPIemidIkUz+/eeKvf7EH
 gN4gHiy/hwyxkOYWL8mBBaPc+X6LWGD4KjsCmDWPPVz6bFqL/E25mfujd1gXiYvP1BAh7HdnGTz
 ErChArW0r+1XvSbZjvQZKfi9vMZXNsDb2Yy8sfr80lOdenqgYtqePZ9NPJ9xLhmqvGPdx9BEnmE
 WHokWNvdGHxDTa9XVVgdSJWZyH1H9Dwy24RQyi4gG7XIRRZKaS8ZNHPSJjIc/e6tLJNwA4yScEI
 xcEXdALWzaqIhq2f0oPuQkB/1r/ZuXYuS5qr5fxLOwkqvCSIsNkm5xyVpJr5Adx13kho4am/Yoq
 RJ1Oda5LkiMslsF99tfpyxaQkEoCnmEKJHOkPuFI4WtQEtsaKMIWCyB43v0jJHU6FCcdud9rjtO
 zDvQ+BXaEwRN4OCjdd4o+a+s8ZL/HC07o6TzmKf+DhzEfWTFb3gy6VXz5rmI8RiVqXKwwHAcMBF
 kKdrFhtaA0hRCTWuPxsG3vdaU6jfbpk+CyznUZx0u2snCqN208WmlOvz0Zw==
X-Received: by 2002:a05:6808:1204:b0:4f3:e98f:fa19 with SMTP id
 5614622812f47-55c00412351mr1224641b6e.61.1792853249162; 
 Sat, 24 Oct 2026 07:47:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c043190b9sm1346319b6e.17.2026.10.24.07.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 07:47:28 -0700 (PDT)
Date: Sat, 24 Oct 2026 08:47:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Bonny Gijzen <bonny.gijzen@q-lite.com>
Cc: u-boot@lists.u-boot-project.org, andre.przywara@arm.com,
 philipp.tomsich@vrull.eu, kauschluss@disroot.org,
 ilias.apalodimas@linaro.org, samuel@sholland.org
Subject: Re: [PATCH] arm: timer: sunxi: Check 9 bits for the A64 timer erratum
Message-ID: <20261024144726.GL3596691@bill-the-cat>
References: <49e2440a-dd34-41d0-97c9-54d556d16824.ad25712e-6d7e-4f0f-8645-1c3547348223.5fb96004-7554-4fde-a88d-0203c3c69942@emailsignatures365.codetwo.com>
 <20261024091646.95872-1-bonny.gijzen@q-lite.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oSv9S300UL9aFqoV"
Content-Disposition: inline
In-Reply-To: <20261024091646.95872-1-bonny.gijzen@q-lite.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--oSv9S300UL9aFqoV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 11:16:46AM +0200, Bonny Gijzen wrote:

> <html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; chars=
et=3Diso-8859-1">
> <meta name=3D"Generator" content=3D"Microsoft Exchange Server">
> <!-- converted from text -->
> <style>.EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #8=
00000 2px solid; }</style></head>
> <body>
> <font size=3D"2"><div class=3D"PlainText">The workaround for the Allwinne=
r A64 arch timer erratum discards counter<br>
> values whose lower 11 bits are all 0's or all 1's. Linux started with a<b=
r>
> similar check, but wider testing showed that on some chips only the lower=
<br>
> 9 bits read as the anomalous value, while bit 9 reads correctly. Linux<br>
> reduced its mask to 9 bits in commit 8b33dfe0ba1c<br>
> (&quot;clocksource/arm_arch_timer: Improve Allwinner A64 timer workaround=
&quot;).<br>
> <br>
> U-Boot still checks 11 bits, so these bad reads get through. A read that<=
br>
> jumps backwards makes get_timer(start) wrap around to a huge value, and a=
<br>
> timeout loop that has only just started gives up at once.<br>
> <br>
> On an A64-OLinuXino-eMMC this caused random eMMC failures after about 2%<=
br>
> of warm reboots, showing up as &quot;** fs_devread read error - block&quo=
t;,<br>
> &quot;Failed to iterate over directory&quot; or &quot;Card did not respon=
d to voltage<br>
> select! : -1&quot;. Debug output in the sunxi MMC driver showed 1000 ms a=
nd<br>
> 2000 ms timeouts expiring after 0-5 ms, while the controller reported the=
<br>
> transfer as complete and the data was waiting in the FIFO.<br>
> <br>
> Check the lower 9 bits, like Linux does. With this change, no MMC errors<=
br>
> were seen in more than 1800 warm reboots on two boards.<br>
> <br>
> Fixes: be0d21795222 (&quot;arm: timer: sunxi: add Allwinner timer erratum=
 workaround&quot;)<br>
> Signed-off-by: Bonny Gijzen &lt;bonny.gijzen@q-lite.com&gt;<br>

Please re-send this using git send-email or similar, this was all
converted to HTML and so not usable. Thanks.

--=20
Tom

--oSv9S300UL9aFqoV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatzE+gAKCRAr4qD1Cr/k
CrgsAP41UViDbojQZiQVyo4z5GVcCxpMmPGPLx5vl0WQ7aFQXgEApHIQqhz1G5pl
z699WpLRyNa+5fVqt4xwFJ+m5769vwQ=
=cXA5
-----END PGP SIGNATURE-----

--oSv9S300UL9aFqoV--
