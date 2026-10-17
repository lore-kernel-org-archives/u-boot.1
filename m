Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C51DCCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 10:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BA8F812E4;
	Sat, 17 Oct 2026 10:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5sZcy4rJDlU; Sat, 17 Oct 2026 10:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35C848130A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233814;
	b=qNGys2Az1eI78yuqs+Q1cn3YCQv3mERwPzvQrgPWByFkZEVNDTPEZz+Uyqihkl4UNCAV
	 ND6uJXoz0B8tR7VaZFx0hiLdyFtKZgLCsNG9zGlwGFeBq0lAayIK/0uZtkPW/SRDGJFHK
	 2HN1vvhGdHMzK8SfFQwxlHfhDG6wxeFy7tY2SmWlBr0fBblJnOGA8vLcPfdfNNZk7Bn7z
	 KhdGBZGd7H4zRy9/GmSjTbPOy8dmxBHduDWGaOVqWczxfJbxRwdH9ehfPR+4drKGE+UyI
	 9lBHte7tq+f6mLuO4qUzJKSu+OhdUchXhB9ASPVSchb88M55PFb8jq6VwzEpHRLVJkQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792233814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RAI93SsoS4DBrL79QfY2d5xSCbOwSNBiWXOL252pOyA=;
	b=C9TxVxK5eR6bEsWXU/HLI2DD6VMzQRgj5dEwOMHoucj4qZsE9waNYgxsc+cAzLHilj9E
	 VfnWYTP5AAiyX76DKDrkcn9dA6wA3B9X5ws5F/vcH2f5RMWSe+DnC3uCXNeG01WXxhZBb
	 csw3/8dvrr2FZfjRXu6WdAeCkpQ9NNXCexAf/beKyVbm5xpSoGEDKQtL4BqK8uabRBfNt
	 KEhyzITL6eu5F/QbFJzVNWO9mZ8Ioo+EnH6K9PpXJco6ToxX6yF9438f96XGw5SNKRx24
	 /oDCKOACT3NlCkwys0xStAHwyd7BEqvmXrgjtP6xgND3QBH21NfwotCw9x1fmi397IQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KYXIR5om;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792233814;
	bh=RAI93SsoS4DBrL79QfY2d5xSCbOwSNBiWXOL252pOyA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txFVaEZorHNCLOUPHFEWFg2IGpyNuNEofbmLjVKhWLeC/eaFIinJyuB+5X4N1H/Hl
	 eROacVxc0oT+jh/8Lae2G9myJW+E4H7ixxVZZzGMT4Gj+1u0A1AtmWZn5IsH10eQHp
	 kSGolWq8JDqr3D1QyyUdLegV51Gq0PP1xbhaCX+YHhXlPlvPsioPUVp2cbH9EO9IYb
	 PpPCTwVghoaKONoVJ0EzikTDFQ+sFjPtEQySpPXQG/NulI4k6dJxUvbyJqxG3HOoCQ
	 FsoFm8DoPlf7kK53+d0dJfgmF+97hl2VNhx+21HHmxCjykHqmFcBIfrewuj5LLdvwc
	 MjnmsxNYwx20w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35C848130A;
	Sat, 17 Oct 2026 10:43:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 50F237AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 428768130A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lz-4SIjOf57c for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 10:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 72355812E4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233811;
 b=jiOtCFSfnkIgWhkFC2cEK+wI5RaUfMBBUOYSKC/kjb1q+Wu7JvQavmbQBqbv1+ii4skq
 1vL3zDKc9XQfJ8IlE3F1vQWBl68YuP+76JR3wpwByUzNL7QDU014ZJfAMGnEf71W/y7gZ
 Tf803pDmgpyaG7xn540A3/m30SdyTALIQRCkSJc+xUDG6HyLwiUTO5rfv9YDv15VetB3q
 XmVz4bNArmLSnePmWK2cO6hAzw9gr+NPsS4t2mFHu+vmxsfNonegO+toW4FuweS7FFqZ3
 u30h9MVPWuR7YXUfJPQkvceSiweLn62e/d7imdFRI10TZyqDcvO0pivTr16X/ktci7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792233811;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=RAI93SsoS4DBrL79QfY2d5xSCbOwSNBiWXOL252pOyA=;
 b=BnX0TD1p5KOGYzJWtIW9A9XVasRdbxqr3kOhxQP77Sc3ReSGrqvfN7PnBEIzJt0+ka5T
 /kgAQD0UjEluOzBbUHer95hsTC+x5Hrco9sQwO2N4pHvEa26OCsGzq1Jw4bvQWBa+IWgt
 Apvt9CWwssFq7NYajh5JClF4M4En790feAZLvRDF+vB/YE58rLcFyGg3CkD0UpvY0BCTj
 3Z1t71PTdG3vSe0rdy8dEAVSpbI4TU66+errdH6fg6yVkUvqn/pxZsXSiRDlH7LCsPiqH
 TltpK8euqkR0agsIYF83MXAWNPFxCOR5cBoGMKCEDACe2nB8OJzNkJI6cbmGXk9MDWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KYXIR5om; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KYXIR5om
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72355812E4
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:31 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so307797a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 03:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233810; cv=none;
 d=google.com; s=arc-20260327;
 b=J9logARvLStMcPYRYzG0lbwH4WMj/mD5v3ZCQufKGIYpdrYjUyE2M5sTEU3zvH+RJm
 ZhWTwQXGjgYFGUsZVi6L1QOkfbr0+i/grBm/mo7y3p0Zh8A8P/PwG9bc7IHGwtuxH88w
 QjWfY8rFt9VoOcTLXIrj6xTQbOp38aGZv9cx+ZcM3N8GPVX7vvlzK4OUSxGPPwrXJPGI
 JXJokVoNS3o3rqzBOgZVyuIZkL3Z48qkPz+swFsP98bapgSbiA5HeAzoF2otVbKl022n
 2JWki3uknI93ZZ4bvg477HGQUKc4YkOr/ukbIpTR2oqSaIE5wbXz3aMoQLg88xnct3C5
 OnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=RAI93SsoS4DBrL79QfY2d5xSCbOwSNBiWXOL252pOyA=;
 fh=/daYdP5YVsY9332CsPiNh31d45lGzQfyqR/6Fal4abU=;
 b=OyTk+kaeGV+PNmcexRYqaSanuLqCu8LcWbovGhEcQqJrEx2Pa4r2aL+oKSMmPDFPhP
 L+Nop0R9+WfH0tWUe4E+ybbKvsPW/3McdTkg5JQOGemwEJmoTzqXiepXC2AdoA1AYMKu
 PYyYdUVJnbROHAe8xPS3PbflrsX+75mVRFYIrPpQ75Q4Ow6SUPzyQ9rL4yOFacbhy/Ls
 iM3LEemKGY9ri1VWRh3msVX601gjQNqoLq7FIgC8TpVGQ47lTPS004a6tCAFHc0jleu3
 5dU5z6syystk5bI0JK36H7i7aSqJQ9G3Febc989je/7rXR/gHHFDaicQmCc5exUWFsJO
 T3Hw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792233810; x=1792838610;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RAI93SsoS4DBrL79QfY2d5xSCbOwSNBiWXOL252pOyA=;
 b=KYXIR5omGqUXDbIMnLRJb/+YK3hJc3jdCTwbvmPP7yKOPpD8pqJXcenWqTP+K7zB5w
 Xc0Ycy936lAUDhPqrKq3RQlT7ovCZV9crTWLlhPao1VFL+QLkaUHxip/sCn1FRFaEzBo
 cXVXAUzB+7L4gBYkcjPE5n2QGRufvhbKA8O9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233810; x=1792838610;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RAI93SsoS4DBrL79QfY2d5xSCbOwSNBiWXOL252pOyA=;
 b=TjzU3zivANJt5Sdv6l9vrblVmv4HpJOsqHcLaDjWLDWHwS2bf24K0xWIivmZ0z0TjJ
 kxpy+utCa1C3DlkZFpqrgnjnoTQoZxoKV6xsgAAWid1RCiCZ8yCIEBGajpNsowzlnine
 b4bRnWqqKREIsWxEwtgDaiw5SrJ5ZM+dchvP574lSRkzyC9DcakfpEZjtpH7EK1yjHG1
 E1RlWeGfU3pXf7aF/bvy2srRV62IARB3qXWHhqlFFp1LifSKivYIqfNnzJw8v9Ee8lCL
 1/m/r1TePhjTcxI0KGsZ/ZxPGb+QSwb/rWYBWsAPaCm3/l56mMKYX0rLuDzS/U7q/thi
 ibEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWC5lPQLGwYsuZnCgzDXL8j0NjH1w3EGE9qLeO6OWCUetCHlZPkzuCPfiWihweN6vspCzTI3A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJlcJMTYRGebHLdJdJ7osVVDQlMnCkIeOvIual5EgjMQnmFFvO6
 ceQcq+q1wOWHvHnx3zfOFYZg/4ng3+JlNTsGG/7tZPpS76aetsiOfknSvWs5vtQ7aRzAZilBoQX
 766q7A+528Xbs3nA47a8Qsr66nzGGMlFLZ6B+X8Zy
X-Gm-Gg: AYBFou2ySv1c1g344x33JPZxNOXQhbN9z0WDv/R8EXpyg3+nGvNKHf56QTzquMHp6IB
 GSLrK4xibJoXsjgRXnPniosXMNQDnPs0R9Ory4DxR0YOYEN3alQ63h6IfYW+h39j4qIcurglnKz
 QVh1AmFArd0gvaeU8DBp4pFDUUGHTjisBhj5XDq+fl/dAsmq6AVNe6/HF8E2jNSnv+jw9DrB4MF
 lNKp/SoRf2UXG4xBZ7C4gBAmSw8NR9c9B08dsW6EijYXs0Mt1cWxLjpHhY9xTGiOyPCDklWTsLh
 MZG2MxWq2GsZf2aWhkMiH+HouSZYtrMCzfN5L1vy+tCCvVNRkW5kwJRpdgeLwHT/
X-Received: by 2002:a05:6a21:1493:b0:3e2:1a24:fb85 with SMTP id
 adf61e73a8af0-3e225d77b08mr1398625637.1.1792233810441; Sat, 17 Oct 2026
 03:43:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 03:43:25 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 06:23:27 +0200
MIME-Version: 1.0
In-Reply-To: <20261012104805.17297-4-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
 <20261012104805.17297-4-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Oct 2026 03:43:25 -0700
X-Gm-Features: AclHuK_JI6U1uC0ITqqmOBxMpvZJHlkAcX1LWpRnaYAYLHl2rJyyTwKVju6NSq0
Message-ID: <CAFLszTiQLVf55_3jdOJhWgyKeSgbS+YUgU2CyY-1R+9xwzhTbQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] binman: Add HSM signing support to pre-load entry type
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, u-boot@lists.u-boot-project.org
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

Hi Yan,

On 2026-10-12T10:47:59, Yan WANG <yan.wang@softathome.com> wrote:
> binman: Add HSM signing support to pre-load entry type
>
> Extend the pre-load entry type to support signing via hardware
> security modules (HSM) using PKCS#11. The implementation integrates
> with the pkcs11_tool btool to perform signing operations.

This patch does much more than the commit message says. It:

- moves the signing code into a new _SignData() helper
- changes / to // in RSAS
- rewrites the error messages
- converts strings to f-strings
- reformats the struct.pack() call
- drops the image2 wrapper from the docstring example

Please can you put the refactoring (extracting _SignData() with no
functional change) in its own patch ahead of this one, so this patch
only adds the HSM path? Please also list the new properties in the
commit message and say why someone would want this, e.g. so that
production keys never have to sit on the build machine.

>
> Signed-off-by: Yan WANG <yan.wang@softathome.com>
>
> tools/binman/etype/pre_load.py | 285 +++++++++++++++++++++++++++++++----------
>  1 file changed, 214 insertions(+), 71 deletions(-)

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -46,29 +47,57 @@ class Entry_pre_load(Entry_collection):
> +    HSM Signing Properties (optional):
> +        - hsm-support: Enable HSM signing (boolean)
> +        - hsm-library: Path to PKCS#11 library (.so file)
> +        - hsm-token-label: HSM token label
> +        - hsm-token-serial: HSM token serial number (alternative to token-label)
> +        - hsm-key-label: HSM private key label
> +        - hsm-key-id: HSM private key ID (alternative to key-label)
> +        - hsm-pin: HSM user PIN

The code also reads hsm-slot-index, but it isn't documented here.
Please add it, and say which of label/serial/slot takes priority when
more than one is given.

Is hsm-support needed at all? The HSM path could be selected whenever
hsm-library is present. That would also remove the 'hsm-library is
required' error case.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -79,6 +108,19 @@ class Entry_pre_load(Entry_collection):
> +        self.hsm_slot_index = fdt_util.GetString(self._node, 'hsm-slot-index')

A slot index is naturally an integer. With 'hsm-slot-index = <0>;',
GetString() returns something strange rather than giving a clear
error. I suggest using GetInt() and converting with str() when
building the pkcs11-tool arguments.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -79,6 +108,19 @@ class Entry_pre_load(Entry_collection):
> +        self.hsm_pin = fdt_util.GetString(self._node, 'hsm-pin')

My main concern with the design is the PIN in the devicetree. The
binman description normally lives in the U-Boot source tree (the
-u-boot.dtsi files), so this pushes people towards committing a token
PIN to git. The PIN also ends up in the binman output DTB and the
fdtmap (if present). FIT signing with PKCS#11 already avoids this:
mkimage reads the PIN from the MKIMAGE_SIGN_PIN environment variable,
as used by testFitSignPKCS11Simple and friends in ftest.py. Please can
you take the PIN from an entry argument (e.g. -a pre-load-hsm-pin=...)
or the environment, like pre-load-key-path? Ideally the PIN should not
be accepted as a DT property at all.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -86,68 +128,169 @@ class Entry_pre_load(Entry_collection):
> +        if self.hsm_support:
> +            # HSM-based signing via pkcs11-tool btool
> +            if not self.pkcs11_tool.is_present():
> +                self.Raise("pkcs11-tool btool not available for HSM signing")

Other etypes (mkimage, x509_cert, fit, etc.) call
self.record_missing_bintool() here. That way --allow-missing /
--fake-ext-blobs keeps working and binman reports the missing tool in
the usual way. Please follow that pattern: record the tool as missing
and write a dummy header rather than raising.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -86,68 +128,169 @@ class Entry_pre_load(Entry_collection):
> +            # Use slot index if provided (simpler than serial lookup)
> +            try:
> +                signature = self.pkcs11_tool.sign(

The comment doesn't match the code. The code passes all the
identifiers through and leaves the choice to sign().

More importantly, the HSM path skips the hash_name/sign_name checks
against SHAS and RSAS, and doesn't check the size of the returned
signature. U-Boot's image_pre_load_sig_check_header_sig() and
image_pre_load_sig_check_img_sig_sha256() read info->sig_size bytes,
which come from the verifying key, not the length binman used. So if
algo-name says rsa2048 but the HSM key is 4096 bits, binman happily
produces a header that can never verify. Equally, 'sha256,ec256' gets
through to _build_mechanism() and produces an ECDSA signature, which
this entry doesn't otherwise support. Please do the SHAS/RSAS checks
for both paths, before the if, and check that len(signature) ==
RSAS[sign_name] after signing.

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -86,68 +128,169 @@ class Entry_pre_load(Entry_collection):
> +        # Sign the image data
> +        img_sig = self._SignData(self.image)
> +
> +        # Compute hash of image signature (always SHA256 for header)
> +        hash_sig = SHA256.new(img_sig)

On the HSM path, each _SignData() call runs pkcs11-tool three times
(--list-slots, --list-mechanisms, --sign), and we sign twice per
header. Binman can also call _CreateHeader() several times as entries
settle (ObtainContents() and ProcessContents()). That adds up to quite
a few logins to a real HSM, which may be slow or rate-limited. Not a
blocker, but it might be worth resolving the slot and checking the
mechanism once, then caching the result. What do you think?

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -86,68 +128,169 @@ class Entry_pre_load(Entry_collection):
> +        # Pack first header (64 bytes, big-endian)
> +        first_header = struct.pack(
> +            '>4sIIIIIII32s',
> +            PRE_LOAD_MAGIC,      # 4 bytes: magic number 'UBSH'
> +            version,             # 4 bytes: header version
> +            header_size,         # 4 bytes: total header size
> +            image_size,          # 4 bytes: image size
> +            ofs_img_sig,         # 4 bytes: offset to image signature
> +            flags,               # 4 bytes: flags (reserved)
> +            reserved0,           # 4 bytes: reserved
> +            reserved1,           # 4 bytes: reserved
> +            hash_sig.digest()    # 32 bytes: SHA256 hash of image signature
> +        )

This only reformats the existing code. Please drop it, or move it into
the refactoring patch.

Regards,
Simon
