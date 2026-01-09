Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2ACD16817
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B10DF8435C;
	Fri,  9 Jan 2026 12:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="FV1t0pNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD55284332; Fri,  9 Jan 2026 12:37:34 +0100 (CET)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FEC8435C
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E40+MEcWNmPMTvycSrpzydhpZTJwdRXZPehuOpd0+iA=; b=FV1t0pNs6rnvNA+vBnhqgBE0li
 6UwgTqg9agbDuJ2w1koY60GZLFgpvKmbV43CT/4MWeAgnyS/5qpMHGy88+jRGRM9rBbjTRxSrPHOg
 nqb9DifPzs98x92aSiuIaHmS0r/Prv5Wl4eSFxvcC/1jfWIGLox6YFDqKdSmNoALG1jkZ8O8u4YT6
 aUAolvEhF0FDZXSXo0rLLGKYDJRAdU7C2Wcj8ijyiFLqmEUidRtpRNF0DSu/KciUACU7KRtqrfymH
 2IB8n2Hrtnh3EF1xBIQUeR1uTL++9TRVJq8zZLGMVjyLQrLWXndRuHZOjlnLx4dQ22nqtC25H+q2p
 snbmMB3Q==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:44380
 helo=[192.168.69.116])
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <primoz.fiser@norik.com>)
 id 1veAo9-0000000CrZj-0EdF; Fri, 09 Jan 2026 12:37:32 +0100
Message-ID: <efb435fe-3d6e-49de-a903-678051c0f9a6@norik.com>
Date: Fri, 9 Jan 2026 12:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] misc: ele_api: Add Voltage change start and finish
 APIs
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
 <20260108-imx-update-v1-11-0d5921c575bb@nxp.com>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <20260108-imx-update-v1-11-0d5921c575bb@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Peng,

On 8. 01. 26 12:06, Peng Fan (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> On GDET enabled part, need to call voltage change start and finish

Just a question, is this some special part or a regular i.MX93?

How or where do you enable Glitch detection?

Thanks,
BR,
Primoz


> APIs when adjust the voltage more than 100mv. Otherwise GDET will be
> triggered and system is reset
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/include/asm/mach-imx/ele_api.h |  4 +++
>  drivers/misc/imx_ele/ele_api.c          | 50 +++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
> index 64b243dcaaa..4e1afc42bd8 100644
> --- a/arch/arm/include/asm/mach-imx/ele_api.h
> +++ b/arch/arm/include/asm/mach-imx/ele_api.h
> @@ -14,6 +14,8 @@
>  #define ELE_PING_REQ (0x01)
>  #define ELE_FW_AUTH_REQ (0x02)
>  #define ELE_RESTART_RST_TIMER_REQ (0x04)
> +#define ELE_VOLT_CHANGE_START_REQ (0x12)
> +#define ELE_VOLT_CHANGE_FINISH_REQ (0x13)
>  #define ELE_DUMP_DEBUG_BUFFER_REQ (0x21)
>  #define ELE_OEM_CNTN_AUTH_REQ (0x87)
>  #define ELE_VERIFY_IMAGE_REQ (0x88)
> @@ -160,4 +162,6 @@ int ele_return_lifecycle_update(ulong signed_msg_blk, u32 *response);
>  int ele_start_rng(void);
>  int ele_write_shadow_fuse(u32 fuse_id, u32 fuse_val, u32 *response);
>  int ele_read_shadow_fuse(u32 fuse_id, u32 *fuse_val, u32 *response);
> +int ele_volt_change_start_req(void);
> +int ele_volt_change_finish_req(void);
>  #endif
> diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
> index 661f70cf870..e7aee0fcef1 100644
> --- a/drivers/misc/imx_ele/ele_api.c
> +++ b/drivers/misc/imx_ele/ele_api.c
> @@ -794,3 +794,53 @@ int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_outp
>  
>  	return ret;
>  }
> +
> +int ele_volt_change_start_req(void)
> +{
> +	struct udevice *dev = gd->arch.ele_dev;
> +	int size = sizeof(struct ele_msg);
> +	struct ele_msg msg = {};
> +	int ret;
> +
> +	if (!dev) {
> +		printf("ele dev is not initialized\n");
> +		return -ENODEV;
> +	}
> +
> +	msg.version = ELE_VERSION;
> +	msg.tag = ELE_CMD_TAG;
> +	msg.size = 1;
> +	msg.command = ELE_VOLT_CHANGE_START_REQ;
> +
> +	ret = misc_call(dev, false, &msg, size, &msg, size);
> +	if (ret)
> +		printf("Error: %s: ret %d, response 0x%x\n",
> +		       __func__, ret, msg.data[0]);
> +
> +	return ret;
> +}
> +
> +int ele_volt_change_finish_req(void)
> +{
> +	struct udevice *dev = gd->arch.ele_dev;
> +	int size = sizeof(struct ele_msg);
> +	struct ele_msg msg = {};
> +	int ret;
> +
> +	if (!dev) {
> +		printf("ele dev is not initialized\n");
> +		return -ENODEV;
> +	}
> +
> +	msg.version = ELE_VERSION;
> +	msg.tag = ELE_CMD_TAG;
> +	msg.size = 1;
> +	msg.command = ELE_VOLT_CHANGE_FINISH_REQ;
> +
> +	ret = misc_call(dev, false, &msg, size, &msg, size);
> +	if (ret)
> +		printf("Error: %s: ret %d, response 0x%x\n",
> +		       __func__, ret, msg.data[0]);
> +
> +	return ret;
> +}
> 

-- 
Primoz Fiser
phone: +386-41-390-545
email: primoz.fiser@norik.com
--
Norik systems d.o.o.
Your embedded software partner
Slovenia, EU
phone: +386-41-540-545
email: info@norik.com

