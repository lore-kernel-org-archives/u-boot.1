Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0332C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 19:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45B588190;
	Fri, 22 Mar 2024 20:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b8oY5P82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3512A88190; Fri, 22 Mar 2024 20:26:13 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF7788065
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 20:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78a44aee234so8075485a.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711135569; x=1711740369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRog0F/FOiFCQ2pmj7PkqGUmbR406qgTDjVFWxBNeoU=;
 b=b8oY5P82GhWbY47ifX8bC+xpsXF04EeeIWE00TrQDwuaHZm56cI1MF4TwBBYOh7jGW
 Fw3elscP/ibzPYzGd1Sk6FSuzymZ5yqblSe+UMnJwRZz99guU12cT3TyuKH/M89FowTc
 hd+Tk4gwfZSe23Xdkq4OjEpTSdAMdkmwzJpGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711135569; x=1711740369;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iRog0F/FOiFCQ2pmj7PkqGUmbR406qgTDjVFWxBNeoU=;
 b=SEceAKNHLgTFRClMdqPt1ID64QSXkc7ND2hb9fmmUK+6Uac5QY9zF2VFgl1IQFJNGC
 JOeT1J5pRWRvyGyp6vdJLXHLor2Z08W77+TnLGAGVQFoQiXSASZjVxLKWP7HWaj72tnh
 7vBWYVRhnDrbo3SqjC1yMayj4J4ktGHwhTIRRclJSV8giaEebAgZVT9OQSRl1unMDMbW
 Xz7Jrm5j8uHIb+xZKhXY7bdlAPZCd03hoeJnnwtgBoSM7Vv6h7d5V2neecdKSB5kC9qg
 B2HSUTd5HGOrjSDgG4AXZcQeeHi0KK4hqriyhtouvLlkMFBww61frdFP7+Uk8RDvQpeT
 YPZA==
X-Gm-Message-State: AOJu0YznLe6qkPdI0kr6jR97dskc46ReNtmhH8wod4udV8RjbPweTr7p
 cYVWaG36WyiMOLinoAuy9xThATD4/VueAA+SebAdG7lhZYCiHpzzjxw6qKN2ONJCVxGEAN5Bq6B
 M
X-Google-Smtp-Source: AGHT+IFAQ5J/0nKEu1o/3NFECEBcuo1LbrmzTlesS3OgRRBNdaOcGNFLDcg+N7/c+XFn2Tl0IpaVdg==
X-Received: by 2002:a05:6214:1c87:b0:691:8493:bf21 with SMTP id
 ib7-20020a0562141c8700b006918493bf21mr5144151qvb.32.1711135569665; 
 Fri, 22 Mar 2024 12:26:09 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 jo10-20020a056214500a00b0069102f97e08sm1362309qvb.97.2024.03.22.12.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 12:26:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, kojima.masahisa@socionext.com
In-Reply-To: <20240318104718.18365-1-heinrich.schuchardt@canonical.com>
References: <20240318104718.18365-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] .mailmap entry for Masahisa Kojima
Message-Id: <171113556879.2191577.18108237016377608814.b4-ty@konsulko.com>
Date: Fri, 22 Mar 2024 15:26:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 18 Mar 2024 11:47:16 +0100, Heinrich Schuchardt wrote:

> The Linaro mail address is not valid anymore.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


