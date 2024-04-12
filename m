Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AFBC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D6C88221;
	Fri, 12 Apr 2024 04:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jD3Eogkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5017588225; Fri, 12 Apr 2024 04:12:47 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42BF088005
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 04:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78d743f3654so32062185a.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 19:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712887964; x=1713492764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggbKJXTyxofvdwje1YhOIxBv3s5qONbeINxL435KOgk=;
 b=jD3Eogkmlita0WaO0a7UDuSCXqPxHS+WIe/HD5ZZsX2GucEpfvjlnjP2bqaF6Rd/NG
 2TswBBfCDHCPCH3xLu3xNnudAn4C2TuW6T/f2E36FDlP7Ay90B/kCNqENtUZS1xsj7xv
 UNPGchIp57Nm/E3Bxdl1Mp9HToYRe3W6U98M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712887964; x=1713492764;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggbKJXTyxofvdwje1YhOIxBv3s5qONbeINxL435KOgk=;
 b=gLIC/d5lUuXi+6Fmkb4k+7R3Rpeb1RJiPqW3Zn0xxRTZSA0AXrqGWqDpL0mEtRn4j6
 axygvQChuvARwXKeYq0NOFcI3APu80rRY3QlJjEAEX8/r2X/xEsk7QfLTNh+e1pAlTvf
 zyu0oTSieHSV28AI/nKx6CXJHTFiV2M7QmcZ8y/nYNnciAEn52i6Ymss1tRftuX2bCF9
 UrJwHOrQ5/Vlf4qUVhCM8q4zGPI2T9tOh7Nr+SAtgR3nBvwRdJE7Vm69Q3sGAk1N605B
 oPBUKmGv2NQphcJJ34YVnSg1OXCYe0R/Ofkn1bNpN85rMUYG4GFx1My/Vxb7bxJuMSdt
 xVKQ==
X-Gm-Message-State: AOJu0Ywka8etlBxmweLZ/xGUDuiIUDLlx6ro15SAb/h1y0YEUgmqZ2Vl
 KGTT8GpLdhnJ+k/APlSrCbZe7A2TIwd/QCMcGIHcWPRpjHtBK7KS/NjVrsOcMMI=
X-Google-Smtp-Source: AGHT+IETRxk54puefDn9rwOlFwiu6gXD2jzjSs4/THc0Y+TQ9eWl9kdSRf9MgXqVX72+wcmIVp2pZw==
X-Received: by 2002:a05:620a:15b3:b0:78d:3b41:cc41 with SMTP id
 f19-20020a05620a15b300b0078d3b41cc41mr1421770qkk.27.1712887964119; 
 Thu, 11 Apr 2024 19:12:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05620a108d00b0078ec439a9a7sm1348922qkk.62.2024.04.11.19.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 19:12:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dave Gerlach <d-gerlach@ti.com>, Martyn Welch <martyn.welch@collabora.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240326142634.2043539-1-martyn.welch@collabora.com>
References: <20240326142634.2043539-1-martyn.welch@collabora.com>
Subject: Re: [PATCH] am625x_evm_a53: Tweak boot command to set fdt
Message-Id: <171288796307.897536.4071006329109979599.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 20:12:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 26 Mar 2024 14:26:33 +0000, Martyn Welch wrote:

> With the current config for tha SK-AM62, fdtfile isn't set in the U-Boot
> environment. When using bootflow to boot from a block device, where the
> extlinux.conf file specifies `fdtdir`, a fallback device tree is being
> constructed from the `soc` (`k3`) and `board` (`am62x`) environment
> variables, resulting in u-Boot trying to retrieve
> `/dtbs/6.8.1+/k3-am62x.dtb`. This file doesn't exist.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


