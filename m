Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7538DC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E1A80BAA;
	Tue,  4 Mar 2025 16:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wr3QWr2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B16AF80F96; Tue,  4 Mar 2025 16:36:57 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D5A80017
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abf42913e95so599450366b.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102615; x=1741707415; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oJg0iJeRt9F6myCFb3JCgaHxbdpzBJYMvNuGNHXKCOM=;
 b=Wr3QWr2XctQBaPjmRIocZQ11T0aVOId0cN7fpbVqm4Ea3TmCWML8894Hu895NDKOo2
 /qx4HyWFdYSMkYuSwHRF+KSMNuhjc1tiAIAqo/vqMFRMx0n2qirHqawqq9tX3Hpy0TPg
 bAWcWlhNrD7k0+S7jm7v8Jn6so5te7OxoDB0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102615; x=1741707415;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oJg0iJeRt9F6myCFb3JCgaHxbdpzBJYMvNuGNHXKCOM=;
 b=W84/6UrnVpXIjZE1wlo62a0+1ioLGxS5u1fg3Igq7aXkSHcoVmYo+9eOnCQA8R0iA0
 upOy4aVzlcC35SEv8hsLzD+nCh7psrbOUkNyMTj0de3wuLVE+e7Q4cuYvOjHFh9zW2Ol
 2csFbWB01k/KqvRCytNPKjm5UabvW+6PtJQTGei/OPA5BIIegCSqch97Gz1wqxJNeOCh
 2ndj8DTpofSiKKUA8J4v/kAb3TmKbtJzVkFPHe0HDIU/KV21AfzuMD6hywdHiD6vzLp8
 E4lA5/4RUkvin+yQgJJ/cCQ9dVR8Rlt85k/tUmsNiGoiRQhBq6EvdFw2qcg1+1hIVbzA
 wopg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXem8r3RWR4m38+Z0IptiCI76C4lc/Q+qJlwDNrRVpIS+KWGvcyo95b+nlIiXnhwgQoYlQv8s=@lists.denx.de
X-Gm-Message-State: AOJu0YwSCOs5TyfVZeW1odUOiFO98bzm/UC1PwjlbrQSsfMhgZeGsHxK
 x8EGb2K4RQwEF0NmJeI9H9DZLI58jwmytLplwZQtf0V1a9qlacTSIome7pkahhUInQIlLG66TZN
 JhnqspZzRqibjwciHsqTx99ir//O5PiK7M85h
X-Gm-Gg: ASbGncuuiTiI2Fcn1s0il33eBdr8qEX4oMCOytoUvL2VmrNtYfparO6pwTlUW0TURvf
 Ws5xtN6Ns0Mhy+FB/uiTMEYY/hVpoZ5Xo8np4A8xydHDSgQZJ09Sd1KJINvkK9pj5mx6HJkHpVa
 vV2lqfEoc27PRHn02gwK7rzErMX0w=
X-Google-Smtp-Source: AGHT+IHXg85VTq7YamvQN2SWI8CWWpZgdGPNrG3kPfd6M+Jq5AH7JjreVxkSUxGZEwojmcOK2ru9lYwvxgGFcBtT19w=
X-Received: by 2002:a17:907:9444:b0:ac1:effd:f2ea with SMTP id
 a640c23a62f3a-ac1effdf38emr346620666b.24.1741102615220; Tue, 04 Mar 2025
 07:36:55 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 07:36:54 -0800
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 07:36:54 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241018030027.842749-9-sjg@chromium.org>
References: <20241018030027.842749-9-sjg@chromium.org>
 <20241018030027.842749-1-sjg@chromium.org>
Date: Tue, 4 Mar 2025 07:36:54 -0800
X-Google-Sender-Auth: wi5TJevkhOICkckCat-IEL_UMss
X-Gm-Features: AQ5f1JrzUnpuiK9SMerWNBccC3yeHgpXSSCQ4JcUBBi3ExNSIsNKf7ZCUTkCVVw
Message-ID: <CAFLszTi83Ksnn8xJefxDm8B1vAbAQBE4RwVFHVPSrpqXuP3BGA@mail.gmail.com>
Subject: Re: [PATCH 8/8] membuf: Support a flag for being full
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Ion Agorria <ion@agorria.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

At present the membuf implementation wastes a slot in the fifo so it can
detect the difference between a full and an empty buffer.

Add the option of supporting a boolean flag, if desired. For now it is
off.

The code-size penalty is non-zero, but the space penalty is small and
could be reduced on 64-bit machines by using a u32 offset for head and
tail.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/membuf.h  |  6 +++++
 lib/membuf.c      | 63 ++++++++++++++++++++++++++++++++++++++---------
 test/lib/membuf.c | 11 ++++++---
 3 files changed, 65 insertions(+), 15 deletions(-)

Applied to sjg/master, thanks!
