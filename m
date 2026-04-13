Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ACDEBFD03
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 06:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C7D5839D5;
	Mon, 13 Apr 2026 08:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ldwjk1Yj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XWFxobS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07020839D5; Mon, 13 Apr 2026 07:32:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F368352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CLxnv21396040
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 05:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=blXBm3R2sBOmxdxd47qgeCIL
 sbz3E5dNgt5HsCb8EGc=; b=Ldwjk1YjlIjvwlBCBQ6KqoAp0Lijt1+r+2eHbcFE
 6DYtlfh1vHAK6vsH1G6G04Qiv0iBV/9O/a4EabIFFOuuukp5IcN1qnIta3slLw+p
 HJ8zpxoeRNOR07n8TKTQBzjYrvseEieNoTqMRYE4+kVWwXfS5QEnDtRJZqu6Etow
 d84eCZnPAKwccdGWRpp7O6QDGGrZHa9vlQtuydjNGZ9qu+vCT6fwr/3RRWr82EzH
 xPNKPjn/2vSPDmWZ+SJf88MaM0rBMI+n7wusVYSRoCkXUhd+qlkY2r+xv5G2Bzkw
 v93F26KYhv2IruZPHKZ2Xi13MXfrMJTKmW4lMgmtEZ5gOA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtkwpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 05:31:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c76cb2dce57so2380660a12.1
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 22:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776058318; x=1776663118; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=blXBm3R2sBOmxdxd47qgeCILsbz3E5dNgt5HsCb8EGc=;
 b=XWFxobS06xayDwwrBWDefKYUzUUwX0VcIF6sOnlTCI/HAtZ0mQ8WDeCRjOF94LParf
 oN1a4tsvjhBC7gVHQmmaD21PG/+pv0RKYeHmc/v566tUsgBjSRy6S3gB4R6FSde72blr
 pIVfBdstQjyLztvR9FFZ4w3N/zCVVvWH5sJhLJByPlmzyUa1Q13Xs8jKc1JXj73jx4Nl
 fU29rSOZ4R5xZBIT7IjuoJlcEmkY9cAl69kUZB4sbXmlFfNjLTAU6Bm83mO4JboxitCU
 41K8GYLdtD2dgQeyQDAiX9GQM/MFi3gUG9rWry17WC+v391hAIH5cRLevcOKJFxIa06b
 oo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776058318; x=1776663118;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=blXBm3R2sBOmxdxd47qgeCILsbz3E5dNgt5HsCb8EGc=;
 b=Iman2kw8h+fHPwMWfNG1g8/Hl/NIAj2OnhYe5OIzwVZBBonLpnOmBs9FdPB+kfxSgd
 nxjEd6NOTrwKgYmih0EMhcLJi5HzrJw61sJjDudUi2b62I0yJEPEFHa6q4pxnHVn4zRr
 iE4yfG1mlVhHVfVv4WKxdeQD2pisv2a5l6Pufmf91rVl+xnltmmQXa3YsGypW7KWVPQm
 R7LrbHNUtq+Oy+/wEv+2PtH8Xzhgb6Am9BM8TI0mJPJuriu79Uf/T5cVl7KmlbclQlzx
 0BGOeX+Tte1zY9r5AfXiisCV+2D3oMCFAHaJAMMh3Y5DDTcxGYNGqWZ9GR4KsS9b6izR
 wAsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oazcjCe7go+M15Hg1vnGHoS8TR98jyXxzUbCrK4Hi6dwfd2+C0wIf54j6a63KbFATyv3RfEE=@lists.denx.de
X-Gm-Message-State: AOJu0YxtKnewKoYQ9Snp0pXDwieNfGI9W8zajCvBZLl40Cud15qY3w3C
 hd+ifr6y76zHY/15tzScVcc3xSzsOcgQUgpUrq//A7LSrqr5iPUUxijFzAqkP+zsxEKKCtQNPKC
 VmcJ/1pzYVkK4vMZ5eVrGXR+8rJlNappSwII2cPqCylw6GR0Cn8YwnrB9
X-Gm-Gg: AeBDiesFUwGD7t2EHsbaY1qcQC0K3pka0CWCQJ6pbuF8KJnq3cw3eaPwMW5QHPPVJA/
 gE3DCcCpVz+qCBa7cRiFYfBAh/RPLEfuXB+4fQI0G2r2bdb3JZDSV8uD/U8cANelQTJYiBk/Njm
 wEpvA5m3lIHcVVOJpuQ9XxGiYUDJVk0sIMdHdfTjDJ9myGHj/eY8SV0MTjtwYHPSzzzeJMKZAgA
 hHO+lpObROrXa/OJChmhoUsfFQJpbkkx6AmYqAvO7Zw9jN7TL0H8ABsLUi+qbx4qgpE/eO6Aml2
 fz81KQmlt34+aGDua3lU7JAVrJAe2h7A7nJ3LwBS0kODqowVLrAiwfIEz2ax51wNvQm57XAjAbU
 Y7o0RfWOSwqln3Vc8q0DHm0V/iffdspW07Y0GvPE6i4fiL7rBrQRSo4hOfWNGDpCGVGxs8Yei0B
 p+oQyN1L0RebQZtuuNEgssqEgQ8pWqYuRABzxg1cY0+u1GcawiKJw=
X-Received: by 2002:a05:6a21:3286:b0:39b:e115:f690 with SMTP id
 adf61e73a8af0-39fe3fae162mr13099950637.42.1776058317883; 
 Sun, 12 Apr 2026 22:31:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:3286:b0:39b:e115:f690 with SMTP id
 adf61e73a8af0-39fe3fae162mr13099879637.42.1776058317297; 
 Sun, 12 Apr 2026 22:31:57 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7922de0626sm9297771a12.13.2026.04.12.22.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 22:31:56 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:01:42 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 5/9] misc: qcom_geni: Add minicore support
Message-ID: <adx/vkAHk96k/CVv@hu-varada-blr.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-6-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTij2Asndsdy4gdVgHWXqayKztvdV5mySX2A90+1xzOfdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTij2Asndsdy4gdVgHWXqayKztvdV5mySX2A90+1xzOfdg@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dc7fce cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=z2Yg-YPY3iKA4PeevIIA:9 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: PiqPBk9G6sr4yqazhsnNG1n211ClTEzH
X-Proofpoint-ORIG-GUID: PiqPBk9G6sr4yqazhsnNG1n211ClTEzH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA0OSBTYWx0ZWRfX8MqEeirKxWCg
 tUuAiJOeDPK6B0A1EqMVA5vcfUbFoHDexbiQWbkC1DVCNCbjDIrgq7/6dPr6JcbsmPkwbzUgG3T
 8vU4ptkrqW/Gcl5aZNoHBl5Jt4fEgELIzud2Sgu9aa17RDMIjzlylAfYKTD7PkHcqrKsFCEv0CB
 hPZcBHEcjxZ19K9cj9QgKiVVwUkAmJmabjzg5g9fbHqzdGugehhJutw4Pp6kghAJWTLqu0UZ5yX
 8IH28LUBea0bJS7nBr0824A9H1qTogEBo+iMiW97JDNhp6syZK7U1YpGtV0sBARG6ZNyqrvvwUI
 V/zKWvXvwXQKwbrDMmHUX2TK9Lwv/Z3RhcHyGQa1xcp/ZMYMiufjjxnNq003BX7w1hC3/1pQqiB
 5F4FbJlZZo49lA6oMu7EfFzgYWHqQRq/HupesyFOeclL2E8WKebFiA5eNCFvFN6iraNH9ty0y38
 +rAo1hbdAOtEh7iVBsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130049
X-Mailman-Approved-At: Mon, 13 Apr 2026 08:48:10 +0200
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

Hi Simon,

Thanks for the feedback, need one clarification...

> > +     ...
> > +     if (elf) {
> > +             hdr = info;
> > +             ...
> > +     } else if (IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
>
> If elf is false and CONFIG_QCOM_GENI_MINICORE is disabled some
> variables are used uninitialised. Please add an else clause that
> returns an error.

Ok.

> > diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> > @@ -377,15 +413,22 @@ int qcom_geni_load_firmware(...)
> > +     if (IS_ELF(*(Elf32_Ehdr *)fw)) {
> > +             ...
> > +             elf = 1;
> > +             info = hdr;
> > +     } else {
> > +             elf = 0;
> > +             info = fw;
> > +     }
>
> Using 1/0 for a bool is a bit odd. Please use true/false.

Ok.

> > diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> > @@ -492,7 +540,11 @@ static int probe_children_load_firmware(...)
> > +#if CONFIG_XPL_BUILD
> > +int qcom_geni_fw_initialise(struct udevice *dev)
> > +#else
> > +int qcom_geni_fw_initialise(void)
> > +#endif
>
> Having two different function signatures based on a preprocessor
> conditional makes future maintenance harder. Consider always passing
> dev and ignoring it when unused.

The signature difference is because for one case it is

	int (*probe)(struct udevice *dev);

and

	typedef int (*event_handler_simple_t)(void);

for the other. Not sure how to reconcile between these two.
Please advice.

Thanks
Varada
