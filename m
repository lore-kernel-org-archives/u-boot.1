Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37C5C6787B
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C16386B5A;
	Fri, 25 Aug 2023 20:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="2z/f7b/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F61486B3F; Fri, 25 Aug 2023 20:06:26 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2516586B58
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52a4818db4aso1675240a12.2
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692986782; x=1693591582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UNgSstCD8F7Ow9gPe/oqxvB+30k5FF3RnO6AmxTrHlA=;
 b=2z/f7b/z2uPZ5Jbu/6aEDvaE8UNoKX2aTQi/whPGvAdmbGkzRls7l1rCXqdqHLRdf6
 YUhmTbGY9rzS47WsRr+YdgNUrfdAGvEg4pXSmO2N03M6Es8RYIjShJ7M3NGjrGBxkxoj
 jv+67ugXg4WFprMnRN9v0p6cJZXibuDwdCs6/BWRHj0gdYzAT7WYw7yjv5PiSeTtVLYH
 FwARxR8LFzixUvzCWZ52kC3fcZBxAEAmow2WNw6LRxxot5P4O7qqOSgxHSr8RTR2aLLa
 A6v9pFMfNMg8lGxzntGFozlwKrovpYgEE6EK35jaVQtWAdhyX0OZPzCP+zwfBFvKbSgS
 vN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986782; x=1693591582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UNgSstCD8F7Ow9gPe/oqxvB+30k5FF3RnO6AmxTrHlA=;
 b=DYzLmHlaOLB4YsHHE7INddIZBOvz2+XHQJZviCg0+1pWaMX7ZYDbYmDK77b7J9yDB+
 rpOt+90pn0fWZgflW+zV7Ishwu0xbg8XfY6Azt1YpKijoey5ps/qD0OjJdrIhRsuiBpF
 MVJsfy+2lAUbn75QvxmNcncfDJGUUaoKTt/8if/GRydygJF1IvhJlryr0X54BbT+qPbI
 r1XxLmo+RgUQJxipYeqba0Un6AxWVeP/D1g/CpX7kup3JX4lwyqqK6VtEJf63koATr/j
 BShLr32oxVbI+C420C0O3muJAMcFI9fpSOnVBzsAI5Zh/TrOvpEuHiyCdX3odvinohkX
 0zCw==
X-Gm-Message-State: AOJu0YzrXLPTIfvq1Y7v0oaAky00aXrb1VnxrjwpAu8KEurrohr4P1mO
 Qh7DP3re0szTRKskA3QFhYdHyd/SkpgnrJj31idaV5ZZcpQSf7CejWE=
X-Google-Smtp-Source: AGHT+IEEhO6J7v5NRfDqlqwgUyytbqB1b+7cqPzfXEBL+maWcoLMO4TzN2kcoA5Jym+xbntTY8c5d+fB4x7PAO4xc44=
X-Received: by 2002:a05:6402:2051:b0:525:469a:fc49 with SMTP id
 bc17-20020a056402205100b00525469afc49mr14586495edb.17.1692986782634; Fri, 25
 Aug 2023 11:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230825172127.3406461-1-trini@konsulko.com>
 <20230825172127.3406461-2-trini@konsulko.com>
In-Reply-To: <20230825172127.3406461-2-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Fri, 25 Aug 2023 12:06:09 -0600
Message-ID: <CAPnjgZ2P2XUx2VzfTwT2DeDFH_T0sKh+M7cMy6P0un90De3=aA@mail.gmail.com>
Subject: Re: [PATCH 2/2] CI: Move to latest Ubuntu "Jammy" tag
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Fri, 25 Aug 2023 at 11:21, Tom Rini <trini@konsulko.com> wrote:
>
> Move to the latest "Jammy" tag from Ubuntu.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml    | 2 +-
>  .gitlab-ci.yml          | 2 +-
>  tools/docker/Dockerfile | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I wonder if they have a 'latest' tag? I suppose it wouldn't be safe to
do this without trying it first, though.

Regards,
Simon
