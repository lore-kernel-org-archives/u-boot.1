Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AA4D18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4500E89205;
	Mon, 14 Oct 2024 17:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JXT+yp/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD020891F3; Mon, 14 Oct 2024 17:51:20 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1FF3891EF
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbe3e99680so21774366d6.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921077; x=1729525877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/CX4rTDqeVWYgajN/YMZoSOPMocwz4QN97zTBDM0XAY=;
 b=JXT+yp/poBf/Fl2qIwaIQK+rhQnfwF3y17nK0t1BDE3MYjNKDCkpWXod9a+NyOgSqw
 tqN3x020HiWfyFdfST8NaEI3GBir7QizYuuWNhhDBEXYGn1K29X0G6sOMznLjg0NzBdv
 o2Yco2hhMqJffUJg8pVtKEiwUWYr+fHAPZgTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921077; x=1729525877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/CX4rTDqeVWYgajN/YMZoSOPMocwz4QN97zTBDM0XAY=;
 b=BQA61BErsatEeiCLZTaXuiJv3PgQdK1JHRct9gyDXPuadKy8pyqu9RQmGFTsOJbdNK
 ZnSRzAGqw3GuRF/DplRKyuZQckjidelTx7nbhwNEnNc818n6Ag+oTZSBmzKRfxqQr+y7
 2sv6Zidpd1PIPCY+cQAryswl1kxyEE4ubqYtBZTCpYsobhDZ4q6gfTLUozyou9Gg1bEo
 eQxqsKU2K+WfDUpyQh8HuJVxvxndJQoy30jrg3/j9/T10v/Owp7Huv9gXM74+x3sYdNp
 MOyqKq2gKSLcQNLbYzr8fjlGy2YxjlKbQgTfl6dXrf3UG9FKELI4TPCQiU/46t7P3dxx
 Zd/Q==
X-Gm-Message-State: AOJu0Yz72awoiosd8Z7JIR+lVv7pJocOwLTxpX3zUJMG9wRK98lo7Yrc
 qyfaMC/G3158N4Ka1dWQIoJ+Kmb770E37S+OB2XfewAiOWNcS4OoQaaxfli1vP0FW7mKpRaJzvC
 V9cf8Pvh6W09ld6gm5Yt4adihQtkWk0szIOV+
X-Google-Smtp-Source: AGHT+IGmpfk58l4aJQ0RxVxlDEIo/tQJ3jqOCyROODJ7Lf9+YqOt5GEsCIVnChqfmmm3wG6IZmp9mT22Oxi7PJJUKRo=
X-Received: by 2002:a05:6214:3f89:b0:6cb:c72d:6861 with SMTP id
 6a1803df08f44-6cbeffa7607mr155682496d6.14.1728921077510; Mon, 14 Oct 2024
 08:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <20241014131152.267405-15-patrick.rudolph@9elements.com>
In-Reply-To: <20241014131152.267405-15-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:51:07 -0600
Message-ID: <CAFLszTgVd7RjgWsy4OtdM9L5898Rcs-SP_4Qmgyf95KBRg1+iA@mail.gmail.com>
Subject: Re: [PATCH v8 14/37] acpi: Allocate and write ACPI tables
To: Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Mon, 14 Oct 2024 at 07:12, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allocate memory for ACPI tables in generic acpi code. When ACPI wasn't
> installed in other places, install the ACPI table using BLOBLISTs.
>
> This allows non x86 platforms to boot using ACPI only in case the
> EFI loader is being used, since EFI is necessary to advertise the location
> of the ACPI tables in memory.
>
> TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v8:
> - Only use bloblist to store tables on arm
>
> ---
>  lib/acpi/acpi_table.c            | 66 +++++++++++++++++++++++++++++++-
>  test/py/tests/test_event_dump.py |  1 +
>  2 files changed, 66 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thank you
