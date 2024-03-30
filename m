Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7DFC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2CD882BB;
	Sat, 30 Mar 2024 20:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dbg+8h+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2464A882B6; Sat, 30 Mar 2024 20:46:20 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ED38882BB
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ea7eff5f3cso451420b3a.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711827976; x=1712432776; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPiw8O7cLju1TLNOw8Qo2kDXnI/ksB3F/m0mk8xf25s=;
 b=Dbg+8h+2XSVYc4CmYMZz4FC7mHoZBNO359i1r68AVuN/h4lSGYCAH+tnOyoCWDqwIe
 uDFivV1M6uKkolfKP45atfXSprMwxgtT6Kz/pj1AwKMWUjaGr+laoVXTbyIOdVJM2Hbp
 FOSDVZeXX+WsFeGNKE4xYPr078cLT1bkO0w3prvWyQP7+thO+lncspgtRox9sAV9AyjB
 yiWDktc8ltG1giWJ6WSJWp7zdW/woMa2DGxfJM5IcQDxNO9EFOwjPt87fOXYCCqJh6vl
 7TGGcM85YKLJFGLUbJ7+0dobsXUr/cU2/MasVmBXZCMoApLtP4PEu3VrAZRUTzptyUht
 dvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711827976; x=1712432776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPiw8O7cLju1TLNOw8Qo2kDXnI/ksB3F/m0mk8xf25s=;
 b=qO5W7IqF96sWAxFiGDbOJW7jHm0aEOn6CwBPRQDmV4ZUuRuTU3ipCVCjC0EsjKGSvX
 jE6QsJaz8hKsBx+UyvMfHu5lJz9C1TzRDpfUflA/UNpcVGNNrYO4vM8B4Sz+5vPXp9Hr
 U0n4iTYsR1yPENdHaCCRuujj5j4yNbE+V263O7qVnS792Kk0KRfSZFZq8QG2jF7a6jZO
 GXxWMk6dkoL7cbu6MEclPzrdLIRwuMCOqPMOka/qc3oZ7uJax5PAjsDqdXvxpNmAXHAu
 JG6IjCDbI9GT5k+qVh8MaYEGABg6EGEvs7KBMQmKDvoXfKeADDAXp2LaoOgnTXPM+iuF
 KvhA==
X-Gm-Message-State: AOJu0YxmBykp+GQ+hSoT1qSJatc3C3/VmvJbQ8DEU94qRV6shiOYY2dT
 ePuODNouCT+latfaaqYql3SaWBgdUQuLeWARIxKyFdOw/OY19MPhjy5K1R+BK2+CjH5m+TzJwzI
 +pTA414E/fitpn8TzxrrXXfMP6Jc=
X-Google-Smtp-Source: AGHT+IFSV2/hYi6cJbfTuD9A1qkZfiBmwz4fKNX2k1pxcnwgsvakniwv3qkouKQbHTVfg7p+HRG77wMZYvd4u6AMtNA=
X-Received: by 2002:a05:6a20:7345:b0:1a3:c603:61d4 with SMTP id
 v5-20020a056a20734500b001a3c60361d4mr7630098pzc.3.1711827976653; Sat, 30 Mar
 2024 12:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240325162722.1350593-1-tharvey@gateworks.com>
In-Reply-To: <20240325162722.1350593-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:46:06 -0300
Message-ID: <CAOMZO5CutomhjoJx3OBAFNbsjWd0hB1Wq+A8dHKYdG5jm+T-Xw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8m*-venice-gw72xx: add TPM device
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Mon, Mar 25, 2024 at 1:27=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> The GW71xx baseboard has a TPM that defined in the upstream dt however
> we need to ensure the GPIO reset line is de-asserted which we do in boot
> firmware with a gpio hog.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx/next, thanks.
