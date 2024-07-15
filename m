Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AFBC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9667D88919;
	Mon, 15 Jul 2024 15:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="InX7lrSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BE688827; Mon, 15 Jul 2024 15:31:46 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D3388908
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-65fdfd7b3deso16456337b3.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050303; x=1721655103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RNmDc4m1EBoVH5yjEOEfSzezFACLvl29Bp86u6QFBnI=;
 b=InX7lrSlStQQwkQ0Y8lJS3e0ly79p8IsNkcur0LAU+UXU8XZhESkUJpOm765hnXi8C
 AXy9/Vnk96YPEthwcQHo5TwNjDK0UHpfYSbtiROHWDFrinrYiI2DvfIIJ4mlP5OSWmRN
 4HUKR0J8keuPxaAFv27znrwFFasFUAMoukg2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050303; x=1721655103;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNmDc4m1EBoVH5yjEOEfSzezFACLvl29Bp86u6QFBnI=;
 b=uPEiQxmGbzFStXIwBtVo5eDaG2k6CdkRtdMW2bY/p2MoobVErox+5NSew2oaSw/e1C
 WVCnrGCkTI2/tf0cfwvo4MdvsPPRlNMSxqxHQimqsCTWp5z08wGEzKyXeRqUdAe6XmnA
 7xwiFp/8gG1+1xe7CHc3lZDVU7zJgW8gnPupc+aCm9tYZfNEoN3i/VXvLiBkZPgTexJC
 Tv8I7S099NZszuzPVAqccGwhtju6brSn/0Zva+hckZqPcxYqMssz7pyOCYkm3VCb6zDl
 WWnFPyCJ1Zunpq33vqlROThezraO+4UKJmrYQTo6Q+WqpjEeM8OroP/vetHPniMDnqea
 81tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWOw+ffynUx//+TTZfz3+wEmhHKFMN2xSkTOh2FfItSpi+oRKI5wSlpPHjcvRLpJDRDA4fffjKNPfZ5uZDQr0HNzh9Jw==
X-Gm-Message-State: AOJu0YzXOBySmVCCLo5qIhv3dlM7h56IG4Oee0ngg+5lfoHcGgZyIE7R
 USk+J4+sy7Sv8H0SVvmrmFUH1Sbvt8p5qOofK2MQceLNYxHJHSXaHtiv1vVftARW8oNy2/81OVC
 ZOzBVgPf1zTVolU6bbd/hkJpp+grQG4qIOxpVIHi/BXZy99Y=
X-Google-Smtp-Source: AGHT+IGPXxWFQrz6viD8pVax0NIWVp4GTjL9A+ARqdtXaOeuPFCQTsVvyRKuq7oqXFy0GG5hTxyfmHaRpZStyHO6HI0=
X-Received: by 2002:a05:690c:c1a:b0:650:1ee7:7689 with SMTP id
 00721157ae682-658f02f4cdcmr221255247b3.35.1721050303148; Mon, 15 Jul 2024
 06:31:43 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 08:31:42 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTg+XCKjksG3BPz0yFEC6rQdsCji0QhdVeQhpY_RF-7+2g@mail.gmail.com>
References: <CAFLszTg+XCKjksG3BPz0yFEC6rQdsCji0QhdVeQhpY_RF-7+2g@mail.gmail.com>
 <20240618172820.5570-1-ilias.apalodimas@linaro.org>
Date: Mon, 15 Jul 2024 08:31:42 -0500
X-Google-Sender-Auth: QpMi1N-2eGLxcF0msXml3qcqKzw
Message-ID: <CAFLszThyNJ=zVnxw_5cyt3D1Xf3eYyDL5FhMgvFpjddzTLxZqQ@mail.gmail.com>
Subject: Re: [PATCH] configs: enable setvariable at runtime on sandbox
To: Simon Glass <sjg@chromium.org>
Cc: heinrich.schuchardt@canonical.com, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 18 Jun 2024 at 18:28, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We currently don't have any boards enabling CONFIG_EFI_RT_VOLATILE_STORE.
> We do have EFI selftests testing the feature though, so enable it in
> all the sandbox platforms and test the functionality properly
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  configs/sandbox64_defconfig | 1 +
>  configs/sandbox_defconfig   | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
