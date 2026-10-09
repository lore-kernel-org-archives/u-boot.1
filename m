Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454D4CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 06:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8B0B81212;
	Fri,  9 Oct 2026 06:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FT0JlWypcIjj; Fri,  9 Oct 2026 06:52:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 122EB812B6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791528729;
	b=kd+z5eTGnUSQ1+gcNjixCcuo0Uo24afn+SB5SpUfapGXD+zZ/IpRUIaPqZxS+SOK57sI
	 kwFZ8wLQwo8Ow4xnjDSmk4hch5O7+aKuTFY8rJ4G2JZAq9EPVgmDgvDNOLfpBmQi0ehYe
	 JtLyk+NbAjKyYzrhL1pgCLsQuv/Mu9g6f9xiO45TFiRlcGkOX2UL0U+3i0m56S+KkYSpP
	 C2bKk/e83CDUx6lZ8s9eoIAWlWx9nBA/6IY/9IpLmgKW+KEXZrmZhZDKDyEy9noOoqEMi
	 9Ho+kbl2JYr5tTP9r3nMRIOfb6cZDqM2cyvqIeJa5YBUcm7+r6/czboZgkg4zVHTNXQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791528729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NAcbm1JY1XQ+WR223E1CggcqdWSPhQpnOFZzhNh9rdA=;
	b=B9jIgFyg4Rl4JMW+EttMWXJ+Xg4ZWE4INDjwfXAcV7rQh4YAXyhiR5qP2Wyl+dtjBiY3
	 oGSdUed96BvDFMCfSOAW75gLnJWpZf7CNDYb7z8Mch3TB9nqL4/9UrP3hessyPteGX8uR
	 b0BcVdN0OPBqyBqzGblHkcHv6bLKvxdlYn62WkyIIVSNUML6huam9spob3Tz4N9RIQplX
	 c12vlKAsM/FJDFLNwQkZ7KR8KdD54tWaS4vzD9Yqx/cnczgr71IYj7OmdqDtnqA1Cz3TY
	 lbmT0hlJk8anJqvaCs0F3KOnaOEq05UggAbCf492j4O9SESC1F3BMu7L37xy3ChfKuQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791528729;
	bh=NAcbm1JY1XQ+WR223E1CggcqdWSPhQpnOFZzhNh9rdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aMJ+s9RTV0i5jMuukakyiRJoejBIPoKYejlJWk/CgpYUHt/Qxnc6waLAriee//hiJ
	 C/IwtmdUk3BqBWZyPXZtbHLDbhNu1d0yj+hTpIFVw0eXtPkA+RPkE6hucfCQwgAJxB
	 IoinLX6eWFGEowvispAwSd/1ydYxldJJC0PD90ybRBlfnjgN/BW9WYlevpVkLBRkyL
	 966Zq6kPL/lwYbjnk+o47pnBb90rkth5qdTTGJw4vWIOjlNYFo55cO7TuuPy/Wg6nR
	 jJL6yVH+a/1PmHPTnvSYdycPK+ijLshWAktLxssrtDr64D8xwgpKwMKPOvgGbtuT8t
	 TTlTDvL5FjqCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 122EB812B6;
	Fri,  9 Oct 2026 06:52:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF8FA1C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D57896084A
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EvKQS3LcswgY for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 06:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A10A56083D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791528727;
 b=D53LJLCn9dPVpvJ41znoYSSdbmVir3SVp9Ntmt8mIjWNlDDdhZ/U8W8NogrLBgg27wnc
 xMxgh6O7Woq0AYTLpYTV5BcIqt6n32VPfxvJZq3BflwzrnVCdL2xH3Gw73IK506hsa3yG
 3JVbGL+T47ssx49dIEUmsOZaquE9Z3Lts+XiQQW/nmOk3DbDTgwkvj8VhVFAP1dqFe5KY
 dOsVT58lDen84thSQ8YxvK64/YMVs2LNbYoBG9niDCkuoTuYhgD1KIeXBuHUGj+gYl4pZ
 gXLOAAKIKwGceSelnNYzDzWk8+T774E7v2Ve66d0+CIAjETNernaLaeUlOrnfhgxEdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791528727;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=NAcbm1JY1XQ+WR223E1CggcqdWSPhQpnOFZzhNh9rdA=;
 b=IxmrI3Y81bjBrsB68m/pYbtEamyEDuul68tvo0Xa+x6naI/mPFryasgPN1ykJ2mychNe
 XIb/HkWQmpC8iH0UOG0vfdZPr4VjI0dmcUTt12WkSYZUcKUCnBywXpobPYhgK2hDmtqYA
 9FBtafv5Ceb4nUzF6OywsCTDgT89TwcoZxW2keH3feBpOIDVajcR9UPJ+5riEM5/DlnBx
 71XG8pLSYHvmssjUgXBgh9KDRAqk87lXppotNEE+BVWf6avw433PCL1kE1WURFIaP6lE8
 AOF3YuAl3cPNyfz9C4p+6BkHi7xwC4U2lFjtQT/90Xba6gV6paR5skzkvuIT3dE3rYA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lXIsOzzs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lXIsOzzs
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A10A56083D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 06:52:06 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6acba4bf65eso3057455a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 23:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791528724; cv=none;
 d=google.com; s=arc-20260327;
 b=p440j0VEGuNk7syFLg5GWQekb2QRm2oLXTz8vMjRkqIGz6YVC0gluHoK6jKIVYNsGj
 mBEqVJlVyhsKqinwQFM+fIwPYrSymhIgl20XULwLxIa9ogMTEDVhs3bdNRYxPUQcGVcg
 ZvDg2MVwz74b0SBkOHJqv0lkhKN5bMhjtY0CnUR5icq+nzLTash4i8z0+enZh/kinixa
 6H0WPyeEKW9Y+IecisFSiRSYXbBElX4sCyq1AdqzHx8ON/d1CbomrhozpHXnQ5e+Xq6J
 EgfA/68aXTXBWJq5FIY/l+CfjGXhZNTs69BYxykq9DtFIFOs/bxbrujcshtD3N4P7hFB
 T9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NAcbm1JY1XQ+WR223E1CggcqdWSPhQpnOFZzhNh9rdA=;
 fh=xNjXe2Q4/tCXs9uffGvfs9qs4Cp7dvyfRyjwIX5STMY=;
 b=qZK/0Gf36nml1iwsB69OFt0dv3EwW8/FnReEfMNNOSi80Pf6KRJK2YJHy3KG1GbwnF
 GL1bwaQ1aelj9JijPzA9YTBJnVBXyyl/PbuNlOXfDLHlxzut9IoF5e/kIgELN0bsu5O5
 pfnxrjW+MnmvrCjTUSfhunPh+qlyCd6TiORiRlh1ZkPA7xWgDCmFaoa5FtvFEMF9A8cZ
 JVGpITpB9LJcWZZ8QPj8SBXSNfF8eLt0i3xaKKf8kjAsLsiLwi5ozdN0XjGxP6Mnvrmi
 V3Q0FWXRU+ge0csKM3UCfvw85xSBQstDwpVkHy6bOf0J1Qt0KsN+B1YSbbo/bhU14mVd
 zbeg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791528724; x=1792133524;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NAcbm1JY1XQ+WR223E1CggcqdWSPhQpnOFZzhNh9rdA=;
 b=lXIsOzzsjmrVgnQSO6zULYgvbjJ8pfMfhbuGY0RRWQn6yjzqZyX0DY4ELE+pZFxcOG
 /cLAWKG88OeB1duMmQ3UW2KDh+hwp1spJnYfSF2UxY1CZDi90f61rjsxcO/PGED3S1Fk
 t9+kpzgQeFM+BbP2o2CE7TpPxWlTUb8CTyxJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791528724; x=1792133524;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NAcbm1JY1XQ+WR223E1CggcqdWSPhQpnOFZzhNh9rdA=;
 b=oYAa8wTD3A5pTJf7j6GmdXAohbdSZfW3XntmFTVaxAAmqr4aFggbPS9mrXPA1BB6zp
 mG2XZcrYL72UxFidZZGxj9PNgH9MSYsBtD4N4oL6VJvtJp78nTOji46ESrBbTsGOhqEc
 8LGVxIXf0c2mp42fGbnnNkNicho1RhGHBwsd2D0j5KoT0npdh7DB1N6ZfQMZCG0XwIyU
 cRZHm8vu/4x1OQj2YhcSgTp9+I1E4qz9MqNqZLK8FktjCBV1bK3qJZXNPLByI0YsUUCo
 wUlgNPB/s1ZZhWH1snWbEH3NfDEncxdJjOIwplNc6jqHXzY+GjfHd/GDMr7Do1qdF6RG
 2bYg==
X-Gm-Message-State: AFq9FYJxQQRQixgViUgm1D5LCvGtIXU8GI8nvXwhaUXoHp3RlbT3VB7F
 xFGh8dfSoQhXupTTjzZfmamKq+fHYQ9LxvPPOh8BNPsOZxP4OXW7MPdk1hBegUTaRTB6slR/16v
 hMZMc9VnlXM4do+SJTU5SAkohG1LnIiibxrz9SZfb
X-Gm-Gg: AYBFou2LMEbDPAaL0dsJ/4f9LV+LsJnsKLvUpnkb/fPyhr8qkjDQ826Wpp+PmZqYQ8Q
 zkdteXpOSTheQ5rCnc+p1EdGnYvgnlQO1qB4Ub5ykpOGXpSDZ3VbTon5JvVh8mFRHiCFPI3ZgPy
 TvEUW/B6aRMZiqDOHoGdOa472NKDb/pzHt2u1d47zXOqjjHiI8UZoHZsB957uQPMDtmyLL/5ZQP
 Oj/+tAVkzPiGdcZr1QroL67wict4BIsS6apzBxZZxcWnCK5qYmzCccpxFTGKuaTA4eewMLi7UlL
 A3QcTkiaIZUvsVhageEqrnBcFjLrAfN9G7GHDpIcff8zUC0EB1in1GE=
X-Received: by 2002:a05:6402:1d52:b0:6ac:9a44:d3fc with SMTP id
 4fb4d7f45d1cf-6b17c2759afmr573554a12.37.1791528724240; Thu, 08 Oct 2026
 23:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20261008070116.328864-1-aristo.chen@canonical.com>
 <20261008070116.328864-2-aristo.chen@canonical.com>
In-Reply-To: <20261008070116.328864-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 07:51:52 +0100
X-Gm-Features: AclHuK_1TP4OTJs6ne7R9ACY2YIO5egcRz1jcDfvB7nUUct99Pxb4x0IL955p9Y
Message-ID: <CAFLszTjdbwmNtXaDmGJ_n+0CM+x1QmZkrdjsWd9To+2khVN=Gg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fit: use FIT_IV_PROP and FIT_IV_HINT for the iv
 properties
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 quentin.schulz@cherry.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-08T06:59:47, Aristo Chen <aristo.chen@canonical.com> wrote:
> fit: use FIT_IV_PROP and FIT_IV_HINT for the iv properties
>
> Commit d0215d8718da ("tools: mkimage: use an explicit iv from the
> cipher node when encrypting") added FIT_IV_HINT and FIT_IV_PROP but did
> not convert the other places that spell the iv-name-hint and iv
> property names out: fit_image_setup_decrypt() on the boot side and
> image_aes_add_cipher_data() in mkimage, which stores the IV. Use the
> constants there as well.
>
> This includes the iv property of the key node that mkimage adds to the
> U-Boot device tree and U-Boot reads back. That node is not part of the
> FIT, but lib/rsa/rsa-sign.c already uses FIT_KEY_HINT, FIT_ALGO_PROP and
> FIT_KEY_REQUIRED for the properties of the key node it writes.
>
> No functional change intended.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/image-cipher.c   | 6 +++---
>  lib/aes/aes-encrypt.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
