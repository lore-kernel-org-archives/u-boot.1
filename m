Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1D7FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806168426E;
	Tue, 28 Apr 2026 16:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cXLmziKA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0317284663; Tue, 28 Apr 2026 16:05:18 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7551984659
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba699316b42so1446512166b.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385115; cv=none;
 d=google.com; s=arc-20240605;
 b=bg01mN2PDvqbbEORc8iohXWWH07ypLTRzk8sQbvljdVGKCWevHp6ccVxff4tdKnnk4
 nuc9r3Pp4DuXAvpoCHUEG02JsyipfApLVENYrcYEVuasci9YfznXVVWjmJI9G/cQ8yF9
 oNW71LJYG5OxS3BWtQ4hlyL2vIjf0tn9K644Hp1Bpxmhlw1/216Eedb2flr600v5FxXa
 un03WBuvxVy0a1FDV8I+byKNTbAZnThYeuItQbOVP1psBtuCxCqUjPhn7ah6zuhCXb6x
 ULJypfp8IklwCGJsOBfysaTmb1k4M2AyAzMWFnH64mgZ2o5oTkefVep7boY9HAjgq0be
 rqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=724eTrWAjWJSDYCxI92kY4mhJ8R/8+XJjG2LmphXjxY=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=KqUuK55LCYhUqC/XRaJgIKf9TQFI7NCRp8tln96G9Bp5vyd2ps2lgqdjcq9qKFah8b
 7pmhFCgbgqZro/sltTXb5pnDI9ZJYL2jCM7qUSlNuE+h2D+LVnPlt1cfXr1nDoC3io+5
 TtDDldKW4aez/3/bLOnG+xQNT6bzGEi6jDxa4KQeNr5voYc45AmZ+qoxFLWJsYzE9MEy
 GCo8A/ZqpD/LQ5KuAJA6bE83IP1PNS5XIP1huw2JtbQZNCdqg+OSgrg5Xor/RM0oGQTW
 4343RNO2ZTakb0b/PALvZd7Tf6O8H413iYivSuGe0wLG6VR4Jzhd3PFxeH+fpZT3rNNr
 7tqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777385115; x=1777989915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=724eTrWAjWJSDYCxI92kY4mhJ8R/8+XJjG2LmphXjxY=;
 b=cXLmziKAVXqJFkjtxhPuSBPOfiEfuK6DaRagZjcojY4J3F4dD07Sye6rWNcNVj4QrK
 9fnTGmtmA9YX91Wd7haHwfEq/+J/YPQ0fU5c69hAWz++xor6dNGr+cXqj8Rs+wKwkyuY
 IqRCk9Tiq+7q/UFtA9oj4+4aG9CXWv5Io4+yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385115; x=1777989915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=724eTrWAjWJSDYCxI92kY4mhJ8R/8+XJjG2LmphXjxY=;
 b=TGgp1nRDyznA2aXWlaC8kB21fgV7vuNlpItRzKmllykUHfzKqrPFiJ7SbWGXMBOaA8
 GF+U5nYb46wFXJr2KP+wsctlYFDwXvtTF6/l/668WPXPQ5BBOEEx8qrmHkLJzbF55orJ
 MhoodXDAVPSdWdUYugvbMcUYfrY3lEPua1jrz6flQQNSAf0njDjXDcx1j/sz8t4qxprL
 y2IIirN1N61OcDnTm3vIFzgNWHlIVfmVS+9LjMtY+HyVNIW29RekZ/SUtSLAUxJnG/Bk
 27Xo/T0Mk9KLQIVRop/hb3yUwlpLK9S/f3++HRvcKBsFykErCM1M9PlmtwwuVpGcgh3V
 seUw==
X-Gm-Message-State: AOJu0YzUV9Xobp1FJObrlL26G1nWpmiOHkY2pdgVtcHsX8ozbLA9+O9I
 M7D3Ilg3iR8nUwqf5XbRrQIIcjyUI9CsgdTy8G5ws+iv1gbkpcdN97Ih3sOHYJUWhaHz0Wtk8dP
 KA7mOAwy80VwgSKUMWjz2UWLeW/RsIv9R+9jiGyPI8jYXRF4sSWg=
X-Gm-Gg: AeBDiettHXFLulTUfpvg25Kps81fG1K4/rma5EdHJQWijOo3Rn27YNeTCtn0cwGOluc
 gguwOV/B4Uak3hJq6VKI1KnyasgFYApmFXWn574n+VHWT6J4KBfwspP7ez+hu4vw+xzEoIBKx5F
 88Dwynk+xxTFp5YebjatA3VKETKb2akehcj1/51JF0tFhfFjzOaDRywq4BZyLT9J1houmTLkEPm
 9FZI9pZxUuqweJua3LkGEqCnVzWJdJyNI25mF/52h6uMT4WcUdnpZs1mlTovqxWd0N1Ixlgnjvb
 iuIkNFAbF2g3SaG9
X-Received: by 2002:a17:907:5c7:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-bb80377e0bcmr207001166b.23.1777385113234; Tue, 28 Apr 2026
 07:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <d43df5c2427cf4d03b441aa8a9e34800fe20be8f.1777272283.git.weijie.gao@mediatek.com>
In-Reply-To: <d43df5c2427cf4d03b441aa8a9e34800fe20be8f.1777272283.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:05:00 -0600
X-Gm-Features: AVHnY4LGnWXPdew6ldmq3idAiq4xfzT9U4oT6hts1b089MB-8o--MHijco_E9Hs
Message-ID: <CAFLszTjj4-SoCoygUij19cOiXVy5VLZt3-nPAJew0w4NB2eO1Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] cmd: ubi: change the type of parameter dynamic
 to bool
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

On 2026-04-27T07:09:11, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: change the type of parameter dynamic to bool
>
> This patch changes the type of the 'dynamic' parameter of ubi_create_vol()
> to bool as it's used as a boolean.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
