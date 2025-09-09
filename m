Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E42CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 05:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2101830B4;
	Tue,  9 Sep 2025 07:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="AS1UnHl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E8383106; Tue,  9 Sep 2025 07:11:36 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A784280422
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 07:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D44CA106195; Tue,  9 Sep 2025 07:11:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1757394693;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=aiXBdgdp6PgX3uv+TBVl4dEDolBGMQCwBw2o0Dd+ql4=;
 b=AS1UnHl8gYeaOeGq72CeP0BagVO00s/3MOoh0gUn9BfcY3MuSUoZ/ETSBpU94jaXDYuIZF
 iVeWSRvxCJAxP+Niaorcdpeg8YwkWjRQKVNwj4TqOUHG/u5P3AkgwzSQzVqWEFYGnO5oWD
 zOzFNiMX0f2BD8oEEhIyACDmoR54IaUDdsprbtpyg8J3SMvfkDWy3tyoZBLz/qGA+bKRrX
 kCeICSSs/dd6hET3c36IyDH3ZhyV1BpV6bUpRe2yh6EJ4dPqbjhzBcVuX+ljtuNmkQJNVv
 MzxsePcNbWjCxUSmQKFM9v/twwA9ftF6KPgoW5nNoMkuipsKnJQ4KFqq9G9F7w==
Message-ID: <beb59699-9497-3f87-7c57-94da6d3df6be@nabladev.com>
Date: Tue, 9 Sep 2025 07:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] imx8: Add ahab_commit command
Content-Language: en-US
To: John Ripple <john.ripple@keysight.com>, peng.fan@oss.nxp.com
Cc: alexander.sverdlin@siemens.com, andrej.valek@siemens.com,
 festevam@gmail.com, hs@denx.de, peng.fan@nxp.com, sbabic@nabladev.com,
 sr@denx.de, trini@konsulko.com, u-boot@lists.denx.de, uboot-imx@nxp.com
References: <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
 <20250908211838.3772709-1-john.ripple@keysight.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20250908211838.3772709-1-john.ripple@keysight.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello John,

On 08.09.25 23:18, John Ripple wrote:
> The ahab_commit command allows the user to commit into the SECO fuses
> that control the SRK key revocation information. This is used to Revoke
> compromised SRK keys.
> 
> To use ahab_commit, the boot container must be built with an SRK
> revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this
> means setting the 'srk_revoke_mask' option in the config file used to
> sign the boot container. The 'ahab_commit 0x10' can then be used to commit
> the SRK revocation information into the SECO fuses.
> 
> Signed-off-by: John Ripple <john.ripple@keysight.com>
> ---
> Changes in v2:
> - Changed patch name to have imx8.
> 
> Changes in v3:
> - Changed patch name to only have imx8 at the start.
> - Add error checking for sc_seco_commit message.
> ---
> 
>   arch/arm/mach-imx/imx8/ahab.c  | 27 +++++++++++++++++++++++++++
>   drivers/misc/imx8/scu_api.c    | 30 ++++++++++++++++++++++++++++++
>   include/firmware/imx/sci/sci.h |  6 ++++++
>   3 files changed, 63 insertions(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

just a nitpick...

[...]
> diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
> index 8985ab6584d..0337525774e 100644
> --- a/drivers/misc/imx8/scu_api.c
> +++ b/drivers/misc/imx8/scu_api.c
> @@ -1286,3 +1286,33 @@ int sc_seco_secvio_dgo_config(sc_ipc_t ipc, u8 id, u8 access, u32 *data)
>   
>   	return ret;
>   }
> +
> +int sc_seco_commit(sc_ipc_t ipc, u32 *info)
> +{
> +	struct udevice *dev = gd->arch.scu_dev;
> +	struct sc_rpc_msg_s msg;
> +	int size = sizeof(struct sc_rpc_msg_s);
> +	int ret;
> +
> +	/* Fill in header */
> +	RPC_VER(&msg) = SC_RPC_VERSION;
> +	RPC_SIZE(&msg) = 2U;
> +	RPC_SVC(&msg) = (u8)SC_RPC_SVC_SECO;
> +	RPC_FUNC(&msg) = (u8)SECO_FUNC_COMMIT;
> +
> +	/* Fill in send message */
> +	RPC_U32(&msg, 0U) = *info;
> +
> +	/* Call RPC */
> +	ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
> +
> +	/* Copy out result */
> +	ret = (int)RPC_R8(&msg);
> +
> +	/* Copy out receive message */
> +	if (!ret)
> +		*info = RPC_U32(&msg, 0U);
> +
> +	/* Return result */

Do we really need this comment?

> +	return ret;
> +}

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
