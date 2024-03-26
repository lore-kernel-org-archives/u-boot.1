Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71820C54E58
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 01:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B4187F5E;
	Tue, 26 Mar 2024 02:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Skcagedt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E3C83346; Tue, 26 Mar 2024 02:15:56 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CDC687F1E
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 02:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56be32b9775so4545178a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1711415749; x=1712020549; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ARKwK/gbemM8saqjnjf94yKMg0D3HYZaKO5WunopXXU=;
 b=Skcagedt6iPmX7m8Atsi1+rrxaOH7UXYsynN2ag0UQ8/GzwzaP0HugpbpldgbvmSaR
 Kf9jGcBFpIHh8odMbO8z4z92RsPVGleW/haAj7SQOecwdoUE2kCfnHKqS+hzMnCbXeHx
 Xl/3ZNKZkl/E0wtuserTwhzDpxlE3I9AkVlWlPDFDmvQ/oRHJDx+BinIAkQg3EymbHb+
 qytG+iy2y3BQoAh+weBA0U+9dzPx2WYL2BhbANSwH5gv5WFE0gxRqNbfMfL9YU+qcZnA
 lTRFOHPTfOMBDW3x3eyBWisoWjCH9DUgJACkaZSe7Fp/eycAjwW1aeIpBZT8vrEhQBw1
 cLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711415749; x=1712020549;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ARKwK/gbemM8saqjnjf94yKMg0D3HYZaKO5WunopXXU=;
 b=N6YiMxWs3fE4DeCyRjOR37nepp0ShFoawqnkkY5vs1eINSoiR9xDz8kMWtZdPit1PE
 6BBvtfmbTvkFPLjQkYikoU9StJ32do+fg+5pJrx6lw2rI0Fp6/Do1VwGWYvjj1iaUh6N
 tiqiNcKJGQtUbqmMA2eG2KnOEdLISgweafZPa4TCc+5v+VVuYz8YL96hhvRsbBoGxIMG
 ZePRPHDcxdzWOeTsMH6X5lh76zilylFuY9EyC5H33AJHoRkyqVzllPMsrEM+OAj71yKu
 1HTpGqSVlT+iWK+nc86gtKAA5AoVyS8suRKmJEZRfji+xn+aJUvpM18UWh7lp9awBqTu
 DcaA==
X-Gm-Message-State: AOJu0YwNvnJzPLLtgon5y/pi9VLn2F7Ejj+I6gYuqMtqBMDu36rCFij0
 TkkkF8GVre4IxNhZFUgjOzrxquGtVDkdZD6Gayq0nLYC40BvV5QTA4iaSQxneo/dA9k5maOesE1
 zkwFpvd/sPS87qVZi2McVAoaj1p2zXBa504Cgy+NzeLthkbucZbA=
X-Google-Smtp-Source: AGHT+IE5u7DvNDWvFJFNcXQnrT8b8ELWN9KYsDHRar/8ePmjfPBw1qHXZvo6H9cdBQbBP6//aiOW+1OAkLr2e1hRfqI=
X-Received: by 2002:a17:906:f10a:b0:a46:bbc9:a8c7 with SMTP id
 gv10-20020a170906f10a00b00a46bbc9a8c7mr5295701ejb.71.1711415748676; Mon, 25
 Mar 2024 18:15:48 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 25 Mar 2024 18:15:37 -0700
Message-ID: <CAJ+vNU12-4EJN_RPGPPTfTVden2=beq-XaeFL=dF7t+AAqje=Q@mail.gmail.com>
Subject: tcg2_platform_get_log failing to read address and size of
 memory-region via ofnode_get_addr_size
To: u-boot <u-boot@lists.denx.de>, eajames@linux.ibm.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Greetings,

I'm unable to understand why tcg2_platform_get_log is failing to read
a memory region.

For example the following diffs:

diff --git a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
index 7b2130dbdb21..57b3c227ceaf 100644
--- a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
+++ b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
@@ -112,6 +112,7 @@
                compatible = "tcg,tpm_tis-spi";
                reg = <0x1>;
                spi-max-frequency = <36000000>;
+               memory-region = <&event_log>;
        };
 };
 diff --git a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
index c305e325d007..697fd1148785 100644
--- a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
+++ b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
@@ -13,6 +13,17 @@
                reg = <0x0 0x40000000 0 0x80000000>;
        };

+       reserved-memory {
+               #address-cells = <2>;
+               #size-cells = <2>;
+               ranges;
+
+               event_log: tcg_event_log {
+                       no-map;
+                       reg = <0 0x40000000 0x2000>;
+               };
+       };
+
        gpio-keys {
                compatible = "gpio-keys";

And at runtime:
u-boot=> fdt addr $fdtcontroladdr
u-boot=> fdt list /soc@0/bus@30800000/spba-bus@30800000/spi@30830000/tpm@1/
tpm@1 {
        compatible = "tcg,tpm_tis-spi";
        reg = <0x00000001>;
        spi-max-frequency = <0x02255100>;
        memory-region = <0x00000025>;
};
u-boot=> fdt list /reserved-memory/
reserved-memory {
        #address-cells = <0x00000002>;
        #size-cells = <0x00000002>;
        ranges;
        tcg_event_log {
        };
};
u-boot=> fdt list /reserved-memory/tcg_event_log
tcg_event_log {
        no-map;
        reg = <0x00000000 0x40000000 0x00002000>;
        phandle = <0x00000025>;
};

So why does the following code in tcg2_platform_get_log() return -ENOMEM?

                if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
                                               0, &args))
                        return -ENODEV;

                a = ofnode_get_addr_size(args.node, "reg", &s);
                if (a == FDT_ADDR_T_NONE)
                        return -ENOMEM;

debugging shows that dev_read_phandle_with_args returns non-zero but
args.args_count is 0.

I feel like the construct of using dev_read_phandle_with_args followed
by the ofnode_get_addr_size is just wrong but I don't understand why
nor do I understand how my dt changes differ from what is in
arch/sandbox/dts/test.dts (other than its using address-size=1 which
doesn't appear to be the issue in my testing). The abstraction of the
ofnode and fdt stuff always trip me up... very confusing.

Can anyone explain the issue here?

Best Regards,

Tim
