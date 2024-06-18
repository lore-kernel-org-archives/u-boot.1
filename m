Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972A6C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C76F8838E;
	Tue, 18 Jun 2024 16:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JisGGNAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB068839C; Tue, 18 Jun 2024 16:53:24 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE54882DB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2547e1c7bbeso2904151fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718722401; x=1719327201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vAhxtgjaFVH/5MBc+9nQYBLdu1xHaTlfzwA01h0W/0=;
 b=JisGGNAaoI4UKZtaG/MejDLjsZzym5AlDhzLfPvn7PUd49u6BQQJoigz3VMJ9mGGBt
 ZxhvjJsmgYELYvQlCC/NWP2lYA1Egp8+GCZe72+FSYLHf3leDLXb8Hdvq/+CIxO3Pwll
 898TuU73domgo4vJlUx8uTB8Mjtf4yHVLTFtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722401; x=1719327201;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vAhxtgjaFVH/5MBc+9nQYBLdu1xHaTlfzwA01h0W/0=;
 b=LVdvjOMDvIvfUiKN25in5iBrztNSalGho0aL/c/L6Sj/KcJMY0NhFNSbnj7/l6YKoM
 z05FfQPRtdiy0VyqldtF23X/Z9d/zqppaJExlAl2B+ik2nafWrcEjUI6qdeOw2iIkhos
 ikms8sGBEHt/29ifRFiBzM6dcRaljZNITBs1yigf3QOW0/12KU2ixaxKNHEFFcxVbk2V
 dTufGg+ZKoGUp44zXBqRVvgNrQe62G1EbxXeeFysslLbso5ubDZ1QFDhmDqxkAFfl/zX
 jtQornIl7MbrM1622h32usgH+zFl7kXeWvjAynkFY+7fI9kYA63i4A9Gy8i0lym8x4OP
 AKfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy7m0EmZJic+P9vDbW/10DPWkyPlfxqfrPbPDIhY1zKu2MyXk1KNJSETAJkwynZdsjIsHiSXgqNn3LAp+Av3Au6Bbf1A==
X-Gm-Message-State: AOJu0YyTO8MtPR+BDsJ71a8MFcZ95iKUDv9hf8hE3JjpycpTsq2F3fyL
 SRLTYByxxqqqVBBoPq1rZ8rowEd+y5ezlzH6NM1HljxrHMY5qBq4U7VE9g8Msno=
X-Google-Smtp-Source: AGHT+IH03CndyZnTYaozqN31r00CvrKlBUjATPXmqBmD78jbBq1L6XX4x3PLlioO8AN1areVRg4NPA==
X-Received: by 2002:a05:6870:b489:b0:250:876d:2a74 with SMTP id
 586e51a60fabf-25c94a0e5c5mr13424fac.30.1718722401176; 
 Tue, 18 Jun 2024 07:53:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94b7besm3202888fac.6.2024.06.18.07.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:53:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20240605091057.48225-1-andrejs.cainikovs@gmail.com>
References: <20240605091057.48225-1-andrejs.cainikovs@gmail.com>
Subject: Re: [PATCH v1] arm: dts: k3-am625-verdin: add combined binaries
Message-Id: <171872240058.3307069.14266677371616000621.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 08:53:20 -0600
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

On Wed, 05 Jun 2024 11:10:57 +0200, Andrejs Cainikovs wrote:

> Add combined binaries for all Verdin AM62 variants.
> These binaries can be used to flash the U-Boot via single
> binary instead of few as it is done at the moment.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


