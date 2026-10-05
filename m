Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C49CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 09:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAA718085A;
	Mon,  5 Oct 2026 09:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eGTJ6yNB2nK2; Mon,  5 Oct 2026 09:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E66E280C1C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791191788;
	b=hSGlrTXeRevAqG3hMvbdEONPIjBH349chg2zk3DyoGefWpT+60f1vqhDrvMKd4WJas/m
	 FIPlrT2wGE7UdAK4mZ+y3pLqurfV5qZNQu5SWw+rC+qoqVNqOJLeRfaWRA3RL4kDBp1YA
	 hVVOqlSorXNsnznhCXuqfXYsCb9Wb0rnt5CnDBuwwD900knnhV13FuhP6Gi01JkGX7YHM
	 0zzTE6TeA5k/zAaou0fp6hc1B7Db0GVA1q7wTVP4263dtRomyfAbgX3z0q9pz9BOgvnwp
	 uhXNOqc8nrdTooRi3hbe+tvuons96cHqul911HG3TSa7Q3294amNgVLmUl7LFOTyxlQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791191788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=d434yMKtweunImihco1iPs3Jzl7PB9l92PVcbpx6YVk=;
	b=gZpoxWXCG+4rYTfdueC1LyrfxjBFt3XE2fuMvScXAZq7Px30UqzY7cLRuopyUZkkN048
	 EGSOBj8WM3sgXqSUDc7N3V3PjJYvGGqsGzNd75EWDO6FsIRrQHHGVULlIcbTGAxC6XXSK
	 +D4D6GCGb11yIaaqngdZZHsWPTdY3fE0r3IPVmm87+CTHTVgbKhYU6p3AohOhuKLLfNr2
	 yZyLCe2w1LRyJYcpcfUIUCEzEwDsLBQM0oV2TcqPVOV8K0oWdQbKQVM8xQ4h29Za1clHU
	 QO+IC5VDfmLm7hAXtJ67h09lAZeY50wJGFGBmDuZuyoE9VmneerWG0M5Wtl0Wd5U3uA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791191788;
	bh=d434yMKtweunImihco1iPs3Jzl7PB9l92PVcbpx6YVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JWXMFMKtBVEzrsupFX394UmLHuT/V71sgIFdyrGGoCAYHc8UHilSNHZSmvDk1hGow
	 CyyMo9xGO1dNnvsTgZFYMA0/5okUMV5eOy1qzYEOq+3vW+VVcaCXPM/S4Pn13FDT4v
	 96clO5QJeb/L+bgZb55+bHI4iUpCNjD9mZE7uf/JXtv+qJ/CBRL02o/P1AiLHfqQQH
	 iYgulaM6j8WKhfM3OFacteTmPOl39xRrw/VgqQ4Wwde/V87D+rhmQ4wjhAuA1uUAnv
	 qLuoiSyKPgEyp1Ga/rxg237qIV1c1oWRQ5p6dR1FyOwAHsHLftyStFWGkbUQwVG5KE
	 5In1sMqAaHybw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E66E280C1C;
	Mon,  5 Oct 2026 09:16:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CB1C75
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6C6460611
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sphxZ46Ge0GH for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 09:09:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E261760606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791191365;
 b=AEGoxw859XJX2VJ3SjFZ93vjsLS1qkyRfQjMQwfF2sNVEN4VZgFLr7ycbqBB/HQ+SWN2
 JG/m5TMrqyYCkjLaNLHyFNsPNpjFA7yzXBizeEoDgnVqJnRchUl1wOHs9AYDX26s4KVY9
 aKWlYyt5MJnebUuk67bQ6otI21XyQZkDKA+FlvnjOKzD9XjDfMoYxVQHit07GMYoEKbG4
 qrevDAXFRdt4KXaAbbtrjuS7azE4bRWe/ZmgDyZ7fi9aVUuRimcMHPOijgfGkmKf7Krpe
 lpufr+BtRl2FhP+E5og9/cB4MAxs4JfnWAjwYjo8rh5n35tHz1nHLCKVznm+AtFJikw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791191365;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=d434yMKtweunImihco1iPs3Jzl7PB9l92PVcbpx6YVk=;
 b=Z11zLdzudxoJwQh2W1Y+2poxf6DUhp7js7S3mei0jjfAas0tmcjx3KZPeRcLgboeWYS4
 MAd525zqGUzrQ7uxfoKJkb4hmSpD4gHbNyfSbaQ1qOexm9ouXldUbBPfIlEAnw1uI5XbQ
 zud/F1oc2u+2j9cNpBM3e3x33mMcYceE3KD0UKFegz3OrHE2d/HxqQlG96uiaVph/18QI
 DvwrDoZl1CyJnj0G3T9Uu33vJomV5uE2SuUQIibKRkwzXq0mFvTbtgjGPCKlW9UtevIM4
 huAaegeBFm8Fje+J4iB0/MJr3PeetZJw6DaFFers+PAQZLsUwBIEPCNlLRVJhPlgEug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Tegmn561; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::2b; helo=mail-yx2-x2b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Tegmn561
Received: from mail-yx2-x2b.google.com (mail-yx2-x2b.google.com
 [IPv6:2607:f8b0:4864:41::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E261760606
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 09:09:23 +0000 (UTC)
Received: by mail-yx2-x2b.google.com with SMTP id
 00721157ae682-8ac8c533385so8071187b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 02:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791191363; cv=none;
 d=google.com; s=arc-20260327;
 b=Vnuz7cAp+Jn1eNMXlknkSgpdGFdD94mjLXQW+Lv6coDmCgnkTS5tvz+Csz+nMk1+nt
 o+xaYaaKee6IdU4EUCsD8jxmwTKPej7m383/zV8lwQqwB24Gtk8QSnVYcVhrprR0TgoL
 0IKmUo0kea6BkPn2Lz+EP/VoAXn4zGYOgYy8Tl09U2sjx3W1yDvQMrYzFvsuYJaULslf
 3U6Ea9XVHRztZLIWW3GF/Fgljb2n4y/dyF9i3ca6gKfDfAR1F9gN6irvyf6QwqOusEqs
 V8fhqCk+WjIJL/ZaLLwuKcRKZhb822Rm4QSm8g0ZFjAgx09dQAha4hOFcmlhQ9YxRkHv
 +jCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d434yMKtweunImihco1iPs3Jzl7PB9l92PVcbpx6YVk=;
 fh=KjHcQVfREBtF4cPV/KhJaPrJlSJqC7wwnBKGBtNBWDY=;
 b=fiYTFnnn0aqtLbMbzlnO5gLVw8vmUM8V9Z6AQ+qYQUEv4CKlZ3AtjLM75WTouxOlra
 JgrFuJ0AQqQppf8tlSFezx3Jxor6YdB0Iu0sKKuKCooTjxt68lAvKv0RMxNIFqDJz7nI
 YrMi/qQtfEjFQHv0jiMCcrABv1dP2KaUk2ZZTLd41Wn/oEErqpNInCyaLO1h21jQL3hw
 g6UVG89k4MIuKRx1dOzfsZy1igqfkUPoIkCTavqvs6BMs4b5LgNvNwAT4gonDKI8SPsQ
 Opyf3AyjgtwVF4LRKeVJijxhseph6mx5I9p3pLZc8lS1l6TAbn+qxizcYgXEk5pMR3a4
 Liow==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791191363; x=1791796163;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d434yMKtweunImihco1iPs3Jzl7PB9l92PVcbpx6YVk=;
 b=Tegmn561OXbBhkntzv+8wAGuPgQin/CyFfY1jytpH2fPp92Q/pvDguUBHwb2dqFEpX
 0f46f4wcoLCo/qMoyZSUX1Vy2g12g3GJ0mAbgi96gYnwKuTDRaXHk0OJJtrYX+f67cqC
 VJC7Vzb/Nb6JsvU6qIvAkyEpG1eE+YJT+Z1AF8s7yqziIe2jH46AjyRkiz6gy6UlmidN
 RYfo4GMgE/Y+ixOya6k9TFIJ3B7MyleyxtfqJrFVWwz+GRw9ut7Pd1acurskf0kdgGa+
 9YBROgOu2Fjg1e5Z3TWQcT5ZYL9PJCWhn9Yay05utKvPvoQORbPZnyu4b/fybed90+TV
 ZPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791191363; x=1791796163;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d434yMKtweunImihco1iPs3Jzl7PB9l92PVcbpx6YVk=;
 b=Kk9A1JMYjh4Q484OTBeIyRbHyUwuV1OGyWFF2Fw2LeBumWYsvH5IWM4Bc7AJR5wWH5
 u55Z+bBQkD+cNQWZ6Lpe6mOveWCA6EFCX9m/MVjznnqf31+tXIEX1O6sdD+PUejr3Yf6
 MLlBF/ngip7Ek1fuAqkSQdzqgn8E0v/SzBHY3trQvzzL/zQ2+MpkGglCmzWtA1kCNEhu
 We/h/wNNxKVVRTG77fII3R9Nk5Fwm4ooOsaLA5OT+lYH6uiyv0gMrGwxR/rZR2yPOksf
 lTFbiOe8bVpqPEkZNWtHJaByhZs/AR+4EQoPx06ETjHctgLDSRmxJ5jKgk6kC/rX7v5U
 xJqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPPYS6Qx0hafRRP7ZbeJfbCH6x2qACsseLjiGbh2IU0Qb/lwkj6z036rgL4ULSZ8J/XcrJkRQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJEQ64pZ6lugoKhUoLStOX/ButyjFnUYTL8YUZJL6r2caYktliV
 tDE28LO1zDuOn+nPrd8WhfOPoU+gbsjZi72MZjIYkEMhZ3cDZHYGEJa4kLn8j9XhIOtE4My4ymW
 Au62a9jOTbOXiPWAXxgeegXvFCxURelp6OUOIC+HTSQ==
X-Gm-Gg: AYBFou0CzJyDx1BMI2v0zUBra+1C0hd+GnxBGpuWmTzVunQnIyvHID6G379196hGKGn
 i0yQXVLx/fRLJ3W7d8qqzIKkFxT+rzBUyLjk4etsA3WMXpSoGgwzb7NRce6kY1+Z5tGtXh3xRiR
 jDXI9B+su7x2G7lukMDczzjdQWRGlikLyKrj/eTbOKaxlNfhfsqGh6f2dEpJ8hAcpX5duUmzTG/
 hlYQJj+WQsMy1GKOXkw5NC4lZUDCDbrEsFlEwLp45u39j+zE37Uu+ALkd50urBYNmSJTmDUw7j8
 AO+zU/mwMFlw2g6VGmpwjoG/muwDZNy+d9oYEpMdnOYoWCdd18x8pXCzSLmOsGgsYxdJIkge2UY
 Sj2mh0+75CIOgatC0uUD1t+bU6Zui9y/TaQw42cYbFWM1J39lNoM4Gru2lfkpT7yVCazcXqpSX4
 6c2IOMs+qMwGO8hKg3gnni6THmY++37bQt7vXcjr8DYsCzqtMY9IeNzaMmtH3O4hGPNWLKZMcKd
 Eh4ol7uTBS2N8csUb3/tuPAcrJ5HLeDh/cmiglrB5Vff7DAXqBrlOse75LHPPWI8iCusGjhE6p8
 fnBzzEmLiB0XxbUdLp9xpOTL3cvM7n9Y97tNuszaPB1Qaf9Tz9n6zqHRbRmMB9z8s/brtVF5Z/U
 6mi5dEwDftabnXsx0w3IaDdCOEPjJX6Z2uI1ez3rh/UFxZe49DpsHAw==
X-Received: by 2002:a05:690c:a74c:b0:8a8:5c3d:903 with SMTP id
 00721157ae682-8ae3ace1225mr26897237b3.62.1791191362660; Mon, 05 Oct 2026
 02:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJpDTRXWjQk2mfmSxens=1-J2Gbba79MUwVHu440uRUXA@mail.gmail.com>
 <20261005082001.52271-1-michael.haener@siemens.com>
In-Reply-To: <20261005082001.52271-1-michael.haener@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 5 Oct 2026 12:08:46 +0300
X-Gm-Features: AclHuK9Tc76zfgzyHtmn1S71knS9KM-wQxaJYuM5kfmOPXvkovyuLcxRWmREi2M
Message-ID: <CAC_iWjKvJPtNvoMdcaw+jg+-9=DNOpSs5Przkie9kwvyE=u99Q@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: Michael Haener <michael.haener@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
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

On Mon, 5 Oct 2026 at 11:20, Michael Haener <michael.haener@siemens.com> wrote:
>
> Hi Ilias,
>
> On Mon, 5 Oct 2026 at 10:48, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > Do you have a real world use case where an OS wants a TPM with zero
> > preboot measurements?
>
> Yes. On some of our i.MX8 based devices Linux uses the TPM for disk
> encryption and for device certificates. Platform integrity is
> established by other means, so nothing is sealed against PCRs and there
> are no preboot measurements. Disabling the TPM in the DT is therefore
> not an option for us, as Linux needs it.

Thanks Michael that helps.

>
> What I am really after is that Linux finds the TPM in the same state on
> all our products, whichever SoC they use and whether or not they use
> measurements, as it does on UEFI platforms where the firmware always
> starts the TPM. Today that depends on the boot path in U-Boot: EFI or
> MEASURED_BOOT start it, a plain booti/bootm does not, and Linux then
> logs "A TPM error (256) occurred attempting the self test" and starts
> it itself.
>
> How U-Boot does that, in probe or from an event, is less important to
> me. I am happy to implement whichever you prefer for v2.

Yeah, I'm not particularly glued on "let's make it on probe" either. I
am fine with the event as well. I just need a proper justification for
it, because initializing it during probe seems much simpler.

Thanks
/Ilias
>
> Regards,
> Michael
