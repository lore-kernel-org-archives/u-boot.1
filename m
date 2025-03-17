Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F3CC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73E968122F;
	Mon, 17 Mar 2025 17:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Synf5rnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A66AB800B3; Mon, 17 Mar 2025 17:16:10 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588B3810F4
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so3422806276.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742228167; x=1742832967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ueecszYArYPiwl+LUlw/Z8otM0MPwtU9V5oRrKyj54=;
 b=Synf5rnqBBXkwe3nKtV3UKUPrVLZziHuRlpW1bTPz5pqg0KYt+oMyhep/NuTKZeUvh
 Q1V7UuVwd/I9otEAAPqValrCgTFnaCenMvndSJRRX1L4zH+aeDH956zQM/yV/9AS7y5B
 1Qrd793RC2sFNcIiZYfHg8NjcdqXLVNPPzQJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228167; x=1742832967;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ueecszYArYPiwl+LUlw/Z8otM0MPwtU9V5oRrKyj54=;
 b=nN3r3hSQ1eJ/Q4hvTtj3iD5kaAPhfuKMEUalxWm0wHTgByFN07Nm6qgSd1Mfxb1KUx
 xw0GE7oz2ObgAbkgTZz9O1S/0yuDibIr0lE7jl8cUn6QhJz9sifxdPVPnkzp5JGLV3sY
 j6SOzuoLU3Z/GjApIL+rLEtcRVIUMNTCu/MBjhrRzhct8LN0aXI998RnCqOHAZEzYGr6
 RZxaCfZ2b8UN15KH27i+8P3Ft9pCLr/XTc9FKb/eVdEKWnXcIHMXRTIg9oH6LxLNoNyB
 iXKFDfhUpFo4PEuFhf2C/ToueqqZ9JiO8Xdcz5p1znc5eWGqjV2nDM5VdQocLWzGCGWJ
 z/0A==
X-Gm-Message-State: AOJu0YzibAHrwz5lJXb/jCqso4xj4mhXfWRa01MOnN4X4s4IuCeDD2sR
 I/roAOhiG2Nsz1LQ9tekvupBsNrqlWggik522EzjySsZTwDa0c9bRzIdkVku4o0=
X-Gm-Gg: ASbGnctnkXChx/9Hf+UopbzNNFHUXBNKtPPeiK1N//TALRYEvAuT7mcKMJZnOA4hgzA
 AJimSByhsZve9GiNZgHFBUnDDJkZTkzFyiZh/qa5u9k/a8WRNwY2NCrrNap/RJeSmHC2Qj0E3H/
 JrtVUW41C5o8q+5hT0lY7pRdUrGRTarW+uy3LLFa1n/qjVSf2QGVZp9vfo4kmmSPx8eWoT0koel
 v0hIU/L/q1PiBV11CrJ5ppyZg7P1Rwxa/n4Lb5eBA9ALAjKV9awqWG7j6COvXpBos1ncE9wxLY0
 5rnFAgcucm6m2E7inqXy4Sr6A9a8owXTLAZYrCq7KfrL
X-Google-Smtp-Source: AGHT+IGECHugZ1IREe3ZjUxqPfDWM9XyTigOxmKtafygwWLEPN6KjY/JHe+FLWoQGwh4lnzLvdAZ7Q==
X-Received: by 2002:a05:6902:2682:b0:e5d:f878:7b50 with SMTP id
 3f1490d57ef6-e63f6534ebemr16341697276.23.1742228166495; 
 Mon, 17 Mar 2025 09:16:06 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e63e50d2b6bsm2322155276.0.2025.03.17.09.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:16:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <18d91439-12ba-41dc-8cc1-763486cf5143@gmx.de>
References: <18d91439-12ba-41dc-8cc1-763486cf5143@gmx.de>
Subject: Re: Pull request efi-2025-04-rc5
Message-Id: <174222816528.1613115.5188893861542269404.b4-ty@konsulko.com>
Date: Mon, 17 Mar 2025 10:16:05 -0600
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

On Mon, 17 Mar 2025 11:45:23 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 15d6518c942f0da13f9a7ceeadbd925c3317ec8d:
> 
>    ARM: dts: imx: Drop bogus regulator extras on DH i.MX6 DHCOM DRC02
> (2025-03-13 15:22:48 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-04-rc5
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


