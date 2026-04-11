Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41661F3ED4D
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 328E58421E;
	Sat, 11 Apr 2026 15:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IhfDY0Pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B988416F; Sat, 11 Apr 2026 15:18:44 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F2284118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66e6d960ff5so4158085a12.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775913522; cv=none;
 d=google.com; s=arc-20240605;
 b=Vno+6S/W2Svp12QCXY81zfo3DXttpMSU/DctaJNY865Mcr2Qpm7oHLVgrksq8YdtlC
 e9IFThO/hI08b5JeAX4UD6K2g4A5I1O5/ow312TwbYkm4Xw2AcWrqvM3g+dtYo6P50yy
 13O5D9ZnfcdLlDLsmcW/6LVPcPhLaTBi/ZNPhl211TSpPkpg5gybI+i+Z9vyrMhU8McJ
 QsertZMFYquNV1uzXC6OEaxUN3i84H/P16S9UpDtYASXulmpEOtyl5bFJioIFnejGV4C
 Tjpfkws0p346l9X0mhmawa/bPJfLs/RdGMzegeJWCHb8ZBzIqUAxPwLZjwHnhIgQI6ex
 i6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=82u6YcC9cgA/1gDruo4+zGrBSPHNn/ZZg3HzcOFY9hY=;
 fh=+QrQlqVEvLS8QHXSWOsJf6DHZdRaRcPxyFQVzygYJuc=;
 b=fP6tFp3Z7PjakWxbBf/6tnzXeKo7H5QC+Q6gd+Zww9itiKCdjskWONTVekKy7xC6wC
 S45xwVxWKBbhZGQ6hwpNSwi2NGMmj0mUqg+2MYsVjMT/8GOz8MXUkU3COrGWD42BWJ7Q
 XdVzv8XAqh3Qzl3cGTzcMd7oB4q5TIdOmI0sI2vcQnozo9Td8l8s9SgX6mFexxpDU+eL
 bE53zeWVyqtY6rgzX28hYzOMwJz7XZiCJvOUqc4LUEMp/qOd5RzlRf5wSDPA2zewftU6
 N/SMtOsJXn4fMnCEnLXpnmRhvxrmFIc0adBmvgNt+hCveqqEWIQ5FhznalSQWl5qI2tq
 fpGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775913522; x=1776518322; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=82u6YcC9cgA/1gDruo4+zGrBSPHNn/ZZg3HzcOFY9hY=;
 b=IhfDY0PnDv+g0ptukCs1hDobXnaa8YZ+jNCfyozwAR2PWOnEjX0xyjoPoV1IXGXG+X
 Hr9CDZWUOAv9q2EMgpxOee4G6zpcHmNAbjPykExkRZE51T+vL93ziy0jwf2c/wwK5GsL
 gXWeJfsiFkarAJ9nNzzKKJLyM8h9uaUrGi8DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775913522; x=1776518322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82u6YcC9cgA/1gDruo4+zGrBSPHNn/ZZg3HzcOFY9hY=;
 b=a8MfMyPtibRf3v5swLoj8mdhtvaQOfCp7JKHPhPJ/krMNSCmnS4tiMeKjBhfqn5Ci/
 77mGG3NeNb641snPovB01kbtHDutu5f92GjcfLwcB4o+hBR+et2Xy+I1ZvsIENfKyX9a
 6TNxF4cxiMz6Cg6aSTIgDBX7oe5jPHoxcXIfrqYESsOiABVkTWtxvuCZzFh1F0bhlBFm
 zg5ar4yVHbuNaOHfBuExExssdILsCM4zj83VN6OaOGufMGYXYHW2zqSrGbhENSyjT4vu
 VdQN8uorHpbMF1a+BSX1LsaweWWZPkjdpDsdx6Gd6UIf/rjtucmX6M+5Q8mePFNW32Tu
 79RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs0hxm1WzBu3nv6FHmLl+/WXZHzH7l4MiUXb/9hyiLXcPcPubOwf2JswT2QW82vQuN91HEEQ4=@lists.denx.de
X-Gm-Message-State: AOJu0YxTs43CcUKNnLGg/2quzUyyCbMXuW5DnBmM2noh1+uXDat3/O1o
 h1OdPQS0si22Jm/x4O0oKkoNvPeHWd1RE/2YCZ6Jtj43Vj+XI0hMOSn4jLSvq4ES7MRqKZ1gXsM
 Gnq7IIja1iCa93exts17YqnLnTU0RpUE2/8mke5kA
X-Gm-Gg: AeBDiet2N6gANtibsQYIXdwlUrNZu5xdxvzjOm3G/VswsWO9YYnRVNGb4fh3bUEShkK
 rImXY5WOusq9q/uDdaVyhsUam9QWj9MefL2wMc/RnW/LLslwUdg9jVjv2T4MWYCDiEUufcAAqb+
 WD6cxSm0P/dkTPUclu2QzhwplfnYa9Tr28PSr+3+e673/D13/c5cG5YIVnEkS3VoE2Dd0KQ8Y3H
 1e2uPY88jiBvQet668Llf18+fljHxByyHuybEIXo/ppG7Jii7xYrfNENa0ioy4amj9zE/Kw3Qte
 ic4o2w==
X-Received: by 2002:a17:907:9615:b0:b9c:6178:6a77 with SMTP id
 a640c23a62f3a-b9d7297e1f6mr355073366b.25.1775913522200; Sat, 11 Apr 2026
 06:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-2-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260410091154.1001021-2-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:18:28 -0600
X-Gm-Features: AQROBzBeQgMCAXNGUdH0pwV9fdcKVMgYkrFMJu3z9pXHX491I4QMLnswf8JbbKY
Message-ID: <CAFLszTjTtGrGQsoGOXPi39AExpRAYFvKhhh5HSg3yzdxLd+Y1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dts: ipq5210-rdp504-u-boot: add override dtsi
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:25:15 +0200
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

On 2026-04-10T09:11:45, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> dts: ipq5210-rdp504-u-boot: add override dtsi
>
> * Add initial support for the IPQ5210 MMC based RDP platforms.
> * Define memory layout statically.
> * Mark the nodes that would be needed for SPL.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
