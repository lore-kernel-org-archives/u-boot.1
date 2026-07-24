Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925B1C531D0
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 01:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFAFA40AE8;
	Fri, 24 Jul 2026 01:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dTREsHe_5Ro; Fri, 24 Jul 2026 01:02:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53DFE40AE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784854930;
	bh=+m2iSFOQUtPUi8+K9xinuPwK/aEa7sB4Uq3lOFT973A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ua6vRUrBNEEpWTO8ZW3NlMo7yYiReIcZGx53moJZMKonT4Ez9rJvhn8bL2CgG7KRK
	 8jGu35o6pcUGwN1Jzn+eUidYgNmq5tHDwTWFIF2jRDvSK5PdBhG5JX8A9BpyXNUjjz
	 ZDRry1aYEDBoigrUb728vPYhwr4vcOrFqgr6Ut5sfBj/gdKfRlvH3+t+IAX52sQikP
	 zXRuk6t85w6fcaBKw23DCODyH/WFGZWYohJQswTrOlvc60YLyBRx4GcI5HrNTdTV7s
	 vuYM4a0dJi6yraScvGnxlUfeDhwi29R3qBtdhFw5r/12ywrLGkIS6H59SFciSAkvqF
	 VHG8AIP6xuu0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53DFE40AE0;
	Fri, 24 Jul 2026 01:02:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CC4BDB4
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12DCF60AF5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EmfrvV6EkB5i for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 01:02:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 25CD760AB6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25CD760AB6
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25CD760AB6
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:02:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325F18493F; Fri, 24 Jul 2026 03:02:04 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FF2D800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 03:02:02 +0200 (CEST)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4518ad44e83so679770fac.0
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784854920; x=1785459720;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+m2iSFOQUtPUi8+K9xinuPwK/aEa7sB4Uq3lOFT973A=;
 b=rSOtUzHb/7DRr8ad621pNczb1KVppMUE4o/+vMbaLh+dM1snvN3qKg8FrLFxheo5ex
 S60Kki6M0smjXx8IENSohwqxer2FYgg6HGvyK2e+7FfZXfcBN+72vFOsLjKl8WBJxQy+
 RLd8kan9ZNw7rjXviK/EawliNJOYiqPmhqmPgc6iGz2zQSbZaolc+X/bKpuJe1lji6s7
 tceWhytIfTVGg9ydVnPwa68hQNsu1wFmlzzC1oligfpehxGgZWzDClhXniNZNgP28IZI
 E3iNfQuN004fvaqyNtV6Y5+WQQiLmy+SIKJsuE8NGf0sDO4hM2RJr8kzbs3aOJXvQJ3Y
 DkXg==
X-Gm-Message-State: AOJu0YxjwSdUiiKTEkJQZNvG/1IR0c+AkI3uCArNr1K0O0BGNonnqwAj
 ThuFxk9iztYGzDs3gQhGL4oG/FhemdyxugmlD36X5Mof1cWnTutF5RMvI6ONe1a62JgZRUEbO4k
 hVuKrBVU=
X-Gm-Gg: AR+sD129CNnzm23sEn69SvD6+sgp8sl+U+jnNq2JsXBbeTfNdtb0zNk23cIUkNxyMAC
 FHHCigpFABJJvzaDGKRv2A3HVQrfygwfxG6FMEbkfhWWsBFfAy9ETZrUNy94BqehaHsM4pPRquc
 iYLOZJRy6P98qkprBroOSyGY4NzId/ZBRGrLr5O86e9cGKNxJuJOFEpOAoQKJ51mGk4wLQYkmvC
 BYZkmTkjEZ4yGCXE8W86gkTzYjtEeAEDKZb/2kuHi6gD27+eUV7Zu1ksQm9KZvhTPJr7GemblgP
 1IKImLCN0ama99vXmW+KIZsUFSgLPWtzCWhBgYZEHgmVxeeGaaFYcDk8XjmKLh0HQ/sfbRL84ZT
 fT0N81CvS5exHrzhGa5NjNDYU2mgsLcEbqy6oNyTMUbiw54/0BvC9eA6gwxZqTuV7KeaA5AWK2l
 hjrY82cQGVKXxdGuU8GaK19U5XSxJeAjwtmDIXwIW+p314O1juDOcDK9FulbWStXeIt+OGB0HPE
 Yor1QexzQzI/xVfuOZhImSKMQ==
X-Received: by 2002:a05:6808:301f:b0:496:892:c58f with SMTP id
 5614622812f47-4ab3530f92emr2607778b6e.2.1784854920615; 
 Thu, 23 Jul 2026 18:02:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0c7a01bbsm4196177b6e.1.2026.07.23.18.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 18:02:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <j22mfoxsbrv264hukqkqdo3rr3lfnp3aramfno3proupzriafw@qe5czb3jnsyj>
References: <j22mfoxsbrv264hukqkqdo3rr3lfnp3aramfno3proupzriafw@qe5czb3jnsyj>
Subject: Re: [PATCH] cmd: strings: interpret second argument as a byte
 count
Message-Id: <178485491944.3246206.3933771054151869205.b4-ty@konsulko.com>
Date: Thu, 23 Jul 2026 19:01:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784854920; x=1785459720; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+m2iSFOQUtPUi8+K9xinuPwK/aEa7sB4Uq3lOFT973A=;
 b=AR9BZmuI9u4r/GBod/q4Wbc6HwRWLN712LX05rhmqQHN9JXifZXOOkaPUN0BBnCMGb
 gDwDbA4l8c7KP0SanhvH8uBeKEazqIfueD60q1Qv4JU3T1NkWFPvLo8Mnv0DmpPMCl4r
 ZzzZk+Axq96G9Eqhg8DkZhvLMTyK9zXxJaf/0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AR9BZmuI
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AR9BZmuI";
 dkim-atps=neutral
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

On Fri, 10 Jul 2026 20:53:44 +0530, Naveen Kumar Chaudhary wrote:

> The help text advertises "<addr> [byte count]" but do_strings()
> stores argv[2] directly into last_addr and the loop condition tests
> "addr < last_addr", i.e. it treats the value as an absolute end
> address. When invoked as documented (e.g. "strings 0x40000000
> 0x100") the loop condition fails immediately because the supplied
> count is far below start_addr, and the command prints nothing.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: strings: interpret second argument as a byte count
      commit: 3c82b041f73fe804d9d464508ceb625a856a38a6
-- 
Tom


