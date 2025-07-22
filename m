Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A07C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 12:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C18818386B;
	Tue, 22 Jul 2025 14:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Iv4ejWJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344178384C; Tue, 22 Jul 2025 14:02:36 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B5498384C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 14:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a528243636so3255440f8f.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 05:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753185754; x=1753790554; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqwxqd++0NEMgcFBxcjpiraeJaqluaNoIlyUsfsxFl4=;
 b=Iv4ejWJ8F6mFasMe7ZoA4E0rCbndpahw+uELnsl4r4jLMI5exOY1HgebuD9A5WJMy0
 vyR6MZAj89/l4p7hWdrzWGsuPuOBWR6hjS/eD/rTzkhs+S/eqH4KssfWhe7sP830CZ7c
 54RhvaFBQkOy/bosXjsUA3qgtD8rfU7mOVtMc+zt2oJM7HzM83u9RQ6gdspG2OEx52r7
 wgTa7L7lbaEsB+v9IjuPl8TnSS/oT996YRCxlFcuoBF2/DWW71eWdPXeRpoO/mOTwR+G
 hSokL2V+ECcnHyCk8h0Q+gedqlp4L13whbjnlZFEPQaC73fAmRrs5bQm6khKAg5h9iAZ
 CeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753185754; x=1753790554;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mqwxqd++0NEMgcFBxcjpiraeJaqluaNoIlyUsfsxFl4=;
 b=Pm7wiz12qmPOGHtuTRXwjLv4rBLxYmX2zHk66t7VkXg8/wBzxuQ4WCRksXLQQ8uShP
 VSKTRX6fA6LQqhBdJe36ufjDN7gCKeZgFcuMn8n/nnYG3VUy1DTCs9yENvy6Oc70PvbN
 sAdGatnOvUfPavMLJ7WmqTfE6J2Wm5M/oZGhAipbTLd1JLnV5+inwFCmwckLl7nDB3la
 3xt+vL+OrsdemQr9NvHrMQZ3It8WyUgVzetYK6vVybOAEkINX/EA9Z0+qlinuyWYRbk8
 MeKPZ4SBQbepKVjbDOUpgmGsBu7m4Pt23io++1J6nlhxLpoj5QM2si3uyfkUkFyMqpSJ
 fWwA==
X-Gm-Message-State: AOJu0Yw8OMEBqUp/GayTDl3nOuC8qdErkRIy6TuV8dEpQyT2b8Sz3hTJ
 vs0tjPrYSo2vYS86uy6yYwj+3LYkfn5BQmbp9uxIwCF/AF8sZ+SOcOfKK0sRtvZu9kvBjAtZ6r5
 rGElH
X-Gm-Gg: ASbGncsmirV1nDraBrgvFUCioN5Jqpuhc9psBtGUvP6jIfVn2onTtl0CbTD03DNzniz
 hXs7UnSOOzI1yQNJlOYFroyylUp4yZXyNN03WNGjzwEwe9vV+TZT/Tp53ZoDAD8DSR6vhEjuMK2
 bf6gZ9niF8FFKiKcP0tRbpdQQcALHmnNB2I2PbhxBTZjzH6AtPngLPE+khH7v0+8KwsSFaRStAa
 b7JkShgZBsNXPtX9oH+XNl4c/PDcG1VnyylkmrHGWewXDSy08hzLVcHtUfJx6kpWbJ0/oZ56l8Y
 vaJK42HN59P+hbEJ/8P+L9b/XX1TiBzKYcMkkDpRefVJ3SkYdDc3bTTc9ugU8KZT2LHPvInBxlV
 FRFelVXMcUSDdgWIdQy/bXKf6kSYT7BDXDM8JCkBGl9OtXtsHa2Xk+9HuRpWmeIkes3zhum55JH
 VFHg==
X-Google-Smtp-Source: AGHT+IEMtpuKVE9HRkpn0GnmM8EKxQkuS3Y2VLIZSMaQb34YkkL5bPirsXU52PX37Jx01MROt++xhA==
X-Received: by 2002:a05:6000:5c7:b0:3a5:7944:c9b with SMTP id
 ffacd0b85a97d-3b61b0f0b18mr12512559f8f.16.1753185753317; 
 Tue, 22 Jul 2025 05:02:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:eb9:1701:2943:d0d1:b3a5:d7fb?
 ([2a0a:ef40:eb9:1701:2943:d0d1:b3a5:d7fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8ab7a1sm189592635e9.34.2025.07.22.05.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 05:02:32 -0700 (PDT)
Message-ID: <82b344b0-3b26-4e4a-a5f7-dc7e45f2191e@linaro.org>
Date: Tue, 22 Jul 2025 13:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Uninitialised variable in common/spl/spl_imx_container.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

The commit 73c40fcb7367f5a spl: Refactor spl_load_info->read to use 
units of bytes by Sean Anderson <seanga2@gmail.com> on 2023-11-08 
16:48:40 introduced the variable 'overhead' in the function 
read_auth_image and it is referenced only once where its value is 
attempted to be used in that function but it is never assigned a value.

This produces a Smatch error
common/spl/spl_imx_container.c:57 read_auth_image() error: uninitialized 
symbol 'overhead'.

The resolution to this error is not immediately obvious to me so if 
anyone would like to take a look please?

Thanks,
Andrew
