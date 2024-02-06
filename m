Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F233C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 05:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36DEA87887;
	Tue,  6 Feb 2024 06:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BJPwtTTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC66E8786E; Tue,  6 Feb 2024 06:27:27 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67E287887
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 06:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4c042af957fso126189e0c.0
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 21:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707197243; x=1707802043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vs62gTzX4rbhqeYwanBX7CqrlYec5j8ZYSDncgb/OR4=;
 b=BJPwtTTR5/WuYQWgoTYUCWi/RZ1Qb6b2WTukrJOgaNAxQxO4euTnaVx+WFUTsBNVJi
 rEhet1b0K5zmOWfrxmdx1Og3iRr47v5SNwsjbp/23juixUSnG089vMYjvoOzGDQSTN1C
 MZF5707TJDvC4OYbiOVRSBq/eXD4rNCbe5edFfW9Y6GAobBZU7TSx63zNPnff73cRDKh
 +CapcVhTsO/sqZPso8v1b0POCQ0V5bxNLBHUUA6+QIndMpUY1nGXCwB/qAtu1orZENoN
 TYdJFQYADXb2LT1FoYr9yzBOp+p0Y2vgWHjC40S8FqEClZwBCKXMnCBqtSRFdRaM/oQS
 Imzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707197243; x=1707802043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vs62gTzX4rbhqeYwanBX7CqrlYec5j8ZYSDncgb/OR4=;
 b=Zc2Y2HO8a6qtMZ1l4W99ou1RwuMWk13nriaQ8F7F2oWQoRlmteNWEC48RPaNepxSi2
 XM402YLI/bfXgLxrwu5EOefKVfKBu9b5Kfapwq+WJWi3ZyNVfAVv3y8FlR0w0W4yTYsN
 8zo1yOGH9vZs0BRcbo9Im5thsr3WZObt/JVa+2Qai1q2YHQjhqPZb3Jz12uxpIX91FAT
 ppJYdnnUCFUjut3ZCKgSZ5VKS6m0mk5TnTBr14lS0eP11aoEzJstEKmTPoRWWHhP/Wh7
 Sg+kxQFHcT2dNbx7adVjyieCBg2a4iI2UCGK7ckotaFI8Sfzad78VIMuthYXOkUGwK8y
 oQTw==
X-Gm-Message-State: AOJu0YwhceAhz79cGG/qKIyYPv4NdvNSKq1e7T6FmJOmei9hxDO31SOR
 GPbdy2oFDGcDBKDc0oR195t/89om5tgMbnKr+I7zEZCAaAGCmVkqLqyn1esLUB5hewtKDKSxcsH
 02U25Wf/+cK3GSc8OTDVAgDQ0V4PlLZWjBUyw4A==
X-Google-Smtp-Source: AGHT+IHMKvD9PAhoTt4KezO7bu9FNq84kDYgqXAvdKGo9aGPV2w1Yeqc6Xh1lgCcdvKO5jmIMe4HGzsorSJXv3dibGg=
X-Received: by 2002:a05:6122:30a6:b0:4c0:3929:2748 with SMTP id
 cd38-20020a05612230a600b004c039292748mr2867893vkb.7.1707197243480; Mon, 05
 Feb 2024 21:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202180226.GF1152441@bill-the-cat>
In-Reply-To: <20240202180226.GF1152441@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 6 Feb 2024 10:57:12 +0530
Message-ID: <CAFA6WYMSvu0rL+et1Q7xVuOnyWMDbJYQj9TeC6c2ALNNFGhRCA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
 nm@ti.com, andre.przywara@arm.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Fri, 2 Feb 2024 at 23:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 02, 2024 at 06:35:23PM +0530, Sumit Garg wrote:
>
> > Changes in v5:
> > --------------
> > - Rebased on tip of master (050a9b981d6a835133521b599be3ae189ce70f41)
> > - Created v5_dt branch for testing purposes:
> >   https://github.com/b49020/u-boot/tree/v5_dt
> > - Patch #6: Added support to cherry-pick fixes in subtree update script.
> >   Also, used https:// instead of git://.
> > - Patch #7: Fixed inappropriate documentation update.
> > - Patch #8: Document how to cherry-pick fixes from devicetree-rebasing
> >   tree.
>
> OK, for v6 please push this through CI. I've started a run now to check
> other things, but just sandbox currently fails to build right now.
>

Yeah it looks like patch#3 rework in v4 has broken EFI capsule .dtsi
file generation logic which should be fixed by add-on fix [1] for
patch#3. The github CI passes [2] with that included. I suppose the
gitlab CI should be fine too. If its fine for your testing as well
then I will incorporate it in v6.

[1] https://github.com/u-boot/u-boot/pull/484/commits/d796c34307cd363674e0d0d2e31618643ac8e76c
[2] https://github.com/u-boot/u-boot/pull/484

-Sumit

> --
> Tom
