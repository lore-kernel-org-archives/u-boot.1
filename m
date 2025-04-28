Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDEBC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ACF880F6B;
	Mon, 28 Apr 2025 21:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hj2aaX8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809B5820F6; Mon, 28 Apr 2025 21:03:03 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5653A80AE1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72bbead793dso4207599a34.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745866980; x=1746471780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUp+YFwNKKv2/s9jwh0PDD/NSXHriEzgNkThM+xozFE=;
 b=hj2aaX8DfqEfm2oN/b2SgI6AHqR5OeyCMVmTQ1h7qwrYBrXBTws+DXrvAyOSTHbYKH
 CD2uutd9REy/GyLAT48jI7JGm+XYYPFzSZgbKQScf2ug7P3tVRtNp/J11CTh6HrBzY5R
 7SICjew4IJzY2h6w/EVGI6hWrvFrgUiT999t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745866980; x=1746471780;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUp+YFwNKKv2/s9jwh0PDD/NSXHriEzgNkThM+xozFE=;
 b=RjOLe7hdsX9hIPmbrHoySlQM36gEFhhmo/WWncIFlS/hxnSW136bsvbzU1gW+jbZpa
 vND2zq5W6OQPsHUY5Bs7TcA4azR8DngoYaD4lR3H4sFQf8sqk4yqO2fs/xgG1GJ9+yy9
 61n9N2D8YQzxoorpf7kRgz7ZNSlosfMQFSNEHBNnl4dos9WLzr2QblOdLzQwvpsHmrmD
 jKI7q8Hnz8zrLi8k7a/nb23xgNmfEkMHRYxQEtGHYv4ofmYUyXXzquqpBr4Zxiq/CPJw
 MmjantN16kmyQsZ3SUWeOoQ3xWxlIeD58whctMCk6QvEL+E/0Q3AhGkC0Nc24MQ453m6
 4PDA==
X-Gm-Message-State: AOJu0YzcHw9ms/pZ3AUF24Ks3Az6hvF9g50xmQcn84DUV0z4BeBj72J4
 BTywt7jW4sk+uzM+N25zKoR/J499/m5DN+Q59HPL3+/kJx/CqTERHKiYFdMDkDw=
X-Gm-Gg: ASbGnctiCJvZyQ24swCZuwzN4z/xOc0aTvMg+ruoLlgS6ytv+f5ztgwyhLtYAuycCTS
 yADvAS1qFiEkTF2HorMQccSbuyvvMZ2Hz99Uiv7CGlRmRHtUAmV+BRfhrYVHLAwPNH3uk0H/PuM
 wmD8YVf1NLlOmNdNPFBeilqERwJCT1jMMYm6fTJkFFp0y/duzbbKs5s/RMX36G9+pKH7s/3BRRO
 cFd6IkLLQJbaA9diI2c9rmidZWiFi6beTkM3NlmucvgOyWsiXMPEBPtfKmI+eZn3WeRm1ueB4Wu
 bP8hcMXR5d9yNouAhCHPQZsIWCaSksyIQQQf565ZYEh/pl49Q6HG//gx7BuYiIeFx72LRaRqMGK
 W
X-Google-Smtp-Source: AGHT+IFMhMO3cJ/I1lgap6/xZx3dBMlhzFs5H+8IzEyCp43/ffjymS1lxYhDouNzuI961lqsyaWerA==
X-Received: by 2002:a05:6830:2650:b0:72b:a712:4b72 with SMTP id
 46e09a7af769-73088b24652mr626419a34.9.1745866980022; 
 Mon, 28 Apr 2025 12:03:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f39b78esm1886623a34.68.2025.04.28.12.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:02:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250331224011.2734284-1-raymond.mao@linaro.org>
References: <20250331224011.2734284-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v2 1/2] bloblist: fix the overriding of fdt from bloblist
Message-Id: <174586697802.1102146.14012849721253627833.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 13:02:58 -0600
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

On Mon, 31 Mar 2025 15:40:09 -0700, Raymond Mao wrote:

> When a bloblist is valid and contains fdt, it explicitly means
> a previous boot stage is passing transfer list compliant with
> Firmware Handoff specification, thus the fdt from bloblist should
> not be overridden with the ones from board or env variables.
> 
> 

Applied to u-boot/master, thanks!

[1/2] bloblist: fix the overriding of fdt from bloblist
      commit: 57a36716cfc0fdac0658bd9317e28e28d4d29f68
[2/2] env: point fdt address to the fdt in a bloblist
      commit: bd5dde0346c3e57634c98cc7a8150606d92d8d38
-- 
Tom


