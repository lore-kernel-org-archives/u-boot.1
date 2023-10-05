Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B208E936F0
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 01:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37975875E8;
	Thu,  5 Oct 2023 03:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ffIa6f2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB7C875CD; Thu,  5 Oct 2023 03:23:59 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B68875C7
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 03:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9b974955474so79351366b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 18:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696469037; x=1697073837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Kp3Zkfb8MELG0m0h9xCQ/3uQbvCVtLgq8sjkNl551Q=;
 b=ffIa6f2RbBXdxwLkWh90aAbLsZPoZg/UV7wnS0vg8oNAkqGqOvv//ja0TN3mdFyU5x
 9eMaAkiAhAnOspeUnEDdiN5E/BLx+vTGekn+0wW6I+NaSBjhsHjDrndoSfPnhPBSR1nC
 bjbpqSgXYtvgZvPutzIM65pmChnPrlXNnYe2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696469037; x=1697073837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Kp3Zkfb8MELG0m0h9xCQ/3uQbvCVtLgq8sjkNl551Q=;
 b=P/erj2UZhe+rwEK6qdvxdJLYCSr+D8udL4sfljgebEE/aTV39dKkvRFgMFVshouGV9
 Mx7cQQmlpLOwgvmwabvVHd7IykiV9XXKhORRl88nvuFKCgDpRKxZi4lc5FbGDWI1dxns
 qAuHq9Vl0fyzdbgz0MEqa/pXGA+zhmTklpKCf2i6VApH/cNpyO4x+QLUy5LlLezMGo/H
 zqctgS1awvKXrSZBkEOsPd3v9g3tCuy8eMlKNIwg6iK5KIyDnepty3Y1yP0qoPGG83YP
 86VcnZ86DxPm/VHhgc5n/MJHm+1bOFfq/kpqjloXKSRfTbmS7Htoz5M4mv0Oob0t+Shl
 z11Q==
X-Gm-Message-State: AOJu0YyQbqMH1DZwlCco6UfcyGuP4QgTr1/eNKx4yLgYHvB7FGVvVh1s
 Njl5ONBSl3wlSXxvl/t2pATgaTio+z/21r5Ec3mc1Q==
X-Google-Smtp-Source: AGHT+IGdKr55jWo3p+XEnzkgSH7DJ9bZ8rqe+ziFcj4zmFFhJ0UCT/PfwjkrsR40KNEUufR7Z80OqKO0UZdIRdWshbw=
X-Received: by 2002:a17:906:74ce:b0:9b2:794d:6225 with SMTP id
 z14-20020a17090674ce00b009b2794d6225mr3423771ejl.56.1696469036562; Wed, 04
 Oct 2023 18:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231004085635.330221-1-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20231004085635.330221-1-lukas.funke-oss@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Oct 2023 19:23:42 -0600
Message-ID: <CAPnjgZ36Gcgc0LDGW81-zrDo+9F8ogs7XsE8bfdcpZDvn54xXw@mail.gmail.com>
Subject: Re: [PATCH] binman: bintool: Change make target arg type from string
 to list
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Michal Simek <michal.simek@amd.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
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

On Wed, 4 Oct 2023 at 02:56, <lukas.funke-oss@weidmueller.com> wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> The argument type of `build_from_git` was changed from string to list
> in d71e7116997f14097735f04cc7847f0a68dbc485.
>
> This commit adapts the argument type of all bintools using this
> function.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>
> ---
>
>  tools/binman/btool/bootgen.py  | 2 +-
>  tools/binman/btool/fiptool.py  | 2 +-
>  tools/binman/btool/futility.py | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>

Thank you.

Can you please resolve the test-coverage issue, too? It is the one
line in the whole of binman with no coverage. If it is not needed, we
can delete the line, perhaps?

tools/binman/etype/xilinx_bootgen.py                       72      1    99%

The offending line is 216:

   data = tools.read_file(bootbin_fname)

Regards,
Simon
