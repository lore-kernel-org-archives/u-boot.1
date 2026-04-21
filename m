Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DD9F94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868B083AC5;
	Wed, 22 Apr 2026 00:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cVdRQu2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEFE083E76; Wed, 22 Apr 2026 00:48:30 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E3F83936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-baa8c78ac7fso93234266b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811706; cv=none;
 d=google.com; s=arc-20240605;
 b=altrUGguHs/rwKSRKzn9sZak3ZXwe9u2vKcUv0JxKrTf7V2v1oIGDKjiXtOZpgbHg8
 OoQvaBe3LNQ6m7EkP9v4Ysb/FBAHPOo8w0LgAeGgCrjcL39ZIsjQpH0hN5wK/BQzYn/N
 V0j1gW4TkltxA3Ge0pw2rooT4LvXbjoLe7CDdTZleGY6kiAhirBrYure4cjw26v0cVmL
 8wh63ArotYkTNQo5Ksc0jV64Xo1bjKkOxDTqxDnU7APZj1iWVpMnBjnwMgWIEiejXeXK
 tCLAKt3z+atVPh9NUjrpzIjAUPdert4EAhqJO7V6VXiMjgovCzML3EH0t83bp/xi0ecL
 /Y1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fNM6j+QCnDsfwSmr+RyxDxJ3DxuzKoUuZ6g3ztiV3/I=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=ZOnva88umxfgaFaTsNNuFzl97mPGnwcnaoPRH2HB0BnEp/46a/tJhHP8HZDrHi8UeW
 2ndB5ILi9NNW90jSQ/Y4oDygRfIcQp7hW1c5858JuIq30kdwJkF7i2RT9P9k32xxw0DC
 y3g5YLbHtyHqqBrtPYe/O+WAHiz92LzC82Oh0JbXne6A5c7U64fy5LEph7QmiKkQvXZ3
 MVhjfdEIHEp7kVJQxORqp046m7hSMbs+dOlDz0EthXQUmnhes+OVMgGqHBBu1T2qEaLJ
 kD/mV6E0nBDVNfvbAcHznUHdN6pGtUwxRIO73TArX0U1qsro5KhB3DHNa82xXbfIrUGN
 +eGw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811706; x=1777416506; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fNM6j+QCnDsfwSmr+RyxDxJ3DxuzKoUuZ6g3ztiV3/I=;
 b=cVdRQu2qUNWpWoy8DRnxu6iZnDFpr2P7FuOZ/hMaLAYAt300wSyCVtMlI7RgOQk2oT
 6d//9BC7K7ol0Utdz9CcLDL1ycxIKJwXD3AL8etJF8jjDTXxsAOaleUGAVjJw0ct1cRT
 z+Cf0a3MsTbRVAcTORycvvpiNLqqkJLJGPBrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811706; x=1777416506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNM6j+QCnDsfwSmr+RyxDxJ3DxuzKoUuZ6g3ztiV3/I=;
 b=lIU0AksV2i/wBR/vo94I4ho6rs8O8thIhVR57uqq6kLbiKwDLCoOLg1YENBIVpU7Nt
 TSsbPDkk5pCLDkQB4zeuwBAeSZLz1bu58hCHTmp1/qu4PJeFUkuILnuvNlfgEfsFqEs0
 1BXq6BJylvAmJ4a4xzo5GUhdJBj0CI3i90iDlPipS2oNeuKT1KsG5Wig3Rmh1uZqTx0C
 jE1aXTXA7JE7wLHb9/IccTbEw447U3I7NRQ6pGSGRUYNCiWNsoaEHx3xTUsXIWu33H1f
 87+Hedl9IGvxpDcw7s2H4Fcp7KE0zrk1DkmsON2z2cbOZLe5zNEJPkONZt781RkbJIJp
 vV2A==
X-Gm-Message-State: AOJu0YyLkjs89jPUvR3yqDxfCYnHd29inrExnQHxQPaRSH6641y1BQ7x
 vK5J0F0P/lLD0QUqQHEVVvfz8TrYwQcTzELz9AJ/cFo//c7TV6WROT+MZrE1jRxUUkZJmQS2+wA
 GViqd8ORvFz0LV0A5H9OViSnMc5Uo9RiZMSw66xRZJ3dhuKTLJKvk7A==
X-Gm-Gg: AeBDieuRV1zrlkH2Lm9yTrRelxaz41VH5ML+mHBMQWK7ADpxd4OqNgAfn7AHnX0fsKU
 a89uNp5Aw7+CCpikClQXq4EzSYebYKeItbzQrebvQxqH+PnMBGL0bByzNyZcgTeUNvWbOfh8E9k
 AK1I4eLoOP1+dqvUCN34EqY27VmJEM5F5yNq0fvTatnPW4PdTEebMITUM6aSqWT2rxiILRroSbH
 DZpYwBr3fIRPazREXhpDDsP0Q5r4AFhzPFIAo+c39zN6eKnWT+dYbTrhVcaPTMliGRe0uloN1/v
 dVHtCCAPe0+mc9Hs9gxl
X-Received: by 2002:a17:907:9609:b0:ba7:d65f:3b4b with SMTP id
 a640c23a62f3a-ba7d65f49b6mr503885966b.2.1776811706085; Tue, 21 Apr 2026
 15:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776759754.git.weijie.gao@mediatek.com>
 <7532f71af6fd58644c2cb7dff07df54ddd854fa1.1776759754.git.weijie.gao@mediatek.com>
In-Reply-To: <7532f71af6fd58644c2cb7dff07df54ddd854fa1.1776759754.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:48:13 +1200
X-Gm-Features: AQROBzBlVmJXQZP0S4MSYXHLo_5PnJXyjLv4mQDNb0DC-5yQ6Ljg9QNUaKfjnDE
Message-ID: <CAFLszTgabJq+YrQL_MSv1-PUZbLGiiX+k0MCotgEyD59b0mMOg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] env: ubi: add support to create environment volume
 if it does not exist
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-04-21T08:35:39, Weijie Gao <weijie.gao@mediatek.com> wrote:
> env: ubi: add support to create environment volume if it does not exist
>
> Add an option to allow environment volume being auto created if not
> exist.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> env/Kconfig | 11 +++++++++++
>  env/ubi.c   | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)

> diff --git a/env/ubi.c b/env/ubi.c
> @@ -105,6 +105,23 @@ static int env_ubi_save(void)
> +static int env_ubi_volume_create(const char *volume)
> +{
> +     struct ubi_volume *vol;
> +     int ret;
> +
> +     vol = ubi_find_volume(volume);
> +     if (vol)
> +             return 0;

You might need __maybe_unused for this function?

> diff --git a/env/ubi.c b/env/ubi.c
> @@ -134,6 +151,14 @@ static int env_ubi_load(void)
> +     if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
> +             read1_fail = env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
> +             read2_fail = env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME_REDUND);
> +
> +             if (read1_fail && read2_fail)
> +                     return -ENODEV;
> +     }

Re-using read1_fail and read2_fail for volume creation is confusing.
Please can you use separate variables (e.g. create1_fail).

Also, when both volumes fail to create, you return -ENODEV without
calling env_set_default(), but the other error paths in this function
all call env_set_default() before returning.

> diff --git a/env/ubi.c b/env/ubi.c
> @@ -171,6 +196,11 @@ static int env_ubi_load(void)
> +     if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
> +             if (env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME))
> +                     return -ENODEV;
> +     }

same here, env_set_default() should be called before returning -ENODEV

Regards,
Simon
