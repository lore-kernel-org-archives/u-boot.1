Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B61C83F04
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 23:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEC486AF6;
	Sat, 26 Aug 2023 01:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VmRUXm28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63EBA86AED; Sat, 26 Aug 2023 01:53:39 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC39586479
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 01:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso1957710a12.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693007616; x=1693612416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WDZseNqckS6mJ6QY+BBNDPvv+KGYJwbr0AHEuLG20SE=;
 b=VmRUXm28eOHz+Nhrz1cyW2HGhW9oyoR2URd2L6NEJPnU47gh6I8DOzevMqHWp0LpYz
 A2Xzatrr/5coRDfm3tb86tCUjOAfkbhMVbBus2VgromQsRiUiMJUNuZr6M6oyztbtG/t
 9zUl8OHIfLivKPI9Oi8OnK7N6J2JiBg6gQwsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693007616; x=1693612416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WDZseNqckS6mJ6QY+BBNDPvv+KGYJwbr0AHEuLG20SE=;
 b=WwHtW4enRh7YCtxeDUlzMKvVWydNoQkYCngOlbcwOeAjktyjbKDCAtj4WdOhpfRdb6
 A8g01kwt/PwZBsv7MnQ0nKugDa4Ih2VjFwExSDY338kmXUlC3b3OgscoO5xGrSVfEntD
 O5ME6LSjCkbTIsfjiTIf3XWilvvF9pIrFRuBY+z6NBDWecbHeHzCtJM2e93hQfGyTHvd
 txbSmP7NEM+53XVValsD3mFTwnJrW0cKIDNZxfk1CmIFIYZYA6TLl6GToJg/bXicJZpE
 u5dsa4U+gpe0OZCHaOWZ6vWLTuEWsE1ZPR2Rj/mHTx+ytwLwIL/o1ONfxRytxqG+EzFW
 TkLQ==
X-Gm-Message-State: AOJu0YyS11oVDVUFCEH7a+oUKi/3Is3sIZ8PnRu1Ebh2m0OI1X+bgoDC
 lF6b6MvQ6yjRVNbzPod7mxdRfLrKlRowU/aCEDzo/Q==
X-Google-Smtp-Source: AGHT+IHDDZe+uvNX6BUt0jVe22QSsfbLWFHXFAsT1bXbpScBw/wPrjFtaqL66MOMtoD8kUgSOsL+W0xLXRJm7crOLNs=
X-Received: by 2002:a50:ec8c:0:b0:525:4471:6b59 with SMTP id
 e12-20020a50ec8c000000b0052544716b59mr16728260edr.7.1693007616143; Fri, 25
 Aug 2023 16:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-9-JPEWhacker@gmail.com>
In-Reply-To: <20230825193830.2753640-9-JPEWhacker@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 17:53:24 -0600
Message-ID: <CAPnjgZ2xmEdd7CU+dYJ4406=Kieew_Arc_9DFckg108hgxugUQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] cmd: gpt: Add command to swap partition order
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>
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

On Fri, 25 Aug 2023 at 13:39, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Adds a command called "gpt swap-postition" which will swap the order two
> partitions are listed in the GPT partition table (but leaves them
> pointing to the same locations on disk).
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c                 | 52 ++++++++++++++++++++++++++++++++++++---
>  doc/usage/cmd/gpt.rst     | 23 +++++++++++++++++
>  test/py/tests/test_gpt.py | 18 ++++++++++++++
>  3 files changed, 90 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
