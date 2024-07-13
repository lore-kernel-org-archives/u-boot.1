Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E496C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 14:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2243887E7;
	Sat, 13 Jul 2024 16:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TW4WHFQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BBC3887FA; Sat, 13 Jul 2024 16:38:45 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 735CE887D3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 16:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-70361c6fd50so1471370a34.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720881522; x=1721486322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3o48vOLnlgz6zAzVzQN8LAsLfCKTxvM2FO0BZMv5Zk=;
 b=TW4WHFQMTq0KTYmN2MerbXIB4G6GAIS1GZekoRzl7ZkdwQbSUwVB6x4VqHikGpeUJl
 srUaHNUqTMORwC/ri2Inde238ZVlpLIAH0ZRl/jre3V94qDJir0N/bjEXu++BIJOUU56
 vC26RpKbT+mSmYuQGAUA3xsjUKvxVeJ0/M75M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720881522; x=1721486322;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3o48vOLnlgz6zAzVzQN8LAsLfCKTxvM2FO0BZMv5Zk=;
 b=REgtgw9I7QzSa97aylrB6eVXa8MRhfYuZg3nW9kqFTo1Y0M+0tOTu98xkshPdiXh9s
 6U/LVq4LXiS7T2b4CuumzV0zE7G4nAKbb8TzBkfJl1n8l7yOgdsMmjfwoOof3OadCqdt
 bdiU7avO4n3jLmfZwMa8Y3sLomhCwfH7wMmR1h+sWtGEWVYIz0lNQ4iV78jGzogbbJkh
 XXiOIGVcetxu6EvFgemNhjkzwKqvxqDkAmB6Zl2y5eptCfZB3XISVtTR297l+B5/ncmJ
 6PQ4D+w2JDzcq/nIIK7fgeB+ZvcFdHf5ECKo9vCMpaZ2A0dUtRca+Ng3I319SolPtr7i
 gDHA==
X-Gm-Message-State: AOJu0Yyd0q2NnlNAAuECJ2Wn1dYYtkZ+RAim7B7yWdRHdljhewA6ULn8
 GLgJV9PjImn8/wOA2sj+1Dw2W2szcqLkf2ZqjphSepjDZuBHOAyOCYvbKy/5Mj0=
X-Google-Smtp-Source: AGHT+IFGY0gDLLAk2r7ullkI+F+KuW5blLpJPopH12v6oDP95igQygfGqTOEl29DD6yJ6+oIJlGz0g==
X-Received: by 2002:a9d:6852:0:b0:704:47dc:cd22 with SMTP id
 46e09a7af769-70447dcd2d8mr13429695a34.25.1720881522150; 
 Sat, 13 Jul 2024 07:38:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0c52c84sm264463a34.7.2024.07.13.07.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 07:38:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, =?utf-8?q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>
Cc: kabel@kernel.org
In-Reply-To: <20240606163326.386950-1-marek.mojik@nic.cz>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
Subject: Re: [PATCH 0/6] Add Turris 1.x board
Message-Id: <172088152161.3049814.9131872605543695712.b4-ty@konsulko.com>
Date: Sat, 13 Jul 2024 08:38:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 06 Jun 2024 18:33:20 +0200, Marek Mojík wrote:

> this is a continuation of previous work by Pali to add support for the
> Turris 1.x board. As the patches were based on u-boot v2022.04, a
> nontrivial rebasing was needed.
> 
> Some notes:
> - Some options that are in SD defconfig are disabled in NOR defconfig
>   because over the years u-boot grew and the old NOR defconfig will not
>   fit into NOR memory.
> - SD boot with RAM larger than 2GB will only allocate 2GB of RAM (We
>   were not able to fix this yet)
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


