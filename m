Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47183CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 05:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F33E484671;
	Wed, 27 May 2026 07:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lbJ1P1Qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F372C846AA; Wed, 27 May 2026 07:47:46 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09EC084671
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 07:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-672645dbfeaso13992500a12.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779860864; cv=none;
 d=google.com; s=arc-20240605;
 b=AzvSTJe5Ur6Tx0+olpMdRfU6jq5+ep/xwubNnHB6JHow9pDarAeDU54lh0nUf/0piv
 t8aLqQOPeNkpRm2Qlyyq5Y8AEwq7OW0B+Ih8Q0cqtq2xWhlNlZknGahKonSmL1k9VWFm
 jJswOG+tIJbvQjEE4WI87Cye6qd8Eq67kugDvBTQUVV+k33J0WY8sa4fbYxMqIKbzzgo
 6prw/5S/P0vdZT9gUrMCisLeFJFbInLrEmRhQlrVuCRisHLA9kkFMBRwUOY0dBeBsr3Y
 COBbJSoy3RlEzVnI/gvos4Un2Q2jjCd3ElEqXwqugvDtH8350tSIhCL9QflEERbypTD0
 rneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VCUNxb5ae3kNwYezc5haipG6dgxDMH3kxsFwBMHLwoE=;
 fh=Cb0YQ0EekVXKCCxXa2R1eOGkLQcpoKEjYog33+JaIFI=;
 b=gtutMrlO/ezO0U0J7Ib98/lB7eHu854bigZlSeDCP8yy/S/1w7YUZghZudi0indOJD
 puS2hkQEPmYw5f0WvHG3/ooFk8ujZQdWcZVYQsn1EZidnGzB8IND2eNlCYPXGt4yI6fm
 fxKEAFXgzrndzGGpoRoOHD0VcEhg3YZt0QbFRqhxWCXStaDkBZ9mNPADykWmObTCK5iP
 Tfci3kSkoZhqLCI3u11glzjm8qW2OFBEzEPvNOGjIacf+wJsJ1h6O7jz8WmaBbUluWQI
 7oXl5paKRnWg6Nqw+3iR9FCHgUp+ua2qUlsMgbSvJ+LBw+IGH1lP9/AKq9zEoQn4nu2j
 yfKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779860864; x=1780465664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VCUNxb5ae3kNwYezc5haipG6dgxDMH3kxsFwBMHLwoE=;
 b=lbJ1P1QosZWIl3HqGm0995MEZqCX+gCZM1ntmXOKpi89hk8biSSXH+r365B+0ZKncJ
 AW8ePZrE+VYD9Yf6nKam7r6WdmCMMZSRloNFH2wzfMADDElIeoIeaMnEf7Lcdl2nuOLi
 j4bDYN7r8+1EBDFG4ySEgFVdnkNuDccrEYYsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779860864; x=1780465664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCUNxb5ae3kNwYezc5haipG6dgxDMH3kxsFwBMHLwoE=;
 b=JRQDPcxF21T5xXERnSlNyqhOSYj7uVXNSTcQBK4D0ODsxWdaVZIxMdQxo+Om4HbQ7Z
 wOjvxkrdv2WtQzmrV+bhHuHsQgw3xxKy1j+482Y0q2M4X8Z0a6qGqKFpH5Ho27qZE/4N
 i8z97ZBRSXxkLIVvoq5/sRZ7o7EZtzn7EzwF+iQKuWRbByT7cIITGWRuMoJklZjDjnx3
 CGAL0fOcpCb2iOpZ+7KtbsfWZ97xsjU+rnrh+fjvIVywDF2+VKeNjptzdbvdxVV65Xwi
 cYkdEW53+NPuOBclh6boK956BE0YfUqTA9Jqy1LwhIRrwleRb6ocrrsHg0PhjWsjhMRt
 tVPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wpZeGp954E6QuAoKMP2+EZ1Eil1CcSKJqmpaX25rO33PWQhNq3LaFbq5pNJyHXhq8zB4Cy6Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyOypMX7b6E6nCm2Hj3K8Lq4i6DUOy1SJtct9u71+xmvtDqo+zX
 6xU0k5W6oeJVR76m4JsElCwaWy/iyxOw3ohnvVgQAk1XQ6fqy+okhMVUEYs/D8iWHM6ftccCeQ6
 DlVgQQDydF+Nuqwv6ABN4+kLlFDVHi+acKJoEZnRm
X-Gm-Gg: Acq92OFQGBKBNjB++ZZJfk2MYalhfuydrYcBBKy0L5f4pfRXddL/d1mc5CcRRZGZoR0
 3/oST03c7V7dew78ChiyvC9+ij9EU+Gu2sIFf04cgqWYXVGcbUxX8e373KZpGl3qYtwH7wUeVgj
 gx+UN8BGUYc6C5JAa0c+HhikWFpBdTF7jAJIjnHu9qvkiesWxYem2SiZeRsFOB7G+vU2zHVmDt9
 1zoRjgAfwHVc+f7/7YCmhXHXBAuDqufp/dDSVzo91BtXUZW+sKC2C4C/WpVwdb229ETpyY101mW
 eapNZfqQA/E4/VF/
X-Received: by 2002:a17:907:8997:b0:bbf:74d7:1c4a with SMTP id
 a640c23a62f3a-bdd27fb3622mr1191886866b.40.1779860864424; Tue, 26 May 2026
 22:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
 <20260527-devfdt-spi-v1-1-37db1f6c168a@nxp.com>
In-Reply-To: <20260527-devfdt-spi-v1-1-37db1f6c168a@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 May 2026 00:47:16 -0500
X-Gm-Features: AVHnY4KgMo8rFo6qETv4FaqgxZbWz51EoOf1f8wXZe2DTcPXtW3YdTSERSHvJBE
Message-ID: <CAFLszTjumbHMhxivD3-iQOS-g7E3nqdf7dugGRphzJPJ5hDp2g@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: spi-aspeed-smc: Use dev_read_addr_index_ptr()
To: peng.fan@oss.nxp.com
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 "Noah.Shen" <noah.shen@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
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

On 2026-05-27T02:35:23, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> spi: spi-aspeed-smc: Use dev_read_addr_index_ptr()
>
> Use dev_read_addr_index_ptr() and dev_read_addr_size_index_ptr() which
> support both live device tree and flat DT backends, avoiding direct
> dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/spi/spi-aspeed-smc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
