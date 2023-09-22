Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC04E6FE2D
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 13:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76931864E9;
	Fri, 22 Sep 2023 15:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dBB2eAL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2F48644E; Fri, 22 Sep 2023 15:34:28 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9416186199
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32172a50356so2071827f8f.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 06:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695389666; x=1695994466; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6EUl2Dt7bC5Yo/FS4UWznC3CDRXwhQGhyx5o9k9YZeQ=;
 b=dBB2eAL0sZB8ZtMVAhlcWRm57GECHejVa1ROabG05HdQbuGHh1GUv/uaR2YNURaC2U
 YvDXyyamdADIfc1C7IgOcXPTYaQQiUyUo2D0jwEvB7KPFPO5SdVkCto3T6XKe58m4Udu
 +lWJdh65zPN6gH3GyHoDCcDUKR9XZEYfRam42t7Hmx/F/7FS5aS9dTfYeegit1qtsBLS
 /Ph0b2pPjT/ZW/+0B/dQkxPmlUNhFJsqb6zXJv1NJveCQXI3vp8sBcBmgv8iPPYYM5Rt
 +XDOlNkDebaC+xkz85FRyWmTIe2hiQkF8W5fZ/sJWBT18pHnQTGCKSxUcxyUNRpI7384
 asYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695389666; x=1695994466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6EUl2Dt7bC5Yo/FS4UWznC3CDRXwhQGhyx5o9k9YZeQ=;
 b=tM3X2ikGt6HUE809FpV7zP54MqqZcnlrvrp+RCeiQO4WJs0WmRE+EUOHHN19Qao1RK
 dXPCFsdeUG7a+OSQgDQB18r0EKbmxFBTfCmYQZxlBcAGRy2acfxlM+5rH+al+B8bUsTa
 I3cbYH46wbdfSGArNMKdJCNRMrSWi8V4Scl/1fal0jnQpUR1XIhacaud+Fkb4eqWNY2e
 IbGdbx0Ssgk1cNCCOpQSWN6tqckMEIVzYTOT6SbnU2RG0Eq/GNovqH5IvM4y2C5LoYWP
 g1TTxvY3QphXohpFYYJiumTjw9Na/zfVx/R1mIS+HfKQyZ0sAWh3fwgZZCN8FdjGDALT
 TLtg==
X-Gm-Message-State: AOJu0Ywl7klwjsjGiyXSXy8S04TZpkmjWYfIgSI2tbqLe50/MiA/ezEV
 u0V06c6WKyRAoBMDncBGRCg=
X-Google-Smtp-Source: AGHT+IFMV2jvIgmkmeFKJ4v9U6fXkI9P8/K57MQ/BYfQguw10RfkhPeDJBac5lh769LbdomR4ORZew==
X-Received: by 2002:adf:f201:0:b0:317:7af4:5294 with SMTP id
 p1-20020adff201000000b003177af45294mr6881049wro.44.1695389665784; 
 Fri, 22 Sep 2023 06:34:25 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.52])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a5d650b000000b00318147fd2d3sm4491838wru.41.2023.09.22.06.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 06:34:25 -0700 (PDT)
Message-ID: <cc74bc2b-d9d2-41d1-8260-8e9490e566a6@gmail.com>
Date: Fri, 22 Sep 2023 16:34:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 01/15] submodule: add lwIP as git submodule
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, goldsimon@gmx.de
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
 <20230914161828.3662-2-maxim.uvarov@linaro.org>
 <CAPnjgZ3tr5rqdPfnUS=5F19-7R9SU6fpe3F7o9+TghKs=m7zrA@mail.gmail.com>
 <20230921153949.GS305624@bill-the-cat>
Content-Language: en-US, tr, en-GB
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <20230921153949.GS305624@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2023-09-21 18:39 +03:00, Tom Rini wrote:
> On Wed, Sep 20, 2023 at 07:03:07PM -0600, Simon Glass wrote:
>> Hi Maxim,
>>
>> On Thu, 14 Sept 2023 at 10:20, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>>>
>>> add external lwIP library as a git submodule.

If we add submodules, they should point to mirrors on source.denx.de, in
case upstream repositories vanish.

>>
>> Oh dear...what is the motivation for using a submodule?
> 
> That we don't have a better alternative.  Using "git subtree" has it's
> own problems and won't make things overall better.

I need to raise a technical concern here, buildman uses "git worktree"
to save disk space (provides git functionality in .bm-work source copies
without copying .git into N such dirs), and there's this warning in the
git-worktree(1) manual page:

 Multiple checkout in general is still experimental, and the support for
 submodules is incomplete. It is NOT recommended to make multiple
 checkouts of a superproject.

It's been there for a while, and I don't know what the current status
is. But if we decide to add submodules we'll most likely need to rework
some stuff in buildman to support that.

Besides that, I've been running into git submodule problems in other
projects and don't like it at all. It doesn't seem to play nice with
even fundamental git features/commands like git pull and git checkout.

>> Our current stack is nicely integrated into U-Boot. This would make
>> moving between development branches much more painful.
> 
> It really shouldn't matter in that case.  Unless you're trying out a new
> lwip upstream commit, nothing changes in there.  It _may_ mean that if
> we want to update lwip it's not something that can be staged first in
> the -next branch but instead something to pull in just after release,
> but I'd need to see how smart or not git is today about things like
> that.
> 
>> I would much prefer that we bring in the necessary code, and that you
>> send a patch every 3 months or so to deal with updates, making sure
>> there are no code-size regressions.
> 
> And I much prefer something that will make sure that we don't start
> making changes in upstream code and diverging.  I don't think there's a
> mechanic short of submodule that will do that for us.

Coreboot clones some payload repositories in Makefiles (although they
use submodules a lot as well). Another alternative is having buildman
manage external sources like how binman can download sources and build
the tools it needs. Or maybe just assume the source already exists at
../lwip/ or $LWIP_SOURCE and raise an error if we can't find it there.

I admit these might sound worse than git submodules, but at least any
problems with them will be our fault and would be solvable in U-Boot
instead of requiring a trip to upstream git.
