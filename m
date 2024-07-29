Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F462C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B991A888B2;
	Mon, 29 Jul 2024 17:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M8mQYtqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464C188886; Mon, 29 Jul 2024 17:28:50 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4983B87E13
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b796667348so26969156d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266927; x=1722871727; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8oBHq08fHvPmnDWNVYlKfmVTuZGSm9Ry0mt+iogHi/c=;
 b=M8mQYtqTsU7mePSlAzFK3G3IjrprUc7eFn2fd5X5TrKGmVTtToRRHjBAxCq7Ll2CyP
 Qjnxr7QpKRmN9lburjOxdUIg6X4yVABIy+xLbqPyonvxnHlFI+BOmqTp0hyhEaJK4f02
 sssXUzrTdVndECpOL63QTmSR0l0iIecCIrCdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266927; x=1722871727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8oBHq08fHvPmnDWNVYlKfmVTuZGSm9Ry0mt+iogHi/c=;
 b=cpVHWtBhx77VMaXBQyB+fwCQoXuiXfWhKzatutNex4GRKxlRBfbZivLQsWswvXXuEJ
 eLxBAQ7fpixzwvE5a/H5hGKLQLTJ4/ySaPe93xLYxJ3iWv74r4TkdCc+FniG+uCSW6iO
 0aNmWDvTU6UVCz3bzr2LNSQB8yOg3idPch8Wz2R0u5aOW0KeEDhG/z/wOEU7EPJ971eV
 r0Og97ua5dGyj56Yp/JOdYKPl70IUixSXeIEVhG5GNV3DdE/QmWLiBdi0FdKTMHeNhOI
 UYwJgWFLh1zxSNIdCbBCLXsKSDLOhxBxBi/dwRtXH9h6bWFCJVxOPsXY+5v9DI/o7hSL
 AcwQ==
X-Gm-Message-State: AOJu0YzxE832x1kENh/KXADCIM11XbvN1/gTEFxYeC8UGGHuZYW915Bw
 VcbvzySXrV+AeE8ZThS7FeN6UTDfHnLRt5oQtmf9fjpOG24B/GlxH+sTUvosnpJcSQJUY6cUczl
 RdNNdXwurxTkImWkdpsYrV8748JnPRrvdnSNE
X-Google-Smtp-Source: AGHT+IEz+EVzK7m1YDScjzZ26Sp+np6JTZVJZRV3x9JlaU0sFUHZd3NZqGe2Ekhx9MKX6IJgCCOtrEbaaNN/jCJfzoo=
X-Received: by 2002:a05:6214:2ae:b0:6b0:8991:a2f7 with SMTP id
 6a1803df08f44-6bb563048b4mr153561986d6.12.1722266927239; Mon, 29 Jul 2024
 08:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-7-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-7-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:36 -0600
Message-ID: <CAFLszTjyBc74msYDmGWFdqNDXaQCEh8Tj9p0rYX3EjPo+U8g9Q@mail.gmail.com>
Subject: Re: [PATCH 06/17] acpi: Add define for GTDT
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add the interrupt flag used in ACPI GTDT table as define.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  include/acpi/acpi_table.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
