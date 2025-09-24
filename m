Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B25CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 16:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E759F8323A;
	Wed, 24 Sep 2025 18:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tz/bleJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7E1835BF; Wed, 24 Sep 2025 18:48:05 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30C283071
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 18:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-890e5bb3100so4184039f.0
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758732481; x=1759337281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9j8AOzzE/q8SzgVArl9WdNYysn4uRg9JinJWiW2a2Ss=;
 b=Tz/bleJLeN6klebqmeCMYhR4i2Xp2ZC2n50fl3Xngihicbd97fH18upFG/NNP2hab2
 vi6hqL0cR1XXzw3yVHWcutJMxq6Y7gwhU53dlF1ouyqzB3Qw/K6ZEJEynVKkrglCf+vf
 cNnmEmALcI8ruDeLIkQ170lPyhLFWPXfv4ac0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732481; x=1759337281;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9j8AOzzE/q8SzgVArl9WdNYysn4uRg9JinJWiW2a2Ss=;
 b=bUBlLH74w3eG+FmWWVv43BN6e9KP/99ZdlMBndAsbK6i6bhWz8NV+zavqFzq01cAzc
 TsRY7kzMETNZlZjNSDgG1i/+0esVR8V4qxFh3vfgQHCyMCb2OW1t/9++93zl++K9p2iW
 vNICjVO4uNKlbrFxzgFBLrvu+AeY7jPvVEpooAqmd61PfUHksK/5AI+IILofdn9gfqtm
 RZb9NWsGQFDQxN1Tp9kRUdOVjR/NuIpMOmkl6/OlQN7uTjkrPifGGqR8OF/Z584engSh
 +OJP/eDjgluZBMO2ECyDJN3buZTcpMvA5YUnbqkt+hznRMZNf+JWryY+2iGFWEyeG9dS
 jt2g==
X-Gm-Message-State: AOJu0Yy+Nvz5NLi9Bxqph3XbSgLy+/nlR+1C7Wtgjd8S1TEvm5uIHNXo
 6xv8qauus08/hxkl7VG3DL4Frhc6SnoO42ecRhpFXpggrC2QjybSXiTPLw6wKnv9qPqYoQpRtFw
 r4xsfPLo=
X-Gm-Gg: ASbGncuPzHOZBn2WeEXx3pJwi/fyZSowH3PQKby0cRJ83245zDyB5gF0JNrJ9XQaQU2
 1KZflKA22D3oQufkzsfA/Ugys3Y60t5grNz+D3Kc7aVVPz0RgKGvY/Gac7Wst46tKJe7/TCV+Zo
 gA4JetCwFDz18vKfZWcnGZxaoUsF1V9Cwd9aIVOd07GazfzT6+8inNfAjEBCZm54QQJlkhresEu
 aI0LiYRWalQajX2I3Cw+cqW2+b5DyGPnCq1Wu4U8t3OEGha4UKps/72GNT7iRoHi1Q2MHd5sr87
 ekUIL5i5qQ3rryFRm3mejkbtm4yzSZ06hTkDQv/U/aen2ntYaI+kX6MosffHbeuTCibhiLkdKiw
 m7hJgqckJcsIZj7obVcgASB56HoHTuYtxPSk+3uKQ3zmTyuG2jKyPkzY=
X-Google-Smtp-Source: AGHT+IEeDDLTxm13HFe2y/Ybp5g6hqv4tJqRLGr6HceG1X3edoDM3XnbBMo4RWGIbjmxfspJRialMg==
X-Received: by 2002:a5d:9476:0:b0:897:ba4:bcb0 with SMTP id
 ca18e2360f4ac-9016fbe534amr26876739f.19.1758732481042; 
 Wed, 24 Sep 2025 09:48:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56339872772sm2149859173.33.2025.09.24.09.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:48:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250924162835.GA2186@nxa18884-linux.ap.freescale.net>
References: <20250924162835.GA2186@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull mmc-power-next-2025-09-24 for next
Message-Id: <175873248010.352133.15700564233138517538.b4-ty@konsulko.com>
Date: Wed, 24 Sep 2025 10:48:00 -0600
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

On Thu, 25 Sep 2025 00:28:35 +0800, Peng Fan wrote:

> Please pull mmc-power-next-2025-09-24 for next
> 
> ---------------------------------------------------
> Correct error value check in regulator_list_autoset
> Minor style fixes in mmc
> ---------------------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27712
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


