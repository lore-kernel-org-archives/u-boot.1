Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D28CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0205686D1F;
	Thu, 21 Sep 2023 03:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YlhcyyjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B665886D1F; Thu, 21 Sep 2023 03:06:02 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D433886D1F
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59ed7094255so5574377b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258357; x=1695863157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6hBBvpSWb+ujwNFl5goygYv3boGZ2hi7faOCnoR3fso=;
 b=YlhcyyjDv1oRWU3AUtys2eYz51RvfNh7JEMqXbpoBVJHIl6eF9PNLio8iuHoliAj5a
 1BUJuYMJdlAV7z/mqC1ZxQRJ3ABfDycoRBNoqLjh1bQu69q3P0eEkK4wL9Gp4h7qa8nN
 EU6vXA9QWJo7cdUAVO0IYBZS0Nqsx5Ta69u+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258357; x=1695863157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6hBBvpSWb+ujwNFl5goygYv3boGZ2hi7faOCnoR3fso=;
 b=DiU0fzVtsVbdHVEFipHhWiKTAqTKcx1hPrnYv4Z7IF1GrqLNUb1dlSgu1TntY5aQnf
 K28ZaJpCt2dA1UrFcyDfSAC+0cVJmEVEI/V6Yxju+VUB3RqMDKb5088Eojmjodvc+KWv
 esX5bvlRdh36DOuzvioCtmPzGgDlDER4uYubqkOhQS3HtRAXo4ZZcti67/zWcK6XUSGt
 cHzai9QBMsP/A0gWAN2T7yKCAnKu9IlYZ3UE6+wcV2KM88WjYJUp3XdOE3s67oKgvim+
 JLOS7p75cxRCMDxbL/rNyqzCUFMBDo6rnGkpZJzqJ120a0NcEU8x4Jre8E2OjZJby0GC
 /0wg==
X-Gm-Message-State: AOJu0YxPUMC97wcB/9LJ75utK7ayphkpoZzgP7T5AZRBcfzH3RZMgRpB
 gtrekmSJkHbbnrjPcXWH006/6pYOkvc48l3CvyjklaUjW+YfK7EzGA8=
X-Google-Smtp-Source: AGHT+IE4NlIr+dK/TkqRXgx83Xyy/dh2tXbuxg8XznrC2eI+DYvV9ls6Si09CWCch8rkk1utnOIRrWYacC/ZNt+c8f8=
X-Received: by 2002:a0d:f105:0:b0:58a:4b39:b62d with SMTP id
 a5-20020a0df105000000b0058a4b39b62dmr4900182ywf.29.1695258357432; Wed, 20 Sep
 2023 18:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
 <20230912213504.65513-5-seanedmond@linux.microsoft.com>
In-Reply-To: <20230912213504.65513-5-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:29 -0600
Message-ID: <CAPnjgZ1ZWwMmuNKoWjpOHAiQJWPrbX9zoU0hj7-PcAUFE4m07Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dm: core: Modify default for OFNODE_MULTI_TREE
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org
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

On Tue, 12 Sept 2023 at 15:35, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> There is a preference to use the "ofnode" API for FDT fixups
> moving forward.  The FDT fixup will usually be for the kernel FDT.  To
> fixup the kernel FDT with the ofnode API, it's required to set the
> OFNODE_MULTI_TREE option.
>
> To ensure existing users of kaslr fdt fixup are not impacted, Let's modify
> the default value for OFNODE_MULTI_TREE to ensure it's always set if
> !OF_LIVE.  This will cause a 1007 byte increase in the code size.
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  drivers/core/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
