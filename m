Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3898C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 04:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C55D5814A4;
	Tue,  4 Mar 2025 05:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TC6Zt/Xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A818081430; Tue,  4 Mar 2025 05:42:01 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5877D81335
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 05:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6f47ed1f40dso39905237b3.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 20:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741063318; x=1741668118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PUUCMKkXXGbh+FUqQ0OfQ45+5Ps7uiG6lbb+zWBSn1g=;
 b=TC6Zt/XuqnLEB+9zXqr9NtYQu3H03KavOBiW4ZNrauw9iHaZv4MwR+fw2/BtTSwFkB
 sa7QeXjTL0ODXDNow9XC01lkSdaX8P7rD3mfkXlY9ekhC443fJCUudd/iZ6zLFSZlyuy
 kWO29BPJX/EMjzTvQBSKadz9ZfkOw2IiKZGnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741063318; x=1741668118;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUUCMKkXXGbh+FUqQ0OfQ45+5Ps7uiG6lbb+zWBSn1g=;
 b=BP7HkGwPpU7MU3Zvyr4nJvDEabObamRoUXdH8Bez58mJPo9GvEvNTuU9fzARIfzBbX
 hOwiYi0FfhSeafSDrqBazcvTNA/0uYvWe+TF70Jx26PnGo3DGmbaiB+B/8xlxftwJBRe
 fMef5XcxsKxh90LYNZnCHYM0zVAiVRF9K6nREsj8MZ2Qx1map95t4SbDIefVYZaZ4cal
 PjhOuRInHkfQ0pp+bfDBvKQ9La3QcL0eqK3TDTNuYvM8BaiJby/s8Quc9CbIUooABEAM
 wmzrPoFAiS5/IXv7SQo76JSzVLQn8SgD0XZP3Grl7Lkn6Y9EUPjKZwE7TK2l90mrniPe
 qhuQ==
X-Gm-Message-State: AOJu0Yz5wVEbp3TxT1JTtyZIt+82S8TtAY4zR1Sghhc9ipghPO6VkcNh
 GMKHCxXkGm6pgGrSwCohK5CAROaXMSkUsvSPODHhdfp6LMjnk5Srb3kSqvBBBPc=
X-Gm-Gg: ASbGncuEN8UUA0HkMJ9ztAJFTWPo2HwPQcZ27vRi4gJEmnc1s3Yz73QnufpHOeodbjl
 FULzuXEwaNS1eV3G+VfAq6snLoc6L/1SQwdQiHrur7QyLijht91pBjc/XlYMlJWNoe9VE87FqoH
 ImQ0Ox/luOwIC1jbJVz4t3fYbntpSQiDLTV5IyvltzCQFF24htKEodMexk26piX7pSaH90LJ1oh
 A0MCbPjSUbdfMm+cS7Mq4QiX78NN84s7pHl/f0sC35CEA7bAtEOIA+Bu+71j4ApESNdUJalA+SD
 nz0CriBIOPuwABRnZDFIUChAwF9eFq26lX4VupmGLA==
X-Google-Smtp-Source: AGHT+IFnbHa0uRjKunSlD5VsCIMGtnj4jUctzMI1ZoGzHTX3cbhle+n2Vr3fImjCStkNn+YxtSHqiQ==
X-Received: by 2002:a05:690c:6f0c:b0:6fb:a696:b23b with SMTP id
 00721157ae682-6fd4a15e31fmr204484767b3.33.1741063318144; 
 Mon, 03 Mar 2025 20:41:58 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca60d57sm23182697b3.51.2025.03.03.20.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 20:41:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anton Moryakov <ant.v.moryakov@gmail.com>
In-Reply-To: <20250206214758.353228-1-ant.v.moryakov@gmail.com>
References: <20250206214758.353228-1-ant.v.moryakov@gmail.com>
Subject: Re: [PATCH] lib: ecdsa: fix prevent memory leak in
 ecdsa_add_verify_data
Message-Id: <174106331644.1753567.4740910842414947988.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 22:41:56 -0600
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

On Fri, 07 Feb 2025 00:47:59 +0300, Anton Moryakov wrote:

> - Ensure `free_ctx` is called in both error and success paths.
> - Fix memory leak in `ctx.signature` when `do_add` fails."
> 
> Triggers found by static analyzer Svace.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


