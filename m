Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6418BC36018
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4E288DC4;
	Tue, 17 Sep 2024 14:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mOd4qGul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F25388DC4; Tue, 17 Sep 2024 14:16:23 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0A688D68
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f7502f09fdso41764681fa.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726575379; x=1727180179; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2TjQAQIsQNxFdsflHpxgDhl9GqlIN2aNUxA9WfhTKA=;
 b=mOd4qGulMwKf5D4ZniIRn0ws4VC/4T7YWWRFWWifyLJ4VH0N9gw/Z3ykJs6g4iAjCA
 8qvupULfpH2zBbYkcB9yYXkp86ZocPpyi4p1HsRl74sLfPq5gFZov+AuMEnqhPAHVZXo
 Q7O63CMR5GSWmgTnD8HyP0ia9N7hl+VwmBdH1AfbN+2Dl6F8CwmNIFM0ktxOiOfLsTTH
 hnPylZUJy/3sJCEdYIqkzE6OVOgAzI608mDXXrGrvODI1+4XfDlIzJ53N8999CXsRqQ0
 n81oipv9HZS/sA1xG9hC94yjAYhTFzzWUtoqjxWZu1LILDur9kXG3aoBaHtnfNv3JBOC
 ncYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575379; x=1727180179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2TjQAQIsQNxFdsflHpxgDhl9GqlIN2aNUxA9WfhTKA=;
 b=TN1DgnnjcjtaLPiMy+bGUR49Wc3k4QwQT1MPmssqpx2OATU6TL2kwN8E4V+BlBv5V7
 78JHYGaACki4w0HpQiNZssnimVNIKRgVrqggREdNPLWjG0oWBldHg56VDi4ItLhMgWN+
 o1G2mZYRJAZya27kJK9I/WxJ82o/r72Y/S+rMmQ7yj0ArmYQDCftDRk2CC0HdP+0Y2Da
 xrRZXFRFp4gT9xG5Kdw9nveyy/Gwqm86N0ptfRW8YNSbZLKpg9qzngJhWFRSHgHqeK+2
 nAUqGC/kXxJCRqxpnQBZeJCRR71GqriI/MdP6VdTB5lfy9mHDLqFDCGr6PI0QaJqQiao
 518w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzNP7QJ5YwPEh5nRTctSGwYltOukyjO533FP2Ek6pjAmzfC0LUpMPcFf8uFhSl8QaHF9IAhgU=@lists.denx.de
X-Gm-Message-State: AOJu0YyAVvx8Tuc7MetG0QUwTk8U95it+m8rvuNNIn9dU7hbUno1sWqo
 9+/Fk6Eisce1v69umIvP0YE1N0Z9ed/mPqMTm8n8jitgzoNqRLtUsutvJC0BtxvIUI0xp01vIyw
 mBqY6UKEKkDLsP24FV+ZSCz7mXl0=
X-Google-Smtp-Source: AGHT+IF1wzTdMEBy8E4SbDmydeZXJtz3CipNguggbLuU8OHyfRNIhZ+yjftGairfjB2DZc/9Rr7q7vs2AJanYMu4Kqs=
X-Received: by 2002:a05:651c:2221:b0:2f7:5ca2:6d10 with SMTP id
 38308e7fff4ca-2f787d062c9mr70210391fa.15.1726575379477; Tue, 17 Sep 2024
 05:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-4-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-4-4fe8effc937e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 09:16:08 -0300
Message-ID: <CAOMZO5DCaU7min2OjigJiXOJpXMgOnncwjbFAyiwrX0UAxiOvg@mail.gmail.com>
Subject: Re: [PATCH 04/21] imx9: soc: Print UID in big endian format for EL2GO
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
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

On Mon, Sep 16, 2024 at 11:30=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> Print UID in big endian format and as one buffer of bytes, so customer
> can directly use it for EL2GO.

What is EL2GO?
