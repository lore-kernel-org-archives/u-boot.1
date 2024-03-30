Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61618CD1283
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 02:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F5588260;
	Sat, 30 Mar 2024 03:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="u0Gsu4gb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B5BF88265; Sat, 30 Mar 2024 03:18:16 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F57A8825A
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 03:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-dcc4de7d901so2148050276.0
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 19:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1711765092; x=1712369892;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4oroLukbr9TqLDZXP+XPJ+GcAWINCsZFDUCcygkjmAo=;
 b=u0Gsu4gbTTWlwXfv7kAClWGMmoY42lKdPynDtsbrzqACvm3ONdjlymDoP7WlZ2VCPD
 Y5QGewvzhnTNn7nP+hC5CWrNK8x5Vrm2uvogw8TAjpc8tRFERali1w/9KLUTAFmRqRB+
 xcMfOnY1cobFqACKqaJ3T5Ic1yHu/t7KFZKfHLvMRJWlIKb07sTFqAslklp4pyRcG1gs
 nK6StSEp7rOOEEEV98doQfyy+wB6aCw7q45P4X0A5N4hDArqZE+9YTHaPbN+CQJSV18S
 /5t3nUl07kj73IWqRmM3p+cF/58Mv6eEfkH8NarH2v52zIKLw6+9Vkg+Hd8cparfSL27
 apiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711765092; x=1712369892;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4oroLukbr9TqLDZXP+XPJ+GcAWINCsZFDUCcygkjmAo=;
 b=YS9aO3cUNQzay1vz296oTQx33+Jb1is+ad59SoAivozjT7opXwOvOiJ5h8CUrsbuza
 ARoD7TqsoStKpphjAa3FbRizh192v/LP1tzQyUCguUKG2jgH4ovJro1Qu0B7A6aM/KqE
 8808aY9CFxTUOHLZjgNraUn7RIf7X65Zo5xcMIsruoXuUFQCmNlmCXJ4XAJg63jZn5dn
 2/hhu3kUortsHGuLKjtCjgQpqyzFFyYz+v3mcNjKNVr4KWViKSbB+X9r1g1oDnQRHclE
 yZQSM/z+Vh1chjw7Y+SOf5v33lSK02zFuxIsy9phJnFOLFaxU4vzQBZYTLiTGLs73JLG
 whRA==
X-Gm-Message-State: AOJu0YyIpQOpj/D7HEJ+RPuUctCTGgl6rNilYKCw87eD4g+sIwVUgx2m
 X4NNlTK6jyoqwyBGTpj2I2yG/eSXBCZadgm3uBjH7rB+vaOo97eTb2ReSJ58bDbN+IIgkoxMn/i
 aR1+f71BXyljwKsNJCwamzML84e7P85SvAYVRPdzK7ueXRhf7/Q==
X-Google-Smtp-Source: AGHT+IERkquwm32iBIefSZm70Pv3r8/7egM3D1wmpCWQEKkpm6IWvHCjw8YCjV16/ZDadxInjrYcWTcwtYTKqIgoT9w=
X-Received: by 2002:a81:92c7:0:b0:610:e328:dd8d with SMTP id
 j190-20020a8192c7000000b00610e328dd8dmr3895019ywg.23.1711765092082; Fri, 29
 Mar 2024 19:18:12 -0700 (PDT)
MIME-Version: 1.0
From: Greg Malysa <greg.malysa@timesys.com>
Date: Fri, 29 Mar 2024 22:15:59 -0400
Message-ID: <CAAjXUao8q+u9Z+yXaMTuCw_9CnyGkknRijw9T_WG22-hmzvR8g@mail.gmail.com>
Subject: Re: [PATCH 01/19] spi: cadence_qspi: Add support for DDR PHY mode
To: u-boot@lists.denx.de
Cc: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, jagan@amarulasolutions.com, 
 n-francis@ti.com, Michal Simek <michal.simek@amd.com>,
 venkatesh.abbarapu@amd.com, 
 git@amd.com, T Karthik Reddy <t.karthik.reddy@xilinx.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
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

Hi Tejas,

+Ian Roberts,

(Apologies for the double mail--I accidentally dropped the u-boot
mailing list in version 1)

We have been developing OSPI support against the same Cadence IP in
the Analog parts (SC594 and SC598) and we have some specific feedback
as this patch series will affect the driver's functionality on our
platform and require changes to our upcoming patches to work together.

> {
> @@ -353,6 +649,9 @@  static int cadence_spi_mem_exec_op(struct spi_slave *spi,
>  break;
>  }
>
> + if (op->cmd.dtr)
> + err = cadence_spi_setup_ddrmode(spi, op);
> +
>  return err;
>  }

This appears to trigger calibration with the first spi command
received with the dtr flag set (cadence_spi_mem_exec_op ->
cadence_spi_setup_ddrmode -> cadence_spi_setdlldelay ->
cadence_qspi_rx_dll_tuning). However the calibration code assumes that
this command is a read ID command, because code has been added to
spi_nor_micro_octal_dtr_enable specifically to read the ID first. This
will cause problems if we are adding support to another chip and are
unaware that this host SPI controller detail needs to be added to the
DTR enable function inside spi-nor-core.

in cadence_qspi_rx_dll_tuning:
> + id_matched = true;
> + for (j = 0; j < op->data.nbytes; j++) {
> + if (spi->device_id[j] != id[j]) {
> + id_matched = false;
> + break;
> + }
> + }

This should probably just be a call to memcmp.

Additionally, this assumes that the ID has already been read into
spi->device_id, which happens in spi_nor_read_id. We believe that
setup_ddrmode should be self contained, for example generating a
non-dtr ID read and store (locally) first, then reconfiguring for DTR
and issuing a DTR read.

Based on our experience with the ADI EZKIT, reading a 3 or 6 byte ID
is not always sufficient to perform robust calibration, as some data
lines may end up being "calibrated" against a constant value. For
example, the ISSI flash chips capable of DTR include a "data learning
pattern" register which could be used to ensure that calibration is
performed against a 0 to 1 transition and a 1 to 0 transition. Such
functionality will be chip-specific, so we need to a way to connect
what happens in the dtr enable function in spi-nor-core with what
happens inside the driver (possibly another ops function).

in priv_setup_ddrmode:
> +    /* Disable DAC mode */
> +    if (priv->use_dac_mode) {
> +        clrbits_le32(regbase + CQSPI_REG_CONFIG,
> +                 CQSPI_REG_CONFIG_DIRECT);
> +        priv->use_dac_mode = false;
> +    }

Why is DAC forcefully disabled? On our platform we can only achieve
max PHY mode performance with DAC enabled. Can we provide a
platform-tunable flag to control this?

In priv_setup_ddrmode:
> +    clrsetbits_le32(regbase + CQSPI_REG_RD_DATA_CAPTURE,
> +            (CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK <<
> +             CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB),
> +            CQSPI_REG_READCAPTURE_DQS_ENABLE);

DQS is not required for PHY operation. Some chips can operate in DDR
mode and don't have a DQS line; we have one of these on our boards.
Please make this configurable

> +__weak int cadence_qspi_versal_set_dll_mode(struct udevice *dev)
> +{
> +    return -ENOTSUPP;
> +}
> +

Setting the DLL mode will not be a Versal-specific function. Can we
rename this (and other Versal-specific names) in order to make it
clearer that each platform integrating this IP is providing its own
implementation for this function, rather than it being a uniquely
versal-related capability? For DLL mode in particular, it may be
sufficient to check for a device tree property, which can be included
in the generic driver without any platform-specific functions.

In cadence_spi_setdlldelay:
> +    priv->extra_dummy = false;
> +    for (extra_dummy = 0; extra_dummy <= 1; extra_dummy++) {
> +        if (extra_dummy)
> +            priv->extra_dummy = true;
> +
> +        rxtap = cadence_qspi_rx_dll_tuning(spi, op, txtap, extra_dummy);
> +        if (extra_dummy && rxtap < 0) {
> +            printf("Failed RX dll tuning\n");
> +            return rxtap;
> +        }
> +    }

Can you please explain the extra dummy cycles? Why are more needed
outside of what is called out for in flash datasheets? This looks to
us like magic compensating for a calibration failure or a
configuration failure where the flash chip is not providing the
expected number of dummy cycles.

in cadence_qspi_rx_dll_tuning:
> +        ret = cadence_qspi_apb_command_read_setup(priv, op);
> +        if (!ret) {
> +            ret = cadence_qspi_apb_command_read(priv, op);
> +            if (ret < 0) {
> +                printf("error %d reading JEDEC ID\n", ret);
> +                return ret;
> +            }
> +

I see that this cannot use cadence_spi_mem_exec_op() because it would
recursively trigger itself as the calibration was not yet completed,
but as a result this does not support all of the read modes that the
device could be configured for. I think this is further reason to have
a specialized function for enabling DTR rather than triggering it on
the first DTR operation.

> +static int cadence_spi_child_pre_probe(struct udevice *bus)
> +{
> +    struct spi_slave *slave = dev_get_parent_priv(bus);
> +
> +    slave->bytemode = SPI_4BYTE_MODE;
> +
> +    return 0;
> +}
> +
> +__weak int cadence_qspi_versal_set_dll_mode(struct udevice *dev)
> +{
> +    return -ENOTSUPP;
> +}

Although it is likely that any flash supporting DTR uses 4 byte
addressing, we should not set it here.

> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index faf02c7778..5895b5de09 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c

Can we split the micron-specific changes into a separate patch? I
realize currently that they are tightly coupled with the calibration
implementation, but after changing the calibration implementation
perhaps this will be possible.

Some additional comments not specific to any part of the code:

How does this patch address the case when the calibrated frequency is
faster than the non-calibrated mode can run at? For example, if
spi-max-frequency is 125MHz, but single IO operation breaks down at
speeds greater than 50MHz? (This also happens on our board). Also, the
calibration algorithm doesn't appear to re-calibrate the read capture
delay register, which is required whenever the clock or IO mode
changes.

At Timesys we have a set of patches that implement DDR and PHY
calibration for the same Cadence IP that presents different solutions
to the above issues. However, our patches only support bypass mode
calibration and direct mode, because they are the only options that
work on our hardware. Would you be interested in looking at our
version and working together to create a new version of this patchset
that can support both of our platforms at once?

Thanks,
Greg

-- 
Greg Malysa
Timesys Corporation
