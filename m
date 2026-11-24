Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86432606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x7Ssje67;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZQyVnwpv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EAF860850;
	Tue, 24 Nov 2026 15:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vwWpG_8yJHEZ; Tue, 24 Nov 2026 15:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7248E605F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795534238;
	b=F8ntdUxZnLazKDb/Lr9+MMzEpMXmBSI+Y01OO1ZW6jW7YE5gCyaRdkQL7gQ0yA64v/hA
	 8VPH0Urwvp76AY8AQc276J90srI30FKpw2GAbsDVsH+qsZqwgg5MhCfCk5UItN4uj/By0
	 mulriQ9HCvPz9N3MC7O8osrDj1lSX/42TSJKFUJNlVVBhkqIHxTUsu1ZL+dJItrGrTbgg
	 fxgEtLjKFQV9lvqK4QFH/CeXsO1G4T6SDcU5aBtKHTiBhDLd5+GV162/kkftd4qwnuY/t
	 GE+xFaPmrMMWJSZgfiJiavVCvV009to3fVo0cCN0KAvvYNZ7WeUEFobNf3EbUwfeidA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795534238;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ohDJNSPkGwSwiB4bgZWmwhJb7BGQBhKv+U0/xu+Jt64=;
	b=k9wMlLiNthhbhoCctKmEkRVfcxQCZEgNHqo+XMulA1e3/T8vxsxKJuq1uj/s8SEPCeXw
	 T0dgqaWouio2gDBL4rFzvhNpxWGFD27tc2ayjByCvuqd4xYK4g8cGYbC8KRfM1yMd22hH
	 K/tyoyNIDyDL+KVDxRVBcwvI3f/NLTsyfxb9FPCw+4tqRpTZ7R3hNWtjjgA1mCjC8/0D6
	 GVIJ8LgwRfArSQyx4e0wL2hYFAVWonGGDWAC9xSNvBqp4Q20/1Zqq5MB/Mrv3SVtaoXGl
	 D4QMWqPgVI9qTROw8+lbwBdR4R9uGC20QlWiv92cBIn5Gg/xlush2gtdVMIBroENrvA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795534238;
	bh=ohDJNSPkGwSwiB4bgZWmwhJb7BGQBhKv+U0/xu+Jt64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x7Ssje67Cyr/Zmk+LCTIZtEQ4d7BTIeIV/q7+SeUZfkABDXsnHUOXwOv64yk3r0CO
	 k1GOvSykpUQgeDHcTcEeJn9dqxOO1fPlQffkb3VcHXvDpDSBGNscY1n34ih5Hkb4AH
	 yOz08SkSExhVyqGRamCFL16UcRZxmPaVBJF9oE9cR5w+9Jb8WT48KJaZGtszYLV0ka
	 9028YBlQfL97ULnZn2bbbB9BUSzg4DTUSCExMbXddRFmtIAcQNrIyRX5YBiaBId1WH
	 pFg36s/7t6s7OCWUiAIPPnF5LfjpzZwXuXbJyMSru1bGTWayJMD5x5LLlUXHVztb7X
	 v8DUoIAkw0s0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7248E605F0;
	Tue, 24 Nov 2026 15:30:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 125023C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC72440116
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFoEoeCD1Jiz for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 15:30:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9AFE8400AA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZQyVnwpv
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AFE8400AA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:30:35 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-53c156ba662so2578354b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795534234; x=1796139034;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ohDJNSPkGwSwiB4bgZWmwhJb7BGQBhKv+U0/xu+Jt64=;
 b=ZQyVnwpvqvk5EFMT4QEBkEzbwKhKnHpLYq6AhrWv8xlD4RD1u/oqBgVedlc9lIXmc8
 Unx2UOGhWTCFRJfe9pHGpJ25fJqQDVSk13q3lBbRpPMc1PRk5CKflQUCyeRUjJw+bG3H
 AFgxQX/nWFtOjjQ/jt11rkXBVvZyRauZ0h5/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795534234; x=1796139034;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ohDJNSPkGwSwiB4bgZWmwhJb7BGQBhKv+U0/xu+Jt64=;
 b=0fYV2PIW6v7Z5O82ScEUwyquz+8e0r+DOAHK3oXWYboTQTJR+LZzgmBPfxfOeabIOV
 QfmhRzq7C6RUK50eAI708r8T4Ud1wvfDsW/6v1oTdD+pV7U073Z6KA1kqf5zG9+kHr13
 /z5PYrR1TIWEVhzotYZxuu74zNTFTAGxYkYdQFl6bdIWklALx5l6KfaaaDrRbWwuvfTn
 xaJJ2nzwM/25KF08sj93J718RMhlOO2feE5nfpnVoRenywYXQBvtJfvaTVaYJLliggOS
 zvH2cbKgJ6uxiJrRd4tmYWISG5d9QjUaU4ZZIRZuC/HQhzQLe3ozKGTS0mec/vLb6D/B
 yHrA==
X-Gm-Message-State: APuU4Z8FeRobmHEUAkziUNW5VZwVG4taiRGCPFkZizCNDEC6iJf6hh7T
 kBzl7bfs5Bc+fH3e7u75UFN1CNjoEaRk/H9nhsQeo2BEs5+d1mzSBuJCeViXVpO6CKksEs1TN4y
 WWpT9uXQG2u+9
X-Gm-Gg: AZFdTZdg/Zi4eY8nUXHYV3sXyCJN/86aZYrCRk/DzNBTuFa45fKcv1deUDVG9I9Z0u+
 C53/0xIOubwQMRiJSgMtk611QEKg8tX8HoIkh/4HqcbdygXfG5lfwag62ag80RWa9ZAQMkW7q4f
 OmIFwBDUSvo6rJttubhNUdM52xzSCE+E7ytfjjfHO1aikuLosX/JyMv1GA0NqRsdlImr5tbaoJV
 /LYjxi+P0tMAOOtJyDJ2fC3XJEzwPavt7PW6+dXxlEX1aaJ7HHyNvAUqmCndCo/SjySvbhK0KW4
 kzGl/7iD0DEWTKY2/PuNxTxk/NsePeRIqSfL+b3siiD3m58VaKKZkuPpdV56dmLoEJ3ijEgIOft
 NHaQngtajmlTab1ZK9ImlCEM5s2F+U5Q/aSbNuvl3pL8OdQnKWeajAupR2T39mKYBXyKXY93ChD
 yT7QYG4ZaXaYAyi/Zu9tmOAMEJmDKaSw99tO4Qlfuq27+LU0vYDUHPMEHfiTkd936XXcJbAJ9y1
 66gOvAvgBSh7JvUxHW6l6HRxfWAP4Eu5fBWdaJ/aeRujQnHlq2iQIPJg9vCjKHnNIH8E8by6rrN
 apvtAMvBQDQ/7Bid/E1st/b0VdC/QrEoqvUJyUOR5dwDSXUDf7Pdlbrn68PzRAeIEQ3bjSV9FxO
 Xv7oQRVS3UCrQLETF/ZhIRLMGD23090J9zD/pE+VQM+hJEtEcbXPrGFyUDRkPGOTf4KO5tfiZf7
 bjKXmv5bbWbZ0ERLomVwqGZX7es6UY0EHCcwe2O8hWZJ5+Q0kV1sVl
X-Received: by 2002:a05:6808:1484:b0:4e4:627a:e0a5 with SMTP id
 5614622812f47-57a0bb6bc73mr16573944b6e.40.1795534233939; 
 Tue, 24 Nov 2026 07:30:33 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34252987sm11350401b6e.4.2026.11.24.07.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 07:30:33 -0800 (PST)
Date: Tue, 24 Nov 2026 09:30:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20261124153030.GT3176972@bill-the-cat>
References: <20261123223805.GQ3176972@bill-the-cat>
 <CAPzfCAbS0nULr+fVHd52LdYY2CrBYV3wWkM-g+Le+pp7pWnx0A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PB3yi3pNGZoS447y"
Content-Disposition: inline
In-Reply-To: <CAPzfCAbS0nULr+fVHd52LdYY2CrBYV3wWkM-g+Le+pp7pWnx0A@mail.gmail.com>
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


--PB3yi3pNGZoS447y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 10:31:34AM +0100, Igor Opaniuk wrote:
> Hi Tom,
>=20
> On Mon, Nov 23, 2026 at 11:38=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > Here's the report from v2027.01-rc3. Looks like the AVB update
> > introduced a few issues, or at least things to investigate. Thanks!
> >
> > ---------- Forwarded message ---------
> > From: <scan-admin@coverity.com>
> > Date: Mon, Nov 23, 2026 at 4:33=E2=80=AFPM
> > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > To: <tom.rini@gmail.com>
> >
> >
> > Hi,
> >
> > Please find the latest report on new defect(s) introduced to *Das U-Boo=
t*
> > found with Coverity Scan.
> >
> >    - *New Defects Found:* 5
> >    - 9 defect(s), reported by Coverity Scan earlier, were marked fixed =
in
> >    the recent build analyzed by Coverity Scan.
> >    - *Defects Shown:* Showing 5 of 5 defect(s)
> >
> > Defect Details
> >
> > ** CID 662464:       Memory - illegal accesses  (UNINIT)
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 662464:         Memory - illegal accesses  (UNINIT)
> > /lib/libavb/avb_slot_verify.c: 450             in
> > load_and_verify_hash_partition()
> > 444
> > &slot_data->loaded_partitions[slot_data->num_loaded_partitions++];
> > 445         loaded_partition->digest =3D avb_calloc(digest_len);
> > 446         if (loaded_partition->digest =3D=3D NULL) {
> > 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> > 448           goto fail;
> > 449         }
> > >>>     CID 662464:         Memory - illegal accesses  (UNINIT)
> > >>>     Using uninitialized value "digest" when calling "avb_memcpy".
> > 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
> > 451         loaded_partition->digest_size =3D digest_len;
> > 452         loaded_partition->digest_type =3D digest_type;
> > 453         loaded_partition->partition_name =3D avb_strdup(found);
> > 454         loaded_partition->data_size =3D image_size;
> > 455         loaded_partition->data =3D image_buf;
> >
> > ** CID 662463:       Uninitialized variables  (UNINIT)
> > /lib/libavb/avb_slot_verify.c: 452           in load_and_verify_hash_pa=
rtition()
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 662463:         Uninitialized variables  (UNINIT)
> > /lib/libavb/avb_slot_verify.c: 452             in
> > load_and_verify_hash_partition()
> > 446         if (loaded_partition->digest =3D=3D NULL) {
> > 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> > 448           goto fail;
> > 449         }
> > 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
> > 451         loaded_partition->digest_size =3D digest_len;
> > >>>     CID 662463:         Uninitialized variables  (UNINIT)
> > >>>     Using uninitialized value "digest_type".
> > 452         loaded_partition->digest_type =3D digest_type;
> > 453         loaded_partition->partition_name =3D avb_strdup(found);
> > 454         loaded_partition->data_size =3D image_size;
> > 455         loaded_partition->data =3D image_buf;
> > 456         loaded_partition->preloaded =3D image_preloaded;
> > 457         loaded_partition->verify_result =3D ret;
> >
> > ** CID 662462:       Uninitialized variables  (UNINIT)
> >
> >
> > _______________________________________________________________________=
______________________
> > *** CID 662462:         Uninitialized variables  (UNINIT)
> > /lib/libavb/avb_slot_verify.c: 445             in
> > load_and_verify_hash_partition()
> > 439           avb_error(part_name, ": Too many loaded partitions.\n");
> > 440           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> > 441           goto fail;
> > 442         }
> > 443         loaded_partition =3D
> > 444
> > &slot_data->loaded_partitions[slot_data->num_loaded_partitions++];
> > >>>     CID 662462:         Uninitialized variables  (UNINIT)
> > >>>     Using uninitialized value "digest_len" when calling "avb_calloc=
".
> > 445         loaded_partition->digest =3D avb_calloc(digest_len);
> > 446         if (loaded_partition->digest =3D=3D NULL) {
> > 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> > 448           goto fail;
> > 449         }
> > 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
> >
> > ** CID 536494:       Integer handling issues  (INTEGER_OVERFLOW)
> > /include/linux/log2.h: 72           in __rounddown_pow_of_two()
> >
> >
>=20
> Thanks for forwarding the report. I think the three AVB warnings
> (662462, 662463,
> and 662464) are false positives. The early success path for an
> unrequested partition
> leaves image_buf NULL, and partition-load failures and unsupported
> hash algorithms
> skip the copy.
>=20
> So every path that reaches the copy has already initialized digest, diges=
t_len,
> and digest_type, including when verification errors are allowed.
>=20
> I did spot a pre-existing issue in the same AVB block (no check for
> avb_strdup(found)) though,
> will send a patch soon.

OK, thanks for looking.

--=20
Tom

--PB3yi3pNGZoS447y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawWtkwAKCRAr4qD1Cr/k
Cmq3AP9nxL81GTTNWMoRlmuSZN6Ao93ZDl3sREJ5rhlsZnKFcAEAtGw+7c1SCQoQ
/VEb138KmM8EBntmo9vCPMpmAf3tgQ4=
=QtLY
-----END PGP SIGNATURE-----

--PB3yi3pNGZoS447y--
