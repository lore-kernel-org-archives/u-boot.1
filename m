Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66070CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 23:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C41788E1B;
	Wed, 18 Sep 2024 01:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IkRfbDhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7206F88DF5; Wed, 18 Sep 2024 01:48:12 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B08988DF5
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 01:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a99e4417c3so435546785a.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726616889; x=1727221689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usakHJio7weHEsMnQL3FkpyU1JvLAHGNIdhQIOFrlh8=;
 b=IkRfbDhZik+WuM5fsgfP1WdG9oXL4ORuPykyZbKpddX7LAqQpd2evfrt0Bt9e5HBmZ
 SU90/jRc/lx9m+Y7dqm/pXobMDYzybJUN3JB+cMRvgSD+3G563p8o6yKHIY2/hiVmGHd
 lIksfqMKygVAUOShIXSOMxelmNBwEepyoks4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726616889; x=1727221689;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usakHJio7weHEsMnQL3FkpyU1JvLAHGNIdhQIOFrlh8=;
 b=CAgZ0yadxIqhfwIxLalFXJhQMgEN+b2TPeHVEGkvE1ZbMwNO6Vzna9IIhy7x021YWL
 yGzRCvQ74kODVbHW7pQiHzMtAYCK8GjZpq2cBxhFCzyOAXqmdtBW1pvvVn6P8lb3iuYy
 qlvIMk4guZN7d+wa4d2jPv0D9MkR3Q2FQzcYsIdE5vm2pAJZ55HisMHmGyN+GWhetaiQ
 Oc/cfJqtLVb4oLRNTJH/Na+2Oz/CP6AGWJ3rFXkBeWlwJRT7D4LpV5Oviy1Foe6Kd7Lh
 9dNKLBo0PDWXSwIKq25cu3ChqUrX6nmwln3tIJIjNbTVIZHSChPkv3z3Nr2RUtbrw1s0
 y00w==
X-Gm-Message-State: AOJu0YyciNNGZIPt1f0UosxN3jszBBH66m+wLJRlO+8Yb9Gi9eXuOHKL
 eNNWfqKw7e63gWhvl1uSd0Mqm9nQmTfgXbmz/o2uDnNiJZbQWMBSS0MwidOjCRU=
X-Google-Smtp-Source: AGHT+IFbdj97DiA6sI+65dk9CopdOx18k5OB0SP1Nx8wQzKb2Aar9uc+ZFkvwzxKFUFZHhGRyMeNCg==
X-Received: by 2002:a05:620a:4145:b0:7a9:a663:4a7b with SMTP id
 af79cd13be357-7ab30d5a6eemr2801871885a.37.1726616889241; 
 Tue, 17 Sep 2024 16:48:09 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2336esm43264901cf.90.2024.09.17.16.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 16:48:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
References: <20240904024106.2030437-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1 0/3] Arm: npcm: modify npcm8xx boot setting
Message-Id: <172661688817.2128296.9585211621738140965.b4-ty@konsulko.com>
Date: Tue, 17 Sep 2024 17:48:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 04 Sep 2024 10:41:03 +0800, Jim Liu wrote:

> Modify npcm8xx new boot design.
> Correct memory setting and set gpio default value.
> 
> Jim Liu (2):
>   board: arbel: correct the dram bank size
>   configs: arbel_evb: change env offset and boot address
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


