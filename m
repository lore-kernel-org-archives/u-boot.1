Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598E7CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 05:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E9CB813CB;
	Fri,  9 Oct 2026 05:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGKZI5ugzqkx; Fri,  9 Oct 2026 05:26:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2C2681233
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791523602;
	b=fZGWvay7oAo0H8LkM+rsKgNkPSs/pImTB2Kkdm0zCfYnDgaHlFPBNlS1Ayrp/UQXA1uy
	 O1kNct76z7S5JuKXpZUhFf+6wOGDnnb/qGr/nFfvOxt6GOiijxxAZOeNtPWT1RMVRQ803
	 +CPFvTL/Aa2IVso5/jsa24OPxOE4ciLDYl7QhA9bnNmm+1jI6QjQieFFxac0hxtcdLdKY
	 RpH50h9ibFRaHcNmp5m1Git67+wqXAj6rCgOAstHcS7zNo97aUoNFRxeU1rrok+EWYQNZ
	 z9GQ/M+2dfQE68KPxLbiMrTUkUfNQQauZU1YDOBg/lbuA0ep3UtUqDQ461sudxkuSrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791523602;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0YI4LOV8ywZvAZ9F5QLNUTIstknzviDvJK0Z7H+F0O8=;
	b=dhYNIFFto4Bj+xvSylMxqKARcpc0r0HWHKDzcD0bS43xOOvOUfYzvE4tWyUBHwKKnQAd
	 xWXNjIw+8redJsZc1ol7EpJNQiqPc09LpAczPyqr6csAeVEDlKU2uyckyWuYR4EgyKc7M
	 erVaupn8I5cguAboWIdrbyFsGvigOsSJtLQ6YZzYyyiVaLr+ZiWc6cvgcsHQXvip5k8Q9
	 exvXHMQzeGUWSrDzKA8HcazDGhyz06tn6lgYjwNxcDSO5SFqgKILLyEGj+nmgRP38wlYA
	 QsnvKUrMPYYqEBP5FuUR64lchUQvw483/98dpwkPsaTBkmGGEmtGTIpdP3xr+iwH8DQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791523602;
	bh=0YI4LOV8ywZvAZ9F5QLNUTIstknzviDvJK0Z7H+F0O8=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t4KPoVOZXkgOitypA9I06qaNDollfPx2V5qfPqbkx2a4pmZJ/IQN+kV2wqBAWSBMS
	 UEgsCyA6lCVkS620OndxYts1TVqhhSkdOHwNH9RmTjX6gF/oB9jFjfR4j2yBBzcE8g
	 3nx6D6QPuoqdq8c6e3a2dQVMXIF/Gmx+e2YxRJRmda9Dy9Rz/Rn1oOvYx3apPCktBh
	 ee91kp1PJiI5KJcBpuNe/dtstKyBWFx2NGJ3cVT1Bnpl06PL2bqKbH4p9EL5NLLNT/
	 h+nQyHhe1eFMl+cfwIdEiFhwFQu7wq7JiErrz8l18CW4GXuHjt59I/jmrQcxJoQqCq
	 sZU+t6wSRYUnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2C2681233;
	Fri,  9 Oct 2026 05:26:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D885A228
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA1D24009C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PYvtAafqf9Ur for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 05:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7FCCF40061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791523600;
 b=lKtk6GP1HK8HW5/hjSMgJsqQtLOvqFxFthiwtKuOfYDFzLoW4cAKgFK+VLj9Clc23bFb
 z23dw+EHdnGnuHQsVDGsyi7E3gQRIY5g/wvrsB5l4CtYD+PTi5y7fd45Tmb6qI9BB2Qg6
 KynOXgMQ5+PuOzTmiJKzUcUq9GcpyELJEqGRw3hhKt27MF8uSxh4Wi4bnsBxzLrfhrAYw
 hk6qWWz4MAUzXGgRa3hGiWmFx12XOfKCxLsVbSUaGu1oPLq1mzW2h9YojfYfqCiSYcgfK
 5ONTvwk6bdKeATBJ5Ur1OxMiAH1w76w4jy+F13YYV5r5bHs2b4vBbBPooWXv3mTdOgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791523600;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=0YI4LOV8ywZvAZ9F5QLNUTIstknzviDvJK0Z7H+F0O8=;
 b=ANe72UoI0bE04YV9WpGKu+aDuKEvzxxzxKGeFifO3Q+3TndKThshs0LPYoqhsCtFYPh5
 Ljxej5OzrqNW0MQWPdRw38i1mYMO/EQiu2U9OiZIk5OwliB5wE2SXunTIGW+gx4Yk53M0
 iDYA/xDM6RLdwf7x7P8hj5IhbiFxg9/klR07MA4nsZa8ZJcKrXtR69f5BPLrdDCDcGt3s
 4c93n5LMV3Nk5H8kDk2v2fzT32+Gqhr3IUVIIySZFj0phuKXHepN92N+mpcOCVjNWB+MR
 BOcp/mssv8pyUzeIx7iYz8UXOcsCQhCCVU9MvwNQZY+556SIo9itfRePqQoBJp/k4bw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=gcpnQ1gh; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=gcpnQ1gh
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FCCF40061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 05:26:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 386DD105AAE; Fri, 09 Oct 2026 07:26:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791523593;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=0YI4LOV8ywZvAZ9F5QLNUTIstknzviDvJK0Z7H+F0O8=;
 b=gcpnQ1ghSiP5SKXkmGjKiI+SIC2IzqSBgvXu4B3uIAXXUYNXJ7Vh23RSq+kVE9BSb5AGhv
 L3aIWVY6MIq6WVthHwZFRthD4LR9SEAeEBgMuwKe28Mr7OTQaVDid/aE2UirEuDkkkDJYu
 Pwra7cwnj3TEAHMSf68fC0y89cMxd+OJ52H6Efl/xj+svjNrI/ckfssAvf2mFiAD3alOfI
 g/jkzoCdGQy/GmuugAW7dmWCduXLCeBcZ9/K/Z6u3YHRhaWvyLliaHtvyg0B0lx7oOGgGv
 OFgorB6aQwrcw4Nl5CBinJM++Q/NEjPPBNIVfR/yIcWbfI+dGi95uWkiq3P5fQ==
Message-ID: <b16f1e6d-58ee-5b07-c235-14fd8ae0168b@nabladev.com>
Date: Fri, 9 Oct 2026 07:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
References: <20260914091932.1194199-1-JJLIU0@nuvoton.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] i2c: npcm: Add deblock callback for bus recovery
In-Reply-To: <20260914091932.1194199-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Jim,

On 14.09.26 11:19, Jim Liu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
> 
> Add deblock callback to perform I2C bus recovery through the reset
> command. The recovery always resets the controller status, even if
> the bus is not stuck.
> 
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>   drivers/i2c/npcm_i2c.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
