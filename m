Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DA8C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 11:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E33E865A4;
	Thu, 24 Aug 2023 13:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GB28sl4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F17C865A8; Thu, 24 Aug 2023 13:53:03 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCE28657C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 13:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1c134602a55so1196946fac.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692877979; x=1693482779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Wc4ZbRSRsSB1iIMj2kXIFebA5KnBuPCC9HLkgUsOyw=;
 b=GB28sl4FzcCSJ000o3qEEsrbOdx9U5VI5G0nxDeNsSYC3snTw2ylBIzz9cJHMLogLH
 Ym+PAIJFJhDWDX1ia6aYI6WwA8qKeE9/RAH0hDmCq7B2Yx7y2PaQzMNHmCE+rFGyCIOa
 6u8g5X5OIpv2yY83BoRiZTvJkoeuezH0+pd8aB++rpoSCpPbn4OSV2fRXb/1W6MHc4Xy
 fGj1bkuDx1fxGlEm4Hv6+W8JcUGkSCOTo4tbG9IHlbmqKbesOsdCOHDIW1zI0yQcWhSa
 QmS7PFlIhIUHhbTJAArUIqJfNEzb4r/laLaJ9zBSrhdzzphHTj1aKkTCZIA0KNcuWFIc
 dAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692877979; x=1693482779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Wc4ZbRSRsSB1iIMj2kXIFebA5KnBuPCC9HLkgUsOyw=;
 b=Pc3T2g7eZW0EkPm1Kvm/2wLZKfJ4y8kLHUwHZflTp6TIuegfQileinh1WB3Zrh4mT+
 GIH9NcsdZ0EykzxLGkUWptkfY/ygPnK6bFcdBEr/0dDrQZbh60iQzeXXZXF1DMJnrofo
 HBis6hwFVa8mN5b59a82s6s2de9cgLr/0SJe3DsljGqSM4FbYUhErK1ZaPyBSyzfksjW
 BW406SmrcXYrWCP4V2BzuHLfpqa8DmnfsG8eue53q8d7+PUzNY/BYbwjwOqb7GLCW2wO
 Ab2N3eDc2ve6JUjtGgDGDDbKUl0pkKz9Y1/BfymTMHwmFVncX5ZTnVufO53op4s523Ce
 8tkw==
X-Gm-Message-State: AOJu0YyhiUjuaUcYkicSym6281UHlR/eGFAeUdGQzT+J+VuTshJjEGYP
 VHEOzVEceMexavC+upehbUQHKOCDF6CjiS6dET3ZCtSE
X-Google-Smtp-Source: AGHT+IFc0/iQGkGaNMLGM3G7vnBji5m2nmMnaHL7kpr0s8uoupw8wYR7sod8KTNVsR1V/Aw23F6IkgXjIwn/OfZ6Uzg=
X-Received: by 2002:a05:6870:8a25:b0:1ba:2e90:cc52 with SMTP id
 p37-20020a0568708a2500b001ba2e90cc52mr18259660oaq.5.1692877978984; Thu, 24
 Aug 2023 04:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230817085711.45339-1-t.remmet@phytec.de>
In-Reply-To: <20230817085711.45339-1-t.remmet@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Aug 2023 08:52:47 -0300
Message-ID: <CAOMZO5AQUPKM7GdLVRM1UZNLw4W2PXQ72L2vtQY7vYr_wmSCMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] PHYTEC SoM detection for phyCORE-i.MX8MP
To: Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 upstream@lists.phytec.de, Daniel Schultz <d.schultz@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>
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

Hi Yannic,

On Thu, Aug 17, 2023 at 5:57=E2=80=AFAM Teresa Remmet <t.remmet@phytec.de> =
wrote:
>
> second version of the series to add support for EEPROM SoM detection used
> by different PHYTEC SoMs. The EEPROM data consist of 32 bytes containing
> information like PCB revision, RAM size and other SoM specific
> configuration.
>
> For SoMs of the i.MX8M family the data is written to two areas of the
> used i2c EEPROM.
>
> We initally add the detection support for phyCORE-i.MX8MP. Due to layout
> constraints phyCORE-i.MX8MP SoMs with PCB revision 2 and older can only
> make use of a lower RAM frequency. This changes with the use of newer PCB
> revisions. We make use of the factory flashed EEPROM data to detect the
> PCB revision and select the fitting RAM settings.
>
> Changes in v2:
> - fix wrong RAM Timing values as pointed out by Yannic
> - removed superfluous goto
> - removed blank line at EOF
> - fix string conversion to integer
> - fix typo s/revsions/revisions

Could you please help review v2?

Thanks
