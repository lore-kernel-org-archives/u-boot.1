Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB400D3B7D0
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 16:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EAF483A26;
	Sat,  6 Dec 2025 17:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p2zCKFKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D13F839D7; Sat,  6 Dec 2025 17:12:28 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE66839D7
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 17:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so2971157a34.0
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765037544; x=1765642344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bI6zfnkypYBfwCNeQsbe03KsVwxsF22hiiJzoCsp37Y=;
 b=p2zCKFKmjrBR/QIVErfMv8XNC+sGkG7k61MG8M/WFG0okXFjq7jQUjma+h4V/H3NZK
 qYtsrT+WxYQoImJZpWRcQmCQVZARUxdWb5jTbpOHjwbdASpp4KOgcs3hSvX9DHM4DaH7
 VXFY818pHDS3l7og/uFSIjj6PiX7BZg0SlKoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765037544; x=1765642344;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bI6zfnkypYBfwCNeQsbe03KsVwxsF22hiiJzoCsp37Y=;
 b=lgehJuOgRSRCuF2hiIW5qkHn4+UWBVSNIA2u/sahWa9XN/OFA40X1cQ/NoKgPVAOF7
 FiWDVc59VAgfvCepsjcoG6QowCjpVyn0InoyCwB475tNCnWc7Fk0JkEjGU94xaGbNP1f
 e3aoHDvKo54C4evNJDp4vihmIqUY2gxELyuynpJccko0Heht+sb5Efsxi8ty0dBjJLeW
 VjeP7wC9y9NxZBmsbVVTznbM2T+TCAJQfYrmQ7lcrQBdf9749gpShQWlrL5fLB7nrC7D
 U7qbbcGRnd1F4mXYpTyviqN96JwR/v4E3Yn/qFByGyAdHBFW4biyu5/wwM6qNjPBSBG6
 h82w==
X-Gm-Message-State: AOJu0YzfGctEBxtCH8MQeTitTszXuXvQrQ8TIlgC/D1XH5RJPo3wphpT
 E+gCp16dRSRnr7T37l5fuVRdQ7c01jI30KxUZsrC/nH8A8pduV72+vcFX0a10D59cD7lJYJdTPl
 t2fQ+e1I=
X-Gm-Gg: ASbGncsNF3xejAK2G8eK8ywdmg/VAuXqCshsHU7cY46WnNv3UT66qNtShSlfI6Hb9GX
 xpGhW93qSyxai87BFmbuP3vx0RF9uIoabyXvIdlzmNVVc207qadKk19goojosU1dwiBMQTtTdZi
 5XSaurR2WOhuY4UG9iDgwju9OGYWqb8JQsPJnXDppMcPj+e7FwG2m+clKuEHKIjQIbRl4KfB2vw
 J8z682iUsjxK8mSVaPx9s0CSchS7E5o5bsWhhHXKk38xx6OeuiXo6v6m4CDqK5NbsjVVBkdNBzT
 PuxlLUGpc4UWgEGBxbxSo/DKOSl+s98YpnKB2xUEPoxwz7ul5Ed/IOtFKywoJzIzmhaSVbWsotl
 dtyW19QTCm1YLSwo3j3HU30nJDWC/ZiEhSu8zB8PEXu2g4LNl5A2hBfecb4IsEV2rqfwaZZyazY
 oJ1C0/V5NR8vHuzjRQyEronKSgZcn8JZqI3yg6tAX1qxF+dY+w
X-Google-Smtp-Source: AGHT+IHvEwhxL9CWUB1sYZ0orTMPIRs9DZMI9TKXvqZTGzllkPxPOXcclRO7QRhd9B32ndPzOrbEBw==
X-Received: by 2002:a05:6830:411f:b0:7c3:e07f:568f with SMTP id
 46e09a7af769-7c97076f7f8mr2157317a34.8.1765037544413; 
 Sat, 06 Dec 2025 08:12:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8fa21asm6946180a34.1.2025.12.06.08.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 08:12:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 David Lechner <dlechner@baylibre.com>
In-Reply-To: <f2df6326-f97c-4081-b862-eda657e50ce0@gmx.de>
References: <f2df6326-f97c-4081-b862-eda657e50ce0@gmx.de>
Subject: Re: Pull request efi-2026-01-rc4 for master branch
Message-Id: <176503754325.2614327.8771538036211399883.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 10:12:23 -0600
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

On Sat, 06 Dec 2025 14:35:40 +0100, Heinrich Schuchardt wrote:

> The following changes since commit c98b6a6dcd1fc7bcba081fc2353954e33de5053c:
> 
>    clk: Remove myself as a maintainer (2025-12-04 13:45:30 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-01-rc4
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


