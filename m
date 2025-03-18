Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D57C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85B48193A;
	Tue, 18 Mar 2025 18:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q5ezU7fA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DAA1819AA; Tue, 18 Mar 2025 18:01:44 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 247B7800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-301493f461eso4091498a91.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317301; x=1742922101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9bfzlLatioUol3pn7DJSZuvLRbFRjqgbj4GV5DAGZ0=;
 b=q5ezU7fAzu5UKhg/v5f6S4ocViDQO3nqkO7ZUb2vmRfi2p7+EJlN0oR8nvRXnzcTgK
 zZHrD13w4fK/z8/V266wMZh6MparaecWiQk/RI4jr3PZtgLQBn//Ed8HENZ0CSfwU1Yx
 GfSA8ibmtl8j1vRvzdhQAQcWo5MJZoU9aK/j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317301; x=1742922101;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9bfzlLatioUol3pn7DJSZuvLRbFRjqgbj4GV5DAGZ0=;
 b=JvkWDW0HIsxR39gWggJr1rIV8JgHzKs5XQHRHiwDixbAY74zJ4SCAEukU8CJoj8uYT
 cF/Fr0pF5YT9liXcEbn4tgs1OSYEswBhFQPlxAhpOzXNrvWuucPM1koFWNpDwUkm4coW
 rgPtoJNsagokSgOVNZQpJ7JTtAo4OOmjIqSUhR8Np0P8ZmaRCgL0DlwJqrcNFMhDQAbZ
 REFPJm8Ugg/vAYO5t+OYS2Jyq12Iw9w81Nt8Bnwa9Sq1+IXfiFHVP4Klo5h9fzQPRBGZ
 CS5FbV4B6syKbtw1OoARIyQGFHDsk1edGNExrTtgt+gkwxpi4F32rqNn1xJKMEXsktvA
 qf7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0CfBrg+sB2m+g6tzSyoyl/r3FlCVkl4c2yFIdPk5bAxiA9rl6sJoRUP74xn0LVj+XR0VuHTI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2el//P0tBdXJJu43F2IdaY39OnB5gX9rK3LrI+e8oUiMBWCA3
 qpfm2z8DfdfOpKlE5Z2sn8WuOjBNTlUv8GWQagy9YYKSC96z1T85a9kziKr2Geg/+39f+fp3mDC
 P
X-Gm-Gg: ASbGnct1WZkbWmPesIi75CTe6ATsAyulGubyIaFxW6nZYSAhpxIUcYIV4aK8Zef+umY
 0mWr/6nCHPhPHiEX+stQFkXcHhmRIC3xlZcEfryjyvTQ9ZBvKbI4jjriHGdVeRRSC1ZrpYopKDo
 tCof8zfwFoljuTtrC6aQu8fAPhwrIMyJZoxxu2cV46iDCXyhBzjQ1WBJp0Mwhn3Q7VTN4L7Q9H2
 XX452VjA2ll9b3EtwjzgDsOkh6bNApevoY+MKNLktIsyXNt/nhvE7U3pH+ENmdFsyKAtCIg3qMf
 4UuPlPYROjDsDsZyg7C9oNBzoJMfgd0bLp1+FjcrkoCs
X-Google-Smtp-Source: AGHT+IGOBwjnliEstewdVJvLg+SYVT4cVDF9PkK9cmzBxyYC/lWjHbdajEchIxOuqpM9seoAbFmzag==
X-Received: by 2002:a17:90b:4b0b:b0:2fe:9783:afd3 with SMTP id
 98e67ed59e1d1-301a5b00731mr3998876a91.2.1742317300621; 
 Tue, 18 Mar 2025 10:01:40 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3015363273fsm8458551a91.34.2025.03.18.10.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:01:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, u-boot@lists.denx.de
In-Reply-To: <20250304165204.53097-1-harrison.mutai@arm.com>
References: <20250304165204.53097-1-harrison.mutai@arm.com>
Subject: Re: [PATCH 0/2] vepxpress64: disable CRC32 by default and add FVP
 with TF-A guide
Message-Id: <174231729981.1761337.3280576575728409584.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:01:39 -0600
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

On Tue, 04 Mar 2025 16:52:00 +0000, Harrison Mutai wrote:

> This patch introduces two updates to the vexpress64 project:
> 
> - Disable CRC32 by default to prevent aborts in a standard FVP setup.
> - Add a guide for running FVP with TF-A, providing a clear starting point for
>   users.
> 
> Harrison Mutai (2):
>   vepxress64: disable CRC32 by default to prevent aborts
>   vepxress64: add guide for running FVP with TF-A
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] vepxress64: disable CRC32 by default to prevent aborts
      commit: 1d41f7afdf17c45ff8a6853742c9a61b371b73d0
[2/2] vepxress64: add guide for running FVP with TF-A
      commit: c4b48b0a6b72e97842e87babf432fee4d3a2bb39
-- 
Tom


