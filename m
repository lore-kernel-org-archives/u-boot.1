Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB6606A332
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pJtkMxt9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKcc1yI7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BECE80D74;
	Mon,  9 Nov 2026 21:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J06YDyKQkDXY; Mon,  9 Nov 2026 21:01:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B666C80E22
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794258081;
	b=idVdP8Dvl3h+ZX3YLiUmL2vOERbww19WYyj5uaMn4aIwTqeJjmWzNmOwno4bKCxm4Fag
	 RU6tdM+Yan+GFnWMc7HNsiENkP7GwMBt7LtLYPSX4+fL+HfjRCh4syvg49VW5juyLQU5Q
	 B/lEss53EITc5sa/HK7bh+Fr+L0SXDDDDbfPxHLx4TLkeBMyqWwx0Ildh2CzjDLEfvIE+
	 nAJcn/jCwp88hyZWpthVFZuM0RZsbnxClbKSLJmi/zJTOCWzRjm9WnzskbP2xWdZ4Qfad
	 4XWyD5ErBc05IuKKTTsHlAZTRDNtBEMDhmcIy/nrVGSYf9lfKzn212RY2AWJ79xO8Ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794258081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ATGEhzyrn9h6hJTh2vS4c3G2SlO6Wmv0pjspH6+rHqo=;
	b=V3BGSQyW/P6yN8s0Y8e7J+2wa4/1os5FfTvcrqSN5A6RjHnv/hfj1pO9WnWdCec2uy/Q
	 w+LA6HRep5d4fTALBWsx23kTp4OFqtg4hiQQPzWzyJnwKTM27/tCcHoCRTYhNwPSQ9x3D
	 l0yMU6MBmdwyBGSfDw4jpljP7E1nsKA/hKkiTvGngrTfnHz8RaNadMjEi1Zk7+rLmyx/J
	 5W9UeQZvxpQfgku5U0wH9Cpaqofkkef16bAwRmLKS9pNg3AonIhGNeTHCszxYaUNF1iNh
	 NrMNZGN4HypE8PaqyZncjoxKIF0D86Mwz9OAS2d0pSVsYcMsFy7SD/2wGqmE8WOXPHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HKcc1yI7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794258081;
	bh=ATGEhzyrn9h6hJTh2vS4c3G2SlO6Wmv0pjspH6+rHqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pJtkMxt95RNK/aJ3RTfDYIagzyRtlN8dRCAOVfnGR18WW1v4z6pj7vytUVR43cevv
	 O2B8Esw+yUyQqF4cnRBWkfn0zdz6RFFlmxYpyaeZ9rcsv3JcszC2TfnexDCcEX4LW9
	 gSVkaljfXsEA+aUDyCQbEXg4q7Bme1NsDqZcsEDS+ogs1XTtgfFPoP5f4gUsTCD/2d
	 r5cJScDefYuZ+6y/ylKxWNMt98wPXNSe/Kyb+KhE1nk6lJXP8mib4uU74e2hUmSRRg
	 GL1CPBqcMuAbMdT6xK2r2zI3nWZyd6FelKoHQPRJiI356KJwGqy8+OPY90IjUqIilP
	 Zzr0cY7lFMMAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B666C80E22;
	Mon,  9 Nov 2026 21:01:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BE101C9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01FE080DE9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:41:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EFEEOjXxZ8yX for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 20:41:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01B5580DBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=HKcc1yI7
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01B5580DBA
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 20:41:42 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3adfe77d336so10011161fa.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 12:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794256900; x=1794861700;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ATGEhzyrn9h6hJTh2vS4c3G2SlO6Wmv0pjspH6+rHqo=;
 b=HKcc1yI7nOwrijpbHLTonHVbqA+ky63DLdbpYlep47orZLmPqLWNCNDbkc7W+6bO+1
 qux26al4nzqNIO931QCV4g2zQp/N9aTwVAgSfb1o8+zriL01og4cdrjZl36yc6vN0FYz
 HGtoIbWZx66eEMZ9WKuP0Z75Yu4pnpodlWiw4AG/lqobUFdTJtutGpXST94f9PtmgiRa
 ahX5v9lD4eB5D0nkI0V2rc65/yUU8vAkPrRjjdPOgPa9kw23jJTNAh1288UA+k3KaPqj
 QqPUii+z6xleXqQZiQG5fthxCGkpX+RGVScp533KGKMX8PG77Fjf3zSj6/VUoBy6Z2l0
 8Inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256900; x=1794861700;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ATGEhzyrn9h6hJTh2vS4c3G2SlO6Wmv0pjspH6+rHqo=;
 b=AipWGYxu/JcXcBa4wWSMcClTdIvhYB/h0uZEeWYW5HlgCialfrkCNWx8tIxde+lMMy
 97OoXDFZf5D8LlP1IKyBXtsAjlT7T5xkeoMO4V1ZAoL/2o1wgahFlZLAxmYhH4T05Xmy
 XWFSGRIlw5hx6gtsQ9W07p6kbG3vtvkpHLNbNAWv8RTL41Mtux9CGy1/QPT2YCuoii9N
 9ifMo8rHbCSTmFrbNwoPRBiPt4AWAhnjZLEhnoWY3gIa1iclV+3NonQJwzeHs7n0AmdF
 nenseK2cLatf3QiEbgGGUP6MNzNtvIxNUdd+uSwnjXogANG6S1WI1UZe2IdbpG5HGcdR
 v4UA==
X-Forwarded-Encrypted: i=1;
 AL+hErGDL2uaJd/hrk78+IVbh5XUUfelqN5m/Ej90c3iPnUigV6PKVYFMAOgqm29rfRz+fHCoP8GeJg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9bD27PxU2bZNkWeXzCjkGpK9BfYZhFRbZV09AIFBW1PrCFxikb
 9t8wqnKwoi1cmgqhZZD5kkXul7NilJrrvFVQvZCdG3d2ba6BrklMSG57HOR6AxDoLUm8xfFDsSS
 6XWbDgRW4YhQita5lvop9jvhhJWJxeso=
X-Gm-Gg: AYBFou3UcgrYSX2a7Sk4czbm6gP/G3chrY5clUnz3XqidQ1jCyytITVvrLO2C5aZ+wz
 KbULmOw12CHhct1BIv1KM4ubTkSQiRH8nD68ggy5IjVxzFKFC2jdOF55lFJNcvbiOJFk915xTJp
 /ThH85PgDgtVQlKz71nFgU1VrcOhvUVg1IvTg140fkvdX2Ij5H3uiyXVj/IsRfd249q5EJeJgE3
 hh1QyDd25iFS+VrHfXR36G5sncbNUjxr9i+80vsNje9A9wGCfLh/d7tceU+N8YYBbW8aMs4ZL9k
 EKjvuhXl0sx4dxJ4Cs926nSOBtOp6dX5pxt9TKAP8XWl7PD6y5AaLr3gepGmuCwe3UapiRdB+bU
 a1smvI2gmC+Ai5JevTEb7/bc8LMnbQxz4YexKPg==
X-Received: by 2002:a05:651c:31d6:b0:3a8:7b84:be96 with SMTP id
 38308e7fff4ca-3ae096458aamr950671fa.27.1794256899966; Mon, 09 Nov 2026
 12:41:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
 <20261106205608.GF3741582@bill-the-cat>
 <CAGG=RgD_G2Ottv+0=JOBYyP8MsdDGGUhCB0R2BAHWa8mS2ECcg@mail.gmail.com>
 <20261109172917.GQ3741582@bill-the-cat>
In-Reply-To: <20261109172917.GQ3741582@bill-the-cat>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Mon, 9 Nov 2026 15:41:28 -0500
X-Gm-Features: AclHuK_TWW9Z8DC9xDz1dpp5KW1YvB56yA4A-wggUx5jRp-1lwzmIWdI5nx8cNA
Message-ID: <CAGG=RgAktXPtjyrwBwhPRVV+yTQKQ7FPXNE_7vpvXyA+STTJhg@mail.gmail.com>
Subject: Re: [PATCH 0/6] usb: musb-new: Free the controller if the host probe
 fails
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, 
 Linus Walleij <linusw@kernel.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 09 Nov 2026 21:01:20 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 12:29, Tom Rini <trini@konsulko.com> wrote:
> So, the general project policy for LLMs is please don't. Using this as
> an example, it's less interesting that we might have a small leak (we
> aren't a persistent OS), but as the part of this thread with Greg and
> the sc5xx driver show, there are potentially interesting problems in the
> failure case (and we don't need to restore the HW state, just ensure our
> internal state is consistent). Digging past the initial leak to fully
> understand the error path and that on the software side we handle errors
> gracefully would be an interesting task.

Understood, thank you for explaining. I will not send a v2 of this
series or of the separate sunxi and mt85xx patches, and will leave
it to Marek whether any of them are worth taking as they are.

Thanks,
Yuho
