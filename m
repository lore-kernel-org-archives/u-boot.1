Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946A0C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7185810E6;
	Fri,  7 Aug 2026 16:12:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2y-xwrpkhVUJ; Fri,  7 Aug 2026 16:12:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CDEC80F84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119175;
	bh=xsqjBAtfc2vVCZQqGbGQXtf1hpoBP77QuACABOSQO+U=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zK8OBDMU+ky53D9/iT4f5A5KqQAMBw1RYa/MCRRk16NRU/CJByd0fRGxZObEtQQE9
	 fHC6QYqVU4r7HO0H8WVEI5C98v+zlgzXOjGp48oxucAEijJFOB/3WYMm8W0vaMLwan
	 2qVeiu/Kwk4suz0Pj+E26vmzoag7uCMQmv7hl+BQu7W4sO4JkR3Lg4NyQsb2HQPrLl
	 mrTtM+QPBtf93cjc2+WDCC+InAXQ8zU+MCr5cVHTB0ccEspqzC7l6+7Gr35bcuKBTx
	 9N+bz20gJ/ypD3+zpSYGRKGjNbBR7458NgNqzLA90DOAPDq/JfBvnr+luHkZ2nc07Q
	 rSnn7VE+66fxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CDEC80F84;
	Fri,  7 Aug 2026 16:12:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E5E9D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:40:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FCA08133E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A4TzwlmPsd5V for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:40:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 149DA81339
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 149DA81339
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 149DA81339
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:40:19 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3DAD03F135
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:40:17 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a178080182so3861978a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 08:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786117217; cv=none;
 d=google.com; s=arc-20260327;
 b=RjjtfQI8X8VS/84F+/OXhZgbsIILZFNguCX9VZ4o0wua2IrbTTtinRidTSXhyzTtTS
 v2FfYpzKXksNbM5t3iU3nodu6dup67sHIMVIbOBTCHTeWeT3IoJZQ8uA4Grx8WMDE4/J
 J3UvjW3FrpPLzNUFRi4IR285CNk5EYHrcn3KuuSt566+gV+tMKr5MChJVKjSf64fbIq4
 X2cJWAXa2Mf7ygiFcJZhTYgFFbu8kJnwH8Ltzmu7QI6hcH7EZKezFmJiztmBUoTSdiEu
 sbRfyRwlxUyCHmCmjM+7qJ/Zk1XAefNckpLICBTon01MSjhSjqhD2MaWU5nz2KBEeMhu
 bOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=xsqjBAtfc2vVCZQqGbGQXtf1hpoBP77QuACABOSQO+U=;
 fh=sJwCONpFUAWjXYRDOOgIm2arXditKxQtR35nu6jOFZs=;
 b=cV6AyM8MzV7i85vWcKuXE4pSNdqaRF+YgbwucPIIvAa11gX5mhIpL5ajwPxV8OlAtD
 ollPqtHJvSp+6qym+TQuQLb2v6zAJb+ps3Ciw6C668ptfgpcaKhFCvixuvlyZoBKXdYd
 EJ7fvZbRcNHOtDSmZwxvAFCSfhBxa6TNlKZAuBw1DS1S7BOSRjQ7KrExiDLfXQenOrbh
 AYTc0PPH3gBj3zaY+CGwIl+RKsKsF5TNh45/2sp7Wnav3jaGlaIsVTq/4KWQlOGrWt3A
 L+kpaJeTnrJPauTJ3YGohaVPUFWIYsQRGuD0CzMoK7VaMIVBD/8EyDx0MN4IiOW6mC8m
 0KTA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786117217; x=1786722017;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xsqjBAtfc2vVCZQqGbGQXtf1hpoBP77QuACABOSQO+U=;
 b=KApjWrsIyCkcuNN8EmTNucx0rpaOFWrtYSYCjkjHxK/mczRRi2fj/e04cKjM50OjAS
 4Rq8LDWCZgCAxCUln3721zFTskI31xfdTOdQwAa7dhAmoDzvbrH7EFhmpXqQhs0KE38V
 V6vs/WKFsmeJY9HlH+nf5fJbCsvsCmesrzB8LCR96dQch40GaWJ4gy2NkAF9mRk5Z6YK
 mKmw9Z2EOqJBSEJHmlgSGlRSzVGPLW1RVrma2an8m9rWNcSZFIXGDNe2CcDhLxaFRrOb
 IKBH/5dFQ+1COm+Chdg2ASunmqd4SVUc7P+PF/qb48v6891CN31bHrG6YOgm+NBfROqK
 F1Uw==
X-Gm-Message-State: AOJu0Yz5pQEvqo02oPhz0AKiFYADOrzo52J1dXSqEbEhnuW3q32PWOxg
 QxL945Vycs1w3bzVq0N6ymnaBg1yqkhASjr+gunOCvm6+2HNb2BwXlfkVy//SJauOXOIB74uWHn
 ZP59cJooimVoSFZ0P0VWAf4RGQ0ViifQfJ8blrjjrIP7ZXWpPmdOeR7lNydiLtZBTsSLV2mCr2t
 ujWxKz8SRWqUVl+Bc/Lx39HRkAZ8YLNhFvhwBsSt/PVogWRso8BuyyUKGWIczr
X-Gm-Gg: AR+sD10SpCEenzi75wq0ibGnXU1zyXmVBL7Fqtn+ts6bF5C/5c5l/Tj84jwDvWRa14V
 PzH/ogGhZeJqHv7taU4uF6zeNQrgJCBAbS/5CQmdKDJffzUff0u8yhsZps62TaRdCwiz9vWaX4r
 iDv3BZIE7N0Fsdqddc0fcBVCoNcXCm4Fqj2UXcJawYEjZlw3elzxnrv+vj
X-Received: by 2002:a05:6402:51d2:b0:697:f6b2:a94e with SMTP id
 4fb4d7f45d1cf-6a14f1395c4mr12042633a12.13.1786117216831; 
 Fri, 07 Aug 2026 08:40:16 -0700 (PDT)
X-Received: by 2002:a05:6402:51d2:b0:697:f6b2:a94e with SMTP id
 4fb4d7f45d1cf-6a14f1395c4mr12042601a12.13.1786117216423; Fri, 07 Aug 2026
 08:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260806103720.1026454-1-aristo.chen@canonical.com>
 <20260806103720.1026454-3-aristo.chen@canonical.com>
 <CAFLszTgKTk2m0wMnWO4zKg2BdH+QkS8ZvtzA76BbNioPTMjfUQ@mail.gmail.com>
In-Reply-To: <CAFLszTgKTk2m0wMnWO4zKg2BdH+QkS8ZvtzA76BbNioPTMjfUQ@mail.gmail.com>
Date: Fri, 7 Aug 2026 23:40:04 +0800
X-Gm-Features: AUfX_mzzmUXnM4S-2gYgSjE-glNYU_HyQJvoRfkrPBzt4oZJomppCoMqDQlh06M
Message-ID: <CAA=k7==J645VNz7hZXm0eZPpPmoZqpak_CA_MopxFd_MUWdL8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: cmd: Add gzwrite chunk boundary regression test
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 07 Aug 2026 16:12:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786117217;
 bh=xsqjBAtfc2vVCZQqGbGQXtf1hpoBP77QuACABOSQO+U=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=NUalTi/2J7aKVDOCM2GxRqvqn68k4mMxHzxqKZX4XHIIZ03/KGbS2l1nWqBqZV6Ee
 6wQuOgcXuy7Ar+aynWvVu5vBlfzK7fp94T3CUkq7Dkhm9/6+FNGBoI/cZUvaioAP+9
 1BYFzIFua2sFcZcfW9MO4vxoqHjio5HJdYjNpbnSQrXf+46BLgePf59KfzjcH3lBzF
 9/wf2+SJRVO4CtScsrylLQIvlVIUe3qvpD3UrJz33KF8TH8D8sAuhM1H12nZkVdTGS
 t9ns+j5iap9aio9DqqHil3OJghepYgpEx4tsfBJdJn5W5h0pNzbfzFigRBSTpnp4Vj
 nYg+CYxILWs+ndKepX96QBskVd0Papq2QhgSMgWY0Mr9Ot/fffJiraRJb3inbmW/3j
 uAJU/Niul9qBi3MgUglfcFdTrxssdHzQDz5MQW34pIXtCwQSB4QKqtYny6Vpuuqtoy
 pwvNMEr06UO0Bxn+U1goXgkWwv7zJZ5Z1R2v7Vsr8ImFeqIzT7N1wtJrdgiaeZMdLf
 cJ+mQ76P7CAWMLNAhHPAHvJvNH/bBuJeZh4aOyJAUXwKhcm0eOeOMCe4yC3AYGsNn/
 dcwGUqIGvPk+vxuZPP8ZbA5kPbbwKNwtyOsBQ/GY3po2uor1NfMQC6jy2N3B7SnnYE
 CioYkaKXdSFyLw5fVgP299B4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=NUalTi/2
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

Thank you for the review. All three points are addressed in v2, which
I will post shortly.

On Thu, Aug 6, 2026 at 9:20=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Aristo,
>
> On 2026-08-06T10:36:59, Aristo Chen <aristo.chen@canonical.com> wrote:
> > test: cmd: Add gzwrite chunk boundary regression test
> >
> > Add a deterministic regression test for the gzwrite() case where a
> > decompression input chunk is exhausted at exactly the same time as
> > the write buffer fills up. Build a gzip file by hand from two 1 KiB
> > stored deflate blocks and pick a chunk size that covers exactly the
> > first block header plus its payload, so that with a 1 KiB write
> > buffer the first input chunk runs out precisely when the write buffer
> > is full.
> >
> > Unlike the existing random data test, which only hits this corner
> > case for rare byte patterns (about 1 percent of runs on sandbox64),
> > this test fails 20 out of 20 runs without the preceding gunzip fix:
> >
> >   Error: inflate() returned -5
> >
> > and passed 100 out of 100 runs with it.
> >
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> >
> > test/cmd/unzip.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++--
> >  1 file changed, 101 insertions(+), 2 deletions(-)
>
> > diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
> > @@ -132,3 +140,94 @@ static int dm_test_cmd_zip_gzwrite(struct unit_tes=
t_state *uts)
> > +     /* Input chunk: exactly one stored block header plus its payload =
*/
> > +     env_set_ulong("gzwrite_chunk", 5 + blk);
> > +     ut_assertok(run_commandf("gzwrite mmc 9 %lx %zx %zx", loadaddr,
> > +                              gzlen, blk));
> > +     ut_assert_skip_to_line("\t%zu bytes, crc 0x%08x", rawsize, crc);
> > +     env_set("gzwrite_chunk", NULL);
>
> We should have assrrts on the env_set...() functions too.
>
> If any earlier ut_assert*() fires between the env_set_ulong() and the
> env_set(..., NULL), gzwrite_chunk leaks into subsequent tests. Ideally
> we would put this code into its own function which does the core part,
> then call ut_assertok() on a function with the test code. I'm not sure
> how much this matters, though.

Done in v2. The test body now lives in a helper and the outer test
function owns the env_set_ulong()/env_set() pair, both asserted, so
gzwrite_chunk is unset even when an assertion inside the helper fails.

The pre-existing dm_test_cmd_zip_gzwrite has the same pattern, by the
way: it sets gzwrite_chunk in a loop, does not assert on
env_set_ulong(), and leaves the last value set when the test ends or
an assertion fires. I left it alone to keep this series small; happy
to send a follow-up cleaning that up the same way if you think it is
worth it.

>
> > diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
> > @@ -132,3 +140,94 @@ static int dm_test_cmd_zip_gzwrite(struct unit_tes=
t_state *uts)
> > +     const size_t blk =3D SZ_1K;
> > +     const size_t rawsize =3D 2 * blk;
> > ...
> > +     u8 raw[2 * SZ_1K];
>
> Please use rawsize (or sizeof(raw)) here rather than repeating 2 *
> SZ_1K. Same for the 5 + blk chunk size - a named constant for the
> stored-block header would make the intent clearer than the bare 5.

Done in v2, as STORED_BLK_HDR_LEN and STORED_BLK_LEN, with rawsize
derived from sizeof(raw). I kept the array bound as a macro expression
rather than a const variable: in C a const size_t is not a constant
expression, so raw[rawsize] would formally be a variable length array,
which kernel style discourages and make W=3D3 flags via -Wvla.

>
> > diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
> > @@ -132,3 +140,94 @@ static int dm_test_cmd_zip_gzwrite(struct unit_tes=
t_state *uts)
> > +     ut_assertok(run_commandf("mmc read %lx 0 %zx", decaddr,
> > +                              rawsize / 512));
> > +     ut_assert_nextline("MMC read: dev # 9, block # 0, count %zu ... %=
zu blocks read: OK",
> > +                        rawsize / 512, rawsize / 512);
>
> Since you already have mmc_dev_desc, using mmc_dev_desc->blksz would
> be more robust than the literal 512.

Done in v2.

>
> Regards,
> Simon

Regards,
Aristo
