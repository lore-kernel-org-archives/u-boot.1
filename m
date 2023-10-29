Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B966C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B7B387C73;
	Sun, 29 Oct 2023 16:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592184;
	bh=fZlnWywCqzBOCjZGY+uLir1/VvcOor3h+lyENa59NT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TmIHZJh2CdVsMGhV9V81xHi41rI9xUeHPv+3ZOGEdPDaCcUgVCuKGx6n5PHYNW55r
	 bZqYHTPzlhZXpcOMRui6XIx9mGwq0qdVrhRFpKqqNozUXgJ7t9m1uXreZjXD0MBV5L
	 NSk5VENObN3h93juLXm+drsfGrYXKqK8wh37+HORRtgZxqjCuhE55a/4rjsbUc3msj
	 KmNaO0mjeam9vyFjNoUysSyWdlKJTsEQJHo+C+aPQ0sADahdrKLadwfhhQzjMGwDL6
	 k7GxFpYhWW+jVIxgA95Yj7WkY9+6Ve32aFiqyBwvRdogpmqVzNkVvnQdFNnSLb0JWt
	 ZId6vjD+wI6pA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8DB4387634;
 Sun, 29 Oct 2023 16:09:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592181;
 bh=fZlnWywCqzBOCjZGY+uLir1/VvcOor3h+lyENa59NT4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rih5cCYJYliq1mz4GtjK56DSIctBr87R7cuFzwXSl60e/vbyIGQnH+R7FN32jrS9Q
 V9dWK1h9ZowQxcnQ2FhhtwXNMGU1JZ4uubzDHF6gelutZo1sbWjs1uG3cd1dnIpYgw
 kIxWB5Pjkvtte+iDr+5OjBRVl8z8XJQ1CsQ3fcr29FDoY0npdV/xvhvPAL4yL7Skep
 a30Po3O7Lksd3lgNEHsIasu0xask54oQp0FYjrDugiRsg1DThNVHCLFdrD0LhzQlNJ
 KciE0ngqKrSYUcSTWqzPDYwswohc6N+oIyqnVq24zgI5jWPJQicl52A+qksOQElbZB
 VKeVWovmHxcKQ==
Message-ID: <6173c4f2-1d70-43dc-baab-a6db76f04b77@denx.de>
Date: Sun, 29 Oct 2023 13:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] scsi: Fix a bunch of SCSI definitions.
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
 <20231029-usb-fixes-3-v1-1-0153210a7f55@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-3-v1-1-0153210a7f55@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/29/23 08:23, Hector Martin wrote:
> 0x9e isn't Read Capacity, it's a service action and the read capacity
> command is a subcommand.
> 
> READ16 is not 0x48, it's 0x88. 0x48 is SANITIZE and that sounds like we
> might have been destroying data instead of reading data. No bueno.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   drivers/ata/ahci.c  | 9 ++++++---
>   drivers/scsi/scsi.c | 4 ++--
>   include/scsi.h      | 8 ++++++--
>   3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 2062197afcd3..b252e9e525db 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -906,15 +906,18 @@ static int ahci_scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
>   	case SCSI_RD_CAPAC10:
>   		ret = ata_scsiop_read_capacity10(uc_priv, pccb);
>   		break;
> -	case SCSI_RD_CAPAC16:
> -		ret = ata_scsiop_read_capacity16(uc_priv, pccb);
> -		break;
>   	case SCSI_TST_U_RDY:
>   		ret = ata_scsiop_test_unit_ready(uc_priv, pccb);
>   		break;
>   	case SCSI_INQUIRY:
>   		ret = ata_scsiop_inquiry(uc_priv, pccb);
>   		break;
> +	case SCSI_SRV_ACTION_IN:
> +		if ((pccb->cmd[1] & 0x1f) == SCSI_SAI_RD_CAPAC16) {
> +			ret = ata_scsiop_read_capacity16(uc_priv, pccb);
> +			break;
> +		}

Would it make sense to add an else branch here and report unknown 
subcommand there ?

With that:
Reviewed-by: Marek Vasut <marex@denx.de>
