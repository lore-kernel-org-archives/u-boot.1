Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C020C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 09:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA8987F92;
	Tue, 20 Feb 2024 10:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="171+TwJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2849F87D7E; Tue, 20 Feb 2024 10:44:48 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410A087F97
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 10:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2780945740=etienne.carriere@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41K6UElR018984; Tue, 20 Feb 2024 10:44:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 selector1; bh=Up+Dh+DV3PCWgv9TiUfSgmoo3l4HHXvY5DslPKrKRcU=; b=17
 1+TwJ3etknX3HxUFKzUtxpRHsjji20IxwAVsI0fBjjCefVx+CVs6HkmmUHJF97Zk
 3x2pe58GNH6SEaI2w9cgcu5C/kfRrq08a7AAyxSVrWqSnMb4HsD8ZMR5PKGTLlRD
 GgrFGsHX8jMLjoX42TQafJVTjEXeMRUzg/IDnP8GljAuAYlPxp9sIz+NUxzHYT86
 IDPykhm5/NIFpXqbQ/jicYDkZgYFTCWiyesVDshDZT3DbG5DsIVnGxlkCwfImz2W
 GVIXnC4TO2FkBJQwTNmZmInTrTwxWbPO8t2FIw9wmSsOqgCCmfP8mxyU/C9O33ER
 2+AtDtJXSjKyXeXkbnag==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wan11tp7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 10:44:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DFE2140046;
 Tue, 20 Feb 2024 10:44:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88F30245507;
 Tue, 20 Feb 2024 10:43:54 +0100 (CET)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 20 Feb
 2024 10:43:54 +0100
Received: from SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0]) by
 SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0%13]) with mapi id
 15.01.2507.027; Tue, 20 Feb 2024 10:43:54 +0100
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice CHOTARD - foss <patrice.chotard@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Yann GAUTIER <yann.gautier@st.com>, "Michal Simek" <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 00/21] FWU: Migrate FWU metadata to version 2
Thread-Topic: [PATCH v2 00/21] FWU: Migrate FWU metadata to version 2
Thread-Index: AQHaXYgaOKO44pQ45UemOuP5NLbbPbES87R9
Date: Tue, 20 Feb 2024 09:43:54 +0000
Message-ID: <0ace0a3a8a94407b84ee95c34eefdafc@foss.st.com>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.22.241]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
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

Hello Sughosh,

Sorry for this very late reply especially since I have a quite negative fee=
dback  on the proposed changes.

I don't think FWU metadata version 1 should be removed from U-Boot support.
There are existing immutable boot agent relying on format v1, starting from=
 the Synquacer boards based on SCP-firmware v2.11 [1] onward (at least up t=
o latest v2.13 tag) and the stm32mp1 platforms based on TF-A v2.7 [2] onwar=
d (at least up to latest tag v2.10). These platforms should be able to upda=
te there EFI firmware hence needing the update agent (U-Boot) to support fo=
rmat v1.

With the proposed series, the new format v2 contains the same information t=
he previous mdata v1 based implementation did (apart that some info where b=
uilt-in whereas v2 describe them from the mdata storage area).
Could it be possible the implementation support both, using for example a i=
nternal structure fed from either format v1 or v2 content read from the sto=
rage, and used to update the mdata  v1 or v2 format storage layout?

[1] https://gitlab.arm.com/firmware/SCP-firmware/-/blob/v2.11.0/product/syn=
quacer/include/fwu_mdata.h
[2] https://review.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmwar=
e-a/+/refs/tags/v2.7/include/drivers/fwu/fwu_metadata.h

Best regards,
Etienne

> From: Sughosh Ganu <sughosh.ganu@linaro.org>
>=20
> The following patches migrate the FWU metadata access code to version
> 2 of the structure. This is based on the structure definition as
> defined in the latest rev of the FWU Multi Bank Update specification
> [1].
>=20
> Since the version 1 of the structure has currently been adopted on a
> couple of platforms, it was decided to have a clean migration of the
> metadata to version 2 only, instead of supporting both the versions of
> the structure. Also, based on consultations with the main author of
> the specification, it is expected that any further changes in the
> structure would be minor tweaks, and not be significant. Hence a
> migration to version 2.
>=20
> Similar migration is also being done in TF-A, including migrating the
> ST platform port to support version 2 of the metadata structure [2].
>=20
> @Michal, I tested the metadata for the two image per bank case, and it
> works fine on the ST board. Kindly test this on your board as well.
>=20
> @Kojima-san, Please help in testing the version 2 on your
> board. Thanks.
>=20
>=20
> [1] - https://developer.arm.com/documentation/den0118/latest/
> [2] - https://review.trustedfirmware.org/q/topic:%22topics/fwu_metadata_v=
2_migration%22
>=20
> Changes since V1:
>=20
> * Do not define flexible array members inside the structures.
> * Access the image information related fields in the metadata using
>   the helper functions defined in an earlier patch.
> * Access fwu_fw_store_desc structure using pointer arithmetic.
>=20
> (snip)=
