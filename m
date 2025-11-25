Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46B4CFD37A
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 09:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437EF83FBD;
	Tue, 25 Nov 2025 10:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4ch+4Jr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D8E83FBD; Tue, 25 Nov 2025 10:45:52 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A126A83FA5
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c765f41346so2076077a34.3
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764063949; x=1764668749; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GhAt+0RGvX3/N+actNGcGDaDVjRfMM5XQ5rOi20c54=;
 b=D4ch+4JrocRNQXm6pe11qo2uG1wrRUN//TKRxlOMWfCyvNbIICi/KvV7lRZdLKqzMx
 ApSkP13LaToDpK/qC4wPegYZDvsbyJOuylxani5b9MNltIlk/QOVluOOndX+21DmrM+u
 FXzJcmLYoZ8xW9cttZX0QJcje/bIJMcJHxWnx+b5fcXlrG+1oXpaxOtCmTYa3YgQXZTR
 qgNZSeQo8QyYpoec93YovtVRSzZ5fiiYArG9wN+Mlu9nw6G3tgmbeG/nXsRLwaonCzRj
 TBUtuarfDzcQDumYLj/uw00u1fc/oZ4T7n+gw4dWLpizpamKgs1NUXNyDouybqVHA0Cf
 7njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764063949; x=1764668749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7GhAt+0RGvX3/N+actNGcGDaDVjRfMM5XQ5rOi20c54=;
 b=NMnfYxD6Xtzi4/iuXwtVmTcanF8gxllyK6elTxOGyY1/7NDICY0yV9CFXS5/cORV3J
 mXk3HGb4NlyabMaFiGd+E1xLUASfvQkZdAs52o69RqgibMcX3pYHABR2Pca5+uIkW0Hx
 BcVgpteb8Mhw06a8/eWAH3ZC/Pj7nkGHadRGgGNfavzwLrpIjz5UloeptbqwyZcTo6Bw
 71ou1LIBM9hc8mNy8CBOSG/P9ZqLKj8PHOtq8/WAjnIY+jdAph3kEr8PUnSWN08IQbE0
 qkLJ1sFio+riWv+I7QR9POAPG4rQFGkv9P5rNXMz9WCs/ZoIgVQFojAY5qxDox7jI6jh
 J7TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCc8xJMzJxWpdU03S4pyWqHhQnibRdJz/YRy3ZQguCoKrh/Rg8bcFHvQRrg3LdGfqiwet+fr4=@lists.denx.de
X-Gm-Message-State: AOJu0YzvumWBx9tqr8kHZpliPXQ/s6UcwNliPmsruIIKX4caCnMjJiA/
 qzHAFOBuE9dEffTRn+niWAgo81BedS0M7Re8AF94hUO23B/gzckFpAEUmG7ZSUxP6Copcw2uXT+
 21dEgQh1VrqPp2q+2PTH8afCZQTb/ro0=
X-Gm-Gg: ASbGncuMszC7Dw24T2mbHtQjAxSrW7uWKSToTDsgVNIdeJbvEkBg96AYb8dBzhBiR35
 i7F0wsftnBXCuPy0e76qrPKOc0245ZFZc7/OdASgWHTs60KAlfCH/UqnYIYV6jsChZiSxlOLGJU
 IWbk7ldshnZRfGQHey/xkZdcdvfCFCJE0VEBfh5uam4KD5FghxCxOwIz/ei4k8CTREOlrfSqHoK
 7loliUVB2GLjWY+mJg+3GKylqjQiplvaDB7/NlhW+0nQB6lzPC4thYFibHGYVrVZ5foNw==
X-Google-Smtp-Source: AGHT+IEULja92TQpIZHA0rHI8zgiHIEsNCIhoKkWL8dQsLI8LwI2TBjiwv+2RdpCthi4nz4pOLQO9FaI5jh2ZfD4qzQ=
X-Received: by 2002:a05:6830:4108:b0:7c6:e92f:41cc with SMTP id
 46e09a7af769-7c798c4ea98mr6931926a34.21.1764063949287; Tue, 25 Nov 2025
 01:45:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
 <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
 <CAN7C2SBtyc_i3inaCMBCUr_x40_d1LqEARtb2iJms=rHt2TtsA@mail.gmail.com>
 <74bf28a9-dbcb-4bf0-8f99-9239018a94a3@siemens.com>
In-Reply-To: <74bf28a9-dbcb-4bf0-8f99-9239018a94a3@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 17:45:38 +0800
X-Gm-Features: AWmQ_bmUPt0RKLhUWi0ihywdoIgRrp2rGF09E6r7MjhMkUHqwaQ1gJ3hcii9Vbc
Message-ID: <CAN7C2SDz08cDgKQXMwJfDf_pVfqhhz2BJhVKHk2WqHP+hhE5Ow@mail.gmail.com>
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

> That's because it never used that (intentionally). We always booted from
> a partition ID, but the old versions had all methods enabled, and that
> papered over the fact that they were mangled into something that was
> supposed to use partition ID but used bits from the other paths as well
> to compensate mistakes.

Are you using the mainstream or Altera U-Boot trunk from the beginning?
Why does it sound like we are not on the same page?

It is not even allowed to select two settings since early 2025 major
changes on the detection of the boot method.

[*] Use raw reads to locate the next boot phase
                                           =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                 Metho=
d for
locating next phase of boot (e.g. U-Boot) (MMC raw mode: by partition
type)  --->                =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                           (0xa2) Part=
ition Type
on the MMC to load U-Boot from

How can you select two at a time?

>
> Just study my series to see all the breakages. It was never clean,
> though, and that may explain working setups by luck.

I am using a custom board na socfpga on Cyclone V SoC. There are
no such things about luck. Either it works or fails.

Completely lost on your case and the patch.

Brian
