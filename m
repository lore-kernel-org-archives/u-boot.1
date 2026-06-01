Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368E9CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8CCB8490A;
	Mon,  1 Jun 2026 23:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iFJ4UFP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1AE584894; Mon,  1 Jun 2026 23:16:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C450584894
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-beb2a97cc9aso482900466b.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 14:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780348580; cv=none;
 d=google.com; s=arc-20240605;
 b=ik/mrN6kKD35Zrar9O/gb1KhqL1yCL1vvAHuoU9xYfeE18T8x1ErsMKez/tHnZntGy
 PLCoBPUsg2Lg7jmdcfdtUAlTUl8aGaC2oLypnDlIhg2CSzPEi4h9VD6xvfF48LywYXn+
 Pp8VFsOyj6ghapjVbaDPLje0/sMYC7gEwwL4K4VZ66+XA/ymPEwsTnFKztPknkmyJO7c
 vn/od0zXt1mX9Nz5rBQ5IAn/shkAcpXjpBaExtKWOjA0IbYGWFIFTGnwuJe0RVkIe+3z
 w++QyNrOX9iAVboKINZIVhaavP8t0Ewkl4XYCOynssOqWvetavcNQz+CRK3hHhPF/im+
 tYhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MGzr4fw4GJw03v+Tzb+hqpf0Tr5cpQir6InCw2wqsGA=;
 fh=p4bas+/hKuaFeZwp2X93pkiqty8BS1+dSiOvHwJZm4I=;
 b=Pa3sQZrwHS1jheY7JjEH4twVq0IRDQP8EU2zgTjHO5GBlV/3AfaTUtinDhwLTTVQt4
 P8PxYrkAynH2nbPjWHMrVDMqmzsurY/OJ+K/T1cWg1cdAgq5YN6l4e+cwAx6zqUQZySI
 8QTzr6QSraJMy3ypClHCaPFlrQHbtKfa4oMWFwBuEo7z20Z4ymWqLtv3Cm0xSDpk3Pi6
 gkfX1vIJtKzoMErfIZgdLe4ejBrIIfG8MiN4Vw9MdgvIRbQ2C6qqWspX+Oxybl+HQiWp
 fA6APB18B9zvid7CMArMrqL70skffKifJNNBDybUpLnsaZ6UiUFpMeiLmPlMPtO+6ich
 Z56g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780348580; x=1780953380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MGzr4fw4GJw03v+Tzb+hqpf0Tr5cpQir6InCw2wqsGA=;
 b=iFJ4UFP89qkIz+fVrvY+JRYEZa7PGnmApWtMA2ZWUVXluy7aWULWI4p3KbKgTpJmA3
 F79QOBVbsSE6caxRSieWM/qqysfIQSsRkTUogym/3RNaawk57lq2YbwW2sCsD7iZl9fn
 25de7ZVhbm3yAx8FtbGYUiVIfH5UopJZrk3eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348580; x=1780953380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGzr4fw4GJw03v+Tzb+hqpf0Tr5cpQir6InCw2wqsGA=;
 b=MmzUuuAOvVIKpxJIKhskYpU5fIEkVtGyVojlyDEHVUkpvpjq410/kcyVm1xo64vKlv
 s77+6h83ScIOChuCgKsYusJNpuVTvLCdxquvxbgt52xeVV4tDFmLH0ViOYZvD2mFie3N
 zdraY12HebcYNqSNQQycVAmjE0MG8zrNRlFTPTmzczaM6eUEMpf14jLgkoWEaV9SJuVO
 zs4Eq9ffeoqnlgOvWYciFaDn7jGaw9z9COt7AGqMBXTdYOpjKmz7rkyLgjCC1MiNLUSK
 aIAO0V4rhC6e/OvpvinjrWMw0wmDRFStwmIxmieMfwHAsS5Jt7rMe7GoGT45VUUWymNc
 9ITw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ptpHY2JQZ8XKTawAQsnfmcxsh+9LycoU2SBcQZbtrNXCX/xz7SRUoFmVFi/b/gKS12fhlQWI=@lists.denx.de
X-Gm-Message-State: AOJu0YytpNu/SJ9p24yCkztQDQaHDqlP1xLUK+Nayngn+9Fn0ldhhTh3
 qWvk02dKbj3IMIGMl8KacyvmVk0Rgu1aalixSEPJlFxe/e0lPHBz4b3da4w+JVXUdDORWldWVMJ
 tjBUenriod4u0q+xWjDk1o6ZdJcFZiIA/2RfHN3QGCHLmFxYMiIE=
X-Gm-Gg: Acq92OFdrjgA26tlM9wt9kf9fhfKFIIEK+Z1RRTqXzjV5VQE3DHtMsYZpDnhSS6DGJb
 0yvomZ9ZulcbHCqOVbo15eH3Yz9UBIFvXfz1cThhkjoJe5PvHVUGvP8lcuiyIeNWr0NPKcyhKJA
 wkfVSiJcnDDPYj9r1+ncOK7F+hNmZQWXck/iTRaAaSfneGtVXcxMxcMJqzXtn9b1fBcAeI7GUqn
 gT5+flm++ZpjUXdF7Bs8nd9tfTRWC/AGlNZG7FsNuMqK5epWNy96hyKRbiXCG5bmGYDQCRI7MJE
 4byVJQYx0EHI63fX
X-Received: by 2002:a17:907:e107:b0:beb:2665:f37c with SMTP id
 a640c23a62f3a-beb26661a5dmr377965966b.46.1780348580241; Mon, 01 Jun 2026
 14:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
 <20260527095123.50797-6-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260527095123.50797-6-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 15:16:04 -0600
X-Gm-Features: AVHnY4L1Km01tB559mEz7qojSIITtDMTHkaglmelihwhHoWn8zzDW_jPFhTzEoE
Message-ID: <CAFLszTjGAaYGR=i7Yh4eFgCi9MrbxdE6VLO_D6X1X3wJrZRZPg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] arm: dts: tqma7: add eeprom nvmem-layout
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

On 2026-05-27T09:51:17, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> arm: dts: tqma7: add eeprom nvmem-layout
>
> TQMa7 has board-information located in EEPROM at offset 0x20.
> Add necessary nodes and properties for nvmem-cells.
>
> Revert this commit once the upstream linux device trees are
> synchronized.
>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> arch/arm/dts/imx7s-tqma7-u-boot.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
