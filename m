Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5609BC79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 08:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 595D960609;
	Sun,  6 Sep 2026 08:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R9JILEJcVp1b; Sun,  6 Sep 2026 08:53:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5394E605FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788684806;
	b=OZiBd8y1oOsja7OSl89QSK3p9KqLK9mMm14lEl9Dw3qm/IVMjfVHRPYXnxIqnIPliY0D
	 pam/YeB4ZxcU1QdMF19uOWXaSx/HdNVg36zpAY7vulwWy75FakaYwNaogM4t1kqLEJQKV
	 xVw60uP30LbgkRRR5nf76Pnxr7rHBJ7szVLMTwLA5PTO3rU+obVV99CVCc7ERJ1CyN+Kx
	 VR+vYzTae6+Pip6W9DVyZpzf7rNF8+9dZaa5K2TFhApFetYYNh6u3MbSEqTjtrSF1F6WZ
	 eaISIehZDclPoqgWxy3A/VvlA9FQMHYAefmEgRR/5tPIhtZS2tGoSw6v1FXip1dZ0Kw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788684806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kkx8uRdhi68mOR8bgCJSvkC1k0hjBexs7n0JGTuPzmE=;
	b=Lm+IYxQvyAgeOzlBTH0xpYCDbY2pmID9A+rq74ErlZOFqBuM66vBBw06EfuEExoPUk8O
	 h+VI0hfTAXIBGEsCUE0Lp75e4cuPlv/6VjxqBJv8ukSTslTSshAfwph6oERbKJSk3Oghx
	 Kgk2wGltseX1BacvF2WMXu3WJy6YHtcjnYxFhvgfC5NNyNQOAYy3b2RJASyZnnAhbuqnq
	 kILT+CxlZ7XBV88T8JHQD9uU89XJSbu1DeFncRlhgttD9GqR0v+FcyTxrJQjlNvioc5V4
	 zzosqYr7YEAMRW+sIn+Ppc27G+68REXfUfF1djdPEyxxnWeFYmHaLv1sagnlc05H4BQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788684806;
	bh=kkx8uRdhi68mOR8bgCJSvkC1k0hjBexs7n0JGTuPzmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eSxMNUtqtgWIPXVFlU7r3Nfa28niI/YilyVLu2tY1HEoV7+NAio4RzFmpT1CwCho6
	 9AbwSSYv/iCyo3lJU39daNId4eVVCPieCneHUQQAsEPaZyYDMA7fPMWjGhGG4m5/0l
	 MYKYqVuVd6uovlcdRHUsfydbWdAVe+t4cQvfwd+xXDN7QwbLSlNgzGvjBBgom3lOSr
	 uNxCv901SA/fxCOf1VCr8uEBFDe70sCUdi0Oy6+JZE2/ekunVAz+sDr0fx53WFANZP
	 ELtcN4qNuk5m3RkqU1FXgNfaDZR5Fb5uggpPlhnea8K6aWMD0wCoYQTtf1S2Dma1ZQ
	 8N48pS0QDpEdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5394E605FF;
	Sun,  6 Sep 2026 08:53:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E002EA48
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB50880A88
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uQVdC1X69z1f for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 08:53:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0E2780863
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788684803;
 b=bOIAMv/Pi7/fQ7XPv44wMcVJxwXqGdvNZuMNHUZsH8ku6/wW6mdBFZhKHMrsmNYUxdQq
 zJQw2LPww8XuoFKLIlS/vdHWqQm3ZewPCHNZ/uaXbgqRcxVxqKVXwpKIs5X0BNONYmoBQ
 rXHmNFOTNUUMuhUXyUqoWcB9BB/fu0EZPBaQHF8hJg6vBA+3dmopz5/+fNM/EMJ/L/4Zo
 93oMBVwQG7pYcm0Aj/Kz6NnM9zZO/jvSkkYiOfeVOBex1+AqwbLNWWGA9fiOBOU5XNxne
 owRBYgg6/A1Kt4N3rsccNJXt2uqR7vI6DBLwJrxrkzxt97cF9Yy1i/86kB6TS6LX6wA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788684803;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=kkx8uRdhi68mOR8bgCJSvkC1k0hjBexs7n0JGTuPzmE=;
 b=fGv6kwU3kOLZGezsBjT0aKZQCLEiaI5Ana5Yic57SfGeSkJrWXfB6cGX7yWZQ0PEXa2J
 zW6j/b2oIdU1k0knN7qhxMoFIV5YVoWRJrX6KTKFOPKFUEgrx3LI1FzIW9zKFutQvh3r/
 0rVi1Xk2Q9jITbXCOPNzXAwDutKyi5rprQRCz4QqAMoOKdzNsHxmKXMAESO5HPs2LYOzi
 bJYsZ05moz14OcU0X0chekXMfKACV02ktuV/dnc8DVZ/A1G24Mh/jiscAjAS/8Vdc4maf
 rbph7ZZq4qO6aNt76W6vpXs5kzjALEFOGdsILNyR3e2ygqAEAYUpQWIzzjMwlFsxbow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WxfgsOEG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WxfgsOEG
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0E2780863
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 08:53:22 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5b568dae0e8so1784019e87.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 01:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788684800; cv=none;
 d=google.com; s=arc-20260327;
 b=EI2zkZ6vyVx7Tq4wV0dcn/S9HZgQLxyfRN2xL3cFwvnbA3cMOotaU/gnuY96jWIL4y
 NBpQcmaMXIoypRBA8N+x1sKR/lqgpqQj7DGSwyw7SBBsyzo/HC5n745FFraa8Du9AabV
 leMnvfQUdNcye2UE5hxc5fAsqog6bwF3uL4cVZUIMPf967QtTHUWZcC2HLrO9tLxJj4q
 8gEBNYffnhJzVWk2o1LqfbgQ6mxgsB6hOg2UtVtHVlublQYZtAcKps7neUbLJmU+cNgW
 jmTJvmxgopOaOzabaSal6+phpdejBRIZVDgsWIua5M+R2h3bUv5eIcELloQXapL9gpWx
 pQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kkx8uRdhi68mOR8bgCJSvkC1k0hjBexs7n0JGTuPzmE=;
 fh=F7wkY7JCMt2UyEMUGuCMjbaKBiOLNx186xEnSPv6p28=;
 b=qQP7yeXX6E1i8YRasMWQlqh41cK8xegzziKQ+QoyVEhzseSa3vGbztuXM1Q/7HF7nC
 rcBQU22eUBb7NAKaAGJXsw3UOkhHSHbHbZV7j2y4l+xBaPeeRBUYStGN7WRnUPgTUDs0
 uJUO1dVaFXdiZczzaJiU1Z6U2K5xHD+3Dsy6480u5BQwpIJjMbQIb+dr0p9tngwIXHC5
 0Xzy12RFkNnVflTyefeCZySrZaXRIIHqYpK4p5qmIvX+y5XrxfHQug93FNNOpKLKOfbo
 q/3MPv7wJl10JeLc9H0QD+qXbtWvnxFuwCxeiot02+olzuMB/eBpM190ciJsEUrUJk4y
 cQcw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788684800; x=1789289600;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kkx8uRdhi68mOR8bgCJSvkC1k0hjBexs7n0JGTuPzmE=;
 b=WxfgsOEG77tWGBSDFBF3i1N6gu1GhbeFZhb0EeYjZfHAbD7DnvMa1+1GA2p3+0fi/H
 yPAnosfHuTdYcYQFjzxmJAhP1VPm2B3tSasNdqMVDwGZsfwyyywdNPdDrlzdc3OFcQhU
 VDnh9O7ufKdNDLbyDm9dhKr+PgopvE31lKPRjBvyVgicZuC//OF1P3Vi42uqACxyo1RS
 K6ezLYLiGxAI4KIj/q/Vh7rAwCcIsXEzgSlaoUJMHtMmqLQ1DBaVQT+tMm5fKcO9wHsv
 /ORUg3gqTWURddMh7+PayF1XcwZDQpHCxUUzoz9PSq93oQ2qw3lvgat+/84mfVsath/7
 IDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788684800; x=1789289600;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kkx8uRdhi68mOR8bgCJSvkC1k0hjBexs7n0JGTuPzmE=;
 b=GHmG9c86zFk/3z13q+yfxxVCVFYVV6dAlrxDa2TvsqRe+eLbobjvi3YS0/52jk3PTX
 AWBCdZCEJVIMQem09BLhX5avMSOSuo1eqVxmxZ8SpYkq0DvS7qPXXEvdRP4vJZbRuqfj
 Sbea/AtBJXl2H9k7rm1gCW1xKuILtN5veHa5bNawrQyZUPZqx4RXElLcUuHl167IVsRJ
 QdEnMCGDwQxcWfBNeNXnOcUQfop73ksCsV4cRR8htluTBTyUT8Tq13SAEA2HVHw/SRw8
 qe+KsXas/H8voOcyjgs0cfHHDetc+orUyGaUPEoFgLJuPag/OjC7v6iY10sqyedjoeAI
 zcvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5MplGcZgHsr76rgk4kMjsNAQ3UW6D3rmOAQC5HeUWhCNW8LCCh7kkSYXJVu3p/SjlBXFkVAs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k7KQberxPtZfuvd/01VfIDktn5218mSJMTnNRGA0giLRZqWD98
 wrNXziVG8JDq4qFJyTMcYgYuqZckNc7j46QQjdf+KZMABHgidQAbER9WBal99Vr3tttgBaJF8AO
 ryWSqRGrTm/h9zmE9kbRqubK9ZX82L9ILButgZoH/iA==
X-Gm-Gg: AYBFou1WEV1wD5UJ+he5kbVZBvxfS6S6acH0MCsmcC8RaAI8nkBA1J1+7lDgsDey62f
 K5SGVct/U7yslnysV2mJfFK/1IzdAEvLNZT9YX+YJ2mHnVarlQxwLe69mbs+MoE5PCAoEu41kYY
 KyFABhKTxQLoIUNFQ6KngchqhaGxXTXGKbzNwY2ftiM+EkZ24Ai+pFfoD8On1C0UeQnE3qbxs9o
 fDW845irZUB4zwXO53+NPxltT2+M2XoM6gX2/PMfW4dPo1QPjH1zygcfegouTdwqicKnZZJN4C4
 ZiPo3kz4NfGZJW5qg/8EFbStZc635Eyfs3Q6We0I796ufd9M0r7RYV2ZQ/JJzDNVpR3bfyT2WUY
 9ZeM7VxdZvym8b8SWd63DhEHoavSs4FA4zeOUVFO/edK7lZZXVuidoW00GR2wS0eThq0ACo56bj
 i7Pg==
X-Received: by 2002:a05:6512:3f0d:b0:5ae:bf3b:c98 with SMTP id
 2adb3069b0e04-5b616f15b03mr2694687e87.10.1788684799922; Sun, 06 Sep 2026
 01:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
 <20260905-m4-v11-3-235eacd94fe0@riscstar.com>
 <20260905112621-GKB84986@kernel.org>
In-Reply-To: <20260905112621-GKB84986@kernel.org>
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 6 Sep 2026 16:53:08 +0800
X-Gm-Features: AcwNN1Xu-3T_QJUecVqps8QDn6IM320q2k1zazdkJQSZUmi7YMFDbyngvKX99EY
Message-ID: <CAH22mJyHQbDHKkqyD7c0C_E+2b4QucP3ig4VTNUy2-caXKDBSA@mail.gmail.com>
Subject: Re: [PATCH v11 03/17] riscv: dts: spacemit: define a SPI controller
 node
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Wei Fu <wefu@redhat.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, Yixun Lan <dlan@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Sep 5, 2026 at 7:26=E2=80=AFPM Yixun Lan <dlan@kernel.org> wrote:
>
> Hi Eric,
>
> On 17:13 Sat 05 Sep     , Eric Chung wrote:
> > From: Alex Elder <elder@riscstar.com>
> >
> > Define a node for the fourth SoC SPI controller (number 3) on the
> > SpacemiT K1 SoC.
> >
> > Enable it on the Banana Pi BPI-F3 board, which exposes this feature
> > via its GPIO block:
> >   GPIO PIN 19:  MOSI
> >   GPIO PIN 21:  MISO
> >   GPIO PIN 23:  SCLK
> >   GPIO PIN 24:  SS (inverted)
> >
> > Define pincontrol configurations for the pins as used on that board.
> >
> > (This was tested using a GigaDevice GD25Q64E SPI NOR chip.)
> >
> > Reviewed-by: Yixun Lan <dlan@gentoo.org>
> > Signed-off-by: Alex Elder <elder@riscstar.com>
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > Link: https://lore.kernel.org/r/20260502-spi-spacemit-k1-v10-3-f412e1ae=
8a34@riscstar.com
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> >
> > [ upstream commit: c580774185426ea316396b1dc3f1737a3ad3800a ]
> >
> > (cherry picked from commit 2eec5923556990fcd34c88c549dd11a5843d7fce)
>
> As current state, the merge window (v2026.10) is closed, while next branc=
h is open,
> and Tom already synced lastest v7.2 upstream dts, see [1], so I think it =
would
> make sense to drop patch 3 - 12, which will significantly simplify this s=
eries..
>
> Subtree merge tag 'v7.2-dts' of dts repo [1] into dts/upstream
> Link: https://github.com/u-boot/u-boot/commit/c671bcceafc08138b88d9c49018=
aca75fed20ba4 [1]
>
> --
> Yixun Lan (dlan)

Understood. I will submit a new version. This also reinforces my view:
all upstream DTS patches should be handled by the maintainer. Other
contributors should base their patches on the currently submitted
ones.
