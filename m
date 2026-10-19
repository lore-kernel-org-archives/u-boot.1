Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1746ECCF2E4
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAD9940557;
	Mon, 19 Oct 2026 11:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Se-1UpBy6KMT; Mon, 19 Oct 2026 11:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34A6240550
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408750;
	b=VeJbwGQ/6bRkeuCn+G+Q9iskhxQl72KYvy3FV7gau5RVvZMu0PmU43ZKCYjySj11VB+M
	 uPrB642pGfpthIDrwZfQ7Gxy2cM7o76BzOIutA5Zq74Zszumn41DFXFL3L3D+L7Ws2LM8
	 fqRok7CQYGLJcr4GPR1aX2w3vn3y/ncTkPJ4nzp7PIhoREzVCVkl4Nr+dkxG6ery9uUD9
	 ej81tjQU7Z9gJQq2405BAhh0tOCaV6K3wES8C36eEOaCshuvnRLx/8bSuwENShwrkMCQM
	 DQMUC3O7lltDAI1lQxV5LC5BcEhZNnNXyehkOtiiDBzMd2cQwkFpru6dTX4tkB6C26A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792408750;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 from:In-Reply-To:References:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XG6o51yV+olrZHD/2noXlLHufZIjGIA5uXIQ/Jd1IJo=;
	b=oVBjECByfR29Y5+EqJs6kLBGBzeJkO5dv8eF8T1j/9U3qQUAN79MtAxb72W6YKch6egh
	 6d9CQsnLB2NS/AXU86FaQLh/1lBxhIcLAIUHzDnnZSSb3toIUSMjWA6WpsLYgHUFRIuw0
	 wygfTyNpu6xEwvmZnUg5QTdfkxgzwXT4Xm6aWgBuykEFV9SQyC/vTf3YMeuTFgKelAXVb
	 HxULsVhiMNo0qf846fZiPxpVnCWiFJ0RfhMadsWBwTaE5cUT67Cno6UyP4rWwoA97hwKV
	 xm3G3j5s8hVJAJzkbUNjiaY+IO1TdHQ8Bo6b6dYpuPqXbxZziCESgpoP8Bxykf22K2w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792408750;
	bh=XG6o51yV+olrZHD/2noXlLHufZIjGIA5uXIQ/Jd1IJo=;
	h=from:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i2FSpdsVPK2jeUdR8oCX9IjKeVWj/mjMzixD6lCRYtGtaldmOdrkCS2xLkmvb7J8j
	 nugYh3Km1kZEljnOAH9a1xD+HlDJIms8VHFV3GHG44CzLBJQb42D+UZI/TooR5WYhM
	 5m0fcJ+VIW6P6Kj2LwE9OGNuh8gz54X23MOlqpp1M/ISKbPFB+3/7WF8yKb+gQlA4v
	 nBv2os3dytbPkG7OAfrVVFxpSmRN+mgQm+3vs3YR49ANk4nkk5bU/BWDBkOSlCnPG1
	 ntBFHkvI6jpN8+CBqxMegzi7+0dLAm8XpYOL1Ppo2MDyHj5Hdj/tLLlH/EP1KX1GkP
	 KR1TJY4g033Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34A6240550;
	Mon, 19 Oct 2026 11:19:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 024E41DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 000F040080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 70WoqjvBBrLA for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:19:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E94C540079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792408748;
 b=pFbMM//tXdNA1MSKkOZTNcEevMyO7hPiQfF9M0RGnR2NosdGajhAskMegJCT4VAJitLO
 brnHrUI+hB7ZjtS595eXT8yGekBW42kP0d7TdFECqRBMiViN3a5G3BakfQUTv6eJxKJAD
 Gd5YSKmMq9oicKFDms+LRH81igMpK+xzpAiz362fvKpaCR+dnFQbSViZnKklzD03IN1wG
 WZ2vPNVtYOt29lh4GDIY2e5HzC5CfNYP+YNeQRluIlo7AM6Pqrh07Qib+wMWfS+nGhAEh
 5heM+aAePN4VqjZSqPiCF02L2Ml6kjwMabHqDh8pAfrzegUaHnHzQEvyawkVuxKCabw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792408748;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:from:In-Reply-To:References:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XG6o51yV+olrZHD/2noXlLHufZIjGIA5uXIQ/Jd1IJo=;
 b=TdoxAnuybaGgjI9FGAPWN2nzD2XXH90sqDHzSE21LqqSn55GnHcwWYwN9QabRAJlUswV
 sdcfVryQDYoUjc8+DzVyRXUZL3C7CJdg1zwBKPRBIMWCxBPi2Inc49odw5uB1w3Rd9P0L
 y76b9Y3MzOLjO1HbtAMZDvoVsnE/w9vr1CGgcMkFfNIPtf7xIShkzCyvhri4vW+JFr/4P
 0FgrKBrpYOPeUa2pZlW3FExp15PHAboVCXiXbJSnedJfSPI/KbAq5P7mihHuBleESNO6t
 t8LJAmFF/hdf04XSgSMl2sqUqCFY6t1LBs4hU/YJLCWVWhpEtEpeu0slxpk3ICNoY1w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cr2qlj86; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cr2qlj86
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E94C540079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:07 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so2856816a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 04:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792408745; cv=none;
 d=google.com; s=arc-20260327;
 b=FJvDVdZpuB+ftxU8yFURPz7Nzb1r7cdUJ0vYGd50rSxV2qlyV1RzrzB4KnQPRMZ2gN
 5nfE20vzP+9Sygn5tnNwln+aXHeJFRptNbl6En1s7SVK639m8PYFgNaqJE4s4lTiNnN4
 MxkEcv0P3M3ok0bioqHHAzZPPYm3B5K/wB/9FL470rYnBq6rcj6/TcL84OAbfJpAjuhN
 E27gPvpOWIFb34f+Z4ANuD9zSNNOvgukgKnABLFs4yEOeo4pEvRHek2JAVm6e+OviyEq
 W+KxdsfD7ayqSZK9wvDJJFYkteptFiZxqFc/noLfU274AfYn1B27xKUQ2cyUommUI01a
 IdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=XG6o51yV+olrZHD/2noXlLHufZIjGIA5uXIQ/Jd1IJo=;
 fh=p5BVafuyG6HA65BXHRbIKQCDKZWy1V8mplSFVMKE0EQ=;
 b=gsfTyBAFt9gW5SjHrRAPkn9IhvoFdvOgN9lj4BMdaClBi/jAsw+JAyu71jHlJdMsSm
 xM0QM1nKt+xapWHEazp8tbUDzYkiVxnCcnzbX46NxWL+0yYkImXSKfAcPLyS3KPSLwcH
 xV2x9eL20RiBz8X5IOI8QxSyvd9ApKfjyGLv/FLz+UtQ9qaS10W0TnFTen6DujtDXJPn
 P9fqZDkJBV+yMjqxAWCPuLGuzpvFfUv794PFmLpa3fH0tWt0I+uNqrxjEw3MtJoHHN0a
 Fij8XgAw7SvHna0ysko2lkXzH9yC0kpgEk5I35LZOsx8FE41vrz96IA+nsC2HKjW+xHJ
 NDuw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792408745; x=1793013545;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XG6o51yV+olrZHD/2noXlLHufZIjGIA5uXIQ/Jd1IJo=;
 b=cr2qlj863AmR8LZSpflJFGFcPKWG0MjdZoXN6g+9KnH70q1hkADakCjFgDkg8uvvoj
 d87vDp5X9ENsQk+kGBkZ9aK10tcCGYwowndBW2Jlytaaz8+NvNYjXGIwWrrP71afAoeZ
 f/k5OQfqZek2/Vs30snfDCrB+76+j50lOPKQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792408745; x=1793013545;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XG6o51yV+olrZHD/2noXlLHufZIjGIA5uXIQ/Jd1IJo=;
 b=edS2CKxJtzWw0Y6XjY4yD+oSO/7pGgApz7aC8cuQItKkYzeWOY8YZ+uQRY6WqujgwY
 TkEkdj96VdytVnNwgLmVP06qhCCj6QO8n1qRrlxdP+6tf1oWgEZHk/JRdxrftnApIomW
 TDueImtep+ySbtEAjRDOVzyRatWt6BWtedLwpFmZUAo78bSmHlP29fP41rnSuN7FHigr
 i3nEavLI382R8q493aENJ8SDZ4unp8rV5Bc9o7KJNFvvV56/IwyT52a4usaTsjAndRb3
 thRZyGMa5mm0ZF2XuGN1f3TvpDhtHQn5N1r7+2Vz5ivVGYDmunb7Ro8STKDyXHYL0o82
 R9uw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpMg9ge1r8L/pmjBWUW4MO5l/amaM/cCP/Hl3LLPUVrpvsAjy7Ht2qT/qUjhepYiciu8Bx3DA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJSM6UITdyWJwoa7O7z97fR8bpOA1Kclv5o6B4lTU/fsC5KeSVF
 4a24Xfd3+dfnPASXHSuoImuiH2PH/2WzBlu7V2lcHbGe6VVeOHhNP5FBnIAVFBbpPw85K1e63/h
 dhy9v/5/ZzDqhpBfnvfqpDNxwXlDg1Cu1xrkMgn+p
X-Gm-Gg: AYBFou0Iac1f/gzDJbaRUy/XWEBufHEfz9/LxQnEC+/Zg82ke09Z49UiLaBcV2Eh8Kz
 +hREbceQ7Bza4paV8N69gTUf3cJg+FESByhCvx5hrkAiWWrBYW7vCmgQNH9hUqtJ3yuT9T5beQv
 F2nwCNVJy1mbyEZe6UGfs2ls4xRURCBHnAgvLdifWEa+KA7JVuFUiUcDBrUm2ObJEtR7pKYPt7E
 ZMVtiEFA2SjOXFA38j1zBcFryjnB3zfYQMk4uG3W6qcyaCEtGqHDNGVMvGlZx/1zvDLFggLjW7M
 1BMxGRNWgKq1+2tRfjqVt1HGAz78aFSpx8hJxBW8ra7cVm3RQaiyAg==
X-Received: by 2002:a05:6402:4516:b0:6b1:ced2:dfd4 with SMTP id
 4fb4d7f45d1cf-6b3a818f754mr4766897a12.21.1792408745241; Mon, 19 Oct 2026
 04:19:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 13:19:02 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:19:01 -0700
MIME-Version: 1.0
from: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAKTNdwF9+bGYArwyFUfP52DjaZRQJJFEbrinXasLjNFNMkjNyA@mail.gmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <CAKTNdwF9+bGYArwyFUfP52DjaZRQJJFEbrinXasLjNFNMkjNyA@mail.gmail.com>
Date: Mon, 19 Oct 2026 13:19:02 +0200
X-Gm-Features: AclHuK-8fdriT4OWzBQDnDZQwuS1gWUFXeUEZOkjxZIlb6ElMmvnnIVV9ACw9Po
Message-ID: <CAFLszTiYjyrchz5z2-67nmeHMH-c7DSgwLB+nZi7PEeOyHA2NA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] binman: fit: Compress generated fdt images and use
 it on Rockchip
To: Alexey Charkov <alchark@flipper.net>
Cc: petr.hodina@protonmail.com, u-boot@lists.u-boot-project.org, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>
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

Hi Alexey,

On 2026-10-19T09:31:24, Alexey Charkov <alchark@flipper.net> wrote:

> We currently use 'compress' (without the "fit," prefix) for the U-Boot
> binary. Having multiple spellings for a semantically similar property
> sounds confusing.

The 'fit,' prefix is the established convention in Entry_fit for
properties that control FIT generation (fit,fdt-list, fit,operation,
fit,align, fit,sign, fit,encrypt, fit,engine, ...). The plain
'compress' property acts on an entry's own data at the binman level
and pairs with uncomp-size tracking, whereas here we are telling the
FIT generator to compress the embedded fdt subimage and emit a
matching 'compression' property in the FIT itself. So the two really
are different operations and keeping the 'fit,' prefix fits the
surrounding code. I think that is the right call.

Regards,
Simon
