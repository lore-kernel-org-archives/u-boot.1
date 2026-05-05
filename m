Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B74CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E37B84683;
	Tue,  5 May 2026 07:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mg3MHzDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E2C84683; Tue,  5 May 2026 07:43:02 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDFDB80077
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651c7ddf514so4518514d50.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959778; cv=none;
 d=google.com; s=arc-20240605;
 b=DY3BFchL8qCU+lhVg9yEj8TzLyyN0KaWb3K8zomnlBigkI9L3O8cLarRWEQq3qcXPa
 DdW169JivknbYdUVhh3owGzJbsEYFH4tibiDiKjnEwVNGClTBX3ZAkANzpLkz2sS6/kA
 G7CH/LgsyVGHNkBBz0gAySCpdAPLDK+sDlGq8bi8E+uURHCZvtOPm1W88XcHkmz8IyAb
 6iSLVOfug3JV8Vbtc9l5qbE09w4Zo7+o+PTW1JZ37lj7xJleiBmrKvnMpWbu72D8+drY
 R1cgJD1NzLsxlCu/HIhrP7D6chbfo0r+1UXmEuQEt0XQXckaDJtyFFe2mQYRcnSJybio
 MKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YuOHbiEalLTYaH0ehProMkPXOx9zrQcajKn/oNnyGV4=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=Ze7JiDIRk9ykwLHyJStWPJzlzcnO0Dm0MRpQ0hF9s53AJhx4bw6L0g3xwIPUgZ4j0k
 uK1CnSUKHKSf+yiQb0wcZh+Cazgbw+YiZwCLov9WLY/8FcYFmHHx78WVrh2yZotqp7r0
 GMvM210gdB4Qr6MK8cruanSUFoMATlyJrry55hqdwUPfdfrJEe7ownC51xmC/tSrClzx
 j0G1nO7LwhUjqPY4JcVYQ1xSvNc8VVSNGrWFWvpFVb07dx0kFQ0IHdk+/2BWDPQNzNeY
 bv4yS+5xdH7mLUBpII6aBmFsQpCqYZ+7Bz1wKxOiwVzf/OI1vscEJnGCVFV9yb+04sX9
 0y9Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959778; x=1778564578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YuOHbiEalLTYaH0ehProMkPXOx9zrQcajKn/oNnyGV4=;
 b=mg3MHzDsmbGRi3+moEjrhqQ3R7NlZWXGnTWAAUTSQBFmObRWWn6gfFrPZDEisHE801
 Vr/v5uE0NlTk6XQ5Ae+QrgAnOCjXydXhq9TF2OlWJzbo/K1XoG7KHAZNZT7h4IDOZjmC
 fZxV8pumFA01XmqnzcD4c3Ewev2DabNG8Vk00YVsoIEUh0TQjfAniMS179SWaIrScmSL
 AUNMTU013TGWNAyY7vfOn2HqtDqWHAOhwDQfBezUgLMioVaNL59jtOxZ8gTxzTcEKCXD
 NrmaYoDl9PUeyFz3Evy8JKYQxS0m5SyNJ8E5suiNkEeapXrDClGx/PAdXaWMM9Gs5NYd
 eLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959778; x=1778564578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuOHbiEalLTYaH0ehProMkPXOx9zrQcajKn/oNnyGV4=;
 b=LM9ACvDErs99Y1r7Nrs6Q3kKb99+GYZkOSLSpj/qVDiVJRfQVUtqtmQE2r+k4kSzmg
 NmrTx/SNBejhb5hPJy/Cr3pFHjJ8rJRK43T9Kdl/4mQpKKUm4s4CmrF8t5IP3eKvoxHB
 nqP0zt77byRZvA9dZNpGKmMvHwFePnINYDNgvqOlanZB61nsYxE4ND/ACjK/v6TX9lQV
 05sv605xJXm+bly2O0Q4Yq38kpocE1/Y4MVx1ZbUC7PtiZyBHOYFUI/UvL5VtwYpgOjb
 bkyEWl3VRSWqHy3VFB640UBuKZXcI8UkK4Pv0VzZIfLYJJgW+Jt7px/3iw+yYYG3Ui1q
 41ig==
X-Gm-Message-State: AOJu0Yx9qVaLyQUlt8udbF1n/EAU+S8NNYw1IKPRk8k04V1Y36R4Wjwb
 jcujmO0hKpISHev/NRtjKNnvgJhyxAQ39zkRgVsjbBZunPgVF30XkiJ1WJf/LHxErSrJkgodVC1
 QkY3PBmdairjlMM/T1E7+/goiOVWbvECcSMp6Ri7mVg==
X-Gm-Gg: AeBDieuRh6+l/nqJzZDHi6/PVY6wqoWLnKAwoSoIkFppxG39HXmQ4QFFxFMUQM0yQ5s
 AAUobjo85+mzrN/URSkTl6+I0kngbMpffw4laWv1GAOl7w1tP4w8OaBQyuoZZUbbNEWTBb0J+sL
 mwebmi27R1El+tM8GbMC5jhWU3Wa7DfgksBeF3CE3hxSqlDazMgW86Ns9joFKTbYupsa7VLaoNZ
 Xmzu/zJBgHoGxXDy0QwCVlpX+Q+/ZlM5TWQntXzrdSRb0Fd0mYfAuiSonekL+CuBuamJLss3b6l
 rDL96WDUYBnPHDWYkTvYM6MfXZNeafhsKVxOYofOJqLjuSIhy+ibpo6AWxFf4RpETLOJkTJs4kM
 AJJT8xIlW8RZEgn0ODeNe4hH9Y4hjPaG/AGrWfbpM3n5iKFt2TsHbknJqDlqCjaPl7UP42DWbC9
 Rjp4nL1s6dKPKfDI//phUiC4zJ21bT/n+q0j3oK64M1jB8WKPooFVOc8g+zeQQnrXv1kJS4278U
 RKEixGs4mg8L/Qn5f2Cz+xyIaaL1LO6nq5NbxWD2rurcnQHxw/Y8MW2s9wMNAl6Nn4OSOTRkDk1
 dHWvgnonGa9Nht1EWbfCtU1kmfO/pSeNyx2iIMNdQbACiG0qEoyZC2zEAz0QzK1PmHRk7FKIYmw
 8UshrpIekUsnllJQK
X-Received: by 2002:a05:690e:e88:b0:65c:2b92:f8ed with SMTP id
 956f58d0204a3-65c3da841c3mr13591972d50.22.1777959778554; Mon, 04 May 2026
 22:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-5-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-5-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:42:21 +0300
X-Gm-Features: AVHnY4LVDD9GaAMn9ls12hGzQcqo3lWB441Qv2L2333vHaNIvnfSHsMNPdMKkNw
Message-ID: <CAC_iWj+sHLRhfRpz09bxA1fs7RyM1a-yke4VEdaNn0DaM1qJNw@mail.gmail.com>
Subject: Re: [PATCH RFC next 05/18] kbuild: Don't try to add
 '-fcatch-undefined-behavior' flag
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit 7eb8e5f073051eebbf55fa6b90ed2246c2274552 ]
>
> Original commit log:
>
>   This is no longer a valid option in clang, it was removed in 3.5, which
>   we don't support.
>
>   https://github.com/llvm/llvm-project/commit/cb3f812b6b9fab8f3b41414f24e90222170417b4
>
> [git conflict in context due to commit 52ee1a0294e8 ("global: Disable
>  deprecated-non-prototype warning with clang")]
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 0404657dac6..a0e9406bc59 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1007,7 +1007,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
>  # source of a reference will be _MergedGlobals and not on of the whitelisted names.
>  # See modpost pattern 2
>  KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
> -KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
>  KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
>  else
>
>
> --
> 2.54.0
>
