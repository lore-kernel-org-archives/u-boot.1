Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D8CD1288
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 11:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F24987C60;
	Mon,  1 Apr 2024 13:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FVNNxdTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8251A88302; Mon,  1 Apr 2024 13:51:28 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7137D8799C
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 13:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29df844539bso1382829a91.1
 for <u-boot@lists.denx.de>; Mon, 01 Apr 2024 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711972285; x=1712577085; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zrLrr6GZqa6T4vhXKjO94HwLpGfKLDg4C+ymknwfys=;
 b=FVNNxdTs1UWx5JlC8CGAcpxjixl2s2pGOqGulj7tLDiY03sXY1ZkzwMYMFoND2TBWz
 Y7G3vTD2a6oaTV+qo+GjckLbfA1lmO5mSiqQWgmYHajJfzrwzDry6cUZDS/VVsifOAxr
 E8eQn811y5EWgzMtHJPmxQ8NAr7lFJ5Mh1Cd6psUqEdaJdPnh+IPgjkPcdU1Tu6Ga/X9
 Jg9iM95Io3kK8X0tTu3SKQcNJh3jfARbdEpuecVARVDU4Er+a41p9+0sSzP6U0ukkgHN
 LbpCqIivUMLqWw4AqebJv2I6NUR31J7uqGJzSopRtWVdoewJvRXEo4ONx2i8MO835xe1
 89dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711972285; x=1712577085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zrLrr6GZqa6T4vhXKjO94HwLpGfKLDg4C+ymknwfys=;
 b=qXsTvu2kDu/mBki0sU4b/zaflnSMBG2XjJ4ZWr/MdBo22CtF/IAStR1Yoh0nzAcp37
 wyKxtr3i2wNqWVpTWUNe8D4DA4t8EH/gt7Duw682Y0bnrI/xFhi6R4DiuVk3B1E/StB2
 SOVtPXmxNm1+yPaxJL4u93mZL3rNAyi5YjTKTfkaIcRFmDBBOABoEerHn6gikjn9MRbw
 UC+pDc4YwVtNMSw+4btHg3LyEp92Vty2YtrqmUo90cYSRUUGOtqmuKgHaZFkR3lsQfiu
 SVGLYbnqB5xDyt98syumB3zoTdYUK5ecaGF3JJzoi/yZ+jMo7q9TfKw61DKltG//zwRN
 kQLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJmDLj9cizKvJluNdlfqfz0tm2/JW19dPQWaE95vrwz7Gd/xX90l/AtuPkUYlVSTyyblgvzYd3tvcxsdqzVy/RMXZAyw==
X-Gm-Message-State: AOJu0YyLXHyXVFrCkW8RlDfzZTg7CAXusfyOPNwmB6SQyccnK97kyjT9
 TmLEasGpJbJQa64tQRgzCqmKW3qaQXLnbYB8DpIvSrA9ZZnO1oRJOIsn9ckhxPqk3D4OatbmK3J
 +f15le6Hb63nTfdPSi0NWe+ykuDI=
X-Google-Smtp-Source: AGHT+IEDaS4UyTZY1C4WzJRWz6DkvqUH1EQ4R7F6KZkzO1/ywbhsOPsKZBaJenckGpowC3GPvcqB68Ih+KO2UMJ3pgE=
X-Received: by 2002:a17:90b:1bc5:b0:2a2:e20:f9e2 with SMTP id
 oa5-20020a17090b1bc500b002a20e20f9e2mr8878683pjb.2.1711972284896; Mon, 01 Apr
 2024 04:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240330213555.2889619-1-festevam@gmail.com>
 <e2a4c7068920316b3d631f2db0880235@igalia.com>
In-Reply-To: <e2a4c7068920316b3d631f2db0880235@igalia.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 1 Apr 2024 08:51:15 -0300
Message-ID: <CAOMZO5BdTWYp_4OVGy0Bpfa8yrqQGt2N_EbFzYBsaiBN1Scaxw@mail.gmail.com>
Subject: Re: [PATCH v2] mx6cuboxi: Fix Ethernet after DT sync with Linux
To: Christian Gmeiner <cgmeiner@igalia.com>, trini@konsulko.com
Cc: baruch@tkos.co.il, josua@solid-run.com, u-boot@lists.denx.de
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

Hi Tom,

On Mon, Apr 1, 2024 at 7:13=E2=80=AFAM Christian Gmeiner <cgmeiner@igalia.c=
om> wrote:

> I am happy with the patch and love the idea to fix Ethernet for 2024.04.
>
> Tested-by: Christian Gmeiner <cgmeiner@igalia.com>

Could you please pick this one directly for 2024.04?

It fixes an Ethernet regression on mx6cuboxi.

Christian has tested it on i.MX6 Cuboxi and I tested it on i.MX6 Hummingboa=
rd.

Thanks
