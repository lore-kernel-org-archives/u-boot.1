Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B88C5516A
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 342E683E21;
	Fri, 20 Feb 2026 10:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZADtH1PF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E10ED83E7A; Fri, 20 Feb 2026 10:14:03 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC72083E63
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c31ca77b4so1690675d50.2
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 01:13:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771578835; cv=none;
 d=google.com; s=arc-20240605;
 b=X3qd/wHW4eU8cZUeJ52T+ZGnlc6zMsOyQ1PlfQP6m//RzXi1ZhDHcoHP1e+9sjEDxh
 fOJUXsL6h7UHSPRny3SjzujS35gMk9Wq3vTKIT+Cf3MSxOP3FlnEzNCpTG3Vs2Q/FQQh
 ZQ+93CBmBIT+TTNbq9H54PCKTpQStUeomXbB1XWnp6H+9wrVnuhtptpP0SA6b186/sud
 pK4hcO9yi8ig3jWnsgIlMWYZO8ra0CgfZNG3acZw5ZbbFL7mPAv4u5Yn7tNq0DPPUNF2
 k/IBZPVsqy6uokiH9vIznmztF8Gpbpzlgv5OMTf2BCz7OcZoEj6s7qnKmxCHotFisaht
 wdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lk5vfAm62M5b0w5w2EWy8LzkLNenkyCD92DVmRRR4i0=;
 fh=qVPXZENsT8HTjc1yhpZmugGERdHloY1MZQ2O3ZL3iu8=;
 b=CWBDdJjO3b/SfWAG1fzSiLpfzRmtFI9H5DV8xa4xsiPrfp5DA22wd8cO67wJ0uiyyM
 5EvHKvy+gHTQ+h3HUrb5u5OC/5Ewn/ZRzU7oqnU0Sn6ygAqg8UeoI4tSZNP1HtlwlJBz
 A3oknTiKeabAehQ1pzrLC03XIMxgBnv8FPh/OdsnNIZlSEdg6wpPQVgmbbdSxL5oLXt4
 Dh5CINrlXCJKEOBzqbkX8qnr/8vvaCC6FpPq31nZQFkg37m/qPUglNmpzz3AVZx/le+8
 bErB1Pi353B6bmf+Qg50edlHYPkHrzU4a+xthdXA06xKYtwdKiirNAAS7DZyyHn6InuL
 OroQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771578835; x=1772183635; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lk5vfAm62M5b0w5w2EWy8LzkLNenkyCD92DVmRRR4i0=;
 b=ZADtH1PFhniI6pJjZfydyy2JmKMfhG9lOhOAaUMqn23Auy0fxt9qSixgw90Ymq1rFF
 xQ57xDoTK+2+US1NgES44JyBYPqEt1lKSbZee1XGN0SMSCs5UToSBS5+jVMHOKeyHPML
 dIFr/Zk5rZwnB0wbut6tiAVn71x+Jw3az5ZhecwOfRwdxvAamn29PzeXEQl/rKO3PitT
 RHA3rkROGUlAmPHeX4AiaUGjGr6zqirsP/nbnR2a2aLX+Yqro7UipRS4WQYls7gs+FCE
 Xh3h72tiIxrLPPYQIsXmrtHvhCKaBXXhezgP9yhEltoKrxMsPeYKPMuPNRCQen6zkuoe
 diTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771578835; x=1772183635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lk5vfAm62M5b0w5w2EWy8LzkLNenkyCD92DVmRRR4i0=;
 b=rGjapnG4TBdor0q4zYKxJvsi53QayhFG2IyrLPh/k2F3cQyBmaAyuO0UoeLAUuv094
 8qgBsvK2qUcCDF81KQd2K9MhHdvymWXLgUhUDPFOjWOe9ZUqd1n2AFfFz5YfPl1/6KE9
 5Nr0kosorrwS2HasUQJrZOAkznZt9U+2JX0dPG1haqckePCJHNjRU7eUFc78p3JTAC7a
 PwhdK1P6/lON49O0ammTw5DLdtSJxSra4wbRD55aNAbCgBNsvQaFRyGiD5KcVTaRM0k6
 9UHESQQmU9PjKjeYa2K6m7hh7qrCc/NQYmOCpCz0QJOVKrHBwWszTRfvw3UKsA5ChimO
 txLw==
X-Gm-Message-State: AOJu0YwiL/oQeYcD1azTtIkhs1OLXXWGNZpeE5W3H4wKEH+4ndEA0F3O
 KKlR852rZ8hYX2HFU4vxlrCKa805R9kSp9T5Y742WCJoLWpvMJb9AsDZNrAKpQYllrFx/tKen+x
 /3i7n93ZPwp1x3hbdcnfvN5wqtswoz0jQZIkdBfZU6A==
X-Gm-Gg: AZuq6aKSv/wfos9BZs/HSYNcKlzfjzgAQUsCaIm1C/EYe5fqetGEYzqXGbUP+z2AtJu
 aycG+sl9xWCvd4WsYR5LcwaES5mck216nhgcDEO5Z7YBzxTTLPjsT/T0H/LBtAiWKVjWGqSi8+D
 a6xQuX+7a1Gv66Zi63uItRpGVQNi3byfRfjMHPgGz0aHaOuLBuEk/Z8yqMMsphUkY2qOUx77NcH
 C7yybnogbN7QhOjlV0foqRjVvvPsa58W6PU/Mcd7GZzZPiI6r+6e7E+EGrsBh8EIC2JymUmmJtv
 LeT7TeK1hsBx6TvQ9F0GQ9lxnV4sNgNgA4We6chEbixG/Ociz1sCw+6ydvPDuZeJZbaqqmy/K9G
 xUNpev+lUNULBCq/62VxxE5LCRHPD+BLyMjNNzceUrFz22a0Z0qrJoVMI1MV4hGO++LQF46TuUv
 oM7NNZswVVF+KwB05oNPxlhCse7nbWrRhtxK3FAqfdk867YKS6C5ZNGM3GnBVXdCMXVz4/bAIdF
 SMYeZk2CFY/Fctwfnn4DQXv5nJPuv5p6i0MzYjSwlELh31GxzghtPqIMZueOtZFmMIWYHdRqlqB
 L6aDrHNdGEiFllEpIVjtWDPOc8YDUSYgYrT2/5is2YgsKGzfcYWo7/Y=
X-Received: by 2002:a05:690e:4146:b0:64a:f927:b39e with SMTP id
 956f58d0204a3-64c21a44340mr16731099d50.20.1771578835440; Fri, 20 Feb 2026
 01:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20260219184400.257008-1-vincent.stehle@arm.com>
 <20260219184400.257008-5-vincent.stehle@arm.com>
In-Reply-To: <20260219184400.257008-5-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Feb 2026 11:13:19 +0200
X-Gm-Features: AZwV_QixsvcVYPIi_tFnWaT1hes5reDifPyQ_VbgLB-xLaLHMBMkbSXtbtYZtME
Message-ID: <CAC_iWjL4R9hhydaXuHDZRvEM=3hcgz9pCt7+L73eV7DFWYPauw@mail.gmail.com>
Subject: Re: [PATCH 4/5] efi_selftest: fix buffer size and count computations
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 19 Feb 2026 at 20:44, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> When testing the UEFI LocateHandle() function, the BufferSize argument is
> erroneously computed with a count from three test steps before, leading t=
o
> an incorrect input buffer size.
>
> Also, while the buffer size returned by LocateHandle() is correctly
> converted to a count during a subsequent comparison, it is incorrectly
> passed "as is" as a count to later calls to find_in_buffer().
>
> Finally, the variables usage during this test step is misleading, as the
> `buffer_size' variable is used to hold a count, and the `count' variable =
is
> used to hold a buffer size.
>
> Fix all those issues at once, and remove also one copy to buffer_size,
> which has now become unnecessary.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  lib/efi_selftest/efi_selftest_manageprotocols.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_manageprotocols.c b/lib/efi_se=
lftest/efi_selftest_manageprotocols.c
> index 7fe7b285011..f07ff256ce1 100644
> --- a/lib/efi_selftest/efi_selftest_manageprotocols.c
> +++ b/lib/efi_selftest/efi_selftest_manageprotocols.c
> @@ -170,7 +170,6 @@ static int execute(void)
>                 efi_st_error("LocateHandleBuffer with AllHandles failed\n=
");
>                 return EFI_ST_FAILURE;
>         }
> -       buffer_size =3D count;
>         ret =3D find_in_buffer(handle1, count, buffer);
>         if (ret !=3D EFI_SUCCESS) {
>                 efi_st_error("LocateHandleBuffer failed to locate new han=
dle\n");
> @@ -245,14 +244,15 @@ static int execute(void)
>         /*
>          * Test LocateHandle with ByProtocol
>          */
> -       count =3D buffer_size * sizeof(efi_handle_t);
> +       buffer_size =3D count * sizeof(efi_handle_t);
>         ret =3D boottime->locate_handle(BY_PROTOCOL, &guid1, NULL,
> -                                     &count, buffer);
> +                                     &buffer_size, buffer);
>         if (ret !=3D EFI_SUCCESS) {
>                 efi_st_error("LocateHandle with ByProtocol failed\n");
>                 return EFI_ST_FAILURE;
>         }
> -       if (count / sizeof(efi_handle_t) !=3D 2) {
> +       count =3D buffer_size / sizeof(efi_handle_t);
> +       if (count !=3D 2) {
>                 efi_st_error("LocateHandle failed to locate new handles\n=
");
>                 return EFI_ST_FAILURE;
>         }
> --
> 2.51.0
>
