Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABBFC79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B949A811CD;
	Thu, 10 Sep 2026 20:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oVfyZpSJTMeH; Thu, 10 Sep 2026 20:50:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 076E0811A7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789073415;
	b=hXFMRh/B+hVYavFp9mhfAeRgZXgLDGni8ki1dPCNyPlYtGSF9fI/eh+J3Vsyc6igl/PE
	 Fw6QfTgxwqMbRH4SmLxNTKaEzEJgBsbY96BFukou+wtEiM5KPqCqrXVXDm1VjBq+9y2bD
	 B/CGJI8JrMy/hzR1XootbCLE4zwjVVMBr2Kv2hWZsHVVT4lh8OiqWp7lVUf2xTaSwxaBp
	 WBEylY01klwzFEek1oyzr98FNN1EjZXXBOaNq2jfAiXtmFqKDMjZ8WmrREvoBu5fdtWQV
	 5ZyeT5XNvNIOoHpS2INvNJnpxlhJ3MN8FjGdOnxUKpMwScmALHqVxRy978o4++AsCCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789073415;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qLKk15vi5XeTVDOh9JkpSyFFViPYys4glZ3QByd1TDU=;
	b=IXiC92dkiHNAu1tSs/qZDR4uLbm3BBw2r+5a4DJPl3d12rUum/M+VrNwepc7vD8fCSh3
	 LOhK/BHlrZCG0pOgZT3FE5EGHJeZh+1ymdkd+dvai44VzzQkLKi8G3hA6Ma8zpSgo7s58
	 bOinyr81r4IrfxZEUqeCEVUNQ2YqgUZ4ko/iwzXRexmAuRpWW3HBZNJ/335faFgZps/+7
	 /pIpisN9e44Tq3XWpN8ltCdeXOA8db0XmFAqM2DW5X9wyk1rj33H3Kepk+aZ4F2eUDhsZ
	 kI41bojsJASazi7Dq4rikPRWCoSUIxKnEPIYC8CG1vX+Ku/ngHPSQuDY5amZqNXKTmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Y2KLdn8r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789073415;
	bh=qLKk15vi5XeTVDOh9JkpSyFFViPYys4glZ3QByd1TDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P5Ga7y2fUMXBBjKRwxPTd42hidXaYu8eXFckrg3MSw7/7vgM3mybX5XZ++apQ8Fp4
	 WykFn3ovc6iejCXvI3WosoWYQPruIQ6YisVyet3x+GPZOXJgcaeiOMZcOPa5AI2drS
	 sxUGESZs+2DO7oIvsLAR+J3wV9F4qa6iADz2Dv8nNQzNhQhiLhAcFLbPYc9K+EUuaa
	 MG61JYttnodf+6J64uwa+h2FJO3W7XSWCwuqrCbyoZFhWv/gEn84jcNxwogQATu6Iw
	 aDhjwTVMYDKpbw+of89yULNEzSmpEg8D8AaSwtamsdjxe4O4ecbtcIMpcep0caEzss
	 XSKK8fH7MhpVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 076E0811A7;
	Thu, 10 Sep 2026 20:50:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D85D362
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32E95811A7
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pRipO7lUze_G for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:50:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BC3F681187
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789073413;
 b=bIxLBRNLGDEu+tQUoTnCFw/i2tUdgfS69RlIEymI91gVQdIwTeFcB0Znk4lVAlQbAw99
 G56ktMs1ccx0E5pRn0nzE1+I7vyN1ou8GQMjkFVZFvMda7B8mqgQ0kkKnZqXopk8xZKgm
 EX4LIA0GfV/yTflwblbt2YtYhGkCCYAT2Bu0YC/8UoWHkn/Wff50+svMo8du8s1P1biDW
 diR/zAXqeJcX/0rzLM6ii0E8VaQTIGxstkqFAKtPmdiOFSkWkBnhDj91QukB71vO+obWp
 2EerjX8fUu6lzVR4zIBJ5XkQjRWfqi9IJRTVYNRd9NuYFkiuLpLHDFBEFZc3hF1r6hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789073413;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=qLKk15vi5XeTVDOh9JkpSyFFViPYys4glZ3QByd1TDU=;
 b=HKTbC/I1MFNNMRzHL2PgQxPVdfNnaMAgdvg3+BiNk7RTmUiPHMPpZ4tblHwbi7/mCViE
 JeFfO76s9HkKCjqewIfLTcTbMVbvPXqP3nk0LePNT2iyPRxky0Y96mKGxsFwVzcBrHrPL
 /YoMQoKH+TE8MCIJQJW+DQBpniJ9ITxtXMDb7/Gp54c3RaPVeDVmtZOmJt+mQEgw4G8sA
 EICt6fYfcekmiqnQvBQHSMxeL0TsTlr3vwXWz3kc9Lqx4dFblTQrGk/ezpBrNPLBHPkVm
 8MXjRLVDF7QmdB7g5Luw7g/E45l6gSuCUz0uyHTkjS939niOe1TzGJm7NRoTHME4dNw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Y2KLdn8r; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Y2KLdn8r
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC3F681187
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:50:10 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so1909515e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789073409; x=1789678209;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qLKk15vi5XeTVDOh9JkpSyFFViPYys4glZ3QByd1TDU=;
 b=Y2KLdn8rgGj+7zVjqETqDpvoxPDbMb2cPPYQHM/kct9Xbbgt8ndwM6ojCXxjEA3ZZx
 5MvMNEqOpH2WhcMwF6MucJL8rtGXDPoCyVXkYnOoPAEp3qE8qoLqk3u6sjrwXiIys1fG
 +fo7du8IQf0EqQ93eg2PHgopdldDUSz2N2IYrkr4WmlJpsRXSQ4Blnyj9iOwTFf7i/RZ
 +oJwVdAHTPcYPv1SS3wruf+7F3q1rTc1rXVok9E4BjQh4DuAO89fIrQNcow0kA/26kua
 OxNAo1e4TajlBFE3W5U23KGy4Ob2o5aJ3eSWiGc+0c/qIC5ZJ+j4Oh4gd1uDsPZvNyvs
 sGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789073409; x=1789678209;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qLKk15vi5XeTVDOh9JkpSyFFViPYys4glZ3QByd1TDU=;
 b=M9T4sLmKczd2e/KG8ZAyyzPAB7sdV4l2sJVJrHgPdpNhGy5xHz8ov5EM4snEAeiN79
 HuWoHPWk8RiD6a0LT224iKHiEYJ9Hg6myT7DfxzZaquxYRaAnj8bZpLqYLqkY+vDynSX
 NXYL/gxzrDqQWwQgqq7BKMuaP06p8raNxttRTTGO5aQ4n77lUe82sAFUozlAERgu+IyT
 +8l7gHbLzwhm+VNQDFFvPap6x6Sq9AdjUs3pwIKZgGKoZ/BEOJn0raDNnDuKdaPwzxVe
 YDGzPBbKTIuPOm5IIxax2tgj4+vQ9uZrOks+sjTBJflZwHQ91Wyd94x9Sz/d0Hx2C1t+
 7k0Q==
X-Gm-Message-State: AFuF++kc+da9+Xca3fhNQdk7NEwL1NF2/TYyMyLEAc6QDXvLYgo5L5kn
 LWHPFYw9q746BT7Fx8MrGmBU5p6eFVQ3Mr+WEKypCeQAuTVa7YVOFlFTZO5+lKFps1o=
X-Gm-Gg: AYBFou1uCYMBodlMAgzLSMFZ2dmy8Im5GAnkQURAimm5fjZwzLklGyKnEb88JUU75CE
 rMoFTauie4H7mKT1KOEPJdqEEflvETDxkVw48B77mZrRttFPtpfUyfvkAdBkwkGw5MuJauG1kX1
 oxIPY0z6z4AWoS7edDt6htdJHEj6ad7d9RLrrT2qTmy5u/GTR0LoeUxBLlzUY+2YCRnGPL/9t1w
 gDJoChicDX0qXEzVZSwxQLEyPR/bS8RglOCfmYgHqvPDjYM6uWZlrbZyRhnM5lezYdAq2MWWKyn
 uSDXd45a7z812t9jdrOySxQsIC0d1DWZ4tTcHKue18RGYU5Vy8JEPro0xoYeGB4lEkcaiPsgwkd
 ekqGyEFaAlzGzcKA0/0CXiZzSwIE/fXy+FQ1P4bpHN5pkPkszyXFnDHILvYICTR1BacuMnEP5Xl
 hqfAqUgwlHeCi1YDTKRoqNufEkEhdV/u79aQnikIuFLBVDsdBlKGvVNHu1lrMCcUMU3SNBwflQq
 FmG9WT0SEMPqjTVzwA2tGeJdZDh653JOHcyuoDPXBdYTMuPonZnQ5G7IW6oliRetyTf2zBDDd87
 fH66uVFa/V+fWA8=
X-Received: by 2002:a05:600c:3d96:b0:49d:72d:9ba3 with SMTP id
 5b1f17b1804b1-49e619b5dddmr7702975e9.14.1789073408861; 
 Thu, 10 Sep 2026 13:50:08 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ad0614sm20668045e9.10.2026.09.10.13.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:50:08 -0700 (PDT)
Date: Thu, 10 Sep 2026 22:50:07 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?B?Sm/Do28=?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH] spl: mmc: support board-selected raw partitions
Message-ID: <aqMXhBA7IX_Qz2RW@macbook.homenet.telecomitalia.it>
References: <20260910-ccaione-upstream-part-dynamic-v1-1-381414ad9a34@baylibre.com>
 <20260910183728.GM1764417@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910183728.GM1764417@bill-the-cat>
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

On Thu, Sep 10, 2026 at 12:37:28 +0100, Tom Rini wrote:
> On Thu, Sep 10, 2026 at 07:49:29AM +0200, Carlo Caione wrote:
> 
> > Boards may need to select the boot partition using on-device metadata,
> > such as A/B slot state. The existing partition hook runs before MMC
> > initialization, so it cannot read that metadata.
> > 
> > A separate dynamic-partition mode makes this policy explicit while
> > preserving fixed-partition selection and explicit requests to load other
> > firmware.

[...] 
> This seems interesting. But, looking at the resulting code, it was
> already a little bit of a mess for
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION vs
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE and it doesn't make
> sense I assume to enable both at once, and now a 3rd option. So, can you
> please think about if any of these would help?
> - Turn the current two options in to a choice, then see about
>   simplifying / clarifying the code. Then add your new option, and
>   hopefully keep the newly gained clarity.
> - Restructure things so that we can have a __weak function and override
>   it already, as I imagine the metadata here will end up being fairly
>   implementation-specific.
> - Move up the mmc initialization to be earlier.

Agree. I have an half cooked version of a version that moves the mmc
init at the beginning. I'll polish it up for V2.

Thanks,

--
Carlo Caione
