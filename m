Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FDBC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 00:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A95D87E0B;
	Tue, 16 Apr 2024 02:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGwtOev5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B5687DB1; Tue, 16 Apr 2024 02:45:27 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011D987FA1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2a7e19c43faso1203480a91.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713228322; x=1713833122; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ba08nCMrUU3CJUXBlgzNo08gw4XV35T+S2rcJRtkGk=;
 b=bGwtOev5mufEt2R1sFth61ncFGS43r2/Dba0++PmUbiaHfl/B8TJ7r9Wx82sIMc5W9
 CAWCtOR2+KixQ5vZRLUKjQR4fo2UT20kz1Z1ELZ5TXll3Hmtd1aH/tKmChOv6qZUuUjH
 hrv9Elkhz5MxMnf4CGnUK8ng7YLwEuKTQYPYf7lPs+JVU+6goQz3m7v6zsAh5Q28DMgw
 /GoIBfbEHDTC1pvtDuZpGK0lNxfr+sXs5/YaU/GHfF+hDaEmu7g3Qe73E+BiYocbJezg
 8qMdrcFZxzZkCQ797sivpjUplB1aEvaJVWw1sQrqLMQ68Suurzz+nh0Ixa3JXPbiejUJ
 JA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713228322; x=1713833122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Ba08nCMrUU3CJUXBlgzNo08gw4XV35T+S2rcJRtkGk=;
 b=JLYXijE0Oc1oNGBXq/UIBBcZILrxiBbbr7/VtFV3VxFgVYptn7IedcuxXtc0BklBks
 9MArT19a46wB+BovF/KH8D3Ds73jGUkMGO4RvOsBVzv3HAJRb4UFxJayNvdgvFqV4ZW/
 Wi9IBpoQpfl4O5aJswPK/GxFCC1F8I4tKiuVL5JRxnIZxiBkVXvasX+P6i+YEyYHjjQJ
 LGaKkIYilTWFSTPZZL4xpCiHZB4kjNv+AMQhMsxzSym7Rl2qnyTupY9j0lpx3PPM/1HL
 20fkykZ1G0Ph59HjHusf7F2Hrdwbg9UuIX8O/WBEZOID9uwcJmtEDi3SU8YWs0LBR1EA
 GEZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDz3JWr72xvgTi5C9+QqhDeJ8mx0HcI3sX2oTBh4LbtzxWaB1HJWMIrig1td9CQOPAfncJJzPPVTEaQSOsHy5AwKkHHA==
X-Gm-Message-State: AOJu0Yy1XnVSX9vicEtTn/oPxrx4H3PH8aW0LVbUjqijWhx5tw8+cpal
 hae3MSx7c30nRmH/HGbVek4J7Jjve/YCAxo5iTWdGwdvQ4ScHNkZdq9sPxqJsFIu2ZjB6212VCy
 YhPDOm+P3ziOnxCFGEo/q1vyLygc=
X-Google-Smtp-Source: AGHT+IFTvVV7IUvP87hqRMp6FwrY4aQHci2DSjRGfSCf947mg2op0QSueIQBQn+qKVLpa5e9zO4m19k7dfOmFSBNSeY=
X-Received: by 2002:a17:90a:408d:b0:2a2:dcbd:9f01 with SMTP id
 l13-20020a17090a408d00b002a2dcbd9f01mr8947237pjg.38.1713228322365; Mon, 15
 Apr 2024 17:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <20240415130013.26721-1-yasuharu.shibata@gmail.com>
 <20240415130013.26721-2-yasuharu.shibata@gmail.com>
 <CAOf5uwm23ck7uwr-tAZp=8L9HVb_A0r6BYNZ3C0KCaTNkHG8Og@mail.gmail.com>
 <CALu9rSZeZYyuCwBeUgR+sxMvmqDBh+Q5hyb-gtHP0U8ovHby_g@mail.gmail.com>
 <CAOf5uwmqeMKKyf6-vxOnUMisHNZ24TupMRd_M-QT4JdtpnaFjQ@mail.gmail.com>
In-Reply-To: <CAOf5uwmqeMKKyf6-vxOnUMisHNZ24TupMRd_M-QT4JdtpnaFjQ@mail.gmail.com>
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Date: Tue, 16 Apr 2024 09:45:00 +0900
Message-ID: <CALu9rSaAgA00m0trimrhL4XwVivr4UFAhENnfmEdGKLsArBtUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: wget: fix TCP sequence number wrap around issue
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Mon, 15 Apr 2024 at 22:55, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Very good job ;) to fix it. Just add Suggest-by: ;)

Thank you for your advice.
I sent following v2 patch.
https://lore.kernel.org/u-boot/20240416002624.1909-1-yasuharu.shibata@gmail.com/

-- 
Best regards,
Yasuharu Shibata
