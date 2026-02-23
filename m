Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CEFEC1117
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4533782BF2;
	Mon, 23 Feb 2026 18:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="leJ0y5qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7F283E40; Mon, 23 Feb 2026 18:51:23 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D327A83DEA
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65c20dc9577so8649874a12.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869080; cv=none;
 d=google.com; s=arc-20240605;
 b=aD37mWeea64RaWu2pA+8+HsSduy64tcPQjshElc7zdF2uKoVS83I6UqUWvshvrn5xt
 sPjQKm3GF/VhVG7jyhPwf+Ba8s8YCTgEKDvB/BwQNNHSBTxajYGgy6eZVgF85vkR0adF
 PFm01lWlooSCvVnqT18qKsKU9vJ78tneLCnPi5C/zz4wa731s4OSxgWenIWBtn7Rp+XS
 8M+Ajj84EzpeNOIpzo2lj2Q3Q/RlN40qPUvmOBFbjfgxk1sm9qATQEI4/MYANLQmXgMi
 1UoXHAkApGEULWJfdopseDbiY7PabCxhizBs+k4nPxMlqWR+o4efjMTFI6m3HKzLkwoN
 URqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n+Fj+FKZr/f02YWjYyijShcHgsbPR+TU5q9V+rbFSUk=;
 fh=GWWGynSCQ6whjMxEhi67LRdRPreleBh5K9aBxP67Sp4=;
 b=KpiQ7j+k9+mfuX7zK5eheqEXjbUMLrvf+xPygfs0SNGisw6KFl1vfeGaUw+IOyTuN9
 4tM1O9+I444KzVCOf0durRxPCm3vpudrSWFd8KaXwyj02mVJ0mxo/TEWMrdyuVlUFM5b
 8Lh667QFUa9G+y1uhpk5U30JlxpYP0L+vGw99EenveSv29j+mee/Z5lZKbFLTPr7GUjM
 pRQqPD0h2ZOiaAESh7CmU6W3Y2DKDsAm6IwNxO7d3vV1mJLibCqEdKd4tznHleOi9Bmc
 56mEZHL4End4aZOXLMdmpIWmSx2aHOnndu4tIAcwpaCmIjd8M4NcK/E8SojEmepCjd93
 JXXQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869080; x=1772473880; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n+Fj+FKZr/f02YWjYyijShcHgsbPR+TU5q9V+rbFSUk=;
 b=leJ0y5qNJlf53CNDT0jyH4sibcROxXo1quHww/8GpWuJxQRLgSle4bskEgHuZKZ5Sp
 gyPkPW0jPOhh7qjRcojM3YOmpXdVHbRCsfGktZtrrq9fC/W8UG6vProIzexxnWQ3BXMC
 ZoZo3Z1+CuS/B51Ch3g1nDrKvnBP+AzjAjOM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869080; x=1772473880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+Fj+FKZr/f02YWjYyijShcHgsbPR+TU5q9V+rbFSUk=;
 b=AO7Ig29SaYme+h11iZeX4Fb9PlDpAjuE8NoksdOm2TYohTAFAoREfBo2pui02ngvSG
 S5vjran9/06D9sTMquAbwRKryM3zhVF7SBZ6LOy8KNYPIitQQWvAF0JOhblqA4+9GjL6
 8EuLrNOdZtscV7OcPhfOy1qWo2vxyx3hN9tj6TjuzL1WJcygXtbiaB9LqLC1jRe3InIt
 pkRsFmaQ5V92J2jb1V/AlXtoQ+/TFSBCmRCdlrGe+fhAlDRqqSQ+i7ikpooTYIPuAzsq
 kOV4lX9e7lMlzopKGVhnAn3MbghTO/Nq8AToiSZd99JDW2h59sIC78GNFpJx0hb0CRc2
 fhPA==
X-Gm-Message-State: AOJu0YymPa9CbpwKlHh1AhNKor1+xhdP7KzzbZKXnaUQzyKUGzONs2vd
 Xx2pvnHuTvuLxUQ2iP43kGCfWy434gl3aIYqfl5Y8Q8hZ/luqUw6ZeAYMFvs0XYcoc9fFms/MuD
 o8xgNFRr9ovnbuL/CoAilZXw7eM9e8KDp9DNkO+Pt
X-Gm-Gg: ATEYQzxE1idLZDxifnKd228jGk0rENuXLS1SRtR15JzcVbjUQgC3SdFgPJi1/AzrGcq
 i+Jxqsn76U2f3Z4l07a7yIc8qwvA065jNonLQcNPeUlkV7Ajkmk5XTRd64mR9QckZIP7AR93/AS
 eJ73dda62Q9v4t+XRHzDfnmmy2B1dPjDA9WySShw05kwWL08Pg5NQqCvM9vntXY9jDDKoMCQElB
 Xav6FZHE4osI+q0p48Dob+HQTlqvjVGaJ8yZotclCWtY79hWE7/KpvyywTl7IIqYoY9cOCHQSdu
 aE3RYQ==
X-Received: by 2002:a05:6402:f18:b0:659:4b76:74f4 with SMTP id
 4fb4d7f45d1cf-65ea4f1a583mr3962881a12.16.1771869080183; Mon, 23 Feb 2026
 09:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
 <20260221094252.3103034-2-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260221094252.3103034-2-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:02 -0700
X-Gm-Features: AaiRm5272kTLBkLjv6sE-0LdZqjQi1SrrxAw7406UxPifJv6UWhStKAfsOXWzdE
Message-ID: <CAFLszTjy3zaNGjThFxr+SzfpjhVEE38ycGGA0SP4mwLBr_XnJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] spi: add support for bits-per-word setting
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

Hi Dario,

On Sat, 21 Feb 2026 at 02:43, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Allow dynamic configuration of the SPI word length. This is required
> for controllers and slaves that need to operate with non-standard
> word lengths, such as 9-bit wide transfers.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>  drivers/spi/spi-uclass.c | 19 +++++++++++++++++++
>  include/spi.h            | 12 ++++++++++++
>  2 files changed, 31 insertions(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Thoughts below

> diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
> index 49b584c648d6..a4a3b6c25b7d 100644
> --- a/drivers/spi/spi-uclass.c
> +++ b/drivers/spi/spi-uclass.c
> @@ -91,6 +91,20 @@ void dm_spi_release_bus(struct udevice *dev)
>                 ops->release_bus(dev);
>  }
>
> +int dm_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
> +{
> +       struct udevice *bus = dev->parent;
> +       struct dm_spi_ops *ops = spi_get_ops(bus);
> +
> +       if (bus->uclass->uc_drv->id != UCLASS_SPI)
> +               return -EOPNOTSUPP;

This should not happen, right? We don't normally include these kinds
of checks in U-Boot, to avoid code-size costs.

I have long thought about adding 'CONFIG_SAFE' option behind which we
could hide checks, which people could then enable if they with:

if (CONFIG_IS_ENABLED(SAFE) && bus && bus->uclass &&
bus->uclass->uc_drv && bus->uclass->uc_drv->id != UCLASS_SPI)
              return -[error number to use for all of these checks];

(would need to check dev->parent and ops too)

> +
> +       if (!ops->set_wordlen)
> +               return -ENOSYS;
> +
> +       return ops->set_wordlen(dev, wordlen);
> +}
> +
>  int dm_spi_xfer(struct udevice *dev, unsigned int bitlen,
>                 const void *dout, void *din, unsigned long flags)
>  {
> @@ -144,6 +158,11 @@ int spi_set_speed(struct spi_slave *slave, uint hz)
>         return ret;
>  }
>
> +int spi_set_wordlen(struct spi_slave *slave, unsigned int wordlen)
> +{
> +       return dm_spi_set_wordlen(slave->dev, wordlen);
> +}
> +
>  int spi_xfer(struct spi_slave *slave, unsigned int bitlen,
>              const void *dout, void *din, unsigned long flags)
>  {
> diff --git a/include/spi.h b/include/spi.h
> index 2783200d663e..a92f54a7404b 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -729,6 +729,18 @@ int dm_spi_claim_bus(struct udevice *dev);
>   */
>  void dm_spi_release_bus(struct udevice *dev);
>
> +/**
> + * Set the word length for SPI transactions
> + *
> + * Set the word length (number of bits per word) for SPI transactions.
> + *
> + * @slave:     The SPI slave
> + * @wordlen:   The number of bits in a word
> + *
> + * Returns: 0 on success, -1 on failure.
> + */
> +int dm_spi_set_wordlen(struct udevice *dev, unsigned int wordlen);
> +
>  /**
>   * SPI transfer
>   *
> --
> 2.43.0
>

We should probably store the the wordlen in struct dm_spi_slave_plat

We could even avoid a new operation, but then your driver would need
to set the word on an xfer() call. Plis your new operation lines up
with the existing ones. So this seems OK to me.

Regards,
Simon
