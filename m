Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D79E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 12:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE2980087;
	Fri, 20 Dec 2024 13:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NtcXxVHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD3C8021A; Fri, 20 Dec 2024 13:19:39 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F71C8007D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 13:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30167f4c1e3so19622301fa.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 04:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734697177; x=1735301977; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPEdXVsDvPDD0105ikdpWNK+n/iDWuS/HJd5ROoMwtc=;
 b=NtcXxVHPWUUjvs3yEeUSzUfL4HDfSSkienWobWAXG58iXJmF7S5Xu34n+RIuu7C9vE
 TTk0qoyLFFvdNovQJ1D3vcsM473xbDeC4OSvZfAlmT9+6/Ldr/6ALcTXBYMjaSRYMIZ3
 ewinH2K6484q+Dqws9Lv0dEGmqd+B6NUh92nWhCiP1bjUqFaJ3MU8Ll0upCd3V2LGkUJ
 U+2+vihSF2ImNSlMRxemys1sg1r6a9NmRqM/A8ZVuQqF4lp5aKnGzzfHYnxnh2rFtSlN
 IcA3rji9EMq0wrfhpMkLCOIxwxmSzeCIVbK7eMCQXFew/BCeCxBh4zmzPQy2gRKl2I9b
 Asnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734697177; x=1735301977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPEdXVsDvPDD0105ikdpWNK+n/iDWuS/HJd5ROoMwtc=;
 b=INUjL8/hHlY4/LK5R2lEOraiZDUA+JE5+ZUMge+B1fGY8DhIJ21m3+ogrinW8vAbAU
 TuU8DgUJ/S2jzFHrbAXInPu5d3qDyq6J+wNV5BeN1M0bu3vtdkOqgvjtphKrWmzlDM6P
 QyDQh/0c7jPQoz5ha9laLhR0PpdDc5/9Sd8FesH/F6Pc6S63vR/AZ0io2FmbCZdrapQn
 pQLneuKRur2A1B49cUFXjmITYr9OfMO1X+Vv8qS4k5j1NhWlKEvcKWiby3aaHXiToRSE
 FrOGrvcnZLwCf6LLRYEOCCF71hxAswzKHS1TxfbhBFbggEPgK1MNMSg1nU0efHOaM6fv
 sKqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnkaYzRRZI8IpF1VtCNi1FOigcANurtf5ngNHOSMT/QXEf8LtdliFWVsiicPDMWlUyLPidjZA=@lists.denx.de
X-Gm-Message-State: AOJu0YymuLsOe11sUKDy9K5MqBRHIhHbpqE6hR908K3Md4zDTZu46+DH
 lQdzlQEzkacp6PhoqTfIvxDWK9nwf2UeYlSwPjEx9LewOnr9hDAHJ2dbugthb/EfliTgFKXVW85
 3MK+3Xh5BSmO+lKmWNRa12LGdQXI=
X-Gm-Gg: ASbGncuOzZJSWSTfs9vJYfu4BnBFqIOkgIQ8OVki1Hk4zYR+/PLaj+3GAthDWjT8g5F
 ddMvtS10d4xl18JP4Eg/yGaps6z8mSwBMArmlmDRBiP5+/4XEWC0QHPw8uiMtLo73Zlk13A==
X-Google-Smtp-Source: AGHT+IFTBqcHS28lbXodgf2SplRMXNxvNqGh+pFPxKbMqkz6dKcNuL1p584d7W7ZXlAoyRryvp4AV402E0GIlBb2F7Y=
X-Received: by 2002:ac2:4e12:0:b0:542:2a73:b4a3 with SMTP id
 2adb3069b0e04-5422a73b5c8mr611791e87.14.1734697176298; Fri, 20 Dec 2024
 04:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20241205-ge-mainline-display-support-v2-0-4683bb4388dc@bootlin.com>
 <CAOMZO5B=4eoMxxFKieUgXVWMpJOad-V-o+NmG3JhAMFptP4DgQ@mail.gmail.com>
 <877c7uww8c.fsf@bootlin.com>
In-Reply-To: <877c7uww8c.fsf@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Dec 2024 09:19:25 -0300
Message-ID: <CAOMZO5C7o2c4_bdLxCgR7ZDO063_cuhNt57wE2u+rspY3rks8g@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de,
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Fri, Dec 20, 2024 at 6:16=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:

> Am I allowed to push a branch to this repository to validate the CI
> passes? Or is there a command that spawns a container of some kind and
> runs the test which I'd missed? Any pointers will be appreciated.

You can submit a pull request which will trigger an Azure pipeline:

https://docs.u-boot.org/en/latest/develop/ci_testing.html#azure-pipelines
