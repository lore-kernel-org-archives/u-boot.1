Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30989C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 07:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501A884C85;
	Thu,  2 Jul 2026 09:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DstEF9FT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2386A84C92; Thu,  2 Jul 2026 09:42:11 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDC8C849FB
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6651bc57458so1181594d50.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782978127; cv=none;
 d=google.com; s=arc-20260327;
 b=fBBhR2x8IjDxVHI79X8S9N8wArNee3VkSxtD18LSqo9MatLLugh0wsQZOEffjryu72
 evSoJj3pw8Qd8AsniYmm/A8DLHmBe8ifkTdDINzj0lUbVS1ufEXQKOQlazToeILMdyss
 eEGsWUGbznoOsY266ehyh30vNfOf3hmNpHgXrcmY+3aKIBj4I8ZiVS8YMqfMtnIiiMl8
 qgAQvE7OR9n+LlYX8j6vo+ZcZBot2wcpsuzhkX3mEnpJCtHuApBTm6MA2IOLxYpH3yMp
 V3sUf7d2GVBWiU8yYRN+BMuXyNvrcNGX4eONbJQAZh+2HhJeNrWTUhy3SELYbWQK2mhF
 QgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xxcoF5qun5LDDhKvOMonSDTiDV4Ax1cH2k+2lpp2WxA=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=ZI4wG1c+Pgcpig+bwCCgnPWuOyWoGxH3ptAe9SvE56fLmXP8KdIqRQMLPsqvDacuyD
 jJiEhu4saX8hdj5oH2MfufPz8e4tOWLSoU0g0zqRScJ2E6anmbDslPg7aBmHhM4hkV7M
 a2weI7aIDvv2Mc9icYm6+V1RFPUfFpwZpDDC/5+kqGxSTOZP1IFmZ1CDe3WajQl0IQXq
 qvcTrUXb+yFCEDoEu8/+n2dcA+EgBUQdThOpk0uWnMtW3+JiZl8GmSeiOd4oNOM+tRVr
 KL6LbfCayi89gEse5Q7YEGzfPio/T8ZEPkLJtDBe9+EN+r/I9OxOw3bwLGAO/TXLsmHX
 i2vw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782978127; x=1783582927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xxcoF5qun5LDDhKvOMonSDTiDV4Ax1cH2k+2lpp2WxA=;
 b=DstEF9FTH17GscW2Ow0eIjM7HVKtQiQdi8QbAv9t2vtp7hMBxYiqqzBSf6K2sJQZXQ
 KRqlFW9DcxYV0Ej57H9s7buvCMLpNesElD4VX62faxLH0E4IAehb6gxzcSzTHWnrj2vA
 GL1uQ4Im+ig2pzXUF5BiEhQ6jvdm3Ie0h2m/0wvpuhzhFzMVT6ku4zQDpOutrhzhX2ku
 egS2guCNJd9jL6UzxZjvwyTktLQajPvHnvWy7RdrvImKc5SqyCKaYS1o/Do38zA/HoAT
 K0+uJwd3fnjpTfnpecufJuD4NkypJS8uFW5Yywui8huQcMwOw0xvWbW6g4HB+9fBfjSg
 jUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782978127; x=1783582927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxcoF5qun5LDDhKvOMonSDTiDV4Ax1cH2k+2lpp2WxA=;
 b=lKGkVwfdwptVJAseJ/DmTVVJz6Te8QKCaxaIZK5cbMV1qdrxTPHHKhUzOVEl2vNj7z
 aRTGHvvBliK0Cyt7gaFTRT01D5h1RtXV4z5fZyowhtDqK3ycOV2x5DigZO1FkaseBZN+
 /oDNRLnYU2TltczuKbAlQl9l3T2R6ih4K5t/Kd2NBgkVrvCg7gh6XZJ7agZc4sUoYJkP
 towp6sFrKVSBrjB3ymfCjEs7JdzCqnjxyaa+VUOU6H82fI4BtWbd7A1woAY78OKjLyQl
 12MqzFiHznsohwBfG+SiNsnu5mQIH8swFP9eiflRLtpULkG9QFrHvb59A6YYc7PlzMi7
 yy6g==
X-Gm-Message-State: AOJu0YzydTg3HhOTozRN5w7uNxGv/W10HMYA1ZbxFG3pL1qsvDHNvOpv
 wmWw2gRzdICB9LerRysXTGxq4SBpRZPRlm95ULDq9Kh4tFk3uGcSNNcbXBzIusuFnZbQgrJRpRX
 LsE7QEu1BbJ7co14UBpxmghy3zxKeSYoENI4QLa0B3g==
X-Gm-Gg: AfdE7cnrKRUUjBHwYxDkSfDVwWCaA0OTsO6DRJjDUVQY90ET8SZqvHryus8QE9XTRA9
 AjIc8zu00TSLtDwWKVvOISptDGWnikufGn5D7+WcrXlsg9QfZzctFPuEuHIAlxbq/Hgzzf9SIe/
 dDcDg/6tKRfRin/YVVqhjbrdqugMlO1fnLQk0RsJWx0ClcyOrWc2ZoSbC7ygfBd8PhGvk6+SXsC
 Qrs8ObOJQNsGdGndrbVmsNixB1fmMbhTGP+UgFAih+jEx3c+6nQoYgLwqAzTnj2R/JQtFc9PNjF
 1e1/I+w26o5bzw5EQhBLiMlporS+k7q/e2SrANdLv1M4pAkDG35/yb4m+YLXIJj5noWBwSpudmi
 6D+yhLKJkwb0/0E+sMdF/KoERqeyqASi+YRrVDHAtoeWpCArRemL0iE4NaBV2tzJr6qXlCKycgC
 13OPwAyKS+wf3Oxz8slhuBGD5Sgw1dcPKREYDoFUo6w0JZYJejIExn56Dzh8qeytqOgtvtCVjDj
 cQ8ZPLEqcHHjdXCVPj1kvmPsqKP8JfLnRN1MIQ1ABRF1biU3p89q2/u+qVds3UcSS+rwOw7ZmQ9
 BBpFN845Wm8ZVED0uQ2peWEWOOPIqJa7HL1wcfuwdFK1/4m5tP0vdJypYe6B78hdGy6xU++O0rw
 STkCUSA==
X-Received: by 2002:a53:d015:0:b0:64e:a9a1:fdb9 with SMTP id
 956f58d0204a3-66591676428mr3593821d50.34.1782978127086; Thu, 02 Jul 2026
 00:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
In-Reply-To: <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 10:41:31 +0300
X-Gm-Features: AVVi8Ce5m_61_W2JynoSuzMhjgX2Nw7Ssu6s0MnyAAq2pfoZWnhECNt3pYzBr68
Message-ID: <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
>
> On systems with FWU enabled but without the required DT changes the FWU
> metadata device is not found and fwu_boottime_checks() returns an error.
> Being an initcall, that non-zero return aborts the boot flow
>
> Return 0 instead so the boot continues. The preceding log_err() still
> tells the user that the FWU device could not be found.

Won't that affect the board later on? E.g When you do capsule updates,
updating the metadata will fail

Thanks
/Ilias
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> We have reached issue where testing team is using the same defconfig
> to test both scenarios and difference is in DT itself.
> I think it should be quite save to return 0 if any UCLASS_FWU_MDATA driver
> is not detected. If there is issue with fwu structure error is correctly
> propagated.
> ---
>  lib/fwu_updates/fwu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index e9bb1b4fc656..25eb5af572f3 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -760,7 +760,7 @@ static int fwu_boottime_checks(void)
>         ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
>         if (ret) {
>                 log_err("Cannot find fwu device\n");
> -               return ret;
> +               return 0;
>         }
>
>         /* Don't have boot time checks on sandbox */
> ---
> base-commit: ea62096437b39ff9038f7169e461bfe7863ee85a
> branch: debian-sent3
>
> --
> 2.43.0
>
