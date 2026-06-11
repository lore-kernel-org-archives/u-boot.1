Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD11CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F808495E;
	Thu, 11 Jun 2026 14:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jPvBfgj/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eXM5FmT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C1D83FEC; Thu, 11 Jun 2026 13:29:51 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 418B6838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 13:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B9xBn2263549
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aGxBzsO/3sztvGvvMm+akLeW
 FpiZaZ+jTnNiDvQbmTE=; b=jPvBfgj/SPRm3KfuXosdy3kgSuo/Ym17dO4Tux4o
 Ymugh1SSuiwRtYXjlkjUN/fOR+Q+I2fNuxgDcHuoblU9uhm5OAiu+xRO+kfR8JM1
 X6JcxVIVfveOctA2q6t0SJa0mlHdqlcrfYu0CMTXvsr0NU8DOHuAsDnJi/4YWOXS
 CgPnqCBDXLzOn4JLuvaqdrST0t8qffQo3WXeLQSzAZ4SfTY8t3OWVPiLHr0yEAES
 BPfjZejjKM6v9+DE6kYNZ4UqrnA9CBnRUIShgGulhnuSU2/BjQHgOBKbDWSaNk0S
 giH2YaZrhosiuZ2EAKm9GuAgF/tOTTj5LNOzyIy1+dPHSg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uu514-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:29:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c0c32faa62so138417095ad.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781177387; x=1781782187; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aGxBzsO/3sztvGvvMm+akLeWFpiZaZ+jTnNiDvQbmTE=;
 b=eXM5FmT8SXnyhG8QOhuTvc5aCU/KV4alIwelh0c1PDvVqUmXk+FpjBV5DHu8hLSfzs
 ZrnkNaoR09IKRZspanvnNMWctRG8H4EVOw4dlHFq4qPPdGPJzQ1DgnU80nGu/s/u7Q5p
 n58gRrk+Bus7EjJ4RiIJK01bbRvdvApoK1atrkSdcRudK04Eq4bikC7a4jkMtHZJQLKX
 BvVGxlXCEtv/ISoxsEP6T14Kx3dfxlO1M3hNYaPMMjvRDf4PArnZq+j7xHbvM+mIJyN7
 lvyWeyHI6+3IIB1c6BQIjr2sAeDsntKMFecKkiNIbiSkMpQBT2WEHZPoyq5CPegaSfqR
 SaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781177387; x=1781782187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGxBzsO/3sztvGvvMm+akLeWFpiZaZ+jTnNiDvQbmTE=;
 b=ianZcazN/Ccu3UIcQKCfJNMpk6/zgHLY+PubRr6ONZ/sVG+BGSju5/ma7oF3H1LUul
 N1o5gcSOMd3rSKogH+pX+ggJBowiH538W7Cg808RsebBhSXPfIqCgpjaSRRvyXGm65s8
 lXHJa8+ikCYmWQ8zvqXdK2R/Q5cR8wgY+DQviRSv20Oa2VLYKTKXfwbYjYsbPNVk/71Y
 1tf2ArwJ4co7dwnFeGZlT2USuZQPh2zmavkujqQ4CQUkXAbObgL4Ej15NfY/wiyRyDJi
 t0g027ib2j4FW2iZKx0pF9Ry5yLO3keEbO3i1EFbZZEJHEJ+0adgvogoPKag7O5yzxNT
 ueWg==
X-Gm-Message-State: AOJu0YxRmQG68u7wNCePF18GN8vfZvhNYvn4ybFShtmRPzF168SRwSBZ
 +Hpzig+buIFIrqePQXlejJYHYpBX6yIgdz2pSWqJXPDTz+OojLqgurlrhepEwWCVr7s+UOF9b1R
 RWkk4LOrvtT9E1zA9i6PQqYdYQWCPcAAdS+hBVZCbMktYQRSwuCSYFqD4
X-Gm-Gg: Acq92OEtEJjRf4X4vD4SAVMj40+bdUX2/VCEe0IVk/6RqfiTMnQh0aTtH+uPpE1A9Cx
 7sRly0bUAaVbU5KaiSYD0TThdpG9mEovnk0idIH6j+3pjoab+oicklANnlev16FjR6TqXt8Elk9
 SWE77nKWTUyF/UOjsKI/kfticcEzYM+gRL27p+OLeVmB1GsNeZ7VfIKu2WCd0qPl5gkdDxNeA5N
 YsAHIqRMzGblnP70k175sbwDSZaN1wWGiJIwYVszRBoMq/wpXupnQ0QXHNr6Ig7A1vss+F6kq7a
 lPRXsa9cRNVaziXUUrf+gZq6nHoToJ0TQ5c81jVE2lEi+hCLSm93kdeuHItCFCH/c7TG5CKEf8D
 g6bQ1csUTRxQgj623JmWYQXvS4fkxNIKgEtfxnzjBMlNvTe32gyK7DAmlF4w838RQac3zshmALL
 A0Tq6avMgnqrRxoEsVTTwMyZd+o/IGKRZGWUfTCYLfPi0c+KS0mO1d6aZ7yUFW0w==
X-Received: by 2002:a17:902:cecd:b0:2c0:c37d:dfc3 with SMTP id
 d9443c01a7336-2c2f0f16901mr26901775ad.15.1781177386649; 
 Thu, 11 Jun 2026 04:29:46 -0700 (PDT)
X-Received: by 2002:a17:902:cecd:b0:2c0:c37d:dfc3 with SMTP id
 d9443c01a7336-2c2f0f16901mr26901255ad.15.1781177386018; 
 Thu, 11 Jun 2026 04:29:46 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c24edc8acasm154483785ad.45.2026.06.11.04.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:29:45 -0700 (PDT)
Date: Thu, 11 Jun 2026 16:59:27 +0530
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
Subject: Re: [PATCH v2 04/14] spl: ufs: add SPL_UFS_FS Kconfig and filesystem
 boot stub
Message-ID: <aiqcF4MfSQUmB7Zi@hu-varada-blr.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-4-72fed24ef01b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-spl_ufs-v2-4-72fed24ef01b@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a9c2b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=hVQ-R1W7B6_Nt_bId84A:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNSBTYWx0ZWRfXyIz7z5JmxKZl
 3nrGIA6rmmREZ2daR5OrvzACbgWmaIi/iI59G6YEIFBnaQa9wYvb1bLimzwu5oubNvkgaQqgrSx
 /vblEaDTLIf9+4Tf/3aOq6k8KJOE4p4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNSBTYWx0ZWRfX146FA57IJORC
 feBzXMha/Z+Souzx2YRBhPJ+fDR3UZkgHNX96rHOzHHblw5vhydPpOlMFCL/+h9OtllWJTVWrVq
 EzIEcM0LAx1mO+tbUxTcCgLyYMad5CCYJ7/2xBKXaJGFMpR+1zbeeeSz+OfUXx6WQO45xzDLEbJ
 ARsTxIClVEAsrPajhjncmtK0pAZEEz9kVwSPfM1xgy9aEHCCWAitQVC792HtVcAyiE4xC/9Oaca
 yL2HvBDAF7NzPh7YROgqGiL62OuzcdLwuZ6DgMXKT9mw3D6kNBEC+QKIh0UCXRvu/4wqVXx4Lag
 +1LAZ50YBFZsN2wkkfJ5DG1P4xg7NYnCBtIBz+Agf+8cHgHZOK/ehM2M2nxZPWOS360QyKjf8+/
 x5+wYIU7Ds2Rz0p/59NXNEpI4PqRNwLdBFmTHAk1MHLYsYbw8+MzOhbIi6iz3LDMlkmJeIo8Xmf
 V0fKh7jPxMf6oAMXJWg==
X-Proofpoint-GUID: D5d6FNLnCXMsWY0q1TArr1BfMxz8EyGb
X-Proofpoint-ORIG-GUID: D5d6FNLnCXMsWY0q1TArr1BfMxz8EyGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110115
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

On Sat, Jun 06, 2026 at 03:48:35PM +0530, Balaji Selvanathan wrote:
> Add a new SPL_UFS_FS Kconfig option to enable filesystem-based boot
> from UFS (FAT or EXT4). When selected, a UFS_MODE_FS case is added
> to the boot-mode switch in spl_ufs_load() raw mode on failure.
>
> The filesystem path is currently a stub that
> returns -ENOSYS, serving as a placeholder for future implementation.

Is this really needed? Can't this be added along with the actual support.

-Varada

>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Added the filesystem support in SPL UFS as a seperate patch
> ---
> ---
>  common/spl/Kconfig   | 10 ++++++++++
>  common/spl/spl_ufs.c |  9 +++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 82b757d1efa..8609f08413b 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1682,6 +1682,16 @@ config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
>  	  with partition support. This is used if partition name is not
>  	  specified or not found.
>
> +config SPL_UFS_FS
> +	bool "Enable UFS filesystem boot mode"
> +	depends on SPL_UFS
> +	help
> +	  Enable filesystem-based boot from UFS. This allows loading
> +	  U-Boot from FAT or EXT4 filesystems on UFS partitions.
> +	  This is tried as a fallback if raw mode loading fails.
> +
> +	  Note: Filesystem support is not yet fully implemented.
> +
>  config SPL_WATCHDOG
>  	bool "Support watchdog drivers"
>  	imply SPL_WDT if !HW_WATCHDOG
> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> index 0590b796267..8a60948a304 100644
> --- a/common/spl/spl_ufs.c
> +++ b/common/spl/spl_ufs.c
> @@ -142,6 +142,15 @@ int spl_ufs_load(struct spl_image_info *spl_image,
>  			return 0;
>  #endif
>  		break;
> +#ifdef CONFIG_SPL_UFS_FS
> +	case UFS_MODE_FS:
> +		debug("spl: ufs: boot mode: fs\n");
> +
> +		/* TODO: Implement filesystem support */
> +		printf("spl: ufs: filesystem boot not implemented\n");
> +		ret = -ENOSYS;
> +		break;
> +#endif
>  	default:
>  		puts("spl: ufs: wrong boot mode\n");
>  	}
>
> --
> 2.34.1
>
