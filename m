Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21B9C54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7AE740A02;
	Tue, 28 Jul 2026 12:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYRXfDEt2xtZ; Tue, 28 Jul 2026 12:03:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D126440935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785240192;
	bh=ITihgS2PToPCbpk3grLoiTYVBDmz8QFQwqBMKsBcHgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z8R9AuZMbtNXMx5CARPXo1DnZJ0HYq6nEMAY22eLN+GpN0en/QeAqLINqzUT5EaT6
	 XMA84bP5P+qE5DrvTs1USKgXzT7pi88R/drbTVeBK8bfKYhMi1dZo+TFEvFTnEs3NX
	 giqddxb/Unsar8E3wADNQJEGY+KLHb1fG+CHrpNEqt+gkeppP9US3hpcaYS91JbS7b
	 1Uza7kempNa6L8OxoOoAxtOLCzbGQjXe4hog7NJS4kTORzbCKXiG1TixdzqtVd+Naz
	 BuElA53ZlIY2tk7xE3s6SEcETtjOyYiyepmwnIjNp61ZbJ418/+6cQX2aDNze10Kzd
	 IJG05rIdXfEpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D126440935;
	Tue, 28 Jul 2026 12:03:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CC1F45B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08B1F40314
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5vh32A7NT4P for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:03:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 16F1B4030C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16F1B4030C
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16F1B4030C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:03:09 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so5552034a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785240188; cv=none;
 d=google.com; s=arc-20260327;
 b=ebbxFqWnboc66DcIUHzYRzcXgrQtqlUGconHTKmF7cxobMnSzHdt9nMnOPO1NeGSg5
 pk0yMJ9TO1NWs4SrldXYbI7oqoX33DruCYDHxUkzksBt9s5jAy/Q3VVr4SRwHBFPh5uf
 ZYxy/EFn9G3jeKEzc4CdyBzg6Bn1zprInd38GIs3/MwPXgh2Zws8MbWYRUtYrUisTh+i
 SxFmt11Dz64jrolqiUclAt1iigIUW2HhYxauPTRtWVFiI+FfY9bqkHyKSOmRjvgaHzl4
 qSposRxFT2+xGy5Z9xckIr6zdFKr8D0r1CoumeMbCBdZ+yiyfFw+Pbb51hw7nHr8Ptn5
 U5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ITihgS2PToPCbpk3grLoiTYVBDmz8QFQwqBMKsBcHgU=;
 fh=m41YwknmSs6bCih8QVN/ODhKEvb1Xu/eQ/3bXony0yI=;
 b=cEELfSt4mqDm1xBsG0gDlcD0vnaKDFWcQsdEmlzWQZj8E9E9K5OQUaaQQgH2PtbErc
 StvLJc0K4TlmFGAWzbiW2WPD1iFWY95W++0AvcRXFv2aLVWxwPGohp2CZHbVeFiWtaJO
 07N/g56LGyZNCXQF95rlCIkVOOarLZrowVRSB4DzvHetMcfQKceFmqrqeV7Z2uIAfLz9
 29CrDHJ0RLyfIavKfYpPJRrhkGvG0yss3EEYo1b4SlU5giiU/aeQSUmuu4Mi6tzwtW93
 UxkcKTPr7plTtzIFgQyarnq/1MqCA2SZ+hFw/T1owufBjupKLmN+n/rqVE2i3LzCX48q
 c9/Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240188; x=1785844988;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ITihgS2PToPCbpk3grLoiTYVBDmz8QFQwqBMKsBcHgU=;
 b=M+Lpu4wpYAeaIvOEuiJHSRn9Srm1soKRg+CYhucotRCMM3TCwkje66WZBASzmtM1nX
 +KkoMvij5VDN+pIRIrTjbBWV4InYiKR306EJhDLds9meJuAFn9UhraL4iCTcfbP8lGz2
 oSOGrv9i83GldzuSHxP7T8hSuRF8xkLBvYVP/oQQTvS36ZAdaaks65Rr0rkJ7v+uv817
 XCHQwyiioHYQNraIZR8uCIvba8TA5PdEvOXiIY8fZOgKTBDDWK8Zbys47NEgflChdqOQ
 HYO6RnTX+HcCahy3pGqlDOpWyFBqRVVnbunZwuCYFAnuO2OXA+5R+CZ1B0l/uxlHDQ/s
 H7aw==
X-Gm-Message-State: AOJu0Yxje0FqVEbhlryo8FfsIBiOEATNEQ0ExIXQqP3E4SzDMWyDKThP
 XURbBP3sajVqr5nye/6r3OuLHjMkUaZywlwFW3/o3uovAVg0SmrHS5gMN8Cm3guN+v+pLk0fhDh
 YKj7se4omHqVrpaBxlZrvzmF2vQRiENGG3cfpajN8
X-Gm-Gg: AR+sD10p7qvXMD1+Hx78NUGkqJU6OaCaw8rvnVBOTXLk+gwOmS16pSsyc5ZS857eECe
 RaQJQfCPzpyOxeSXhjS1hsb2nIvevANnPGEr3TU5onjhl8ZxSfD6K5tcl3DY0u2AWNosknLNjbp
 eJ1LgykCRZgNXYl5UXrX9tO/vIet7jZTy2Tq+btR3YXnzD2fYWa3y/sk9/FqqcwOrXX+hqkC2el
 X7bpOdkFf5rtWnYAShZtPZisYFfgWpHVzKFWbGtlmLeVnwcfABb/ZuJodwWcXQAqE5TIt0=
X-Received: by 2002:a05:6402:388e:b0:69e:35ae:8afa with SMTP id
 4fb4d7f45d1cf-6a034a544bdmr1043051a12.27.1785240187864; Tue, 28 Jul 2026
 05:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260713074539.32875-1-liulhong617@163.com>
 <1784776723.232131-1-liulhong617@163.com>
In-Reply-To: <1784776723.232131-1-liulhong617@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 06:02:55 -0600
X-Gm-Features: AUfX_mx4JolEQnV_Gggjr7Qys8ll2a1oO-de4xuTBNJ7Qlfva41Jfp_c0cgb7Xg
Message-ID: <CAFLszTj-zsJBXvCpqgqyQFOEQ=sOX0bOAyTiPX2H56sXnw5Rog@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: depend on OF_LIST dts sources for
 fit-dtb.blob
To: liulhong617@163.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785240188; x=1785844988;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ITihgS2PToPCbpk3grLoiTYVBDmz8QFQwqBMKsBcHgU=;
 b=AKfXuPfGqPiE8WuZxYisvE+fnuSXXHEOhOTJCgFgnmT+Phm3/xFBvHTYw7IfyVWb1U
 uYYzzv68lwIBJEwrEsuv7stsM76sC2HWiDLj/kU0x2mG/QpLQfixTwStvhQf0oyPbyz7
 EaeWenCqz39qXPOdhf/ujEXtqZ2JtC4mRvkE0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AKfXuPfG
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Lianghong,

On 2026-07-23T01:40:21, Lianghong Liu <liulhong617@163.com> wrote:
> Makefile: depend on OF_LIST dts sources for fit-dtb.blob
>
> When CONFIG_MULTI_DTB_FIT is enabled, fit-dtb.blob is produced by
> mkimage with one "-b " argument for every entry in CONFIG_OF_LIST.
> The make rule, however, only listed dts/dt.dtb (i.e. the
> CONFIG_DEFAULT_DEVICE_TREE blob) as a prerequisite:
>
>   fit-dtb.blob: dts/dt.dtb FORCE
>       $(call if_changed,mkimage)
>
> Because FORCE is PHONY, if_changed ignores it and rebuilds only when
> any-prereq or arg-check is non-empty.  Editing a non-default dts in
> OF_LIST rebuilds its .dtb (tracked correctly via fixdep), but that
> .dtb was not a prerequisite of fit-dtb.blob, so $? stayed empty; the
> mkimage command line was unchanged too, so arg-check was empty as
> well.  if_changed therefore skipped mkimage and fit-dtb.blob kept the
> stale dtbs.  u-boot.bin, which appends fit-dtb.blob, then shipped the
> old device tree and the dts change did not take effect.
>
> A previous attempt to fix this added every OF_LIST .dtb *output* as a
> prerequisite.  That is wrong on two counts:

Thanks

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
