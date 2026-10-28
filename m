Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86527606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ugJEnp5J;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kc12ITZU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21E6040A34;
	Wed, 28 Oct 2026 21:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id poolkU9OqizX; Wed, 28 Oct 2026 21:40:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7CC8240A41
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793223602;
	b=E0n7dNo7T/pyiG0tka2u/CiaH7vH1xcWO8xhx3lA208Ji/Uhn2+rqlGhKMmGXw53BdAt
	 n1zdcGKGyDsh6XDpFW//83Ean3YROE8qy2y3VDYEFruYkK+BNtk2nTguhawNsnuUmho6A
	 wnHRPTdP1olcM4l/5rXcynsruoVq1PC+dh4krlyRNQc3soE34uNetBxCOlceZuPLPStoc
	 7tYZXu1Gy25b1FS3yY0w8PGIPtGH1hm2g8VRIjfJROCH1tSGghkfQP1mTVEfBm0CLWNWw
	 gIje9tfDkH5+Aw5kpAAbwNh16QHKkdYGRjftq9OwdY/949V7i6fMMV3IdLqIo0NvQOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793223602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CyvHiXaQTt2s9pPiKzfyD3MwRkN47N0JcbkzM/WCHsk=;
	b=dn7cqZWSwyc7LshaNeq4OHkcgFYrXJH2owkf3WDUFuHXIzVme3wT3daZHcJu9odJGSjp
	 vs9PZA3vQfJt8rcw4NS325Sdq6BPsEYGeT9092j9pwC2b43xEC3P00abq2V7pVI5DhMil
	 Kmefd2YdN2U2noq8S1OmY0xbMGYrGThiDdHxcMdSuiPuQfrrQBhSvnuQuirRgibu6Sihn
	 1leCMano9Wl+qLu9xDASLM4PAGKCOiWLNzEkPCx0aF1/Tsx7EgnVZQ8lE3AWaUaiOeePr
	 yKfmxAH0hT3XAGN2LuyilprMjS9ZadIjpNDOfDO/V+hVbk001uBcYxqe0tHaldMQy5Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793223602;
	bh=CyvHiXaQTt2s9pPiKzfyD3MwRkN47N0JcbkzM/WCHsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ugJEnp5J5rt76fFgG1Jfn/enzAi6tu5UFGSBh54O80Uo6PZowU/5rbiws/JiaTDrM
	 hzca4GO8lJDCNOda/0vpU6jZ6SYBng172Txh+UQ4BImwYi9mkRVKT2i4O+z9O/z8h4
	 KmN8ubvoSALeNmMLDjSu3IBpOMsdzyXhhoRSY1T+oIq9AVgw7bWTSCuVNebPxmTX+/
	 l0wgjahMblUoK6mX8offtfGNRuuRIkCq0ZPd/xn8mTfTbKkE5Q5or6p/KcDi9Rp6sC
	 Zop5EhWlyuAbFdBLTtf6sjfwtHh+PNR3SMNs/b5s2Dn5pP3t5xlbVf8s+G0KjKaO+j
	 3y++a8SdpExHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CC8240A41;
	Wed, 28 Oct 2026 21:40:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B121D235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96DDF80BEA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIOtSsMG-qqj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 18:51:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9CF2B80DBF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::12d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793213483;
 b=YbeVvhQNZ/gbrE5ZQrwB3gyhIP6J9t6QlLY2EsHcMjIRy0dhUnfCxKxyOrPFvjsVexEB
 IVDP0IYQ49so9HecolcByDqZzhmk6XUhFyo3LuUBNkFdPVHeMgUQJVjot5ysb2UX9Hbi7
 ZV9rUh7b+JulAgmd6wd5KrblPF3jYjqcEJWqXPbg6KGComBsiDtJrOYqfVsmNZfMQ/WVq
 8JWf34XyLFRTVmdKK7HlUU0HUWsOeu29UK+tnQzFSrhJX6Exu/hI2kf1NbWnM/Ge7nNmR
 TtThx80dC0FmTl0DnBo0IFkspxSVe2z/KbWxw/x5VIEy/qseMxMDbW9Z7aXaEDquRuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793213483;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=CyvHiXaQTt2s9pPiKzfyD3MwRkN47N0JcbkzM/WCHsk=;
 b=CuRHeFo77o87K60T7LgHFxvjENPer8KFyD96o7meurNrdPI8ckt1nSz1WPZXxyLv8LsK
 LU9Ff+NXP+HzbB0BqwZajfwKiZrQYySpZsa/0cWYU+sghBxIdVuviw9k+clMjGS36r+9p
 5cqFAVqIjlTAvquCEdDME5v4x2kGiEk0fVXJdO0oXNizHuA4ZdqCWTWR4gmO/ecz5Sm2v
 iwFtivvupIqIPmYZNu+t4ayTtDz3C2fbMlw8ee2dZHYAx3oUnila7bWKJaqc4uZO61yDm
 8/i/l1M+tgbnetwTuv8gQhrDA7b5bxzHW0VK2oHYW2RT2zFpni+XBT/FOyFFuIGdXAw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kc12ITZU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=kc12ITZU
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CF2B80DBF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 18:51:22 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5bfc2ae6e9dso1056390e87.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793213480; x=1793818280;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CyvHiXaQTt2s9pPiKzfyD3MwRkN47N0JcbkzM/WCHsk=;
 b=kc12ITZUCsa0OAI6DIgE/TJLpFE/dq1XAmX8Jvr4Hc/SrTFN3fbBpTRhjHTyG3JD3V
 uJu0+Hf2ITWquDimtoNwzIuu7fLBsXKEEizdveEmYbwTyW+HOmltT9THHLRpl0mdXR1s
 ZELpnt5WLgjBNLHEB3zHSTGZGDG099nHp9thGYPO5ckO2xlc3DW4YmrC1uK+m3sQkz3q
 z+aTlCw3KCCX52Yj78UWwdQAXTrWbe09j242kgF7VZ8W+FjZTSeV4ULdF8hJeowM1liG
 MVz5y5waGhRssZjvgbYPOMl/hYGYsP9HVnJKkN5tgXFRkCcnkfI4zbqJPm2ZEM+RuzEq
 DPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793213480; x=1793818280;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CyvHiXaQTt2s9pPiKzfyD3MwRkN47N0JcbkzM/WCHsk=;
 b=K59reSFXY6Qn0xHgNarYJ9UpDwiUZrsPPFuWO4g7+ABXYOyrIxbimtwuieYuQ5+tZU
 147fha0Q5cYY83m2bx4QBM1t7IMkKSYNfXOfacGYTlMANis6fb10s3+qd0vz74x3jDxg
 lZgmWFAbksyxBzzHAeAJNVnUfsrd0ym7Kc5bjNWRpuy2F3+FDU+nryAyxuuncUyP1uvj
 e7SogiaVSDxQnsl4hlUSo9rBg+dPW6UuAR5NiNA5JyqulLiwVvixmrqqGWQWHBboN7jS
 nSqIOUhr67bsAtb7oyTxS34PkyyFmNUvl8QBGYEXGGrdVqgvzK3klvINJJMO4d0p4fzg
 d+jw==
X-Gm-Message-State: AFq9FYJHrkh8t6RcTyjva8Trz+S7+jTCKQYcZ+u008MkmaLdyBmwsXs3
 /zEhrrjNnp7mKLtitadiHOprggfIWs7k0LW1JnSPRes7lThQ0/fQqVI6
X-Gm-Gg: AYBFou0zDtNQLSfVrG8Gzv4R59rG8gyosilSnXi5a6+neg5zlkCtXjJuO1TOdeB06l8
 E6rOZO4q9i5PmKGyMJ0+KVW1A2ykEyaX7AegSwdyYEMQaiTg5knBsy3Vfon86P1ji6SfQJ+I63Q
 Aomp3TdxNH6QLT5R/OI/Gsa+vdogUxf1EY83Ig6V4MH5e8X3pW3F+XQWwCXVKhmA5I1UMqVyxS0
 e6ozfsbINRi36RtHzl0vEFCDkKuID0gpYrmSSlWiMd18wKWG185BivwYOnJXUvdc78wDMFV3d5k
 uHbJWSiAAg/99A/aeEI8tgGsIT/qGvA72wh6p6zFhPVnOQ6W9NmLImjXeJJze6/w24tKwpr+U/h
 onVCp4ZKhRVICiI0tHZzlueFE5nzyF4vjPCRQAgkbWTIzvFo+2BwlR2AQUhSS4fycHHfG3uHtLz
 NZPauI490RBVgZ+0ZAmlCebquoLraNXT9bVr8RUUGSO7/jC+iz4XQmP7K7/TGTLLAuIQ6lDHtB3
 h1ZaUWqA17FClPM6fBrmW/wjptw/v5bSg+e+q+cPRP9qCHlfznVK1Sy19LlJOUnE+LHJfIdEL2L
 YAvWKp7JY7xt7rNL6rQF3+UUHyUdZgR85UrJVeGUBSLx9VFC/0dLBH+yQdW3TOQG9AGkQNATqSq
 2n7e4
X-Received: by 2002:a05:6512:12cf:b0:5bc:a9f9:b641 with SMTP id
 2adb3069b0e04-5bfcadb6d3amr1178670e87.67.1793213479754; 
 Wed, 28 Oct 2026 11:51:19 -0700 (PDT)
Received: from Thor.home (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfca5a9366sm782069e87.62.2026.10.28.11.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:51:18 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:51:16 +0200
From: Maxin John <maxin.john@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com
Subject: Re: [PATCH] cmd: binop: validate inputs and fix heap overflow
Message-ID: <auJEJCE1Fxlg7JIV@Thor.home>
References: <20261027151229.642110-1-maxin.john@gmail.com>
 <CAFLszTgxvQ9z8R=nr8COaFvHKS+cwEnmHjjG7ihhVBxfiBtunA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgxvQ9z8R=nr8COaFvHKS+cwEnmHjjG7ihhVBxfiBtunA@mail.gmail.com>
X-Mailman-Approved-At: Wed, 28 Oct 2026 21:39:59 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

Thanks for the review.

On Wed, Oct 28, 2026 at 12:49:53AM -0700, Simon Glass wrote:
> Hi Maxin,
> 
> On 2026-10-27T15:12:29, Maxin B. John <maxin.john@gmail.com> wrote:
> > cmd: binop: validate inputs and fix heap overflow
> >
> > The binop command never checked the parsed count, hex strings or the
> > return value of hextoul(). A hex string longer than the count would
> > overrun the heap buffer and corrupt memory. Bad input was accepted
> > silently and the command still returned success.
> >
> > Fix the count check. Reject hex strings that are malformed or too long.
> 
> The existing code has no count check, so this adds one. Please can you
> say what is now accepted, e.g. 'Require the count to be a non-zero
> number'.

Agree. v2 says: "Require the count to be a non-zero decimal number.
Reject hex strings that have an odd number of digits, contain non-hex
characters or are longer than count bytes."
 
> > Check every allocation and return a failure code when something goes
> > wrong.
> >
> > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> >
> >  cmd/binop.c | 87 ++++++++++++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 57 insertions(+), 30 deletions(-)
> 
> > diff --git a/cmd/binop.c b/cmd/binop.c
> > @@ -14,13 +15,15 @@ enum {
> > -void write_to_env_var(char *varname, u8 *result, ulong len)
> > +int write_to_env_var(char *varname, u8 *result, ulong len)
> 
> These four helpers are only used in this file and have no prototypes.
> Since you are changing their signatures anyway, please can you make
> them static, as you did with read_src()?

Updated in v2.
 
> > diff --git a/cmd/binop.c b/cmd/binop.c
> > @@ -28,40 +31,70 @@ void write_to_env_var(char *varname, u8 *result, ulong len)
> > +	if ((slen & 1) || slen / 2 > len || hex2bin(result, str_value, slen / 2)) {
> > +		printf("Error: '%s' is not an env var or hex string of up to %lu bytes\n",
> > +		       varname, len);
> 
> If 'varname' is an env var whose value is too long or not valid hex,
> this message says it is not an env var, which is confusing. It would
> be better to print a different message in that case, or at least show
> the value that failed to parse.

Good catch. v2 prints a separate message for that case, including the
value. Kept the existing message for arguments that are neither env
var nor valid hex. 

> > diff --git a/cmd/binop.c b/cmd/binop.c
> > @@ -89,22 +122,15 @@ static int do_binop(struct cmd_tbl *cmdtp, int flag, int argc,
> > +	if (strict_strtoul(lenarg, 10, &len) || !len)
> > +		return CMD_RET_USAGE;
> 
> There are no tests for binop at present. A test in test/cmd/ covering
> the overflow case and the new error paths would be good, perhaps as a
> follow-up.

Yes, I will send that as a follow-up.
 
> Regards,
> Simon

Thanks & Regards,
Maxin
