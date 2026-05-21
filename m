Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D038CD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 23:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B439084866;
	Fri, 22 May 2026 01:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WGBeQBi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 196AA8486A; Fri, 22 May 2026 01:30:27 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC7A846DE
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd8f9889a8cso747669166b.1
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406224; cv=none;
 d=google.com; s=arc-20240605;
 b=cMUBy9HhEiN556nzZ+M64h8GPyycdeUJhwn+O5dwX/IPotYe4md7yiW7h6nkqj3BiW
 v93WtfPm7ej9Rs7w36gkQ3SLNSRjoRd10H0FCFojHVBmOXzIZCEh1ZzD+6CfSqii1TM3
 9IcIr7J1/HYlP4oLjRZnJY4JUumNsMxeef1MlEdwgJ2KZqLACqRdc+AEDCXlwqWxmWuq
 bMFa36hi+PZOOQffyiTFnM5X/NZMnk1xID3uCyCDvZRpx7zKDIcPTH948ky++8lzgUhV
 ThkXZm6OHHOAM5O0Yaeg9ByW890qexvmBD/SXq9ZALxIPLwq+olomVdqMkG5xzreDkXA
 uEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PG7b1FjRx5fESAzEVbDhNrD/3c7mU3mCHZbqmoS2IW8=;
 fh=u2CoA0IH4DkCFeRPM/q/XLziJs+v+BZbtLbiaBJMQ1o=;
 b=eW/dMoIY+YOFJXeWIAr+gW2BSJ5+GY4ksoAHW6fDiTEnNrWwQdLYPDBJ4AaAzV1+HK
 wuKpN0NrkkY/hbuDQTnQxQqBs795Uy2QxqTn+b+fzDTkNwpp/VeGUs5fyPvzn0Ymb+69
 XFWuIC6Dmxusbsq+HZUq9anIVJFnuDRFGflE5pZBvLb1RlpbweO7qzOVXk9d/dEYpsYj
 nhVT8CyGihkxWM/YcqN0/B00yGb5Yq8xmzAJnbq/FJmHyNNs0hlEFNpiNdsw+tpd+Ac2
 /hOruVumtSllWut6Afb3uzleC1ev7B3wdEexpWYkxfztjrmAIC1F7vFCSwgszttmg5HY
 0AzQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779406224; x=1780011024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PG7b1FjRx5fESAzEVbDhNrD/3c7mU3mCHZbqmoS2IW8=;
 b=WGBeQBi4PCrIBo9P3/o9POzETXyIff9b5wCQPQ9/nD8Ihc6Z6STYtbSnQAbLFB+aJi
 Q4SINxn27gcmEvchTEuUlYS9SFEr18E7P9C8afTnStE4ej6NMDJmaDOCKzmkeSkPWHvW
 iG1ehxCFSZ4C/l8z0toKMglm2U6sBOM7JBZbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779406224; x=1780011024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PG7b1FjRx5fESAzEVbDhNrD/3c7mU3mCHZbqmoS2IW8=;
 b=nvJtC8UKLUbwemg/p3BfNhCVuHF3AJ4IIkIYeVg+ZcDlTptFLiq9eps0rRhWWGHEnN
 cLWOQr8F6L+YliUOAkfzao2A+cexDF9wJsAYLPQ693N3PWyN6XTcMSMG+yK2QJl18y53
 k6t+EuC2k6KNQa7jVSnzKo4TLOC/uxrbVzB/NtjSVfreCb2mgjRFVwi8WNG/ExCLXznQ
 L0Ff6nJh6aIQhVZgGASt2KOluEz1rp/8OcfEcnKXMelji7i8fB/Kbl2/MqHYAPy9UGkv
 Wc/oGswomFhRG9bAYHCf85AzWLOz28rFm8ar6L4e/8//W3sp8ARN4cNN4FZLuf8FVO+2
 NxLw==
X-Gm-Message-State: AOJu0Yw0o5km/Hq+sYaqysAcXCdlmg0Unr02T4rJjuwbkyBXvXwnNNgK
 ss9KBJ6jCuhZ5qA6g9fn+9O1kiQv+T6atmhkD3Yj8rYD3JFyXCorFJJqEagpe08gr2QqymMumzl
 DzlmHb+3xBLaKN8QRi82xoHGreOP4y/qqbd6/AlTX
X-Gm-Gg: Acq92OHUW6hhqAAn7zQ+aq+rOe/3pzc3yE7QcEwj1u9Tzo+nODnBIg3SA514zw/PXBI
 2wwmw+syDxF38VROlwC5xNa6tfxmNSNIIi1p3xsjbA1dzFdp3wJrlt7J6ofj/BCGq0EwHPa7z9M
 21Tw/E6pemxpy8lj+GYYgq6QoHSZDQ/SE7bUZRTb9weErjo/EdfkuI5bPD+nkZOvqnAOZSbQ3hW
 H3xKt6OU8dLQLK4dw3AXs51xh0Tby06uMhvys7ENst71ZyqbnXmV2dk4gSAvLb7mwRlxlMa3yJt
 4utEEk+0WPf4SFtT
X-Received: by 2002:a17:907:c317:b0:bda:3488:96b3 with SMTP id
 a640c23a62f3a-bdd25cdfdd6mr73562566b.27.1779406224537; Thu, 21 May 2026
 16:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260519152101.716714-1-trini@konsulko.com>
In-Reply-To: <20260519152101.716714-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 17:30:12 -0600
X-Gm-Features: AVHnY4LLkMOhaRMqZqZYr6x2dtkdkpHZroGzSmmZxJJ1JqQne3jPGNcz_ICX0wQ
Message-ID: <CAFLszTh3vk3FbrOXWrxY1JP_Se7ewuoQhHETZhjrkKcQLZ5pzw@mail.gmail.com>
Subject: Re: [0/5] Remove some empty bootdev_ops structures
To: trini@konsulko.com
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

Hi Tom,

On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:

> This series fixes bootdev_get_bootflow to not require the ops
> field in the driver to be set and then removes the empty struct from the
> places which had been creating one.

Two more empty bootdev_ops structures fit this pattern:
nvme_bootdev_ops and usb_bootdev_ops. Please can you fold those into
v2 so we clean them all up together?

> As part of Marek Vasut's work to add static and/or const to structs that
> should have it, but do not, it exposed a small problem with the bootdev
> uclass.

BTW for patch 1 it would be useful to update the comment for
bootdev_get_ops() to indicate it can return NULL - normally, we don't
allow this.

Regards,
Simon
