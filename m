Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579BBE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D5B806FB;
	Mon, 23 Dec 2024 14:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RSR9HoWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF26880713; Mon, 23 Dec 2024 14:21:20 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016B5806D4
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5401c52000fso4344575e87.2
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 05:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734960078; x=1735564878; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oCzXX9chQFcwa57YDr7SB1oxdi5hzLAOog2qfT99tI=;
 b=RSR9HoWIPCdy+p5H/Nw8eZ8fZ/Ey8FbS7dHd7YH3dbujEfvDtIgvHS02KrKS+MS3jb
 6rO7WNFisD7eXY8CbQ59Ka8oxy/LCRJkHmITv6C7rl7LZkWjconnN386bh7y4Rq9R75a
 19GlO2NkXGe+oQaKUoISbNFMbJelZ6fwWidTnnSppar9tR1jXG7xdnr5PM/OTrNOgk2t
 katgUoLMS0OHSft6jZFQWQk/88ao02T+g1doQXWjvNSvO8nEQPb/h9sC2od4XKg/EWQx
 5yDIcMATtpA9W4qyoIz+Imtw2F+oLK0l1Yf7K9JEmHkQxvO5B6w/Gf+nhTnwDHuS1f+7
 CCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734960078; x=1735564878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4oCzXX9chQFcwa57YDr7SB1oxdi5hzLAOog2qfT99tI=;
 b=JlXz4ockL36u0sHYluIlKk28OH21+gWrWGgAl3GXnQKYj1tmwvKV3DvdWuSxpEHGIK
 bdtyFGw04h6aeS+vwFbyf2DzVJpNigidnLIdmbjvQW9NDKqX9V1EzAGzk4B4hfAMcxNM
 PXcgwTdR7KFnHtfJu3gbYzwRUeB7WOw4etF76cTf6QlhK4+Wm6FXFLlagtd2ZxDgyuNx
 0AmTv3OCkLNFtPX04zZCQPGOdpWRyu7Xq1Vhoqq9dyRxyvp67Lp+IV6OpBaEPMZNUKnK
 J4e9qykOzSqN2YSAx79KSZoUJ7I49q0HpK2RS3vxVfi2LPRuETEOJxXzNrs8xUb2aFwH
 274Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT3Ol266p5jC6EmMhrPijb5gtTxmSm51jYPYrktnJePBU5PDkDxMwdf9HFYY2xV1X7hPf0ObA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6/OSSVxA7zaEsCQsNnGXzrnwMU2MnF98VpE14ID3VrCESZNXU
 WBxlLqwvPJf3gG5R6zdgS3+i35b8LMm+5+tRstYUCKN+8zVeu/mLynpVNL9vSSc8efV1P78H9A4
 cGKBo96J1dMaqRDG3I06Iiy4Cmq4=
X-Gm-Gg: ASbGncvm24DKRwJLaJAIwGL2hpMRk/1Pe/byu4VBJBqxZ17Wukheweu+7ZxHwGLCHcx
 1hlkzDpkG1LMtrXDgieeXZiHxy1iezJMVxsJFljU7YXMLJR4aLTF5wa+hJGGDKon6ou7I
X-Google-Smtp-Source: AGHT+IGUyKCp/sA5ZTsJtXT75YPzAUv5NeSIn1a406QL3xsAxMtbPoVF9XPdiKjtabf7SMiidE0hqRAyR1Zqho80ccI=
X-Received: by 2002:a05:6512:1241:b0:53f:f074:801c with SMTP id
 2adb3069b0e04-5422958eaaemr4499626e87.41.1734960078134; Mon, 23 Dec 2024
 05:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20241218212035.1892970-1-tharvey@gateworks.com>
In-Reply-To: <20241218212035.1892970-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Dec 2024 10:21:07 -0300
Message-ID: <CAOMZO5B5NwH4nD9ct5tEczMpC144yCZu8038cDxh4uOF-g4t3g@mail.gmail.com>
Subject: Re: [PATCH v2] arm: dts: imx8mp-venice-gw7*xx: fix TPM reset
To: Tim Harvey <tharvey@gateworks.com>
Cc: Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

On Wed, Dec 18, 2024 at 6:20=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> With an IMX8MP based SOM the SPI RST is gpio4_9 instead of gpio1_11.
> Fix this.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx/next, thanks.
