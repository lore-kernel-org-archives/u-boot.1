Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D904C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 09:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F4188210;
	Tue, 28 May 2024 11:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j/vhEQx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3941787EAC; Tue, 28 May 2024 11:11:02 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E065688210
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 11:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4202cea9a2fso3886935e9.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716887459; x=1717492259;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DYMIxS+eDhDbDY2MCLElNhP9NdMF6BDTDSrIeh+IGWw=;
 b=j/vhEQx0nceDe+048M4DsgOkhn3hynm9UuQiBIf79aPFBYr4634bjv4QCVAjNj/gN3
 3Q0RMjoLfKW+u7F9jTx7yigvE0uFPOx5CKRVyqx7CqzTnu0LsW9TDh3xu/WCnh49aOll
 etDgstKArkYONK0PHgbothOt3Hr8jEsHS9Mf3pSzN5+XNPmBkNfJsyKd2i8G6rmwVEkA
 Sq7Wsv2Y/Oqq3ZVxneSPSth0OgPR1yXOm8CecAmqD4FFqMIFZInj/lo5CeyacS/ajhoT
 YENZ/MUyiCBwWQyyM6pBZjiHASFnzsUV/JwtvShWFfrWIcZHc3msv2r4/TAbCFsupHeh
 UnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716887459; x=1717492259;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DYMIxS+eDhDbDY2MCLElNhP9NdMF6BDTDSrIeh+IGWw=;
 b=iBc0+VCVzCcNLWu5SgrsLy1guq3uDcHSUMqChkEFZ9JkE1fUn13ljJ3TArKQxl4eej
 9kI56/NVmYwuuwkbj0AVs8ruCQf+eWle6kxCVlRbiw+hwRRsQ0qCP5qVZk1NNN59IyZe
 hFbZs4B2BJA7dcgUXCWvZmGr0SU6ifuvY05eCKxjx+fia/dhLNOM+5xub6iL6CXUWesL
 hFVNZT02Z7ElbLCtsXt64Is6N9pL38fK7K25EXzCzhyNMcIW3XDLwOpgPELW09Ihjzd+
 vfX7SvjJ0FAERQAiceQ8RWnxihLH6Qg289ynNqjeoQKAlxJiJD3fXsuHlMx3AHf9nzPI
 XvwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcXrl3974uJnzwSWX995CQ4Kp716Bg1bRgpMjFRHNUTbRCg29ylFjO5+IYkxOurhitbSrztPQVH0PdBBaC2QrC3Io00Q==
X-Gm-Message-State: AOJu0YxC8quMm6pNGSxXTdgH+4s91RgaljnwVIyiTeYYYMKibSlywryn
 sq6VXFgWX8pt96iOaLjluY6lNibEFMFxFxftoT4F4CXWTPcl//i9y+eB0vhhzP4=
X-Google-Smtp-Source: AGHT+IG4nhycn0tbcJQIM6Getl2bAgJX0PUmjywDdETEq+TVHQ3NaTnNf1PkRehQQ8dfrZmoAseCFw==
X-Received: by 2002:a7b:ce18:0:b0:420:18e9:86d5 with SMTP id
 5b1f17b1804b1-421089f8242mr94054705e9.10.1716887459242; 
 Tue, 28 May 2024 02:10:59 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f1ad4bsm167894275e9.19.2024.05.28.02.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 02:10:58 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Lukasz Majewski
 <lukma@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH v2 1/8] dfu: add scsi backend
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-1-47583d7ad428@linaro.org>
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-1-47583d7ad428@linaro.org>
Date: Tue, 28 May 2024 11:10:56 +0200
Message-ID: <87le3ugv33.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Caleb,

Thank you for the patch.

On lun., mai 27, 2024 at 19:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> This is extremely similar to the MMC backend, but there are some notable
> differences.
>
> Works with a DFU string like
>
>     scsi 4=u-boot-bin part 11
>
> Where "4" is the SCSI dev number (sequential LUN across all SCSI devices)
> and "11" is the partition number.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/usage/dfu.rst      |  31 ++++
>  drivers/dfu/Kconfig    |   7 +
>  drivers/dfu/Makefile   |   1 +
>  drivers/dfu/dfu.c      |   5 +-
>  drivers/dfu/dfu_scsi.c | 437 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/dfu.h          |  26 +++
>  6 files changed, 506 insertions(+), 1 deletion(-)

I reviewed this here [1]. I could not find any response on that thread.
Could you please respond there or address the remarks for v3, please?

[1] https://lore.kernel.org/r/87o7a94pe1.fsf@baylibre.com

>
> diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
> index 8cc09c308d82..dc4f8d672f99 100644
> --- a/doc/usage/dfu.rst
> +++ b/doc/usage/dfu.rst
> @@ -166,8 +166,38 @@ mmc

[...]

> -- 
> 2.45.0
