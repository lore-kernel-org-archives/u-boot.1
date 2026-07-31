Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0257C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 06:29:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5683E80B22;
	Fri, 31 Jul 2026 06:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x97GW0RW4t8c; Fri, 31 Jul 2026 06:29:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45A5280B36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785479378;
	bh=5sO76E8o6g3DJUmU4u9wpVZDnSlakNeXbNK0qeaRmdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HYT4z6ouAw0GMzrj8ZN4FxnVpWLeyUxRRPexHsNluAeCK696vL/6ONfwqqVaGmbH/
	 g/opOjPZwu991rE7tGN216ImX8c3FTZ2pT1BmLg+XfTFTZ/IEQZ0Wp+9ue0xrSe6ZV
	 96ZVLD+4vM8CtSLXJkfUr3IMOfijpIZy3udFOxaqNKew97kDiwvV9whX2xUFuOR9Jy
	 eHMkz+bSTUaZQptaW21HL/KELO93v5WZiRgaCRMTveAcHLKE5YGVYgtAKgKsQzYs25
	 oRrpKUva+H/reaNXWunfg+wTVTWASFkStc1R6x3TeCHV1af6aDRx75DC34Drw4UJSr
	 TVI+pQ1rtSGSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45A5280B36;
	Fri, 31 Jul 2026 06:29:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7006069
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61D4C40EB9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:29:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Do0AxV-MspS7 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 06:29:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 29FC340EAD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29FC340EAD
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29FC340EAD
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 06:29:35 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso85141066b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 23:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785479373; cv=none;
 d=google.com; s=arc-20260327;
 b=AaOd2iv8xZFbXYX/iu0WcHd/yMRJQzrScDHrFGlMmAilH3q5zB9m4ubgDFdLGt+15P
 lc3QSoDT6uP9GITnZNqh1M/u9U7oUYZeEbLlcJ/B1zqyGxkmN406w3EFfsGJhqL12eLx
 PeCMcdJV73tX4uJxie+sVyLNFf+8WMDtr9Qj8SQORATfzqALhmaD8iMEHUebKpti/WDX
 dUfAJjrR1XIopdKv2i3intfqVkfuvEPc3JZk4qivzAWojN9CDhtBK1mylfaa+eUNsXVU
 dh6HxbT83njaNH+yrlmL/o+Qa2TvC/8kdEo6/vcmjOUFfQZzQYbuY6iEn0xE46ns8FIx
 P7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5sO76E8o6g3DJUmU4u9wpVZDnSlakNeXbNK0qeaRmdI=;
 fh=Z6a47XvYt8aC5iiHVQdRWtFpHRSP/N0YxDvulsNCCoE=;
 b=VnUBmzpkSWHNZFDpHIKRXNUGZIdLOjAO2UJzR2hSeP1F72ITpTCNno0dGbXRPD1hCK
 0zsTzULQ7QV/C+OPee8eXlErm5DmEdA+GG234GdmSWUKNPcVCHhHwZ//WeN1Av2+S/O/
 K1g8SZSpWABrpBcH1Ttj0PHlB3l0F4vuSRASEaBojREYr5+sYfV4ZZrWB8TclEEChuYO
 hXEjBhlS+pkt+Nn9x4g6zlXXqRtvYsFALaeNqBeSar+KwYZa79OqWwEvkM+XAgP7AUld
 nIWgjSIVRyh4XMYOwNaVqu73MI8is/Kee1bgWLWbN6mFmhYC72RMyadOVehJFzAV4Ysg
 xuCQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785479373; x=1786084173;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5sO76E8o6g3DJUmU4u9wpVZDnSlakNeXbNK0qeaRmdI=;
 b=m92/gIOQ0rNkobqDHeYeBJGsg6oV5rBJXPHs9rbuOud7HWwBzOLHogw5eLCcei6Yzr
 UCzrSPvigbW0XBKCCEh+T498eBEO4zrnBxoBoLQh3fsyAAUUkDXVukH2/dU/ntVYh4/J
 A8GTTUlgxMNUrg76GcIfZhBDaVxs2IIOIe6JkRtKhgPztPyEER+6nCKB8sZ2Rk6XhijT
 SpTysUiOo/Akv0kyGp4mWthNOHOXpIAxM3WnnPDzsc+zCbpuwyLDWoqadNls+PrVPi3b
 I6He7S8IonK01PpDrcQitv3i4UIvCquZTpLZn9jItWcyfaANqFlzx+3Snticzw1fk1p2
 ajXw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEAUgns0wOJXUVoKjvzUHqweCCkBA2e7psh1OwDld7cZcf0nNSF8bwh173KEK/FK7SXy3fAP0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxbhjRv/S5WiPe15EzFRZX7G1PIRTueHnmGHBezkATIs4xgYfva
 S29HaO+5WzVWbMfT9YKBpiCra6q5T24HDaST/dlFHwU1dWG7UgpeiToDkTT2LBbYCgkpnL33qtf
 dsHi9778sipZVfhSESUWNtuZZiS+ynJZupFUn+4ckcA==
X-Gm-Gg: AR+sD1229KKE4IgoeyjohkBEQSjPZIA+hDlwOx3CWbnlAJgnodnmZaXNIlabWXEF/Bu
 dSXdJh9IwUV7gpb42sALRQFW5qWtDcvrWxZbiOS5Xx7BmcW7s2LLww81xUFBdWGQfHC5G38QBCg
 SkdRug80JT0PS/WXzTW3CjILBQQ4Iv6IE1kEk36AML8X6K63o0RpTG775Ata3BlFql6TKG03VRE
 Fml1SLt7N8t5LHnKyAjrXzSThDGxa3AvAS/VAQhaZ+F/O7HTkPHu+MCXtdidOaMrj82ynPXGDWF
 mMiyOglO0fCQrdrUfEgjG21SzAjLjP+EFgYADt6DiZMNpBhX8mkOeFFGfHmKh2gakC2Wu5QRkU1
 NsqmSG5I8+cA=
X-Received: by 2002:a17:906:9f8b:b0:c16:88ec:358 with SMTP id
 a640c23a62f3a-c1fd24c99bcmr37178466b.39.1785479372884; Thu, 30 Jul 2026
 23:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 10:29:19 +0400
X-Gm-Features: AUfX_mxzospAL07Kf6hUu3sWDF1OSnbjln5Vl38TWGO7lnD09qnft8QQJu5wGx4
Message-ID: <CAKTNdwF0ivN218qg1z-mh8G7gmwnTeksEQhmSGAZuB5Y8NSiGQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] lib: resync lib/div64.c and <linux/math64.h> with
 Linux v7.1
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785479373; x=1786084173;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5sO76E8o6g3DJUmU4u9wpVZDnSlakNeXbNK0qeaRmdI=;
 b=ZxuGFADin+/1EgihuQgpZD0xDt02Yb385/EnGR9DPU3LtgbQI3CzExYNhaTHGj77BY
 QVFrnUoLiPXUwkvWue5QrmuR883xFQKF2GLl4KTI24g08GkhMNs2LNlbboqVujCXGxm4
 53IWiC917P/pIVGOpnLhDyVrc1OzTl9q5WR+l0xcD0Lm+ZDWTldc2YNfO11ATxgue18F
 kfIhBgEot1fHC+sLH5ufHYBu03KfFPPVCx+Zvz7QAarXlqdCU5VXegPjAHDy+JV2pLF0
 m1LuC5IIJ2JAbZu2/uJtBs4G8wKG6FIM11+/hV/kUZET5ns2Erv4i4nya41fJ2d+EGil
 JoKA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ZxuGFADi
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

On Thu, Jul 30, 2026 at 10:41=E2=80=AFPM Alexey Charkov <alchark@flipper.ne=
t> wrote:
>
> U-Boot's <linux/math64.h> was last really synced with Linux in 2017 by
> commit 0342e335ba88 ("lib: div64: sync with Linux"). Since then it has
> only been patched locally twice, and both times in ways that increased
> the divergence rather than tracking upstream.
>
> The one that prompted this series is DIV64_U64_ROUND_UP(). Commit
> 3adc17f60bf8 ("lib: div64: Add support for round up of div64_u64") added
> it inside the #if BITS_PER_LONG =3D=3D 64 branch, whereas upstream define=
s
> it unconditionally after that block, so any 32-bit user fails to build.
>
> While auditing the header, two bugs turned up in lib/div64.c, so this
> series starts with those. Both are 32-bit only:
>
> - div64_u64() and div64_u64_rem() shifted by 1 + fls(high) instead of
>   fls(high), losing a bit of the divisor. Linux fixed this in 2019, while
>   U-Boot never picked it up.
>
> - div64_s64() used abs() on s64 operands. U-Boot's abs() is not 64-bit
>   safe: its own comment says to use abs64() instead. Both operands were
>   silently truncated to 32 bits.
>
> Transitive headers that affect what <linux/math64.h> offers were checked
> too. <linux/math.h> and <vdso/math64.h> have no U-Boot equivalent and
> are not needed; do_div() comes from U-Boot's <div64.h> in place of
> <asm/div64.h>.
>
> Deliberately left out of this resync:
>
> - CONFIG_ARCH_SUPPORTS_INT128 is tested by <linux/math64.h> but isn't
>   defined anywhere in U-Boot, so the __int128 fast paths for
>   mul_u64_u32_shr() and mul_u64_u64_shr() are dead code on arm64,
>   riscv64 and x86_64 where they could have been useful. Wiring it up in
>   the arch Kconfigs looks like an easy win (but could result in subtle
>   behavior changes or code size drift, so needs to be approached
>   separately).
>
> - abs() in <linux/kernel.h> diverges from Linux and is not 64-bit safe.
>   Patch 2 and patch 5 work around it with abs64() at the two call
>   sites that need it. Replacing it with Linux's __abs_choose_expr()
>   version would be the root fix, but changes abs()'s return type from
>   long to typeof(x) for every caller in the tree.
>
> - abs_diff() lives in <linux/math64.h> here rather than upstream's
>   <linux/math.h>; it could move to <linux/kernel.h> alongside abs().
>
> - mul_u64_add_u64_div_u64() and the mul_u64_u64_div_u64() macros are
>   not ported, as they need a u128 type and ~110 lines of
>   lib/math/div64.c that nothing in U-Boot calls yet.
>
> Build tested with both gcc and clang for evb-rk3288-rk808 (32-bit LE),
> generic-rk3576 (64-bit LE), malta (32-bit big-endian, which is what
> actually compiles the __BIG_ENDIAN union paths), plus sandbox and
> tools-only. No size change on any phase.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Alexey Charkov (5):
>       lib: div64: fix off-by-one shift in div64_u64() and div64_u64_rem()
>       lib: div64: use abs64() for the 64-bit operands of div64_s64()
>       lib: div64: inline __iter_div_u64_rem() into its only user
>       lib: div64: sync with Linux v7.1
>       lib: math64: sync <linux/math64.h> with Linux v7.1
>
>  include/linux/math64.h | 201 +++++++++++++++++++++++++++++++++++++++++--=
------
>  lib/div64.c            |  46 +++++++----
>  2 files changed, 203 insertions(+), 44 deletions(-)

NB: CI passes all green:

https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelin=
es/812

Best regards,
Alexey
