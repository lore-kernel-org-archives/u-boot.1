Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBA8CA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BAD080EB6;
	Mon, 28 Sep 2026 15:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SMMP4sMp4YaG; Mon, 28 Sep 2026 15:19:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C6DF780E25
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608760;
	b=TQ8idHrj5ULAEZMvEAxKuv1Bfux0PRTlRCX3OvF6QTumCZdHtUv8Pah+SYn0mri9TT2L
	 wcNFWRvLmjdasoHjXWuxmNhqJwpGH1UM0VehJRoGxn1YxTfs6CLWT7UjLPyd/QIQ8WNhB
	 kQnQVWrB/w9TuOwxI4xq0yMez6IWnon81eaq0kdJoJeS9vfuzlP1H505tcPRMFdEerUI+
	 qh5OaTNp7i/mqeVyRiDITBZSinG9jP/fslRiFZjypnpj2pkrOBvDisLett/6nG8Va8W0s
	 7IwxOhQABu0RlfBAJn86dRjK62+g60t5OjWgO5V30s+z7zaEKAHz4mEIfVrSsNN17JA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J6XODbai8MBq1DaaN5SqjUft9X85ekOjERlH99AmRDE=;
	b=mTRjtQluzJKBySVerBC4JFKJ8Xksh1Lb4mfgDwd2Gn+33csyimW6tu0Nt1VlM0zmWSuj
	 pn+7JIvhYS2A0lmKlP2dDLdHcTEum/YPXhlfFosMpbS84NDWgWucO2VRIV/xfBw23Hw5f
	 kxxNc44sCc7gT7XmL8pb0F4XCcKY8kiWPYWlFTn/naZvmaa9HnrbS0PZGHUaRZ1L6XRdq
	 8J9k98BtetYSJLADxe61ab3ir38pOC6L1YRIWmj8HoKlK7wTENjMuncMJOfNzs3kurgdX
	 BD2zPa8OkZugh5ti+608JE7s3eH+C2ps4vT8V34gvA+XlKDTJSbybP4cKooOHcKiL8w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608760;
	bh=J6XODbai8MBq1DaaN5SqjUft9X85ekOjERlH99AmRDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yt4NuZXcNQsWJ1KoZ2XKaHRmA3NzuxjtMR8K01RzqKQnXIZZxMhum6z0zyUU2qMr2
	 dySV+cAqR0ixmi1vtKuIlDPWXQ87FVUsJ6Oa8SoFP73HKM0bWTPcDbVHNOC3Fk905I
	 OkPaKUOW/szy1W6uAysbT6Y8P1JI3Qx2n8doJYReLZHDLROhh1A+izFDu7hnBPxW+T
	 k3VtBW4H4G5O00rzuEQffq1qVz4SZpOE+sJzzctGo2zdycd/2MdAfu73sfjQv/UCm9
	 slqTijPhA0g5NqPEv298zS6czgaYu/4KObwTlolabmFOyUqQKdkChiw5HRC7anJvrZ
	 UGyYFDXpagIOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6DF780E25;
	Mon, 28 Sep 2026 15:19:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80B5D3A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:19:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E44F400D5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:19:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GbCOSA9K_D0C for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:19:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 756E3400CD
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608757;
 b=aG38I0V6Zx5CAwCoWCKsy53ZYhukwg9mkvHwFScj+KXcs/KleD92zTe4ZR7VGrOoLyah
 a7y4mDg/WNnaU53odjcirG23AGG06FjOr6WYYidXx0HMjdGHmQmAHXnnEdNSsYbxFgzQD
 cI4PN+iFG7bH8yJZ1Y1W20W4r8iZZhTXHH6/QUZcw3k5kJQMfIkttZ45b/qTN6dEIzVZA
 gyQMd4OTXB8qg+OpxvPd15ntVaf7pUd6s8H6qiL3EQ14qDyutKcIxagE+kKEfRC8/lTgc
 ex5djads7JOyjS4CwrZ9eyyDz1KuSGO+iq1D1h2Uh104LueWVJhmX8mBNR6/zV/snRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608757;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=J6XODbai8MBq1DaaN5SqjUft9X85ekOjERlH99AmRDE=;
 b=ehSqGkETYWGeYPwCZECgpK7s5tGy0m/pmbxYmTWhNRnpQ/E8znn8cBfCkNfCbpzdx3i1
 lwJcyER3xOKvQsZBMVizDpCRrAY41Iw4zTEKzNa6QI0P6LMultBOQzVr7+RliD3gNHRVq
 VNH4K9HnfFVvveSw+zo72SaPTZon8lOTTnLRKZviNOU3ZMnk24U7KaiGv6svYAgdOwVC3
 OHDvAf3bkFuJFMpc3ohmLsKulHpkgShgKN+Mh8u7WOoTlDLIHCB4/A8e4/py5Jc/OS6gh
 AYtYu0BucwS8n4VYAJLzxPfIImia7/x6lrTT4Nw1EAZxdBUtwglNC/cIuxABeIZZ10Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="a/ChOTz+"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=a/ChOTz+
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 756E3400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:19:16 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ab0c3c3af6so2812992a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608755; cv=none;
 d=google.com; s=arc-20260327;
 b=Eo7OXNF5rowz3kUaVMNQP5R1/z7u+hw0ibvQMZS3cpYKpuhZG2FEcSZTxX74rsOI17
 u+M6N47BnvZRVVAvkXguJWKJNko4pe8gnlNj8cIda+pMtn9B3ynmQcfy58I2bmNbqWcX
 Jbjhdtj85XuNBrZ3FevtAf3uR7M8oU3T02X7qIuHQdlsuOFot0TPwghLQd7yFif+gTfB
 PMkT7qiB6qneAnHMBAGvkexRCo5e3Tn2gy5VNOQsEwKO7KL7uafookYE21jtRDIDTgzn
 Yw2ZaS1LJeXRufIrEsIl4N25zaPze2dNNA3hyaRbxJ0Jn4Q81jK/NI9zqPRAvTcymPsY
 uIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J6XODbai8MBq1DaaN5SqjUft9X85ekOjERlH99AmRDE=;
 fh=8DuR7XNy5AEjb4gBS1/LVK9PjPsoKjz3k9sgz9THXC0=;
 b=U1ErWAgJN+8V3uqetdCMET/BaPuOKI/8UTxv5xPKnoQqWjnNZCofYvov4JshQaWXW1
 +0+h2Ym4KatLGhEWoGYM6ArSJExe7KDgp8Hk6sXg6uGb+oBUQtm8vJrhLwi0cF/MN0YK
 UbB2zBUR0mqO5HiBNl4Yz4xcVLRDXD2rD5FbkxS2m+igIu/kQvFvOXmJcZeZDxNUm6qC
 /jUAnfT8vtz3s52uHjF4MU/3jmRb1PWCKTT9tfGt/wPml3P9TbeEAkaeArjr8DiFU64m
 PtxyBmLOUlGcrvsVXucDtXwwRVE6oEkA33tnFGuFgJFkE4R2bS6QS+XU7seoMA42Pymp
 SSdQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608755; x=1791213555;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J6XODbai8MBq1DaaN5SqjUft9X85ekOjERlH99AmRDE=;
 b=a/ChOTz+6m3hqIOe1AAccUJ94HSA7qVsOLZkx2lmV6Ao/p1tMKDEjWCiRT36zWeQJB
 klagoqlFnPw6BjG/rFyeCt9yyTOn3WSqGVzqFXzyC1y3DVw8JZhtnMgvkuhRGobkZCVa
 qDuTkTCMR36WAdGHyqJONsp6IcQ6+XTtuo7Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608755; x=1791213555;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J6XODbai8MBq1DaaN5SqjUft9X85ekOjERlH99AmRDE=;
 b=qBuLzQTz/b1gqqZpoE25OJOMlDD0TzP0vpkq4GTtmtChdSvi2cWZYeMFUkxVbEVblO
 xjvtiah7bA6Fte+eKYuPZ6HFek+dHIOb0ZdbedwyUVfcyPmeL3KxCTYsC9lQ+Q+Hgawk
 QCDbbrR8rQgmOs9V/42MFZqsKma+7NjJBfuiJJQ79AAboYQudVQ2XCkZmZh/HCalobh9
 jsB/nJJQiJ8J/TgxEvi23julv1/G1wRl3Leyc16WdZKmrk3+0jlSeOQQ1/4zXHXFU9tl
 TnYmqUplZuWjl58cAxJ5kt5CWHRD2cYU1kaURE7zrCF9KWaX5Mn+WZlRbzEmXmeTpcjz
 QfLw==
X-Gm-Message-State: AFq9FYIRuCkPIeCzYpy0tiPQHK52nPckr7/+NZQvFuxmp4QR3TGj/OHf
 0tw2w6xh9yXzAyBFxEYcHFZEiGukKDIs6bIKuvBx0ADg1yi8EFWdjnkUrJAbIAF1zJKbbbStfZD
 8KL+qDpFs2BqnwfEq/DW9BCgKk72Wt+5mr1gpBSQg
X-Gm-Gg: AYBFou0qcbL/RRYlFs9X9beFrxPI9RMC3pivx4qYzr3DRJuouGskbOq1HSP2AzGWXFB
 BNBxYhfpjyYiscEpkU/GWuTQgpLvfrJLyftJNoR9Knd9BBLbEnzHgaJKgqfnOtxNUMHCWwlX3ne
 lp6pHRATQxpHUjNO0hishY9PWp9HpuoaA4LKs9kv557oDAUJcYQfdH4ngUJCHqElff9FSJneST6
 WsMllKYUjzqKOe2cUwSWW6c3y6+JQfMHZqxiutwx+XbRzA9vdoTcWB1Q8i66XG9o+eEsPsUUygh
 yY3QufpWsx0JmBoyCjZmGxBVCLRgAtHdhGYf52UXAWdUCcCLRmXpUQ==
X-Received: by 2002:a05:6402:3251:b0:6aa:a3bd:c6a1 with SMTP id
 4fb4d7f45d1cf-6aae8f66ad6mr5615908a12.40.1790608755027; Mon, 28 Sep 2026
 08:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
 <20260922123630.608961-7-aristo.chen@canonical.com>
In-Reply-To: <20260922123630.608961-7-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:19:02 -0600
X-Gm-Features: AclHuK-sDU2VwkJSOK1mooLbKx3-MIE6062xc9Fs0BUMyqJud9kvPke1EgOcbXU
Message-ID: <CAFLszTjbAhRE7pex8RQ7_pKnvZ83xi71bs-spR9fXBPAN1dJTg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] doc: fit: document shared image data through the
 image-data property
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Anton Ivanov <anton@binarly.io>
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

Hi Aristo,

On 2026-09-22T12:36:21, Aristo Chen <aristo.chen@canonical.com> wrote:
> doc: fit: document shared image data through the image-data property
>
> Someone trying to shrink a multi-board FIT has no way to discover the
> image-data property from the U-Boot documentation, since the format
> reference lives in the external specification. Add a worked example in
> the style of the other FIT example pages: a kernel offered at two load
> addresses by two configurations while the payload is stored once,
> together with the rules the producer enforces, the resolved form,
> the interaction with hashing, signing and encryption, and a pointer to
> the specification.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> doc/usage/fit/index.rst                  |   1 +
>  doc/usage/fit/multi-with-shared-data.rst | 114 +++++++++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)

> +            kernel-1 {
> +                description = "Linux kernel";
> +                data = /incbin/("./Image");

...
> +            kernel-board-b {
> +                description = "Linux kernel at the board B address";
> +                image-data = "kernel-1";

Naming is asymmetric: the target is kernel-1 but the sharer is
kernel-board-b. Renaming the target to kernel-board-a would make the
pairing with conf-board-a / conf-board-b obvious, and match the
fdt-board-a / fdt-board-b naming just below. Minor, feel free to
ignore.

> +mkimage resolves the reference while building the FIT. With embedded
> +data the payload is copied into both nodes, so sharing pays off
> +together with external data (-E or -p), where both nodes point at a
> +single copy of the payload through identical data-offset or
> +data-position and data-size values. The 'image-data' property is
> +retained in the resolved FIT as a record of the relationship, and
> +re-processing such a FIT with 'mkimage -F' keeps it intact. Each node

The 'pays off together with external data' phrasing is hard to parse.
Perhaps: "With embedded data the payload is copied into both nodes in
the resolved FIT, so the size saving only appears with external data
(-E or -p), where both nodes point at a single copy through identical
data-offset (or data-position) and data-size values." What do you
think?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
