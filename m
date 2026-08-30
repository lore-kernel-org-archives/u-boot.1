Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF9C61DE8
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 20:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E771560618;
	Sun, 30 Aug 2026 20:54:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjD_sORSfBDF; Sun, 30 Aug 2026 20:54:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788123292;
	bh=aERGuKTFwAdoTTJhNeK5Cv8apeknSR/5Fk+9M9mg1iQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v5b5lK7YJTlAaX3wYe+iuTmyvgqyZ+eQ9/bmZf4Hh0NZUc0eZffiX5kyebdOQ8lfw
	 Klni4P6zUusshp16i350F3HIs3JwVUaPuAGmvN6ljsqB74q44V4ujTw47PgiW7f6QH
	 nMI65mjySuVUmEgeTzRiMXEs34DhRAFLI0UyITS97952FvNlQqXAFLV6ZcHXMS7GRv
	 IB3e87I+x31QjtGOrBA+rxys+ltf1H29t5yHEOytg/Bm50PXeoZC8HEpsQqZaWt23c
	 +BoCtwX7Pm8Ab5axUFK0xTh0TNh2HErsFLhjSiwxVz3kiRp5CqAl06All5WK59fhZI
	 Bn6WwMSNXTfSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBE7D605D8;
	Sun, 30 Aug 2026 20:54:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D7BC334
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 20:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 038424057D
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 20:54:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w47NymYY8Bpn for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 20:54:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cLe5dmx1
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CB6A404DE
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 20:54:49 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-90c776f6c13so33679136d6.1
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 13:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788123288; cv=none;
 d=google.com; s=arc-20260327;
 b=rfxN79CiEbQ9vwSbsa6jztSRGW9rEAxfscFrN7byeKjqM14uUIdOA4AAXNO5sghZru
 Eu7eXvfrWowtD90ke/tZHVojEdbPpx9Yg8oQHluc0nF8P2+mIFwjJAZDMFw4RUeMAqko
 cdt2q8XQY/jk0anmJySxcRb6aiF7Q6X9/tvlg4xxV2uZOlFqa1PxZ48a0ENZySLkSYe8
 tgSViYTxMe2VdYAI/DiWSUXtkaqD7sLyQouzQCKc46qq50TwsrfArG9Tff6biSXKvyun
 vOrAKozpLA2sDRly5cpOa8uxgWQfHytloBQnUhu8iyDGgydmp0+ylPDGYivM3bzmV2Rj
 IZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aERGuKTFwAdoTTJhNeK5Cv8apeknSR/5Fk+9M9mg1iQ=;
 fh=4tKbE/50oq63LA1914/MXi+Ac8mPa/ByT6vrUnEjTmE=;
 b=OE1gC6pmlPUjQ2xty+4ITOnGpXb9DP/eI3zDZaZ6suAzJ8u+U0EcsPlfjXHUXIbLBV
 CGEmn1033B0DKnbaxNCtZmCnM2PFAHfwxLaKfPiZPuPPh5puEX9jPV1mL4yDQ6kmy7eY
 jz1c2vVjV3NwQHxkOfJhan4FDc/lw6egnkV1VSGaI/Ar2XKbuqtoGNtbbb4ERu7Gmcn1
 dGyAPDnCCouF5qEuPFjJmgk1NeOjMtoVBxuBQpdVzkbOsUxjGwumyoVI3cRGNdbDvyLa
 HeUZBJrkUr9WBA00BwJ3qO9QWM3Fb10UurSG2bMjpCUln3FvfyoyEt6IiE2kmwsZpqMe
 Uang==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788123288; x=1788728088;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aERGuKTFwAdoTTJhNeK5Cv8apeknSR/5Fk+9M9mg1iQ=;
 b=cLe5dmx1nU85CDsymnZdK8jof9KefmCq7r+8E+HXY6dj3zruFrXeWlDV6tK++bx+T9
 FsBxausxt8D67x7Ip5agiXghFtA3To05izcOgnLyfFdAbbv2pdma+cDk/+GO0do/BXWu
 9lK9F5uy1goElcKzIIZqC/pZS7rC1+tbFxFq0y27Bv+B5i/HK3jg4UzzJh9Ycx9S0fYc
 qGpKTIbg/n+NdEC+ra4ZDJhElZKrQF0D01qAgEz9vbGlSFnWUVzS4QgHUKMcQNXbY2EV
 oIEpmk6etTVmHB++tIG1WP54/WTWotj1OfI78kCPKGx1Xp/r91nTP4edwPy9FAYllBMk
 a2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788123288; x=1788728088;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aERGuKTFwAdoTTJhNeK5Cv8apeknSR/5Fk+9M9mg1iQ=;
 b=BTpgKmFEwfkWHzuFVf0JGM3zHfIRvxE8uglHU3fQcYvFVrl/S8U2MgLM8xUcsQhVt3
 Bse6BU3CM7uSg7YaR2+8IYVLrTTSSt6/kd1Hg41Lp2YQvTXnZaw2oJ8W1T7uDhVs6biN
 6BSmSiDXIUg23NjghS+xOSdLTSx+ehrKmqa94dltE2owQd1zTx6PInejlm6dBgWto2iw
 /i6g4sxD2MAheW05oepK2HhwbVySznVbl/unRd2TVqQcYsDMvy+e8I2ewIX+O+ou4e7c
 +kT4fmt40AVZS3maSDDwUyhlX8tCEqzLRhKdcmNnKUguaPlAgE3t2NUZAZRsIGXQ59rF
 Cnqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxcJXDHI5Bl1qfeLNnhRHv98FC8IW6haxsKIm6p9Mut7355FE2O02leOaijIUcpwmBBFC9m30=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lJPcyCDUy265U/5YIcoEDHlVgxLqQ0hfseBPyiMSNNR09M0jbJ
 LaHZsEwnOx+GQMwK8Z2UdjL5YfTX3GSTpHJKt/R1GysgrIE5zaB8sqZfbTm70myw9Rbx1HL0nP0
 iPmyK0wB/BI5Mjpp5n/k1t6OwxZQecS0=
X-Gm-Gg: AYBFou1kmXHqRwr84xd6aRaa2t3PM/Bmr9QKfPnrUdjbqZQl0arN4JdolrdfEZesn6j
 5s+tbknIsrpvH4Da8Lttu/mgbk+KNU16UqHSnqh5jeypptpyIuHkoeutD1yPhhzEBk3kyjtsoYw
 n5lKzNAsuMcoaIkWW7ukigJKXjj6TsfwANsbtP6nh0w1lNat4cJqmJ1rNbRDsruGAu/ZpOPMRxs
 nXIr+Wb1IkwTMIAMTti8TYx9aJW+h0dGmcPnKdzpR3sJmuo72xgd9c335IBEiUxlIfRCfO6UgOd
 nObcusdWNrtukXmpZtmWbu5BlfooGpE49cKtkEuJRIeCSyUMBanbDPnIsLkgGIlXABsypPiyDTw
 FPsJkdqFKFBygHQo3T/aRIIl+XriLg+dilbhnhiVfjW2k8v51mYVdTTd+dbfDC/Old1yGKBDZQg
 VQCcUTB+d+F175BNG6XPz1Bg/UtaUJDIEOFVy/7bw6XskwNhXQSA==
X-Received: by 2002:a05:6214:21e6:b0:90c:4d1f:f88e with SMTP id
 6a1803df08f44-90ce0ed1626mr255801146d6.16.1788123288427; Sun, 30 Aug 2026
 13:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
 <CALeDE9O3Taz2Q-NgEM4Prjn_Q=z6mXduMR7y_iSvwgBR6yKGXw@mail.gmail.com>
 <DL2BE0LQPFRK.1IXQLUXGFDKAW@baylibre.com>
 <3aa3d789-3cfc-4913-9003-9a9d8dc81647@mailbox.org>
In-Reply-To: <3aa3d789-3cfc-4913-9003-9a9d8dc81647@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 30 Aug 2026 21:54:36 +0100
X-Gm-Features: AcwNN1XgAfObM4Wi0TTXUOyb54VN5Y3Y4uTzTjdRPaSbOz8i2nqM-hleiO6fHY0
Message-ID: <CALeDE9MPBAt4P3Dw9oE-eEF_UjSWUprFG_ipic8SwjwTAb0Ubw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add RITY devicetree preparation support
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, 30 Aug 2026 at 21:47, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/30/26 3:32 PM, Carlo Caione wrote:
> > On Sun Aug 30, 2026 at 12:56 PM CEST, Peter Robinson wrote:
> >> On Sun, 30 Aug 2026 at 11:18, Carlo Caione <ccaione@baylibre.com> wrot=
e:
> >>>
> >>> RITY images select a base devicetree and an ordered list of overlays
> >>
> >> What's an RITY image?
> >
> > Fair enough. Since this is all MediaTek-specific code, I took the term
> > for granted, sorry about that. Anyway, RITY is MediaTek=E2=80=99s Genio=
 IoT
> > Yocto SDK. By a "RITY image", I mean a boot image produced by that SDK.
> Can this instead use fitImage core code which can already apply DTOs on
> top of base DT ?

Or boot using UEFI and be generic, deal with the DT overlays with
standard U-Boot mechanisms.
