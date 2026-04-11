Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A46CF3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 16:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F4D841D5;
	Sat, 11 Apr 2026 18:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jRqRrNVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72FAE841D5; Sat, 11 Apr 2026 18:29:36 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0E7841FA
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b2494440f3so11001405ad.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 09:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775924973; cv=none;
 d=google.com; s=arc-20240605;
 b=V5qvKTL4VBieuGYfCdPKVU04b7OvPy4333hZf9514x4FOff682BqNjsNbZLZLwtKOL
 22UngfDyRXqVsyN0xoe4aXOjszn2ny2tXtgMGEuXhmLbeePi5JZm4c7nadt/RMNPlRa6
 ALllxkEvaXiq0NBXJX9evuywSQPrD0GUP9ZkDE+BRMHfhJ4hQlr/zfvL6OJB0jfQZKYh
 2IuEZLV9+LGix4RpkLf/btu8+s3KtWU6GRMTjEsZKz0ncSZoohBETk9QCeYUdKTC7s/n
 ZRcxvIY6laVvD+TfcS0MyUaSvLz/hp3T86lL3x9pJuDQ8MKpd3OAepDC2SYoDmgmoA4N
 ddLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CnqKgdk1W6nf6S7MMzVRWJqMfy8gP0jrXXeMW3byXGs=;
 fh=SvNL3e5NAGuSy5UTGASj56G+06S1wllJBYrbSrb2B+U=;
 b=I2JqoD9ICzSvLsWo83PFMvefYfPHZdxyXtQzOorLoyB9hb/DUtSTvP0LSrEtFUpkJl
 iM385Yjwi6XWunaGEVTt8nhJf1oD6Tfirgn3wNspWySaAzae9eZZ/p6/eNLbh2P6HjHz
 Aj+f1SMHrj5jdlGUYhr7fmVp3D+8Cid9oKG1qJYNet840nWcwjTrNAz+tocYubFbu4F4
 JpvILdctbuQPdKNRYVkQxy5xVz/fCBrlIJH+Ea371rPg2Zi4pCyTXCXwLildjWN8GspM
 RM0HHKyVDmfJ+281PweQWYTOnSwBrwEbbiC6GsJbmMX3oFgSIjYpve0wCrTC7KWTyb5L
 8A2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775924973; x=1776529773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CnqKgdk1W6nf6S7MMzVRWJqMfy8gP0jrXXeMW3byXGs=;
 b=jRqRrNVDI1FUAN6HjAKlyojVts954Xx/sAoUT0fsFIB2PhxRs0l+9EQ0cz2+bxnxLi
 Dl9yHFtEkr7upUlybmlDyyzGZlOY0j43v9l6KnQYKlQtrZEu/bta4boNxFZkxDUBB9zr
 aQY4QIxcoZUL0/Ztge2hnsDnGZvUAEESNtA5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775924973; x=1776529773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnqKgdk1W6nf6S7MMzVRWJqMfy8gP0jrXXeMW3byXGs=;
 b=dbVXOdh9k2znJtVG7qlV7RWs5PPtIZ8m0K3T8v4u8F86gUtgeOv+fdgaO2/DspsG/l
 xYHRDx/Xe+46nKibvmzT62Hij2PjHU+FpuCoVx3CrbvxxJ40rn31ETQQ47AVVAOL2YvZ
 OTY+oWYP6igsS2RsjlL7KfU08H0AoJ/4cEmG/qFDgHwoNUPpicG5sMS9ZlDH74AwDml9
 UXH8FXI6jjbaXt/hNoqbzTKUfEOYZOHfXNWGZL9wPm3fN8DQXcJTZEiJR0Ebhy/5TU8C
 MajC+O7XOypulMiYmWgP9JMgvvNXgC2YNMvKpe30uqMff2iCZaKTcIir27GGbMiXjENP
 tVSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ80XNkh4lkaOcR58GMwfC9ERKXxSAO8D3L76XtQ7QarqxPrNCRYr42PwaMHAISayz9nQqn02+g=@lists.denx.de
X-Gm-Message-State: AOJu0YxaSpnhKw4XGStWyaad3Zd692f4TTMWEDKOpAo+msGPOyorGuaZ
 OjrHAfmhxwbQQdOnhwfI8wddr66v7+zGKqqhXLBx6NCt1aMpX2svin0R3jZo4g4/neFfcjR4f1B
 n0HKEhahJxMmVbdti6GeMUKqNdSyi+52VHGfcBcX0
X-Gm-Gg: AeBDievVu+JvdPV2rJsZzK6yfoXzYHZPECQou+CxWDWkQV4Z9UbW8QBbND+M954dqui
 /PsgxYlNnBqfJCYkiVhY5rlpwONNTHaJ76HNoyUPT+ZlyclH9YzlGsgtVUxL4i7D+kA+4Vno8s1
 bvdQ4yVjceKWpFQ9ZBtxRVQM6YSlLaTCh/obOvW69ukUbtQrVITwVYe7rKCHLZW5GWhWSS8fFyh
 l/ko5fEotpi3Dizj0ooiKdRM6+ggX+kFuLtAt9Jcw5Qn9gsWdTkNfMbgymys7a659gFbHwoz7hY
 1BOLlQ==
X-Received: by 2002:a17:903:22d2:b0:2ae:4800:141a with SMTP id
 d9443c01a7336-2b2d5a4881bmr77773915ad.32.1775924972768; Sat, 11 Apr 2026
 09:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-4-daniel@thingy.jp>
In-Reply-To: <20260408220928.3328551-4-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 10:28:39 -0600
X-Gm-Features: AQROBzBFFADjRuBI6JS7FO-bsxYs3yNe4f_76XDElyU05msw-AmtVPkWYeAJSDY
Message-ID: <CAFLszThzPOFHLNmq_HAv73-rNSJSv-oFKUfOANH9D0qTHngX0w@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] virtio: mmio: Allow instantiation via platform data
To: daniel@thingy.jp
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de
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

On 2026-04-08T22:09:23, Daniel Palmer <daniel@thingy.jp> wrote:
> virtio: mmio: Allow instantiation via platform data
>
> The m68k QEMU virt machine doesn't use devicetree, yet, so
> allow it to create virtio-mmio instances via platform data.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> drivers/virtio/virtio_mmio.c | 27 ++++++++++++++++++---------
>  include/virtio_mmio.h        | 12 ++++++++++++
>  2 files changed, 30 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
