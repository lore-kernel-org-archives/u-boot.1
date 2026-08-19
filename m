Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703ACC5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 14:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22C3F605C9;
	Wed, 19 Aug 2026 14:49:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b81iIeUhOwE3; Wed, 19 Aug 2026 14:49:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787150993;
	bh=UuzK0nGlP7UiV07yYY3CMWx0edcOgoqSruVI1mKT2y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d1RH8wUK2Z+PZ8Rl/UBG084EaLdhkrYxuNJHN0xJe4vWOM6QtCoVK85fO9YiwN8Dx
	 wds4/DR/l7ujJ12OGFJAHyox0PROVCJN4+3KkdbShZq+ub2+S7nGunZiNqXrjfEeDj
	 9d1BsTK60GW5IdhxqY7343DfPqwTqQ5YNgi9UDVCDGnH8M5Ae3oT49MkMHHhYaxaWP
	 BIHuRv8tcaYH2G46LciNfyBCE6PwKu1Yyy/OXGLZPhOL7HXQ95Zv4fXLbUT1G3tw1x
	 Vmgii6Yp3AiJdwQpOD7tADpm51OmpSfhNjW/eSyXJsQebAOtKnHni4Xgn7AEY8ivUN
	 /MEt7Lg0U2kxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C93C60645;
	Wed, 19 Aug 2026 14:49:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A9FB42FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9BDD940144
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tX5yyVnEpOcr for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 14:49:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nx7LM3gR
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D128E40122
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:49:48 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4518ad44e83so816629fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787150987; x=1787755787;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UuzK0nGlP7UiV07yYY3CMWx0edcOgoqSruVI1mKT2y4=;
 b=nx7LM3gRnOs96jXFLN5rg+qSsURz1pjw9SZ2eBMco3NPr8TX7oMKVh/pyGgeX3xvE3
 QsW/w2/ScnfPdzwHwJrND/OLhXNMpTWEu/dSIA6VkQN2X1hqkU+CDbQO3jdBW9iSqLx4
 W5zycNKskL6rp6RRVBvKyqfwMByILjAz630+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150987; x=1787755787;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UuzK0nGlP7UiV07yYY3CMWx0edcOgoqSruVI1mKT2y4=;
 b=GLyvGYuqOn/tZNpT87jHWnBT+qHkIZXs6vHQCVlTt/JvK2ey3oGnTjELgNzm9o4zcV
 IhPVt37O7tLGZTpQWNMDC6o4BpcGQ9EHzXl6ARziqheamQz3IdgzN3bXtqBkwSmWhFUO
 kDTg7nKIDjIU0MZbhsBmrzDnjf08HQqLhw+u6kGcOOQfwCptwEX4PDBrT9HKxDu0RtQs
 pgrOynBTOjJrmjyDt15ZqeCk6mnBuy7cogiOioMhypVhFeT1BYXxiicAeQi1jVFmgebf
 2YVVqO08AgWH1d9/EDIV/iLJd1rOtcUN4sMtxKvmZwSJwuEVZyLktedVKdVGorkl8BXw
 Offg==
X-Gm-Message-State: AOJu0YxBxQ247pRU7r2SYIdwHwj4lscp4hvJGA/GKcaaXoeLuPl9Q4v9
 TNFOjPSk3DPNTj/gyDtwML7ciVD0VGoX9eOdAX/AxGqXWNWXrpWME9G64Ykxa/fnveYhIEkoYGh
 yQbklKHjAH1iZ
X-Gm-Gg: AR+sD11MVIsM0KrmU/m26aeXRwYWl6JkhC75PC1O48X2T/CT/hi9a+X6a8Gc48Ih6NF
 ZiiADkY672q0VoHSIxVf2mY15wDj2+JVJownFPEotrEjcK7Xxcay3LAkMfKzgFE3nYi49r4hysn
 xizPLnC6kTSO0TJ7hrT3B3E0V4FlUWnvi5B4JdPhAotdQAMN5hO2ngkfXEEUg1E8pafQsOjuj8/
 I8nRgTLHgd2sCNmXRQRFu0czmmpslQ4lQmDjp18VVF8ijkMgLZMj05z5smiA5GC24e3htFETWqV
 t3GJAoz94cb52Jk1ygTuWLkCKQHoF5m6QEuRAWtaKxNbyTXIb7nVF0x5xqsDGfemRoCBpE9RLa2
 oSi7WoRM03uPhUBBP0mn3MWwV8tqHTrK638WM+70s8zZGwmBWJl4vXyWGtYbZNaGpNcxmK95YnE
 DRnGfJCkxD+jQOlXU9+13V3rPmwNSEzsdngwaA2hKA0E4Fl6rvUj2WMNYKhOueqAZebcfciWdNC
 Np6QJg7Nn3hw1o47iGrA8665frH3RP7n1oJscd9C+2lSdFh+zta0w4IfWeB9zrBSjYABvdA+mFE
 lO5sOsKnjA==
X-Received: by 2002:a05:6871:2ec7:b0:45e:9b66:7175 with SMTP id
 586e51a60fabf-462f6af357bmr5611225fac.16.1787150987543; 
 Wed, 19 Aug 2026 07:49:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-462e99f0f27sm2325984fac.13.2026.08.19.07.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:49:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Pranav Sanwal <pranav.sanwal@amd.com>
Cc: git@amd.com, michal.simek@amd.com
In-Reply-To: <20260730094817.1937340-1-pranav.sanwal@amd.com>
References: <20260730094817.1937340-1-pranav.sanwal@amd.com>
Subject: Re: [PATCH 0/3] test: dm: add sandbox coverage for gpio-delay
Message-Id: <178715098618.1496674.13156778915011115004.b4-ty@konsulko.com>
Date: Wed, 19 Aug 2026 08:49:46 -0600
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

On Thu, 30 Jul 2026 15:18:14 +0530, Pranav Sanwal wrote:

> The gpio-delay driver wraps one or more real GPIO lines and delays
> their assertion/deassertion, but had no sandbox test coverage at all.
> 
> Patch 1 is a small, unrelated fix noticed while adding this coverage:
> dm_test_gpio_requestf() requests a GPIO but never frees it, unlike
> every other test in the file.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] test: dm: free gpio in dm_test_gpio_requestf()
      commit: 58fea72c0ff71ab3c28c27910218c4886c0ca714
[2/3] test: sandbox: enable GPIO_DELAY
      commit: 7b1ae01ed37ae3527422fdf5bd7ac8110e80c288
[3/3] test: dm: add sandbox coverage for gpio-delay
      commit: ef019bb9ebce5f3025cd93f2da6d3b586a13293d
-- 
Tom


