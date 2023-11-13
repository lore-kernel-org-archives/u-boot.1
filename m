Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B2C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2296087061;
	Mon, 13 Nov 2023 19:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nUwFUGKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0891C8708A; Mon, 13 Nov 2023 19:15:19 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18DF986D3F
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-778925998cbso321917585a.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699899315; x=1700504115; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx3+7dTYlYneKzdfah+phWn05nuBAhYUaCLX+BDiZUI=;
 b=nUwFUGKqQAZT8v5xk5XI0gT4GwwWrnsPR39KWGcTH61cJzMalbKyyWFXv7xyMRAmUH
 SGOQt8Mdfx2sMg06nAj2o+/9dqw1kZXFDZkH6VoyVOsOMfdsYvDdk9IwRTzn74NzAgYI
 6yhU5YPKxy7k/q07lWFiniT5TzJQg7/iVSXqBAWRSmDa6uo/h5bFmMpn3QbOTlunAY4Y
 QSdA8861nePc4vTjLqcCUhLMGPVAv4q1XRARYEp2xjxNSDgzcAS0p35E5b1xhQQKG5OW
 TdwhUOG8S+xRGX/GcuqPPFabtkjkC1LjACOCDe6h0TlG6lIBuJmbd1vJC7folfaAR3/+
 JuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899315; x=1700504115;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dx3+7dTYlYneKzdfah+phWn05nuBAhYUaCLX+BDiZUI=;
 b=KrVHb7335hohz2Mjj3VGs6+DxVKZYCldAhTn0JUmUCG4m0p0rky4craXbNB2gE9SWn
 /4EIpuaHg7YdVF6L9TP+errxkbuz0kNmI3xbf3aOPUoGMOEhuj0vQ5OYS6wxs6PSk6r9
 qFzjt8GpL72yShluBXW/w4P5D0TzvMjIqQCkyBXoTDlruwpLlD35qnLQCdFXm8e7nq24
 6GoBw1Vv89UCnlgXsCAYlbZNR8WJU5QUtejnoSOaAXqrN4lBzZR9yum5EN5yHZpIjF/g
 0r0OTnbLFbykc8vs6anl9aBLYAnsnF0CFbNLWj9Tmz2pj2WoLR5jEgjhYom3CFoz2Vz2
 rpXQ==
X-Gm-Message-State: AOJu0Yw0Sv+RP2/mtEm6PNjVvFEXnPg2z4SInWSZ15lOMI3ld2b8U6UA
 zIKoHkQCoZ1mTIyHw2RgqSA/dpGX5sU=
X-Google-Smtp-Source: AGHT+IGY5u6prXBlzN9BqHqpOna01i7xXFBKFUzLWx0AjANLNHUS3sPREhTj6oPGfgqn7BiNa1p+GA==
X-Received: by 2002:a05:620a:6228:b0:774:2113:743a with SMTP id
 ou40-20020a05620a622800b007742113743amr6957038qkn.19.1699899314945; 
 Mon, 13 Nov 2023 10:15:14 -0800 (PST)
Received: from [172.25.83.38] ([12.186.190.2])
 by smtp.gmail.com with ESMTPSA id
 m5-20020ae9e705000000b007677347e20asm2035082qka.129.2023.11.13.10.15.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:15:14 -0800 (PST)
Message-ID: <ca3435b5-25de-727d-ca46-a88a234f9fc5@gmail.com>
Date: Mon, 13 Nov 2023 13:15:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: u-boot@lists.denx.de
From: Sean Anderson <seanga2@gmail.com>
Subject: U-Booters at LPC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi All,

I'm at LPC this week, and I'd love to chat with anyone else who's there 
in person.

--Sean
