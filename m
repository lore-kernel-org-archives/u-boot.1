Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2353CD216A4
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 15:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA8C84090;
	Thu,  4 Dec 2025 16:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IgLS9mrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6A28409E; Thu,  4 Dec 2025 16:47:17 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A8784064
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 16:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29844c68068so14572325ad.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764863233; x=1765468033; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVIO6PX8R2NcvKVSgQWfoV9bN+aEe87hQxL1Zo6jPeA=;
 b=IgLS9mrKdcDSXku1rnT8g7nYagkoLvf8MGVh15PRwehC8bOIe8fPIGL8O47o99zZbL
 EjJXiOP4LFz76HbDR3DPxDr/pAYU7JkwlVdDr1GhWLEjoYFsWdNz4kcRq5YnPHL+C75M
 LCzMS2iAjoZ0WtcikRwkQUJIxyV9T9o0LQeW9N8JwYulpyi+Qv2YNPJQV5GA5JkrZSA3
 0M4n8jQUcHXKv9uwHRtcuoYYyARB08Hg2g4iVkjDBiqVMhS1+e2z9KjHWHYO4O2nvJ+I
 MQ0DytxkMAgGsZC5n1WES27d/T2NhFq/utdRSPRkeftqYSQW/fZTzIK/IkNBsDEiuXhr
 zGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764863233; x=1765468033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aVIO6PX8R2NcvKVSgQWfoV9bN+aEe87hQxL1Zo6jPeA=;
 b=F2it1o4ZifPoFVuPWRdRRN41qEQ4FMLV15ANLf64XumbR8P4GlLzii/PJiWHTcCm+/
 ME2na2TFfbbJIAL7RwIgMufomfRFnZTuo8p5+OO3A9ZO7VkXW3bstZaQvFipYxkIvohO
 miBxMHpNm+sjCINypH67Zudk0W0ycYhcC2assZmmCm8m5PLACht+PfWJd743fSnQPiW+
 ctglwejuo3+Jiqvoand6yUP8fqvPG7o5CKARoMADDMCzKj2cgN7+KwjZsYY9xK+7uoXG
 3XLNE0vs5IjupmqwIuCM/K8JSRGV4cjCThvW5tHaMZlhP5VDdCxeJpKtNvOQhS/QhHyR
 E9yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM2WCDCLF7uFtjif2bKw5CBc5dZtSRqa0j57Xw47jCfusuA/QvzhD+xUDIiqvbB73O6cTtwSU=@lists.denx.de
X-Gm-Message-State: AOJu0YwYoc7Wva1gzOAmvTxCcK7wcejKvJ8Dl9DhVj7ESY6D8fLABJhD
 GgKMQyUU/Qk7SYJq0QFvmMCJrznostJXUn63+RBmHjevp6PNvuOBmf9gPAnRBqyesmbwy5Kuhf/
 Lda71TC5PA4l9A3niQMKc7lnvv9dsW8lyNn45h/hSmw==
X-Gm-Gg: ASbGnctmChISiLaEE7mGCEgDxO6h/+XMr7UPs4nnND9mpxeMurBqL4ygRRZFqTgJ07I
 eBM0FUkbh3Oz0ZnZ8o4UjgQJtNvKRbbs12hZnwyjMLkABewsjk7TH1CGLcpMuVX+ssBcIhEqzNV
 D91zfASZjv/JeyfrJrOh2iKGnzZrfI3Sz73nd8LIT5OROKOjfeKWqWoAsTcUJUeMKGp5egm7Wpq
 TXc25G6bhpbLbonpxtgJxV/imCio51EhjI/fwsSiZROI7MiZUyIsgKAr7Bf3tvBph46iMXpiA==
X-Google-Smtp-Source: AGHT+IGe2/5aiE/5iNCslBamnu5H4r+BYmcjmq1BKT/AAC1eZWgfSlUN3ohXPNZQzwtWldV5XH3dPRJ6r3Oc26RvrHc=
X-Received: by 2002:a05:7300:ec16:b0:2a4:3593:6468 with SMTP id
 5a478bee46e88-2ab92e5276amr5460341eec.24.1764863232843; Thu, 04 Dec 2025
 07:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
In-Reply-To: <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Thu, 4 Dec 2025 10:47:01 -0500
X-Gm-Features: AWmQ_bne9hAQ8aV9tAhhZVPpLSQzqIXq4Mw3hWvjrBUowM0BRrHWyvqvqMvVAHI
Message-ID: <CANp-EDZa0Y4NFOD2sco1xvONeLeixFQOrGLZ+hC275wMCHuF6g@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, Dec 3, 2025 at 3:52=E2=80=AFPM Ralph Siemsen <ralph.siemsen@linaro.=
org> wrote:
> Then it sounds like it is a recent issue... hmm... I'm currently on
> 2025.10 release version (plus some cherry-picks). I'll give a try on
> master/next once I get some other things stabilised...

Just a quick note to say that master branch (with Jan's v2 patches) is
working fine for me. The calibration is passing on both cold/warm
reboot, as well as power cycling (I tried a few dozen times each).
Note that my board only has 512 MB.

Regards,
Ralph
