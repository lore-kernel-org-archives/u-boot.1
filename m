Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5308EEA71B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B6380433;
	Mon, 20 Apr 2026 03:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GFUW7Ucr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 824FB83B99; Mon, 20 Apr 2026 03:18:11 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943C480087
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so448362866b.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 18:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776647889; cv=none;
 d=google.com; s=arc-20240605;
 b=SIOCopb1M/IDihRSAFhV5hSPb5mIldtYXTYgQaqOqSzxE6j650iZa5haVlRSkLe+45
 2i8Fz8OeWQoozE8hA1Pd30SgHpz8/j2uBPWeBH+5OsDDSPTiokLLfEqqYNa9AAK4Dumo
 iZHdrVsWBQnLunxTWHRy2SXRuYaoj8qeCsNYmoKbDRvD7vmsTvLdb36j2QeJJfuCVqR9
 JIefq9FmMU8d7hOPIdaT1jZrMP83cBnKnL+YvDetIa3absI/8DXl/xjMi9lwq7hcX9A1
 dv5EAU1jTsOVT6LNcwxRoPsLWAhDVZJd5PuO+7bvXSltpn5oHYVKsnXnXrLmvWV6djoH
 h4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hC0UVkbef+qqs/ky7EqHlA1ApiJNE5oSnlg2XjnNdGA=;
 fh=S8xjaNhDK5zkqclbPZi4D14oajyF+NpuR2kRzRAZ3EE=;
 b=HVP3ctAWxWyGXS/UyzK7klyUWWQ15MNqM7ISefc+nzx8eQi8nCQ27yQSJMfwj0is3Y
 EoduDcfjkhi9Oga5I+KNGkmsSmjtpRYLDIeUCs7idmh6sJ9vJcrJYC//GdPXx/TcV5AD
 JEcPGW6G+Z+F1UN/24Md8MkjMWFHFgQ9tfLNAQQv2TcohU5LC7iF7iKR+xHbkZfMLsxi
 NIgq2cEpIf87n1iIyVzwW5BqTg+uY5cIO13f3vPCUP3h1zKFhYz9rNt9Wxf/mKIwUnuP
 +ImNvNDX1Li69akwqTLW5LmdyVXJcdL2gE76PL5qpTgY8co3ceI1aFppa/u7Zqv51Gzs
 JPaQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776647889; x=1777252689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hC0UVkbef+qqs/ky7EqHlA1ApiJNE5oSnlg2XjnNdGA=;
 b=GFUW7Ucr+d4ZeL/uWhBccYC1Pj700eYiwdgJlZR0dekRV2B1s6wb6tmUbIelL1hzej
 NxSM8F+GSgjZwAJFpv4VqyzYvIpxcKaLVNAxADoiHjipSONZz3PdYTws+FYaCII+MJ68
 FYqFXSopAKR1xXN7dKuLtSVkc3jS0w6sc+k48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776647889; x=1777252689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hC0UVkbef+qqs/ky7EqHlA1ApiJNE5oSnlg2XjnNdGA=;
 b=jzM8qE/I0FeB1syvEhvXXj2qePLW4rmLQxM2MKRrbjGj6rXjNjEW8vmI6Ea/3RL5XB
 QgPosRvdTt9USXuVAPkRETp5USfBdRB2JtDHEmi49Q7sxli3FBhosEd17kJ2FNSwUzjF
 759qmMcuHL4NX0xfhNZ0nPxQRzJItnvFI54chqxcpfZ4eehYyuGBSxmeiCHBfRGrAIjR
 4Vs2WZ75XDm8kUBbIj/XAAZLwYq0x/d0kiA8xFxgwxp6ES/wAOVd1vknNHYE7jIIfdYW
 NeA9pWZSHu+jzfRDvnkC5rdkqk7rTyGCbWSwISZBxsnwuxo0zD6W87OBC6moOrtc1AN5
 6Plg==
X-Gm-Message-State: AOJu0YzFLcdO1mo99h/ER7xCUWlkxAFi9K3zP2ob+wwMvWsCrljlTUbH
 e/fYHyxvbkT3W2PnzwpVw4Ek96hYbTlx/rzegkbyAmbIWFEMrLbgK7NCkegYq++Vipj0KemEIHV
 hj1YHTcfnvJpAVGMzxyaFNJLBsgVqEnuaXO7h62eo
X-Gm-Gg: AeBDiev6CqkmOSf6Y45kJbPFj5l3hgGQTNuC+EFOr9nHgjM3wLfMJSLNW9s52aTCXOI
 EIxxqdsgY+kFHMyERXGsWLKzOM+BJwdmxdYm19PvougbBQdpyRRmUGBa22HtWN/jWZUYBG4EiNs
 /qc38kwveorAxKuICW/rxU0PAoz6Bxtl/r7REeP+rJB1/d/jbWy0KJ1vPo35al983Kwqyqf/Kov
 tWPkUn1QbkS6zzmz+ddh4iBRZrVQ8ddOgDGrFT7gJiGuELzJJnQp2Y5R97c2nzgmFtgKBKiWXRd
 IWMkq4KJl40eCPRHTJcE
X-Received: by 2002:a17:907:a68a:b0:b9c:1a5:acb4 with SMTP id
 a640c23a62f3a-ba41ac02272mr515489766b.45.1776647889036; Sun, 19 Apr 2026
 18:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
 <20260419-type-v3-1-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-1-ec49acd6870e@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 13:17:53 +1200
X-Gm-Features: AQROBzB0vC20FiYmhD9-NyNFYCc5f8G0SuavZwymek9_nuS0W1GPLG1D1TEe9AA
Message-ID: <CAFLszTgqYxSFZunDAed0t3-zxW+mUnmDQ5VpJ2hfzFjJ1hvvag@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] disk: Add partition lookup by type GUID
 functionality
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michael Walle <mwalle@kernel.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>
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

Hi Balaji,

On 2026-04-19T10:24:02, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> disk: Add partition lookup by type GUID functionality
>
> Introduce part_get_info_by_type_guid() function to enable partition
> lookup using partition type GUID. This complements the existing UUID
> lookup functionality and provides more flexible partition discovery
> mechanisms.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
>  include/part.h | 21 +++++++++++++++++++++
>  2 files changed, 58 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
