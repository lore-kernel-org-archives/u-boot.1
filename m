Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3848C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F7A84A4C;
	Mon, 29 Jun 2026 14:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nEkrH1V6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF51D849F6; Mon, 29 Jun 2026 11:16:20 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDB3849EF
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so4304921a12.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 02:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782724578; cv=none;
 d=google.com; s=arc-20260327;
 b=IjH1n1RGa4xN8a94GJS4T6LP7IEMDEe16sU2eHwPiBvylviUvxCPa+cUhAI49ydwN7
 EhYcgzetHKBhE3EhcfGhlrGk1bmSS6PTE3bEVzZmNgE2Kobko8cazUJSWQCaVKS++4Xg
 IEww+GNs/HQXL2a+4koeglrxvMKic/im5L1NYZT6SnDcMfpFG6IC9QuAnCG/h7dviOgm
 YWjc85eoKnnXXu8N9uIwvAV0KQFQyP1ZFpvM6HqzKVtqQ/CtwMcbhSb1y3TyjemcpqHP
 Mj+2oMUZT0LLhE9eDU9nT6TUYlB0JEjVPbXwjj6qmA0Lj205e4Zch3kHQ30ZHwwjIiWa
 NqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rUQMPORPYr/IoU6yrXkzPB7/rd+qJ+5gpshyLy9imb8=;
 fh=YKmRQ/5dfcornsb05gKLAQrim6RtPp+sCXs9pi95mqs=;
 b=Egjlkyfgvn9He7WJSGh2onvmtncBS0xmW4sEbBTbOjfib4unzs+sO4d2/3AL/IJcbh
 VXo1shh9UNn9KflvjnvW41J3sdxFDTsyCm099DlC93jNkm3XP8/26+2rXGdUj3gIv1wa
 3NiMVwtyd7Hu03FdD3/EPElPqnSUPoj92VUR+eusp3p5tXvpZVc9gSZTWbC0bMyiZvR7
 n4ecuwP85mXS8bzB/9x1r8Rjq5ex7ggfFBwGEXsEa+enRvKt88pdUoCQFgncHgOIzuoj
 4LlKfZUWNA35Aqbx8Qf59fKc+lIF/MXDVr12UoxEXhkhe1xN4R4/vwQ28XUkurNbMCPw
 xknw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782724578; x=1783329378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rUQMPORPYr/IoU6yrXkzPB7/rd+qJ+5gpshyLy9imb8=;
 b=nEkrH1V6ifKYVwkeMsDbRj76IsXPdc+RbC3Gt1vv6DeCMvogltmOHGblHXBcFKQENV
 HHJcE3uJlyYx2wXhrqcL3y3ZfBhMCtEqLKMOiaS3WZ1AP6MR0NWneklhc4+aDslLFIKN
 K8lmnI8FVU9wAtDnaxNugJ/rqRZlcPEW3S/eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724578; x=1783329378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUQMPORPYr/IoU6yrXkzPB7/rd+qJ+5gpshyLy9imb8=;
 b=pD8xweNYsDPD8vQfBkULzOtCAEyAp9zHHJAh5N6OsWk/9XklUEUtXfORAKSW15LYSM
 ZaZlTa8FQrHfb1zhODYFyHKXN35qDs6c/RjFFzhzC9IH/C3ae0Q9Ev/T5d9g2QXaou1W
 Er5HTqaYYcXmbaE1reJSm4hM5hNYkyZQjPLA6mCMEmfcIJ/SmvCuNq2xX8Zs5tRQ2HR8
 l5AfcHnH8E9nq29eudFNtQvNzMokzz0mcNDhdKyIOPBrf8IgVYdrPJb8yJvXtWCVvXvT
 l001auEInLdB9DYmlv2UgniyvTaxE2l4yZOTaFMIr4ysLslstCXc8y2kJDlbu7eLhScS
 aOxg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqc/WvpZYOZX8U1qUdnJOaFzatS9CdY5/0tphUh+sHxbNglu7URgputwdm4XpA0p3i24ZD4O9I=@lists.denx.de
X-Gm-Message-State: AOJu0YwwYE5svBzq3tYjjPleqdioUqtEq0bA9+8xQVicwq40JlGOUeIE
 2LzdQ48gOq8isUchV0U+927hZBVGXt8RlJ4tJqzoRX6o6Mq8CGZNN7+A+iN3C1xBlHwXQ2fVKjw
 Wwk0iX2i9GnlBNpsB2t7X4MwZXVKtyWsUThbHTzEj
X-Gm-Gg: AfdE7ckap1j+p8LMYNKgqBZ3sM75txNLfoRyUL1bCfTNpxDsQe8wiDM1okCLwuGq09E
 pKmnUjI/Eo3rOHHs89OLftzEHChoMsIWXrJTKR2/BBLOAPbnviiwQMXZhb+KRjXQOrvpgxYfN1i
 x9t2Ljgiv6zIJV9/NWZ6a5ei77FFIZKRr3GpgSQpP0njXqwXLSs1TgWFOG9yWR48JnRJ6x3D1mx
 G1sFjxz4MPU/XyxBugtQEW0FpBZldJx7JyOFOueRjdapvaDbKTqQ+ZRSgzPIa0r6VaBdzBcTw==
X-Received: by 2002:a05:6402:13c5:b0:698:3b7b:e48a with SMTP id
 4fb4d7f45d1cf-6983b7bececmr4300392a12.32.1782724578135; Mon, 29 Jun 2026
 02:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-5-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-5-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jun 2026 10:16:01 +0100
X-Gm-Features: AVVi8Cf85DEn16-9BXop6WZxnPNLqQhI-9hQzpnqIWDcy4xbfOYaLeDVs3iLF6o
Message-ID: <CAFLszTjwS0FQKR-aPgg=6ZvMJ9Hkrcz-kLDCObN5t6d59NJtQg@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] misc: qcom_geni: Add minicore support
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, marek.vasut+renesas@mailbox.org, 
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com, 
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com, n-francis@ti.com, 
 mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 29 Jun 2026 14:47:37 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-06-23T06:47:53, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> misc: qcom_geni: Add minicore support
>
> The qcom_geni driver reads an ELF from storage and configures a set of
> registers and programs the firmware to the GENI Serial Engine (GENI-SE)
> wrapper device for the expected functionality.
>
> Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
> wrapper is pre-configured for one of the functions defined in 'enum
> geni_se_protocol_type'. Hence, the firmware download is not needed.
> Only the register configuration part is needed.
>
> Earlier, the boot stages before U-Boot would configure the GENI-SE (to
> access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
> (i.e. boot ROM) doesn't do that modify the driver to do the register
> configuration part alone without reading an ELF from the storage.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> drivers/misc/Kconfig              |   6 +++
>  drivers/misc/Makefile             |   1 +
>  drivers/misc/qcom_geni-minicore.c | 102 ++++++++++++++++++++++++++++++++++++++
>  drivers/misc/qcom_geni.c          | 100 ++++++++++++++++++++++++++++++++-----
>  include/soc/qcom/geni-se.h        |   5 ++
>  include/soc/qcom/qup-fw-load.h    |  12 +++++
>  6 files changed, 214 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
