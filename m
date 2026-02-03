Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA86E8B365
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC5183DA7;
	Tue,  3 Feb 2026 22:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hRHXz9Of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839DA83DEC; Tue,  3 Feb 2026 22:12:35 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6352383DBF
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-662f2fa7e67so2112753eaf.1
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770153152; x=1770757952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QJ36y+iO24tYXYSFr+68AaPtC8ugLap5gRtN+tSjrk=;
 b=hRHXz9OfCXJpKmjQhSa3gTHzd5s9ODfqruLaSEG7bRNaWmqgYCK6TDw1QghTx7wOWY
 MwE4EwOmILrgJCoTH4FjCCpOawZ4Qc7EgsZFQVriwnXghN1Xjkc/bQn+yppjwD7Ekbvm
 J796kc9+lKLrpHGEV1APysFqZy1yypTVTGC4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770153152; x=1770757952;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4QJ36y+iO24tYXYSFr+68AaPtC8ugLap5gRtN+tSjrk=;
 b=sYMFVprmTZZRTIw4XxaBTboIC01I8U33+tzor6raiivz+Du9yI+830nJsiXMPRgjCH
 s9auDNpLyqAGmZ3RSmVrXgZymQJFtO6tpHciL9DGSsuu4AkU5UMqFzsorq2QsIFJrZnS
 wYO+Gx+EuFeGKhvKNsbrriumQtSbLyGNp58qMtxT2CmUZuyvdHdKpyEuodx/yMhc1kou
 v1ynscry4vQI85n0+lRrHKnx5numFzukyRrrGiVTs26IHC6VQ13pk0p0kUKwkX+ydZfz
 ksbyoLEfEC2M4JEiLU8trBJSZI5CuMua/n9F/5/Sr1+S53VpUYvCyDXgBHpuYcgPbU8h
 2MYQ==
X-Gm-Message-State: AOJu0Yw+c7DchhE4X64pUz7yIBztQpEq3239HGCdPknV6Eq2gPo1zK8G
 OrazlUUqrUD2IvHy2n4eM6ZPXxzJy/5HCoZVexWfIw4IftRzI1mAtKv4jyQ7CpySLmk=
X-Gm-Gg: AZuq6aJyYPSVR2LZgWAsEOTHYeSm3+bS3Mf+hsfKibkHrRZd7VFZTDYZ1Ppn8Ftv1QL
 gevlbbrGO/XAetio1Kvh5ItET/fknIMVGYWDxgLApNkFSbub/B+mV7b37rpIoIArDzsykl44t4o
 LHHHiaSmZ1ovlGI9jAapMpAwIK9e01COJeCUT6WbRB7TSoZHcZ+avQsbmGdEX19wHW6UqWrhDPd
 U8H9Yt49tPDlj1KdAymzGb4clQksl2ZWQn2mlNvE3tvnr7dJRax5/Qg9nNUtYgrxqQETEofiwqG
 aisPQfOw5C9lDFfh2zjd0+jVVc97+dGf8YQ0ZAQbbQ2XsgJoWqVw8bp58kE1TVciZy7l227vJEl
 kdf4bZH/TuKQVZhQhZVS6gm985C6HRyJuhGASehrYfN+adI1QKUljNeTmu/KK9HiVPHb3nUa51M
 pF+ATvg+xeKVEGlhpo3i1UAtskPQxMhGFdoTpQX00k3yPp8atCOfrArQc//O/+sTy7OGN+5mT0N
 KdE6EAZePzGBbXuysUUrDiY/foX2tltWULESeY7wVITIpGX
X-Received: by 2002:a05:6820:201:b0:663:2d3:6d7f with SMTP id
 006d021491bc7-66a200b8fa9mr445369eaf.10.1770153152140; 
 Tue, 03 Feb 2026 13:12:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a35f7a4besm324630eaf.17.2026.02.03.13.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 13:12:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <OSBPR01MB1670973BD7364B102A973F79BC5BA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670973BD7364B102A973F79BC5BA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] mips: mtmips: add CPU reset support for MT7628
Message-Id: <177015315127.1503561.14171217297455205030.b4-ty@konsulko.com>
Date: Tue, 03 Feb 2026 15:12:31 -0600
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

On Sun, 27 Jul 2025 13:55:20 +0800, Shiji Yang wrote:

> Allow the system to reset the CPU without calling the reset
> controller. This patch also removed the default SYSRESET controller
> for MT7628, as it is now optional.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mips: mtmips: add CPU reset support for MT7628
      commit: 80a3572f9bc3fdd8f0b0fa73f2f853da71b059eb
-- 
Tom


