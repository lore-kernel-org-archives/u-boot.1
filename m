Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A2606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V8B1qNkJ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VJ8VW2wl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E65D281339;
	Fri,  6 Nov 2026 18:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jIU92fhe5kd5; Fri,  6 Nov 2026 18:06:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 378778132F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988388;
	b=cYF1C1mYlK6bv6grfCaaCdMdESNB2bCkoQuQdYq8qCxOBvUUZdlORx3lDVeraQn5RNr0
	 k57tUzPNiREDTQlsZuOEezzhVmDSbfSu1O2ppA8vuAMPRkYpqqKd+vi+cdqS1MgGfdwOn
	 xkFXdgfgAmV85dTdDCVuG607QoCUx4dv4E39fzfAMeNjJV79GoMzLAU54CXU6DDlX6KTP
	 7EuYOirndHJMYLAvgKt99+6kIPxYN0aKK9CXFLtrV2o0k52tECzgIpSFt172AmVyOFl9h
	 ghqqlXFCmAcGTWXL7KLp9iNNKq8qcjAluN7oKterNRlwwaeTlZ8D4wf6ha0WZuyfgaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RyjZ8ZwdB9IFtIHQL18qAnoArCjL/zs4fz6dfdcF6wY=;
	b=tG7/tirgO+Poise70eZEMqOFjbZlg4qTaq0HP5DoW2GlzEcbJ0ck38vYX+yz+Mp3vvHj
	 U45AOS0zTbnDPqvga18t9AR87XA7g3VlsU3P0hBo6gCPn7rNsvfkSDptdTRtC0z9pXQUD
	 kcK6QCjtR23CPc3LhsiUvFYe1MS3LQs5CyeV0Os01Mi3GWQJhlaF1cwqp3xJHD3WSvdel
	 MSMV23D0l/AS/EIqgycP/hgKAQfwJQuq9BnGa69+/QK7kARs9udVtoPOg07JGKdnWxErU
	 pYKeBQ+lXJCiqMGuLD/clCoBC2JWiI34s8az4QNDBQTp52OGNa5bYSqS80hT6QnKZ6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988388;
	bh=RyjZ8ZwdB9IFtIHQL18qAnoArCjL/zs4fz6dfdcF6wY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8B1qNkJGnhUUXKIGQFEcTjOo/fEM0s/9I+0NGzJJKkVHcbXDwFfAN8D1jkMhMFTP
	 K+/WBdx93F6MU2KQaAXTGPgrkhjOvY+lWKjRTImTZ6M18qysZ3VwVz9NFcD1qRlCY3
	 oy3GxkB2aO6kElt6tOq0IC4VABHhWKXhFcZbjexceI4Ib0+7mHmcg4FwiYxA4woZm4
	 hj5yTrSUIUTIb1E41OcaBKct61R4GRyIp+LmBlvBPP+a7Kfg93HwyTF5120J2kbq9K
	 /aqUmeBbMm10aN1NyvdhOUjNFlnpWK4nI8nQnoMaldqEb22qy/v2rg3koq0BJZk6+9
	 L7UdtxJMB9yRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 378778132F;
	Fri,  6 Nov 2026 18:06:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D9F14B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7652403D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJZNXqGQ5-cr for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:06:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 30380401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VJ8VW2wl
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30380401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:25 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-85d363fb73cso578664a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793988385; x=1794593185;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RyjZ8ZwdB9IFtIHQL18qAnoArCjL/zs4fz6dfdcF6wY=;
 b=VJ8VW2wl6lbaNfa4fUTKqwkB6pxdoqosEyDr/nRoNvNRxVTeCJ+EeK6JtH/7Z/2Drl
 K+QlgnD7HB4r3HVLjTLlowZ4WOZ0LeD8U8uDmmPJZMh7oKMXAc5fIUJOXRjfWwpewoZX
 vXcAeAvfeOV/EwvxbzUnLTqWCx4o3kfAPwANM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793988385; x=1794593185;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RyjZ8ZwdB9IFtIHQL18qAnoArCjL/zs4fz6dfdcF6wY=;
 b=aTpvWjAOzYffMZFtylm9ErIlb5mnAUPtKwyOE74DdxDQ0pgjN3/vxhVgKYYcQColKL
 551OnFOs+1TEdMgsJuk7Zbrp7dSiVnrreXQzEpmZkkr0l0i+Hg+E3IIuS7L2MdvMfoZZ
 RoqAtozuExifTrXBvEhPfH5Whad2FGys/vqBXv+ZbKmQC0jKUSe87vCIizYSacZu6Iy3
 MXpSWvfmZsLkx9gmudvPib/dfAlxeekRT5Y+Xh+SJCTMaAXq4Vq+wonEioPdH+iVm/wG
 OF/K140oxQM104InpptaKSuE9F2sqfG+xCaf3aJ7dg9UsTC6r1zJrMSeHx3bg2/bYje8
 DphA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPLCg9+2kq0834zDOGGaCFXCCxft97MP2tKftFji8qQq+u8JGNYZhClJB5tJufOEvCziKoU0A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8EgZKP+kfSvF7okVNCyPhGYskGMeogXKRQDKoEwEFli5H1AAjG
 JN5RZNjZcsRYapiNS0TgAO51m9SLW79r1r0liozD3OAQ0y5yNbEmrDX+KcFAIueFNbk=
X-Gm-Gg: AYBFou0NIQDjnzkHvNkkCpaf6cwHTyJrXqqK87iYDlHGWaSHvpkZwStWDOcEiNVNXna
 w9gMLyo6zwY3+VCTcxaReDQ4uQJl4191Wv6Qg/e9fFiqgMpOobqebrP14LzjJ/L9EuXMOrIEWPg
 fVvFVC7j+6p7OMJkswQ8ezDQocZMD9kgWRafMhEkMM84/zBMIKnIYhk8SfQzOOc/Ch52rg/Eqle
 Ou4afd95d6RDkGzahTurpOFHi4lBtOrP/JE9gjMWIFz/uPoc4RXPxctck/qjmTgY2xv2Fomkgbr
 kiOdBw/NpwQq0oqZRpUJ3u1m/jDhzJIFtROYERCInluEAEr8MkyAAiRM/GFqR+VNDWYtgqlFF0A
 XfNIfxEjFoRtw5gkd9n+R3bR1l2t9DswZ4rIzGjJ3Cs64cMYXdJ4sGkRULz1WZ3egoqVy6iIszE
 DoozXxcjZlaDEYoGIqoMKOlA7qXPpThwaOo8xiBD6xEZMIpf8UfFhP6+foI18BjXPeiDwWTTK8U
 edT6ZPwzWcy05WGj6+tw7mWuOgR9IGb52KA9bAwhP4A7N56NAWOYG8/pIabZhh84TTR+RMf1iFv
 PIWpEynu7qfAMnx4PtJD1Zk4Iv1onKD/iCV+k+QklUhiBa6sa4q9/olfF7yIu6nmfnmM48A8IXM
 rGNrRUzmlAK5+qN2pcqpnLHEnvYXAW6QyDwkHZz9geQqlo4SyhqutENm4LRtM/kkctL7g6x9vks
 M72ktaZdMjwEl65jWFr7dyk41A5dKMHVeiCaeaj5YPpV/9/0s8zAk=
X-Received: by 2002:a05:6820:2383:b0:703:acdd:d16c with SMTP id
 006d021491bc7-716e78ed8cdmr1847381eaf.39.1793988384835; 
 Fri, 06 Nov 2026 10:06:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716ea18a791sm2108657eaf.14.2026.11.06.10.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:06:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261018043128.26916-1-semen.protsenko@linaro.org>
References: <20261018043128.26916-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] lmb: Enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9
Message-Id: <179398838372.3737566.4963146467281082245.b4-ty@konsulko.com>
Date: Fri, 06 Nov 2026 12:06:23 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 17 Oct 2026 23:31:28 -0500, Sam Protsenko wrote:

> Since commit a3075db94d49 ("lmb: Reinstate access to memory above
> ram_top") secondary CPUs cannot be brought online on the E850-96 board
> in the Linux kernel:
> 
>     smp: Bringing up secondary CPUs ...
>     CPU1: failed to come online
>     CPU1: failed in unknown state : 0x0
>     CPU2: failed to come online
>     CPU2: failed in unknown state : 0x0
>     ...
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] lmb: Enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9
      commit: 217f4f659d9a740e208bfe513ebd359773121302
-- 
Tom


