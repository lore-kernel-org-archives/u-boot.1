Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D383C5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 21:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BE8680F42;
	Mon, 10 Aug 2026 21:00:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BNIQEfBRoG4P; Mon, 10 Aug 2026 21:00:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A718780F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395643;
	bh=Mob3UCX5eixx21UeetdAPPuLaLJh/ntM3vyGGlfWueo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DAs/pQ3rUGzBVBvZDI3j3qxYd1HhyETBd2P+8GYdKay1lyVMrPWVKLnhzgSg4knjW
	 +gkQJXxG+zqAyeojXr0cyuFlnsS2pek4QD8BraIpfP9h6aoiJ80LAgOsOSR9+7d/Fh
	 ez1rAFjiKnQMeuhyDKFZa8EDGz+mTLnjTcJTI81OhGoaASRo0vdiDqcBzxdFAQMNvd
	 ViZZeUw2J0JPcn3mbtNC6b2DZ+a7rQ+9SsD6Cyl6pGija832re4UqwI0g5sREdJOt1
	 Cx4v8ayGIxQdZiSOzV+aLQ4xxsY4Veg3FGsiHOQvUD0nE9UM8wybMBGaPq+gHzeg59
	 CGpuckYzwQ5zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A718780F02;
	Mon, 10 Aug 2026 21:00:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DC1D1AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83FD1406AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:00:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kxd1IiWLpODf for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 21:00:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BBA59406BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBA59406BC
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBA59406BC
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 21:00:41 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso1485255a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395641; x=1787000441;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mob3UCX5eixx21UeetdAPPuLaLJh/ntM3vyGGlfWueo=;
 b=KkQeIA9YtJeG744p1dlyjRgTl02MWA3DxTVveTAqUaxMakP+Y3MYzv9TX6El7gInTA
 hoGducOeAPzrEbdEVpmRhV5A6wUYHPL+35/n03jZgyK3lokMkO+TbUKMoaIV2hEqLgor
 q+IOq5Sm7WZ5ZY4u+cPmB7nlXU+1+E2Pfzs+cuahwmXH7iathwM+pRy198H88lxl/4Zx
 uyW3xwF1WHHo59TpnAUJtCbzV2udDvb0s73MH0Dh7fuhiQak7PmFI7HHU+TmWC41o3yQ
 yeP/Cu0lstuMwjTgdXvdBBY/Wht4r1PQN9d4CudGbvGD5pnI15Nc3AEDOlI6H+yn2N8y
 PXvA==
X-Gm-Message-State: AOJu0Yyx17Looppsq07l7C7+tnIDG+shiSAhXJj8kOwOZfKSGNgPy+rK
 AXo3O5Bxqpvzj3pwnGWBlDoIA5gRhKLqxIyApfcf5ToHovNIck+mKIBu7DsO9YgKnQvOEt2Vt6c
 4dSqbAnw=
X-Gm-Gg: AR+sD11hRKpshbuGEhYl41yeBLrEbzQi/oRkxhgwXac2RURwsNEtKByNepleyX8jmlX
 qtB6UTzXwLeTGpDP3K8Qz2Mpd4s9TykHJUoCKDFMwwSX9c12H7nDFSLLLdeeK7KANF+i8eq4igq
 Mg2NWqy7ZPbX/GtSrTlhpbtvmSXa7NdV2PWyU77AhjXWuBnV2ToSizTCbE35j7JLpcFdYbiLtUc
 o8HlTHzOWdoYtLIRMIgludZTrvuXHl5vBxVxdg7MG208o2bqkTjFjsj7fOqwpMJYJSFHFl01qpd
 m3+HGsHw3hm4hEC0mxa5UAJdSowguWC7ukQ1KjoA7s/vo7xUqQ7/1ZxNarSrQqYfXMGWoPAY8Xw
 ChAXy5R2KjOij+GSGP97WVQL9toyxw676iUYQegH0zG9UkADBI7b8ZwSZVPC7PpK0jVKjijfP31
 Gf5dbCuAYnqPVuAocxvlh9OaquZhww07Lym5cdlTt3XFKWVI7whOOXlLaw9gVivIMdKQXnWZEgb
 N39GWnZLKIz7AruDx9UQk5VCjrdVQZqsRZMuHjl6ujcKJEWSGnFE1/rLGKjCQYGoktb6lXbXz+z
 9cd9bY6N
X-Received: by 2002:a05:6820:a0b:b0:6ae:8b66:8726 with SMTP id
 006d021491bc7-6b0420b71d4mr12320888eaf.18.1786395209791; 
 Mon, 10 Aug 2026 13:53:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Lianghong Liu <liulhong617@163.com>
Cc: sjg@chromium.org
In-Reply-To: <1784776723.232131-1-liulhong617@163.com>
References: <20260713074539.32875-1-liulhong617@163.com>
 <1784776723.232131-1-liulhong617@163.com>
Subject: Re: [PATCH v3] Makefile: depend on OF_LIST dts sources for
 fit-dtb.blob
Message-Id: <178639520902.1450255.11399255890207793027.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395641; x=1787000441;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mob3UCX5eixx21UeetdAPPuLaLJh/ntM3vyGGlfWueo=;
 b=WwshFfZhGpg00Zv56t3hl2RBUnsH34F6xX6RlJC0TdtOrbTLRitkqdRdLo1QhEz5Kf
 7l4SATk7HlF9vF+FgYuITwV+Qeoh+r5FsW+9yI5gaGUoNh3Ex7FMRC3nAX558KrqUsG3
 O0vnWGC41OCK+fGokcpQNfNgIhhdfrUqv0iDc=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WwshFfZh
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 23 Jul 2026 09:40:21 +0800, Lianghong Liu wrote:

> When CONFIG_MULTI_DTB_FIT is enabled, fit-dtb.blob is produced by
> mkimage with one "-b " argument for every entry in CONFIG_OF_LIST.
> The make rule, however, only listed dts/dt.dtb (i.e. the
> CONFIG_DEFAULT_DEVICE_TREE blob) as a prerequisite:
> 
>   fit-dtb.blob: dts/dt.dtb FORCE
>       $(call if_changed,mkimage)
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Makefile: depend on OF_LIST dts sources for fit-dtb.blob
      commit: 93926f630e486d3cb2f2278c2785b2e2e9a3d705
-- 
Tom


