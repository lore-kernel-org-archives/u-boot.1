Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEC3C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7562180FF2;
	Thu, 27 Feb 2025 13:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OazCHGqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 079D981026; Thu, 27 Feb 2025 13:50:33 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61978083E
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-3078fb1fa28so8078451fa.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740660630; x=1741265430; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+lG6BgI4jk5hLDckCJIcp8d6ha8TIIZ/lkzlJIRLyU=;
 b=OazCHGqiO6LY1K8dYriz0IN2RdvcxxFAqDEn3MWvfAo5YngH2NJvFdY09iqdbCKLAJ
 Bg8q9ndq8EXrTk5fg8q4862LwDANuo3lur7yKMWDox3ub34DSIdSQt33Q40UYu0Awxdx
 ZE1MXX89FgVFGsYZXk2KUHcoYpNuF60Z0P/sk4XjlBZdRw7lVq3JxvEnv1KvRKZcqIVT
 uEKEUhydJa4e3wyyAWkMTcayujA1/lOAzs9aHi4kBqE0KIGVbzLapxP+f5i9/TQOH6Ul
 GvP+hxg9yXfffv7+ed77QOQpZGPB+X+ALD98EEv89iXm6QpmJZKQ/QtynOyIJolqgaym
 90Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740660630; x=1741265430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+lG6BgI4jk5hLDckCJIcp8d6ha8TIIZ/lkzlJIRLyU=;
 b=suRM2bKZf4yBr9FNrFjdk0YoNUZrlTpGhW8GqahUd2MJp7uzUT2gbhSAll0Pb7PO/J
 p6M1HBX7sLjDHvnxNGg4QlFLEE3QkjNZpLMVfUD3CQn3FMLHjFWB6m4YuKTjL11Vsza5
 YGC04npgbU9W9ZXoq37KrzuKTC9wp0LT81q4ra9qQ0HbJaiTorAPBgI32dK08iaT+Nzg
 DWKzho9tytBe3of0juvSavjynJ5SK0WKD9ed/wAG7ISSHYnkbcv+Vun8Zw3ew4pUzunq
 4z8hI7H1gzHkUH9tu8NINwMTSe2aDfSougdZ15OwL4XI0r6vqX+mt1F/FjRk4viMl5IC
 0fkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnHCQemYMTVdlGtpiUvw1nn6HnIsEFa+8dGXAOW3Uz4LZgyu8oyo0R99GrrnKHX2ZREbemDZE=@lists.denx.de
X-Gm-Message-State: AOJu0YzN7nh2t1vzzslUqZRviqNg8w9exSK4l2QAyF+8q68Qn+W05LF/
 xFzKoamGNcRg52MTh604ZoTA3EobCQ+rn6KykU5ORwyNQ1I873oNiYSTmmYZW1ZV1tTW2oMnDup
 6Zk/0miNUB6ewz6i9a8hwPOQLlxFZmQ==
X-Gm-Gg: ASbGnct6koKCtk4N79MaPts4r4xgyaGmPkKNFgnAOJ6+O3Iv23nWnowCueYuJ9XrHl9
 HCwHBdtx7vfT/zyge91t2Jm/ss5rFc9lpuSquTFgSzlhLlN5Rag9i2x92W0qysD9oSiZ5vkjjmg
 vw8uOMbRs28f3tsF+evCvRdTk7DoRrWV570YRKNd0=
X-Google-Smtp-Source: AGHT+IE8iCfaeMkqZvufLCkF5PfL5YagN/ulH2nFgH/F7dczYxe/tRB3mwhSG1wxir+uDejfoiC800N/7sq6gDmEdXY=
X-Received: by 2002:a2e:3207:0:b0:309:bc3:3b01 with SMTP id
 38308e7fff4ca-30a5af4c7bbmr97748971fa.0.1740660629816; Thu, 27 Feb 2025
 04:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20250227102916.164418-1-festevam@gmail.com>
 <PAXPR04MB8459969E5B8C4B6E77C21FDD88CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459969E5B8C4B6E77C21FDD88CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 09:50:17 -0300
X-Gm-Features: AQ5f1JpHHqTuF0Nw3vm9oButASHgllCKcYfoYj8UL6trDYtgjXuRA7rBn1Mph_g
Message-ID: <CAOMZO5BwU87UD84Ryfc8fkqHDuZDGkXRHVG+gAo60gA3uotbFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] imx93_evk: Pass kernel_addr_r
To: Peng Fan <peng.fan@nxp.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Feb 27, 2025 at 9:11=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH 1/2] imx93_evk: Pass kernel_addr_r
> >
> > From: Fabio Estevam <festevam@denx.de>
> >
> > Currently, booting via bootsd fails because the kernel cannot be
> > retrieved.
> > The reason for this is the lack of 'kernel_addr_r'.
> >
> > Pass 'kernel_addr_r' to fix booting via bootstd.
> >
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Series applied, thanks.
