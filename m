Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E16CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A57808AF;
	Tue,  4 Nov 2025 19:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pnyjfa5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CFED82A9E; Tue,  4 Nov 2025 19:09:48 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88AA58003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3696f1d5102so45080291fa.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279786; x=1762884586; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7OT/0fFuqo1SxL465hNKGVo5kK46c3mdXaDeuwqMQQ=;
 b=Pnyjfa5f4WtEUb8KOm4gq+9DFfTUVAaWQR/SskDO3qwmEPfKT1sF/XcYS2Ckcd1R0n
 Y0oTeOkVinb+jXJSJaeBVxwS0TiyGzIJiRqZ1A2Dv7Iy4rckTGO4g5mvQI9vuMSIKtN6
 UUCiw21ffyWG4Fw6XRCyz9m6Ujw78w9hoN0U6tUXkONd0WgZuQTmeGhV8YbRMbVlAjl3
 UtSAH3cUmDvjIoTgWz+YSwkaFdnuMULbIqe8ZXR4I6B64j5/I5tp98sUWQQ2QjshvEpm
 SLaTi49qt6ANQG+Vwd3iKuZnTAHURQOgZ+RVo0hi9DFrNkhC8Tda0zNbaw80KAW4uIYV
 ZAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279786; x=1762884586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7OT/0fFuqo1SxL465hNKGVo5kK46c3mdXaDeuwqMQQ=;
 b=MshkRoq3Embxbgsz9pf+vFyFO3XBJkSb2nFAys9eHpiE3E6xY1ZgNU1XmzZNgDOrfN
 FClGba0LgzV8REHwZ5GvyDTQLAPe/Yd+t8emFfGENlXtJK2Z06dxguy8pHutVhIkfCDQ
 ccY0cggTjKPgNir4nrINmmrSROeU9mjSiOKQ+QlI47D7EOgMR8U7RhmoLD76aOBZe7lM
 Q9QOV6F67VSjvhaVRH2iB5XSWfo+XC7mt3u4whIcuawFJbhmao0Smu5W5g+b/b/CAGin
 aeav+7JImoTazOhm9E9OvR9OE6TE9f0Xshd+ojSQHyhDXC99IVTINc3iKxe8eZ8NTPIC
 VS7w==
X-Gm-Message-State: AOJu0YxML6z7Z1BcNJKYehfx6j4nfOBBvZGE/fn78110UmyA4J0S9EaS
 jvM9iJVEfx/l9lCYbGSLFlY+Y5nconmllqYa0O9jo7CB+TPfBPXY4wWxl2/7+ntjUaEcXf5cLJg
 R8qlrNGYdcdGPaDn0UN97st4Skyiilng=
X-Gm-Gg: ASbGnctrl/c4CgNPmIJ5tXKZNFaldlYpkzd2mXyWKTN5EAt4CZ29Uzh7rLSqkG2AS5Q
 a5hZdQ6j0nK8zvLstiFjTr1OmvIqDc2K+rLPW/4tjRDfeUNwde7xUX2JPR0lEGSirrNzXpn7JPX
 yeysYVi859Xm5Ia1E188Kb6532Ic3JHKMpQnGOzsyFNYUW2HGPXLDOsl41nlrFLJRNXJ/PgczFQ
 TkLAUPckvXR/RQM6bnhCTl60bdke4RR2auMgUqUkTKcIdyvPbfi+cSEXZ+6EonzNJsVInTJyNAk
 tdwzccaJlMVjgP4I
X-Google-Smtp-Source: AGHT+IG7gCHGM1s32BrpW4f8SW3Ey4twOSvxiYaK38JGFEL+KwZHLYyX9ddl46XQC9pNvftglAJc4NmeTevj0VCEWyI=
X-Received: by 2002:a05:651c:410f:b0:37a:4e47:9160 with SMTP id
 38308e7fff4ca-37a514a28dfmr505221fa.48.1762279785659; Tue, 04 Nov 2025
 10:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20251013034128.1752157-1-ye.li@nxp.com>
 <20251013034128.1752157-2-ye.li@nxp.com>
 <CAOMZO5Bh9tZnRvV-SRmRNdLoruWUQQ2Gv-YJ9K8-CE7q3ZVU0w@mail.gmail.com>
In-Reply-To: <CAOMZO5Bh9tZnRvV-SRmRNdLoruWUQQ2Gv-YJ9K8-CE7q3ZVU0w@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:09:33 -0300
X-Gm-Features: AWmQ_blVYcYwkKnkU-fUALXvFZ4IaO12ux-DmxUkuLiBxjxjEsgs5LCiP6asDvw
Message-ID: <CAOMZO5Ad7zxw_i3mkOHu-KMwn-TrKccONVn=eiAun8icEBzYOw@mail.gmail.com>
Subject: Re: [PATCH 1/3] imx95_evk: Share the env file for both 19x19 EVK and
 15x15 EVK
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 alice.guo@nxp.com, ye.li@oss.nxp.com
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

On Tue, Nov 4, 2025 at 3:08=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:

> Applied the series, thanks.

Actually, I applied v2.
