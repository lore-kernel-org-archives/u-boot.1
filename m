Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830C8CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1590184908;
	Wed, 27 May 2026 03:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IBIh97jB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B170C848F5; Wed, 27 May 2026 03:17:09 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A5A484869
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bcceb394417so1367660066b.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844626; cv=none;
 d=google.com; s=arc-20240605;
 b=g5ho5Vi3aYz9E2mI2KCOlU8mULsg5l0QyQ+BE07xK1Or/CeuKurXUwcrTL/9JYKHGI
 /kyn6oeLERchcjGd/9FQcs9eteO/1SZ5Kljl6WbvdeI3DHVI3/8fD7lJmuUx+7aoWANM
 +SVti+mHkQzzgas6j9pJQ4G97Qo/yr8jUCRA/NFphgaWRe/edCX2tsSfHoeBcFfm8xv6
 yN4n+UbPj9ZABt7QIkG092fXESTI+d/tZRuwAsF881/Ta1fmSuxjFYPz5P65OdvoAI99
 7TBQY3zTR/B32A8o8+dVF3aVH1FzRDqsGDaatxWrsRoM9V7uEbk5gaoTp4LmtYOiiQ2x
 CeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iTVjYYcwzDhxEsCxqjt0f7QUJGZIe3s2nMifviIbQ6Q=;
 fh=Q2N5Pj19gnOWaEtQmv0mF0A8ovEsyTAH6uzK2RJp2Ys=;
 b=iD/3P0/Bs2gGb/z7+Gu2ZP04rrLMJeZ5KcMbdvPox2mI5lJXOnuYdG6eNyVvQW6xGp
 KrsHLRYWukYvNbCwTEEWhKYFhX8os07h2i+2T9ApSl5xtHCnRSieKtZR8x6BPk4ygNE/
 rW53qLup4DGa9uj322gjNcsIySKjCRU2YAe+VDpZLiVokUliOMUAHS5X6UTXd86QKeVv
 +LxJmbkBK627k5VSG5y9wJo8dVN2+xKtqGntOwFmSoesi4C2ejKtN+Jhl2SWfs656sHc
 dLHE4rKHKYjxzGgTFq8TsvJTfZt5oRbqOQc+PZZ1wWDg5VkWEjRCFu3o4ZBvL61fctof
 yBaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844626; x=1780449426; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iTVjYYcwzDhxEsCxqjt0f7QUJGZIe3s2nMifviIbQ6Q=;
 b=IBIh97jBzBSe0qn7IRzs+mYnAZd7SrPc2UVXEihU+t9LZbsOAB/DmzZKTZ3l9nKQjV
 rPlkHj2Fd4vDCPXw+HRibQHY0CbX3saFopIKGagiekKh7V/wR4OPBAuAH8x5arMC6LBl
 5bVlkv9A61nlVgPyQsKbV+eBuxB5rf/AIQC3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844626; x=1780449426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTVjYYcwzDhxEsCxqjt0f7QUJGZIe3s2nMifviIbQ6Q=;
 b=RgKWaUJwVn9niuD6OlR7AAmvKjcYxHL02l3yM6NrTw9dU3RuuXJcmVKAlXe2tQk95P
 8fC0mLBSSS4M5JUsdkl4+TP3C7+ZMQo2Jwn0AHQXcVkFcw+D5Y2sASsBnDOCwByXuWRe
 VwBbF8xgPCb7Dh0ZJxPhsMvrnn6AIIY3f878K2xpI7Nu6tXOt4q4Qa/ZDg8kUUfusvaZ
 JJSNKYte2wvhbAUOIMouoP0u8JGjp9rT6UUe8y6bBur335H9A29qkHAf4/muli+0fA7z
 ITGlTyWXtXBqXY1EWbGQC2aNbBOc8IgupqL2lFeveIn9+acBiNyOiPagYFepYIaZtsJP
 XsWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+y9kloCb3PlyUd++KLnkKB66g5FgeRUlxZ9Q5aDt7cr5lUy+fZFW2yQ28F75ZjqxzLOm6HViQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxRriZt2++Xx5CaSztR0QxNUo6yUjFCU7HHcUgbelZqb3tUmd95
 5HTP5v7/fC3WnKaZiv6oiGnam4+bS5FS4Vt5a0C/EnFpdFK6rx+xjy/N0JGfK5PdVTj74Y8hcyH
 BzU1ohQSj+LuqR8yY+bEdNc936a+DOXZHlG18q0pk
X-Gm-Gg: Acq92OGIX4xIOjvLjMdky0sfJOYrPpLH/iEqrch+oXAG4phUBdIHKfD6pjMS+Bw858p
 0+9lrbpzaSQeF4AA6ohLtP1SgWwfi+qj0rSY6bBWAJSL6F2AwKz+GHqLqhqfjOoPZxX2arixflY
 EgXlLX+teEv3ve9Ig/iRWFlLT93k2EVuf0Upg2g1wNSRgeLgluw28w+i0Tnaw6emls+S5q4CWdv
 b0E7xjgJoNrZKKaHGeiwFamjJE5PoIZIdUml3Zu/MWlRqxTHxgRTThJLYuSO4wIAE/vLeETQBot
 YJ3K6z9WZogy9Pf/
X-Received: by 2002:a17:907:8e0e:b0:bb7:eb68:514e with SMTP id
 a640c23a62f3a-bdd2aadaeb3mr1224979566b.36.1779844625973; Tue, 26 May 2026
 18:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
 <20260526124044.354578-6-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260526124044.354578-6-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:16:52 -0500
X-Gm-Features: AVHnY4KG6A56D-efX09VOtYUyXJaqFnRBB32zT_DJnfn2KxKdAdfpf2S2vfrcOQ
Message-ID: <CAFLszTg91DVHSE=GtB12-WHp1Mof8JjAJ1x4LPSNL-dDkEd6kw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] arm: dts: tqma7: integrate tq,
 eeprom sysinfo driver
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
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

Hi Alexander,

On 2026-05-26T12:40:39, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> arm: dts: tqma7: integrate tq,eeprom sysinfo driver
>
> TQMa7 has board-information located in EEPROM at offset 0x20.
> Add necessary nodes and properties for tq,eeprom sysinfo driver.
>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/arch/arm/dts/imx7s-tqma7-u-boot.dtsi b/arch/arm/dts/imx7s-tqma7-u-boot.dtsi
> @@ -9,6 +9,26 @@
> +&m24c64 {
> +     nvmem-layout {
> +             compatible = 'fixed-partitions';

Should this be 'fixed-layout' ? See nvmem_cell_get_by_index() which
only walks up past the layout node when its parent is compatible with
'fixed-layout', so I suspect that the cell lookup will not find the
EEPROM device?  Your binding doc in patch 3 uses 'fixed-layout', for
example.

Regards,
Simon
