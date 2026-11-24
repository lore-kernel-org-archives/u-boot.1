Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22967606A322
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PLuf+huI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+inykb+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED89D605E5;
	Tue, 24 Nov 2026 12:20:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vUNNPNop8K9M; Tue, 24 Nov 2026 12:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60ED0607C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795522812;
	b=YCgpbHGE5kF6SgLeVXuTAoZNxqulJyjLwJTVCBqWO6HkDsPlAJj3udsAKXLxaK/LEvJ7
	 1yhIY46EnYxHmIOls0ycwo5rYPkHcFpDpGhYotaY14FLvIv/ydwAHHhc+LaJxi0W4uZig
	 hxJEWJzO2QlAoDFYyfArOtW2cM1R3WHv3aMVQiA0WvTEbDodRjjs61zZ/ve1WOTMZ9XoH
	 uv4WmAVNWGJBMysFRFXCqEs/IjmIFW6Oj7e5VYaA20Svb5tXC1GAIVmr3l7IF1DRePvs/
	 W0CGWdj98HgdchMM/tl8VaEi1bazyKBATSUtHmZNSA/YK0FZxQzxxzy8aYIGCP5uCNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795522812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Bd/2pezcKFcGWjVIKpy+qh50eV2RELXQhPANnZmwfYc=;
	b=RL1/7UExtOmJ4Bz+MTAx46WJrzJuxV3uVMrGMNmzNxDrTZKGAOq2HSq2SNRrJ1kWel/y
	 KzFfINFa2gNKmeufc20ohh3HqcHv5lw/zkbNLXfXq+PMVmM0ILcXJwmHZ/KtTAsqHCzju
	 ogrT6wBIl/IEhbiMgcroXRCa6nEqf80D5vxZLJjB/89DUHP0se9gV6tbLUnBr6hHODVef
	 E9GsRv9wQDoKFgpRM7gTuj1jn8o5/d23EwERtl7cn7gSj21kiL83Rj2XVyzHr0hwb2/rH
	 jQ1Na+uLruIsDe0HuwFO7wDprmGs5LbCUTtnyASvpaSOvBcPn/cobRBtMJR2cS6yHSw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795522812;
	bh=Bd/2pezcKFcGWjVIKpy+qh50eV2RELXQhPANnZmwfYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PLuf+huIL8tWgkNcVotPfKVvUasAtQVpUbJvIziJ5jMMIc2PEryt0a5tQ3EnBc//L
	 eS33PmeqZmrDbuUO1JelXy+hK/CU9PBMwoelBuYqcWlNLStOPRGiVHwBfmLzH8NjkC
	 XBpDq9EsQx6Zxeo9DpEIgwf91r55bsSv75yNpk1+X5T7GWgbhYpBtZV5FL3mqaHqBR
	 f26D3Yo8woTtxJnWQvzlHzcZOvcmPHs7HxVAnyb6LPG7cqAWJohGMCBIVh/oN7PDS5
	 tK8t/MQyUkX1h3UYAs+n1Td9f0JgUF9m4EXEIVEseG932/EPnhnbH9glHfOGUFOUwu
	 8SjFTl0fPoOnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60ED0607C7;
	Tue, 24 Nov 2026 12:20:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A5193A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAC3B80FDE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vm3Xerf7ynPn for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 12:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDF7380FDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=E+inykb+
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDF7380FDD
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 12:20:09 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3ab3b29a298so35743171fa.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 04:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795522807; x=1796127607;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bd/2pezcKFcGWjVIKpy+qh50eV2RELXQhPANnZmwfYc=;
 b=E+inykb+Qab50zXesYNord1upeqpFZWNgRDCFioWILj1L5grMLAR8fbLKNsQnwMPcX
 ajWPyNFHo/yqct3aVBGT9950KQ1EppQRdLK8scbtsUPPa3SICULiIl6Tg0m+YZ77+VGk
 JtL4lAqJlx4OwhKMElclj+VCLnWyCle0Odap8bb78gF/c0+HnatShUlj9mldKsjd80Ie
 Pv7FNj8WQdT13FwRB/s/FZegkXgOnid7C6Xoj72f25FNmVOunm+ljkwCGljlRfh/LHBf
 aEnTiEB9L/PlThkm/aUKLW14VOH8zAhOfP/LYTrWKUa/T45K6VmxUXccwWP32rHRDBSh
 TDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522807; x=1796127607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bd/2pezcKFcGWjVIKpy+qh50eV2RELXQhPANnZmwfYc=;
 b=tp7rofRyPEuUFFB7veicWKtBotlNUJS4cKIrgA2v0SMKllCFKqV1biMzQhTpVrHt/9
 YJpn29t8bizKC26zaY5WPPb6AAJaxZhFhIAhR+yI1nTAMoUbN8n/okGapAtcT40l47ir
 FqZWe4zNRNpnXxp6dpGnY9leNZ1hbpGFlSmzrN8EAZ22pgTVkz3HTxiJXBpLwp8IHWgw
 rekfVLmyc2ZIzaRzMY9PMCdxs1yFuG1Fq3qqrovE+V2jMo5cQJTv/RKTz8OpgRyXU2Zx
 MA3AjZwK1IvN93/VEiiGvN1ImsV0bpiErNefAkUQxCoEUkBV/qfV5exmxKVGY+Bm35PG
 sSfw==
X-Gm-Message-State: APuU4Z/4aUm0sCqf/+QEQ2B9lCCeg/ZI9X53wBAcYc8trYmzVokpFO3M
 BAIJly6WNsohBeBRf80xzwT6Yfu11HJeGq7ZNo6FpI12oMdXbIXXNQZ0tPC/RT6ettY8fQx3L66
 bMUFQx7xNXJOK7ds4RASWPQUblUeABdA=
X-Gm-Gg: AZFdTZdBPSDDDqWxpl3jKJ45adY6mRaBNCuYDAnZYr73uCRxroJhKKx/QbNSfx/1+yc
 m6f0w54i7bAqRUiXt1p+KbH6E+Icu5THG6SejCmHx8JAKLjiNnDe3ZEozcmE3uLayx0TJg75gsq
 6PPjAzHYI+7CpcQ3wOKJHF+jlaH/b8W5MC2GgybZaPVLhpzBnUkxUTkq5qp0JmCuqDtYdBtUMKd
 Syuk4AaLjPnvcJeM9DXzN0DpEOGqXVCSHKHyP1g0tCGWNg8sWFD4+sq/yD63hD5CHGVwyc6PXoj
 wkCVyfnWPhNIPx7b5NenEnJuFO+ST62Q/8zARAdbLWZIGo1uIvrXRXsWLZWAUhMYlFrLyXDIZST
 D7/5KdV9Cdmu6wpTOXY9LZtG+Y5hImHYuLfKZA+3YDVEEquo7zRMfB6khZcjxfM8y4orxcd9WSj
 qiZUJMZPQxgy7NNL6TNpj9p52tOg==
X-Received: by 2002:a05:6512:39cf:b0:5c1:ad16:20fe with SMTP id
 2adb3069b0e04-5c1bc8a1674mr4868983e87.46.1795522806829; Tue, 24 Nov 2026
 04:20:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124060245.509053-1-hs@nabladev.com>
In-Reply-To: <20261124060245.509053-1-hs@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 24 Nov 2026 09:19:55 -0300
X-Gm-Features: Aa3M54rMuOC8QsGdHCDuzKBZcTZJLd6kfaIE4i5FVy__p5DVtJ7RDgTjyXP3sw0
Message-ID: <CAOMZO5Br4Y0RVTs2Fb+MTcB+AzcBgbow03yFvfEt9_z9tFHmuw@mail.gmail.com>
Subject: Re: [PATCH v2] Update maintainers and get_maintainer.ignore
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tom Rini <trini@konsulko.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko,

On Tue, Nov 24, 2026 at 3:03=E2=80=AFAM Heiko Schocher <hs@nabladev.com> wr=
ote:
>
> Dinesh has left Altera (Info from Alif Zakuan Yaslami) and
> has not changed yet his email address.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>
> Changes in v2:
> - add Reviewed-by tag from Peter
> - drop change in .get_maintainer.ignore
>   as Tom mentioned.

The Subject should not mention get_maintainer.ignore anymore.

A suggestion:

MAINTAINERS: Remove Dinesh from I3C

Thanks
