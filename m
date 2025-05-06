Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA8CC3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 22:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8B2820E8;
	Wed,  7 May 2025 00:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PfeuczE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0622881FAB; Wed,  7 May 2025 00:03:03 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D904580050
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 00:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7301c227512so4356017a34.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746568979; x=1747173779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ae0ttNf+WO2ybW+HJbhmRjfLKvz9xizYAVeVnCvTz+I=;
 b=PfeuczE2R8b3y0o+krUOaV/4HFf4piQ1t3DLQD3RWpkYms04pshAz7BUmE0oBQ1qkP
 3jLxrY96o5W69yZSyLB2xS0Hg0N9a/x5G16Qv6qaxzUOMdFN26qYcPqzWQMdD9CLP5xK
 /1hEL24lw99PH1NC7QnzxJbkFvetTS2LGDA2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746568979; x=1747173779;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ae0ttNf+WO2ybW+HJbhmRjfLKvz9xizYAVeVnCvTz+I=;
 b=Qj0UHOXsWitorMvl+EOHmodJ5FTqi3PcHLCbQvRy3/c3iIJKEW7m/NmQiFTahglexP
 vBGHhdjimqOgAGYum8oW0ADgVV/WfEvl5M13rS3UeDXQiJTlUQLB0xDT3Vn6avhrMvXg
 4PJ/pf8OUWsLdz+C4oZIwZmrYyZOwW/GWQCpadLa7SUdSt4Li69j0Y8mEcxHZU3D+hVM
 I/MT6q9MqHRyFiDHJyjXignFDNqS/ywmPjMZy4XChBb1nx3CtrGBrKqm++ueqfv9qs6B
 24b3Ab8okaTmQ2xgfEmO14bPScktucyYRGjtHSAyJa9/056ohvY9RgtXEqohD+++/87a
 e5wQ==
X-Gm-Message-State: AOJu0YxzvjKqF5MoZaQ88XEy+rtK7xuiw90+mN4/xf5leK5tc/Zx/t53
 WMy9OCNA4vcQmz8BOmyaAG9J5LV9MZoUY8NAdJ4PscadDZRVX9cqsUgIPLAXxoDCsQjSJBnMUth
 +
X-Gm-Gg: ASbGnct7sTih2jtVfjuUsslY8ISwWaTAXZWDMZHbrC2us0oGanJT/sZlSK68hnrhpwt
 5GuAJTf3AUiFejOi3L6t2eBIZkjwCHzcday0xy5bXyLhmdlaxlEwr7r4ZzpUcMJdKuzSdDiAHbe
 kEYxrt8j/Q26+YeRaHAvIE8/4NL7fScOZ8YpehsIFo/CXUVTjKMVTCidGPoSadKP4jECiak5zQb
 b36qby61ZuiIf4cK1Bde+GQl0ewHn7YP2Vlb1T5zR9k7efyIQ4rvbXiKdKybx4kRxNwfO+GU/dI
 AxHNCUa6qyqSojR3Pm1r6/2HupF+/UrBZz0gLkS4x7ZmZW6MFMitwibM1SXEso9kfq19+QxKEqG
 t
X-Google-Smtp-Source: AGHT+IGWY1hGZdHftc8rmUI2v3Ki3xyp8+ozw96vVzv6pin7unQvuZzJxWpxTd3AW58oH2NZ9qYWUQ==
X-Received: by 2002:a05:6830:61c4:b0:72b:946e:ccc7 with SMTP id
 46e09a7af769-732109a42afmr712041a34.0.1746568979573; 
 Tue, 06 May 2025 15:02:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73210a1b343sm143796a34.39.2025.05.06.15.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 15:02:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Aaron Williams <awilliams@marvell.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250409-octeon-middle-expressions-v1-1-fd6248e6975d@ti.com>
References: <20250409-octeon-middle-expressions-v1-1-fd6248e6975d@ti.com>
Subject: Re: [PATCH] mips: octeon: remove unused middle expression
Message-Id: <174656897875.280764.3207207466128336547.b4-ty@konsulko.com>
Date: Tue, 06 May 2025 16:02:58 -0600
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

On Wed, 09 Apr 2025 12:26:20 -0500, Bryan Brattlof wrote:

> !A || (A && B) is equivalent to !A || B
> 
> Drop the unused middle expression to simplify the statement.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mips: octeon: remove unused middle expression
      commit: 13d1bd5bbbfaf725a4c159851203d658c1de83ba
-- 
Tom


