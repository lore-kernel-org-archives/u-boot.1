Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22177C54FDF
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 20:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0370660821;
	Wed, 29 Jul 2026 20:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id baA4bNtVJ0iu; Wed, 29 Jul 2026 20:33:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06256607BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785357199;
	bh=VZmk/c1W/lt7+pc3Toq9/krsISpkczgUCciG/TZIzkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dX14jLzEygYLiv6fnq+lObiJdWjE4BKngSw3wJQrKhJYESxWWWARreaPxRJvJnDlj
	 MoawKTo4Rz3Fzlx1Gh9WWWZuOOIIEJcRPBks6WTMS6JeAA7aI/p/2XjInmZYC2N91m
	 iIb2MMN5lIsyhxWd+InTVejWgkdkk9AwgvyklOBa/BdfxJZmvdm53Sdaq0YI87lr/6
	 JJ6yUw1CIWlNeUNt5sG345guab1keWpZGmb14ibh6N4dWPJ5pO4GamY6/DwkMSNlW+
	 x4IUG48OFW9GWpVik7vKDNHOOpCdsq8btLx9zNZ8LEW20bi5DqQEXt/c5hfu4OSKAc
	 /+ehv5LenbmKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06256607BA;
	Wed, 29 Jul 2026 20:33:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26F7C26E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D5C8606ED
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pt3X6ExAgoY for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 20:33:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 509FD60786
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 509FD60786
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 509FD60786
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:12 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6ab05b2f9daso557206eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785357191; x=1785961991;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VZmk/c1W/lt7+pc3Toq9/krsISpkczgUCciG/TZIzkA=;
 b=bWz229B6USsyrpDJ7dtGVbV0f6KJmMn+B3rMYvYRO8ct6WpWBHkaSRpNIb48ITTwps
 2bTNw5q3jqjnw7ThcByoXGOJ8aNnvysm9G1Co83wJTHc6mu/RiWgzvCdLJpO7+Au83zf
 2LuTvpb/zuHl43zRNl80OEGIuDpcoRvXHZZ3bYuqYl/pMywoLCDD0wT6NYpEGzOYmiaS
 uqGsIBWrNbtKWF2Vx0QLPtfzskABbJcC0tEHdlrI7NZyITShaK5byKZ58Xn2os1fnnnh
 wK6V1SWy0Q0kmq0IynrhBV7+2PzCFs+jCUABneFBZ/T48SvkVoEtB3HL1qGP5U9k7ef4
 MkSw==
X-Gm-Message-State: AOJu0YwHjTO29s2WVtcBt26ud+hUEZ99bEl5mGPB3Ol4usRf5Nmn4426
 KSlr/qYsXNBcAJ3RsjSZqRBjes8dNQ1NMYmM3PE9g5wQo/b9YF7DYA1zSJQPsGu88dU=
X-Gm-Gg: AR+sD10ZiQPCnPm2/6z9nOKy9dEGfSO4wl6zPlb19les/VvON9AdIdzgEIhmKDHoWbG
 B2b7lzFMMYuUWEEaHvdWXodrLgds5re5UmDgcXkgjZ5vATGpgZDXUwtIervicYtqkh5uEFELyN1
 vdQDLpiHBXmbWycmnRgbWsOR//9ksNc3ugCk7yO0UzcchCfa9WDPBjzLKXFIfpTOHmsErJWndpV
 C3gNb/hA1y3YruokM2eEwbndzrF7/9nPqJHYlFqWLgOsneoeaPSDCCCNKE+KJ1p7kAX1TaDanpJ
 b479UuXOrQxFNEU5Hl6NbUNHpYDUBz+Ry2obECypmj9TTsNG8pQ6+zVAqGRHUF1oXdnaBrcfday
 hdEtTqOdN/gds2on7YXHR7bNWSGrQgExh3lDIr5yPiKWEeUdLwsfiFSPPpOCfzvY+/b8Lxtd1wr
 HG4Htb4vNGwxLcrbd+go1m5fjXUJrak/6sdBOGEeMbGJrs3oJoBXaVERfPuGN2RLZLeL6ynaCRc
 oxLQb5EzC5CxLuAn3QIGMPxy7izvQHDeMur6ke9rOsKiBM8p2SM6YH2kVxY94qjzhJEH225DcSV
 gInmnL6Z
X-Received: by 2002:a05:6820:4de9:b0:6ab:10b:1a97 with SMTP id
 006d021491bc7-6acbb787220mr30516eaf.43.1785357191255; 
 Wed, 29 Jul 2026 13:33:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4588688e692sm3420221fac.14.2026.07.29.13.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:33:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
Cc: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260724-update-mail-oss-qualcomm-v1-1-bf9d3193add3@oss.qualcomm.com>
References: <20260724-update-mail-oss-qualcomm-v1-1-bf9d3193add3@oss.qualcomm.com>
Subject: Re: [PATCH] mailmap: update entry for Christopher Obbard
Message-Id: <178535719022.1975967.13296475479387616264.b4-ty@konsulko.com>
Date: Wed, 29 Jul 2026 14:33:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785357191; x=1785961991;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VZmk/c1W/lt7+pc3Toq9/krsISpkczgUCciG/TZIzkA=;
 b=NmOC494r5m3n3RsIwuxeVr/QVkYfrpDUQQsL3e+Mqeq1KC5YRnEzO9/vw0gbSzBIWh
 VnAHKjfSyWoHqISUIo0YZol8PaRUKiaXU3Gwvn+QkXTxWeEtFTTaylI18YVOl4nnQzTi
 XOoND1PPnJHKVezqv1/M5kHZrParu2HLYe/Xk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=NmOC494r
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

On Fri, 24 Jul 2026 01:34:02 +0100, Christopher Obbard wrote:

> I have changed employer; update my mailmap entry to point at my new
> email address.
> 
> 

Applied to u-boot/main, thanks!

[1/1] mailmap: update entry for Christopher Obbard
      commit: 44f0dcf476140c1077ee3dbe16a80fdb6f8265c4
-- 
Tom


