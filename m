Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DF7CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 15:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF11A60897;
	Thu,  1 Oct 2026 15:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CDsieU6EtVm; Thu,  1 Oct 2026 15:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0DF2F60A41
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790868905;
	b=j7kwtC+ZoLqYhRNhLbM3InjQwmVVUg34rtpDo1A+WWxaFMmlf9jDfrLrBw8pERF+m9TM
	 lpTpkNzEt3SIcJDWVrCBYB5dOTTS7iDrtvO2WTpkmTq5dIygfobYXuB0qV67OeQ7FEgQf
	 w57TEDq3uvwrMKEZ7nVwT7Mk3x1aFSDC5TVWg8i+kKH3jNsb9sYAJzk/lA2j7ghcYyDUe
	 FfaW4XvVR0CRMQQLBB1iJ5sJne49gwh3JYfii10g2+OdN6eos/nRjqD3ChsN8frrQh9Bq
	 sPP+WxFMh4Ua/RxajmUtG81VPD2+jtxKVH3QzACFZZ/z4ZKK4WYm205tpb0QJUJMt1w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790868905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MrH9wjKiOFBI7owHOAFlpSTvD6uaDWgt4XtU/cWA6Tg=;
	b=OlgnOxz+uKbGZxRwRRrpPTMx2o+ugpNv9y3Vvz8Y/KLqD8xbZFtUkYoycHxGeQrDm3xo
	 aS7SKRJURCEKV858+lQjReTOz7WXV96znjg+W3fx+2EMElpnSEnotdy/S/2Id5jbn9a94
	 vLZInKaLeMQxZnv5wrEhJpf6niKRpWnBXNm+OUu4PLHlmn+FCrRmLsy1TQi+FDLdd3CPy
	 ort2uBGx6dbtJsJvaX1IyhAj0Yu6UDpShKWNbHZHsYGo27FHBhnQhWW1jD0Y4Q5iVRgc6
	 AU+lRZ6ItMHNkTS95Q0id2RuwC+F2iqMO2NaTn8pZwmLD0FKqAy/YVUG8dLqLTFAzYQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790868905;
	bh=MrH9wjKiOFBI7owHOAFlpSTvD6uaDWgt4XtU/cWA6Tg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ks5GXDleRFmo+4gIB8k9h8cCSRFGrsU7F3zwyGmjstwtxWeqE5fW/uCE+GjdEwyOZ
	 KaJPmSA2s6wXiVhcA9m1IAvLdzoV2dS1B6j/N9JKa3JcIgJXrWJ2EB5hDXyqw7vuzK
	 SvjruxKNn9An+EbRsmTyUKBYI/JGIQV1dohUW+UO6PoiJ/AHyFPnd6flvxIJ0TgLQR
	 AmRnbrE00B6TJmlDbTl+UweZfgYTVf18JMP2G8I1HkaY7voxNI7OQNBWdVkiRjxswd
	 7bys8jZgaNBGKHU/IHF3kXFx9M/bFLa4lRQB2fR9TMt6DJ38Ct5c1vuAvCssKoEHdV
	 4Vq6OgyhPWuAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DF2F60A41;
	Thu,  1 Oct 2026 15:35:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8C6B3D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFBC340098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mwGEqKxPR3Zs for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B58AA40528
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790868903;
 b=kmtS2glpUEqXV3btUty+qxo/GbbISEe+4vAUnwOnclWVhMbIUW0IVsFbm18oircyiYnW
 c1KsGu/aos5ZRVwj3YaYMICElANs0c01AGmE0By84oUeUaFwW3IBw5PFaGGhKZZO3oUxD
 k0PVSBlFMCVBjfkqZtELaQpULLYHe2Kp8bCCPHqmNMN/JbH4AH82WMMjJn8phJ80jBCq5
 JmUH+8kgmS5quFAc9RU6Q0zuj3EyCzHNcWiZ1QX2SR6VtdpVyV8iNiuUj+HTzenZm36uE
 Q2FZv90M001TlrqyMdqvQAHI+n1r8vqah2ngeeSiLvYSaR6LumbDsWDopSGdknpkjkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790868903;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=MrH9wjKiOFBI7owHOAFlpSTvD6uaDWgt4XtU/cWA6Tg=;
 b=nIKTYA/6qW496fIBdwu/ijqsfDli17WmJmWtT+ddd8xvUx7XX28rD1ZBzx3rjScEicNo
 us0HNbSUZqPGekGB4wcIiXK9HOBo/1aFLZpVxm6KEub41gwSz5qVEglwiQjHf0BUG8bT4
 u6Uoa1ZxHSXXep/XAi+UD8yF+Z1Sy6Ccs/lYIc8PB6TLFzSDv5FP1+aavkZYJb9xcVKV6
 XYyCqIMGO+NehcdG8cxSmyKa5OWv5nZ+MAEASUXaZTOrc+WMAmuSdW1zwpomDGgTvoZgc
 klBURqNJyQS1Rf5JuSLvow7t/4MrDleij0s/L9y/284FYN1wfuRZqpYn1Z2iPYmY2Dw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="kVKr4G/l"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2b; helo=mail-ed2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kVKr4G/l
Received: from mail-ed2-x2b.google.com (mail-ed2-x2b.google.com
 [IPv6:2a00:1450:4864:33::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B58AA40528
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:35:01 +0000 (UTC)
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6af85996a92so393153a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 08:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790868899; cv=none;
 d=google.com; s=arc-20260327;
 b=eM2abfWNzpFtpRBlI0wIQZDuetK14IYj4ba/oMhJJJhvSKJkv82TZ1/IO6kCjYRjrT
 b3OnYMQ9DcjoNmU35cIt/lIDpzp6vM6Yd1/wUQb+bYAc7DzzfyPgSdnIvdtpZFBHlE7j
 5KSRJNaw8KFDS2iWeNOmj6bByYDhIqWyjFApueaLLdR8CTCHZAeO4hRwzV4Flqbgri7c
 ZiA/0zP2ucjl6Ooj5XFVO3sNlH8F+LFGFV8eRz6mY4TIkGjMJNp3MfEYR2aq9ueP4xsB
 3k16bgWEKz/cRhx+pcOXy8/qmS2o9MyL0yI9edvYgFGO8VVBn2QiKAQw2nBrxKb7lPhN
 KDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MrH9wjKiOFBI7owHOAFlpSTvD6uaDWgt4XtU/cWA6Tg=;
 fh=SZWRwRB2eydBZIDGUvU9lOvA4h6PDO0/7AUOlFyuM4E=;
 b=F9+IcHbhRz7kt2EAU6QTtPs2LJ1BBRtBIuUJ0DRYIw7ktzspYtEPF0s18Bf0003IN3
 FYlJBDfJI9NFwzMV4M75vbZAxUbaLhiH9idhnR7/2n5roddoSTmyGv45fk3PzpLhq5+I
 YQ2qF9EQsalzh3Z9l40epUOVhUrqERqTN3Nd2NjywKSbb03h01N2+OPKvdYDCKs0mbkU
 7MGd79jCpBw5gW6m6y8bsrRNkgqIxitvFcvBdVv9wMHwchRrSvDsL0mNWxZ7fkYXp2xt
 D5lu5JckchZbVJ66tlzfPZXxGkv9CNJfUHhmmFODtZkkjr5h8nYGmiGdsNtClsSYi1Ik
 gZUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790868899; x=1791473699;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MrH9wjKiOFBI7owHOAFlpSTvD6uaDWgt4XtU/cWA6Tg=;
 b=kVKr4G/l9anCfqSLtVdh+cmM9xJUoMZL39KN2wFxY6L2YMb5Zg9GMiK0jC74HWephT
 wiShZ8yMkQ1PE69bblIK9uh4Zp29Hf3d26p9YN9Ksd8v7Zy0BSZkxvADl2E7YendtRjB
 pyangsz1rRT3wQsnuNpl8qHJm32AxRhdU85u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790868899; x=1791473699;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MrH9wjKiOFBI7owHOAFlpSTvD6uaDWgt4XtU/cWA6Tg=;
 b=eRwocxMl8oTYIOws6UAlDGBQd/4uCpZld+EcRuYGkjtCwv9m6Nhy3yDrTlqBHlvyaN
 EMEJta5A5ZMAKw3ywWYaj7ZRRA3WT8VxI6ba4AQqsDvUYp/mG98P3sR4yUo0ZPbX2D2M
 qSaT+Wjd2xWMMtzK3KeoNL7HtK+No3ZFpc/aGYII8K5sXnl5qwa1tjUSiFpY52qAjnfP
 jZetAAhn7WdbgHwGUdU4LiVSqb58ZBJqh3xYu24vqQzK7mPboGXPqgdM6HgT12ANPpOr
 6FmZBDXXINUX7qtu0toXik+IM2t7Xl6zdCFspzxTGM5GmFM2ZmMkVd7sovBJCCJUa68c
 57nw==
X-Gm-Message-State: AFq9FYJmLtcNATXsURj3djii1w5vqK4zvHDGYBIaZMOpLXSNTu9q32WK
 fc2rkEBV/52LiwxvwQ/WkdOhAqhZaIAwpdj66xU+pmjdTPFOwkCdLLOUOkTsr9PWkp47fcAbRVH
 RX2X6IftlXoo17f/qZroh6r9cdkOvicv2/C8glal1yN3AGtNeLUt8HA==
X-Gm-Gg: AYBFou1t43V3KUJlJquukxEe0xL1LRKUja0fVgNo88wwg4y35kvRJ6KPE1jGSavuSKS
 YAMgKT66K3qh/fsaEoW5JGu+l2kT13fzpUolWROYZSJ9bCpeNi7agfKCsb8nmpC6Wq3KDS2npHL
 +TmiRA8dM2TwUuCWYcvryiKVPw12QU5q0htQf92naTvPmw4IXLFkBSGHiJ0agxEG1+W9xd3tWlO
 00CVHGOh+z388vSyg5C2kYTGRohL9uFjEz6NGom+KILwAHqKmtS14xrn4c6ANFPlrw0ISof4OBK
 dF1DpN3zMf4rajkVDLUfvl5bKH7wjLau6f+fiEh+RisxBQVYGJN/NKYnCc9u0mD0Cvo=
X-Received: by 2002:a05:6402:50d2:b0:6ab:e30:c9a0 with SMTP id
 4fb4d7f45d1cf-6ae307f3220mr2948405a12.13.1790868899411; Thu, 01 Oct 2026
 08:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261001071620.2377255-1-prasad.kummari@amd.com>
In-Reply-To: <20261001071620.2377255-1-prasad.kummari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 16:34:47 +0100
X-Gm-Features: AclHuK_hcmhkB89Ra6TWrWRJMO5mR0lRI68nQ4FLuAcC2uoen80Ua-h9k_wE64c
Message-ID: <CAFLszTgdRbTrANeQya0emHgEmsZvqd2ujx6ycwDFq-xhUfr5+A@mail.gmail.com>
Subject: Re: [PATCH] rsa: fix undersized modulus buffers in rsa_gen_key_prop()
To: prasad.kummari@amd.com
Cc: u-boot@lists.u-boot-project.org, git@amd.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Prasad,

On 2026-10-01T07:16:20, Prasad Kummari <prasad.kummari@amd.com> wrote:
> rsa: fix undersized modulus buffers in rsa_gen_key_prop()
>
> n and rr are sized with a floor division by 32 (num_bits >> 5), but
> br_i32_decode() and the zero-init loop before br_i32_reduce() need
> ceil(bits/32) words plus a header word. Whenever the stripped modulus
> byte length isn't a multiple of 4, br_i32_decode() writes one word
> past the end of n; whenever it's odd, the zero-init loop writes one
> zero word past the end of rr. The modulus length is fully
> attacker-controlled via the DER public key's ASN.1 INTEGER length, so
> both overflows are reachable with a crafted key.
>
> Switch both allocations to ceiling division so they always hold the
> full word count each site writes. rrtmp is already exactly sized and
> is left unchanged.
>
> Fixes: 49d0ea3746ca ("lib: rsa: fix allocated size for rr and rrtmp in rsa_gen_key_prop()")
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
>
> lib/rsa/rsa-keyprop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
> @@ -687,8 +687,8 @@ int rsa_gen_key_prop(const void *key, uint32_t keylen, struct key_prop **prop)
> -     n = calloc(sizeof(uint32_t), 1 + ((*prop)->num_bits >> 5));
> -     rr = calloc(sizeof(uint32_t), 1 + (((*prop)->num_bits * 2) >> 5));
> +     n = calloc(sizeof(uint32_t), 1 + (((*prop)->num_bits + 31) >> 5));
> +     rr = calloc(sizeof(uint32_t), 1 + ((((*prop)->num_bits * 2) + 31) >> 5));

The rr line is now over 80 columns and the brackets are hard to
follow. Please can you use DIV_ROUND_UP(), as used for mlen in
br_i32_reduce():

        n = calloc(sizeof(uint32_t), 1 + DIV_ROUND_UP((*prop)->num_bits, 32));
        rr = calloc(sizeof(uint32_t), 1 +
DIV_ROUND_UP((*prop)->num_bits * 2, 32));

BTW there is a related problem. rsa_get_n() only rejects a zero-length
INTEGER, so an all-zero modulus (e.g. a single 0x00 byte) leaves
num_bits as 0. Then n is a single word, br_i32_ninv32(n[1]) reads past
the end, and modulus is malloc(0). Please can you reject num_bits == 0
with -EINVAL after stripping the leading zeroes, perhaps in a separate
patch?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
