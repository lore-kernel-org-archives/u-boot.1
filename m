Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F58ECD6EB
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 20:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F978388D;
	Wed, 11 Feb 2026 21:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ST6VKIqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBCE83A47; Wed, 11 Feb 2026 21:40:53 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA0AE8367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 21:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64aefa98fe6so2632384d50.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:40:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770842450; cv=none;
 d=google.com; s=arc-20240605;
 b=YSTrCMkeNr849eFWlhDU2dGYbvglRbFNh9TdZEvPS9gdiR99K9UfilS+mgo4N0EGIx
 iaFsQj53ghqSk/iNxm4SKYNiUvMmVWbwPrrZDYslVCj1LWLSAjBw6D5OnJw+9EZAZBl/
 /tuwzUB2OoNpQ7yDn6fDYclyk8cs3VCpQe45T7gYxGbYhoml6c3h857bQhuqtGJ0Rbr6
 8CQ5lYw8CnWX+FnaG/okfWS/a35ciYahu9+xSLaIOy0G7vQbD0XCVybJPjTe9Z85r1kB
 ipdLOZH9RGIF+CoMaysyUYDtpQ/LPt3VmC/5bMJ7xE46PEUzeQZLDayF1TcDUuxEpthS
 D+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FoCsjep3NEY7xXTl9PW6yHWbxOLO2+KCn7d2PKJ3Fb8=;
 fh=tcKOgpZAEGylP8s3V6z7rbJ+8JKp9pyz4iuHUl17Pe4=;
 b=C1R88TR2y6PLYyqczVBnaiEZ3O7hcZ72qVpnqt8V4/lfmoOERbWVvyZUUXNhLkZDlv
 73hHkr898cz3hFBnZO/qoJuX8LQ5D19Qp+INkpmIvT45b9tsBxx4uru4g1Nppq1ZM68v
 7M8XtUQXpWN8CsJiWxVfIcjVySJOr3lcp0gt+e2HSps3QdylnZRcodHzCSm/g62az7cE
 9aTcu1IzMTmr2PA20VLxInJ0aexlevX2hEwArLl2y6qGGcEORXSFJCi5zSRR54khb/y3
 w6ZF15NhhTM81c0IXPQy9TcalRxcji/OYecK1AxEe4MO/HbcD06CCkQIchDhk+7yQ7wQ
 9jgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770842450; x=1771447250; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FoCsjep3NEY7xXTl9PW6yHWbxOLO2+KCn7d2PKJ3Fb8=;
 b=ST6VKIqVAbzh4WEM/b9D//VKePUUZo3sEge41xlOs5hwbBTWiOwKDfeiYXSKMoZtl5
 +BsbyZXntq6MW1UE+D8Yf/86hBC0uO8/rJ6RGEu1QHZxpT4ZHNtEcutIAaGwK+jDhq51
 RL+lja71VPEIt8W6qq38odtDIPlT3uNbsArmP7dGNXSR2jehDBi16obHuyLRxepS6lU7
 Phwl5kj1vRniOu7tHhy8Vq2e4KP/HvJWFm24N0eV3tkiSUZ7N9yRT2TaM+CIrQXlKn4y
 cRxufnxegSw4KnjzCqz2mwFLY1N+RtlgXvLKHUpaLBxVja/MLVWBu0QA1IM8cDVuhhYX
 DaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770842450; x=1771447250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoCsjep3NEY7xXTl9PW6yHWbxOLO2+KCn7d2PKJ3Fb8=;
 b=i3Wrz1AW9e/1t0PMLBc2o+/1igt7b7PyKjBVc8GNlQGXCuaJEM2qcTCDYVSGR7G09D
 qJO2J6A0a9Au9aVx/WFRIDY4mxXP3XNYDo54ZI1oE+OVKBvL3yekWQwV7tKoVBjAHzBs
 CF+dcuXc8n4rYvh27CdXWhJznomXKY2V/rCJxbe/GdQ1bQEMgy6Ii+IzjvbxrRnIPNKw
 f6xDBrP0i5xaqlV/BMIUSZ+JxFq6rZWkoT/A3fyLg6+dRRfNgW252vaIqCG+jSgdkx7e
 fShn5mxvAfiKTtbipcHe3pF+sdvKYFgRPJS6gOJRjXWTJk1jIprjnp/aNLpg5SZs0Clp
 VEcQ==
X-Gm-Message-State: AOJu0YyupD+nULDLLXfCM9Cix5HZQG1sruTkIf6zx8f7VW6ZfqgK5KeA
 rSV3DnNFoQsOfy/lfa6rRMl/REJVxJdBNASniYzfH93JzCKhrRBpogxVyKL8pERjeHEnaLNqU+Z
 F/S6g4ppGUONl+ges1yvL0M9hQ5HNNPyxN5VbKFKZCVCavG27s8AJn/HZ3A==
X-Gm-Gg: AZuq6aJqV68JkY32bpgqfNymK1AI4a3XX7y1GKJnF1T1dkuLMMFVXgsbDYDI3WcJ6tI
 kdV/Rg4qdQ8K/BrsST5riCLtsWZxPhYRW4ZM1yRaNYInqXAgulFbF+eBC9G/tL1YpNSX2pap3+4
 bad64FNeA6B5vqoLYgYYcR2ftHmYITdlZpb8HrO9Th5TxX1n+zn3PWgIUwwkx68gg0X+QgO6P/l
 LTpFTyJJ95e0Vf2/t5+r91kdjesQ2+nrL/r76FFtzyTfHKNe4uqTGHShmDgYIEKiqazfPZZP4mh
 yh2h4DYD07a6q8ZehsNnFonElySO8sWy257BiNmMV83iCbU82MDLklw+LIoGmdznZP1xd9XiJ8k
 JGa10km7ZQBbLJ+gljr5dUrsdgE7XpOdI1Ugz7dwbQkn4iww3IPEQJabR5HpHAlKbiQNkzSUph6
 dFvvtgOYWQI+txDFqYkfT7MTe2N7UA/03oMo9l5E3GZaMJ2gq2Y8kPYlgOw6HDIb3dJmdQwfvAv
 C4RA94naFdT2pM0DBjYwDH9mx7YafoTu5Y3CSnihq7E/VlGdZLTh/Txz5IKVgR+eKa9tzbTzR5+
 Nd7O9nJDFrbC2WjinBPF3LW6R0vT3IA1arUkRHYCJTQQiw==
X-Received: by 2002:a05:690c:45c7:b0:793:afdd:c5d7 with SMTP id
 00721157ae682-7972f0dc9ffmr15847697b3.9.1770842449602; Wed, 11 Feb 2026
 12:40:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770825377.git.michal.simek@amd.com>
 <da151d1eaab4ba5aaf37c11ec1ae5ac3f1abb98d.1770825377.git.michal.simek@amd.com>
In-Reply-To: <da151d1eaab4ba5aaf37c11ec1ae5ac3f1abb98d.1770825377.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 22:40:13 +0200
X-Gm-Features: AZwV_QgrnxlEZSUgZ6MWPAuW8kKs6PcB8EpjbzOl-L4p3exB_meHaVsr0n2sayo
Message-ID: <CAC_iWj+WM61FedK+1EbpV7oQJuEqc=5eh=58NwonUCAyX0CW1g@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] efi_loader: Setup default location for UEFI
 Variables storing
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Wed, 11 Feb 2026 at 17:56, Michal Simek <michal.simek@amd.com> wrote:
>
> EFI_VARIABLE_FILE_STORE is only available when FAT_WRITE is enabled but
> that's not valid for all platforms and dependency should be covered.
>
> Also Kconfig behavior is that if default option is not valid then Kconfig
> selects the first presented valid option instead hence it is better to
> record EFI_VARIABLE_NO_STORE as safe default option.
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Changes in v8:
> - new patch
>
>  lib/efi_loader/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13e44be1d067..579eed658801 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -112,7 +112,8 @@ menu "UEFI Variables"
>
>  choice
>         prompt "Store for non-volatile UEFI variables"
> -       default EFI_VARIABLE_FILE_STORE
> +       default EFI_VARIABLE_FILE_STORE if FAT_WRITE
> +       default EFI_VARIABLE_NO_STORE
>         help
>           Select where non-volatile UEFI variables shall be stored.
>
> --
> 2.43.0
>
