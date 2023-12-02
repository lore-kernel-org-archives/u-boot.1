Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0BAC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FA18767B;
	Sat,  2 Dec 2023 19:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FjdA1uE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657AA876CB; Sat,  2 Dec 2023 19:26:54 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61CE38767B
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-db5e692d4e0so1551651276.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541611; x=1702146411; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HNDeXHvG8k1Kn0R5F8mTMC1GBHUhslZA/KThqkn2bTA=;
 b=FjdA1uE5NsbR6gpCiFlGNhupYcweuV4Nx9O9NprjI/YBYQq51sa+Cm3S4Jw7OCBTGL
 A47DTGAn4JtnrU9vaWh+2T1hhm8eFKl2M9dele0+K/eDDigKcFhAg0ed6TUaHJ0Jq/Z6
 TGQtEIG8QMhTOIzcLhYu9MNo6w3mL9DjeDy1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541611; x=1702146411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HNDeXHvG8k1Kn0R5F8mTMC1GBHUhslZA/KThqkn2bTA=;
 b=ENma5Fzs6im42XZxxtVfVTl03uup6ivQNbAeQiaUGd6733xAfiChxB8itw3MnqjXNi
 uGLhYOQsLL6SyF0DjRIomv4ss2sz9g25db/MiXpuqANdX14n+vCHSVZYES9/5kYw9yn/
 kk4bLG2X6GCEO5RqLV49nqY8tdlWaMhRlixvfJ5TOUx2xK3JziCOX4xE5ATW4h147RcO
 40q5GTx7Xi2bICx5MGnaqdXMyMykjW8823JiaYm2BmEwJLgVkaGYE+zI+0cJk1Fxp0oV
 DGQY4nKXMsVF8EL4Nm5cl7FPSMXC39Q7Hgt/bEu30QTDYEI+qNt3cRQLamviAMGzbOW5
 igLA==
X-Gm-Message-State: AOJu0Yx9baUtqHt1sxjJUjNDpxR+K1EJ5cN023Y6MMcNj3Rxkt2X+fiS
 thZAuVnqLiuq8BgXktoBc/8cWcgGhNmiXQfRUwNNzg==
X-Google-Smtp-Source: AGHT+IH5QlqbZTZUOAAT7NnPtr4sd41/nlUHAs9X/VXkzQ5Ya/tQNUF6dNhrL3wjZ0YyVSUfcSkggT9oWM+0DjbCRlM=
X-Received: by 2002:a25:ac24:0:b0:db7:dad0:60ca with SMTP id
 w36-20020a25ac24000000b00db7dad060camr1010647ybi.87.1701541610918; Sat, 02
 Dec 2023 10:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20231125162705.1383401-1-devarsht@ti.com>
 <20231125162705.1383401-9-devarsht@ti.com>
In-Reply-To: <20231125162705.1383401-9-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:26:37 -0700
Message-ID: <CAPnjgZ0FZOka1UYSTiWVxCWHBbwgNi6cNYb_c1sVMxf3HhMCQg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] doc: spl: Add info regarding memory reservation
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
> Add details regarding scheme which need to be followed in SPL and
> further stages for those regions which need to be preserved across
> bootstages.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V1->V3:
> No change.
>
> V4:
> Split this to separate patch and add more details regarding
> memory reservation scheme that needs to be followed at SPL.
> ---
>  doc/develop/spl.rst | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
