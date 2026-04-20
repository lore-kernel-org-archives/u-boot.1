Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D4CF5A8AA
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA18843FB;
	Mon, 20 Apr 2026 21:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qld1EuZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5B4843FF; Mon, 20 Apr 2026 21:34:26 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 894FE84376
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba92146cc86so76204266b.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713664; cv=none;
 d=google.com; s=arc-20240605;
 b=kqVuaFxVeOwKJNfGs2Cy8sEulntuZyJkE6XS14nLSwBgK8Ykl9l42I3/eaPHrahs9x
 50CfHAUzPm1JCugB8+mjXGm2i1WYdYDj1WmwPDhM1oI24Uhj4aLMglpexyv2J1YBOCTb
 xVqtfSL+ly/IhMTpLc/lfx2R9+FWyY2UmsfuwZWs7ukf0geRvvKN4xq73YloSXU72uCR
 yzWczoT4XdudIaHsXTAkjO5f94gqwyoD7nhAoQD3VvAz6BBHel5w9B4sOVF6H6kzRqu1
 xNUH4uk7Xf2LtQtqrIeB8ymFW9MGQn6RwpRsFv9/kT942FYvwVgiuVUuy206M2sYlB/S
 TUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qcxhFtN1vj6SttfNha2T6o2U5kluRFpNFuDkBx3ZgJ8=;
 fh=udYPg2+gcJSgNZwfCxxvl5AGPDvYxuycLRmb6JwDAjA=;
 b=WMQzU/sgw18JQhX4lq8bTyipYJEgJ3FMPFfEu1xlmgJv5oWYaAKZu4IEDauPuqFSha
 UPIHfpaJp+kIdCxfD+zptfahqI8BsVTzxKhwVOKuBAE6vZIhUSkjAXMT2B3bY03Qqx4T
 /71bC1zhoAdh1+wUhw+gQV+LWq23WgfDppWCdOq07PggLs2mRs3IO6NskEoEDDCLxT79
 7e9Zmd46Y2nsE0ivX5Z6xd9JOYroNsI/WegrbQ9XyQouftdOKc2OsHXIhiKFpCW3A5Q5
 +shKrS0M3p9q6ujNa8EGSm8Tj7oU1YSYn9ah0kidOs7WTEWnXn1oGZlRqDSifg+JAW/v
 gLDA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713664; x=1777318464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qcxhFtN1vj6SttfNha2T6o2U5kluRFpNFuDkBx3ZgJ8=;
 b=Qld1EuZm26HkLcbpUESzdhPm/GZd56YlLCEJ6Co2qcnFoUY3fN0E6r8FaUVwtJ3/Q9
 fr00bkQzVpe92ftU0jRETjYzVPqtp9WeOiUxRr2NBOzpP9nAdyPzW9F3ATB96bcPyTt2
 xGUE9i4kh5SfQxO2SvHocv0IrJWkLG48+ERJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713664; x=1777318464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qcxhFtN1vj6SttfNha2T6o2U5kluRFpNFuDkBx3ZgJ8=;
 b=Mj3zbfaNVbjGLM9bswKdiLJnbhtpTZQcw1p8OBBSD5eVuYy/UYWzdnGbdR4eL1IgmG
 JYcX4CeApcMFxBa4OUIjwXU9QW6VBRo63iKExBbDOQTrI/lJQIo5FATvs8+TyuYoCKZE
 Y/HvSbaegHB5QDb4o0Oq4bzvb6K7fDklMHtghBGtUS+5F5gWrIkEz/lEu3Tyx3NwqHOJ
 crnBQfO4clHSFAkAGV9ZTQ4hsGObS7BdBDRhzNGFkgmDIl8osFQDdZllehgyzqoF3EAO
 /E+FxinHJnpVga3eKl4VaPUeJYnRlT/43BqOOrIhlWVmoSf0i8+vnw6ukMw6haa/IM7A
 ePyw==
X-Gm-Message-State: AOJu0Ywt9KqQ3uiD7pSPAz6ieO8kpKYNPorS6CLzH62Ed46kckBwFsux
 5pRPmPue/Z9q8vov9upi+BX56gKA5MtZz7rQL6Vdb7/yeLsLtQk+g7XecCZ0MWaDyDEDTHaEorT
 a7KKl0GxsiBGmlRuSNSSLkzmLJYFYaFTt300qXjm+
X-Gm-Gg: AeBDievNFsFuuud/eFNCxCokeQVVc2SjRYmaAitMyAf7K10wc8iaWFHby7wl77EPf/Y
 gieJqeQDkMj194l4jIisEFFIdZ97t70NKhepmHA9XJv7bQti8fCZFC6+pNMLXLA5y9j+agYqWdk
 qsT/p1qzjLrmA6YVvdMCvZcavWlIzJ2nbPmQL7IB95L7qlE2ZRrcfmzVpL6BTInyjcVmNlyFqJY
 aPkr0Z2eOx8Nvy5UkAwqgj+Uwkh0iUk+ZLVZnG2AOn7rW1aXMFkg352Q8+Zad9gh1QSvcb++5xG
 EoBPknuVDjHU1EKuyxAV
X-Received: by 2002:a17:907:2d0d:b0:ba5:dfa6:1e8e with SMTP id
 a640c23a62f3a-ba5dfa624e3mr518461466b.5.1776713663987; Mon, 20 Apr 2026
 12:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260420072935.3024696-1-padmarao.begari@amd.com>
In-Reply-To: <20260420072935.3024696-1-padmarao.begari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:34:10 +1200
X-Gm-Features: AQROBzDhPZPqYfEVnEN81_dgO-h14KVnXTkv_6dt7xdFi2Cd1xxmz-o21jWRzLw
Message-ID: <CAFLszTi4kiAEpO=8jJi0QyaJnYo1RzmjkLmuMYPhGnbv4-RPOA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: expand disk device names with drive details
To: padmarao.begari@amd.com
Cc: u-boot@lists.denx.de, michal.simek@amd.com
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

On 2026-04-20T07:28:41, Padmarao Begari <padmarao.begari@amd.com> wrote:
> efi_loader: expand disk device names with drive details
>
> Increase the boot menu device name buffer so we can append extra
> metadata. Append the disk capacity and trimmed vendor/product strings
> to the device name so users can differentiate drives in the EFI boot
> menu. Also tighten the parameter validation and pull in linux/string.h
> for strl* helpers.
>
> For example, the U-Boot boot menu now shows entries such as:
>
>     usb 0 (29.7 GiB, Generic Ultra HS-COMBO)
>     usb 1 (28.6 GiB, USB SanDisk 3.2Gen1)
>     scsi 0 (1 GiB, MICRON MT064GBCAV1U31AA)
>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>
> include/efi_loader.h      |  2 +-
>  lib/efi_loader/efi_disk.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 85 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
