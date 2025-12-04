Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E88DD2CDE6
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA9D84144;
	Fri,  5 Dec 2025 00:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b1yUY3aJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D73A84144; Fri,  5 Dec 2025 00:10:36 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 627BF84129
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so1375014a34.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889833; x=1765494633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQ2R6D0viQ2G2MLXPhtn1pQD1araq8aLw1lhEVXovEM=;
 b=b1yUY3aJOHXtaLkBYijCgx2TdTa6WtEHC3jr0ZnnmsuyzZ+qbOWJOsS+LtwNtHyeYb
 9Jh1uroekl5HqnAIJM/HO4BoBiTjvA7Gtcv5KfgjK98IHCCIkuyH3DfhYaZOa1C/cQJk
 APvUjcGEYGKjxVNYHAO6JP1ZGIsLa9EigkdFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889833; x=1765494633;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rQ2R6D0viQ2G2MLXPhtn1pQD1araq8aLw1lhEVXovEM=;
 b=kicY8oWDrxKg6Ytj/zh7ZM1PhkBKxRTwz01oEizMi953bS8Ybdtfwo+FrK1grjh3fB
 /dU+avbLWJxuWHu8Mo19O8xUei1JmXrta00GQBX7+HNkk52q/kir0cGNhysfISDbadAi
 UxAmPTF+PTiXF6xeeWFZxI0VxtdyVOZfN/5YfBp959vkSBcx37pKrA3kIY811m8h8VWx
 6kPayxc+y81zjiALus/ZpLlpLoRgQ08GDI65DzqhqGtqzFC0lcRy/XD1Lihd5JukMo9K
 huOTO96lpOZTk7YJTiiP7DHquH+tA4YVRUwnQNisBWiuDdEYtR66HdBiJqheiwHfM1ph
 nqRQ==
X-Gm-Message-State: AOJu0YyMfVQ2SKClwtW/EkYdesuwEdu/arZr6bdXGtx6xRR+9J9iMc4A
 SJMFqTjSVHI3SYVA5/2FASNK9tRogfodgfoySHrkRr/jsUervZGBXuBCP8NZ+L4fql8=
X-Gm-Gg: ASbGnctYjru8vVF6MFHR4NghovkIoU4veNEB70DMjrb75Nh5n7WSlHH4Oeb8fixVtkI
 kjvHd6sOLi+ATHJN2eAGJCd50wgccHaI5XTaHSdeBOc3bN+ozIFlk11XTiDU8xKQN4uFrxHH13k
 GO/bU/8fOI/AgODc+juyXD+0dli0ro8p8G+Rp5L70IwKHPXmBnQWIqwjOUffC+GMun/GZok5Por
 6X7escup+wCBk3PVzUak1xt246OSrRPJHHUWe8qUFBEPOlwr6qKBHvLzIOKKFnkmiRdfEd48aOk
 GN5oXcaL1Fmc86E+5VHVeH7+iCz5xXFm0u9ufmloyh9Xswbp8pMS5Y7Vj+uvm4wVdNYRDsZUGI4
 v+tOMDErHdp0wOC6bUdbYfaJNrH4OgYNTVY+UKhq1n/KZOd3yFcPuzwkJJq0LOYnCseiQsuQJpd
 1LtentUGg2Hig7X1ZN8B/5P0D0biKr5nLFEg1cfopyd3UM54Xq
X-Google-Smtp-Source: AGHT+IFdcssNVPblvThIzO67CBk9IiUuIG/mLiyz7cSv9klg8dOVHNXqIzBxhloAaPI+bcJdhCvAUw==
X-Received: by 2002:a05:6830:4102:b0:7c5:3013:e50c with SMTP id
 46e09a7af769-7c94dbb5e02mr6370828a34.33.1764889833233; 
 Thu, 04 Dec 2025 15:10:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
In-Reply-To: <20251119145517.843161-1-trini@konsulko.com>
References: <20251119145517.843161-1-trini@konsulko.com>
Subject: Re: [PATCH] qemu-arm-sba: Stop disabling device tree relocation
Message-Id: <176488983221.2091996.9752974798338480981.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:32 -0600
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

On Wed, 19 Nov 2025 08:55:17 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] qemu-arm-sba: Stop disabling device tree relocation
      commit: 8d247f3e91178f048a5824c0061bed03f7a8fdf5
-- 
Tom


