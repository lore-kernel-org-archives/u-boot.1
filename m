Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBF4CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 14:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC1C060FDB;
	Sat,  3 Oct 2026 14:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XN8eXrDf1eQg; Sat,  3 Oct 2026 14:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DA86E60FD8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791036779;
	b=j3hDJE6CLsEpACvz8wKhTez1IKEA+SonIzzIiqisUbzDgPP+cI2uWHH89YvJnwP5g2Ss
	 +CXxni/TZ5QeRUauggpZGBZFLkCLUrWteQOzDjD/EBBFn+MYm05hPYnvITRJXTNbTto9r
	 y4qe0DSPK11V1+5cE2env1RVmYs8t7FHmnnjSXCf4KItv8qJECXKsQefCjAXuCCiEvhNx
	 VRJ/bbqpWgmogMW4zGaBTfd/9Z1xAcXr9mpfeRyttGUfLSjsoXiRy4nTBrtw4/RDRFVau
	 IYWfAdjuyAO2fdtMgo1R2C++QRhzyiNPJoWJmwCfwpkiI8b6L8lKU6PJWqTObbN2dpQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791036779;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wovrrC+UWjVdSdOd/b6TV6tlitXVB83AJINxp3UBJVE=;
	b=SJAlF5dU2dPLS4PNdeUavU32UDPJwKvdyMAGnESnGl9ugVncUzNGSIUaOwH3Xk4aXwkr
	 O4maqUHh74B/Ww+xSfBeuzCGk1pNUBkpaPa+IvDDTNViz4PZdpXQgGGKkBm0bsLq0smCt
	 rhkti1NQmDHMbiEupEBF3jY7MX9dyR7kSW2SbEWr99jgeDVWZVs74UKCQ6lQmCEINdfFC
	 vdikWLSnUBxD+N4i4g5ESxuLZAdGj35FjYlkjjxSCwsTJOvFB6rrruweiFrR1ZOGpRxp0
	 zLvSe8FeDi9fXiC7lx/JTyd4Bl6mSyumtFJxYMER0uuHS0WcLFARbuxeoUk/CQBCiQg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iPNdj4u5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791036779;
	bh=wovrrC+UWjVdSdOd/b6TV6tlitXVB83AJINxp3UBJVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jiwtcu6TvQlqVtu7fY2TyUU/iWEaNv1cmZiGTGwkAl0PI2sYxgABEB84N8bzIMCqX
	 W1c6hfhEn67ELd2Phc68CrbQiuOCcmP7pnxeIWCTCu+TICb0BnTg0HZh3nd+oVHq63
	 uSXdMNQIqOgLdttWcO5Vxb/dKTo3hwWVT2L8cszhAw2SflE1gUQjiqxQ5fJ1Ycar7X
	 KpTDXaITZBwNtm8tcIUtMjFsym2uFMBNGxMHNvbQvP2Ct/P7LqRnymDypHmHOyYXUC
	 DFCAjN/4eatV4CKqD8y8bjV7RyQ9iQXpO0eiVCfm7loKL7RrKpcEyve9dQ9cYbVOHk
	 IJ3MNrE+acw0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA86E60FD8;
	Sat,  3 Oct 2026 14:12:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A3581D2
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BD3660FD8
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yDQYcqM1Ehem for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 552EE60FD7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791036776;
 b=G3iWnvu9X8JHuZjDHKFGACLYkgk5+TnEPX2bp65eZcOAbtk13A/HGiaVaxS4wASnub//
 HbVwQZRcnEmLMGRUrsvAkQaMPXppzogAEqHm7T7534BX5AE9x+ys5NRxC4whl0WZVczrg
 87saRGssMDYJFPQ0sTcbrjR9zW2+Hyal+7HFJwkB5NlAD3qlt3BBPWwLZ4FU5fIZTeVZO
 Dgabsy+bXyxZk6jccl/9o2mpBQ4R268hV6bUE5st/0PLVyX9RGTVIkOq+c2M4ex+9UZzj
 3MYMG/u5vD00pZHODG6IXjDLBZpyyFxrKTtJ0fkCoGLx8pYomM6vTNP4JzA0oFs4X9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791036776;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=wovrrC+UWjVdSdOd/b6TV6tlitXVB83AJINxp3UBJVE=;
 b=BNgMUKdDHoTsjWu5J89pwpGQmW8qgAMEu97guvjFu9jdz3nf6/DxuExgcGrhqEmq0wIc
 4XlxegbfpLsmM0FExe8eg3nBNtw9NpYCFN9UE9mELI1INDSaddtdBbXnoVFu3s6i+dH/z
 RjQeckbL7jNtYElJprGGCEKGtKUwyiFR/B9rccGPVreP4DzcQs7TCXq0iBAm/O8s11rYp
 H6UolKR/eiaPg790S750ehH4xaEuVjHppeaEXVZl/pQNiDN01vg3ZPmTddtSCiI05JasR
 9umi2+cUJXl8QO20D/U38FqZCzqaJ0PuzuFzP2fu2RBrsWJLKwKrbQnjtqKi7w0FaHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iPNdj4u5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2b; helo=mail-ed2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iPNdj4u5
Received: from mail-ed2-x2b.google.com (mail-ed2-x2b.google.com
 [IPv6:2a00:1450:4864:33::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 552EE60FD7
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:12:54 +0000 (UTC)
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6af82ce3c83so650440a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 07:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791036773; cv=none;
 d=google.com; s=arc-20260327;
 b=k3s8aKkSxxjMPV5EZQAr+q0JZ+ysN6Q3trUCOoRdoqY+PiQMelKkdK4SHlTdpLqYja
 3kggccKMYLlMQeZlqEbdKveofseAlhPirZWAKfGUBpq2h4jb4Bxy+UH6TbZcrrylGhBv
 Yds+Z2m0/WtQwmzfXSVS+TxJwXh2YONJnYmrKg/T/86iFGmbbLdZbxM5wkgfMJRmzF0u
 XgvIAyFylRRMhE0VVNeXNMa043IEnFA7DWRW8qzOHG1eB4qPVw63V+JtmCzSOLyNtq34
 TdnHOS/CDFRuVOr+bur7koqh4CYNtXXtuTP1DSvq2BP3ynKc3MzAhMYv08PFO1KpPm/z
 W/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wovrrC+UWjVdSdOd/b6TV6tlitXVB83AJINxp3UBJVE=;
 fh=foHa1jey+Zd3ZUQULBmfvN+OWcMIoZUPgiQ+bZgnjD4=;
 b=IjKiEHpM2Yn3ETPMSuwBBnKboFTcXTdQpc1+9WydhKaqObGXpIDs6R2XZx3vy4Gr43
 OAQ8Ont39wIEI7h306m7DrmavwUwI1WEMoGI1SfPLIjbSjgl4py0N6VxlH3hwCyrXO41
 4qSc4qASNw5aIk9X68BGa8hEDR59jZSJeF7opwQXK2NNpF7pgpqDKPn364pq4TyKXnTY
 BnOw/aYFqve/WYKY8reVoavrrO3HcKJnRmAX54zlvoXT8zGoSo6OpLi8+VyjLEm27W4+
 nmp2sspWhfO0gIuNFvTDqDM+TyiYxfiEDx/e6a2fcEAkzNKsH/K7tBQHLQ5WLQyMy2sr
 bONw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791036773; x=1791641573;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wovrrC+UWjVdSdOd/b6TV6tlitXVB83AJINxp3UBJVE=;
 b=iPNdj4u5M6495BduaP8nL/5YH1CxENHPqEClq2hWYLtnxr6rK1BUSgHohF1yxQSsge
 peJ+22Mpkw7BJe2rT45Zc5cLWhjEf0yjTNfz1b7dVuTcAWoTU0RP5Ir17FmqIXpRuVlc
 KDB6E5a86YostyBmYzzBhV+vLmxT/ncKFP0E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791036773; x=1791641573;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wovrrC+UWjVdSdOd/b6TV6tlitXVB83AJINxp3UBJVE=;
 b=zs7IvZgGnCqjRhGxes6U1WPVnL1SgXsfM8+nUKDlykleH5c31kiPi07g8eh0PrwZWq
 krf6Mq/R27pq3kmRBy3brRuySXzC5g8x4fFDrJcusQMPXDTRh3DtWhW1+Cvke44C/SDn
 647dwSAWXmvzAQc4pOrohRIeNYzQIh8uHrdWaNgsBkW87gXMwQaQDYIoTcvFUybGF3r0
 Y1xHEODRoieUVoG7JIqhWbJWU789GitCr5aJSS1ySVAONR68w2gRMoy/2BKrpFh5NGUU
 WKmw6PmzcqMWazt0ZQRvGVUcpU41U2qGSnY2Y9/u0nCHLf7SRUid12R1GMkBTHrEwkzX
 HJ9g==
X-Gm-Message-State: AFq9FYK62Xla7QtBXdsaU2sLxdDnX+5gvjV9/m/GU6iOZLorPLSjzZC4
 AW7YcmL4VU1vc0uZm3KFjprXMvejSrlxsAspbTffxJFYl2Yxe64fmE1vJLNbKQygKt11657gOt2
 lwKHVE7YySsrsRGn3+vDwUnu3bJtc5SfCCwZuGxVQ
X-Gm-Gg: AYBFou0kvA2TK+Owwbmmp2yO7M2hHIP86X7qH3jQYUcnyIGgGN/haTd9aVpEoC/f+Qz
 7SGZhP9/7wdnP6CWl7ZQ58kPwCU/F/o+r4EQZTFoZfn6aEFt9sT+iNIbBbi/XPENItawNPp+Lre
 /H6+3YrIgl7JZum+q9eqXfx7a2pdj9h+kLK7HgqJv3rv1pYH5WNwOZI9r+DkjETFgEOfQJi8wMm
 W6e8bLgm981dqjZNhU7P3dWXIUbD9NKZeTufYUrTUU3zV27q0a9gjWuJYJ6Yy5/OykUq3t0Q0+f
 0lKmZp4TiG+oM60VgPuodGSxyNR744uWnP72q26V5uWRJtQgaRvzW0A=
X-Received: by 2002:a05:6402:5489:b0:6ae:1504:5ba with SMTP id
 4fb4d7f45d1cf-6af9e3494e8mr4008924a12.30.1791036772766; Sat, 03 Oct 2026
 07:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-qconfigdoc-v1-1-9dac84b3ef75@gmail.com>
In-Reply-To: <20261003-qconfigdoc-v1-1-9dac84b3ef75@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 15:12:39 +0100
X-Gm-Features: AclHuK-u4-_iDaB4ObMET8TKa36lT7iaF_e6xjwDACYs-7aL_5ep4LxNoDgtxWc
Message-ID: <CAFLszThXUz-ijZDgnP_fSKT_wfiifVi8Nw6Urp=6Ewq_OJdf5g@mail.gmail.com>
Subject: Re: [PATCH] qconfig: Improve the documentation
To: massimo.pegorer+oss@gmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Massimo,

On 2026-10-03T09:09:36, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
> qconfig: Improve the documentation
>
> Specify where the database is created and under what name. Add text
> value lookup examples, including quoting, escaping and regular
> expression cases. Trivial fixes.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>
> doc/develop/qconfig.rst | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)

> diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> @@ -26,9 +26,10 @@ How does it work?
> +in include/autoconf.mk.  The tool must be run at the top of source directory
> +where it stores the database file named qconfig.db.

Please can you reword this to '...at the top of the source directory,
where it stores the database in a file called qconfig.db'. The article
and comma are missing. Also, check_top_directory() runs for every
operation, not just -b, so this might fit better in its own short
paragraph than in the text about building the database.

> diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> @@ -95,10 +96,23 @@ boards with an empty string for `CONFIG_DEFAULT_FDT_FILE`::
> +Text values can be looked for too, including regular expressions, but taking
> +care of needed quoting and escaping. E.g.::
> +
> +    ./tools/qconfig.py -f TPL_LDSCRIPT='"arch/arm/cpu/u-boot-spl.lds"'
> +    0 matches

The examples are useful, but nothing tells the reader why the first
one finds nothing. Please can you explain the rules they depend on:

1. The value is a Python regular expression and must match the whole
value, since defconfig_matches() uses fullmatch().
2. String values are stored with their double quotes, so the quotes
must be part of the pattern.
3. The stored value is the one from the Kconfig file, before
expansion. Here that is arch/$(ARCH)/cpu/u-boot-spl.lds, which is why
the literal arch/arm gives 0 matches.
4. Single quotes are needed so the shell passes the double quotes and
backslashes through unchanged.

Also, the text above uses 'For example' rather than 'E.g.', so it
would be good to match that. I would also say 'searched for' rather
than 'looked for'.

Since you are doing trivial fixes anyway, the earlier SCSI example
shows names with the _defconfig suffix, but do_find_config() strips
it. You could fix that output in this patch too.

Regards,
Simon
