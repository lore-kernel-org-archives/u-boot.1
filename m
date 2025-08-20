Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1B8CA0EED
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 23:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6189481E13;
	Thu, 21 Aug 2025 01:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PkhBHQvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0D182B07; Thu, 21 Aug 2025 01:13:51 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701B5801DD
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 01:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3e566327065so6375205ab.0
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755731628; x=1756336428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4TJS8Xmq5M5y7vw2l/QIonmHl3UGgW4Cihynyn1u+o=;
 b=PkhBHQvTpx2u+fZrCzy1w2hzwytVgYur/6j+oh7anPm6Qll1i6vIXBl/Yykithk6LW
 /8sUH7yGuB+xO0PoHyWBuPHNEC84i7eqK560oT3jpehtUr10pq5IKp3Gl85IyBTUxVPD
 Mfvd/xWtxQ7L5MOM9Ig0B1R3lwTSJeLI9HG1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755731628; x=1756336428;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4TJS8Xmq5M5y7vw2l/QIonmHl3UGgW4Cihynyn1u+o=;
 b=dE3L/QedBbz541gp1vaHOJDk4Il8mYhXuzz/2R6hAGtQlpV0IbXyAKjWJFPNYTuOyv
 pOek/uNO5HuROTfwG0SX6slRPo8geHScQPHoZdjqK+HfnR4rsOqeD1ibyA+dFhwEBvW0
 HbNBWxtLMZQM3JGu0/wI81H1znJUs0ZqGJG9aOiIr9dlE4YGTtV20K4L3ERfEb68sf7X
 0/d3AULo36L8XAQCRZ3joohwgri4JuiTQ0tBGqgvhCygtX2xmGmFUH8Eq8BbyKdgll89
 Wl3l/x7r5FPUtjfoQozArI38H/39suV0dbDXdnB4v3mIBenJJzSInoHST6nc5xasb6nM
 rFDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9MOy69IFEs6vfOeMMbhN1J0C29txBo1eBCgJMFw27llL7sC4NYko+Cl0XgZigs5cQ2KPeqdQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz56PtQzF7rB8vL3KhVmRqqM06m0FEbXJKV0Y94lm6LZhKyH07N
 CEZVI0+AigWrw/liWcW2zFsBdNSlmOFoL/fKCOCYDQlJBJ5XQwrjl15wS7oXOVHEH+FJJKD3ual
 ngMwjnJE=
X-Gm-Gg: ASbGncu3JS44PyRi7hwvhVVy4eBHDl7OQDrwkBpKMDfGkQAN/oyTl7dlibD1rH45ttr
 u4Xmis5A5ytQM/XqNoxUy3slj+vAnEPa6EwbdsI29pfnJECa0IchWworq8BwKIV4o8+TubHTwV0
 172Ep7U0IlR6kHJ3YB5YviJA5Gd6AHfg77/By352REasy8CaVZlrbY3MOhBSSWAFr/IgrnSX3eS
 3LAI9ZvGCLu9vuBRH9Y6M5ui6sZN+RJjNjKBHyba25nP0z6o9+DKf5430XyxRN5sKBbKqmjOM7Z
 EJyVlHcYYohg54NA2Yvtm9SKShTe2P0O4Hgrnmb905gsRteEfBjgAoo3vhKAA4FBI8/28lq1vAs
 1CDdWxhxcyS3bPMNqlqjqI3xMwiTTnmf3bGtkGscnOoK27YBlsjDJPWo=
X-Google-Smtp-Source: AGHT+IErUAW72WVt97Nr8Mqd8ACwYLhbsGKPuV9UkPBiHKwtCmwJ2QrhbtnMk8RaqS1uTkVKfZXxSQ==
X-Received: by 2002:a05:6e02:230a:b0:3e6:66e3:cf66 with SMTP id
 e9e14a558f8ab-3e6e1ec3b98mr4608305ab.8.1755731628169; 
 Wed, 20 Aug 2025 16:13:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e57e6790easm59405065ab.34.2025.08.20.16.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 16:13:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: joe.hershberger@ni.com, otavio@ossystems.com.br, u-boot@lists.denx.de
In-Reply-To: <20250812174612.1159634-1-festevam@gmail.com>
References: <20250812174612.1159634-1-festevam@gmail.com>
Subject: Re: [PATCH 1/3] env: fat: Add support for NVME
Message-Id: <175573162691.3540900.10071114085654569613.b4-ty@konsulko.com>
Date: Wed, 20 Aug 2025 17:13:46 -0600
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

On Tue, 12 Aug 2025 14:46:10 -0300, Fabio Estevam wrote:

> Add support for retrieving the FAT environment from an NVME device, the
> same way it can be retrieved from MMC, SCSI, or VIRTIO.
> 
> To use the FAT environment from an NVME device, pass
> CONFIG_ENV_FAT_INTERFACE="nvme" in the defconfig.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] env: fat: Add support for NVME
      commit: afbed1ba2f8776b06ef821212b14a3e34bdcd2bd
[2/3] env: ext4: Add support for NVME
      commit: 7b21bf086053679c5ef1ea612072a78018370281
[3/3] env: fat: Standardize the interface type check
      commit: 82444e3ecd0ea8404ed6fd1dd3710bfd8d641f52
-- 
Tom


