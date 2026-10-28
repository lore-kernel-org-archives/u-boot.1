Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA1606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FwS83Wuu;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kJUjrjxn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E703404DE;
	Wed, 28 Oct 2026 07:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuucV6DtntCd; Wed, 28 Oct 2026 07:50:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1C9740535
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793173799;
	b=pVB2Ox/pjVnh5ObmW3vRhAjINJ59DcxxnzHQxGSLP6HwzgyXW1Jd1sWJ/8l3ZdIl6Amu
	 7H/Uqx5bIkKn0cBvGlfs8YxlhKE0/H4R//7Yc/fbeIPTyhpLTfyUQkw9TME2zCoW5uVbu
	 oSxlDH5DVzl29yQzMH6pF116Gpzx0yeKOR5xkl2KRhXC3D3HVPK1K/1sK6gGwWeO3E0F3
	 MooDKHdyDmyemfYmDddTK1Cl79pJ4QBeD62Jh0YG1GNccrJnwWjaDJcPXSB49V19zsT7X
	 0q3T6s2o92nkmFRZTHU9UXiC0Qm+vguJCpH4Zk2Ir793tdXTfWLLW74BFSVTF/ph1/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793173799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MyzhEYsNJNvqNRAJbLaP+Awo/FYDv+Dg68uKnJpOUIE=;
	b=HC2jJFfS4RLJrVwgPgW/DGk6FMkptM1U5Ot4vRJzM2efAQKasTmFu/i8vdbrNJ2bS7/d
	 xCddualvf5vBhm2nErHowrcg30i3+bXrsPKqL1GTUL3QFUllHAL0IE5oLDM2iJHrkgZ5v
	 AmQhcGOqBraZBC55yBXqmDSGRrTDY9AcZqzXCsG+JqIeETE8tc1ImUryEBns/4I7vkdhz
	 xiojbEMpPB/L2+wCBxpbAFAlPw+Ch/qtnOfILU8q7A0iPzIk9PJdKh7GLrAGJK/DINYEW
	 0yZsUWD6hbymNmwlAXd1mHfGv5rKxqL/G6FxJzfjOVRUUaFNjV3HrMF+ScWcQp2JY2A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793173799;
	bh=MyzhEYsNJNvqNRAJbLaP+Awo/FYDv+Dg68uKnJpOUIE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FwS83WuufnYZimLCDRynkVNqrgfWES11xq8sNu7O9Ilh2ni/LBzKls7FnFArbcWYI
	 eUYdZwe/8rNAZ3+5gfX8Y/AGxXfoumNjoFGTanAJoyhJy+fC4HyUlb/gLgOMMCsA7b
	 fc0n70ttyRx10Z4hf8pawkzKv3hGU5QRtEnU1+TvGSSNq5C4gPWdBPZBA9qA8DvB1t
	 GheGy+08OtLuHjpF7LspiOLa98cgKFiI4aVNlo2bTIPrr/Mau5iqJXhKjhVh0jMSuY
	 wH4d+LNltcUfArMjOmMMLkl0TG2lDM8iwgTnB+eIuWs/183fzowQOnzkhRt8VRuiVy
	 VTod7p+lleCGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1C9740535;
	Wed, 28 Oct 2026 07:49:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B2842E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CD7260658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftEPjWDFDwXx for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:49:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 616DC6064C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793173797;
 b=f02N7jayY2dWU3ldQ4is1su++l9YZ0O0rkAf6Ki91JF85y0R928ZsaOf2k4W3njXUJZB
 weDOd7r9DY62CyL//0uIFiysewt6EwdwIBoAHbJyTOz8lJ8J7CplXQWicCreiWuVXihdr
 uNbL5EFBkHEUg7oocXm21SlCbchJVC2OlozJA3ZX8CIz8YYAlr537zxtClx6kpHx/VrPK
 S12bPJpTeegQWHFyOSTmnWhht9D1Xg4HqYQIe62P6yWZ5K+8aI3DlytZxvDob5j0TQ7kv
 HeFyt2NHxJ1N2iTL9WxLYODcfevkDyUunFWc6pkPvRTzDUWQVseOVrN5pP3juoTtSIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793173797;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=MyzhEYsNJNvqNRAJbLaP+Awo/FYDv+Dg68uKnJpOUIE=;
 b=SB5Kj5wKIWZlzHlqPqsR0XbAA7VHr5GA4HKg7krbpV0MiOdO0gRJH8LdWIWcZyZCO3UR
 JL4/oIoiBDbZZuteEmaxrtbWShe13VN4SMSzfb6aVh9yYJKypxccPuKwYWO79bqI/w5jD
 Jp2ewIMjwUTjgMIyaN8+ytXLX9qTDkPqYeF/urxpC2G92MGciHQwu51n96DLw0VGk3Q50
 6RK44JpHhcy82gwuuUyRx4HwB0ImJDifT7AnP5AVMgTR6hEOMXPifMGQhAnYtLAygWKdG
 k5j1hNNPJCDuBT19V4AAaE574PUxdR87UTDyEGDpJXnksvjqpX0XqGrNaXcH1zlc5BQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kJUjrjxn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kJUjrjxn
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 616DC6064C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:49:56 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso1029400a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793173795; cv=none;
 d=google.com; s=arc-20260327;
 b=NtsN2YO4JXJWQY2rk4Jvvf4eifCAR4idy1+G5KuN/QrXS6cZkL9GrURGXHXeOwl4gH
 BqzTVOMRBNw2EAKW90s9PiQKggm5YkATH1JRJ3IEnT9ioVViF+ZGLufZRFY3nwwpFq6L
 qLM1M4XLafIFr2RGDOl9UYFx/uI+mIzC+o6/Ufb/mxmC9XhEXvbp0TR0lO5L2X/v2Mpi
 qpkd4LAENTIcc+IyddfOUxVrRksoIezb9cAYX4ZbMdTFb5LV4C2LZi8n/faKvn/56y3O
 isOaUmczA8vo1lwSuMT1Ec2x2N3B5x6ZPsiOXCJaW6DyKP50LKy8KNtHd4LSRqItiwqj
 TS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=MyzhEYsNJNvqNRAJbLaP+Awo/FYDv+Dg68uKnJpOUIE=;
 fh=roxpdKPeJSqPijdsITN+QXVvPaO6+8qqlqZARCOszQw=;
 b=aBT7DguWCh8XsvxIeRxk1Eh6swZ0C/aJ3TuzmzXlYytLorqA+iHKCP5gVmiGpON8aM
 WV5dr/9K8MAGXCDkt4+Vl8ymp244Cb1yU0U5GDqvplxCoiKeILTolI5kIWRHNHQnBCG2
 XRNDYOoRJrtY9SJTCVIQgCa64LMgcqXh4AlmdTuQBOHe6Y2RXIbF8pz9Ypkep5BTGyAF
 Gp7Kb9zejUuDW2WPkP/2gUT4hddA35R+zdyPWfthBr90SdFvwVyNRVSCbONonU9FK/XX
 GONflI1lFGtVQgxnZudJWp9n9XgWqEfpfs2BD9vsgHW0o+xFECx591SF7q0TmRop6yfD
 k4jA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793173795; x=1793778595;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MyzhEYsNJNvqNRAJbLaP+Awo/FYDv+Dg68uKnJpOUIE=;
 b=kJUjrjxnMWD797J5OG1s8V9I1wyV9akIP9fx5aNsEVf+bpdpvCetPxQtlt1S3GQ5jh
 xIk52UrQGKSTygwrYbDMbHtCm9i/QkZ3MpBr1XBeTxjUMQ+U91odJDoqtcdzyecv9Mu3
 uD5UVMmtovzVrttX2GbxA2Xvdqzdum19Y/WJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793173795; x=1793778595;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MyzhEYsNJNvqNRAJbLaP+Awo/FYDv+Dg68uKnJpOUIE=;
 b=v4zOjH++o+Oa4BoJTdccwdIecdKAtdCUswJf6v94oaP41kGS7LP6v8K81WWEul+e5S
 HACAQg81xXV2WDhVOpZ4UWc8wMFEp7Wj1W4ZtvFpder6DAZB7xqdcftH1MnJIoZqz9Nj
 IeT4+MLXGRJuPc7Eg8s1BUdeTh/mxAKvaGzHBAP7JFyiw/h+9fJOz9l1WluT8ddmMDrq
 ALhRDBDe7NAV/YN+EeFEtQC5y5ze81pZH3oPbsvB0vusXAkBT06tAKkMJEZDmvomDHED
 qQSYYHZ4CuYKObx78IxrBYeFxl+FF35K0l+wMeeBSLg9+1nw8zeInKrJr8MHyBGBJhzh
 YICA==
X-Gm-Message-State: AFq9FYKe9HO3qQs4pUdINoMrTXbbHIH1vKkaWzsPFB5kcfS/lo9R4OZ/
 xmTRxqdxnImMSNNagH4xwZ5RkxpqUHZbF7fIcifBL35RwynsDoIGOdtwpCz0Icow0OZ3XzWQwlT
 O1kV45Xxc+iBwagg7niNmeZdH3ScjvxX5h/bDiCPt
X-Gm-Gg: AYBFou2ruBog1J4Au8MZAuNd9MeIFcLDr40VCWay3HD1VMHd820Y8/1hqat0aupTPHd
 DU7GqXuXU30eklxOIVtmCCXfnMZjarV6sxgxbJMu4P6/qvq8Wco1Wuan9MtD2rGw0cFrb7jq2+0
 x2a+LFTp/ao9QdOUlhODSlT/pqLBkP6MtGhrtk/n9u7VMZfmgmtdmzDy86dZBHiJOY3jzpCT+77
 MgUeKd7ktxFWfqhLl0yy0JMBo/1ih+WgfYzDyOtjRyns2NCv0YJI6B65wI9/8oP3p/6QiFy4ckG
 P0NXnlGyWpDkhwTZnLKABQbO4TXzgxeikPNwaDqIFPgNCUjgrCyb3H5FJTc5nAgSrABFSEiKfEq
 WGgrM2OQboteaS4hX4ZdeKi/0iKbGpyrGrMM=
X-Received: by 2002:a05:6402:1e8e:b0:6ac:7d58:dbed with SMTP id
 4fb4d7f45d1cf-6b49e57fc46mr574548a12.3.1793173794991; Wed, 28 Oct 2026
 00:49:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:49:53 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:23:09 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027151229.642110-1-maxin.john@gmail.com>
References: <20261027151229.642110-1-maxin.john@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 00:49:53 -0700
X-Gm-Features: AclHuK863fvTmlEQ0NXVuTVcXCDHokPZqL-B2BGUL3Bz8d_Be-_UEhnOgmvYwDQ
Message-ID: <CAFLszTgxvQ9z8R=nr8COaFvHKS+cwEnmHjjG7ihhVBxfiBtunA@mail.gmail.com>
Subject: Re: [PATCH] cmd: binop: validate inputs and fix heap overflow
To: maxin.john@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com
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

On 2026-10-27T15:12:29, Maxin B. John <maxin.john@gmail.com> wrote:
> cmd: binop: validate inputs and fix heap overflow
>
> The binop command never checked the parsed count, hex strings or the
> return value of hextoul(). A hex string longer than the count would
> overrun the heap buffer and corrupt memory. Bad input was accepted
> silently and the command still returned success.
>
> Fix the count check. Reject hex strings that are malformed or too long.

The existing code has no count check, so this adds one. Please can you
say what is now accepted, e.g. 'Require the count to be a non-zero
number'.

> Check every allocation and return a failure code when something goes
> wrong.
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
>
>  cmd/binop.c | 87 ++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 57 insertions(+), 30 deletions(-)

> diff --git a/cmd/binop.c b/cmd/binop.c
> @@ -14,13 +15,15 @@ enum {
> -void write_to_env_var(char *varname, u8 *result, ulong len)
> +int write_to_env_var(char *varname, u8 *result, ulong len)

These four helpers are only used in this file and have no prototypes.
Since you are changing their signatures anyway, please can you make
them static, as you did with read_src()?

> diff --git a/cmd/binop.c b/cmd/binop.c
> @@ -28,40 +31,70 @@ void write_to_env_var(char *varname, u8 *result, ulong len)
> +	if ((slen & 1) || slen / 2 > len || hex2bin(result, str_value, slen / 2)) {
> +		printf("Error: '%s' is not an env var or hex string of up to %lu bytes\n",
> +		       varname, len);

If 'varname' is an env var whose value is too long or not valid hex,
this message says it is not an env var, which is confusing. It would
be better to print a different message in that case, or at least show
the value that failed to parse.

> diff --git a/cmd/binop.c b/cmd/binop.c
> @@ -89,22 +122,15 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
> +	if (strict_strtoul(lenarg, 10, &len) || !len)
> +		return CMD_RET_USAGE;

There are no tests for binop at present. A test in test/cmd/ covering
the overflow case and the new error paths would be good, perhaps as a
follow-up.

Regards,
Simon
