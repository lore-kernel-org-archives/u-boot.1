Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8C5CD6E7E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 15:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F8A586D2E;
	Wed, 11 Oct 2023 17:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QIh488l8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E48086D28; Wed, 11 Oct 2023 17:45:11 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5162C86DDA
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 17:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=86480ece7a=etienne.carriere@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39BAUlHb011122; Wed, 11 Oct 2023 17:44:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 selector1; bh=zdjpkLO8EWeBENqT+ftuzsI59NGVF4k7QxBwCat0SdE=; b=QI
 h488l88hdlBo0AL30WLfj5+Y/FnvDvO3vyTj19SDroPcsnxYR6UA53zEHaPpa6dh
 BETk99oDYAoxbI1Q0h51z4cm1V1l1u1aWDdaQdwu+33jr83EDVdFN8HyvygdpaHZ
 JxnFQoRf7sUH4XHcREEY55YLMBqJHu28lVAx0fVS4XNkt1MAqVOWazyR+zH1Lcj4
 cSfF3tOMethHXGTsdV5IuEkK5JRc2ZkdqfEtBUf9mlyNWMWK6oz3ZMvr8uUYqdyp
 5/trd3fW0ne01DtarvbW0XQhky36P4TJ5LsVNPa7C8l4vVOdlL/rZLop0A/C+saV
 1/jZWMn0n9OMj50yigMg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tnp24jmwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 17:44:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 30C5C100057;
 Wed, 11 Oct 2023 17:44:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 17F94208007;
 Wed, 11 Oct 2023 17:44:37 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 17:44:36 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1]) by
 SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1%14]) with mapi id
 15.01.2507.027; Wed, 11 Oct 2023 17:44:36 +0200
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>
CC: Etienne CARRIERE <etienne.carriere@st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/14] firmware: scmi: add a version check against base
 protocol
Thread-Topic: [PATCH v6 08/14] firmware: scmi: add a version check against
 base protocol
Thread-Index: AQHZ/Cs72zckkWwNUUuSCBNHAxyVALBEsOz+
Date: Wed, 11 Oct 2023 15:44:36 +0000
Message-ID: <571b810596424ea6a5feba27b417487a@foss.st.com>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>,
 <20231011100707.1007417-9-takahiro.akashi@linaro.org>
In-Reply-To: <20231011100707.1007417-9-takahiro.akashi@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.20.20]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_10,2023-10-11_01,2023-05-22_02
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
> Sent: Wednesday, October 11, 2023 12:07 PM
>=20
> In SCMI base protocol version 2 (0x20000), new interfaces,
> BASE_SET_DEVICE_PERMISSIONS/BASE_SET_PROTOCOL_PERMISSIONS/
> BASE_RESET_AGENT_CONFIGURATION, were added. Moreover, the api of
> BASE_DISCOVER_AGENT was changed to support self-agent discovery.
>=20
> So the driver expects SCMI firmware support version 2 of base protocol.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> v6
> * new commit
> ---
>  drivers/firmware/scmi/base.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
> index ee84e261945a..1d41a8a98fc6 100644
> --- a/drivers/firmware/scmi/base.c
> +++ b/drivers/firmware/scmi/base.c
> @@ -481,6 +481,7 @@ static int scmi_base_reset_agent_configuration_int(st=
ruct udevice *dev,
>   */
>  static int scmi_base_probe(struct udevice *dev)
>  {
> +       u32 version;
>         int ret;
>=20
>         ret =3D devm_scmi_of_get_channel(dev);
> @@ -488,6 +489,13 @@ static int scmi_base_probe(struct udevice *dev)
>                 dev_err(dev, "get_channel failed\n");
>                 return ret;
>         }
> +       ret =3D scmi_base_protocol_version_int(dev, &version);
> +       if (ret) {
> +               dev_err(dev, "getting protocol version failed\n");
> +               return ret;
> +       }
> +       if (version < SCMI_BASE_PROTOCOL_VERSION)
> +               return -EINVAL;

LGTM. The open source SCMI server implementations I'm aware of (scp-firmwar=
e, tf-a and optee-os) all report SCMI Base protocol version v2.0.
Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>

That said, maybe a more flexible implementation would support both version =
v1.0 (0x10000) and v2.0
but disable permission commands for v1.0 compliant servers. Maybe in a late=
r change, if there is a need for.
I fear using such strict minima protocol version values for other SCMI proc=
otols make U-Boot client too restrictive.

BR,
Etienne

>=20
>         return ret;
>  }
> --
> 2.34.1
>=20
>=20
