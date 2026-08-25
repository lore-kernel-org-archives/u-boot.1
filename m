Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49666C61DB6
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 07:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEA5F80AF9;
	Tue, 25 Aug 2026 07:43:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dYPUZbS0Z02; Tue, 25 Aug 2026 07:43:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787643821;
	bh=MG/Bg1DDQ/CN6H6a7McZYdObOIbzazSLKEJciItASRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+R8AdrolCzmKYrSos3sWH0Oaw4f/nC5EL8z2IUuAEHO5uNvLkZOiSp+G7z6XQUux
	 hutD+8H673cO3qG/kqACnADLJVZS4bzWo0lLTAPpAGZvt+0UHa2Lxy1XN9AZDf6mI6
	 3He2A0DgiXBJ4kmxVr3LEu+R5NhTd+MRixS6KPyJAiMOxz0rzHpDZZxXZYByNcfk3R
	 3KBLJf1mJWGWBXhcHt4CDfDLxabt+OcYyizAUDwVnbITwu3NtpW4AmMyuSvOXZBAQP
	 C38wDcrgLzaWfYR/A1kQVLYVriKcNzbogvalCJR6+BUG4rxW4UPfThOm9CX0MzS4d0
	 rOaR/34uqL04A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23FC480C42;
	Tue, 25 Aug 2026 07:43:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31B5D279
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FA9D80C42
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:43:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RmOrmuhwKtID for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 07:43:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cm+onvJh
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E16D880AF9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:43:38 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so498625566b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787643816; x=1788248616;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MG/Bg1DDQ/CN6H6a7McZYdObOIbzazSLKEJciItASRI=;
 b=cm+onvJhpqaRkhzeILFE6tDj2VRLa97td/t5C6FCpW483MykhJJMHfW3qRK03ycDpw
 Alk4bSkZTu3tTGN+SsgpPfWbwZgFkZTov/HuZfScQUqNEawlTV/wGSn65QSU2ROA8GUG
 n5eTS/7ag/dsmsLAUWHQCwnFIbLtUO48bIus2WovT4f1U12FEFk/yo1bVtT3p3Wg4OkP
 qm+GU72tIm2JlGAPjFpaEqlQNzG13IScoJTW8nGVPM2YwppWc9G7H985b5x08Sp+J4US
 4GumPZGEUZ7fFvHQir4e8fmk2q2bADMjjfvMA4kBKhlP9j8XSUX2kbjxz8z33DjEXGH1
 fkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643816; x=1788248616;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MG/Bg1DDQ/CN6H6a7McZYdObOIbzazSLKEJciItASRI=;
 b=rEasbEfIQ2+5Ukl0g5l8qLNZJrYfYES3dELceY974xFEAz4bIT1Zf/NOrrObrBcM+7
 ZHh4Jh8veqwhsn+nmG7JY0Vix5wpKshG3EUT3kL8fUhcyT/Tu5gGBzwilAjZs+9JC81I
 BDdbREeGZ6+SGh6B6c5FqrQOf9F1VMjVNht4RlVJVMIZWAFv0ObDo520r5JSnSQVJyUy
 fx0tcWQjqY2Jm9uIfsWfu0/sqShGjU5OyWQVrIPEZLo7po9YxLlB7ukOMqPQrMDbfGeo
 t4FYrOQsAzvGkGVKO0V6ENSqVbGeZPK9qpc4fylyxrstlv6/YMWBmpCtqET6OxDxhQsn
 fl0g==
X-Gm-Message-State: AFuF++nl0An3tp5uLc9SWD6qx6inLDxxyph9yXFg42zDiBXFFBwnHs0X
 etz91OQjvZ80myyVbSFRCww7whRXREkaWbddIKr6C9ni0LXoUiv7JGl9rsUNnBAgjPHhHx+Glwl
 QDsVpcvs=
X-Gm-Gg: AR+sD129LnU4NxXuIHEDp6PauuHaHKDPSFCzVT8IfMTQDr3JGaerzJEpZo9fUneEK7q
 riGI9HCxL2vMxQ0QDdCS0CYoSwyzaFhEgAodZmMDwnLvg1+PaczWaiHQVgLFk6YlQU7WEU5Xigo
 5lRJXzPSP0pvUxukyK9Yq0lwayUH0AbI7/fuw1QU5hJCE8kWtwSm8/dmM4Ic9HwHOQ3FLQ35ef5
 AB5yAYIkIDMGTBVOtlTWa4U8+HOpG+R3EnmYMx6isXokE+aArSFYOeyoDoRDgtxzMx7zi+3A2W9
 SJJyFp6EX7T5ewj0961OII9mcWYYuBFDuX3SwvxVWccnAvl14t7bd5F67LHEReqL8v73aWtA3qg
 3HueMo6Sro/Ac6QJWP1OjCuSlGw8wDbHGv7Zcr5VUaBPIcwzG0pAdHi4AeyWFOsbtPPx4wdnwq+
 gZ2cYHJVWoACVSbbxrtsuLpyLxF5SKdQzNGRcATeu26MHH58q4vZjAxwtGzMJueFnfrs6NZWdv
X-Received: by 2002:a17:907:9814:b0:c21:792:8257 with SMTP id
 a640c23a62f3a-c24e5ad9556mr472752166b.15.1787643816266; 
 Tue, 25 Aug 2026 00:43:36 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:311e:ea59:471e:d426])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606bd05sm1565770366b.2.2026.08.25.00.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:43:35 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:43:31 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v5 06/13] mmc: arm_pl180: Power down card supplies at OS
 handoff
Message-ID: <ao1HoxujnepQYsSL@linaro.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-6-07ca794e2b94@kernel.org>
 <aoxHY_tS5pVSl1_I@linaro.org>
 <CAD++jLkaoYcUd56iddL_5E+gj4nE89srPpiwv7zCD2PDgAa0sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLkaoYcUd56iddL_5E+gj4nE89srPpiwv7zCD2PDgAa0sQ@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Aug 24, 2026 at 10:01:15PM +0200, Linus Walleij wrote:
> On Mon, Aug 24, 2026 at 3:30 PM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
> > On Sun, Aug 23, 2026 at 10:39:25PM +0200, Linus Walleij wrote:
> 
> > > PL180 card supplies remain enabled after probing and while U-Boot is
> > > running. They are no longer needed once control is handed to the operating
> > > system.
> > >
> > > Mark the driver for removal during OS preparation and disable its VMMC and
> > > VQMMC supplies from the remove callback.
> > >
> > > Signed-off-by: Linus Walleij <linusw@kernel.org>
> >
> > Is it worth briefly toggling the regulator off before Linux turns it on
> > again? Linux will typically need to turn them on again later during
> > boot, and even if not Linux should be able to deal with unused
> > regulators. I'm not sure it's worth adding such cleanup to U-Boot.
> 
> For our specific Ux500 target it is true.
> 
> But this driver is used by a bunch of platforms including some
> ARM reference designs, and also booting other operating systems
> than Linux.
> 
> Something could EFI boot off one SD card, then have rootfs
> on another one and the original boot card undefined in the
> hardware description for example. Albeit that sounds a bit
> stupid.
> 
> So I thought it'd be more clean to shut off the light on your way
> out.
> 
> But it's not like I'm married to the patch.
> 

I don't really have a strong opinion either. We can just leave it up to
the maintainers.

Can you re-run get_maintainer.pl on this series for v6? Seems like the
U-Boot MMC maintainers aren't included in this patch. I think it would
also be worth Ccing the "ARM STM STM32MP" maintainers for arm_pl180
changes, they use the STM32_MMCI_ID code path in this driver and
reviewed/tested my last changes (Patrice Chotard in particular).

Thanks,
Stephan
