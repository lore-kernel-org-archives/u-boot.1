Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20C8C5AC82
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD24660A7F;
	Fri,  7 Aug 2026 16:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5YOws58Cx2kq; Fri,  7 Aug 2026 16:16:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2869608F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119399;
	bh=HJTXHyB2qec3eY+K7lz6AloxJbZE4ZPuNF0RgKuyhW0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KUUtL8OvTvLmLRFavyuAlYgi3EHHiBpipLI6ipQvfxYrT+dOgfiL5IxXIsKaFP7Fb
	 fEJvHScSnV9pK9OPCzrDzMBLkI6+hh7L/Bc5G9Jn5gIXvYGMefo62/9AresdjeVSnQ
	 A+jCUl1OZmR1JLZZzomo5uxP+KFerHbuYPR/1l1WRr2+8TNH63/dw1DkKOGTKgySiy
	 JdRMqhrstz+p94SDjiyRTZ5WkrLDfvkltUVY8ynJ4QV2eF/FMdmT0DOF9gMX8rUcKZ
	 AUomzt8EjopoOMSg6jZd9n/uVu+Qx/cP5V2FOSFdLLVRKe5cjXE0h+dy5pP0naIsAt
	 10BSFFcwn5TWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2869608F0;
	Fri,  7 Aug 2026 16:16:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD183D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEF5880F6E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHvsSM-lieOp for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:16:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E91C580F22
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E91C580F22
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E91C580F22
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:34 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-44cf70de986so1437507fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119394; x=1786724194;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HJTXHyB2qec3eY+K7lz6AloxJbZE4ZPuNF0RgKuyhW0=;
 b=DlToi+9iPssRgWceJ1+z/JXK8bOU0KJPP73PFjtYCZU20u2/VfFwBUj1xV+2XRQq7h
 od9I2HPBXNh4VxYflmYp8Aj7opklBobW5mU3GVK/zfnXqK9X0yU1ksL3uAlb6oEhDtxJ
 NeAW6NXRP4dqR3a7xDzJxwIQPvA/o04zSLjr7WSS3hADJkVvWiTR6XLZNCPojSm+XYcB
 LwAvjPFkbrmaaQYu0XxdS+5J0QV1GoZjdJLJqD/943r76ot5vWfwS3YcbnSATlJBAQ4B
 z/dJ4qvPmIssM7keYEbC9jv8Z0iZi8JwSGkEqwwN83S8NOYtJ8WpY2Z3PYK2VlIVK56/
 Qhhg==
X-Gm-Message-State: AOJu0YxfZ/FZUMmHY0Im6gAvyz9Cl6TBWY80thXJFzb+jtduCBiRVlS/
 RhZIR3EaRT+I+/ScU4H9Q8ONlABQC0Cr/Rpu+SsPYLFvtimOjuojre/HfCUt6ctNL3s=
X-Gm-Gg: AR+sD10CsCj2qmvjqJfZztUbDPhfcat8beFNnVZVolS5IGjKMyevh9O77eyfQ0TxTdL
 PpZ25y4t0T3O18yl8smEnRlKVaw+JqZBKmgxooHjmktxxLFyd559bML7oXMCJ5MRa4XjDwQP74k
 GeJ+44ihdFh56dJr2sF+8P9roTg8Lqu4ecWEuO304AhnVQ9LWMlEZ7pf35AFejY02VhInf1z9lc
 796C8YSUnyqjVsvlWzBo+O7gfJlzq4KkCivZ1Qt2e/+1FK+pgG+JYbfUURvAKs0gTOTQ8nR0M+Y
 2jWNVRgpykV9u5T3Cu4E41+UHw5VMnZL4xiwtFX/ChCpxLlUNA+JrpvoXOB62NmRZ7q7j3G6nBY
 G9JTEtcjalPWstOiTcEB68HxnKhRhc/dF+XJ00zbDya7FxW5L+em4NxSN79VqZNCkbilMagxa2I
 FeDrv8FTkQGENtzCJQopoW+G7rJUa3w5KT3+Fem2LiTB3b716zlsPLEhEuVe274wsggPDvbv4kJ
 wlFlZlkuRoStvizm6YhwMVfFuHYGi/qNLcUbQNV0m6C16UEq8gWigkpBdH4tKtupujQ3Ta7Fh4a
 0BnrGZ99
X-Received: by 2002:a4a:e908:0:b0:6a3:d77e:725a with SMTP id
 006d021491bc7-6b04213b952mr710915eaf.20.1786119393713; 
 Fri, 07 Aug 2026 09:16:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2712445eaf.5.2026.08.07.09.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:16:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, michal.simek@amd.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20260803100932.64260-1-ilias.apalodimas@linaro.org>
References: <20260803100932.64260-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for fwu-main-03082026
Message-Id: <178611939311.381449.10883514654000342783.b4-ty@konsulko.com>
Date: Fri, 07 Aug 2026 10:16:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786119394; x=1786724194;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HJTXHyB2qec3eY+K7lz6AloxJbZE4ZPuNF0RgKuyhW0=;
 b=Bi6SMxpM/z3Gh3B/hLZgyKBGVni0Zr6STOez1F8MQbCvOPknHQxCifNoAjn0N6Jh5n
 93VChpxpSkty5pp2mdOGvzdaq8XsZPB21dOrQo3PmcRUZD/Dp4NuEfBk6hi/sadqAcWe
 yJaI68HvwSi6yqbrmWfm7d2mRd8VGsKEySEuw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Bi6SMxpM
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

On Mon, 3 Aug 2026 13:09:32 +0300, Ilias Apalodimas wrote:

> A small update from Michal enhancing FWU prints
> The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:
> 
>   Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git tags/fwu-main-03082026
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


