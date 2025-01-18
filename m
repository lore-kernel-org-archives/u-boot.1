Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CADC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96CCB8063E;
	Sat, 18 Jan 2025 08:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PN1N1t1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77B9780657; Sat, 18 Jan 2025 08:22:33 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D7DE80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so472049066b.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 23:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737184951; x=1737789751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftf3AKI1gOXSjPDP4MhsGdFYttf1FlnZv/ywvWS62ZM=;
 b=PN1N1t1x12MtWeVxLRqLKOsApHg1yBY7jMwJLE6CC2TY6OI+y3PTMf5iqW67rn0JE/
 8FpgZZH1zETKag/lu6D/VBOFSCQGKGEd4DC3sDNTcRlhN7dlpX6Jv0OsDFSP6yN85ild
 78RceQc2N+ZDrF4CIYOb97TkT9ZmwGyV+CzhNJtAuPyiM+g6xiRDMTTXa0NMK2k2OdfJ
 53zYqlrqcsQMDuVY3bEY/tt6bvqVJqffAJVAS403VWtKtCHtnnd5q08UMEWGT2/oeE9g
 2DL+610lH3s79evy+XOgAptJYK/Irnjyw2TN45mXG2LSGJdobqo4+eUUdhxkyL9PWifb
 gs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737184951; x=1737789751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftf3AKI1gOXSjPDP4MhsGdFYttf1FlnZv/ywvWS62ZM=;
 b=lB7SgTi6PWH8RXlb6EPTpwNbTB9Opkk2iiLfMLLZva6TxG6ViEcH5kClNeVK7aB7Qf
 7C7tu0DrWauhFZ+JO4njwRHkxR5LcdJSmeFPNy5htkBsaQRQXp7C2+7FoCU7qU28G1V8
 ub8yFUi/oePQWo8jwuYwYGLD/zub0UVX3Z3F7rn/oSzHVmaexYBUgBKufLFC8JFTSzWQ
 YkZ0zHjUvFvoQHtfUupwwg7qLV9RoJ4TG73ysjDYNfW9DglPo7sMt4gw+QfNO8IEE9XX
 HH9EFOtqstc5m7GVodBvMbfoYaVoJbIhlhGO9aTWecfAnhEfnjhrsG8mRdzHDgIvC2rl
 2jCw==
X-Gm-Message-State: AOJu0YzYe+069YWjc8ZO8/iASKP3CXZ/lJcbpGsL/XGjVljoCnN3Dly0
 c0ZyyFiDaLOYePYHGZU/iyuCNYju+Dx8EOSRvYqaQYVDiQgsfbTB0ZEbTg==
X-Gm-Gg: ASbGnct5tzpuX9Yx5BvEpBPnVjAonRp2x7Eg9GnIhRnTb+Cm6bGWnKZRG731VLxum/h
 VtJ9QZZFA1Ss3FqpGswTlHInW3nWv4KSE4kFnuNll0eYhsV+0HKnCn5LMvYeHuAlb1oxWClO0xv
 +O0+x8fmXKKA5tQFaX/jQTsPHfxEQQzRVDLowku9chgaJK0wAotRSXRqkAiAwXFAfaUISSLefNu
 ljUSxNIHbMZbxT0sP9zuHfD6zjc98wyieKhf9DMlj7byLT2pYMEnDOxUNv42+Vi7L9ISpgDXMoB
 ecPUEdZvD7jgqc5cf2T8UKbe5Q==
X-Google-Smtp-Source: AGHT+IFztTGE5C4Momd3DiF/L3uaQXeq1f9jrSr3F3OTeRqTGvNNBN6uR1LyKIKGaqQcxDW0YsywzA==
X-Received: by 2002:a17:907:7296:b0:aab:75f1:e51a with SMTP id
 a640c23a62f3a-ab38b44e04emr557490266b.38.1737184950724; 
 Fri, 17 Jan 2025 23:22:30 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcd5e2sm293583466b.170.2025.01.17.23.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:22:29 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 3/8] sunxi: H616: DRAM: rename Kconfig parameters to be
 more generic
Date: Sat, 18 Jan 2025 08:22:28 +0100
Message-ID: <1908509.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20250117014537.22513-4-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-4-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne petek, 17. januar 2025 ob 02:45:32 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> The H616 DRAM controller requires some board specific parameters, which
> we declare in Kconfig, let each board specify in their defconfig, and
> then use in the DRAM init code.
>=20
> Other DRAM controllers now require a very similar, if not identical
> parameter set, with so far the same parameter names used.
>=20
> To help keep the Kconfig file at bay, rename the existing parameter
> names to drop the H616_ part in there, to make them more naturally
> reusable for other SoCs.
>=20
> No functional change, just a rename.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

That's very welcome change.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


