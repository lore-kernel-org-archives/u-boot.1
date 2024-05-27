Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C50C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 12:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEC8D87EDC;
	Mon, 27 May 2024 14:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I9ns7KNr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5B1882AF; Mon, 27 May 2024 14:01:51 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682DF87E52
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 14:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2bd816ecaf5so4283676a91.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716811307; x=1717416107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYSMIYrayVPB5M63UZO9lISlNsr1vJQxV4q3KkluqaQ=;
 b=I9ns7KNrSh49yaHMJW9w584g/6xmzSg3LbjzmmpV4wpZH5411CCf0VhUqLhZiECkiE
 +WjADH1GYKoXOImViLomC/CNzaPoYBmBJPH3pp4vfBlQpbRkj+bCz5unFWf7COT6x9V0
 9BeKCB/MklWZQLEWqLhV8/YnjL2puV4+Jp87fWBK0Lr08NN1urWdvumSGPTbQrF8Z9HG
 Jxz/sUBdql56W3w8+CncpYbWoNJmYyv0O9337J3WXBO2fvCi5JO4eSzWeDHRH0mqMTUR
 qSXH1kLMXKQAM9zKUvQsr5v/X+LoMcdZ4m6qQ5r+hkVijlP1QfMXI0Eg6yw9R63RvUUL
 bOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716811307; x=1717416107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYSMIYrayVPB5M63UZO9lISlNsr1vJQxV4q3KkluqaQ=;
 b=krDDost32SFz5OJSZTfzY9RDmWzhYX+djsBj/SB+zFOcz4ypgt1vuj2crLAygZLTj+
 mYge1PK4zGH8Cbha7M6Gb2xq9wDvr5LmWh1cd4WtyM3q6dyDoIzbpSzEZNvdF/Fd3kZz
 xsvDNjvgYBFF8LLNTKk+jRYrs21y0odydGCzIwCtGVWHrKpH1YlYvYZMide1jbmhzGM9
 nX71ZW7zIbAbu/c6379Zmir616SH6foveJVM04Ud0hg/MxQrUf9+PYqqY/+CcLG5hLUp
 WlY0i5XXNMHc2EB4XyEoIwZ2p499Qpgl7n1RMNCGhpPX8F232ZuMKY73NN1JhMjhT0Uy
 gqHA==
X-Gm-Message-State: AOJu0YzVGAK4qZWb1dRQzbyWcS+9mxgasrERjkh2gyin7ilZP8FaswKy
 LAtmYbU1Tt6yihRNpeb12j5N8t0idV+WhlkWRE6zGDVqy1JIn+JRD1emG2VfpdMgWZ01hFYQLL/
 mfz3SSZWgnznz2sap7lOInGTKhNu1wPKCAnGFZ6hEYB9SFimB
X-Google-Smtp-Source: AGHT+IGnUOObnDdWJGXeYYLUPuAdjO8LRt/beljVEmDyac66xb2uT+ompPsXv0e+D4kvzOJksFA+w2zWRyPKEDKWfcg=
X-Received: by 2002:a17:90a:d50b:b0:2b6:ab87:5e5b with SMTP id
 98e67ed59e1d1-2bf5e171cecmr8381969a91.9.1716811306551; Mon, 27 May 2024
 05:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240527061504.19822-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240527061504.19822-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 May 2024 15:01:10 +0300
Message-ID: <CAC_iWjJo+2wQBw5+a3PJRf6X4X2akTuW_EuC+0_A_NsSmoMzVA@mail.gmail.com>
Subject: Re: Pull request for tpm-master-27052024
To: u-boot@lists.denx.de, trini@konsulko.com
Cc: tharvey@gateworks.com,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
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

Hi Tom,

Don't pull this please. Miquel added his r-b tags in the meantime,
I'll queue up a new one

Thanks
/Ilias

On Mon, 27 May 2024 at 09:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tom
>
> I know it's not early in the release and although this contains a new feature
> apart from fixes, I prefer this going into -master. The added feature
> is on a TPM cmd and is harmless. If you only want the fixes please let me
> know and I'll send the rest in -next
>
> The following changes since commit a7f0154c412859323396111dd0c09dbafbc153cb:
>
>   Prepare v2024.07-rc3 (2024-05-20 10:05:16 -0600)
>
> are available in the Git repository at:
>
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-27052024
>
> for you to fetch changes up to 89aa8463cdf3919ca4f04fc24ec8b154ff56d97e:
>
>   tpm-v2: allow algorithm name to be configured for pcr_read and pcr_extend (2024-05-27 09:00:27 +0300)
>
> The CI https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/20873
> had no issues
>
> Please consider pulling
>
> Thanks
> /Ilias
>
> ----------------------------------------------------------------
> Tim fixed
> - An inconsistency in the reported active PCR banks.
>   This was only affecting EFI applications requesting the
>   active PCR banks from the TPM.
> - Adjusted the error message when a reset GPIO for the TPM
>   was not found. It now prints a reasonable error message,
>   instead of just printing that GPIO was not found
> - Enhanced the tpm command functionality. We can now define the
>   algorithm(sha1, 256 etc) we want to use while extending or
>   reading PCRs
>
> ----------------------------------------------------------------
> Tim Harvey (3):
>       tpm: display warning if using gpio reset with TPM
>       tpm-v2: add support for mapping algorithm names to algos
>       tpm-v2: allow algorithm name to be configured for pcr_read and pcr_extend
>
>  cmd/tpm-v2.c               | 49 +++++++++++++++++++--------
>  drivers/tpm/tpm2_tis_spi.c | 21 +++++++-----
>  include/tpm-v2.h           | 77 +++++++++++++++++++++++++++++++++++++++++--
>  lib/efi_loader/efi_tcg2.c  |  6 ++--
>  lib/tpm-v2.c               | 82 +++++++++++++++++++++++++++++-----------------
>  test/py/tests/test_tpm2.py |  2 +-
>  6 files changed, 177 insertions(+), 60 deletions(-)
