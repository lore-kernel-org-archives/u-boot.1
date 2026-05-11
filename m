Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E4FCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 438AE83F14;
	Mon, 11 May 2026 15:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HR/PYIiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F031F80398; Mon, 11 May 2026 15:11:33 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42EB784099
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67c566cb519so8080112a12.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505091; cv=none;
 d=google.com; s=arc-20240605;
 b=KaC5jphb/019SvqmH2VeuZex3CRAoVtMOXVrrB62h62hwPfECaxJpcdZO6KeqA3v1/
 +z6qtZuKkFhBqkfYqtAQrXK0tacwBx/LCITPW4w7QD9ZLW6N70l7UuCQ0hDVgYC++684
 +lErJ+3wjIjNVsdeIeq8+etmmjx1xYeoLwP4mySokiu739T3nad7L3TkVWXvD7p9deuC
 65h5VYdaKx+F6Z20nJNONgXeYG21BsAPL5kTYScA9EktFdg8zc+HjcW8LFTaVmc71aXH
 PrW6fFyrQU80ehdAkUq2SzacDWxqqjzOQxGmwOTidoEKalP7+RQil3arKjqfbGN0I/Nw
 yu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f8LkcP7BAGuP9nGqsK8Sylpywi+VN4kM5ofNU5XiKyI=;
 fh=7+NugGQ2fjuifNFbboBIeXRgPjkONDOweWugJxHsSfY=;
 b=D1wbJ8/ZId3Fb2ekxTg/nMadj7ccUhFMubPXn7tEbVPAct9E85DB8gXvOzTypKwPLZ
 k61g4MwBAZ6na/hrteuajqRtzbMBwsSqJEPWx/iTVBw0qBl9mAOFK59hR1cTPZoetZmH
 rEKS3tOHgSK7CkG+CBb6BmPUcT6f4BKCair9vDni8hcRu7eJN24jutZG2CR3DLL5id9+
 TKbo0WtBBDS4U8yJKI6Mn0vrj6R3+HN7adCqnCq9sKhj2iIOn73EWPOsYDgJQI2ShPhh
 QpDPDFsHe9J54rXiB6iZRGIgqDpUdOqCDmnb79EfSfeyh5Z8f5Dk53HaX5vgVd87blnd
 Grmg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778505091; x=1779109891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8LkcP7BAGuP9nGqsK8Sylpywi+VN4kM5ofNU5XiKyI=;
 b=HR/PYIizYpYaeh7Ob3AZRUOvaiCWlEdeOma62ic+Ya27RmKt/r5F1AhpAZJo1ddpKe
 LAwAKUb+vrirwfKU8WUi9eKSslr0vUJEH3lBzsuCQf7IwcHXmENt1Co55wHYdl4szBtF
 T4cOlfr6Cu6labuuzQB9A/vrusAPB2SVuonCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505091; x=1779109891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8LkcP7BAGuP9nGqsK8Sylpywi+VN4kM5ofNU5XiKyI=;
 b=DvzaSf0g7X8pSXHyhDnuA7U6FkAyMl5LcTZtSzOwwxD9S1rYkhQ8lZ0xixRgn0/FkP
 eM1ZAVuIZOWTdG8iHQn9c+Q/eX+DRp6r7l+uZatiBGoLbivsaBo19siHsXWN+kk0f+L7
 HvQMPvWx8w8Yrd0FHcU3ZTOCbo9/59TRj1wICcjl7aKfVhFe0vZFjKYPj2sW4k0JaVJz
 MoqzFb39e3lfDsBZi30nvHeoqltY+2VvOZhQUhj+qzFpEV/13ZifX1gLeMyTvOwkoNRj
 TytArbnQkDsqP+UgcNCTaOPrWuYeEEqTHW2M7o3ugaOABa84/BV0C0aXhJY5k5KzvvUz
 IlMA==
X-Gm-Message-State: AOJu0Ywhv3i79MWmd3+k6rCDrSWO9S1fUzZbWY6oK73zL80oRe+lF4pp
 aSYJP696+zBnDId0dZBedKWC0dugmAy2IYIdrsBaCar8Ua8krJ+e/+ATAL99gRgjjsNscq4UOeH
 ktPupSP91LzSTyMGU7EkJ/p9hHwLtQtDSqukR1cC5
X-Gm-Gg: Acq92OHXNiWRVd+5+2s4y+7haFtynV5VlbMdaFp9S2BSHLGNXs0Tf3m1rB+Gh8R6BTL
 UOnAJ7vFIzZ6xoG5Ree607CInm9F3Wm+HkQ9yJQbUkX4nVoS/szNcqALXn/XcCeFkA4cYQzAmBS
 /O3CaObQR4fxly5fkXCh7ord9aN5oRMhxkRMV2U3o8aevOsYDJ3+eqb6b33HmGeCDWYyjeUFrwi
 QmBQGOuBj2Vafhi9d1gM3zD24XVwmVl+EfBuEkj2z9eBRPW9usZrxV3iZ4tFH8IGqyrF0//F6kE
 1C31+XNgg/pwDk2P
X-Received: by 2002:a17:907:9305:b0:ba7:7f6d:be4a with SMTP id
 a640c23a62f3a-bc56d132a0amr1393731866b.26.1778505090721; Mon, 11 May 2026
 06:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171604.56788-1-marek.vasut+renesas@mailbox.org>
 <20260510171604.56788-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171604.56788-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:10:59 -0600
X-Gm-Features: AVHnY4KMMfNK9PqFSdyUPpkud-07dvPvOB61S__rITwZ1GGhO-ekG4JEwY4BzoI
Message-ID: <CAFLszTgWa1T12pHQ3Gi_dd4s-WOnwxKmVg4KxFUxEcpb0Z1AQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: bootstd: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:15:52, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> scsi: bootstd: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/scsi/scsi_bootdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
