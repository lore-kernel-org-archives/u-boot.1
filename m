Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B861EA71B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 01:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B7F83FF5;
	Mon, 20 Apr 2026 03:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FdUkRPJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7451C84181; Mon, 20 Apr 2026 03:18:20 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A52880087
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 03:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-674a44b84fcso1229675a12.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 18:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776647898; cv=none;
 d=google.com; s=arc-20240605;
 b=gOduzxLTk3ZzjIec5Lr4B6z1l6J42kIOmqN/qy3Zc4zXVz1IwrHEK01fvYO6+v8swI
 dizshEfuv8iOT5m4IgEMhnure6UNClnJ2Suxp334JfHX9O9pqfnXAevPvCD/hF9t6Ck3
 JXZw5uEzmIbBE6B11E51FXodeo2d64w4AjkOao1NnHSd+fnzTRBFDhKlg/xgYMNrJhrZ
 VtCOwuOb9F9rL7CqwnZfclNIBhfD2pFbATG2Cos4RW3dMHc/+9TK+hlUiFxCm7RIwwy3
 VTTBSW9Vm+Yz9p8xNEe/m6DITCTwinx3jAxM2gSyNXT48eZDy6kO5lCsX1ZtMfeglmcj
 Nv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=axD+jozH5GUPmtU/8aKhVCsDLQuoRVPiYcgvqBF0qi4=;
 fh=S8xjaNhDK5zkqclbPZi4D14oajyF+NpuR2kRzRAZ3EE=;
 b=B4Vr2oPVFdB/Zx7y58zde41kwzeUySKKgmug/oLRWRDZIPTSL8GQolNpP3YguTZkf/
 S5JXOv3wkgdoJzCUBYGOMv7JCmygUXdGb4Ynm4ORuWXuyMFXwkdYrdJRQ2yT2F/s7GkY
 5t8IEXEiTRdXnttbuWunl0djtAIuR9Tt+M4YxCjsP0NK54L0sALCHplC7+fCT2/f0xGB
 VIIszF36EPUXW832vIjkJaozbpvAhpMrpQtiXCPaLHMWlYglU6zw05InQiKoUudrPWMT
 lr7GBEMWzruK8qGRLFTadGN1IUs4/GhzfG3VGBxKKhi7Solb6OBAfJ99Dr3DinMz7392
 x+sw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776647898; x=1777252698; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=axD+jozH5GUPmtU/8aKhVCsDLQuoRVPiYcgvqBF0qi4=;
 b=FdUkRPJjSH/sWlz6c/2CNDCD8pKszxw+ZMX5MmlaOmdbEZ27Kw4olHY83Kw4hb6BHj
 3PCaKa1VnVgJ61rqcQC3kt/lo4b9d5e04gDP5R6yvN2Zz6eQmF8zpsDR+wMdq15Ewun7
 R8oD3jlxujiK95GrOk3gzDp9M0JPj4FnRKLQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776647898; x=1777252698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axD+jozH5GUPmtU/8aKhVCsDLQuoRVPiYcgvqBF0qi4=;
 b=F3nPqJ1PzQZ9C49iv7t6CCDfB49P6fRXluCxV7b4tCXVKr86b60TQYi/I3muEi71JQ
 G3wwv0fFR7fu82reih9HkyGdFeLPmKqF1uYKiePMwixnxF916oJiGDXGa6reT0E0iQth
 lVoIbbhC3pXcVuETYeRLcWZfjcUDumfSvrwXNCOcPVV7ddE97Avi1kKE3gckKduSzFVD
 zuzVP3GLdMz21IHFNgFf21xqdHMS4QbmMkcxIIwf/50Hk3/YMhjvk+r31gzuVnWlGO3Y
 BWFOYNwLyZPaWMZ3gmJywVgyvXRGDd2VDaoHSkuWG3woenafqUfB5Z1n8JYpyazSQFrG
 P1Uw==
X-Gm-Message-State: AOJu0YyJFjGeFZmusE7WGwYBU3UZK839OseQrIxRarzL6rJIX2wROSB5
 OvclnenlcPt6Nr5MI1cOu2E6snn3VO8DrHnAK1p++2oaBmh4FZOc34UPAVC/L2ohpqmRsc2HQa2
 I/PkQ+ILUGdGqVsMw9Ye6dko7+Mu3/KMckrXFyAMo
X-Gm-Gg: AeBDietLJMnS7mSr+e80IIMgN26g8LbclvT9Hli1mbdunKamejRf7iu0uy3iJDlmQlG
 HlTAouWm/6nCpps7QCwL5m7qpIo5+g6UBJrBbelhu2FzurorKehqOoYlIIon0cAYSLRNopyKGA+
 F1iS3D98R992UFA9Y7DOhShwueZ/p9KmXTCXplYUpbXiwvNFuoL4InWEqVXcB0mg+iiifwh4gym
 IzN3DMdRR4+knPy/En1mfkONxK0DcmglZ0IZpImYMy2RSDqEYBSXCXlra+5Lt1Bz2E4VvFxwug7
 WE25If3bWcUjbU3Yxz2S
X-Received: by 2002:a17:907:c30a:b0:b9b:7bf8:800b with SMTP id
 a640c23a62f3a-ba41afe998emr529926166b.40.1776647897757; Sun, 19 Apr 2026
 18:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
 <20260419-type-v3-3-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-3-ec49acd6870e@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 13:18:04 +1200
X-Gm-Features: AQROBzBIF_SQfAAlTgjORCLQyyu-FYDDDU3tFeYhnqnZfIJhmRpn7tDCfkHzCug
Message-ID: <CAFLszTjsLf2tr2neDt2uudxkEqooerAnXRyrSSaDTnG47jZOLQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] env: scsi: Add support for partition type GUID
 based environment
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
> env: scsi: Add support for partition type GUID based environment
>
> Add support for locating SCSI environment partition using GPT type
> GUID instead of unique UUID. This enables the saveenv command to
> work with partitions identified by their type rather than unique
> identifiers, providing flexibility for systems where partition
> UUIDs may vary across devices but types remain constant.
>
> Introduce a Kconfig choice statement to select between three partition
> lookup methods. The choice provides mutually exclusive options:
> ENV_SCSI_PART_USE_UUID (default), ENV_SCSI_PART_USE_TYPE_GUID, and
> ENV_SCSI_PART_USE_HW. The corresponding string configs depend on their
> respective selection method, creating a clear configuration structure.
>
> Introduce CONFIG_ENV_SCSI_PART_TYPE_GUID configuration option that
> allows specifying a partition type GUID for environment storage.
> When SCSI_ENV_PART_USE_TYPE_GUID is enabled, the environment subsystem
> uses the type GUID based lookup method via
> scsi_get_blk_by_type_guid() to find the first matching partition.
>
> [...]
>
> env/Kconfig | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  env/scsi.c  | 29 ++++++++++++++++++++++++++---
>  2 files changed, 74 insertions(+), 5 deletions(-)

> diff --git a/env/Kconfig b/env/Kconfig
> @@ -763,12 +763,58 @@ config ENV_MMC_USE_DT
> +config ENV_SCSI_PART_USE_TYPE_GUID
> +     bool "Use partition type GUID"
> +     help
> +       Use the partition type GUID to identify the SCSI partition
> +       for environment storage. The first partition matching the
> +       specified type GUID will be used.

How about adding 'select PARTITION_TYPE_GUID' so that users do not
have to manually enable it. Otherwise the lookup will silently fail at
runtime when part_get_info_by_type_guid() returns -ENOENT

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
