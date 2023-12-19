Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9D9C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12AA9875B5;
	Tue, 19 Dec 2023 18:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hkNqfpII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA3F875B5; Tue, 19 Dec 2023 18:07:36 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DADE807D9
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e3c6f1c10so3138758e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703005653; x=1703610453; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bMEB2kn+p2aTlLBE7g2PrVWqXTXeF+tvJmue+MCkG/w=;
 b=hkNqfpIIU5z+9mLjC6HpwViBxc/StxGzBt43VZfBzUY4RneP8VizGNWLoi8uZysmtA
 NLqWbCr8emwmwzZ3U0tTgt/c4qEhpEOLa0ixEiylHTG3n3lZJlyEnlVWhP3vd2hvEX71
 FSZF7jXOr45pqXNjO1hTLqcehsmaRbBFPYY7dxa6JoXGeXWjnMR8DglhvFlyIOqBqanv
 9ZwtxWOrGrXqyXdlf6qnEyfGuyVHaBUt8OsQkhdlfv6rS9ciAYUY5bCxT2/g+oxe31WP
 kJkaMvSfZKoUz/GW6lxjbd+XoLzfgtUvVkM1eUUj//yqShmIgGhxXIH4vfUld5mEDqFl
 Xh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703005653; x=1703610453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bMEB2kn+p2aTlLBE7g2PrVWqXTXeF+tvJmue+MCkG/w=;
 b=BN7A2eRJMu7spsCjoF2C5syhXkyMUuxLfN7L8Ripu5FMcNPZ4xNlx8GHci2jfzpGdR
 zf+XMoFbzZjv5VrKP42IyiZIKSPJ3TeasWQ29TVWjAC3ybvuxA0AZ01p4fsdBXCO4PYa
 wAidqBZ8p9cXZ3Ma86OlD41sluNsNdFYdGfMzKP81k674JcDtwqHk3PlBqyZEMLfpqLI
 nEePI2GsUHbmi/NoLauYrIVZHXvxMyfr9HGyfRy7G6rNsuyioj1zwiHdHsDyv99UNaVu
 yhX2oTrdfeBjusEJkidehEgQv8nHYqHfzGvidBReVXGflYAPmeDfhI5iTWlJLA1psGtd
 tVMg==
X-Gm-Message-State: AOJu0YzB3x6cOfrsQoDIrDoUuFnVRmlxpIaN4pUbzbqgJ9MlpNlaEky5
 AlDhYGFeoWMK6lKfvHck9bsr5XNF/IA25VCTBNyaEg==
X-Google-Smtp-Source: AGHT+IFEfuu8pD/BkSzrzzS9sJA4qZlVud6vIWQqzqU0kPDjN9Eq45JS8b584WjkOfdWXTefmcG1nMK9/7aBz2kxBH8=
X-Received: by 2002:ac2:55b0:0:b0:50e:2b8e:2ca0 with SMTP id
 y16-20020ac255b0000000b0050e2b8e2ca0mr1119347lfg.243.1703005653477; Tue, 19
 Dec 2023 09:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-4-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-4-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 19 Dec 2023 19:06:57 +0200
Message-ID: <CAC_iWjKm-tJ8nXtEcVYcvqx9cB3=agr0YMgHfd+OfXV0z5bUTg@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] bloblist: Change the magic value
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Mon, 18 Dec 2023 at 20:19, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> This uses a new value with spec v0.9 so change it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Update the bloblist magic to align to FW handoff spec v0.9.
> Changes in v3
> - Update the bloblist magic to align to FW handoff spec up to commit 3592349.
>
>  include/bloblist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 5ad1337d1f..72c785411d 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -75,7 +75,7 @@
>
>  enum {
>         BLOBLIST_VERSION        = 0,
> -       BLOBLIST_MAGIC          = 0xb00757a3,
> +       BLOBLIST_MAGIC          = 0x4a0fb10b,
>
>         BLOBLIST_ALIGN_LOG2     = 3,
>         BLOBLIST_ALIGN          = 1 << BLOBLIST_ALIGN_LOG2,
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
