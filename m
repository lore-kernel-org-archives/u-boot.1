Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64756C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E0587BB1;
	Thu, 14 Dec 2023 19:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bOWDRsrL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BCB187B22; Thu, 14 Dec 2023 19:27:23 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4773087B6C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dbcc9d4b1aeso2336382276.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702578439; x=1703183239;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJoBlFOdKEdFagdg8uhmI/7aFiMtsLsZo9YRL+RlGmw=;
 b=bOWDRsrLitt5Qo1SwR9kX/edYpBgRFZt36bf+JbYRPtOPu3YOuk1KB4NtiLOQoF/15
 30Vv+JqSD8hTDBzSF/SPQa2taXQazNd/pZi4SPZBqeyRSmuAs5nGY/PcETLEpcsAJ29K
 3DsAGwfqWwaeOgoeRV3ffT5QXu0Zf5OyyBnBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702578439; x=1703183239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJoBlFOdKEdFagdg8uhmI/7aFiMtsLsZo9YRL+RlGmw=;
 b=K0SWWs6uSCHkiaP874+mEmrDOIzpdH1dpXDjpJMfSKSotpacFw/MX0H3q+xcgPWsxA
 ASlN0eDcjiZ5xO/6DoVrLPYt7Bdt3pbpM3anVO4E4y6VVpFJ0rkm8h+2d5IRVZOd1Hea
 fGtb4gwzc0idkJ1s8mOeYAX3NWW4sJFxO5gfcLYS/nNfw7gW6bcYRPiaMBuCwhEutnp9
 y7WSZpkmSy+D+cV7VdvFRkbXoSgzZNTyWSZTey8+xPzPi8v+Y96/mUxWppvIjsX94mJr
 p4N7tCaLYEUPt2P7rLO0N8hk3Ey6yjajU3ND0OXgCNfzXsDDniO7DfsZCdjloyjotal4
 uM4Q==
X-Gm-Message-State: AOJu0YyEY6ldZg2qhVQCk1qZTWMbr3Ezn+sGBk9kxv5JxHcQbZwICNU1
 XxPKXsVwTUC7gnxoj/ACbwUfxw+CJylfsAf3mWJpFvrTLEQh8jzlkVk=
X-Google-Smtp-Source: AGHT+IEB9dEMsLUF9xd7atc2v10zW73W67mhdJC8dzb5IK1tgC3SqyLt4OVMmOU9DGc6fI1WVOzY98JA9W92WXZ72po=
X-Received: by 2002:a25:abe1:0:b0:dbc:ec97:d7dd with SMTP id
 v88-20020a25abe1000000b00dbcec97d7ddmr700401ybi.97.1702578438960; Thu, 14 Dec
 2023 10:27:18 -0800 (PST)
MIME-Version: 1.0
References: <856ada64-ba6e-4f32-bbf5-23030df85238@siemens.com>
In-Reply-To: <856ada64-ba6e-4f32-bbf5-23030df85238@siemens.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 23:57:07 +0530
Message-ID: <CAMty3ZCnNLX1m8q8yQ3knAhfeiHH6uOUyY1_ykA5kKmoVj4P9w@mail.gmail.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix error message on stuck busy
 state
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Stefan Roese <sr@denx.de>
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

On Mon, Oct 30, 2023 at 9:50=E2=80=AFPM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> We are not iterating CQSPI_REG_RETRY, we are waiting 'timeout' ms, since
> day 1.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Applied to u-boot-spi/master
