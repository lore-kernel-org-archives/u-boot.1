Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E02CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7506060618;
	Mon, 12 Oct 2026 09:40:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZ1MBP_yp6S2; Mon, 12 Oct 2026 09:40:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7412605F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791798045;
	b=C+M0/kAde8Zq+4HlASii43Lnpxe0GtnzusKWiQA+ooJZPXZWes8FeXuqBT623vch62L2
	 Fa36jROc1oiVWLoyfcOqxXA1gZXui0/vmvHyK7EIbrvDQxSjvzpBHyOIcrAZ0varHjhc7
	 arSVwNPOE4wmrjdeCO1FCze92OP7zZDi0xIOwZsph043a+8jUZzuXHwsPPIR5Lcwgf0Xk
	 LsU+s1kEbNElwV+bk2ACiy2ga9TGeo26Gl97u13V+NKBvYr+E0FcTMaqIaBLWAaDEu5Z0
	 WzOsKgphEcdhCstn838+qUXRyiFnqJXVLJYZK2E6EZDKpmbNdHtDv9/LVt1SbsQDzkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791798045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZF2XPhc+v+Hqt64vd+Er92zn75LcFLGZ6dG228XxhG0=;
	b=TSJXZ7o7MctOsMnRStZf2/Vb7VyFzLlsMPVOTuz070xyGQ4RfdOJsLysTk8/yLCvJFRU
	 LA0VsgS2FhnZYT4B1c9RPmWW64R5ooqJWOqjqQ7K1awMiRWxbByEBUI1rX8ROb4FeexZr
	 8guTQydM6Sz3Buhsa+pSkO5ZQ7fokYPebL5eSgYSJHTctjaKrFN4oUNrWNPPCTPeqBetQ
	 PtUGSKSrav2u1yBLIg79CuopLpKwg+xQjmR0A0STX/eg3OUc2sFksxVP/XcKsFucS4izx
	 nATSsMP35GIXQM4rmKuPebZ7vIHz5Sxcf4T012CgwHTGjXExP7zHPt14Qp/hti+nYBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=hl1d0LNs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791798044;
	bh=ZF2XPhc+v+Hqt64vd+Er92zn75LcFLGZ6dG228XxhG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOuCpbhc0+DY0oWXsYhDLJPKSrzLQi/gpkemL4wAHn/Jvwj3nM+9YpjCg7P0hvWbp
	 1x8rF8YpQK2M1+ErxOOLh+1mhEIuVZ3tnXfhODcm0nLgNYouVj7cLwxiXTuuTJoJgo
	 ePR370YZiVcGSVi5LRX24huGYB4QXLa2JCabM9WIPfRA2+sSSh3lCZx0R2xynS9/zK
	 PYDAQRz+qovG0/LuUiVg6lhpq/GcLaE8zizuUyUDAFqOGNwcZVmKQlMTJukihH3eDv
	 93f0g+vLPguhDEJMe4mP39hnv/RH7pTjWsVwvy2eojG23Ikv6PGrBNg/YISxTNpU4H
	 tN4vqDCiJRQUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7412605F5;
	Mon, 12 Oct 2026 09:40:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61C55194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 479A8605EE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yRREGEb-pHHU for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F3F59605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791798042;
 b=T5xoLNdkXOeFqwhQzq8WGPc/nS81g6yXUh7DZEQHMo5QM2hLYLJ+MfV/IV17G59jjlSf
 AvJLYx2/3R6sur11Zg54CImO9niVZJIz4x4YD8GgosPcumGQv8r099bj5BS7VFPh6Z3eX
 MrTnEn2+vfBQQJUsx+r8eNtGSTKNKiWl3wlx34TQYBpyl1hFnh4wGVv+EqjZR9chQauoU
 nUbSWL5i7kt8Sqf9Uj1CFcMc1k2BWHNujjjimi7QFtKhbNbS74rkkZjZxxYs0unkbDRf5
 0D+/hjsXlcXXBTSg/++yXvxq6HeQawLtJlhH6F/onu+8y4oakYRKdXB+i3AUia+7Buw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791798042;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=ZF2XPhc+v+Hqt64vd+Er92zn75LcFLGZ6dG228XxhG0=;
 b=o1eJfzEgaZIPolKGpx/lef6RW/q4dVhWVfVvbmqHIk9vY+8mRvUz1/zwt7uIyRf5CGHC
 Em/ntewy1/HfKDEWyGF9ix/gEEpnWP44qrLNo0iJEkdn/S3FfqYfxFCLpIkhmr6eQ31Da
 xKHnRdkfhKt/ahh/neCar+HFkBghZ+2hi6y8RDnK17AOywLnsnYtagXEfW113XzufVobR
 X+gOfIz3GKlpTp78B3J3D7azgMxNKkxtfnLMKDxAWG6EK040onLKweR4AZIpG/dR/HvG9
 Uja2eBEKKCnxA0qN/4O0TciziWouutePGSs7mNkTjO21QfuSJkRO8IkFqWU0POgSstw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=hl1d0LNs; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=hl1d0LNs
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3F59605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:40:41 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j3CBY6mpzzKnrh;
 Mon, 12 Oct 2026 11:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791798037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZF2XPhc+v+Hqt64vd+Er92zn75LcFLGZ6dG228XxhG0=;
 b=hl1d0LNswbqjgTm1Rr50/tdYGpasPkb1ijAt1nNL21oPQA/Rz3zCm5S3MuxLJ8VwWWBMPP
 esdWs8A2+EwdjrXwRJdGvnwXf7MXPZbpyU5COxPZhVJIlQRcj+P+I6/V22WXXEB7WLSI5s
 3sCBjW1W5446zxjQ37N/dW+NpVjSOFL4F2XY/BTJjrVwYsiGvFBQAQN0UU+ERSvmLKejoN
 2jMPRKZ8jldzirnwNZ9aiCfA8va4Hm8SU9ap/vRvT2ekMh+5/b7/B5epVthbn5JIwvx9y6
 XngrFW6TyPd2rsQYeypp66LYGtK4j1sjoWFfYD7NZmFIouee5oi/fczMnWQBhg==
Message-ID: <e367f3f3-79bf-4537-bd95-a0243a48b11c@mailbox.org>
Date: Mon, 12 Oct 2026 11:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: dwc3: generic: add SpacemiT K1 support
To: Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-0002.DaveWK225@protonmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261006T020608-0400.uboot-k1-usb-v2-0002.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 51uknmc4urys5guay7ha3uemqpc1uqp9
X-MBO-RS-ID: 551488d0d7a39569aa6
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

On 10/6/26 2:32 PM, Dave Klotz wrote:
> The K1 describes its DWC3 controller as one flat device-tree node with
> the controller registers, clocks, resets and PHYs. It has no separate
> wrapper registers or controller subnode.
> 
> Use the existing flat-node callback through rk_ops so that the generic
> wrapper binds its host or peripheral child to the same node.
> 
> The generic glue handles the K1 controller clocks, resets and USB 3 PHY,
> while the child uses the existing generic DWC3 host/peripheral path.
> 
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
