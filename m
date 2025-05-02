Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19D7C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 09:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E8A78070C;
	Fri,  2 May 2025 11:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A8CtYZw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A33980F03; Fri,  2 May 2025 11:28:16 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44320803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 11:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so1924098f8f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746178094; x=1746782894; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laGktBNv4R+k9YxAKr6ziJSI7YkDxglH/5HDyASqDXA=;
 b=A8CtYZw5Ev/vZSkIvmN05/DLfAocCUPR73Sk6tGEKDuFVXds7t4DAxGN1ljBnPZT9x
 cpjx0QqFO7ZU0qrHC6KIgmm4Cg5YVrBoEaifDObmfYsxEiXK+Hyor+4rNH5aLbdEVVIM
 iUf+ieae7BTYv25uXol/4f/Do7tNQmbjcl2aAow5IoShG++5/hfBGvVoTstNPzaJElyQ
 SyoBsv3jY4sCWXOUgO5zGx9Aidr/xIV7BBwuodZzjcu8THB+LMnjjbYEchkWzRtZMNcR
 eu9KOy+UQIQdDj8iXyXBEmShfsd9NQA3KLPHya8DA+S1O5Gb51A37RHkUNwYhv3I4E4G
 rDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746178094; x=1746782894;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=laGktBNv4R+k9YxAKr6ziJSI7YkDxglH/5HDyASqDXA=;
 b=s6/rPtIy3IbLAdvIvF0XCbD/tssHOqlc4hiro4vCAoA2aGOxFDTAFshWEdBxGqWq8K
 kIC6E1OJxzO+CLI6CUJqvlBeBJg7W3aSoihK0snAMYLDsNd78y5TEmzqyvRz00bbZh4+
 jrEb6eSW7cFHdH0bsHy4J3Fi3rVp52A5ZUJLtnx+D9933GMZaXi1k2hvfj8KlwaYH2m8
 cri7SHlwLo1JjiZtIjuRaa9kXJY4qZEIskc/+8Z4XKd4JUEb6duiggGwyTXq8fUHyR4w
 gwpSZJq+sWKgSxhoRI+TwQvOKJyqliztDZUbHSMLKw6eh2QktIlbun6cPYOE28Ny2YYu
 i4tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvbgA7MADbftNquigwDDvCxZImcNcQQQVAwKUDVzf+RNnKfKzH6wTMyfwj0vGZjnTFEpJWl6I=@lists.denx.de
X-Gm-Message-State: AOJu0YzUk6r6V1gc9KkMzR3odJn6HtJAHEeaMTxNtlvMEgoCg2eciaQ2
 4X6F2E19rr+REWs+lAjBOGCXDk9OBXn3CGylxf9/10jdc4gPSbGWHB74p5m6unbX+eSMfad+sL/
 L
X-Gm-Gg: ASbGncvtT1Y67RlxIjpecDUnf0VSjsC+jz61sKADQlrbLCoyFNQ+E9Rqa2eZDtkf2yy
 /XqS1fGGEPd3kSWORdd+x1xRsN2YD1W2B9n/kT+wVuTC+EdMtglW4kkg34NPDHd3VWLJzRRFr1V
 fs1bxCDYD5KtVc2WEFT+1mL40c6X6YZrVVH9EG4WjeZNQDoK7RB5GqbFmBWI83h2t4QhAicHw5V
 q7czdBURCSBbZmiu59x2azernRLa+cCieB/6fZc/e13nPMjopg/5FMbti5J0ztMWOKBfwX1Gb7c
 htZ9/nXkYinvSwn2bqSwf3ZkeS4boAtCuV2G+rooihzRqxob
X-Google-Smtp-Source: AGHT+IHLlHY8nUw5+TcWj8EMm3Psuh1VHUkfKz3eNDOlN13cbYjt+ai54Qwh07j14/6FuaRH/EwmBw==
X-Received: by 2002:a5d:64c4:0:b0:39e:e438:8e4b with SMTP id
 ffacd0b85a97d-3a099af1fbamr1280019f8f.50.1746178093734; 
 Fri, 02 May 2025 02:28:13 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b17017sm1619805f8f.92.2025.05.02.02.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 02:28:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 12:28:12 +0300
Message-Id: <D9LKH17KOI3W.1X2BUOB3TJWX1@linaro.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Tuomas Tynkkynen"
 <tuomas.tynkkynen@iki.fi>, "Patrick Rudolph"
 <patrick.rudolph@9elements.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, <u-boot@lists.denx.de>
Subject: Re: [RFC 2/8] boot: BOOTMETH_DISTRO should select BOOTMETH_EFI_BOOTMGR
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.20.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-3-heinrich.schuchardt@canonical.com>
 <CAFLszTgn3kXFrbsfbQCpJ0pHmgAvF2Df_V7_tTZ732k3Q4UVew@mail.gmail.com>
 <2c28be83-aab4-455a-9ced-602b7c6b1354@canonical.com>
In-Reply-To: <2c28be83-aab4-455a-9ced-602b7c6b1354@canonical.com>
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

Hi Heinrich

On Wed Apr 23, 2025 at 3:53 PM EEST, Heinrich Schuchardt wrote:
> On 23.04.25 14:28, Simon Glass wrote:
>> Hi Heinrich,
>>
>> On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> Distros expect the EFI boot manager to run. It falls back to launching
>>> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
>>>
>>> BOOTMETH_EFILOADER is obsolete.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   boot/Kconfig | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>> index fb37d912bc9..71ddb37f6bb 100644
>>> --- a/boot/Kconfig
>>> +++ b/boot/Kconfig
>>> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
>>>          imply CMD_TFTPBOOT if CMD_NET
>>>          default y
>>>          help
>>> +         This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
>>> +         launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
>>> +
>>
>> I don't agree with marking this as obsolete and your commit message
>> doesn't explain why it should be.
>
> This method was written in a way that per se violates the UEFI
> specification as it does not set up required UEFI variables.
>
> You must never run this before the boot manager as booting
> EFI/BOOT/BOOT<ARCH>.EFI if there is a boot option violates the UEFI
> specification-
>
> The boot manager covers the functionality of this bootmeth.
>
> We should delete this method.

+1. Do you plan to propose a patch to remove it and only leave the bootmana=
ger?
Or you prefer marking it as obsolete for a while?

Thanks
/Ilias

>
> Best regards
>
> Heinrich
>
>>
>>>            Enables support for EFI boot using bootdevs. This makes the
>>>            bootdevs look for a 'boot<arch>.efi' on each filesystem
>>>            they scan. The resulting file is booted after enabling U-Boo=
t's
>>> @@ -648,7 +651,7 @@ config BOOTMETH_DISTRO
>>>          select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
>>>          select BOOTMETH_EXTLINUX  # E.g. Debian uses these
>>>          select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
>>> -       select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses=
 this
>>> +       select BOOTMETH_EFI_BOOTMGR if EFI_BINARY_EXEC # E.g. Ubuntu us=
es this
>>>
>>>   config SPL_BOOTMETH_VBE
>>>          bool "Bootdev support for Verified Boot for Embedded (SPL)"
>>> --
>>> 2.48.1
>>>
>>
>> Regards,
>> Simon

