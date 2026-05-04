Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83896FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0632D846CE;
	Mon,  4 May 2026 22:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KdcHjJnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0808B846F4; Mon,  4 May 2026 22:31:28 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65F8846A1
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c8025aecc40so697109a12.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926684; cv=none;
 d=google.com; s=arc-20240605;
 b=TgWzTdvEhcY5Eh2fj4EcCCsHlNCEBZPXXDFmfSiCtlMsYikIibpxtbUrI+h4vaWXt1
 0PuH2wuhN+zp0Yjv3lbhdFp98wiXCSnYAXWWEjnQZhK1IPo6Xh3iqioQeQsk8AKeAilM
 g1uIXxJKg8UgX+QVxvafMP7UHvRANGwfuE94+/6mt+k847RfSydMKxkjUMgYCMqE1/Tx
 j1/SGia/OyZyDCpLITJQWBkcfs24PvEHnzNMHSQbaMMB6WmP1yDv4vl6nuXAseH55FjA
 /or5DX9cIDTFBkXOTScsQjFtP9DmSZhts4Bk/Zi0cIXEJDBlNIAYPNUMhtbEED5+ezP9
 IzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V6zTfvO5m4cGnjW8GLaBOAw1I855z9ylRWaZfCI8DX0=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=IDHrmT4ZWxwIAsd/egZWPVM9jlVYq+268n84iJx8OtmCzpuOr1YOIV00Ic24D3hSWB
 fvJ6iE61B8Ex/N+8Qmc4pdXcS2W+28N4LvyVndrFJOkgXDj/6vQk1h3HFsTQhGyUDatO
 sYqzQ/BBoebsMG3LHZy2M6Wk6f+x6dDxkIPjbp21aRBEQsiPjQQ3v6V8t2rNneH+lPV1
 KVUcxaMAUZy0aeP6N3gUF8KTT3R9jRaUM6DKEufbODItUx3MYL8jn2PSf5dfwUQrL6y0
 0BgRdHdrq2kejLjKEdtKIFa2CLUX8LzVBJx1OIDAruQu5oBsMKIYdW9A4pa2BrbzLMHa
 kesQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926684; x=1778531484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V6zTfvO5m4cGnjW8GLaBOAw1I855z9ylRWaZfCI8DX0=;
 b=KdcHjJnqpYy1b/+UCpwcrvaoFAM5A6/d9qct8H281fgmW/YcuRNm2FUyjXluYeb5RW
 VrFoIl6A9ce+l3s1yyiY858y+GXt/pmEpa+CPE3OVj+lbMVSfOYZKll57Pv89SyrzJPw
 2FLu3Yi62o05MEkL1AXk+x3N+mQ9/1IpkyquQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926684; x=1778531484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6zTfvO5m4cGnjW8GLaBOAw1I855z9ylRWaZfCI8DX0=;
 b=nGj12I7PSxFjvkCWdUzXahM4ky/dI3LoUOuOxdpc16bQI0lly+whJH+nexx7zbaLSo
 PXEZ7WcKA5JHakLsmeShJMOUj0ak7Y/WdqLoeTIlEZwkl1JkLig1dJ/+2+9ScUa/8OGR
 X4lUkNyFlAs07DqeUEyaRpQE8qyJ2xUdqY6+DwFB9RCald+jnvA5NUNUeXdj2Gj21e6s
 kJveMMfNCeQ8HX//ffAhmuoCVN0N+Zmbp1M+aUneJQM5zg1yGXne7O6iO0wexM3EhEah
 kAivm2lrxOcHFFQSp+U1l8UB3bHry0qiXjfp90uY0JfpJnsnFWUjCO4w+aLryqEVM1C7
 yWWw==
X-Gm-Message-State: AOJu0Yw127rcnKiI1xTE2i+Hn/mMnutVhPGkbUCA2QfGz784b8nkBOj1
 lFKbObxaS4aXVk2WsvBfq/Dc2Q1oCAELvLsx1hkk3DQNwfVvZjWfbuo/42w3ZScNAikeq+IJQGL
 tWINWgn+/QjFFfvbOllbXSucz3ot/IGx+JUC5ypIN
X-Gm-Gg: AeBDieuTdKYtiSnfOKY/KmPH5O2Tzs4dx9RVxqEwO/1YFncNh/izLrhVUHsUflAkc7a
 YsUTd8IOqG+JtwpMX6kmqFD0kJ/KY3k/L1TlcfuofXUJzLpjy/SSfa95CxAai++lmxQSYWj6pqj
 vC8/CBnL2EzQ8Qua7piQ1Ex6mwdANn+X10ONVztI8d1rSAynfWgCXEBRe7O2u48PBKCveHf1xxO
 5qHq9YACHeGTrCAPGM8hJUVF8Aq3ezu/U1DxtC5sRTvBqs86JZUHALkN0FEWOBOkGYNO6xuj6kC
 qQfIlncY5FjTlUrfXzgpqcTo16U=
X-Received: by 2002:a05:6a20:a104:b0:39b:897c:6f8d with SMTP id
 adf61e73a8af0-3a9f762e6a3mr859876637.16.1777926684296; Mon, 04 May 2026
 13:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-7-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-7-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:37 -0600
X-Gm-Features: AVHnY4KmHa1mpFglPKh8aNhFmxy-8pO-O9LKzzFrUsbzwFvFnj0xSHG6n_L4uzg
Message-ID: <CAFLszThyTyCa8H5GTWAddKBNyiyBcnKes2YtVv_DB0nyZ2oYkA@mail.gmail.com>
Subject: Re: [PATCH RFC next 07/18] scripts/Makefile.extrawarn: handle
 CONFIG_WERROR in U-Boot-specific file
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
> scripts/Makefile.extrawarn: handle CONFIG_WERROR in U-Boot-specific file
>
> This is not something that is in Linux kernel in v5.1, nor in v6.1 which
> will be the next sync. Since the next sync will be importing
> scripts/Makefile.extrawarn directly instead of backporting individual
> patches, CONFIG_WERROR handling would be gone.
>
> Move the CONFIG_WERROR handling to the U-Boot-specific file such that it
> doesn't get removed during the next sync.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.extrawarn        | 3 ---
>  scripts/Makefile.extrawarn.u-boot | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
