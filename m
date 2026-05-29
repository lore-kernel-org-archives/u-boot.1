Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1046CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 09:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88264846A5;
	Fri, 29 May 2026 11:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zmbu3ADH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F87B846FD; Fri, 29 May 2026 11:58:37 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6179884671
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd5047a2a4cso2063832766b.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 02:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780048715; cv=none;
 d=google.com; s=arc-20240605;
 b=LyFZUO3EmSQOildAiigKczWktMbL/xrhmacCN/2Ei2ArIPOARHfZFksyqM1UR4CV8h
 TgXzvE99ZPApfpZfpkrdfsXL4ACoHGgWR9XOTzPxyjAdn4cLcTRQFm5YyETkzSK/O+oJ
 tt4V+9wAdPeJmjfxfiwqp/hoNCTJSta1gb/RfQ2hlDYFnDLqKAcJG6UQLXsKMx3i66oY
 58ElIPhpbW5CX/QR872hkKlkZ14L/lceum2GrsI7f9/4Rj7EZ66nwWTpTq/U7gQgOEtH
 eWUn9YAk4wySNqSnIADZ+C0fqYiG2x4WStjjDRV7nIz2UbLFHfWyY3UjwSlkHzE45kmb
 pkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=saKsVPZYpQeFLzP8qBURWmp8xNcgtr49pIKOov2XneI=;
 fh=rLQMN6a/UX9jMmUsQuTe1A8wK9bTo6tPxTHfkaExRTU=;
 b=fIlz8oFhqDFyR5OR8HWbsrbETx+J74UAPn5Vqd1hAejmVNtb+5daJAWd4e5CxmPQHQ
 a7f4hUHoU7FC9gMMTF6gHlU8P/DxZUfJMnXO4hvHLxHVtn8cltQRRR7DEfrKaZ20ig+4
 A3eMJ3xnLbcztPMG+mb4N1OPnal5UdB+1rRufd5/j6QwL66M9DFYMV7G7YEGgOSYmDHN
 D3AYlXBiLfSu3Gv7PwWguD9r0WWdOj47EgaFGBGajpxvJ96praywHIZEP6IuiXicD4Rf
 /KIaO3eoQVMmMR1mDmlZNsE/I3J601hb1Y4HANXaFvjxcq5IGYQFwq0z3bdhGgMXOoN8
 6JFg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780048715; x=1780653515; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=saKsVPZYpQeFLzP8qBURWmp8xNcgtr49pIKOov2XneI=;
 b=Zmbu3ADHHRhW8Lk+xcX01m+PkhyNe2l33ZO0mactkhW7sQU1AdjxeqXhJ5eMYzn/qp
 9jGmhvTk4gKWGVVdoZMihwTI60S2MUrso0Km8JZvWb5/fStd8i+oAqigfvmSciTMTZ5c
 7gXFk7rhZjIcsUtJnU1cF2/c1MDSroCNME1vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780048715; x=1780653515;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saKsVPZYpQeFLzP8qBURWmp8xNcgtr49pIKOov2XneI=;
 b=K0fq5sZiffxJKqdTl+Dp/IOmvqnRbZidJYgUSexVEkExydoRIfc7Vlwzhu3NhJjmk2
 dTEvRLq9ck6Xix1xtP+uiX5ST4icJXNG5o2SU75kVzg/VnzSlnyR0PdMPBcsGJ4C5n4i
 DoxA0n0u50ZGy/E7pnnzBhjIje8FIlmejiRAx6H5vCmu3tGRxx9n12Yv/nU7KUQAJ1s0
 7tFTnV/R3XfCB0Cnnxi9EQUVor7fCyWHkGgOD6Pw7uh8Ai9NrH3b/xj/ehVtprj5l9Jc
 85S4CWwByc9T+xx1w2uYhk+j0OSK1S4yFSJJQlbTwkeKX/lqVVe14QsemmwQ3jSDatXJ
 vr+Q==
X-Gm-Message-State: AOJu0YzKM0CGZ75QeMAKrKPHnwZVCdHapRAk5t4yy9UVLLYN9Cq4KJh5
 D8QKwwExZZB4a43A4SIqRWjTETW0vAJHWV92qbS8Qmczqa7KPWMVWh1sWp3Lu2TAN79qa/QijeD
 XZNROHiZzj6fe9Iq1R0fP0JhROtJYvSp/ZKoHHwXEGJ1K31CAftYx3CdOe7g=
X-Gm-Gg: Acq92OGo94SujCjY0zc/M/xc3sHPsDvwIPEO81PacSNC4rQPagxLV5qDdXZ1XrSf48T
 AQY/qUQZtQkoOhHPl3nBsrEJKkvt38kXRWlgYVOwSiPho9ZS6sEaOIH7A9uMGqf4Aqc1YGY0uu+
 ROH5oLOtGDs9Qg4S9A8u75h1tcMGaZ5wzq5Vh8GxybMf7GiJJrFQTqLrlReDZ1WS74ThVf8/a1z
 ymaIr2+SitpAgyjy/DdZwzp+rLOH3rd02cM66tihH6vIXM2G33CScIMR9KdXZYhYusvpW3UyAND
 ZGWgmZUe6RoJZ0RUPco=
X-Received: by 2002:a17:907:2854:b0:bd7:f75a:817c with SMTP id
 a640c23a62f3a-be9c9338b93mr91183466b.17.1780048714776; Fri, 29 May 2026
 02:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034441.2075305-1-dmukhin@ford.com>
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 04:58:09 -0500
X-Gm-Features: AVHnY4IzILobVP-NftYfoSpQlINfhArAh7rXgZWgh5ioYKjM0CW1BvGBjvNCTxc
Message-ID: <CAFLszThsbqGNLP3jO+hHW-1AE4q4vwHVdWWeVTe3BWCpwUiQ9g@mail.gmail.com>
Subject: Re: [v2,0/6] nvme: few fixups
To: dmukhin@ford.com
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

Hi Denis,

On 2026-05-29T03:44:35, None <dmukhin@ford.com> wrote:

> Patch 4 enables flush for the currently selected block device.

It adds the flush subcommand to all the block-uclass front-end
commands (ide, nvme, pvblock, sata, scsi, usb, virtio) in one go.
Please reword.

> The series adds few fixes for NVMe subsystem.

This is more than NVMe fixes - patch 2 adds a new block-uclass op and
patch 4 touches seven command files. Since you are adding a new uclass
operation, please add a test for blk_flush()/blk_dflush() under
test/dm/blk.c covering success and -ENOSYS when .flush is absent.

> Patch 5 makes nvme_shutdown() symbol public to enable use of it from
>         board_quiesce_devices()

Really we should mark the driver as DM_FLAG_ACTIVE_DMA and then this
happens automatically. The board_quiesce_devices() function should go
away at some point.

Regards,
Simon
