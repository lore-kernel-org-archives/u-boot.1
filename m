Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D113E7C4F4
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 07:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C527086EA3;
	Thu,  5 Oct 2023 09:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="4usiXGxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E779B86CCD; Thu,  5 Oct 2023 09:07:15 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A7AE86EA4
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 09:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864251c908=etienne.carriere@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3951K1XM007238; Thu, 5 Oct 2023 09:07:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 selector1; bh=kl/t8rdQqQoYfVOGn5um5iu9ldwouGHgGpgTK/69Qck=; b=4u
 siXGxnWm9sL0njGGvCHuUz+mgvRlYm47uI4O00gfWplVQWjbtc0Jyt8ncfqgbXQV
 FrgR5oGMVRlu7cEDhRu7FkXhJDiUla6fjxH79gANf1XjWjjZVIaeGWiP0h0OVkkP
 6db6DWlwXuDEKegsTVp0MBiHAX6VO/PxDTJHj/46ra0gQTFtCPwb3KwnY15thDuU
 8+2mnQXrJ11ZCBRYX53b5N4qvH7RwDQ+RlIredPoVO6dRgiuRooV9F7qhhyPhKhS
 IpWzbHaEKQQ+3zNEdSuhLRbPrBOphlidI9nsI5cczxwl/dpMVOJKtYGOq4m1wf7c
 bBE+M5VYAZIS7i6TJajg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3thkcxs5pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 09:07:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78C28100063;
 Thu,  5 Oct 2023 09:07:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6CD6D21B52B;
 Thu,  5 Oct 2023 09:07:04 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:07:04 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1]) by
 SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1%14]) with mapi id
 15.01.2507.027; Thu, 5 Oct 2023 09:07:04 +0200
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: Etienne CARRIERE <etienne.carriere@st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 01/16] scmi: refactor the code to hide a channel from
 devices
Thread-Topic: [PATCH v5 01/16] scmi: refactor the code to hide a channel from
 devices
Thread-Index: AQHZ8EbWGKSSR33EbEe+NgyhWSOb2rA6yMbr
Date: Thu, 5 Oct 2023 07:07:04 +0000
Message-ID: <ce9ab6f7e46248dbbb5cde4340e3d74e@foss.st.com>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>,
 <20230926065750.734440-2-takahiro.akashi@linaro.org>
In-Reply-To: <20230926065750.734440-2-takahiro.akashi@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.20.20]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_03,2023-10-02_01,2023-05-22_02
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

> From: U-Boot <u-boot-bounces@lists.denx.de> on behalf of AKASHI Takahiro =
<takahiro.akashi@linaro.org>
> Sent: Tuesday, September 26, 2023 8:57 AM
>=20
> The commit 85dc58289238 ("firmware: scmi: prepare uclass to pass channel
> reference") added an explicit parameter, channel, but it seems to make
> the code complex.
>=20
> Hiding this parameter will allow for adding a generic (protocol-agnostic)
> helper function, i.e. for PROTOCOL_VERSION, in a later patch.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v5
> * correct the size for per_child_auto
> v4
> * revive scmi_bind_protocols which was accidentally removed
> * remove .per_child_auto from the driver declaration as it is not needed
> v3
> * fix an issue on ST board (reported by Etienne)
>   by taking care of cases where probed devices are children of
>   SCMI protocol device (i.e. clock devices under CCF)
>   See find_scmi_protocol_device().
> * move "per_device_plato_auto" to a succeeding right patch
> v2
> * new patch
> ---
>  drivers/clk/clk_scmi.c                    |  27 ++----
>  drivers/firmware/scmi/scmi_agent-uclass.c | 105 ++++++++++++++++------
>  drivers/power/regulator/scmi_regulator.c  |  26 ++----
>  drivers/reset/reset-scmi.c                |  19 +---
>  include/scmi_agent.h                      |  15 ++--
>  5 files changed, 104 insertions(+), 88 deletions(-)
>=20

Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>

