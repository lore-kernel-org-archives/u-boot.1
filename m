Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB106C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4970D88954;
	Wed, 24 Jul 2024 16:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gQ8XY5UY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AAC988954; Wed, 24 Jul 2024 16:38:25 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DB48889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5a18a5dbb23so17288a12.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721831903; x=1722436703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jUZycltVFw0uTy5tzU5Uyjjcfz81k0Dtnr4Q4lPVVfM=;
 b=gQ8XY5UYPtaCeYL1aQagCd62sHJ37wVU1nxSwT78BWWfCSefdQB03ltvmsz4Z8CK6H
 3Z8ciUOIBlYurOhe2GdLt4JJWG22/2gOr1cV9OnkkqXYu0Jwb4PXukDAw1wjHaDnXR9t
 zc9rnyc7LeLfPVtslZj27DYAxwrudNMvJNEBERvM/OHRKBTS1wdn/zJ5ZP9xfxRgmz8s
 4lfsnLi8l8JwqFFsKx5k7chMo8LIucT1eCRQJCq6nS+JKZIJzLcBVqVpTP65e6LxlFEJ
 gq99wyMIRVTMIDMV8KxWhH1Hp/qQmRgztevTiRUzurhVT7Vj8bJ5Xol8u1e/UwPzjrT7
 IWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831903; x=1722436703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUZycltVFw0uTy5tzU5Uyjjcfz81k0Dtnr4Q4lPVVfM=;
 b=YXzdNp0a/D2yMp5L7sXQ3DN2RUP9eD+G1nPxXQ6+687X48czzA6JEXizu/IlbH9Xic
 xZAmNH6f1+nsVchpIqWDVjefmH1bmxTfhkh416/0sanDJxkM5XYTZG0FvokHH0nBSALm
 EDMH60O9d7/QmLDXCZ8fG/gfqyVLlRxbqLSO/xp/dJmG9YII3jBrtAlDmv2pOkW/0UKQ
 uT3giGEVqOn6GcjtoRO/Vipj2/BqpATFE5N7h/aFNb3kWOjefpI6+UolvwUHyDDvq8hV
 wEgMqFzijFakoX1bdQQ4UY3P1q+X9gVe12ByDrGo2vZEMeGIBCdfTsE7i/0XGqwLUzGm
 ObWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVONfF24qIC2mU5jUf//qSgwXL9ekn50QPkMCuKkB5oxGWI9HcRH5gsvQh22ps1PtAUzWEqRpt+HQif2k4hwYLAiqYGnA==
X-Gm-Message-State: AOJu0Yy3GEbQUC/jcSxlNhzG1fkntzcRjhMUB7hyabecSn5WTg70+Cu+
 /vtIIkfJPHYhJke+R/JpwNz7e2lPS2OYeTGkZHZXhYFy5gXbxliU9QY5zalBuIiRJrzv7eUkmGn
 8zh1m5BpYnloiaGWjrYaTP3UgVFNbONBXE+r6
X-Google-Smtp-Source: AGHT+IGFXACGCrilHck5cs3YK086mydSfCCEkbeiNFfiWp2zxzOV3mtsvdUMhDWFwLntmDA0PVNjPcOqxm6ZvVyBX2Q=
X-Received: by 2002:a05:6402:13c2:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5aacb8e3ef4mr318507a12.3.1721831902714; Wed, 24 Jul 2024
 07:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240724-bcb-crash-v1-1-44caff15bce4@baylibre.com>
In-Reply-To: <20240724-bcb-crash-v1-1-44caff15bce4@baylibre.com>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Wed, 24 Jul 2024 15:38:11 +0100
Message-ID: <CAOWkq4ktZPYgChGT0z91PsqFfeCcDD3fAEqnCAYjLQTVS6u=kw@mail.gmail.com>
Subject: Re: [PATCH] cmd: bcb: Fix segfault on invalid block device
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Schuffelen <schuffelen@google.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Reviewed-by: Dmitrii Merkurev <dimorinny@google.com>
