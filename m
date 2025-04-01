Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7112BC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E2DF81703;
	Tue,  1 Apr 2025 17:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RnUPvgva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA8F82040; Tue,  1 Apr 2025 17:52:20 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FCA681F6B
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso10030067a91.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522735; x=1744127535; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KB3Tm0DNQ85ZE40tDNiaHlw3h46GOS2t2NWe/asGxz4=;
 b=RnUPvgvaDcZfkkCC+8Uy4H2vQIunNFmMaJjl62CR1yDHoGyJqpoP9ZkKsIggaWf36A
 /0rs/c99skbFaUGuIrP87UhwL33LDUHDZSbaLxTeLwecgsu/RX3y7e8YUTmuZVHmv4VS
 MnmD04tSA1Ok5i7anWbAD4DhIVZSzq+z6b7Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522735; x=1744127535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KB3Tm0DNQ85ZE40tDNiaHlw3h46GOS2t2NWe/asGxz4=;
 b=o79dAu8ZKJ+FY/0rWh9TCAXvCMdAcJImVPFUqMFTrybnwFBaNhvrPoyINVz+7/Kzu1
 grlib5R+dbFC4WQN/ENHjbLYGjYMCyaAG2QwXrGaZQNyAJNInUoJPPM9hgxp0Wj540sr
 06XExWgfhVVixEoDunJD/9IP+StgbINzTu9MMPq++HhhehVvy8XvI9ObkHzwO2uaEzfp
 FK9FTJiuV2U/N7HbMb/RHB13kZbCyqJQuHkTJhNKcjAJaHYj/woRcCrrjvm5jsIrXNEF
 rwQu/76dgcqVCj42IRp9uePpS65PrUZl+govMxQbdtP1DCMXLLuw3H1KDF8l/7MmC0+z
 irEg==
X-Gm-Message-State: AOJu0YxeJajSnMNnvlo4QmsVRPWCzQmOXF8mwnvKXAJqluagiMg/Jpjh
 ieQjQgP/4tXMEqIqiLG/XyvEBBDSHetV+l5Iz7Wahm/5zkQ+LMoht7f9A8sz4GC+r805bjQc/rE
 o+8KFISgYfi52Bp+DRf7N6k3IWdiD6MLR6MBluPTIsSOvUR7qKQ==
X-Gm-Gg: ASbGncuWkkmwUlHMsadscFTeKdf5BOD6nh+A3VmQXOP9jJ+wZhaLDRXSxDbJ1Frm/Ek
 7VzByYafKQ6VTxTnY2QgrOgZFxefkOQNbA+eMJbOMy6FW4vGF5NhL+mLsjz4mjY+VCBwVFV6oel
 mICunGvxja4XrtCApmwyNajrTZbAg0
X-Google-Smtp-Source: AGHT+IGfVwtRnRRTYOtMQZgifDcsYjr893UlqxEyMFBaMBnVryEKbhg/p9qmVoPu9PT7YcRCqkuFKKIteN6XRVhwy8k=
X-Received: by 2002:a17:90b:2b88:b0:2ff:62f3:5b31 with SMTP id
 98e67ed59e1d1-3053216ddc9mr21271951a91.29.1743522734846; Tue, 01 Apr 2025
 08:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHiZj8jq3JC0=o9LasZ5Xz2AvhvaSyLbpZED+fawcfFn5GdVrw@mail.gmail.com>
In-Reply-To: <CAHiZj8jq3JC0=o9LasZ5Xz2AvhvaSyLbpZED+fawcfFn5GdVrw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:51:41 +1300
X-Gm-Features: AQ5f1Jr3bCcpq1two0XrSXNug1xzPvpLP7PP8y-N6bLURwMEIeLLLljRq3EFH6U
Message-ID: <CAFLszTg52ps6qVK5jONiXSexGFR27SJbqx5ZGreCWMA8EcqZyQ@mail.gmail.com>
Subject: Re: Suggestions for Custom U-Boot Project
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Suraj,

On Fri, 1 Nov 2024 at 12:21, Suraj Sonawane <surajsonawane0215@gmail.com> w=
rote:
>
> Hi everyone!
>
> I'm planning to work on a U-Boot project for learning and would love some
> input. My idea is to create a customized U-Boot bootloader with features
> like dual boot, A/B System Updates, secure boot, and OTA updates. If anyo=
ne
> has suggestions to enhance this project or ideas for other interesting
> U-Boot features to explore, I=E2=80=99d really appreciate it!

I'm not sure if this late reply is useful, but I just saw this.

There is a 'standard boot' feature which you might be able to use as a
base for some of this. For example there is VBE and a VBE a/b/recovery
feature which is slowly inching its way to being applied. With VBE you
can use fwupd to do updates, although it could use more features.

>
> Thanks in advance for any guidance!
> Best Regards,
> Suraj Sonawane

Regards,
Simon
