Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA6FD68BD8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 21:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20760896E3;
	Fri, 15 Nov 2024 22:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cioI2cir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3767896EF; Fri, 15 Nov 2024 22:39:25 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B30896DA
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 22:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6ce3fc4e58bso7498336d6.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731706762; x=1732311562; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DrNb9Wkn7bXVIP75Du2rgrOkP4oE6TyPjtPZIHJZAuM=;
 b=cioI2cirBZu7bgmwJ9x3AJ8iitW3diUnykze+Dnq2udL+f8nMnFsk1cQp3MPrjM/6O
 VKHKyjPpXZbX5aVv/RuO6D+kchRK9BwwvXlu6YHbZlMo3ie4Rcr7Uq/lmXgl70zdAw2f
 9dqXaRAUXsD78x8nFGHfnJ/kKgeP1UPXHcKQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731706762; x=1732311562;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrNb9Wkn7bXVIP75Du2rgrOkP4oE6TyPjtPZIHJZAuM=;
 b=JEZsALGVUj4gWjvq5Sb7Gf++lrBUvvQ3yieKMPElTcRbx1g0Bn49hVCrnpjFU3HyVK
 gRPROr4QplgnCvXyoau5tKaKOBB8jU03xGvP9NqqWKJfdeDmL1NebMTWw6c4YoLWc9oz
 Z9Wis2wTrQrgjG/aC72ssQYVgky7hi2ELSnYx6q/X/MTIZv9pdra57dWzXdfJ7Bch3O+
 eTq7c2KnaIp5HpqEikRlXjGfHf9FtM+XU4X3eD14cOcWdHMf0g/AN5XxMznDjcr7cWA8
 dKdmIajgEyFkDEtUpeV4BlSN01Ur/pCWfgTvwUH4J3JhdrMq6AAOJ1HZUEWGPmo+Jmmk
 QnLg==
X-Gm-Message-State: AOJu0Yw/Bt8HUOsm/jgALy8eVtgWM3NmuU67g3FljJ5YTZas49P6ca+P
 AKLIvldB+Ks9XAGtqpzFwE7o0OQHWwY8M0+aUxZ5NNxDfCYliIKEkJDc8/DXrl8LLD1CXMhJ5XD
 V
X-Google-Smtp-Source: AGHT+IFCG1LFXJEg4nSUoneQxt2NOnWnc7NSOtDlhvj+ou5Z3qAK8TYyCaieLz9Mq9Zt7oC1z5UgYg==
X-Received: by 2002:a05:6214:390e:b0:6cb:8364:b0d3 with SMTP id
 6a1803df08f44-6d3fb7a864cmr46304166d6.1.1731706762592; 
 Fri, 15 Nov 2024 13:39:22 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca68b71sm201771885a.125.2024.11.15.13.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 13:39:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Holger Brunck <holger.brunck@hitachienergy.com>
In-Reply-To: <20241114180654.2564945-1-holger.brunck@hitachienergy.com>
References: <20241114180654.2564945-1-holger.brunck@hitachienergy.com>
Subject: Re: [PATCH] km: disable CMD_JFFS2 for all PPC boards
Message-Id: <173170676066.2851979.14741656128876537249.b4-ty@konsulko.com>
Date: Fri, 15 Nov 2024 15:39:20 -0600
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

On Thu, 14 Nov 2024 19:06:54 +0100, Holger Brunck wrote:

> We don't use this feature, we can remove it therefore in the defconfigs.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


