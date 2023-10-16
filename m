Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184CCCDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 19:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47B986D18;
	Mon, 16 Oct 2023 21:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eXi0ILiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A0F86BE0; Mon, 16 Oct 2023 21:02:20 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D4E80834
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 21:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so749856966b.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697482937; x=1698087737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IwX1i33i9tsWZUt2NGNFlW7DeYlL43YO8somfEXxIT0=;
 b=eXi0ILiU/DU/yCuqhssL4Dn3TsFFFDiVrjWh6Z5mTGaR7KyyRTsHgrsYbqD8qwwtef
 ylmBvEZonNZi5/aXM59H3y7T5sSZHeu5b7b5c5G8Skb04wX+fRti0NdV7G9cn6C80y0M
 FZgU5zoe0xdAdt1lGc1Ztg3HyQoTDylrl2wBRDtDLLNKKpaHT5kFV58ZwKstoO4JunvT
 E1/t/yyUWRTufwUSKu+iEMb4wfU7LACW/HRhxAG+fKBwmp/iHvs22jrOpNpDJrXol+RL
 GRSlZSjZZHvk3VCBHGzLuvn7kA62zjBtaMSWErz2Ut9s5AmbMkKaZHNdsbqEECGXoh5v
 wTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697482937; x=1698087737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwX1i33i9tsWZUt2NGNFlW7DeYlL43YO8somfEXxIT0=;
 b=HPuuaExXyp2crHsu17/gPELLQI9CKGFCfwg26dh3HAYgSzw69DdaqLGGNO4gTu/REn
 iqVTZOKEB2OXB3fvVdKiJE/EuOvhSknvt4CGVcdkWtVzTFT+szoDL81fVCcBMI0zF6QK
 YvGJ5SXKr35jLrUkOSDHbtr/aUNsQxvmKApiRgFRwy707x7DwvCHc+Eu0/92FDZFdddL
 iuo+zJ0b7D926q+ly/5Aq3T0eh7TQLkInfXQ3ZjMmzkKBaPP+aKqB84UFCZKtg8iwm1v
 j55rf9+lDZsPqKY0pInB5jLXqIlk6CUmmAHlWfA7ZcuTDpPed2OwlB04QaRF0c+f43iU
 AT4g==
X-Gm-Message-State: AOJu0YwwSB+T6z0qYgtPwLAKRCPBGypFQiQPQ/fi/T/D06hOw8hiRlFT
 BbmUeQ9OB0qx0+eYSgM6JIggTlWjd/hoNHg0H7c=
X-Google-Smtp-Source: AGHT+IFRd/yo73Q4iTSc1JCgF7QV2aZo354IY3B9jr41DZfAvI2DHtzxZ1dv8jjPkHXpesCAaefCus4qGDpdtl4zxGE=
X-Received: by 2002:a17:907:1c85:b0:9c4:54c6:8011 with SMTP id
 nb5-20020a1709071c8500b009c454c68011mr2965711ejc.42.1697482936626; Mon, 16
 Oct 2023 12:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-8-masahisa.kojima@linaro.org>
 <CABfBAmBOSLp4VAfTepU8n63MjXcVMWzzNtPv4309UhZgfVN4zA@mail.gmail.com>
In-Reply-To: <CABfBAmBOSLp4VAfTepU8n63MjXcVMWzzNtPv4309UhZgfVN4zA@mail.gmail.com>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Mon, 16 Oct 2023 21:02:05 +0200
Message-ID: <CABfBAmB3pdvdZGcStpprSEyCovK5JFyw4O0Dn_hJyPZ1h_ZW3A@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] Boot var automatic management for removable medias
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello again,

Em seg., 16 de out. de 2023 =C3=A0s 09:58, Jo=C3=A3o Marcos Costa <
jmcosta944@gmail.com> escreveu:

> Hello,
>
> Em seg., 16 de out. de 2023 =C3=A0s 08:47, Masahisa Kojima <
> masahisa.kojima@linaro.org> escreveu:
>
>> From: Raymond Mao <raymond.mao@linaro.org>
>>
>> Changes for complying to EFI spec =C2=A73.5.1.1
>> 'Removable Media Boot Behavior'.
>> Boot variables can be automatically generated during a removable
>> media is probed. At the same time, unused boot variables will be
>> detected and removed.
>>
>> Please note that currently the function 'efi_disk_remove' has no
>> ability to distinguish below two scenarios
>> a) Unplugging of a removable media under U-Boot
>> b) U-Boot exiting and booting an OS
>> Thus currently the boot variables management is not added into
>> 'efi_disk_remove' to avoid boot options being added/erased
>> repeatedly under scenario b) during power cycles
>> See TODO comments under function 'efi_disk_remove' for more details
>>
>> The original efi_secboot tests expect that BootOrder EFI variable
>> is not defined. With this commit, the BootOrder EFI variable is
>> automatically added when the disk is detected. The original
>> efi_secboot tests end up with unexpected failure.
>> The efi_secboot tests need to be modified to explicitly set
>> the BootOrder EFI variable.
>>
>> squashfs ls test is also affected by this modification, need to
>> clear the previous state before squashfs ls test starts.
>>
>> Co-developed-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>
> [...]

> Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
>

Sorry for the previous reply containing the wrong tag. Here is my
Reviewed-by tag:

Reviewed-by: Joao Marcos Costa <jmcosta944@gmail.com>

--
Atenciosamente,
Jo=C3=A3o Marcos Costa

www.linkedin.com/in/jmarcoscosta/
https://github.com/jmarcoscosta
