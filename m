Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08217E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 15:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2752B893D1;
	Sat,  7 Dec 2024 16:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X1UIRQvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07CD89182; Sat,  7 Dec 2024 16:57:15 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25FA89182
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 16:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6c593e8faso39286885a.2
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733587033; x=1734191833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLsrRXHu8GV2+LI68dJ15BFYbuX9VcXBTEMpX4YatyI=;
 b=X1UIRQvP5Yfs5h9EZAqdVk25RShoNQHV4K7ypCX6k6dpxiCzHSer62je/S0V/sIIwC
 2RHdGQ98D2Wv+1koTfcGY1WP2Eil8rOBcDvrvQJiFRckebvqTcqRN6gkNk52fr7X9Z2o
 L/+WCCOZ4vxW9Y2ty7syhJL2FKmsfXiLF86UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733587033; x=1734191833;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLsrRXHu8GV2+LI68dJ15BFYbuX9VcXBTEMpX4YatyI=;
 b=CAGh704D5CwdQq9u3BN/yansIxYVRFqyXU1ncdG1lQqd91ZFIdks1GUmSdKSMn1/zk
 PMPIo/I12X4h14EFIUrm7EehOQ6VKHOdrXUSEUFh4CL8Lsn74V4b0da+bbK9+wr2Ah6S
 42W7auJVMRgRaGUZeZdKlhPN3XF0iU8t5F8fac44vhXMPmoC3MAaN1TGsHTeguWfM7iu
 GSKO81KV0xDUqHQSKEc08cwzu2cB7lia7IcTbN6JKfzwR3JHcoiTNs3FP0OvcWus5Tio
 /sM45YDn+IsttsWjKsOwEfefjjr8yP3uBnLuT0ctY8ea/LrhZDD8nhabpmnkdEuz+uYT
 SquQ==
X-Gm-Message-State: AOJu0YwS98QPXxyNsNptVMF+K5CLAz1i4+VxJOwNGTIaGSSCZguTsoZp
 sPCECAuxh618beHU56rGqYoVFOypPJyBGVV80lAgI8XNs5/0wLcFCqR53W6a99H2I06qKMn+efD
 MSnY=
X-Gm-Gg: ASbGncuP6pwjbqcFOlphWZXrxa1jFm8AwmTXjsDU6saBbLp1oEj8ggSvUFzdaytAc4q
 OR8MGC/okKInUTOLBIiyBu5+57pwOXGXxvjPh2c/Mhv3S/3UyZ+/mL0zEr5Xo5FQu3oQKf3KkLQ
 hGBJlB2BwW1ze9HchBuk7zjKH7hQFqyliWXhUXL8z44qYRXuF75TEOKHTbmUF3dayHEmK/SLd2/
 Dhol7XEcctbbbq8ce4SblAjpdBWT+btbmsNTGatTS1ivcFLZA==
X-Google-Smtp-Source: AGHT+IFUOY4cJm6xzn4MUl+oWvhncsfGJ7RnnODyN7UOvajSPDsdP74UXddYD9MnGslG/7dNl5OC1Q==
X-Received: by 2002:a05:620a:3903:b0:7b1:3bf5:2da9 with SMTP id
 af79cd13be357-7b6bcaf0e31mr906956685a.31.1733587032686; 
 Sat, 07 Dec 2024 07:57:12 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d2f15sm32998151cf.35.2024.12.07.07.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 07:57:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
In-Reply-To: <20241206075853.1819633-1-vincent.stehle@arm.com>
References: <20241206075853.1819633-1-vincent.stehle@arm.com>
Subject: Re: [PATCH] arm: qemu: fix update_info declaration
Message-Id: <173358703075.3722028.14984851921617797638.b4-ty@konsulko.com>
Date: Sat, 07 Dec 2024 09:57:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 06 Dec 2024 08:58:53 +0100, Vincent Stehlé wrote:

> Add a missing comma in the update_info structure declaration.
> 
> This fixes the following build error when building with
> EFI_RUNTIME_UPDATE_CAPSULE or EFI_CAPSULE_ON_DISK:
> 
>   board/emulation/qemu-arm/qemu-arm.c:52:9: error: request for member ‘images’ in something not a structure or union
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


