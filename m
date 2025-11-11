Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18630CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A54E183F88;
	Tue, 11 Nov 2025 14:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="vqmYMDuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530AA83B0B; Tue, 11 Nov 2025 07:34:32 +0100 (CET)
Received: from send276.i.mail.ru (send276.i.mail.ru [95.163.59.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9138C83AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 07:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
 :Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=ij7WmP6k5bqJDSxBq31fPjEAobP8q6xNB8/xrqIXxX0=; t=1762842869; x=1762932869; 
 b=vqmYMDuDxr+jtYL6hNKVRNwdX6qGjzq+Q3gHMTGHX7ym7ruCug/+FE+FkB+4lm2eyxk1lSO65ja
 FG93ihztk7Z0DoTTSVVht1/NOHqvRoOsJ4Vu0KYCrJo9TT+kfZylYs/95OlIMfY6pqa5H58biBhEN
 IkcqZ5w4BrObmsZkNyPngJg+Rlr5UIdO7etP/9jhtTwb/S/YrjWqQjFl3WEOSbCIZ67683aogOF1R
 6AhQBt9L2xrnhNyx/iOAMRABv4G+dVRnYP4TU+7b3KYA7nDNwjJMmu3aqXZmR2DSW5RmEzIBnKFUH
 mI6A6HqctV/pfN3yM0NZGl7l/RmnzVIrm+BQ==;
Received: by exim-smtp-68c8686b96-dnqld with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1vIhxT-000000003mj-3tBo; Tue, 11 Nov 2025 09:34:28 +0300
Message-ID: <bb061efd-19dc-4d59-b300-84bfc918d66a@inbox.ru>
Date: Tue, 11 Nov 2025 09:34:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] clk: scmi: add compatibility for clock version 3.0
 and onwards
To: Kamlesh Gurudasani <kamlesh@ti.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, d-gole@ti.com
Cc: u-boot@lists.denx.de
References: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
 <20251104-b4-scmi-v1-v4-2-51f101a6f8c3@ti.com>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20251104-b4-scmi-v1-v4-2-51f101a6f8c3@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: exim-smtp-68c8686b96-dnqld;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9E2FEC05A616BBE39F1FF651D7505B7043418F790C378EFD3182A05F5380850400C786E6AD96626C93DE06ABAFEAF67058F965FD2D5EB8C63D84761B12673435DD8331305C3D564B6
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FCFCB92DA8654BB0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566B292563C351EC717B0831997EEFD27ABEE55F7F32E652A07BC1CD43BF4A7745B8EEF46B7454FC60B9742502CCDD46D0D17119E5299B287EEF6B57BC7E64490618DEB871D839B73339E8FC8737B5C224992B0BE0DA6BB795DCC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C08B0023DF17FBB7E08941B15DA834481F9449624AB7ADAF372E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3EBF4D8D28E8B690335872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-87b9d050: 1
X-C1DE0DAB: 0D63561A33F958A5AEA03662B804C8E65002B1117B3ED6969C033CB0321F8E319E040399BDE4761E823CB91A9FED034534781492E4B8EEADA2D5570B22232E1EBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFCA9DC9E0BE25FB854B33A63FD8C107A64EAD10F1670C96B15D83E35F898A6E48212E5196DFD6A13F23BB165979B4CD0A1E57CF58E7F601637F43DDD1DCBC9C5BA3C63468ECD487CC034D55ECCE8C67C6913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVVMPnv1PZQG3tAoNixFI9/I=
X-Mailru-Sender: 689FA8AB762F7393DDD5FD59B456EAD2053DCE9A6A6BF4430719CAB49600A673C6D10DAF25DE623E90DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
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

04.11.2025 14:19, Kamlesh Gurudasani wrote:
> Clock version 3.0 specified in ARM SCMI Platform design document
> v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET and
> CLOCK_CONFIG_GET. Add support for that.
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>   drivers/clk/clk_scmi.c   | 52 +++++++++++++++++++++++++++++++++++++++-------------
>   include/scmi_protocols.h |  6 ++++++
>   2 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index 83ea7bb4286..6d47cc6cd01 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -131,19 +131,45 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
>   
>   static int scmi_clk_gate(struct clk *clk, int enable)
>   {
> -	struct scmi_clk_state_in in = {
> -		.clock_id = clk_get_id(clk),
> -		.attributes = enable,
> -	};
> +	struct scmi_clock_priv *priv;
>   	struct scmi_clk_state_out out;
> -	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
> -					  SCMI_CLOCK_CONFIG_SET,
> -					  in, out);
>   	int ret;
>   
> -	ret = devm_scmi_process_msg(clk->dev, &msg);
> -	if (ret)
> -		return ret;
> +	if (CONFIG_IS_ENABLED(CLK_CCF)) {
> +		/* CCF: version info is in parent device */
> +		priv = dev_get_priv(clk->dev->parent);
> +	} else {
> +		/* Non-CCF: version info is in current device */
> +		priv = dev_get_priv(clk->dev);
> +	}
> +
> +	if (priv->version >= CLOCK_PROTOCOL_VERSION_3_0) {
> +		struct scmi_clk_state_in_v2 in = {
> +			.clock_id = clk->id,
.clock_id = clk_get_id(clk),

> +			.attributes = enable,
> +			.extended_config_val = 0,
> +		};
> +		struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
> +						  SCMI_CLOCK_CONFIG_SET,
> +						  in, out);
> +
> +		ret = devm_scmi_process_msg(clk->dev, &msg);
> +		if (ret)
> +			return ret;
> +
> +	} else {
> +		struct scmi_clk_state_in in = {
> +			.clock_id = clk->id,
.clock_id = clk_get_id(clk),

> +			.attributes = enable,
> +		};
> +		struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
> +						  SCMI_CLOCK_CONFIG_SET,
> +						  in, out);
> +
> +		ret = devm_scmi_process_msg(clk->dev, &msg);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return scmi_to_linux_errno(out.status);
>   }
> @@ -275,12 +301,12 @@ static int scmi_clk_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -	if (!CONFIG_IS_ENABLED(CLK_CCF))
> -		return 0;
> -
>   	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
>   					    &priv->version);
>   
> +	if (!CONFIG_IS_ENABLED(CLK_CCF))
> +		return 0;
> +
>   	/* register CCF children: CLK UCLASS, no probed again */
>   	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
>   		return 0;
> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
> index 762a1032c37..a4d1a4c80c8 100644
> --- a/include/scmi_protocols.h
> +++ b/include/scmi_protocols.h
> @@ -807,6 +807,12 @@ struct scmi_clk_state_in {
>   	u32 attributes;
>   };
>   
> +struct scmi_clk_state_in_v2 {
> +	u32 clock_id;
> +	u32 attributes;
> +	u32 extended_config_val;
> +};
> +
>   /**
>    * struct scmi_clk_state_out - Response payload for CLOCK_CONFIG_SET command
>    * @status:	SCMI command status
> 

Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>

