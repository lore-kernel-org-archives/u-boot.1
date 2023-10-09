Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4D5CD6115
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 17:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FED786BCD;
	Mon,  9 Oct 2023 19:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kRwiytXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB25486504; Mon,  9 Oct 2023 19:57:33 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 805F086D2D
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 19:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59f4f80d084so57409357b3.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696874250; x=1697479050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E3qsKh/sEvkZ8y3e1QEB7vW93vXOQPwUzwy9F+BovvA=;
 b=kRwiytXEGXfdVM0y86TVfbov6YowHh2uHYdiwWPfy3L9/AxdgXY1zLu/xqAj0w3AWV
 Z6I+pvLxEJ3GMfqgAfM7J/e85e2Fa9gVYk5HefbS8xzrT9ud7GFvHVnrHJaEuFf3LWTK
 hpxVQue3R34Q4mUuh9Na50cjrdB4lCyDYmig0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696874250; x=1697479050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E3qsKh/sEvkZ8y3e1QEB7vW93vXOQPwUzwy9F+BovvA=;
 b=U0hLF023i3wr6naZj48GWRlB5nHUpmB87XkuZUeKATS4VN0COryWPA/19GwAO3HKrY
 Fa+pJ/4109nQ5P32C28MlV2HN66rtz5cCmwgq0N6hhrSqHVGPw32uo0tZ6sTCPtaI5B1
 bcSPWXeaszO49ln6UlU8qR/EVTHWDh+qq5TCRtN9V2axxwdd7WDxuP63QQbtlyaTxtsI
 Ki6KDvZZzfjwjH/v9VOQjzUrFcD0DCvv75ZYFDOc0YRAVYJf2qA8kUl1X9XeoUcjarVd
 IBOyTJybLVLfTN9B2pydG6R4Cc+ZPcF0w+jUfU4wIL+cogRrIOlHAya1CxrD75LIt19o
 vTpg==
X-Gm-Message-State: AOJu0YxXbFv+D+UxfbDBgTzD0BR2CqKvLZ7j/qdnjWH4xojWexPlzQ56
 r3IAMELfrnCXiWhnjM0bMSg3gbfbXBHjXcxfs1d4zVGaIurz6OjDoj8=
X-Google-Smtp-Source: AGHT+IEImPemJ7r8hpCX2xjD2mbqoIvwusgQJ5jOGLOY76cH4NBCRl/aYWOZTBRWUqAUaSOkV5ZJgKcb1uEz+/LUOHc=
X-Received: by 2002:a81:4523:0:b0:5a7:aa7f:17d5 with SMTP id
 s35-20020a814523000000b005a7aa7f17d5mr1359213ywa.11.1696874250031; Mon, 09
 Oct 2023 10:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231009144151.773721-1-artur@conclusive.pl>
 <20231009144151.773721-3-artur@conclusive.pl>
In-Reply-To: <20231009144151.773721-3-artur@conclusive.pl>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Oct 2023 11:57:08 -0600
Message-ID: <CAPnjgZ2730+-hv-uPiq-Z_kf4w0Dpm0ekCNC=8Z+m0qgRESQXw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] event: add new EVT_SETTINGS_R event
To: Artur Rojek <artur@conclusive.pl>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, 
 Marcin Jabrzyk <marcin@conclusive.pl>, Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?Q?Rados=C5=82aw_Adamczyk?= <radoslaw.adamczyk@conclusive.pl>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 9 Oct 2023 at 08:42, Artur Rojek <artur@conclusive.pl> wrote:
>
> Introduce EVT_SETTINGS_R, triggered post-relocation and before console
> init.
>
> This event gives an option to perform any platform-dependent setup,
> which needs to take place before show_board_info(). Usage examples
> include readout of EEPROM stored settings.
>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
>
> v4: new patch
>
>  common/board_r.c | 1 +
>  common/event.c   | 1 +
>  include/event.h  | 9 +++++++++
>  3 files changed, 11 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
