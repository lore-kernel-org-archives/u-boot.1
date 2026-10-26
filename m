Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC2606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jSwiRglp;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=poa+4sLg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A820405D2;
	Mon, 26 Oct 2026 00:45:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fwLdwrgbBheF; Mon, 26 Oct 2026 00:45:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 63C79405CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792975536;
	b=Y3HacwKN/bhhnovhEevzzWPASGYBQucLj2hhF3D5VJYwApxNwgSoPpsqES+m7hkr/z1K
	 KdyEUPUi8rH/AR79T1wpXe9ht1pDqI9hEdHg9UPaOf7hPjDjMu3mGvhJWwfhLZ/WTQtNE
	 FH2gwt0eKbzToGOMzHgi7NlNybktL7C8+EDK4s6FO/g7dms6zIW1kT/MfDiTlUQITR/kE
	 Cgk5FoMqPR6V1JNcUBJzP/piJdtkDhGXSuXa7mIfavgGjoq3eUYFnTdQEpvYORlwTD29l
	 kXdMuyXel+meHj5u8tmELAleJoz1EXHwRSATJ2IoNeFrYVW5L8+5e+b5rCwSv58EmZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792975536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=go7zovBpb9zW1Ei0m0+w3NgqT40UubD4XITb1bq8XYM=;
	b=IqKvhmDJqBpP52idejAGAQInNx5OkHiCfk4qnYqBmkKVgqpXWPwAgtly33cayL12GAxr
	 i5pOofQczBGYQnEwvVz6M0R9VxZ79hrLpz5UBMzxZZk+1mmi29lGT8X8VAjmqsOedfs8X
	 LiWN8kcqXTHTV63TspzfBhJLmIDKqpfYea3/ImjyUo6b6y+RK166eFulQqA5Ea+h+mBkt
	 VZoAMHZUeTyG7DGCWdAHJWBnOJ20c6UoiKKXIy2M/Am7Smo+M54F7wanyIUrRp5p+hmVf
	 Gql0xQ0A2UIE5WzcFX38Zm5D0dD6IulVRe6nmGZ/0Pi/hOzAlxyFNyyJbvQq24el3Pg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792975536;
	bh=go7zovBpb9zW1Ei0m0+w3NgqT40UubD4XITb1bq8XYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jSwiRglp0fadpB6pJif/zvcGm+H/9oXQ7IXA6AgR082UFiPwdIXRJS4wJtRi1eYe/
	 +ghgi99sAl1vMT39iRkIfgI046s9v+KmQtgtdk+IPq18viXn4GcW0lIipgjrLgka5Q
	 s2yGK3MlZxulq5ngvSrp5MQTl+5mxj9hCAyN1e695qs4e9krieUUzS/KMpfa2+DB6U
	 Zgocy37WZQEWPB2Jkr+YnCdVmI0GKoJ9Mrxls/cUL52JyKFc1FMm/9dLaDWI9FAAPJ
	 OmIZ684rvTXaqBffo5zaDLSuHsgrFd7a0kiIKrNtlcp9SgsbuN/aXWoYCFR5elPvoH
	 by+gae4KWLZEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63C79405CC;
	Mon, 26 Oct 2026 00:45:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DA94334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0318580CB6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:45:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NtwaAO2mYvCi for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 00:45:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2559D80CB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792975534;
 b=bV+0V2Gq98A/0Xj89o03+oSPOJdFQ1qFNDbyBi9ZLRvtqxMTLAiAZSYKC7kBM4KE2D1p
 c3xFdn9jLcJoa6q8ZUpIlOe6+NJHFFtFD9+xHCehZOLwohYYTuCF5XHLryja17lQgQSx/
 u+WWNf7ZkpIAr2ACtRJKgBI0smcbh1wNn8IRaTN4GfFPR6dmEgzeKWM37qBZFNUPYrr84
 iaFyOQBN1V9UcYlm/uQgOI17I2bvgYRDw6NCA3tbpKDFsAVAw9m/WO48T1mtVBfRNSIBH
 w2plUGhj7tC3cO9hFTA61GvB4bHw40w42qk4VvKMh4PeSvM/r6CMQZKVyRHwLkSfYWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792975534;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=go7zovBpb9zW1Ei0m0+w3NgqT40UubD4XITb1bq8XYM=;
 b=SCcW2wTiyNYYAKgg204bkJgxvwnn+4hYw63ZYyWZlrossp3FUrswQQRWLuXhAGsM8Kww
 08OoFSsFJH6SnW86x6fMUew9UMlcKCKAx7H/sLArS4uxKCnwVBc4+9JKjc336dpo4pLU3
 FJirVTFoTfj3YB1D6FrafCszyznD5Hl9YB3HiLsgJzao3aNDMpXv2dArxqZ/6/e8dyElm
 AlQGoG+MpAIUwWrlS5/rpSaHoLPqSGL8pJ0BYPCpu95F6Y7+3qGrusZVKNDeio1th3cv3
 0TuLD04tZdnErbYwVGLsmbYqdURVllMB7SJlrIrUBx1tyl2KOyWrRoG2qtPwLgm6Hdg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=poa+4sLg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=poa+4sLg
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2559D80CB2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:45:33 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4ab8cb2a6e4so1933370b6e.0
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 17:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792975532; x=1793580332;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=go7zovBpb9zW1Ei0m0+w3NgqT40UubD4XITb1bq8XYM=;
 b=poa+4sLg5zO1N7BLjUt+KZvroR4YmAjnpwxKXBfGQWldnFFHxLKsTQgyy1M/HA1Vik
 e+XR/ktGUg48C9FyfVlou6aiP7M6n7V04CdBseHFV78l5qTpnj4xr4y1Q2n+IxKUatov
 NZeEgAViuMIvoMEivUqonDKTM0bLO6gA7BBd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792975532; x=1793580332;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=go7zovBpb9zW1Ei0m0+w3NgqT40UubD4XITb1bq8XYM=;
 b=qyhvuBkGqVIx4ReN/XH0k/+G2EqCP1qZwzM1xuL/8Ve4uFUYAmgh5OOhmspoPEj9Um
 zXb45GyHp43I2RpJJi7sGvfEAESZiFlrJ2RZ9K6g0aV7TBXH3fggIxMQ6MEZQK/ZZ/kT
 If+JwKRCpdmLkjmEaQKpKzkcesqLw8WLV24DeZeqsafujQGCV30656/hxDB1fH9RIVDL
 jZ3bZxunCrjQ0RQ8vIS+dxW+DceaZE5ghbI8jjY+ODg5xpSgZM/Cn0/kiCc3pUTf7eYq
 ZaHoWshDCJlApjilKTUGHJq9oeNadOrlI0XXa/NXY8HiLVXPxrpDVlBDyCTGLZhY3CCS
 omDA==
X-Gm-Message-State: AFq9FYJVaMMa/vQwi8O7q/eg668G3v6dsF6KzuTXEEq4qweFNLw6QSnG
 1VxW7gUq20EoQ8iNShcoXpOrP99Y1N5goMtTwsrm1kGGaXWv7nrotLq6ddhVmFMEClA=
X-Gm-Gg: AYBFou1CgivWCn6bMun7+NOsG4S3jCxin78pjxFAzUpb1HT48R88orou+N4Qp+Oi44U
 Be8i5ryCdRFD17wx4516gskW75jWMwBQDEh6oTkRVjVomEM/S2gaxEJ29XF78tzfUJdr/Lj3P4J
 ZIvD0ee4d7SFhpvxdaj1IwonQDZs7bLKfkUaoC/tktQ9ivNXorok59zagPR1VyG6yVzZez9K8l5
 UEP7dg2C0pPMKFSLI0ZtKa72BST+PvIQNnh6L+Ya7a70dYrfDOGxxSx5KtPTORpRrYBEdr+zP9X
 2/bVN8cNFigRnHbknbhypTmlsE9oIuRrVUaE8XXwIAz8YtWNkHCXh2NGtAu9jwu6vRE5f2fUxyW
 JlhK/LWRLubJGz+uQSxOIx4jySEvf2AstQLrHF8gReiNoZtfP6TESEf6b3zHDGs2QCdjIO6Wx26
 ILrKAMoGCzy2BvUev5lb94WSTvqvgDGGX75NjBp78S7IinhrfrAv6IjjoHYzIKCJ1fZtlBw54ub
 yg7AuKgBLlk9EngAUI1TfQmSbTw7np4OZXdgrkWOwZERp8WFCKuyObiBIN3tp8PC+4IH1E9IWiQ
 cjxoJBtSpuXkRXyu7aqtlTJp3Tqs8/0tIJbRyko5T8fJFK2AvRwI8rI5QRhLBISDTOZ9D7JxJL6
 16sJjy+wKUol2MHNs3ZyzeKUB87UgXvFMuzxB9+yPOpEMQYbkoQEpOTEzGw==
X-Received: by 2002:a05:6808:c40a:b0:4d6:90f4:48b4 with SMTP id
 5614622812f47-55c0039dac5mr3607962b6e.54.1792975532594; 
 Sun, 25 Oct 2026 17:45:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c040806a7sm4144632b6e.2.2026.10.25.17.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 17:45:31 -0700 (PDT)
Date: Sun, 25 Oct 2026 18:45:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Mateus Lima Alves <mateuslima.ti@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 3/6] configs: ls1021aiot_sdcard: Reserve 1 MiB for U-Boot
 in the SPL memory map
Message-ID: <20261026004529.GB329625@bill-the-cat>
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
 <64aa14e2db0472120fa3a6ace2e326ccd0d548ac.1792893601.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dLez8MELGDYE5hK9"
Content-Disposition: inline
In-Reply-To: <64aa14e2db0472120fa3a6ace2e326ccd0d548ac.1792893601.git.mateuslima.ti@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--dLez8MELGDYE5hK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 11:00:09PM -0300, Mateus Lima Alves wrote:
> As more features were added, U-Boot for the LS1021A-IoT board grew
> beyond the 512 KiB that CONFIG_SYS_MONITOR_LEN reserves for it:
> u-boot.bin for ls1021aiot_sdcard_defconfig is 604 KiB on v2026.07. The
> SPL malloc pool starts right after that space, at 0x82080000, so loading
> U-Boot to 0x82000000 overwrites the pool, including the struct mmc used
> for the load, and the SPL takes a data abort after "Trying to boot from
> MMC1".
>=20
> Reserve 1 MiB for U-Boot and start the SPL malloc pool right after it,
> at 0x82100000, as the LS1021A-TWR and LS1021A-TSN boards do. The same
> adjustment was made for the LS1021A-QDS board in commit 7ee52af455c2
> ("ls102xa: Adjust some macros for SD boot on LS1021A QDS board") and for
> the LS1021A-TWR board in commit 9b6639fa85bd ("LS1021ATWR: Modify u-boot
> size for sd secure boot").
>=20
> Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Alison Wang <alison.wang@nxp.com>

Please follow-up with enabling perhaps BOARD_SIZE_LIMIT so these issues
will become link-time failures in the future, thanks.

--=20
Tom

--dLez8MELGDYE5hK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat6ipQAKCRAr4qD1Cr/k
CiTzAQC4XqU7p1KiildCd+y5w/oiX3HcIV71moWHKnuG6+KDLgEAiMtlBX8DbdQH
AkKaIfj3R9w4VMbX0bbARUihUPUxGwQ=
=ZTlt
-----END PGP SIGNATURE-----

--dLez8MELGDYE5hK9--
