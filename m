Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D57FC72C2
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06FF5840CC;
	Sun, 22 Mar 2026 14:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PzIgSpkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD67840CF; Sun, 22 Mar 2026 14:30:29 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37923840BE
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a27eb8311bso2070111e87.1
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774186226; cv=none;
 d=google.com; s=arc-20240605;
 b=KM37lXLfBm7pGuZflcK+d7aYmLUUPJ5lMNY5u77vUWuA0GLuPmdF23N7I8aS3GN8la
 jVYtM2dSeaRxbzpZCSSkNMXoml0OywElWFl9ZUl0fzi8d47Gxphj0zKMmFsVJTN778Lk
 HPOTO69OCzjUXuSc/r8UNGQ8dY7Xw/uv8fRSR+L9W60qbDZNUeKODfb4fvUsZG0DFgs2
 dLN4Ig9dCgXF3cvck1y4q0+bQ7YFg9DbL+jOkUQW8yUjEzPzt1ck/pEUiThwyRbUniN4
 NzRQg83jMdJ7cKPKdBVXNFASwUcTm3MttCTltLA47AjgLCcIhZZ0k3wc+zrD87h5ReHd
 GTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lvnmrFJcXw7pEbn/X4/rxU/r6XJcbTZ9lD3TKHsFtbA=;
 fh=/r5ooKYyhPwbocsvVouMrvAPAOyUk9KSnxt2quwOXb8=;
 b=Do0bry6+ddhjV2H4CW8KYQLGYpI824lwm2KaNi8TNb2dIlzIXs4YeZI6+Bg+suoMuh
 47JP0mmr3jNTGT7uoRQ4PTbIaR5T3blxLndiHol8OTxLr0/zC9NnKD99B1BWSwYW5zRA
 6jHRihLubNUg2eRIE6d8NM70pH0vKGiTBjmKIBTuSxeUG7OCUG6TtMwmsrjhVSV5DAdZ
 h6CozNc1St435IPjfg9ExmSHzAVXGkCSKrytal9e1Ag0CKK7Fb88OUyG5PFVXjq+4el1
 sFQzNv5P3qZQweBRddkEZyPy5LAnZ65UvSF7LzDGpaNzfY5DCk3Lmo8IKTmZCZepqKHN
 Sv/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774186226; x=1774791026; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvnmrFJcXw7pEbn/X4/rxU/r6XJcbTZ9lD3TKHsFtbA=;
 b=PzIgSpkQP6O1u3Cj7OYyT6a969pRoXea7wueZFV5jtQdgxGkb34Y1w5OZr0PfpfYbm
 zix89EBFttqyAL1xByMxmvADFpsvrwauKAFIQa2IAcG42XcBJGs8BaXqIsD1Zy4+g/H+
 1tZyh3aeiIlM3dcuLoh/c6wKNeDqf+MgAc6miYVoIKKZrTAj75EppfJltMB3T2gQfdRK
 2MLZNMexVhskavRJ05a/QrBp7SyWBX9Qczs5O6lzzf+q0W2dl2otIJMfKAY6BEI/2BDs
 GQXRM7A3pkVvcEA/HMhVqeM4Iz/ucon0KnQi7gFX0Da2FBmzrhmZEUU0kqwuvwgShsZf
 DfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774186226; x=1774791026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lvnmrFJcXw7pEbn/X4/rxU/r6XJcbTZ9lD3TKHsFtbA=;
 b=Ee6hzUicVj0nXnUI0SHmJTejGnkbKaGQHAK+kYFXUGBbOyDqDoNRj9BVV+3a7CFzub
 LbAZYSxDVtfxJiFGUlyUxU4zhU1Qcvyy92sD4PI3mgT6+yX+1033WA6nkYrXZC1kjOaK
 ZZMrTCEs8/caySu3tvT/s3HX8b6hZlLPRtJjgakmRAHhIi/NNd5LS1GMEdnKDIbT54BS
 6SWHFxBNOtqM1sLu1tJU3jY8Qk14wEsmph1+YYNIZ4k8mgrMPNHdnzr5Sd5WfioPCl6Y
 Hq64DcVf24FjoeW2tufdgsEhNO4g2JRrofuduLPU6NBRL2C+K5vCJdUmyLcPywqnYSq3
 6nNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ7059MjyLzSRHeAnrSYS3/xKQl5oHT2hkD4vEnHLhm6zXZTBNT4cQUjOJGCkEyH/PEp92M8w=@lists.denx.de
X-Gm-Message-State: AOJu0YwMaapSM2nuAKk9G0kamwORiGxFdhWZowvJ8X77T2frERvJK6dy
 YxOEd1hOTLqQ7OkyqMFpanE7ScWcxesQnVZuQlGXkiOf6/MQ+IaH23BULSGOm20jK40fQ1QOPEY
 3BarCM81HVxMpuIhJeTuWlOAT7LwRoDzSug==
X-Gm-Gg: ATEYQzwlc372AtHAANDiShGzcEKuJLAPtmrp/8Nbww3n0ySuNEKT5qYGcCOudro047l
 sf/uojRe0k8o008Ch18fLPUNSRVfPqUim9krANZjDWM4IqHs+tsaSEMCmJ/tc4IswzePJcfKft+
 9ECabk5O7bZfIsY9r/yODruZVHlM7GLZE0eIIzHnpkoljzxhiogyKtK0IHWPmhbzhUlTmnrqg+Z
 1Spibt8Fay19ZR2JBomk7+TG/nmIHhEHZjwXNnlGd5og/ERxUlwOmCXWri/UCwrL8gr4ZTdTX28
 Um+KvXlqJjw31wyLoGR+B9L1HqgEhGIcWziH8LqFJqZNuZp9qlheAo3jSsQMDMV2WGtKl4A=
X-Received: by 2002:a05:6512:3091:b0:5a2:820a:382c with SMTP id
 2adb3069b0e04-5a285b61253mr3378287e87.26.1774186226297; Sun, 22 Mar 2026
 06:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
 <20260312095711.3219756-12-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-12-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:30:15 -0300
X-Gm-Features: AaiRm52bzylZb5psyhwGLlUkcxkbhkN8FgInOuwi7xEKDMAguKEc8IyWmeI5ZPQ
Message-ID: <CAOMZO5DDCA=hqa6K0pPXG-RFkp0Bp-CwVjq5NG0Y7ysYetA9uw@mail.gmail.com>
Subject: Re: [PATCH 11/13] board: tqma6: use common TQ mmc function
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
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

On Thu, Mar 12, 2026 at 7:10=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> use function from common TQ mmc
> select TQ_SDMMC option for MBa6

Please improve the commit message.
