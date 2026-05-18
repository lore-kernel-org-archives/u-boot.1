Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A67FCD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 12:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9103383EF9;
	Mon, 18 May 2026 14:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sPCVvZAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E1383FEE; Mon, 18 May 2026 14:50:14 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3764983AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9508140491;
 Mon, 18 May 2026 12:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D0C2BCB8;
 Mon, 18 May 2026 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779108610;
 bh=pGpb8DzjCGK2OYO3bf92IAl3mmnJx+O9J9rrgK8wIqs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sPCVvZAI8CGBbhhjx9bycu1q8ltHf50H41EVHYrgYVtayUuxUE0voGn+2UHC7ZRH3
 Gf0EST+hqaUsRC/WBGlrveZBJR00HYnbiMfQ8bNw5IcwKeViC8jp3gygirjEmd4psk
 uFVq6k2gp48HXHm+i8DmaQWKHJAlc0S7/+YuSUA0Qi7P87rko80fwBFUzdx1taVfgY
 uvjgnWbIYGS8ng0wcTWdBa8fmLrXYCLWG863yKAraeC+9/KHkovnTuvaMyFbNQ1jgC
 1kJnEpcwR5dmq2QLP2Px5OLliN8XkIHUxQtiV9UfyqagmUvLj3BK4QDrambHgEWziu
 PP5ADiB0vq2FA==
Date: Mon, 18 May 2026 18:19:59 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 09/15] soc: qcom: smem: get serial number from socinfo
Message-ID: <agsK9-9Za941QdMS@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-9-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-9-c01ec2ff3886@linaro.org>
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

On Mon, May 04, 2026 at 08:57:37PM +0200, Casey Connolly wrote:
> Implement socinfo support to fetch the serial number if available.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/soc/qcom/smem.c | 25 +++++++++++++++++++++++++
>  include/soc/qcom/smem.h |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 96288d7bcdef..e20523e2cec3 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -14,8 +14,10 @@
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/sizes.h>
>  #include <soc/qcom/smem.h>
> +#include <soc/qcom/socinfo.h>
> +#include <env.h>
>  
>  /*
>   * The Qualcomm shared memory system is a allocate only heap structure that
>   * consists of one of more memory areas that can be accessed by the processors
> @@ -991,8 +993,31 @@ static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
>  
>  	return 0;
>  }
>  
> +int qcom_socinfo_init(void)
> +{
> +	struct socinfo *info;
> +	size_t item_size;
> +	char buf[32] = { 0 };
> +

Here you should check if the environment already has serial number added
as follows:

	if (env_get("serial#"))
		return 0;

As otherwise the env_set() throws error.

-Sumit

> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
> +			     &item_size);
> +	if (IS_ERR(info)) {
> +		log_err("Couldn't find socinfo: %ld\n", PTR_ERR(info));
> +		return PTR_ERR(info);
> +	}
> +
> +	if (offsetof(struct socinfo, serial_num) + sizeof(info->serial_num) <= item_size) {
> +		snprintf(buf, sizeof(buf), "%u", le32_to_cpu(info->serial_num));
> +		env_set("serial#", buf);
> +	} else {
> +		return -ENOENT;
> +	}
> +
> +	return 0;
> +}
> +
>  int qcom_smem_init(void)
>  {
>  	struct smem_header *header;
>  	int num_regions;
> diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
> index a955db08c0f0..755003807dba 100644
> --- a/include/soc/qcom/smem.h
> +++ b/include/soc/qcom/smem.h
> @@ -4,8 +4,9 @@
>  
>  #define QCOM_SMEM_HOST_ANY -1
>  
>  int qcom_smem_init(void);
> +int qcom_socinfo_init(void);
>  
>  bool qcom_smem_is_available(void);
>  int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
>  void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
> 
> -- 
> 2.53.0
> 
