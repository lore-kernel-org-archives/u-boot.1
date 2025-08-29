Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A2CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 15:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 039788367F;
	Fri, 29 Aug 2025 17:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k1Pxv7Ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F0883689; Fri, 29 Aug 2025 17:12:45 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6826283675
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 17:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-437d4a31cf4so83999b6e.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756480361; x=1757085161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWDGhEjOcc/AfK6CiSI1yPAlUZpKpC/dyscsVs/fils=;
 b=k1Pxv7TsSCUPL7AClqVNVUx6hRsTdBtr15PfH0l8YXAOlMVsx7LMLGO3qIObfmD4Zv
 7WC/mbCxOlPtMR70oe/LO1Oftgyxc6kt0Va+AzSfA4kP5AO4cn2DUdzQvrqNRKzozLNr
 BrHu9/M5eiabDPoHssQtVEyKjU56nLBHgGrNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756480361; x=1757085161;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWDGhEjOcc/AfK6CiSI1yPAlUZpKpC/dyscsVs/fils=;
 b=YzewkRze4jS/QO7jsu8UIeWaaRHd6HwtIEJ4DAJc6TuepyvkZUAtNidbzyj7QP7jQt
 rrCvA13ctPBXrQN6/CQZkGRKzsVWCLuyiOwbJy9ME/qieHAj5r/ZPwpX5+BN/lkBulXx
 IxGbdV3Yl+tveQ+8guQhngy/d6JH3ygaJgUVXwTwFowEjXxrg0dAJIFIIh2WoZSxkpkh
 QUXiViLZSLljPAIfPhbt/kvyvZa0fQeU7jZPsdK1BgDE8AfMX6eTsXtiKTz+yqOme2co
 l71RIrK+ineMmqqIbhODoAC7KrySD2aew+dQMAqB8bnOIx+vDbgookbYA0BQdV39fFQY
 Gcag==
X-Gm-Message-State: AOJu0YzpYBcBo4gGPDEjd92KV3aUvknx4bQsjCADgEvtaKwnmUffdyS7
 c82HPHD6yIb9oFHP4yCStQ9bS5uc53uxPqmazWUEOQV1myS1UUZ+DvOBtBpjnDJVn2PUjE8URIr
 mvhrey6o=
X-Gm-Gg: ASbGncvxNCZULzKfC1YDJhqF7Mh+p+s7lPLmymAZoOyLJQoMH7C30w1b67JgF58DVFz
 JMGnrZTS3nsrtgcclr1JEj5adliy3kx2lN3KKun1uW4f4CUyqGV/fRoswrbochLtiXF1/3LA9iP
 UVps7RxR2Jq+Gkg0j5jNePhWN4ZZMypxrLNnsJQKVFYWWdvmXO5d8Op1KlNzLuyS7irqBVPScLf
 EiLcqEAlZXVLO5VSoWCJ58vxQimTubzhAE0Kv3J7EHSgD5wgc+x1cChzw0r20c8NbW+tVOUdgg4
 L1HeDFy+a/3e54ImEl3hX96whp3+kZg4vg8J58g9QjLJsHV00NXQcxaA5bOdbk+OYcSSTmY2CLW
 HYlIYm7bxiPtKHbrxFqki625FFH0P9PKGeb0hleThTIiJq3KBzKjgex0=
X-Google-Smtp-Source: AGHT+IHRlBfFGIoS1WMz0n1qcpT0QcLh9R0bkdaqUrBefBzLe8Xbxjl6VQIJb3rg//+BZFw8mk6lWw==
X-Received: by 2002:a05:6808:448d:b0:437:e1b0:e969 with SMTP id
 5614622812f47-437e1b0eae8mr2508768b6e.40.1756480361025; 
 Fri, 29 Aug 2025 08:12:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-315afbdb61dsm1388136fac.3.2025.08.29.08.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:12:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <f08d1d44-2bbb-45be-8eee-d81233e73c77@monstr.eu>
References: <f08d1d44-2bbb-45be-8eee-d81233e73c77@monstr.eu>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026-01-rc1
Message-Id: <175648036026.2107740.1857252832587775599.b4-ty@konsulko.com>
Date: Fri, 29 Aug 2025 09:12:40 -0600
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

On Thu, 28 Aug 2025 09:05:23 +0200, Michal Simek wrote:

> please pull these patches to your next branch. The biggest patch is around UFS
> which has been acked by Neil. I hope that mbv in azure CI will just work fine
> because I am not running it. Please let me know if you see any issue.
> 
> Thanks,
> Michal
> 
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


