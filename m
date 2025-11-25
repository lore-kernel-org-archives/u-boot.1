Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD81D0E6CE
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D140E83FFE;
	Tue, 25 Nov 2025 13:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFD12MY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A2B84010; Tue, 25 Nov 2025 13:19:13 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B71A83FF4
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so3863257a34.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764073150; x=1764677950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H7eMtLwhVxpIUWUKhnwvhVyySHOCVzYOO82UjgGtJvc=;
 b=ZFD12MY2a2IRg7/I6nlf9KbJ+hzVh/Hhl8xurXhm37mtgIALKCPGEPQmq8hkqxfdJM
 xOLHjB1U2ZXAmgiXZKmBHiKqOxyNAUenBXQMpo36XwtZOQqC6w5OCnlY79eR4PbHcwex
 R6SXSfYaaz9/5PC5WPC3cutFIt9DICo9i081vU67/OMoF6EQ+NqObTSqEDqs/GVtQtmI
 cFVh8SPUPSWh4EZWxcRjcBBGCeMTNNqCmgDixmPK4OQpldCVkcd6+K5KxHmdXwF0m+zp
 RLvIOnlbymSQHprKS+VRsQeQlht8MRPMCA6Of1pgYboxEv2hpHC1+IBwXj5W55k1wHGq
 1zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764073150; x=1764677950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7eMtLwhVxpIUWUKhnwvhVyySHOCVzYOO82UjgGtJvc=;
 b=crpdGVJHbwrWi76ABgM/TTvl+vSA5u0OlAq5FW3j8YHlBBEa9489klsBfPEwxE+uZi
 07I5FlL02F0qJ2gx1UVoQDrHJICp7dc5IhburQ+8sRPCkx8k4cwsOCthLsd+fD6vdEvl
 pO+cPyJlQ5sU/yZOhkOVE8XMBOh/FX4fvw+AcADUDYs8xihXgoeYKNRyb/L2373n0jm+
 dbsrcn0MdLalXt8dB5Xrg2bU1z0Osx5SByAHSEAQTLQedfJZGIpT6xKiqKBhIpYa2/Qr
 muyjc28qo6W5Jwy8NIqZ9sEySrGcrcEYAR+67yZuRN8TunOCu2m1Z455+hySf+vh2CqD
 x5XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX1ZEU4i6AVKyuYngWPE9/d+mQax+1oIfwEwj2oVhdqyPmUCb/wQjlkhMbKUTDC4vTeCZu72o=@lists.denx.de
X-Gm-Message-State: AOJu0YwAh/oS9168S5dCbvCrUufNsYMClPZLFRunigrBoyhV1apaB3f1
 YZB0txb/tBacS4e0dIrEXeyZPz6KRHdMEOwtRAbMLv4KPMGuam3N/Q0ymyxGeSDoh16/LnlwgYh
 4MKV9jDkKy62gx/aFOa8TJTCRkjZcuLw=
X-Gm-Gg: ASbGncvS8k/ewyV5FjzaOVf1vLdC2amYnG4jVOyH8aGHmBFcfvgFYz6z6bNcczLfDxy
 QY2pQFDn2/oi00wMHztS9pYhrkamyAFxXCLR9J4VpZN9F+Hg2nF4RkVSc6d31myBbEBHKfnyhox
 5LczpQ0nXWpBOaB6ah8DAO7qE1kItnYimj2ER+NDTMMjUbMdChZA2eaZP2ynl+End1TB6SAEcuZ
 DZYfztQfY0hMOsBfojdjucHvaUQKcHYUAYO9v83k1f7t/zb+yiQp4lJlaSuLJtBx83i7w==
X-Google-Smtp-Source: AGHT+IFivaCUGY2PPMGbPtng0519YtB1IQW4XjyROd8m2IMpJ6Jpwyz08u57gjKQyMyBk3XqbOMigaoqBdMe6V9xIhw=
X-Received: by 2002:a05:6830:25d0:b0:7c7:5349:4e31 with SMTP id
 46e09a7af769-7c7c4399d1bmr1178006a34.21.1764073150358; Tue, 25 Nov 2025
 04:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
 <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
 <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
 <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
 <CAN7C2SCODX0Xd+onkiaim0P78csxFdBDnWXP8ZK2eTL-pUHMfA@mail.gmail.com>
 <8abc9d21-434a-4909-a854-fa5cf8863bae@cherry.de>
In-Reply-To: <8abc9d21-434a-4909-a854-fa5cf8863bae@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 20:18:59 +0800
X-Gm-Features: AWmQ_bku-VPkZKE6jidyCgaCKAasVB1kF3pRoH2AeOcxCj89pMW5Aua4lN1mZ70
Message-ID: <CAN7C2SD6kUPQNdr1M2WKryt_jvAM7HT36+oOtqchjf5ZEdNc6w@mail.gmail.com>
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> Which defconfig files are you talking about? Where can I find them?

Actually it is not defconfig it is the entire socfpga gen5 file this patch
points to.

Let me explain a bit. At first I suspected it was the WDT driver and settings.
But I am wrong. Even turning off all dts and WDT it still has trigger fail
calibration. So now my guess has failed, but why?

I diff a bit by turning on WDT and before that the diff shows CYCLIC.
Then by default the CYCLIC somehow removes the timeout?

So I am going to re-patch this patch as reference. Then you can enclose
it in another patch.

Brian
