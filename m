Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98E606A325
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FCOhKW1O;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvSRmNHj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 398E980CB9;
	Mon, 26 Oct 2026 09:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1K2G0KLrP0o; Mon, 26 Oct 2026 09:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 89D928097B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793008137;
	b=SKTYT52z65DAMxH+vdOc+2ioi1QMdaDQeRnMqxBHdjdHNxEXcVV0aELSLElwtNMuXc6b
	 ibYdN6nMdhltwNq0eZfyf6tYtSASTCWHZ/Yv6jn/eEhghdJLYUcMcAN9nFzq5MDxHQ0D5
	 NtrZ84OBGt106bq8Knnnbr9/aU+mNzUoehw80l9wOmN6V81fUnaP0MFyaJD25k/VCDXDB
	 TEusPPXFwNP27jesSrlwEQVN3QPpzpjpNdwGCzx0yO/7KTtuRj07rXp1JNS4xLifrdEej
	 zw6TZpIAGyIMpY8AZUqf3Z7rw836H4Iv+bWyoDVvU1UUb4gpKL8pUcSB5hSksfMqAJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793008137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dq52/mMrX2JDWmR93z2tPSZGcCYph5huVXoKo+alafw=;
	b=mzdlpZbfvqXhwPcxAe4bx9wg+a8zV9diqbv3m1Q7JdOiKvPkQ1K1sH2jNl7EZxGg82/3
	 Wlvufkm0buqTeft108At2ihNHgdcHK3dlM/G1wmd7+xO6AHCKpIqfYl/bLObUeeqNXv9c
	 b4L0JX83ghK7B0C1SvSmF6xF+hmu54PQOafbKD9AJ2sg3pw2/Xs84zhOKNZyYOAAtd9Sh
	 Q/dWUq4qsiBasmkSYzUhJ5seLLZiXVN6DRPywczHqZTRhU57C8zgr558b9dXMdrk9K8qw
	 TvzW9EixLdfMWxxvjUF1o3e0jiJTuzkYVpLGKv7HnMcEVU2H6nfmh7VPQnZ+gIIrnZw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793008137;
	bh=dq52/mMrX2JDWmR93z2tPSZGcCYph5huVXoKo+alafw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FCOhKW1OFBLCs0ypnGsXbzqwR1p6y1MoS/duofsBNmRKz9kMA9BeDDjrtdbJ5nBet
	 xutTPdg5Hreux5ydvjzFN14vTYgjGzrlrwqh5eUR5kucVDkUIhj+2utFfkFBSeRLjS
	 7vE23GgflB+nj4hvbMKxLPCZhmZAvCuXPSSPXJYQsKGhf222oaRpRz5YyiL7z0kPW4
	 IsRL/gcfv9LJ2HX6gZ/31jHnRjV60c58HjSNnLNtmORTZszHde5nVaXeZ5NDXghtoh
	 JIqwUBWh8GABiom+WKzugzla5sci5D5YDLz1WAcJT9/TYfXOHq9ngq5JKdHJTA4xqv
	 q5l7eETm8qbMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89D928097B;
	Mon, 26 Oct 2026 09:48:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99A1A334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 800A84004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:48:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hYp_fGjc5dmu for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:48:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DD65E40049
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793008136;
 b=C1KG5XBNdaaN15CRAoJjgPY/m9RYisJBeWCxNcia790SAhAWAOKWY2h57sMaHWTNjMiK
 PETFnWrig1slooD11/vznSk3ZoenrvNhtBg8s3GLbspJG7TrOpeQHW6qQjUeUglizNSrk
 G/qVhLp3poU5GC5hP9nTFpuonq0lj1eRMlkZhLQN/GBd/InysHCFwOKCEpZC3LqKagHYq
 2JuGjIJU5v5yRDhnmSrzdxU72Ro+upWVlXkQR33Dq+4zvWOlqvsFRf4flWOka4pPaqqWn
 YeL+YFS9pRqZ2NokZUosx86ET+7umyfhk8qP1CazH4Pfa9JQKN0dToE31Wu4X/i+tEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793008136;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=dq52/mMrX2JDWmR93z2tPSZGcCYph5huVXoKo+alafw=;
 b=P9vwlNUo93fTyJAVtRe5pbw/qUZB5HewDvcgVuXCFP+jBs2YXMuADOrzjB6SttirjEyz
 iClUk+R+4diTeg+ouLJT4Y1yHv+sBd0ZfVKIJVxON7657i0IXWfmR9sweqpxrLletUe7U
 Guf+bAIW+nMUsbWsw4xicVB0ARy+5rmK/yd5EBlPQ+k9rjlQ0UUhhZ/7+2H+JT7BU0bea
 Xx4SBbd0SqY9cGpRiww7TlwgevtXT5WCK8U0voA58dPX4GAaNHc9wYp9EvQ0NYEA6+OUL
 9ZGQu0RF98v7+B8db7w76HuAhUNtlazkXqP8IHicW/UGEFaICzOxUZt7QTPBftZu+Lg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WvSRmNHj; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WvSRmNHj
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD65E40049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:48:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B29543705;
 Mon, 26 Oct 2026 09:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6061F01825;
 Mon, 26 Oct 2026 09:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793008134;
 bh=dq52/mMrX2JDWmR93z2tPSZGcCYph5huVXoKo+alafw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=WvSRmNHjBdPKedTQu506HEDG3gHxgaJICyL8qCgqZISKwRHdOypLgOqMVpLlivaRY
 m3OMGCFRhpirP0RcMaQOXIFITiLFyev6QaJH9Wka9Dp0VRl7V+ozfTpx4nGuD6kamt
 0MC/8e0FDE6u52KKThZ3MnSegI6TR3LB72yIIoeK+po7Z5x6lPN8Z1g4HMk4RkMB3x
 0d53Yn4+J8OxQ69UhHcgO3Joch8XEkjHDJSHJiyG18Id1/fIyGvEiJ2ltquYFis5P9
 27ybU6SyB0QrXhrlPEli7XW3AZJyoyzLSzLxH+Q7UvrEL8KOGigV3QNZTtLmTXjU4d
 0GBoW1WQIHOAA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mehmet Fide <mehmet.fide@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] colibri_vf: separate the partition numbers in
 dfu_alt_info with a space
In-Reply-To: <20261024113459.3259910-1-mehmet.fide@gmail.com>
References: <20261024113459.3259910-1-mehmet.fide@gmail.com>
Date: Mon, 26 Oct 2026 10:48:52 +0100
Message-ID: <xhkdbecdc3i7v.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mehmet,

Thank you for the patch.

On Sat, Oct 24, 2026 at 13:34, Mehmet Fide <mehmet.fide@gmail.com> wrote:

> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>
> Since commit 53b406369e9d ("DFU: Check the number of arguments and
> argument string strictly") the NAND backend takes an entry as
> "<name> part <dev> <part>", three arguments. The default dfu_alt_info
> of colibri_vf still uses the older "part 0,1" form, two arguments, so
> its first entry already fails with -EINVAL and "dfu 0 nand 0" returns
> at once, before the gadget starts.
>
> Separate the device and the partition number with a space. The
> partitions stay the same: vf-bcb, u-boot and ubi.
>
> Fixes: 53b406369e9d ("DFU: Check the number of arguments and argument string strictly")
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

