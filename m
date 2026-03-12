Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217BF106ACEE
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 22:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA3384167;
	Thu, 12 Mar 2026 23:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mfy3TTNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24758416C; Thu, 12 Mar 2026 23:10:05 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D0184166
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 23:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-67bd4e63606so450744eaf.1
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773353401; x=1773958201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5q0pObbU5suLvCowFcrV5Yr+/AfKD2qPnxr5yG5A2WM=;
 b=mfy3TTNoz+M86qSJjiIp6s+GgCbE+ZF+QQTyL0aY4ptvTGkqzzQ/MeSPvGCXiOTtB3
 GAPKoeO+gy8TTQngcpQhUjrAQB2rV9KYzEKaoT3w5a/E10t9tmSZDlA7E72yLp1siZ0/
 Jo/60lNT+8rDKN4pLMZYehbFg5UddBtQ00jUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773353401; x=1773958201;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5q0pObbU5suLvCowFcrV5Yr+/AfKD2qPnxr5yG5A2WM=;
 b=fqeFO4hn58VboZFidVBZwytBjcyLHRqe00lSlPmwb7aG0BLse5+Nt6by99/rKLlFRe
 NOhWSS/ftq3wXOs2surB69ETArAEqt4wwbZBuO+fMNCtX7cTnlK8GnbD2Q1EbeDFhwbk
 FpAtCafRalkZR5kbvisdRrhLkTWsbC7E12qZlucJJOx837oEDClYpYldcHsyxB/67Xk0
 oKfceuRwCepvOdLy4ruW69dFUanjdPHwMiMuV3e2qmsdTcM/KqVsXduBckGmjTVoQkK9
 e5bX/YyrsVeyc7m/IIlfqoaXCOWRVSpSMxUu1KEGHmD0H4fDyUpa8sAaqYGrg6Ft9BQO
 FQ0A==
X-Gm-Message-State: AOJu0YyIMnSetrgRODlKPybDjWAWL9FvVLQay7Ebonw6ggbdi8GUnaTV
 QiKmbGaZggnh1qKvdUsk78gKTcuJaodYJpO7X9xoCj5NPaRS6zeKzGyto7rXV9hdYiaogPWUa/X
 ty1a6rGk=
X-Gm-Gg: ATEYQzwBFpj38a6npOZ+eusjTOKToUNaehKD/Il2+nZXM85AaicLaUB//uErMQI8raM
 j01FCYTXNrnaFU+D7r2WthHsVA6Hl5MEHY7G78IGPlhvOhLTuloHzK5pzlaTyFkjIOU/a1WgFNZ
 HHNnkwxsY4uNv55S8vxSxkNJZa7Vt6E1muyyrdYxNHcY0YlgWnRUruByQSbR69CsvpM7P/ONfIf
 qDDMJHMnYAwX5pHKkE3QK7dd4h6KM3ANC0FtDOrmBwD9w0VEfpzhwAoSXGxCkxxdOZBiFDlhF0p
 mYWKGgH9QGJF+zpAuetGCkH3To3YZrYggRTGjP/j5pv5b5NogrzbeTXHKMN0X6pz8BHZhFXNcUp
 /+3QKuucTpP8tOezjBZDxfp/TbFOTX4xhH0JtYDm46BkTtje021/o8CHlcCznxHIunFRr4f3bWO
 49yMhSKmIX55N+42NNHPQmSyPuBBxNaLoCNSzKFZsmNOhf8G7m6BXYdrEGBtuiEEdn6h0JptZSQ
 h1hJP2QdgvJLmIHLIwfOIYScG6qPpoCa9jgZ8NteIRMxpk=
X-Received: by 2002:a05:6820:490d:b0:67b:aa33:408a with SMTP id
 006d021491bc7-67bdaa38eedmr550621eaf.43.1773353400743; 
 Thu, 12 Mar 2026 15:10:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9354e59sm3873539eaf.16.2026.03.12.15.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 15:10:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260311220131.2526133-1-dlechner@baylibre.com>
References: <20260311220131.2526133-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-next-2026-03-11
Message-Id: <177335339985.789657.15737146916981357258.b4-ty@konsulko.com>
Date: Thu, 12 Mar 2026 16:09:59 -0600
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

On Wed, 11 Mar 2026 17:01:12 -0500, David Lechner wrote:

> The following changes since commit c0ca147ac6228949a6d6497531c9f2f4a0dc6c67:
> 
>   Merge tag 'u-boot-imx-next-20260228' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2026-03-02 13:44:46 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-03-11
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


