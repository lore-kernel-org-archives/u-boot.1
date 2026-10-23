Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE184606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YJm5Jc0w;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BVFik+0N
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67E6581496;
	Fri, 23 Oct 2026 13:07:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ki2KxvOtM-Al; Fri, 23 Oct 2026 13:07:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AEE9E8146C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792760831;
	b=DyIW5qGgycpmoYyJa/I6Nw+761cbgGLu/JjM0bNYGAHpyZ8bwOEKTGSa590i6jxdCtac
	 Q/5BxIv8lrqNDEz/mBpjVJx7vjD4tybxN+LCgVfAhQMtfJEQcEQpsYGeS4GQGIMGbJbAY
	 YTp/nx0TtwUZzhAYcCoU0xePrdHZ1ilkWGpEzodk6AK2m5WMexmgdm3sJdJOWD1pzUtw4
	 nrio19O2Jj8N9H7760vh7DHSP/m5PxcoxeuVpG9+EI/Ie5bqkkv0AfvPJuZVm579Ad0O2
	 +HLL5MbfPgpILZ6+KueiBcdGK0fDJod7WOIwxH8wFZ/euI3oo5UASoh0U1ZEGI7APfA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792760831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f8+keWiQ3OKsXmFMSTqfxfODGWgyK+dtloxP5wug52M=;
	b=shkV5DejxQuj8BzOWRnoJdlerqvv7yxvoL8oWsclzXUfPrO5UBwTWueC6nzbU7N7a9zx
	 8NTDp+eU9Ge0qQSoBguSt4Qub9eHR1NWqe9zEk/L7ARMIXarvYyY8e6Jp6+rB29rSeIse
	 rxu/oq6NJt+5tmlZ20et+uo80BqZN145kKaD1MZ2j7Fpi2Rh3SDd1ydVZGhRf+c+D43Tc
	 +aqwy7gliyemOc1J9JTXYHKEykaIYzmmw9+nZJWGwZ9s3RCxquBRz0YzvHpzQ5WikSbvC
	 rX8ZfamE3DXuE2X+3dRnEzg7AFed/Xi2Vb6m3i0owQMTYfXoZ1ZV0RlNSVB+1amLHvQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792760831;
	bh=f8+keWiQ3OKsXmFMSTqfxfODGWgyK+dtloxP5wug52M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YJm5Jc0wTRrxXrgKaHSocTrdHmv2Z3PePdoXAkKOyKjjRmN1VDEIxj9lRONAUSQ+0
	 ZXN8NHXu/nJ2UlQmQxscwFRs3OqIAnQQIqv6LjaMCytw2E8z5/vfEj16dWaAwQqO0o
	 A0KHqWvA9ep0O6zB6SXZLgeHt3pOJ/hsLxJKc8iX8zmUHUeSTdm7Sz2wsXHynkKeEW
	 dYvcbqqxVAOWQVR0Ycw/hYgnJI/ObTtkVpqxsfw7rUgawrbo4gpkUzxU7zqIO4+n+1
	 ZyVn29Dar7qIJBQ6FfPf1FnVq3Uo9vEoMSf5HxcS0FBjBO1ASDwKh0+TPhsVC+Xp2d
	 IoPQ0uyiV2T+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEE9E8146C;
	Fri, 23 Oct 2026 13:07:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F1363C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 206B0606BF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iaDusTU5s-TF for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D7BC6069D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792760829;
 b=rpK9YvBZnVeSwMftuy54m77X/l3mBMg0bWInMWgiIqyXgd8diNvEl1+d/pHIWDs9hnlf
 FoBK/TgphONkwBN8u3HZ72pAUItzTxOruastt33TPS6auK9I6e8pKnGpGELnJ3M3Rtpj3
 2Dj75kVDsAFc0nbhVR2UxUv817/+ftzEk+w2rivkzpZaClF1+Rch1s6wl6riyXu5MqUMd
 dYF+6G+cI7pMCZqW1cpwtw0aHXsh2XksObuZ4iZhWNOyX/AZNi9vtXXeM11yqqR6t3Vr7
 GmsPzCw9UA/XuWADeJGDQEhFKs6mx+va4jZo4IDEgyWNAj7fpMfV+EzCJoNqYZbeR4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792760829;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=f8+keWiQ3OKsXmFMSTqfxfODGWgyK+dtloxP5wug52M=;
 b=TVnyzfbonj3CO0qiFfUoSWMfmYraUmigCBelPN/4YY1km+Jaosl76slYH60GvfvdP2FR
 1nBLpNtRNOsJGTe0zTWh6mKjLIgI6c4dhY+hFNGyqUk81SVDyywD9rbVgxgyspsNiNCNP
 BFj8ulwB5+yftYOKtEFjn5HUF650HlaTCanaNX/zUzAUk3f1/jeobFAyv7szQ9CzRDdFQ
 shf8+kR4M+qBJfc6b291RDMtgZthQOpduTHxmw53R1aXptq+RjGn4okq45H28nYY5NK6z
 yfreNeh8ptguGFoTvfz0fcs3v4JN1HpP5bnZlMlpqRKJyM+djGdZ4g0zQdjgbNmQrJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BVFik+0N; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BVFik+0N
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D7BC6069D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:07:08 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so1593451a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792760827; cv=none;
 d=google.com; s=arc-20260327;
 b=Mv2wUQHpooX0PnJChOrtpaJ0MP78F9LjuQ4KfAnF+eHjWuSbWKXfRZXJZ9P6Gl0NQb
 FMX8NHf2fkclttV7FD38CwQLgqqLTphF1XrEf/VMstxbyrslAnYYd0ESUjzw14cZRf2X
 0kUwKzMkGYMA0s13b7kWyXoR80hUtnBHmw8JjyNXX1H3U5FK0zr6Ljbq6khkNaOhydjQ
 4dykgiWwrNMOGaXZO8OJ7HyOIlejztHLWYr/GF1E/CiD813ksIxOSvF8eOOi/vjVGq4v
 e0jKA6FMUqONCC8W97bHjVegh4furxaPQAZ9WFHgXOg5jq1GKzoAD/mvfVceh9yMpkdy
 hqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=f8+keWiQ3OKsXmFMSTqfxfODGWgyK+dtloxP5wug52M=;
 fh=i2tQHTfbjxCsmvhnoxB9qnRhfzM8iCx7s7bfzE6Yn9Q=;
 b=aaUcsb3wWoZ7aeKmkEfvE30ZdIL7fMGqCWTwDURQ1nGTD00xRx005CeX61AwSfOiRM
 mYIaNpvPF5CpLGD3ROc5ciY5dARJSEfDIq+8vVOIkIpYs4vhtY3x/mQajeIyojRHfgF5
 wDQAdn9r7owDfKklERxR28wzhlhuj95uaCvzmZWQ4UDzlCN24CvP3xFG6jh+d/7N0n0L
 hb6k0ZEbW6Ia8cInAQW6eimjjnAPomx8irfpMVZvnmsEVDSbHMhT64a31k9CjJS/6Rnl
 VjyALgMFRRwAEWgD6Grfe5dSKtQZmSEsRj1mA2NLRJzFV/YFZiKb5fhJ2gWNj3zppTa2
 iRXg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792760827; x=1793365627;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f8+keWiQ3OKsXmFMSTqfxfODGWgyK+dtloxP5wug52M=;
 b=BVFik+0N0Unb5qt1Ny25JpCfiYDgrHHDu6BST6R7sidhtBVzhuSlwlZoGo0nZQG669
 fWX7MOWxl8w6DXlQ+9OhjJegMcHBYbDUceLvOq7JG1Zvm5kEibSvHxOg6FVzxpSTVaPL
 EY8G3pqgJkMYjuvY6qrwQ5gaNCzpp27tmUDIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792760827; x=1793365627;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f8+keWiQ3OKsXmFMSTqfxfODGWgyK+dtloxP5wug52M=;
 b=Yc/yUwnBY1oSjEe1mNrygyMOQFOKTM0g/7W24tIaySyKtbus87Y8nkcLGikPeV+itn
 WW0pQUn2UmWTCeCy0GWXXgrnDUOmm8CDFJBcCG/LsQ7pKzut1etmyvbE/TrsYzEpfpsa
 crhbKja+fDQRMpqxNOFgGXTysDWHzWN1XBdlfmqHj7Ad9lJWv0K9N06tvuK/3Hou1evz
 AYRyk+gi20cHbvLF6LdDlqEnQfqa6up3KF7qnK211FtR4qtJl4ne9JDmtbSwY/Okz8+0
 dJohpAy7Xpkti0cxfShhH8KlS6WcxZKJ1+mQLW7mwJZ9QzAX84YfXTwsA10kYfgA9ETb
 X2gg==
X-Gm-Message-State: AFq9FYJZIUYalPZlOfkndNE5U1DN6w14L4dU4Q9Xk+TvxOY7mIZ6s6hU
 9ztHSka39VqIgZYuXID6G5x4trT9BN1r30O8NnyXkLYcKomEwADglwg9T4pOOP085GaWmAl00aT
 9PMr4qJA1WpQ/1BxZziPCWd6uVPyxiW/A3Dxm9UAP
X-Gm-Gg: AYBFou0UFtxMtpS8I6xRZ7S55vd89YMhQRMbrljdWmORNCCreoMum4y533GK6O2ONqu
 VzcMRoj0EoDKjIDz0AZ1JngLQx6tVYVk2zU8gAq2czxwwP+bl1GQYF6uN9dKwiHqDGJTCNXujiR
 TaWhBBwuth/o/TdQlrfK6dhWCf2RgVjFUXfJXD9JY3S1fiQ7PEbEZte3paDNfj9s5UYJeKQt6EV
 8uD3Zp9tIq91lY9XM5B+xlFJ7RiqTdd+DP6m1gxnk/besueqMspEZQFzgawQ4q9Dpu0Z0DgfV4p
 J6Q5N7LpyTIp62Nhf/IGD53vrugbGRcD5ex81GedeE2Te09mVXnbcEqaaxVYO0dKbjofqIf5huo
 cOF4286Nj+4fdM8JCSl8sW5LtE1ub0zF4GcqT
X-Received: by 2002:aa7:d0d1:0:b0:6b3:f7f4:4e40 with SMTP id
 4fb4d7f45d1cf-6b432bdbfebmr2402190a12.11.1792760826082; Fri, 23 Oct 2026
 06:07:06 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 13:07:02 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 06:06:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
References: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 13:07:02 +0000
X-Gm-Features: AclHuK9IDFNVqHnO7ZCAmFvw7OVaoJactM3VALtChzOgO-jGGiO_FAw4a1YQhqA
Message-ID: <CAFLszTjmz9vVDfWn2wbr5_rBeYNhUorC3U6gTbziKP=SR_9n5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Prepare devicetrees from FIT configurations with
 fdt fit
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 David Lechner <dlechner@baylibre.com>, Ahmad Fatoum <a.fatoum@barebox.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Carlo,

On 2026-10-22T16:20:10, Carlo Caione <ccaione@baylibre.com> wrote:

> The first three patches provide the loader support, including rejecting
> missing or invalid overlays. The last two add the command, documentation
> and sandbox tests.

Patch 2 also changes bootm: if a listed overlay fails to load or
verify, bootm now refuses to boot, where it used to print a message
and carry on without that overlay. I think that is the right
behaviour, but it may catch out someone whose board currently boots
with a broken overlay. You could mention this in the cover letter (and
perhaps in the commit message of patch 2) so that people who don't use
'fdt fit' see it.

The new tests only exercise 'fdt fit', so a small test of the bootm
path with a bad overlay would be good, perhaps as a follow-up.

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
