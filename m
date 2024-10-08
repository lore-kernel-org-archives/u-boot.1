Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F154FCEF174
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E2888E90;
	Tue,  8 Oct 2024 15:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JkpGWZFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE6388DD1; Tue,  8 Oct 2024 15:44:32 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EA088CC8
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-710d861eb56so2633498a34.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728395069; x=1728999869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ssVtrkU0XWgRg9IA+9RbfpWXqPW6dlLz4I6DUcL0PY=;
 b=JkpGWZFsB+d3Xd/07EvnQXPLo6jMC5qC9RTwSjqUzLKckxFhEPDsNfhVOszH5AyRd6
 X9T3pgMkypQRntL8+btMgkON6IJ10eDztjSYy4ivcSiSCAQtFkTmBsJFDn62S9jh5dvo
 8ajgwi4hNAXeNlX9q5KkomvPyfQNSdLg6QN9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728395069; x=1728999869;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ssVtrkU0XWgRg9IA+9RbfpWXqPW6dlLz4I6DUcL0PY=;
 b=ro+B/TSm7PGxIuD6b32NYdfpR2jD/PWBQSa9BC+GP6ZypUdA7pXVLpuEbYLhePfIUo
 iPFJmDg+m+37mF+sWHiUFU41icamFI8vmlTHYefI1UFkpEbhc/4aXk8QpOErF9odh4zt
 6AjRCiMnY951Amn7G1WkIhZacErU84utk7cqo9c4SLbyrpNN05yn5mms6+TjdCwNOmIR
 VwsVgTga1JDh1twMPANOOQ1uZ4EH+wLl8Sq0FNEKOZnrRwmrnzx20DB0hxRyNhf+2UjW
 hvn6jlm0fRnu5vGr0wWRBUQJLaGBoJXg21OKQYItNR8eVjnfSm0OXj4hxNhgMC+PL+XM
 K8SQ==
X-Gm-Message-State: AOJu0YyKXL9dKDT6v+V/kUlvgDx67GKFA0iS/QPfnD/X8Akh9VrpNTeJ
 FuOPNN3FaZc4puVVFP0V3AWyGMXJac2/fn/afNQ7QnVWZOqTk8SDclnkxmbriT8sI82N2UPtJ1M
 Rh/Y=
X-Google-Smtp-Source: AGHT+IGMGK2j3iMa4daAJFinIQBhfTiJ5eVzW89sgeJ/+2T9vamaWvFALtwMjixPkoRVwzNe7/XRyA==
X-Received: by 2002:a05:6358:7182:b0:1b5:a060:678b with SMTP id
 e5c5f4694b2df-1c2b7f36a20mr600139655d.3.1728395069670; 
 Tue, 08 Oct 2024 06:44:29 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cbf9sm354028685a.41.2024.10.08.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:44:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Matthias Pritschet <matthias@pritschet.eu>
Cc: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
In-Reply-To: <20240829124447.46451-1-matthias@pritschet.eu>
References: <20240829124447.46451-1-matthias@pritschet.eu>
Subject: Re: [PATCH] mkimage: ecdsa: add nodes to signature/key node
Message-Id: <172839506891.112860.900868185633517360.b4-ty@konsulko.com>
Date: Tue, 08 Oct 2024 07:44:28 -0600
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

On Thu, 29 Aug 2024 14:44:47 +0200, Matthias Pritschet wrote:

> Add the "required", "algo", and "key-name-hint" nodes to the
> signature/key node if ecdsa256 is used.
> 
> This change is mainly copy&paste from rsa_add_verify_data which already
> adds these nodes.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


