Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBBB10F9945
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 14:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C2A84105;
	Wed,  8 Apr 2026 16:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s/MecrDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB0C84106; Wed,  8 Apr 2026 16:50:57 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BC0840AB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbba5076c8so2415183a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775659854; x=1776264654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J+dY96nClOUZpFW6fDzHnYUI/l9Ky8hv97kGQwKq0n0=;
 b=s/MecrDFRYGWQp9PgrL1C+P1iiEzCFv1/n6dx7D81jgYeuhZjGwG6xPB3Jvw/8s+k4
 AR2Mao7Y7RD+s/faCrXua0pBTyoJ6tdOve8NzSTHlUweyEoYr32nauiDiWuxr9Aqj+kh
 dP5IRvsL+dx5I1+UQcqjvPi620QDfbhKP9qnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775659854; x=1776264654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J+dY96nClOUZpFW6fDzHnYUI/l9Ky8hv97kGQwKq0n0=;
 b=Pi+A45bw0SmOcpv3xNsPkW/GVsO6H+HQMGowI7PLIFn+MO1xtbIRJdGiLAX9zlcJp6
 GtArW1BmT7OjK7E/v2vCYM7IShHLyjdCgO1F1Gs9yCL9n91NxOUKu3Q1nCxTCcTea9et
 tnxkiUyrlrGzLiayzeRXhQllkcMqQuqRTK/cGqYDrFF8IV5545doZuW2U9YgggMu/Rch
 mbptAmk//q5VsqVTUHVEcOOiG5ZUz/Wj04DtHcaV8j0VVG+WyFzbud6thVUwI4quKaR5
 G+JghxputjjwSGdEvTUyJbcgwJaQ7N+vo0NwQWPNoT1s95K+TYjn8B9LruwCmw5pf3cF
 VT3g==
X-Gm-Message-State: AOJu0YxzSKiOijTAawZzk80ttYTWV1AccVHP3ahW5JuOigfgk4gLfIMl
 syCgLG7QUwI56cKl6e7BHQCjtpqgBeS7myMGGNGO0heDhmU7ZTYA9QphNYfzyna7dURB5zSIDO9
 7OCaM6Mw=
X-Gm-Gg: AeBDietgnu+W+iPuideUP+yL4dY3dobAmp0npgtxHDvBQ9hrHD7TOgmKzMiN+W3KKRv
 inIFcXK4sUrmSyiiZW8+BfmHaPbbzCFLe7wVn3A5dXQ7MWkC+DhSsQsiMc9w4LveaVAHL7qM/KC
 br0biBwGu14hyoPVHPX0RpFr3/tqoA6xfvmj7YMtyLitBX33RF34c7dAhKRxEzxLshqdWbB8ae2
 rb6IHRAF7GM5EGmBhZC6+LUazkmpHwV+sXj2CQx+Uy35Ab4RYkpI4KCqjLCyV+Zu2/U1a7TLFDh
 PSw1Whav8upN/WZVa8YUIYOL5jjIKADNspfoSDaNNvGYXLt3NiVlbrHH8Ck+lKE1F880fahiC2J
 EVSgzIK4vv0czU9u4N15zuZ86BcK+Z8cNRI8RLQjKZCjRwV+r8nJKiAfDfk/gxA33zA3BBMJvv3
 Ls05SMG1KqaG/PsD0lR/3bhrE2/C/0PAtaK2YW9W+TddlVfI+eTivSKsb7CvpBgNmZ2aCWflhGW
 /GYeTIuL7BIeHdRMQV9qlf0Aw8Bg4mZTkDO5RULhZCD0uU1bSgkA0lYVg==
X-Received: by 2002:a05:6830:2409:b0:7d7:c92a:1d73 with SMTP id
 46e09a7af769-7dbb73b3f48mr16383586a34.8.1775659853796; 
 Wed, 08 Apr 2026 07:50:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc081753f6sm1514644a34.6.2026.04.08.07.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:50:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260407164011.210590-1-sean.anderson@linux.dev>
References: <20260407164011.210590-1-sean.anderson@linux.dev>
Subject: Re: [PATCH] Update my email address
Message-Id: <177565985276.779397.17389305711307230329.b4-ty@konsulko.com>
Date: Wed, 08 Apr 2026 08:50:52 -0600
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

On Tue, 07 Apr 2026 12:40:10 -0400, Sean Anderson wrote:

> Soon I will no longer be working at SECO. Update the mailmap to redirect
> to my linux.dev address which I still have access to.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Update my email address
      commit: a724ec74947522a4424876aac9cb60ee8d2e49a6
-- 
Tom


