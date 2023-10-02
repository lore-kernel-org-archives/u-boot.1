Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63407E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C290874D5;
	Mon,  2 Oct 2023 03:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NKC3e4RH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E7687286; Mon,  2 Oct 2023 03:23:00 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E783874A4
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9ae75ece209so2062000066b.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209772; x=1696814572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oFdSFrENfhuUQNne/CdqAj6dvOT40oD2J+ceDU79dZs=;
 b=NKC3e4RH4IN28O6CB67efrcf4EZcCrutgt4eyrud72FgrJr7msCL3KHpzbASnqjBSn
 /6AcjQx3hUAhhEv1w5OS06zfwRJJjlxaa+eNca7yNAFSmNezCF/aXpBMlCkWLFt2vThe
 r4U01BGwc7tIohtf8igm7jE2LZi7/aacbHMNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209772; x=1696814572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oFdSFrENfhuUQNne/CdqAj6dvOT40oD2J+ceDU79dZs=;
 b=DIgRZ3mV+WJfVokdgH4ZsFt2vc7ZOzih7CUuMKJCKUG31XEToD4IvU9yHohrhTWaKa
 J3GsEuOmd0RXn1eWiFtbFlijR+z+WR5dw5ZbjCBhfvVTesZ6ojTQKErDzFDBZAZxhjFh
 4oGlHn933avbxb7DTSGDREs1ddWV2/3tHR64FbR6eSCugSMNibHgvs42fQ/vQ/12Bk+K
 srl7juPy7a0VJORubRkNkUS1oeRz94lryM9gmZcCLSrHngGByHny+iATHW5T5igmqiPS
 IrptFAoOVocLYCbRqLNJgl6XF3CKx2wMjFj1uSc6oEHJHCwDRS8tsJiPddjcsEgJF8iP
 pfPg==
X-Gm-Message-State: AOJu0YxJblsGUCFQyPC1vVXNwyYyElE8bIYcsiGQKF2SVV71YbtgFVGu
 mJz+g1YUZCmP0dbWF9jdoiCqli6Ly8bocXFztmwJZQ==
X-Google-Smtp-Source: AGHT+IFqHDuSNwbQT536irZihmjTcJbEz3TBiLK4wadVFtfcb4v+zuWGm/0ScRsoYSYyYWUZpyL31r/7uiDgcfhuWgk=
X-Received: by 2002:a17:907:7886:b0:9ae:3a68:93e8 with SMTP id
 ku6-20020a170907788600b009ae3a6893e8mr10091422ejc.14.1696209772225; Sun, 01
 Oct 2023 18:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <20230926-binman-firewalling-v2-3-b1a084ec634d@ti.com>
In-Reply-To: <20230926-binman-firewalling-v2-3-b1a084ec634d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:10 -0600
Message-ID: <CAPnjgZ1wK5uCpEW6sc8ftDBM=REXav_uT=9XDQzXEatOaTpGtw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/8] binman: ftest: Add test for ti-secure firewall
 node
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

On Tue, 26 Sept 2023 at 01:58, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Add test for TI firewalling node in ti-secure.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  tools/binman/ftest.py                        | 12 ++++++++++++
>  tools/binman/test/311_ti_secure_firewall.dts | 28 ++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
