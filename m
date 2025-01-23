Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2982C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DADE80763;
	Thu, 23 Jan 2025 15:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="luL1h+Pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B976807E0; Thu, 23 Jan 2025 15:37:41 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 593BF807B3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d88c355e0dso2038073a12.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643059; x=1738247859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hBEDj0hGvnb3fRu8braKoCcp++LCszzSWX3aXgnYwsg=;
 b=luL1h+Pn7VQDmtQ4BXw+p5xcZmlyAxz6K2DKWkdYOnOOil32vHbZ7uj9Qqe4W3U1MP
 rLizMOTKJnnngt8Cm1CjyTZM/AzlYonVlqwhZyJzsBD6D2MvNFOOt/fw06c4wMRogAVV
 YVJTFqeqhlTx2ylYcgyz6D1la5e3IZcBCd6u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643059; x=1738247859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBEDj0hGvnb3fRu8braKoCcp++LCszzSWX3aXgnYwsg=;
 b=QrH6eZksQVOo5l0t8tLoBUneBOphWX2vm85Wg+n7z30Z5Jc6QTbN9vgVy4SM7mfRDM
 yaLIizRELBnr+DLgT7RCvKce5BA1fl9GOxohxA2R4zGULSI24InNTQJNixgZH7ZGsjgA
 yslInXEfrQ9KiJVG4tDOeOaxwcJDticwMI+twDTwhU7RKTQu/LH+eup8JmdraZ7JziSM
 wPbcD292ShOb6dP9K9KImCd/58uaYZc1jMzDbtepIFfI+2LXskHMNqhJiUB3CXKSynuY
 MuRrMKxfqezhXV58ThJMJN0ycbxF0jf3hErJGkYlDf2/rZBy7kjLo2Z3r+rANBgHSzlF
 JkfA==
X-Gm-Message-State: AOJu0YwAeaRhOfai8tBvtVHyXgy5xGOh+sWalZnh7lnpfjkBhDWCvQKB
 jzIBjmfVpx+Usxv23DktoAsFEsTzSyvbZi0IUak+szKJcIp5sH64r6L0WzE1CnFrRy2rNmUwUrg
 vIgqVZo1HuTsPc4wBzJOCDz/moOI95IWr/snT
X-Gm-Gg: ASbGncvpovRypg0Vdc31oSyhk66/S4Cjjmq7jp+kh+il1d5j3wiIp4yPDsNhv+313Lb
 8owfnMQikerjaUoZYONkP2E85NDCLoZiBEvGDi60fwEtt3cURvgt01SuYgTnMZIZ+h81yGr/dCQ
 ==
X-Google-Smtp-Source: AGHT+IGLaoYffVX3shTzXlJYVsOQ/oFGM5IdIszd3cbCC9cnEoLYE8w1QBvQ/SZDmryLRT3itRXqC0gxT8lvFv4m/eg=
X-Received: by 2002:a17:907:3e1c:b0:aa6:4494:e354 with SMTP id
 a640c23a62f3a-ab38b42e5f5mr2304964866b.42.1737643058758; Thu, 23 Jan 2025
 06:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-20-adriano.cordova@canonical.com>
In-Reply-To: <20250122170858.961359-20-adriano.cordova@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:37:26 -0700
X-Gm-Features: AbW1kvazQudqOSqse_LjgGDjXYJL2EPN_9o49-3_PDL4PF0zRkaMF0ubR3DnhKE
Message-ID: <CAFLszThCwGRxjXRSeNKXQkL_g4uBioD1bsyquiP+tZxvn58Jxg@mail.gmail.com>
Subject: Re: [PATCH 19/21] py/tests: test_efi_selftest: Add test for counting
 EFI netdevices
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
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

Hi Adriano,

On Wed, 22 Jan 2025 at 10:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> check that the number of ethernet udevices matches the number of simple
> network protocols
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  test/py/tests/test_efi_selftest.py | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
> index 310d8ed294..af9992a6f7 100644
> --- a/test/py/tests/test_efi_selftest.py
> +++ b/test/py/tests/test_efi_selftest.py
> @@ -195,3 +195,24 @@ def test_efi_selftest_tcg2(u_boot_console):
>      if u_boot_console.p.expect(['Summary: 0 failures', 'Press any key']):
>          raise Exception('Failures occurred during the EFI selftest')
>      u_boot_console.restart_uboot()
> +
> +@pytest.mark.buildconfigspec('cmd_bootefi_selftest')
> +@pytest.mark.buildconfigspec('cmd_dm')
> +def test_efi_selftest_count_netdevices(u_boot_console):
> +    """Test the EFI net device driver
> +
> +    u_boot_console -- U-Boot console
> +
> +    This function counts the number of ETH_UCLASS probed udevices
> +    calls the EFI net device selftest to check that the EFI driver
> +    sees the same.
> +    """
> +    u_boot_console.restart_uboot()

We should avoid restarting U-Boot in a test unless there is a strong
need. It makes things a lot slower!

> +    response = u_boot_console.run_command('dm tree')
> +    lines = response.splitlines()[2:]
> +    ethernet_count = sum(1 for line in lines if line.strip().startswith('ethernet') and '[ + ]' in line)

This test should be written in C, e.g:

struct udevice *dev;
int count;
uclass_foreach_dev(dev, UCLASS_ETH)
    if (device_active(dev))
         count++;

> +
> +    u_boot_console.run_command(cmd='setenv efi_selftest netdevices')
> +    u_boot_console.run_command('bootefi selftest', wait_for_prompt=False)
> +    if u_boot_console.p.expect([f'Detected {ethernet_count} active EFI net devices']):
> +        raise Exception('Failures occurred during the EFI selftest')

Again, this should be written in C and use run_command().

Regards,
Simon
