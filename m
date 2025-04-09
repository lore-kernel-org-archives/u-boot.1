Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA8FC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F8883849;
	Wed,  9 Apr 2025 17:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="NBT6VPEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338728384E; Wed,  9 Apr 2025 17:06:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D8E8381D
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3b7d=W4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1744211172;
 bh=COvYk2KbTnVlmD1A4rLATWoTgG21ALiULBp7PfKh6ko=;
 b=NBT6VPEhhhoZnk+w4J/66A6t37p1O1n9PRo+hC/hckTSeQddW/5YFsQrs/dDFbn7nqdKSXbxf
 D8bSOS6wE0WlPjXLFPG1vlk8CCPseN+h8MKrCO6fpwnJv/L0bDUO/cvoAavKMxTuWAbUfmSvz0U
 QHCjhn9AqUkC5n/9igbihchdom0BJsycck5lq8v/sPEHkPWnumNpw4V2WNdJ5Dg1n1WdUWLa+85
 s3Lyrcp/71ITACKdODvTZwcuS1Hd/0/aCRnDNt2aBx2QKye+wsLxeumkxijgT0hzlVSXTkgmoXG
 wzRqeTjc379JJYEg63hmyX5UtvMMMeKH35YowMX3Z3rw==
X-Forward-Email-ID: 67f68cda1aecaf4e4108d6f8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6fe987ef-39cb-45ce-8c84-bd74a5e3e48c@kwiboo.se>
Date: Wed, 9 Apr 2025 17:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] rockchip: binman: Include a compatible string in
 each configuration
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-8-jonas@kwiboo.se>
 <6b940128-c5aa-4499-b62b-1a63613d91e7@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6b940128-c5aa-4499-b62b-1a63613d91e7@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 2025-04-09 12:02, Quentin Schulz wrote:
> Hi Jonas, Simon,
> 
> On 3/29/25 4:06 PM, Jonas Karlman wrote:
>> From: Simon Glass <sjg@chromium.org>
>>
>> Provide a compatible string in the config nodes that U-Boot can use to
>> help decide which configuration to use.
>>
> 
> Can you tell us more about this?

I think the VBE can use this to determine what config/fdt would be used
in a multi-dtb FIT image.

This also sparked an idea to use this compatible for board selection in SPL
instead of the description (fdtfile) field. I have started to play around
with a board_fit_config_compatible_match() a few patches in at [1], e.g.:

- WIP: boot: fit: add board_fit_config_compatible_match()
- WIP: rockchip: implement fit config compatible match for boards

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/for-next

That could also be used for having board specific TPL+SPL and use a 
single multi-dtb FIT with U-Boot proper and multiple fdt/config nodes,
one for each board.

> 
> I don't think mkimage -l/dumpimage -l actually provide that information 
> and the docs are sparse as to what "so that things work correctly with 
> FIT's configuration-matching algortihm." means.
> 
> Looking a bit into tools/binman/ftest.py it seems like it's a way to 
> expose the DT compatible property from within the first entry in `fdt` 
> array property (a DTB) into the configuration node in the fit image.
> 
> I think it'd make sense to update dumpimage/mkimage/etc... to dump that 
> information as well?

I think so too, I know there are a few load/entry addresses for some
image type that is also not shown by dumpimage. This is something that
can be improved in a different series.

For FIT you can always use: dtc -I dtb -O dts u-boot.itb

  [...]
        configurations {
                default = "config-1";

                config-1 {
                        compatible = "radxa,e20c\0rockchip,rk3528";
                        loadables = "u-boot\0atf-2\0atf-3";
                        firmware = "atf-1";
                        fdt = "fdt-1";
                        description = "rockchip/rk3528-radxa-e20c.dtb";
                };

                config-2 {
                        compatible = "radxa,rock-2a\0rockchip,rk3528";
                        loadables = "u-boot\0atf-2\0atf-3";
                        firmware = "atf-1";
                        fdt = "fdt-2";
                        description = "rockchip/rk3528-rock-2a.dtb";
                };

                config-3 {
                        compatible = "radxa,rock-2f\0rockchip,rk3528";
                        loadables = "u-boot\0atf-2\0atf-3";
                        firmware = "atf-1";
                        fdt = "fdt-3";
                        description = "rockchip/rk3528-rock-2f.dtb";
                };
        };
  [...]

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

