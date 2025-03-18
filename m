Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB93C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67A2F819B1;
	Tue, 18 Mar 2025 18:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rTTihYF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F3F8197D; Tue, 18 Mar 2025 18:02:49 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC308191C
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22403cbb47fso111713155ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317366; x=1742922166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ep2rq5R13bhB/WgloilzUxvMdfIRtFjFIn98tHDirjY=;
 b=rTTihYF6EfcMnpHsyhOP7uKQjIXDa6i8QgMP+dWGT45fdASqFK5QEJJWW8rNaGR7Zu
 ijvJ+1NvkZZgcwDcDdgmpfhp5cnt6p4TJ9oyhBye+1uKusNS+UnnTEc0kH6dNqZv3BFj
 2SkpExVN8j4IPooizIRy6BGpzG/eiJ7w4RhwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317366; x=1742922166;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ep2rq5R13bhB/WgloilzUxvMdfIRtFjFIn98tHDirjY=;
 b=MXCI4XZD7M5OcZF6H9jU6pM7V/dIy7w2w84ZOuPnZTCPshIsq3lYaXNiRSUn1tEWUM
 oHWxKmi7g6O2BLOXFqWloc0K5o3Vl8VpenV6GPEqcuAymENndhG4letoobO8xAYHo/LI
 xokQ2Cxb1GgDi0c+1Mm7nXqKwXUpNwkV7RQC3BgvhhiF+HnliPu8WGdvtz9MmlM6aT3n
 2Gbi5veHfV2JGdLpBrNJL7vJSt8lGIUFuhy5HGu6kiJ0zFNBLNHDP5IuiMNfuKbOV4SY
 leF6LxATt4ckG8fvbed0GaF4RjezS2BIfDgY82zq72lfAnT7uix+Ipal78XAIPckAvJk
 eFMg==
X-Gm-Message-State: AOJu0YzFBHk3Wys74yaacEbOn26WAznRjZ8ocQhAJVF+WHJngz3mxLVk
 CXMULMiL2TJobaSJLQbe7ApCC9QxkR0p4sGyY/ruTSdvpG3VXX9mRw0Kwo+XWt4=
X-Gm-Gg: ASbGnctwc34Zc2RY43lPSdd9aFwFdJOU4vMAylgmTou+3kAb5uARVAtVbexOphKCdS7
 BtyyJY9i70/6bRcWFQnBwwrBc1jS2DY44PHzNVGaY2dzO/m01E/NOdxQFe0LNh9oN+E5Z2UQ9+1
 p9a+p3n8S4inGNHThkd+E6ikkh286FQ1BQ7nzDu9k1D7eZXoBaU8lrm1qJ1YPdmwsAjCs98Lnw9
 sVUepyIJ7b1infMZdM8rncfgRf5POkWHEZ/wxfzUTag+fKmZGiNSj9exD5v4jJFQ+XbIN5IVBOc
 PMKwKe49pxBaAJAgj8Q45hXn+aYZN3Br2goex0LWYoLg
X-Google-Smtp-Source: AGHT+IE/KcdcpgwzCPzjtGK11hP3eNW/xnnrIslYItb/979Rhm4yj8rEWQ/jdBex0FpbBzEHIf6utA==
X-Received: by 2002:a17:903:1a27:b0:224:1af1:87ed with SMTP id
 d9443c01a7336-225e0a8fbf0mr235185715ad.27.1742317365614; 
 Tue, 18 Mar 2025 10:02:45 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4e0dsm97501595ad.221.2025.03.18.10.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:02:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Hendrik Donner <hd@os-cillation.de>
Cc: sjg@chromium.org
In-Reply-To: <20250306201540.127646-1-hd@os-cillation.de>
References: <20250306201540.127646-1-hd@os-cillation.de>
Subject: Re: [PATCH] checkpatch.pl: Report an error for CONFIG_xPL_BUILD in
 device trees
Message-Id: <174231736457.1761706.11288258778698456041.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:02:44 -0600
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

On Thu, 06 Mar 2025 21:15:39 +0100, Hendrik Donner wrote:

> The defines for the different build phases shouldn't be used in device
> trees, currently they aren't even defined for device tree pre processing,
> resulting in build errors.
> 
> 

Applied to u-boot/master, thanks!

[1/1] checkpatch.pl: Report an error for CONFIG_xPL_BUILD in device trees
      commit: 69fb899133b6c374eff11b13482371bec6898a01
-- 
Tom


