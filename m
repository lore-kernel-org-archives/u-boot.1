Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3602BCD13DE
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 02:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE18E843B6;
	Fri,  1 May 2026 04:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XMS54ZEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4084B843D4; Fri,  1 May 2026 04:12:47 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5F984255
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 04:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so264377466b.0
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 19:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777601565; cv=none;
 d=google.com; s=arc-20240605;
 b=SO6VzylJZtiPCWQ2U4RY51Iof20QCgWujOX8hkiTNfVEVzZeD0tDIDzsmaSc3xuYo/
 JfAxoq6bfkjHaRDxD6v9fZxEpJrfFD4tUq2z7IqUdcw2AQL+GJRRtjT7HJxAfPvUZeRU
 BQmjUGTZSDuOFQidlg8URcEH+PShmVJI2AzqsKnfJqcPBeRoSqHSjoVNGIBfoE1wiAfH
 OhEbGCeyv0WZawSzZlLaABn38cBBMHLyHStqq14bkhyzF9X7g1wPx4uvtloIpdQmLQ5f
 9xsMV9oYDVZ++/4lnBSJW6fJyecN+kCSgenagSVF0PAcIn3mJcHWMfIT+VByHA53riD+
 t6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E6RmBx4GIq1z44VWGwVlM/SIh0E96ewEi09zPevC0lE=;
 fh=Hlp5JdeYs7swG/WVo1DQPRB6YL+9MtR5xSI8ADFgAhI=;
 b=Yxz+JS/sR9zJij2C/OlacI80IVva3iUG68nSNpUqf1a02khew/pa5/Kc65u9u1OvSI
 mmYW2F6AWm2efuQ7vNFh5UFdc+GfvK3ed3ZiVNHn4vr9eEVTDgg5xEkkoRZ/IKhA/O1x
 jzcNH0JjuS8g9xGXKlj139yYEsOlPJXNNqAHEzNxLJAKkex8snZmENHSiWZKdAZgnLgd
 JrbGVGQOEyq3WAIeCFrwrLU66vBJ93xMh+f4c+We3C6wI9woHsWtf3FFFwGymC992Rk4
 JY+iS7vETX2pGT74jipzzIfZ4fL07Rg4XLtAla/R78PbiO6nDM8RliKa5tdDTl3U87vY
 cOxQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777601565; x=1778206365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E6RmBx4GIq1z44VWGwVlM/SIh0E96ewEi09zPevC0lE=;
 b=XMS54ZEQkJDBlvR2K37z1yJvOKgA7ErWDrFDmzjGQ0hs3msPOuCCpqoYoHnQaqRXLb
 nvdvvTE+GmnDTKhWKKt+kuloZ4mg+Zyedh4wPMxFFZWSfNEOBfiDiH6tkOba69Fkt6hl
 zLmaUrE40Ksow7ukBnKGLMFd+N8nu0ARQSA84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777601565; x=1778206365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6RmBx4GIq1z44VWGwVlM/SIh0E96ewEi09zPevC0lE=;
 b=WaEzXMjibNJk94RSEIETMs+nvJfKzMxKFwFIOO6kZ2dYiFDqF+jkm3zsJwC1jX+SuU
 LBfISz2zNwIo3VvU0oP1AjuCDh63QG6pBJ45zx+XYH8ybjiBhrftKDIrsezAfTrMcclz
 AZ4pyrhaU0jU9XgSPuEs2MgUINWPcbqj5GzMzIoch21uR2c12gkVuMk/W11J7ESczHvQ
 MDHQ6VtEOMpe/VohH67ZFp0Rj2ouQ/aJulEfu9M3/xN0BxvyDP6M5ki9sKwopmiEkhn/
 wY29lfzx5c0rTOZAc1obPQZljpoiGCuLiRgRXQWzKX+lau7/w3ipzTA9Oim/i1sbgwoD
 fZBw==
X-Gm-Message-State: AOJu0YwX1OnezB/jQXb+AyLRR3IuiPVyILbeOxBQgGvj+mlMw6bewI5v
 vos3vm40sQF/HT6pZgfXb/J1wEGLBk1On0fsBFRC16q1ECtEIcxcfoLYaP5DyZVQNHlZ4FQUljD
 m0V0RcqSk3ER346q4sYWKmsDQPeQaXYw+61fZ64eh
X-Gm-Gg: AeBDies4SZ8w1mCVsguYrCkfq1rAL3mGmPo08P/YwFjTT1MxRHmxJEYWPayp0VUjcvn
 jmgHdXyX/05H7n87b/F38rd+LfhIWKddHIbnPQ5hUdIYEzkxhv1wPmfTfQvrmCNZaCEktIuNw4T
 X9Jw3gZtRLWzI/NOM5spL0UWbd/5vHf2+1Qj06l9/LGMpGr5iQaSRE6oI8sFtILMuFQ4LOFva9C
 hGoTpgGhsD2YlSWOgHVONLiN1nQ5i0r3bE+s73kKNDgs/Vd8oQRPBTLwxINtmyQN6u9Puuq9dmV
 xnNCuGwiMjhJI4ep
X-Received: by 2002:a17:907:6d15:b0:ba8:30a6:c35a with SMTP id
 a640c23a62f3a-bbac4aca22dmr352646066b.6.1777601564785; Thu, 30 Apr 2026
 19:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
 <20260428-type-v4-2-b7051dc45a88@oss.qualcomm.com>
In-Reply-To: <20260428-type-v4-2-b7051dc45a88@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 20:12:33 -0600
X-Gm-Features: AVHnY4IIjjcFfmxA2Bx5r4FK-w9InDpTkCwcEHcm4FUKWn-znR7yfndS8pV7IaA
Message-ID: <CAFLszThVZWo=nD8hfMbCfc2u3EB0j0WO+Gmfa0QfY_nBC8bWjA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] scsi: Add partition lookup by type GUID for SCSI
 devices
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Javier Tia <floss@jetm.me>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michael Walle <mwalle@kernel.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <simon.glass@canonical.com>
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

On 2026-04-28T07:31:42, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> scsi: Add partition lookup by type GUID for SCSI devices
>
> Introduce scsi_get_blk_by_type_guid() function to enable SCSI
> partition discovery using partition type GUID. This function scans
> all available SCSI devices and searches for a partition matching the
> specified type GUID.
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> drivers/scsi/scsi-uclass.c | 23 +++++++++++++++++++++++
>  include/scsi.h             | 11 +++++++++++
>  2 files changed, 34 insertions(+)

> diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> @@ -47,6 +47,29 @@ int scsi_get_blk_by_uuid(const char *uuid,
> +     Reviewed-by: Simon Glass <simon.glass@canonical.com>

Reviewed-by: Simon Glass <sjg@chromium.org>
