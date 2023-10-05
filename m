Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE0EE7C4F3
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 07:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B7786EB7;
	Thu,  5 Oct 2023 09:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="4CveMOV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AA186CCD; Thu,  5 Oct 2023 09:07:32 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD7D86EB8
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 09:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864251c908=etienne.carriere@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 394NxwOF016445; Thu, 5 Oct 2023 09:07:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 selector1; bh=3knODt/4jsrZbqoi4FIwiju3xVRwmy0fu4xV3E5cmfk=; b=4C
 veMOV6xt6Kesl3MltS2+mtBLjYVPEURljwYy1mwuFr6kTfKB9zK7Ce3Dts+8qrAT
 omWODnQCN8ufFXy4t6RyhS2pz5z5qvbe6jTQiHf0bFgtz5AF1Jw7CShn/Sqa37nE
 fLjazp3Jx2TC3pflZj06S7OOOsY5k7wzkdx9cAlqNuQ5YUv1KIEzwYLaZbSEw1vE
 R2N5kn3Fa71TGsSRO53APas0YKHPnyCXUIFQ6OPAilig1ElxQkx7RIAQRN+wWfXg
 nXcWxziDAWdSWaMkKl2G7xMKnIpMyTyxvLX3XbYPSlpIB3gfMInnfMBC8+TkQNZe
 IEpbDAYkTCgqqgoHmUcA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3thj7e997p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 09:07:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8638A10006D;
 Thu,  5 Oct 2023 09:07:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D96721B52B;
 Thu,  5 Oct 2023 09:07:20 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:07:20 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1]) by
 SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1%14]) with mapi id
 15.01.2507.027; Thu, 5 Oct 2023 09:07:20 +0200
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: Etienne CARRIERE <etienne.carriere@st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 02/16] firmware: scmi: use a protocol's own channel if
 assigned
Thread-Topic: [PATCH v5 02/16] firmware: scmi: use a protocol's own channel if
 assigned
Thread-Index: AQHZ8Ebc2sxd4AsO9U+s5vaAlFjrWLA6ylJn
Date: Thu, 5 Oct 2023 07:07:20 +0000
Message-ID: <872a32eac67e43e499f3640512c1a6a3@foss.st.com>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>,
 <20230926065750.734440-3-takahiro.akashi@linaro.org>
In-Reply-To: <20230926065750.734440-3-takahiro.akashi@linaro.org>
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
> SCMI specification allows any protocol to have its own channel for
> the transport. While the current SCMI driver may assign its channel
> from a device tree, the core function, devm_scmi_process_msg(), doesn't
> use a protocol's channel, but always use an agent's channel.
>=20
> With this commit, devm_scmi_process_msg() tries to find and use
> a protocol's channel. If it doesn't exist, use an agent's.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> v5
> * new commit (fixing a potential bug)
> ---
>  drivers/firmware/scmi/mailbox_agent.c     | 5 +++--
>  drivers/firmware/scmi/optee_agent.c       | 5 +++--
>  drivers/firmware/scmi/scmi_agent-uclass.c | 7 ++++---
>  drivers/firmware/scmi/smccc_agent.c       | 5 +++--
>  include/scmi_agent-uclass.h               | 8 +++++---
>  5 files changed, 18 insertions(+), 12 deletions(-)
>=20

Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>

Thanks for addressing this protocol channel issue.
BR,
Etienne=
