Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21A606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t1CZrLMo;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a1QWnJy7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C14718125D;
	Thu, 22 Oct 2026 08:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id td_PLjxyyVqo; Thu, 22 Oct 2026 08:25:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0778C811E3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657553;
	b=i8h4cdgIt1pwM1mqMe+fxzL4uU2lmQ144gPPWf2IY7/orJhJ+iFdaF1Y6YUnrPYg0e4F
	 5PL+Q1IRhM8LnlB6Cx8VkuMSJeeeu53OWnmDHvMkcXKh8mVskdSMle1SOQRCQNuQDyWSU
	 e/4z+fEo7HZQ81W8iVXKw4Q4k9MS170+CrNtd1FC1AuQUVCvcuvh00yNPzTvHnI6F6Ha2
	 sj5rgvwWGw7j7999gBDT4pzlisWDwocJlvXsFxZ+5o6KT8RZvM5iEikKB0ZxfUyiM9E/V
	 XkD8xdE7Ej1nNXJgR/e9lp2dY3bW5ImA1miJAQfryEVtcES5Jg+X3W9eOTHWoOaHtNw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657553;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=d4ESUneGddY4Z1gMxAjpO99HoPu8/8txYczyhEsCWnA=;
	b=ntkgdd+zQsw5E7mHyIaemzKj9mStNKkqLALW1yTZO5ZPyQneK4V5EETNphdtV2Ndpb9X
	 f3tsEtzdcjw5f2CH7hJQqoh0dH6QzpcOY6Gt1RvzbelwNqKzX7gm/sNWWAMGm0VX0jcnK
	 NeYCoTLMgMxKHlcL+TvqoqCL7orGQA4WbA3BQriPdJTR44CE7WEI1g46D6oyhd25J58sT
	 +Z/cExkM04G0kQah3jKoy/PkX2BGu+7tmy0bC98eK7ltQub4wIPwAz2WbVnjDUOvmuYRD
	 Ro5B1JDFU6HEBeNy922B9Yg/RRja6l9jwqSAumSTEU82AaMnqUcTkwyqAR/nwuax4bg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a1QWnJy7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657553;
	bh=d4ESUneGddY4Z1gMxAjpO99HoPu8/8txYczyhEsCWnA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1CZrLMoriZhZtFeh1iWUZl2OaJCXXNhLbsVQeFl433hB+0yKfhFVpJxAc0AKHrWo
	 Cp2UqhXu2qqTK4qiTeo+Dm6weuQ4ytcO4jT9nLtPQYdScUmp4lhY2uNVZ0FeveFZrC
	 NCK462HBO6m4WQDjAxoGKBpEMhYcTYwDPsMgVKxQguOliZmIBcofSTUpahJox6iCFQ
	 QT5G2xSlh6bfhUN3KHK1X21sX+I1nc0fLM9gBMVNqIdU6U5cgEfu4PzJom+TyHcDWo
	 l+bkFy2cUfo0hXLBpAbWfuAl0Vl8wZw/6ye/7S+bUWXL8FyvqkB81oEL5Dp3FCZIri
	 9XT6DQTh169eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0778C811E3;
	Thu, 22 Oct 2026 08:25:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F3B8D769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E648881209
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ma_-PoAMKeww for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:25:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 428CB81203
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657548;
 b=L895NKr+j+Cz+YrG7jlKytbhEF/s9PiBJDE1o5pAdnfzblQa3blqNQq6/KOUoTHVxrTC
 xBKE33BMJY4LJs70YxvVZ2ie/JyiXVklMUIQtQI5OPe3M4TKMHYGqcSZgFhf8Hfd1A+jv
 K02QGMekhp+Tfj/1QHXUu1RS5PMaxB73rATFReCEfv08HEzwMdn0o51YK8IIZLiFzioNk
 KSseYRylb5OvEuusrbPbfId1GFcRuzJ0sqx5Am1KSqsCfJQXkPr8K60OFfcCny78lztrz
 noHuAuN42ld/IfSU+hzLWgSaiHrmJpXzx1sKJudaGhvWbT0RqI6GjbCU2IT7OEHm4lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657548;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=d4ESUneGddY4Z1gMxAjpO99HoPu8/8txYczyhEsCWnA=;
 b=LxV1i9CN6jkObuuEFfv27aBip0OFQ1e1PTBpIvoeucG3wiRzWIkPQXoLqYImW718lwNU
 Mg+xpl4twwryT/f3kCbrPJsDkafQ74XKp+w6RvzDubD+J93zz4N0dZd00mm9ZWZqTtpc9
 8d/0rpPTe/ylCnxzQQz+3cggpAmKp8e1goqpQibpe6U2y6xKvCA3w4ZbGXuTv6yrQy1QZ
 S+BQN4t2O9kCQ5XBM4S7257Su1Dwmr9vqeMWLZ8mvRbODsd+wSRq2tM6QFd1c7zYt/NyS
 pmfIza0OHUJRSvWUYM/3t5+dknvj4e7pWMK1USrmLVWQAp3/m9XvDLyE96Lki+oT54w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=a1QWnJy7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=a1QWnJy7
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 428CB81203
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:25:47 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e9f6a16aedso9258785ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657547; cv=none;
 d=google.com; s=arc-20260327;
 b=VA5xHjSLe+CR5Mqdfq8ujhgAf7YXRiOJgfdEeVzwEpHUmPbSn1COsM+d0hi3F7xT3M
 BBlwizTj5pLrZEpnyYmb1qsNXOW/0USnz7GTy4uBtuoRY/HFXUv7yBl+Tp6VKpv5rKZv
 opntmvoPaCBO7WMYG+uNM/WcbFpJxsAuhLBuM+7MGkuKh20SYuXU4NW6WeQ7t5ZYTeBS
 7kylqFyfllR2t3lkSX65qC5gUtb6YgH3seiDffetAm/OMnas74pnbtjgoLI3Oie/Oc2i
 FEYXslgcmWl3Oq91egHWx9jEKAjLO6Ol21VRLn6zGT7KQIW6eTJkKXwlNYcU9UasyyL4
 Eftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=d4ESUneGddY4Z1gMxAjpO99HoPu8/8txYczyhEsCWnA=;
 fh=XiPutGoD2g15zxVuqT/VhyF+y/RumASrjwRzhHQVRYE=;
 b=kpfoHiUV+JsiYMIhHGABXTzkt5BLO818eXiZiQGVXmFXMYZWisvkJUre8Z1BeQehxd
 Eaoh8FDdqj6k51MAgFBJ9hpFaac0hjnAMeOmRbrTSYqDHiJZqk3HrRTNIIhXzTYFUmLU
 coHe6QdYyamx5BUOqwkIt2Hv4bcyoAj7dMO/yYs49218PyWRWSQjaj4KJCjVTIHIAjCS
 SC/ABghWcMKf81Cc8/MZn3rpyinkeKFLPRqOXxv/+GO/g0OHbH4laAwnJyD5SyikScpR
 7Lvs5wdzGriNhmB3yHM/Ni3Klc7YRwKrCGR/6ZVxi4Ni7fWzZHw9PGV4qgqV72C9Ho8l
 lECw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657547; x=1793262347;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d4ESUneGddY4Z1gMxAjpO99HoPu8/8txYczyhEsCWnA=;
 b=a1QWnJy7C4wvJ5AhUyNKkJsxKyEId1Yq5331kNW3a0I66EgUo6dxCfW7gx3/S5Eqry
 0VPah6PLwWBI45gceNfud1egJYSFEcQJzjYzl5CobiZf6gV/48t7oRodlxjXqBiFz5Op
 /brQ5qGUps0ZZf1QRviDdVZM/+4KTpBZg5IzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657547; x=1793262347;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d4ESUneGddY4Z1gMxAjpO99HoPu8/8txYczyhEsCWnA=;
 b=daROu9IQjyam6XO9546JhfV0QFhMCniM6W7ORxoNVGIsFsr4f60gXSjTh0Vx3IO5Vt
 7EG8Hf5xe3IZt2dfqc7edTvANfiEH0J/FoEn4YNZ0MKcdImfGCzqcfrNTtgRbebilOfE
 xB340oaPEe2V0N8jFsdxKLsL0uh9EAvqlQdrD/sJqbCUdEeXPu32yQIAB5ZKYBM9pA1p
 dlLJB/6bGN+uCtOFdgIDsQEkP2eGQHXVMiQoGtWDc9NdeEdEBmidO1Ay0yL66yqas1kr
 ufxQS4HWLiGzXKFlg78jkMcZ9aIcoBTd53V4zI6vY7CORnr2LJEOJtGGXoOcaOcDHGfu
 tOiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzYNVJgV+YQQ0ZWKUeQqRPju0NRhgc5mdJGxOweBa9/yR8pyYFmwcIYV4Ob3oHSW7nAQHlxSA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKYZjpxQfv7EKroy96leGSkM78Sees7335Q6QJqH6+ankM0B1Dq
 qWjFi6Z6qEq9qaBnX2iGaikDJLZQcQeOHZQmAZvjVfi1zEcf0te312/001qatnVaznPZ+w8tfpX
 uWM976dJ7h8FJaNtw7H2RD3N6vRWvRPaEzWA80JCX
X-Gm-Gg: AYBFou1gztYBd0w6C4SsjG4VjD0x2pFzkf6IkBwobREZtlGmssosOvOFaELoUgOYYhb
 WIf5lTXNhvm6Wj6sYaV2+ke33OA5S0HWlBwQHMeV1tP5vy8kvAg2Jhd4d8daMU36nCQr3py42Uh
 fy6dQhIwwiNUk7LQWeWwKxIfYJswRQcyTOqw7flxFxq/mSgSa03qDadnjv4k7fYCbShqnQ9xK1b
 dz8c5z/dxlD6cYX/k13seUMU+dOuPPMJVzFUZw2hmVCpA4FmdtNuo1Qf7lYocg8hUTpcZg6x9uo
 A22tscPPUeg7J4+1jOpF7MHjO13ZQcb6jrMGf3aR4BwEQFq9i7nFZS3wqu4gXuiCQDRbe0sUbsM
 99GPMoJvPLUZHeNbaEwJcLdYySfn1RCEYOxU=
X-Received: by 2002:a17:902:f612:b0:2e9:5714:6087 with SMTP id
 d9443c01a7336-2ea4396c219mr37196685ad.5.1792657546783; Thu, 22 Oct 2026
 01:25:46 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:25:41 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 16:09:04 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-3-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-3-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:25:41 -0700
X-Gm-Features: AclHuK9sf61psRoy5k9ZQKfTkXpS2od6fr1oSvVHK2gmkZFIzr2zuifqgFJzAy0
Message-ID: <CAFLszTg9wWPFhQgFctyg8tMQBLG4+zkMpsSRwcktVSMkCdGSMQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] test/py: android: Drop verbose printing and
 unused return
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: android: Drop verbose printing and unused return
>
> The setup_android_image() is only called once. The callers does not use
> the return value.
>
> Drop the unused return. While at it, also remove the verbose printing.
>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  test/py/tests/test_android/android_image.py | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
