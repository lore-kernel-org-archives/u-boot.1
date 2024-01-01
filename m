Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A0C4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386588793A;
	Mon,  1 Jan 2024 17:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C2KOn5WB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B554B87931; Mon,  1 Jan 2024 17:53:31 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C3A87920
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-680285e7ce8so44438886d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704128007; x=1704732807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6wdrAA3EvXZdvoiJCvXroEYyeHrwjVJ1/BtOav28cBM=;
 b=C2KOn5WBmqvYCbBkA9ClsgfyAsob4kkpXT5cdMNd/dVhPXD9P+VPeXAQ4roW2/CBAX
 LTuNYF0GhkiWWadu4vhYQR/ex5GIGdGMyBZ6DzoL2XVOMJ3BBVVzUsmGjNkyHxVlYBrp
 uXOYyjkAIVZ4HwwVQv1RtFTC29V++4WMgK2mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704128007; x=1704732807;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wdrAA3EvXZdvoiJCvXroEYyeHrwjVJ1/BtOav28cBM=;
 b=OH8d4sS7UH9FQYlGCi7bWSoY7mRGbr2RPeHZrnn4/Ria4WTL7pmuYZt5jBJ4yUcRFH
 wl9sbDvO4mmJSXKW/Y3B2SLCKAjY/vr41sRNiV4Bbnnrw8A9q0HGbM6MmrAB1B0GCJr1
 MbozzdziaVGQw60s9M21OChuhYnFFUv7FW1XF+Nf2iFoOfSWkR0+SbrfVJxIPvsburnj
 XmwI+M+/Xb+q+01rx4S/0eQK6LwRYBBlC4qEvRvR1lHPfqMyIVtSnTT4QnF3aHSIqkFW
 0Tl9D/4Vgw084y6JBMxqXEzRmmlcjxIcGEC627LeN44bH8UgKSA75W6MP8MwqxCkjahQ
 Bcug==
X-Gm-Message-State: AOJu0Yz5EgBDy/B6ezTe4JT30XifYVhqKwKWtRjjclfT0Wf7ZyDjJ8/P
 6rtYkZKbMFDAtxprzpI/MQXFC1h3tXtrzPz7MjTrkAfgEmk8RQrUlAwbQhDj6A==
X-Google-Smtp-Source: AGHT+IE6oZe8QtbVcdIL4DtzQbS/Qwqtv9TG7nEcqsCAIf5TBuAndxaEaVfjCkj+WzOKrJibDojWMTNsFW2RKMzH0rM=
X-Received: by 2002:a05:6214:23cc:b0:680:b917:feb2 with SMTP id
 hr12-20020a05621423cc00b00680b917feb2mr1428160qvb.44.1704128007432; Mon, 01
 Jan 2024 08:53:27 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:26 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-2-raymond.mao@linaro.org>
References: <20231229174244.892818-2-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:26 -0500
X-Google-Sender-Auth: YiPdBZr2YXAgb9mIJ4R23FIi2aI
Message-ID: <CAFLszThumJVrxAqj+tkK6DOrqXV+G1T0c6LUpApHjHkwBs-trQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] bloblist: Update the tag numbering
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

Align bloblist tags with the FW handoff spec v0.9.
The most common ones are from 0.
TF related ones are from 0x100.
All non-standard ones from 0xfff000.

Added new defined tags:
BLOBLISTT_OPTEE_PAGABLE_PART for TF.
BLOBLISTT_TPM_EVLOG and BLOBLISTT_TPM_CRB_BASE for TPM.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- Align bloblist tags to FW handoff spec v0.9.
Changes in v3
- Add TPM related tags

 common/bloblist.c  | 18 ++++++++++---
 include/bloblist.h | 67 +++++++++++++++++++++++++---------------------
 test/bloblist.c    |  4 +--
 3 files changed, 52 insertions(+), 37 deletions(-)

Applied to u-boot-dm/next, thanks!
