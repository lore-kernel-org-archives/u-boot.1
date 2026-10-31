Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF98606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EVNkBSrN;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cofpdB3R
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A24840A77;
	Sat, 31 Oct 2026 14:02:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Ion6Ul7ROMn; Sat, 31 Oct 2026 14:02:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91F5240ADE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455338;
	b=Nt2e7blFLI22Yh5FjwyQNi5u85AYVDj9BdrWePPupKLe9l7Go99hpCd9P5xklMCttYc2
	 Wjh33xn1Cq6CjEXCAQ8y+w5vbwp6J+EoemSdRH1SLNzIB7/19yk1Kg+YcbygV+YpJdoXT
	 IJFU+mwJ5dTfyvhVKRPcWJgSrqrqf6CrXS7v8rlPj68r6UbTuaocVxgFz8Wv4+a29Jvb5
	 cKVn4T9pbutKxNxs9H+X6KdEljfQEmTl3vEAqcXbfcACO61NEBClEtyNCkSJnnbGPPknC
	 8RGCZPNPK9KkCdw/FxZ6J9bnm60cGS4fP5vEAoAx0AxcAh3xSKLrxlyzA/5ct3bJyCg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WoOVTginyDbeSR5JJETDW2l02ShTRPvD6SPR/8+HoFo=;
	b=lD0bsHTBvyIKvTACqrvqf35RQopykpDKE+/BXOLaYUXLeGvXrOQjy3f4zDrAtV2htJye
	 2lSzPo2DZTBRq7DFLCWMMUYLp5J8XSvU/n4kWVSJLK3qHqegq/bdL4ca6qAVhhTHRHEQ4
	 WWo8oVesEBUIzhvFWTE/OBD4OzEbwq+XC5RRwCuSK47lgxAp0628Xba7VirjA8TQwQisA
	 WAHbNvA7fXu8PK9rlEiOA1+9wv7afvg3VNYaTr+IuEKLDg6UbwP8/1mSz+ve3CQCQkEr1
	 pgaExczS4GTpbQe7iYMEpqMvJefHxaNtRvpWAP/j/3BpoSBEgm/g8SD0qFC7eCZ0wHw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455338;
	bh=WoOVTginyDbeSR5JJETDW2l02ShTRPvD6SPR/8+HoFo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EVNkBSrN1l6qsvWQ62cnYrd+Qu1oxzhLX8/4pbt61mmGa98AJnT9sYi4479hbBDw3
	 Kik7E4aS+nWbL/A+bohFe0m1rCshcnN5SJNfVrP4b1BO3M8eU+N8Mx4vBRedC8WEna
	 f7enNHxHf+HduNvGZzTmuND/zFAXPO83hm5W75HVciMtvoOASrHf/hLhMs/v304US1
	 nHc18rfNmRGltbvUb+VZnCFhsBP670KleQBqTPQT40q0hzqlRQLSQpcCCHHd15XeGB
	 36rFF1WlXE/H8boL+YJL8VB76qpw8Vs5CMNF5Pz2y2Z35HaggTSPec0WdNKav3raUf
	 zQZEdN5FSiOVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91F5240ADE;
	Sat, 31 Oct 2026 14:02:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B83121DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DFBA80E73
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:02:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jT0l3IpNxXsa for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:02:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D97B80DF0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455334;
 b=IrwjYMVF8PR2EAJ/h7uD7BkOOJcDJCgguhyFQCAAcJi6i7RJT8N/g7omCxjh5MQ+yRz9
 m73RSPUyknVy8Q8zpaouWzK5fYsNfT4pApN2kIGUZAOLHVEYRE5Slnyt6fBH4TXOl0g0p
 fG1s6LZR+uN4hlTgjmNrD3O4FQ0GJOy20stsane/TNBtvnOcxjSZnhXQu0xQpz07TFSVj
 Mtg+jlr3rxCzjNMjluW7rT76xkfGdgLdduKE4Fi5RveI7pq5OFHcgVPIjiLy8tly0g5gL
 g7vCA8l5SR+Ur/K/A7jmNAcg8PQMW/XEZBmuzpNcTTgMLcslGiXt40rETBNPtTmJDYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455334;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=WoOVTginyDbeSR5JJETDW2l02ShTRPvD6SPR/8+HoFo=;
 b=mVFsUbHDRO8730YfQNn3CWkCVqcEZKsPgwRm9jDh28hnVLy9Kn/3XztYIT2rVpNj/xYC
 MdcOTeeDjZGLXcx7GtJGa14ZJAg792pDNKrQiKgwOwsSdaQR1AJM0W18i6Q94qRNpW7Ar
 dN9VdQXfltVmrC1xJsUYveilwdSjC2CxrM8PL5SCHfqQfd7P3LZZUJO3bg67QpPBFhGJA
 /kxhizBkx0iyYsXfiYFFd20SId3i5HZyVu1o9OEQGaEFSI5F6WdaWKHfeZB4WBEqRx4wT
 NXhAU/MVZSk5J9dBhdmKKD2WypmSJKzFHhzfGPz2vR3ebAs81KRG8d0CBPk+ipJTbzQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cofpdB3R; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=cofpdB3R
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D97B80DF0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:02:13 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b4f7d3cd98so328689a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455331; cv=none;
 d=google.com; s=arc-20260327;
 b=fMEImat028TnSXVJzBuGU6NxSUWmrk1/faR3qMcJgByMVXb8m89Bp+KZUn1r1FsNMv
 2irMvqON+ZA2dJz8apQUNmX4Bd0rkH6oNQUq9v7r9uPCzzSULx9ayZCUVNIZClEKwVtU
 t/ZUpQKlPV0/I0bBoON/Zm08fQVgZ5OYlf6AlFOhBKpNMWqIUN7y+4woCS7i2giZlCwM
 +ytKwmw5yDwWHSxbmfy4hOI3hv0gPtV20pT7JufQG6rsddRago7jaD4Uln5jhIx4p+rm
 IxBdmMyYIwnqSMnLUh/3VoyGZqe0MrqiP+dS6K7uyBBnh4KUJ3g/FYcazuyhb56yR6B9
 0osw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=WoOVTginyDbeSR5JJETDW2l02ShTRPvD6SPR/8+HoFo=;
 fh=nzE2e0sOf2xQOfsu1Q73lHHwm+fw021NhscFcTlusQI=;
 b=oXD9f8DwiO91GqiKZwrtFXX08ylfq45NMjI/2i7TZY0oc3B7onc8wfqEf4f0MDPHsn
 Rr8SUfPUm6LyEBK7DJlqnpyWMOztyCiZf4Ys4BKXn9Ylk+eFu/dNdAarjIwGhrDyZZlt
 aos+e98nMQelAIAVjIRjhP2MEktuDjKoMMwzx+xg8LdBOMlkhlvjbDSE/vT83aW0lfq0
 rwzfj7PRFIkrfmTgXp+qtbgVlG9cX6+ypOD79fE7nlXu8zbbW9+TvB3EYg9oLPNtRjje
 TUos5U0TspMFaq4EgfISzNOH8jmF8tIcy0JBaaj9wDy4gIFRgiWG7vJt6FL58t66cAkn
 /WnQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455331; x=1794060131;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WoOVTginyDbeSR5JJETDW2l02ShTRPvD6SPR/8+HoFo=;
 b=cofpdB3RvoWk3sSi2FYTHwf5WXYff1QK8FG+hWycqZFmldxnURIncVnMh6XCZcpt7l
 j6uKuq2T57l0dCbpwHwailBlKe7hapDa9OyIrDp1YibEblvOjG+FcxhngAyUB++3418g
 539iH8QO9foapR166l+D+nQOFvuYhCXSiSJ2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455331; x=1794060131;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WoOVTginyDbeSR5JJETDW2l02ShTRPvD6SPR/8+HoFo=;
 b=KDeaSskTHg6DWxYkpW19APP1IZxzF7HKH+r0i1TcgdsiFkcGaE+aD63b6wTVntz98t
 d4empNmkjBTW+gW6Y5unkZSQsFlIxBQN2iBwknDP/9DjfFpKi83Z8V1KVzHJ/nNP4Oq4
 N0TFQRnB/sNy0ETRRMiZqRrYz5Hi7aTNHkYVHuvJYDxWDz8ETooR4/t5oAUhVRYnTIzN
 a2lCO36l/cA8y/hSrk/AS8ZNSoqE0RsPOjFjCTFq3zsDpKVeraXiUEGJ2uJqvDzOQpKo
 zjZ3bnYOE2fxzNXKTPryPaPXQ28o4rl27XDf4azW1Ttj89xzPYkIIX5xDYbmsxnCNS5f
 wdNg==
X-Gm-Message-State: AFq9FYJQe4RZq/PIsoPFEvUBAIdjfo//xmwgTFXCRsR5VdQtXV9hb3V9
 vb2EkZt3zEzlc2Au40AEZDUEeimUgdFKKpSBQiYr/qoi0Rz3N6VucMQuQqYBfWOz/xYVsB+viok
 /33rlmjt4jBSCPb3REstp4YiHjHqSsdZJ0DiCRoOzsVhwXGZB730wRQ==
X-Gm-Gg: AYBFou2y6WcdRgd5uaaQqgfl5il7h6TXrKjnQ0ClpbS01KcfhwRL7b3Ddaoqed3Uj2K
 81LrF0HQvUzAZZs28MJlwyP8z1+VnM7B6SnRBu0K7vI99I9ht4cIVFV487IuGYMSWHkz5CIajBD
 RS3Gf9yOZBX3dSebFTwXkLZsgWDpTfIxF8qQc0RvIW00utX5kS50Ry/QnrfrlAMKvEkUoSFj3qI
 fQ/Ha3bGiITq8HyQgHvpCwNxhFPr1jIb4YBBR56TYwNfvTbvD98lIcx5cRP1bgRZSA9pViU7TAM
 M6x1nDIzzkMGO2+o6GESewA1OeO+Db0DSQoBMdEZeJVfT8jLrQd8a+lz9fsslqLM9RyuFK2DV+D
 DhNubxfW8RFGqcAdsj5i3sYoRPinIgPw9547MalkchmDhYFIvcdgC8CesrwBu63n9oCdytR4=
X-Received: by 2002:aa7:c693:0:b0:6b1:abe7:8276 with SMTP id
 4fb4d7f45d1cf-6b4d33ab545mr2682958a12.2.1793455331072; Sat, 31 Oct 2026
 07:02:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 10:02:09 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 06:05:52 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029173443.1495866-3-maxin.john@gmail.com>
References: <20261029173443.1495866-1-maxin.john@gmail.com>
 <20261029173443.1495866-3-maxin.john@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 10:02:09 -0400
X-Gm-Features: AclHuK9AiRf3w_mO3C2DHmfb0L1z9FtoG0plbDn7R4FRjwusahHz2-_I4R7eCcc
Message-ID: <CAFLszTjZ1XXUYvNoUrBo4ny+dFKP=0=q_xcOobs3D0Lsqdi0AA@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: cmd: add tests for the binop command
To: maxin.john@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxin,

On 2026-10-29T17:34:37+11:00, Maxin John <maxin.john@gmail.com> wrote:
> test: cmd: add tests for the binop command
>
> binop has had no tests so far. Add some, so that bugs like the heap
> overrun are caught in CI.
>
> Each operation (xor, or, and) is run on hex strings, env vars or
> memory, with the result going to an env var, memory or the console.
>
> The tests also check that:
> - short inputs are zero-padded
> - console output wraps after 16 bytes
> - bad counts, operators, addresses or hex strings are rejected
>   without touching the destination
>
> There is also a test for the heap overrun.
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
>
>  test/cmd/Makefile |   1 +
>  test/cmd/binop.c  | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 193 insertions(+)

> diff --git a/test/cmd/binop.c b/test/cmd/binop.c
> @@ -0,0 +1,192 @@
> +	/* Output wraps after 16 bytes */
> +	ut_assertok(run_command("binop xor 17 000102030405060708090a0b0c0d0e0f10 00",
> +				0));
> +	ut_assert_nextline("00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f ");
> +	ut_assert_nextline("10 ");
> +	ut_assert_console_end();

Please can you add a case with a count of exactly 16? With the current
loop, i == 15 outputs a newline and the final puts('\n') outputs
another, so the user sees a blank line after the data. If that is
intended, a test should pin it down. Otherwise it is worth fixing in
the binop clean-up patch, since this is the edge case most likely to
go wrong.

> diff --git a/test/cmd/binop.c b/test/cmd/binop.c
> @@ -0,0 +1,192 @@
> +static int cmd_test_binop_invalid(struct unit_test_state *uts)
> +{
> +	/* Failed operations must not change binop_out */
> +	ut_assertok(env_set("binop_out", "deadbeef"));
> +
> +	/* Literal hex string: too long, odd length, not hex */
> +	ut_asserteq(1, run_command("binop xor 2 010203 01 binop_out", 0));

run_command() returns 1 for every failure, including a usage error, so
these checks cannot tell which validation rejected the input. For
example, if '*nope' were later accepted as address 0 and the command
failed for some other reason, the test would still pass. It would be
worth making this a UTF_CONSOLE test and checking the error message
(or the usage text) after each command, as other tests in test/cmd do.
What do you think?

Regards,
Simon
