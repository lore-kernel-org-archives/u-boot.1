Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D2606EEAC
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cHEps7Co;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=CXIeX5gA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5CFE60686;
	Tue,  3 Nov 2026 19:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PP5njtcIHZ5F; Tue,  3 Nov 2026 19:07:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04C1C606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793732850;
	b=DramPMz9bW52CaozgBJ2PMrz4Z9mw4N1H44o5R6baap+EK6IUL50uqRbUGdApxAzOvoj
	 r0KIE8oC/tL30ksWU+L9TEMmW55ILh9VAIYZVIVskHkr7JcaaLGxi/dJHMYlH+1jnwg+l
	 H+Mtt9i06y30ihLc85Gn+qg8X0yOjiovqQvlaXIdVrtphLk96NnCp6VEjFGdf1AQdw260
	 YaKKHrJKI5iX0XWeeCNHrWZd7hb020q0/9MayE6v8HotrwMuyZJIuemAxBt0SmODcVqE8
	 cgWt9NJYMiMFazIhmU2MOhcXHFNTCI3Au/G6iPq1NOrk/ixsJQZGYHU8i9gH/qejg/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793732850;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7rUhXCeZtcFJcX/2Fkbhwfu6otwaHPmBPhSYipWvRlM=;
	b=sE74penu1vxuA3TkK8L50s19wRUaiNWNtPOd6CUvFefdVNXgu9RRTgqaSoM4EOTxqDx+
	 oZotO7qmxY6TN7Xw3IMyBgs/FjY4XWE5nymvOBKwW9Okgq/TdYqfe5F6xVZj2eKg9v76F
	 ZiRH8M/r9GXarbpNff3OlRIOLTlK96IP923C8EwZ4K6AgfGYKSigPuGPIQB3+92lL/+60
	 jYlhWcEdpyHsWg1eyX5QLGpzxmo1ojk5ipNUz1WB2krj+cj4ZjaS+UdcEHhCGf2C6bVmf
	 cbuKxKL8mOcH/4o+bygQ2pXypVGix3xgwC6jG6iAqqCyHCfpE84+h5WmapudKTfaocw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793732850;
	bh=7rUhXCeZtcFJcX/2Fkbhwfu6otwaHPmBPhSYipWvRlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cHEps7CoT2+Air5nN3ZsNJ0r0fqfL257zFJFBfdw8F+sT7Z7froIKrBciHKKHLrtu
	 TL8hm8ciuM6O40cHMtlgUrG5Jcq86uhmKbvl4zA+ilAqhXcnf3O4pGLyA0+DXYubhm
	 YxixrSlvkWzUab7zGKmZMJJlE+x5/Ig7dTH1hDWotXmsWAqUCrXnvFZECsWdknCaZl
	 BWw0qTvJyoPzFm0fnXl3TBmXJrslnXvh4V2M7DaN5rF8ssPStM+mgAq4sQEmYyt7x/
	 ykMZ2z41DS5e1mbxG+En/1lm9QeIInpQXWa/vz7K8Eu5lfdP4Uwxfr5bvvRJhntvAK
	 ddSSMaKv0q3uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04C1C606A0;
	Tue,  3 Nov 2026 19:07:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2D5E784
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D04AE80D6F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RAhMfeOZbb2i for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 19:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FF8280CB0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793732847;
 b=kSSbHcS8wpH7j03ZLuspiBfQlcu+P6lDbgCetNaXZwfD3X8VjnsYQJN8tDeo3Lvjm3pu
 Yk2/DvCf6KmuL34U7ZR0Jky85tO6m3l0Trsld8KWPUlQ1gK2FTo/NK4+mLectM8UC0pXG
 Vr0owEpP+43nPeutgE8twkZKB5w3yjtRvK+b64OfzdBYqSUUzfQWHRflbNOsoKK2jYMfA
 nTmLpOIXoWaH8yTyXa1tmgfLnN0YBwqMe4heDeUE6pi+6PdWyTu9UIx5UoGvf+rzBQiCO
 ip9pLnjXfkKD4nfovlQaQlyS2JS8WCXwro0/ogg+LLyry7QyiifJcunngVUR/Tu5QAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793732847;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=7rUhXCeZtcFJcX/2Fkbhwfu6otwaHPmBPhSYipWvRlM=;
 b=QlqApOiBiubCWlNlH4MG4EtWFbiJJsbA/A1z/6wtmdvqFTkcwFAgd9Sppl0Pit58CHpo
 VQEc1zLdvsmT2IZ0FtU6ru/DvvMhDOwc2kA5jHnMY24DnGgotAvKb8syNOo8vAQW5N0yL
 MurYSHhstAj46HKCL0wU9ibDZRNjZqZcsUOZfzsOAu0p6eEEuo92R+wFbCJxEa+DHqFJm
 w99A+0EdTq1a2BadlWq38rRaS2tmaDtjCePOworaJlmgrRBzR/kKlzOzPPjv34doFREPy
 3tHqxTyYI8M+lVEk+xzaa4hXtuDGU7yl7VpEz5DM6Dlu5NI2CCvE7meEsyzXjOQtK9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CXIeX5gA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CXIeX5gA
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FF8280CB0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:07:26 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-833e671ee9fso4702150a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 11:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793732846; x=1794337646;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7rUhXCeZtcFJcX/2Fkbhwfu6otwaHPmBPhSYipWvRlM=;
 b=CXIeX5gA6Y2zJLC6ldowN2Q5vGBJNwm6MfHq4TVzionJ2+bkd8tiAbLacSGCJN19Cm
 xDLQ0fJXAGbVSxk1C/tBpdgeqq/Jpscu5rGsB+0lA+TA62MvFUj4vuKTztTu203Lm4sT
 urdi/6fK/4ShG0/0fC6au3vVyvpo1AUXf2OOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793732846; x=1794337646;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7rUhXCeZtcFJcX/2Fkbhwfu6otwaHPmBPhSYipWvRlM=;
 b=ed3q8XQpuRqet0TMPfIosx3VsseVGr94kUufbvmetYpjQiKvFY7ulLRmh/Ieu7aBp4
 x+Zc3Z9NErMRTcodujvxgk5hrVDXVFXzjHd1H+A26kug7/aEp5MR00aB22SU7g5mPic4
 oxVL/OpyjCRePK+98D2gslc1wtiCzKVaTU9F+pywbTNk2XN5SKc4ygHaK5rjBrqYP+Hf
 5nJuzGjVVFUIuqNZVh7hD38ZoKc5/3F0aJdlCxIFnHv2fbzZocbHHN8hKMh6aoBSfjOG
 hv9m4D+Aysu+c0V8qCqTR7fsxn4l8v36iGH3B6/jyDjXI3U+76xpr42tIZnE2KgnA9Rp
 dO8A==
X-Gm-Message-State: APuU4Z/rT7HqfMomLcrrxLj8T0SfdEpBNHOIys+GWzg6Y6JbItM+dvFX
 /1tcCpq3eCsdiQFC6dfh5H1V15iM/j5hfeoK96wKI8FhH4gs2OS8Gh8ktQxECm24X5Q=
X-Gm-Gg: AYBFou36JGk0Mzpo8cQhfe/oKm1GdB4hVk2n7npgJuR1cQNEYzxKD+X87u4iYGwR+PH
 kVQcY87SRmqwpaoLPM+Pag3dPmlwGQPCKPMu5g4RqmNEA5o1XMcl+QU4P8nLo2ra/X7c2JXb/dv
 5BqDD5HBKcZ7sF1oTE8dBHnbfhDSJkLLKV9TCT1OcGMZO8fTwvs9r0E35O+DSKkSMF4W3QSJCrz
 JnXKn5JGOE88bQPTBHYXV2i+PA+44x8HYP67o8zgGSwSZKLHZy6wHlL82a68sQqijfd14tVOV4p
 WS6eMeCZyMZ/sRAsVv5Z79NymNsMcb1Q5WFBzCashj4Yp/uuN0jk72ONkpmpw5U5Dzbv+U7mDwX
 PewiklEaCPXqZEonJO8kFb+jY7eDyS/bA/K1TV9hVk+DIWaATy9+Xo1XJ2f77y88JS3CwvVB1Wq
 2d3UfoeUEfaNGLvqEh0mE3vm2n7DpzRIe3b2t5QyyeN977l0C0LPmBTxQt9jX44uRF6cpCGh291
 srtwMQSjhnIIDtcembAqi1Q4FgAn8xhPKTRXgWIMilOpCittd2rAhTAx/v3q3JU6Hu9drvgHBIo
 /Z+YrnWw/GOEXOga7Ae2bOOzE5+zVRAuMQ/Wtq0z/E6QqumfqURs276SaJTRyQTfa50rB06QGHz
 2D2j+wJjrGKNembgE9NxJxVIYjWiejAv6zqsK4jVtcwfgIAoxT6eOfC/c6jESjOC93HgWSsGwFg
 Pq2u9T6psPtiQFrJVfm0B17HW2R4facicn3+0IEV1njfLdOO50Nyg=
X-Received: by 2002:a05:6830:2313:b0:822:40fc:2eaa with SMTP id
 46e09a7af769-85d36601115mr9491449a34.27.1793732845539; 
 Tue, 03 Nov 2026 11:07:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3a1a6c8sm31734a34.2.2026.11.03.11.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:07:24 -0800 (PST)
Date: Tue, 3 Nov 2026 13:07:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Wagner Popov dos Santos <wpopov@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/7] fs: jffs2: improve one-pass reader and add metadata
Message-ID: <20261103190722.GA785819@bill-the-cat>
References: <cover.1793724561.git.wpopov@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3Z6MQWUT9EW1eniz"
Content-Disposition: inline
In-Reply-To: <cover.1793724561.git.wpopov@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--3Z6MQWUT9EW1eniz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 01:49:46PM -0300, Wagner Popov dos Santos wrote:

> This series improves the robustness of the JFFS2 one-pass reader and
> introduces CONFIG_JFFS2_CACHE_TO_SPEED_UP, an optional directory
> metadata cache designed to reduce repeated flash reads during sorting,
> directory listing, and pathname lookup when loading files.
>=20
> With the cache enabled, directory entry names are interned in a
> configurable hash table during both full and summary-based filesystem
> scans. Cached names, inode numbers, and parent inode numbers allow
> lookup and sorting to use in-memory metadata. When fragment sorting
> is enabled, listing can also identify successive versions of the same
> directory entry through interned-name pointer equality before reading
> the selected raw node.
>=20
> The optimization trades additional RAM for fewer directory entry reads.
> Names are allocated from 10 KiB pools, and
> CONFIG_JFFS2_CACHE_NAMES_HASH_WIDTH controls the hash table size,
> defaulting to 256 buckets. Cache memory is released with the filesystem
> cache, and raw-node comparisons remain available when names are not
> cached. Listing still reads selected directory entries and inode
> information, and loading still reads file data.
>=20
> The preceding fixes address unchecked node reads, missing inode
> fragments, incomplete file loads incorrectly reported as successful,
> unsafe symlink target handling, leaked dirents on comparison errors,
> and incorrect handling of the selected raw dirent during listing.
> These fixes apply independently of the new cache option.
>=20
> The final patch corrects the sorting documentation to describe the
> existing post-scan merge sort with O(n log n) comparisons. This series
> does not introduce a new sorting algorithm; its performance focus is
> reducing flash accesses through cached metadata.

First, you need to send this to the new list address,
u-boot@lists.u-boot-project.org so that it shows up in the archives,
etc, correctly. Second, what's the motivation for this series? The
initial patches in this series do likely address the various known
security issues, but as I've noted before, we're down to two platforms
using this filesystem and I would be inclined to just remove it. We
don't even build-test it in CI because it has issues being built for
64bit platforms. Thanks.

--=20
Tom

--3Z6MQWUT9EW1eniz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauow3wAKCRAr4qD1Cr/k
CqsgAP9k79tBn57ct/ix1K52z77cwm6SmgFAke0RyWT/Gkkv5QEA2VyYHcr4zson
9lPUP3PIJ8fOBtvg77VuVkwXGu3i4Qk=
=g4dr
-----END PGP SIGNATURE-----

--3Z6MQWUT9EW1eniz--
