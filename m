Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CBE606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TjhRY012;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zyj7G0bv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2BA0606C2;
	Tue,  3 Nov 2026 16:32:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elCxyNkcH934; Tue,  3 Nov 2026 16:32:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10EFE606BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793723572;
	b=H1cFvNNhiqdwiec0af7gx6tDY5PwUgoqBhaf++3T0LSF4Xi20nk4gJrH5EWHGhiihYFf
	 Im+lO1S0+Yu83/xoaPj+848wjOAnEZqM1lbOyu/9FTcrp779wMAGxpW0rDjeQyp1N0OyH
	 846lLY1uxLcjDYLFUwPotKyW68Sbbu1aT6rL4T/mvW3JXfH2LUoaGYQCsxttD9EZ+iQgM
	 k73SZkSZYFZ7TqIbGvc7CnZthWaDRCPBueccmYhumFPyMSQWWLELXO+PECSZ1A6tpW1n+
	 my2XPoplGWIvcskAK2M99Yq4X+nlmpDrPQtvoyULN2t1O9sMzvvHoOOTG6kyTXLT59g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cSjvDLi4wZC1V2KWoDoD3fiLEasfrGWPRf+wSIsgtxw=;
	b=ggKRXJKddcuT6Q3SAlvNxLil6BZg7L/jnRgFmyBs0dNGTTFVhMon4aKwrsl74nxTDHoP
	 D+C9wPmtoPy1lQGQCxjeDYoKXe3VcSl1i8mFpxonLn5f5oUBre+dkr/31pOXU3HSlIg7M
	 EJP23Q0DqaaD1MbBOsEEg647K2ZTqnDr5iKSQiVIDklXi8sYibumPe1vBqTfJKDI6nR5j
	 i29h9JvTPyDOpdNUh5vgHF8TBzbQJ2Po74VQ/cVq3jrjawTuZJFeoql89a3nRFSBIiknM
	 lmLX2EWS7nErKgNY2pdA2rzgT6tAdMXqfndyU1RiULHRm7/BrRqY4U9ZTI7SfNIGXGg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793723572;
	bh=cSjvDLi4wZC1V2KWoDoD3fiLEasfrGWPRf+wSIsgtxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TjhRY012kctcOpL6+PMIwy4UYp8bnsrMEsakRAeTjUrDyc5ROliwqv5ktiCEZNuUy
	 gAU3APyRyFRYsdp09JYHJhYvRhXmL9feZacCwS0Cn5IjC6VyvF5YIMZCVhfjrbmGCi
	 4hf9s7Iszhm7hQYKceighq94I3pvk/oqCk08cnFFHKKX9qfOIDrtYeoZQjvhDOA5N0
	 gY6KAtTPWCqjeTyRqSsfbVpxO0QSWWK2vI3D79eOBKn7WIVgqKDDnNsaPHKu6jkuJN
	 WWY7C6opmiDGS5tmBU7OD9Rm4TIBY3CLrs0mfEX2eTvqSXpHxkrFI6d2pHAyj/8vmu
	 nod8UUbuoceug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10EFE606BD;
	Tue,  3 Nov 2026 16:32:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 137B3A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED69480FA9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6rtZuGLH1uLc for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D003280F4D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::229"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720373;
 b=W43O6gBU6iLpXM9/h9i0Ms/H4kcF1cSUO6YdqXxCLGFHLvTYPs4O7uKbe3bnNgToA8xf
 /nJPLOwn55yWCoA8M3IfPaeU8sdVNSEZMgGto9tkGa32QjF39mzKayEi93PXKQppfXWfN
 7N/BDvqBhOiOMaCX+ONdmhAbKgajeJaDLlwrIceEofJp0IAhsoMApAfIKilmtUmROqZB2
 EzHNTNmKJ59xrqXox0BKw7mgnParQk2+r667Hr3SBnyf+Q2Q9mOMCSO2kYOFTFeemwaWc
 Yf4dBHJzgBF0otW9Y9PHAECKw3RE/QFeIW9VKUA8PxNWDd5XLyZJkEdqAVSCAKMbGDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720373;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=cSjvDLi4wZC1V2KWoDoD3fiLEasfrGWPRf+wSIsgtxw=;
 b=a24pSHx4iYkqHF2aNeGtTsE4TiROlfkbk2KRGRUoQ+zQ2hLrp1zprTbwN39jhQYCEk8T
 0KFSISnNEHhs1RRPA4KGGDLAIpNo4CMGZ5z8nPMwy+IGGnwnC13xOV3uNOrbQ2iv+wQC9
 BX9uXvuBt9Bd2HgKGSgDUdr6WfwNS2yuJLnVMrAD7VmGcZ1DJB9lzmMt+VcDhthDllcbE
 VFN4Feh1Jocfbq5NBd8v6XjzTRfQQoRj9xSRIZ4vlmcrcmzBPwKw7mAmwuO2avgO6zL0z
 9w7sl/P+/1F8OHQjs2XBeJimR2exoXJKdE3amVd4aMUnVafdcVa9eAM01y0liIWITzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Zyj7G0bv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Zyj7G0bv
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D003280F4D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:39:31 +0000 (UTC)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3ab07d956f2so31083561fa.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:39:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793720369; cv=none;
 d=google.com; s=arc-20260327;
 b=cp58x398tDbO4rr0qmMJ+eDr4l+4VB36fcIe7y25GAM2R/Wihlh2W91cWFzB/tSNWf
 l0kM3dZh4CtxqpG+l25ITWTwfIdUkWJjZCaBwrniAcalmAI6+2BU97Lms6b+Ekro3dyt
 tiLDNl2BpY2yJAx/KS0VsFIuNPGIvUh26CrRmiO1mnf9tnAhNmZOq5oUbHMlpiT3uWhX
 Bs37a4zpAvrp24YBobiZ6Q7wdyPC74CEttlOb2gyddvLosHJcOhwOg7sqa9OmvVk9Kv5
 T3fLBvORptwClFOOp9v+IJP+ziH0k5GlkHhGsTpO28ln7Q14EWbkA+8Df5tU4biDvg+d
 3N5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cSjvDLi4wZC1V2KWoDoD3fiLEasfrGWPRf+wSIsgtxw=;
 fh=D9JRUk8c0ojuxpx5kARbFNhBT0LausUg99I1PPBM1oI=;
 b=fCIj63AON6MzJ7Rnh8L1+1ll500ns9qkeTst4hw7o14bAqgICLtirE9jR1Fffe5eMI
 ZGd8zN5uv+L1Nmsdi/rPtgWyT9xWWJigA5+riGK+2GInwBy2IdWO5zXnfcS1tFadAoRb
 CmeGoyc9krSmpdpAfcZ+PfcJIbGRYXdvno1opgjza9qnmTNi14kG4q1WIGNfbPAxyTew
 Mow0H9o5xxVPf7eDiT/IeQggNOEU/Rgy6KQUcOG8f18+qQ5JkKhubZy1CIzis5smRShC
 0exHLMI6n4Nr90lx7ANlWPFXmBjU9yeq9Ck4b6prOLCr1Ex76dMCobDZ6AqLDxpYQPJ3
 cBpA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793720369; x=1794325169;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cSjvDLi4wZC1V2KWoDoD3fiLEasfrGWPRf+wSIsgtxw=;
 b=Zyj7G0bvschv9STkpEeNziN8bM16uHCJZSnV/j1O974Al1543VoQU+auNUM1BDUgDQ
 ZU5yue2yH+0lv634GNcYJf7RKETFw/ddCjkeQtGVSYXNNfLin7yelhmwB6ug6PDh53cf
 2V24rWsHgZB7nygXouZh9RDWM1d4CvY33Ip1jPAPv7JoCCWVk4lv6vdkehNIyUTbPFi3
 VVwX8Gi4MmAFZxoifrhrWmNQxGchewOZEoHnNn9iS7Cq/5S/ApEFIFkd7bFCqOLv9BG9
 Leg6UqkSR3MbKjtOteZaSVHNWk/s5ctN7eQ+NokS6oUli3ctlQrYM2J6bGFCm9ny6yNL
 AAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720369; x=1794325169;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cSjvDLi4wZC1V2KWoDoD3fiLEasfrGWPRf+wSIsgtxw=;
 b=YcXdYp3U38eR7iT89IOwJkeGpbxiVMjuh3amct4Qvrzm2EXke+tpVb5LkLdZ6Oj3VY
 +mzwzSyFkCcbdmqBssh+H+NJ0nXPw3r4sO6JPfrlzltoHq2dfsV3Gl0ErkOlhBDbZ6+0
 /lm9ehYnPaofE21xWiP0ZwX96uQR/nt5qu5cjiC8mGLvstWaHGep7v/d/4j+VRW5NgFK
 nK8dqGzyVPspzjATRz8+D4m/3w+BQTk+NyADqMXEFnkOOl0tV6k5JCdw5iSX1VYWH55s
 qBsEhJ9XqyewyIJ8vWwt7vt2+e5e1VKVFRoFle9oyUTPEqH3QqH6NHvHFXtHSsIvQwBn
 5DHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBztQMcPKm/55pVsb0AU9fAXWmzyEWi6sDeOtbNs2+Yd91/ARFXacCPcrjVj8kjBu3Z8NOMYDuw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+iLfCGjSqWGH3Nd9RgpavMbaAzHvwmtQ4f7bUAwFTQTuKXVncf
 O44cFxrxCQ4orVxSR7uEG9DE20gXOQBiTtNGRW31OHtm3m2u+QjhcvZVD9dyhP7qb4+K75cFDmc
 RGvw7kaJkXCKBdLZNluMKiwQwJ45PoQQ=
X-Gm-Gg: AYBFou1kcQAXaasIWrc24VRVdeFaEg+x0DUHk+JFDqTa8jVMOd96pnIlK/sSrjVjx4T
 6ggZhFCnKcpm9q+nYR1ySRLGxB+lBGBLG7fLw7ZZYrJm9JAiFqvFBAB47xsQLfEFNDp8J3GKSOS
 mp/gHr6TGGFKVbIPHLQOviLwid2VYFPX2PFxaPOPUGtE+OHRfiooqvPJuyuaQV6zKXIxMGXzho8
 rlxrTDX6axlfsRu7Y8ycvA+8yVtNsx7pBF2YAqssHqlmdaCbgN4g7xB9DrHpJLwq6DEFoER5WOy
 GrH/nG7l4Tt7KjnKQH+lzg0ZtoLZuwqPbM89FAQjoawJaZEhxKOMZOALagCfzQEEQ7vwp+3bgCu
 NCI9ByFfjKYrzmHJPLU9EQyY1icjHKeosLpM3Mw==
X-Received: by 2002:a2e:a991:0:b0:3a9:d9db:61b0 with SMTP id
 38308e7fff4ca-3acb7b78cdemr30450121fa.24.1793720369034; Tue, 03 Nov 2026
 07:39:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102041038.369162-1-oss.patchbox@gmail.com>
 <8880f413-76df-42e2-8630-acc456e7f55c@gmx.de>
In-Reply-To: <8880f413-76df-42e2-8630-acc456e7f55c@gmx.de>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 3 Nov 2026 10:39:17 -0500
X-Gm-Features: AclHuK_wubRt4Q9UKQM460H8L8lhg9e_4wrfZX6LYMYCJerBYqhhoudimiKLz-4
Message-ID: <CAGG=RgDGzdaBGoyYva=Pa8iFcG1-22UJarTpbDi_3AizmRGSfg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: unload image on security violation in
 efi_run_image()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 03 Nov 2026 16:32:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 03:39, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Why would you only unload the image on a security violation and not on
> other errors inhibiting launching an image?

Thanks for the review! efi_run_image() also leaks the image when
efi_env_set_load_options() fails. I will send a v2 that unloads the
image on any error before it is started, unless you disagree.

Thanks,
Yuho
