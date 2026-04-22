Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F34FA1FEE
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 19:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8731D8439E;
	Wed, 22 Apr 2026 21:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WbVirwzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C6F8426E; Wed, 22 Apr 2026 21:51:24 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102A88426E
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 21:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcd689829eso2176715a34.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776887481; x=1777492281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgeYS1Kp0f6IlVNN+8kUPFb9feC9115+wv9Us3UTFag=;
 b=WbVirwzXoVC7lNE7sPkFPMfn+YgVJypl0zXsWozt5Vt/S0QpsbKT8ds76LujeLIDqa
 BqfZt7IH4UTOT8/ivu5td+6ZfWhg3JZeBVrAeB5u5UutrcSP+1khvlXatJ1Txjjmw8LR
 OGZV7LWSP0dSZHvereDfJojiRAr91Pg8zDmLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887481; x=1777492281;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lgeYS1Kp0f6IlVNN+8kUPFb9feC9115+wv9Us3UTFag=;
 b=I8DhHde8i6dIF+HI4XVUZayUp9gL8eca1aq6Z7nCXrSYTXrC6uCzXLJB2DsQ5siIJ6
 a/b5aZXshavvsOzvnj5MWad93uE+77EJAWtb+f/4JT1gyVuyahTEFWZ7+0iHVrrKUJqT
 ozFbIAec5JOjdy61pnOHe+tvSovdRyESwtUciQsxQ88xR+MrvtYOJhyWo7s5VzEaKt+7
 33WwqqSbIf9Oll9Ta5lnvL+TnqdCzz0fo29zIVsdpDeBjb8jv+FgKeju8HTebhLW/CKV
 ll+/VoptWSJQVE771945t5lmoyxHRvxGhJMvD80SrNLC1zuTILesRSqL2Vj6tDH4qwdR
 BkaQ==
X-Gm-Message-State: AOJu0YyqFpyge4FfGN3iLqR1ncNqnXzNFeXLJIVEhkgJ+AIqM1+69ecW
 wfZjp9gKgLq/mbsPu7ZlXz6yasgZDQgKO+IgjhQfEDkquzKDvoWGUZs/kBqX3VI2kFo=
X-Gm-Gg: AeBDievUSYnaVXjZfiz5cParl+tno0TYk5ntjpmwIvoMcoUOIwKX8wPuFJsradxbhGb
 yFLWAObylN5/3XIxgKukGupTvMKZC2wjeFkCXMN35wXEVJOwxjz0tBkRnIBP8eDgtZJTqSO6ZDt
 +kkRu4XGn50ItVsyDmhh7VGHcyiY44Xbl9EXW7znzTyoS3lkPW1YQ1ocZG0fANAhbCxt1Am9cWU
 XbqWWS0mbgqmm8dC594F/aZBdV8O0ho+a67aEEtcT1lT0QwdH27XNWcsW/BNPKpW/y5RvcedS04
 4CvOJ3fblHpyMXX6/IsUqMkrgXAc1j3J7M283g+F+6R6Ky+c9dYlOvP8sEVZHNJ2DhWduuraCqY
 bVzLRQDCEd4vRbtw3y5AP+WJPLp7uCfas0vCesG+vd/W+Z790kiDUG03rIb1DutJPH1nrD/KQwR
 MEOFEgOFApRaGcuZgjPBu2S80xRLUYmfp32BRJ7L5FIj94MzzyBH9g96FDEo0+7+V0IwR0R7u34
 CXJhKpTYkKQrkY8qcvztLmbzhI5PzWuY+x2drxEdn4/sk73UnQ0ttDBojrQ
X-Received: by 2002:a9d:5cc6:0:b0:7dc:a256:5e2e with SMTP id
 46e09a7af769-7dca25660f5mr9563231a34.1.1776887480809; 
 Wed, 22 Apr 2026 12:51:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dcd9a0847esm4963542a34.17.2026.04.22.12.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:51:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, franz.schnyder@toradex.com, 
 alexander.feilke@ew.tq-group.com, cniedermaier@dh-electronics.com, 
 emanuele.ghidoli@toradex.com, peng.fan@oss.nxp.com, primoz.fiser@norik.com, 
 simona.toaca@oss.nxp.com, ye.li@nxp.com
In-Reply-To: <20260422014627.1870805-1-festevam@gmail.com>
References: <20260422014627.1870805-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20260421
Message-Id: <177688747969.1917521.5957258528932035654.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 13:51:19 -0600
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

On Tue, 21 Apr 2026 22:46:27 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 052988aa29bfd506d7ce207fbb3f5374a5dbecbb:
> 
>   Merge patch series "Linux compat improvements and CCF prep" (2026-04-21 11:21:59 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


