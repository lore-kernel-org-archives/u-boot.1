Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2028CAC5B5
	for <u-boot@archiver.kernel.org>; Sun, 28 Sep 2025 13:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4DE2809A5;
	Sun, 28 Sep 2025 15:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ee9iMwAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999D8828A2; Sun, 28 Sep 2025 15:04:32 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 396CD80819
 for <u-boot@lists.denx.de>; Sun, 28 Sep 2025 15:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DDF88252A3;
 Sun, 28 Sep 2025 15:04:29 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lpmFtS_4RNrU; Sun, 28 Sep 2025 15:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1759064669; bh=UP8EvtlJG6KuLnkeQl3qkUE0j4Qew3IyOvesrbncbAc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ee9iMwAtoFqORbILX6ir2x3gmkvH0RtRSbnfAhpp2MLC2RRST7H2Vd9m48hty0f3+
 XgOXyWpbyPlHx1gbJRnFuLVPYU1K4z4/18eu93J0kY61KXMZqaVT4u0/WnU6Si13gc
 /wXi8YYZNoK/HR20ndoaNKtORLMp0RzY3D1CVL0DgseNQdhj+3Jk3OvkJRx0kuluqY
 1AwcmGsGFU3fgWJ2HwqfMr5gMWi1PHjYW39Ct0mTSouxpFaTpFO1C9QqsYjF27HcHU
 2AttnNX+KGw7kSuoqCVR5Wx/6AZ6Zxqzd88ylf2uvzI/Gygy3CGm0uzxc3ePKJKGbM
 0653DRt1TXSrg==
Date: Sun, 28 Sep 2025 13:04:16 +0000
From: Yao Zi <ziyao@disroot.org>
To: Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH RESEND 4/4] doc: bindings: add Aquantia PHY node's
 "firmware-name" binding
Message-ID: <aNkyUAyL2mXvQ-KN@pie>
References: <20250923071315.276114-1-root@infi.wang>
 <20250923071315.276114-5-root@infi.wang> <aNKWLNH0ZhqFckNl@pie>
 <A93BFAC5-DB33-43E5-973B-58AF65EC23D2@infi.wang>
 <6689E83F-4029-4BD5-8AE9-20B9BC3D1A5C@infi.wang>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6689E83F-4029-4BD5-8AE9-20B9BC3D1A5C@infi.wang>
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

On Fri, Sep 26, 2025 at 05:30:03PM +0800, Beiyan Yun wrote:
> 
> 
> > On 26 Sep 2025, at 4:22 PM, Beiyan Yun <root@infi.wang> wrote:
> > 
> > 
> > 
> >> On 23 Sep 2025, at 8:44 PM, Yao Zi <ziyao@disroot.org <mailto:ziyao@disroot.org>> wrote:
> >> 
> >> On Tue, Sep 23, 2025 at 03:13:01PM +0800, Beiyan Yun wrote:
> >>> With the switch to generic firmware loader, "firmware-name" binding
> >>> was introduced to define the firmware filename.
> >>> Provide the document and usage examples.
> >>> 
> >>> Signed-off-by: Beiyan Yun <root@infi.wang <mailto:root@infi.wang> <mailto:root@infi.wang>>
> >> 
> >> IMO this patch should go before the driver change.
> >> 
> >>> ---
> >>> 
> >>> doc/device-tree-bindings/net/aquantia-phy.txt | 30 +++++++++++++++++++
> >>> 1 file changed, 30 insertions(+)
> >>> 
> >>> diff --git a/doc/device-tree-bindings/net/aquantia-phy.txt b/doc/device-tree-bindings/net/aquantia-phy.txt
> >>> index 7dd3d45df12..1227c04d04f 100644
> >>> --- a/doc/device-tree-bindings/net/aquantia-phy.txt
> >>> +++ b/doc/device-tree-bindings/net/aquantia-phy.txt
> >>> @@ -11,15 +11,45 @@ a custom firmware is needed for each integration of a PHY.
> >>> Several optional bindings are defined that allow these configuration points to
> >>> be driven by the PHY driver and reduce dependency on specific FW versions.
> >>> 
> >>> +Aquantia PHY's firmware is often provided by PHY-resident SPI flash; if absent
> >>> +or outdated, U-Boot can upload firmware over MDIO during PHY initialization.
> >>> +The driver uploads only when the PHY reports missing firmware or a fault.
> >>> +
> >>> Optional properties:
> >>> mdi-reversal: 0 or 1 indicating that reversal must be disabled/enabled.
> >>>              Firmware default is used if the property is missing.
> >>> smb-addr:     I2C/SMBus address to use, firmware default is used if the property
> >>>              is missing.
> >>> +firmware-name: String containing the filename of the PHY firmware to load
> >>> +               (only when CONFIG_PHY_AQUANTIA_UPLOAD_FW is enabled).
> >> 
> >> This looks good to me, but I have a question: should we switch to the
> >> upstream binding for aquantia phys? It's already documented as
> >> marvell,aquantia.yaml, and we could avoid the burden of maintaining a
> >> separate binding file.
> >> 
> >> The "firmware-name" property is already described in the upstream
> >> marvell,aquantia.yaml, and it only misses the smb-addr property. The
> >> only U-Boot boards making use of this property are fsl-sch-30841 and
> >> fsl-sch-30842, thus such conversion shouldn't be a big job.
> > 
> > Good point. I’ll add a bit more info in related Kconfig options and drop the doc.
> 
> Hmm, I’m a bit lost. Here’s some of my concerns:
> 
> - Upstream binding has an optional nvmem cell as firmware source, such mechanism
>    simply doesn’t exist in U-Boot. This could be misleading.

I think it's okay to support part of the binding in U-Boot: the goal is
to reuse upstream binding, avoiding the burden of maintaining a
duplication, and making it possible to share devicetree between kernel
and firmware (same binding means same ABI).

I did a brief search in the upstream dts tree, and found no consumer
of this nvmem-cells property, thus I don't think it's a problem, at
least for now.

> - About “smb-addr”, what’s the best move? Do we upstream them to Linux?

Yes, if it's really necesary for the phy to work. If you decide to
adapt the upstream binding in the series, then I suggest upstreaming the
property to dt-bindings first.

Anyway I think your original patch looks good to me as well, it isn't a
must (at least to me) to switch to the upstream binding.

> Any idea on how to fix these issues?
> 
> Thanks,
> Beiyan Yun

Best regards,
Yao Zi
