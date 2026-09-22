Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08BEC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 11:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 737BE6077D;
	Tue, 22 Sep 2026 11:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNuCp4Xom_T5; Tue, 22 Sep 2026 11:36:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C7446076F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790076972;
	b=g2hUOTkNVlbNTZYen2XElQt/+Va80V9GL8inep/ZRKWC/QZvDRGUtZ/nItvNNX1z8htO
	 xznyor77AL6js2A5yqCQJl4WMi3zfnm2r3jfeoURL5ZN33qMIMEAZEeaTFivtSUNiEToi
	 Z/qjLZ8phaXgeNCGd44arWkKeIhLwKpB5scaVmYquaohReNBIRA9W5F/yCHaMU20mvn1j
	 GBYRi+x2+GWBpu8oN1CC77ncBLnzzHNYREfxutXFFWvULZQ038mlQL6U1SZkhdHy9k9zz
	 bab5GlL3LgUKIXtJdmXiPtFED2+CjiBb3uMAzannJ3Y/lX6Iw2aZBfffzFQhb9O5ljw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790076972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=e9A2+K8Kgqjym9rkevRh0R7DvBivxXLCmLJIxzcbEf4=;
	b=DpspMBW2uLUXxNaD0vvtqesYCfpe7m5yzTv9UQ4v5o5ebbQD9dtuQYcNGzbvWt49yMp/
	 cw5++HyuDwKMzx5U7g97139epmmgZ4XPw0cvnwxoUNKB0cYmTc4szKiR8q04oO+dfk7pG
	 5uX0M1jdkU+iRwrnDt0YCiMMyODZok4gJeFDccYWhURXtru+dSuW4Hq+WfJz/MTruQg4e
	 PzShaCC0pFv5R5sRDe+bJJfN9GhPvrH6krwInrJ7iSnOBLgqgC58ihj5xrTnGiNsiH0hR
	 A9hZy8WWV/aquo08PeeliPC1k1KO772cYUV2sTPtcwYVbQOsMoxKXd9+GdVw7uZNh3g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lF1NxW8D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790076972;
	bh=e9A2+K8Kgqjym9rkevRh0R7DvBivxXLCmLJIxzcbEf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dAm948/L/SR6E4tzsAmyc8usA2u/IC7hKthkU0IAqeN76g1JTR9wkoqY1XC2ub7Kv
	 mEWOJt1zE2pRzdQwIbAORe14qp/S6rS00UglKIC1voNDED5agjSLgNrWpZwPcCaCqq
	 YS1LZlsbtLfK80WqkTtZ8PznNno6tQKEhM3cA4QNP2NS6JDIdt9QUdeSptlMsmjGAV
	 WOwOe1p5CtPRM8iUDe636gWN8lJCZMq1BOYApZeICs+uBV43wEpWG+OuFaWqykImV/
	 D3gohQ5DtzyZ5p5CDdlEK3Tl5tLot8BSNLQn62jIyCgYDr2ol1PdLqp+GQ6hFZkejo
	 Ug04ln7D9IXwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C7446076F;
	Tue, 22 Sep 2026 11:36:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0AE7A20
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 11:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9241A6076D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 11:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xz0LP1fDRETN for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 11:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 469486077D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790076969;
 b=U3CUXHvjyKaEUYmidxUdgrrLTOKuzyFFDHzar4nyi2F/WimN94fzjVu2/Oq3VP3eDBMe
 jmsBMWALhV6rVBJpDIrJqhDKyc973R8mUihP2ThWfHAolq+FMLy+r7umUXFhpEYUmlTXq
 nYnMtQeFrQOESb3z2f1VOfWXleS30ljbpYbHc5bOGZBCfOVF7brvSrjAFyTMBBkwXKGh8
 xBNAZ7ZrEOg2Uy8SSoJLBhU7/fsjJOv21O3NiPtshPzt7upCwuhoL/qJvh/G9u2IxIkPi
 rg5hAyYv8rxThltDWDqJ6GbtRy6rTJ23EBbIdEOiubM+z9RxJzmfQ10Z14VQuxG96XQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790076969;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=e9A2+K8Kgqjym9rkevRh0R7DvBivxXLCmLJIxzcbEf4=;
 b=IiONfSq0MW19CLQ6mhag5GRLChRjm2DIvNGf3wJGzcX2Gr21i1SPenZW1+jMwINpTstd
 RLmbP/VN1tREqQ5/ObyBBUCW4vuKmehy0BEoimt7+iKtlxiZV5BBL5va5mFwM+TdwEEH7
 yqSIPvfY/35BOvko0IsKoRSMbKsslU/9c9gMh89pv1pNqH/VuQZH/av4VRDCQfFE4k09k
 db677ZmJ36cA2kGSgF3Br6flgPMN7f0HAdrn7RMWQ6qGMh4jaJuP4vHGZ5uvlMGGjpaWO
 5L6a8TTaRtyzb+wxPz1pvFzJ/eXx1B7DEyKBqHaUePnG7LoIyaQBD6o3pFpPbEcv1Fw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lF1NxW8D; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lF1NxW8D
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 469486077D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 11:36:08 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f6c7a56so476061966b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 04:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790076967; cv=none;
 d=google.com; s=arc-20260327;
 b=B8YIOSdYhrJ49C5CWEP1Ad8GY73QjA0ikrUFO2oRd5K3sanamHcBMAlU9Sb0tf04e0
 V1NtNK+jyrkt8uyqX5W4Nem/B1v8RwZS33nDiaiZ1EY5fsgIPMM+oTN3ZvwuWdhQrtHT
 R9qVW0/X0ygah/hw3UCaFd6gvnsWTvT/CZtq1zExvzHaaV4vRMzoMT21/pr2JyjpQwLf
 nqSk5b+tdA+z0M8MjhZic7PqCGA+jciloKF3JhC1C54Owt6BaItsimHqv26svJvh8i4Z
 sddXLSU5huLknM8NEw8aJxrtTuU7hIGuCmG3L3R1UoJnmuCCdEGsGhxuTvaLFWtV4W7F
 tqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e9A2+K8Kgqjym9rkevRh0R7DvBivxXLCmLJIxzcbEf4=;
 fh=rfC24J2KkvHtz3yRq4dAGLMWmkbp0hYVluQ0/1T0kuY=;
 b=R8ZVpwT+JxoL0MpM/hADLU0WSAPaGjvO4l/4Y9v2pgldDLJzM8lZxDPrg6euRHQsz4
 VZdgyAltl5CcZQ/3Q+zu3nx1V6YjpF3Pgmx4ZX15u+pDHS3UpDqRVgxJhnnBFe2yIkpe
 piimkZ4V13FvlmsfAju3+/wRXMnq8++7pcRoS9zHPE5AzZSRbt8dqPkZfv8Ga1ZVCmZ9
 4Zu3vhqDzs+3umBkJzVpwwYqxs0d0jJeNEQOtO1r09yjJ+AaJ69rSFEe6cv+2ASv25AB
 O+MWcQ9iWmpDdJxmbc9ZNuSdJx6y/pfZK80zzqZifkRz7mtXfDbc9mCKcuaxBXQk38jX
 6xMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790076967; x=1790681767;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e9A2+K8Kgqjym9rkevRh0R7DvBivxXLCmLJIxzcbEf4=;
 b=lF1NxW8DpkqCxqpEpokfvXauI4eJ0xSFRummF9I4XfuFCaiTiwSQ+aovFerZhhK2qs
 1Fy2vyWMXR3pzxUn8aqtJ+3ylB51nXOj7xdwpFdNyPoc4NkTsiG0nt8Ut8Ux1FT6E2wd
 mm/WwhShrHvy3+znSNHQ7RsGyHBlW2kPBmybQVTrC36TVBBj3h6fEBf6iYRU+UqyDS/a
 YJkqPzxJelLeNNLj0VF70wgSCb6zb0WQWCdKdWZBik0UEQak5bDHOrNE5I1cDIFjsVUF
 aDUgYoiZETa5p97ncR0oQEm65dEWXeHU/r/KaKySVMzyg8R8ZM04RG7zug7KBDTF9OWA
 wO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790076967; x=1790681767;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e9A2+K8Kgqjym9rkevRh0R7DvBivxXLCmLJIxzcbEf4=;
 b=0+ik39nQxr+yVelWGCAnMEfea87V/tg3Zyczj7K5xp0b3uK+j3X/0cwkCZuzw+3arI
 wW3PYBr0ikGST40TD2bWmv/Ed/D5fZO9piJQ3NfVLz6d+JDtYyFXxG2jqtD3l5gmJPhV
 FimyWznMWteKpOgtAAAdadGbZUQEU1OWEWC9lSRBYho9CCqLQQsJtLay13lXtF59J13A
 27udOpXAPsf2+NS9gDxdhxTfo0DRBCnMg8O5QsoKPR1YKF/Q4AtzIBth0QFJqkb+lhUP
 Gv23avxPtBIFeNd+6ElVMyLB1BHgg6fbCUt1jwQmlTzVdoL8EgAb5yQCgu3xQC3cIuST
 +LdA==
X-Forwarded-Encrypted: i=1;
 AKwUvByNoJvFOclr5PrHyO5O/JDp+vK8PrtTEoGUqcj+Fdid4WE8ckPItBpYrR855BmtKS9PxDVIYw0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kJISUCwb0KwqF0M/n5AZhDhQ9bFn/r2r1nSXpekEGUncUlqUPY
 3LoVaLu2UFrQWzPVWyQ5EonvDdLkEq9ot2Nj4WUCBv1xjs1nXen2f0DZeMtdLP0cig4Xhj07R+I
 G5ucrm6D4bc4jS0pC1fdqJogqJwzUVYc=
X-Gm-Gg: AYBFou2n1uKxaCm36ESYM77XEG5q/eMiitvexSwN054vugPb/G/nmQKhiIKkyI8gybK
 dfX10lQXhIf+wd0Wak4vfv8Z7N7nXIQyK7Dvk9W90f0I0p3o4hFF6h4yDbce0JBokMa26xl/yn4
 nILeA4C+Frh8iKJuzZ5/D2OXkR6r8Jnete/6NsVsLTwiBOc/Bly8OW+6fH8e4Pq6JeB+noPhuxS
 LUOWxlvFTmsuVQNt7aSeifx+sKtPy+kVLOCg4Sb91aCejxxbALjUKyOX5zwDmmfHghRjLgwlEE4
 YsGrAsIbHgaJtMZ/ZpCqmICueYbtT2VMFE5cLm8Fvd/nHp8v0YTtHyJW
X-Received: by 2002:a17:906:f585:b0:c29:183c:a5f with SMTP id
 a640c23a62f3a-c2a15788ee3mr1075516666b.5.1790076966474; Tue, 22 Sep 2026
 04:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260920161930.1880133-1-jonas@kwiboo.se>
In-Reply-To: <20260920161930.1880133-1-jonas@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 22 Sep 2026 13:35:55 +0200
X-Gm-Features: AcwNN1XT_NIlnrYjzxG4z7PbMcWHU2cK5h9XeOU19Vitq77LziTNTRFXUYp_Hnw
Message-ID: <CAC928Hb3HdGURxLFhxocpQAWGVB2morvpLP=GEsRs_w1iE0oig@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
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

Hi Jonas,

Il giorno dom 20 set 2026 alle ore 18:19 Jonas Karlman
<jonas@kwiboo.se> ha scritto:
>
> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>
> SRAM addressing only seems to use 14 bits, meaning that reading from
> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
>
> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> reserved region for its global data, malloc area and runtime stack.
>
> TPL on PX30/RK3326 does not have any use for the malloc area, the
> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
>
> Current memory layout possibly looks something like:
>
>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>       [..., 0xff0e08c0)                       stack area
>         [0xff0e08c0]                           stack pointer
>       [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
>       [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
>     [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>       [0xff0e1000, 0xff0e3800)      10 KiB    code
>       [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>
> TPL currently does not touch the malloc area, instead the reserved
> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
> the TPL stack addresses deeper into the BootROM reserved area.
>
> Using current offsets for global data and stack does not seem to cause
> any known issue for BootROM after TPL returns to BootROM to load SPL
> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
> could theoretically change this and cause issues for BootROM.

Here with "any change to [...] code" I suppose you mean any change of global
data and/or BSS sizes, correct? As code size itself is checked against
TPL_MAX_SIZE at build time. Regarding build time checks, I have a couple
of doubts about [1]:
- shouldn't we check for less than or equal against TPL_MAX_SIZE, instead of
  strictly less than?
- shouldn't be more correct to check the TPL "footprint" size against the 10
  (or 11 or 12) KiB limit, instead only the code size?

With the new layout the check should be:
code size + BSS + GD_SIZE + TPL_SYS_MALLOC_F_LEN + <min_stack> <= 12 KiB

[1] https://github.com/u-boot/u-boot/blob/main/arch/arm/mach-rockchip/u-boot-tpl-v8.lds

>
> Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
> to 0x200 to avoid overflowing global data, malloc area and stack into
> the BootROM reserved region.

The new layout is certainly safer, but I wonder if we are losing the
opportunity for TPL to have approximately 2 extra KiB as they are not used by
BootROM once TPL returns to it. I mean, it would be useful to know where
initial values of TPL_STACK and TPL_SYS_MALLOC_F_LEN came from, and the
rationales behind them. If Rockchip were to assure that preserving only the
first 2 KiB of SRAM is enough for SPL loading, keeping these 2 extra KiB on
the radar could be useful for future TPL development and/or maintenance.

Regards,
Massimo

>
> With these changes the memory layout looks something like:
>
>   [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>     [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>     [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>       [0xff0e1000, 0xff0e3800)      10 KiB    code
>       [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>       [0xff0e3848, 0xff0e3cd0)    1160 bytes  stack area
>         [0xff0e3cd0]                           stack pointer
>       [0xff0e3cd0, 0xff0e3e00)     304 bytes  global data
>       [0xff0e3e00, 0xff0e4000)     512 bytes  malloc area (unused)
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> The overflow/wrapping was runtime validated on a RK3326 ODROID-GO Super
> by printing out content of [0xff0e0000, 0xff0e5000] and comparing the
> initial 4 KiB with the 16-20 KiB and the data matched 1:1.
>
> Changes in v3:
> - Drop TPL_MAX_SIZE change
> - Keep a small 512 byte malloc area
> - Update commit message to reflect changes
>
> Changes in v2:
> - Mention BSS in commit message
> - Update spelling in commit message
> - Collect r-b tag
> ---
>  arch/arm/mach-rockchip/px30/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
> index adba1b49a52b..0088d436d36f 100644
> --- a/arch/arm/mach-rockchip/px30/Kconfig
> +++ b/arch/arm/mach-rockchip/px30/Kconfig
> @@ -81,10 +81,10 @@ config TPL_TEXT_BASE
>         default 0xff0e1000
>
>  config TPL_STACK
> -       default 0xff0e4fff
> +       default 0xff0e4000
>
>  config TPL_SYS_MALLOC_F_LEN
> -       default 0x600
> +       default 0x200
>
>  config DEBUG_UART_CHANNEL
>         int "Mux channel to use for debug UART2/UART3"
> --
> 2.55.0
>
