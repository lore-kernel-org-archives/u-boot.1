Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019E7C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 11:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A28833E8;
	Tue,  8 Apr 2025 13:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="EijbogOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 821E5833E9; Tue,  8 Apr 2025 13:12:32 +0200 (CEST)
Received: from mail.per1cycle.org (unknown [IPv6:2a01:4f8:c013:8d4e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35B338312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 13:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4EFFA3F79C; Tue,  8 Apr 2025 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1744110749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mcj9bcwhMHo0PIDbcY8NRYrmQRmine84XmUrRY3XK28=;
 b=EijbogOTFg6X+vDNU4dyl7ii8mi3Uvy6XmP7VfN4qZyDWAjiR/+EV32QI5yLSIwgGjfv8Q
 SzSIM7bqUjf2h5Req8iMG2llGwdTVuIXvECTv7NXEQS2YW0+zPyEbDjtbUEwQ505gUGGpb
 dnUqhgTZ4K+7ptZ9hEu79d8x0S56hSKD3jGNGh3dCNzlFaHjdJbu+ijLH6G5uytzrjJNm5
 5SJOqYwkvZ+yI8H1mAj/hCvWYXq3SiFK/y/GhLIf/KVLukamFzxXyIyIju/zB2w2aPZLij
 YN+a8LXWlNyofMhFxvv0mG1PVR5K9AmShkBixg285juyKPFj5zw5bXUBHnsXtw==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 1/2] riscv: dts: k1: add pinctrl property in dts.
From: pericycle <me@per1cycle.org>
In-Reply-To: <Z_T9-JsRTe-HsWuD@swlinux02>
Date: Tue, 8 Apr 2025 19:12:07 +0800
Cc: u-boot <u-boot@lists.denx.de>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <76D9AD47-C7CD-4D52-8602-8F3F8D61A9AF@per1cycle.org>
References: <20250329-pinctrl-k1-v1-0-3083d7057989@per1cycle.org>
 <20250329-pinctrl-k1-v1-1-3083d7057989@per1cycle.org>
 <Z_T9-JsRTe-HsWuD@swlinux02>
To: Leo Liang <ycliang@andestech.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-Last-TLS-Session-Version: TLSv1.2
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



> On Apr 8, 2025, at 6:44=E2=80=AFPM, Leo Liang <ycliang@andestech.com> =
wrote:
>=20
> On Sat, Mar 29, 2025 at 08:47:59PM +0800, Huan Zhou wrote:
>> Add pinctrl node in device tree and update
>> in bananapi f3 dts.
>>=20
>> Signed-off-by: Huan Zhou <me@per1cycle.org>
>> ---
>> arch/riscv/dts/k1-bananapi-f3.dts |  3 +++
>> arch/riscv/dts/k1-pinctrl.dtsi    | 19 +++++++++++++++++++
>> arch/riscv/dts/k1.dtsi            |  8 +++++++-
>> 3 files changed, 29 insertions(+), 1 deletion(-)
>=20
> Hi Huan,
>=20
> I could take this patch for now.
> Would you consider using OF_UPSTREAM?
>=20
Ok, I=E2=80=99ll update in next version.
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

