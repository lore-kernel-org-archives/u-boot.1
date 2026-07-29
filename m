Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3971C55160
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85E7F40851;
	Wed, 29 Jul 2026 21:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTST6EzxXIZC; Wed, 29 Jul 2026 21:52:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E2864083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361950;
	bh=zWwP8sr3agJa7dfJsY/bSZtYVJyRbPi2bYtFHCUGyCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGA3+XPQO8LJ7Ir42QCE+awCzwAksDKcENThoRv/aRLfpb5VUBoDrCowKMqRrGywk
	 lj3pYD8l/z0zC0IoAx+Y/L45HhDO5FPGWdYmQ4djXpYnw2ZNar0XaFF+b4UAETqiID
	 AG9N92VJpBaKeR8nuIodVOwbx4k5HVJleu8ZzDPKdVKfzW7Cw25/6zf/7ZEeul2Ttg
	 3lXOYsi8OrfmUn7tIns5ruNTFNPYX4U8xwz9mBDm6wjPbl2yG5CgkFFu7/EIlmzCtb
	 w/twLF4GQhugSm97D/9Spa09MUbLFZD9yNzS1ANc3YcUKBtlbNdpHpOIjbR5op4BUG
	 2IhpD7lfDFHzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E2864083B;
	Wed, 29 Jul 2026 21:52:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 99291197
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86FAF80A9B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:26:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sc9B_Ya_U0Hc for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 18:26:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C5D97805C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5D97805C6
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5D97805C6
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:26:57 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso17475e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785349616; x=1785954416;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zWwP8sr3agJa7dfJsY/bSZtYVJyRbPi2bYtFHCUGyCM=;
 b=ig+TXV9t3yPsSXNhbzy1AiFV1oqFGWr6VMFUjYc4G0sXJNEU2WWSFkkNFZRQ53Mrgc
 JUBl60QCF9FmHckqUJUs+oiYihpPn2itIvLTAU4MzuAPfSl5VHRW6c3Bkmixn2uShsFk
 fXzN+pDW8IhCB8rvhTgOpA0c0tf2uwT7pvObYtqrEdMDB7X3dxGySPVxRjD0rDV7qDv1
 gPu4+oFD5FMVC5+s8QC9VrYkQ3lYpuzd5z4vsMWUEOZYDGwDXgHVgijT3/BzdJG+ajP3
 +AKKzbMBtjJqWbaE3HC3r8XcNj6IGSv0jLEVC8CIK9K90ZO2VA+yL0GdnWxPZy67BE04
 ILgg==
X-Gm-Message-State: AOJu0YwWh7bxM2q145zH05yHPE940Hhfn14SuoD2N65kGAb7OVO5qELZ
 1MMC34+QDCyA6Bq4zgb5Ijyg/Jc8La0sITjx5FyRNyRYy4H7/cidbRmHdhPs3kqb2+emKWfbeRY
 0KgtsXxY=
X-Gm-Gg: AR+sD11rSAiPIfdRj8LVPOK6xZGNnikiiDMm2RkIl7CXd/Y0G5Vv1SMtwf/dvzncPx1
 8JUsE3az1Cr6MnmN7hSCKVQZsB6QnsWbGq44rQrogfiiZAcJbppgEtfND8XX+dzZgm7ObDfGM4T
 4UHQn+5P/PArFMASSsnrmkMYg8E6mQNfWfDI7Tx0Or3PqmjEbrJZS9TUZsbLmW/lS9FUvcvz/6r
 CYFm07yRcAAZEzxbShJy0LCHamsjE5K2yiNBJ+7ls0nbpx/9Un5w8uCFScPjVq2jxXtMJPDOfu2
 KI4jTR243crMgugEdOlYhArHI55b2aUYp6q7KkE1w1O+TwFLywfyw0AF65fcDmflhEVJcCKQbEz
 HmOrzYLqNsdfRaQNUp8fXS02067aTUPu42vda1AXeErAc0rm+mubeJihEDxZO5Wlba6ySPTLbQJ
 AWqWTZDsfvexVzLCYWMTz0cafBGCRvcdmXRmGmaoVES2e3nzk0LxTrTDFm/H9KkISbpIjFq8Rl8
 JcCufhxhCAFu0G2dvtf5Jy1MKtXeBZHcWzzNwfJzVYyxnVW0iHiWVa+xL/KGHOhyJAPQWKwmaz/
 wEbm3cS2CUpWGwhl4dj0O7ZO2QOocfeRzYHm9qmql4m+fpjtuXRzPVruAzyxp2DuPw9T
X-Received: by 2002:a05:600c:8b42:b0:495:495f:bc30 with SMTP id
 5b1f17b1804b1-497fd309700mr39204345e9.12.1785349615771; 
 Wed, 29 Jul 2026 11:26:55 -0700 (PDT)
Received: from ?IPV6:2003:ff:f03:8f00:4cb1:53a4:7b38:3d18?
 (p200300ff0f038f004cb153a47b383d18.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:4cb1:53a4:7b38:3d18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45c297dsm165730465e9.7.2026.07.29.11.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 11:26:55 -0700 (PDT)
Message-ID: <dc27a337-94e9-4581-b3c0-6311aecc244a@byteray.co.uk>
Date: Wed, 29 Jul 2026 20:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] test: tpm: check malformed capability responses
 are rejected
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>,
 Che-Liang Chiou <clchiou@chromium.org>, Dirk Eibach <dirk.eibach@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
References: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
 <20260724-tpm-trunc-resp-v2-2-381857e959f6@byteray.co.uk>
 <CAFLszThRysSxA=U0_qQ1DS26Y9xbNG2WQVtdJdKX74JdrVvsuA@mail.gmail.com>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <CAFLszThRysSxA=U0_qQ1DS26Y9xbNG2WQVtdJdKX74JdrVvsuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785349616; x=1785954416;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zWwP8sr3agJa7dfJsY/bSZtYVJyRbPi2bYtFHCUGyCM=;
 b=r8UQSmTpiwprPfomzvt8ZozyttfYlV8Swjh82izyqj7M3AOgLg1AQqU2bQXuye/Xwg
 T8JH6wR2k8eNlZD9YTmX2v5nung4IWITORfT+dPe6uXjO9OKVZTqMSY/HumVuP28733M
 taf84PuM5UMIc7OzaVYR9jtAYOphOpfI1rssbxBbhLRlLBl4JcBDCylYwDY9ZgQnceJ3
 R/40zSrlhJXNG/BPkBoxr+umJWZDUfFQbyzINh7tWLwff2OqMlKU3r3oAlERInzNedl5
 hwPrrYRWon3OJCBJigRKNF2jwSaJamaIKQ4Je0EmAnvzwhmwQuGyNlMzZd+8SDzaAWQ+
 2iNg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=r8UQSmTp
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

Simon,

On 28.07.26 20:42, Simon Glass wrote:
> But patch 1 also adds the TPM_RESPONSE_AUTH_LENGTH underflow guards in
> tpm1_load_key2_oiap() and tpm1_get_pub_key_oiap(), which get no coverage
> here. There is a v1 emulator (tpm_tis_sandbox.c), so a short-OIAP hook
> along the same lines looks feasible. Please can you add a case for at
> least one of those, or say why it is impractical?

Added in v4.

Thanks,
Shah

