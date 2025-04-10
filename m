Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046D4C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 17:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECA6583DB3;
	Thu, 10 Apr 2025 19:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IvVVf1Zb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B8E683DE4; Thu, 10 Apr 2025 19:33:58 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EB3E82160
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 19:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ff0df81fdbso372022b6e.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744306435; x=1744911235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FN1cZAxZ0eHOIXcnf4InT450qIv7gjBbfYD5cwp87tI=;
 b=IvVVf1ZbJOyqZ4Fz8AYKg/gEhGAzUlFJsIp6eGl4QMzMf0HD0Maw3e7jQZlfxflv3F
 KbU3HJ88j1w7Deu9NGuYR/uYrZqjMmY4U60IEHsePd+ZXTFwVCuqezksv4UJhXVAjLTc
 CBqp1lqjh16gYLIV7RGrWLapA3Z+eTLsx1d7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744306435; x=1744911235;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FN1cZAxZ0eHOIXcnf4InT450qIv7gjBbfYD5cwp87tI=;
 b=jH5+X/sTEdx4/Y6ypGJXm6eMlIImCO0ys6zn0J7jHzLFE9G2g3+mhZ3TqClwrMuO34
 ykXcPoIZSCY7J+gJeIg9B/u8G7AK56efpZPOqKN+wjkS2ClSZR5t5tYBHI0buhK/woCL
 HYqHQAE/tS81A9Ab5UweP1cHL5WdjOy+shOd18nzs2g8dr89MaEzl/dN/n9yU9IR1a7F
 c9YeO0OYdp9s97GKLOGKUzaBY9qIoFs+QeisTvXEV4QXLHNTPAIrXg6plHi4q94dIXsR
 EYuhBaiuxH8OjV7v5NSnvZup8eTGfw6sttrgU1gmxX59nfrNU2rOCIL6nD+K3VzdCJN4
 C5hA==
X-Gm-Message-State: AOJu0YzeTNcwmGKbgWRR/uIlxK842aZ6kQ5IAUX44X+vMAxs7xS7N6Z1
 jJILlBsadCesTQceNt5ucIajLoV66Ag3oBCR+PnslgmelLwI/NgjsmwN5BYsfttnMfJUg9CCn8D
 KfHs=
X-Gm-Gg: ASbGncuthhbwv3RbphyaECbxQkZ0E3eLlHpWs18r3YCisQicnaVZHQoTIYUHKqHd1eg
 SWpWjf76qDfn74TIXEBX6H9ZWD2c22mFnRlm1aXA34NBeNVmzuBynrQwzAXY3oMlVtuTnjXT49W
 suwwWqeYbXhsdFks69tdxSFF5T66bzgpPQ5BzcaQjakLhng2Of2EWN1X03KqYA+Jn02KGzJf1SA
 /Ho5vII4VuYfA8x7IjAchUzh92vNnhez1TFSj9U8rFYGKNvyBA2Z4fQ3+YJUdFxPtbjHL0+Q2AH
 Zr25fOG1EHWHiSxi0Wh1B315lJE3dwlHj7pKNcS76to+J1rjdB4Ho5yXezLObj8n1jVlKYk/A+4
 VsY7JBC78VwM=
X-Google-Smtp-Source: AGHT+IHSfzmFlP7Fd7nFLNsQBfXJiaW2AgAiVltTpuTBeJYPXXFmu6AvaVpywCsVwvSTKRajSs+N+Q==
X-Received: by 2002:a05:6808:22a2:b0:3fe:aeaf:26a5 with SMTP id
 5614622812f47-4007ccfc020mr2118272b6e.31.1744306435151; 
 Thu, 10 Apr 2025 10:33:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40082515ebesm75008b6e.11.2025.04.10.10.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 10:33:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250408202141.1434754-1-trini@konsulko.com>
References: <20250408202141.1434754-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] Dockerfile: Update to a more current TF-A release tag
Message-Id: <174430643415.2959201.11731171141864014636.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 11:33:54 -0600
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

On Tue, 08 Apr 2025 14:21:40 -0600, Tom Rini wrote:

> In preparation for using TF-A more in our CI loops, switch to the
> current release tag for TF-A.
> 
> 

Applied to u-boot/master, thanks!

[1/2] Dockerfile: Update to a more current TF-A release tag
      commit: fe8a33b81cacdd01379f3a72b8dcb0dc29aa9cf5
[2/2] Dockerfile: Download the Arm FVP and extract it
      commit: 01fa1b18ae68381d9d462be66df3943f41426874
-- 
Tom


