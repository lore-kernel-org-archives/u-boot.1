Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51400FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E650F846F9;
	Mon,  4 May 2026 22:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZPxDdQ2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBFB847C5; Mon,  4 May 2026 22:32:38 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBDAF846F9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba922426c5cso785810266b.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:32:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926756; cv=none;
 d=google.com; s=arc-20240605;
 b=Rpm4vcQxwr/CPIFPOWuQmukTrgM9onOWD+FNNZPkMun9v2skmvI4bsqouBht0ZrnqU
 XcIW+Tx2yb+cPSUkqRcJMtwEl3VU4PHbi8RYWylAYmoSUL08terbCVpoKCDGE7GKOE+B
 29VQavrReI7QGMS9og8kSt0hiKcmntQ//8fne7YexGELG3AHEEfRw5ZdNX3Jj0Uxep0f
 lv1ca1uIW+SnsD6d4wmhjB08lvJZG/yiGfNWJo+lpV0h/LlSISrYAPrhL8mGzZACTVPo
 SZtmE263pSw60eID7gr9m9Wu3ZmMTLWQbq00uXfoQcxq4FMKdsRAx5a8TNds9RaIeO2m
 oNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ypBGQ4FZG73zdkDiyWvjnvWmAojHD1sMSZSMu7v8nCc=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=K+m/zSOrWxqCMwMV3zVQacm73FgdQGvpHVq5SSk0zDW2FEtInL+4+PKt3PLTxidRqy
 6oxDXk0OS1/3XeqVib9uhwvS4a7Cbamft/ATIsCrhL5IGOBbFFssKnIsfKPEgejmH0mC
 9ZwtsDdhPA7ZjACon2/qC6wTGgFIX+L1ucLeKsGN0/eNihms+zZgSSoDN6tNktnp0Scb
 tHwj7hTW9VTKLx1wQqnB+dqQkeDM5twoB90kFzMssxlLMhh96YB7BfGnJ/0eimtQ5BP1
 aO+fyl1Er5USdGmGZoj+sDTlInsxH5ZkHx/tTeasYt/aEQi98HpiJcLuXHvFz7ffS/yQ
 hQfg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926756; x=1778531556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ypBGQ4FZG73zdkDiyWvjnvWmAojHD1sMSZSMu7v8nCc=;
 b=ZPxDdQ2hRsSBXbEIP15HgWibugv5wvy0qCgRzR5GWNoEu9W9PqMdSQ4qsJjW8F0+dL
 vOS544maxoHg2CIjMNvml6cxpeXI/Wrw1Poz7oJBq7r+k5UwgRFylKZazQQBph8tut2Y
 OAiMeJgFsAVnFtSXL8qV24ENif6gaVVbkLGko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926756; x=1778531556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypBGQ4FZG73zdkDiyWvjnvWmAojHD1sMSZSMu7v8nCc=;
 b=PWKHrq8WRiN36A9Me2H2PhZcTRE2/ThM+fEpYAEVV0p81/tiV4+zV8lQvS3iGKlsTt
 Kyldz2A3OmcKMP+n7d/cooMVIfGGBmmaEz+SlaAL8V8infoG8abXCd4FA0MzUj3v0dBZ
 2yViu8ytTofArS9Dgp5QfObW3I0W/RszcKQW52C7cxIgT0H7DiS5E8b1df61pTjcLdJo
 bMuiWAUvrTQJv6Owt1oI5+nlLMGAbGZ+O5Afqflrpgd+6K9mDlNjwGEYuKxDlv1e+fu0
 dHkIg2Ouv6t4JUEkwpSojohHwMjOf+vi5+WyGtbCsOhN7hHFbVfwhZ2kTrSvDNritbOf
 czcg==
X-Gm-Message-State: AOJu0YxOV3nWQn9BW0HOmY/Oj75nqKbx3Jg8nRJIliQx8lC/8Kls5cx5
 36H6zR4XrxtI3IEnI8XPcfkIWTUsmjWY1RdH0k1W1FQN/KHeqz5lKfid5+Bt4NcpNH96LUpD1vl
 6UyzgwR3bZPTWrW5t1SxOMkrlvxViyZekHYW6JQkm
X-Gm-Gg: AeBDiesdyv/4zP1Vukn5klwuF62DQGMZ92/VWUksVCAc3Xp+RtjIaUGVK/kWBgeZzwp
 aIwQluOIl3ENDE3tXIPOVRVhDyX33amZqWC8ZVS4AjmTRqNiLUaaB6K+0TX2sYz+H1rF2EF1s7+
 m0B3g52dvlv9VcQlg3eaRb194PnSRBdT0p+XTD5lHcKhf7oIWtFvOBMlHwHzlIDh0lp0CSROhSM
 gGyZTnfdvnY3sZnKqi/APwlO43i6bKOAM5Rt+UHMEvYClIr0fGDaPet8gh7ykMZsuxTxl2bcn/Z
 KPf/WlyvSmCQr9XD
X-Received: by 2002:a17:907:cd0e:b0:bc3:d976:2453 with SMTP id
 a640c23a62f3a-bc40f532e4emr7295166b.10.1777926756216; Mon, 04 May 2026
 13:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-9-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-9-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:39 -0600
X-Gm-Features: AVHnY4LDmej7YS1C53ihEasGmfwGTYcGadg3Ku7PfRb0HjgDlbC9eF750JhzyrQ
Message-ID: <CAFLszTh3oif8uE-V6Be-9ukfPHS_4FYshN=qOHQ0tNUgWZHxZQ@mail.gmail.com>
Subject: Re: [PATCH RFC next 09/18] kbuild: support W=c and W=e shorthands for
 Kconfig
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> kbuild: support W=c and W=e shorthands for Kconfig
>
> [ Upstream commit c77d06e70d59cbc6e3c22bf644bb0b197a5fc182 ]
>
> Original commit log:
>
>   KCONFIG_WARN_UNKNOWN_SYMBOLS=1 and KCONFIG_WERROR=1 are descriptive
>   and suitable in scripting, but typing them from the command line can
>   be tedious.
>
>   Associate them with KBUILD_EXTRA_WARN (and the W= shorthand).
>
>   Support a new letter 'c' to enable extra checks in Kconfig. You can
>   still manage compiler warnings (W=1) and Kconfig warnings (W=c)
>   independently.
>
>   Reuse the letter 'e' to turn Kconfig warnings into errors.
>
>   As usual, you can combine multiple letters in KCONFIG_EXTRA_WARN.
>
>     $ KCONFIG_WARN_UNKNOWN_SYMBOLS=1 KCONFIG_WERROR=1 make defconfig
>
>   can be shortened to:
>
>     $ KBUILD_EXTRA_WARN=ce make defconfig
>
>   or, even shorter:
>
>     $ make W=ce defconfig
>
> [note that U-Boot currently doesn't make use of the KCONFIG_WERROR or
>  KCONFIG_WARN_UNKNOWN_SYMBOLS symbols as we're using an ancient version
>  of kconfig, so technically W=c won't do anything.]
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Makefile                   | 10 ++++++++++
>  scripts/Makefile.extrawarn |  9 ---------
>  scripts/kconfig/Makefile   |  8 ++++++++
>  3 files changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
