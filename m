Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEF4C46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 07:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB97D87578;
	Wed, 20 Dec 2023 08:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IQql3TcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F298700D; Wed, 20 Dec 2023 08:41:43 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C228753E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50c222a022dso6504171e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 23:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703058099; x=1703662899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kf9xr2CwfB4xQlaSyfBEhugaaKI67Cp1Ch33FYr+els=;
 b=IQql3TcDlO+hVNTCDa1+qzPqsyLdVsEOnnwP7U0csFBOChZHoBhjsZV0SajDxqPYGC
 5h1AO27w/2PACqxkcrpjcIuiNo/C9dj4seIEurbMSxwKD09OL6ss3GbFsfMmaqSUJwWj
 CARVsYJoCIEes7ev963JzG3oit0/LkFtAjGyLn5ArgOF12LEHIIBYi8dI30CkP/SrN4U
 guvu7pibKvFqyoH1eZ1+X9V3gw1srsck5CsN4urwPxotnvExmJa9ZQLvaMIe5GobgxTf
 1HxKSyGBr/wKna1CLM7smsp8DTT779zNX1cQPa0WM6UE5jA/eQ/RmI4FqgDtc5n/pqcS
 ffmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703058099; x=1703662899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kf9xr2CwfB4xQlaSyfBEhugaaKI67Cp1Ch33FYr+els=;
 b=Y/8HTrgj75fcPxKDCkjfZLf9fOJv9eE4PyuoJIm+s9IMazZyNtuHnt1mcphjd8FpK5
 FBHS8HaUsreq3IQISpIrlY5nkbqHKKtS5Rs0VMMKYMDY7JAooveELwCg7oZe4+NNbNt1
 gqGEGAl02FYKlRwSePnFylC3+fGizqZ4Lv+PqYP9sd3+9l60H0TUmDsp8y+u4MezmnK4
 GU0Qz5td0mBh8C4Zg5C4+VH66NzL127n1wi5nsxDtw+8sNPMX3SiLI3lYZdPGQ5YGOCB
 VtXYWABkX5LjTwgfQXJ1iVCuGADDw6sRZxigocK04siEuU2EZFo1N2cNZ11VZw+3L4UI
 WSNg==
X-Gm-Message-State: AOJu0Yy1LhE7hYryaag9S0kGFAidNiwxGM7TPbaX3IJvEDlB6eAj2All
 aF+QkoJ9LE9ymC54BQJBmTuMTwbGyk/XcO2pkE23FA==
X-Google-Smtp-Source: AGHT+IGwre6pQ7UIeGATx+WAbHb+MVMWrrkzLCsMvngN2idOSpkaHfZPdlP+qyXOV64M2u2wIDsb29UCm13+rdnQN4A=
X-Received: by 2002:a19:6705:0:b0:50e:558d:b871 with SMTP id
 b5-20020a196705000000b0050e558db871mr62884lfc.40.1703058099476; Tue, 19 Dec
 2023 23:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <da935e1b-09c8-4829-b841-e53137165b54@gmx.de>
In-Reply-To: <da935e1b-09c8-4829-b841-e53137165b54@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Dec 2023 09:41:03 +0200
Message-ID: <CAC_iWjJ6+pd+ye=7mnevyCNWGJpHM2xYMHa_J3xEbisdDWNvYA@mail.gmail.com>
Subject: Re: [PATCH 0/2 v3] Provide a fallback to smbios tables
To: Heinrich Schuchardt <heinrich.schuchardt@gmx.de>
Cc: sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Heinrich,

On Mon, 18 Dec 2023 at 10:11, Heinrich Schuchardt
<heinrich.schuchardt@gmx.de> wrote:
>
> On 12/7/23 10:18, Ilias Apalodimas wrote:
> > Hi,
> >
> > This is v3 of the smbios series [0].
> > v3 has a bigger cleanup in the existing smbios code, folding in
> > smbios_add_string() that were sprinkled around  to smbios_add_prop().
> >
> > The latter is now the only caller of smbios_add_string().
> >
> > Simon asked for a selftest which makes sense, but we plan to refactor some
> > of the smbios creation code anyway. I am happy to add tests once we do that
> >
> > I've also removed the r-b tags from Peter and Tom, since some of the code
> > they reviewed changed.
>
> QEMU provides SMBIOS tables for x86, ARM, and Longsoon. I have just sent
> a patch QEMU upstream to add the missing SMBIOS support on RISC-V.
>
> Like we do for ACPI on QEMU we should not rely on the device-tree to
> build U-Boot specific SMBIOS tables but we should forward what QEMU
> provides.
>
> This can be done after the current patch series.

Fair enough. I'll add it to my backlog

Thanks
/Ilias
>
> Best regards
>
> Heinrich
