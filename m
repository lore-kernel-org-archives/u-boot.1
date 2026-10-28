Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0532606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bm4rdurU;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=G7X3XvMu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DFD580DCB;
	Wed, 28 Oct 2026 08:33:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L1gtosKq9gJm; Wed, 28 Oct 2026 08:33:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A7B480D6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793176419;
	b=C1i+1b7/LRuPSntsoMseJVAHb86++RfFnPNOaLTz7vS1ZG4PPM/L2b4QKVzszNSyu7BE
	 fjCq+37P2q+iGmxx/6tZGawncb5h0Z/yvNHhYhylyyPFqL23GmH5ld29qnH3UDaWyRfka
	 sCXKc+JuWd4Szx7yNn9Yh2r3MvHb6ExO/XsXbWpcP0WBn2m9NeAO10BobzT41xCeMEbON
	 vDtfHMzfkcHmVDHenBpuapXWXp2QFh8H1ot1zvBz6+5YM+6rFeOO6AvaGGxiHlOt9M0gG
	 gEqGZ6avERfgNb5QsZqPoglMoEPowSZCXw/G3SA1XwOnU/Pk2ghKp0o1dv4QyMNFQ8Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793176419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D8RhyX9TxM+jZIAyqouOttBsNSt0PruCN2c1EC0FV5M=;
	b=QTjdaUfAhXYcyWa678Ipcezj6l2uiNTLOi8lyBop+R3sUnaj4yZNB4nB9yr3iizp420+
	 xSSbcGq7MJLBlROKcyTJreNTzJl6lGCBqniA50H60FX7etsCYtKXgy8RLN9tJ+SjaEyaj
	 pU5Tz/xyWd9BUTOVGVYH8X9oq94u85VWlqNFc70G4Wo+SKuSbzR62rx+RwVQvP6mpgLnV
	 aLvNpb28XfS5d009eHn8xU+UZUncn4lXtpEyuDJYFdLyB3PTcsjBuklwWHUxezByEpw3U
	 QS042do7hVzcOSrCuX93nQm3eIqUnLGQhSShoIRi/P1R+xHqJqCNTV3uvNkjcHLO8UQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=G7X3XvMu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793176419;
	bh=D8RhyX9TxM+jZIAyqouOttBsNSt0PruCN2c1EC0FV5M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bm4rdurUeOPDCxUq7zPlss0WJU5fgzXprGRnjEx0i4JSuRuS4WgUTh89ZBwJT3128
	 6ZLvZiJZgi62pAfvUzs1wDdg6wt4n9Cbeixf6B5WitJRfh3VYCL07on25oAWT1zSxV
	 HdaZTevydZ6MrDehbfWdv+dYDlNVw9wL0Zs5RBiI61EWizIQvQmcEtnbxh9tx5ihTS
	 r5TCDHUmBb2Ckba8GhnFr2p3/WO9mLYyQIWTfminxcfprmS6I1hx72J2tGw6Bl89H7
	 Gxr/HcA5RRKL2IEo6NAb4aukY8BDH0Xgmkse9vu4qI+9Uf329vwoawNt3gq9e3t0Nf
	 pmmU9Mi1W9z2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A7B480D6A;
	Wed, 28 Oct 2026 08:33:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AAE62529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C21D80BEC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qjXOlA0yVjt for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:33:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A479B80D6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793176415;
 b=Mqjqoracujl+w3RQs5MT6rTJjTk5P0TWnHKK8aBsetZKA6vYNMfk7Qay3zT4fkj89nBB
 buYcblfJ1+6otX9BcW0Ttx/mNCf15cRGFR8scL0exav1INquIouw6S2YUEAmDxuexdlju
 pucVAuh16gxJR0CLuLQWHIvdkw/3Fd0LQDbwAqU3pq70Y7qHe6sLg5E1J0go7s4n6cKTP
 ci26LLBe9PpiVhrFfF8r2+WSs3MsQMoTOzjHFBHnJkRAwyIGD4wJxk+I7FJJM0l1JmcZw
 Qf4NTQvG4alCLlLdvg5Ydrd8yDD22sQJcEVnh3YiWLN7BhFn7ookWRPESB1EhS258lQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793176415;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=D8RhyX9TxM+jZIAyqouOttBsNSt0PruCN2c1EC0FV5M=;
 b=DsEfyIWODre/41qYIEi3pajsrv3FV5jWuFkoB2G1u7i57g7NO0XAv7l863/oiHkn6Bte
 lcCPNy2mDkj8ScjPG97WRCaS2xF/CqtSq7AIZQOHd75PBa/atYv4YE/cyK5y8yCv741NK
 IXuxns8Q55s2rhiXCpVgTm/VzzL+Lq1YxPE4MNdGKtL+NjVDHWwCkxmFyynxTXEfkHTwM
 TYY8eTUuyfKbLwWYHfWw62ge4FPYM+5XkvBLAp/3zBhSANfPm5ui2WKoN0Wa9RMikup4s
 XoOHqtJ70ZtHvuiP4dPd0KuI9zCnOq8+po+aKQz8L31SUb6/szOYwMxryyRvTfbOkpA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=G7X3XvMu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=G7X3XvMu
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A479B80D6A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:33:33 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b1f4d8e09aso1075270a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793176412; cv=none;
 d=google.com; s=arc-20260327;
 b=Jt7hiehReGXPTdRbxMZFZIzWu+V19gWuZspoHaNvVXp+EFYhr9+sHPb8Gz33WR31EE
 ZSbYw43Ji0L+QaDQfHHWcUWknERrcrs5DumsIRm4/9Tsol7E9xlGiug/EvFp64zdmjKD
 cQzVQ+EhFOl40RmHxLVKOqBRhOj1yTWxHTuV08k+FvCH4tQUlGVx/MkDBOjpmzTrPPmr
 JrCgQGbrfNEziPPWNh+y7kK5UDgXbYO9ykfNs7YBx5+Sd1psSjiw+ncWCutDxuz6kkwC
 VtaMD+PpRHIcPcGTNe8SuSzHgQeYUSrT8zb4I183GiPglUO3c7hzwSrSnEaJWwCmNws0
 5JiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=D8RhyX9TxM+jZIAyqouOttBsNSt0PruCN2c1EC0FV5M=;
 fh=fOL/VRzgmEzJcBVNXrC3naxYVoxFkNSzM35qZdBosIY=;
 b=lz/KCAKXl/8yElU/wglp69GSfCciPIqjXDcNjaSh76fGP0NZXKqvDp6hOBdVhzFOTe
 hyUodQPS3T7mYQmEqftCaMs4VORXWprOa8gwzIFJv8MGV3722n0iZxwNn6uDVNJY6RfL
 P1RY8Okl+Ae18+GDLwHZ9+eIi/bkS8AMGelDxAd4GB/xxEfUGQaciUYzWmWOUb8Xba3F
 P1t1xjethY3VR8klxoWMONe5wswgrDjZC3kqN+d6ypxVf4A/YyRrBaTrS+ztbBpJ7dFW
 E3pGBr2fnM+zgxfcvDr3RLNdwdqW4s2ti9eBX3A+Qd+isB8FO4O70l3b4oB1e94aYDVc
 SkFQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793176412; x=1793781212;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D8RhyX9TxM+jZIAyqouOttBsNSt0PruCN2c1EC0FV5M=;
 b=G7X3XvMuvYfkPp2rz8btqnNDBt60IjDvB1rkZKsooN9jxxrjXunYKNgNooXdaskRf9
 X5crdPLvwUZNJVlfupr0TIi0ncj/sVY0IJMtN/W4Kaz+p7pWgz6wJBb+ZspyegnBXJMR
 jRSdXxujOA/dMPN4RelDnhdOIX9Rby7sc0QpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793176412; x=1793781212;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D8RhyX9TxM+jZIAyqouOttBsNSt0PruCN2c1EC0FV5M=;
 b=XTCvBcY7onjxaht+M3/zjchR9G2Z1b3m3HY7LAfcxTCQwAOUUpS+Y4ZVZzLEgW/Eww
 hmORqyhv0yFp6Pq3fscDkwIU/xH2mROi++eX7CNGybQfde2Jh6d+ooeq8TryOCQiL8qh
 Hs026b01/9N6gypjTGy/a98QrKtpgA8UWfP60P/t94wg99Hzzi1RMFc5VSN6m0PNZ5xD
 uDaFvMVkYRdu2An/CKdiHhSCZAkir2efU4my7giuE238LO2NW7Mos7E4iRL+RtMZSX/2
 VrSEwKRhS7Ms4nDPQQKIbXlGkPxJbZW/wzaozLktqdE0JPLQiod1kFy8j5OctWrbW55S
 g6Mg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxT+Dw/xELnrG9RYAzICm3sjdSRKJgf3hCoun3jQc7pS9Ao1tve7AJG2BWuufSA5xOm1F37W1A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIq2D1ECRGt09acv8E9V67tadY5/UwoQJ3/UNH8Z6gqHt+eFV7N
 76uL/pI5zCF1TRaDVG+CINrW/j1GLVozRp+nAefraYkvO8EU60ist67sCJGyrtgwilgllsWJukZ
 ck9Qxpg8MD2/VhrZIwZWZEMnBP9D/CVbelVTM3kbwfZ1eJLGVIMZlUw==
X-Gm-Gg: AYBFou0Iji2j5oJGesapTp+p6AgInk+7uGdxKhH1ZkkUXiIW8Kd2E/1w1HTLMXhxxl7
 6G5IbozQQIbZUjVU74oOH5ws8Hx8mz7zZL475fZjz6IecUlOn831WuP42obcagETy/Eb42BQgTF
 qOacuiXCwM010+48/EK3JxSK4TRMgaCEsG4DbwH7V+gHHdIKQ5l/cfL6u+7GUQEYcxBA6IEHjLK
 OFGHSeAdU6DsHxJUdyH1F2F8bY0JDdMTgEvR6zlS32WfxNLv1TmcY47Tf/77vDC1HCWiRDheKQt
 rqIYqSkd1vpllVX3ERBzD6aZmYtH2D7vdoTzcuRyRjoHwdqmQwrTge/htXqTjIhfj32WtdSHF86
 4oQE0UTg7kNTuJqIFJdPgPa+4w6KucV9sQxc=
X-Received: by 2002:a05:6402:1cc1:b0:6b1:c1e5:a85b with SMTP id
 4fb4d7f45d1cf-6b49cb5a7bdmr1031715a12.3.1793176411741; Wed, 28 Oct 2026
 01:33:31 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:33:30 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 02:23:46 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028021415.2439865-1-ehbello@gmail.com>
References: <20261028021415.2439865-1-ehbello@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 01:33:30 -0700
X-Gm-Features: AclHuK8p2-2L_JPOAFzlcpYtfC9xq7ryXE0lxUIgxoQrv9PBkXx_qzJVEqIhJAA
Message-ID: <CAFLszTjf1sv_018UjfSPZukTAiSEcosVK_9rrZYcqq24Qsa11Q@mail.gmail.com>
Subject: Re: [PATCH] tools: mkimage: copy the FIT in process instead of
 shelling out to cp
To: ehbello@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-10-28T02:14:15, Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com> wr=
ote:
> tools: mkimage: copy the FIT in process instead of shelling out to cp
>
> Rebuilding an existing FIT (-F) starts by making a working copy of it,
> and mkimage asks a shell to do that:
>
>         snprintf(cmd, sizeof(cmd), "cp \"%s\" \"%s\"",
>                  params->imagefile, tmpfile);
>
> so signing a FIT needs /bin/sh and cp on top of mkimage itself. That
> rules the tool out of the minimal images where firmware tends to be
> assembled; in one of them the failure reads
>
>     mkimage: system(cp "u-boot.itb" "u-boot.itb.tmp") failed:
>     No such file or directory
>
> which names cp but means there is no shell to run it with: glibc's
> system() uses posix_spawn and returns -1 with ENOENT when /bin/sh is
> missing.
>
> copyfile() does the same job in process, is declared in
> tools/fit_common.h and is already called further down this same
> function to restore the backup, so use it. Leaving cmd empty makes the
> existing "if (*cmd && ...)" guard skip system() altogether, the same
> way the auto-FIT path above already does.
>
> No functional change intended: the temporary file ends up with the
> same contents.
>
> Signed-off-by: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>
>
>  tools/fit_image.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
