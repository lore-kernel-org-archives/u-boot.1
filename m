Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FD3CCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464738362A;
	Tue, 14 Oct 2025 16:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ivojje16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EA9D809A5; Tue, 14 Oct 2025 16:20:37 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DDB834E5
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-36f51ac0595so1484718fac.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451634; x=1761056434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AGBTq45BgB3ypEeKqmRHVw84/GYqVrKvhzaaqsXW4kc=;
 b=Ivojje16qJ217uiZ/KHEFAHcLnsnHeVHSOPV6wPGdTuzwuKJeF4vuWeoXf03COs+jB
 rF4C9cRkhR0Wv5UVttButeVaQGxTvSDJZI/cC7ia/NA+55kkGOHoUJ09vA/DF8eizBRJ
 FU5pXfDohctVOOznWLKBxd+QW1oGt9M0vlKD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451634; x=1761056434;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGBTq45BgB3ypEeKqmRHVw84/GYqVrKvhzaaqsXW4kc=;
 b=po3+6L/3JWQDYqq1OV1mV2g+PJH89/PxaGiqYiyus1jSv0FXUMkb8IoI2PeA4tb6Uj
 tZoe46Cs8ukDa1fMv3asjT16MzojyGO0ky/+NkF+vO7RoLUMH/tRMUBsYY8k79nQmpvJ
 +6jTHvvmXXkSaAA4rA1EpK+zVgluxYuo1L551P5iaDHR/j13G2RmbynU+ycyielnbxHP
 AooVtNJ9StnoBQ0MJdVTMG4u3RSoApisZVyKzyGA8ZJ0gQX/7jZbmSHXdzSbvHqPAYzF
 T42VDQ72XaM6yV8kKjr9DCXDL3i3QzhV24RlveY2l2bytati/6/1llqxhmYZbhaCS9Qs
 I/2Q==
X-Gm-Message-State: AOJu0Yw9hmZWQgDL3dqDliHzBMDYtT/Mo5vPeQ1a6N+e49UU+bTj7t1a
 oT2Y1k4mrK9IgrMUh0sTAsTWtFmxN7eMNI+ZMjOljgE4dPY7/HEAAc272UvKK6IeEZhcAWOORB0
 IfyevSAQ=
X-Gm-Gg: ASbGnctnIZuzdLLpsEgm4l8po03P5oZ77OCcbIav/ud1V4iv9+GFkxzXl87SOLzFkgF
 SKR+WwNcGX2QkM6kpyIdLdSaNP+xKLYCZQDeh8LIJ0FwSlwWE9Fc5QfHpm4EDeCj/ZNlD+KZo97
 oA0NCWK1TIY7D6HM7Qn/RKKeIjbJimlnD+Tu2GSvXICgEXu3GDp/Nh0LVarCVuq/7rPY2IeK9ls
 5C08+MHuSf5deWxdPun4ycdEcNSp0ZNgAkaH3FSxr/ahyswO3wQgxHNQ2qUwtw5pty0/05vlqMP
 4PEMSPweOWC0DB5EmUcwmaSWgmLy1NvPEKWgvYYg3fTk9K4HMLhyVjo7ONrGd2i5ABdbVWTiE93
 mwbQMbkxMKbXUKotKHVvisn0ECxYpGVJMeHwh4WbF3d0ajyEa74V5DT7MN2NK5BtZ8HDxt498RT
 aTqMcKBDRzbqXGyVQ6C1Ue1Fep
X-Google-Smtp-Source: AGHT+IHZgJBW/OLDvqy+dE/VgxFqV4QLDesgOlhrrBQWkf2gexM5xuImvyBu0FgWNJbRFyvg7NxNUQ==
X-Received: by 2002:a05:6871:582b:b0:35b:fde9:2901 with SMTP id
 586e51a60fabf-3c0f62f9570mr10662791fac.18.1760451634090; 
 Tue, 14 Oct 2025 07:20:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251003203930.1030078-1-trini@konsulko.com>
References: <20251003203930.1030078-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Make REMAKE_ELF depend on !COMPILE_TEST
Message-Id: <176045163331.284655.14779435498257706598.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:33 -0600
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

On Fri, 03 Oct 2025 14:39:30 -0600, Tom Rini wrote:

> The REMAKE_ELF flag is something that should be selected by the
> platforms which need it, and not prompted for. Start by making this
> depend on !COMPILE_TEST.
> 
> 

Applied to u-boot/master, thanks!

[1/1] global: Make REMAKE_ELF depend on !COMPILE_TEST
      commit: 6822583672e21dd84eb1c5bc2cbf3fd93f181d95
-- 
Tom


