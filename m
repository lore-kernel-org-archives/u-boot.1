Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E068CFF887E
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 17:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A055848D4;
	Wed, 29 Apr 2026 19:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V5qqEBQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC58848D2; Wed, 29 Apr 2026 19:15:21 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F434848D2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 19:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ba92146cc86so1496058966b.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777482919; cv=none;
 d=google.com; s=arc-20240605;
 b=W/7Er2R0LB0W5saLbPgkrhOcA3yg6i2rPEOeSs0tLn5yERVFA3VN1x6pkFQ0nPOF5S
 +qdCZjw1Z/QY0PAmdR9s8Jnh2RWyL5pfdsurUHmFEy9KfsZ7pW9uvsGUNlOSGJW/HbKR
 d5IlSDWRsfwGtUP4+E1tjsu8qwU7oyc29HBwZvztKFQYUILP7TPJ9CGRwOlfIGdRCMgj
 AEpU354S7P0PuHADpwp8qXTtBfJ5fKXW0fsHzaFNETsJr6r7QDPo+ghe4BJS18QpnzWn
 3lZgaLZoF/MsXKG9JM30SAJBQsJZ2EoN+yG3O2k4dFSDzTTo3Fyfo/7dTBEqaT9At5bL
 DSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TEBIF/xVvRNGMJCY9jswVYQD5ht+XuD2YEhbyCa7xwU=;
 fh=+/pNFDyGYsDJMoXpsFeigOK5l3QyGzKdfAevrQne9bY=;
 b=Fp83KRuqlRY33cXR2MyeSNgTaO+XVGhSufBxxdXLuD3O0HtP/XXjddjWK92fsQG1CC
 ZAb+0bdgXNxW7zkbLVX3DXkg31mI4PlpE7mvwuSoj9XOvhElgC3wpzRsJYJpPDnww7n3
 UdpBpxz59IHH+YwGS4YTh1CZyB/7OGM1o+YnBWKc3xBcVUyFT1gu+QNPf250VGMpvWOs
 I4fWQLuXwbwWfPC67F0UOYAAtitjYzm0yg+/4UN8MyAOTdLhpZsV0HE7OrJ58kH+xD38
 31ihN/P3zFQotOf0JZ0yDWCSOY2+erMTsDwg52/NRRHSvk1W4UxBPQbe/LOMvpCOa0WN
 kZQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777482919; x=1778087719; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TEBIF/xVvRNGMJCY9jswVYQD5ht+XuD2YEhbyCa7xwU=;
 b=V5qqEBQ66RIqzrfTo58SmrBGJ8AOnUxQxrtvpA1VBVGrzc5GhEn3bhJz+0TkYWrL1B
 Wi0LI8xNe+EVE8necWrpYMBp21R4IKdz/fTIOXONffkq/GJXpQEAcWm7UTbrhj3wJWR/
 2UgEx36cmdyecyNmZRJl32tBQJ07Nn32DpQmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482919; x=1778087719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEBIF/xVvRNGMJCY9jswVYQD5ht+XuD2YEhbyCa7xwU=;
 b=iVjusWLTvJMGSEIg4A0S3z7BLnKQ/IPeyh5zwF0R/8wJ5vWaD+pb6oEBlxZxKTzL4b
 kGSG0L+XsLfplI92VqDYrleoouxjDEraCoi8TfEVK/hE8K/ciLN24KJTy+r2ddFhcRjK
 tl/cay0p1BCiQPVEaCYW2RzE0Vxj+Vmz0cl9CIUqCQk4WAql/Sw8hpplBgfvDXlqC0da
 bXeAk7hDC+Kdh0euoga+aSIti2lZETaJfltqPIrbS1E289yn4oOHUfRVADOKR30x5SWi
 CnvbL8fESv3oFh4e/6GlyQs3TbgjgLnKZfmHK3E25wQvBbSip5P1ucz8YiqNQuyhmAtQ
 udRw==
X-Gm-Message-State: AOJu0YyeYJDsO5+RO9BKM+5joWgX5ehjbUaFCoCh9yE+0ScsvYCxbhaB
 Lckc7nf/aKvOZq9flTiliefUqtm+aoG/FSZk/IaeyH1WUtTi70tWfA+8MqKt122gO1TGOZeI2oC
 pSScl1tqqrDrXKrs6XUXECBSN9TGmZ//gz3GglqJI
X-Gm-Gg: AeBDievHcOQgsG6unfkoFVPOiR7Kp1KTmkUg78piNAfCCLLlv3cJgfJsAgZsoOYgdAf
 nqKUFZ7XQAkSQa8z1W746w6340SgEA2RW74NN0Wi26f4HtUS2nUcEEIrgBI7tG44o5h7qzVpLra
 8gY8bZK2BaWApxFTcschq0wrp/WPyC1CDd2CaeYl0VAbpCgmGbWiH7UNo4ds/DNemNuhW9zJJiB
 ENRkcejbj3DF1IwB20W4rC9WzDzT1FX2YFsj4equJ0/Xw/QAV59KDKNEdoAoAgl93aXIgIb5Uqe
 nhSPF6Db7FB5MMosabLvc9JI7f+egFWXK1mZgX+nhnOGInN2XKq+
X-Received: by 2002:a17:907:d20b:b0:ba7:9885:b56e with SMTP id
 a640c23a62f3a-bb801bce354mr538568766b.20.1777482918719; Wed, 29 Apr 2026
 10:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
 <20260429-sys_rx_eth_buffer-no-net-v1-3-396ef37ae93c@cherry.de>
In-Reply-To: <20260429-sys_rx_eth_buffer-no-net-v1-3-396ef37ae93c@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 05:15:02 +1200
X-Gm-Features: AVHnY4IGQux3BFtl9fzJ0CtLCoNi3YQ7HX2YxqADaNfjtpavE_CWr7xB62TBw-Q
Message-ID: <CAFLszTgOim8dYpdGZprB6uft3krLiHYiRfyuBFb9_Q_yEyd_0w@mail.gmail.com>
Subject: Re: [PATCH RFC next 3/5] net: tsec: make tsec_private a private
 structure
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tang Yuantian <andy.tang@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-04-29T10:35:00, Quentin Schulz <foss+uboot@0leil.net> wrote:
> net: tsec: make tsec_private a private structure
>
> Move the definition of tsec_private within the only file that makes use
> of it.
>
> This adds the benefit of include/tsec.h not referencing PKTBUFSRX (which
> is set to CONFIG_SYS_RX_ETH_BUFFER, which we're trying to move to be
> under CONFIG_NET dependency) anymore. Considering drivers/net/tsec.c is
> only built if CONFIG_NET=y, this is fine.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> drivers/net/tsec.c | 17 +++++++++++++++++
>  include/tsec.h     | 17 -----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
