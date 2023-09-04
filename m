Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0D0C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3E1869A9;
	Mon,  4 Sep 2023 18:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bvBLpwjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07C186886; Mon,  4 Sep 2023 18:49:47 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3668A863DC
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so2209112a12.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846184; x=1694450984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L4Y6fDOlAHmT0vEwG/+ES+cmGa2+gJbHY9PtEVONHfw=;
 b=bvBLpwjOEeaaONF/W+jLHvbMCXlC3AccFUBs/aefCQj6LaBUU6PDAHIJQ5dMLs11mb
 Qw+ovOQTHjakUUSnPLCxxe0vYTEw49vuVwe4IesHyMcXVwkaFjbbOiEJNsf3KPLRAWRM
 0Gzutpq+iNhMW1hT/rn+yx6qgZIi8YF9eJQqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846184; x=1694450984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L4Y6fDOlAHmT0vEwG/+ES+cmGa2+gJbHY9PtEVONHfw=;
 b=XaeeO0mGJuyF0MY7Zhj8zA9JQHcuR6UcUtgAW9OEZW6+5grhzAXf/FmaA26diE746E
 0tnJgB2PdsfauQuBkSiscKFUwEWQG94d1bba63ddeNnrRwRvlfwViwJyxryFnd5IYuXs
 /kSKIn8gHuroSTOwyCfWFo4+XdzZRy+4SMnKtHEA+7Ui2oyII52mpR1PTGQIe3ZGiTiw
 7CRAa8af7UFFOxygIAlaSkok6j+1TP1KqOHnE6VFuIuiVFz/McUFD8ogt1gmHj6a1oAE
 xvYetxeFbh576JzQd54T6iyywroUU6D4XdfxAQwrbzsJvc/jdcfyNoObehtpv7I37dxg
 JmCQ==
X-Gm-Message-State: AOJu0YwX1485kxIBVApQhn5Y0LqKY8VdrN4Jznu50ti53gu9y5Z2Y0rd
 ZJpI/v2ix1Jvd0PVpx7ZhiQCDO4/IRxxtXtmDeIcNw==
X-Google-Smtp-Source: AGHT+IGI/+nUcO77iLAC1RtoPHFysXVAVtnYfc6jVocNHNWk3FVb8y86dp4jam12gT9Y9NE50hnLTigHhDJdndh1iSg=
X-Received: by 2002:a05:6402:1f82:b0:52c:b469:bb01 with SMTP id
 c2-20020a0564021f8200b0052cb469bb01mr3829568edc.38.1693846184520; Mon, 04 Sep
 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
 <20230902073524.87451-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230902073524.87451-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:52 -0600
Message-ID: <CAPnjgZ1wEay5S5azzQ-hCPuQiT07LhMSBe=QOO6opJDb-0UrtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] cmd: gpt: use UUID accessor more consistently
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de
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

On Sat, 2 Sept 2023 at 01:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> disk_partition_uuid() and disk_partition_set_uuid() were introduced to let
> us avoid the usage of #ifdef when dealing with the field uuid of
> struct disk_partition.
>
> In allocate_disk_part() commit c5f1d005f517 ("part: Add accessors for
> struct disk_partition uuid") missed to use the setter.
>
> print_gpt_info() and create_gpt_partitions_list() are further functions
> where we should use the getter.
>
> Fixes: c5f1d005f517 ("part: Add accessors for struct disk_partition uuid")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  cmd/gpt.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
