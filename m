Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A536EC54F51
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F3A160A62;
	Tue, 28 Jul 2026 21:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gnJOSVhshiVn; Tue, 28 Jul 2026 21:57:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B67E60A4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275828;
	bh=xjx0VEHLpHNbAS3aXUOGsiC8OsXdAvLBVKQ5edqZHIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pEWDcA0k7UodQsy4yhYPUfmTt664Arn3XLIZNXAlBPQLq1j8f76VEiRS5NWZOt+lc
	 ljW8Ard2DdwalFp+pnXtdl+is12ufOLBACnA7Slzr5Hu/A9goLg5NB7clMvQCdzTTI
	 ZBL8MIJa8AvvQ/j71eBMZzRd4fHyMP9Cr9tWOTvVtCdlUQQvcVCTeuaxbv9ZHH2pau
	 UWLMJ4usoKsAqxVQdcGdcfWmOqOZn93uaDkVupkRD/5Ui4gCxs7toVn3UnBjFofrog
	 rlZdmkfZ+0wAgrNqPalOuYcak5YS0BiJHzeOthWV3THOJI3nd+DokGVjyqLxP0U0mt
	 58+03uo699R8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B67E60A4F;
	Tue, 28 Jul 2026 21:57:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7897A350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DEEB81457
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0fK8Shw_WOU for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 51BE481290
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51BE481290
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51BE481290
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:49 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb34c17b96so274866a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275808; x=1785880608;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xjx0VEHLpHNbAS3aXUOGsiC8OsXdAvLBVKQ5edqZHIs=;
 b=ffKkVN/xbBQnMsMEHYsq3DuUTmerinZgCEHLmoHKj3BSGq3GxbHlvb46ZnBTVgdid5
 h+MZ45JKQBUBTo6uejtdPHCitgUWkUEB4EDvtRWfX3GEDilGz4oo2J9GwBm36yxXkptv
 MU5G4qhSfIMt7JfWAuMhsAzI3heoTgsILZBlQwQY3kFOgakX0QAKXLtw48Jim4v8vs84
 DPc6TCUmdcc/0QSaigYnW/DGpcqVJNAqTBWowbjt5ZViH3dCAqAajfBHPqoe5ktTj6Ex
 mrDDaAJiimh3NPwmBOKH0SoW4P2zV8yOJLtMAO55oiC98RmFVo9OkV2zmtKCUpjugWX6
 p1Rw==
X-Gm-Message-State: AOJu0YzWDq9OehBFhhYJYYhbOHtD8AeZUD6EvyxhUSNDmoL7ApTuHdKS
 ynt7diBYwMQx+SFcx8VasUEAZeF9xI2a3GpdaXgXOBXOvFrCcvm6UW+Br7HAvFHlavY=
X-Gm-Gg: AR+sD10549j8N8tBdQi0JymM4sUltfBDPfnxFUWaLhmhKcX/lYi8/fELVW1k3JGKfiZ
 oyForFP0f6lm8zEEaCXMfMmFAX6tWp8VHGFf/Web1CjAXDG1WWYbCrRrnZ3Bt9mKw+RsOE/O/DS
 QziO/NyfQKgJF+gCCdMYcQDBCGVV1rNhHDcbhzf8NEDBlHnxZkwcrcnlfAptAxhAUMNmwwIEfHb
 xWL/YhjHfX4zdZdx+zmTlt+16p+482lHTKXKX7TGIWtTIvZjAOJ4Wy7lDrVN8caeyfsd8EdPUVL
 sjGBa5eHzVjuI7rgd94aI5Zl90mg5LpFGXH+NFmoH/UCfQcS7Y7RjeiCQLk6gonbxHFPXv0arxs
 aW0w1uCf6B3i1pCtaLgPc0Lv6vrohXtU1GOB4TtrtbvGxRoZwf48BAPnW1H17/jAHVgeDg6sH8/
 ChYftbeCwGNdpoZ1t6MbQ/qxUOv1upyrADG7zrb+29QPZGh7S4KyroIkUEWjpBzQs+4ihAuTr+h
 9wcFrXu1wOArASHKljeka4gqcGeZaJznJORrElhhN7zKGdiX8YBW9MENHHmDTr8WYxPDTwK42YW
 olfYESUn
X-Received: by 2002:a05:6830:6b03:b0:7e9:faea:3dd3 with SMTP id
 46e09a7af769-7efff30febemr2544252a34.28.1785275808297; 
 Tue, 28 Jul 2026 14:56:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, romain.caritey@microchip.com
Cc: charles.perry@microchip.com, mamemaria.mbaye@microchip.com
In-Reply-To: <20260715232921.1182646-1-romain.caritey@microchip.com>
References: <20260715232921.1182646-1-romain.caritey@microchip.com>
Subject: Re: [PATCH] cmd/mtd.c: fix do_mtd_io doesn't support 64bit user
 address
Message-Id: <178527580763.1742553.17118274689026311591.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275808; x=1785880608;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xjx0VEHLpHNbAS3aXUOGsiC8OsXdAvLBVKQ5edqZHIs=;
 b=sZIBOUeNu8TnfJkHafeeluJpZJ42xI2+KwzYEsiBFDQQimdChUrZb5VX7a9CCudz+E
 i/5HXgFKQ/g4+qDsG+1E4ko326B+9opdgMnEBN/TNto5h65uLzJKEX6lsdbKLRSZscOr
 ewVohL0p9/koNHgKODtxUeg/BMWvV9y4l+RD8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=sZIBOUeN
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

On Wed, 15 Jul 2026 16:28:54 -0700, romain.caritey@microchip.com wrote:

> 


Applied to u-boot/main, thanks!

[1/1] cmd/mtd.c: fix do_mtd_io doesn't support 64bit user address
      commit: a1ae6e971c3962f73257ee5c8535e108d869b24f
-- 
Tom


