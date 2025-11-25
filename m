Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2781CFD37F
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 10:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3386183FD6;
	Tue, 25 Nov 2025 11:18:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CeojhPxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF61D83FD9; Tue, 25 Nov 2025 11:18:08 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1CD83FBD
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 11:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so3429226a34.1
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764065885; x=1764670685; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ekJWS3cAWHpYP+Gad6UsHwVkUCxuLHAP3ynT6WVyh4=;
 b=CeojhPxSFtiAPTOB0bZBNj9hBTYey61ahAduSdEGWjzIkA2/+J76O1Ot49lifDYzyU
 r0hdHPCglCytzC979XSArxNZv1mZhVE8cb2h5fcZosK5d4S/pkx9DYm7IddKUsk1gooa
 /UOqNRwf56bb/1+UkU4wAAM/pBJxf8hhdiwNzW2r09bWDZNZdCVN7kxcAPL2QJEw6PFE
 dMf8ls5/Nx5SdVBjIaoitbp1Mz4sw1R8itrhy6iWHxryl4/3DwHMWhiFGAqAR+8udQ7m
 3k9rxhyuJWDIUzdn3zDz+pEpBZsx+xlt0A6AlLAvuMC9LAtpuJNAR+/Aa3MXDqNqAAiN
 timg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764065885; x=1764670685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ekJWS3cAWHpYP+Gad6UsHwVkUCxuLHAP3ynT6WVyh4=;
 b=BmjSeMyGlbzh230YgPoqcCMpIiGRUWQIkCCNABNb+PgrOeEZgJoVGT5Pl8dANXOGq1
 YZjsjwN7xQlGYy1NzfIrdlRIT8hczXYHLUkjqWbDtqOiWLNoV4ss4aoJNwUwU/gNF885
 +7mi9879z4xLovfvfFfqzYZcdkhg1lqDCs1LJMTpMxlbpV05D9wVFCyF65oNte/fiw2f
 6hGtnHTfkMNiCpfq2U9xX2Y2umvBMeR2MUHnpyI3PDIM08h3QKkEStFlMb+jz+85TlCW
 Bg/5gC6AJ8T5ib0ZjTD0gtiBwW9+tqsJyrx/ZJcjRBT3PHjM+kqucJJgt7r7iMiCRzBJ
 vvGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFJPrMN7eHIuUVKp0z9sS7D8xsiMOtlpeQZauecIfhdfavOyp/EPS95cz35s6l5r3okz3LpFQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9Zh1MfGYjdV/4/9BcXOLDL5lOOPyHFpzYgdf9CBEmwpFlyym+
 1lEtplTm8y7S5AuZeoFfs4zQ+cSqFDO5/XwToNGxS2pTDPszdPPtDfU8wY+dR+A0M+25gIdXZN/
 Qvt1UTwgDJk7Q6eTrzS+YuCLNQKlUmmE=
X-Gm-Gg: ASbGncvQgDoSGisURRzKvdPeRcgmRqzlv/ORAOmo9+QfiwoJPjM2h07tGqsHUo4OeRX
 4ls3yT9o4L+WudiDZRJVKdkBAShkKM3CchBW/3vlIP0TdPPzkgbwAxMrjfntmA2pmqPCdO3nNrg
 T186qczz5gZ0c4FGx+hNk6qCgbVEoeIbK9MhshdIsmEMt2SlShRGr6ZWCrZHIVcjOiea5feMoaJ
 dhNYeMf7F1oWVk/L+OCiUoCL+9PZPO8sbg4+/V+oK7fIPKlR2frtrwtUv8jTNyVwP95bQ==
X-Google-Smtp-Source: AGHT+IEMDlPkMNsUZAB/VGOX+YeZdQ1jT5ugXgJvnV+TGmDj5aBuBOJvSNj8a9O3Wpv1M3mgSSJMILknY08CJHc1yJs=
X-Received: by 2002:a05:6830:268b:b0:7af:353b:95ea with SMTP id
 46e09a7af769-7c798be781amr7065938a34.14.1764065885445; Tue, 25 Nov 2025
 02:18:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
 <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
 <CAN7C2SBtyc_i3inaCMBCUr_x40_d1LqEARtb2iJms=rHt2TtsA@mail.gmail.com>
 <74bf28a9-dbcb-4bf0-8f99-9239018a94a3@siemens.com>
 <CAN7C2SDz08cDgKQXMwJfDf_pVfqhhz2BJhVKHk2WqHP+hhE5Ow@mail.gmail.com>
 <bf13f555-b1e9-4208-9497-baa3870bc0ed@siemens.com>
In-Reply-To: <bf13f555-b1e9-4208-9497-baa3870bc0ed@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 18:17:54 +0800
X-Gm-Features: AWmQ_bnPwehiBqqzmIxHGa_C4kujp3Lg7enqEbrIgJzWdgXpkbOuBpaKJ3Bcfa4
Message-ID: <CAN7C2SCQd9M=ghBFt2t2Kg1w=VLA0DOMY9HnbwTH2Yram1iYfw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
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

Hi Jan,

To be honest, it has nothing to do with the board.
> Different boards.

deconfig itself also requires alteration from first place.
As of early this year the boot detection, so any sync
patch had been pushed?
The detection is completely universal on cyclone V HPS.
Unless you have the power to reload the HPS bootloader.

But long story short, I did not have any issue on
Cyclone V socdk
Custom board two variants on size.
"=E5=B0=8F=E6=A2=85=E5=93=A5SOC Cyclone V" by china vendor.
Which this board is a clone of DE0 nano

So I cannot see how DE0 can have such power to defer.
So long story short this patch is not really a must.

Brian
