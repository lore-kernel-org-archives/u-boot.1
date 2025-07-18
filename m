Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08015C83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 19:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2821836E7;
	Fri, 18 Jul 2025 21:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZUYbadiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 836B2836A6; Fri, 18 Jul 2025 21:43:34 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533BC83537
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 21:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73e7bb65255so1209884a34.0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752867811; x=1753472611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YluTKFqoV0kGmtXn+90e/shPQpp4shtF2EmFv+pOyr4=;
 b=ZUYbadiFlxKqBUcFWbRvRSpS1xaGu6kkZZtbsF4XtIi+R2W84yi5ry4AMf80luo8Je
 OmOYubFvfKKuktJVpviNkBxNDnRwr3H9b34yeid4hpDvYcb42tlnOI2yRBS92ApHJ56E
 qYGWnkgFJcesSxo8tQnwxQTtlScGZza/ScfuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752867811; x=1753472611;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YluTKFqoV0kGmtXn+90e/shPQpp4shtF2EmFv+pOyr4=;
 b=GAfpGoEdUgEYOn8o4GEI/8rpP18VrUHMaEgPnjMCJoq0RNB8wBLx+UD8sIJFkD8n0e
 ZjRVGOA0WCRlrGzoFNiVsjshpQ+jRy/SInvoSeUUASdlR8RaAvfaXDuH0T3V0A8GTEFN
 VSnDXeLSYHKT8o/d9aQPBkrrTEneFImNNYaKzytilyIqRKyDKDSvOa+M/YQe0hvJYknz
 Rue+UzqLhDS1i4Yc7N8Ovt60SHEugi6MKE7b9RgyNRDYTE29Cc4liLa6B6ol7HIYdub/
 VodKmiCmiiqZiNsOhFzbDEW4dz7MpGx6bDoAJw2fGZYwZFcVDjhrdYmHEfpdfSNR6TA/
 hMIw==
X-Gm-Message-State: AOJu0Yy422z0JNf+njYUZz1YZ0RwIIWzfiZtZnOT1eev9hsPq2yYgqBB
 7Qi65rXZBDuwdPes+WgHMMZxNLQzAf932VqDemzDDYMVqU2PWETwCyEkF3tPBeRe3RVn1i7xCej
 RlJawH38=
X-Gm-Gg: ASbGncvuJAG+IFy5tQxkIYdMl4odYDZIun2RDJG5UYd7nMyBoq9DSuiNDkuNXH2B1qV
 6PZJOWH50lq5ulleplK5cpUQzSfl8dH8FUW/5T1YlpObtgQ/mOQdfGYpgXcnMDhdl65Dcw3ry8X
 PicQTALBHbzaepBeZ2H/7igXWMoO7xAWKWYwymMZ5P0vsLQg2wBu22kjM9A9ELFzSDNfXnhk1RT
 vGUA9L16zy9c1QiqN3/3O1BVBz8MYyikTdPBvtIcWxVXDHK5pHb+74630vBR8lj8x/9WZB0L0uO
 8EYxRxFsYdLK6r+Tzgt3eT8ANXPpnv65R5dI+vqoFAQvAJcQ53C/bXNRJGtiEB5ZbU2r7BfP6Sl
 CWePATMPc2jh89iwaExrSIPGbHqY91VLG+djZ5f7+q3Ozgp8Hh8MrPIY=
X-Google-Smtp-Source: AGHT+IF7yLLKx7OKgiM8rVRmL3qTjE9D5ajUf+Bu/hVA3he1Ed8wl4Kp8rCGY/KQ6W3XHcYBiMp2Ag==
X-Received: by 2002:a05:6830:d03:b0:72b:9d8d:5881 with SMTP id
 46e09a7af769-73e662d52b1mr10120979a34.28.1752867810981; 
 Fri, 18 Jul 2025 12:43:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0be4csm871076a34.39.2025.07.18.12.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 12:43:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: ilias.apalodimas@linaro.org
In-Reply-To: <20250712104558.77355-1-kettenis@openbsd.org>
References: <20250712104558.77355-1-kettenis@openbsd.org>
Subject: Re: [PATCH] kbuild: Don't mandate gcc as the host compiler
Message-Id: <175286780960.1647311.4448267827855078528.b4-ty@konsulko.com>
Date: Fri, 18 Jul 2025 13:43:29 -0600
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

On Sat, 12 Jul 2025 12:45:58 +0200, Mark Kettenis wrote:

> Systems that use clang may not have gcc installed.  Set
> HOSTCC to cc and HOSTCXX to c++ like we did before to make those
> systems work again.
> 
> 

Applied to u-boot/master, thanks!

[1/1] kbuild: Don't mandate gcc as the host compiler
      commit: bd0ade7d090a334b3986936d63a34001d99722ad
-- 
Tom


