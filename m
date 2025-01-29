Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2048DC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 05:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75C6880EB5;
	Wed, 29 Jan 2025 06:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738129167;
	bh=QB13J0ybSrRQ9FzWjsidLnk9y47RSgkxFBsdRTfCsFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Get01YOnWoSc1MIrwcyq/nK6/U04HIuT0YX4n1wvR91EKl5NGMpGpIcGSMJIbVVJq
	 LcIUcaLRd53KKDXIPHWBbFm2G/Y1jdUQMf+P9mkmNiMWa/BkcB/V8OdhL6Q0egSCdL
	 KaZBkaYo9kmjC2bZNSjW0eAaLbovJw91W6iN/vRgeHH0LOgtbr0uNTFH1XHPRrVx+I
	 gVX4HIktVETe3nO5b8ZAUcilKn9LxE2eeDM+L9Cob9tSJXwZnwVAXA6oxlGSIxsgvi
	 pRIvT45LFiYY9gelUlWamC3y/pIh0PTq+yx4RidOIo/TCTvfDSYmnBzdTWJ0DFUZNQ
	 Vij1Epyq31IGQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80A280F10; Wed, 29 Jan 2025 06:39:25 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9901080885
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 06:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VV6Vwjm3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8EED910382D08; Wed, 29 Jan 2025 06:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738129162; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QB13J0ybSrRQ9FzWjsidLnk9y47RSgkxFBsdRTfCsFQ=;
 b=VV6Vwjm3bZWY/13EOvPJ5CxTIjkBBrd0OlBYBELaVvFm7pJux1sSQWRrPfSJ7il09UURxP
 UoSyrYcMQX4Ia/u06XOrZrcER9/APoCyVPP+AJxKYT24FAStpufQ7k2bB7oCNCIRgN4Vt+
 n8q+YB20BmxmBzqU/oWud3UtYMMXhx7R83c8cVITRYR+GMG5t+5ChJkiJa34wZc3Ald6HU
 yYd3Xm85A73xQb8UYDjUT0EA99U6sxdc99PA2hCweGv6GFawNk/dXcref+GzyyJ5lKsuEC
 jfHHHAREWXvitnz/z7FhT0ViGFhP/zndP4/yFLSMRbYXrZCyvlaFOQsQOpNJsg==
Message-ID: <837c4fc1-4e13-afac-46b0-99717f4d1211@denx.de>
Date: Wed, 29 Jan 2025 06:38:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: Remove unnecessary assignment
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Michal,

On 24.01.25 14:17, Michal Simek wrote:
> Variable self assignment has been found by clang. But Linux kernel already
> fixed this problem by commit 2a068daf5742 ("ubifs: Remove unnecessary
> assignment") and commit ae4c8081eb77 ("ubifs: remove unnecessary
> assignment").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   fs/ubifs/recovery.c | 1 -
>   fs/ubifs/scan.c     | 1 -
>   2 files changed, 2 deletions(-)

Applied to u-boot-ubi master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
