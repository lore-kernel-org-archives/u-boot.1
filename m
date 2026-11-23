Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1780606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r0BQ9pqT;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=E8GtI7rl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FA2A4059B;
	Mon, 23 Nov 2026 22:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAadoZb8qiUr; Mon, 23 Nov 2026 22:38:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 828B0405A2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795473492;
	b=jNCbWCBZ0dcCOF6vO0HRfcEgI6V8xwC6Vt5uk+i7oyc7DoTqqZD/7tpU0DIF7mch+M0i
	 cX2g+Cq5I1hqZeK0DR3Ll9cdsfzLT7te0z5t90GIARFlpaDiBKyoWc+hU7gp51M7NB9mR
	 AHdf+GqcisRuwaNrwTJjtuwKYjYjOQneNuUF59D+mLqIIkuQGX0Jm4vW9mnX5OoYagfgz
	 oU4Fpq89t82FyWmJnrzPn+Z2tFYIC5GIFYCPOT6Jzw6a2DOWR6N8v+JZYSqnm565HU+rS
	 usxDWJ8clHTG4S1Sqd2pYdAHlPnzCwlSwC9/LHnncrUJSobCb5Mnaabe6elTZggPYvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795473492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FKWYZf/oZzdtMSB16KaXtr1uLaaIdNwOV5XxolDTM+E=;
	b=tPkjFbBCnyGw2QPBoBwd+ZlQHOcEjUrq3V6nqqnfpQyKWR8J/mCbTRRxaaxizUe9i/NL
	 3gFDYkdlETWto9jkaXWACHbQVHmFO37u//NCWGjLgWuIy/RDmphNZEzJVrN2HFjfRgYqt
	 iBoMlMsklEGxgfPVCIKvjAbSZdDyuIxEcnhhTGT74JXCNxlcg+5qSttiR0C9wi6h88A6j
	 7Drx4x1Hkjpfw8jYs4dm1uBzQSbyQMDWFShAN5wMRuJsAwg7ICSEfvqI+J+nOuQWzqtE9
	 yF4eanLOemrmV4cNTeMCJTeth5idtL+dyWPjoyaFeJcnfgjfRRZH2lYBNL7MPj1oGDg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795473492;
	bh=FKWYZf/oZzdtMSB16KaXtr1uLaaIdNwOV5XxolDTM+E=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r0BQ9pqTNXsfVmRi90aEA6LrqrCY4WqNnbs3ybuTEoAxP8I7ttRjHTnVH1/pZ4EMw
	 HdwoUr7RygWKpvasfE7N8AuYbEAcazu16cNiLABc89uC8ll+RMc3AMaEFswj0qvcmv
	 8FqUOBn5LRVL2eopaIPfu3R3KrxI96NO4ddccP6WY8ZwnEOu4t9Fb5M8sBJ+29AwJP
	 fzd5lAXewnqlzSOApOk1F/fQFyRZTueWPBmA+9EBhzzT3d3z5wfexlHUrW5wgrHQr/
	 tzqEmX8PJ/qDlmPeQeQ9/ilaC4zn9ooBp5IRoNx1rDUn0R2CT3mJJFJ4Wnha9tLtzk
	 1v/H0RMr1mk+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 828B0405A2;
	Mon, 23 Nov 2026 22:38:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E6764D32
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C321A400E0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:38:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEXGofbZf1KX for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 22:38:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9D71240068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=E8GtI7rl
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D71240068
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 22:38:09 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-847ac7ccd85so2234237a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795473488; x=1796078288;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FKWYZf/oZzdtMSB16KaXtr1uLaaIdNwOV5XxolDTM+E=;
 b=E8GtI7rl23OJoJRKvB6qpmp8FaYxXS2OZQjBM2bLOo0c3cBWZ5kbPRzq64fqW4DliE
 e4/TTP0S4PVduU1twsYW9eqOFn9gq3lqOGHitdKlcDto6DRjKBasEl4tYRQShE5INnD1
 VmrkYJVVFev1R62k4SYy5bYP6UVxASH7uNEtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795473488; x=1796078288;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FKWYZf/oZzdtMSB16KaXtr1uLaaIdNwOV5XxolDTM+E=;
 b=W2DJhy5huIb8HwWrLnN5QbY4dW5IKJx8I5+w+xvo+uMO4xLVGWs16rJVUCyLa94L7/
 Zu4rbD+uK+eTk89zAW471rxT6L/1xZdILkyEYTqIm8/LX9mjziVMAP1dugqiuzGaxwGI
 TweIDlZ4C2wzbjnchoR2JXiJX97f7A0ooxS1dw7Rrpzquti5y8Zf7vJtR/CgLrTWNR40
 Vh6XopfftxBaksJI2QmoyX/JScCa8DKy1bZWY9N1BKYn5ddENsdd2Hi5Qke+mxPsKk4P
 KqMkmqebJz5W8fzC9uezpziNtMLoTeDmy3hZ4hNtscamYmOXPepfwAdFEMuLuzKAGjbg
 vetA==
X-Gm-Message-State: APuU4Z8cIUWalAO9OqBUvHNnfiKnoUqFS3kMjZJMs54ODiRlDjjPVcMz
 cwXh6Pz0z2pDL5PflnXWYu3rNQf59+/sMlty1uXX6GkTGzsu0LwBQatt+NajF3x5Ly2SROHAHV7
 mHXoVq+kIlYao
X-Gm-Gg: AZFdTZcPlnBCWOAhIj3xfqW7A56NoH64pD2xVkc/Q4T10drd52v4UOcDMSRl0riSKFC
 Dy9DQfHZUOU0ewS1pURyTvaWICCLr3jhXBhYhyHM2xhLgsF1P/ulvRcc6KHVqz7q9cUktH+nvLI
 FJasiyqgaf4ZvuKSWB9l7LpsMFQrkslLuS6Qlwf3/zSjhZBRi+s3xJ/LrYonsDQ3T5BhxKvdUsk
 Ra/1l5yRuVyJbhlGyVG3T/ntzus1ZXMQHkwyq1is1SlXluCDJrhD+BvvIeIiSsXGDn1yIVfzO4s
 S2oTO0XUcWn/ps5QlNo5p7kSp78oQhGX51PFw+1rphb1dyaQ6N3Q5rZCDRP92Q7Cqm88hyFFeBW
 XePqX7OP+MZMYkO5UM/R4ToqblaKeXHJXO2hucUKkXzRQKMLiPFGcnuWZx/b5h/w0XtER+FP+lp
 1pKnELntEQIngAZonn7sbjn6gv0w9NCFfBejtaXiW6HUAiByqR7OzkihCOemLElLXfWHKtGtVku
 ESzOT/Ig9CK19VyBoUwz2TQkgL8OewidiolI2qUNq5Rvt7naetwslUuT8a7tLcuQ6Fef6UFAq2P
 mP6yOWMU1r1oRk0+oMvIFPPWE23r12bzA1A4Tg19A0lNtOn94qeOVcynQZgtcchreuo1p0emIJ7
 ixm+m5KI7F5CF5Z6UkWQh409duwMhASATnKvElcxEXVfMosRkmv7lK4TnjxR2LE2n42qKrw5jRK
 8dajobpmK6FuUO4Q8OiifzmwfS6njf6Qo=
X-Received: by 2002:a05:6830:2b2a:b0:834:b015:ae9e with SMTP id
 46e09a7af769-86315928296mr15631533a34.12.1795473488313; 
 Mon, 23 Nov 2026 14:38:08 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f6d33sm9283171a34.18.2026.11.23.14.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 14:38:07 -0800 (PST)
Date: Mon, 23 Nov 2026 16:38:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20261123223805.GQ3176972@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qR8zq0vuYUH+vBvW"
Content-Disposition: inline
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


--qR8zq0vuYUH+vBvW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the report from v2027.01-rc3. Looks like the AVB update
introduced a few issues, or at least things to investigate. Thanks!

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Nov 23, 2026 at 4:33=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 5
   - 9 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 5 of 5 defect(s)

Defect Details

** CID 662464:       Memory - illegal accesses  (UNINIT)


___________________________________________________________________________=
__________________
*** CID 662464:         Memory - illegal accesses  (UNINIT)
/lib/libavb/avb_slot_verify.c: 450             in
load_and_verify_hash_partition()
444
&slot_data->loaded_partitions[slot_data->num_loaded_partitions++];
445         loaded_partition->digest =3D avb_calloc(digest_len);
446         if (loaded_partition->digest =3D=3D NULL) {
447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
448           goto fail;
449         }
>>>     CID 662464:         Memory - illegal accesses  (UNINIT)
>>>     Using uninitialized value "digest" when calling "avb_memcpy".
450         avb_memcpy(loaded_partition->digest, digest, digest_len);
451         loaded_partition->digest_size =3D digest_len;
452         loaded_partition->digest_type =3D digest_type;
453         loaded_partition->partition_name =3D avb_strdup(found);
454         loaded_partition->data_size =3D image_size;
455         loaded_partition->data =3D image_buf;

** CID 662463:       Uninitialized variables  (UNINIT)
/lib/libavb/avb_slot_verify.c: 452           in load_and_verify_hash_partit=
ion()


___________________________________________________________________________=
__________________
*** CID 662463:         Uninitialized variables  (UNINIT)
/lib/libavb/avb_slot_verify.c: 452             in
load_and_verify_hash_partition()
446         if (loaded_partition->digest =3D=3D NULL) {
447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
448           goto fail;
449         }
450         avb_memcpy(loaded_partition->digest, digest, digest_len);
451         loaded_partition->digest_size =3D digest_len;
>>>     CID 662463:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "digest_type".
452         loaded_partition->digest_type =3D digest_type;
453         loaded_partition->partition_name =3D avb_strdup(found);
454         loaded_partition->data_size =3D image_size;
455         loaded_partition->data =3D image_buf;
456         loaded_partition->preloaded =3D image_preloaded;
457         loaded_partition->verify_result =3D ret;

** CID 662462:       Uninitialized variables  (UNINIT)


___________________________________________________________________________=
__________________
*** CID 662462:         Uninitialized variables  (UNINIT)
/lib/libavb/avb_slot_verify.c: 445             in
load_and_verify_hash_partition()
439           avb_error(part_name, ": Too many loaded partitions.\n");
440           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
441           goto fail;
442         }
443         loaded_partition =3D
444
&slot_data->loaded_partitions[slot_data->num_loaded_partitions++];
>>>     CID 662462:         Uninitialized variables  (UNINIT)
>>>     Using uninitialized value "digest_len" when calling "avb_calloc".
445         loaded_partition->digest =3D avb_calloc(digest_len);
446         if (loaded_partition->digest =3D=3D NULL) {
447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
448           goto fail;
449         }
450         avb_memcpy(loaded_partition->digest, digest, digest_len);

** CID 536494:       Integer handling issues  (INTEGER_OVERFLOW)
/include/linux/log2.h: 72           in __rounddown_pow_of_two()


___________________________________________________________________________=
__________________
*** CID 536494:         Integer handling issues  (INTEGER_OVERFLOW)
/include/linux/log2.h: 72             in __rounddown_pow_of_two()
66      * __rounddown_pow_of_two() - round down to nearest power of two
67      * @n: value to round down
68      */
69     static inline __attribute__((const))
70     unsigned long __rounddown_pow_of_two(unsigned long n)
71     {
>>>     CID 536494:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "fls_long(n) - 1U", where "fls_long(n)" is known to be e=
qual to 0, underflows the type of "fls_long(n) - 1U", which is type "unsign=
ed int".
72     	return 1UL << (fls_long(n) - 1);
73     }
74
75     /**
76      * ilog2 - log base 2 of 32-bit or a 64-bit unsigned value
77      * @n: parameter

** CID 243627:       Integer handling issues  (BAD_SHIFT)
/include/linux/log2.h: 72           in __rounddown_pow_of_two()


___________________________________________________________________________=
__________________
*** CID 243627:         Integer handling issues  (BAD_SHIFT)
/include/linux/log2.h: 72             in __rounddown_pow_of_two()
66      * __rounddown_pow_of_two() - round down to nearest power of two
67      * @n: value to round down
68      */
69     static inline __attribute__((const))
70     unsigned long __rounddown_pow_of_two(unsigned long n)
71     {
>>>     CID 243627:         Integer handling issues  (BAD_SHIFT)
>>>     In expression "1UL << fls_long(n) - 1U", left shifting by more than=
 63 bits has undefined behavior.  The shift amount, "fls_long(n) - 1U", is =
4294967295.
72     	return 1UL << (fls_long(n) - 1);
73     }
74
75     /**
76      * ilog2 - log base 2 of 32-bit or a 64-bit unsigned value
77      * @n: parameter



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--qR8zq0vuYUH+vBvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawTASQAKCRAr4qD1Cr/k
CuR/AQCuM5NB0DTaNoyA/6OQ2lhscvjtcD0EuIh7DEsizAQyFQEAl+tKUmT4MlSD
2rBzCuSCMK/8P4EIXWB/axm4TY7GWw4=
=xv3R
-----END PGP SIGNATURE-----

--qR8zq0vuYUH+vBvW--
