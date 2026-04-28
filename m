Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D3CFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 182E5846A8;
	Tue, 28 Apr 2026 20:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="COL+eMxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C4D846AF; Tue, 28 Apr 2026 20:25:48 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96466846A4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9d9971d059so1659620766b.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400745; cv=none;
 d=google.com; s=arc-20240605;
 b=OW7AzLmCeDgYER7+t09lq0Gr6SGuVy6eMqJ583FkqhIhIDeD6j2t46dwNA9KUxpRng
 2mi4E7usbjqBT45MvFa2TdQtaJyBjwb+IOgm3I2RCTNf0bbAb0nTJNiE+OWpP2dVoqE3
 fL7d+GdxCtFe4CQm64Kme0od/ETa0WzC1b7dO6BLtKPYq8ejGOlOc+Um9oqUDSyQWaqI
 jCYMN9UOY2ekQr0tJgPuDNraZXJf0QleLu3jPalvr92FzVuIAzd1wNZGL+F/cyuY9GsX
 TpzbcFf2mZABTlT6DzDezXGJ4KGkYZmkF35GePhY1SAFK848jPrlj8AUrOqzG57RytS8
 hj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x+VVZfLECzB0P8v7r0H1uWPy2+kMtEWMbXSMDoyGAfc=;
 fh=GYIekQEhESPWanXHuipF/cx0w9AeOdHDaa7vPtUoRvA=;
 b=Z8UIoppmjc++kQr72Gl0quuBzg4mn1Cduj0+vNtCpzyux0p2rd5+G502IYI5Dx62YT
 nzWiq6xD0MzekAjx060lWQYfbOdbeV1Qkgg43WnaJix7hxsPHc8EvitrHu9x9ubZmxs1
 vRTkuGJUVF5YJSU2Z8kZg5rPr0AguHjmQZdcXKnpvWuAP/U+UCE9vuWbyrFCrCo7Beph
 OZt6jDCHLxrbYbfoouW7FacRa0Vk5pCK+DCBPbYQAiQ6Mqbr/8dhQJea6CepELBc4q4E
 t/GhWXEHNRaJfsPObvWSb1SRX+6i6XsKdiYXIj4Ixdm9RHBLG8IDU1Dhrw4PkZNfYIEZ
 XKIQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400745; x=1778005545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x+VVZfLECzB0P8v7r0H1uWPy2+kMtEWMbXSMDoyGAfc=;
 b=COL+eMxXEIuJf/e38AyC0Wag6vDFlmr8flEL/+EUKwS5BdQ+FiIZDTym5YYzh01jlt
 5L35vmcGNtJiLlyK4Vxs+sW1Giudcui2CulGaoi9OAVl0BJfql2nGH9sp/VOShoA2g8W
 EfYEMU85oBMl7LI+Go4LkSCZiq7vpqUYQGkdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400745; x=1778005545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+VVZfLECzB0P8v7r0H1uWPy2+kMtEWMbXSMDoyGAfc=;
 b=ozylcIt7CjQXA7JpCX10fKwLYv7XcMYi3KIWkmO82NsQQVEhY7uMiPrzXku6gFogtC
 UfS6gGVyuB2SYJFRYlrxnGYzKB2WnrNu6WWENbC05w3QHVKg82sIg7ADCRZPfvpCtaYq
 sMi/DJblovDs/u9/EXhNQhh7oy+LBYLIbJDOJRH7MvJGZy1dk7bAMrce21AblIY9lvXN
 P1A3nXaRdEl8woPZUFccXV2znUXPwfsKkk1Sh8MB3fZuThGagBSmrJk22JDkebifZP0r
 /+g0sWjQGWpbADbVdycJfJm4WqcS6+gnmCXYh/9h4p5WzScG98GZoaSM4IDN441tVpr2
 vWJA==
X-Gm-Message-State: AOJu0Ywy65vz7Le0I4X6GXvMSeXhZEYzIGBhWg7G3Q6JU5ssrIsBLSy+
 yfsc+h9HWEy+p0O76WazX7nTR7EOkjVDmNUhhnru6UmqBBS0xFPyDsM1gUZdVbxEjUMpOrJZT8S
 jM0ivSUtVY5ew3B+CE1UPOx3abCk6Tl97ZmbLP4Rn
X-Gm-Gg: AeBDievjbVva/5EDVi5nrK6Mes8cbnCLyyuEi6GPI8m7uLcwnJS0kx6MBGiZYvtNzBt
 NHVzsSfWeJIloUdsKn0zQL1EA5t28i9clJ9HuRVxhEuL9MCsRmOynzpJWBCfGTDQgrT+XRiwuY3
 bgSpqqkJDlMKaTaRAGTOpiEb99paMffgBOfvo+w++RPYafSPOY66gxYUdVhvpdOopNr5uJBwmth
 uKsn3NqmHTHYP0hZ2QH+Zg4ggVAE/+mU5rITuNUIlrjOQgZ+Fjxz6BD78ReFdNA/fvwGgjL4Epr
 Z3tNcFQrBNjaSUUk
X-Received: by 2002:a17:907:1c98:b0:b9d:6d06:b78a with SMTP id
 a640c23a62f3a-bb93ce8c877mr30267966b.17.1777400744905; Tue, 28 Apr 2026
 11:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-6-harsimransingh.tungal@arm.com>
In-Reply-To: <20260424173151.371134-6-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:25:33 -0600
X-Gm-Features: AVHnY4KKYtJ47ae-LRZA28LmL0OoqEGTYOsIyDtHKKO9eJlFuhDzMiEoXwkBpdI
Message-ID: <CAFLszTj-Fdj0juQLA=1ohBesS2EO=Pg8vyvvEFc8VYeLyT_AZg@mail.gmail.com>
Subject: Re: [PATCH 05/12] efi_loader: move runtime GetVariable() helpers to
 efi_variable.c
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Harsimran,

On 2026-04-24T17:31:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> efi_loader: move runtime GetVariable() helpers to efi_variable.c
>
> Consolidate runtime GetVariable helpers to avoid duplicates
>
> The functions efi_get_variable_runtime() and
> efi_get_next_variable_name_runtime() were implemented in
> efi_variable_tee.c as part of the FF-A runtime variable handling work.
> However, default implementations for these same runtime helpers also
> exist in efi_var_common.c. This results in duplicate symbol definitions.
> To resolve the conflict and centralize the runtime API, this patch moves
> the default implementations of the two runtime GetVariable() helpers
> from efi_var_common.c to efi_variable.c. This ensures that:
>
>  - only a single definition of each runtime helper exists,
>  - backend-specific implementations can override these cleanly,
>  - the EFI runtime variable service table continues to reference the
>    correct functions.
>
> No functional changes are introduced; this is a structural cleanup to
> avoid build-time conflicts and consolidate EFI runtime variable support
> [...]
>
> lib/efi_loader/efi_var_common.c | 24 ------------------------
>  lib/efi_loader/efi_variable.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 24 deletions(-)

> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> @@ -579,6 +579,30 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
> +efi_status_t __efi_runtime EFIAPI
> +efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> +                      u32 *attributes, efi_uintn_t *data_size, void *data)

Just to clarify the commit message: this is a relocation, not pure
deduplication. efi_var_common.c is always built, while efi_variable.c
is only built when CONFIG_EFI_MM_COMM_TEE is unset, so the move is
what actually resolves the conflict with the new efi_variable_tee.c
definitions. Please reword to make that clear, and drop 'default
implementations for these same runtime helpers also exist in
efi_var_common.c. This results in duplicate symbol definitions' -
there is no duplicate today; the duplicate is what patches 3 and 4
introduce earlier in this series, right?

>     efi_loader: move runtime GetVariable() helpers to efi_variable.c
>
>     Consolidate runtime GetVariable helpers to avoid duplicates

The subject and the one-line summary mention only GetVariable(), but
efi_get_next_variable_name_runtime() is also moved. Please broaden the
wording e.g. 'move runtime variable read helpers'.

Regards,
Simon
