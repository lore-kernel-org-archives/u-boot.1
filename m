Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B4606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eC40fjbK;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Xo39CD0x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A3876083C;
	Tue, 20 Oct 2026 07:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2QI9Q6YdnWZt; Tue, 20 Oct 2026 07:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF96960856
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482972;
	b=WOXj9ZLiV5+6z7zi+Pt1IfNPIhHrXhuJ7/FJJFGfxUFkIql6ft4NC4Q42M6zAIKr0Sjj
	 IT94KxMFozWTdSJNoy/YyYzsbGgIzsL/Xz3kkF+YT+inUsfAhBbfy/s83W/Z9UY+832if
	 SJfvH2iTgp1J1rLKfc30N+0U67dAAbBgkLWbV4tFvKIc1d3UU+5+HlINuZHkfM6FB8BJg
	 jfilLPoyFhZEP4LPdql91jmGOWoe1Sc87Cqx921qMGRuJ9dvS6+G+O/B9bZvrqFa3ohIj
	 igAGZL7PSJpFvhhinKI2kW75C5y9O9ketHuUT8pPy6/R7yw7Z6MzTmZA3J7cjNtQfrw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792482972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rdS3TD3GwtkhTb7PgN/I6FWXDuptRuM4sb8VXa7P3CI=;
	b=QgvG3eaZmXutb8KGQWwoABDGiieImL0WAnSg8Dyv8XTedC9kENIv5gPH91XAmBT/yEqL
	 qKaH4jrr6mDyNv8XmR7ZWaVW1oPh9JJcnu91S7LgYuM1aJahCaDuAaafr9fXCmJTJnUpX
	 VmWA1Qj0Gji3m17uBforQbrS+zJSnjUuc5KaKCVBqY+k67fcWAqT2+H7J0T8mKmJr/HwJ
	 33QsJ0bEVD24tvKiqzHA5DmGLUeozgD3oHa0vR6MY49VBSfYd/djgbSfrix3l4fj7pV7a
	 f0f6dyiIiwsUHIE8KKWOouikGyrSSaNzOLUda/UxpuJfyYqzLTLju5dn8o7Pc8ZE2XQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792482972;
	bh=rdS3TD3GwtkhTb7PgN/I6FWXDuptRuM4sb8VXa7P3CI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eC40fjbKsgVr96NNNUko88iXjeVGaCq7bRUu1LwtIbghdmJ31Rma7rl0Fb6KDnQKw
	 Z5DWw+fDEVXWro9S2fBSkJWK85NhAzrAf7qADkLh52jqoqZa5yA7Sn5013V5E3xCU+
	 oD3vERyqUIqkBLTwX+xWK/tFrtZLi+E6SSQ31OwT8FtsSb8WhGNxCXFlyJbx9jXC1q
	 XuiOadDtR0P2G7c0REdt6c3n07V6sosFA9/nhxNGLx9S4MRzBv6Xj5aK5uiI9WMl+i
	 Fv+JITNA76yyxViY8Nzq16esVPUrFaDZ4cx5/DwRBVh/AZ4RUE3iCrdFKWkssaUU8z
	 PBZlW/k0IJRNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF96960856;
	Tue, 20 Oct 2026 07:56:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FC8623A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F53780FE8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbbZdRDtDp_l for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C81981006
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482968;
 b=ee926msz4h1tM1PGqjKfNRbwUbQuwfEfLRGbFz7cX0kKWAcWcDJCJZEvxvf1yICbqOKF
 dH//XuXw0ET2I5DiIdz5GhxiP5LthbN1cKNHzggdfRH0BLMDX9YgWwEwQPAjUbX1C2tEK
 Uoesx8gQXA420KTUYLnSNBWMmf72FbAY5oBlaULkTw8VLkmubmoUo4LhGr/5nUlspxubn
 lYxsr2fHlNqk/Ov/DTQCf1CSsFX93Uyn71s9D+5q22o0aYdqDOz6jj1JUM8F483kyRoWt
 zzRfIyfKYeSrZOUw8Xcnj19xkcbwXPrPZpu3QOZP8ZkT77XUNlt36qbkqU07BvfsOzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792482968;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=rdS3TD3GwtkhTb7PgN/I6FWXDuptRuM4sb8VXa7P3CI=;
 b=IYAF5HnQoV1fIcIil7PO/P9RXr2NELigg+q5rIa+5m1U4nGpMYc4BVUBKnqaYGVr6kQ9
 c+G/9+iwRA/06BnIRcVljNAe1TjwOOAP+z34zrFjnxBY3Ocd57uwV5hJ00TkyPtAHZ6ia
 hsZX2LCVAqDZhviu2pxq5Q6xnLa9C1Nm5344WrTSFlz3gkAbxa0oaj3AgH8IJYosOs6LG
 9Bm0CQBQq572Zf0tprV6QGmJIImS1r2G7d8gMq7sA8vicx8EP7IFHCTcqupOQlLoPwByo
 ZQ+2l1enl48MTk1uB7QY2mqUrdCnlDfeK6/NyuOoYISBQvnRLIpBhB8e2Bh7VEnV67w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Xo39CD0x; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Xo39CD0x
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C81981006
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:07 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c37b612635bso377561466b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792482966; cv=none;
 d=google.com; s=arc-20260327;
 b=UuFAp0iQg0IWXS8ndS3St/SXR+3LNYBiEo6NqvILJjDgKTgXhFL1qVb9VPrEj1Ec7f
 ggRewin/dAYA7uI8elynanVSe16BBdolyf/ooUVzhUhSEZOQJb6jHQ3il0H2QByER87+
 /OMBoykaSzlKb8XWRsZvCkTFeUph6MtLdJtkWdym7MqMSdEPSWto0aNFwl6pV+JNbTPA
 F+SYh+WMhT5ZEh7svNOvTAZ73btoZ4+Tzcjf6zfWZrDGZLmGAgDbNAcr4yJMq5V5SyMF
 s93Uf880FVOXXyi3osOWIpZWywdZGBfYLfA+fmD2OGV4h6s8MINvGpGoLOfCx7Xs73jX
 bOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=rdS3TD3GwtkhTb7PgN/I6FWXDuptRuM4sb8VXa7P3CI=;
 fh=oKj/xgv4qiWANteti62xjETDoPsv/T5Ip6MufvIY1GE=;
 b=hzWHVl56SMNiUZjnZOQhgHBR7CeRn7q1SmEGWqrvFRAzV6PO3O/CXBvHWc0zIiAmwx
 CwGCyUpMW/OGG6R55+2zSwm/W4egJsUTiJaFtz3NLlJ4VzYFRuNymfsqJCklvVaP1mHZ
 ERDJEN3yLwM22JYHQiLUt6SlecyTHYkIQ1BMaULift8ybWq+gaIoPcD1f1pgIOp1TIKL
 Y0Te4jzdxNFKv9gSPcvgKtieR014ivhGlolGJ/nqfQ45piWALYhP0dB/HvdvJ1M2+hbF
 cdXGMRPofrGovlveb7I7QhyEHze3qB8fuLBP1SVdsrsLBHufrilcIfLLgoWk/Qr0P4V4
 Esrw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792482966; x=1793087766;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rdS3TD3GwtkhTb7PgN/I6FWXDuptRuM4sb8VXa7P3CI=;
 b=Xo39CD0xCW1U0NadTjEZOgDdKSxc3AAeffDy7jgTgq/OXZmFvUmFPQFgKtlnETVy9s
 Af4e5zPQVUjsSldd1LcYchy8IKLyeVuvoAPp0qpOn6uUUQy9Nl1KVgZV3E+JdLYt35Mr
 h8caqggDRvYD2Lk8Btqo3W2fbl7HOIJIz7Ako=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482966; x=1793087766;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rdS3TD3GwtkhTb7PgN/I6FWXDuptRuM4sb8VXa7P3CI=;
 b=BhlekiwQ1Ua5umWiTxNSox4e6YmFRGNVYSm39iMFD+k2UYYltwunw7gbSQrfCz2Wcc
 3hjFowyEC+9h1b9gG26tbWfrg+/2mMQ/93NnV8QulDNDi8xQMxWKBcqWML76cwCT9xth
 OAjTMs5GTGWHPrHzyDeEgX6ozOpI0ONmFM0edT+M8xr5GVDQebQ1ajH1OUfL5H3MbYHh
 fOSyiBngDwe6UQraJmDQt8WPZrQE5lYR4afH0vRmTQcwcW1w//CjshQLCdaQFoPu3HAj
 oNwdyo+ZvIQmtYevtY63s+t3wJqNmPt2POIOBWZYnW3xOUqqfdIuVhCDo58ZS/EFz5Qq
 m76w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWhhn3azJ5ug2Xv3fzCtTrLWuorcbKzs51uueZZjBuq7rioB+A27YQG/Ix/ehnSvtIMYne2YA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIOo5DjDr6oT6M8Mp7RVVW31Qkvfr9rO8Y5XzeT2Lph32WMjM86
 2pA0EPsyBOE9BmzL1yQY+ZauJ91E0FQekGwHG5Y6v8ELEJD7xk5aLbfwDesbyj9fNlojyshAeiK
 u2XFbQuFkxXA7wIQRakMXPavKesgixsSkyvPQTu4v
X-Gm-Gg: AYBFou3sz2sLqhMPZlfVvSbdMVVDr2/rQDGI2VXPCFygFHxp3oUw3DW4AoNb5uorqGE
 6sykJ4p/aAMYJeuBfGDBw5CDmFRMlDFP8xlLall0kPiuFtVIvQgT5om4hROaMGTsc6cBHbaNz0i
 IgnxabOzL4rK+e/ugfbr2BG3i+RsbNfQfmmBGXncoL1L1MOkwA88ZC9wrEk2wehplU4PZ3lcw0H
 3CLSJd6+lORy59fZjEC3hLME0Kh0pYoCGn0ithb3IA16o8MW1QTWRQtLkEN6+/420amnyua9kmP
 rPPpe2X5JSm15Ig3t8hES5vx9j65SGX0Mc5nqhwTWSgtA/EYYelkNA==
X-Received: by 2002:a17:907:d093:b0:c40:bbd2:62f3 with SMTP id
 a640c23a62f3a-c41a1b8a355mr644727166b.49.1792482965969; Tue, 20 Oct 2026
 00:56:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 00:56:04 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:31:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <776dacf4f1e0120c0fa12f81126733024591bb60.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <776dacf4f1e0120c0fa12f81126733024591bb60.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 00:56:04 -0700
X-Gm-Features: AclHuK_7ngFZCvlavKAO9yZSBmPGMmT5I4buHlxkdQYr4QYjTc4DSAAfck__-js
Message-ID: <CAFLszTjGMycCqbhryBRMaOK4CjdfaSq6S04672ygQNucg_hKeA@mail.gmail.com>
Subject: Re: [PATCH 03/11] boot: imagemap: correct the lookup guard rationale
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: imagemap: correct the lookup guard rationale
>
> The comment on imagemap_lookup() attributes the need for its second
> guard to ulong and loff_t sharing a rank on LP64. loff_t is a signed
> long long on every target U-Boot builds for, so it never shares a rank
> with ulong on ILP32, and the guard is needed regardless: the comparison
> is against an unsigned @size, so an underflowing subtraction makes any
> range look like it fits.
>
> State the actual reason.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/imagemap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -72,10 +72,10 @@ void *imagemap_lookup(struct udevice *dev, loff_t img_offset, ulong size)
>  		 *
>  		 *  2) img_offset - r->img_offset <= r->size
>  		 *     The offset into the region does not exceed the
> -		 *     region size.  This guard is essential: without it,
> -		 *     the subtraction in (3) wraps to a huge value on
> -		 *     LP64 where ulong and loff_t have the same rank
> -		 *     and the arithmetic is performed as unsigned.
> +		 *     region size.  This guard is essential: @size is
> +		 *     unsigned, so without it the subtraction in (3)
> +		 *     wraps to a huge value and every range appears to
> +		 *     fit.

Not quite. The subtraction in (3) is 'r->size - (img_offset -
r->img_offset)', so what matters is the arithmetic between ulong and
loff_t, not @size - @size only enters the comparison afterwards.

On ILP32, loff_t (long long) outranks ulong and can represent every
ulong value, so ulong is promoted to long long and the subtraction
stays signed: underflow produces a negative long long and the
following 'size <= ...' then promotes @size to long long too and
compares correctly. On LP64 the two operands have the same width but
different signedness, so both go to unsigned long long and the
subtraction wraps - which is exactly what the old comment said.

So the LP64 attribution was right, even if "same rank" was loose
wording for "same width". Something like "on LP64, ulong and loff_t
have the same width, so the usual arithmetic conversions turn the
subtraction unsigned and it wraps" would read more accurately. What do
you think?

Regards,
Simon
