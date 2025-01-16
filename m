Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F52C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 09:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E94C180214;
	Thu, 16 Jan 2025 10:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qyxiRPtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC3480283; Thu, 16 Jan 2025 10:31:33 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4FC801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so543277f8f.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 01:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737019891; x=1737624691;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tcAMZYCmx+oewhcdm1jszwyPPzWE4SIVdOBha5eHnkg=;
 b=qyxiRPtCBMQJ49iAVwVQDQeeoSLt8XEYnsMdavmS5E17AtzkbAtsxTYsCRdxwnCcAN
 E4AHzkXX9OUEKDdh86qpjvVyOb+hupVxEgfYpuhaYkfEK/Tdw/Dpd7eUtX2Ug46+o09c
 vD4yC3hwE5eaKhMztWtwHo/REWa+WBMgdAacoiHEXsGxuF/akpdwFXR/9krsmHA4wGyW
 veb9lNIkSddElxh4cYbbBUfoaR1w8B/G17GpvHiS3C9IDtxj9ihmn5msjOnnABybshIA
 c1eMJ5HHzzBLfc+cgwm2iFgDF/QRKljYaDfWazcVjIM8jzG8Id5R/yfC8MxsAIX/JdlI
 QyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737019891; x=1737624691;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tcAMZYCmx+oewhcdm1jszwyPPzWE4SIVdOBha5eHnkg=;
 b=L7Qw22p4eEz7hq6HrXUSqfNwaxOvD+ArqYbk8LNHKodZX8oTnESY4DZCxMgIcTvb5p
 a9CVTr41Z7SoT+RjOGaezbDLAfJR48UxbqUb3F7useg3dg39HOmLO/VLVtHU/xSSzpsh
 j2BN0jWYnvBIrbnHQs1HUf82VD0aNG0jXD8ZWte+Hb132NFq3npaJl2d+50tyIRqOtZ/
 dAvPG+qflgEjB+QIIo4nGrm6A+swZo1DlJx/EO3x0Z0bKbb1o+IhMax77KZXSCVhb813
 2owv67JenayZjr35qUOIHeFFNkdo4O66tQGqRrTqVMDFwYVsTVaZdYjfFcNBnIzqrF0N
 8ARw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY4ZFUkCTLNeMvHF6O/uUY7byxWwRyrZgKJQAo1r6XE1Wu8ZUCOBBwtdw+ig8lFpaMB/iMHLw=@lists.denx.de
X-Gm-Message-State: AOJu0YwIg3fRCERTMZlCFSLL/NqW9liFmkde/oUqdU0ZogAecE8OJo9t
 rv1isEk7uCc7JuJuK1LIv0rV98/CI5lde2yKBtKYx3+ZorMoqJiB9rD1L5/JM00=
X-Gm-Gg: ASbGncs91v+Oo0kLN5UEMoYc+VRDBGGmCz7qn711mBc7hWZ7fZUVoTVOUR01vfTWmar
 aRTpcPCNN9P3Rgu+KEscFNSFtVc49MIWV/XakVt3qyfgzOXNs63Wx5dZh/aujM+sz0EBNAngiQ1
 oqSdXyqynnD6Ou5L9eL5pTWeepqNNJdyYPGyGsYVebG/MLXAhDLD0vq/Cpv92i6EJXwIcrwz/pn
 2DN7ysPUwCD4ciwsVOpwZPoWI+jdwkkRyIH+iW3HPgftUaloA1olGtyQ2IBHzzwUg==
X-Google-Smtp-Source: AGHT+IF88cv4XHkIJSR87JornCuvSulLFsRiPr3LUWqPx2NlS8Gf0+LefW9zFdJ4nwrmHRrcUVzglQ==
X-Received: by 2002:a5d:6d03:0:b0:385:df73:2f18 with SMTP id
 ffacd0b85a97d-38a8733bad0mr13232993f8f.51.1737019891033; 
 Thu, 16 Jan 2025 01:31:31 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c6a2sm20006322f8f.54.2025.01.16.01.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:31:22 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>, ni@konsulko.com,
 caleb.connolly@linaro.org, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, u-boot@lists.denx.de, Marek Vasut
 <marex@denx.de>
Subject: Re: [PATCH v2] usb: dwc3: core: Fix timeout check
In-Reply-To: <20250115062044.3834433-1-quic_varada@quicinc.com>
References: <20250115062044.3834433-1-quic_varada@quicinc.com>
Date: Thu, 16 Jan 2025 10:31:21 +0100
Message-ID: <87frlj85qu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Varadarajan,

Thank you for the patch.

On mer., janv. 15, 2025 at 11:50, Varadarajan Narayanan <quic_varada@quicin=
c.com> wrote:

> dwc3_core_init loops 'timeout' times to check if the IP block is out
> of reset using 'while (timeout--)'. If there is some issue and
> the block doesn't come out of reset, the loop will run till
> 'timeout' becomes zero and the post decrement operator would set
> timeout to 0xffffffff. Though the IP block is not out reset, the
> subsequent if check 'if !timeout' would fail as timeout is not
> equal to zero and the function proceeds with the initialization.
>
> Use poll API instead to resolve this.
>
> Tested-By: Varadarajan Narayanan <quic_varada@quicinc.com>

s/Tested-By/Tested-by

See ./scripts/checkpatch.pl:

=CE=BB ~/work/upstream/src/u-boot/ varadarajan/dwc3-timeout ./scripts/check=
patch.pl --u-boot --git HEAD^..HEAD
WARNING: 'Tested-by:' is the preferred signature form
#16:
Tested-By: Varadarajan Narayanan <quic_varada@quicinc.com>

total: 0 errors, 1 warnings, 0 checks, 33 lines checked

> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

I think Marek can fix-up that when he applies, but if you send a v3 to
correct this, feel free to add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Thanks
Mattijs

> ---
> v2: * Use poll API and remove the timeout variable based loop as
>       suggested by 'Marek Vasut'
>     * Drop 'Reviewed-by: Neil Armstrong' as the patch has taken
>       a very different shape
> ---
>  drivers/usb/dwc3/core.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a35b8c2f64..847fa1f82c 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> +#include <linux/iopoll.h>
>  #include <linux/ioport.h>
>  #include <dm.h>
>  #include <generic-phy.h>
> @@ -587,7 +588,6 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
>   */
>  static int dwc3_core_init(struct dwc3 *dwc)
>  {
> -	unsigned long		timeout;
>  	u32			hwparams4 =3D dwc->hwparams.hwparams4;
>  	u32			reg;
>  	int			ret;
> @@ -610,15 +610,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	}
>=20=20
>  	/* issue device SoftReset too */
> -	timeout =3D 5000;
>  	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> -	while (timeout--) {
> -		reg =3D dwc3_readl(dwc->regs, DWC3_DCTL);
> -		if (!(reg & DWC3_DCTL_CSFTRST))
> -			break;
> -	};
> -
> -	if (!timeout) {
> +	ret =3D read_poll_timeout(dwc3_readl, reg,
> +				!(reg & DWC3_DCTL_CSFTRST),
> +				1, 5000, dwc->regs, DWC3_DCTL);
> +	if (ret) {
>  		dev_err(dwc->dev, "Reset Timed Out\n");
>  		ret =3D -ETIMEDOUT;
>  		goto err0;
> --=20
> 2.34.1
