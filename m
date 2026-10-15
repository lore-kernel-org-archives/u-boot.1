Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A872CC6B2D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 03:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B88794040B;
	Thu, 15 Oct 2026 03:27:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RI12GbYSdm5j; Thu, 15 Oct 2026 03:27:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D91AE40535
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792034847;
	b=fWL7STtrDpShV59nTmeadUC32C3HG+znziRZS1pSW2r2JhJva6L1xeF1ck03duF2ocej
	 QK+WwHe8GHLfxpTr+dSvKf4xLFI3yBBeypGebz8z7BflMUmku8G5jp2rWE6OzjcDoH2sf
	 c0dO+NvKqt7ke3djj/e/5Nd31e6ksUY7Et3E/zIKHdvokuHASi5ZefkeJKpCgSyHqpZxs
	 uLKaf0iuNng80cKSi2WAelHB8etfhxgi3SDFdF8spgjlVqD4/JwmBn6H+ekM3n63wLSoa
	 YpRUgvZvoKs+YJNkNxPgybfa/YK0Cbsr3GB/c/8dasWmsYOLr5FKrakaUc8g7KSG2jw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792034847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TUVYViv+LoRnmMP0+NREr7A0GbE1xeqoc2a9xHdgKcQ=;
	b=HEmNnSl+3CQo4gICp7XEnLuSLLZHqP5tkl5PrJGJnKFbKH3U2BIlGA4WAkVtx8q48HBK
	 SsKcdMvdSVcSdSSwG26Ss+F20udObMztDjwGoBDYEnOp3oWTQelnEoTvb9Fpp1DV9O36U
	 pypeHAKBJyN/K/rnqqSKneJcza5UbPw8OIGPCfdBjsUDDtJw7weXi5Yqa5zx7fUScSDdW
	 71aaHdoh2mtb9U+JVteoeEwlm7e+8eymu6M6tFkYbvIy4+uyjl/g2qQxtiiEXC38DRt2Z
	 SLii0EBCuMiYIroDEDH6nkDjv/1ERDHnfSJ/Pzt5u3WT15Ov2YfYpYXnMntSSRf8fCA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792034847;
	bh=TUVYViv+LoRnmMP0+NREr7A0GbE1xeqoc2a9xHdgKcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i22Geot2yHPEs0JR/9KA4qn3dF0agEC5MuTW9hxkY1m+B/A2tPkyQHywJ1/eadJQ3
	 gMRSKWDtHoJTQM/c04AnOfiNRgFi9iBHhWkAZqOglR0amzyC8fa97v4fQJ0Dkk5dFm
	 V7nZ3hXyhk6P6jsjD8WU610fbAvL5QqJJ7hQY1Uzt97+0CbAwhzYMZpsWJQgyS+S16
	 DMwgNB86iPXziOHq53awPT+aYp0VzQOk2UHzcxms10rLmtdonVTvRCIIJOqpyOvUIj
	 /Nm9zBIkoVh00Xi3IZUVOby8lEayUnielVq+ZSkMlWXkxg7LrZyhzOgvA7keI/HOqt
	 UFMM/pBAF+8ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D91AE40535;
	Thu, 15 Oct 2026 03:27:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED4BDE4D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEEB760898
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:27:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1TH41JmYLVUN for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 03:27:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 68C4B6077F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792034845;
 b=eGWJloYYcom/9hXi3u0RRWjZalL1QgV43Z8eeCyMz2/vf0tFhQbP9DGKQat5o324bjS5
 xhGqFHxkRy2FjRkSRdXbttGTzHW2PsfqYiCEXbSVJgsI/dXblA3MEdZvI7nDaIshHYGnb
 fMWwfmoppyWSY/8gkhAPKUZzLCxX1HWxGhFN8H9cn1jPRpcQS9qF5kmeLcj901uP74+r6
 /Z7pZjrnoSU0e7STbq9h/6PKq96sSaGf9ODMTkUnHkEP4MNNKp0SBfu5Hoch8rLLMnq3h
 ZAAgfLEvR4UvpNJ47STb3dVv5PsCO0ndgQxvMPdQSs8atvwxQikgTFZxyRwxxNjdoCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792034845;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=TUVYViv+LoRnmMP0+NREr7A0GbE1xeqoc2a9xHdgKcQ=;
 b=RGeNojYm9RZC7T25WvRYQdPUapDiaA/FXMO4aWElMG3iy4QGFQhCJfC33Dd08d1NMbrf
 RKdzzFSRj9zyP73Tl2Bpr+HF0XHWqhOTMz/vYsenJbfx1PE1ipmGYG0YAa5V7utbFwuxK
 GuI/M+EgM+FhShlOg/9wkPb2B2HQF1c9Oe5WC4yJAFMpyIlECJAEekvIV++5y6YZbUITA
 OT1u04jL4zgypj7AbI0MysbLdvpEr8nA+qZhKORumXZjb5RjOhIiO+iovxEC+31h/QA36
 yAeY9nswYO4CoEOnxkadLdR4ecGStW4Z1gQxiJMIUMY2ZMAZTBVZmkze90UXv9uTKhA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=AE+Y92LZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=AE+Y92LZ
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68C4B6077F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 03:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792034839; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=je2AZR9CJRfqlXsY/GJJvpMEEl892qAh7EblQ5e1pazLNgGY/g+QFglbaRQ2ltRfX8Ii+4TEMRyxUYmd1e8sDR+QHiFUuWJHT9qFuHQGHyAvpsL7QPu0L5Gfp0pVo06S1uW93iwvYsj+0qwfIbGJTt7L3muzrqUCflMHeFhCaw8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792034839;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TUVYViv+LoRnmMP0+NREr7A0GbE1xeqoc2a9xHdgKcQ=; 
 b=Ckau2dDzQ0Ul1s2h9CDEezBozuafAjiH7VNjcnTs/RVBRkLpJTclCm2sBY/Ezd8dnfd2lQnMoh4kygXb4OfCZlc/PEvdTCbzLme4w2aq8nE/aUnvU59Z8y2QdeNLj1qS71vZ8aLIfEZkaO5Thfrp6mlfk1gxQiwaMfIfEazWs7g=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792034839; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=TUVYViv+LoRnmMP0+NREr7A0GbE1xeqoc2a9xHdgKcQ=;
 b=AE+Y92LZoLN+tXp1UlLUzHfeh9X20rJOeNWxNgfXuNhM+TjBZQksMxwsKfcxSJh9
 ECFuj8tkpLw01IEKO2g6WeLyMWuewgnkCLJEYhLjo8qUyAktXa/jjbuxWPRtcsNKN9m
 /fbzx8grFT10gprXvHNja6xcnnAkEY7s+Y5ymJuo=
Received: by smtp.zohomail.com with SMTPS id 179203483728757.89175044161129;
 Wed, 14 Oct 2026 20:27:17 -0700 (PDT)
Date: Thu, 15 Oct 2026 03:27:04 +0000
From: Yao Zi <me@ziyao.cc>
To: anon87111 <anon87111@gmail.com>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, 0xiviel@gmail.com,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] image-fit-sig: bind a required image key to its own
 verification
Message-ID: <atBICLs6No2HdGP5@pie>
References: <e4f97d42-fb3a-4c5f-8f11-90a87b2172f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4f97d42-fb3a-4c5f-8f11-90a87b2172f0@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.28.93
X-ZohoMailClient: External
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

On Tue, Oct 13, 2026 at 10:16:08PM +0200, anon87111 wrote:
> fit_image_verify_required_sigs() walks the keys in the control FDT, picks
> out those whose "required" property is "image", and passes each key's node
> offset to fit_image_verify_sig(). That function takes the offset as
> key_offset and never uses it: it calls fit_image_check_sig() with
> required_keynode hardcoded to -1, which both boot/image-fit-sig.c and
> include/image.h document as "-1 then any signature will do".
> 
> With required_keynode == -1, rsa_verify() skips the "See if we must use a
> particular key" branch, tries the key named by the FIT's own key-name-hint
> property, and then falls through to "try each of the keys in turn". So
> every required-key iteration is satisfied by any signature in the FIT that
> verifies under any key in the control FDT, not by the key the iteration is
> supposed to be checking.
> 
> Where two or more keys are marked required = "image", a single signature
> from any one of them therefore satisfies the whole policy. Possession of
> one required image key is enough to boot an arbitrary image, and the other
> required keys contribute nothing. doc/usage/fit/signature.rst says of
> "required": "this indicates that the key must be verified for the image /
> configuration to be considered valid."
> 
> The configuration path in the same file does this correctly:
> fit_config_verify_key() passes key_offset straight through to
> fit_config_check_sig(), and fit_config_verify_required_keys() additionally
> honours the required-mode "any"/"all" policy, defaulting to "all". The two
> functions were written as a pair; only one binds the key.
> 
> Reproduced on sandbox at b871f722 with two keys marked required = "image"
> and a FIT carrying only a dev signature:
> 
>   keys marked required = "image": 2        (key-dev, key-prod)
>   FIT signatures present        : sha256,rsa2048:dev only
> 
>      Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev+ OK
>   ## Transferring control to Linux (at address 000001cc)...
>   sandbox: continuing, as we cannot run Linux
> 
> The doubled "dev+ dev+" is the defect: one dev signature satisfied both
> iterations, including the one for key-prod. The same scenario against the
> configuration gate, same keys and same default policy, correctly refuses:
> 
>      Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev-  error!
>   Verification failed for 'conf-1' config node
>   Failed to verify required signature 'key-prod'
> 
> With this patch the image gate refuses the same way, and the configuration
> gate is unchanged.
> 
> The hardcoded -1 dates to 56518e7104 ("image: Support signing of images",
> v2013.07), where fit_image_verify_sig() already took sig_offset without
> using it. 99f844ba3a ("tools: Pass the key blob around") added key_blob
> and left the -1 in place, in the same commit that kept key_offset wired up
> on the configuration side. It has survived because nothing exercises it:
> there is no required = "image" anywhere in the tree, and
> test_required_key() builds only sign-configs-* fixtures, so the image gate
> has never been run with more than one required key.

Should this commit carry a fixes tag?

> This is separate from, and complementary to, the fail-open gate reported
> on the list on 2026-09-07 and patched in "[PATCH 0/2] image-fit-sig: close
> the image-signature fail-open gate". That one is about a control FDT with
> no /signature node at all; this one is about two keys being marked
> required and one signature satisfying both. That fix leaves this behaviour
> in place and this fix leaves that one in place, so both are needed. It is
> also separate from "[PATCH v10 0/7] Improve FIT signature handling" [1],
> which covers the configuration gate.

I only give it a brief glance, (at least) this paragraph sounds like
background, too detailed and less relevant to put in the commit message.
You might want to move it under the "---" line.

Regards,
Yao Zi
