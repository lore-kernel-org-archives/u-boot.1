Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D16C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 07:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E9D6811FA;
	Fri, 25 Sep 2026 07:40:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CjAu1nhNi_eF; Fri, 25 Sep 2026 07:40:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A5A7E811F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790322048;
	b=LL58nfsXBHD0L7oteclTZtj8l5HLtdY79peATDYP7exf6JedO98RGJw0hGmTxqQnTpAM
	 3ohjDjUJwUEpr7yP6j6UPCsn70EM+SqdpePlsvSKw+Xok8mgw5RLLXAm5FFRIGB71FzWx
	 vMIpaIH/pf9g9no1bPJC2tDPXelxBhK/4J2n7P+ax5BmOq7R48qKRB98d8B6NQR9qmhlp
	 a0mFrzq8uFROEFYlGUmmD77nODxb/UtMkAZ0VnpnfnMsKLiXhZVJa3SW+flL7KJ5Uin4D
	 3RquEdwYob0rwkNS+U2SZk5WD4Xhj8xu9SJdbNwdogqdgTUEyGHFP1Qzv8RWrvs2gMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790322048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Bo8wxjYpADV1G+L6krpvlQtrGLEOvJ1Ry4CZV4lwEsQ=;
	b=m4X3KBm3IvkHo2X74raXdyqsO6FP4EMfdvMy9V3td76tjS48l7vsR/MSvNQ6Sk1xUJPZ
	 YOcBsyB18qluJGIuRQCdCc4Jp9g0VG+jGp1usQZ75laYKklNYZhvcelwxUY2RR5mKaDP9
	 MqbDEfMsmkndxs95nfvFPhzXXf19M5ymVc0asRCUzpu39wtsiAZNOs685s01J/yo3tDVn
	 FMicdPdt/D9d8bIFbIql9ma5p3S1LoXB2RYRCs6hbGKrtex7qEEd0Ly4+lUlSkyr1fooD
	 l9cqbapeQrVL+F4WBoj9ytsuFlgPKfB2AGckkcjZ6GEwMZvETEf74e5IOY0wFgyf7eg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790322048;
	bh=Bo8wxjYpADV1G+L6krpvlQtrGLEOvJ1Ry4CZV4lwEsQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C/cEs75Nx2FFo4LYVrjto8T5ZVGXOuiJyEUw0pI9K4CjczvDEB1GFM9gtht1B12bn
	 gHgD5sXMVGaoQbYEWAPusRQWGPhp/qzyXBuktQsi1cCrtJsqM+YtuOPqFAKDjNLCHT
	 L0L4I3E0hivH2x1Rsw/QHSKmBIO1bam2RVs6KHq2gZh2OiqevtZI7c/Nue12SZ5n+t
	 SIYj+aCfbUYBKtFTkdjSS/ZwmvhgyFwspm1TBMZ7/iBemtDWz6jOs/xU+qSOiFOgQs
	 PKs/kfbtz5FEbbuAKW54OEm3sLhBkzefARmp4za9+f2SWZ5521I5gNTrnRPGIdVD5e
	 K62xVifewgEaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5A7E811F6;
	Fri, 25 Sep 2026 07:40:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EE544194
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF9A140122
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcMzJd-qvmiq for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 07:40:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 30222400AB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790322046;
 b=f7etKvLQlvdC+PSNJzoi3qUkYhq6MxkigmyO2rxeA7abZZTfs52lQ8EWBI3PpPoyb8An
 LFUn8+A4TL6xAZpUXPUm5yTe1GwBtO6fdib63ZZrGZ4K6UoSviMLEeGSjJMJvCr6RGJvd
 2zAW59Ta/DGC2pX7lrPV4+HuuRYB0LF9krE8MwVw9FYIqIRTmY6MTXY+qwheeJg7u6pVN
 vdSntBb+oNndOyBdtgbNZ9OpNyqUYx21a9gCtj3+/SS3Z5bYb3JomwvIHCDTRZTWvJLmV
 TiaDgx1/9afqjL0kQ83/4RA3bHEcJxq1snG4ckDMe/ceCxwle58qcYu34noCCGSl+Bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790322046;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
 References:In-Reply-To;
 bh=Bo8wxjYpADV1G+L6krpvlQtrGLEOvJ1Ry4CZV4lwEsQ=;
 b=UqDKlDFAOdfBG27BnyWcu+zaXMG0Fhi9qDwkfk7a2GpPycckVOGqNt0b5fCwYqcUkDpZ
 ck8LOFyDwzgCcg5CSTDWus7znyy8A8oUG041DlK8yIQtxIXIJDrVhRM91u834JG9OfMTX
 mF4+ArMO1KauzUvJrxEJNXr3zPhl5ndxIwaaLAK/7gspZjV4CWZTAVHOJgDZh+LiHmGyI
 P4kGRvs98Bhcd78DdvYE1GAXDLghuk8r4XkEBMaq29/hVQ04B31I1VMuin9LCfaSTtXxl
 cwvTJtC2M5+NbBkV/tPE5UDoFlab3oM0DHjV+mXQHb5t2LNYc1ZS0qQghabcA8A1XdQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eqV6fHX9; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eqV6fHX9
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30222400AB
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 07:40:44 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f63546c5so428412f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790322042; x=1790926842;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bo8wxjYpADV1G+L6krpvlQtrGLEOvJ1Ry4CZV4lwEsQ=;
 b=eqV6fHX9+mft6spnqrC0Lc1e6e/fVR/g9zwX5IDi/XJhbSgL9h53jyfB17HTHD9CXG
 CROgmJqyy8+2/IAHf0t3wIVa+iLFqz0OKBhHbTkinmfT972F9jOt9HCLjP4FawJlflPB
 lNYbT4POUZKkeCO4KGQAEAbB2cppDbi5Geob9A98/CtnKYPWUYxXPhv+2yz0eGOkgTDY
 JIJuEBaWNCqGYQvd++2J5cSPevDSUkVr8zUZ+yw0zId8ft7agv3apJhMEIn/rgV2fjLb
 P+U0a1RBeEdEk7NckH8ITGPABk6SxF1gSfHuS3N/YSGVPBYnHuts9vE8emXHoNg63ARe
 LmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790322042; x=1790926842;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bo8wxjYpADV1G+L6krpvlQtrGLEOvJ1Ry4CZV4lwEsQ=;
 b=hxAURXOJZ+ABO9xD8wNDXcpjdgXyEhNx8/b7yt4FMhcgjDX1lAZKHgnPr5OCrYA2F1
 4IcJ2/9VxMV/YrG9S75Dc6/H5c7pJCbjkn/HIHqQ45ItgT9mWASG1Lf8l1FBgp/H5jdv
 Y7gulkOaIf2OzNc2XBpADXtw23pjTsnU/IUP1MefYLgq6UWwdfFFCUqYGI1RD/iQ3BWW
 R2z0AzhUSk+AzUpeJdXt1Ra+5FQV15ozdAjoKgzqyIK93pv6HcUKGPxr1ILxREhndljW
 gKIX8C9tMgEeGd+DuRdBkRrVxrj+p+E0di7fZ+qU5+sw9lpgLZI2n5P05obVznbuU+PR
 X4mA==
X-Forwarded-Encrypted: i=1;
 AKwUvByfF1oIj2S7pUnv5ALVENOvpbttKk8NX3T11GKwCMbcsCsQTW10FjbAzexNsWEsfjB+JPEyuOs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mm0XepGLEzO/q0KMWjnxiVc/iz2F0rHg95+8QP6n7lsZsFxStE
 wGk2AgDU5wwZIx4HWCcq3rWGo58FYZUfaUXaz/zG0SnyjxRnhXFPag6V040ogLm4h5M=
X-Gm-Gg: AYBFou2nosRNFUq8vdyYxVPamORR3K/Nke3juIbennD6e/pvUioAMnTaaPBJ5VbTSMj
 uoLqFc5QdVBmXNqVGURTqahIb2IiWwpMSN1g1ie6mkoUNXxqLvDKFlvurGo9SwWXgyq7WCUw9xa
 LgFN3phcqfy3FAAvx2EWHaAVa1rLtR9eLQ8MH7km4+7vYvjQ4fW2VhqtP5QAOzFKbRhzKv07utx
 ooGLVNZqatDIRZGD5yP/H6a8NkZR+ABZTpAvwjG50N7SmHUOxv5Yr8uCPYXXrL2gZwn7WbZvl6e
 eyLehwOn25OE4AaG0NCOvbzDImpfJgJcIOuRPcXq19Z8mTJJhxXuMw80je1zM4rsabKY5OTQqf3
 5PpjRTH4oE7qmY1mbbc0iECEFV97SrwFv4FP0dVx6QxivJWS+pe7slyfHfNhE5aMEa08r3gc7dj
 5h3HNCeExsieKtRSJRYOw2vu3WHZRoltIh2XPq6CowyQ5W2TwNA0vsJhMv1zfd5qD5
X-Received: by 2002:a05:6000:4028:b0:485:a394:58ef with SMTP id
 ffacd0b85a97d-4887175f884mr9427825f8f.30.1790322042305; 
 Fri, 25 Sep 2026 00:40:42 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8223:c4e6:4d28:61c:74bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a638sm4726122f8f.9.2026.09.25.00.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 00:40:41 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=06fd7e860d12e29bbff4c0d1020833a38ecf1f5d72fbc8e506bd80f0f35f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 25 Sep 2026 09:40:18 +0200
Message-Id: <DLO86T747FHQ.2NF28TVL3CFX2@baylibre.com>
Cc: "Tom Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Daniel Schultz" <d.schultz@phytec.de>,
 "Richard Genoud" <richard.genoud@bootlin.com>
Subject: Re: [PATCH] arm: mach-k3: am625: Wait for TIFS initialization
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260923-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v1-1-300ddb9f5be8@baylibre.com>
 <82208a4f-b91b-4415-8173-1272189e372d@ti.com>
In-Reply-To: <82208a4f-b91b-4415-8173-1272189e372d@ti.com>
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

--06fd7e860d12e29bbff4c0d1020833a38ecf1f5d72fbc8e506bd80f0f35f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Udit,

On Thu Sep 24, 2026 at 3:00 AM CEST, Udit Kumar wrote:
> Thanks Markus,
>
> On 9/24/2026 12:40 AM, Markus Schneider-Pargmann wrote:
>> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
>> the firewall on the registers at the end of initialization. On HS-SE the
>> u-boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
>> leading to a race condition. This leads to a broken watchdog since the
>> signal configuration doesn't succeed because the write doesn't take
>> effect.
>>=20
>> Add a get_ti_sci_handle() call before ctrl_mmr_unlock().
>> get_ti_sci_handle() leads to fetching the TIFS version which only comes
>> back after TIFS initialization is done. If a response is not received
>> get_ti_sci_handle() returns after a timeout and continues as it would
>> have done without this patch. get_ti_sci_handle() has to happen after
>> spl_early_init() as it requires DM to be setup.
>>=20
>> Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@=
phytec.de/
>> Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti=
.com/
>
> Here tom advice to include all platforms
>
> https://lore.kernel.org/u-boot/20260226143756.GC1593142@bill-the-cat/

Thank you. I am aware of that request. I can extend the series to cover
all, but I don't have any other HS-SE boards for testing. Also I changed
how the implementation works and wanted to gather some feedback on if
this looks good to you.

Best
Markus

--06fd7e860d12e29bbff4c0d1020833a38ecf1f5d72fbc8e506bd80f0f35f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCarYlYhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMq
AwD8Coxoq3NNUSBq4Gp7bG2ARvdVpn0rESirgNWVDaFkq8cA/A0o7svoJ+nYdS6y
F4XbXuaCtnSdY+r4bpXhnfbp1+EG
=a0IQ
-----END PGP SIGNATURE-----

--06fd7e860d12e29bbff4c0d1020833a38ecf1f5d72fbc8e506bd80f0f35f--
