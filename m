Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E1DEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4D686D14;
	Sun, 10 Sep 2023 21:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NfBq9vPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BEB986AFD; Sun, 10 Sep 2023 21:14:56 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80D5A86D0D
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bcb5df95c5so2846188a34.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FtA37RitGzTMjNgYrR4p6prNZZ15/1aJRP/qBnf5q4Y=;
 b=NfBq9vPmFzdoJ6DcchBrqXGI6413nlnpSbkvTbzxiI1o8/cdmzctj6r9iiGrxhRNsr
 u5dgqTdqlEPQUKNzfOT6ZwPXX8fVO6E/8RAHyQxz/MdUA49V5hRWa+UQcXA9ur+o08Uw
 bM0BPtohEHiK1lrrV8VN1wGJ1zG+6LdtwPz+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FtA37RitGzTMjNgYrR4p6prNZZ15/1aJRP/qBnf5q4Y=;
 b=RiF7n8qrqZQ5WtETBXGsIXzxH3Mm4aNrCpcCrJl5o0GGCqSvrdO0tXVEJEiXHCxUF3
 TvsNlWgI6h+IXhA/sU/ZW8H1gmjH8NwVbx2PnO0aBZETZqiXw/jdFFTuLC+w18cIphV3
 kCkCA/FAZbjtnq+oOiYyvdZAjrGVP55pVvpYIL5ewpYRqxBQ7mpgfQzBRunsYqIqybOY
 DCD0NNeJpN14BRA09Fqb4dnt9HZclGWFQsag/0ScdsgMSkhJPByqwnfi/Zu5WjlsUq/V
 GY7Eoa4SUJAP2yYYWTDBGNrOHyfmv8rnyv6BYc57faXkbvDUe4B5BtabNAT/d9mId5J7
 /Vdw==
X-Gm-Message-State: AOJu0YxMzNu2RyA504bXGv0Ug7zG2R5LKP+yDpof5Ztwtt4R9I+252Hf
 iy3FJIjxpZCXsRL23TFRCxDyl9JBHb9GVdyb45kYUw==
X-Google-Smtp-Source: AGHT+IEjil7l2O2/oz4bNgmSDrMqYaEra3dtxM6A3UYwFQg1AxF0HNWc+wM9aOHhFfqg2sNsy2ebsin+ja0BD2mJKFA=
X-Received: by 2002:a9d:674b:0:b0:6b9:da1f:653f with SMTP id
 w11-20020a9d674b000000b006b9da1f653fmr8115643otm.21.1694373287022; Sun, 10
 Sep 2023 12:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <536af05e7061982f15b668e87f941cdabfa25392.1694157084.git.michal.simek@amd.com>
In-Reply-To: <536af05e7061982f15b668e87f941cdabfa25392.1694157084.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:22 -0600
Message-ID: <CAPnjgZ3YCV1ptVNCH2kgVE9-da787hULAOngDz4h0LLCus3LvQ@mail.gmail.com>
Subject: Re: [PATCH v2] global: Use proper project name U-Boot (next2)
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Alexander Graf <agraf@csgraf.de>, 
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>
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

On Fri, 8 Sept 2023 at 01:11, Michal Simek <michal.simek@amd.com> wrote:
>
> Use proper project name in README, rst and comment.
> Done in connection to commit bb922ca3eb4b ("global: Use proper project name
> U-Boot (next)").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - Revert change in tools/binman/entries.rst reported by Simon
>
>  board/cobra5272/README                      | 18 +++++++++---------
>  board/emulation/qemu-ppce500/qemu-ppce500.c |  2 +-
>  doc/board/xilinx/zynq.rst                   |  2 +-
>  doc/board/xilinx/zynqmp-r5.rst              |  4 ++--
>  doc/imx/mkimage/imximage.txt                |  2 +-
>  doc/usage/environment.rst                   |  2 +-
>  doc/usage/semihosting.rst                   |  2 +-
>  7 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
