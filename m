Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9F5C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 16:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C1D80E9A;
	Sat,  7 Jun 2025 18:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KpbCe4UZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4211C81F0D; Sat,  7 Jun 2025 18:44:03 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CF4807B1
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 18:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73884ccffcbso1729392a34.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749314638; x=1749919438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfEAUxAoZdu3lv2ap8t+Rsq7kXVnuD2WH8otLEnyhIs=;
 b=KpbCe4UZGuxLKhBfIRTQ6VKwVetErgZlpm0X11RgcmYkIeUyBYhN+ZCi9QsACvtWUC
 WhiIsJbWoSQJ249xDsTw0ED5AH5+HKhMJoOl5hIymdq3OCzXSpyGNKI68gu0Cpy0+xEc
 rXEpA7P560X7kxccTn5ljMWAJofWWYmFcgY/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749314638; x=1749919438;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfEAUxAoZdu3lv2ap8t+Rsq7kXVnuD2WH8otLEnyhIs=;
 b=JHeZO0/iaPMMVfxCJykNng/WGG8QalxwAwjhrLajt+UReYUoricBXlhlKVFxlFw0zB
 Dg89N5OAu8Mgl0ZZamYUpWP4vv3TK7BwnQFYp7zjxYj2A5SbELbCEkQvudtGZHDqy8YM
 pLpnrpy0SwyV1iECC9nBCII7F1X/yVKEKXLr40kwjn6S3vzg04H3PJvsV7BDD50QQc1N
 eqoFKD8GEOlNAHL86cuxxYQcPiZrKNu5o0fKXTadR1hMQgA7ghym9s5OwP9UUZjmLvOQ
 pEmeyy9NDbe6NwhIVdOrSm3puMktorRM1o0WZCKG3qHOoAN0aPB53puGL0OA8qw2q5Rn
 rZ5A==
X-Gm-Message-State: AOJu0Yx+GY0sD1ADu5kjMuAEgHth5N0AwrfO7FXKJ6vCoRNT1fe21NPe
 vmmTLpAduK2OR3MY//tJ+omjk6p+yTHIrWLTtynjvGKKiStUKMB7z+aZeh5Y5ZYWkEM=
X-Gm-Gg: ASbGnctIuoThQNYsPBphcUgQHO6tpA1NCe86EBmf2xGB4VPTiEdDjJNWEXTZA6K8EvB
 sOl1okaU5FoI7bfZfWtiKmswR1Z0iIQvFe6aEzxEcuai1TmfRBYgCnVwiUXYBWgX456+Ma7f/Ob
 /ri2mYTaX6cHxpnYIsxEJ1f/I0P08LNynZSxQZz7KkWekt2UGRHZvKB3mCSfVBzz+zW5pCSIRSJ
 3aaisozO4S95DHkjUjfYJ1XhmWwaR3Lwj1hadgd7jyTVCC5K131aHMoDn8XC+YYtVxJpLoK7HaE
 u9xfkO0rCoZtY/wF4ZLL/f3PKrFvVppwgPMFFvEou8qJzEYp9RUEPa/r2zVR3Y5pCdTcZ6HK2hS
 LzvhSHr3En+8=
X-Google-Smtp-Source: AGHT+IFfbOxrrNHRWXKR1MtvDaYblcm1JYPJaFjC6ydDNmIR2h+RW9i9YwOM3Z0GxbiYZs4pqz3KMw==
X-Received: by 2002:a05:6830:2a11:b0:72b:98f8:5c96 with SMTP id
 46e09a7af769-73888dc05b8mr5961427a34.8.1749314638476; 
 Sat, 07 Jun 2025 09:43:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7388a06a980sm864869a34.46.2025.06.07.09.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 09:43:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 BehradElmi <behradelmi1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <468c1753-395d-4b35-b948-5163888fe02f@gmx.de>
References: <468c1753-395d-4b35-b948-5163888fe02f@gmx.de>
Subject: Re: [MASTER]Pull request doc-2025-07-rc4
Message-Id: <174931463741.3459787.11022898231898104910.b4-ty@konsulko.com>
Date: Sat, 07 Jun 2025 10:43:57 -0600
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

On Sat, 07 Jun 2025 15:12:33 +0200, Heinrich Schuchardt wrote:

> The following changes since commit b3f69c14187d413610abbc2b82d1a3752cb342c1:
> 
>    Merge tag 'xilinx-for-v2025.07-rc4' of
> https://source.denx.de/u-boot/custodians/u-boot-microblaze (2025-06-05
> 08:40:42 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


