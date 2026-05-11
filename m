Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812B0CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 392AA84659;
	Mon, 11 May 2026 15:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HJpaFUdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F96684659; Mon, 11 May 2026 15:30:15 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 840338460C
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67179ed133dso5195295a12.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506213; cv=none;
 d=google.com; s=arc-20240605;
 b=Fvn61mEN5sdY2sgNHpMuvrb1Cd7IPZBNFRveBwbz1+9G4i9OM9QwBL64yA/RVoHJEe
 719H2RGNbnhc2bHs3Ql76gKjucohRfPrLRbZ4uLqqSX8/SMPSitIwW0rDmSqB9I7EEQC
 zt2EA9QGGXGonV31MTWFUq4vKTgGolwNBDkqN8OWjCZJYfMdvOOGo1tGW5veaQs57vEx
 ZpYnTueA0VZLZRLNNQiEJ+QTkr7MFUjJ6y4xkAV0k4oOqKm9OHmdix4cGAn7NbpbEo7q
 JW6xmzfIleJSefZ+u594rfRMRJaswwKEhcg2l6uDa33zBFm7/+vizfIcll3PXRQsiGOG
 FaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kJmAFlu7+2/SmZnV2Sck6YZjwg5oZzHNumAasVyX73Y=;
 fh=fBm7EhaxT1SUowwZhYSK8KUZMRMH8OcBza+3EkETRk4=;
 b=Z+OgQ0YvkvgNqM83jgRyYoCOCx64ct5S5bHDd2SpyAzLmhkq37AJppwfNiIt0LwJq1
 uI7tcU03OxMQDurgAjLWdZRzP7FqHI3pgA16xIuQWsFkWhvdo0DFWCGqNk/mdLA8+6P8
 qzcx9a25YNN7lGp2Qw2cAE33/yYw7mWe4+EituEQ5Cpfg6DiofQQVqC9iyqWp2eREVcc
 VPgE5DEtOkCh/sMOyDpwKfPRggHOO3c+s1da7t5rKSYZBzDEhjkEffCP/9uphwSeNYZG
 +gqddJOcOsUWWOCalDi4wbOM6USpJsllBz3DdHmRyyaLbDthg4GL7Jw7tUSjRpCly5LW
 ZwXw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778506213; x=1779111013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kJmAFlu7+2/SmZnV2Sck6YZjwg5oZzHNumAasVyX73Y=;
 b=HJpaFUdR2Rl9/ByTKuNACGG2FK1gtgO3wf1APOdhwGRlkmJguqybwgftzD7YWS4BXC
 Po11V2Engh9zI+NtJzeTRgPXS67ed3j/V2vgNMDve2KsFzbQt6WF63rOiQI5AcvLyHAQ
 RyRxuDFqkj9Qm1S7EOInPim1eQJ/cyUGIwAM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506213; x=1779111013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJmAFlu7+2/SmZnV2Sck6YZjwg5oZzHNumAasVyX73Y=;
 b=UERy2zq1H2sDXUcZwjentAr81r1c+yfgFqaf9l30cfCB9ZOsaAIh9bdb1/3RjqY0On
 CyuNw8juFts7JVB1XfdBgr5fSah9lw0DFSFJg3QfaA/crHre0g4CYh1MGl6Ak5UIhPTF
 Q59K9tBEWrNbq2jXglOu9xb+6nhBAp1azXDsXdKDC8tJbLP+UQdoaLT9S4HTwd3x6eW5
 WTaXhjoRs6WKK4/7hogm7VGckVCovqU+mZt/yOajQ9IM724XgRd6VDYb+QTIH8u5VyM8
 dk1Bm3pAhc6ZP6GFWhFiFDR4FUkLeBcoWfX/ZkjuoRtm5BSVkrWplOLvCZVheecNNbC8
 8T6g==
X-Gm-Message-State: AOJu0YzU8HXbwvYvOG5HDJXlbNkxrCkuCugXeWBU4AP98x8L6Uj7qK2H
 jI9B0IDPzpxEZi1siB/z/ZLWr3TkA+hbhrGYf+d2iAj27uEVRWBKS8VjHZwv4FXFvbrqNGxKz85
 3tEA1OTpcczl05eU8rSdBbbFqm6ZvLNOVmK40Amrb
X-Gm-Gg: Acq92OEDKhqJ2JB1UGRTFrgt5qt81hsOVXFxTm3WV9tCk0YLuocoR1JjzMrkolYFG4U
 B6XVek+CTfAAjE7mdoeqIOJatifP7zupeqwvCs+/r67UeMwpR88IeYpvoO8HtRZcVRjDjh9K+C0
 Y2FXtJh1deJ2rpOW4vK9QUGkqy6omcZb79RwXCXlts05v4x6S/8Jj5dp+ZSHntw3oT7BY/ihcOK
 4YDrT0U6TakTvqtqUM8O3nkWSoYG4pz6456vo93n7TG8JfBFgBU6wAZkVsxW/gJh2T0unXyIV1F
 uCjnLA==
X-Received: by 2002:a17:907:a704:b0:bd2:bb2:9308 with SMTP id
 a640c23a62f3a-bd20bb293b3mr27728666b.0.1778506212684; Mon, 11 May 2026
 06:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260508213217.3807786-1-aristo.chen@canonical.com>
 <20260508213217.3807786-2-aristo.chen@canonical.com>
In-Reply-To: <20260508213217.3807786-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:29:59 -0600
X-Gm-Features: AVHnY4ItUmKEGofmYhyF0HMAJafE3rTpqUDOlVjqp7TmDyn5HbYb3B9Ao_nkFMM
Message-ID: <CAFLszTjMv8Y-A_4XRfDXPK_87osk7_TqpBsiBD75L_ze6eyUQQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] boot/fit: read default-config property from the
 configurations node
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
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

On 2026-05-08T21:31:58, Aristo Chen <aristo.chen@canonical.com> wrote:
> boot/fit: read default-config property from the configurations node
>
> In fit_print_contents() the default configuration's unit name is read by
> calling fdt_getprop() with noffset rather than confs_noffset. Today this
> happens to work by coincidence: the preceding loop walks /images using
> fdt_next_node(), and when iteration leaves the subtree libfdt returns
> the offset of the next sibling in DFS order, which by FIT layout
> convention is /configurations. The depth counter then drops below zero
> and the loop exits with noffset still pointing at /configurations.
>
> This relies on /images and /configurations being adjacent siblings and
> on the implementation detail of fdt_next_node()'s post-exhaustion
> return value. It also blocks a follow-up conversion to
> fdt_for_each_subnode(), whose post-loop loop variable is a negative
> error code rather than a valid offset.
>
> Use confs_noffset directly, which the comment immediately above the
> call already names as the source.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
