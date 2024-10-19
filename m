Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D8D3E19B
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 02:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB7788E8C;
	Sat, 19 Oct 2024 04:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oaFjWBtu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2822A88E8C; Sat, 19 Oct 2024 04:21:36 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E621F88E33
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so15513216d6.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729304493; x=1729909293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJUMvU9sK+zD8fgaqq29VwB2S3sL9PWfqfJ5ppnCS7c=;
 b=oaFjWBtuB5qdpTHS9gPW+ykdpSHa4O7d057AM2tN82bNQ3PpOIojagh0BNWeJeuSDj
 Cs2+ca7MFnJu9EHBpmSx0oxOoDjkKJ5pR6+hU95/EdO4TZcURqDMAkXRXKjEbFzlhzBP
 DoM2CjEAdZsYo6Z2BDZ2JfsqACC2rjN3u8dwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729304493; x=1729909293;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJUMvU9sK+zD8fgaqq29VwB2S3sL9PWfqfJ5ppnCS7c=;
 b=loMgEXBVxspfoIQBMlo1XsNBoYl154dnX4ubV6k0aCJf6tr7q6CbBdT93L2fir9J1I
 qeGKApKr1FXxaja8hHSzXucQSxJ4W33xqHbx8XyCuAdftRIWRuH5H4PrGgKFV77/YSpw
 gEEf0cNenU3jf5McTe4XJ0LvgaM3ZjUYIzwIaf2Nkyw694wpjrMIC7PRITGLsMtJqKSZ
 MuvIZ4aRt0N2mbqRccQ8OVvEkZGRtS18fFS5qKObZR797snhu9AcnISPP0WfsBN/aeyw
 SJRcWzpfxTKnac42YAsZGUS6OSKCaIfGpDe9h5Tj7sOTGF+V05wenlfx1Vh4XBzFMykY
 ajkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeFKsmUdGCzYytUy/1/Zf21wcTm+P5gGQ63MW4rE+YYSIGT1xFKJb4sYxDh9S5d7NRmepnSo4=@lists.denx.de
X-Gm-Message-State: AOJu0YwSl6rP/nti9j5cUVXOhHCTJFzoSaW1X1ZKYfRa2/+bHDEDj4Al
 d75tw/L/gyBVzChtRgsiVpUdVym6eAn6J+OZaDiv7G3sIar2V5T7KegsVKt+veY=
X-Google-Smtp-Source: AGHT+IF/5dtlAV+pZX3/rIQWWtkOyC9XlLGyWrqwAcwGCfaO/LJjB2aGjfSAK72KIfARn7W7bJN4uw==
X-Received: by 2002:a05:6214:4a08:b0:6cb:4c1c:508d with SMTP id
 6a1803df08f44-6cde1532664mr66932266d6.28.1729304492694; 
 Fri, 18 Oct 2024 19:21:32 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde138fde7sm12521016d6.143.2024.10.18.19.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 19:21:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241018135112.3978130-2-caleb.connolly@linaro.org>
References: <20241018135112.3978130-2-caleb.connolly@linaro.org>
Subject: Re: [PATCH] lmb: notify when adjacent regions are added
Message-Id: <172930449018.2505436.15632003283722582856.b4-ty@konsulko.com>
Date: Fri, 18 Oct 2024 20:21:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 18 Oct 2024 15:51:07 +0200, Caleb Connolly wrote:

> lmb_add_region() returns a positive integer if the added regions causes
> existing regions to be coalesced. We still want to notify the EFI
> subsystem about these added regions though, so adjust lmb_add() to only
> bail on errors.
> 
> This fixes EFI memory allocation on boards with adjacent memory banks as is the
> case on several Qualcomm boards like the RB3 Gen 2.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


