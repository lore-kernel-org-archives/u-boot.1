Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0D8C5DF86
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA5B340589;
	Thu, 20 Aug 2026 18:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9l0ZpJsbzRnn; Thu, 20 Aug 2026 18:55:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787252147;
	bh=E9tAaXZX7CkSG0wGlnu3hIfHOowi/cYUzRShl0e9ktM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rVhkbXCLjwHW0i43iXU8doQvQzPYqJ+a+YxpIUnBtfSBdpADV3MtY+Cc4OFXBROM3
	 1uScNYFln5x6yQBH57i4W1x1Yh+4lae5IM1w3hDAeGvNLvtRCrQC1gQ/RlcNHuq615
	 UOtwCA3N/NwFH34oxkcuYZluTSFLrUrDnOY+a0THgATB9YmvUFMwMgl0BLgL3TZTTe
	 sSS6VFnGC5t13dpPqbs5toVfwYMJkKAmLlssjIU6EnHEapAcAp00QUUeayFFokjwZE
	 g0LyLKfN01IeCX9kJLr230prGJsgkgH1b2EMJmSacT+mlIRYpAhya7i8spPPVPEUBG
	 HQyBC/CsJu+Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BF0F40592;
	Thu, 20 Aug 2026 18:55:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A41D1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33C1F400A6
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vScSkuqBLx5V for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:55:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::8;
 helo=mail-oo2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=C/pPaKdJ
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E56E400A4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:44 +0000 (UTC)
Received: by mail-oo2-x08.google.com with SMTP id
 006d021491bc7-6b136fad4b3so80270eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787252144; x=1787856944;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E9tAaXZX7CkSG0wGlnu3hIfHOowi/cYUzRShl0e9ktM=;
 b=C/pPaKdJ1xmwouP22VmkouB3VSl9CuDHbEpyBIxJ7d3NXK9AbMGbNbsBUVPo9yemz0
 JNTgOKaFr0qNRwgpJ+4qypxE2/lplCCMUuT891LsGIsB35dW99LuMxT9EUrJOFwtbN8R
 sSXB4QNjn7s6Zm7MWBctEPlJblUbQcfAOBuuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252144; x=1787856944;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E9tAaXZX7CkSG0wGlnu3hIfHOowi/cYUzRShl0e9ktM=;
 b=an42EcYT9ACL/TJiDd5K7i0Mz7thlGjGvy0nyKqPwSI6hNnM7B28wYWCvOwZEJqDU4
 XdYdW+BwbKtIPCuH39d320lTsw4uAsUJa/ha6eM+wPwLDWpG48DWBgXzsvaYbrCbHuAZ
 TB83PG2iVd1OvpPz+YY/w7zEq2E3qMqrjQhDCcma6oOCMdUFbVhHFzzG2X45DNTr34fT
 30g+x4c8yuC9L0txKDIpWQEE2/X0pESt+mI3BPutzNFdmnqaV2Azw17AWeQOO2wd5sHS
 UDjEg0fbpcrHq9AjWOWbD1O7UIn3W+VMXQAojKelHVZcikYj9gl7KO9zVAgo6VwufXsB
 q6AA==
X-Gm-Message-State: AOJu0Yyb/N0tLXJf1DJ5bAxsUBKZBI2iN7shWB9XITHObnLQlhcFBwxU
 amINXdU5UJuPWSxs80P5qJJf5+sYMYt8HrkWNg5zxEk2cSLlgxTCiGMSB8We034E+fY=
X-Gm-Gg: AR+sD127PVP3Av1ArnlPNX7Pppvh9ZF5xggIW/bnhXhDg9OR2EaDc/6N+M1f+gYAl+w
 B3cVmltaeFg4iwhq2fV77dPeQMc5iQfxZd8JLJPzIz4jM/4VuXvJdP5epK5WYisiZ9tYp/Y/5yc
 rXTPtDPhZB+GNMBydlfowatK7OWiK9FfC+CVLpRZcia48LgyzBsRHdCWMEihE9cAq8YvuoXcpYG
 cw+hXgk0Eda+91L5CPQbEQqtAfcb4qpuHlm+hbomYtuixywT8pt9H9jYuT8iHB8nZhs1yM0bekQ
 WrmSDs7fEqROYt8YlWc3xCk9ShpWxiKlsOdn7GkmDZ9ebvZS2v3JR7b4ErpUKjG6uiuCtoJAD+5
 AFzDnyuDQL7+BoGoZFQw97HvUxci1uJqmgiSGPBe0JPOS5Vu+muPz5MkBcvsWLfX4EsCJ44iB9s
 zy+LJKIkyZW/ZCuzmcauylj7wGxvgnJqbY79jFDv/trlv7zjHwfCtWuniIfr/YeoU1kd1hno6ei
 dwg9jwKFZm7EZZIVdrom1U8iEZpUjS43LYPCEADjiLDqUuV5GLA/IXlAdxVbpjuqH6OPogbtgdr
 wIfVbPkX
X-Received: by 2002:a05:6820:988:b0:6aa:fac5:a3af with SMTP id
 006d021491bc7-6b159278b40mr1018832eaf.16.1787252143894; 
 Thu, 20 Aug 2026 11:55:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cb55782sm5729175eaf.1.2026.08.20.11.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:55:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
In-Reply-To: <87mruhgs1t.fsf@kernel.org>
References: <87mruhgs1t.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260819 into main
Message-Id: <178725214291.2214048.6398148623762077713.b4-ty@konsulko.com>
Date: Thu, 20 Aug 2026 12:55:42 -0600
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

On Thu, 20 Aug 2026 09:38:38 +0200, Mattijs Korpershoek wrote:

> Here is a PR for main with the following:
> 
> Android:
> * Ensure boot image read is bound by partition size
> 
> CI:
> * https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1015
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


