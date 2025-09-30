Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC5CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 23:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982A68344E;
	Wed,  1 Oct 2025 01:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eztUjQ/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCA08349B; Wed,  1 Oct 2025 01:45:20 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9E483335
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 01:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8cc0cb783ffso589672439f.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759275916; x=1759880716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8cGy3Ot/y9Q0RtuR0zk3118IIuFNcfc67ZYLvFOMpY=;
 b=eztUjQ/5DJX+9BD+hhf04eVHa8YSMVetbqCEEHP1RA1YssG0OLSwjYgFLred3MRjqS
 M6yYyh8lgZXggYMnqBf2B+/9oJIN/MOA/EWJWaC1y8mvYsxwsmooDU8AbnQrPxJhkMW8
 80EwG3AhSYxkoOTJLBRmElfbMKzISJ66DGuFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759275916; x=1759880716;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8cGy3Ot/y9Q0RtuR0zk3118IIuFNcfc67ZYLvFOMpY=;
 b=pALmciJwiPvEzvI/nXlZYO82vvcl7tE9Ekc1oumvt2pXbg0C0Y9wy+MyujJMccdQGX
 fIQR6t2SrZcR2A+8nVG05poSFw5SCkdfzXvSIJ7ILeJ5pO7lPTVgsOsTe+7Mfb01fEoU
 j6U0sre/cjIjXHePZy0J2r+QkhUOEeXQamN5hCUMk2rCYuIG4fc2/c9q592WRiZKxeRl
 buF9Y29B64ngfKT7iZ+U3/Ovrr0hMVPioZeht8eiz4gYmfAhx2KfOi86r80Vpj+wDBuv
 ZcEjDw5oJUaxoPnuHbQbVzSbF6lSkzkF9pfxK2E8oyARim/HHcZTg6zXPWrHzauVF+CU
 PoXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrnsF4Q4biInHN/6jypvC0qVi2LUmxy/WRlEod66KroeyVeuMAhCEnaz4PuY8cdxKAZTKi0vQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywsmr7YvGMFNbcRppshZOO/1YIuuCCnhDTQ99M/nbnaWZq+9SMQ
 UtPRk28tapQrW+IEWxsD3PUDkntRaejqQWACLBD8Q4QCNntpGtQqiS+F3ah89Xlmcw3NSklKCZi
 cbYqmBj0=
X-Gm-Gg: ASbGncsPR2uvautiK7NrAT5j6CUJPjlvMOwI8ewMIXzv+7A51iQmSdyG7YosWPmXEFl
 rthBs5mMhMAdzOgboy9MVs3iBvC9kdN8GqYdEDxiYJjlYP7YJc52Sq9KpF/QshlHGXIkOqD7DGw
 eGV8M2PDP6J83XJnw3o2z9jOCAlzDZICY6MZcUIXmftTFWVcRnb4BC8FMXz6pAF1w5AEDX9wrc+
 1j1p6t/i2dU0lWRCrCr6mFvDq+9Jx1ZNDWK3Q1nYH2b/Cs1ptaytTq0rd1mqfCceL7br3joowa+
 OVGaqCcgKRd+88w7V6keHg1HF9gvSa27ppfJexjjQHvk2lB7Yo+x8/0xe10T2NTSRqy2ZiF7VEw
 YkckXZqs5KN3aGizH8EB/WaY8i405mwJVs7r4bPLpAIWS3KX9beWr1Tjwv2Bwh8HmQSH7R87tBt
 PQUNQ=
X-Google-Smtp-Source: AGHT+IF7Hf+/EwLfA1uww6S4CfeauQq7e6RO88WV1GrngihI8TPEqYI2DEYDR8T1EQicdW0XoMcIzQ==
X-Received: by 2002:a05:6602:134b:b0:920:865c:a8a9 with SMTP id
 ca18e2360f4ac-937ae5ef022mr249761739f.14.1759275916119; 
 Tue, 30 Sep 2025 16:45:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-903f6ea358bsm572665339f.2.2025.09.30.16.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 16:45:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <e59bed17-8d4b-4a08-9091-e8805f7df1d8@linaro.org>
References: <e59bed17-8d4b-4a08-9091-e8805f7df1d8@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20250930
Message-Id: <175927591465.2084249.6656043500733474934.b4-ty@konsulko.com>
Date: Tue, 30 Sep 2025 17:45:14 -0600
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

On Tue, 30 Sep 2025 20:37:07 +0200, Neil Armstrong wrote:

> Here's a small set of Amlogic changes for the next release.
> 
> Thanks,
> Neil
> 
> The following changes since commit 9710d98e8942151fc0c62d54100d9d27e8263d04:
> 
>    Merge tag 'doc-next-2025-09-27' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2025-09-27 09:49:01 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


