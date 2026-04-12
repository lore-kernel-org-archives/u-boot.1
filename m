Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEFFE937E7
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 21:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE7683B99;
	Sun, 12 Apr 2026 23:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="A+vmdugU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5449883BC4; Sun, 12 Apr 2026 23:47:56 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 038EF839D5
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 23:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79a535e7c00so43051967b3.3
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 14:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776030471; cv=none;
 d=google.com; s=arc-20240605;
 b=KokKyOCR2rZo1XoWawio8wGC0Hll6bukUKaWh15qifeoN7dqR+Lr6olr5IcQm7zR2G
 IcLl4S2Y1AEVtalnkLSFKS9NY13E4H17Yv1AOEzYHokiAlUrZ+hwOFH64qd3o1b615ct
 LqiqVri6vVIztBgznokz/DjQvrzJqQwIvtAZwdUYAFQSOXcjmWGKWXx3jF6kqbMUJPKw
 ttWFhyBAEgepTRA8yVM8zaa53P9JTpuWZAQaQTO3nCDVnFekQsPSIzAbQv5wKeisKilW
 SMP64r/MAdl5T+Kn0Rerb/SeBkR3YKjSsKTqYnzRTuar8Y1GnTV1gLT2K0PrmqlzxlNS
 t+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R3zMBYUHqDpFaKl+tjEGHQenNirmU7FpD3trzZgcW9o=;
 fh=0Oc5kyYjVCmya2mmcsaGUFu9KBl763qOyu40EeTAIFg=;
 b=KhpAJEUroCM5oZU4WCRkp3n4Lg6wtkqiRfSoab5cB+SzI9WsOWZ6JK9GAVMsebnAbq
 h2fUrcllXVj35OggGbQbx07sYCNI6jq+bcmZBnWv5IO7KQ4NCD0YKWYLJw/YPgQUqgWb
 I+B99GaLLEUXNyXVsozAoLRK3I5pyGHpsaRn7CwxxU99EJqc2zLFQaCZ12EA0vMnnFSY
 kas+6qrmNtZ7oJ74c7n4OkODM/hzsWECxKqB02cZFxAp7LM9KJ3O9GhfHftz82MfYCkD
 HWg5ZK8T3Bzi8Qs7x2uGE43cmjX1LxH9PEvQWvJkUMnDXYDyKJmPs5CzyVv9gA7rBJ6u
 3wfg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776030471; x=1776635271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R3zMBYUHqDpFaKl+tjEGHQenNirmU7FpD3trzZgcW9o=;
 b=A+vmdugUBIqwHfBjsFZW8IM9biZeWAGMbvKMp0oPpSwPuX6dkple8YfRpTwH/BAlmi
 E05dpAabGOjvjbscl0Z4mUQ9mCGjY9OadLKL5VqJXYLkMRw1UavFemdlRvBeDGZmZ7rU
 FxAKizRhvyQ1y22cT1SYAiYTx2/Jy0tOT7JmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776030471; x=1776635271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3zMBYUHqDpFaKl+tjEGHQenNirmU7FpD3trzZgcW9o=;
 b=ClL+0LGTFRvPcibzepva0VJPj3Za99CixLfCHNHYgvt/ioEAjmw1iatCrTA+/Hcsfg
 sDzBNR4JdoWvxQ9e9ZWN+kKvBTXVEAMfJ3eAMEtky39O3WRrsgB28BkJftubeVXzTTQs
 RB3j1TnSe58LhkEzX7Q1W+LE4heKNp84hdClHIgZ6V74krCNyhewLIgpggEP9F00rw2D
 qpdn7Ar3ly8w1NYBBbnoQ8oTSt7ajstoxM1NxgWDzbrYTpwOJ8ue64BKGCl49J0//2vR
 EURjDvydzNzZzJQCuu9/3xUAeT78Gcrzi+6NcZb/v1so0a9HQEoQFLpK3kR9V+ZjD8Ux
 VTNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CKQdZZyvgnLNhdyERvQdnRGafg5uU/Iw7+07JnbV8fUX7jKCumsoADltdmvtmlD810ndBTxU=@lists.denx.de
X-Gm-Message-State: AOJu0YywkrBXbTKT0p+url+fS0Uv00BpyzBbt7D6EqA1NHWgOYGTIA1M
 rKnV7hIQ6yE1QeDuYzExUn0wKX0l6nsGb7FdR8FKY9vkpzV7OyDA/bu7pGOiW/Sp9oVwXa/8slC
 ihXvucyisRr5ZMJ3FX90ygOsQ7ib/jPy9w60TcbRGLg==
X-Gm-Gg: AeBDietdBbBfrh5BDWBOQy++EIe/MFNqW+UqL2qjEodr8onWu//ob+mPn0N56olVmgc
 WVeYHOklQIxE0XdiaCn11RFnRPKOs8Hzm0Zsj4seUb9oPAoCMw/GtXJEHaZ1qz4yo5rut6oDUA4
 T6q4yXmRSqtBksjhu4a3PquHXl7vomTOq8kUNr1dKyFZWvKIBiQS0uMMct9zcES2tb3B4Lj5VXk
 k5QCRD2WI9yKfY4XbtiRxO5ww1icPihypferqyqfFgQZo4DzlGSSZEhrjRPimBjNZmxohDxErWz
 JXGx9EorW9fb5fFc9MyRv9c3ZwifBjc4F1lFergwCFVscS51qHE=
X-Received: by 2002:a05:690c:498f:b0:7b1:e942:bddb with SMTP id
 00721157ae682-7b1e942c63bmr49833417b3.13.1776030471414; Sun, 12 Apr 2026
 14:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-5-daniel@thingy.jp>
 <adwP6m1zDjUQWAl0@google.com>
In-Reply-To: <adwP6m1zDjUQWAl0@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Mon, 13 Apr 2026 06:47:37 +0900
X-Gm-Features: AQROBzAPrRUGjGRlE67z8nm-YnLb2x3bOnlQ4EYI_6Efdt3bt3Lw8yAjw4FG36k
Message-ID: <CAFr9PXmVeWjFNM8x0rKeLHjvZOFLyvbMyNngt8EpMqkBbugHGw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] virtio: blk: Fix converting the vendor id to a
 string
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Mon, 13 Apr 2026 at 06:34, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> Is there a chance that other non qemu virtio-mmio devices also use a
> 4 character string for their vendor ID? If so, this patch will regress
> their output from a human-readable string to a raw hex value.

There might be other implementations of virtio but probably not used
together with u-boot.
I think this goes the other way too, we are assuming the ids are
printable ascii chars and it's possible to have an id that isn't.
What is currently happening looks like luck and seems unsafe to me so
I think regressing to printing hex is better.
