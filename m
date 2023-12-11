Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E978C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713D3877C7;
	Mon, 11 Dec 2023 18:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R8gabG2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8032B877C7; Mon, 11 Dec 2023 18:53:25 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE1086308
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso3626601276.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317202; x=1702922002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ita4yprcSjsuj5EEzP9vGENJKg0Y6b9N6gCbqQWPs8A=;
 b=R8gabG2hFjc3kC9d4UbW2J4lA8Qbk9hZlUkjeMUHdWQNS2OsGhM6Frdp47/tdYHv8I
 E8PDCzL9ltaiplGI6ldz1pqjcGgOYeNVRpwEHSe632tEW+PUa09irWSQ2N23u/VWo/T/
 HrlhTK6VUVw42/FumZrfkpwL9jKpTpb2zCyzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317202; x=1702922002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ita4yprcSjsuj5EEzP9vGENJKg0Y6b9N6gCbqQWPs8A=;
 b=r02tSw2Bd5xmfLmi98IUFTSbugQVkRzeY3iAvdlpG8bhEAHsk6e3cl+9gZHfi78THl
 Cb8qcXtosWRkrmSAe1pFwAQh3CSLiRtHhTQAmXTmkEMwAeZWWXUlFUsEY4KUVC432Una
 AfHpuVyqTT1p9w0nRNpo8R9pt1gAWQs++7EzsoZt2WtEKe9yZpvdqxOIN6qktmFrR7yb
 wwiF8HiqL3vaIvbriG5DsJXhPS9yvqDzP/eUTUK1UTN/40bavaS7rZKrslTWxUIfxlMe
 CLQQhTzQjX6QA+oWlejK724J8Lg1mNNwghK3lPBTz8aH/hEjT0B9vv8x3fRJaF/7nHm8
 kKxg==
X-Gm-Message-State: AOJu0Ywc1+UNglNubbO8RnH+KTxYVCLp2I+5lyfvQK7GJloVDrtKtBBI
 5FqbgFiDtxpQQq1OjnZrYWqsB2mmvfXAlOFkly3gng==
X-Google-Smtp-Source: AGHT+IGzcmlFgubS2W8HB4xigY77o276maR5iKGyTrmtMiHHidUyRzhxIcj1TVKj3YDD+vkgmJroCydI11N82u3HVzA=
X-Received: by 2002:a25:b944:0:b0:db7:dacf:4d63 with SMTP id
 s4-20020a25b944000000b00db7dacf4d63mr2020216ybm.95.1702317201941; Mon, 11 Dec
 2023 09:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20231209185031.7275-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231209185031.7275-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:14 -0700
Message-ID: <CAPnjgZ0wa=CK5Q5SCpPHZiv7zGLGXnEprzVTTt_P6iiP-zmZfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] binman: elf: Using variable 'old_val' before
 assignment
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
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

On Sat, 9 Dec 2023 at 11:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> old_val can only be assumed initialized in the finally block
> if it is assigned a value before the try statement.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  tools/binman/elf_test.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
> index e3dee79d06..b64134123c 100644
> --- a/tools/binman/elf_test.py
> +++ b/tools/binman/elf_test.py
> @@ -249,8 +249,8 @@ class TestElf(unittest.TestCase):
>

Reviewed-by: Simon Glass <sjg@chromium.org>

An odd case though...I cannot imagine how this might fail.
