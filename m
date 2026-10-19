Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD73CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FFAE60752;
	Mon, 19 Oct 2026 09:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OTYwtuYsURhL; Mon, 19 Oct 2026 09:24:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 960D7605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401846;
	b=MqzHZiIywPzNE8FlMpVU0TqO5Nh7wuSTeAytbsYq/0qk0+yBukbGcdDAXwtXmayrecno
	 seJY3n8Uht30Kso/gBjgGQWn2H0oQbvYv6jt0itq/VZjvqBpD3oJ9M8rHxput7923JDdL
	 aU3b8NObSGbscZLmwZoGy7ammE8xS+Th9oZo7K1oOOQ7AkG5FMqPvtLqOFoirj+7Bt2DD
	 OWpnC4u2A+rFpenjKM3qtRy600gkHDJu1HdtVSGQTFc1osaO2jiqsJSEyxpC21RaqOJCP
	 /sRDHFF0vpXfIySL4Y7DN5ZSrXWqHrn7sG/WOW0JyTC/+2vddfL+mZejGsAYYNKdOUQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uxPU5udFIJ2qZ6ViQtiNzzfJiTm4fvV1qMLvQ8GRl7s=;
	b=QpP+DL4xWiU8ZrhsjKvYVvDqjwAj/GSMETp5OJec5IICm7VKUHk/WnmGzP9w6x5fpmr/
	 w//2hs6k4hsot7Td4RsNXu3kgqGC5mttdJIoGZ2KAiVQzsqu0sBhnW/bctx8BBvqAvodh
	 orpCHO5E7vk7XLl9nL+ZlMu4nxlq6obdvkGSN6D62+sqplmDgspngA8w8IHDTl123MMZ8
	 cYsBK2bVDskYAWMzzjtTuXlx5mBCWsnvUQVdP2XpHy4wYmlBQZsIhF53Az+9jPv2KrKq6
	 PZjTSUMfIfwmoXuHAsCTGNsOtlv+u+k+f8m2NczZXOCIyn7qJLHYXVQtnfyRPHW/Q8Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Z7ZUn+9K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401846;
	bh=uxPU5udFIJ2qZ6ViQtiNzzfJiTm4fvV1qMLvQ8GRl7s=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PmxurXCepFqPsK5PN5Gg/cEXMf+h+Nz62ufpKPNjuwWYDdD5DxvrwM0AfjRkrg+14
	 sa0G/wF902LBOdCmwmWhFTufZnacqSiqshaB6WPg+MD1mClLJTPGIeKc33wXGeM/Dn
	 5fDhLW9NR+rqzD/bfsCahtBFX3p4YPDYNlLHbAWl9+zRDmi0/npYHfzrs7oh2UR3m8
	 /3lSoVJOftgAaqCrFAKvT2okMBwoZS9/bG7N0yny49PJlYG95NtF3iZikwzZvA3Im5
	 Vg3zNx7FJB+jv4W8Z/cL/FdlxsjLvnOFYdt7Ne3/1eDBWh/MYF/7+lcZBgecD6yMyR
	 1DuyB4Wgo5jiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 960D7605F1;
	Mon, 19 Oct 2026 09:24:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 578C61DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49C75605D4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9AR9MX9pcbm for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:24:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C16E605CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401843;
 b=Q8RU4gBVnDhgxeL4bXCMzz6f/E5+xN6KkPILgZmbd58rz7qFMads4WdXtVU50neC6+Ff
 nZ1g4uHB0HqnTX66oL70N1033dn/B3YG9wEzWUrPmlFBv+ku1uJgWXq9dtSeuQ5IRfG5u
 kmXKg1XpDWa8+lKmbHd0xKbK4LgsvvD7fUVnm9zLuuLYn6iuCUlt6h49nUD5KLx7wl7pZ
 2a7qY/xxvo8T9es66D9QjjUEjc0t/1OKdd+1PoyiGMza3oUrs8/Eudq8gjaThDNaH9Wyd
 tK3THeQGJCQLtho2F6PI/NWztumHmUXRok+H7vWZu8Qat7A6DG9XxKtUu85BqW3zBGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401843;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding;
 bh=uxPU5udFIJ2qZ6ViQtiNzzfJiTm4fvV1qMLvQ8GRl7s=;
 b=guCMGaQo9jTcWtMbie75h9NgQFeXPpH1MY2d5J2zY5kE/BNPGPC1z72pGGrVdqlBTl/O
 clGOxQFNqnJq1+6rCE2JlB1Bf6OSYHtZQ+atxzR3OJFm5yqdklGGVpMgDEZ6UkWaiA4lJ
 dTvfzLrctV4mMUJt2rHNMbdcMR6BdYo9S2DNkvf39NqstLYnhkIY3pYwQU5nlbW2hJBHH
 q3/w194ZjgGak/iCyBTRjMmO7XsgjgJ8Hbjlzj2izIB+ewIvQt7JRK8BZbOtWGHs9D1eG
 AV/hIlt/LXIbyoCNQmGgxrYI3yyxK40HwRCm7ChXDFSiHIjmVXuXphhT6q+ltRLFRrA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Z7ZUn+9K; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Z7ZUn+9K
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C16E605CB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:24:02 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3ab4178ee33so1453513a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401842; cv=none;
 d=google.com; s=arc-20260327;
 b=R/6pvqjQ5Fo5HaDHy3Tjovqmi4JtJk2AY8Ii2fCwoefERBovh/HVfUjm14mpKl6NuI
 zJ880xhd3A1PcdUEA/b3UhC1+tLIZMeUq0O1QOWOV2PEN7yMVWJ2GJ1qoUh47ydu5muZ
 hnxUJLrUQJk+xZEe2zIUPBbsiuxdExIwRxrlAEApSzXzzEbHETTvCVS8Vnuj/w9vTSod
 +LfdF/bhdnoe++7bGwJeyHGdUTiK1ctubZR2g3moqqkX1WFkBpqfIlDs4YCZhTkTiJ99
 YWgA+OBYIQbBeZOwDAGyFj1WqFXe2A6FroUbUCleiF7SQ22bOZrYEdPWq3xEQXLWwIJF
 8z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=uxPU5udFIJ2qZ6ViQtiNzzfJiTm4fvV1qMLvQ8GRl7s=;
 fh=kcTwKzLIqR/+Se2R+6jxC+vUBOe/RTTnwqJw2bt0OAk=;
 b=rxIWqYnFbcI6Dm+G8OFkXkcyylfei9MyC03bB2spuiq0mAhWm5GbODbaLEEQrtyI8s
 h7hnNYPorFGNiq/YQlBfE1x2fuFABs2lvuVfeYZ92RbCFJrGnHXaLVwNZLyAG1CzCLCQ
 QCYQ1CXlcAN/595NaYYDC/eelq6Z/fHomSaO3V3i/5D8HwJLhT1/ln9aclKVHus8sh9U
 jbI/meP4HUjaPqSPHXfnkjO3hnoJ5W8gAiQ9Y5GCX8ilcudXD/ucv18Hup9Zd0pM7gIZ
 yJZ1dHIVukEMolf/PRagFTw2CJY4OvvUPRj6c92idOi3BRQjIcMXr9ltL12HGGgOJs96
 QfJQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401842; x=1793006642;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uxPU5udFIJ2qZ6ViQtiNzzfJiTm4fvV1qMLvQ8GRl7s=;
 b=Z7ZUn+9KrrBU1Yk7mej61VGoNQd/gJnQFaC93/AmLPcJ5DI563yy9kpStMCsO9uhEA
 VpABm391Y9nxM33HjSolJSenw45cZKsrDE9xFXtS4ePtebAhS9+lO+Nt7303I9CwU0PZ
 ZXjsfpsIWIBFPlHDQorkHHxrtUcsc9C2P7NmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401842; x=1793006642;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uxPU5udFIJ2qZ6ViQtiNzzfJiTm4fvV1qMLvQ8GRl7s=;
 b=07+3Tb6YwMzbS9zMHUOI6iBRpLFtCNr69sMleDFkAwxZSaaHHUdNlBJ3QBYw3rF4Jc
 GQ25moUA5OKghpuu7MdiIRU/I34J1dHv3NGfSyKYDcGOvPiR2JCNSqi6qN0FvWaIqo0W
 Jf6p/v5zC9e06SaDJuOIUIz7BE8Z3KxuC9BXXvl6SI6Eo2E3TPQZE/ubn9PgWHWHDFrn
 FQZdrT9uKyHm+MMleZTCdbqx135Qsvh/ae0+K0Ja06e35ZgH3HUr545a2w3M1vCY43Bp
 exv8mySJidlhW6voUObg2lHqxmDtIbzAvQP7qW5L9K+JVq2otBucoDEcCSdhXXisYEB3
 hQNQ==
X-Gm-Message-State: AFq9FYJqhjohsVrOJQnslYRybMDZe2e3HDqqxwWV4uGbqH9axetwtco0
 seke1Qf0aNIwr+ym+zpH8mOruc5+H0LGmcy6aGS0UZAUE4rrIRkc/GOz2dDkJHeiAbas93hC5BV
 1spVB6n6uNVJ5x0sNGFAv/HhY5b2jjNaHwT3S33w4
X-Gm-Gg: AYBFou0RYSXjbNJC6NYkkMZZqUQc0uxrnt8xf63CmcWr18eykuDIk5nYC58lwkWQ5IF
 BNJsPCtwW5WDSZrtfb1MAjKBK/FRcSIenLFvi/tTMcrJbK99T3DFZXTiizVW9n3qVplcotxyW8M
 r2LzGU6WlWf22ApwNoZNO+/WsfSJEvGai5f+SDkCH3qMYG1O9sQJHcmEauBYMSd2l0WyIbLAt/O
 P3hJkZRHhwu56hNIJHS6Atmmb2DWPJiPk0h1mblY+UIBLNxOX09awQK4hsh6ZuABANc7hNUiR6M
 kSRug1hIlwcrb6QFhDJlt7/tAH1rUlEW0i8ovEGtwEhEZ+u6H6PoRQ==
X-Received: by 2002:a17:90b:5109:b0:3a7:ef4:164b with SMTP id
 98e67ed59e1d1-3acee2958cdmr5300039a91.2.1792401842233; Mon, 19 Oct 2026
 02:24:02 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:23:59 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 06:36:33 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-5-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-5-d7e290847543@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 02:23:59 -0700
X-Gm-Features: AclHuK-y1u6ihun5fwNZKNMP-FVUYEycSSUIRXBYMSjPXS7Tfl4ALIg5HWN3lR0
Message-ID: <CAFLszThxQRp+RtkX2HmOMG-YHfKY0zd0fBm=6we8PiJnNjoPrA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] boot: Add a choice for the compression of the FDT
 in the FIT
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, Alexey Charkov <alchark@flipper.net>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>
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

Hi Petr,

On 2026-10-17T07:38:59, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> boot: Add a choice for the compression of the FDT in the FIT
>
> Add SPL_FIT_FDT_COMP so a board can select how binman compresses the
> devicetrees in its FIT (none, LZMA or gzip). LZMA and gzip are the only
> algorithms the SPL FIT loader can decompress. The default is none.

Just to check =E2=80=94 do we need a user-facing choice for this? The exist=
ing
FIT_UBOOT_COMP in rockchip-u-boot.dtsi picks the algorithm from
whichever of SPL_GZIP / SPL_LZMA is enabled, with no extra Kconfig.
The same pattern would work here and would avoid adding a choice that
every SPL_FIT board sees in menuconfig, when only Rockchip uses
fit,compress today. What do you think?

>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> boot/Kconfig | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -236,6 +236,38 @@ config SPL_FIT_FULL_CHECK
> +choice
> +	prompt "Compression of the FDT in the FIT"
> +	depends on SPL_FIT
> +	default SPL_FIT_FDT_COMP_NONE
> +	help
> +	  Select how binman compresses the devicetrees in the FIT. This is
> +	  independent of the compression of U-Boot itself. SPL must be able to
> +	  decompress the chosen algorithm. Only boards whose binman description
> +	  uses the fit,compress property are affected.

If the choice is kept, please tighten the dependency to 'depends on
SPL_FIT && (SPL_LZMA || SPL_GZIP)'. Otherwise every SPL_FIT board gets
a one-option choice offering only None, which is just menuconfig
noise.

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -236,6 +236,38 @@ config SPL_FIT_FULL_CHECK
> +	prompt "Compression of the FDT in the FIT"

The symbols are SPL_FIT_FDT_COMP_* but the prompt doesn't mention SPL.
Something like "SPL FIT: FDT compression" would make it clearer in
menuconfig that this is SPL-only.

Regards,
Simon
