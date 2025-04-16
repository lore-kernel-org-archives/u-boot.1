Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E485BC369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8FC82F46;
	Wed, 16 Apr 2025 16:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L+cTGu/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661FA82F54; Wed, 16 Apr 2025 16:11:04 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4315C82F54
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 16 Apr 2025 16:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2cc57330163so4004557fac.2
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 16 Apr 2025 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812661; x=1745417461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgP/lX5cflPnDAuzWoNKAZZeyKdfGXuMeKnnfDa8oBM=;
 b=L+cTGu/Tv0SZ6vz2SWIYPanYiX7aQt8+KtmvUoohVeEIn2h6bEpZIxg+Is+HR5V3AR
 5WsXZRFUze2Nre6M2wUqjFqMqxqeBzx2ehSkB8ZGjDX+T5UQKVNOtnN/KVMX0Nfc6nGj
 Pc6wipcPFLVotQFhXOkVHWDTjoZ9wG1Z+j248=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812661; x=1745417461;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgP/lX5cflPnDAuzWoNKAZZeyKdfGXuMeKnnfDa8oBM=;
 b=Hr9JKlvY55OMqxkDHiOAGiFQnmA6qI3Wrr+VLusdsHcDcaZn3EtWpJrbTf5Ni4yT4y
 u/T03l0pXodxuGuBjPjubDmCLn0xxLIMp3hNPXkC30+DBi0qYQt0OIhz0sMcuGFrhXsW
 r+JJ7USb7xQpLYEYHbX5TmBZ6YX0I7EvPxrSKkc9oFetNRB/ENX5Cs67+FyBLb81m24K
 5oJmVTtI9wMsBPUsvT0aRNb90SsX38fRs8FZ6KX+oFSxWkAo/yEvoNyyE8ufc1zwdyhR
 b9DcbZ/4XsVErsdmsZSdsAOZQHdiiPchCnNL6bUZc/4TNSIXf8o+AHVdGiu5GkQjrLy9
 y1gQ==
X-Gm-Message-State: AOJu0YzYD8x6CVh16h+ag0yud+191IFVqBjjkbIggwD+tKi0rgpEsKq0
 JmQqKqfKTRShsCGLnUNV/X8xQwa/GzfXmzx7VgtCoAHN2cJnkyD5daeNeGEnOoIbLQgZ09fsMBH
 g
X-Gm-Gg: ASbGncs1GNa4z2zshn8JeqFk9Q55fob/tJIu1EXnXAYICTb77jwCFJtwEDE/wst3GWA
 BoCYhOA7hw26jd8lkPaTxkvesyIiPRQ5vdHIms2Wp29nbtP6YD+dsNNZ7AVZ8yfFCFvnPEEE0Ox
 DvBUTP1rZnAUWaFIq6Ejj5BFrlOOkzYWIkohXKseaqRXKxf5bEprJVIzOFkPDLlRHACDdUNS+eA
 NvdjlF+X2Cb3Sf9ri/q1xjoKpBQmjatYcvATaPWNOOPxFWmQ0bdtptQXzHMAaJk77tnNvR3I6YR
 xrygmv96GE3MmGUiJjGKTDnMPEotFSVTEck9o4r2ibiwNQI8FNd7C3hqqVk6V6I1ENwjT4KwRKG
 f
X-Google-Smtp-Source: AGHT+IF8kDkyEmU/hm7kipH8HgE+I5D7fNvgnwnMoL0/fjuzaOCjBpmpO2DrACESwFiVX+m7G/cEYg==
X-Received: by 2002:a05:6871:9e13:b0:2d4:d9d6:c8d7 with SMTP id
 586e51a60fabf-2d4d9d73bf5mr1095989fac.31.1744812661097; 
 Wed, 16 Apr 2025 07:11:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:11:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: trini+nodisclaimer@konsulko.com, yan wang <yan.wang@softathome.com>
Cc: u-boot+nodisclaimer@lists.denx.de
In-Reply-To: <20250410092850.316905-1-yan.wang@softathome.com>
References: <20250410092850.316905-1-yan.wang@softathome.com>
Subject: Re: [PATCH] spin_table: add missing header for ENODEV and ENOSPC
 symbols
Message-Id: <174481266041.2150978.6602099655762108321.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:11:00 -0600
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

On Thu, 10 Apr 2025 11:28:50 +0200, yan wang wrote:

> Add the necessary header as <common.h> is removed
> 
> 

Applied to u-boot/master, thanks!

[1/1] spin_table: add missing header for ENODEV and ENOSPC symbols
      commit: 3bf5e4411acca17c58b83913c150f00992ecf942
-- 
Tom


