Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0BEC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4B8864F1;
	Mon, 28 Aug 2023 19:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oGcfnG1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 892A486503; Mon, 28 Aug 2023 19:55:20 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2018864B3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d77ad095e5cso3601776276.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245316; x=1693850116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h19KjLtKgx3IXefBuma9sclq55GQDEu0vR+zxxlLSOE=;
 b=oGcfnG1pjuGzv91JLeztLVQDPt83ywr5kj7iRVfLD6oB/s8oE2MqlOTEcFAaWQRWDm
 m1mhob09Gr56F/6aX8VePRtdGsc5rVENQP3oIcQNMo0QhtmP+y090vdKCLpMK+m6bdIE
 ggY174GzunKA4YWEoFRIassBTygnH02CvZiQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245316; x=1693850116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h19KjLtKgx3IXefBuma9sclq55GQDEu0vR+zxxlLSOE=;
 b=heQnaVitrlDtrZaNC9nuzcAPl+BvJ8ULPrAxGZxlSVEvnbY3A12BNBCk6xm7HPddb2
 7vw1v1ATqD0/KqvP4F12CdIEUFcKx+dBYMyY7w3D/tcFzDOn24Tngt8kTtjGoRuaYXRo
 uJQGb4WHlvUShlkXgQX6ylAXUVYtgA2a61/89rX1gratiRUpw80gTTT1eqtYd+Mf45MY
 GnJ3bMmB6JTk/jgrWn+Ee/3sfpBE9G2aWycBwklMFRKmnMEBCFU80ZKeTe3vsuU+FHgW
 xoCaBwceNq+glAm+4h7HKJK8Rd3oHliNQSufQRistG3NwJ/VnbEQMkj8DwoTtCnqyp5k
 lz+w==
X-Gm-Message-State: AOJu0YwIjNkqpzo9XscnMo1EQEVlKvbvKZb2EVACQ5vhXI8nJbpFH65v
 lTBbBGFzcTaTfQ0BOtbb7NSFNx5nOR8F+KwUsuboag==
X-Google-Smtp-Source: AGHT+IFWXHnAP7N057QNjCmudOWNNrph6U6xEgUmTgbyiwXyNANshLS/NIo3WEK6UySenxAu94uV9nI0YK9XF79ih4s=
X-Received: by 2002:a25:ab0e:0:b0:d78:21f2:a404 with SMTP id
 u14-20020a25ab0e000000b00d7821f2a404mr10967787ybi.33.1693245316362; Mon, 28
 Aug 2023 10:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230828152226.73466-1-heinrich.schuchardt@canonical.com>
 <20230828152226.73466-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230828152226.73466-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:52 -0600
Message-ID: <CAPnjgZ0gQWuD3rFnsoxZp4i=dwL+wkqxxYC8AAFjSg4ejtUkcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: add events.h to documentation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Mon, 28 Aug 2023 at 09:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add the events.h include to the API documentation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/api/event.rst | 9 +++++++++
>  doc/api/index.rst | 1 +
>  2 files changed, 10 insertions(+)
>  create mode 100644 doc/api/event.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>
