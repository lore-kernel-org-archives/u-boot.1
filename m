Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F547C54F51
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA0A760A60;
	Tue, 28 Jul 2026 21:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DxIW1rgEEd4i; Tue, 28 Jul 2026 21:56:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3742060A55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275806;
	bh=SFmZ5BiBdNMCEcwzxdEx2cmJ1ahK364deS7qX21gVBM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jw2U8ffiJXeHeRrPz4XWBgHBGGWtwrOeWm5ZnH4c5KUCbLZ7e15j73CEr1Ee72MDZ
	 WKFbKXG1ckH8leO0yRnIbHo/UgUm9EXLiwc068i5FN8z/giP0Jzv3z5uTNIIxEbWqt
	 rM8L8keghg1oUusOLPWaQSb2QhWdbr/LTWFWEacfnmuMqcIUYjF9wjH1unXw8QeBxZ
	 8tbLlWdfD4RsCcTT2U6mOt87eIUdkJ9/wthLbpddOdLCcRO3vDPufw192M6kqaYOz0
	 x7ocBu8WGxySWQeCZMlk0SmCHgKLhSwM0C0PPVqe4LdavAO1Ypdihr47wdAUnRqMJ8
	 jChbQeGhRZpYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3742060A55;
	Tue, 28 Jul 2026 21:56:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFC90788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5CBB60A4C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RSPKUjRu0jZB for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 105B760A48
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 105B760A48
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 105B760A48
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:42 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso250237a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275802; x=1785880602;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SFmZ5BiBdNMCEcwzxdEx2cmJ1ahK364deS7qX21gVBM=;
 b=eXt7FgIZoS1hLprEovlF7fMYkzTxvRi2+GKV1efZCk75kJg96alP4/rynKnBElbhMF
 DpkzZoV7q7lS0s5tmGfZfwv9eAoIs+uLPupbzz9wXZfO6otcRCFVbcyEXLDG8iGMOeHw
 +K7EOGyjVqZdjGNHKLb0cqdl81kTJXZ96JN+QhUsiL324XmrTpPzP0nSrOf8f4KbvGnN
 F2awrSle6ZJaKHp5ObL5oZ2wKVIJEw7LQxNEOiYB+Cl+ZVOWO81nnAn5DA8tBrimWGmX
 F7mgC/AgUGovKMN9VZdlktZhyaBbEhTZXCdmLIYNIuXf5fxUu43Y0695j7jv8VkynP3O
 Rq9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKzLmesFGXrZFfZDptkQUY/a9UbADa3utmdfrZvgUQuqnDFQGq1ZUm+gxaWv5Mn7TXkdpzwrc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy6ZYopGpr9vtvXXzSzwimj3TWHPqpkm2CddSqeWI9ffY75oSjE
 RL5q7anniLf1W9K+A7Td4Ho0o50S5DxYBIido9z+PLXawN9eP/ZxjTG0y+xjdftksqU=
X-Gm-Gg: AR+sD11VT0jadiZTApips/GJAtfyayS8yPID38lcRB9MO/Pnnm1y4LOhd54/knoN3Gw
 8ZXztuHmIkPmG/TGH/DYAAbUO/ZfVVV73JWzh7uqV8UBwYGWOiVBC2SLOAyH9B3uSVl3vRC9Z4R
 NNSMbQb+hGFrvHdHb1QKPlywojfktS17/h0RP/rR4zuqjBGoWowNQgARCSwFswVLQ+YjozIacM3
 8Ez+iH/vrGJJYRvWp7vEgxEoaZ9wHIlP2JHbhWA/ltNFXKjHZwkZ1DAF+tf1XQ5HIX1YySZkUjC
 e9txAe1hTErO4kVvVrvkG4v6iNgwuIfZ1f7EJxVKXaWZnb2ybQl50R0iRChGNdJMpfgS1xvzbgV
 1BDoxC3KgrlkAs+IdkVqhEGHwAFNolRguoVDhdMszfVNecyiaN6vsLIU5H9jiO3Q/hmHH93zwoO
 nHKYOKlqBcQIePnmwt//IuIlBtqlpsRcJeCw8O7SMGLHphAgFjABFNNYjPa2xtWsjXIewE/H1E+
 W93R6yv5SC7PpWicyQWtr4pT4SqJDOZLZohhac9+wiCgslNKf6ELnFa23mqS5UNsUCq9HZ8jHr3
 zIc18SJb
X-Received: by 2002:a05:6830:270e:b0:7d9:f50f:9691 with SMTP id
 46e09a7af769-7effee030e0mr2565731a34.0.1785275801902; 
 Tue, 28 Jul 2026 14:56:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <142bf69a-7f65-48f9-94ea-c90260f3fa43@linaro.org>
References: <142bf69a-7f65-48f9-94ea-c90260f3fa43@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-nvme-next-20260728
Message-Id: <178527580130.1742553.4122976360398190771.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275802; x=1785880602;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SFmZ5BiBdNMCEcwzxdEx2cmJ1ahK364deS7qX21gVBM=;
 b=FXlJN//PvFsLk3VawGApi1KOJEWzGfk0e4Dam4BhZqse8DUFY1KNYn5GXYvJYGEm7y
 6C/ZrEkiplMiZfWTR2390slWZQcyfI9KeHH0TvNr74fCO2/+FeXiOk/hRyWrKUFcnzH9
 VyeMWEUaEH3bhwsHylNEgI+2bG9FMxuNlQ+nY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FXlJN//P
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

On Tue, 28 Jul 2026 17:18:56 +0200, Neil Armstrong wrote:

> This is a single change for Raspberry Pi platforms to use the bus offset
> and make the NVMe usable.
> 
> Thanks,
> Neil
> 
> The following changes since commit 042e45e026c77227319a426940577856ffe62e7b:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


