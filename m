Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E50FF60D5
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 19:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8F283E7A;
	Tue, 31 Mar 2026 21:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dQv7REMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3607C83AA9; Tue, 31 Mar 2026 21:52:49 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DC384035
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 21:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so1028491166b.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986767; cv=none;
 d=google.com; s=arc-20240605;
 b=ejURJRdM4ryzFBe1g/fr9ISiZoVaq451qQPqWg1Fb1JGrDi77o4xn3WLUFB/Oq6kcu
 Kc+LzY4IAd7aMMuFxnpLGqe6ODDYRa1BN8ESVosPPFyRf8lh/xwllYVYcSJ3P5t35gMf
 r2FF+iHAGZc2cYmsac5oZ10ZZaBVPzVJR+A6ok+3BUPQjwCLXyyY57AJ/sNg1YJXk9XL
 be+1AgGZEivrD4RrbI8OTLKzD0xwtoaQeQpwxmXrrjVrZ1U3mu8rmRr0LI/1gekWVTQu
 w9+EK3vAqXkxol72qXYMB6ecAsyQ1ztrVj9KB68CrESik9hbwgzwYMmxADOWEHvGW4Xw
 0vCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vOhtdpeSH19EkAmSB5iP/fXvQWVKR0iGYNTVjOWVbTs=;
 fh=qAasFF1fszSSxrY2exrybPtC2RZfNp0tKheKIadHXho=;
 b=jE7nYDUKLGkv70gsMTVmse1FwVWS7hHQrrNCngSNz6ND91H52wgrDc0oRR4u8Y9LV0
 yBK5Mp0ZY8ekLkwtlba4Pb0pNYLEcwSx6ANpj/FSIPiYkqm5pI9ZTQeupjUaD++2dtIc
 rPkiq4WTG28AhmmGeW0gGXsuop1DoFWellbcpkbM6/bXa2usDjNPQAHrz5T5RS4Hfyui
 KHunRsBXNsNa5E7QT5fGfTBtSEO2b1rZfOmYGLNm3mrGu6kfJLpALT1YU4bS4cnc8pR0
 KUURLRFRkuVICB6gkliI08bRgRITT/HzWMccszob3Qr2KdTrxljO1ZpP8Jjurk/LK8pl
 qA/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774986767; x=1775591567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vOhtdpeSH19EkAmSB5iP/fXvQWVKR0iGYNTVjOWVbTs=;
 b=dQv7REMMexRjNJQs3jFUlODemvUE3RUtjOTFQcb7vtyOYz5RNU7qxMGT5WSFndyFzN
 0XoBXRki8hNRLJI6GxaJ1WfDzmzwqM2DBIfu/Xn+gqcGd3643Km9oQqvKDLByE2nzNIz
 MczLt3yS1vqXEBtEKK+64rE9BtPRRbPtWzdNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774986767; x=1775591567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOhtdpeSH19EkAmSB5iP/fXvQWVKR0iGYNTVjOWVbTs=;
 b=Yd8Az1dyNFHWUvEENwnl94QvvIaRXEUETY10CYbm/wYuu756tqfoM879TNlYK8HC4u
 OP2ifr9VvdbdgRRBJz0dxGTE1i/u66amFm/gUmJy4AgJdwGv2x8y6sgUZcQG2vnlOyHf
 CSBBWmyox8Uf/vsCtl9t4kMx2+UUWlb3OIFry3ycmW4cTaB8+Qx/9zGuGP6LU4QkfGpo
 cQXpCRUGNZK0qOOXQQUi2S+GJiRVUvvqUWI6bZK16vJTgr5OCfmxcB5xtgwbTGadRqti
 1TJZWBwmhVcxe/NhCiBsECPPQgcowJqokXmHKp0fcajn53QxKYNmZnbI2oSzJCGc5zVa
 EMcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+aeNwpdOwpGMmLOTuBzm6cvYVn5o/ZtmHkynqqV3y8g8t5tX3OL1I/wAm/dwEnxr218zlAU4=@lists.denx.de
X-Gm-Message-State: AOJu0YzGU8GZX1PJHXlU+rFv3XR2GKP37Sl7UK3niJPiRB6kNJBj4/Tk
 RMv+P+djYq2wl9tRooovoIDsa38TOabCmLLrjF4Czbz4mb/746uJNVBFIsvjGX1ojTs1AXK4Wd4
 hnG48TBnO+etqBi73PnzkhV8vJK8otuSnmY3ozPtw
X-Gm-Gg: ATEYQzy4evnYWFFjCAmbBDwHDMZ4HGw3qNeBBJqyk7vYNXzr2q7azMhBMvc0KR4Zmks
 HDXOgR9RL3qXSpsZmxzVNkd3hh5QJiNj8dgzRIRV5D1TlMnCOFVRFJTn94rYIEfYlTKp1DhF3UE
 QUPHm+6p57KvtzfUkZ6kw027BPyEni2djCSH6U0D0h9NRAi/0GPyShmzFj8C+5WUQZ5s8838FgC
 QKCaRRhsFU+Z7WBzWohTE5Z310bxQo6simzT0rQCwrzNqW7uNHlBAJj9iGUVRcxan7DLRn1JwgO
 ekBDCkdsZNkfklle
X-Received: by 2002:a17:907:3f82:b0:b97:e4a9:baa4 with SMTP id
 a640c23a62f3a-b9c133b2d68mr67382066b.0.1774986766684; Tue, 31 Mar 2026
 12:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-8-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260330171419.1117817-8-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 15:52:33 -0400
X-Gm-Features: AQROBzB3F8tWjMa_jZ4LzWkrw1D0kyWijzvfzujr11vV4YRgY7AM2opl8NRtcV0
Message-ID: <CAFLszTi5oj8KsY-QS0o+u=CDa=h1uiKrUV8WcJ5-s+jiVnAM6w@mail.gmail.com>
Subject: Re: [v3,
 7/7] misc: update API documentation for bit field support in NVMEM
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
[..]
> diff --git a/include/nvmem.h b/include/nvmem.h
> @@ -47,9 +47,19 @@ struct udevice;
> + * - Requires @size == sizeof(u32) and @cell->size <= 4

How about '@cell->size <= sizeof(u32)', rather than mixing the
symbolic form and the magic number 4.

Regards,
Simon
