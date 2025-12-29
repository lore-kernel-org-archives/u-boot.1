Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2647EE92724
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 14:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A609783E28;
	Mon, 29 Dec 2025 15:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SJj/h4E/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E2E83DDF; Mon, 29 Dec 2025 14:44:50 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD470838E6
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 14:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-29efd139227so119726295ad.1
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 05:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767015886; x=1767620686; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xvV1wmW4099EeQ4ktMBN8AnWUvS61862EZW8P3fgt8A=;
 b=SJj/h4E/G5H1JFUqwnsUL8uCvW+Ok96vDvsRXG4LN0gcsZ27ApoCE7+0yx8cmR4YIu
 1eVFdl/IoTLTeYdw5sO34Oafz09TbpFlA5Wt+0mlQideIvR/rUYFO1k1QWolL6l3dkMq
 n4m//whLjM+54pFypzXcH4FzVtBer9SmgeTh3iYvGT+ZNHAaS9KWyk04vsJfA1dcZ2/k
 ONrDzE1TmIiUTBhPLEJp8NiSEcm8Gc07tcKqvLurrU7ijsd8S0ey2QA/fgI3kzJ3vflw
 Oi3Ut2oSnX7l1PRaoJflRnY+NcOAyFPeBJda4CCYceVlUgmg8IdxqWFQI8eOoR3ywFCK
 ELIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767015886; x=1767620686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvV1wmW4099EeQ4ktMBN8AnWUvS61862EZW8P3fgt8A=;
 b=Grf4xgtvz88avJMf7lsruPdpmji0jinYcj9l1EpVPFlvd7jXKB0cTYOS8jsMoeT6Y7
 ZDN/UcVv59JO/UlT8nIuAUjGu5qND3KrF0zhs/h8Dv8WnB0S2ik0Btfot1xTnU/XldO1
 MtSRHQwBppms2Fpyk5MKAqPZ6LHPLQ1cLAsDmyam1lq5SIX18e13NDZ520zKwbOPPUqy
 HE0+BTRDBSCTq71hRUhSOe4oXZLRHPMY/+MznckgdIV+xE6mZ8gyzyUzrws6bOh8DtAE
 La1MRG4L20lB0AmIi/ki9AjvW+Z1exBIR/Ux3mmAqg4+DAHk6rYObiPw995GXtt9tWTB
 IpVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ2o5cC78ttixGS++pKXpdH2QOcC5MnRaeeAFO4PE6twJnPqso6v9RLulbnJkXLICNRLDv08E=@lists.denx.de
X-Gm-Message-State: AOJu0YxWdFcYVuGiYR3GZarGhbp/HkfZHSGbRwLqYQaWbrZRJzYjQmSA
 aVqizUXrvyIHB1oRTY7TeBMYOb/unSpjzVpOtVh9w1EiakFNJFnZI1It
X-Gm-Gg: AY/fxX4P+vzQyR3jo/4h51nPJuhyhenycm/Wx4L3YK2hgyDw32zyC74aLHoALCBH/Rp
 Q+MsCOUUgYw3UjMkgGu/gAuPGbIWqi5vu+yaIRL56a7dpzR3M1cRR8S5wv1KUN0aLaDZTMbV8Us
 RslR7OrqHi046YOzVa74QPQJyu19lzy26XBPZzo4W//xYTQu1OUKUEZXZWOvauUle8d9BPlm8f3
 ySumbUyn/NYv0vlb3uVHzZ8x+kSDnlrYLkr0xvr+qPcvNf8Zo+IbWkl5Bc7VYXX1S/8ajfFmQDD
 Pdm2drkCOlwG0d4YyqVQQ1+yX9gkiQG7I+4p8u1iybGy+rw/CLsK0b5W5DLI4xgFNmlyzRWhLS1
 B4+ZpwI5FI3uYEAIvcGkgtUG2RL9KNaI+Ff/d0RkwiU1jbH+t54umesPG5Yv3YdGMZde2ZaMXkL
 QtCZGgD0cdcxAXY7fkz78OKkr7
X-Google-Smtp-Source: AGHT+IGU20zSUzBbaZzz7H6YBUl6MGvzy/6aiBMVMWMxjD4X2+AQBpmtESApZR2ZYGQeo8UrdJBYFw==
X-Received: by 2002:a17:903:2309:b0:2a0:993b:d72a with SMTP id
 d9443c01a7336-2a2f21fc51fmr305958355ad.4.1767015886131; 
 Mon, 29 Dec 2025 05:44:46 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:39b1:7962:379a:1a23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c83961sm275858895ad.38.2025.12.29.05.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 05:44:45 -0800 (PST)
Date: Mon, 29 Dec 2025 21:44:42 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] board: Add QEMU m68k virt board support
Message-ID: <aVKFyqkgt_n_4qX7@google.com>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-4-visitorckw@gmail.com>
 <CAFr9PXnZPOw3V9vwxtpvkVFfjOt10ZmfSjY6yMLcFnGW15bvZQ@mail.gmail.com>
 <aVGBVwgr8528wTcn@google.com>
 <CAFr9PXkk_eVwFG4SA1BCB_S+kUoJHPSdsOJZK5bXB+=_an91Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXkk_eVwFG4SA1BCB_S+kUoJHPSdsOJZK5bXB+=_an91Mw@mail.gmail.com>
X-Mailman-Approved-At: Mon, 29 Dec 2025 15:45:36 +0100
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

Hi Daniel,

On Mon, Dec 29, 2025 at 10:42:54AM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei,
> 
> On Mon, 29 Dec 2025 at 04:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > >
> > > One thing I found when I did the bootinfo parsing in my version is if
> > > I corrupted (during relocation etc) the bootinfo this type of loop
> > > would often get stuck forever.
> > > I'm not sure what the technical limit of the number of bootinfo
> > > entries is but bounding this to something reasonable feels like a good
> > > idea.
> >
> > In that scenario, I assume the correct error handling would be to add a
> > loop limit and trigger a panic() if exceeded?
> 
> Yeah I think so, if you didn't find the last bootinfo entry within
> some reasonable bounds everything is probably broken and you shouldn't
> continue.
> I think for most real machines (Amiga etc) there aren't many entries
> but for the virt machine maybe there is an entry per virtio mmio
> device so there might actually be a lot of them there.

So the problem becomes determining a reasonable limit.

I think we can safely assume the bootinfo buffer won't exceed a 4KB
page size. Since the minimum record size is 4 bytes (tag + size),
setting the maximum records to 4096 / 4 =1024 should be a safe
assumption?

Regards,
Kuan-Wei
