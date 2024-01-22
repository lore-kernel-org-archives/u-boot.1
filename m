Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3228C47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 18:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDDD787872;
	Mon, 22 Jan 2024 19:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e/VTyKix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0357B8780E; Mon, 22 Jan 2024 19:30:10 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E681987872
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 19:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5f0629e67f4so34658567b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 10:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705948205; x=1706553005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3c4jgIFl+UYbtG8gCdCcO58H+b8JxLUp7bzUrOaftI=;
 b=e/VTyKixJiCbPO3STMuSAZx2HMrRTiVkQ19ILYEy06v3wIwTARmzFe0D30lcpHe77r
 noc9M5jaLU3wBAv7qDAjXkAIMyuGgJZ4BJXK7t6EIwZbjTHflxUEtKuK6zYE76cAOI5z
 0qx2gYPx9ARGmjhGOc/MWdvMdYWlrAouXyJKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705948205; x=1706553005;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3c4jgIFl+UYbtG8gCdCcO58H+b8JxLUp7bzUrOaftI=;
 b=BmeLuFYK8KzHzFmB1Lkb99kH22wDvRgkWT+gDzM5jEv88wLbkpQRmXbggoxN6JffJV
 4eZiGHB5VUMSe4ALV/qnUfpDz9CSxe8NfQl26GAOK1V0iXuN/Ley84hu1NGS7dw9pWsZ
 6ZQee4WahptYpnJznxa/mFf3p+NL2YTI0aiPLd7WtFQT9cXKCR6noFCQL3BVaRo8W9CV
 UTarCOwt4hq5ZlLLzf7JZ2m/Z3rVO3v95S76ZT+B2kIoKG7f409+H71ZUxQjZWPqQc3N
 2umNuIEz7j/duZ9vx6f+jtkj63m0ldSHvzmKi5hUivo7lTm9D85eS01/qdAYfKjRgsuj
 N6UA==
X-Gm-Message-State: AOJu0YwP4Xpr7QgpIBN/yEIVa7lAiJzxnJgXrNBvzgm3PtRVYJGbsqom
 vxM/M/mK8AWS0w2pxHHMgFHOdHrQOhOi6SooPYySYLLVUycedpRmS+v2T8bp6VFya7Fvm6oGsb/
 3
X-Google-Smtp-Source: AGHT+IE7AJq+P5Da7ZLlaUsFB4hOtdwb63X0QHyEdyW2XdFeGXyD5/rwn4kddGVSq9VXgeQ2l/2qsg==
X-Received: by 2002:a0d:ce05:0:b0:5ff:958d:5b2 with SMTP id
 q5-20020a0dce05000000b005ff958d05b2mr3865251ywd.51.1705948205250; 
 Mon, 22 Jan 2024 10:30:05 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 x129-20020a814a87000000b005fc98de3763sm8072218ywa.79.2024.01.22.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 10:30:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: marex@denx.de, Shantur Rathore <i@shantur.com>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Hector Martin <marcan@marcan.st>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20231209181057.331815-1-i@shantur.com>
References: <20231209181057.331815-1-i@shantur.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
Message-Id: <170594820459.1394778.2012357904510640470.b4-ty@konsulko.com>
Date: Mon, 22 Jan 2024 13:30:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Sat, 09 Dec 2023 18:10:56 +0000, Shantur Rathore wrote:

> Currently when a hub is turned on, all the ports are powered on.
> This works well for hubs which have individual power control.
> 
> For the hubs without individual power control this has no effect.
> Mostly in these scenarios the hub port is powered before the USB
> controller is enabled, this can lead to some devices in unexpected
> state.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


