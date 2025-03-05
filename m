Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A3EC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B2180FB9;
	Wed,  5 Mar 2025 15:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EAw8BlIF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045B080FE2; Wed,  5 Mar 2025 15:15:50 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B1E80F92
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e0b70fb1daso11992444a12.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184147; x=1741788947; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRBB9rQqDTkHm75pU2wopTVWXg6bue5KXKRygZ11KsM=;
 b=EAw8BlIF2QSvbsAjUD335I3GvDNaa/Wm7ObuCLodAr9BaIpaBKnrdYQF54h3IJjWUS
 YhOxd9BU1vARwKnceiXSd2ZecPX3t/5cCNRjyW1gSPnAGSTmfwuIrS+oh9aOpWCkxYFz
 53gsFqtKBQa7icBVg/ekRIsqeRzf2Oh59CeOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184147; x=1741788947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRBB9rQqDTkHm75pU2wopTVWXg6bue5KXKRygZ11KsM=;
 b=NSjOIOjAkcjR7r9j6fX0mSBRTM4wP7yy8UR2XqDOdG/v3aKZTC0bq0y2JZEaFQ+7dX
 vczH7Uf0LwUkY2ZEIlsER7KVjgsjlbe1dEiL2HkVfqMLLelX+2t1DgBe3CiFsdTpFK3D
 taAV361p31++GXvz4NcoU7fcI0tH8BuGn8MoL/BIEGccSAU2JelpYuRAyNNG5cRNM9lx
 vM6rX3a08t9n5sUElpDxS72guYBm8kE1OtoJon6soNMkJe/MNB4RPN4HcGDfzeeLGeTc
 d1u6ij8p7pKUyXZfH+AV8OhUk0JxnElPxKgct790KQpdycD9cskuYR2XqSB16yZQrSC9
 mH+A==
X-Gm-Message-State: AOJu0Yx8AN/poUFUBJsY0AL+WDl3qKKhZaA/cKdFtljngJk2oUke5fJ0
 qlcJl1NfY4qL+dPME+tqH7hv4/3xebkfDEYk/gYm/jSQ/acbQCKcHg9PNsRMHx9tKAEArkSf+SR
 SqRABY7E7Gzn2MShGzWPROxlYGMwS0XwW21Qg
X-Gm-Gg: ASbGnctVmiq7axjthtJ90JCiLDGiZJ8hFERzYzCaMqgIaS0w30wyA0knoxSB4efKR/V
 Wsto0DxU4TRCKgloC/azxfWWf/YaOcWrP961bNbN4pnouK2Mc9ZeYRYvv9Ty43yxUjG615mozC+
 GAv7L7+09mu0OM1l7yZUavil86ekI=
X-Google-Smtp-Source: AGHT+IGyhS5FUf2aXWbjy/qN9Hefl710bcTzSM+sjKIG5+oz3xVkSfdbZp8KgbRUDcHvGYkVor0Bf6l0wmuj7pTOIFw=
X-Received: by 2002:a17:907:2dac:b0:abf:70fb:7f05 with SMTP id
 a640c23a62f3a-ac20dafc173mr334860666b.50.1741184147420; Wed, 05 Mar 2025
 06:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20250226210501.72794-1-l.anderweit@phytec.de>
In-Reply-To: <20250226210501.72794-1-l.anderweit@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:15:30 -0700
X-Gm-Features: AQ5f1Jpj6JOeL_RFMyP9wqlfE6wjFz_PCL86IE2-OGUzS6AblOVmlYQQOU3mFCk
Message-ID: <CAFLszTjO+VmE3uR9R5xhQ94d7uqVOnTHKrP-f7nTV=fLaSYC8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binman: build_from_git: Add argument specifying
 branch
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, upstream@lists.phytec.de
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

On Wed, 26 Feb 2025 at 14:05, Leonard Anderweit <l.anderweit@phytec.de> wrote:
>
> Add optional argument git_branch to build_from_git. The new argument
> allows specifying which branch of the repo to use.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> ---
>  tools/binman/bintool.py | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
