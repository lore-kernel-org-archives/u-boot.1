Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2561DCA6017
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 02:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4ACAF40762;
	Fri,  9 Oct 2026 02:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ti5CrCCEIr1y; Fri,  9 Oct 2026 02:07:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FE0940757
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791511652;
	b=daqwZPZ1m9gZK0+eQcpo1SbQvXXz2fzMnQXpADws8x3hOuprzG3Sb0UYxFzgdUZKy46H
	 8IIuXZ0EBGdpWN2Aa5yfl1TrKLEvmMrcHAA2oMzttEbGPJatzUADvP/mHpES1ze3T1Q8v
	 TyouPr+73ughq66cfGhV9i1Akugr8tYlxNAyLUIl8zSN8KxR5X9sKPDwQtLtJ/VKJOe1+
	 hFo5gkwt2DychVLcZvC405azY2m+/kpopHq+dLl2vnrA6zDgBg28C8US8xQSSqSP9MHwb
	 0Kxs1SZhq3fxdF/FhiQNN9Wu54VZrT1jsFY+uIfhjVWP0eSWr+6NNFQl2wofQyeJe3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791511652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2IPdQVkG36WMUhEzysdwGbMIw3kBDaENgHEpsrdCKew=;
	b=ej83x0n5RvX/irlU5/kLVc8tBhxp52jphm8yvZyc8PRLQGXoiLiYewPLgeA1hTn+5TtW
	 YlK93CBnUNo0qgY7+hypBlMAYkxh1tqMPcUNoJl16zUGDvhHxCpwDM/xKhB13fmEZ3c/P
	 JnonQdQVPd2PADQQTqWxg7FXhzWCWdc0NZ1SIR56fyKrJI9E9lyFtXAhV2EuwAKx4+TP2
	 VUv6b/lssToxD4J/Muw62i2cwieEDrx7w7bfysH8QARuH2SOEHQb3pzu2LRkOwzFmp9or
	 BV2eE4GYnFqM3s/ZIy94vK0k/3QYNhZgpXY/CUQ6/iZl9la4UXdI8RllynAd/nW+acA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791511652;
	bh=2IPdQVkG36WMUhEzysdwGbMIw3kBDaENgHEpsrdCKew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zadPbUI4CWKMhOmLmfYqbWLbJ3GaZf4GOYr/QXUkJvdzg8a3kW9AMWudGwf5V35eb
	 JO04bVjfDmtOIQogoXndNXIvjYuU3FT3XAwAmqD9vODpLmq60VTeVUcf1ra2dEwTgm
	 8B8HzKAaT6tGZw9rLBF3f+0fu+xidr1Gy5EhmZHNJyFTYuvkAEiKKrdiTZA+wwElQs
	 x4lPGV88De7fv+mJjRHCbMTYIF3TnMciFw2z6T4gXX479D7mNIKjTCiOUpQ+/0rk7a
	 mlOa3aOkKyg+6HghS8Mo9pdVP0Xop3aDzQNOYTz2nV4HFaczxJsT+GE3yC8+tA4Tx1
	 ddo7ccR5S0fSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FE0940757;
	Fri,  9 Oct 2026 02:07:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED4F51A6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 02:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEBD56082C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 02:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbQKBMdhAuPF for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 02:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11288607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791511648;
 b=fCZfM7yaMFjHM0mniQhCRDj81TMwbzPKvab2b98OSYEyZvuIDJ17kaW5uK+xi1cC+EPK
 dCjqOv6EhX/BrYTIHxqUEnMNeXG7km0HS2fgQpr8K+RnljHTrtGVIl0MRLW4SovxVPfVK
 3IEgNYCBVHzesqrAAEUa7wiQBJb3u55py9coJqmY/lCfSR8joIuBJtJ7aJElA9IfSNNoT
 QQTARcCPRI7ofnQAtEBe2rcjzUIDBJT6+eV+KKj5xMGanDQsSC9CFw2j/b85/km+IfElq
 LCyIvmJF8DMAGMLWtNxxO3vWYUSCwT9m9U9RgyiI1CdwKnFsA5jrDqlm7uIOBz+jQKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791511648;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=2IPdQVkG36WMUhEzysdwGbMIw3kBDaENgHEpsrdCKew=;
 b=CFPjZSOk0+OnLcKGp1ghgsQgI34dj8msPTbg1GWUQ/lqXQdV+QPMnYC3Dau1BO90yFg2
 cWi1sMAIhzh60c5NbKkgPH+k1cZZgfASjmosfeA+A44xM5j6rr7Fm4RBKT2ERcw/+Nlrf
 kICMjlWRh6jxLIX5HOzNu0MCSknq87o82fIhv9iWC5XQKbWNq37nVKkA29OZWdSIdd/0L
 vLEmKfDOircofu28Qrgv0hIRLFYfSN70p0SFopI8J4LHrECByOyfjWLbH+3lh0ZrI9xNt
 oWVgFNrc48s9Arp1RsZUU+ETg/KT65kqHsJkjcuO126eSdNF8xVmCbyAGtAdA2SsXtw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="i+Xr4/Bk"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i+Xr4/Bk
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11288607B2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 02:07:27 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-677bf06de21so5730240d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 19:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791511646; cv=none;
 d=google.com; s=arc-20260327;
 b=GfW7RUb91x2N02aChuil9oFNE67wyKGzpc6lBEXk0JPDAhnDmyZr1wZN+25pUrqYvG
 0NZKDpSkwij/1KD4XoZCZdqnbq/bL/BlWPdBzUoBLsG19Bei/l71LF68Giq8UiN7Wf31
 OMzFpUZDPcJFUrtb16HrBTcHlVX5fSqOC/LdxLeR1YMAaG3AK8T+1ZfhjJpclwVJicT0
 4mqJm42jxKyZKifBFGwyUAqJ5g2BvPHzyBa2nGuypbQgUTji9FggLuBv1Jnf2y5WDjo4
 5nKcDVEk8XSAuF04eqiUI1bxW3Uv+xVoFz0GiJxzHfXraVxdBfwoGaYENSMETOgtaV39
 vhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2IPdQVkG36WMUhEzysdwGbMIw3kBDaENgHEpsrdCKew=;
 fh=/kL1y21aNJcYkJetP6uyzb063T3IsQBozu0QHfCbiEA=;
 b=pk0rkDB02c1NAt+Twtc7Z7FM/LeAwIm3UC4npdMFM0j/ptKXsYvvx8cjXFq0j0KJ1x
 Q/0gv8XfVKO0npqGdFfmI4b9izFNM6CRrL1NN86oqruXYVCilhRhfACZbU7NeQZ43NRq
 wvnhaEAmQAbSHUJ5xqw4HFqw8AMOfeR9tKH3DxYW658umxyV6BVKlmneSf6TbcygThbG
 GIW9nMQ8T6ADWj3N/RfmJP0U4TOMiPmmWjrkIIP9wEkJNRPr+lUxG8mKX9OH8Q2Q83gC
 fJIWiG0D34pfbCt1TSjeqomumNi1TJzB83c0pPbvGV5D9VscPh0R5gtCKs6uv8hqfuQH
 U5xg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791511646; x=1792116446;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2IPdQVkG36WMUhEzysdwGbMIw3kBDaENgHEpsrdCKew=;
 b=i+Xr4/Bk3Unwyy9EjCyIBa+SByGObw9a6Oz8UCO+ymmvZT34zVUTn/uLIYVVulyTkq
 DAKaheytevviwXK4kAG6QGDGUt8USW5v+3rRl9PP2IZgKZ7aNTywacnkCNCHQxnVtbXY
 FtQ7z1RhMzLZX6D8dRvpcOZGqrPAOdwUbSXghH64eexgXQuQI25imi5e861UHfquyT+0
 ZqradW2plqy6hrlbTdj74qnieYIugtTR7R+Ah8d6qORS6jbDzU6UWi4pJL83C/NR0Y5h
 JNwm1qoaEO3+4Sl5Ya+6xrznbMq0hEWFneijRDg2ArgjadtEsgNxbbW5rZZxvQV7hwBQ
 wkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791511646; x=1792116446;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2IPdQVkG36WMUhEzysdwGbMIw3kBDaENgHEpsrdCKew=;
 b=ctwaY99Jb403IzYKaagZX6TiWVNSMBxlT6PZMfXrVqb7eCCNzbyM9VxZ2PLfq+9kLT
 pilrOmqRTPmWuqVCiA4ihNQMSoibl6ncEI8s5o+7CJy58BENAI/ajWYqg9ixJJxRPmDP
 wPu3wWiH3D8NqWl/Mo1xhc9YoRrHe4SOc3cOxdAqHYgj6zxyaPmpS5xW+QGVIXmdAxeW
 v/jDHxNhJocTTe6KETZIQjhJcuVviyB7Yi1dojraJz5DrEY5YZ+8i7djmg4sT5UGAnYN
 xHh3f7StaE6ii/SZaKywzw+Rqjn/LzK3WeUoqWc6QQSu/jDDaENOR0tcsku1P25pj7Aa
 +CdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzC6Uy6q9SHfGP7xrVqNNLE0JmbF4CMrHK8uPeGFFB9nWw/2idFJ1a6zy4MtLhDsBIyEdeME0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKEWFpFo3It2qmUORp1NBiaMdqj85ooTjwXZE9f0BoLBy9BGrz3
 IaUvRLgreA5TUWwljs2FSTGlhzx+nJSNG3e2a9YDgv86iZ2w25HPZGUDIJvhLBAJPYCeb+XmTku
 6pMry/dGe44nnHbhh4+P9tIkWb4npz+S3cu91X1s=
X-Gm-Gg: AYBFou1/SItHxyXjdxLryd5ADyRKjCZUvOK5Dqu2QSf4qNr5emMf+JZK26+ncfsXF3n
 LZfPcVImgA9gyjUTZsFrypvHZUo1mS15HB9IUC4IlNsOCIGLu7PEC+SdwMdNL5hJACA3o19Yrm+
 xJ6MZfsUmI65oEGyeTmyUjTyMKDNPLjEL5APojDdH2fA0vXAM96SYAkkAZKT7+QCxZngGy/37S4
 mvzVVLsvCH2QUsRF6VT/UN+dreKZRcYhb/q64hqh48OdX3Mcxd+3lO63rCvfa2pP958dzYOD2Sa
 bZOv9fX8G4+Xz+OELoB7tBFr7bx7kaUJdYHrx49oU3n0TqOWzcrJHtXnUlmE/LnJXwHQ6Fs3JKf
 AuvpIazsyuvkjAa8=
X-Received: by 2002:a05:690c:6885:b0:8a9:d345:1c59 with SMTP id
 00721157ae682-8b07edf81dbmr1598227b3.44.1791511646398; Thu, 08 Oct 2026
 19:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260826113515.137299-1-jayaramudu.desapogu@amd.com>
 <20261008135024.13784-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20261008135024.13784-1-jayaramudu.desapogu@amd.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 9 Oct 2026 10:07:14 +0800
X-Gm-Features: AclHuK-PTsaYfSHriGaj5CsIvMQwGeM7rrY2QAygc4Ui_S07MBGY5ItoxULrUiU
Message-ID: <CAEUhbmUw5MeQ=mmqg3FxHrO-o=46oG4eUu4H-T3bSHs1G9fX9A@mail.gmail.com>
Subject: Re: [PATCH v5] x86: cpu: x86_64: Detect CPU vendor and device ID
 using cpuid
To: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
Cc: sjg@chromium.org, trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 8, 2026 at 9:51=E2=80=AFPM Desapogu Jayaramudu
<jayaramudu.desapogu@amd.com> wrote:
>
> When U-Boot is configured as a coreboot payload on x86_64, the current
> code leaves the CPU identity at the default Intel vendor and device ID
> 0x0, even on non-Intel platforms.
>
> Read CPUID leaf 0 and build the 12-byte vendor string from EBX:EDX:ECX
> to identify the CPU vendor at runtime. Set gd->arch.x86_vendor to Intel/A=
MD
> when matched, with fallback to X86_VENDOR_ANY for unknown vendors. Also
> store cpuid_eax(1) in gd->arch.x86_device so later x86 code can use the
> detected CPU identity.
>
> This avoids relying on a fixed vendor value and keeps vendor-sensitive
> paths (e.g. TSC calibration) aligned with the actual CPU.
>
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
> ---
> Changes in v5:
> - updated comments in arch/x86/include/asm/u-boot-x86.h
> - leaving the function x86_cpu_init_f() as it was.
>
>  arch/x86/cpu/Makefile             |  1 +
>  arch/x86/cpu/i386/cpu.c           | 51 ++----------------------------
>  arch/x86/cpu/vendor.c             | 52 +++++++++++++++++++++++++++++++
>  arch/x86/cpu/x86_64/cpu.c         | 24 ++++++++++++--
>  arch/x86/include/asm/u-boot-x86.h | 16 ++++++++++
>  5 files changed, 92 insertions(+), 52 deletions(-)
>  create mode 100644 arch/x86/cpu/vendor.c
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>
