Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D03C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988B384BAA;
	Wed,  1 Jul 2026 12:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UQsNBAUm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C15MBpp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8EAB84B88; Wed,  1 Jul 2026 11:54:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE0884B86
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6618G3ZE492841
 for <u-boot@lists.denx.de>; Wed, 1 Jul 2026 09:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LGtMM9RmWKs7CgXum1S1XEkc
 EmKg2wPMAOWNYeHBGLQ=; b=UQsNBAUmOiHeHJvi1TNVGXdlzOX7cEc/x/IZVbq0
 1VA4pSAMSk0sYhhz7WvXuQm3VeuIiZbeJHu88T70pMRUcxYxbjTe6m1iITJbcXkb
 ZE1r+RsnRbclvJRWppe2vzhcpqESlt8rJQDsgWoh2BJWWb4v1kDKdFfbxsBiD5AE
 p4mnHmw+aizau0Oqoxzm73kIiAoCLCMtggsvFVA0ovL4HaGCvaTcRHPyicX/b4/v
 lXRup3H7OWnl+GA3DcgoamA9GlpaaShevF0cvfFv9R+e+v4PBubw4xsjrHUyWArr
 6itYFqE71X5ZZ+ZIs8yd9DjSGbee3Jg473n1GHAwwZd1fw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw3crr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 09:54:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30e85f5bc9eso1640747eec.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782899655; x=1783504455; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LGtMM9RmWKs7CgXum1S1XEkcEmKg2wPMAOWNYeHBGLQ=;
 b=C15MBpp5Kbt3LExe8zTUTmTopzru7AKkyzOmSXa+d7m2xjiYlQJclIzoDQA/ocWJLq
 MkYqMHBbAzhCOWX2lxgchBltWgn5hpKfN4VVnGunve668kfsPXWdkeuYnzldsfiOo9m9
 tf1T7jJoJ/mH+p5edVAH9zuiZgjwpGYC7RLTKiXyprEMlTIdBEF6XUblnlaIcEFPg7y3
 CZU1BMFKyQ9tkiI6V88r+JUhNnXaPxQaATcHAT+w4MaZ5ncTXe0m9Ai4ZUXU892rZOyz
 sf4jwsuKSKoJlZE85WGblwKNATlvtI6rvUXMuJnU073ZBXE2+TUbm99Ep0+8ka5PqG9E
 P3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782899655; x=1783504455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGtMM9RmWKs7CgXum1S1XEkcEmKg2wPMAOWNYeHBGLQ=;
 b=rjRU72+UcUnu+gTEnorIoxwWN8qwe+Qvk2k45rP4JaCwz9d0U9VXKD8ezLPAYUaHPG
 /U58FD10wu92zV6ULlI5nsaAJJkpFnJCST7MbWnelpUMiXcxkPRWIjGgLaYf0DxxzMJ5
 q3sHMbtl9THTPQnNmKjYUBRV39zloMHBpsj+y3Gg30eXjnZJiYwLFdwh0zP2Ae8pWX71
 hHwIcNWigGzxDtDzjNy9NExSlht1N5oOSEvoQnJl78MqFFVfCPKHGuLk9LNd3GxafOaF
 ikAWv8lpnzpzDd6OP/hsTzGRhT6FyA0eNw+NUGt3bCv4AtQAcB06/jJ5hkPouinXZbsC
 xizA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiPTQP2KHheHIWjSnTCebQvM5FOLh/WVXc8X01qmao5bVvRlN7mqm3VwYvMhUA7xx/hVbDDW0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3XwkIcA1KnotB2gy96zrjOMWwYtmpEa5PzT0ZRm68I1u/szui
 BDskF9n6JfNz6YLGsWsp4fFfstnkG+BmZewZf7KwqVRtT1LybOVXEDiIEN/aZ0uI8EqRdrd/Sg6
 RnGzsN7Xp3H41HtZaPjbJCMFOzc+HGKgb60PEQPpbbi3wYAyGusODDUIZ
X-Gm-Gg: AfdE7cnyVyRaZ5lja5pxN2ueiRocxe3ot8VvsBZkniX+/7yuugLJreghAx6EAxqMRWX
 5EWYkNwmerTfQt+MLGmPZ/uRW2rHe7GGvYNo8dpJNan32iWq1IJl5wlA/j0aBoIWVY0Kiy1kA+X
 Lqz2r9aRukKa4cj3W8ADPI4ApsdnoLnsO5yuzniOnGU4felYJcVeDmMPFVNVLRFVWb63TJHPpL1
 fYxZdz/DZ/+VZ+kzY28+kgss1P9iSpXD9fhmZqrJyBvdH+aWtu/5C1JK2kz+zCeTNLkEFdkhf/F
 04Puhj7VKxi5rkajkETz49XpRqNqVhK4WavR9V4CY0IGE1lOVOnEzIc5mQmo+mIhdHxD9uD5jCt
 a2OnnTMF8ZhVDZXR9lznHlqy9edP20vfg3mdn0UdA8StxYjXn6l5PYjhAbyhb4/laugYRRvnFdN
 O16CNlE1091ofIkGYXOTHqMv34xVaSMGMUVcR6PnT5
X-Received: by 2002:a05:7301:3d0f:b0:30b:c502:23df with SMTP id
 5a478bee46e88-30eff07d600mr1143040eec.13.1782899654703; 
 Wed, 01 Jul 2026 02:54:14 -0700 (PDT)
X-Received: by 2002:a05:7301:3d0f:b0:30b:c502:23df with SMTP id
 5a478bee46e88-30eff07d600mr1143014eec.13.1782899654118; 
 Wed, 01 Jul 2026 02:54:14 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fb6514sm15923374eec.7.2026.07.01.02.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 02:54:13 -0700 (PDT)
Date: Wed, 1 Jul 2026 15:24:00 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, tien.fong.chee@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com,
 tingting.meng@altera.com, alice.guo@nxp.com,
 marek.vasut+renesas@mailbox.org, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, andre.przywara@arm.com,
 afd@ti.com, h-salunke@ti.com, alchark@gmail.com,
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v6 05/11] mach-snapdragon: Add PBL shared data defines
Message-ID: <akTjuGpnI5ibT4qz@hu-varada-blr.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-6-varadarajan.narayanan@oss.qualcomm.com>
 <0299e3ad-ae16-4e99-8b02-4c0ffc6ee14f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0299e3ad-ae16-4e99-8b02-4c0ffc6ee14f@linaro.org>
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44e3c7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=3HNdf_qXCeo_3jbfwTMA:9 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: OJut7MI-FMN-chq4rLTymA9b4HkdG6_o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEwMiBTYWx0ZWRfXz1W1egVmrNqy
 qxFJ5JnKdyINQImcXRoogiQEKUPpyIU5/LDKZNXKig/j4rMSXYCq12l3UP764SQyvRKC4dsz1en
 65DxdYE4oLC9Hk9UmmvPgayEityreLU=
X-Proofpoint-GUID: OJut7MI-FMN-chq4rLTymA9b4HkdG6_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEwMiBTYWx0ZWRfX7TObn29MMPm7
 4wKrulh1gZiW8cVLCT+S6WfXy/RGg5t3H0XzsUrdKTyl32+y/6kTQGsTB4H8/DMZCOAduY7dy1I
 tdwVlKMyG2sXMIU92lYUl40yynyqHNJi9fJxYGig6XKS39SjbG5Qz9EQjntqc0uusbrNIwVTVFZ
 Gy0tX4Jn8tDvpdKpNHxNAjUUiTThVlKuU/MpkJR1C58PdIIN2BTp02ywBE0fQmjzIQm7dBFRr6v
 4PKQ1P/OastaF4R8/d7xvost32MJhuzE7oIohI4+/RCf8f5dmJwguYlTp7R8ceohlq76Eq4xrV2
 gUDOt8CNGdXaplgiprbPS5yQYvot/eodCKFb3YbwIUe2VULZZm//198WAKahadA6ZjKEm2ynZyW
 0OBqsOfHBRRzCY5kWH1XhM9REWxpGBSJbCjjy/WNXFHZu1UwHBf+L3DkBnONluddCRebaXjqBKc
 ZUos49JjB4t52jCIkTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010102
X-Mailman-Approved-At: Wed, 01 Jul 2026 12:58:07 +0200
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

[ . . . ]
> > +enum pbl_shared_data_param_id {
> > +	PSD_ID_PBL_FW_VERSION			= 0x0,	/* PBL firmware version */
> > +	PSD_ID_PBL_PATCH_VERSION		= 0x1,	/* Patch version */
> > +	PSD_ID_RMB_MBOX_BASE_ADDR		= 0x2,	/* Not used */
> > +	PSD_ID_CPU_BOOT_SPEED_HZ		= 0x3,	/* CPU boot speed (Hz) */
> > +	PSD_ID_BOOT_MEDIA_TYPE			= 0x4,	/* Boot media type */
> > +	PSD_ID_IS_EDL_MODE			= 0x5,	/* Emergency Download mode */
> > +	PSD_ID_DEV_PROG_ELF_ENTRY_ADDR		= 0x6,	/* Not used */
> > +	PSD_ID_XBL_CONFIG_ELF_ENTRY_ADDR	= 0x7,	/* Not used */
> > +	PSD_ID_XBL_SC_EXT_ELF_ENTRY_ADDR	= 0x8,	/* Not used */
> > +	PSD_ID_PBL_TIMESTAMPS_BUFFER_ADDR	= 0x9,	/* PBL logs address */
> > +	PSD_ID_PBL_TIMESTAMPS_BUFFER_SIZE	= 0xa,	/* PBL log size */
> > +	PSD_ID_PBL_DEBUG_SHARED_INFO_ADDR	= 0xb,	/* Debug info address */
> > +	PSD_ID_PBL_DEBUG_SHARED_INFO_SIZE	= 0xc,	/* Debug info size */
> > +	PSD_ID_TME_CPU_PBL_ROM_BYPASS_FUSE	= 0xd,	/* Secure boot status */
> > +	PSD_ID_XBL_SC_DEBUG_LOG_ADDR		= 0xe,	/* XBL SC debug log address */
> > +	PSD_ID_XBL_SC_DEBUG_LOG_SIZE		= 0xf,	/* XBL SC debug log size */
> > +	PSD_ID_CURRENT_IMAGE_SET		= 0x10,	/* Booted image set */
> > +	PSD_ID_MEDIA_DATA_INFO_ADDR		= 0x11,	/* Media info pointer */
> > +	PSD_ID_MEDIA_DATA_INFO_SIZE		= 0x12,	/* Media info size */
> > +	PBL_SHARED_DATA_PARAM_MAX,
> > +	PBL_SHARED_DATA_PARAM_SIZE	= 0xffffffffu, /* to force 32 bits */
>
> Remove these old compiler hacks, you don't even use the enum type in the
> pbl_shared_data_entry struct

Ok.

Thanks
Varada

[ . . . ]
