Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C28CCD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB36084944;
	Thu, 11 Jun 2026 14:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bKNGSHk6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZO924sVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C6283FEC; Thu, 11 Jun 2026 13:27:17 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D48E838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xAZr263521
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1w0WR2nRE0CQWPU47VH5voXK
 dw4am7bU02qxyqcoFjg=; b=bKNGSHk64XpfWfdA9jAJPCXId4aVXn5VMwsX09Kk
 pWuGuwytLmKU2s0C4KPyt/SA16c+5yC7DnUFg/6x90xgOgMIyJLB7QkfvLyuBuvx
 SGYKLzvkXpnLYYr8HwzeM7A4S3bIZh3ETHk6ICFJEJzZmGs01UhD1dl7bnLyycGR
 tFUX8meC6727Wo+whCckQY52AqY5C7R7X7I7QLnyeUERXSsaauVWr3Rg03BHSgVP
 I5seloYzlgCfwv9hOFUBK1uTy3v+XXd4oKZNG4Vah2RatVcQ+FTIg72+XD4zC0uL
 RLEezz0hImEELr0E0TzOP4r99OmUaHuCtLfZMtCQUqy5+w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uu4sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:27:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36d99181eaaso10313095a91.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781177232; x=1781782032; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1w0WR2nRE0CQWPU47VH5voXKdw4am7bU02qxyqcoFjg=;
 b=ZO924sVxTSgXbrO+d9TJGVJcEi/8rV+ymhUX+ALzMuTWML6jusr6Qw8WfCe9aC9my1
 yCKpksyUYEyVxHCiLr4EltoUgQW9sWX4QJ2uYJmG++W/41E4RmSubvN61fBU3izSGUwM
 a6Z3aSYzFZqXCpqXhrAqihNTtUXgdos9mtE+UOy9Djefbb+5WXMdOYbNp6y9OstSV64z
 jn3dAm5RexDOz9fPbIc115+wV9Ft/i84dSvfeqDqqk9pD9SiayHhAtHK0uGVJKpYppnq
 QpwmrBHrVhuHytwYEn00Zrr22aCPa2h1zMdGGsMhIQSG4De6i5KroSHoh1MmPF4qcrZo
 X4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177232; x=1781782032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1w0WR2nRE0CQWPU47VH5voXKdw4am7bU02qxyqcoFjg=;
 b=CbwT61i871mqy0hM70bdjtMYDsF0t0IuiZHWYW0c4A41M4DHqMTSvaWy5Ewoxpltf1
 dlbefwiB29tTLcQQRL1AoexzvtUTednch95S/I2g0xVLRUkzAqJOHq/lOgYZfT+Jxr6k
 n+1S08uj6aKncwztv/wHZxJ33ctgfXbfp5phCKS931OeuYnvGJpjvVjT9L2qGIPrpKqv
 YSPFp1djdr66KKysw296Pb5VWe4hppovZ1TjaysvdNzuCzYbLgb6TIHsWROxwE3SncWc
 F6gnKiKd24aSVCCnt20MGx/VerI7qf9CB5ge1WJzC6eosGnVhq5rOYle1Rw7YMimlqpZ
 9/NQ==
X-Gm-Message-State: AOJu0YwMa/cEcvlLSiHEey920XHgkrW13OzdQ6bteOwH63KqxDR6SsNW
 0J9/XsSx35lNCHPjzEVomwCtlrUYXZsf7IGmHwzqQgjXT/HnurvZKwm08rZ5R+AxTwiuGpwv+Kg
 MokDLXkTiNMUfejQKs9xXD0gdmXDUy6aXbKN7AnNJv5CcpUIjlQmYmXVM
X-Gm-Gg: Acq92OHsr1f7/C40gJG5wK0AlwnS34gDOMc3vxkbZkiKwe52DO/BkdrxGeks9V1U8nu
 n8Hmj2yuyjf7TtRCpGn39KQpZUPu2iOlkZY4ZTzavbO+tPvnGfweGBmDGtqqnVQFUwkVK4fQkPp
 JBiccm9nLjyiTpVzIDdbYSR6mMQdOc+4cemrn/JPRy9HcUN5a5dAe78rXrb0muBdGQVliMK1C5J
 2uiGe6LS8DOaSUMn1V4V6qtLSWxGRTxjtkL+cmdqYdst2vfbpkNVAK1g/XDlTdTkYO8qGUuwEvi
 QE8WR09MVCtdFAXDY9soNcovgg8U2ofjW8p74r6lKUfuIJ/0PMYCVjRe7qi8L0UFInzqg9sIB5P
 m4hwdoFKhPkOPgqUL1v3FiNUHr1J5QoT8caKLlLBtrjQ3GVR/k3XseQecQPOxAuzbDDvH0/VXXg
 w0/uFe5yIpmVJtW0uo4VSq7W7nvMahpFdeZH88bAe4w7gmI2P68PkGWjAu8kxnEg==
X-Received: by 2002:a17:90a:fc44:b0:36d:7a76:827b with SMTP id
 98e67ed59e1d1-377a73e2769mr2791378a91.14.1781177232221; 
 Thu, 11 Jun 2026 04:27:12 -0700 (PDT)
X-Received: by 2002:a17:90a:fc44:b0:36d:7a76:827b with SMTP id
 98e67ed59e1d1-377a73e2769mr2791284a91.14.1781177231593; 
 Thu, 11 Jun 2026 04:27:11 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c865860f3d4sm1493143a12.19.2026.06.11.04.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:27:10 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:56:52 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v2 03/14] spl: ufs: add partition-based U-Boot loading
 support
Message-ID: <aiqbfGNQM+MHBNx5@hu-varada-blr.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-3-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-spl_ufs-v2-3-72fed24ef01b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a9b90 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=x8z6N94bNqqnlutHHogA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNCBTYWx0ZWRfX5WUb/av0pmc5
 oa/ZBc3kjLq3BmSfVFWHIjpjG3VUTOVjjxm/ils4TC2vHk/XDYeWv8OiscFwzL7/V7YaMAT2i3Z
 OcAUMsHFTsx1yV0N+nu6xAf/LGY/TgM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNCBTYWx0ZWRfXxb88iXltE5Wj
 mF7CxI50jQrtQmOMdNMa1ciIbhssaTeflf9yjj7fJ5Bgoys0fI8DiuZIj0LQH67zaKoOHlsjpVL
 dZVxi/XThF9H5CjN2/hYlwh8biTOXexGiVzcXlaq2ZBShP96zFGspWwmU84IwUSC4By91ZGcYD2
 LD6hI8oUeOOObPtJPlAFSGWIzS7vjujBtspuZ0XqZHIEWBFglWpnTX1xhnV0BeTRzHqMzmb9jz3
 OUAbdzw1X38eO4gUU3c/zQ7REV1dwR2emZy//7FnK3St7somWejM9BwWG/DDdZO5FGPDaJLPqC2
 ZiaK9ixBCp4AUXS/hDpdkFeo3uA9PhCLx7TReNNj392n75KjbJO2gktAYHvaKAoer9j4kjbyJsJ
 FfwEo5zfLI73HWyF3ccJzEklPTEZnRCI1LScA0Erde9z7gFV+UkVv26M3nowIXMs31zANgnQgZj
 Vs6d+bXwuJ1aPykg0JA==
X-Proofpoint-GUID: axHmUTq61oGoXTsbV3iIeGkBtqSyAdms
X-Proofpoint-ORIG-GUID: axHmUTq61oGoXTsbV3iIeGkBtqSyAdms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110114
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:44:23 +0200
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

On Sat, Jun 06, 2026 at 03:48:34PM +0530, Balaji Selvanathan wrote:
> Refactor spl_ufs.c to support loading U-Boot either from a raw
> sector offset or from a named/numbered partition, controlled by
> the Kconfig choice introduced in the previous commit.
> 
> The monolithic spl_ufs_load_image() is split into helper functions:
> ufs_load_image_raw_sector() handles sector-based loading, and
> ufs_load_image_raw_partition() resolves the target sector by looking
> up a partition name first, falling back to partition number. A new
> exported spl_ufs_load() function drives the boot-mode switch and
> can be reused by other callers. A weak spl_ufs_boot_mode() hook
> allows board code to override the default raw boot mode.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Refactored the codes in common/spl/spl_ufs.c to use helper functions
>   to make the codes readable and clear
> ---
> ---
>  common/spl/spl_ufs.c | 153 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 134 insertions(+), 19 deletions(-)
> 
> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> index cef1843f40f..0590b796267 100644
> --- a/common/spl/spl_ufs.c
> +++ b/common/spl/spl_ufs.c
> @@ -3,15 +3,19 @@
>   * (C) Copyright 2025 Alexey Charkov <alchark@gmail.com>
>   */
>  
> +#include <dm.h>
> +#include <log.h>
>  #include <spl.h>
>  #include <spl_load.h>
>  #include <scsi.h>
> -#include <errno.h>
> -#include <image.h>
> +#include <part.h>
> +#include <blk.h>
>  #include <linux/compiler.h>
> -#include <log.h>
> +#include <errno.h>
>  
> -static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size, void *buf)
> +/* Block read callback for spl_load framework */
> +static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
> +			     ulong size, void *buf)

Not sure why the 'spl_ufs' prefix has changed. I assume these are SPL specific
since this is in spl_ufs.c.

>  {
>  	struct blk_desc *bd = load->priv;
>  	lbaint_t sector = off >> bd->log2blksz;
> @@ -20,30 +24,141 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
>  	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
>  }
>  
> -static int spl_ufs_load_image(struct spl_image_info *spl_image,
> -			      struct spl_boot_device *bootdev)
> +/* Load image from raw sector */
> +static int ufs_load_image_raw_sector(struct spl_image_info *spl_image,
> +				     struct spl_boot_device *bootdev,
> +				     struct blk_desc *bd,
> +				     unsigned long sector)
>  {
> -	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
> -	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>  	struct spl_load_info load;
> +	int ret;
> +
> +	debug("spl: ufs: loading from sector 0x%lx\n", sector);
> +
> +	spl_load_init(&load, h_spl_load_read, bd, bd->blksz);
> +	ret = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
> +
> +	if (ret) {
> +		printf("%s: ufs block read error\n", __func__);
> +		log_debug("(error=%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Find and load from partition */
> +static int ufs_load_image_raw_partition(struct spl_image_info *spl_image,
> +					struct spl_boot_device *bootdev,
> +					struct blk_desc *bd)
> +{
> +	struct disk_partition part_info;
> +	int ret;
> +
> +	/* Try partition name first if configured */
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME
> +	if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0) {
> +		debug("spl: ufs: trying partition name '%s'\n",
> +		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME);
> +
> +		ret = part_get_info_by_name(bd,
> +					    CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
> +					    &part_info);
> +		if (ret >= 0) {
> +			debug("spl: ufs: found partition '%s' at 0x%lx\n",
> +			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME,
> +			      (ulong)part_info.start);
> +			return ufs_load_image_raw_sector(spl_image, bootdev, bd,
> +							 part_info.start);
> +		}
> +		debug("spl: ufs: partition name not found: %d\n", ret);
> +	}
> +#endif
> +
> +	/* Try partition number if configured */
> +	if (IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM)) {
> +		debug("spl: ufs: trying partition number %d\n",
> +		      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM);
> +
> +		ret = part_get_info(bd, CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
> +				    &part_info);
> +		if (ret >= 0) {
> +			debug("spl: ufs: found partition %d at 0x%lx\n",
> +			      CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM,
> +			      (ulong)part_info.start);
> +			return ufs_load_image_raw_sector(spl_image, bootdev, bd,
> +							 part_info.start);
> +		}
> +		debug("spl: ufs: partition number not found: %d\n", ret);
> +	}

The debug() is not considered, both the above if blocks are same except for
part_get_info_by_name & part_get_info.

	if (strlen(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NAME) > 0)
		ret = part_get_info_by_name(bd, ...);

	if (IS_ENABLED(CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM))
		ret = part_get_info(bd, ...);

	if (ret >= 0)
		return ufs_load_image_raw_sector(...);

-Varada

> +
> +	puts("spl: ufs: partition error\n");
> +	return -ENOENT;
> +}
> +
> +u32 __weak spl_ufs_boot_mode(const u32 boot_device)
> +{
> +	return UFS_MODE_RAW;
> +}
> +
> +int spl_ufs_load(struct spl_image_info *spl_image,
> +		 struct spl_boot_device *bootdev,
> +		 const char *filename)
> +{
> +	u32 boot_mode;
> +	int ret = 0;
> +	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
>  	struct blk_desc *bd;
> -	int err;
>  
> -	/* try to recognize storage devices immediately */
> -	scsi_scan(false);
> +	log_debug("spl: ufs: devnum=%d\n", devnum);
> +
> +	ret = scsi_scan(false);
> +	if (ret) {
> +		printf("spl: ufs: scsi scan failed: %d\n", ret);
> +		return ret;
> +	}
> +
>  	bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, devnum);
> -	if (!bd)
> +	if (!bd) {
> +		printf("spl: ufs: could not get device %d\n", devnum);
>  		return -ENODEV;
> +	}
> +
> +	boot_mode = spl_ufs_boot_mode(bootdev->boot_device);
> +	ret = -EINVAL;
>  
> -	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
> -	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
> -	if (err) {
> -		puts("spl_ufs_load_image: ufs block read error\n");
> -		log_debug("(error=%d)\n", err);
> -		return err;
> +	switch (boot_mode) {
> +	case UFS_MODE_RAW:
> +		debug("spl: ufs: boot mode: raw\n");
> +
> +#ifdef CONFIG_SPL_UFS_RAW_U_BOOT_USE_SECTOR
> +		ret = ufs_load_image_raw_sector(spl_image, bootdev, bd,
> +						CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
> +		if (!ret)
> +			return 0;
> +#elif defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
> +		ret = ufs_load_image_raw_partition(spl_image, bootdev, bd);
> +		if (!ret)
> +			return 0;
> +#endif
> +		break;
> +	default:
> +		puts("spl: ufs: wrong boot mode\n");
>  	}
>  
> -	return 0;
> +	return ret;
> +}
> +
> +/* SPL load image entry point */
> +static int spl_ufs_load_image(struct spl_image_info *spl_image,
> +			      struct spl_boot_device *bootdev)
> +{
> +	return spl_ufs_load(spl_image, bootdev,
> +#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
> +			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME);
> +#else
> +			    NULL);
> +#endif
>  }
>  
>  SPL_LOAD_IMAGE_METHOD("UFS", 0, BOOT_DEVICE_UFS, spl_ufs_load_image);
> 
> -- 
> 2.34.1
> 
