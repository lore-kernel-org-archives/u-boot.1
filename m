Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28064CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 18:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A1D835CB;
	Wed, 24 Sep 2025 20:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="keJ/TKAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D846D83621; Wed, 24 Sep 2025 20:16:41 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C7E8361E
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 20:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8d593793af1so3530439f.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758737798; x=1759342598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qR4qAgIe+U+6yq+NmQIhh7K/B7V+jnuwuiNIdCYaE70=;
 b=keJ/TKAJ+EfZH6XMu1ay/ETCzEtalK8OLo53DgK4cO4Re/+zYHKfkQs9BmGRlICkiI
 LkhS27LfAjhq1X426mFAVSfKt/G0NeuLHQpCkF45HK9nJMPYSnTPiNZi8YlUK03ghBYg
 5EuSICp4Il80d2pRzQcTsc9SkIm/CM0z8hn3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758737798; x=1759342598;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qR4qAgIe+U+6yq+NmQIhh7K/B7V+jnuwuiNIdCYaE70=;
 b=biylxyKdrj9sInbQZrFsgomqQtWVA68jytmrLfPttwTjVkI+49AwGSu0dhhH3ImW3R
 w69f9uMDrzBijeCMHit8zFVAt/uB61EDuIiB0KDkkkbEX0Rbyi1KvejGXoWm3/j5Cl4e
 R1AlVeC+c6TT6e4jDdXyoGPxTcTUFxWg6pC0kL9kPGaU8KV3hzv0bHFBBfnI5oP4iTdT
 3Zb8KfqraEhnYHnmOrqacrj3ifgxZI6h2FXJo7VhsJ1uJQSpmJ3gu3D/SHM3EeGTRNW6
 G1HuI9iqv3YDqY4+lQNjrtVGRbX5S5OqxuqmQy3uoG7AZo429+bCO4V5kFsvchvKUDRi
 hJRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt6tyTIDwgBssurazzsDmFwhu9BgbqC0UwsW9OJw3cWn06nMoZ8tWFIc9Ky2q9D7rPDDFGMZg=@lists.denx.de
X-Gm-Message-State: AOJu0YzW+yOrqJxIg/LzNtCEFcRJGLRB05FfsskNG1tJXBNuf0+J9GCJ
 ht69baUXw3M5mmGmHE016sWxz4Y6yIub9dKzm/so86atGEEXzN17Iyfhsv/6w5/hsHA=
X-Gm-Gg: ASbGncuTb4xutre3Wpo0rRi7+MTv6pCg31/l/WMmPips4pRHiaslyzgFhdSBAx+gtTZ
 WsG31eaOlBJRPxn/K2nWU6qOYoqmX3exQYWsuTZziCY1gCFfA9LXf7lWyE/cX5ESWi1Z2a6M7fZ
 O5kB7Dk1zAFOe1yOtKkp3g2iCzZaHHnU8sEyHS4UWzFjXhRD+L0FzD/6MakqXwo7rmUSHXHeq7m
 b00ADBUWUeh7SlsgMsYZw8PIxzaUk15ZuG7FiAxtYTGzfcYxd9Dma/KIIp1Z0HjqkJK8URnA2e0
 YzMjsTdDw6y9+JcMf45H/zdsRHTlh6Duvvyn+Z0fKz5Q7AcO9x3bNKc89x7owa3WK5KsI7cV8zQ
 a9JEt0yG6CWcXZSIbBGj1THWnlPOQgkRoyJ9TNO3ohdzi5OLxWc2ZJsI=
X-Google-Smtp-Source: AGHT+IFq8zu29dXn8R8xGtwd77S5yNZGk27we0vqiQdqq7+RYQH/VBM1JL+6Kcx8L1vsz4ja7UXNWg==
X-Received: by 2002:a05:6e02:16ca:b0:425:7a75:1014 with SMTP id
 e9e14a558f8ab-4259561013cmr7280025ab.12.1758737798428; 
 Wed, 24 Sep 2025 11:16:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4244a493b40sm84122645ab.12.2025.09.24.11.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 11:16:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <de5e5cfd-6946-4be3-ba08-5105460a7de0@siemens.com>
References: <de5e5cfd-6946-4be3-ba08-5105460a7de0@siemens.com>
Subject: Re: [PATCH] test: Fix optee unit test
Message-Id: <175873779755.361751.11990697884693627232.b4-ty@konsulko.com>
Date: Wed, 24 Sep 2025 12:16:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 15 Sep 2025 15:41:55 +0200, Jan Kiszka wrote:

> This was apparently not built for several years: Since a2535243e011,
> optee_copy_fdt_nodes implicitly works against the U-Boot dt. We
> therefore have to tweak its reference before using the function and
> restore things afterwards.
> 
> If it had been built, actually trying it out would have failed next: We
> need CONFIG_OPTEE_LIB to actually build the function that is primarily
> being tested here. And we need to re-initialize target fdt, now that the
> tests may run in random order.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test: Fix optee unit test
      commit: 44c4919e9dd6c162b237633ba689441eca9a149c
-- 
Tom


