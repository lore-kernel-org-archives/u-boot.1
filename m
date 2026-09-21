Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A9FC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52BDB40A57;
	Mon, 21 Sep 2026 16:58:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVH_PhAeJoAi; Mon, 21 Sep 2026 16:58:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B619840AA0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790009934;
	b=qJaywu3keIbGN/WRNwbU+cw4Tg+SqJsxoM17S0xXx2R0pUpPo5hzoZmnmv3Dzz9aUFrf
	 yaYWFdz8ZWnS+0rV5wVqxc4ROI8nXaw1Of5smi8zMEeuc/14BMr9aCHbfTcWGzZHKgPgR
	 6eFqWLS1CYNzyVPHyrAMnz360r2SDgmRVN0ch+ng08AkKB7hybGIBFLZFhYCQ3cCjP+Vo
	 aCmN6angxIZ/mMPV7iu/CxhfKTy4arwfLz1GT6mm0K7woRPunz8ZpL4/S8pW1mOzBv1Fe
	 GImnTt91UJz7ON6aegwa0hVeGVhYsv5dVbNl3zTl4hk/8qRai8fyx6qF1ZO6YD0pxOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790009934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iVBWgH34gkNect6/XizlZJCWgyIOwPYzGwvEgV97a2s=;
	b=HS+7Nc8gPibJPJNLzcjg+T6ZNISTPXTaJxN7sdNeJD96e9nhT0tNBYLcs8EST8Mn1EdH
	 Eh96xHRfH4oza7qDzmVx73DXI1ddN7CqG87IEAhuvcyuLmt03V6ectlMkWuVnPJvqomQJ
	 cWNFrQsXTCWQeRtmkTVl/nCvFPuTNWKvneeGA389zs1KAGv79sAUjZ5zHwRNjw+2hQjIs
	 Y+JCHInkG7E3eMiIkwtkL6Md+/Q5fN8rEq5BjjUtCVhS9JLa529aTMbJ9Aj53DpeBsxZD
	 GVRIVu8qUvrBbbY1GgxvFcj4WY4go/mcONscxiHw5dLcttvHsStetQ5RjTntODsq0mQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iz+kAwc7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790009934;
	bh=iVBWgH34gkNect6/XizlZJCWgyIOwPYzGwvEgV97a2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kdkro9yn+HWTv1YFuWJ5frknV7s5x8DhfRRYDWD4KzgyLXJgv5+qYUoGR7Glq3lIV
	 Du6WVcktfRImeM4xw49Y73RefCu4Z5lDUBQPBRfsNG6tcGp+zd4p4iDvunljJiFsa5
	 0fJAFgr2NI1dPqDIL8C8U6pj4AU8X5tcJG7if5sgpBWYlozoOjBdQRz4ZcKFZLd3bJ
	 rG3YYyypn0fqG4TkS37Imlzo2ZTROpAoYYc+tGchnehEQGZ+OzRve/e3wj6weCqENG
	 eCzYJ54VCnhrrX0nRx5MG4r3kC5dnp1Wa7vgUtF6F/8jnKiBjA4sEsbli8gVt55C0M
	 gP8jaqVDUuekw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B619840AA0;
	Mon, 21 Sep 2026 16:58:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ACBCC12C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E8BD40AA4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Th6XQ2Fl1leH for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC01040AA0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790009933;
 b=Qsh3w1/DrBWRAeSXpeaFOha1DcPAoVYNwLi0M8zKi6yOrIP9Ds1tdh5xTj2noIHLaDY9
 uzPlKCRCyw4qsN8MjVXClGXA7Tq0Fu09G+RaKyO09vnmnCoiqg+YqAzmukSna7fkZw1a/
 qn0SUvAXGAsBQQwhxDQNv5MtV7vHfOM+5/pKnxHa/bW3Hv8RzyfjbEvf+ttF4x4tW6PFL
 xPDgzB/atUr/JVg26NkEQKrlaxz4dv8KT9lhlUKnZOcI+FeJBu9iLOvr3GYWYxghc4TXx
 8u3CZvKBREhA82uM+zRxpVKQelQu3PmVDvlg2mSZFx6tVcxuLruki661tEscyaY5qeg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790009933;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=iVBWgH34gkNect6/XizlZJCWgyIOwPYzGwvEgV97a2s=;
 b=PHr3U8HpGyuyU6Z/7T/8yJxvFeAxQ7FUucmd74IMcdVi2QgCbe0mupL03Jh9YnSixjhG
 5cQFkIWYYtr+SXbTeTTJJ/p+Gt0DIECqdGHZJavhx6YKoNG1XVsTwibDysnzRa8Nt2ULE
 Xx7bzEJXrLAz7xzuTkMaysy3hpijHDJBawea8+voRkbKTeR5oPEPkU4vyw+GzugsgLGdc
 rzWs6+zsp3ev5X99YxYXh+9o3eUZSAeb7RUcP8MdkGEjWrjw4CLfqtRdUKR2mbX+4SG9Q
 hmzrpaRhbCceUuLbA8WBI9tAFtB3VnzaqvUB5iOs7hHMSUauqJI8vuumIAyiZc7q17w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iz+kAwc7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::1b; helo=mail-oa2-x1b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iz+kAwc7
Received: from mail-oa2-x1b.google.com (mail-oa2-x1b.google.com
 [IPv6:2607:f8b0:4864:30::1b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC01040AA0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:52 +0000 (UTC)
Received: by mail-oa2-x1b.google.com with SMTP id
 586e51a60fabf-478cbd5b48aso2305934fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790009911; x=1790614711;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iVBWgH34gkNect6/XizlZJCWgyIOwPYzGwvEgV97a2s=;
 b=iz+kAwc75w2noag2l7+OvgguhwnakBd5ZqH/wuZXlDZrOGqk7QVfFHLhAeLFB2OQyK
 MqLTr5vtzXTgazXyCbG2cBo69gLA+I/jI+anXi6OOzQ25+z0rTJmM429t6fC1iUB4AtX
 U1zTrlDn1lfualjpqpYFqebi51hGiOzqifRX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790009911; x=1790614711;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iVBWgH34gkNect6/XizlZJCWgyIOwPYzGwvEgV97a2s=;
 b=LTwh23lDRQoBygIDJgiWCEgIBQKS8RTKr9VKToHeLeClNjPWBKSchn8GkXZeZiAZLK
 f1kmeMn/FtT0uBGhZCs1ohcYk6mcVIwCsPCAZ5xkS7TCVvrwtOnqY3rLjKsS+k4ya8O/
 f/tXQGvB4nRmh6IoM4rcEPM2l18vcbRQ8AQeOvWcuema4HvvXXSLCvK8zWBq29Nkir6M
 Un3DOP4pB1ihIN//4YDTRxMChaLegX+MYu+P2BjJJnIMbW1GHM/chHxd6JufX1UWln2E
 EeuX6ajyQurB+jmKBFozvYs6ot5JQ7jCOYkfgG5CqRRLx5CItzBB2GKd9raMrFkke87U
 zQVg==
X-Gm-Message-State: AFuF++lS4dWEU4jrgfjJO4rKSJiD1eQpj4pP5vIxKt4uIf+vZHRXFiWp
 D27BiLc04oA71Tu1BsK+txBuwCcjGNJrQypShV9Cn4HmbERvn1yC9bgIhgRIsjWLZYc=
X-Gm-Gg: AYBFou3AtJZN1gqS6pr43Y8RHs112MBkH7ggZ5erTEvUvabFadDs4fraTK/FzuBdsRF
 xm4HYDAQ2/jXAfPLl4Ng7G7s3QzCWHiti7Q03djq4Px78f6gt4MqE6FoyopgdOsf9KrV+qkR3D9
 DTZMADojRX4bupVqJw+cIDswgogX9iWqkn6QtK6CN0CyC1OXXM8GzGcOTnwlUociuC+OsYiG8z0
 eZ74gO88oS5YG4S5n3r+LEIbgNmiZ0BN3kQK3VtkOnxoYB9OuJLwroi+532V56vIcu7Fv+Zf3iG
 akpnwBPJ2ONhraZ8Q1bFUGAlRj1SiqqtY3inmrJT1NxlaTAT2nB0ybOLGIYa9J50iiERoGJFHVR
 /VjyM1sKIHDPLu0IsDeGmf3y4JyBOpGMG+rukXRgvWM+j3GuMNxxzpXq4WanNy/0qG4wpfsALu5
 aTdsJqH2UcD4+S7ysLTHYG7+SxM47CFcBoml6KjDf9GN8OfZg32TwgFzOgjzvqF9RpNOzxidiwO
 2SdT54x+nwFsOu5H03sQX4Ud7KDh1lbR4Xrcdl15PzV7kszC5qFBLhfS6DQkJ/zlKeu5Dd/Ds78
 zVGtZGk3L762puUk1g==
X-Received: by 2002:a05:6820:c0d4:10b0:6cd:3fcc:96d4 with SMTP id
 006d021491bc7-6cd3fdbde3bmr4511825eaf.82.1790009911447; 
 Mon, 21 Sep 2026 09:58:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4881f4d7861sm9261433fac.1.2026.09.21.09.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:58:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20260914210444.638315-1-trini@konsulko.com>
References: <20260914210444.638315-1-trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: Update some SoCFPGA related addresses
Message-Id: <179000991082.3174152.14963032593634927997.b4-ty@konsulko.com>
Date: Mon, 21 Sep 2026 10:58:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 14 Sep 2026 15:04:44 -0600, Tom Rini wrote:

> With Altera no longer being part of Intel, some of the email addresses
> for the maintainers for these platforms had not been updated. Update
> these to match more recent patches.
> 
> 

Applied to u-boot/main, thanks!

[1/1] MAINTAINERS: Update some SoCFPGA related addresses
      commit: e278bc1e434f122c556dacafc062c98bc4f3a4f5
-- 
Tom


