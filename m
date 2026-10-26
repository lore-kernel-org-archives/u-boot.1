Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D4606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T72X2Mau;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LkAi59tG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D6EA80E07;
	Mon, 26 Oct 2026 14:20:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z6WAdlJJS3XR; Mon, 26 Oct 2026 14:20:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5ECDE80D7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793024429;
	b=bhGbjmH88TKsfOVJBeOBmxPGKa/OFFzhCcrt/oGyMHs5xKfVvHfI+QoBCWJ0ANerExF0
	 YJ1LBeufUXysKGvfvyxLMDM3du4EMF/CCPwIsnVnTqY0jmTCq4+nJ3MtkUXWHLrFk5cQS
	 NkWbKOzpwni7VXeegzCaP9F1cPI5Kub9xzboiRjttDAvc47QlYHQjjJXtQmuBr5d0e+EG
	 mdAizLnbDemQbzrAMz3YY39MiUpswNrURGiYuVnZia+AfweRQXkAd82y6EAo5FDw1dyc+
	 75keZaeQAvyNZiZPcYxhyGGYa2jbHcPEu+5dp7lw8/38lQ0NK4HAwB7hSUPUAMbnGyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793024429;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K7VqKiuFHyCOfZ23g3lMrTVeW2Ksk8XBNBB1E8D8Ask=;
	b=Ve36AKyFSL3xMoblpSJRuzox8JAB3E3b9bqrCTGZbz2BqRgRb+0HOUUMYTaVrz14Dguh
	 IJ0M//IW7n98w+2VyvYd4uex61OSvGtiqbagHYNL+Y0yHurLUq148RbQE7fRk5HKjN5ch
	 4OaaTqFQu+7dMLcaUyHDkUogPtSHRj1wArOt/5MjHziieFNLhOr5ZjK9xyjjzASwJRCRG
	 TMFhxI8JR9MVW9HqeMQLrTCCsD3Gn7VMpOTTkywhwdsY779sL/VumX0nXhs0oLV8gWhy0
	 DhUWgSAd/bZQmgU1/F/NdTaTS4uw38GhPvJlW+yRh3mOL/yh1OppDzYjmH5CZ/6k+Ow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LkAi59tG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793024429;
	bh=K7VqKiuFHyCOfZ23g3lMrTVeW2Ksk8XBNBB1E8D8Ask=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T72X2MaurYSBU0uY5/4cj3WHw9FzjY/wl/eSOgr6+NLaQLesl5RfwOI5QhbFlUhAd
	 1TfENx7vczMhGkAgOfL2gbFSEAT74UathTNBkP01baoNlIovxmqldzKY23DzTR/TJs
	 yfmjVIsBqzZZikqCTMvijGcW9TKYv9rdOi7fiasJB5YejW7BFy6miZQVBSO8Uow4n3
	 7zb/CONYduHrAnXyJD5F1Dla7avzWmsrALaajzRY3boWBLuKNcVzzBeli3for3tAgv
	 tB1QvoexLs5JS7d+/FombT30wYaIVku8YkmNCVi9rLIf8JPq8VtHGF1FarbECDbN3i
	 weeLlXvSrcs0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ECDE80D7B;
	Mon, 26 Oct 2026 14:20:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C464D279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:20:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1B1580D7B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:20:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZPy83RmuTxd for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:20:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D8A3880C3D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793024428;
 b=kP1cffiqXxa4kqmgGjz74/U1bfaVfyZsRH1GTDfcydYlSR4OZv4qmgZywEdvTDG/EpJ/
 oklPrjLMewGJIELiexrERUwXE/tDKSlBnxohtscUlaqfC42JDUYg3dHGk7CWqB3/EzHsN
 H6NNHlMB9RB7hwGP+qOnWoLzkgrN1kvJaAm/5EitNai9yAFLBshvX2tjuJE1Vomxi3snV
 7EWP93RtxOm5XtpWsBy5VFx3oQvXvR3iQqs+PpNDXnO8VEyOuQdbEwr/hWl1hk6EBtSUY
 4DFBCPP7SFyQoCf1FcabUxk3YPbHIHRw530YznCtn51FayeZXIf2tpEwjSWb66AwmSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793024428;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=K7VqKiuFHyCOfZ23g3lMrTVeW2Ksk8XBNBB1E8D8Ask=;
 b=ImbfK2dAWlR/5XlU/la9Zjk1qASoxIFjUFPJRlgUW8C2I2fG2AJT1E3GAqrHgqLUWOu6
 psaMRxNxsduqnAiqRizXzIacIJ1nnQMgBDjriEzbj9e5ryGRmnQhGEdVmsx+8PmLsgYjY
 TQMQJhsH4ZUtkwmq3PRFvN64G0jJ6mJqPOH6z9iFNJAj0eufi19rRWgvi6qh9FZWowdRB
 yAgS6LYsAbQaVPjX5zE4w4U7cwE57HUPkvWl5scM/5tKWAo5TG0qZAXfr0zsgxwHsprzz
 JXAHbqXD+JDgbTGNGHbjHiNt+KM2B4gt7GdRqUZdMpQ67peMBaDaLJo6g3LD09FM8Ig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LkAi59tG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::b;
 helo=mail-oa2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LkAi59tG
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8A3880C3D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:20:27 +0000 (UTC)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-457e289483bso77802fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793024426; x=1793629226;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K7VqKiuFHyCOfZ23g3lMrTVeW2Ksk8XBNBB1E8D8Ask=;
 b=LkAi59tGtRCqQio4lDPy4GjKGgothfpzxzgQU3ALWmP+ry6lQOCmXx1+tJdoNWx42d
 YiAj8wr2WygnpiVFq9XdeNLdJjNuj5hkxGApUCplaMBnzSUX8B0ykhQuyvju0o32PgBB
 rGOc8g5isySY/gymAKE0TwV+kvgVQA2tH98OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024426; x=1793629226;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K7VqKiuFHyCOfZ23g3lMrTVeW2Ksk8XBNBB1E8D8Ask=;
 b=0MqRJOsY7XUSAG89C5uEsGSXOZ64hPE3KAkmrCTOB4DzvKX/JEoXFKZMasIGNXlGnP
 s124ThHwtrbYA+sojmxVEo1qjibPnnf6TdpK/45GLpAOZmWJ2hd8EDjzbl9prUlSpwy5
 5eRafQZdzzPUj7tSzvvN/AJzOEs1TavXxiHQijhgHEXu8PzSKtqrEEapD1iRyE/cNOG/
 uPWumvjiQXwPKk6ul/we+sZVUnYFICK3mdbNdpF7sHQj7k/IIrAPjelJB+hq7JfC7mGZ
 SNkTnKiRZvOqDtbl6pamM400hrSPiOdnXSJLgZtFKaoToS77hWRoRVDQ+aaNxf/USdoY
 R3sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbCDkc5jIPIZUX6V+BxV+tRTwk/XoyyMerwKIMxura0qw74uL59syJAPd1UY6mxW/df2P03wk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYITMC1hNOvGgES/RXiwUkhSaA3XdZxUfiuazjuGteDCKCIgzfad
 G7W8ky8GTv+p02KsE+quLkbeIEcBzgAXyXkTaXZzAWCAKEa8L/MQkpJsB17ApPHzWkI=
X-Gm-Gg: AYBFou1DXW6DpbNGDGA1qHsrqzTW4yvFinKHJxUes2M0iq6tMGAHCyXeopAvYH9CTi2
 q0vCJAOC7jCfPD4Jv2YIBMWGKDQrpzbDUXgzZIbdCkExOKXtIs3hVNIlND9lohKwoOR34uUinB4
 u0LFdB5SrcLTHulRSwLW3+yupaGJCw6oULuTUKfYrw4VcJfz0XICpbNfVvTiRZoxy4gEEKxrB3T
 ttsdTk5A4VkQlR7m18aEJ9HFRsC+mugYrCmJXnz7JKwd4e+o3Cov2cwYT9pvVzOECko0lAFr4v8
 WOmC/NtADjz713yE39wn7BCnnulYSGE492RFX89CP7Oo+p7boX8R07aYBjIqfuZntxEQZsTb014
 vGTXI3N8XvJuDgH6pcBVUnP9iVRqexxpHchD3DPMdWOFcydBoczieHfe1vmskCxESwsYt1f28O2
 +yOFWDn9Byabx5OgmwgoAhU2mxj69LpOZaokYb3nWovtGXytbIJJzYiuE7gQSvTz+9QyRRa83ZE
 QNMCDHpWxhO5pkCxhzVygJSs85Om53ZWhuemjtrzxgsEVYWRoMe4bGTGrEAhBISo1pbZIATOU0y
 HB73gpeZSSl9Kye7UqmUP0/HsdFMrzXFDrP17iXVUAOnEY7HasPWD/VIXUpXps4bX1VoJhUQ6C1
 IkTBe5TyyIStDn+X/ErohcEuxAanUBrUDRyKfyINs0kIKBnTaglQnP4IBuzE=
X-Received: by 2002:a05:6870:d61f:b0:4a7:2baa:8701 with SMTP id
 586e51a60fabf-4a83f9aab83mr2899848fac.15.1793024425903; 
 Mon, 26 Oct 2026 07:20:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8428e8b11sm4514622fac.0.2026.10.26.07.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:20:25 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:20:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Vincent Jardin <vjardin@free.fr>, Peng Fan <peng.fan@oss.nxp.com>,
 u-boot@lists.u-boot-project.org, Sinan Akman <sinan@writeme.com>,
 Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <20261026142023.GA624796@bill-the-cat>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vDXnft6tjn/eRMiT"
Content-Disposition: inline
In-Reply-To: <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
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


--vDXnft6tjn/eRMiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 09:25:25AM +0000, Bradley Morgan wrote:
> On 26 October 2026 08:43:32 GMT, Vincent Jardin <vjardin@free.fr> wrote:
> >Hi Peng,
> >
> >Thank you for applying the the lx2160a series and the other patches.
> >
> >If the powerpc removals need more time after Sinan's remark and Tom's
> >request to wait for the board maintainers:
> >  https://lore.kernel.org/u-boot/20261022014554.GN3275858@bill-the-cat/
> >would a pull limited to the first 20 commits be an option for rc1 ?
> >They are below Bradley's series, up to the commit
> >e7fbf8d2233 ("board: nbxv3: apply sd1 hwconfig before MC starts")
> >so the SCMI, fsl_espi, pmbus, ICID and SerDes patches would not change.

We can always take fixes now and dropping platforms a little later, the
merge window isn't as strict here as the linux kernel.

> Tom reckoned that today would be his merge day on IRC, but things could
> change, I feel these board maintainers are deliberately not responding
> tho.:(

PowerPC just isn't a very active area and hasn't been for a long while.
The general rule of thumb for non-urgent changes is two weeks between
posting and merging.

--=20
Tom

--vDXnft6tjn/eRMiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat9howAKCRAr4qD1Cr/k
CjWWAQDkf2+5uBiiK7Mo4Mh3HXYUVdwnfHVHIVIg34RiQvc1kgD+O6g4AjT9De30
cxm44tZ6yYp/1J+2dgJ1Rx8J+UcSfgo=
=9pgD
-----END PGP SIGNATURE-----

--vDXnft6tjn/eRMiT--
