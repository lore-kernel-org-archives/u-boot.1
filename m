Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107C0CD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E0583EF9;
	Mon, 11 May 2026 20:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O94E6n9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE605803C6; Mon, 11 May 2026 20:10:53 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F412A803C6
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so2514000a12.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778523051; cv=none;
 d=google.com; s=arc-20240605;
 b=jhHqr4meFTwJM629KXl9c8bSIxGURVOiDC11Ac8rYAbvrJXj8jJTNue51GKvQe16pI
 vyGhYmkjbBg0nKlhTrfnfAUbBmJZCIG3iGa/oUj9aP5L8AJiINRkQ88+6WJ8/uw8+b34
 jagPOQSivw8h6POMeYcpNGZDgFMSRBTr6ScFzp8hHBXIfAnN96Fhg/6ESKKLLqY8GiMW
 2HDI03Fu147zzpB21nzmd5q2eJBMd7kLg0Ger4SDNuCRSR8z/aE9z96GTW/H9p6JCUut
 Ys8K49/OWXz6o/amYgoinmop5uIx8n8VDpXSiherdbBbIcj46nESKq9phqCh7GfdXODb
 /n8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bir/10CjvK1WoDyjif5HvpMP6EHUtuJMQO3Ogw5rCNA=;
 fh=7+NugGQ2fjuifNFbboBIeXRgPjkONDOweWugJxHsSfY=;
 b=eJnX2EtVpirzBER0lVceRr0QIuQpijUSL/fxpUwjpsC9qmyd/32hHHcEZyv9tZ1UJ4
 tqgYTvuWOFwlSldXRfxKpgSrUFKMKPdI/eRDLdPrVGBzk4J59J/ZUFnqMHrscyivIREM
 2SmX/jEScYTpKCy0Agf626O37KBRPCM1sIXVNrDFoI5CHPGZmqlXO5TNIW71wH08XdL+
 MZGolwTo6xONuPveZbJ0ctbh+/Zo6ranDxeRrVThw5Yd91xMdItVv3uRl3hAeiMtKkBg
 UeYZlzW/cHNNAnmPWvinSsZPc40weCXXCCCagjqVolHrnx7VaYLXPp3App1pOpkhfYAC
 iaVw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778523051; x=1779127851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bir/10CjvK1WoDyjif5HvpMP6EHUtuJMQO3Ogw5rCNA=;
 b=O94E6n9WfnFD/vTd6a66fXf1y/8jf4CfMWwqj0l49htsq4neiJfLfBCNdpxc/ssTyR
 Tr1TYQ2Rlam2i+6jIbe43fJg3rS57XooUsEyHrubLqPFV5lkxRP8vQ0dzy+GT34Rqiec
 HsBZCNuCxnUjbfCwwJJs4XQ3yVt14iD8ZU9lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523051; x=1779127851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bir/10CjvK1WoDyjif5HvpMP6EHUtuJMQO3Ogw5rCNA=;
 b=Q6XP2Uqk+9HBWo00QpFKLY7E8rxzFjivelB46wD5gyRgiCtzPakumcrZIp/py0SF5l
 A/Sv+A9bq6fPbOqHZHoF6sMm/PR5lk4AsoIZLrueZFWTicxR64E9rdS2Sqg0+eB2tfaj
 RoXF21n/LQ62KPhH0P7mFGig1XPawO3GWO9icMHvLY2Onn482lRX9VcNH6aXqwbEXjEk
 SdssuIfQt/DSeWp3MRopBxPWezw20B0PoRda6r7LOZzSyzEyIPdqWae3YN2n2PFFZA77
 LuiGj/MlTRVLNLZloi+fOckKX23UipO/6a+GuxoSat+7ENuKUVGQUqelYg+Hvm2mSuY9
 nXKQ==
X-Gm-Message-State: AOJu0YwxD5Dy9LzmrRg+HLfw38DntGcugyX/iIo0ct9RxXZJhV/SrS1n
 RU8j73jaDwDYrmn92lLxh63iwRTbqE+5HBgmHFOubee5g6u2fJb1E/GR9DVIKBGSK1rgAC5J44I
 gxcSdoxpkerHrXRjEDAbWBgyoh7TdrnH2IRwX54cRrMD2KEz6Fqg=
X-Gm-Gg: Acq92OHFQFKZxSwAH6UMK8ADqeab4gfdg2zJyUfNBtJoY7AQ0Y0yu0N5ceKySGu5DZR
 +JW1B/FO8h0UwjEJK0AK3jRqqsBkRSD2a6xBJjz2eIu4k4cwjNi2W6KyYRfnx2R+oQBgeQd8XaU
 RIoU4cPG4tJkyHrWw3syoYHMvw7m+QI3mv3+P/XBeHaihcK0x9pe6FXSqwCfSpIUksRAqKgHW/y
 H7iHfQ3af5q4CmrOOjqcJ082NuLXldv6b9zzUWpeUZVok4dRI1ISMI7gXO3AFSelOVfNgOTd6yK
 WuT6aw==
X-Received: by 2002:a17:907:86a5:b0:bcd:882e:1f22 with SMTP id
 a640c23a62f3a-bcd882e211amr471778266b.33.1778523051360; Mon, 11 May 2026
 11:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164225.59325-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:10:37 -0600
X-Gm-Features: AVHnY4Kcr86797iVRdEl9GWP_rEME7elQpBzDBX9FXKvxbIIo2cqqiq3hMSwYyI
Message-ID: <CAFLszTgoAqBsuuNQ_H82+j9Uow8An2VPSk5c5MECQ4FpTs5N6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ata: fsl_sata: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-07T16:42:06, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> ata: fsl_sata: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/ata/fsl_sata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
