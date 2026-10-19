Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E230CCF2DF
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F23E7606CF;
	Mon, 19 Oct 2026 08:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUrvcxaS5jT6; Mon, 19 Oct 2026 08:57:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 510FE60743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400278;
	b=V/+CcE9RKHWKeMS8ax5L/2rFxRD4wGHmqzH0llNktUuTiZsHN+pQWeUEJqdC3t42IPsF
	 JI3CD+leYF9b9STanlKBf9p0Bv/jeQnvSKCze2W+CjEpKIfEIrmo2pcfcahgOIP2znyA/
	 qBVPXn+s6lUiC6jck3n6Y0G5oCBY2PhAPshAfdp+g0O18Njxdj+Uz/LjGWLOuHcoMTWIe
	 xcjYQUDxMuEvJ7kb4g3ncJMy5Mejb67sHfWNNF5pzRFQ6EDfPrFXEnT+quwMXSkToosu5
	 TnMhuWvb09vUkkFeHfOB1/6jZPvIedJlYRczDEqFJ4m2NzWdhzEHSP2DfOmYVZVkJVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400278;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wvcGWYjejIIgYLLAqQgMA1yXAdr6vXzPviBXLIwAPrY=;
	b=drjnhr7SZAwJqnl3RbhzSMG7zVD3Qcs+7lUn1ePvafNiuE0mxAeQW6NMid4CrM1l/k9r
	 q3ltnkLC/3BeH5L4qNOj0UxIHLt9goAyzMLzF4X4hoKWPg4uhX005VStxQ7tIyy4s881x
	 0c4n+YRTKV+keGghMkz5pzRFn4m2ZLw4sVP4aPQKtNKIpo0Pb15C2Prd0mbNFXyJ9dwcY
	 yUw/Ur26Rb/YLehR8L3gybTn2XWdZ8LbLDCjPw8cvMa+gCtmxY4HPlzB/aDtIVda4qaTr
	 K5oxM1MSjVff3HUKLd9dnbWf20/ThWb61voDN3J30GijMksUsyJHJ2pFBFkpNwQEOhA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bgmHP0P5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400278;
	bh=wvcGWYjejIIgYLLAqQgMA1yXAdr6vXzPviBXLIwAPrY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tf5MOnypRmp0P+a27ls00kniPV+vWNXt9G80ZZpBZQaIUmf2Y1MhHv/Z2gXxOrlCh
	 itiVO1G+1kRVtO2nGeojZ1veUGWT3MPtgTP/mcHIquGDrPCDenxfgFMKdY34B7hZil
	 FYAlm1FeQC+W36BAtJ50NVaU6sNS3YcXc/SHceLrLsYYzPQ7MAxBwae5BMK0cIS9Iw
	 Vw0NgKvZfndQbWz1hKvon7WZNvoBkc/ff8n+M8NdARUsUhB3CTqq5Dwuz5Pft80Non
	 civFt1bVmSyktgiPls7Uvcf2EoNae3Lmv+UBvheAxhfTpgILqyy4HhmtohEp4+sAdF
	 TKH9I8yQx9sZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 510FE60743;
	Mon, 19 Oct 2026 08:57:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C26271DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DE8060739
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NW_Ddecz9PX for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8CC746073D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400266;
 b=FgNzPgqX2kLrj3tGU3BCFRaVQDQysdLFp7gWttJgGOTbMJkKza8Os+PFZOr0fNIEyBs2
 mkVmvFW+jaC+CiVkt5REorKSHeAFRCfqTevLjfv+/Ym9ZNIdAfE9jcpTM2HGyKLf886t1
 5RoemFcHze8pLxZ1DXhyVcv1190FsZMHbn1/uaO3rs97U+B5HHy99FIESNDYNc9KnYuIy
 AiXq1TDHAN0nno00sCUaEWDzbAxnFHWY3lVmTfxk/Rg8j+PGhKQwOqczZNC/9L6jSrDfL
 u05079q3/1u4Pub41KqkkZ3OsAUKe2mYGvLNkozyCQ0imM2qwSMc4Q5Wl6t+sWS46Sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400266;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=wvcGWYjejIIgYLLAqQgMA1yXAdr6vXzPviBXLIwAPrY=;
 b=OuaaT4SRYmqjzuBbdRUIiYL9X1YY8/cj/SqOLjstYxxcZ0EHAqhWPMvS1TH7oOC3G6Jc
 QW84a/P6K1Jg3FrjJmM0zLHhbmeLFFEk4OSONjXTX5AHk9eA9sLUBIR28/Zz5cG4Gw5Qf
 7n9zB+R8WdhNi40zd94vBxeSkQqb76A5jvA2YGkB1Mqk8B16lDUxx6lJaZJuMyI6pl/6X
 N/CmScmxx7PDRVQplQuqBEi3n07VyclXZ5aRZU7298sRaqjWgsCtILGeucV2FCKNRNLkp
 CnotftVl9OabLfas9v366Uo8E8joVHdd4pvYwugySeHevL/wWAuLNYAaVrIhri7tLtA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bgmHP0P5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bgmHP0P5
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CC746073D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:44 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c37b612635bso210190066b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400262; x=1793005062;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wvcGWYjejIIgYLLAqQgMA1yXAdr6vXzPviBXLIwAPrY=;
 b=bgmHP0P5Kmni3cJgzA2lNpeKQi3iKR6zinuFWlkDl1GCWpRRYyKtBsiY/VysmyblRK
 5u/e4Xe23qG0iouNintOVEL+bznop6ArtmkSXIeuJGgq2SIf6cqK3qkXAdNM7+Y6kHPC
 q91EexI7nY0gDjFurEanlaeWXJDVBIZ1ggUvu18iOpc+nzG9BbnEt7OSA2DlaH0eBA7x
 ih/gNbmVWPwV+ByivPOVXBF5GuJiJjcWuaEXk8LzahtBcoTasYslT03kaGDo9T2g4QkY
 JAtLnbioGcfaYd2R3IxqCclDYyqO3RofbWBP75a4XgGbfGh22KsQEI+nQwxP3aKY+ANN
 /Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400262; x=1793005062;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wvcGWYjejIIgYLLAqQgMA1yXAdr6vXzPviBXLIwAPrY=;
 b=X5MGwNCM7mw9aghS1ocQ/v4FYTp7NB4rtNLO2Qr9q8IA6m9cNh9rmgtNXM+46bZhqD
 dlKHpaxyPGMNVYEzMXb8P5sfkI6JliiXkLbGk3UU0Ryf5G3JlXm0alEJHl0s9hiU2/yE
 luM8p14ko/UFg9txe/bx8pJztlM9D1XIMdQxaJtNdTQWgNxsI5M2+uSgCdEaMyxCY/Ml
 3GOM2nK/RTxMN5wH60UVka3a32gc+BMCCDymaaigQwm6OQ+vmzuv+UIh9RSeWY+FsymI
 0p3JGtiHjtqjQtbVdIPXLC0ZvHr0Ww3V1AgSbjgVC8KL1S2dZK8BeCnHmfrrooW3iTSn
 LYVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPnMRiXyfld/eAsy5JW9msX3n7f88HKro4ND9FM7ZJ92N73cGAHCCKqvjt5+QxbaEEaqg95dY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJG7rYUsVvSho4+D91ri7bmLjsR25QB3oEJGGQwpXLAyrtwC5C+
 5Wg2a6G9cyvDdo4Hjlw5z1QJ390+6Eqbb/H1URjY8SIwg34XS8TQESDe3YdAnMh/Gfs=
X-Gm-Gg: AYBFou3IdtxyEbAnL8F9kF3EMBEmRNet1M8uj97UstNHwidCaoOfdxrrzg1f7EsH6w/
 kVkWtip1iaZyCKGOq7S66nxqGBvqng95r6kwcuGYF+k/WU7OaruM7Czu8uOVz6ryn0pHn51Rqjd
 iey2BZC6IS8bZ3N39ocAjlE1RrULe7zISJ7/HxH3stWGsVv63RfUC64nK9dpbKwyHvWEqmDNbdT
 tZVVnfhLpu6TNYcTZmTReBem3WscKQaSnUAjUliFPkaRv3CMrgBVYjc23AX0WEXMRYSQ1XWqqMO
 glXo7opzxZtIX4hAM8wnEzfBHqVwSdebPVnoeLknaIf8C/CChlPnLLj/KTu51dPcKig2Rq5uOj9
 BSWPQaTSrPKgzwpqEnw511cGdyRAl74GPldn3LBDZdV+Cl3P0SDu/p7+V1YjtWolzBKQbpB1HQq
 5/lGkT6ttxI5E97JjZHALNBH+7oORNuGKBjOxSS5phtvNJFnI804AxeMpgBuMHASKJko6p1yU7m
 bKRVI6rqH0D+CQEQFjRnw==
X-Received: by 2002:a17:907:3ccc:b0:c42:5363:38dc with SMTP id
 a640c23a62f3a-c42536341e6mr383650566b.25.1792400262478; 
 Mon, 19 Oct 2026 01:57:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:41 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/10] test/py: android: Add create_gpt_image() for
 image creation
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-5-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-5-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024783.806974.10399277066432874535.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=291;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=9uk5Ne3FRgGWEQh8mX1jfUbhx07hRWbJMbDYoXGIRwU=;
 b=zA29kBHXvI27F70XDHRAlvkKG3MKNUEgCJKKLsIu3AsY3tBNBDIDdv7U8LL7JllotehNEjlFd
 BpH6AXJks7RCLlvLBnw3Gfp2VKWaW3Mn3VjDCh2UhwBIkzOIQC+TXSa
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:54:55 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

Hi, 

it should probably squash with previous patch it could be more simple to
review and understand why you do patch 4.

Regards,
Guillaume

-- 
Guillaume La Roque <glaroque@baylibre.com>
