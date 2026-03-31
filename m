Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333EE10F92F8
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 19:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953EE83E7A;
	Tue, 31 Mar 2026 21:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TjIpVCY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B69B8403D; Tue, 31 Mar 2026 21:46:36 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2010E83AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 21:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66ba9898ae8so366931a12.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986393; cv=none;
 d=google.com; s=arc-20240605;
 b=dCU09JSjTkTK6n0Lpl2OHwdz+hDUwMgu67psiw83D8l5PMjVLm9akkIWTHecj2RM6L
 FgrUlUfq4AhpYF4TbeG5Z/DY609aCEMZYUubx/yR670fi8BjQzpivrim2bSk421C8Vaq
 7bCGIMwUNtwGXtUj0ep8ze10fNX3Mq1RhK3M6ok2K+IQjmve4btfaHQvvArJBQ2ONPsw
 0V3mDdykC57DZOWAlaVCTT9VSfqLtU3cTgBRa4DUuocoV2hVpqFOolzRqCPsg8Qd8U8V
 z3JZeJEFNGbss4UlIGuKELEW7eoT1LP9BydHEVFvyVWsYAZMA12Hec00wbw7apUrsB1M
 ee2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q5F2UiFBxNRm6cEjPsh+QWMnuKUXruF7fgXwn4/0n9I=;
 fh=ufwLZ+14vKizi6t1RvKP2qWt/3LRJv1PcKHKgx1eoOQ=;
 b=CRsDjkPBis8HR5dB2F63S3D1lRlp0o4zpdeUMKC5JKgfJZkL7HqZ+fwiRdwU8/RjHi
 SrmkHvi42/SseJto02RKyzyDHkI9eHYsjbFf2fVFfW9CES5dfweFNYAb3isOM+ifPzZl
 To8+EhR4n3JL3LZB8BBKk7NM7FfLwtt70W+2y0Z69oY2MUDZkM8TXACssye/+XNKqn4b
 cSR2CeKv+YjVrUrnCqWEqOPBhxOhwbY7cdOgUDtrjcM7bbAQ/u4VBngqF/QjG66CtlS/
 NdslIW8E8lzwMyklGSyHFk62ogWSfI6NYNXxjTmlmao4gVprziYxBMdmao65gNZeEOzX
 MTUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774986393; x=1775591193; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q5F2UiFBxNRm6cEjPsh+QWMnuKUXruF7fgXwn4/0n9I=;
 b=TjIpVCY6uBM0JWoy2cIsjYf7r9PLsw3TABGAsKH79afxHQFEiYB13k7TOphoqdjajC
 nXCazefTCA9WxDIm7kme+kjCQWTOuK//xQLtj8/F9T1PfFKoY01ADzl+unSvdHfNXupm
 URUJdbSQ3Qk/rpgzQVaniU9NWHKBArtmeVv8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774986393; x=1775591193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q5F2UiFBxNRm6cEjPsh+QWMnuKUXruF7fgXwn4/0n9I=;
 b=Fo1jAz9x9UVhYNlMXm7f4hHty3+SjnQdysY6kaWF86yw0tJOefOA1Ef1KTBtX0m/pl
 zzr6TmjOFrhsQ4Eyke2+RwFP0ung74e9fQEEZvHsreedTNOTRVOgJJAigoIqITfAw88z
 i4dsB39N3zcNc6hCemREyxY4bAe4sZ/ialozn9ODe5DWpuGZfhB0P2ptvj5gxbl4YYqh
 4zaVy4qZUdGdSYU5Mh7mZMCd13oZMkARPq8Ha8fdveMmzVEzEp+EyDcYVVVBvv0lWvTo
 EUWwzxBXDEYU3t2GaPxw68WkLrc5M9opcRESwVHLdCgbiKrcx/Mb+pTBPiXxE9aFGdqu
 /sdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVstiM6pMJk8KvI/hZ5okrjdgokwN/CauQ6dgwNVx5pf2IOYiP+HKComouVTu0pzjPiujA1j7M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz08BwXqKX21zfehGUwJURCRJ0t7/ejp0OtO9gT7TVLSY94H2Q2
 2/qIjOJBSmX42CDb+PDoo7NIohiMFsOq2gmxLgXmAcTW+MArp6V4pwym9h93vwbU98PoLww92X/
 U9eMkYjTZqdgJGR6hN8tH73GLsQUb1uaSp2JPWoj/
X-Gm-Gg: ATEYQzx/YUTnaKPRH9e2Yk0KS7ej2qLH3rfxizhypcVjEPCIBdp6sqwu7kA2qjdeIs2
 CGik0hSZPsRCFzQItyh8GQw5XttSOB9mlJbvNQrJiS9HAgGE6HQH9OjznuygInRBhWyM3HYE/SQ
 C2aQJ3GkYbjy7X8JYs//KWH0aht/fgi206UyHia14DrCi4238Kcv2iO1+E0S63W1KE1pmwY9IAI
 THFEIsjeZcZZf7wNwqD/BAeNFjW6zqr8CWtcgr8UNSJ7v70Cp64igmH4wUZvriTmu5SsObcCfiY
 xzXSlg==
X-Received: by 2002:a17:907:26c8:b0:b9b:ee93:dcb with SMTP id
 a640c23a62f3a-b9c155a5f22mr37258966b.2.1774986393385; Tue, 31 Mar 2026
 12:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-5-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260330171419.1117817-5-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 15:46:21 -0400
X-Gm-Features: AQROBzB8VQahVHjuQC7IyVu7tUr6uIpkMwgJ5gsFMi12lYsdoHtHFp4m3XQANPo
Message-ID: <CAFLszTitbMqESJjyXE20pabFawoN5=PBQUph32rL6qHFiO-HNw@mail.gmail.com>
Subject: Re: [v3,4/7] dts: qcs615-ride-u-boot.dtsi: Add reboot-mode support
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com, 
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com, 
 mkorpershoek@kernel.org, hs@nabladev.com, marek.vasut+renesas@mailbox.org, 
 msp@baylibre.com, dinesh.maniyam@altera.com, peng.fan@nxp.com, 
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, 
 jamie.gibbons@microchip.com, justin@tidylabs.net, xypron.glpk@gmx.de, 
 n-francis@ti.com, h-vm@ti.com, ycliang@andestech.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

Hi Aswin,

On 2026-03-30T17:14:12, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:

> diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> @@ -11,4 +11,30 @@
> +             reboot_reason: reboot-reason@8f {
> +                     reg = <0x8f 0x1>;
> +                     bits = <0x01 0x07>;

Please can you use decimal for the 'bits' property values, i.e. 'bits
= <1 7>'. That seems to be what others do, e.g. ipq5424.dtsi,
pmk8350.dtsi

Regards,
Simon
