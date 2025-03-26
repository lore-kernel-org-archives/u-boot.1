Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF78C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 07:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB17808B6;
	Wed, 26 Mar 2025 08:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WWzH0Qjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD13809D0; Wed, 26 Mar 2025 08:28:43 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 283C98083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 08:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so5120694276.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742974120; x=1743578920; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ivQ4jYQrp+XcwtaZlCFDtARkEOPELtGQMqe/IEl5R4k=;
 b=WWzH0QjnTmFI1aLwg8l2uGndF09a81VELudNezau/S9/8JbznMHlg3e4pOvpdYL5Qa
 wk8p9jUY0m82GX0xAS3DyKkyADsfbwRDqcrePQOO1d+dRG9nRe4lNSAROR9rFfRWiwy2
 yq61meOibPiHgDPEm90k1FuMN53XUiprXlbS/fHbPSjLGeCdeHX4u2qTu/3Q3a7IqetG
 X6iPEtlWwKh7iIhgHqSyVgZ29Ec5/sE5G5jx2i3Hiscsv1MTyq7RGbNdqHsOt1+DVKEF
 yV6qFslceECrluBhskQLJ2k8ZksuUPCPvc1lqcZgJ0htIjaiOA0B3pUcMqGxeujK07ln
 YOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742974120; x=1743578920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivQ4jYQrp+XcwtaZlCFDtARkEOPELtGQMqe/IEl5R4k=;
 b=Z7kqvDNxg6dS5oeIAwBgnlQuI7fN+uIvHV8B+bYuv3qG2nScPTZPuY9FkjzOjX7cnB
 86TaibjOamf9bVd12v9UXafvsaNTGFmaKmNs2OwVGjhk8Hz7xy5QtfOh/p2IN2nlL4ID
 bvUEYqok8c2XjP4Sr6MDunz3BKoXpXSR6ESwWwOpVkLqAvh36dtYJ5zzSDkYsCdSyYHJ
 Ibdtq3MJ9fHMf/U5rrKmfpTs1GKPUdR1ivxxIGafzzb7fddj+ffkS970EwHLBSAqksek
 XzhbqTtVZZtfvDW15PP9q9QzMPw3ObCuliLnMfVd3DOASzlQY7f9EGKBGWI6G6qBgjSH
 ZqtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyf356N7QZeCOyRrKlU8LgqaH2q7uC7o2foyqCJ/0+1WA+UA5YZHq1xUCbVBeShVKmY8Oho1A=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3sGQo7+I6Q+KwJyaeedg72LHGvffUi8j54XCiKBKb56ay63hK
 ApmQ0awFwnsgozzBbeobIg+CitfNzRGdEg+m8m61wkGeANGeCc80fapMvM6qUjBGSyRtPqx1lMN
 4hihdTfWSaQLFnaXKycaEBsx8yfE+PLxwcDQhHw==
X-Gm-Gg: ASbGnctbbwhSdQdsw4p138fJTSmEK5dTAe4MwSPOGiDyOoNwVjlnoMZwCJhYjNgGNSG
 fcuw9xnsQslUk3+xGAaSYXLfU338J3NhdpyGiQGia6m4eAbBnYwaQcOxXoukJX5WyvxbmWF915N
 ncBWsB1MBjNod2OJ/++O/2eYirtajFQlF/QCOH5w==
X-Google-Smtp-Source: AGHT+IGoM6kiD/gpNMqJM73Bh987kXc7uifJkWO49P+G1mnzBibVBt2D6vgHw7ONZ1+XQqjmKC90QzL+YmCg9BTAk9k=
X-Received: by 2002:a05:6902:2781:b0:e5d:c5f3:13e1 with SMTP id
 3f1490d57ef6-e66a4faa663mr20672394276.35.1742974119817; Wed, 26 Mar 2025
 00:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250326054653.273906-1-quic_varada@quicinc.com>
In-Reply-To: <20250326054653.273906-1-quic_varada@quicinc.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Mar 2025 09:28:04 +0200
X-Gm-Features: AQ5f1JrINPgQ2_olLh8yGa81r08cwgKH6CwQ7PmHteBEF5YSjD5CMbUkR5DC1HI
Message-ID: <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, sjg@chromium.org, EABachinin@salutedevices.com, 
 jerome.forissier@linaro.org, rasmus.villemoes@prevas.dk, ansuelsmth@gmail.com, 
 sughosh.ganu@linaro.org, michal.simek@amd.com, u-boot@lists.denx.de
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

Hi Varadarajan

On Wed, 26 Mar 2025 at 07:47, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> If the EFI runtime services pointers are relocated even though
> relocation is skipped, it corrupts some other data resulting in some
> unexpected behaviour.
>
> In this specific case, it overwrote some page table entries resulting in
> the device memory address range's mappings getting removed. Eventually,
> after the completion of efi_runtime_relocate(), when a driver tries to
> access its device's registers it crashes since the mappings are absent.

How were those page table entries added? The runtime service
relocation might have overwritten those now, but since they are not in
protected memory this can happen arbitrarily.

>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  common/board_r.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 179259b00de..1dd3b96c2de 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
>          */
>         efi_save_gd();
>
> -       efi_runtime_relocate(gd->relocaddr, NULL);
> +       if (!(gd->flags & GD_FLG_SKIP_RELOC))
> +               efi_runtime_relocate(gd->relocaddr, NULL);

Have you tested booting with EFI with this change?

Thanks
/Ilias
>  #endif
>
>         return 0;
>
> base-commit: 244e61fbb7f5045e4e187024f7ae80434c952145
> --
> 2.34.1
>
