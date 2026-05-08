Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66C9CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378DD84DC5;
	Fri,  8 May 2026 19:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ef31nY63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E05984DC8; Fri,  8 May 2026 19:58:10 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B5884DC4
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c82471904fcso1043297a12.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778263086; cv=none;
 d=google.com; s=arc-20240605;
 b=flGYsHW7bOaqklZnjNcKTL22a1rCgraHcFYa+T2JXdJswY9XUErps7PRAx88RJn741
 oGMM5/7cOpGf7tocCkbLTLXJpdSo25zR2WbBwhZNvNt5dPpxo/VQse4bZ2EC4b4Zfjh1
 ycFi5Am49TeHnxw/gD7tfbz0Kzg83KgoaU8tILw34Wc9Y1STlZjIX+r6x8AgYbfYRZnj
 HtBGfgTcvERNAkEvA0+g/LFZsV+tvh6eoF4V2Fljhpx2j/5etveSeXwQliPDNsDoBW7B
 8rFiP2uC+Wnki5+1RZKADy7JIrSs15qILan74mvbK+dlcW7FNtoM1Vss1lJ5Ccq4RAEo
 TNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xds8CXG3O/feVU2+2EDE6fpp7Y2n19vK17t0yieQ5QE=;
 fh=523FaTOBFN1Oloy6VXhCfiDzLq8MJLaBc5ZkYCBBq64=;
 b=B9+Noh9/D5NZA0Bv0+XTLR0KcFRu4nMGcZwXgcrbHDpboy4l3uGbtsM42GHSalxfUh
 jHXTyvibMktBHyiHsru9A2JX+TbVjx3C4+/8Hz6ZjgCASX4c/9H1J6KIv+kWQHFjZJcV
 pdzoEHXes3mZXDsg13f7Age8YHBnwzW0sdaFiyqsoLt7YRoOUpPQHUeVFwVK6V1zBc+V
 wwJYqcVkbukOY3q6fdttbQyU/iRRM7LG+NRk1w53L3JyV7Seo5JawqUpehdvVQ7KfDvh
 bsP0gI2P5eZfO0QESa/NWfZ1BMWR2x5CWQX4x8K5UH0qGgUdNjefX1l6RD4/KZVqSkGX
 SURg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778263086; x=1778867886; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xds8CXG3O/feVU2+2EDE6fpp7Y2n19vK17t0yieQ5QE=;
 b=Ef31nY63eMWzc4CexZWn2HTdD8tp0akYDRr4dYAcKT37gE6zkjdEtluQ0KDTqnohBh
 E76KZmC1Ah3ngUWsRS5n8M8/7Lg0oM6QMvyn8RbQdE92A5r8re5D+oLwY5QA96TFWzt8
 EdJjQUfG7H4Z6eKIe7n53m1VYbcJhNkeeGJH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263086; x=1778867886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xds8CXG3O/feVU2+2EDE6fpp7Y2n19vK17t0yieQ5QE=;
 b=JTqQnns8pDn3OwjomBMCsUgx1vBWolrq7QJnjfdmsUF1gTu+vLO81qqwlwt2hgdqiq
 kGRYKjLUy7tsNZ5+lVQU1A8hZDzBe1s//bVK5NtqD3cz63AyyXeJ6QMCPQw1rRfPkAoD
 dr0eNqj0zFL5pG52URIONkTEFu/fGLrLnHbCMOI+FRmjqHgVz1xUJRv5Y0aCxrkkRnJ1
 5QKWOslpekX0UWU/i7XLFJvRCzN6MEE7RA3A17juOsI3TBNx1dBoBgxfHYQLtW/dKuDK
 37FiZQDz/h3WlbE8Qa17KjZaIyog7uwl+VrsYT0MKnS9kQnQzpGztAIXqwWd+I+OmEcD
 LKwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tP2EOYwuO93NxXMyQsJTCyKssPwZTvvgjXM5z5220v//urxniq7JuzSPUfSQ1q29pzHS50Y4=@lists.denx.de
X-Gm-Message-State: AOJu0YzPoWvlyDCvL2RGe/2G2uLjySK0n6VvLhTP2TsvyF+odXe6vXeN
 NOKl3tTvrpisFzmPvuTHJA11XBbEjN3BTQmqwlY24RqH5LihZOhnwtm7mXbPF/tIR7OogvHd5s2
 Jor317k8qqX6LoTd1Cx5RUsFvjilivu3J6Jzqsxrj
X-Gm-Gg: AeBDiev4ievDTCMub0ZG4gqIKEuivDchv7UCugGzIbySWDg2QLYwIbaz2C3bwcjNEAH
 2vGUfBBKQ3amNs089/l81T9vllRqzgFPWY5Jjg5irldozc+EKKxsx8JbPALWFUCJ/pqsFLSqxNC
 TZAAkNO122irTlarx2yq73uO/cbaClmtdPEBfoHm+R0Nw1nTf1wPO2C3OZOHqIorQIcYPES+SIX
 5UqQB6wXL/wO95uK+FXuljpNm8/oCZdxnJGRYF/stMpvHvzvuw0psdMCvvQb7ceeF9CbxoBH2Y1
 HRYerA==
X-Received: by 2002:a05:6a20:3ca5:b0:39b:f8d1:a603 with SMTP id
 adf61e73a8af0-3aa5a931e3emr15840621637.22.1778263086237; Fri, 08 May 2026
 10:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-3-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260508084834.45637-3-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 11:57:47 -0600
X-Gm-Features: AVHnY4Kstp8PYIS7Rm62b7lkDLfa-wnc1KNaguPAghaMYqmjsuTRUBA-DJGwsuw
Message-ID: <CAFLszTjuOVvix7wiwv+MVCd7CkkU=5fT_4OHQp4qiDu11+tMtw@mail.gmail.com>
Subject: Re: [PATCH 2/6] sysinfo: add sysinfo_get_and_detect() helper
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Nora,

On 2026-05-08T08:48:28, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: add sysinfo_get_and_detect() helper
>
> sysinfo_detect() is commonly called after sysinfo_get(). Make the API a
> bit more convenient to use by introducing a helper.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> include/sysinfo.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> commit 4e2201c3294275168ba5ae00b20c9db89879474e
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Each Signed-off-by appears twice - please drop the duplicates.

> diff --git a/include/sysinfo.h b/include/sysinfo.h
> @@ -446,3 +446,24 @@ static inline int sysinfo_get_fit_loadable(struct udevice *dev, int index,
> +/**
> + * sysinfo_get_and_detect() - Return the sysinfo device for the sysinfo in
> + * question and runs its detect operation.
> + * @devp: Pointer to structure to receive the sysinfo device.
> + *
> + * Since there can only be at most one sysinfo instance, the API can supply a
> + * function that returns the unique device. This is especially useful for use
> + * in sysinfo files.
> + *
> + * Return: 0 if OK, -ve on error.
> + */

Please rewrite to describe what the helper does, e.g. "Get the sysinfo
device and run its detect operation" and describe it as a convenience
wrapper around sysinfo_get() followed by sysinfo_detect()

Regards,
Simon
