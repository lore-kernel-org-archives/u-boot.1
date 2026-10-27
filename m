Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8AA606A31F
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PdVhg0nF;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KOkfXLG0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C05626075E;
	Tue, 27 Oct 2026 13:29:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L6mzov9Ci4gd; Tue, 27 Oct 2026 13:29:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D9640605D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793107770;
	b=PyCbCLZX0JTzEA8m0wcTGILq/WttrFMoxkjJ6UD+RYc3/Vp986cO0UZUEMy4+t3jEVUQ
	 VCOf2RVgZPon2ipsP+W1kzzTLx6/w7HjEwgl5GMyuvXRgxp+YSfDO1ymWmUJLeAORSRxQ
	 JqBHaGOQc9dsXeC6bPGpw+CbEx8A9oWHjg/E4SucT+F+jA3urhP7d5J7Ank+EgDf3/35n
	 L8Apj3uyFbUvrA7hPgg84jvprDHm5FFa0L3iJsbYGkLka9I6RfQpvQ/0aMg0wobH3FzLo
	 ZomlVXXCMJXnXQ0D9Q9bFfdJlaMD4YdMey/Z4G1/K4QR4+uzZYfLkHNWDeIj3Lz3RKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793107770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Mtf48l9ndh1o+auZdkaZjLkV1KqOfPYhyWrNoMI60Tc=;
	b=MFLRbL+UGcabXM6kOI3jgUXqPVXCCbzjTGK2lMcB8rLVbbCYVMS0DFbuJI1yw9Nu5w7e
	 DvLK3CO5KOXSsr+AW4GlyYnyTbD0SaF5XvlRdEvR5OgUK6u0ILs0LurPno54Fpjl3cOT1
	 Nq327+oB/cwKF2eFmdyabJHPHQjfWqtdwTPnDrr95Z5++GQx5qQpNxyGlJCjO7PoYl3hg
	 WnyHaxSwLJiD9yJdeaWxhwQ7et9i0qosTIyLzJWjQOo7/sg7FlQ1EazC79dNgXx4uvct9
	 t7FkHdbxjET5HBt+Cypc/MJP0dQSJfaYC6FzEzNfgDhXgL2jE6sYU+AlbgAEZtfzJDQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793107770;
	bh=Mtf48l9ndh1o+auZdkaZjLkV1KqOfPYhyWrNoMI60Tc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PdVhg0nFm6fyXwe23cxE9y6XBfqAZ6wF/3oYE5bSKQAnnHQWejUJZqeP4umeM+Mp7
	 qExHs3+lrsP/C6jBoYddVwb0MvKB58zIsozMqrx9eoLR4LcDFw+SB6W/TNDSOICzpS
	 4HtWHWOIGyBMHUZGhJMAlF2Y84+pCHHFday1nhuZKOFfPUBFHRQIPYoq0ny1+B1PDv
	 otrBgXhV2OoPnVjtgYmWXK0+UarwhNveB6vhLiEXuFL6vBDzeHlGsiUGPf80/H47cC
	 7WG6B1IN4dHXbaOWCCnwhUop/c6ToW6Wn9fR7GJSYZP0u6KIkRl62vbveOTYmgQs8N
	 ZkyWsVk1To0Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9640605D0;
	Tue, 27 Oct 2026 13:29:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB9AE3D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD90F40261
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:29:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4uyBmBGuiI5 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:29:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AF7874007E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793107767;
 b=SfIDQ1g2R1evzJCOUPgXJOtXXWmbaR0CX632kjO52BXD9OkpWZhgIguHPjxXVOeVII2K
 TUjn7IJaM0E3ahP5t3H6Nr5SW81bxv3VJWW5diE5htTnoYvqg8WRLk9lfed2W015DXQrN
 X9HBTfbdKp8fTMZiGall/rWY/g3eyBB/StK3rmVTgU69X0m02EDt1YHq9PpXI1m3MlRbO
 OmqJRRvo5HnPug58ljFjSNmezo+PtHcSZtHSWJCDokx95suTSA7BtOtr63FKsbETUIDMY
 DN4JjcY5prtTpmkASaoOGlx66O9wYrJIxVX99oXdBSU8vKhtfiptXSpAhbPVySIiUjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793107767;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=Mtf48l9ndh1o+auZdkaZjLkV1KqOfPYhyWrNoMI60Tc=;
 b=fQrExyxp12DNtwBIhfjcEPCyeFmeHgwKESKSWHUoJltN3GK0BidtFNnYwegqV/oHBL5e
 1YglSD5iWN8b97K/Dycrx15QQrQZz/6adgrF7xZIY6jaXXpwTj9umljLyHWiyZSIrcdkH
 s6qEFOiY9Cp1nlQZBxPuRmxLkULvb5N3zzn5rRz46mcfwG+XRVKPpdUCSjvoRmjePLupb
 NMBAtahzYL3RjIFqeNNFCmtda+KNZeQMOuJILKz02N91h+c+oy7x99sfW1j180M986fLm
 skOmzrBvVYGXizR4nz1P/5wt97hWmuJ8JrCrHfumt8lqDVZXBajLhlQA9cMV1H7X+uA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KOkfXLG0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KOkfXLG0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF7874007E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:29:25 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so6345335a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793107764; cv=none;
 d=google.com; s=arc-20260327;
 b=JXO9tqFp4VV1ijkw5r/CN/l+1Hg6fKBWBR55TkQpYA5HNrF28D/ffgz1MPmIue4yHu
 oe0axHny4eJiDX1nUzqZcy0wzVJr7QEZ1Rxt9vGPL6SXyxiGBorC4HRIrgJYhdFLSZmF
 xujG/F+BVJPvNUaCQTmz9lQ8UWT6rD35A4ftm7DbR68blVqmSdXvjUNdooQsLA2Mevpl
 4nDr5J+/RlUDHCzqTlcOMpA9gkcZt54opixORWXJHPkU89o4vhqL3cUtiXEvPViw1oa2
 ZYGZwsBcnxPe3yjO19zYSdXVrK8elukfDwGqwXKllKwUXEspFeiKFWRHLrGONu/slUOe
 zKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Mtf48l9ndh1o+auZdkaZjLkV1KqOfPYhyWrNoMI60Tc=;
 fh=MobRHbWoZgdLw31Ff1oMaU7mF/Pjw9wcT8En/nD/I3g=;
 b=ooq/2m9mVYm0Ypo6AfaJENkMy9/FzYXPLfPTO1e6oHQCsj9+6dVs34EgqCvsykqtkh
 8GW7wajjQDWgNuH3ijASvDzI6TyDRqZe7e8LCQBfBzInYRI61zZ6krGS7DUuFH5HVNKF
 +hYZvPppWuPPffQPMNbeDn4gv/62eiUPAeZOyHy7myF+AyMQofz0LTBLOiEiT2Pbimpd
 vlQWk9yrpKX+z03xq+rgI484SebiuUuY4QjP03eNWwz05u7e91XI4og/7xl2v3KGl60x
 IJ8ywJy1uopr+y7PI3iS6cA7EPzu2ubgSx+Mnbcv9TvoczJLGEXqttRKq+u0vc28uccl
 TynQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793107764; x=1793712564;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mtf48l9ndh1o+auZdkaZjLkV1KqOfPYhyWrNoMI60Tc=;
 b=KOkfXLG0sxwHkwdGUcOPUYkBmSwpnv7bKXUjMfFj5ln9UmhM9DumjlsRP6rcE33yIy
 qWh2lbM0Qxkm40cIg6U9AVdMDQW5YE5YHLiRlsGOT2suOveckkUkzQz8Xqmzipp2xP2v
 rAEbDVL0P4IkGdXHsFTdDaWHMOyd7Rq3MGRPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107764; x=1793712564;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Mtf48l9ndh1o+auZdkaZjLkV1KqOfPYhyWrNoMI60Tc=;
 b=aoiBLFDmpIX0LTIFMz9sUPz2wXeuszZYP109WBq8Wai01IqYQZc7PYpHpxvWCLmDUW
 tZ5tjsDhIjIsRPKYvWxz3w0MWaOvgXDNMLNVlMTnar8U9lbSVifrm0PcizGlg0JC3syC
 1055y7kW/uM5fea3EFcmwT4PDMGvq9wGUELEoOSSpj92u8JXZArvir/1kqKgr2Fbrhhh
 m2TldMym88qCvh6q5+yJTr1DzW+bM2EybpyDIgcfE1k395p7SH/3gh7Ufapn6jRFzHKF
 6vSj1u29mLG4SGZPrkIQ/NyJ4n7gJ04t4OsWj7ilVS+0A91KfwpkrY+ne5dMego1m0pW
 bQFQ==
X-Gm-Message-State: AFq9FYKwlIR9J//CF4V+zXJk0xjzeuKiFJc0Z6ilvXUC4FYZbCyli5Go
 TSBY6n7fNedBpoAkIeF05ocHRcfmyJ7qbl+HqllqGeSX+Glu1TSt3fWAlaBJr+0GWqITj604jGe
 uqfrab6tZ/gX6cRrisVr8XxtYHiDGMbaGMjar/i3b
X-Gm-Gg: AYBFou3R4DWODInkbsHe3PdMSv0EV14tMDPGSSAfqxJ6eMnTRzZc9bD5hA0im52c7gS
 LkoI12weZ1W3TiCVs5Gakwh9sleuAVoXt1yURbS74evagcEqj/H+oHIXySsRUQqTYrrrGigYP5/
 Kazrctq7/ma0BapvO4Rw/S/b+Fxd5oSVcnK+6tFtFp3qwVUXV/bVWEjKhbG8OJT9Vn/Pe5AsrGc
 iv5k277dX2AS7wn/NZgt2An1bDXaMIFCn/TNEOS5Qh+5aj1QJE2ihHlsuOWiBQEhkc7sCb2vngK
 6aXSSYGZ69sSgT9AHY/k/kmDveRMIvRSzNT/7CqQFE6HugeoQtOWmJMLwGh2mRdsTk6mv4H+nM0
 F3an11at4/MGK6cLbe9AF7ZX1prR/eRLYg8l3YWbXSc9KGoZzRuVEjrsW
X-Received: by 2002:aa7:c1c7:0:b0:6b3:d0a0:2781 with SMTP id
 4fb4d7f45d1cf-6b442fe4bb3mr6909992a12.24.1793107763892; Tue, 27 Oct 2026
 06:29:23 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:29:21 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:29:12 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261025231817.1155249-1-marek.vasut+renesas@mailbox.org>
References: <20261025231817.1155249-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 06:29:21 -0700
X-Gm-Features: AclHuK-LaRd6KSTvCZNbYnt0kGawn3T1Q2OlZ6XvwrKRgeS_g-k1vfIiKFrANpU
Message-ID: <CAFLszTjONjSgX97zYzFVFeDtjtL-hL_UbQ9LTkuy0yS8LM=o2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools: mkimage: Simplify fit_pre_load_data() data
 types
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 2026-10-25T23:17:42, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> tools: mkimage: Simplify fit_pre_load_data() data types
>
> The fdt_getprop() already returns const char *, get rid of the
> void types and multiple type casts. No functional change.

Not quite: fdt_getprop() returns const void * (see libfdt.h), although
the implicit conversion is valid C so the change itself is fine.
Please can you reword this, e.g. 'These properties are strings, so use
const char * ...'

>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
>  tools/image-host.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1763,8 +1763,8 @@ static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
>  int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
>  {
>  	int pre_load_noffset;
> -	const void *algo_name;
> -	const void *key_name;
> +	const char *algo_name;
> +	const char *key_name;

The helpers still take these as const void * ('key_name' and
'algo_name' in fit_pre_load_data_key_rsa() and
fit_pre_load_data_key_ecdsa(), 'name' in read_pub_key()), so they keep
the (char *) casts in their fprintf() and snprintf() calls. Since the
aim is to drop the casts, it would be worth changing those to const
char * too. What do you think?

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1794,10 +1794,9 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
> -		fprintf(stderr, "The name of the algo is invalid: %s\n",
> -			(char *)algo_name);
> +		fprintf(stderr, "The name of the algo is invalid: %s\n", algo_name);

This line is now 84 columns, so please can you keep the wrap?

In any case:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
