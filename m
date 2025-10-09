Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B08CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3034484572;
	Thu,  9 Oct 2025 16:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bZPuhJI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663298456B; Thu,  9 Oct 2025 16:19:06 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 553908441D
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-643cd58c678so563420eaf.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019543; x=1760624343; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mzpYQ5MakmBAoX1JbBwJmgPAirxuX0hLmP+7zpkaxbg=;
 b=bZPuhJI5KxrggXJWZ6XYmW/nZFdWpYZE+mw/Uu+Tof+3zSrt+wAeyT8QS+TtZH2ReZ
 wRg8Tlf+ef956dO8Y8w/mrblFKVelfb2aG4nlW5K84njqF5c/UQYkQKeBBWi2N+XlFIJ
 RBX7CR1FcLrZsYSBq+DM/EnhauYRZ0zzwba7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019543; x=1760624343;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzpYQ5MakmBAoX1JbBwJmgPAirxuX0hLmP+7zpkaxbg=;
 b=pp48gSfPw0RnvYzD0Bvu0LALt6nkJcSwQfuV5EaQIjKqqFuPACYfO5wLDuX3/qdqDF
 aPVm81JVbxS+ZNSaeyNyn6D3oJ1k2eeJSSNTQJbbJl4eLoHdwFIp2iOl5ZJfO2IccETq
 ge5Wwiv/tub6tpy9ipc8dDb/E6VrVS8Gyv99SDL3eGRriZm7tLmxXbGeI/xG1xNmqGh+
 CIdVZHtrNH0K0nOn9mqaoImjmmmnzbPfvlg9QUyw4xSNRLxA4lDssMRKBBG0aVO3PYSw
 NUJKlgLl4DmxEC0JuucIBKYS9cBUOp7COabaZqBZYeCCGCDepwwIhldRsvPuuHSUcU+n
 8DSg==
X-Gm-Message-State: AOJu0YwM78OEgy3jHzGB1itXaGqxO/fUstRm4YmAbpxNDfcX/n5B7cte
 GXd6ocTs/vIoFY+LAgGf0JWTytLBOTVDhogWqnuzoGu3zFgiyqwQwnG5D8D1g8uDh1xJGXjtzze
 51dm428g=
X-Gm-Gg: ASbGncstPH6lTq/jRUR2JOqJC7DlbRHR+qxhqIaHQPTSO995yfBB2n/uPldTFVm1SJW
 vCpv4yHb8LxyJ/r6OkLvaw1W8Jc+WTLxzVirooRZCLHlgs5owzqpzo8dUBbLqwAqXhcvRjaj+8i
 hcZuU63aZV3PnkZaRTfd5W/35FUMqv6jpXCD4nAlQ5w932WHRrd7kA2U9KwZpTkKlfiMccStaYV
 dHRQxcF9DUv4BMcNaApR5c6WIbNiab5D0lvTXtB+LklBXmu+VGXzIqdosWYpcKg0UkZpg5gfPpy
 pJJM97abkOG5gCIAqSMRmbDpySzs7puc3UbhmsOCDFv4SVEqm2AEMccNdIl46q/uadmF3C4Leg+
 AkKhM08JlwNp7BmLlvrQMssBHGywQuYe82rDZa5+ziitbnQrYVMaQ5a3nnWIyxW/oq5ufHWRglC
 N8plLknZRT
X-Google-Smtp-Source: AGHT+IFBIAATDyhacyT6S/IiRdi0nRy91kDLUInkqeCuoCTKAphB34kOOPNJ+uCR9nq4GyIcvsj0ng==
X-Received: by 2002:a05:6820:189b:b0:650:1417:73ce with SMTP id
 006d021491bc7-6501417933cmr680318eaf.8.1760019543040; 
 Thu, 09 Oct 2025 07:19:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:19:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250926153148.3680967-1-trini@konsulko.com>
References: <20250926153148.3680967-1-trini@konsulko.com>
Subject: Re: [PATCH] w1-eeprom: Make use of static keyword in drivers
Message-Id: <176001954229.3159859.1835904261854949352.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:19:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 26 Sep 2025 09:31:48 -0600, Tom Rini wrote:

> Both the ds24xxx and ds2502 have a family_supported array which is local
> to the driver but was not marked as static. Mark this as static as both
> best practice and to allow both to be built in "allyesconfig" for
> example.
> 
> 

Applied to u-boot/master, thanks!

[1/1] w1-eeprom: Make use of static keyword in drivers
      commit: 7781f1d832bbf9461b82d48301091b15fcf1be14
-- 
Tom


