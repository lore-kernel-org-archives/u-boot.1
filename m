Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43767C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 14:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C9E87986;
	Wed, 27 Dec 2023 15:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z5FP++2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341C787986; Wed, 27 Dec 2023 15:15:22 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B17887866
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 15:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a270200b9c1so170708866b.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 06:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703686519; x=1704291319; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h1vr09ttMwi1groOyI9GN6hFV4cRCguSYkIrIgHUGnY=;
 b=z5FP++2C3uA9dHggfOpdkrdwOt42yQJZjf61xkSKOsJQr40ZZnj2+Q0GtkiBZ8aC1C
 ma3JjV1j3WKtFVH2DeY3ZCy+I3cMAJhZVQ8I/oLLdb0RdZWNl53AGwtnZXihrwjQEg5T
 rS6+gzeKezhce4CGjQIvsW/GuUHwKLdZQLm2lATM/cCBu5Qe8re8Qvnu/nXJ0lTdu9Ce
 L2HLONjC9y9c2pe4EVkVQG8uQuNd3sHDCpGDDNs49Sfpj3cc2HFguOkoHyKG5rKByDMy
 O7Gg+r48onN8J/aDffMgrN0oTu1KfpshjpLeg+spNbk5Qz8xQN2cKFSAmWRbR521eqhH
 KvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703686519; x=1704291319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1vr09ttMwi1groOyI9GN6hFV4cRCguSYkIrIgHUGnY=;
 b=rE8zAfn+8u/X7Alr/AuOcW5+XzMqA6f4vaZ+uqu5deN9QWEu0XwK41lNIgW6h0R0Oi
 Mqh2btLcqnGdDPHKfGm8MnBCckuVR5vMxS6fOTH/cPNJ9+kmJMI+5tl9N+8rQR0hqUDD
 B7zVKUt3r5o31fn5KYS1G3i7sUsWHth4huS/ZXL4xGhSoR3KV9KMJ5ashG2FPAQK8kJc
 1CoiYoob/jk6FX1fzi48gDGbCGu/7S3mLjrjhyV5oBxcqpEhybsjXYNT6OD/6tF7EfCr
 CHKFGlobxY6g0SXG/zFjMleoFgG35bIFDoTaryya8ZyWlZHCjyFnuFv3Z1gCZnuAkuBy
 IQyw==
X-Gm-Message-State: AOJu0YzT6TGnczmbtl/7DaKfbCDy4s6oKh7wgGnX8TVLGqQYC+4XHYAY
 TiFBQesiq49Hnjn/tvyWtZrIpaeWH5UHyQ==
X-Google-Smtp-Source: AGHT+IEHoVuflkuAFwJ7SoUQGcLtM0PRUyPSGcpFUfMN9QY2Jj/XMcPl+LmfE9kwZjKyYgDD+NX42Q==
X-Received: by 2002:a17:907:1049:b0:a26:f04c:4be7 with SMTP id
 oy9-20020a170907104900b00a26f04c4be7mr2016687ejb.59.1703686519723; 
 Wed, 27 Dec 2023 06:15:19 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a170906094100b00a26ae006522sm5856969ejd.122.2023.12.27.06.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 06:15:19 -0800 (PST)
Date: Wed, 27 Dec 2023 16:15:17 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] test: unit test for smbios command
Message-ID: <ZYwxdc1Sjpzrs-tP@hera>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-6-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223004429.247301-6-xypron.glpk@gmx.de>
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

On Sat, Dec 23, 2023 at 01:44:29AM +0100, Heinrich Schuchardt wrote:
> Provide a unit test for the smbios command.
>
> Provide different test functions for QEMU, sandbox, and other systems.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  test/py/tests/test_smbios.py | 47 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 test/py/tests/test_smbios.py
>
> diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
> new file mode 100644
> index 0000000000..86d8d07539
> --- /dev/null
> +++ b/test/py/tests/test_smbios.py
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +"""Test smbios command"""
> +
> +import pytest
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.notbuildconfigspec('qfw_smbios')
> +@pytest.mark.notbuildconfigspec('sandbox')
> +def test_cmd_smbios(u_boot_console):
> +    """Run the smbios command"""
> +    output = u_boot_console.run_command('smbios')
> +    assert 'DMI type 0,' in output
> +    assert 'String 1: U-Boot' in output
> +    assert 'DMI type 1,' in output
> +    assert 'DMI type 2,' in output
> +    assert 'DMI type 3,' in output
> +    assert 'DMI type 4,' in output
> +    assert 'DMI type 127,' in output
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.buildconfigspec('qfw_smbios')
> +@pytest.mark.notbuildconfigspec('sandbox')
> +# TODO:
> +# QEMU v8.2.0 lacks SMBIOS support for RISC-V
> +# Once support is available in our Docker image we can remove the constraint.
> +@pytest.mark.notbuildconfigspec('riscv')
> +def test_cmd_smbios_qemu(u_boot_console):
> +    """Run the smbios command on QEMU"""
> +    output = u_boot_console.run_command('smbios')
> +    assert 'DMI type 1,' in output
> +    assert 'Manufacturer: QEMU' in output
> +    assert 'DMI type 127,' in output
> +
> +@pytest.mark.buildconfigspec('cmd_smbios')
> +@pytest.mark.buildconfigspec('sandbox')
> +def test_cmd_smbios_sandbox(u_boot_console):
> +    """Run the smbios command on the sandbox"""
> +    output = u_boot_console.run_command('smbios')
> +    assert 'DMI type 0,' in output
> +    assert 'String 1: U-Boot' in output
> +    assert 'DMI type 1,' in output
> +    assert 'Manufacturer: sandbox' in output
> +    assert 'DMI type 2,' in output
> +    assert 'DMI type 3,' in output
> +    assert 'DMI type 4,' in output
> +    assert 'DMI type 127,' in output
> --
> 2.43.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

