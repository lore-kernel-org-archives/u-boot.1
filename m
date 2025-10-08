Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276D3CCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBFD8394A;
	Wed,  8 Oct 2025 14:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SSiX57Fp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEEFC83DD8; Wed,  8 Oct 2025 14:53:58 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F02838AE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-639e1e8c8c8so716245a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759928036; x=1760532836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cRPGetMEiBYOvruZxh4kixiyHnnhn+vD1w6W5T+Ctaw=;
 b=SSiX57FpbKbrzbmaKcYPfoHk0ev7xQK71nzZGy4cq9iMteJ20PQqkpqyNfUUp+pAYF
 VVHNwNB9pGrTHc0OVAm9T/zy8jkfof3ATFFwBurZOkrvAbKp3CZZnhiLvyxj9l7UGKx7
 znteF4nNBv9ZZrZrKtGmvKGILZMIhYoHjtuN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759928036; x=1760532836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRPGetMEiBYOvruZxh4kixiyHnnhn+vD1w6W5T+Ctaw=;
 b=rhJi4mkHZPpFySgTyN4nsdYevrd9/JSsAMrBKuY3C+rZEFmdr1+N5nTI97Aby4SJOl
 fOQlfi4Tt5B7saUAoTQzen5sz/l6hd1FZFqi5NSpnqWzt8xoJelSBNtjIYUiUaezJxYY
 +NUj9uPIpJAUa61BAwSP5zDLOlU4sNEkrxq643OQwXhbEgj5TldGhgZ6o5S+0aX8rxpX
 1bNAa5of2BSrCJ8MhKHvFuRzxTHImJ/2Uzo2B2qKolhqExgxVzLDjNIWvvUMfOrUULOD
 bpK9OFCmYD6O0f1JlyvdVTp4GKhG6oIeiQcIb+be0LEd8DAGOEVt1iW3ANs7hIIOzOyi
 mLgw==
X-Gm-Message-State: AOJu0YyBnqpdUAEwB318rrrE7iaPcKwqoyFtjMQmOK6YdK15GD1GyrPl
 E9+gFTtAubGmcuprT+c9KVw1mUbKYgjugz0BHFan05ybGJuLPEPIvt66y0RhqtQqVPjxth2R22I
 VoiH7GZuOhyx4JcqF3oR7zsmubbSY4FVzjkmt3RJQ1b6TnzFVWSw=
X-Gm-Gg: ASbGnctUO3f8dDu8oigLcaS2SmprUUcdFrge2n+P1vf/0aAVmE3jsKQdPHiMPUDnNM/
 W7afJCffKAhdGnxn3gIVvi3iS6hsePuCvaCltn8wHhA8HTgWinC4ZAIIJDqsLSL/x+jtoUVQzuY
 RhYvGpskxczwHl3b1RqzkxApjnlV62Cnvve08GtJLzAwl09Zo7YXHmqIQdoVa16lSSWjsthJnbO
 aOhGdUz2W7+rRiRhK5uPuOo+vU5VA==
X-Google-Smtp-Source: AGHT+IHgh7/3hZvNUq8ii/MVXyW12UBHJTWEDjT2Drz+Elesd2JTNPCayCV6tEgqREYcBZj8opXLk28N9edtxQ6eOTw=
X-Received: by 2002:a05:6402:2348:b0:639:ea7d:f674 with SMTP id
 4fb4d7f45d1cf-639ea7e6273mr780792a12.3.1759928036183; Wed, 08 Oct 2025
 05:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
 <20251007181356.GO298503@bill-the-cat>
In-Reply-To: <20251007181356.GO298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 06:53:44 -0600
X-Gm-Features: AS18NWCsEdOE3De_rzkPvkIofDE7i9AAaHL_rBUKPyyBIaYnFME9v1dGHeSq_Wg
Message-ID: <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Tom,

On Tue, 7 Oct 2025 at 12:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:
>
> > At present when one bootmeth fails on the final partition, the next
> > bootmeth is not tried. Adjust the logic to go to the next bootmeth,
> > which is the more natural behaviour.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> My feedback on v1:
> https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-the-cat/
> was that we need to do a documentation change when doing a behavior
> change. And I cannot recall if this change here is because of reports of
> problems or not.

This is a long time ago, but I think it might have been an
inconsistency that I found myself. Otherwise I would probably have
mentioned the person who reported it.

The documentation already implies the logic in this patch, as I see
it. But please suggest any changes.

Regards,
Simon
