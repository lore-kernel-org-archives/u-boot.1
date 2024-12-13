Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA6AE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 17:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E980F800D7;
	Fri, 13 Dec 2024 18:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sasq66VW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE9E2800D9; Fri, 13 Dec 2024 18:44:48 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3EC800B6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 18:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f27bbe8fc3so6695377b3.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 09:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111885; x=1734716685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WYBM5Y5osdoz3CVCefAQYVZ9UqtBBT/ryxYtC0IRXPw=;
 b=Sasq66VWfBRDNXixepq04a25ayuim+BENEIJLCm7UQYdmYQ7H66jobY90NuC763g3Z
 1pewJHrNxS785OrJNKzNmoCjjRO+lbMq7qHcUmywhKmZ0xGCiBDMbD9Mh2W0Xi0GqZFy
 GrBEIJCJP2lzfd4znm8iZ+i5N2hfs2oXHNnJ5FTQ4SEM8SFcPAr26sFprRW29niyWHVh
 mumpjIYrCl5TSGjSAFZjlNhGyuIHgqfwwMfm9WsQFSu/Me0na6qk5S8NI7XXg/ncUin7
 Pe31r/2Ipba1xeF2OwDm1Az5rtqc2hwPN/Ho2tUQIOAJdSOdlDHh6Uxvp07wF93nNfl9
 W6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111885; x=1734716685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WYBM5Y5osdoz3CVCefAQYVZ9UqtBBT/ryxYtC0IRXPw=;
 b=O2wfk2HKhRv6ejM8OjFNGVpN0sxWVy9grOUoyP5FDpvAVKl3jf4D9ByiiCJYeDO8ph
 rB0ltCnVB1SZdTNy3LiisJD01YLyW9pxBUNUmj2026dP8U9TuuUoHdCNFXybMP6WInHp
 M8up0NYC8kw4Yq+DUjg/r48tfhexJ3QHes+F5IJcOE1oxamDd9XGlqDwalkOS55e1L12
 rSC21olK+9oSPZjBxJ0J6HF4iUe/jj91EjC5is8UgcqqdZ+Sr97brCsAvWazQxxH37jo
 tzY1BPOkZumS4lqlOfqihpNbTeshQmiHfilDaZAhMHaxhQrMSjzU/yZy7mEjDmYmZTrq
 w1Jg==
X-Gm-Message-State: AOJu0YzFKYuMb7lOmfP0JVZsnQsT+8xOi5u5WlqwXLmmNnwvC0RLRmuh
 knBY9y0jup6C+GoRwMDCuHVPUy3myeNkjNsitDrZXca93sfI5l47E0roz8Toh6PvJamTMk3v9Nb
 z4zVITKPeJFzMRYFvfGMkMSoRxcbW3SM9LBHSQg==
X-Gm-Gg: ASbGncsnXwLPr8PL8smjVZZstXXq5wDll0m6+H+imW6hC73kJUdtrqsPdIYrWcBC2yK
 65RWOYmhnMkVYCmRJnJXqjZXuNjtx57DEr8t9/g==
X-Google-Smtp-Source: AGHT+IE2JSCsap8MriGNAHIdjMMc4BM0vcLQu7vQtYnnnq51nSKg8R+CtUGSsrNENmKlBKcVznLHKrVKXx01hTPA4HY=
X-Received: by 2002:a05:690c:25c4:b0:6f0:23da:49a3 with SMTP id
 00721157ae682-6f279ad0e84mr36638527b3.8.1734111885294; Fri, 13 Dec 2024
 09:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20241213102024.174888-1-l.anderweit@phytec.de>
In-Reply-To: <20241213102024.174888-1-l.anderweit@phytec.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Dec 2024 19:44:09 +0200
Message-ID: <CAC_iWjL5MFRUVAh3Jm70Lk+5vOrEUDcuMHoDnEwbmFCj=bDFYw@mail.gmail.com>
Subject: Re: [PATCH] doc: cosmetic: fwu_updates: Fix formatting
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, trini@konsulko.com
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

On Fri, 13 Dec 2024 at 12:20, Leonard Anderweit <l.anderweit@phytec.de> wrote:
>
> Remove one of the double colon so ..code-block is used for formatting.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
> ---
>  doc/develop/uefi/fwu_updates.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/develop/uefi/fwu_updates.rst b/doc/develop/uefi/fwu_updates.rst
> index 51e8a28efe15..847135814590 100644
> --- a/doc/develop/uefi/fwu_updates.rst
> +++ b/doc/develop/uefi/fwu_updates.rst
> @@ -170,7 +170,7 @@ build the tool, enable::
>
>      CONFIG_TOOLS_MKEFICAPSULE=y
>
> -Run the following commands to generate the accept/revert capsules::
> +Run the following commands to generate the accept/revert capsules:
>
>  .. code-block:: bash
>
> @@ -180,7 +180,7 @@ Run the following commands to generate the accept/revert capsules::
>        <capsule_file_name>
>
>  Some examples of using the mkeficapsule tool for generation of the
> -empty capsule would be::
> +empty capsule would be:
>
>  .. code-block:: bash
>
> --
> 2.34.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
