Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6EBC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FCE5874BA;
	Sun, 12 Nov 2023 21:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UlqNmWRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF6C874DE; Sun, 12 Nov 2023 21:03:57 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81178874F2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a82c2eb50cso37498167b3.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819434; x=1700424234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tGqn2TDreY8JkItD+hHztj4WY8UpuOf0hoc9JZZGbqU=;
 b=UlqNmWRY1EltcT0FN22j3B9PXRWas4q3xRZHfM8B5arAz8lI8+GS6XiUFL2pN56TGt
 Oht+re9b3HKbM0r8DsL+p/N0SMPPM7ZYgiI1oC0lXvv/0+v62+v8o/dhQ2FGXv1yRb+Q
 gxePMcjPi6IaU0iDDCCLDB/s0rGeiKr/50p34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819434; x=1700424234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tGqn2TDreY8JkItD+hHztj4WY8UpuOf0hoc9JZZGbqU=;
 b=Q3SmqyTJdwvqnttkqq4nakdBOqtcDNVRm+TXUAXnLHV3q1BilgvEVHaHGIVfP9nZIQ
 XPoG26OL/hgCzeGlNwApcjie5LqhCPtzOKBhQxCH/So2lcyC+g1B8YFPh7JpKkZUt/Bj
 dWpSIxTR2XpeWhDW79RdoYumFViyclS92kGeClQHA7glj06ExeRLTp+1NShYH0bhqami
 rs+U2ESz/pG76O2MUAgQM4djmVIYtmKxpB1PlcIrSS7bK7baWL4UmfkbnEBF/69BhfTG
 SI+M2Bf3U+JWAKl/Fq4IiYrjkUNZAIJ5bHp7Ll8rHIuzyj3X6pwSwq321ApH7cfiuR1+
 nlSA==
X-Gm-Message-State: AOJu0YxJFLlQuFh59PQB7AE3F1/v8OZNxqG690P1/SMn6em4EUylPx0J
 U3WUAsUSfgboD4XHeG0mb9r67UXaC3EVVb+BLmXzvQ==
X-Google-Smtp-Source: AGHT+IG+6kA2Q92Vn6ZK9CkCptt/awBJ8iPpMJyoNxBtx5SQakI5s1m1y/bAQ6mzHsWuyjlIaGffbZZlQsv7l5ZJVLs=
X-Received: by 2002:a81:710a:0:b0:59e:7f14:4b48 with SMTP id
 m10-20020a81710a000000b0059e7f144b48mr3251503ywc.41.1699819434115; Sun, 12
 Nov 2023 12:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20231112070316.17982-1-heinrich.schuchardt@canonical.com>
 <20231112070316.17982-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231112070316.17982-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:29 -0700
Message-ID: <CAPnjgZ3pZ4gYo_hAHwfsKDrbP2v-ZSsfhoN=r43LW-BchhhSMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] acpi: fix struct acpi_xsdt
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Sun, 12 Nov 2023 at 00:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The size of the ACPI table header is not a multiple of 8. We have to mark
> struct acpi_xsdt as packed to correctly access field Entry.
>
> Add a unit test for the offsets of field Entry in the RSDT and XSDT tables.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         add unit test
> ---
>  include/acpi/acpi_table.h |  2 +-
>  test/dm/acpi.c            | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
