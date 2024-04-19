Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078D5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 01:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B7488698;
	Fri, 19 Apr 2024 03:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bA0rmYoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6B85886A5; Fri, 19 Apr 2024 03:58:01 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91F98866E
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 03:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-69b628c4893so22526976d6.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713491878; x=1714096678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMYp41FFj0Ftq8x0n/AF5rFnG2uqxCmg/5NL4QHXTpc=;
 b=bA0rmYoqiinD8QTkVRgGFditOmHnFtUE1TAucxPQ0h+do8FYV1NcmbzZWlB7prCXrh
 LhsA43ObX6/zlBhnBnWRRJPp5ChMOratKwL2YwmKZ7o2mJG+l3OUNmDdy9t5KuqKLhRs
 JTUODgyTHHKNiEudUlkRksYrdxVGAFcwkxFCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491878; x=1714096678;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMYp41FFj0Ftq8x0n/AF5rFnG2uqxCmg/5NL4QHXTpc=;
 b=Oew3MWZbbXS8oCzIZDjp3lMDyOEYHLvYKWeT/WGLpjICY8OWyFSlfnofulmXMdRbKC
 0FGabGy1z/5Pd0d9uFz9rse40jNp3gUsOsd0Q8eihyrUXiWLvVnOBQ2YOCX9wAxmlcC5
 LPLuLyznmZADvusoFtHEIhe2Mw1wQ/oNbtD3CqzTGt0jxstiuhCq+ySAPR+Z2enpbvjx
 88i+SOOjySxHsTEn05lhTISnb7QdQYicbXK8W7FmK7hFZDrxWu4X5Uz5kjJorL+ov0X3
 hzLwPxxzIJxnPAJXc3VOAbLp3P30iWJyqKKhBnuZ4CAU4L55v3BHlumAujQqogqNI4Pi
 pMfg==
X-Gm-Message-State: AOJu0YwitMvqyAagIqkw8HeqHf7JP3sZ6ONU1F/ZoSCt+jdd5oG9HsiZ
 b5hnGO0D6z+mRC+vE02hQyJIeeA9bgzNCRlxAlkPB9QQqoU5XJ5UPS74ylRVFoZSiT62A29/kXE
 ue2M7lA==
X-Google-Smtp-Source: AGHT+IEbcMrGC1C9PDX2AySBFi4KkVtIdkdGMGSePY24fNQOxVMy7XFQdsL40LRwPiI+h1VoY8tGVA==
X-Received: by 2002:a05:6214:508:b0:6a0:5d02:f86 with SMTP id
 px8-20020a056214050800b006a05d020f86mr1699586qvb.29.1713491878191; 
 Thu, 18 Apr 2024 18:57:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 18:57:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Charles Hardin <ckhardin@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com
In-Reply-To: <20240412204533.83605-1-ckhardin@gmail.com>
References: <20240401191319.62652-1-ckhardin@gmail.com>
 <20240412204533.83605-1-ckhardin@gmail.com>
Subject: Re: [PATCHv2] net: add support to parse the NIS domain for the
 dhcp options
Message-Id: <171349187717.1524174.14190020250473347542.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:57:57 -0600
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

On Fri, 12 Apr 2024 13:45:33 -0700, Charles Hardin wrote:

> There is code in the bootp parsing for NIS domain and add the
> same support for the dhcp options as well. This allows the same
> usage of the data when the dhcp command is used in the boot
> command.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


