Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF00EE57CD
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 22:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A174866A9;
	Sun, 10 Sep 2023 00:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bKzwIZ7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89EE28697A; Sun, 10 Sep 2023 00:40:31 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFB9B86661
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 00:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so4156379a12.0
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694299228; x=1694904028; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7a0c94JkjA6NYMy6JtBt7GITo3Of/J9s/SeGwWpMPoA=;
 b=bKzwIZ7bANQiUaVCJuKfDvSj+tHxCzgstJI3MT7nIl4+N7Zc5jnlO1YPhqw47fAhVH
 KFZXrsCnXgFoxJmid3CDnuD/o8Q4g+n5ur3ZNwDuufX7ZakpkBf7H+5J6rNO+CMDADJl
 U3UDcwZiNwSNgKvTrBeqnWjAq1QgGU0BbERNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694299228; x=1694904028;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7a0c94JkjA6NYMy6JtBt7GITo3Of/J9s/SeGwWpMPoA=;
 b=EDQkEdIFxiN5cwW7RWmAdq/fVf+ypJRktSCjehKX5LYAY0es/+D2wsF4JZ/9B9bFa8
 bU3vy77ULlrAcZ0GvZOVKvwYnWPsmDoWj7anpnC1AmxryUaSoRvD7TLJeo1TEN+vfdT+
 ADuBBZeQgvS9tZLSvjfJz77FJCsZPthbFuw3iYKTMV2hikGgLo4OnvHM4pCCEX9bYJwy
 eWp6eRpK2PQJuaJ4LbK/x5b6gexXnFgNnzRForZWe75HO91H40PLPPBLHD1BFtAsyGyp
 F4wfO75AczWjGNbVGJWmzQ+pchtXgaqsXqB1L+Uolu70z/mDGB8NYHqc3Ytwy8BYl7Da
 uiUw==
X-Gm-Message-State: AOJu0YyQz8t3/6x4nFKgrvX7+kHLRUFUoyvrCaehAQd8GHKbnfPQmlaS
 FwB8kHegEfOneG++bAI/vy+VEbxEo/38XVpBmZ1mVQp0FhEsyNKT0Qk=
X-Google-Smtp-Source: AGHT+IFdozBE0bguIv/OS0k9WzgkJDzAaPOBiPFPZkDWQLLE/vIX2+fcRrVF58JeNsfRKJfm8QKJr+CXwsWSPiWrtwQ=
X-Received: by 2002:aa7:d5da:0:b0:51e:362d:b172 with SMTP id
 d26-20020aa7d5da000000b0051e362db172mr5105924eds.32.1694299228133; Sat, 09
 Sep 2023 15:40:28 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sat, 9 Sep 2023 16:40:16 -0600
Message-ID: <CAPnjgZ11KEV4TAjihfijFNpXmROheGPKmVwVvpgfOpZP7GZ-HA@mail.gmail.com>
Subject: UEFI update files missing on sandbox?
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

I thought that all your patches were merged but now when I build
sandbox I don't see the capsule-update files generated. Is there
something missing?

Regards,
Simon
