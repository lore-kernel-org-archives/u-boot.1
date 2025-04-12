Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6E5C369AB
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 20:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910AF829E2;
	Sat, 12 Apr 2025 22:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744491171;
	bh=OcQkJQsTin/nV+PSxLhaWvel5ugsm3e2bceE95eMCnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n7VXb30sG35+m5naq7Y69TnBAtdR7MXoAxMItNtXPIQwRxdPV+YeS5UfSz6vP8kpX
	 qBgwCZ9b4rKjplQwyawD1M6Y9qbO7/bPEn0zgxu25ADHhIRM6gryVFQhPZ8GtYxu/e
	 gtT6DhXZ9fiOIfwGm4dyRDcm6Tu23/QKZWEtP9VnecocJeTMA/UCPDz019MKhBKI3m
	 JokmRqXMth7/gdYUy4WbB/So0mJkwV49Myz2FHYJqsMXetQyzZsue4vCqyamXqTsW5
	 SgyaAmk3e9FcvW/Sm0naZlmIqU8LNt2qvYaQSi7J1PNt8RLDjAvEYPMuXK9XTCagw+
	 fc+UM52BTe9Fw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA76829F6; Sat, 12 Apr 2025 22:52:50 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0D4826AD
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 22:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JL5/mbwQ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 300B210275AD0; 
 Sat, 12 Apr 2025 22:52:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744491167; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=OcQkJQsTin/nV+PSxLhaWvel5ugsm3e2bceE95eMCnY=;
 b=JL5/mbwQcWqQGG8Qs4nqeK8Dz4eR5WJSgiyHFBULmvo4nTmLE90rsay9kAL2kDsgA7yQsG
 sMW3zbDIqgGPIhCi2Dw56lD/+4GtQg/CwQD3N8jCBGE18rZ1YodeuzzI4m/DaYm1g0+JVc
 DbcXN+39xkZm5dQ6Po/qRGjwTbi5Bu+BT8/Nev4SDBM8Y+J+7FCgvQ9bdw2FMlUK4EfCOd
 X7VAxxQEjkRj1aRGF06qZyNyxBvpO6ef3rYVmCKofTpo3FkN3c2a4OruLllEBBOAiyiYPq
 HRPyQzln0IqQABP2yyG/4R6FS+58hLVGW2Ue+xukgu8/mlVdQezoQ6d32/QYnw==
Message-ID: <fd4fb3ed-5988-476d-aea8-2c5a58bda9a3@denx.de>
Date: Sat, 12 Apr 2025 22:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: onboard-hub: Fix return type for regulator APIs
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <a2d520f14efc30fc28ec59881205e156dabbfcd9.1744350937.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <a2d520f14efc30fc28ec59881205e156dabbfcd9.1744350937.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/11/25 7:55 AM, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Apart from ENOENT observing return value as ENOSYS when
> !DM_REGULATOR that's why cover both configurations.
> Changed code is not working as operation should be "&&"
> not "||" (ret != -ENOENT && ret != -ENOSYS).
> 
> Also fix the remove function where the regulator_set_enable_if_allowed()
> function is returning an error.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
