Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B868BC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E0D82C2F;
	Wed, 18 Jun 2025 11:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="xZLcgzVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5064A82C55; Wed, 18 Jun 2025 11:39:02 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A2882BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
 :Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QSu3Y2snaosvPAJzR3o0LqAbRv03x6U6++3So18tSrA=; b=xZLcgzVuSj4LI3JEv+H7Tpd532
 dSjRjt59T2urINvvzVT5oo4l0fwqP1aEDFJc4LS7jsD9dc9NthQI8Iog1yee53wI2tvTF7yAEOFeu
 dg4izUn9rCDF7T4/aQ1UZQxsoZe7scmZSc5+DAWlLwpS5HCReOXwj0uesvhKMribr/0b7xzQRK+hF
 hk0Mj/88N7NFKnXRtO+wXMR9d5lDY/gdzc+IaNKpQMVh2qXMbQ4r5D7jxhTqWY2bcwi3ONj5zX54p
 3xM3tfaedp+8eltuLaInhR39fTyCOuMjptn8bPUIvusmr3ydm5Ntrq3S02hCw9KJ8SYjbtYYQ06Oi
 aSE9f4nw==;
Received: from [167.98.27.226] (helo=[10.35.4.135])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uRpFt-00GE2d-E7; Wed, 18 Jun 2025 10:38:53 +0100
Message-ID: <9ec17a7fbebd6ce8c967c05848395245c3a96c28.camel@codethink.co.uk>
Subject: Re: [PATCH] tcpm: fix pd_transmit poll condition
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Neil Armstrong <neil.armstrong@linaro.org>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, Wang Jie
 <dave.wang@rock-chips.com>
Cc: u-boot@lists.denx.de
Date: Wed, 18 Jun 2025 10:38:53 +0100
In-Reply-To: <20250526-topic-tcpm-tx-poll-cond-v1-1-38a81560ffff@linaro.org>
References: <20250526-topic-tcpm-tx-poll-cond-v1-1-38a81560ffff@linaro.org>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
MIME-Version: 1.0
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

Hi Neil

Good catch. Thanks!

On Mon, 2025-05-26 at 09:42 +0200, Neil Armstrong wrote:
> The read_poll_timeout() exit "cond" parameter wait for a complete
> transmit state.
>=20
> The "!tx_complete" cond means that on the first tcpm_transmit_helper()
> call, if the tx_complete returns to false, the poll loop would exit.
> But since at probe the tx_status is left at 0, the tx is considered
> as successful. And then later the proper status is returned and
> ignored.
>=20
> But if on the first tcpm_transmit_helper() call the TX status is
> returned the read_poll_timeout() would return in timeout and the
> negociation would fail.
>=20
> Fixes: 1db4c0ac77e ("usb: tcpm: add core framework")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # rock5b

> ---
> =C2=A0drivers/usb/tcpm/tcpm.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
> index 0aee57cb2f4a44af7b483e0e609e39ba584a06c0..c8679615cd7701982b64b1905=
c5822ac98ed6f79 100644
> --- a/drivers/usb/tcpm/tcpm.c
> +++ b/drivers/usb/tcpm/tcpm.c
> @@ -209,7 +209,7 @@ static int tcpm_pd_transmit(struct udevice *dev,
> =C2=A0	 */
> =C2=A0	timeout_us *=3D 5;
> =C2=A0	ret =3D read_poll_timeout(tcpm_transmit_helper, tx_complete,
> -				!tx_complete, false, timeout_us, dev);
> +				tx_complete, false, timeout_us, dev);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(dev, "TCPM: PD transmit data failed: %d\n", ret);
> =C2=A0		return ret;
>=20
> ---
> base-commit: bab54f5942c428be698216224fd10b91d974d4da
> change-id: 20250526-topic-tcpm-tx-poll-cond-8dd3ebbbeddc
>=20
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>

Cheers

Marcel
