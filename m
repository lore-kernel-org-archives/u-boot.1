Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B67D2CE17
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 22:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B352D839F1;
	Sun,  7 Dec 2025 23:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RIa0LXjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB9583AA7; Sun,  7 Dec 2025 23:19:47 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BEB583A5B
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 23:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c7aee74dceso1501781a34.2
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 14:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765145984; x=1765750784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCvql8aH+/u0RlPO4Gr1EqLDPwMwXs4MYvT340nU+Ng=;
 b=RIa0LXjvTzMKi0Uaxc6BwkmImdEk9gqR/cJVTzCqkSVJpEMKGnGttxLZO3oMTH/K1L
 G9xHkeVsL7aT7osCGTW1ls63fb8dgtAsHGZZFFiq6FjPAhj0jPiKitBKiDPZpiWvgC1v
 ly4HnZEV+VZZSivkUqnv8mwFIoY5zdfrqtS+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765145984; x=1765750784;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oCvql8aH+/u0RlPO4Gr1EqLDPwMwXs4MYvT340nU+Ng=;
 b=CrBeV7WmUYBs3r7wxLIYe6ikXzjJYJWTHKb5ybYDmIt0JqXtIYE+MXQaUfn/hcte4p
 5iQ3F035fjPCnZq1Zhh8u4bIFlxSqD4uXdnsWgf4FU5iy4zzDgaqhwo+4jW5/vTRwK1C
 uuHsFdC+RKn/TDz+2zMPfb6MK735ZLZ2oo8C5rPdVOZglEj16IPvpnLLPut8OHTEBjMW
 kS6Lo7vdYil+g0QkY+JGi10TDaw6I3rvRqt6agb4pnczgYabtQULaqjpOXG7AxeTLdHC
 L3xh0qlqD71mx4n9Q3C1xqfuz7Tao2yuO69DrAz2RYeFeMaL5l/TYm6jYxnQmAaDHUsy
 +Tcw==
X-Gm-Message-State: AOJu0YwgukRR3VUc8ZDQ/H2qWDPdhAoVuETsG9QPucXXWT0hJwC1NPsU
 HoXSMVcxAM7FFGt93SNAlQDtEYt960WNOmSkuMhd+ykMFS364E7lzBvc4OxdGi+8iQFlFCH5bUf
 u8tuSEXY=
X-Gm-Gg: ASbGncsLbzjVZqbY7lZ+9xdzetzi1iyWkoG33jVzWXm0+PdZ4oAbA4ZvnMnlbVoJ/kC
 yn/VF9AeqO0B/eg2VFFbgbsX0Rr1ulpA5HveDh/Ws+qLK7gGI9Z/RSFrmiB2fTZ1alJ1dbzK/VL
 ODicwohxOVlVxmo71JPL9MozXiW7TlWrWxKT15GNGLUdDhUpoO2BgEkLPAGkE/4VoRiNu5wqJGQ
 7itONRnhNSWu9wrJXvG6QNBTzE7Iz/l5D7yj+VyYI2uZtM+591tIs+un8pTOoExJ3+HJRph9eQo
 NZTPcK0wLBQFtM+bfFpmCw8NuWXQ8AfK9Wy48WQ6Gf/v5kiE60lRz/N4P93wUwGoCVl2InzHuB1
 5a5UiyG8DgrcNvHkGxhEa4l0TY0cbyPFXjB3B68AFCkKXCuC2ZMBy7c78xUykqqihZtgCodlJ46
 Feqx4sz6nOE1vlLvqgLd0XS8uGEe7c+boo+6SRcbas7o4c2TUg61Bp2lttPx4=
X-Google-Smtp-Source: AGHT+IEpacuGYp6wW+yMxgyFC91G+TnzA1jqME8dKVy6NxmxiinAq4gRxCnJWlw39XU2i0CScqeG2g==
X-Received: by 2002:a05:6830:2e13:b0:7c9:5c77:54be with SMTP id
 46e09a7af769-7c97088f3a2mr2482594a34.27.1765145984038; 
 Sun, 07 Dec 2025 14:19:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acdb599sm8634803a34.28.2025.12.07.14.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 14:19:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Daniel Schultz <d.schultz@phytec.de>
Cc: upstream@lists.phytec.de, primoz.fiser@norik.com
In-Reply-To: <20251124082506.3376876-1-d.schultz@phytec.de>
References: <20251124082506.3376876-1-d.schultz@phytec.de>
Subject: Re: [PATCH v2 1/2] board: phytec: phytec_som_detection: Add
 missing assignment
Message-Id: <176514598328.2987146.8251805652963023263.b4-ty@konsulko.com>
Date: Sun, 07 Dec 2025 16:19:43 -0600
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

On Mon, 24 Nov 2025 00:25:05 -0800, Daniel Schultz wrote:

> Assign the return value of snprintf (total length) to a variable to
> properly check if the string has the correct length.
> 
> Currently, this variable is always zero and the length check after
> snprintf will always fail.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] board: phytec: phytec_som_detection: Add missing assignment
      commit: 9ce3d264e3b79b91d997eaa89dcd51488259c2b9
[2/2] board: phytec: phytec_som_detection: Add support for phyFLEX
      commit: 7bcf0160901970f4417488982199fece129567b4
-- 
Tom


