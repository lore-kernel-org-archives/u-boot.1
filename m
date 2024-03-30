Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08B5C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48EA5882BC;
	Sat, 30 Mar 2024 20:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="drzM2ZL9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06926882B6; Sat, 30 Mar 2024 20:47:06 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E93882C1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29f66c9ffa5so733558a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828018; x=1712432818; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUqS0WsCLZIx2Sc8dg1+U7SjZLDOIgzbKToX64MRndM=;
 b=drzM2ZL9a8iJ94wm5kKoFsbMxgZcA2WNsolymqqUHvS5kd4TW1pf424SGne3y9mrAJ
 PDNAj87q5i0rtHQ4I+tPVOKMDeS/UqwX7oeAxs3qrH5g7i0zbU9ksjKc0whiGsGMhwe/
 KWhEzCpDfiF01tOalgUxLphWrTiDd9lpwAv8RVO/RwJIB0STKo+iagmriQ3SQ2nfJrDn
 YkfHEKsWJEiHqTcJmSiz9htdBIrspvqdXdd0eUNAoi3hgRp0TXnlab9qBotWCWKbYUcF
 /XDtaN5Mb1EUX60yRvMUcicIqm39XCE9gIxIOOmtjLegG4WjMnLlGz10CcBCKDZTFmki
 nr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828018; x=1712432818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUqS0WsCLZIx2Sc8dg1+U7SjZLDOIgzbKToX64MRndM=;
 b=q3/cGKMktqRxS9zdyp/GZaUS+FEy83Y4LG6OJYIb9ZcnIcKPGzdqsCyRP4Bd/mzCQl
 PwfQ0Q2y6fVALlArIamzIzQL331i4vZXJbLx8GI+hZfADrF6310Ozw5pIYf1wTGem3Ut
 /TsEz6y2b5ZNuYI0dTKnzfrhWtK7RTWBF6X8ZHkx+k3aP1Ka8uqeBRbVRa/QCqfpYF/u
 pkz4zPjsfqVBzOtDaGoSM9X1VeHCiYTt+Q6sihERRQ+qTUxIonzvHlZkMORS+VfY4u6Y
 KCGCkZPoUb98oVL/IQ0LN5FXMmUJCral7H6DSFCaNmWQlzUxO1rAQVgMS//dzUjTEe7y
 J3Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBPREufLN0EsQF0ITCpBF4XJieeP27C0tJIxe9uC8loX4bbMrEm1TQ8fuOtMIx+FRoKxHfNV8NkKehwpTfOLzSEss0Fg==
X-Gm-Message-State: AOJu0YwFDnPugpNI9scRKhh3c6fnXF+4oH5AbVa1rQsKx5uSW9blH35t
 q4ALgMr8q3HK67wHf2UGlgiGRYhm0t0B87OfCCW/X0rEY0yHgffJhy+cpx1k/mm/bcrPpfmyMqM
 x/+ezXKILzc6wmF8DHvkOTOgeAjc=
X-Google-Smtp-Source: AGHT+IHm3JOok4w6KA5AvMfJtEhO1hmGMLojdN2tJXcHxxy10LO8EE6kI4encuFSSbVHWbCIti4lOTdzTdZEsHjndII=
X-Received: by 2002:a17:90a:f0ce:b0:2a2:2ee9:beb8 with SMTP id
 fa14-20020a17090af0ce00b002a22ee9beb8mr1160859pjb.4.1711828018580; Sat, 30
 Mar 2024 12:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240326121949.1915850-1-festevam@gmail.com>
In-Reply-To: <20240326121949.1915850-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:46:48 -0300
Message-ID: <CAOMZO5DErtSDWzrktBfBLKbsWPeeAC7miHfJH4cTupLvFLMGhg@mail.gmail.com>
Subject: Re: [PATCH] imx8: Add a default reset_cpu() implementation
To: festevam@gmail.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, hiago.franco@toradex.com, 
 Fabio Estevam <festevam@denx.de>
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

On Tue, Mar 26, 2024 at 9:19=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Add a weak default reset_cpu() implementation just like
> it is done on arch/arm/mach-imx/cpu.c.
>
> This allows the removal of the empty reset_cpu() in several
> board files.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot-imx/next, thanks.
