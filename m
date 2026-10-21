Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B7606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t77yNP9G;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=d0eUfNks
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86469608F5;
	Wed, 21 Oct 2026 12:48:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 91epK_Pr_TP9; Wed, 21 Oct 2026 12:48:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EC64608CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586887;
	b=mBO3jF1IlRcDxGaIPwg6LAZ6R+WIKcMBqJKwrt2OIeFiJsptiS3tvbAdgTuNZDD4OnLa
	 gdKip6jjj8KotRcz2aUAVY/3Ty3eGUxrXqrvEJXeuuute7p7JxVzR2dUkP94g0jOx8ZyB
	 RE8Cb5B1C8HnYVq1ypG9r7KpaVXhOMHyV+xD85FFPwXz/P8VpR1AYd/3loStaz0sXKcvg
	 82fC1tziB4nUg6vPUAksKxydO6I2ujHRBPPajN+DTlEAO3hAr6wq6h1LR5BthRnTDDhsb
	 9eP4bOcGdfLRYDmfNEsQHM6oFAjdwNi8y+hMZlseTIo5LjTZ2ZoeOAKpaxcW5xAJeqg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8DkyX5W8gcEybzsw1sY+wvxRh0BNxCPFa7//o6gRmfU=;
	b=bowFBZX8+7kzh/vp6SvPrMxGt1AdaankM9E0v/1lwQe6ixRgTTRVdWVkaWxpe+eBoFOV
	 sHi9qQ1d9If08k2yq+idkdKwl54ayU1FB8rt7MlMpR1va+Q3sBZcJs/GV5o2qNWPVIkVg
	 T85XOsTbNOaH1x/nhm+QgJCYvuSO7Jgu0vqEhceEb0hKEgJqmCwj9OCnTtusi2+5KnoUb
	 BhDtvUL6x54loFaP9fO1oEfn665zZef/gBlsic4hHXZlCQKiNQDE82ts/e7ERY74mAJQJ
	 dmFODD711mHPPEYlhhWwMZkZ9mORrA8GIaxBADQiP567Vzn0rR4NTlvy8VpSNApw3pw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=d0eUfNks;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586887;
	bh=8DkyX5W8gcEybzsw1sY+wvxRh0BNxCPFa7//o6gRmfU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t77yNP9Gky6C0qiMMBsZ2IB9d49v/nzXbs7Tf9a6M5oB3vQMyDTVx/Zt7cMj7rsVX
	 oxnLuza92GdybsveNGagKzOLrXmPegK0H6GE5ca5thb8n0V/5A7SzDLf/t4YVW3pRc
	 MNR5td5wUpWlncN67Hydrqz4YVeYjPGq0c/BEUtRnpsIhoQXUS8Xssikyn2uV/RXPj
	 uTTtzpiK+w3Y2d/EOT/CsG433hC1Yz1mtKW5KU2YQKQuPTb73nlngaE1zHDeDeHoJF
	 M9icM2T01+WdmCDQIJ64l67rFFwnu6TxPDKUfeFLhup+zWGQ/H27E/i7CojA1m7KJZ
	 mnCUG0vBjovZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EC64608CB;
	Wed, 21 Oct 2026 12:48:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A772F930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88EF7607E4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:48:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k8L-NWava99H for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:48:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F3C860856
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586880;
 b=o+t9cRsbXhW3wE0SPn0hLlkUC0cwQRKmqPKP334acGlNf5Wi39LB5twMULVPIw9fyHgP
 t4uc1sh0DhW6zI4RUjVSUiCcmEJSP9dnRmAl/Vw30rfYvqZ4UarAGDGjWzH0NP0+fCxJY
 EvMVzhFquSwB7rcsciWqyt1W+qHhMvwUw5JlNdNXTUHSUEePzwdl1YHY8Y5nF+eRtZZX8
 MgSTvDUxofX7iVFidYZ4Y9Cz4UoPaHTsELAZW0It/us7gGp+NTCizkGvolAaMBh/aayHm
 RhNgJCUsZoJ3FH3sFspRRJ/87U6RCOKhbtea5WV7uzIVpD+jnjJ5cLn2qQnMStn+sYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792586880;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=8DkyX5W8gcEybzsw1sY+wvxRh0BNxCPFa7//o6gRmfU=;
 b=laNSApXA7CKzISzw7JuUqKUOjaWfVd8X+I8AnwcBZDstowob1XY9hFXAHKIUYzI5zBZs
 2uqftTaJI93llPCMCebdv7A4ZngrL1AFKvLD5k+adFBt514TWTsB1stYD/IAZXlzlKiPB
 q0qB8SVcQaiLdxb+tjziYfuFKWujAxxqvdcxDFgERXicuWxsuupGtNlCNOmdnjHmFfefb
 R5t4Xx2a/gM3j2+Bwbcsi3cuim84KqSP4r0mvzF178JNx3JiXDcqMz44ZGGApK9hxJlQd
 ykNVnadn7mlotnNN+yL78knMLbRCYoNRBqj1Hy2yYy+xJVqKduPkW1H8cPll7ALR+Rw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=d0eUfNks; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=d0eUfNks
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F3C860856
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:47:59 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so879947a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792586877; cv=none;
 d=google.com; s=arc-20260327;
 b=DJixagqxvpO69XcYOTYB+Ju9EGhrl90B1A6cP1TDxSkM0RzqawbX4bK9WIVwYdNfI8
 1YvqdpeEqe7B6wafw8fodEMLu4VAkMy1Nv5O/2XXjI6Dy+vse97ATSupWNpJ13jBHrt3
 BZwt8aakwHzyvEspRqiIy08l7So41iwJYyTzpT8mP62dh1jFxAAxsTiiZzXAcDIDQliC
 y4KgWUejWf9NxV0qwWyCNU6/6gduaWyXOd4gv1pBfcclPFqlzz13gQpr5zWEXoZ5+ta4
 IFJ5Qs5fcVxbHwCyKJIOzwHBuCxFwnKNNlhVjRARJsX/GPycceUT4NFu+mw7Vq/DSIHV
 4u0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=8DkyX5W8gcEybzsw1sY+wvxRh0BNxCPFa7//o6gRmfU=;
 fh=6fpq92GWJ70Qk2cHIBHbw3/JULXpe1Y2ppLaf4lV+J4=;
 b=cOeBbboXQ6UsHCfFLGqssugnsby2ySq7yzKFvsv5E5rhM0mbcahxRKN6DlbU78+DVa
 yK+R8l6PEuDCtcAyp8W5J7VSTdsGfW5kmlKloAO1bVaKuTeJUI12DfzwuKJY/uGAccue
 2J/xuMbL5cI5xBdDCmBLz3Izd8j8U1lwH0gV6tImmRJt/ahQ2xLgrdK/ujDImqPYl8PW
 Zcea6OW4+jxOwogjvlMj9M7vMkxYEk8OUimsUIYaQ8hKjl+Cg7FhnUnWLOmx938WvEww
 uhuThuzRsh1mO9fhacfyMDBjd4/6WHjNJ4PDcDN4o3vFXi49rt7z7jBnS3MVIDE9HBt4
 zQvg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792586877; x=1793191677;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8DkyX5W8gcEybzsw1sY+wvxRh0BNxCPFa7//o6gRmfU=;
 b=d0eUfNksq8jPc3iVkFj1yrZ0nrBlYm+ONqHN30wXVHvSaUCqHNm8P6kVf+xnZzBRpi
 N3SVYP8kGMSVCiegwv6uKUiPtU/neL+BtHEvT+rafIEi80Wv3eytoRuh3GW+/7YoauGg
 Zdq5syTM+vptyqojDyIxjH32+UW43w4onydwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792586877; x=1793191677;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8DkyX5W8gcEybzsw1sY+wvxRh0BNxCPFa7//o6gRmfU=;
 b=pwFJRBE0Q19GVZDbHgIKQjHYmncQzCYMgST+SvKpLf6d6/+85LtLbThJ/jz6gqMhru
 r398Kdqx+2ZEkbgcXgfE5DOf0q1haPG5+21CxG4uPVPztyjtH8P+lgj82/6PXLNufY7g
 vO+X/33rfOiz1ZoD2JhNq1eNwkI/pDTDjiCiGZaerT5G8fabmLsORwuUTzppNqvt5zoV
 qIN/Vb/rTUBQzp+u4VJoY1+7OWyX4oDJDPCI2ttOxmE9VbMYugFobTkExA1h7PdIcRIe
 STBjHISuhp95WCfUS0GQxtt7ykDl0FbVeb99jdQQmtjAJZW52AnBB9YZ2ZxUrXqSM+7X
 U+3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfp2/9CTf6se8ijTC7JGRub8Y3/0eAwW3t8oelZGrztzMMlusPZWrQ3mfEKH3FscAsgx2T2EU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLIkWpk/fcCwPWdGIV1HvatWLUxtKIzFScS36w6VcbLByywAWAN
 iRWvouWUBFf4MP0F0noM6sPBotdNBHIOgXQJreMZEiQuu2NGMwBbnqRLt3Ft+HDOj5wNdDstRbn
 wXFd45/l3rVk7p8Jl02v8XbyO2I2pag5ZAfCVe83n
X-Gm-Gg: AYBFou29Hr/FsqFAtGzr6PWQrM+KvFpp49QjXBuHMsJcj5lCKW/L92akNa2xzJYqoxg
 wCXlSkO8UTfEWXAtSgnqfH/rkhaIXEuMZ4hpLElpfhzIJ0dIoaTwGTb3SAUKvVHXjTgb7U863Rv
 EOXaVsurm86m9BiBVIZ/2KQ+2KfgieZBauVuSKPT6XvWzM9lwgLDb6YkLt8/sK0FFMPURlnMTtd
 8+a9WQqQeGhEbw+5zZFusrixKVlE6DaKN00y1GNKUlrmBjB3mQVu00t5yaO2iaoS0RWW6PexEZ8
 uOtp0BeY4UCS6gz0UNPMgsl5L4TMyYUzYcQpxxf4bRxKExXsxZOiMO6vsqr0I1P091LRH5yfxe3
 mKRYGLvjLvPCjm6Kisg2KkgtW8acCPtbTI54=
X-Received: by 2002:a05:6402:28c8:b0:6b1:a544:da5f with SMTP id
 4fb4d7f45d1cf-6b408ebb43amr1324069a12.27.1792586877073; Wed, 21 Oct 2026
 05:47:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 08:47:52 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 07:40:33 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902211501.127915-3-bhargavdas100@gmail.com>
References: <20260902211501.127915-1-bhargavdas100@gmail.com>
 <20260902211501.127915-3-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 08:47:52 -0400
X-Gm-Features: AclHuK8H_h7unhJd0zpyCE-ITC8oSyHpsX-5TK87l920JXFL7bVtFKgPfdV8uAU
Message-ID: <CAFLszTi4r8SoE2YOm6cnKp8hURMaVbn6mj+3bC+A_iSffLDVmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm: dts: Add RP2350 device tree
To: bhargavdas100@gmail.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bhargav,

On 2026-09-02T21:14:48, Bhargav Das <bhargavdas100@gmail.com> wrote:
> arm: dts: Add RP2350 device tree
>
> Add device tree for the RP2350 SoC (rp2350.dtsi) and the Raspberry Pi
> Pico 2 board (rp2350-pico2.dts).
>
> rpi_pico2_defconfig selects CONFIG_OF_EMBED, building the dtb from
> u-boot's source rather than CONFIG_OF_UPSTREAM.

These are two separate choices. OF_UPSTREAM is off because Linux has
no RP2350 devicetree, so please say that here. OF_EMBED is different:
its Kconfig help says "Boards in the mainline U-Boot tree should not
use it". OF_SEPARATE should work fine, since the dtb is just appended
to u-boot.bin and picotool can still convert and load the result.
Please can you switch the defconfig in patch 3 and drop this
paragraph?

>
> Currently for the uart nodes 'clock' property is used instead of 'clocks'
> as there is no dm based clock driver. This will be updated once a clk
> driver is introduced.
>
> Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
>
>  arch/arm/dts/Makefile         |  1 +
>  arch/arm/dts/rp2350-pico2.dts | 25 +++++++++++++++++++++++++
>  arch/arm/dts/rp2350.dtsi      | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)

> diff --git a/arch/arm/dts/rp2350-pico2.dts b/arch/arm/dts/rp2350-pico2.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0+

The .dtsi is '(GPL-2.0-only OR MIT)' but the board .dts is GPL-2.0+.
Please can you use the same licence for both? The dual licence is
normal for devicetree files.

> diff --git a/arch/arm/dts/rp2350.dtsi b/arch/arm/dts/rp2350.dtsi
> @@ -0,0 +1,37 @@
> +		uart1: serial@40078000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x40078000 0x1000>;
> +			clock = <150000000>;	/* CLK_PERI = clk_sys 150MHz */
> +			status = "disabled";
> +		};

You don't need a real clock driver to use 'clocks'. You could add a
'fixed-clock' node for clk_peri with clock-frequency = <150000000> and
point the UARTs at it with 'clocks = <&clk_peri>'.
pl01x_serial_of_to_plat() already handles this through
clk_get_by_index(), so you would just need CONFIG_CLK and
CONFIG_CLK_FIXED_RATE, plus bootph-all on the clock node so it is
available before relocation. That gives a standard binding now, and
when the clock driver arrives only the phandle needs to change. What
do you think?

Regards,
Simon
