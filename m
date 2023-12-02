Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD80C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5491B87759;
	Sat,  2 Dec 2023 19:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bUsABvG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F8E387754; Sat,  2 Dec 2023 19:30:12 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20CB787759
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9fa45e75ed9so462293366b.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541807; x=1702146607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x4NE+ITNZNedbYKrWqwPzsFZ/y6GVHgQxjy93pvRqEc=;
 b=bUsABvG8VqYu1yW/Pvu6AFyLZt4qS0Yj/XUFumcKCb6vXlVmjgvchVS+/7D+J6wDRF
 gNDVXFdkCWFQ3KsyFfHORxDhi0wq0r5Cq4Y6PG4SWfLsu/ka53e/HhJw7FcU1oljGDHb
 8ZN82ZHnwGTrMeghn6s8ZohhICZzJSMSzyrZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541807; x=1702146607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4NE+ITNZNedbYKrWqwPzsFZ/y6GVHgQxjy93pvRqEc=;
 b=VoqcgpKA2l1cLExnmG2fEz7iPCTE7HYKu7CC5cz3Ex9MskhZurhSoe5B02AIAf2p3Z
 Ta6ALCEz84iK3RI5UmENAQeGXW/p6opQLcckfG3hy7I3h3Zdjc3e/8FMNWD2n3T9CnYC
 a50vWgTgVhUMCXzsPKvK3zVGlqMj8OZf+TJIjJ8gfYVYQypcDxZFxgV4dUnvVgvtuFo3
 dSL/Qbjgj6dwf9JW0s4HdJV/5KUwlMeCczxzmW2wYSEtlOjFPmU0NJM+h5c6qcOqeTyP
 I3rCOMf7vO3IIp4TgdzUt9zg+NW4LuC6i7qnbKT+l0iwGWGJOM76YTG+mXfpp7TlWNij
 t9og==
X-Gm-Message-State: AOJu0Yyqo6bUrClv2dn2kRyhBthg31qv1r+fFWS07FGLgFXuSTw1vxWa
 YkW7NVYUCqkK1WB6ruRiZ+k7fiDDqXMNEIwSpXyDKQ==
X-Google-Smtp-Source: AGHT+IFf13Q8dj4KONXtxPYXsm1dlLQ9aFeGOG7/XmoMaSQuAioSnNdWGoHy5jauOf9ocMMUIWKZwoK6/1TGtZ+MKJw=
X-Received: by 2002:a17:906:3f0a:b0:a19:a39d:8f6a with SMTP id
 c10-20020a1709063f0a00b00a19a39d8f6amr2045696ejj.8.1701541806821; Sat, 02 Dec
 2023 10:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20231125162705.1383401-1-devarsht@ti.com>
 <20231125162705.1383401-8-devarsht@ti.com>
In-Reply-To: <20231125162705.1383401-8-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:28:24 -0700
Message-ID: <CAPnjgZ0gS1MVER3=mi0QfQE+pj_TqqFg6RKW_+5QicHsdbXFtw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] doc: spl: Add info for missing Kconfigs
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

On Sat, 25 Nov 2023 at 09:27, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Add info regarding splash screen, video, bloblist and GPIO related
> Kconfigs which were missing in the documentation.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: No change
> V3: No change
> V4: Patch split from parent
> ---
>  doc/develop/spl.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
