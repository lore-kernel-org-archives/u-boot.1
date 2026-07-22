Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D4EC44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:39:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 185254071D;
	Wed, 22 Jul 2026 07:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MLA7Ei24jsfZ; Wed, 22 Jul 2026 07:39:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CCBD40733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784705970;
	bh=fCAKEiJpvEhXFweVprPUCzvw/oXAAE2m75sKyjb3rSA=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=km2Km49+KjIj735UvzF/SinTGfB7FH4uImAwoxNuLvsU708wWRrmhHaxHuOQ3raHR
	 GF2gjWR+MHpLI+eM56LTIW7rjuUR6RUDti93VQD7DFAMj8ToUyW2AeRiJgifFhiTbp
	 CfVPciS9NQuUo6D8WTpTCA+IyVv9Wdf8IuURI2GTtbUN/JC4KpD6ezo/Tui7Ov/TL6
	 Q49+BTXh14o9BrTMq3vrZy27xYj9Kvje4Qb0eiW/qFbxE5ey/GSVOw9R6d8d09gXPh
	 dQZOmmkoZWF/E/K6pIhofwwRfq6pyr6UXMdo/1mU7yDMRPeMVrsy/la/MzG6XySUQv
	 jzFHp/FjPHgYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CCBD40733;
	Wed, 22 Jul 2026 07:39:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D53C310A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C686E40733
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 00vcRrn6bxhI for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:39:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 923904071D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 923904071D
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 923904071D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:39:27 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15f360851aso1350177366b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784705965; cv=none;
 d=google.com; s=arc-20260327;
 b=E3euyVk/RKUbyPEgl4L0S9BQlniV1OA4lB6mJ7Y5xeYjc3xqCRcVfMNN/OayqS/M70
 JJGI7MVETACMfxu+J/iiaTCrtt2m4Adn0voADZNj/KliQmgHEg0ILpjnneyJh6OMbKBg
 sP390gUB2A/J8xMjCUkcnHEmqbG/2rZoQ8KFzQAPaKA9Lt668k/2Qafh+eeFx4iQP4mD
 VH401/5dmrBc664LCjZXy/p4CYBC5BIrzuve4RU+TuH3y9XFcaomfsdjxzUADQ6oBiNX
 R7VNAE9gy5JdXO1+HCHNK1Dcn/66KfKDsYp7yFFLBBxO88vUgE1I0McfHU/qY82DugTp
 /Drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fCAKEiJpvEhXFweVprPUCzvw/oXAAE2m75sKyjb3rSA=;
 fh=gAEFofJwMzmmys8FTmp9JMRck47sQvrIEpQ6H9kUapM=;
 b=NoiTNnEAUpmkMtobHAjrFcrjnXgbCE0C5i2Vb2oZr93aJzPJq+ciHg99vmJPurgyVB
 xLFXRfwTeXCJKcNAJM5qDDiNGL0EowoGjLb3/e5F0LjVtDmfrJBPf6i4g6A9v4fAdPR/
 Cv1JLfqabEveI6+nHWr9VX8J/aO2faLP1dBoWC+oYbP3fukyiKGb2BWLISCVaW5IJp5a
 857FALVQLZg4ASVBEGcwJX+dDRdQGuOSbhXJS/tKqESGX1qDcnyidXcYbPuixqmrzfKi
 s4SBJVhtyWOlyT1kNIjKjQs0nzxMWsRco61L+qkCEuTnIIIPn/xQMvvoNbbmcSNBT0Ve
 6GjA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705965; x=1785310765;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fCAKEiJpvEhXFweVprPUCzvw/oXAAE2m75sKyjb3rSA=;
 b=G05wPYfdSv1sLXpj9xOafS5f3V6EV/TXgOCt6u1bFuYBf+vfwVhv8Sp7Ka+K/CtLpR
 Q5uRJiZAMaunpmddLddEhclNpILFD7L9oNHkf6qGELlFWkikM9eWzp88D5DxZ2MPupDy
 H0TqNJ59/LoqHHlS3IRzx1HUYqTWH4YEypuPdV9Kq2gmDzOflrB6fFDNLnYLbH0b2DXI
 PkGt5wbZ/XNI2Ic8gtY8dFRiPZQSvmAO4/PNVj5ekv3j+jM44PzypkzpvJwcc+AKJtp0
 tVHj8WVVUknmYoOh+7evvUGgpUeVYpGj1i6P6v7CZax7zBCh3HwLVU5JzqCe6pAyYmZv
 PZMw==
X-Gm-Message-State: AOJu0YzQdqmXiycysY2RiWM704paK3zBslrgZ1EEwjrzsD0crdxnqAED
 mcmPKr8C5t9SAkTZjPHD5BFS5Em6HQQ00ByA+PNNlya7/QxvHlV4ZzxGlM5oQ49vlSgbjGuyVa5
 gkgoh7DuKDlBRwcLRNsmcVqZYYyvZZFlEIW9yMfXUNg==
X-Gm-Gg: AR+sD12F42xqkMuOsUCNhnzXeWyVB3L6n++gNE1RzIclxs3Y9ZFCBfanuGwJl4hvK2l
 RpDJ9RIJMQOA++7PtQLmDY2MaMq5Sp8IkoKAQAEMa1O2Czewq30ImIb0Ibp+B8udBPfbws/R527
 IbsMJ4rn7glcMLwvodGlFcz3An5+zdXfmtxrHi52UUpej1jmc6JBcpOBf5qs6sjmBqpu5cfshXW
 zcxBXeNTd1TSsR3v4a2QBreFjnNfViiZo5b9AxGRrSsmFR/dVtlBK6gEbWTn3u/EKPyd53W/Ppg
 Q6R8bJxU6TwATdhGag==
X-Received: by 2002:a17:907:845:b0:c16:61d9:1679 with SMTP id
 a640c23a62f3a-c16b483d4d3mr948848066b.52.1784705965325; Wed, 22 Jul 2026
 00:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <-mj8gZELtrWJeeFLCaw39rL0jrHYwmGDsHwx9fof5bU-yF18H0CThDfILBU7eQ-8AdiYZfBrbAti-LfJkf0Ky5lyuxNU8zDJAjJTZBszN1Q=@on-the-web.ch>
In-Reply-To: <-mj8gZELtrWJeeFLCaw39rL0jrHYwmGDsHwx9fof5bU-yF18H0CThDfILBU7eQ-8AdiYZfBrbAti-LfJkf0Ky5lyuxNU8zDJAjJTZBszN1Q=@on-the-web.ch>
Date: Wed, 22 Jul 2026 11:39:15 +0400
X-Gm-Features: AUfX_mz5sb63kItjHCOk_aZOy8fyW551XEiZaMGMGR9EPbEg-AHRQPjFMpQbOSA
Message-ID: <CAKTNdwGD5CR4+YD-HZXdQnKbB==Y4f5NfFtwPfRoAnTZ459jNw@mail.gmail.com>
Subject: Re: [PATCH 0/7] rockchip: fix boot from SDMMC on RK3576
To: Martin Herren <sputnik@on-the-web.ch>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784705965; x=1785310765;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fCAKEiJpvEhXFweVprPUCzvw/oXAAE2m75sKyjb3rSA=;
 b=uuV/Wa5CCSKb4XGkdpXjX2t0Hqr8Mej81Dd8t1ARQ/nKhBIWTNC3p2z1aOfk3e/wal
 3eTrHddEuLHopABV/HsjbGJM5Cc/RVb5sgnwj0/7WDlv1r52uqWKAJLCVuhPpfB/bBkr
 yYXDxZ858Y32gGINS/fVvQkF+UGbv2GiX4SqFBuAL3Lpyw7HwsrBwjgF57/ywmmhJcf4
 oGay2Mky+okf2UtywHIg39tjlvoMnVGJRiQ5YHdU0Vks6xQ6C9BVZqOPz0L3Sncuu/YG
 WSjHl65h4bTkZW+FQz4GyhHeZPCThN9P35FtBb17FknttXRnN48GB6GIjB7yMzU6ohkZ
 ph+w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=uuV/Wa5C
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
From: Alexey Charkov via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Alexey Charkov <alchark@flipper.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Martin,

On Wed, Jul 22, 2026 at 12:05=E2=80=AFAM Martin Herren <sputnik@on-the-web.=
ch> wrote:
>
> Hej Jonas and Alexey,
>
> On Monday, July 13th, 2026 at 12:03 PM, Alexey Charkov <alchark@flipper.n=
et> wrote:
>
> > This aims to upstream Jonas Karlman's long-standing patch series fixing
> > the boot from SDMMC on RK3576, which requires a hotfix to the boot ROM'=
s
> > global state area before any SDMMC reads are initiated to avoid clobbin=
g
> > the ROM's state and breaking the boot process.
> >
>
> > The preparatory patches for the image tools are submitted verbatim from
> > Jonas' version, while the "boost" code doing the actual hotfix is
> > converted from using a pre-built tiny binary to a from-source build usi=
ng
> > the existing U-Boot build system.
> >
>
> > From-source build also alleviates the problem with parallel out-of-tree
> > builds, which could skip the pre-built binary but which always pick up =
the
> > from-source build.
> >
>
> > Tested on a number of RK3576 boards, including the Rockchip RK3576 EVB1=
,
> > ArmSoM Sige5, FriendlyElec NanoPi M5, Luckfox Omni3576, Radxa Rock 4D a=
nd
> > Flipper One, all of which fail to boot from SDMMC without this series b=
ut
> > boot fine with it applied.
>
> Thanks for the original patch and reviving it with this v2 !
>
> Comes really at the right time as I'm trying to add Yocto support for the=
 Radxa 4D board.
>
> Successfully tested this serie on my Radxa 4D board, even if already repo=
rted as tested.
>
> Tested it on v2026.07 where it applies directly.
> Also tested it on v2026.04, in this case 2 additional patches from Jonas =
already in v2026.07 must be backported, then it also applies without proble=
ms (little fuzz).
>
> In both situations, once flashed to SPI it boots fine from SD !

Great to hear it works!

> Now no need to use the 'WiP' commit on Jonas' branch anymore with the pre=
-built boost.bin as it is now built with the added commit in new serie.
>
> Still SPL is not able to load U-boot proper from SPI (probe failing) and =
falls back to SD. Saw a few WIP commits on Jonas' kwiboo branches that look=
 like handling that, couldn't get that to work yet. Anyway that is out of s=
cope of this patch. So for the scope of this patch it does what it's expect=
ed to do.

For booting from SPI I've got this patch [1] in my local tree which I
"think" solved a similar problem for me on a FriendlyElec NanoPi M5 a
while ago. I haven't found time since then to investigate whether it
is indeed required (and by the looks of it, it _shoudn't_ be, but it
needs thorough investigation).

Could you please try and see if anything like it helps with your
symptoms on a Rock 4D? Except of course you'll need to substitute sfc0
for sfc1, and <&fspi0_pins &fspi0_csn0> for the pin config.

[1] https://github.com/flipperdevices/u-boot/commit/749a5e430fad2798c948bde=
db948ebf238263bde

> Will happily test a potential future v3 if that might be of any help.

Appreciated, thanks!

Best regards,
Alexey
