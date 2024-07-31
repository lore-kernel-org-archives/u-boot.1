Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177ABC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 11:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47CC8889C5;
	Wed, 31 Jul 2024 13:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lVxIMouT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5767B889C8; Wed, 31 Jul 2024 13:44:11 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D786889C1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 13:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef243cc250so10732671fa.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 04:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722426249; x=1723031049; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9ikT8fw2CYqKd+ljTMwXzyFQAjqm0KBQ/QPu83E5+M=;
 b=lVxIMouTLAxg4T6tIkXsv5KUDJFf/5GUs5wZXwRN3WzimyFqhNTKjq+U0e5+wGZZjN
 J0ccMPNDG2vZ1Rspurm1mLXR/lG+3aACmhw/aFYi38ksLa+2Gvck0L28nE+twfPpfY0R
 yhMT13fkIsJ7Y4BxeYtVCSBaiZ9YpOQ0MOOL7f+lqfPRVUlIFb7jPKWKMaxaDGzMMqyi
 6dXfxV5uGwOherX8uRtxefMc09XzUg/hD0BzBBDUZL8TbMm/0U48tbvLhNb31vxvRAq/
 +5iVBgfLxfT5gdnDdgDIKjOpqJ3tZFcHULT83h30XgrVlcjn8fgWQ5LgwecxoMuHSk+p
 zqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722426249; x=1723031049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9ikT8fw2CYqKd+ljTMwXzyFQAjqm0KBQ/QPu83E5+M=;
 b=DTeaM55JzKWndvVRufs0c4jAHN8/Zs1NY5JfxrwymOoUnLY7s4dPbClCRE+AXBGHpS
 wCXMTjaojw/BAwKDumWSqIUPCCZOlmJWIQTaCuGPhO++9iwVw340RNNYFXQIkA8tK95U
 K2dHzgd+FxPqQxpGvT9l2qr5WcULzw5zzGORm1QvassGn5N5he/vDv5ASe7UPMtQR8HG
 f7otz+FK/ilcJlHE8k8poRoBg/RjHckD8GJ411pi/IQZ7OEQrqQsubcxstrzr3aetdyu
 WJtIPKQd20666JNfs6d93SPGnyK9iykNFJDErh02vA/mmYEEV3/5+726Anp0MX9TMtnW
 jBVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQWN5XDYKD2bGskHkhd2PlPFvgzu4sJgdt5Q44eC4Tv228hkT9FlgOLTLzXZEUQIfDSuWoltmsDXNme7bRYMtEJ2Ok0Q==
X-Gm-Message-State: AOJu0YzYT5x8K3ZONjNffLeS6rhWRILC9oamSg1h5IQEa7wVjgmICxzP
 zu9+jwXCkSOv61K/ql9VLjp9Wn2GO1RYXmlcyIdNzWbrsAcBWdkqXtJ23FttvQmHizhTr+X24WF
 fg2qDAixVpStDYJKBsiQneUNb4+U=
X-Google-Smtp-Source: AGHT+IH1zrXGwl/EzeONhGaGDHkiir+cKx0ouNQZyqgei2JW72F74F16iwhbwrpu4CwZbiMIQ+wch6IbRmxoQpUI+E4=
X-Received: by 2002:a05:6512:2247:b0:52f:c0dd:d168 with SMTP id
 2adb3069b0e04-52fd52dfc88mr7169154e87.7.1722426248465; Wed, 31 Jul 2024
 04:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240731041129.3839918-1-mikhail.kshevetskiy@iopsys.eu>
 <20240731041129.3839918-2-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240731041129.3839918-2-mikhail.kshevetskiy@iopsys.eu>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 31 Jul 2024 08:43:57 -0300
Message-ID: <CAOMZO5Cg+PvUmXZK67mcp8rhUPE8Ro0MOHfY7oZKAwup7y4ydQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: soft_spi: fix miso gpio property name
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 William Zhang <william.zhang@broadcom.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 31, 2024 at 1:11=E2=80=AFAM Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> The patch fix a missprint introduced in commit 2e9fe73a883a ("spi: soft_s=
pi:
> Support the recommended soft spi properties").
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Please retain the tag I sent in v1:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
