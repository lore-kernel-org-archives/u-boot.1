Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389B8D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD0A83A2D;
	Tue, 20 Jan 2026 09:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yD+Bgmxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3237E83A8D; Tue, 20 Jan 2026 09:36:46 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E3D839E8
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78f99901ed5so43178117b3.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 00:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768898202; cv=none;
 d=google.com; s=arc-20240605;
 b=ZicNApHVVqyMCl2dy+nKzowbb+kFtNLjKP/ZRPLSE2AV672BjrIvR+AFHIocxfLEFO
 G1j/L/PjOt1zPtwhRdfW+QvfHBYDlboEudQm1MqtCGNffkiCvZqHrON23SG3FWijGQjc
 k9C10YGDBtPjUXHYCU72W6yLYzSuYYkRuaatRUzsrpWSVzqY2c3yOehMA/Z4TGiXtKYN
 QIMouuFKpvWz/+fLA4DmV5rjE71FoGUVKurWyZGmH+zXopksbuMjkDY977lFFXkHM6mr
 6db1Kam5PLuAb28iTv77HqzCpQb2zSJGmj+o7ktL85I8Xv4Lv69kAPg9Fu2P9Guhd2p0
 Uaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mylGkbgZUx8zSgorI/YuDfLAnDixvfBFQPmExP6+rmA=;
 fh=R6CruAYP7eKeQmc0LFU7jm779USBCKzG7y0X4Ahi+qI=;
 b=jYXt5kyibJARin+QDE2S1kA5U6iDReaIjss1exi0YRQF4eIuLX4AM5ykYWI3MoYXKD
 g7jUlqFi6widpdg/dNB8619eqtiFpB2aejiOMFbPMWkAM3X22UIkxioT9uzqICI2UZJL
 ZBXMhdWM2/2rgnfFVxqUFx2aY9BpLFMnPZHDvCrV+/kjkx5duPeNyNFY0ptT5VMUN3xB
 boDHV6sgZxhHrqgNkyxGnGP6++/wr6PGKMrdzYr+2QgpHPXP6XBACWuLO7yxtLwQbACo
 IEYCFAKE4JRfyukBovKXMo4n4+E1vCyRHBGh/FdM+acTO6G6AIBlg3JZpUFWryowz0ey
 qvnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768898202; x=1769503002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mylGkbgZUx8zSgorI/YuDfLAnDixvfBFQPmExP6+rmA=;
 b=yD+BgmxlYgpSt7OkKK6JaoXh3d48O/CPtjKFmJpozmuW3BjO2HuHdXj8m7c2yi1P3q
 Kfc0yCtTVweHP1Y1skG5wn3Vj5S8D+5gYDQEirtHapxFWlg2RQafJcz/1tezCjA3O94b
 LLki05ta/fBUw4GF5lQj1h8Zs/cqhiO1eB/MlxxOpe0UWOinTvNb5i8gP3LWZOhFLimL
 Vf92zNAQntcKD/2wN5SudIDe8kyiUscGJQn+XB+i3egEKBLBAPH5oNSDvCe07cqhYWBA
 0S9auyXgfGLvqUYAD5mx+9iqihrqiW1f6JL5sSHgDJLgI/sXHBlCTN2lm4Je7zr2/bFU
 P3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768898202; x=1769503002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mylGkbgZUx8zSgorI/YuDfLAnDixvfBFQPmExP6+rmA=;
 b=c7/0x5deGU69DNggWVIY9dvgCDQdWyibGWSUGFjYHMSDIwEJbjU988T9/TmDT8Tfbm
 HktrM/5C2FX12tI2q/rB2BM4LNwqqy7NRz9yRoeKTqwCBP3tWgRetJUqk9d60Vib2NIb
 PSuSEe6LDReK7s1+qIUkAzlHvjWtiSr1fVSmdJDeR7DNhmJiQF5iXwN1kKj/1YY+XQca
 n7C0gzZzwi0B/gUyhxS6TzzyrD82IYaePzQuCrsUbq04BWJ8lPagPNsnxHbdmff7/xdo
 4nPvK7OoocFnuXzBcvAeqVcurYE/GS0e8mWrEZ2Dyu6shmvu7Y5TTRo/dhOaYYrC/B/2
 nPHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvyoGXvYz9bY9lECvYI3AF65pyVoENDjTWQcdyz8ayYiYsMHuZX9DKCCdskdjiFJ5Q9B2STW0=@lists.denx.de
X-Gm-Message-State: AOJu0YzfFAnON9Ve7AXGR8s9Na9nYlchbfd29xPOagsziYe4cBBGpIKz
 JnzFJhqwbEg7mPixiC8xNxJ8XYyaweHWWNxCyCAhlEParS35aG+/V+1zA7YQqBeI3RPmUW6yi+L
 tyurKqntml0aHIuSk6Z2htKuV439/o+2rwYScRd7ndA==
X-Gm-Gg: AZuq6aLMbFmMki9Txgg0vqYuqFb0kU6HAlS16zsDx/zThM9SjKz8E6SKbOgxLKtFOtu
 +KVQGwx5a5pWNMIqsx9ScT1kp3dxouJreBTeck5e6cr1bJtW8tXvNfoJAKb5/GH0VRTOrFI3N+D
 y4T6gpVUyl5hiyNCakc5GiYDdyj6GKT8Ngk5urrLAhU3JGl9OuetwkexDdc83qw//0EOtoX1USr
 tzFk0monmalOPAF7b9po4I9nZldzgE7VeTYbSnwq5R0bitrwI6ExqAYCsKII/Mca2L/f/46WD8n
 qR/jAJqI+HP3h6TormkY8jmczsC+AzhGJslsm/D93bDkfZTp9aBvndkzPHZp6mMGbMC3Cw38IAd
 cKI4Z+XCGV2KSsqZRjpB8yXPpWXP/fZFuOT0+SUPC+vIXvLBbBb8/KAVxbUVxDaeS7Jf5EXYsjP
 PwtKsne98LIDyteKAqm3uVTVEo9fxka9v8btduVSfotX5x6T3YQUm1Mz1OK3yIl6UHz2Bh6QHBE
 36ImcApPO92g/wcgqPASg9f9YXC69hPSKA47Zk9/f0nGDUHc3qHxmVH6qxbI0cCeulufMM4GwmY
 TdkOHxx96lfPQ5GcabFVlZy/zCLzwDjo
X-Received: by 2002:a05:690c:c512:b0:78f:b820:f2f9 with SMTP id
 00721157ae682-793c525d72cmr128003547b3.3.1768898202583; Tue, 20 Jan 2026
 00:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20260119210925.29185-3-casey.connolly@linaro.org>
In-Reply-To: <20260119210925.29185-3-casey.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 20 Jan 2026 10:36:06 +0200
X-Gm-Features: AZwV_QgPy5daTtaISgyCUWRZZl0-i8P-rnxpLToAfVcZOA2-6Y5yIJqkJM3CQz0
Message-ID: <CAC_iWjJrtHaqk9Oyp3ss+DZtcpaj6imTJ0jqSfLwLJqagU7T1Q@mail.gmail.com>
Subject: Re: [PATCH v2] efi: stop hw watchdog during EBS
To: Casey Connolly <casey.connolly@linaro.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome@forissier.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de
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

On Mon, 19 Jan 2026 at 23:10, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> Hardware watchdogs don't currently get stopped as part of
> ExitBootServices, this can result in resets during boot if the OS
> doesn't have a driver for the watchdog, or if the driver isn't loaded
> in time.
>
> As with the EFI watchdog, stop any hardware watchdogs as well.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Changes in v2:
> * Fix compilation when CONFIG_WATCHDOG is disabled.
>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  lib/efi_loader/efi_boottime.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index ddc935d22409..c34616db578a 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -21,8 +21,9 @@
>  #include <time.h>
>  #include <u-boot/crc.h>
>  #include <usb.h>
>  #include <watchdog.h>
> +#include <wdt.h>
>  #include <asm/global_data.h>
>  #include <linux/libfdt_env.h>
>
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -2263,8 +2264,10 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
>         efi_update_table_header_crc32(&systab.hdr);
>
>         /* Give the payload some time to boot */
>         efi_set_watchdog(0);
> +       if (CONFIG_IS_ENABLED(WDT))
> +               wdt_stop_all();
>         schedule();
>  out:
>         if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
>                 if (ret != EFI_SUCCESS)
> --
> 2.52.0
>
