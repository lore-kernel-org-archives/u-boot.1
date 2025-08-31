Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2B7CA0FF2
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 22:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ECA783966;
	Mon,  1 Sep 2025 00:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VIUdRqfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45DEE833AD; Mon,  1 Sep 2025 00:38:26 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27FA4830E4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 00:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30ccea8f43cso3151025fac.1
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 15:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756679903; x=1757284703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZX4ISBTt5IU4NZbusmvtOCHWLgm+D/LRIlPcH/j7FE=;
 b=VIUdRqfNYbaADnaeI2jAaJSBxSKKut61VkByvmbolmHyMqUOp6GLAcb1NoB4Pc4+EH
 YI3SuiYovxpiWLT5wbAkXkmT0vNow3D2re3yDOpdj0l60SlwuwKo4/Kh2SmzSqDEredG
 0tblAEimVg1W251BsT9/BDwa8HvPGoDaQ5DkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756679903; x=1757284703;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZX4ISBTt5IU4NZbusmvtOCHWLgm+D/LRIlPcH/j7FE=;
 b=NYQucLy1Fswa3qOWLp70keThcrLMBARlvJ7xoro08ZE4gwM5FOtoN7thdMvyrKaD5B
 Z+Rtr+zSYCSg1hoA2gIkqsovS5EnRMjPah5ngW7eDeESvMhFqSOoUR/xsOe1oCHZSCzR
 5cRwqT8QnCL1IMn4aTCZFB5xMJ0TxfX0B0Dfykh6MBp0WlREKD2AXwjz8U7OtH7O4roZ
 r6xMCc9OfYj3JlG85HeXpBz5kw04UKrQFKakv2IjaEo9+7qZ+xVj+P3L3lMXo3SJssjL
 ynXGBTV3NCDbb5xd8TKgDGdOrJt6QzU5iAxl2a7JzV6E0qCWjWRzEwCMM5/NpyAfdEvr
 KDtg==
X-Gm-Message-State: AOJu0YzBS/Sq2wTP3j6tiBWoWl6K/oZvu3blpNavssHn8cL18oYmBglD
 7jTUeb0l8KVltklcmr/rr6bPbYj6+LeBnDc4agYMVPtyjfT0Ebf2we96MClcJiB5ypcA0Bit/Mn
 N0VbwJ4Y=
X-Gm-Gg: ASbGnctOwe2vqBJwBj+L+IldWevY6KGxylhm2SdXJptU386qiBpsp3SMrLazMD3w/xK
 V7BB+xlie/2s5o6iOfi3TLB3lM2f2BT1wOEOZfstdLT7emStQ807ig7HRXATT+hQBD80VnSiJzf
 a3SFj+KznSPU/YZoEa+QbUD5XZ0vgxketoW1RIB09EEyjepgOX09VHEMOLn4xrcXFGBhWkKIN/L
 BlhcpSNOBuFVfYJSYkvgx8qGMErfrrMw7VnDcZSnb+VLk/gXZZThNxtEpV3XYvpTq80w9boAybT
 Fnl1DFlb5k4O8cd96wc+MD4AAraRs1Tqt45tetxjJKtZi9SKS/XE6ZvOvO/k1zxyAD1LWM6Vma1
 N7TeiK4vYS4kGVT17cW2MYpMuThVapaakC0jdPu2KWxsCyDb9ES2YGaWrerylqfT82g==
X-Google-Smtp-Source: AGHT+IHXeuojmVFMxRy2KpVez5QuQVq2DEt5lU4tDQxW1FfgSiQuZyDz/7gUWhj+Bg/d7h5+FWlJ0g==
X-Received: by 2002:a05:6870:d628:b0:315:b869:aeb4 with SMTP id
 586e51a60fabf-3196349046bmr2662457fac.24.1756679902888; 
 Sun, 31 Aug 2025 15:38:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457428c153sm692089a34.8.2025.08.31.15.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 15:38:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Alison Chaiken <alison@she-devel.com>
In-Reply-To: <20250818165406.3194425-1-trini@konsulko.com>
References: <20250818165406.3194425-1-trini@konsulko.com>
Subject: Re: [PATCH] test: Update logic for video test
Message-Id: <175667990170.2964020.4956396187017816911.b4-ty@konsulko.com>
Date: Sun, 31 Aug 2025 16:38:21 -0600
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

On Mon, 18 Aug 2025 10:54:06 -0600, Tom Rini wrote:

> The video test here is specific to the sandbox SDL video driver, so only
> build it when that is enabled rather than VIDEO is enabled.
> 
> 

Applied to u-boot/next, thanks!

[1/1] test: Update logic for video test
      commit: c9ffeefeb3efedd754e3ffa3440bfeb15cea00c3
-- 
Tom


