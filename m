Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAB606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J50rLATg;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BGFCa107
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6032940B65;
	Sat, 31 Oct 2026 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HElw7IDONUIL; Sat, 31 Oct 2026 14:06:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D1AD40AF8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455572;
	b=jMJmZ1mt9g5+jQVorr7MYgEX8ywe5unjfTSkASLt8bj3VVI08ewabvIwh9ksyNpTtsKs
	 Valp1rLprg0n+7bQPjx+nbf+UNsfhB4WGIKHFT5S+oUSohofjv8ikhjs+b8I8ROCwRN+o
	 /ITFixQtGVtP2+Jned9rrY2CyYZnkbV0rYzbug8slBtADzEnYf0Qxj/1V58v0/464zm9G
	 vaVndxKcH1IVd9slNIaNwVSCzgDxzlPnYx8Wmqlkv5coZPHpG2PDIagbN0Q9VOsYUk5v+
	 racIWJTiFsQ+fkuBPcxdR4Pd1+GVMCWJenMltOmWqYKddJ9ZJhP3YoOebVkuZh24hGg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=M87oLtnSGfS5jFyjrc21okuWUjKoQmniEYr7mLPfD74=;
	b=bB0B5+KPHq/1vNSzuEb393Kkna4GgVNbRXsO2QNXi0oBeqS+DVTKszdasSYS9sxxg0l2
	 PaOJmF1/2pO55C0zrHxY7ni1/RgGGweKxgoO5fegkCE6HWyZB4Uzu8nyNqAmVtVKjCYuo
	 XUkUKc5xIzFjP3+Gow5ZyAJxZWwQgbZMV6QZoQZLZWRLGx9lucEV/tQF+/0TKIfAsvj9a
	 2ntrZqeqDVvL1YbeRALZshmB9fEPMSbakDrwV2LfUhyEFtZ8g6ez7GRVvzFeeNx0rR0b2
	 zPqfxSApTbFSrm4WUZ5itK3Pk6o3gVGVqQZ+opDUjrchSzskrVpOjyxRXCMc7dTkEsw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BGFCa107;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455572;
	bh=M87oLtnSGfS5jFyjrc21okuWUjKoQmniEYr7mLPfD74=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J50rLATgtQMO496ol2feLAQdtk08m9/agUSITgRdyk7ceOiRGOMq/isIJEM1/wRO9
	 2U0yg1Udq/qQIW/JRLudDCNKKoEpqjUai1YKVxuOcfnfT643z1rvhUGFAoXKIsg1u/
	 /U+4x0WG3g4u3Nqz6Rp/gnmj86lMStME55Xrub12X1FOX8at0Gld5V/6ICgW0bUaQp
	 MsnfWQMuLVa4u4S9+BmeBZpFAU0ogkxfHJfDzKGoeAiED+KjfEypHdEhZ58WV0ATjJ
	 NfJh+KjZrxt7hbXu9bXTutuYUgfAtJ2ANV/UWyDE/MAoXjTh5FCf/WkMPE/KN5THrI
	 VNDB8m3qM0idQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D1AD40AF8;
	Sat, 31 Oct 2026 14:06:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D41B411
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29D9E40AEE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hS5O1n5RsnZa for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E542A40B26
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455567;
 b=o2928HFCRl71vG4dm3nzjjKn1hAtD9L2/UJZDSXnjfHtZGwQ9MGe1S/giqi0qcW2HXJK
 SEzlmjb12tLbZUHKZnMftaqoe4N42vPxzshBovyATJpqnNT/xejDF6S2tzuZj5QfKJnUK
 QMi6DLxRlkmI3O8+213C9ecePOe013t5i5jrVB+Fw+25JPnD2BJHXyFnr/lVVPTONl6LZ
 07iFbXth8xSR0Rs/+C4RDOwI4w0z+rjcYctnqO8No7jseFuKrWYEuWVSaA9p6+VPCwwok
 SoFhFmaYU9w6OknMpe/kXzyEftNYxrhadNk9MnnwoWQszTvadjdvFpJRLIyr6QXKv0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455567;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=M87oLtnSGfS5jFyjrc21okuWUjKoQmniEYr7mLPfD74=;
 b=imRaQEzZdrmemzT7gkZB+f/9N/R/ADVg2ce+20BQVIfpdMu2aVlJfM83USDhoeIuu390
 50agZMF1IL19JRvxgkLW/IEv6sWOA2Bmb5+ZIxrwgxOzS7l/0NMH645nSzaZAcXcyoNd0
 X6zxMjwrC9H0k24HfmbzAMwkq2wAyx3aROGmw3WR1qHJ1jspbp3NPqm4/PKH1Dqe8Iz0r
 v9372khAkBGG/gqKKwtVxA2Y5//3oloZcnwjFCQMF5Z8J/pCtUGvMirZIENLi7hL/i4Wn
 1HfGYYstWjMLMQlxMdpVQiEq1Rm56QjSGsud90qiwgISrFKSHw/0JP/ml3eL3FCx/Aw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BGFCa107; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BGFCa107
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E542A40B26
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:06 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so2572789a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455564; cv=none;
 d=google.com; s=arc-20260327;
 b=sMXR8Rnfrw4mjmvnhuQLPEAxEeb30vb4PnZxWe3GT2cuPSVaEhE/jPqttOtMbOmiko
 65Tg/nHrryG7dbrJE4kwQUARy9N6PX/00Qn+3II07lgqYgHxUvRV6lS61TOwkN8eHaGv
 KTF/VabMTdbreToI3cjWMOIvJ4vr3SCu0NPPY2jBKaKbAeXQTRlwHsFURCZrQ7c7FBGC
 v1OOHIT9YV40Yc6tPu7IQ6+TUb7XeNRkoQ7Y0DJ1tob7GuwAMIm6Pt4ssBAt2qU3Cy9Z
 b0e98gLYQXqb3P7Hkw9yAejJ58pwou66uEW55ePMahFMPQaTbh4EFkiXldMxz2avZnRK
 78qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=M87oLtnSGfS5jFyjrc21okuWUjKoQmniEYr7mLPfD74=;
 fh=QpyH5SY7vR1wt0JbIXovzCg6nOtFOGAd/BfbUegcQog=;
 b=qkN3kiDVs1qmOgRWjb7jZwXm6mmHwOw4z48art0Z5oJqLUyBEgbhoREF22z4uQEI6g
 zFGDaJ2W1RZE42mQffzhbdOLSQ2oLjTgz6hQpGAZlEMSW0jGQ1pdNs+NSaywb4BUL8Pk
 ls+Vh7hurRIVDU3rW8+qEEDIO24xZ6ygpGpRaYroK1SNMK7hN/6BIBT/TTewkfJHOehw
 IGU7VUA5i9gtm7n+DVSulOcKfR9Vdj4t+EhGWMpK3nkreGihJhSvKhMSpVfhPQwFKE+A
 7Uk5SndkezqHJaV3eB59GXQ2jeUdPZwHgwI39dYbJ694E6NkLrkD4xwlQHgDcl6kVHpf
 t7YQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455564; x=1794060364;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M87oLtnSGfS5jFyjrc21okuWUjKoQmniEYr7mLPfD74=;
 b=BGFCa107BihJoovSKTlLT2JDv8MJQmL+O/1+ZXes1PrMh1CNPX1SRdnI9zhL8+Q04M
 OviwfFUhO73WZFclqllsvau/C+rP5wdb3hSmigpNPNZ68gRHcJEFJH1DrB+69ZZ3CMMC
 nwvH/AQWeU9KwW9Mf26tcf3Dkg0oUJiLOofTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455564; x=1794060364;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M87oLtnSGfS5jFyjrc21okuWUjKoQmniEYr7mLPfD74=;
 b=ncWkYnYl46Fs/B61DmsO+oSYjkSk8h4WAH44FavCZCt+8+4ypfmhZlQSh6cqN3w2/t
 M0dMSQGRK+1DVt/7Y79JSYYroXq1Y9Lnl1QmU5Jxfx9c9+fnkKH/Yt/SFrOO8bJI4B98
 HqXNGyH+xd0UkP7fljZxf/MDJcJrdXWHl/CgW5YZJUPbA8Zctmvxt9Wv7T5qXOjxZJQt
 kO1nHsuvEmJPgYG7yVC+nreuYWiRsswWnKkcsbh45ppAZdIMjocksVdVkgfW3aNEGj/u
 4tdcu73MP0DiZIqbNdbndtMG3O7x+Wf1X5cAaPCaxUwX0yp4fmhUjRrUcE0DeGYcHGA/
 /V5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxfH/CVvwsNDtSd7uLhSapqk0FTJjgcDECApH+UjwQr+A5xc+T3DgwAmUh3bumdK/Qev+NoXE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIwIZ9Yoi4g9nB0rb49C5+Xec9hxD7Ag8gc/CosZ/xBnIiiN1Uh
 +8S3/r33qIMEJPRvjRvlPxuYM73iQMI8N5GhtezepDGp5YFjvEqKMXB6Pg4XP4/3a8BExEIEujA
 hAxCkn4id78LYcBUtbTfev6gaqe6l8VU6Sa5+ROqQ
X-Gm-Gg: AYBFou1u2aA4LTlKPo+lHFZpIi8vYOHeK26uj0ca7LUGEAk946SpSQ3++B8k866i+pH
 wcVqcaYuc/TBQGJssvlrmeHezdzFhG5bPcQQDBK5HSKzpogqvuz1aFe3bbxdzt5z2lpKq9Si/TJ
 7u7cFTQrFghE+Tg0BR7hZJ/OnevxLdYwyjgjlcpexuArEbHvaa+rXeeMJTdqjv8YfPRMZ1RLFHY
 WpSS0kEZebeW27qkWLmCZ7TCazBohxLArAc7P8BDgZuDZ5bncdiJaol8iagzy2PTNnrceDWGky+
 t4tu5xrbxB6ZM9hBBCnQ9Bht8gdjTe8hoq8APXwjiS6uFzEhftjj6rWJjzJ22lrwPPgI6/FFo9I
 mdHI9r5Qx//GEAleihaOgaHqU3mCZdih1woY79gnd+KBgloa2wRqe0ZwFNWgCUlPLAIAxqIs=
X-Received: by 2002:a05:6402:c9:b0:6b4:7b28:858b with SMTP id
 4fb4d7f45d1cf-6b4d468a69amr3004105a12.19.1793455564453; Sat, 31 Oct 2026
 07:06:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 09:06:01 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 10:03:56 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-4-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-4-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 09:06:00 -0500
X-Gm-Features: AclHuK9e1qDcZC7bz3JzgzRBg83j1DYVk7cXHrbPeKJCCX3Jgbx9_iRTWQXuv0o
Message-ID: <CAFLszThLc6_KXTyM7WV9KFC+iazCcLJzLqtZAsnR_bH3-hA-4g@mail.gmail.com>
Subject: Re: [PATCH 04/10] bootstd: rauc: Free the boot script of a failed
 boot attempt
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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

Hi Frieder,

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> bootstd: rauc: Free the boot script of a failed boot attempt
>
> The RAUC bootmeth loads the boot script when booting, not when reading
> the bootflow. If the boot fails, the bootflow keeps its private data and
> can be booted again, for example with another 'bootflow boot'. Each
> attempt then loads the script into a new buffer and adds another image
> to the bootflow, but the previous buffer, image list entry and subdir
> are never freed. 'bootstd images' lists one more copy of boot.scr after
> every attempt.
>
> Free what a previous attempt loaded before loading the script again,
> in the same way as bootflow_free(). Also check the strdup() of the
> subdir.
>
> Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  boot/bootmeth_rauc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> @@ -305,6 +306,15 @@ static int distro_rauc_load_boot_script(struct bootflow *bflow,
> +	/* Drop the boot script of a previous, failed boot attempt */
> +	free(bflow->buf);
> +	bflow->buf = NULL;
> +	free(bflow->subdir);
> +	bflow->subdir = NULL;
> +	alist_for_each(img, &bflow->images)
> +		free(img->fname);
> +	alist_empty(&bflow->images);

The search loop below only runs while bflow->state != BOOTFLOWST_FILE,
so this reset only works if the previous attempt got as far as a
successful bootmeth_alloc_file(). If bootmeth_try_file() succeeds but
bootmeth_alloc_file() then fails with -E2BIG (or fs_read_alloc()
fails), the state stays at BOOTFLOWST_FILE. On the next attempt the
loop is skipped and bootmeth_alloc_file() is called with the stale
fname and size from the previous slot, even though bootmeth_setup_fs()
now points at a different partition. Please can you also put the state
back to BOOTFLOWST_READY here?

The image-freeing duplicates bootflow_free(), so should be in a helper
in bootflow.c which both can call. That would also fix the commit
message's claim to do this 'in the same way as bootflow_free()', which
is not quite true: bootflow_free() only frees buf when
BOOTFLOWF_STATIC_BUF is clear (although that flag is never set on this
path).

A test which boots the same bootflow twice and checks the image count
would be good, perhaps as a follow-up.

Regards,
Simon
