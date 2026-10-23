Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E863606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gc9Y70Mv;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=stxC5HBG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B701608C9;
	Fri, 23 Oct 2026 04:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEkVCMPcLPsw; Fri, 23 Oct 2026 04:59:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73B9C6069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731565;
	b=l2FSe13eEv9MmOiFOxgYsiI/05gr+BsMmFcpmv4dLa4tpXx5hWYxi3Jji7/hr2jm6b08
	 QC4HyIXvwDI1/9Hfahtqy7XumRJGw9TK4qKFs6nHPvOJR7nUAZl3ewrI2GwqE0niU2RZk
	 Uaphn6uYCGGcBrcmmFEBpdRble7cQ28735vSEuKUKy4zTYJL9aDYcXXDSlBdirB6bQW7J
	 tbpsroeONqSnzFldGx0Le+PGLyib7u92IQ6biRfwR00VGtS6cVoyY19fK+6HjdxwPQh9d
	 FcC638bCLOMRozoi9xbS294BTAa1RTq0uPyNXwgz/rQC3SE0yvAm6CvySF67B9rXFUw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uoUtOnBxKEZrIp4cmNWKW9uoXIZKHOd8+WDhYADQ8kU=;
	b=j2e9SaWIuVnoJrXBjPSIywvDfsXIDYOMhhJmoSr512rg3/psPeOl45l0W24iZ5P3vG79
	 Iinil/BDy8G+zOfXsj/4itugZqxW/NYuwh+SSm6h/yf/xtlhSWpnDXw5scFnXn/r8tvwB
	 fIOWpdVr5bxbzyUYRq7MNdzjtd/WNrPyAgwGB4uwd8kKmybcnqIMW5yMa8UDykEpvch6o
	 qFQZRFXTxHGo5E9stFYsnTGrhM4wzH1HwiLlh3rifX5GCJbsL0YAS+5LHaUBYOyK2A7sS
	 t9rTld8owmQsnnUCajR9bXYB7ZbM2jgvuz7M+x6YjInMMyvaMW/gVxEhDWtXGqna+mQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731565;
	bh=uoUtOnBxKEZrIp4cmNWKW9uoXIZKHOd8+WDhYADQ8kU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gc9Y70MvziwusSw0ZVkPUkgE+MDhoTZ4SUUsKd+nHm5h8UclQuPcwh1kkyzc9hy3D
	 TqKYkWUZPRlOx2w16keNIuRnGY8y05GMx06Rms0fSFowCMra3SWD/B4lc7xNkXcQcD
	 6P46cUt5BiHeQ/PO5yyYWSiTXJJrMaFivd/dhEKzO+IFIoSr8z/2vpacBgMKA81+wL
	 d4SHmQhMvtPWdCvQPgofaEQ3IgnEx4qujtGp8kLx21hxUw+6CBk+MRHoL4JIHBoBYH
	 A1aT/TOqOuB62ncFXYfaAZzmkUqWMdXIKQuLSTu1R7cgs4MTZeYilzjOnyWjqBYbh1
	 SxTuQk48MJnyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73B9C6069A;
	Fri, 23 Oct 2026 04:59:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A09549D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6AAD6401CB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8zirkMk47g0U for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 04:06:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8F39F40180
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:30::b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792728382;
 b=j7bUV7v74hbNLKhdHX/6A4n1I4ZQ8GMg99gppHJ5HnAXBEF7P9PrXJSEdbrNIgzBza6c
 UrJysPqRXj1TRkTfX6trqrguce8o0Gdj1QkwsnuA3lY5wgOsHonM84U911z90HyAIP29b
 4PRMRFXjBj+vhZbQmCtgYi8m2S36QV33RAWyGppCAy/12DmXDxDPtD4la/ChbGU921Ouk
 wBOB+IGEn5ZoNPYjt4MRYCTswnkVWI1YFdbH3bjf8CJY1vqGmG5kjyAhBfxRaB70x+XjN
 JLCFqWGDIcus2SuW5lfhI7ielPH16TATbdqvWQfp9GzsHCOnJBUh7XLrfipRmXE4jPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792728382;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=uoUtOnBxKEZrIp4cmNWKW9uoXIZKHOd8+WDhYADQ8kU=;
 b=cDDA9NtyHLgmwVEedPXcoTKCiQ+9pNBz5f3dR0ECL+Xb+yVGdARhyByGz/oZ0uMGNBrd
 1pnS4pDuHGS2I8ZMPNIzxrsBkEGH08TFSLRU/yWQyGWTjVcv4p27zy3uoH/ajiST3v2gL
 /RdFhlGcYskkOQ5t0bqw/OVr2BujN3IwVWwujMS6pCXAZi274Z6Lb+PpAJasHLzg9eddm
 Yukpv3fC90tsL4cPEMzUqfLJke1ONhHAbpvMBq42ChrngcV4yWs4h2L3Zz0iw/woCpGKA
 acs/bvFVRUCQlaS6H+Wyjp4xCcv93UZoe8pWNRiC+qPaMoeDJkuyXoeiAD/bwf94kzQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=stxC5HBG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:30::b"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::b; helo=mail-oa2-x0b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=stxC5HBG
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F39F40180
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:17 +0000 (UTC)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-49e2cb73ba3so167514fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792728315; cv=none;
 d=google.com; s=arc-20260327;
 b=etuEQG9qaB9FdQJlSv10E34FzsvA3HzSvDU8Wbrj+reBEmf3cbb19to+jVAyM5Aism
 +w9Fp1BQfhZa9BpLMN+8M5fP1BiU0fpV9bb8iIfHrE+6ejcj36SifI0c1ajaw9dvfRoY
 HsKPzdf9yUJmU0mZOgakjBVFYyRlHvAi75oNQBYfq12vwcEDZwdDEcvgr3a260H3wffy
 vjm8SdUWR6TIBdkihSOeyl9SFp5r7WxSsYdQ0AFMYQqk2ueYFH6rlfpXpNeZHOGlIIeV
 2K71nFLtbzvrQpyp1LxbN6FITc43NOFwhprbuRVkUeh3WDe1Dms7/OO+z6s1ePQwr1xP
 kuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=uoUtOnBxKEZrIp4cmNWKW9uoXIZKHOd8+WDhYADQ8kU=;
 fh=fO/i0n3hYJ74cs21KGuyGF2OazYql2f81AfdSYYrRi4=;
 b=B0qIHoGyG4P36B5xQrVlvKBLQ0DGvedn5TLGYT5ZvSRyxKEvGv2dRVXrDZtBacXkiu
 V7IShW68CDi3XzxrX540zKDFz2CLyJb//3VSzAiVs8On5x4uXqIwbMH9oj82uXmWe9Eo
 T/+Kk1RJlB3SOhCeqGbgCwXzBGADciiq2TKCFsmenrDYLJWIRpUhGAXCvlucKeSBGShD
 fgRI6SityaQf15Fd/xbeHAKS4bbXdVKW6V+sgCOooFI8MHbuANf4GL5AqO0jIPT/E8Qd
 AOhb4ULQh+6ob8or9kzbNEvlq0bL5/OJ78ewqUlQr7zxOngkKZt+C+OLl0ue90Qph7wB
 12/A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792728315; x=1793333115;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uoUtOnBxKEZrIp4cmNWKW9uoXIZKHOd8+WDhYADQ8kU=;
 b=stxC5HBGQH41h0x92ldj3TjQRRfFPhlurikvd2E5c/MqOBhtIQhuW5UWM3zvihg92Z
 pfxMQG7XSik8h8DsUFtCou5HXVNzlwQIvPO2TGYtF1N5JwBrSyp5T8n88tffgLruuhAv
 Xp+BWi6/ZxnF7lE5CB1FqICsFUdJVn0dw5MVD53Tvl8gvy9Bk2Zn0XBfSygwEyWJrvj8
 EVOQCDCAurXqfVzlRjvZ6S2HJKM/0wkJvA8jH6m31N+Dan2u4/m/IOsNbMuhjvcZzHyW
 9MK2c94v09LChZTavqP6xd6NLTIHKPjD0xbqHULsmR+9cvBRNT/pu2Jifin0IyeuFYCO
 e2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792728315; x=1793333115;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uoUtOnBxKEZrIp4cmNWKW9uoXIZKHOd8+WDhYADQ8kU=;
 b=xi9rfUTXJbc+16oq+hpY7/QPI1i5ENh5rlfXIrutGAz/WiLM0yqAO570B/Az4Hsc+0
 X97Zkx3pq+EmcrXmS8tGIGl90ReRFSH0nM7hokl6ic+NoH15tHN1NDPdcdbSUbROPj2l
 tpV0DR/WuHI4qp2OppAemi+tylFl+y03R+MRYQWbGJG2XxkZk7M87pQPaOcVOlrDxWkp
 i7//3zYjSLg4b4JSc0tUEQksiUqc/27R+5iIFt3bss8SIPPLbfxXwQFpAfPaLLe/1L9R
 vZCqHE5x1604i+4ni+PdV/cLsqsqStcFIbbj8vH9wctSVa3vP8xMP8BkHtrDvP1eiu5Z
 tHqw==
X-Gm-Message-State: AFq9FYJ3KDzSb7x137qI40jQhUbVCB5QQDkkkq2C/GkZuFuVHVv5BwDB
 +JeWMRd7+qjZFjGGVAYI/e5tJnpjZDyuohTCErrRMxXCszBJnV+pGm3UaeVQlvxiY9oOGmGtr1t
 gXhKNWDzLBJyXazTbzJ5xFdHQgkrFBAM=
X-Gm-Gg: AYBFou2xlC7VUYbDqi2kDVt7/ahrsQRT3gE8Q0Ldw8OKsego/tw18tc/Ir6HAfqFYsJ
 AY4niz/AsmPrk0IEndLRFlKEUDEFyuyJl3c9PB9GqXcyOjb2I1kdrlxyz2xR6IJyWobVyRTmjJy
 emS5QIovtxbLvTjLVNOlHGiwioGCBOIKIT5cUdNiI8ahpFFK0ZYSvjuLcie0NTebJl+Jjlyj3sQ
 EDkb9wzghFwqXcDxCih83OYgL/Vz9KQ82mUvCDmgGFzMTjwe6Yyt3QUt9KchAbf1v2+7vvNRy77
 kp2tbK6JJfxr1cIF0jLlJ5wkRRncRqYu+dOU/iW2QylSpcsIaBaC3H1rqQf/kcu0XxHbkFWmKaE
 y+S/fXX7Nf+KRLEQomhlBvN0=
X-Received: by 2002:a05:6808:f90:b0:4d6:9335:d534 with SMTP id
 5614622812f47-55be876e7eamr605028b6e.65.1792728314889; Thu, 22 Oct 2026
 21:05:14 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:14 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:14 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 21:05:14 -0700
X-Gm-Features: AclHuK-lHDwiE9KC15u2-wAveLhWRGPN-Fl46qi9BJ1naAH1PW9bRZAyomQ2hxw
Message-ID: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
Subject: [PATCH 0/6] fs: ext4: check on-disk indices before using them
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ext4 driver takes several indices from the filesystem image and uses
them without checking them against the structures they index. A corrupt
or crafted image can then make ext4load read past an extent tree node, or
make ext4write (and saveenv with the environment on ext4) write outside
the block bitmaps, the inode bitmaps and the group descriptor table when
it replaces an existing file.

This series checks each of those indices where it is read:

1. extent tree nodes: entry count against the node's capacity, and the
   depth, as Linux does
2. the triple indirect lookup compares the cached block with the wrong
   index, read past the end of its buffer
3. the write path refuses block group layouts its bitmap code cannot
   handle, including zero blocks per group, which divides by zero
4. block numbers released by the delete path must lie inside the
   filesystem
5. the block group of an inode is (n - 1) / inodes_per_group in the write
   path too, and inode numbers from directory entries are range checked
6. tests in test/py for the cases above

With sandbox_defconfig and CONFIG_ASAN, the new tests fail on master and
pass with the series applied. On master the corrupt extent header is not
rejected, ASan reports segfaults in ext4fs_reset_block_bmap() and in
ext4fs_reset_inode_bmap(), and ext4fs_init() divides by zero. The
existing ext4, env and mmc tests still pass, and repeatedly overwriting
files on clean images, with and without extents, with 1 KiB and 4 KiB
blocks, keeps the images clean for e2fsck.

Simon Glass's "ext4: Add a few overflow checks in the writing code"
series from last year checks the block size and the table sizes in
ext4fs_get_bgdtable() and ext4fs_init(). This series checks other
fields; patch 3 adds its check next to his at the start of
ext4fs_init(), so whichever lands second needs a small rebase.
