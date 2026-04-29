Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CCDFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40636847C6;
	Wed, 29 Apr 2026 10:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OlnOCJYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00132847C6; Wed, 29 Apr 2026 10:50:01 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8172484701
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so211803785e9.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452599; x=1778057399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84m2gbFg97u5bev6axfyvHcLljMtBi2T/mqls701Z60=;
 b=OlnOCJYhqehmhNQHt4xEqBqkSarcwevdr3rh2Wz84aNdF9drHhto5XJzz07TqHLrE9
 yNTccvKr2kzPlmWOfjWqvFeQ6DbRjQ2j7EXBTgwWrGh3nsoQ8XjakTNVYxhPs2TAL54J
 VH/GqFl92Xfi7BaDWAR/pLe8l4sZZzoThgAiSjtdbSUTHu4lV5+zngEzbIBRBV18o0Cr
 qQORqK8PXSQUD9xWa9RzJdQwVtcCbWcfgt99VIGNHgm1/HLxK+tpmcK7ubxaVDM5V2Ux
 c27CcjYrNyL4WtnV2MqNNuKH1ZYj9czxOaRVppETGa/nKOtOD5zpweR6P1SaQSkiiOT6
 x27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452599; x=1778057399;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=84m2gbFg97u5bev6axfyvHcLljMtBi2T/mqls701Z60=;
 b=iZqP8Bt9Gb4veJ0uIUKcjshV0iHj10eYkftg1sPor6tw8HFLNGZYumCqsIQDE/4qQR
 sFnBB3GXHZCSSJm0VCLpF8B4Uh4B6QwYCa9rtN0iqDLSWnwN6GX7HCdZdcuSNPob+Wtq
 kufdXzCOFI5NIAwUaSqM8z+cfQacFhI4ilMYhkkFyF3tThe3fMndVGgpM8WvL5QtXH51
 V8dKGeo6UVdhIoSRjOkxCMMU+MEgai9dAJjYDr/ObPnGWISve163KT7kCgNMRCirerdM
 oolIz0+Y+dfbin8lE8+y9W7WSQEULRXG9JnLTnr6ZKlAE9CFtel6NJKkeXjhGvEU20Mz
 gnHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yax711R9jZUuRBAbXPCIPSFJJZ6WT3Y7HhO0iuM5t6fJgV2z7/my8XrTQ5DXnpaVhzDgWexE=@lists.denx.de
X-Gm-Message-State: AOJu0YzUVY4yBXE51pMEmQCFX/2Gk0dAiduJ3vlO9CyiQNQPyuO56q5C
 5NUoPlefaxzx9fY7VRXRvm6ea5kQNK5daUuq1ts1OdOzhmsyhigz3lIcFILfOK/yXH8=
X-Gm-Gg: AeBDieuy9eu+c8ikl2vS1UK76ieWvTtgiUkb1KJsZilc9mSeO0az+aXzkipWsJAMD4Q
 UkNzy2ODL3xrBaWpHS0Ew7H/I05b35bZxyZqzIXYE1qUGQP/OUuUQwpl4lldrhSKxcegC+LEOg7
 zTIeo5FttwUdzbdEF3XuNr4BJky4kkM9VnTQyu+d8zl5AtFLvGKVMcW4ccdMUcuTkDpgNbWUpJl
 Nk4aHUTifslNyAHGXeITUALJKha+7pqP5zwdYHmrawxEKrdhPrGxPcJiOJQZUQOLZByblIP37/x
 EvttnnH+PDeMfzZnqYxeEJYyD6idBF0FUP5XLOdVuoKSSJ/Qkpexsb31AkSjniMpOGJjoCZn1F5
 4nFbq9nb8i199S8xnluiqjMkhbV7CNGniyzMSXhmAFEIx562vx0scIUJRhwi4PVVQdNYh63nXYY
 KRWaImDLvnFCohK1mLwWslqj5cEHZp4NcvqmkRBHWZxbCnJWdQ4wQoEyfgCBhMvucxGPTmNrEYR
 0OVsjk=
X-Received: by 2002:a05:600c:c84:b0:489:1a65:dd6e with SMTP id
 5b1f17b1804b1-48a7b51c37bmr50983655e9.8.1777452598825; 
 Wed, 29 Apr 2026 01:49:58 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7bc23f4asm46380095e9.7.2026.04.29.01.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:49:57 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, 
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com, 
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260127062341.723966-1-sumit.garg@kernel.org>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
Subject: Re: [PATCH v3 0/3] mach-snapdragon: Enable OP-TEE support
Message-Id: <177745259132.126665.11352532849405386941.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:49:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=oX6Ed+/MhVaCwaTzh4O9K4U/I1pt0LvSX3/AScJKgs0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPx0z2S9XynLSQ8li0JuTvRu0D/3dvePJVVtar1N5zc
 oVBz+mNHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiTfoMPxl7gsIu9href835
 5pb58qpDlzcv0di9WfB7vNE9E7H7XxsY/kdPWhGSs+KskNbPsw4KvIYr113bpy26ubuytjDRfFm
 fAzMA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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


On Tue, 27 Jan 2026 11:53:38 +0530, Sumit Garg wrote:
> mach-snapdragon: Enable OP-TEE support
> 
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Introduce TF-A and OP-TEE config fragment
> 
> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
> platforms. RB3Gen2 being the first one and more to come. U-Boot in
> corresponding boot flow is packaged as a position independent executable.
> 
> [...]

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/3] tee: optee: Export OP-TEE message UID check API
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/145a2bcea9c8
[2/3] mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/43ade570091d
[3/3] board/qualcomm: Introduce TF-A and OP-TEE config fragment
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/845a1750c973

Best regards,
-- 
// Casey (she/they)


