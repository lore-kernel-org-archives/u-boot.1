Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8697C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 02:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4348807C0;
	Wed, 12 Feb 2025 03:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iOedTxUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFDC80BAE; Wed, 12 Feb 2025 03:08:18 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB9D8043C
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 03:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f818a980cso54999025ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 18:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739326095; x=1739930895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QlimLrkogIHUyMkSGAoKh6t8UrzgegMxtGMlRRRzBU=;
 b=iOedTxUuSBiDj+LBPjWJa3gV9VXiJxPLICl4MViQ/CIVNtxI0Zvk1ZLLMZwjeVyPEL
 b+7vCUd2AFGFhr8jMOM/+fBPyfBKJBzWx9EFilF+sKqFr32IdOXEuHn9xooso1gbQTzh
 67FQQ9gWFuZNvyJBuTtL1RwhVXq6j9IIIMjS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739326095; x=1739930895;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6QlimLrkogIHUyMkSGAoKh6t8UrzgegMxtGMlRRRzBU=;
 b=lFBHXevD5O24O65K+w4jUQiPXweRtrRJW2WXplmEYWoekqPsUeLBqwWQC4Y4/kEkNX
 Jz7yNarYQdrd9vCPmF8vIlmVXM02i8qQW0DH6c0fRsOgg/Ilqno75flvGiugF7sAZV3I
 JY+pF/wbWo1VuMVJRydAXJT0qQy/zxGsBb041Q1HKKOo6RAHGAwFMxXOdFbW3PM3kNwu
 EmQgBXMzYTJBOGibk5R4eL/mvtKLWBMnTFoDZKr4TZ5Xowy0j56gpfwJ8qp2i3dWjZZT
 rmilyuGJiV2aYtt7Bnmk+8pibjIVbdYokOK5R+cUAA5bICC+n8wbtc1V1B1WBmN7PvqW
 KvSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUTZvxfn8N90jnJEINOWp6p9b4Oa86kI/uNDA2iUhUiiERSZ7GwH8Spuj5ENCoLoBk+8m3AwU=@lists.denx.de
X-Gm-Message-State: AOJu0YxxX08cuzEwDoaBfII4Dkgo3EaXJDDOKO1iTSVvlvBDQfF9plwI
 xBSB1BC77QyFRRzYuw0AWTEBUg8kRd2snn42TQ+n0QK+tVOEuwH/9GJcEcvginw=
X-Gm-Gg: ASbGnctW9wv0A9vi/rpu3jQjunc+4ycHNHdPgEg6jhUvlPWTKwQHLmENuDEYXUaOSf9
 aBxWTeZ0Ub6LSivnrGGFnykLqvZZkvGZrOB/Ysmdkagskm+QE1i7iZsL/V/lKx1rLE8dASiOerW
 +/xiIhq0Kyl/jDEXgSNnwfV/lH8YQznuONgPQXsS60+GC+JG5rBME4xWa5Frj7PZWEMZXmHJGE4
 uSoSdDUElRCITyhlp13J2f/10qvvT+qtlQwj1R0xAxgEnfN9TK1Z3pzWPC6TfcoiUYlyzGrEg8B
 L2hp2dDtGE1wBg==
X-Google-Smtp-Source: AGHT+IH6i0GBlozih3lPQJo5pB3ixNUplKedD3jrYYu89urnfchdhe/5916jU1EwM/8hGMMxCA/S8Q==
X-Received: by 2002:a17:902:cccc:b0:21f:5b1e:11ef with SMTP id
 d9443c01a7336-220bbc64587mr29649435ad.32.1739326094605; 
 Tue, 11 Feb 2025 18:08:14 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3687c6bfsm102618595ad.191.2025.02.11.18.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 18:08:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com, 
 u-boot@lists.denx.de
In-Reply-To: <20250204175844.19890-1-harrison.mutai@arm.com>
References: <20250204175844.19890-1-harrison.mutai@arm.com>
Subject: Re: [PATCH v3 0/4] Enable bloblist support on Vexpress64
Message-Id: <173932609329.124376.6896697583346498392.b4-ty@konsulko.com>
Date: Tue, 11 Feb 2025 20:08:13 -0600
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

On Tue, 04 Feb 2025 17:58:38 +0000, Harrison Mutai wrote:

> This series of patches enhances the vexpress64 platform by enabling bloblist
> support. It also introduces support for CONFIG_BLOBLIST_PASSAGE. This is
> necessary to boot vexpress64 and other boards without manually specifying a
> fixed address and size for the bloblist.
> 
> After this change, all the bloblist init modes are supported (i.e., fixed,
> alloc, passage) and Vexpress64 boots with CONFIG_BLOBLIST_PASSAGE.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


