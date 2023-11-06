Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F8BC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C83DC870BD;
	Mon,  6 Nov 2023 18:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jK05uDL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F9287124; Mon,  6 Nov 2023 18:25:36 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79ED28702F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso5499052a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 09:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699291530; x=1699896330; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cjFCeIPmaeVxRyZBwxHd4PtHY2/oP8M00fyEy4S50z4=;
 b=jK05uDL41+c/PQRyiCzkkyKws33PjvSqkIcYiC7qb4fQ3Nl9hXNW9aEGGO6DpHI625
 kSb14ObtIkQK6yEaSqokEXLXhsKNeAclNH8FPcxxRsraRkE8LKV1jBkTkkpg8h7TAZq/
 k8ZJqkJCIShXAiqVaw4SaYhk+Q9luu9qstlmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291530; x=1699896330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cjFCeIPmaeVxRyZBwxHd4PtHY2/oP8M00fyEy4S50z4=;
 b=WK2yPMa6figp0oDZ/M9CkrJyb2TN69ZBuupSw9wdOKYNxBcZIU06Nsp3RCvJ8eWi9R
 UctQxbuo1R46TUS8jg+bmwWcK4/IyEfFa7gFA7zdvIe0HvWRi98H8QEHBFVCqi+zMgSU
 zit9kUfjUCTs0z+OetUr6VrGKeDV0M5bKtd9c1sU/3xgr51xrbOwOkP2HBRUBGXiHWG6
 CWUpSo68WTtWw7k9bX9iXWhbzER6ugHIYm3RTyFaeK7kiiePBKZKh3ad/IN8P5g49uJg
 oFGC6n+VLQGP+1Aut3HX4kvJqQEp6QlWtX0jN/GXZ8NVwkgyuV1TvY4nENTifQsEU25i
 F7KQ==
X-Gm-Message-State: AOJu0Yy905hdQM1QFr1ee24bNJDPVtvX7eO+29qFG+iI4HzVU5/5wfPD
 hClwKIEKkdOA0YITKLLgwV6odCXVnvgOE3wgl5rqm+z3I7SXYP8aGJo=
X-Google-Smtp-Source: AGHT+IHmRbCcDBlfG7qgd4ZlKbzQyv0tAF/O00/THQV1NpHzpwK2wmtsMtN2PejPydhxknRR1wl53CQTJ5wdsgVBgTQ=
X-Received: by 2002:a50:9f4e:0:b0:543:6e4f:37b with SMTP id
 b72-20020a509f4e000000b005436e4f037bmr17477160edf.36.1699291529880; Mon, 06
 Nov 2023 09:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20231102185116.21708-1-mibodhi@gmail.com>
In-Reply-To: <20231102185116.21708-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 10:25:12 -0700
Message-ID: <CAPnjgZ0k-Pw7SJWj55+3pd7opZmn7fiqVWikMeOhtBhSYv8_oQ@mail.gmail.com>
Subject: Re: [PATCH v2] bootstd: Skip over bad device during bootflows scanning
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
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

On Thu, 2 Nov 2023 at 12:51, Tony Dinh <mibodhi@gmail.com> wrote:
>
> During bootstd scanning for bootdevs, if bootdev_hunt_drv() encounters
> a device not found error (e.g. ENOENT), let it return a successful status
> so that bootstd will continue scanning the next devices, not stopping
> prematurely.
>
> Background:
>
> During scanning for bootflows, it's possible for bootstd to encounter a
> faulty device controller. Also when the same u-boot is used for another
> variant of the same board, some device controller such as SATA might
> not exist.
>
> I've found this issue while converting the Marvell Sheevaplug board to
> use bootstd. This board has 2 variants, the original Sheevaplug has MMC and
> USB only, but the later variant comes with USB, MMC, and eSATA ports. We
> have been using the same u-boot (starting with CONFIG_IDE and later with DM
> CONFIG_SATA) for both variants. This worked well with the old
> envs-scripting booting scheme.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
> Changes in v2:
> - Restore bootdev_next_prio() to the original.
> - Add a check in bootdev_hunt_drv(). If its descendant bootdev hunt driver
> function returns -ENOENT, set the hunt status to successful (this is the
> case where the device does not exist, or a bad device controller).
> - Update bootdev_hunter_func() docs to indicate that a return
> status -ENOENT is not an error, just a "device not found" status.
> - Set status of sata_rescan() to -ENOENT when the SATA device is not found.
>
>  boot/bootdev-uclass.c | 2 +-
>  drivers/ata/sata.c    | 2 +-
>  include/bootdev.h     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
