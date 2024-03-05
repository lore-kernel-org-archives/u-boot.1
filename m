Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16800C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E58C87F6F;
	Tue,  5 Mar 2024 11:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709634670;
	bh=zgMy1yAsaAMSZ2CJOH6lyawVtdqAN9rhxdgJOSrrVAw=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KzKEhR/4GIEUlsHzwx+WIGP+hEs8eNIUw3+cBu7EdZf+5NCgH47C5+aStoLOL6i9y
	 RFZUczwLLQenElkTA3UfhHiTS2Gb4NLOP6Jg4FWvqpJdZiY1IDA9kEz8vtf5HHmNQp
	 ctn1PQmuCv/f0yOhLEQbteiUHVH5Cup35JqDldKcZrdgUr56M3MgW6sgSC0eCxN1ik
	 FlK9rWbS7ZdgHXG0mBsStsEtGDUMycLOezpGFiwtZWYB58u2lLTDENCeqxD5e+zQBz
	 hAw/wRwEZc5Zn3JyTS2+JBTq5X3FoUSBNEkRrmG5klvg3N6GjyQDAWhCtu7Ewz7saq
	 G3EwdrZM/lsPQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1590388021; Tue,  5 Mar 2024 11:31:10 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C7787E2F
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TpsKh38Flz9snd;
 Tue,  5 Mar 2024 11:31:04 +0100 (CET)
Message-ID: <94ba9f6a-aad4-4cc8-99fd-b651d3a0d188@denx.de>
Date: Tue, 5 Mar 2024 11:31:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: mv88e6xxx: fix missing SMI address initialization
Content-Language: en-US
To: =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, u-boot@lists.denx.de,
 joe.hershberger@ni.com, rfried.dev@gmail.com, tharvey@gateworks.com,
 marek.behun@nic.cz, marex@denx.de
References: <62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/6/23 15:35, Marek Mojík wrote:
> The mv88e6xxx driver does not currently initialize the smi_addr field, but
> instead keeps the default zero value. This leads to driver being unusable
> on devices where the switch is not on address zero of the mdio bus. Fix
> this problem by reading the SMI address from device tree.
> 
> Signed-off-by: Marek Mojík <marek.mojik@nic.cz>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   drivers/net/mv88e6xxx.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/mv88e6xxx.c b/drivers/net/mv88e6xxx.c
> index c073f81e72..8fbbc1cacc 100644
> --- a/drivers/net/mv88e6xxx.c
> +++ b/drivers/net/mv88e6xxx.c
> @@ -745,6 +745,7 @@ static int mv88e6xxx_probe(struct udevice *dev)
>   {
>   	struct dsa_pdata *dsa_pdata = dev_get_uclass_plat(dev);
>   	struct mv88e6xxx_priv *priv = dev_get_priv(dev);
> +	fdt_addr_t smi_addr;
>   	int val, ret;
>   
>   	if (ofnode_valid(dev_ofnode(dev)) &&
> @@ -753,6 +754,13 @@ static int mv88e6xxx_probe(struct udevice *dev)
>   		return -ENODEV;
>   	}
>   
> +	smi_addr = dev_read_addr(dev);
> +	if (smi_addr == FDT_ADDR_T_NONE) {
> +		dev_err(dev, "Missing SMI address\n");
> +		return -EINVAL;
> +	}
> +	priv->smi_addr = smi_addr;
> +
>   	/* probe internal mdio bus */
>   	ret = mv88e6xxx_probe_mdio(dev);
>   	if (ret)

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
