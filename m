Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6620C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 262D084B20;
	Wed,  1 Jul 2026 11:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aHcqpAE3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZAJwsmJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76EF384B59; Wed,  1 Jul 2026 11:48:28 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA2B84AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6618Fpwj495576
 for <u-boot@lists.denx.de>; Wed, 1 Jul 2026 09:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=UFxYdOvdv4CuydbytdElW6kQ
 aLKKZDYQnXmFgA1Aozk=; b=aHcqpAE3sZJQwyK11I1AVaQxKDfh853QqIBOn2T8
 LLGUKbLtTSsWu2xEkZWvXvkZv3T2t4fxsPD+HfXJEYjoo36pvZW5HnstGasxjxk2
 RWZ+te50d0Rk0gBh1FQ4WGoMSVHF9zxN16/g36B+s/ExjPGlva+vBtYdIp0PTYIx
 mXS4lOvCVIrxytmYZDBUSo0wwgYcIoU2ftAql5fgZ1qlZRxYcfV6SuCSjdoX34XJ
 6wl7y9YOL91aPuTSsvoQvrC0RVVY8xWrNIpDDyfLgp54K1+awoXDCjLtIHF8vZ2z
 g6pwD0iCxvfmepBQg4kCXPV3bKiU2Z6w1fuVyjOcuYtXbw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99kt01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 09:48:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30ed53abff8so760225eec.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782899303; x=1783504103; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UFxYdOvdv4CuydbytdElW6kQaLKKZDYQnXmFgA1Aozk=;
 b=ZAJwsmJ70lPs8S2IxGNB+n9baxGFLa+YQvlW527Kmvjl4VK9G+YVFmmHdBdgYtTjKy
 pEpGbyDMlJCO7McCTjX/9JPGqbn7pw68Bfhd/TsaP+oTX5Nu5rzPffYwEgNfigluF/w9
 +w/msNhNq2o/l/FEmzxzj/zaxA/Izyqv6JgVPoTfOAx6wFMdP7KskZeVOwyLM0mDXwBU
 FRjJV8sh9i5mJgA6LmSEsJ+ln0qP8PWZOxpisCG86k7Ge4T0DrafQhAcPxkhmt6x0JTW
 mzGxKuQs595TotllHNv0SL8MEuW4/E7j7ebeSl74IOTrf9UUtqMtxG6V3zkfdBDqM39N
 bBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782899303; x=1783504103;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UFxYdOvdv4CuydbytdElW6kQaLKKZDYQnXmFgA1Aozk=;
 b=O39n2PVrPVMpmiMWrHmlENsJqMIdalp6aSyVQn7V0u+RWNJfB/tQZOdmS7yHcUvo3X
 RIZ91+84LR6/BVwxaNZjovptxsrNHGx7IQoWFD6lJ+OofBuKc3U0y0wy0osBnXRGRfr8
 m7Y1SlfahMy062Zw28vV4IVyCL7VsDbrlYN0ZCAdH5znEjJWNhUvNdZjYTvKFZCjdN0I
 8kmbzKs4bKR1svKY++yz36Rg+rwODKQpVqfbUeA9AXP/5ppc1f5zKXpgpmfuctk8mgca
 u8MFPk9dVk31+fp8JG3ApD/hFuWz9bSarrrnKq4mGAYblbLBPcqNzAueEYyKsXAdt2D4
 7MeA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNyC6OeYuz7D9k7CTMlzcr1L3NoZ8g8IkOcWU2Y1eTxGLsyyPBy1oPLH6EmiRoZseYPueB4Rk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywcr7Gm/xuH183TsDtUAMOZaoDoNuKMhfmY8ignhDncXyBnQ7af
 NkS9FTQUOfl5I+5AunIqwtWUsJ51m0trUTGa4iyKjibQFGtsRKY9rq1CcJoXaRJ1rFDoqcLMK3z
 BACWhVQyBqGUCnY4cO3kU66ZX17P3Fyr1fMjmRE1PAhC2oz230HzGIF7s
X-Gm-Gg: AfdE7clw89gQ9WUqEfaQVZb8Tp0DffPDvTU9S8wPyGDvK6f8wp56PQqRybg9IkUHrJl
 Q2kvzZK9E+BhL4l78o/GzNN3sldxOyKgT1/kG1+lonKW4InT53mxQQQ99EIQ2Y8BHB2hxrimnpq
 e9Wr3oud39Ufq6RzQvRLShKaWybeLOLvZwCRrRl4AFGVztYdvYkxFPzGyBqQDEM8iYd43HEi9ll
 mqQv21eJF18dU8QJGyZ6u2Vl8Fjitcy9C81CPhGaIeh8T93z3UBFKGF/52lL8DLqrOmpRFU+CPz
 u2JnbCXsXhnji9t9eIVCHBglugRb1z39NLut732fSG9HuQx0Bl/4CCFk3OJs+svjg3Zq79L/n24
 kNFDn9ApOZ5sVD2LITb8YwtxmwpBFCxBl5S4CxX3IeW3v8CFfQ71oj2tgma73cvgOmbwrrLv5m9
 9S0DjeR+d+UR+f4tqnWtV/aP6IGPZaVFdidDkI/qp+
X-Received: by 2002:a05:7300:a584:b0:30c:ab4d:3824 with SMTP id
 5a478bee46e88-30f0545f67amr11163eec.38.1782899303096; 
 Wed, 01 Jul 2026 02:48:23 -0700 (PDT)
X-Received: by 2002:a05:7300:a584:b0:30c:ab4d:3824 with SMTP id
 5a478bee46e88-30f0545f67amr11116eec.38.1782899302472; 
 Wed, 01 Jul 2026 02:48:22 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm17502223eec.10.2026.07.01.02.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 02:48:21 -0700 (PDT)
Date: Wed, 1 Jul 2026 15:18:13 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 peng.fan@nxp.com, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, rayagonda.kokatanur@broadcom.com,
 mkorpershoek@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v6 02/11] clk/qcom: add initial clock driver for ipq5210
Message-ID: <akTiXcTdP7YDhhin@hu-varada-blr.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-3-varadarajan.narayanan@oss.qualcomm.com>
 <d90c6a1a-4bda-495e-9bf8-553d8a8ad8a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d90c6a1a-4bda-495e-9bf8-553d8a8ad8a6@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEwMCBTYWx0ZWRfX3Vg4Mflbsi9+
 2dIEGnmb/ZxbMHMABgyqbQr0BGnYXd1KvqEPCXwv++42NnhCiUGfqzp4OjGdgfK1e5YPbc1KSUF
 aOtvoM8gxRWWYozs0OBfp9ntKxAygWU=
X-Proofpoint-ORIG-GUID: yU_g2hhqrf1xCZ7Z738b5_KFXFJcd4lF
X-Proofpoint-GUID: yU_g2hhqrf1xCZ7Z738b5_KFXFJcd4lF
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a44e267 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=T0SotiO-K_Rv-sZgm3cA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEwMCBTYWx0ZWRfX7sKZj3JMWrmy
 cqkq29pfZc5+lhnc6kizzJVrfgJzokBItbKR/nQ6K8lffw2kppWUVXO03cW24IPMD0f1OX67jEX
 QVVFuCHMvrzXoBwK+NWShwheU/w47IBZrvMOZeGEFJuH0uEPJEUXzilJHju1a0jkCrsRY8wQTi0
 G+K5irL3IzT+1ds1RJC/SkdqRR9CfBd9Lma0aI/uQC8mXWwRJBPyNKCjSIlJo/vAdNvPONNroU0
 cbfDkY7mCuh4zIBzVtJCPOZ+zbLVlFfuXdYyVp5cNoPw3cYyHyDzs4mY1SCURHKQtpa5XBX3O4n
 QPH/xR6X0+HZR7imSBDzpdrWUDw9kLazyVweAmlIYWSZnqIA43c4ILS4oA4XNTsrgjpVl/BhaGz
 Y0gwvCtmUO4hQlH47FV9rScP7/TgMOECdoU4Wv+pLIxMddk57vCMwCg1yy62630b/ji8CYBWl+s
 Nn5ac64MGkx9GOvNYEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010100
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

On Tue, Jun 30, 2026 at 12:53:43PM +0200, Casey Connolly wrote:
> Initial clock driver? As opposed to what? This is just redundant
>
> As an aside, why does your CC list have a bunch of emails multiple times?
> Please check this.

Both b4 and get_maintainer.pl seem to return this big list. Not sure
how to fix this.

[ . . . ]

> > +	/*
> > +	 * Since GATE_CLK is deprecated and GATE_CLK_POLLED is being used
> > +	 * use 'cbcr_reg' instead of 'reg'.
>
> No need to leave comments explaining why a deprecated API is unused> +	 */

Will remove, added based on the suggestion in [1].

1 - https://lore.kernel.org/u-boot/CAFLszTj=iQO73XC8+d83Um8sw-QPd0ceTDLN6zU53GDD8B3aSQ@mail.gmail.com/

Thanks
Varada

[ . . . ]

