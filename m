Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ADBCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 01:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDB4860B74;
	Fri,  2 Oct 2026 01:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dvaQ6t8cpsq; Fri,  2 Oct 2026 01:27:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 004AC607DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790904466;
	b=A3clyE0VIVrNSbGVMuNS1PcOdDY8/7a/Pk7cpxIL+xRQAQ+IOAfgiXlAxVyyme8SIo12
	 tzeMPyg0EyINwo0mEJlcrI+O7Gs2i1zaFxTw4W18X/pa121b90acccQPpEHEvgsmE6Uw2
	 nMc9aKHfgZoeOJZlAP7nz4a1cFTaw1feKBsYO1Hap3CyadBQRQZtIGKIgbG9Y/QrRVuzs
	 THdRzTVGZMdETVNTIYXPgmdtd0JpsrMiMOoTInfnsU7eHhARNUrNdKXOnFVnPN8lSaIjI
	 /geoxFHQa94HdVAaPcIz1DkggibKzT9hIA2KEaLfEk4BzvlB3+yTBrqLH4dG45/76kQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790904466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mLvo/m6SVNDIQ52HdiaDjF4R4DaF3Z2TpmTrt66gXuI=;
	b=MyvMy31gB1xvVvg0vA/Xcs0FF9xphQ9th/TC1pLLK5/oBDaqhW3/NZZh3WhmMt2CfuJ5
	 d7Ys3ddpb3Kb8Gs8EWJHh/b2YHpJ6lY/nEtl2oYDdUcMIU0W2d0/ElrExc87sL7P4/Cyu
	 +NZODpS/HGIMrL3kGYuzFRJXfK9QSwRGaTbiiRV5mf9Qd9q22x+jXagdTZ0YaGbaY1OTI
	 iir5+UMlY4XD5IL5hITGN5wKiEDekS9sqVSKlOmelxAoMEqrl7XGDXDtghe0hfKPsyEvd
	 3GyxW2tkWiQ5joKE01WImufDIwoWbFsi6wKpmRwtBadyIqX0e0L3BxsPGZbakBudEuQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790904466;
	bh=mLvo/m6SVNDIQ52HdiaDjF4R4DaF3Z2TpmTrt66gXuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QLJS1JDyBNOIwmlRPFgmemYY7Y5APU5wji01PM6tjeaqi3xUVMSKP6bOERFY+qIla
	 IaXMOQWMhvWjdUlEf02GvoxY43JuXaLXdhzP+kjs2UJShb5VBU9lryohU0htAAR+E9
	 YGGbpGglC/85CNgTkMGH62n8ChjOb7tG+afRnQqG7nxhs6wH5ZeHv+OugbB2nLsodc
	 XdQ59P1hcrnlixfv7mPYkNQ+rghc31+IgBUENkcbjQz+65+2rUfhnRv9qUFhGa6lJV
	 LztsWpGlwXLmyOjaCf/WwkJMybyo8HIyEmM3ZuvkVS1FICz4CFt2Mr44vHqzdr2f22
	 ribbgE0SuAjuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 004AC607DB;
	Fri,  2 Oct 2026 01:27:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DF7832F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0FD4B40BF7
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjGFwhOJssTh for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 00:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F210D40BD5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790902530;
 b=BZoHLLPKwB0i0/lckE/q+dzPc6F5F3l5QO47Potz2f6vEr99Q3CfLqPTaSlmn+99elj1
 lhU+ZMkoPtihqdpVja1BrPcVFL4ORHiclILTM7TwfR/kb7RoFH9Ldf5m6tC0pI2gU6VkG
 FJ9Pte6/iLLuZ2cO0dnUuvYoL/tNQooOUrjL7jotDl7tjBngMHezR5Sbf6/Hm0Mj2wMjg
 e84afIIDDtWkxgIOKnE2Pw8gLe8/hC+wavVWYNe2Bjfn07z3f1Xv4NjWi6vpBy3ev5fs+
 BXibtnbnFBTCrYKmBJIwf0QDPt1QKInO8xOLPQ+kbYKD6d69pynC3upkZphDNuaXl4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790902530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=mLvo/m6SVNDIQ52HdiaDjF4R4DaF3Z2TpmTrt66gXuI=;
 b=rYc0s4ehaBMPxs0cx8CeORn9ZVXKoeai390IcJRk0EuKUpE976+va2JI+iA54rFETmzs
 lI92CqgfwmTLuke3ns6MRftaPryt9P/sO+zEOvuvc4avXgBkodZ9dK2GfpyknFIQheqMG
 t5nAG3zC98/D9uhtgeKr7Gmr5PYvmaA/tUMVztLREWDo35Jabff+NCV4ieKy/9m6tmaQD
 Y+Ne/P2qvoaPwOQW9WqBMxNnAwIR7+qZs/mSbiTfAC0zikfZu8sVs2zHSw2C+rWKz/Y5+
 +IEL03RpJYTriWs3Iqkym/xYtIom05/fcdSZoWjm+lhp0PFHZw6vvJmeNWlx98JSzIg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZedKDCYY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=m.legenovic@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZedKDCYY
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F210D40BD5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:55:29 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ab43af5e97so11355717b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 17:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790902528; cv=none;
 d=google.com; s=arc-20260327;
 b=F+QJ0H8/uMVNu+CXhF/cgnr8a26IdLaKoUf9oEIA/cV32jm8YmfbkFFn7RO6QA/4eS
 5DTStupFMX7+j7UtO0vUhN8M8cUmfYHsNgl7GapfRpXXcpmXAyIVtD83PQZZGGO0VL/B
 f/BoxHC8po7cBvwCLlsfTWD17PcYZwmsk/ExiVrTPg5sz++zWeelPP3/0wCMbHtsqSig
 CBkmDDdIS5kULpAV9Hokw+85VcL/wzKv1H6RLcN38dTwDdWIk8ofD2ALY9BZ8rJ7kat9
 jxgRqJ6IIWVvQ6Imb+bOKBDdlAzfaCbMQFiTf2EFk6bnLpRmgbrfwjZxbRCF0E4xX8ot
 C8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mLvo/m6SVNDIQ52HdiaDjF4R4DaF3Z2TpmTrt66gXuI=;
 fh=mpPB3DSsbuRQ8J6bhuqWHO1+dotwjP7/nN6AT1eMQ0I=;
 b=YCM0CQRnjfDp5qgIfhz6vDjsvi1hhHF1x1EAidFP0R0rv2vLiCWKuFuKeeeWvzqAtv
 f3jJbPR+63PNeCJwaATyhSiSQUXGbiD7lz85037Z9FCoauCy7FGO487gEtjToRPBLnGI
 3ZdStghslomK9z0f947AhkJhVyW7dIOXCXq4bIYdY9vaCYG4x8OzWmb7JGKI3jEPbVjI
 MVUaixsJx9h6fv9rlteRQevM1nWr69Z/VY+JXZsqDhT0NwxQFdxaINjJwggES3odIGBE
 at03yxTm0xs+grrYcG4SkZiJQd5Oq0404jK02Oij4OcaW6rWl4aMV1BUWST9Ueq8LT97
 a0Fw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790902528; x=1791507328;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mLvo/m6SVNDIQ52HdiaDjF4R4DaF3Z2TpmTrt66gXuI=;
 b=ZedKDCYYAzDj9V0OruMU2DTL5e92zF3mloCmF0awf3WY3ezFIL9NuCMsWOtBRKMLUQ
 qqeMn2PuXx8AHtSVnXVm8hTnmu/WLk2V4EeHjZjTQCbcSPO924hkfLCfMPf5sfWrDlzx
 FUAENYYUJYTizGarerOKjeVurd03bFDXmc29+zzmnmsK1TxIICHsVBQG5rrLxrhY86TD
 eXlK/gFIZ/7ONQ70zLNrNIGeOrFLEb4XT6cdUoryGvuCiC+6jSpp8Yia6nhh6t7lC4oN
 TI6av3EntQ6Gg2Hfw6ZSm749DitSvlsVrmyADS81zPHmeED98LNlaF/ZL8ywJMcCB4zj
 HsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790902528; x=1791507328;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mLvo/m6SVNDIQ52HdiaDjF4R4DaF3Z2TpmTrt66gXuI=;
 b=jJYgApp6+r/NQHazBNacc+B0dARL36FsXE59VHjikKh0GequJKZSDEuQBNMmgygreA
 VdXPcHfs3G26kpiwy2ZfDQfCgBHxc4VDLnniB5fkDBTe+WIOT8jtNhEVbTao9xG2N3J+
 8QdvsZFyfTnPE6s+k09v4KRVlzLcJatg6f2msJT8Zgl1mfB7odGqFm/NXK0b9uCi3yDY
 9ANt9iy7Ldc5dkTc0fWxrhAsea3DvIrh6ZP1j9ZA0IcYhrR2BsiBVdlG77TW5wNVrQjq
 ZvVINGteee5gD3stYC8kiewFL+gNlxnIKoGaSxC5/4iu9dv3YsljTSZdyBjW7GBwWuZ6
 en4Q==
X-Gm-Message-State: AFq9FYL6mXwW06BrfpBhtiGceFF1vuyuQ9XeibV7hnFWkuoLRj8tAvEn
 3HbK8+8gztqcABM5Sloh2gyr1SEnRvO3o3fRI6mWHeSRyRAsuLK3lX2AD5DFnVg4iwiAgerICc2
 AuA70rfMaHRyrROoQv1zn63559biBriE8pHPr9CM=
X-Gm-Gg: AYBFou1GrGL3wx/mvDzuB0f7NJK+WJly7Q1KUJMbA0PMBoUAq7TFTo5Lq3p+rOS9/Fz
 liz0sRqG5weiPvD2VhH/8wm98xBU3EiKvRDLwlilKGxtSO+fdTTcn6ai+GhKhY84dFHh13QDwMW
 JJiIbyH6z8qhyWm2P0muzAQPbwh/hjsHOVAPqzAf68BT3S76EeVasUnT8JgP2/Nu6lNIF7pMZnj
 KznGwegomyqYa9G19Km6MrmTdXErbBdFCJt4bRJAv7H8Tx4bejuYjrUuoEYwP6S5alVsxbEKW/+
 kY1V+NkrJISRBiLFyZwuX1UYYiTJV0uq77hoe7+uCMO1LPi2Ub6S5A==
X-Received: by 2002:a05:690c:102:b0:873:5c7b:c12d with SMTP id
 00721157ae682-8acdaeb0820mr23566997b3.21.1790902528447; Thu, 01 Oct 2026
 17:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
 <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
 <CAFLszThQZy=Sj7bRsbWOFn=Sn4mgzkeo=4Sj0Qyhu9cWotO1ZA@mail.gmail.com>
 <CAGuQyfVDA9cGRk-o9O2ha3GC5-U+7q3fwz3tJ08-DOxiQEMi=w@mail.gmail.com>
In-Reply-To: <CAGuQyfVDA9cGRk-o9O2ha3GC5-U+7q3fwz3tJ08-DOxiQEMi=w@mail.gmail.com>
From: Milivoje Legenovic <m.legenovic@gmail.com>
Date: Fri, 2 Oct 2026 02:55:17 +0200
X-Gm-Features: AclHuK9WsMkzzQ_9L09Eu2gGpWSyy6cB0IgBf3G0njYQ12WlqcaFge_OTXkXijw
Message-ID: <CAGuQyfXOPM1KVci6rD1x-uav+dGiH5z2HMz+_5zeXP0BBJhX9A@mail.gmail.com>
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 01:27:44 +0000
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

You=E2=80=99re actually right; git bisect has shown that the problematic
commit is the following one:

commit c6bba31dbdd450081503dc0e20fcfb4328b347e4
Author: Jonas Karlman <jonas@kwiboo.se>
Date:   Sat Jul 12 21:12:29 2025 +0000

    rockchip: spl-boot-order: Defer probe of boot device

    Boot devices are being probed when SPL boot order is determined. This
    may delay boot slightly and can prevent booting from SPI Flash on board=
s
    that use same pins for SPI Flash and eMMC due to pinctrl being applied
    prior to booting.

    Instead defer probe of the boot device until SPL try to load image from
    the boot device by using uclass_find_device_by_of_offset() instead of
    the get variant.

Your question about used u-boot and kernel version: currently u-boot
version is v2025.10, and this version works. I tried switching to
v2026.01 a while ago, but because of this problem I=E2=80=99ve been waiting
for a newer version to come out, in the hope that the problem will be
sorted out there. I=E2=80=99ve tried every new version, but the problem
persisted.. Kernel versiona are: 6.18 (so called "current" kernel in
Armbian) and 7.2 (so called "edge"). I have tested both versions, but
the behaviour is the same. For git bisect I have used "edge" kernel
(7.2.8).

I=E2=80=99m absolutely on your side =E2=80=93 we should get to the root of =
the problem
rather than just treating the symptoms.

Cheers,
Milivoje

On Thu, Oct 1, 2026 at 8:59=E2=80=AFPM Milivoje Legenovic <m.legenovic@gmai=
l.com> wrote:
>
> Hi Simon,
>
> 'dmesg | grep -i dmi' shows this:
>
> [    1.107089] DMI not present or invalid.
>
> and /sys/firmware/dmi/tables is not populated:
>
> ls -l /sys/firmware/dmi/tables
> ls: cannot access '/sys/firmware/dmi/tables': No such file or directory
>
> Adding fdt_add_mem_rsv() does not change anything, it still hangs, and
> "DMI not present or invalid" message remains. This is how I did it:
>
> fdt_add_mem_rsv(fdt, smbiosaddr, 0x00001000);
>
> As I=E2=80=99m not familiar with the code, I didn=E2=80=99t know how to c=
alculate or
> determine the table size, so I simply used the SZ_4K constant (aligned
> to 4KB). Let me know if that is wrong, and what the correct value
> should be.
>
> Cheers,
> Milivoje
>
> On Thu, Oct 1, 2026 at 3:27=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Milivoje,
> >
> > On Wed, 30 Sept 2026 at 23:29, Milivoje Legenovic <m.legenovic@gmail.co=
m> wrote:
> > >
> > > Hello everyone,
> > >
> > > Here are the details of my analysis:
> > > The commit that introduced the change in behavior in version 2026.01
> > > is this one:
> > >
> > > commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
> > > Author: Adriana Nicolae <adriana@arista.com>
> > > Date:   Thu Nov 27 08:28:34 2025 -0800
> > >
> > >     boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
> > >
> > >     The Linux kernel can discover SMBIOS tables through two primary m=
ethods:
> > >     1. Via EFI tables, when using EFI boot;
> > >     2. Via the 'smbios3-entrypoint' property in the /chosen node of t=
he
> > >     device tree.
> > > ...
> > >
> > > I found this out by comparing the device tree from a working version,
> > > decompiled using
> > >
> > > sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts
> > >
> > > and difference was in /chosen node:
> > >
> > > chosen {
> > >         u-boot,version =3D
> > > "2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
> > >         linux,initrd-end =3D <0x00 0xecbffca5>;
> > >         bootargs =3D ...
> > >         smbios3-entrypoint =3D <0x00 0xedf47000>;
> > >         kaslr-seed =3D <0x00 0x00>;
> > >         linux,initrd-start =3D <0x00 0xeb519000>;
> > >         stdout-path =3D "serial2:1500000n8";
> > > };
> > >
> > > In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
> > > searched for this term in git history and found the commit mentioned
> > > above.
> > > With git show I saw what activates this, and made a patch in armbian
> > > build system to disable it and confirm it fixes the problem. And it
> > > fixed it.
> > >
> > > Here is also where kernel hangs for 60 seconds (always at the same pl=
ace):
> > >
> > > [   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
> > > [   78.137967] Freeing initrd memory: 23448K
> > > [   78.165027] probe of leds returned 0 after 63677665 usecs
> > > [   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 afte=
r
> > > 63684076 usecs
> > >
> > > As you can see, I was only able to find the cause, but that=E2=80=99s=
 the
> > > extent of my expertise.
> > >
> > > At first, I wanted to sort out the problem with a patch in the Armbia=
n
> > > build project, but then I thought: "Why not sort it out at source?"
> >
> > Good idea!
> >
> > Does 'dmesg | grep -i dmi' show a DMI line, and is
> > /sys/firmware/dmi/tables populated? That shows whether the kernel
> > reads the property.
> >
> > Does the hang go away if the property stays but the region is
> > reserved? A quick hack is fdt_add_mem_rsv(fdt, smbiosaddr, TABLE_SIZE)
> > next to the setprop in fdt_chosen()
> >
> > If so, you could add a fix for 209bbc4e003 - i.e. reserve the table.
> >
> > Regards,
> > Simon
> >
> > >
> > > Cheers,
> > > Milivoje
> > >
> > > On Mon, Sep 28, 2026 at 4:37=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > On Fri, 25 Sept 2026 at 18:59, Milivoje Legenovic <m.legenovic@gmai=
l.com> wrote:
> > > > >
> > > > > After upgrading u-boot in Armbian for the Odroid M2 board from
> > > > > version v2025.10 to a higher version (it doesn=E2=80=99t matter w=
hich one),
> > > > > the board does boot, but the boot process halts for 60 seconds,
> > > > > and only continues once this time has elapsed. Debugging via a
> > > > > UART cable showed that u-boot hands control over to the kernel,
> > > > > and then freezes there. The only difference compared to v2025.10
> > > > > was the SMBIOS table. After disabling this configuration option
> > > > > everything worked perfectly.
> > > > >
> > > > > Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
> > > > > ---
> > > > >  configs/odroid-m2-rk3588s_defconfig | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > But I agree it would be useful to know why the kernel can hang in t=
his
> > > > way (I didn't even know it looked at SMBIOS tables!)
> > > >
> > > > - Simon
