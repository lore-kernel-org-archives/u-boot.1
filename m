Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82889CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE71D83AEC;
	Tue, 11 Nov 2025 09:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JsjP33MF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA7E83B4A; Tue, 11 Nov 2025 09:30:04 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BC783AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-787eb2d86bfso21231107b3.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762849800; x=1763454600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zIzsuh+zIc+UJUAlZpredXa6psH3TeZCMi80OsC6TIk=;
 b=JsjP33MFfhKtZ/qulglLbdF1kHnU2uec1pJ6ogY2TX011f+iWAzKpiGxsN3naQ7jBV
 Z5N9sHdEpvIXRTkEj0PA8ZYKxFnwLcX3EpKtBZ2nFCno0ioMU2HIuk5f+GeM4Tc6uezL
 IExqJ9H09PkvqlZ7Bq9tjiXtc2YedUFiXe9gYKi1bSlX+hbGvj4Rsq7tUy1YjTnMAnBP
 bsHm0L5sLkxAowJYGErf7K461zEA7jsMFKqUk+1v0K8U1HvV7f/V1P4Z4Ru2TO+ZAIoo
 m9oMFd6OLRh1jlVzEHQny/VKDqTybKeDDvfKN43Ghc25VIXJlHr2j6ucB9KCJVyR+Ngd
 pong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762849800; x=1763454600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIzsuh+zIc+UJUAlZpredXa6psH3TeZCMi80OsC6TIk=;
 b=eHIprIyChuLBWoi4/e6dRJweMJOJybiK+V6pBeqR9IojKps8zaonzk+bKQc+rrRBUd
 /MeBO6jnASZGUhiJVcS2QSsu+KgW82uhceLUYYNhfAznH17vV2E7s+dGyzUTGoQUfs/1
 gNJpo5P4shQe4i+DKotLw3VxG6SRjh1xRmC2lWEphf0fI0xfq4ZK4yscwncLw97nL/KN
 mRJsXSHluaVSNY/ZbzgOgD9zkLu3PZA/mJ5j/YDFLP4aaDRtq402T/ul+HGBIB/IeDQ1
 qu/yllEl9v335YTDosNqj/PNPeDBv8fTDHyCQtWoZOTFAIeQQDTNMCE5DkPHUVvmkxna
 otkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnGjRxNrrWMIXGRBwdAMu/O++n9avNEcPYs4BhKdkhpn0JJeeEx9wju/lsVbqr7WCq3UhqFYw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz00XPOlomkptGOlcMxP6GobmcHHqWpNoUgd/B5MCVHmn5vYREN
 swiD6qKeVV9+ptOmCwbNnvq16xeDnm9GQsiLozyi4F94pUsg2g/wveXEYH0ivqtOptMjuM8wcpc
 sSKpuzPUoDR+e7J9kvT/9oRwOkI7V29v12Q8ONT1O9g==
X-Gm-Gg: ASbGncvO+iJMqRapgc6woL/D3y8VYeE9TLnc0MK1MpeWmjlVu75zw4nVjS2Zy56vAq0
 aVEihNXDSxt19q2kMVW0HVeRdPNZp98bNKCAIreGB1no50L0U5MmG8VHtXmnaeB9jBaKMNKgbut
 EGgVNuO/5G6LikfHbE/KfZBWgQvaMH+hg6mtdjZUxyI6BuDYJQ+CejRi/j4SkGnS/EQfpYJxxCd
 gaoB0Avd1lvLGjdtA14VgyNr34TeTeLtH2g8lfX8gActWbPakMSb5Tv3jgeABoLq4kvrYAhAOds
 7OnraHPonSSUpd0friswaQypSg2ck51BfNzzPRTp
X-Google-Smtp-Source: AGHT+IE9U8IOwNH/mUiKyjkiGCFMpdsJj3Ouc3ZVBqkcjwckNEhvN5aAoCPEhtzyqdQCoqaUuDerWmHGqjK9yF3Ul/I=
X-Received: by 2002:a05:690c:370a:b0:786:4fd5:e5e0 with SMTP id
 00721157ae682-787d543a95dmr95062127b3.47.1762849800503; Tue, 11 Nov 2025
 00:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:29:23 +0200
X-Gm-Features: AWmQ_bmXMwh8wQA-RLC2BLoYFy5P_A7uDQUMlDjavrQeD5l_fLN_HpiiKzk5qhg
Message-ID: <CAC_iWjK_SUEZsEzT3zb2BK-dwcXdp1gZoU880Wc1efSPAzftMw@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/9] test: fdt_test_apply requires
 CONFIG_OF_LIBFDT_OVERLAY
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

Hi Heinrich

On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The `fdt apply` sub-command is only available if CONFIG_OF_LIBFDT_OVERLAY
> is enabled.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/fdt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> index 96a8488e172..a36f2dcdda8 100644
> --- a/test/cmd/fdt.c
> +++ b/test/cmd/fdt.c
> @@ -1319,6 +1319,9 @@ static int fdt_test_apply(struct unit_test_state *uts)
>         char fdt[8192], fdto[8192];
>         ulong addr, addro;
>
> +       if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
> +               return -EAGAIN;

The asserts return CMD_RET_FAILURE on failures. Should't we use the same here?

> +
>         /* Create base DT with __symbols__ node */
>         ut_assertok(fdt_create(fdt, sizeof(fdt)));
>         ut_assertok(fdt_finish_reservemap(fdt));
> --
> 2.51.0
>

Regards
/Ilias
