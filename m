Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD1CF94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F18A841F2;
	Wed, 22 Apr 2026 00:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TDOEaPDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3912D84368; Wed, 22 Apr 2026 00:49:10 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61C783936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-676f6c823c3so31587a12.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811742; cv=none;
 d=google.com; s=arc-20240605;
 b=QEQW1qtAtI1Czjz/VZmdLJywyb1D8sKpvXhoZjdgwHGt7/LfevkKuDJyfnoh1WupFt
 4HygKV0PhHztjVihpSO+v1c9u+snpF9H+qaaMx68InasiE00Z633x70d2VkYDaQSog38
 P3Y3BL+DvyyKLaRhNpXxuSIrQAMll+Lb6qtJiFttlAkFeqdgjSl/8nncS9VqdOoTExfW
 gGeUDf+PMFk+fjLmYjF6XB6wJXoG3xcSwLxUm7+Q17W92WTk8GhT7yUZMWWu/rZKRacq
 OcxWdPfarrKpKsq+kD0NmhA1NYomyW5wQZCLDUiMWhduDu80jMqjDqu6M7C+WjsmWjCN
 5yNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fVQMIvyVs4riNxTQ3Ne1izpUQzix5rooeIGZHyyYcD0=;
 fh=g43PDCvbMQnBS84yLyS2MZ/lnMGufNsBZld9pcJafow=;
 b=g3zGk64a5Qm3lIBTJTpzH86DodgkPGMR397KpSdUY+DgHYDLsdhxHt0iVBfGhMR/e4
 /8TQtGck8KgXjo5/4sXVOYpkzjTfv5P/VH2vBJDvn7KqeDdBtTa1SF5urRogaTc0d3zA
 XaknwkhgLY2GhjakpRywRdktPLKpbgUepRNSj/om6a8n/fQmFB3Dz4eC2duPI6e2PPJW
 2HNRUL6UCZK3tmw/+u4DnxVIq8ZeyiKh6OjtX0NpLwswMILhp4TTN0XFGNN6jA/yHd+d
 JT0Aq2eRHD6a3CYPjNuHEkZyAaDJKfObIOeZQ+ZKgNQLNnp5az6sZj3Kaew5J0JWwd0c
 6PuQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811742; x=1777416542; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fVQMIvyVs4riNxTQ3Ne1izpUQzix5rooeIGZHyyYcD0=;
 b=TDOEaPDGSUErkjLmxVRk0deawjRHzns8UJUN6xSJJxJjq0swbCUSRFAskvgVdHC6US
 ODLjNGV4HCVSutdM2vjcTIGT5eS+LMfbRhJESzxVSDKj1MMXuYAeGeXNSFP7mKxEhqN4
 Un2wKcUyoDdvtfgvrlISkpBd+P4cR8qd5x+7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811742; x=1777416542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVQMIvyVs4riNxTQ3Ne1izpUQzix5rooeIGZHyyYcD0=;
 b=ErmplLyLvS9L/XsfXiaVys43Pa+sNfhDxrEyjapskCAg+tjSg8ibGj2wRprPtaBKOt
 Ti1VuqbX1RKoonUr7zz60SQzt1CDhMF3x+/+wC+LHGSWdugBNqiT59Hm45goxKBhjw4g
 Gc9n94+/3TLAplEg8FHe/18u/281QJnKlCcyIawnlhQSs1n2UbPM7udBcxjD2OfuisDK
 jHUHZpPoi8e6XbzE+EeO4M3J50H+3nUzwhMujJCsyN9IqnaeC5UG35Tk0qvHr0CBO2CM
 XQfJx1l8gDyXz3BSG4fB4/faLcaBdDb5/yAvNJxkJHCfemiPHHJ3NWkW5GfvlD9+YsKp
 e9Xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a6j1WBhLu2QImjsjn1FiOiFurKfN9pnZ25Ya0hUVb+XevnquDwUoUsfkBld9y5B+Qi5c5RlI=@lists.denx.de
X-Gm-Message-State: AOJu0YxzV8iOBCFxy/Z0WYof6K20kd6Q8Km5EgwVdrkmzlHPi2AkskHM
 05pt25Ej9BA3TDUKWKdgRxCVdKVWqz1307zp9QRGBY0vmj+vMAizVwcC29d/+Z0dmrwTyt/Qu1Y
 8afQDHNxkFg2fy1BAmdf0IlLfb0u+qZvq5Wv6AbWd/j+BBN7ZGpfwsA==
X-Gm-Gg: AeBDieslnr/IH+YrSO1mNV0TM0kYg3MQgiPeZlhhtJfW3nVo7eJvEF7AbjD0G/8GiA8
 IHFkq8fXMH7cgzVX/j/+xHpT3xpCKiFg4oVR2D+HFB6HpTXxhXDv5zdOEyZ9OIlK/woV+L+QUEW
 L1Cegw3El4xbHzVDCqm8GWJdwcH8fHhTgZy2/pMJcKqOgKfw7eZlz8H1wAJ71QKcf4FjokgrAva
 BIaauJBr8MfVZ2V7QbTmN89Ik09iEaAu5LOIIea67J6WM/1GJ29cSryf29WU0gPTpGivBQ8BBjK
 fievg/gSriFf/D9YJ2By
X-Received: by 2002:a17:906:c3a5:b0:ba9:2282:2897 with SMTP id
 a640c23a62f3a-ba9228229b5mr246742566b.15.1776811741913; Tue, 21 Apr 2026
 15:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
 <20260420220804.71564-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220804.71564-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:48:46 +1200
X-Gm-Features: AQROBzDWa6mJpKuLff-OqSDWSfgl41rOt2Pax9J2bCsTmpYsnwMAyyVcD0kIIZg
Message-ID: <CAFLszTg9-bsUbi2hppB4W1RvCXQUbgVm_PYtXYT+eJhuRucGtQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] acpi: add index parameter to acpi_find_table
To: heinrich.schuchardt@canonical.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-04-20T22:08:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> acpi: add index parameter to acpi_find_table
>
> ACPI tables like SSDT may have multiple indexs.

indices

>
> Add an index parameter to acpi_find_table() to allow finding the n-th
> instance of an ACPI table with the same signature.
>
> Update all callers to pass index 1.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> cmd/acpi.c                       |  2 +-
>  drivers/serial/serial_coreboot.c |  2 +-
>  include/acpi/acpi_table.h        |  3 ++-
>  lib/acpi/acpi.c                  | 21 ++++++++++++++++-----
>  test/dm/acpi.c                   | 18 +++++++++---------
>  5 files changed, 29 insertions(+), 17 deletions(-)

> diff --git a/cmd/acpi.c b/cmd/acpi.c
> @@ -55,7 +55,7 @@ static int dump_table_name(const char *sig)
> -     hdr = acpi_find_table(sig);
> +     hdr = acpi_find_table(sig, 0);

Commit message says "pass index 1" but code passes 0. Did you decide
to go with 0 in the end?

Regards,
Simon
