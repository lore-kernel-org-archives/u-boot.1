Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2FDF46C4D
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 15:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6DAA8352B;
	Mon,  6 Apr 2026 17:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HX6ij80N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F52983936; Mon,  6 Apr 2026 17:48:15 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526E98341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9c01854477so664085866b.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:48:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775490493; cv=none;
 d=google.com; s=arc-20240605;
 b=YejgfhrfkOATxjiyU4WLSXVj2oEUwMFb6u/mQ6X42QkowMzbF7MVI7jdeK+eRj+oXy
 bQgpWYnnlUn3Nj+qNT5kRNruxPqV2oASV8h2p/NHAO9fapORyLpdDwzis+J3r49tvWbl
 Aozxxnyril8JNK9+Txs8dknL+kU1IoucFX8M0JOj7/XNxhNXKhLBXTiEk6lWN4a3efVO
 wSq0F/3tmutZT5MkiAaIBy9sPn43vI67t0AKKS/A5gYi73Ho79iaC0VHAqKVLjRulSB4
 fDY+zmwc18XtbJ/Rlxqq9ezHB5xSw45gKH6+Cs1RfWDABvoupFr+igBmNelOevF5O6WP
 w6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4oAVw313PXU/ZvCIp48vKAnco2c6zs/R/Kvej8C4O2w=;
 fh=BIogcxHhBq+Vd91gzrul14NxEHdKQm0Qafq6kiJRMaw=;
 b=OmCz/lY/uJd9TKdlBvft7Y2eR4Hws/JxUOF7HmY0DUfTq6YNyQfoA7VpqER5UMFzVU
 OEdLoQ+HCGsPAtufzBxIzkqd/afTCTLTKpX4rMbarpdY/fqzPlr7FB3D4lpQRCJ9S7s3
 eLXCZiTrkq5Lc688j1b/btu8n3tYJMUkLpjtuXCWf6HZb+NWyKDyXXZFlWwDg+fxt5mo
 Uhn/cXHjx44XaNpHavGQnFJhDgTLTNC56B4Y0/xyjzaTy+q3+9QdMVJ6oGPFYleFOFhO
 zQZM4VRVk4DFoyfyWq78yHPduTLxBcRcogoMcHsR7nGVRbpb1hyu6D1+MofaJdRF4gwk
 xXag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775490493; x=1776095293; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4oAVw313PXU/ZvCIp48vKAnco2c6zs/R/Kvej8C4O2w=;
 b=HX6ij80NvvUw2Rq2umoh1hvKfiFPJ6l3jVNJAFGQ0c9WbBvXd/punBXdsD5H9p6EAC
 VLjiEQLBBTTe14LGXYRcAnbwOvmg9j+0OEZQY08cHJStsOSUuNiJcm8q0fGET2D1q7+A
 yKs+vFfQcXuARqFSbQ3DYCJ0ClN2BaDQGup60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775490493; x=1776095293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oAVw313PXU/ZvCIp48vKAnco2c6zs/R/Kvej8C4O2w=;
 b=VNIb0VfIoBs2Y1sgEe4UerUB36e2iVjehU46VxW+Q4+jM1tSgtddRd3K1bTjQzoMGk
 4rNzM4CFKYbNbfYOX4nH2eOiXIE91G2hibuUTX97Quak58uRlH9rsDOyg35T96jFSPaI
 vGjqJjkWXzq6KIdrlG62ZCwtSCnRvncV/Z1CtzZZuWerRxoIOHhRKCNO0lYB/gwOEaBX
 XwMVQjuHHbWCh89HuejlR+0Lm5wBwMFu9b/wyp1VEMg1DxqzELkR438SeFnglPFrUv64
 FxXY7SzF0/a+2wdjNN+PX/3U7mrnPv7JcRvZucZhidWXNn/bp9mh75ugLE+QfCwYILMZ
 PjIQ==
X-Gm-Message-State: AOJu0YySBw9BRsqHSJv0FWO9znkhOHCWh2b+wgBgLfau9vUN4T/VYDm+
 za1VwSbkTiBN1MmCKKNvIHaTs9SZov2ba+ulMkj83Zqu9P+4mnZuJhu89i5ZsmsfA5PIQLgeF3z
 cgfd+4kVM7AtvHNvkDhm4skhzxs1lfxsgZmUOQ+0bg4qi0makhIY=
X-Gm-Gg: AeBDiesgcZ45QSG24/IFQCtTSBij0wBCT5OZLmeQlQUQL+JrS5bsz9QIIBxqBX9mqfq
 Ur2d+gPN1lzi6MByej42fbAN/KBp9YvzPXYK79sxhMEtmqIxL96EXjFNyKAknOBiHr4KF2B/jjN
 zWUTySIDckp0S0G7RJjSTX3Hldqz5MQb4GuJ4leyjm4jBOL3bPGJQpOGVg9DIfZCUZL23NrPOyt
 YBgu10CPlg9AHdZgimoR4S5essdMz4ZlbuNTh/s51pij3NdaqDGwVRqD5uo/UThz2tAghMpqWHB
 sDDn/g==
X-Received: by 2002:a17:906:9fd0:b0:b97:34e7:ea87 with SMTP id
 a640c23a62f3a-b9c67454a03mr585287866b.19.1775490492744; Mon, 06 Apr 2026
 08:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 09:48:00 -0600
X-Gm-Features: AQROBzA3Jw_51sYA2335kHfbc_jGWO-eiGOM6nons9pRlxSXwVd6tcHu_F2bVMY
Message-ID: <CAFLszThqzujQqjcirUf-2w6+wuXKv9+=WZ_nGjyKiKtzTkG07w@mail.gmail.com>
Subject: Re: [0/5] Add SPL support for Qualcomm platforms, starting with sdm845
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Michael,

On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
> U-Boot SPL, as it will be built using the defconfig added in this series,
> replaces xbl_loader.

Please can you clarify what happens on devices where XBL_SEC does not
have this vulnerability? The code checks for EL3 and skips to reset,
but if the SMC call to unlock secure regions fails, does the code
handle this gracefully or crash?

Regards,
Simon
