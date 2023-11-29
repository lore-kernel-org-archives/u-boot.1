Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBDBC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD769877BC;
	Wed, 29 Nov 2023 19:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EVGA7NEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9D9A877C4; Wed, 29 Nov 2023 19:23:26 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADF9877B3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cde1c40ed3so6975b3a.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701282203; x=1701887003; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IJmdDyT2/HGzK52pT0PFzGWMnOWC2JjSGm7G1bGqBU=;
 b=EVGA7NEffzM/W4JG5nsDtzqD8mUPWiJWl3NrqwF39Ruq0uEBBhtsiAf4yeOtA4EqlM
 dnB3zO6WwuhkFMYSB2emeFGTF79IrRccuv6+w4Pi5blS4Hy+v69rta5CxgR8SvtExpZJ
 TwPaxkHiRUTnzCeZ6cqU/KrM4rZF8lCF9OtUoLhj2yxk0AmVKsBKMX+aEqdLWzp6dDx1
 jsEm6p0ZnkSO+9ggmUwjBnFJna/7rK2qEHxNvzlc2WkG0G0tPqO0W+3P50GPTOA0kjJT
 V9lrSVHu7zlIDtC78wOwsOYw/9S47XJJ643bF+QXdd7hKBXOZE6CXu/uNAcd1PzsftmL
 6vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282203; x=1701887003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4IJmdDyT2/HGzK52pT0PFzGWMnOWC2JjSGm7G1bGqBU=;
 b=WQTIKXImUDiRCtn/qCbHljQtPEKAueHOazvwCunaSSUXd9nmjXTUa1nutq9QAKxNft
 k1+os/tB3CEH1/d0uPhS8Z93MBOURGkkvZAAUMatwihAayyQjGgxNp2oYGfRTMW4K0Z9
 fnjIhvwak81fs5pA4z+ssB6ABTh71Xmd4m/waIk9eYq5kB36SWucBvF7nWHwffJDjClw
 xg+OIUDolT80uWA8SMJV+Fzoh2s1zxHSeApF/tEqpLLhrvq9jYbnBSsFVKcuO2AuWXdi
 bAIljXDHc+pW/oMsm3V8tv8Cxpfa42YqhfVMLWQ89ya1O1F6qMjIrrlpB3eypQYieTOX
 IxPQ==
X-Gm-Message-State: AOJu0YxouT1XPGtfmYTM6InBLkWId3wiq+KIU9pJPbADxdRu6iqSWdvc
 DTIZHkc86k1ky8JT06Z0upYD5wcefmy3/uc7SOo=
X-Google-Smtp-Source: AGHT+IETx6K30dhVoUsA3xvYSxjcr0d9LqbonaMX7vrb3IiAR4EUOzjlTFVWdjjC/oIo8SRyFqQfYoFft33uAvSrPG4=
X-Received: by 2002:a05:6a21:7896:b0:188:67f:ff2c with SMTP id
 bf22-20020a056a21789600b00188067fff2cmr26073257pzc.0.1701282203017; Wed, 29
 Nov 2023 10:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20231127193723.685180-1-tharvey@gateworks.com>
In-Reply-To: <20231127193723.685180-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:23:12 -0300
Message-ID: <CAOMZO5DvOYgyCor+85V38bErtWtQmRD6YhatpBaRVYoTibm6=Q@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mp-venice-gw72xx: add TPM device
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Mon, Nov 27, 2023 at 4:37=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add the TPM device found on the GW72xx revision F PCB.
>
> This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
