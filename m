Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A173E63FED
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 18:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1388341A;
	Sat,  4 Apr 2026 20:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nMgtucl9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7FA83A8C; Sat,  4 Apr 2026 20:25:29 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1A6807C0
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 20:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso436972a34.1
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775327126; x=1775931926; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHLNpx1bI7P9/jMhKwQTVjNf6a57bj2rajwbWKb7LbI=;
 b=nMgtucl9DIBaCnMjWAvRapCEBUo1zx5NTvfJuKBXbjxMpy+SCIqkQGnWC3UbF5Axhg
 CZtbSY3K5u77031e9IfekpNdsz2QIVJyCf/uVNo3+xBdIEKoNkmNiFoBOJ2T7jikaHRZ
 NkRnPxnxMJjxmWtLyU7TlutoR6gP7wpoRn/+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775327126; x=1775931926;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GHLNpx1bI7P9/jMhKwQTVjNf6a57bj2rajwbWKb7LbI=;
 b=Kpgjy5fIl71NSxi9MJkTVdHSauJFMd9wRPm8hNjKHVR/Z322KDewc4LAPBCS9HIKD/
 4sHeLmnKWVoGABdvnZlFkp+uXEi/qVekQmy3ZTpPwPFOHcE0kJhUeifR65LKtCEoscxz
 sYApmcyOr1Bw73IJiWQ52e8Vc2lmEnlCY4mKwKKDMabGTPrxi3OJW1hQs9GyQmhBnqij
 s7wX+CLMTSzMPOoCx3L5832fgUP1wrKkJvWyZT+G/z+5CBISC20sa0XQ4usxkGqCVq7a
 pJav1JHUw4KMTIcI9iA0g+S/IJLZporSI2n64zO7gMdnijVWE9axn6/Ak6HbHhRzoBNF
 jPqA==
X-Gm-Message-State: AOJu0YyFt3hf46jVAN/kg/i/n24Op5qZubwkXJgnWnXDcrAp0O/mKM0C
 DH51la2DlZZOuYoSmHVihus3m7Hbc8IkcavmJgRKtIwPc/e8CU+KoOiLAF1zZWOkJ5Y=
X-Gm-Gg: AeBDietVbQlZClZ7V13Uzd/uelMxMB57bs2TsWMv/7M20h34XdvIqTLd+qFSDCTv3/m
 iQYueE7HGlRZn8LScu1+Q+NzyiK5gGaLzOWR5JQZNF16T2uxjlh734a+mqecW3h1E1k7HCAN7g4
 npMmbD440y10Sd40KIyBqKmvm4Pm6xE8Hgxs6mg/wFGqFCoPKX5Zhj+k0PvQ5i86Mh2gdG4rU2p
 rAkep2qmTgHRswVXN/z0bzPYJ2xZqf5TzBRWrdwEjkMXnyhtp5ALI37EU+oLnYN/1+FyfI088QG
 Cry3qxNuzh/0QoHJrqVY8uUiqgN6Ra0ekDjZJzOI+tuWrVr8qQR5/NPjOiSGrLRRCtIamuKnoda
 /N4kmkUglrHVu4RQZ5Quuc/U5zA8zf2SMS9LmnRrEj6DH9iPt9fJnePm8KhB/G+b61t2MD4xDn5
 Q6KzCJPVo5DTUmNyLoMPDSiDYHDIbIkXGQfOOTbG4C6KG/Q1AZc3yzycfF2MJqrxPc1Fxd4TNub
 Apuws5a+D9QvOW1eBUqM0X4bzKKjAqy6bjbqgnLWwktY2c=
X-Received: by 2002:a05:6808:1808:b0:468:9c8:791b with SMTP id
 5614622812f47-46ef73079e8mr3624702b6e.33.1775327126266; 
 Sat, 04 Apr 2026 11:25:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d90447177sm5406801b6e.7.2026.04.04.11.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 11:25:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, n-francis@ti.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-kumar1@ti.com, vigneshr@ti.com, s-vadapalli@ti.com
In-Reply-To: <20260312133247.2192335-1-p-mantena@ti.com>
References: <20260312133247.2192335-1-p-mantena@ti.com>
Subject: Re: [PATCH] Revert "usb: cdns3: use VBUS Valid to determine role
 for dr_mode OTG"
Message-Id: <177532712490.2577589.16492260809067949903.b4-ty@konsulko.com>
Date: Sat, 04 Apr 2026 12:25:24 -0600
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

On Thu, 12 Mar 2026 19:02:47 +0530, Prasanth Babu Mantena wrote:

> While USB DFU boot works with this patch, but the non USB boot modes like
> SD Boot and flash boot fails for J784S4 EVM device.
> 
> So, Reverting this patch.
> 
> This reverts commit bfb530e06ca6c19f66c079601e568c761a001993.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "usb: cdns3: use VBUS Valid to determine role for dr_mode OTG"
      commit: 214aababe07de0598bd26ecb0c8fb2e2843ff7d5
-- 
Tom


