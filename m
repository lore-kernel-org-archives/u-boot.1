Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ADCC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FA2580EBD;
	Thu, 13 Feb 2025 15:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YTq11hvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEE380EC0; Thu, 13 Feb 2025 15:01:17 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B0A807D9
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5dccc90a52eso1371900a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739455275; x=1740060075; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3AWRpQGwvJXa1gkX8434nT9JO0TCa3tsfTLAAF4kP3Y=;
 b=YTq11hvGrp0BT1HOU+4m5rekao9pWV/NBem1fdVJGJ5eRqmjbvx0y2gPNH8k1M4CKT
 oMSM3rMiPLesmdUbEm2bcoa2QNtvZzY0hIoCi3pAsvzL2yg2UpJU0yyHmL6PFn4qRfD0
 /kb3Dw6lCpCtIQhtVybWgM8RQtLRdBAUDKaSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739455275; x=1740060075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3AWRpQGwvJXa1gkX8434nT9JO0TCa3tsfTLAAF4kP3Y=;
 b=KFqdNUNZG9wDEhH/SocxedqshQFmdxIlKx7AkjDilLGx6GMt7nCJkUSX1nix2Ikk6T
 YjOaG5R8kknj+7ksKMZn+LRtpnUr93WZiieLt+5IB22MYutRvC54YLMxOaSenERTb/wO
 wLAcdYHT2KCp3zAX57nYGRb2oIYDVZWCQI47z/+1Vvk9W/ducB0xxFawyjMhAcO4EaMs
 o8OuoVEErU630BsJZAElgG+PdZMEOyOxJKzi+8p01Tzo4qSvG/KGpCwHMY+rTV919WSY
 CzpfTjZoofLv7VJXYdGz38mVYdQ5OnJLn/OeTBMbSZSMHfM2MlZDRU+FFHH2NzPe6WJZ
 OFow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOi2Sr5ph8EOcFf4R3aydH8moAT7Oeix1lukFl2BZjZprIJ2nHzJ+NFXMn3HKl7DNl+XCd7PU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/zM/Y2Q+8xAvIDwstwUbpzDi0crzNBRtjIIz47ZWnEBcChZkB
 TinsMfgNbC/upXllQFCIoaTfyrc/7PyP3LOb2KUc8ZzFozI5AhBXP+EvWNJiDUa18nMeUx9cMpB
 MAMgfKBLfOfXgkhaXsu7ta0qpvheyo75FZPy4JVhA/MuHtiI=
X-Gm-Gg: ASbGnct/EvLT3Zy6NtUb2+oFDZZD8Uv0PUYUJFZ8t4yBlz4DXIUF+SxCrlFjGnQI+JJ
 MYTZ12N1h1tIUnlUMG3CZEER5UPZ5+zJRY4uIvVnaqFjpuC7zN/mBCxAZwn+HUwI6ZKRK0Uap0d
 Q+aoZWZQXau0H6v3S5r8JV3nbx+NL9
X-Google-Smtp-Source: AGHT+IEzpFFGgDQ0rSw+lzXNArKsNiMgn6w3RaB8oF9aNBPKeVKSvgYqLDoJ6vsgqiWGk3Wqlq2swCXko/qXQytSgRo=
X-Received: by 2002:a05:6402:34d2:b0:5d0:81af:4a43 with SMTP id
 4fb4d7f45d1cf-5deadd04147mr7442547a12.0.1739455271480; Thu, 13 Feb 2025
 06:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20250213-b4-upstream-j742s2-v3-0-e00f2a73efb0@ti.com>
 <20250213-b4-upstream-j742s2-v3-1-e00f2a73efb0@ti.com>
In-Reply-To: <20250213-b4-upstream-j742s2-v3-1-e00f2a73efb0@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Feb 2025 07:00:58 -0700
X-Gm-Features: AWEUYZkdki3r4FUde7M9lA3i7DhtwmHmMeR5eMSCHE1tZHPR7cVYtHVrA665nqQ
Message-ID: <CAFLszTg4jaiF+PPwOiMuYJNCdwSR0Kb6k0y+SZd__zAnNXhqDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] tools: binman: control.py: Delete template nodes
 after parsing
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, 
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>
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

Hi,

On Thu, 13 Feb 2025 at 00:36, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> From: Neha Malcom Francis <n-francis@ti.com>
>
> Dynamically going through the subnode array and deleting leads to
> templates being skipped from deletion when templates are consecutive in
> the subnode list. Prevent this from happening by first parsing the DT
> and then deleting the nodes.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  tools/binman/control.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index e73c598298cef76cfdf4f0f8a021feac1e7b825a..81f61e3e152a9eab558cfc9667131a38082b61a1 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -522,9 +522,13 @@ def _ProcessTemplates(parent):
>  def _RemoveTemplates(parent):
>      """Remove any templates in the binman description
>      """
> +    del_nodes = []
>      for node in parent.subnodes:
>          if node.name.startswith('template'):
> -            node.Delete()
> +            del_nodes.append(node)
> +
> +    for node in del_nodes:
> +        node.Delete()
>
>  def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
>      """Prepare the images to be processed and select the device tree
>
> --
> 2.34.1
>

Can you also please add a test for this, to check that the template is removed?

Regards,
Simon
