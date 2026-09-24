Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11798C98304
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 03:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B37160B1B;
	Thu, 24 Sep 2026 03:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZ3YwH_svxbl; Thu, 24 Sep 2026 03:34:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6F15560693
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790220852;
	b=jqHycqwZLvlbBj5rAP4mdEjVwz3IEbQm9WLiKFVaTvDru50OLl3ZPUnRa1tro8mr5tSU
	 yGji3TfKloGNJCnsFTczVxC4k6cOqbdnArnFvVIiMLGyYTe+rplb3vqzXLhHcKJeP/N7v
	 IBtyl9HRWPuwpXEk5qAQlUU6I0t9HWhcbb5DZGyyJjpkxU/qLT/OXY7UEa7GzfCynwS2x
	 /xolmGbXjpw9qAaXSg5wIyxVN9aNN2czsIsnrrOOFfyazacQumlbRpSypN4sT+aiJ4jx8
	 nbNWk/KJGSOFcFzUdGzOPEpUkTkPYKEFACMgZIMYSD53WVvOU6tiwH1A1CQ/SImhJ3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790220852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YXOkrDjDr/hkOl8KYzN3mQW0ciYsQRBL6yev8DOgKVw=;
	b=Fyqq11dGMynRkdbk5QwdZAjUQb2jJRBfvBBrXYSesZLBVv6eelnKa4Porl5uSy7R1nd8
	 8Lr+mgGuUMOF/LSUzp5k3o92lm/au4YvQNCJbrs0d7QvppSYxpoH6UTY4tKVuoOrcnxea
	 aYYXnIsx20gGIrSAPspC9Bmg1HdLhWfgwXCHuG0IR74Y8VPaEf9vA9xmAg3SbVATyHf0n
	 Y0FhZesY6hAAzOH5ksj+ZSw7/pfuq8tIAzDxIuhtdDBANV4mj2XuI7jS0zlOZgDK0mbtG
	 /PRMYp7N1mJ1MLvRnXKNWp6x4Zi+NgbjvPK4Jno7lpW0mrk1isWS/UOQe9HLMtVDqQw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790220852;
	bh=YXOkrDjDr/hkOl8KYzN3mQW0ciYsQRBL6yev8DOgKVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S0C2uWa6NVd7UT4F0T1mpXS4y+a10TYTnH5SyThp9K7MNT+h7B7Ezt71ekF5YPfrH
	 H8P1KcQGYaaNm3eaorvcwwZe0rPlrT+XW0SL9CgRlPIeHZDC2RXrJIfe9+/t/FpgPG
	 DFoYczDwyf2pgt5Tkf9ULLHocZx9fM8z8kLE77g6lIriIPbHZNIzXzjrqzScsq1Xss
	 iJym2r6K5hHAGhbKJzX9QId3jWAyPk0rGd30tuHianrDikGbFdkH2tNIsdTVEqznR3
	 tBblWI0C3jGXrbiags0vCG5ZWNTYcq4HRVvuA9TSvZWhvNzaN1N2EwIRW0MKXAmYg8
	 T1kjw7Eh8l/bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F15560693;
	Thu, 24 Sep 2026 03:34:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 94B183B7
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71A90400AE
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FINbQeH-2YON for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 03:34:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6D6C940079
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790220850;
 b=QsVS7x6ilmYseJ36fGWL2GL2O6z6p0pMrb4C8ddQvmWk+UP2EArwlrWnny5a0jw3BqM4
 1PXECiGHSd3VO4r94D/tfWJW2espyvwl1snlSqjQx8ny/vrxo3ayso64VQJMHyYdifPsc
 svZq77tQhMB7gHRiSyI34EOttIP0edQrTXfK/5RYARQznwaBLqcisTQCPGNQUiNuDbaic
 fqwKjOBpCDJbTEZ3itGJxM5bFcFQwNbBbaaTnmaYfgdJXTefJwFLvuP2MVdrVXC1CZ+D3
 Flxn86Pvqv9Jmr/fdBuWiWdlgYXaUJBU8jMwMO7VCrcRohEPI9ywhRA3HyZWwZPWlSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790220850;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=YXOkrDjDr/hkOl8KYzN3mQW0ciYsQRBL6yev8DOgKVw=;
 b=FmSdSA+n4llaTC9dVxrhoJDdQkAFCvtnozcUSXFY7tGdiVNEFpSdUwmGW6s06dGMT450
 s26K71Lq0Z+FqBq7k8aIad2cQRHmxp06bCU0lTOfkkZRsME/LGx3bx5+ixh0y0msC8fn5
 0OSme1IjmFXD2/sV5cPgCVqD/P7fOHXHKlOcdUeNYOLdBrTwJvWo2r0Vq00eHSU0GW7Np
 3sOgVuPt5DVc/fGYMRbyknwgFTSrCxYF551f5ySNsfAbu1fzDO5lIUc/qFVb/A4pOdNoZ
 E+eIfRAxtuUbUdz7L4ncXAptC/82e8EQFL8ety3XG0WdV1eHcBNpZbKirSCNIRSwIyw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RthLfoWc; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RthLfoWc
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D6C940079
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 03:34:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B93F600AA;
 Thu, 24 Sep 2026 03:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C461F000FF;
 Thu, 24 Sep 2026 03:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790220848;
 bh=YXOkrDjDr/hkOl8KYzN3mQW0ciYsQRBL6yev8DOgKVw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RthLfoWcV/a6L3CwEPDvhMWUmUeqfl8i4IikHgu1Pyt0Il0tOzxchTbgz9nofrQgW
 +fMRL+E9JMeSOkwYGxX6cFky1UFadaE6PjG1nUhv6XHGVvRx/f/4C0oO5krWT0E26m
 kgOvhODZ6RFBBD2dUVgM9d//zTiMlw7jvq69GhMjQO3UBUPkHiPnUThxKXaOwrR1eY
 f6ZfF68iv5dU0CtLDpgYVEAXcqxdWXGBkry0Lay5hGCbUNuHzLzPOQOI2a2FtGc8IN
 xtSy6DzYIEYKXl9jf3yoOAPnLi0z8lgZ1lRxeL/GiPne8Hr5YYVuR8A0mV9vHKmSBT
 vvyxrhPkZXcuw==
Date: Thu, 24 Sep 2026 03:34:04 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 fanyi zhang <fanyi.zhang@mediatek.com>, spacemit@lists.linux.dev
Subject: Re: [PATCH 2/2] configs: spacemit: k3: Enable Ethernet support
Message-ID: <20260924033404-GKH353745@kernel.org>
References: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
 <20260924-02-k3-ethernet-support-v1-2-b8e1fafc9249@kernel.org>
 <e4c84eac-01e6-4955-865c-56d8fb733498@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4c84eac-01e6-4955-865c-56d8fb733498@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 20:13 Wed 23 Sep     , E Shattow wrote:
> Hi Yixun,
> 
> On 9/23/26 18:53, Yixun Lan wrote:
> > Enable the SpacemiT platform glue for the DesignWare Ethernet QoS
> > controller together with the generic PHY framework, Gigabit Ethernet
> > PHY support and the Realtek PHY driver.
> > 
> > Enable DHCP, MII, ping and PXE commands for network configuration,
> > diagnostics and network boot. Allow U-Boot to generate a random
> > Ethernet address when no valid address is provided by the board.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  configs/spacemit_k3_defconfig | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
> > index 6ca41aecc41..3a70a0a4858 100644
> > --- a/configs/spacemit_k3_defconfig
> > +++ b/configs/spacemit_k3_defconfig
> > @@ -24,10 +24,15 @@ CONFIG_SYS_PBSIZE=276
> >  CONFIG_HUSH_PARSER=y
> >  CONFIG_CMD_GPIO=y
> >  CONFIG_CMD_I2C=y
> > +CONFIG_CMD_DHCP=y
> > +CONFIG_CMD_MII=y
> > +CONFIG_CMD_PING=y
> > +CONFIG_CMD_PXE=y
> >  CONFIG_CMD_PMIC=y
> >  CONFIG_CMD_REGULATOR=y
> >  CONFIG_CMD_FAT=y
> >  CONFIG_CMD_FS_GENERIC=y
> > +CONFIG_NET_RANDOM_ETHADDR=y
> >  CONFIG_SYSCON=y
> >  CONFIG_CLK_SPACEMIT=y
> >  CONFIG_CLK_SPACEMIT_K3=y
> > @@ -35,6 +40,11 @@ CONFIG_SPACEMIT_GPIO=y
> >  CONFIG_DM_I2C=y
> >  CONFIG_SYS_I2C_SPACEMIT_K1=y
> >  CONFIG_MISC=y
> > +CONFIG_PHY_GIGE=y
> > +CONFIG_DWC_ETH_QOS=y
> > +CONFIG_DWC_ETH_QOS_SPACEMIT=y
> > +CONFIG_PHY_REALTEK=y
> > +CONFIG_PHY=y
> >  CONFIG_PINCTRL=y
> >  CONFIG_PINCTRL_SPACEMIT_K1=y
> >  CONFIG_DM_PMIC=y
> > 
> 
> Please also enable for this series: CMD_WGET DNS NET_LWIP
> 
No objection from my side, can add in next version

> We can intentionally leave WGET_HTTPS behind when there is no
> hardware-specific DM RNG driver implemented yet. I do not see a reason
> for the legacy network stack instead of LwIP; LwIP appears to be working
> well.
> 
Ok

> In my test I start a simple HTTP server on the local network host:
> 
> $ python3 -m http.server 8000
> Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
> 
> Next from a Sipeed K3 Pico-ITX 32GB board and your mainline u-boot series:
> 
> => dhcp
> ethernet@cac80000 Waiting for PHY auto negotiation to complete........ done
> DHCP client bound to address <10.20.30.40> (38 ms)
> => wget http://host:8000/mini.efi
> ##################################################
> 87962624 bytes transferred in 7414 ms (11.3 MiB/s)
> Bytes transferred = 87962624 (53e3400 hex)
> 
> With that,
> 
> Tested-by: E Shattow <e@freeshell.de>

Thanks for testing, will apply your tag to the series

-- 
Yixun Lan (dlan)
