Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BB7CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 16:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88C9A8407D;
	Thu, 11 Jun 2026 18:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qQ3kNt5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 533A3846A7; Thu, 11 Jun 2026 18:01:50 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC3D383FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e615efd7d7so16491a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781193705; x=1781798505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USsuqyD+vhOLA278JxR7zgAy+UakHEWzeydNTBwpvuw=;
 b=qQ3kNt5e2+EmTUoLb4Yx2v+JyVq2/MEabkdWlputGRKjecPW5S6A6CcGodYq00nOH/
 iiyHxBjOdQQlDslYugNwVtlx6BRa4oEw100CIILY41LnAEMGlLt2pJZbdqckI3iS6/tc
 kkEU8wrMDXuloDtKfzjoaeJWTYTCjad9uOM7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193705; x=1781798505;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=USsuqyD+vhOLA278JxR7zgAy+UakHEWzeydNTBwpvuw=;
 b=ShJGp8luZOlVAIJFC4A6h3TEh8ADb8uTdHZq2V65AcTJh6cWFBGKetFxr1RKvwt9yT
 uihglT+AgVu/weyyXyIgnjZLDqwW3jcPX1hqmoWqzjpH6nRfgFIBwdMOgWqZNb9Dm6/n
 37Tx4TKFj1jFWaTaxQOqJBp4NgiGnYKsAjxgOXXLgbqqdLZEPdnMwRwjrR9WOLrSgtsP
 cYYnaMCdSTg6+Dk7+WEvUnVdNXLcMnIvlraShI3VM0fn/yK0BMG5dkuLQe6pDq/zFiZI
 PDBe79w2qDFSyubzSjsVfu/LqtBQVDsa6Dipkk5coLIvYCL4ZhMgxOKP5jmITvm8y02K
 QyeQ==
X-Gm-Message-State: AOJu0Yxql34+Rv/qrmbcS/fgY4LVF/Cl9xK2hfkPvDEI8zy8pqdtjD8c
 FLeo5HqBj8bJCPpJVZgbVYqGRKVux+ZinsDZ9OmAfwdM34L3MuJyIpAc7/VU5z4m7GdXfB29eGM
 ELrzyA7I=
X-Gm-Gg: Acq92OEEIXR1KJYDo4wnIJOQVkI2n+yFK4LmJvG18RhBsx/JqaOksZ1QyhVlgIsCffR
 qol5c+utc8XgP5v3/Qz71HslQm1RdD4CcsbrkOScW5NQQ3EoUDCmUWQhrIijagDDZPMbr6eG5MB
 Pug15Q7XJmOEh2KVZATSwqPnmusj/qRerfDD08iNJr89Qiqhvv14PjEIcjMxBA3ug4MeBHdv5Qn
 1EO0ZNu6JMb9+K40fQyzq48ilbHf5eFfC3SWp0GFlzM6Fuv5EA1AhmTKyM1lfv3xHl//eq1WLXB
 p3mufaFxJkAxtm4/QrUhCIXzaWRQXMk9GiF9U7aFDaaNQrWHIQRlQEHqVMo3VCYOxymEMNIY+72
 ngI8taM1yQ3MklavdkeQnY3qGCsWFjjXVq0nRmJRovjwomvHwFMYzpnXeLHXpT+1Ah7RM+kNY/Q
 Iqpdhd8RrkFlVNJhy6tWFAl5tfprigmzlCzjxWhTH0yIdqiI24S9cvLe76kqogkv0dvM3uOgaCj
 zn5q/34NIBCC8JC1wWk4npcBxurenmc15SJQaH/dkt8/WE=
X-Received: by 2002:a05:6830:6d54:b0:7e6:f2dd:93c3 with SMTP id
 46e09a7af769-7e7734e5d2bmr2738673a34.15.1781193704635; 
 Thu, 11 Jun 2026 09:01:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774cefa1dsm1662723a34.24.2026.06.11.09.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:01:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260610211926.701621-1-dlechner@baylibre.com>
References: <20260610211926.701621-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-next-2026-06-10 into next
Message-Id: <178119370392.503339.1193979332217651225.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 10:01:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 10 Jun 2026 16:18:52 -0500, David Lechner wrote:

> The following changes since commit 953653936cfc9e12f52df1165080fa6c7cbae1bc:
> 
>   Merge tag 'u-boot-marvell-next-20260610' of https://source.denx.de/u-boot/custodians/u-boot-marvell into next (2026-06-10 09:18:15 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-06-10
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


