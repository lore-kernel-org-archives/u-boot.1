Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C56CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 18:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 186D280F8D;
	Wed, 14 Oct 2026 18:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wY9plICuBhXE; Wed, 14 Oct 2026 18:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1106D80F77
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792002193;
	b=bC3NAytgEHoEYrzlybV8NmlpeMPWFgWwQzm9PePnkSWk9MzlsaXjf2IMaqXPsM7GcLIi
	 0AmBCzDKgwwcfWZgYt40orPLFUkWZylmLIb4W0U2QmBb5gxUCzGczJMmY5Br7jQ6t1LYx
	 zrniVNEbL96QlMFwer/tc1r+LMkDoDWXfXqHL9oOie31Tyi3jD4h8cAR3wJa1bmpzEldS
	 ktmfBwkXdn+I9BivLNq7t5F9GmPEMXpCrA5Ax7x3GH/2u1Yd0HOLwmo8IwBfcK9GrJIDN
	 qoVnZ0jG30IgJvTTHRLtiZGGic6jBFE4TJVsx0qkU2V8vJkR429+d8qKQzJq6DrYFgQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792002193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Op/ex99Rnu2y4VkEwj8412fI0IJJgwMkxG2ca44OhTg=;
	b=oyYaoH79ROPuNEfx4FSbWEL4LSSfSuhvOpwnM1HiuqUTkp4gqkVRdolwza3ItcJzA62i
	 rDEEPex7jZA/vksNNzvHk44RxjYjDQBIwRobyStZbsQLw9DUDuvdmMN4HG4Kh+idlorpD
	 8Edloy5UtI1R2ocOZHUh+b9yLVHDtT02kw6LiCe5+3qDzc0fIrwobVjmjD4v4uFpn6PG8
	 7Q8zDURNfrr5+S5A6kFyuEMgQ7Ur4W+gUd7sV6V6uyKIiGrVoyJYPKoCm7p+N+VJvMFf6
	 YeRwrTgxLzgbdTGVWlceiBsKid+eIvRvVT7uzae8UrpejHY4NV/rB6qGgzbwYw7tNRw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792002193;
	bh=Op/ex99Rnu2y4VkEwj8412fI0IJJgwMkxG2ca44OhTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QOFC414MbxEDux7z1wwvAfDoWxzQn1rQ8r1/tshVfjU+pcPHEAaf5XRAVMM28VEgS
	 ALZCK98NimsTpixfl/4kIwa2dvwuOJXBiO+HYNRwosYDrdOQZeyRvdRahg9Kn0Xiqd
	 BDWzmLu/hVW5FEHVUP5lcpw2+yUz5N1jQNPt3Fsfchk6s0TiXUmVCOH3cewzmRwjHb
	 S3/R8tlkrfPQRxSPIduQaTyoyiGh8tIu97zJiNy/1EETVlfT2j5pC5zkICrAN9Qq29
	 DwtygBRXRMbo1xZhT0/I1ogBtpGTJtm+JnO4ynE5tAPn4ZVPK5bH/fKzVdNfsraZgA
	 9RaRNeUqgVWpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1106D80F77;
	Wed, 14 Oct 2026 18:23:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1073A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6CEF407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6M1Bagx5ioE for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 85558407A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792002191;
 b=DTXXBKeWx5bZmitbPGrDEfws7WDM3nNw/4ntJhwKmz+2cikceWRzZvGT7fRI+8kS0QHz
 2UR0rKvMiGW52CmE79AoKc1l8EXHjS9c6rxv+AjSgNftqrKByM+y6cG8qhcx5v36ovup6
 Nejeb+QkmAd0vP4tFeDfJ3j7rQ5ltxGmBz2wSEZKqmfhbI0dOk6EhJumjsVe840qLbUWl
 RoZPjA+clP6MBpmoWrltyM4wg7Q4XVB51lIQ2l0DIWWsAaTo8kv7i64xPv/eV6/9ZR8k+
 A9QgijKJTsUwGIl2mMp4yFWlVbZUx/dw78JODAm7PVThAOr32lwxr4LYyqzzHLUHDxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002191;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Op/ex99Rnu2y4VkEwj8412fI0IJJgwMkxG2ca44OhTg=;
 b=dqkbY+kUikcMLjh+sAjhf6pF8pBz5XU5VQw+XyvGgZ/alzZLDSUO2U6N1Rnpvz5TTYLR
 6zny0VkSkfF6P8ASquSO6oYOwJvc7M3dGzFLygqC8OGYVNJam9Ac3wO29/gm9CaHhb/Ym
 7LBxzh1QRCDbg8MHQAFgcZqpe1rH3qR8ZXo/1Vcc5BCRISEZGhquG/At6/nPg+roxZQ07
 BongibVLnT+hnsX7YxFzEbD/ts+trekFDukRlyUZlS2k1rnIq9ohC1QDzQTjqAQEjFNTv
 v0Y/LmB5fwHZL7Uj8H3yFLqkhKzW1csQE9d5YYqigLu1Po5TDE+OJFyukmeA5B6QwLA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZCCXL8OB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZCCXL8OB
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85558407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:09 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2e7496f947so729592866b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792002188; cv=none;
 d=google.com; s=arc-20260327;
 b=S4q5dcyxbQX++tvVvSk4Av6Owbcw1CH6el05SDDkwD0QQVvkXkHcrxE2I/HCM9Ll2p
 FfDMujvWPDc1sJH2QeFcjI8odDr92WN83lOQaxXoEfF7hc2EQnPoAmaLu82S5yNkMp3I
 nfRnnSlaSa4P+rw61E+vTpvvT4SFPJD8dNPogcjFarYMNRcVtCYPR1bJISwgBFhsRpYh
 lrw033XIPOm9YLblcONu7c2RkN8AtBqwBvfDsB74LkY5Zcn65Gy3fQhUQXsDZnanlLnU
 e7nukotzFbB31ejOe9T5cMV0O4Lr7wtsQKMyMhuSQf4dCNqd+Z20sy1Y0J1LTJn0lsu4
 hoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Op/ex99Rnu2y4VkEwj8412fI0IJJgwMkxG2ca44OhTg=;
 fh=9/6TcA7U/8s8CzUeM3ejWl5X+OpKahskrOgPI1blGHk=;
 b=NUtEmiRfLEJ9BA6FWidmSoKhBz/CfTC+7jk4maVV0BIa5ouzyqhw5MEclsY3WjCxdu
 anJkcVlPLTd1n4tI59ETmVZA/M8FL/aDD6YhVocg7e3oaooifdqQXsJKzfpfpXhUM1kP
 799Km7sd9cwXpN4fm4a3R5QgAgI7rMKydxE0EHRY4YHQUdZf7aZlgXE++XcLGYCbHkfD
 S7WxucIDJ5TBzX0PutHsIKs0obLgbPocPCNerHL1vXGLmzjB9DS+EiJPtHqVQGs3gTtt
 eUnIL1wWc12enGVqF/fg6z8GmkhSkvVYX8H044AUuhzHKEQXZqYJamm3ca5vM/ibj50c
 65tQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792002188; x=1792606988;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Op/ex99Rnu2y4VkEwj8412fI0IJJgwMkxG2ca44OhTg=;
 b=ZCCXL8OBSXkfZa6tXbqar02MXjdklJH/YFHWgx4wbF63mNsXlkF0tj2ctuv+GgOFnD
 GsvbkdKVnpT0OqtZCRTZVMpvE9jUpy5gC3EIg0wIA+mzNnvB99vopXx5f0IYXsaOUEKM
 aAeoOYzOrU2X25nrvqMok2keCJQJXY+w28+SsfXjnH76RjfUF7TQs1bK1PUk/K9z5vv/
 0Ac9Ao+ZVGW8zmarfjGFdz5qh79j3UqFNVSJJdWGkmWg8Yb/cdKsnFwyl9HFtHBfw3Wp
 sl2mdsdES4Whpm2h1rP6sWbp7HY9ZWi+8HehAkf+18U0J48QoCxpb4RMx97VP6XbE8Nn
 4oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002188; x=1792606988;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Op/ex99Rnu2y4VkEwj8412fI0IJJgwMkxG2ca44OhTg=;
 b=O78IdhstoizZEClb5jNP6eeYCKcA98FU3sIH+lu3Q5WMPVTodZNsdovKTGVGS12dw5
 4ZdOUlNIdyIO5XXPbbKzon3lMtaLkqRCtGNJ2o4pSur0ebRW3biFd5VHlZGFnaRADGgy
 WjyJpVMgP788KAOWEJ63SOvbJya+/+o3kIiHTq/IQQ1GXvA677Rw9yJtUoESaEbqtxXS
 xB0WxhFr1AhIf1ObbTOv6tfW0zr/RQqQY0Oe3WyefVFlXS2UpHO7hnGZNG4gP60nvh3J
 Xw396OsSC0lUcl1Nox/svGqJGgBBEXn9TSOzrjFxP2a7RpyiuxC0XYKcZL1UY4snGrg3
 vuqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcYVzUI2mv07+rU4sYzlpF/vG7q64ZEkTExIdALciFcWcGQwBDsFxuAcS1z/IM2ZVM2KgAaGM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJWWqcTSh4wP4J7VF1ztGsWAntgs/b1MNQQifjHMt6FSKsTyJ9e
 cVrH1e6nz2KBqR2gTz81aWMRxz7MbishPuRBvpuEfQM7oNVimppE6d8QFYxNQsKZT8x5fVoSD4z
 eflF3eEc+44MLi02gvpZReUUyyyGboMc=
X-Gm-Gg: AYBFou27nCAkDg8R+swbG96ZZdhoee0jWsPTYR9355RIeAQDjYhU+PdpW2hvehxM+3m
 CL8dijO5PqsaHHPkpoMqnZTCuvJXGokkLCFtS/teC4n/sPVZg6yMj2eP1LNEvLx/fBXbwJ8oNNu
 vn8T4zCgx+tG56xe3bN94kaFvf0YxwQMaPZpnFvjvtzxdCNNu46oVRjl+KIKcyrUQLZusi2eIWX
 ehRFl4VBMIEBTeJeIRIGpVsma8673YWwzO15/TkQt/fNgHk3rEIh35lo90lnlki3L2notWNtbNd
 fPhURM2iMpP+9oGbj7AgEKgb0SSALq/+HnNOpHJhYeR0dxVGujYiiXOYQA==
X-Received: by 2002:a17:907:d27:b0:c2d:e548:3ac with SMTP id
 a640c23a62f3a-c31a9d2a1ebmr1572218066b.19.1792002187691; Wed, 14 Oct 2026
 11:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-3-11bb20983682@gmail.com>
 <888f4840-7c54-4b24-85a0-b3cb645a94bc@0leil.net>
In-Reply-To: <888f4840-7c54-4b24-85a0-b3cb645a94bc@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 14 Oct 2026 20:22:56 +0200
X-Gm-Features: AclHuK9nGlN_e-EMFqfr3m0wyAqdfhdq8W9UaP4bY954raOP1WkmAH-VCYSabWk
Message-ID: <CAC928HZwf5yv0MTp42sFtZoMyW+ug44PFyE6HWftHQJb+CXXPw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm: rockchip: Avoid BSS SPL config options when
 unneeded
To: Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>
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

Hi Quentin,

Il giorno mer 14 ott 2026 alle ore 18:25 Quentin Schulz
<u-boot@0leil.net> ha scritto:
>
> Hi Massimo,
>
> On 10/2/26 6:36 PM, Massimo Pegorer wrote:
> > The configuration options SPL_BSS_START_ADDR and SPL_BSS_MAX_SIZE are
> > guarded by SPL_HAS_BSS_LINKER_SECTION and SPL_BSS_LIMIT options in the
> > common/spl/Kconfig file where they are originally defined. Addition of
> > a second config statement without 'depends on' guard causes these two
> > options to be put in the configuration even when the guard is not
> > selected, which is unneeded and sounds wrong.
> >
>
> I'm sorry, I don't understand the issue. Can you clarify or provide a
> way to reproduce the issue? Multiple definitions of the same Kconfig
> symbol are "combined" as far as I know so this shouldn't be an issue.

The reasoning is almost the same I've tried to explain in [1]. Sorry if it
sounds like ancillary changes. But in this way qconfig tool is more effective
and helpful.

Thanks.
Massimo

[1] https://lore.kernel.org/all/CAC928HYUq6rijik177mTxMt7Khu8QBwywrt2H2f6CX8z1r0aVQ@mail.gmail.com/

>
> Cheers,
> Quentin
>
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   arch/arm/mach-rockchip/Kconfig | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> > index 1a2e7847c9e..5ed774159be 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -836,11 +836,13 @@ config SPL_HAS_BSS_LINKER_SECTION
> >       default y if ARM64
> >
> >   config SPL_BSS_START_ADDR
> > +     depends on SPL_HAS_BSS_LINKER_SECTION
> >       default 0x63f80000 if SPL_TEXT_BASE = 0x60000000
> >       default 0x43f80000 if SPL_TEXT_BASE = 0x40000000
> >       default 0x03f80000 if SPL_TEXT_BASE = 0x00000000
> >
> >   config SPL_BSS_MAX_SIZE
> > +     depends on SPL_BSS_LIMIT
> >       default 0x8000 if SPL_BSS_START_ADDR = 0x63f80000
> >       default 0x8000 if SPL_BSS_START_ADDR = 0x43f80000
> >       default 0x8000 if SPL_BSS_START_ADDR = 0x03f80000
> >
>
