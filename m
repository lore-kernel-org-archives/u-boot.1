Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0F1F94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1488412A;
	Wed, 22 Apr 2026 00:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RcltHXmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6775D84178; Wed, 22 Apr 2026 00:46:11 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD1A83E76
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so6635576a12.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811569; cv=none;
 d=google.com; s=arc-20240605;
 b=fXp9aFAVQoVjh/m2FfEb3Q+0XmWYE+MddKTwQl+MmDtE9jniEo8MXQEJQ1Z2pv5nk7
 b7DI/xtC5IdRWBp/3Ih2OhdyzJTNVMODLopw8JX3H38cakeDVFsBTp25kRGoWrrd8eYL
 q/LKHJ6w1u7INWFE3nkBZvu5uS1Wqr7qaHd6lyKs7PFMJtgghCyHpVJYhX1yjARasfaz
 3wXxf9oU2QWXDhhMYeyCsOh8r0DTNNYzxEJ2xiCzdOVKrDhpf5BIElJtZq7rCXokvmtS
 kobV1uwdKoiQKX1dVZMb973EudLyP4sTt5CLgVIV/64zPxMPV2GD8v2HQk20C5SHholX
 zU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N0QiTwD/R34wgP0yvMsAMqCDZzuC9CkLTuUHknMez3w=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=MPNleCnA198XkPyFwqq921elZ7tFaxEJd5GpkblanOcf//Sp12SviwgXPOQ24h6iAZ
 xCaTZN5lswyOYtoqPwc5BXPTEuWAoTMYMPScCZA5gBlhlioUpdGoo5IOZSEM/zmRMTAp
 8QALOfLelHnNK8TAP0wJCXMDv31tVbBhkU8IxpB4PvS55yukKT5a2+kDvK2MpTLbJXH0
 QhF2J+ReruXpYKxmiMAcS/RLKmVFeRCxqq+frIqhf35SA0OsstTspvbdOYJhDj2HVpuO
 IMtDqCHZ5To3+uGXxNVj9OdZ3LslkPw5KW0rlNDE+ySL7h8Hcdc3tMjT4f+JJUck7Lpe
 +cew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811569; x=1777416369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N0QiTwD/R34wgP0yvMsAMqCDZzuC9CkLTuUHknMez3w=;
 b=RcltHXmFhTCYbX2Gv9eIWpUpm5aog+f/jVnaXRU4xjVD9CMnXrn2elHoKdtA3m23W8
 P2/gYt31Ldjb5F0GVHbLR59K6vrtM5sfenYB5JbU9LFnMJtGfye1UxmOVfREil5TDgMX
 k8qm8CGxXAQrqH52i2pDf7O+61DxGCLatLjdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811569; x=1777416369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0QiTwD/R34wgP0yvMsAMqCDZzuC9CkLTuUHknMez3w=;
 b=lthBDtVnGursAMtmkPu/9Te/D52BkcYyQYA8iAzIa5NkemmK2znUsaEjD/ZceHKqBQ
 r5n4UEd5+N/8kFBeh9MqHZ1Yf7aqDSbiUjXFo2cZBr0fLUI0cyesml3glvMJnPrU0tmj
 kWPbfNCMs9wEIkxbg9o37/1Kdj/DUoOZm3wsH3Q10wxpjn+awJYQkFHHpYyxx5YiEhhi
 A40TcMd7Wb5wkn9JMsjclRBNj01lT36d0hvCrjnjLovfFgWAK8uztO299HhjM/vkoNsc
 7sNON/novLC3Hi5xYxJADDSWG/c5z5EYDQcona+/jdy8PtZz8CjCDH79wvGl9OW+GbRe
 YFfg==
X-Gm-Message-State: AOJu0YycnsSmqPSuHX+Dwnypby0Hi+bhTdS52Z019W2t+rO4fyPG7drR
 kYwswAeg0HOJDw9nZLM8ryMcVoOAQmLpa6aDUwFhphcR6JkTEaIWS0mVYfQYvk/wIRQr36xazop
 /yi1ZoYKxwDbCivRnuQLZKjTOV8dNmNylKUKKwQwVrz3XTxf8FSqltQ==
X-Gm-Gg: AeBDieugiQgeZ1SD6yefmOAXsvBYpnGy//AIPaBSUSIkpVyzHmPGrULGS1oXr5MDfcm
 4mO/dwm0I84QWNChaV/AjwYI60XAO3oFzY2KyuSU3tIumz9CaOQMF2NVYrF6Q72DiDg/J7lOT0i
 Ngs/1vamKMbiQ1eF2IH8ydikowe6f6qukcmm9X6q5xF4N+tGLM1lzQvRAGa74D4c2L4KIJtz4av
 6Co6fv4qfAw7Xpkr5hvxWt5qIUG+FDMq4i4Sy2iqWzhjhIVoMcp2kKzke9nfPOtX95W9wHWJP2N
 4VjG+RdP3TxfRa0XvozH
X-Received: by 2002:a17:907:da7:b0:ba7:62f:9fa4 with SMTP id
 a640c23a62f3a-ba7062fa21cmr540411566b.6.1776811568638; Tue, 21 Apr 2026
 15:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776759754.git.weijie.gao@mediatek.com>
 <fd67a0a7da68717a551f6c6153b56c8719fe2022.1776759754.git.weijie.gao@mediatek.com>
In-Reply-To: <fd67a0a7da68717a551f6c6153b56c8719fe2022.1776759754.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:45:56 +1200
X-Gm-Features: AQROBzDSQqfz28zlM_MtNxa64dGUVi_5iTx6TSHR8uHXoIlpVfGvWOVeQPStS9M
Message-ID: <CAFLszThADZT1+uHr2GVXtj+FQtt4SAtHtvDTDVcmh0ybZ0gTSA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] cmd: ubi: reorganize command messages
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-04-21T08:35:39, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: reorganize command messages
>
> This patch moves normal subcommand messages into the main command function.
> This will allow current and potential api functions being called with clean
> output.
>
> A new function ubi_require_volume() is added for finding and printing error
> message if volume not found. The original ubi_find_volume() will be silent
> for being an api function.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c | 92 ++++++++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 65 insertions(+), 27 deletions(-)

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -514,7 +518,7 @@ int ubi_volume_read(const char *volume, void *buf, loff_t offset, size_t size)
> -     vol = ubi_find_volume(volume);
> +     vol = ubi_require_volume(volume);

Won't this print messages, e.g. ubi_volume_read() is also an API function?

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -402,7 +406,7 @@ int ubi_volume_begin_write(const char *volume, const void *buf, size_t size,
> -     vol = ubi_find_volume(volume);
> +     vol = ubi_require_volume(volume);

Same issue: ubi_volume_begin_write() is an exported API function.

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -806,31 +806,63 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +             if (argc == 3) {
> +                     struct ubi_volume *vol;
> +
> +                     vol = ubi_find_volume(argv[2]);
> +                     if (!vol)
> +                             return 0;
> +
> +                     ret = ubi_remove_vol(argv[2]);
> +                     if (!ret) {
> +                             printf("Removed UBI volume %s (id %d)\n",
> +                                    vol->name, vol->vol_id);
> +                     }

Use-after-free: ubi_remove_vol() frees the volume structure, then you
access vol->name and vol->vol_id  - please save the vol_id before
calling ubi_remove_vol(), or print the volume name from argv[2].

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -877,7 +909,13 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +                     ret = ubi_volume_read(argv[3], (void *)addr, 0, size);
> +                     if (!ret) {
> +                             printf("%lld bytes read from volume %s to 0x%lx\n",
> +                                    size, argv[3], addr);
> +                     }

When size is 0, ubi_volume_read() uses vol->used_bytes internally, but
the success message prints 0. The old message was printed inside
ubi_volume_read() after size was adjusted, so it reported the true
value.

Regards,
Simon
