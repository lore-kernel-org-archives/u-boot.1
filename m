Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D09EE3F0F
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 19:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238A586D59;
	Tue, 12 Sep 2023 21:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fMctscrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCC6686E3B; Tue, 12 Sep 2023 21:27:06 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2494B86D3E
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so389029a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694546823; x=1695151623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NrFMrMXDuqb7kn24N395MBJHC0mA2STiSrfvnjvD/6M=;
 b=fMctscrZCSxXYqxRHR135T0/VhMfaIZSY8qVnIKUhqlBx98VCWexphD8Xf2nRMZ4RE
 1nag8yEv47tfnJnComdHhdq39wpVP5VyomiAxj9iE5gxSeP3xdl11UpNksnsj64NvcwI
 /RXNSS1Lk6sdNABY/7bLVyo4zUofolFl90CbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694546823; x=1695151623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NrFMrMXDuqb7kn24N395MBJHC0mA2STiSrfvnjvD/6M=;
 b=EWWOH5K6MSd6XNqQiRtgNzndQbCAaRSng1jKTgGrMTdYJ5drz5XZS4j+PZ2chjn9Z9
 1Dk4WBnX8b7ZhoBCl4rUXzFjUDwLq4nvGCqAkESH7gsZzsjOHFkMnj8r6U7qNbKSRG+1
 vZDdcqTF4U20tlfBlKJoi2dS0zQStOvKRUzeWBQ9Iwf9bdnjPgCc87ghs9QQzYlwk9e2
 5YJU91ZvAOiwdO46fnv0B4C/bD5xw799fWdFKI2hbJf5b87a0YUnV79vf0KjnwIrx9lj
 zazCHD8dGk7iFlGwUrqKjBQaKTpjdQS3WwyXb6bymypGlHJJ2U9ws5J6W0/imtf2/ur9
 2O3A==
X-Gm-Message-State: AOJu0YxaDNH6JtytofGRRJb9ijN9RXrlJdQ5JRDFt8AKriMjtTuT/A8N
 z2X6ryaPWHPkMFaafT0PxIZV5leGQEChV8s8l1otEQ==
X-Google-Smtp-Source: AGHT+IHiifXGJegiZEhCeH5qTMiqw2CV9jzRJxU7E8GtNjg9IwxIdZuJNQbwOrGnmVmYqg/MsGDu/6UDzVMQBJrobqA=
X-Received: by 2002:a05:6402:35c1:b0:52b:db44:79e3 with SMTP id
 z1-20020a05640235c100b0052bdb4479e3mr5676518edc.4.1694546823509; Tue, 12 Sep
 2023 12:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694435541.git.michal.simek@amd.com>
 <9d02ae765d23ed8b82af8db4f288492c30d08ae2.1694435541.git.michal.simek@amd.com>
In-Reply-To: <9d02ae765d23ed8b82af8db4f288492c30d08ae2.1694435541.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 12 Sep 2023 13:26:48 -0600
Message-ID: <CAPnjgZ37rxp8pNsshifyBe1nKu22GCmqe1dwF2OJ0OiYUJV6WQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] trace: Move trace_clocks description above record
 offset calculation
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
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

On Mon, 11 Sept 2023 at 06:32, Michal Simek <michal.simek@amd.com> wrote:
>
> Flyrecord tracing data are page aligned that's why it is necessary to
> calculate alignment properly. Because trace_clocks description is the part
> of record length it is necessary to have information about length earlier.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  tools/proftool.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
