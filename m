Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71377D35680
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7E983F01;
	Wed, 28 Jan 2026 15:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R5FEfxVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4488B83EC9; Wed, 28 Jan 2026 15:02:33 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D046283CEA
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4095cd2b11eso507495fac.1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769608949; x=1770213749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8v/TIf7DqBFSbs/UQ71Uvkcg854g0bNs3L7kp8zy65I=;
 b=R5FEfxVVqCEZJWhG0AFgSiCUYccVDoWffYK38CPOjsNAl7unr8rNrWdyfDQWg8CKKP
 rshIEANoYVER5GnwRC9v7Xffey9vG9RfyqUwlVL6JpvuSpUTYaW4vfHVqkY4+MfxrJKd
 Vn0pm1CmCxbKNJh0HvVYTXkW87Wc/Asj0p34w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608949; x=1770213749;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8v/TIf7DqBFSbs/UQ71Uvkcg854g0bNs3L7kp8zy65I=;
 b=t/BvZwz8KYhrNYc4BAaoC7Rvnz4heT0HaziE7hmsNQQlAXQoTBwkWUBud6wMETjbTD
 SOUkA3c2e0XRVJW7zyQJbkUo2/YInXiYxIvCaR5ivpvbg7+YW0PvgAQ4h5BiqI+99pnz
 +e+tXm5LXFsE3BrsHq9yfGQcdaPM9ozJTDhfLJAFs7NJR+qkBuQTeifo7XZMdmu6psH4
 hswG/rH90JS3sOdzJLcH+JDj+JSb17RC2HU2+rHfMp3XhNum3Tpy+UBqa2OWDGNzYl6B
 PxeqtToRXgIXQpeOpZcPcnhWnlzC//AFE/OHlCYlxi6YRymmmIxZrjBDEmJOyieKkQmz
 MMiw==
X-Gm-Message-State: AOJu0YxPb1n3kWfvvJeXmGyg9mN/PURwwmBZGDtZGVOj4+L0pJ6kMEIL
 PeRwM+oRUW9YHYBUYIstu3/nwOj35cerELLcrd9dhBlC/lyBYFjovNuguRjR7NxgwgI164Z0J8w
 2mPvKqkQ=
X-Gm-Gg: AZuq6aJ2v3575mmdjqBtkBXAkt83l0FNc+qy54TDFkLhh3V3C9NRQ6YnHhN4+Z4lH0X
 D320egoHFFlO9cyLkArb3/hgoBwZMzGV5lZ85THICGN07R3Z9p/43Mo7pA3FgssY3ddMkICrwjr
 yzpIycQkeayD7BoTGnzk23nKvHa6jokx+Qk0VzE2gGzpKRO6ITIFKZHpzJTCoZXgeFjehlqYEXb
 mzyFsIdfhSkv8Xblp1Bcdou+Mn44Y+D6hCMoiRbFNksyPZm/DyUIR6Ck31Ahdgu6ukFktegfSX6
 +KVWN2IKnyEQvBBGxXD4rcim7qdAgM3iSGnx8dJl84J7pjkSew5vREkRzkb1MbFSIOev2v+w/4L
 KppBJNo+COy9FMGOzuTYStP9YS4XWOAITHAugxQfhh1xc2Pm48jEoh53Kv3/99JFTSxoBLofR1/
 p9iLvhmhOC5AvD0eMRrXUZ6C69m2+9FIHSYdNhOucgaz+J2rxjuVhnso0RYxUTJ0n15ZQjU51+x
 mnlGy0xy5oxS3eUYrJmO8g0iNfjE/NenCp6ZQ==
X-Received: by 2002:a05:6870:b2d2:b0:408:694d:ff34 with SMTP id
 586e51a60fabf-4093fc61932mr3719870fac.9.1769608947828; 
 Wed, 28 Jan 2026 06:02:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095749f332sm1751438fac.11.2026.01.28.06.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:02:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20260127220140.1370724-1-marek.vasut+renesas@mailbox.org>
References: <20260127220140.1370724-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176960894725.1640006.15683768644431017272.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 08:02:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 27 Jan 2026 23:01:24 +0100, Marek Vasut wrote:

> The following changes since commit 431f1ce46bbffff0db8f03437a34400b11b30175:
> 
>   Revert a number of incorrect commits (2026-01-27 09:29:59 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


