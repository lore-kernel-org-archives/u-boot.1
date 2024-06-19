Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5064EC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C4C08846D;
	Wed, 19 Jun 2024 23:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUcyoAeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8A6F88485; Wed, 19 Jun 2024 23:34:38 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BA78840F
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c2c1473f73so39604a91.3
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718832875; x=1719437675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJ3rd7vRjo0WUyvPL8DE3GwPkzQGAK/ezDRbHUtT3xE=;
 b=XUcyoAeF7B42+CrGmAGoL0FgKq+5ur8TxvCzzJTSy+ynunjF5tV698MddscAZzR7cH
 10G93LkQpw/B7+huB4O8S1p40bDavvVWlaXPY/40M/1dNicnqT+oXxU3vpiYYIJWj417
 L9d0s/A2bZveRJR9L9TLXOSbiC3tpBdsuLMaHoTsyvHCn4ZOmjXXN4KL70s2+o0hFn2c
 9rPW1+d0opNnisFs2jV1gH0gg8PKSeN/qRVZQKSSr4FDKLiqFSp7BABGQv37IC+dSfH0
 tvihjDxftbbfAqoguPAHBaV0ThDtecwX1y60CsaWom2/2n4Gft3sEDH8IvLwFxsvgmpG
 p/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718832875; x=1719437675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJ3rd7vRjo0WUyvPL8DE3GwPkzQGAK/ezDRbHUtT3xE=;
 b=AWItrKUWpsquWMxPfa/L3ERx9XXiFKWm/FazYy3NCF3483j/pVbuNfL0RKl++U3svg
 Lnf6Osoz3FxN+TAI0DptkDKUVV1xXWbNA3zPBNe0G8Cmuqoo1QS1W2mYsc2L77ebSJph
 LRmI17Qf+BT8RVoiEXnazik4zoVzRt6hQpIAMSUw18ClBvNrOK0/b92CCMdTj5LwhJUx
 yBkjpbZpuozbNjZ7bJy4oioXbL/IPhrLOx1qgXe8Fo6jTLz4zMzmezlyrYdWJaLwmJLd
 45XExHUnjgJAqIRoAUQnbc2P17Rx51UGASipe0v72HcSF+ziz7PTrEoyNY4eDWFXGKmb
 IiaA==
X-Gm-Message-State: AOJu0Yyvl+/HCAPi2VfIXlqgMpXBMqZag7G5jLSnfViWymJeUOrzZCeH
 smT7i1fQMvogJPUi85eMfqPnXNG/DmCGx05IWfahXRY346f39Rz2oI+EwLOj/BSAA/7ZWMvRcyN
 oPLp48BpbbF5IHMxAssCkxhatrec=
X-Google-Smtp-Source: AGHT+IGx4a7pgWveo8kJyKbbBtNVCHkxjzi2IQhPl9SEJUn25sFJjJWbNL1b97oRjI23rAZcuC5tZYSWx0xOFVj74No=
X-Received: by 2002:a17:90a:ca96:b0:2c2:c967:3e56 with SMTP id
 98e67ed59e1d1-2c7b5e659f6mr3588715a91.4.1718832874900; Wed, 19 Jun 2024
 14:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240619212731.2083570-1-tharvey@gateworks.com>
In-Reply-To: <20240619212731.2083570-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Jun 2024 18:34:22 -0300
Message-ID: <CAOMZO5B-V1B+KPhOaJqJT04hcTk8BB88JyM5HXvNDF8rjFbhfQ@mail.gmail.com>
Subject: Re: [PATCH] imx8mp-venice-gw74xx: fix USB host
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
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

Hi Tim,

On Wed, Jun 19, 2024 at 6:27=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Please write a commit message.
