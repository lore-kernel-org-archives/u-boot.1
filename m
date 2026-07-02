Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2EFC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 11:20:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC8C84987;
	Thu,  2 Jul 2026 13:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WcbrQQna";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcfIN6w3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F1D849A3; Thu,  2 Jul 2026 13:20:49 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70BBC8496E
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 13:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662AVWfb3591605
 for <u-boot@lists.denx.de>; Thu, 2 Jul 2026 11:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6wDQTSvmO8A2rbxPzL6jn3j+
 qKhJX6IaFifZfyuJPgU=; b=WcbrQQna90F8oVuTKWXyUJS0Y7CqNIEkAEV2yUk4
 UhQskeaaK+lytmiF7sl7hgmBctQeXa+MWHcbF09318GTUx/uyUgBcCfw79ejm5MV
 0AMkEsIm73Bz6L7Z3ysnfKsB/wdtcIVV96TEXk5YXEJsizvY3ckZ47YADlu01ob2
 U6W33aYhcvpypnVHoSCtTN7ojg/JtLXVJ511toAcx44lveuQk2GbWwZ8fHDtCGQ0
 TG4sbvr17Jcrfz9jIIuo58nM8uKXLwjmERreWZrtxZukb9TLvYXD37dKn7Lc2RGb
 OJkxSPT/rQSuBfP6rNCZRZVHnynTCUubySq2BYoUZzIf0A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9ebu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 11:20:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9aa197d5easo645678a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782991244; x=1783596044; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6wDQTSvmO8A2rbxPzL6jn3j+qKhJX6IaFifZfyuJPgU=;
 b=hcfIN6w3M9fIpJL5q7xVroIGKRIExby0Xgp/dxEM+1sn17yEKHj3nApaIOwguC3XzR
 SiTJvorzkl8+SmECtcs3GAQc8rilWBPxRY5oWQz+XcMh9DS4aaUS7Kd0ZurAIYy34Gbm
 OQkWU7SdGGQHrg5/yK7mqw23EUThp0M8KjdVOsUgxDYC3e2jXESKe2S3qXIIsXpfdBe1
 YDIisssqAh6GT7OOezcanAin7NTv1eLC4NKJOd6BlnoCDmeoIrLi1S1mITSkSgDBHZVG
 nEXc0OEuaD2UwzF7AdWYfyu0lwS22h415u1FCLZOC4fomleWX44gFcNCTzPgPvPGme6b
 l/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782991244; x=1783596044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wDQTSvmO8A2rbxPzL6jn3j+qKhJX6IaFifZfyuJPgU=;
 b=nzbSGl95l5r7M1UVkpZ0Ge3zTnO9qRgOiurjh/Ixcdyhfta4W0rqLrcdzXXk5IK9X/
 IufWmZUoSzjB/Kr/vTSrfqBTUoaeUO0QLFFojJzBNopFGknuGpt4jUE3s4vzAuVAkaQ4
 61PBhN5Wx9JMueS4WX5r18JdR7GPxYWbxnkc418P2fKsfxSYjtXFaliY2Dk4qLVFS2/W
 67V+yRSGUG/EzOZWIRva//7/wgN2/odiU23QpCYuVzURWrBnx1FotKVQViOYX6GcOd2s
 9cKrCLH8z1zH5RyJsWQjo9s7FWVavtPxiq1EbT19inAp9hqVqLOv3auBCx05xptQVHrt
 CLlg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpqUCk1NdOxKaEtMvQTSiJAPihqCkhLRlTGmSU2abl2/9lR0o4eS2bLi+yYZUGL/BGoqVCGGcQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyqVhxAAd58CxiCwMnWHI95WMuaXLZYJABhpCMwCryaIVqIhBVc
 HgqbY0icVaJ+TnThIDf6+JM6Gucu3FqUxPnPmjI78A7r9leTN6EW7qGJq0Ee63roAVAb0TEtSWX
 iez8egykLsdwYnqN8rHioSxfa3i5eFcnuktyVQRx5jsoFkpeiolHoIGow
X-Gm-Gg: AfdE7ck+hMTcA9PigOcFqnwtd4mN5hVr1Lf0k6WaFVuH6QDTVWIfY1o42pVyfL68gTH
 NnhGPy3KF7Lwq3bkHD2guwqRrf+e/9piGUKqGLKVAhVzTdg9lNOEQoWrmoMscLagDTi9mB8uLZ8
 +6/2Whb8NKLseOs4xXoG/Bio1+p6dFkcBq9bjtxV2kjn/XOBrpEFRs3rsYaaL7MxxJVEK+nenra
 /+oj+wbrbW2x0Z7Dni0NDvbwGakBI3FsghoBxE5OMQfbAcpua2yca5njOA+jW+L7KjSTL7sFtXC
 rLUbR1V1X37REp+AzffKRKri/4xbPsmNHc5wHk9+5ERIH4L/JjflAz1CTmE9S1gZtK5bJQH9qRR
 wf5tVe3WnkQmkVmmEWAO6G1j2jkwuxaSvcW60WS++hLAROUDiqGvYPSZrO3SkZiEio/t8FfHVsh
 GRjewC98Uu27bsu6b6iEZ7P8UhJ9Bxji9Bn1dRA8Gu
X-Received: by 2002:a17:90a:f943:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-38086d88420mr5321912a91.18.1782991243510; 
 Thu, 02 Jul 2026 04:20:43 -0700 (PDT)
X-Received: by 2002:a17:90a:f943:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-38086d88420mr5321880a91.18.1782991242825; 
 Thu, 02 Jul 2026 04:20:42 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f1595e912sm5175024eec.31.2026.07.02.04.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 04:20:42 -0700 (PDT)
Date: Thu, 2 Jul 2026 16:50:35 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot-qcom@groups.io,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] dts: qcom: remove hardcoded memory maps
Message-ID: <akZJg7fQmXsvFqg3@hu-varada-blr.qualcomm.com>
References: <20260701101937.234609-5-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701101937.234609-5-casey.connolly@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExOCBTYWx0ZWRfX70lCtfjSb2b+
 SVbuTsDMVV8zMwUZVWDbkeRynVeLqnyrvaO3eULHdkY0O+RdT2QYN/E+jB9ocFEgY6yClWKDLnX
 MaNfrSWuj/WBh116mDLQjZ1Ch0iMAux562tHrDFFvZH2WIdiXqMpfDv9+tlgkMJ0Ofz4fP090+R
 OjyfZyRe0vP4dYlS+Nw30hJ1urkCUnbqeiDGm6i3AmNIFP/353yvCaMxUmE3xZqBKDA+MMGgyZ7
 HXo1qc9KNAzgnvCMSJ/enYI/KmncDoIYL37A+RjBX1dPLzo7MtKKo9sFwGZN1BXv0J3XDTIA0bO
 CVdE8TjvHfH4AofCTmiNg52XD3KpdV8jFum8tPV89wuPJGBjfpOJud5xSE8WR3sGUt5p0Py3bjw
 0O9j9SU7PWK8ulA2jbHaEVWkCjK7i30HVMKAvG8uZeVs/WZutM/1PMjI1HuzPEGHowN7tDXJXbd
 ifSM3W9JoLr/5AS6uyA==
X-Proofpoint-ORIG-GUID: 2dqf9D4GdqkBeP9PkvJrR_8A4aK62DVF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExOCBTYWx0ZWRfXw8qgBGGwVHtK
 g9YN0VsCAzhHqz9UTB8kQuwpIwEIhDaAby4T8H5PN2ywumWi9ml55YENjGJ2fnsUOGxj/o/jKfl
 22fzQQHrKJlhOgiS2JyMnANHLdrRevw=
X-Proofpoint-GUID: 2dqf9D4GdqkBeP9PkvJrR_8A4aK62DVF
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a46498c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=YfCOm-DyAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=Q0FsJjaaF8MOv_KBiecA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020118
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

On Wed, Jul 01, 2026 at 12:19:33PM +0200, Casey Connolly wrote:
> Qualcomm boards have traditionally relied on a prior bootloader stage
> to populate the memory map in devicetree, and when that wasn't available
> the memory map would instead be hardcoded.
>
> With proper support for SMEM in U-Boot the memory map can now
> dynamically be read out of the SMEM database which is populated on boot
> by the preloader (sbl1).
>
> Switch over all the boards that previously relied on hardcoded memory
> maps to use SMEM instead. This has been tested on the Rubik Pi 3 and
> db410c however other platforms still need testing (see below).
>
> This affects the following boards:
>
> * IPQ5424 RDP466
> * IPQ9574 RDP433
> * QCS615 Ride
> * QCS6490 RB3 Gen 2
> * QCS8300 Ride
> * QCS9100 Ride
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> This patch is based on the qcom-next branch found on the Qualcomm U-Boot
> Custodian repository [1]. For testing please check out that branch,
> apply this patch and then build/boot U-Boot. Ensure that you have
> CONFIG_LOGLEVEL set to >=6 and look for the "Memory map loaded from"
> message during boot, it should say SMEM.
>
> If nothing is broken in U-Boot and Linux then please send your Tested-by
> indicating which board(s) you tried as a "#" comment after your email.
>
> [1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon
>
> Cc: u-boot-qcom@groups.io
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This fails to boot on both IPQ5424 RDP466 and IPQ9574 RDP433.

IPQ SoCs have the following node in their DTs under reserved-memory.

	$ grep bootloader@ dts/upstream/src/arm64/qcom/*
	dts/upstream/src/arm64/qcom/ipq5018.dtsi:	bootloader@4a800000 {
	dts/upstream/src/arm64/qcom/ipq5332.dtsi:	bootloader@4a100000 {
	dts/upstream/src/arm64/qcom/ipq5424.dtsi:	bootloader@8a200000 {
	dts/upstream/src/arm64/qcom/ipq6018.dtsi:	bootloader@4a100000 {
	dts/upstream/src/arm64/qcom/ipq8074.dtsi:	bootloader@4a600000 {
	dts/upstream/src/arm64/qcom/ipq9574.dtsi:	bootloader@4a100000 {

While booting, initr_caches -> enable_caches -> configure_reserved_memory
unmaps the above 'bootloader' reserved-memory region. Eventually, when
U-Boot looks for environment variables via env_get_f(), the 'env' pointer
points inside the 'bootloader' region. Since it has been unmapped, it
crashes.

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f64ec0c674e..d554537fbec 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -112,6 +112,10 @@ static void configure_reserved_memory(void)
        fdt_for_each_subnode(rmem, gd->fdt_blob, parent) {
                const fdt32_t *ptr;
                attrs = PTE_TYPE_FAULT;
+
+               if (!memcmp("bootloader@", fdt_get_name(gd->fdt_blob, rmem, NULL), 11))
+                       continue;
+
                /* If the no-map property isn't set then the region is valid */
                if (!fdt_getprop(gd->fdt_blob, rmem, "no-map", NULL))
                        attrs = PTE_TYPE_VALID | PTE_BLOCK_MEMTYPE(MT_NORMAL);

Thanks
Varada
