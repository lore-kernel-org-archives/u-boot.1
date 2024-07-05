Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE96CC30653
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 00:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F5C888F0;
	Fri,  5 Jul 2024 02:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uR+4fCKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D8288934; Fri,  5 Jul 2024 02:01:46 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CED7885EC
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 02:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d566d5eda9so534840b6e.0
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720137703; x=1720742503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mq++KdySjwFWnpsPNG2foiWtoqo5GX7qrU/eIaISuQk=;
 b=uR+4fCKKiPjilZ4+t5r8gRmdvnwj0Po0JBwS/gwzfs9hec+aIQ1IklNrl585oGk5ob
 B2BZ3tCO7iMnjCjHI6MPyMFERWGkatoM4bICGoW2kBl2cQCJY5g3eij9EbHBXPOy0sSI
 9VBedTW67bFYaQiXcfDWSTQFvRleuGcY6lIZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720137703; x=1720742503;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mq++KdySjwFWnpsPNG2foiWtoqo5GX7qrU/eIaISuQk=;
 b=trhKHrZo2qUxs5+wRbd0XbvAOI8obA1gglvvb90xlDrDuolRnNWvR52x7XOijTWZQ2
 c68EN7Lmy3IkejXWgnq7ydN0XZn8Ov1GEbepdwSsVx1yhY9YI1HH7m5cAeeDNyRDXCA5
 SF+YBYmw1ciSEl0hFHl3k6nqpXKoSD1UoztnINeiWk/R8n8JwMZLa6zh6c8k/7qgn7i7
 NmnHu03LggczbdyUmQQdBeK4foF0KtzX63SIUQ2ZbCH7iwEdPSdNRqCtykAP1CWzAwDk
 RXYBDEaZM8tXolAADDHWc6RTkaiyw0js6ZLoOLT+7lcX7F4d/2Up5L0Ll+UckCZ0eGuN
 yXtw==
X-Gm-Message-State: AOJu0YzSneV1yHqT8e1RJVq5Egv7cWcpW8AblTt9sNiffuYZ53oOaK05
 yRbQacvZhsuFImd47T/GJ2TeuiDu3bfKoQAGgFH3lUZ3RVjW+upxNiv+75nd6fM=
X-Google-Smtp-Source: AGHT+IG1FyCl7dMFgfpu0h6udYRuc7lnG51VqCRoJyphc5osKDbKxSKObgNHs3AJOUms1IFR6muwaA==
X-Received: by 2002:a05:6808:f92:b0:3d8:49a5:7c99 with SMTP id
 5614622812f47-3d914eab9f9mr3464626b6e.54.1720137702255; 
 Thu, 04 Jul 2024 17:01:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62fa3984esm2568485b6e.44.2024.07.04.17.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 17:01:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
Subject: Re: [PATCH v3 00/12] xtensa: Enable qemu-xtensa board
Message-Id: <172013770136.1516714.1427723044278371009.b4-ty@konsulko.com>
Date: Thu, 04 Jul 2024 18:01:41 -0600
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

On Tue, 18 Jun 2024 14:56:00 +0100, Jiaxun Yang wrote:

> This series enabled qemu-xtensa board.
> 
> For dc232b CPU it needs to be built with toolchain[1].
> 
> This is a side product of me investigating architectures
> physical address != virtual address in U-Boot. Now we can
> get it covered under CI and regular tests.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


