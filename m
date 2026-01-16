Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1431C982E8
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA6183B32;
	Fri, 16 Jan 2026 19:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DTGFCrl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3BCF83B4E; Fri, 16 Jan 2026 19:03:31 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0A183B0D
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so3487669a12.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586608; x=1769191408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i4P2Iy1geWo/xXP5F5BL/Ct324M1hwNELwwnlwNIZoc=;
 b=DTGFCrl+fKVb3Z3kGA7+hvIFrxQgKKPfpHjXeuEEqfrrMgacfyW0Ikmeen/lPi0cRJ
 NqMN7mLqrCrH4JmgcZWbVdhY0qxLrlfda6X6Pd6drsllFwCP7QJPDYkuURhXY96vQFqa
 wZn3SHGXMQriuQOSH+IVPkb/2moCmGdiep877fnJXNxqhSoGGK/PZz+jg32/UT7tAwrQ
 4NkgzEHcPlwRe+vGm2UDrdcz0taCBmQNm4M0zGDETEIrSGJNjumPwdaNG0RuvEOLElMd
 tNTxhE8G/pqT8jNfFbO+CXj+eLyhmA1wgPIbivK9JglJtkX//5Rk1VBKlmRp2oMFiHFa
 1qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586608; x=1769191408;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i4P2Iy1geWo/xXP5F5BL/Ct324M1hwNELwwnlwNIZoc=;
 b=BR3FuBg16iKvZGWq9WhIRKYHtAxjxx+m7KaugCrr6Vg44lIbB1JW8a5gXM7SXufj99
 DVy23RGlD+nvfbq3tSksGWwnWZaIiIvucBqmlt81vgrw9TVPgCEZlJyQxDaIJNrTTAL2
 DmeYE/Pa5FC5fBn3hJ2F/8yjsVDXh10C2G6rdRgg1GG2E9mLVMOgvk8El3bqt+7I/G01
 VPWBEj3L7xYiZTSZPqw+L+hFBYCnSpwqN7sOltU92sTGrhyh+9/1PKZaxzKbf9++u2CI
 6Jh4qupD12wMsj4S3N8ySsb/FNHTC5zdEdfmTnVuMvOtK5Q5iAAw/X6bDH7oJVnNowof
 yA6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUncMwF088n8y516G1muFnwGcxolgmW8L3sb5lYkKU3NjRgl9rtK+g4vUg3q4J58Pu4F5vo/I8=@lists.denx.de
X-Gm-Message-State: AOJu0YxC+lHkR5eAuYSq/Rdn/YZL4n4MEE48HIh9/6chV/uRMGKlAmqC
 2+LIrIg4Kd3qr6Jr+rWkvbV5X1U2wrjNe403JCpAOQeqGUJkCAdiR9j4RSXAcpxp8Dw=
X-Gm-Gg: AY/fxX40/IKTnAIQg3ggwTgpXxqkSwnbnOe4BDEM367wGCRVHxoE3Mu9LIIS6XMVKnm
 PQcBQrfiZPAuxR6ae85iU1Z/dipMtkiG01EPOig4Q7+nwD0iCjRZiwpZmkqmfBUcLZKaPuagSCi
 A6DfgRehlGysHm8JwuJHfGZ5GfaxVxqkHrIlNX/lyNAiFGpqkk2utEWbPuDp1afDp0fGLzCUkFj
 /q3NH2AdeI1AxaTH8ojYBn4Ybs5HCJxgQiVCNyb5UCl/QIQk1hoX9k1aWxHdoFMoJHgjz1baPW8
 Jrs+kNHNc9RX/wu6XCBrCA8Uukqu2vWZNcflrAWbS9AznolDJOGUAVDUrgpxE4vAUrU/H3pOfro
 JX+Kun3BbEe32eHwrE3hR3DZU95pH/JMGKYZt35X3ikDcc0wxhBazZFqWm+9bdbkz09PW680X9v
 MfEVh3wi6vjZoMNT8cqGg/u8InxvbHWnvIDKAkXrnETtKt7RIjN6ui6g==
X-Received: by 2002:a05:6402:144d:b0:64b:4212:9d4d with SMTP id
 4fb4d7f45d1cf-65452ad09fbmr2368727a12.21.1768586608109; 
 Fri, 16 Jan 2026 10:03:28 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:26 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 mateusz.kulikowski@gmail.com, trini@konsulko.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260107153504.550450-1-aswin.murugan@oss.qualcomm.com>
References: <20260107153504.550450-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1] spmi: msm: refine handling of multiple APID
 mappings
Message-Id: <176858660669.3399278.6943293185924150262.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 07 Jan 2026 21:05:04 +0530, Aswin Murugan wrote:
> PMIC Arbiter may expose multiple owned and non-owned APIDs per SID/PID.
> - Keep current mapping if it is OWNED and a NON-OWNED appears.
> - Always update when a NEW OWNED APID appears (make writable).
> - If current is NON-OWNED and a new NON-OWNED appears, update to it
>   (remain read-only).
> 
> This avoids write-access violations when not using the newly discovered
> owned channels.
> 
> [...]

Applied, thanks!

[1/1] spmi: msm: refine handling of multiple APID mappings
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7966d35b1fee

Best regards,
-- 
// Casey (she/they)


