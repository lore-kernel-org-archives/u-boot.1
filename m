Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C48C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F6E874EC;
	Sun, 19 Nov 2023 01:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XTjFmGAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5AC086E95; Sun, 19 Nov 2023 01:44:16 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0AC874C5
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-db35caa1749so1325561276.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354638; x=1700959438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4CDeuac85nLxzxnvC4yBhIbf82Ysv71K3cHRo7Ter8Y=;
 b=XTjFmGAVkEs/pUjvLZ7uzOzXfXxT+qvB0SM0E1CBbZ9FI/JgBHQKqNgFlBCM27dB61
 O1+Q65jgRwjax+zL/l8ok/rkV2hTbGo8bJeT6E0KGnCy+oC4YXOjjbNv6olg62NvZCyz
 CLlPVXKgv08NHhZH2T1k5ETR7NSc7oxJrPvYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354638; x=1700959438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4CDeuac85nLxzxnvC4yBhIbf82Ysv71K3cHRo7Ter8Y=;
 b=E5h7CKbBKwlwmyDS8DZB03N7E5dhIak/PQaoTTKlEB31KnC6Lq0xrs2shINC6ZzpDI
 huUFDuVsPqHny+N30HTt0gO2MJVzZel1rclJqF8wK0X4K+w0PElHXQMBsfXy8C55UISQ
 zr6aOQxHs4I5CbTKKGvlVvI5d0PYWkF92BXAQMKJ/03t132YToVRc3reQS5XO0zM4R9G
 sPk7G6ZJ5xnWzeMCfr5A5bmfNiXr4JXwgCRu/TLnSMhp4728bwLMxlqjbDJ5JbGxlu1E
 rL0+6qitTquLc6jFe+NgMoIAHY+3MWXfcAUwpUo6ukXWkm2BOUP8Ao52+F19ZTfCSSZZ
 PtIQ==
X-Gm-Message-State: AOJu0YxyksTV4YSUTEZg5T5o5TXfGphMff2opegCzYnE2sJd/c+oU8eB
 1wuL4k8cJG5f77YPZ66WJt6c09Qku+na17QiwTIvOA==
X-Google-Smtp-Source: AGHT+IFZ3/mnwRHQeuOqqMqd0k7rQPBDuYqzobSZlzSO5roFNReac4UuzjbCaH9T6wMduztaObzvZ5WozmRvYJmZj0E=
X-Received: by 2002:a25:44c4:0:b0:da3:76c1:c779 with SMTP id
 r187-20020a2544c4000000b00da376c1c779mr3296774yba.52.1700354637924; Sat, 18
 Nov 2023 16:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20231118220313.1271556-1-i@shantur.com>
 <20231118220634.1271886-1-i@shantur.com>
 <20231118220634.1271886-2-i@shantur.com>
In-Reply-To: <20231118220634.1271886-2-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:08 -0700
Message-ID: <CAPnjgZ08AMMgcBO8NdsiAkXeF3DXBjJb+tdEM58y3pFjKLqHgw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] bootflow: bootmeth_efi: Handle fdt not available.
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
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

On Sat, 18 Nov 2023 at 15:07, Shantur Rathore <i@shantur.com> wrote:
>
> While booting with efi, if fdt isn't available externally,
> just use the built-in one.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---

Change log needed when you send a new version

>  boot/bootmeth_efi.c | 19 +++++++++++++------
>  include/bootflow.h  |  2 ++
>  2 files changed, 15 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
