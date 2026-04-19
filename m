Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED83EA71A1
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 19:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73099842B7;
	Sun, 19 Apr 2026 21:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SQRoetLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C79B98425F; Sun, 19 Apr 2026 21:56:37 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30CE82BF2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3870778358aso16372571fa.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 12:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776628595; cv=none;
 d=google.com; s=arc-20240605;
 b=kGmzFuAzPEaqOKAO1G5+yWkFxY4g+SyElghHAfPYzSNpf2ejdMYQ4M7erMednTciUV
 ImfAcOsxXcBSrKWktEk9dmbqLKNQnMELxUVdb8h8ZwHzQuWvT/uA0RtZeEjT8c1E2MoP
 ZEYuko9cVu/C4Tm7+qlibHg9vg5EOot7jHTl8A8dn4c7UOK3tNHx9a0UeR5IUgOWPgSB
 omsqk2OxvZp3vw8+0NKwonZiU6sgNhC7nzzh0Pj6cBgQJPQhibyFT6i2bs3syTfmVJRh
 bWMy/gPQ4s70KdchrQI6boSdlZbhByylYvgA4TfulM86bJ4d8zQ7OM1rseoS+rrHDrZ7
 2rAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sOn1p9T6/7pcOhB9eyC+3Npdc7SyjrfFq2+CKdS8m0o=;
 fh=qRD5Tdohu4EAqvgpjtyyYI4XNOUpaDHsBt5+7uf3RGs=;
 b=OhV+DQdEMylgn+0sqO3KSiFV7Ifap6KnvjhiQkWkV5Bdbhay9Wyaipr3yAwbR9tljx
 vc4b/R3OyljdgIEW3juQFbRPodcO0tzvHseNrWtQ6rM5ThxgDNif2uMtasM4oLHxhlwD
 GK2hJhGn/FKp9IAj8tmPcWlfXYZtrJt0v3KxJIvqBhZCHXHZ6jZWIdvbUM/hx8xjDUuF
 2iMBRM86iJhf5KJezwECRp61BaqZ0vuNd5XMWjCrvcR1V24XhGbd/ziQB1zw8XqkjMMu
 oHvVFQF2v4WODFvzGOD/hiliusxJxAZ15sqnuAloqnulrRa0gIjxhVoWHs7Z8fn3BLQe
 3kVw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776628595; x=1777233395; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOn1p9T6/7pcOhB9eyC+3Npdc7SyjrfFq2+CKdS8m0o=;
 b=SQRoetLTM9AxRODtVLQyDvIfOKAqSSgI8hfvsugQZTM7jzz9ZBSemEwujblcl4y7aV
 /2MnrnI0A7MXxMyb1+KxsclFsMCUv51Qqfb2AwzjDd5pxaCkNapURzzCzFc2A78mogUp
 18LFFK/ZWWXswLxc+0XTsLRPtbNv663okCKH2YzmbwlN8ppvSdUJYdFRj45mDe6V1qXu
 EGEyqz6MXOZDqoD66S/eU4FZGmgesOyhC8oxSQGNtW4O1mSTuf5c4uQVwyehd68OYWRn
 GHuEYCv5kXVN8k8phW0TUo1PdO22J6zpTM/UNBaqeJDGfOEBf+hzSSDqpN7UBNWDWH5J
 sFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776628595; x=1777233395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sOn1p9T6/7pcOhB9eyC+3Npdc7SyjrfFq2+CKdS8m0o=;
 b=ae0bX+U56WqQ4IFGSORVDd4OdVWZ1BulSRqTpykV9OIDKaxdRfc2f7qo9MgQg/gxCK
 rcrmIQgg5lRgh9Y9CULjLrZ+mre4FEMZAbLj1JPZRMz4lPF8FN0eB8YTaoldSAkKNxpO
 mrUYto0SrQy0fVUdtLUKtXAHy5Csc27VP3Q6i3gr2Jr/l8ek3VPs9JJkJSlsTXP7ck3v
 Hq1cfvYYonHIvxduu57w+WWRSWLDA8kVnHE1dstLdBCbY3fi8MitHHXAdLzYVTcz6P34
 sVr/JS+q7xeOrQh0+2PxKiQ6PRtjbHIHznKQlP3cjRh6lNK+odxMVWbolks54zlxLLrO
 5YbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ87CNHGCzbnPtUr/Qm03jFVx9T17NEwiQJxqH5D1xZp+92AM9Q6O1hFhnY9ZN98WyJXAE9BghE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2LDuIlohpwpE2SuLwoEFz0Dbr92ql2WMQ5fddotPr8cH5jyb6
 nNZ+nzfLfVk2FQrW1lfRE4wJhdy4l2oItBRmmOfHZDm5IJtDfZfJapYCB3g2879HsBqhGt1n8wT
 YZF2ZFpA0o3gXyj17SnnsXV7PydoTpEo=
X-Gm-Gg: AeBDietDiChOwhH9Hu3AbwhLy69YGzzKKDezFyksjdGViPNAfrQi1wHNEbpJrbH940k
 AeBMYYmOL1o/uyIAIGlfPCDgmrkkb2pbryQIAimXWwBGwOOU48+r0xbpszaIgRUBBqTK8lV18it
 GBg7ehfLKIP6F1PQkxFNZqZnq8Pssdqnkw5aPl2gFhQWtsPx7kWyLr2y8LzqxscZpPFDdjX4aFS
 eex6We7D+UuJfHrbknJSqGwdCAXmet7q3G+3KL+AJImPXPaSZB7rGGrhKuf2HLZIotmGV9EQzYn
 J00q371K7QNn92mbnXP0Ap/WOm7EyKlZYkeY3lBDncn6ZP0wC646tMPfegUFC8GzO8/VRfYKryP
 PDrUYeAFUUrhKk/qM
X-Received: by 2002:a2e:8e88:0:b0:38c:9503:ebfa with SMTP id
 38308e7fff4ca-38ec7840a87mr21218351fa.14.1776628594841; Sun, 19 Apr 2026
 12:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
 <20260407130654.778838-6-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260407130654.778838-6-Alexander.Feilke@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 19 Apr 2026 16:56:23 -0300
X-Gm-Features: AQROBzCxCcqVt4VUV3ozox9VD-QA-9CZwprjEMm8hqEQRntTPUfQjr2XVnNTW9I
Message-ID: <CAOMZO5AEzBptEzN_mvS+CDhEe7051ZuPLK9kQN5Ty8nuibNL-g@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] arch: arm: dts: tqma7x: add boot phase properties
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
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

On Tue, Apr 7, 2026 at 10:07=E2=80=AFAM Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
>
> From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> Revert this commit once the upstream linux device trees are
> synchronized.

Can you add the link to the upstream submission?
