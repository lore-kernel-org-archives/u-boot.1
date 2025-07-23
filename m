Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CBEC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 23:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698A483599;
	Thu, 24 Jul 2025 01:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h2382DNI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE1B2835B0; Thu, 24 Jul 2025 01:09:27 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A960583577
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-74121e0fb77so98009a34.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753312164; x=1753916964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=brlT5xVz5Rs4CtOcAQaRHrm1PF9SOVr8wiAwD7fbOPw=;
 b=h2382DNInWwTH5RDXsztZ4r8pWp7foPbuLUao1T+oGb/R8WWOPMl12/dFQ1/Y9qL3U
 OB7cIx0cVp3viIIkmyvjSINvRODRBT856TODOR0f0253041pHGOo9ofm7oyJtiuzFxQY
 f2K0hvZKljdSV/K149ZQ3pCoaQH8flH6TPwsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753312164; x=1753916964;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brlT5xVz5Rs4CtOcAQaRHrm1PF9SOVr8wiAwD7fbOPw=;
 b=Kh0Them/h+7zTx5MJ9VvYNj4l8m9a+vJWisRWxa5Ijad9xb4/HWNMoT75e7Qw3AROw
 1ptvLq0K3dWIJrMJY3+UrRjUHbN68xrETu83qpzU3UWbc6A4f+uWw3DamRPMff1kF4fL
 zv05H5hhIiq6Nitg+FhnK9Qz45UeyDBhspXNZiLHRvz5gQyH9dYZwaNxR0vNGA77gemu
 tTstbW29PQj4nFDUgby731fliF2CrP9dtIcIeJAK8Whk1s5o7CmOTs3tc8f+sm3xOBXR
 UvGcPPi8bFEl6EVFiBEoFfaZgA3ppK1lwQOawdB9YWsT0kkCe/CoRZkYxiK6dlrZ0D4U
 xB0w==
X-Gm-Message-State: AOJu0YwSjLwzBVk2N/v02juR/3baON4KIEmNb2AM1vzkvQRo+hOPrSz5
 mxP+43Z9FEI/gqMxalHtjzoqhoe2PpFfbQx2CqCjiWCZGcw3DisQeAQzKFTJrdLSIy0=
X-Gm-Gg: ASbGncvp6A+bUdrrH4U0sINCt8GUYfckiRBabdBFDKH8BpDxjm1cgUf9AETX+1ZKbCX
 CCvqGWaIeI+Vdlx0aJIuUbPg/hCzHwa4EUw3bq6r4gRjYkDkeLMysxR7V17Taf5XHWFzN591KZ0
 DrDmcKEtrSjfnlzbmuDwOWO3Oulldj/O99JkjsNQlGo47QWzEtCdE9/7Gn4HBOPr/yuvGZdEuDj
 Bc5O72beo67dhoHdvnfEuzIpvIQMEbgOyVEg4r5DEl6b0PjDOGrNH1XHjfivT4v6LXhCJ57Zine
 oqJQTiObvoa65KKFv6iZGu7xIg9IU5LSt7vEFYIiuzgo7fXlPuSlun1uj8QFCN1AUJuWVT1yGlN
 bBEpqy2zXNysgzCAonco93asrg1FhzHmBF4W+aY+e42mMSS8ysBWYXaX9UtLglZ0kJA==
X-Google-Smtp-Source: AGHT+IGnkHvIpuMvZUSXJHijwpy+vhoMTB8E4KTdfG4TKhMxnw3MgOAYdoHbdm1HgzJ5/BMqU5uz7Q==
X-Received: by 2002:a05:6830:2711:b0:73b:2617:87eb with SMTP id
 46e09a7af769-74088acb159mr3738442a34.17.1753312164321; 
 Wed, 23 Jul 2025 16:09:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7412d0fa63csm52693a34.10.2025.07.23.16.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 16:09:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250723194459.224015-1-trini@konsulko.com>
References: <20250723194459.224015-1-trini@konsulko.com>
Subject: Re: [PATCH] patman: Update test for Anatolij's new email address
Message-Id: <175331216354.248145.11170064829260153775.b4-ty@konsulko.com>
Date: Wed, 23 Jul 2025 17:09:23 -0600
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

On Wed, 23 Jul 2025 13:44:59 -0600, Tom Rini wrote:

> This test was failing due to matching on Anatolij's old email address.
> Switch to the new one.
> 
> 

Applied to u-boot/master, thanks!

[1/1] patman: Update test for Anatolij's new email address
      commit: 67c791dcdf84f3b84e447685b0301400d9e2db73
-- 
Tom


