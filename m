Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF74C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 06:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FF58780E;
	Mon, 22 Jan 2024 07:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A6fSOTlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D2E877DA; Mon, 22 Jan 2024 07:44:35 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD49D87954
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 07:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so3249353a12.2
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705905871; x=1706510671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X8ENpfktBlmhO2eoJ8jCvxkc37AguTaRf0VO3VmQyO4=;
 b=A6fSOTlVK5IE6LWBAnQugiCSgfRhesYmjkd+ZjqT3Nnv50zXQKXMDgdneamUvrq46b
 XwyqE3ZUC01VgCUdw3OYYQdEDUzzeg2kjlFNmOnNFmD0guzWwAE42nogt8CaoPKsfh0k
 YZfSufpYw0wJzrVBrNsXI9CLCpqTYdKsy5aAZpG7hdWt4+Vf5GahvJvK7W/p76G59dW7
 ddf9aY0vwe+CjKNGG6ElL9opO6MioimJWoUlwkVCq4Nzox2bP7UaKViBN2i4Pi1NHFfh
 slGY7DD8v/7UXbJL7vAAW/CzY4iF+dNxmyU54JnrWrj9qS0Fh04CkVB1wo5VtzHkijaF
 5eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705905871; x=1706510671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X8ENpfktBlmhO2eoJ8jCvxkc37AguTaRf0VO3VmQyO4=;
 b=E5PE/DwZcW9uW/c+hlr/hga0q3NDTORDREahlAkvwvX7a5MYeylxY4lZeUfxLB/Yg2
 2zCbSI4+wnEEPICEXN808+6gjMljErr+3hbs1Fc5q/TrJNJIcFqcvqxLZF2KHCkbTyMW
 DTIOJYwXvDUnRuJVnK/1hrewQpmvOUkjK+b14W/+8tVQqKcNjsazwqObfAwcSSPmp2N0
 GQX4VnrzM+TF8trY2V+EqTKP5/Hda8NVcOUVLPx4UGdkBuVd2x9+9LD3Jyhty00S1KYX
 djIbRA9HriGRTUAFe0BhmxICpASrCjb2EXadBdhNKv3lkfOJiwWx/c6owRM6exB+/3Ug
 X7nw==
X-Gm-Message-State: AOJu0YxTkuA7ACVGx9bPJjwTvi3QkSziMYnkLk/fYSbBml1eaRq7V+Gf
 Regeny9DbeqSXSLYIwu37xWW4ti/vYb9tmx5aFq1WUydCiwnMIWazYamYKuSjFMUw8VMANWjIIj
 6tdp3NtY7DA6p9YjTtj+8VvBc2PVnPjmRkM6b5g==
X-Google-Smtp-Source: AGHT+IH514q1EaYWn9fNuEr77bk0bOeiJO4OYSuYLZs4Jqar5a0lz9H6ez6vNZ4qxLkZEE1GozdEYqkeLsD2ZkDmkdA=
X-Received: by 2002:aa7:d617:0:b0:553:2ce6:1447 with SMTP id
 c23-20020aa7d617000000b005532ce61447mr961374edr.34.1705905871346; Sun, 21 Jan
 2024 22:44:31 -0800 (PST)
MIME-Version: 1.0
References: <65a933ab652b3_da12cbd3e77f998728e5@prd-scan-dashboard-0.mail>
 <b74415c4-3be0-41aa-b6c7-eade599e2baf@gmx.de>
In-Reply-To: <b74415c4-3be0-41aa-b6c7-eade599e2baf@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 22 Jan 2024 15:44:20 +0900
Message-ID: <CADQ0-X-sXPzDBZB2dRkdVHYJbSp0TCP4pGasD7HtOqi8ORfnrA@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
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

Hi Heinrich,

On Fri, 19 Jan 2024 at 17:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> ________________________________________________________________________________________________________
> *** CID 478333:  Error handling issues  (CHECKED_RETURN)
> /lib/efi_loader/efi_firmware.c: 413 in efi_firmware_set_fmp_state_var()
> 407             /*
> 408              * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
> 409              * variable has not been set yet.
> 410              * Ignore the error here since the correct FmpState variable
> 411              * is set later.
> 412              */
> >>>     CID 478333:  Error handling issues  (CHECKED_RETURN)
> >>>     Calling "efi_get_variable_int" without checking return value (as is done elsewhere 29 out of 33 times).
> 413             efi_get_variable_int(varname, image_type_id, NULL, &size,
> var_state,
> 414                                  NULL);
> 415     416             /*
> 417              * Only the fw_version is set here.
> 418              * lowest_supported_version in FmpState variable is ignored since
>
> There are a lot of different return values that may occur when calling
> efi_get_variable_int, e.g.
>
> * EFI_BUFFER_TOO_SMALL
> * EFI_DEVICE_ERROR
>
> Should we overwrite the variable in these cases with NUL values except
> for var_state[update_bank].fw_version?

The var_state buffer is allocated by calloc(), and efi_get_variable_int()
will not update the buffer in case of error.
But it is better to set NUL values to var_state, I will send a fix.

Thanks,
Masahisa Kojima

>
> Best regards
>
> Heinrich
