Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466B9CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7163D847C3;
	Sat, 30 May 2026 20:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qys1VsFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 141FB8405A; Sat, 30 May 2026 20:37:00 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A12784693
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6b571750bso46160a34.1
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166217; x=1780771017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O0pD7Zl9eYyeRc1sO1RU9sL63A3S67oyHIImzpWuS8w=;
 b=Qys1VsFqQQRW7EcUyyZ3NqJAs3yVMdJ9kVLa7NefZPf7Z6YvSPh3TCKdjJykT1nnpl
 u5EnOZPEfXY01GC5HvRDiEo36utjhBxfZokwFHjPGCIM+pGdFEJNcLaRpHS2va4Lhz3F
 kaiOliutNoFTUvxyNf8e9YJvMcYlZKQFNDXDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166217; x=1780771017;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O0pD7Zl9eYyeRc1sO1RU9sL63A3S67oyHIImzpWuS8w=;
 b=Ygzr8Cy0VyR0ID7KQp8zuhnWbTRC71msADZ/vZPkC1QyubwBa9vImyTT0KlZsoSP+L
 VvdTUDhffGQJGw/bTkhnaJirb/ujrMplwk5pJvqAU69ytXihRV2UtVxGJbmTrxreOOLz
 O0Qgg6XSuTa+gttvD+H3Wfw69A4Jsk/iyR0h8NyoiNXjyjcdDX7a1L9QetCpnBnTDNfk
 J97st/QyFkpcwCfgPRmcMu50sXA0maUxT2d12TbhBgncrICfjmjpowlZPdo84cseTI9K
 VeVidM2PvPr+y9cbDS8UcmlcB+Sv1K/GiQuuxQCFPN2/+au94wDE9hOp+iviW8q4FfvS
 33ZA==
X-Gm-Message-State: AOJu0YyqRTGz3p93DQmX5QXR69Z9fmHYt4hBl8hQnMzpAjttMAlhAxSs
 oJh4+av90XBTavuaqpmPx38I2n19Zb/p26AxTEVIAIVTfIHDijPfO5mb6K7BSNE5UGs9kDz9W8K
 SAzWx/6U=
X-Gm-Gg: Acq92OHIXA/7SyPzR/jBCAv8REkFh2DLiZM6NMpV/NrBIPoarv1Tq/Gz492aDSuM4cP
 UME+WpeQ2EDbxCsBDFRduOai1whmF9bQxgBLtqd3CwwwQrpE3lspLOSGwHT2nM4nutMkB+k7PAN
 mPOhmiGJG2tnXHL0o8tZAaBf5L+Q/I+QsqeQCHgAwW5N7X/NmB47DjkkKgA1se6EsLtVqcceBDZ
 +yBaQ3eyBLkHM3AMXYzdbdZwHxvNZezb4MEKTWK6qCKmyF0FP0TnDU3Piw6m7ij8ljbgoxDcMfA
 glq2Sk6ewsJAQ2bmANi5PDhXptQ0mAwfsLPZBAQUQHP82CK/ZUV33mx8COb1uHZ0S0PlCTgWhvq
 tjdtay/6xDhKRrfJfFKRQrmXgHQEF6IvRYcOQgwAiosUws7lvyXKVZm48+ZczcKN6c/UwivZ9tX
 aSiW15t1VDs2W1kYbNO1WxpkaeaioENRXebtnF6wOCQQQBAmw5GxWKGAETazwyJuo5yXTPxtvva
 esoY31RN+Yt/04gsvvvvfvhYNFpzAsbz8sQgZsvpKxOfRJFDDXGOcM=
X-Received: by 2002:a05:6830:8286:b0:7d7:e57a:bcd with SMTP id
 46e09a7af769-7e6a1e26951mr3131675a34.20.1780166216820; 
 Sat, 30 May 2026 11:36:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:36:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205354.3789141-1-trini@konsulko.com>
References: <20260320205354.3789141-1-trini@konsulko.com>
Subject: Re: [PATCH] video: Correct dependencies of LOGICORE_DP_TX
Message-Id: <178016621620.1038765.5560406359407637665.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:36:56 -0600
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

On Fri, 20 Mar 2026 14:53:54 -0600, Tom Rini wrote:

> In order to build LOGICORE_DP_TX we must also have enabled AXI, so add
> that as a dependency as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] video: Correct dependencies of LOGICORE_DP_TX
      commit: 6033096d3c1e09d6aeba456d13e4c7554ca3b871
-- 
Tom


