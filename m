Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5019CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E852782FC7;
	Mon, 25 Aug 2025 15:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="erWQ2dEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5446D828A2; Mon, 25 Aug 2025 07:40:53 +0200 (CEST)
Received: from mail-pl1-x662.google.com (mail-pl1-x662.google.com
 [IPv6:2607:f8b0:4864:20::662])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D943E80077
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 07:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=david.regan@broadcom.com
Received: by mail-pl1-x662.google.com with SMTP id
 d9443c01a7336-246180dc32cso5112215ad.0
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 22:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756100449; x=1756705249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PcaYgE8eQ242+POQxJGpY1FEVDYc9rtfytK9giwPnGw=;
 b=sdJiI5lyVZvj8TyRBBYg7coSp9R04OEC0DVEBwVrrX9qj6+3TgPzSl9+K2cPioj7W2
 U618vFm4oQFB+Kl3O+of9iJdLSKj3Jsv6YuAaE+cypbYsAUjJIsSXDVrgHHwrMyZq1dc
 AskyZcqi7dI6Mu4xoSSIFy7j0l9al71zgQUbRG60PmbE28q/xf6NoUeMdd9xtnL3gmm8
 pl/0+tPjIk/tPKHI6lErRiynFo9azB1z8w7/npwRIfRVJflb1D/W28WrPT9naN/s7G9/
 ZY32FtnRNfznazteBuu5vQZU2mcrtq3viVeqdWSA1k3OfZ+Ej2eLWTVGiPuTt48usCKo
 SzNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXutW1oozfY+nmQOpLoA2cDj0YPmn9YJKB695KPpqdDSGVMwwZfyKqtzgl8cNKUn0Gi+Bb65zo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj/Uu10ZEmxRmeRC4JG4JPucpNHlV/2J/ACA6wHLBMJ+K8Xuc3
 D26ElRYrlA+E1cc/0M0h6N2xBbsZXSQ6sfFkTD1N6KaF+5ujSCuh589mG/4QteNeGGmX2Y2N3lf
 jFNGEK9Ut6KHZeozwdkCpg4YrBefClkH/vHzfg8Q/VucLXMeR+/J9dAubMTb3mdCtN/4Kj+Jt60
 pdA3EcSkaDLwIZRvmymrZBeeW8PZm2Nh9OhXiUecs/PigxzZgMYNn0Z51i4YZINM2VwZjRZXUWX
 FOA46w=
X-Gm-Gg: ASbGncsudPE83aRA5nJYe1KgiEN0bunBmc60mVxOCCvyPCKyQddGNdFiphDN+PX+tmX
 NO2Q0SvT5dmKiKaFUKByFw0PvqQK7EgCgRWq2YjBODXgsg0JU0PzqyPWVFetg+ota/mpNPV6Bu+
 jTaoqseMBfXULE7FonJuqHaOThng4fDmkS+DP1b+hTA9uuAEYPXSPSoR07RbkPuJwfcs4O6l4U1
 7Cy7YCSIOJtq8d9s/Zqfkqe00mTqbautTPtrwjq9FMJ8g6mDOGtCYcDJSGnT/S7YBtTa41tgUDf
 0DgXYVZe/Dl+2OgUcefCvdKH50bvaE1qyUIwRev4PQDLzvb9HOMhubzLe98DQFF4T5XRm1iQhKp
 z/wpzBe4lO+ReRnx5LqsSbAXL+aciCQdknxRYq0BgX1AfE4VKMGCAAvkNhhIzigTZUKM6DX/W0G
 Hp
X-Google-Smtp-Source: AGHT+IHJnJX+E9UJtwSdFEIXty7kqQzdXOnVwwdoCew1OiDGkkUnyXMxV6MrHemjlNQwoS3rK9KLBynhUhvV
X-Received: by 2002:a17:902:e888:b0:240:8717:e393 with SMTP id
 d9443c01a7336-2462ee8e35dmr68453895ad.5.1756100449125; 
 Sun, 24 Aug 2025 22:40:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-246687919bbsm5591385ad.6.2025.08.24.22.40.48
 for <u-boot@lists.denx.de>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 24 Aug 2025 22:40:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-245fbdc2546so8754535ad.0
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 22:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1756100448; x=1756705248; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PcaYgE8eQ242+POQxJGpY1FEVDYc9rtfytK9giwPnGw=;
 b=erWQ2dELFLjdbNWbLOFTMa9rccNznc7hes/mFDs498eObqc24YDEmwlshGYy7mAKA5
 AzqUW6bwydrawh/Wl1RJea4/TXOBxiDzTGJch90aLwFKB+ibUlXFYpMaLKoGt/r5qgRb
 4sNBsSUSxWIWUvi4aSDpWqs7hsnS1ERbkPUhc=
X-Forwarded-Encrypted: i=1;
 AJvYcCVAlZXzwvlFWFZbw2JWI8Fla6csQ3xmnW4Urm/tqhtvV5OpnAqHb1q71u4ZZpPuyQQGApKsIfU=@lists.denx.de
X-Received: by 2002:a17:902:cecd:b0:246:a19d:c13 with SMTP id
 d9443c01a7336-246a19d1686mr34031565ad.1.1756100447563; 
 Sun, 24 Aug 2025 22:40:47 -0700 (PDT)
X-Received: by 2002:a17:902:cecd:b0:246:a19d:c13 with SMTP id
 d9443c01a7336-246a19d1686mr34031325ad.1.1756100447209; Sun, 24 Aug 2025
 22:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250814180647.1805196-1-dregan@broadcom.com>
 <CAOf5uw=FF=fK1AqvoBhZUN0R2zy7sqRLUWZn=RvBat_W3zerhQ@mail.gmail.com>
In-Reply-To: <CAOf5uw=FF=fK1AqvoBhZUN0R2zy7sqRLUWZn=RvBat_W3zerhQ@mail.gmail.com>
From: David Regan <dregan@broadcom.com>
Date: Sun, 24 Aug 2025 22:40:36 -0700
X-Gm-Features: Ac12FXy9IQRTXAcsOjLPEfSgg6hn_s6-5Uv6XSZ2S6akdVHMH5GPSlUujhM1J84
Message-ID: <CAA_RMS6_T7gcQh1pERUnno9jCMBH_fcmx-Ud-ePQGz5zu6UhXg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cmd: nand: various updates
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: david regan <dregan@broadcom.com>, dregan@mail.com, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 William Zhang <william.zhang@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Mon, 25 Aug 2025 15:15:31 +0200
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

Thank you very much Michael!

-Dave


On Sun, Aug 24, 2025 at 3:37=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Thu, Aug 14, 2025 at 8:07=E2=80=AFPM david regan <dregan@broadcom.com>=
 wrote:
>>
>> Bug fix of name changed OOB placement option
>> Change ambiguous 'count' to 'pages' for read/write raw
>> nand dump display update to show ASCII characters and data offset
>>   into NAND
>> Add option to nand dump with ECC corrected data
>> ---
>>  v2: applied MTD_OOB_AUTO to MTD_OPS_AUTO_OOB fix to env/nand.c
>>      per Quentin request & added Fixes tag
>>
>> david regan (4):
>>   cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
>>   cmd: nand: more descriptive help info
>>   cmd: nand: nand dump display update
>>   cmd: nand: nand dump with ecc option
>>
>>  cmd/nand.c | 56 +++++++++++++++++++++++++++---------------------------
>>  env/nand.c |  2 +-
>>  2 files changed, 29 insertions(+), 29 deletions(-)
>>
>> --
>> 2.43.5
>>
>
> Applied thanks
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
