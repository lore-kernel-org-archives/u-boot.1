Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7549E9A779
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 12:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3746A807C0;
	Tue, 24 Mar 2026 13:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="s0WrO7RI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57CDD838BB; Tue, 24 Mar 2026 13:02:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E99880517
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 13:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b4de=BZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1774353736;
 bh=06jmEoeVsNS1NrYkZxCjGty8bjBn67YCBAR81LmN/4E=;
 b=s0WrO7RIB5VCjfR/GQmwuvPZZG0yFZ/mBuREi4FHvFjS9UCyiQCGvjjixGCCjJZaXonNdSfF3
 3QzCc/hH9z6P6tVibkc9MMGhCEjopwh3xrDMPoRUsKeY88j/ZtOwxzbgn0TmC6J0HW1u2aSmxrZ
 8EAnEIHwSLdMbeRLWCE/uo0lsybSJ9WnDrQCQ3QcGiuBsXtnERyaUpzVGVDMKzlpmktbBJ4cgF/
 eMzrzKuD5Hm60fW3bTtd4yKywE3SvXhR9HssJjgO9BFojZhoK2MW4pamTJNxfS0YvCx/gQI2LDN
 aOc8sOr4mPna4/be5pSpUpr0GSPwPaaPV5sNbNWO6G4Q==
X-Forward-Email-ID: 69c27d444e162f78964b74f6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.55
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <6b16c87a-ef5d-4c5d-9268-f1c0c3884b05@kwiboo.se>
Date: Tue, 24 Mar 2026 13:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs: fat: Limit transfer size to prevent SDHCI
 controller timeout
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Lukasz Majewski <lukma@denx.de>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
 <20260324-emmc_sd-v1-3-883a45538b6e@oss.qualcomm.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260324-emmc_sd-v1-3-883a45538b6e@oss.qualcomm.com>
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

Hi,

On 3/24/2026 6:52 AM, Balaji Selvanathan wrote:
> Some SDHCI controllers have limitations on maximum transfer sizes
> and can timeout on large block operations.
> 
> Break large read and write operations into chunks of 16384 blocks
> to stay within controller limits. This prevents timeout errors during
> large file transfers on FAT filesystems while maintaining
> compatibility with all platforms.
> 
> This patch builds on top of the work from:
> https://lore.kernel.org/u-boot/20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com/
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  fs/fat/fat.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> index 85b511f75af..6ec241af584 100644
> --- a/fs/fat/fat.c
> +++ b/fs/fat/fat.c
> @@ -30,6 +30,9 @@
>  /* maximum number of clusters for FAT12 */
>  #define MAX_FAT12	0xFF4
>  
> +/* maximum blocks per read/write to avoid SDHCI timeout */
> +#define MAX_BLOCKS_PER_TRANSFER 16384
> +
>  /*
>   * Convert a string to lowercase.  Converts at most 'len' characters,
>   * 'len' may be larger than the length of 'str' if 'str' is NULL
> @@ -136,18 +139,26 @@ static int disk_rw(__u32 sect, __u32 nr_sect, void *buf, bool read)
>  	if (rem > blksz) {
>  		n = rem / blksz;
>  
> -		if (read)
> -			ret = blk_dread(cur_dev, start + s, n, buf);
> -		else
> -			ret = blk_dwrite(cur_dev, start + s, n, buf);
> +		/* Break large reads/writes into chunks */
> +		while (n > 0) {
> +			__u32 transfer_count = (n > MAX_BLOCKS_PER_TRANSFER) ? MAX_BLOCKS_PER_TRANSFER : n;

Have you tried to configure SYS_MMC_MAX_BLK_COUNT=16384 for your
platform, or otherwise set b_max in your mmc driver?

That should cause similar max blocks handling at a the mmc-uclass level.

Regards,
Jonas

>  
> -		if (ret != n) {
> -			ret = -1;
> -			goto exit;
> +			if (read)
> +				ret = blk_dread(cur_dev, start + s, transfer_count, buf);
> +			else
> +				ret = blk_dwrite(cur_dev, start + s, transfer_count, buf);
> +
> +			if (ret != transfer_count) {
> +				ret = -1;
> +				goto exit;
> +			}
> +
> +			buf += transfer_count * blksz;
> +			s += transfer_count;
> +			n -= transfer_count;
>  		}
> -		buf += n * blksz;
> +
>  		rem = rem % blksz;
> -		s += n;
>  	}
>  
>  	/* Do part 3, read a block and copy the trailing sectors */
> 

