Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF5E107BCE6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D43084324;
	Fri, 13 Mar 2026 21:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fkhKzNw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89E58430A; Fri, 13 Mar 2026 21:55:04 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EA883DA7
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d74c1157a4so2656388a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435300; x=1774040100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tghMQaBbRD7XS5ibiEAB4OwDuCbq6ISvAISxQNQ3xs=;
 b=fkhKzNw7kKv2KoBJmt++O+ncBXR7cXdZ+ZVdsFuaqxUwQxcUnPOPnzOIW2egXW9bpi
 Lus9X73vjlyy15vejG5TWz+WrtiyOt5WXqBFO6s8fNwlerb2KSWfyGrzYPaHNv58ADj5
 qjQbcArZtHvQ3Es8N+CObKpdP+5nMk4u8eUuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435300; x=1774040100;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+tghMQaBbRD7XS5ibiEAB4OwDuCbq6ISvAISxQNQ3xs=;
 b=PMHAFfNrQrD2EXhWK5JRz1SrmjFJKYrB2kNU9aUZxmNBXv7wx1B58hx5jfNePhuFAm
 iYGEDaI+L9Y6RymNIHGVZ+Dl+B7uVQt020pfxIW4oWWxlpP1FfIuWJ97YCc6nrn2vJK7
 jl8tnBTEBUpuCxDfAl+HR0ZNPaud/DVyidJ4k75vPD+wxSCvnZrLAlKV0MdWcco5Z+/v
 tHQSnOeG+4CwgN4NhdcGAG4kXm1oLN2XXHBkmcAoHDiYLVO3nn8/6rpR309aroYJuput
 STKgvXteBfEcRm48d5Wp3bzhnQdohldPL+oJi+Gz+iGYQAFDQHC8DqkAn8J4Zd5X5XXV
 E3Fw==
X-Gm-Message-State: AOJu0YxTos8u/CQ1gnAHivH/B3cg1GD0Fhevidyj4aEAItqqaLaAFMaU
 zRC54/lkryaFb9QHwfPhVX0/GfRwaYX/tLHimqYXEjuB6QsNhRNXUKRYrcla0peVdhM=
X-Gm-Gg: ATEYQzzG70NGilH0XY5qKdAAK4ursF0g8XyjUZUkDKfsTDZeENuR5iXZcTFIHdzemMH
 X3QoRUQTqBAaaYD7CTxKD1LEb/lo/xmL9Aotmv7znbUM3GhbzJ5mWWuq10e1Ji/RY7NsUA9t5RJ
 1PXJUCeCue1B9ffjRcj9S0BPwlxB7tmrBXRLTdXTzHe2airMCpyWvRO7ak4Atn2unHlzz/0C+Kx
 7um2F9PMNyn20Ttw4p/FhK1AroNAC6NniQtjBTXJ6UfRh5ek5U7lPptnvqiOIgLneKtYKCRpGjh
 TPwIjUZfFUV2hOYgFbKRI//qvVpL7EaMQWi5Z6V4u88L/ZKdPK7+gWWUWd7gRsSJhZMKi+BB+RL
 rMVpH9EIkjVVSFmIxNN6qfJtAXwxZUKTAJPhAvz8+qzMfcmFCyYVeZp+fytVsHCH/A05WpcXXrq
 +swyBflI8y3Z5HnWyc/Ko0NTSsXDdz733q/71XldF/2AAJwbp8Z1DOXa9P14gFdoAvWM75UKOaP
 SdKfb/9uVQxgM7CHX2XEn0lwFyPKw6B8VYj++aydKuaXns=
X-Received: by 2002:a05:6830:82d2:b0:7d4:bb79:65cc with SMTP id
 46e09a7af769-7d782526605mr3050700a34.20.1773435299791; 
 Fri, 13 Mar 2026 13:54:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm6857942a34.18.2026.03.13.13.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:54:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
Message-Id: <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 14:54:57 -0600
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

On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:

> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
> same bank"). These are based on incorrect premise of the first commit, that
> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
> not and should not use memory above ram_top, user can perfectly well use
> that memory from the U-Boot shell, for example to load content in there.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] lmb: Reinstate access to memory above ram_top
      commit: a3075db94d49f415658bf7e961e1eae90d9abc33
-- 
Tom


