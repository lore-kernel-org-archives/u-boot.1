Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED92606A686
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TTKdw7kL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC6WD1Au
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01FE18115D;
	Thu, 26 Nov 2026 13:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RjycNWmxB6P1; Thu, 26 Nov 2026 13:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4F95881159
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698103;
	b=brVeX+nzPr60AziC8NyzwrXm0smjNzclB1ld5q36u9jg+eQT+k1fKFatR4Ocie2zgitq
	 Q2d5Vb59kAwIjkVF/nxw7UcgP1ZnV2cd1yI1n5TlfnssUIDZnES4zJLEyHyFXpH36psoS
	 mObxDqEbuWVNidZ9Ot+7245oZQSkpOI3p8Ud66E2CC0rh7/LV1/YW3YUSS38uB8aUzYFK
	 ZmaP8nFhgVhevFTjF5bSpPxRBVSdVdjrdUqZG3x80H6ZjU9I5F/uZy4JNoOVDu2ZjerCL
	 g7RB00j/5oIlzx6CNZ5FTM21TDjLjMzWTIdz4K2nf2Jq6k9mQiauS3szAXSkPjmdJzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=broIc/ixGeppZhrK3sUNaGAhPLI0kh6zFPW6Oij4X+E=;
	b=V5cb2f6Yd1hEys4TLbFnaQETmit0e2ElB9spchITAuZUp+/wcQ8ng3qFVcODBZuV1noT
	 zxNKe8P44IwQKt6PvKo1UjB5lLO+3sSv6S/MftFA/iz9A0xJxbcw5c1ixTGt8SYVtrDyu
	 ZLXGV3+zD66XGKbfewA0wWvE3/0VGvmKE2zqlKS1orQPZR1X3YbEjIiKEOyHDx3FDTshE
	 dv7qzPX9X8M/dm9vyF1sNqh823EN+e9ODO6tO4QCqrUFdgQOvQYe8sEZHcDqp7N6uH8Gl
	 i0CW0CPAO3X0QDAs9fBLpckZ4M+bdeO1/A+HbVnDrBKsTj3ycw9+kXqQXt2ctXINbwg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698103;
	bh=broIc/ixGeppZhrK3sUNaGAhPLI0kh6zFPW6Oij4X+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TTKdw7kLY2nfkBxP2cpkVdiYl2cz+e7sTkGSEuLOhal0o6HkTCpwTk43CAfykQaLM
	 55++sL73YcGLHWmCfAMC3sZt5Fv8NcbZ4SLnhQegYVnfqIAFgPSb7GvChS5CCnaEiC
	 nVZ+4i8mLTydbDoPIuI4rtXyD7DfARZeBgireXC7EZQp7JfP/9t+0nxkCChNPxPKw7
	 RQdZZC9IlhNkohUVbzuUD7L4vISRD60FEduNriLjzIkjNnNwPybLvaVMzHpL9i5AXB
	 Z8psBt0H4RymOTn4r6efe9sh0EDZGJ+eKOQbJByx6gqaKLHuvikTYfxCA0atfR5xj7
	 9vpJz07EnZPbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F95881159;
	Thu, 26 Nov 2026 13:01:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AEBE325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 809A6404E5
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AWPYTtXLJFcZ for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:01:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE339404DC
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NC6WD1Au
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE339404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:01:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 55A9E46567
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ABA1F00ACF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795698101;
 bh=broIc/ixGeppZhrK3sUNaGAhPLI0kh6zFPW6Oij4X+E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=NC6WD1AuLyPb6yjtmih4SAlfRL0odHD5mDgBojFJd21dvrugLsu+Si7cz/LUtpATh
 bmHkuXEjSSrsmsEdQbkfHbOXpBwTCHujqWvK+2/4uYurXN/HLAcm7kBI1h/J/9aVl8
 5xK1Qj3bl9PrAXEA0iCHQQv3ROOFBdYzGP6RiPcWrmMaFDY8v16a3hy+2uiVCvNQSx
 XD8S1pRGqgNt3IY4dGOd/cNrHeAOziHwMSje9OnkJ0tFZuhhqxV2u9BbqVotphHfRR
 s7jZrq+cauyp7PPD3RJ2/ECR0T+DTARDK9gypgQOOSbGg+QuKO/W4cr3s2gkTN7kSC
 kIHX3/YgauGsQ==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5c1479a959aso5266968e87.2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 05:01:40 -0800 (PST)
X-Gm-Message-State: APuU4Z/uZxeJIaNhhLOWoaLI9zSY8w8lBpOozMM/RbN3Yta7HQkdTPAC
 XGkdNglFVhYkVJLVPq5kuB1TOfCkIf06itGw1DT9uQrsGulfzVhasUXLm9p0fSmyZrQrkKx4soY
 UVucZhRownyO1hxin4KxDdOjc34KEf+k=
X-Received: by 2002:a05:6512:3f0a:b0:5bf:dc07:3c10 with SMTP id
 2adb3069b0e04-5c1bc7bc316mr6221108e87.19.1795698099539; Thu, 26 Nov 2026
 05:01:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-6-9e3b28c77cda@bootlin.com>
In-Reply-To: <20261123-sl2619_base-v2-6-9e3b28c77cda@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 14:01:26 +0100
X-Gmail-Original-Message-ID: <CAD++jLmAwPAKSqsR05UqY8q+0Ln=+95eTtTkYbOWRrGFb2c3nQ@mail.gmail.com>
X-Gm-Features: Aa3M54pY_LMBaSiOyuVnZih8T79aB4mx1Engw4ncDRrY1WXiWqkbGqNdi5Eje8w
Message-ID: <CAD++jLmAwPAKSqsR05UqY8q+0Ln=+95eTtTkYbOWRrGFb2c3nQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] pinctrl: synaptics: Add sl2610 SoC family pinctrl
 driver
To: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Michal Simek <michal.simek@amd.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Chris Packham <judge.packham@gmail.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@nabladev.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 3:23=E2=80=AFPM Richard Genoud (Synaptics)
<richard.genoud@bootlin.com> wrote:

> Add support for Synaptics SL2610 SoCs family pin controller.

Why does it seem to be two competing series floating for the same
SoC? Could you and Jisheng coordinate yourselves.

> It uses Generic Pinctrl framework and is compatible with the Linux
> driver (same device tree).
> Pin muxing and pin configuration are supported.

Send the pinctrl changes separately so I can merge them, unless
there are build-time dependencies to other patches.

Yours,
Linus Walleij
