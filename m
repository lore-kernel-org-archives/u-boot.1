Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CBEC4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C981B878EC;
	Mon,  1 Jan 2024 17:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ht937E7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B298780F; Mon,  1 Jan 2024 17:53:19 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0513A8787E
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67f9fac086bso67436676d6.3
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127996; x=1704732796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zGvjmaO3yIoPHgDkJSP/E2kcm2iiBPs+QsPqGoPB7Lw=;
 b=Ht937E7Voq8StpTbDTJuQVs33aX+4SVpb9BAy+7z8PgnMaFU020cPbBvMFzde3oH+Q
 OqVzHMfDFpQI6EZQFcVAz/OVF6cGw8jdjgl9N7cD5RDhZizoj7tOhgFiW5C4ZW3VTs5A
 m2zJ4eXnFUO1VVi2sDsMsZagcTutDDHU8JX1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127996; x=1704732796;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zGvjmaO3yIoPHgDkJSP/E2kcm2iiBPs+QsPqGoPB7Lw=;
 b=XgS9fQ6x3PD9Y7JtkxoMNQ4T1RpDOA77Ia/9lnN2epNjcnxKfNynZPZeHLXNtN833S
 LJjaKWa6GgJ+824VS2zV4yZBd/u58Az1wqrMBzbiXZ2zmq/XW/0IuNt2Bx24eoAvg95n
 CvSpm1ugFutXXBM1ea0DPaXhAo4FHBJusdwVwoHP5BvgHzJom7xAlgawNMcLM1NCO2Jn
 Vmviwt22lzyjBC0H6WLhGlsPI5Ej1Oq4fZX37u+fpFL+fHxXp0tSXCR8wdVW103JgTAn
 WiBZPId8319IiaUk6U0+M+zg/54IFr3OenJbqUOn6oB3lShFHkHpvOBDfgRi+dr7SQTQ
 E4ww==
X-Gm-Message-State: AOJu0YzxgIxpvIOeSSrSoEhnr/GPK3MabhNOV/kWYgfKhcQSqzuiGUwS
 fl6S8fi2LrIVQ+5fmro59v8xMx5+EEeVqA9+khmBcBuARiY0
X-Google-Smtp-Source: AGHT+IEQ9EsUTaWDpOTCgO18T4gcPShgN7V9LbOiPVr+vQ7H5EEjZvrGEQaJxo6OwHJAWcGmju522x74mZlL68qG9VA=
X-Received: by 2002:a05:6214:21e6:b0:67f:e61:7f08 with SMTP id
 p6-20020a05621421e600b0067f0e617f08mr25649149qvj.69.1704127995875; Mon, 01
 Jan 2024 08:53:15 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:15 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-9-raymond.mao@linaro.org>
References: <20231229174244.892818-9-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:15 -0500
X-Google-Sender-Auth: 6EEnm-DbomR0v2xiDUPD5CkAsEY
Message-ID: <CAFLszThV+yyPWkuwbBTu+678-rbswAEk7LiJe6JS_wpo4RZZ3w@mail.gmail.com>
Subject: Re: [PATCH v5 08/11] bloblist: Reduce blob-header size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
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

From: Simon Glass <sjg@chromium.org>

The v0.9 spec provides for an 8-byte header for each blob, with fewer
fields.
Drop spare value from bloblist record header.
The blob data start address should be aligned to the alignment specified
by the bloblist header.
Update the implementation to match this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Update the blob start address to align to the alignment required by
  the bloblist header.
- Define the macros of bloblist header size and bloblist record header
  size as the size of their structures.
Changes in v3
- Update the calculation of the bloblist record offset to make sure
  that each bloblist record data section start address fulfills the
  alignment requirement.
- Update commit message.
Changes in v5
- Squash #6 from v4 into this patch.

 common/bloblist.c  | 24 +++++++++++++++---------
 include/bloblist.h | 34 ++++++++++++++++++++++------------
 test/bloblist.c    | 16 ++++++++--------
 3 files changed, 45 insertions(+), 29 deletions(-)

Applied to u-boot-dm/next, thanks!
