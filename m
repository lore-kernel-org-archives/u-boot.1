Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2D4FD877F
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0458413A;
	Tue, 17 Mar 2026 15:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tAG5ycVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E7F84368; Tue, 17 Mar 2026 15:29:52 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BAC983FED
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso143024766b.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773757789; cv=none;
 d=google.com; s=arc-20240605;
 b=Mti3AV/II/SILkwROTz6aUw5L7QYMkt9SjAhKFYcpmvnVre6k0uGoX5fn934btIQwA
 FgaXhZ/EtDqJEjfqiNy25s91Nu6tMGndwON8APVpylt0rntCkHT6qMBT+6xnYgJlTZLR
 ajHIHW8oeUepS4BTw56KBnw/7WVy8pdnssFj0eEBFzTe2RhF+sz/IG3GEMh5nFFTpwak
 KJ4qy93F382VdNVmXSQdFxacq2nvJC4DXGizveZRF+lB35EncYJ9PfF3KJZNy9bZ6ytW
 PErHHPXLeU19UsZBI30plDrwNXBJVS00SGFb/5CSIdNAKs+QYebT8lBbNvQXNIrNuV7C
 MLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nQnrW0D/1PcL7mA50P1rMaVC3xLcnYzRGKdjTNMw7VA=;
 fh=Mi6f2utaRLQ8F8RltETw1S24CoUeUsHG04MLrr7EW64=;
 b=O1W6i13X1IJgKphYklGCwuDCPAFSi9xYKrppiN2U8MzYKd/umGwPRtPQl35iFl/an6
 S99m2BF+a3X/IX9qQfSyPq+Os17PEB3l3K4cXVr6KPBQaNiLbUy7EbWvszZUqwyNwIXM
 D2umoGHivhSgDQ1J9dwmGP5v96UmkizbetIOK8dn9tvJgjxjPs9V2XvoqDW+NQcMXY/u
 K0W2606e3KdYk98RqI3+p0uffR8/TrcTifTckuqimO93dI8/asgRM5mkrTCvxmaiOX0R
 ELZHj9dxPNkURpnHCk3piYZYU2I1ZLlD/1VkhFXY0nBdTlA/gM8Wds6sVruBjz31qRYt
 6uwA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757789; x=1774362589;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQnrW0D/1PcL7mA50P1rMaVC3xLcnYzRGKdjTNMw7VA=;
 b=tAG5ycVf4acyt7P2mwIOcKfOnND/r3KkmKl5Mm6dcsfwgFEGTiIqr0ClxyrA1EM/jU
 LvjQ11+2eR/Fqiagklb9jD0tGgemb7BONuqAPDJh7xuLbNO5xZWeNf+BULrslIq6MkA+
 CzEF3hExloJEueM7u7TGc88z/oRx/y3BwTOr+mA8CO0r26JBEStCSeDL7Lltf9FvsU21
 rIzeOF+vfWaygevJXrz3trk54EQ4QEP8WeAo+eVRts97bU068idAC1Ge30DJx0LX09Ku
 NywTF+v+qB2Lge68ga9Tw481yJ4MkAN+YIvk/njQvA76UIedTSd7YR5WemyZrK2L+rjs
 knFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757789; x=1774362589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nQnrW0D/1PcL7mA50P1rMaVC3xLcnYzRGKdjTNMw7VA=;
 b=ZS0r6bWrgo0EWKWLuSLfiFlDldTdbqKmpALN+EcBzhNGkMHmE5K3guQ6Bv252EUnkk
 Y7WGxhsJaDIwLYdTQYHqH0rmAHHT7SCDmSlhNKfN4uSoCkQijPYiKGg9ZtS4pDeLu/Sa
 YOm1kh7aXJVpjjC/yVRZRDAY5hM+nUrQ6aqeCD1lJyltYpbNSz0I3AnIR0+CBjI1237J
 cFT3NdjF0KCdRKpAjmetJS5yL52PlOlr4RkohLHkbTtSI9VlzkNlKYqVSrz190yhND2G
 WJPuAGL/+MPCPpzm0TebSud26ScD7rygNkLGHEhIOmyT3EyXb8z4UFCstc4gFjtqzZ3O
 mOUw==
X-Gm-Message-State: AOJu0YxXSKoOqmtwlf5SJBs1/2I+dVUWshR6ojRFJgEamxxqWCuZKeDN
 Y/mazWJ6Loy8/P8XeHBvrxTcV6gX+HjKb11HXgOyWu64UgavmZMpCfc+74DBoCNCUum+KsrS9pt
 ASBvrJiRWbTVSNHa6DAbY82HFZBkY0nTnCGHktHqr/A==
X-Gm-Gg: ATEYQzwjxsa5gibnxTufA5Kc6Jc40JmgASeZqPuwNCf6C7UasUsGrr1t0H4WyD4on6l
 rGaeAhuiATgDxaQbxDNJmuWfEeBTIKITRe4+Ux+iO6L6oxUYNbcUJn8We+gyE87CWY3b/55gGdd
 fejesf8eIKURavf2zqaXs24NRTjPHNIOargOAxtikjYPyBMeOrdJOtfbUUB8j3dq7cb3NxI/HhE
 i5XHJVJ4D908RyDkTkhvLO+OOabEagYTRBlUlNw0W/wM4HdkBA53ZlWeUv0DMLF4DGa2TQMWQi/
 PYvl4DQYYlXUOyWe7W8z6nXDV0nAq+oeOcSQ4Obo3E0meG8X2tN/O3/dTNFJ/HL3abW3GcybV/A
 ig3EizH7TPdbQVAe+zJCEBxdpWw==
X-Received: by 2002:a17:906:c14f:b0:b88:51cb:fd65 with SMTP id
 a640c23a62f3a-b97d6c12718mr238815166b.3.1773757789268; Tue, 17 Mar 2026
 07:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-mt8188-mt8195-disable-mmc-disable-dma-v1-1-220da4144920@baylibre.com>
 <67054ce9-c839-45f4-b73f-ec46899379e1@baylibre.com>
In-Reply-To: <67054ce9-c839-45f4-b73f-ec46899379e1@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:29:44 +0100
X-Gm-Features: AaiRm50ekfZs4NNRlXb7bQHoBOKvYVYhUbKZH-uFwqpn5Rk1fTqzaLQcpcALgBw
Message-ID: <CAEHHSvYkXkf=p9d=xCxG7OagxC_34Wtj0yEGmQ6RwuaQaOnnsw@mail.gmail.com>
Subject: Re: [PATCH] drivers: mmc: mtk-sd: disable dma for MT8188 and MT8195
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, "ht.lin" <ht.lin@mediatek.com>
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

Le mar. 17 mars 2026 =C3=A0 15:21, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> On 3/17/26 8:31 AM, Julien Stephan wrote:
> > MT8188 and MT8195 SoC should be fully compatible with MT8183, but
> > currently dma is not working on these SoC. For now, disable dma.
> > Investigation needed.
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  drivers/mmc/mtk-sd.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
> > index 7a4bdee7496..8f93e51599f 100644
> > --- a/drivers/mmc/mtk-sd.c
> > +++ b/drivers/mmc/mtk-sd.c
> > @@ -1989,6 +1989,30 @@ static const struct msdc_compatible mt8189_compa=
t =3D {
> >       .enhance_rx =3D true,
> >  };
> >
> > +/* MT8188 and MT8195 should be fully compatible with MT8183
> > + * but currently dma is not working on these SoC.
> > + * For now, disable dma. Investigation needed.
> > + */
> > +static const struct msdc_compatible mt8188_compat =3D {
> > +     .clk_div_bits =3D 12,
> > +     .pad_tune0 =3D true,
> > +     .async_fifo =3D true,
> > +     .data_tune =3D true,
> > +     .busy_check =3D true,
> > +     .stop_clk_fix =3D true,
> > +     .enhance_rx =3D true,
> > +};
> > +
> > +static const struct msdc_compatible mt8195_compat =3D {
> > +     .clk_div_bits =3D 12,
> > +     .pad_tune0 =3D true,
> > +     .async_fifo =3D true,
> > +     .data_tune =3D true,
> > +     .busy_check =3D true,
> > +     .stop_clk_fix =3D true,
> > +     .enhance_rx =3D true,
> > +};
>
> These are identical to mt8189_compat, so we could reuse that instead of
> duplicating it two more times. MT8189 is in the same situation that it
> should work, but needs investigation.
>
> And actually mt8189_compat is also duplicate of mt7986_compat, so I proba=
bly
> shouldn't have added that one and just reused mt7986_compat.
>
> Another approach could be to revert the change that enabled DMA in mt8183=
_compat
> and add a new .compatible =3D "mediatek,mt8365-mmc" that has DMA enabled =
since
> that is the only board that has been tested where DMA is actually working=
.

Fair enough, let me do that
>
> > +
> >  static const struct udevice_id msdc_ids[] =3D {
> >       { .compatible =3D "mediatek,mt7620-mmc", .data =3D (ulong)&mt7620=
_compat },
> >       { .compatible =3D "mediatek,mt7621-mmc", .data =3D (ulong)&mt7621=
_compat },
> > @@ -2001,6 +2025,8 @@ static const struct udevice_id msdc_ids[] =3D {
> >       { .compatible =3D "mediatek,mt8516-mmc", .data =3D (ulong)&mt8516=
_compat },
> >       { .compatible =3D "mediatek,mt8183-mmc", .data =3D (ulong)&mt8183=
_compat },
> >       { .compatible =3D "mediatek,mt8189-mmc", .data =3D (ulong)&mt8189=
_compat },
> > +     { .compatible =3D "mediatek,mt8188-mmc", .data =3D (ulong)&mt8188=
_compat },
> > +     { .compatible =3D "mediatek,mt8195-mmc", .data =3D (ulong)&mt8195=
_compat },
> >       {}
> >  };
> >
> >
> > ---
> > base-commit: d31f96cac1e25153779c44f1fe014978f9b06032
> > change-id: 20260317-mt8188-mt8195-disable-mmc-disable-dma-b64499a6a47a
> >
> > Best regards,
>
