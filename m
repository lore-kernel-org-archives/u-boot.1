Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AA1EE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6555387042;
	Mon, 21 Aug 2023 21:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ullEb3Zc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CF787046; Mon, 21 Aug 2023 21:13:27 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F1586959
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d743f58050bso3288199276.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692645203; x=1693250003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WaWm6QTg7CrndR302Y/JAQVeg2yxPFu7PTpUxspuDPA=;
 b=ullEb3ZcCw1FwjrmU93ba0dz2vVhHJxFPyPbZcQHmwagBRZ/eNVl6X4WD07OE5KO0w
 WZsecXpD3yvI47mEvKkMzGE/tGBjUFRRQOhMq3r3JLL8Ixto8OFPbU5I3ZmZlUgCs+ZE
 81NSN3eE7oZOcv45sS7nbstIFTKS4s789bim/qNSn//IvKSpuoa5xkKJ/9G7OoK8Q0CO
 Uh3qPolkQKUYG3SeK4cFulXXs4aHYHVgXW+u4eEGS+y6k0zSZMwXjoaPef/DeouXoANl
 9B62RV4H+WURVFuGJxYBiGPLQEuzzqp3mPKNKBqUJJeZFOf6NzbtmENW4NnjOEH+FRzA
 erig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645203; x=1693250003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WaWm6QTg7CrndR302Y/JAQVeg2yxPFu7PTpUxspuDPA=;
 b=P2Cg3pSTQCbVIIPiYgJEP/ACJt+JR+tcqge8/vRFsoLlCnoSxjqKdtpf2QgdubvInb
 1t1fpLWSqg8oFKmZELSAWaVyAQtK03ej4/ooKCCX1gmp0QUW4YRvxwfQci8+a6aJdZvV
 CQ87CHwNxIwrapVHGvKbnzgqKkrmHDT8O3UnmRzc686Zc6C6zB2uIc5OTdwsGu/d7SPq
 FGZQb3QaKWBlzNRtZWnbqnJjbc4YiKI414ZIg5GADcxf9W6NRhvb4ww2vlAdd+QLzjTh
 8Ft9KvNlg+gqKnhN9+w4ZbDlT8nOr3zJxQrUalpTOUSBozc11QcMNzWUzsm/PwGut9cT
 oIDg==
X-Gm-Message-State: AOJu0YySmkWIN8y5wSuLdo4ovs2tQqPDF5JbHj71iJMl2qhTDVzRVvO3
 0+kEDE2kxHgsXRLZ30CEZq+KfJuZvdshwCwnYkTM21DrNZS3M8QtllQ=
X-Google-Smtp-Source: AGHT+IGtpW+i5IrMUEkBrp5t0n90oFT1sF2SbiXjBV74LpxMPCT69ZKL0UHR43cX58O7JCF1RGrwUkfipR0nDL0xMWU=
X-Received: by 2002:a25:ac4a:0:b0:d09:377a:7bf7 with SMTP id
 r10-20020a25ac4a000000b00d09377a7bf7mr8322178ybd.16.1692645202810; Mon, 21
 Aug 2023 12:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230820173129.781985-1-trini@konsulko.com>
 <20230820173129.781985-4-trini@konsulko.com>
In-Reply-To: <20230820173129.781985-4-trini@konsulko.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 21 Aug 2023 13:11:43 -0600
Message-ID: <CAPnjgZ2zkaYWqv5motijdvNmCntk4h2sNFY9KXVkXcqSmqmbtA@mail.gmail.com>
Subject: Re: [PATCH 4/4] CI: Drop some jobs we didn't really utilize
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sun, 20 Aug 2023 at 11:32, Tom Rini <trini@konsulko.com> wrote:
>
> - We have added more TODO/etc comments since this task was created and
>   never focused on removing them.
> - The output of sloccount isn't preserved or looked at, and if desired
>   should be in the release stats pages instead somehow.
> - The results of cppcheck aren't investigated and require modeling work
>   to be useful to start with.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml    | 32 --------------------------------
>  .gitlab-ci.yml          | 22 ----------------------
>  tools/docker/Dockerfile |  2 --
>  3 files changed, 56 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
