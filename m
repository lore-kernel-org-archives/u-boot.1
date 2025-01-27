Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EFDC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 12:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6FDD81119;
	Mon, 27 Jan 2025 13:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCX980Lg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03BC8111F; Mon, 27 Jan 2025 13:12:31 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D6081115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3003c0c43c0so46075631fa.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737979949; x=1738584749; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ninPNXKHcfL/WoF69mg8hcL/TThJbTzhG2cGS+4tx8M=;
 b=gCX980Lg76ZBVPHaLo2vLDJcmgwqXeeVX3FUURZrRBMMQmS8rqaIWuTK2EIh2AQPaG
 nTBYZcSDcnjC/Xtz/qKDBbtVi+d6izTcllc0e0N3pTKpYKwNLd0aXKE9LXpsaLK7/oPS
 mCHbAczlBjQMLrrPBUHKROeOQzmWiqOdye8oAHD3p+4t9n7Ni70CKiz4ekcNcManM+ml
 mGwVs6+gClK9ropYIZxAZxkERSv9mFRbsTUNeGV337DfPJ9eJUpT77K4n45BgVT27Ch+
 6TUVcYFYsNk68nh8ytrICz6q9iAopE9sR68bvkWjL7mA8bxKokoq26PqkrNOyRm2fDjL
 oUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737979949; x=1738584749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ninPNXKHcfL/WoF69mg8hcL/TThJbTzhG2cGS+4tx8M=;
 b=Mm7sZIwOCm1+uIV/v6XF0anMLEwUusufMI2OIlhjlrNCX9cCb7uQkFbIaXfTQC3o36
 6E4cn0oq6mwmpXflcMwJkxVeul3e0XyuBZEqR/5wXljPufVN0wUh1Z4D0yi30Gmtu0eN
 MIl0sbtwle/RNydXRhrlGFbYGVWVfuIsbJA2hjDn+olnEvE/V4hvneczBozTk19RSRE6
 bQ/kneZ++exk9mNiETIZ075teBzavSdsOEmVprgc0jelrlZxMtnfxirjbmotu43QpbN0
 Z5nV8BTzS/IOoo6p2l8oEtNbpg9cmhKeG2Kl3r3l0Hcn0WcLBqhhX7ow6z8+st8nm2T9
 mSPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7NJtcsPhg94GVRj7xCCZv+yBBWy9GU3mVCH6cIIGpJsvDrqtkR/m+tVnKeGq5E9sDjmUtn00=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2wXfbSrhOId6MMboY9LSS0tacOUrMiGas2HLJFKsaQ+/fuxbj
 Zy0SiJetfd/8KCVLcFm4aheLh6cnPNlc/WfoKArvEqICS/zXpF3M3Q9v3C7PQXSTxVraYA7pRJI
 dvTMZX35ipaE22ASVoiJPqIOTsC58ew==
X-Gm-Gg: ASbGncvaFIVfzyDoXo6DfrIpvzvkz6GH3LDAjcL0yOdCHQyQhlyKHWb6O6WuaXXS+Yf
 T0NegqDS925wTO8s+8YXuSKslRzlmXbQmYZWZPMU08I1HJsvYIya5dIsCkpM8a+FglS+6/0mAYR
 Prst5Mp5d2AEOW5v/jKA==
X-Google-Smtp-Source: AGHT+IGOgmsFIa83vOMWieTwQt9qke4+CpCAtu/+veZD+SszIZu6GkdW+Ixc1OmrLA8avXeC6M9V0DXj1rH0u72+9dU=
X-Received: by 2002:a2e:bc83:0:b0:300:2a48:fb65 with SMTP id
 38308e7fff4ca-3072ca99e81mr189099601fa.18.1737979948427; Mon, 27 Jan 2025
 04:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20250122-optee_guard_fixup-v1-1-032bc2de09ba@phytec.de>
In-Reply-To: <20250122-optee_guard_fixup-v1-1-032bc2de09ba@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Jan 2025 09:12:17 -0300
X-Gm-Features: AWEUYZmznWCGWLXh3DdsNx1WXVQW5TbAD1TLFNxoLbNEhfV5Eg-idvYUK98ZfmQ
Message-ID: <CAOMZO5AyRXfQjdHpRJhnYCCn1aSd=A10zxjpGeOVLPUzbkEwdg@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8m*-u-boot: remove optional from tee-os entry
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>
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

On Wed, Jan 22, 2025 at 4:42=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> tee-os node is guarded by CONFIG_OPTEE. Since OPTEE adds driver support
> for OP-TEE, the binary should then be packaged in the bootable image.
> Remove the optional property to enforce this requirement.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Applied, thanks.
