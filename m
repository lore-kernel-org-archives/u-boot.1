Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C2C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD8D864D8;
	Tue, 29 Aug 2023 00:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="aKvW+V/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C3C86501; Tue, 29 Aug 2023 00:10:07 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B284B864DA
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d77b9d574f8so3346895276.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693260597; x=1693865397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hmS9pdWtG88n3gh8xVQEKv4lrcU1xwGGfMX/8bbYAXA=;
 b=aKvW+V/bVbkQeXhAfOmXuUVrtjhjdMeytJSeBFvzJPf+DrM0oSpiKX0cE7pDeVOY0g
 XpAyy3UHOj5uLTqh9CL56x9KpxvLC6+o5BwDtpgKXZO2vjjm0cyHLgsmMiqgD0TV7E5A
 bKAaZs9uZWq//yjPGbXCsu4Q4UkPBucLEYmnLAAER591HoIfjlF1YoJgasw/Y51/Q40X
 vL2ppIqUXOGPFAp7wqBUribaoX7slkEjIC9OENQraTGA278BhZuC/cfCb+LOl8Ctz5EW
 aFsnQvhryVRVyx/VT4pSBBCNwhFb4r2E+R2biSuMn9nSjOG6FLu6kFQczm1iQENdCEeX
 1uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260597; x=1693865397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hmS9pdWtG88n3gh8xVQEKv4lrcU1xwGGfMX/8bbYAXA=;
 b=ZjAn7Zen90XD+VeXKrixoUcXDx/8sTaTf+0POIj1xtw9CI00iaNdQ/+yEsj+QrGQvX
 0ASsdmmpRvWMH90Q/s3CaQ61t/HIgvMF/ul9HtnLWbDLDhLldNS12DBxLWKPW3ZxYxdC
 nktKM72Ywn+ZW+LPWOmyOc5oefUIv78N3iXqFXXwTOI3tzsujdGAEJtfBNbNF6arI+uk
 K2fW7WmD41cBB1w1zuudFI05I6C1Kxc9F8yNvGagdh/qEq5N323uEM9kso93+rvZ1lkM
 q1JR9BnO+SufAmGwgd296KEyggSIUaDk672PjrsdiPqpLvfKg5YvlTjwP1GZE6gXOMWh
 fGFQ==
X-Gm-Message-State: AOJu0Yz65/3ubEvjvrMVZW01rtCdQgnX7K1zOY7biCe3rfn7khCUVTYm
 VL/1WS+ISK0SwtQ2XGPlfOMMvzRfoGsA0DoCursK+A==
X-Google-Smtp-Source: AGHT+IFppu7eoluSn1j1r1m/ccuQqamkBfg0Lrs2PS5c3eNtg0QYGxPyz4hQ/nx5f2OSQt+D8UuV4DLSrqKnQpA1vCI=
X-Received: by 2002:a25:ce4e:0:b0:d78:322a:c47a with SMTP id
 x75-20020a25ce4e000000b00d78322ac47amr10391498ybe.56.1693260597163; Mon, 28
 Aug 2023 15:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230828204047.91300-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230828204047.91300-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 28 Aug 2023 16:09:32 -0600
Message-ID: <CAPnjgZ1=waAnS8-9NMmE+iw+fvtg=ugFgAn7Xhe6YDOpCw3XKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] video: fix typo in video_sync_all documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
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

On Mon, 28 Aug 2023 at 14:40, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/there/their/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/video.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
