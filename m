Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20600E7C4F3
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 07:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE4386EB3;
	Thu,  5 Oct 2023 09:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ekQRpNQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CF086EB3; Thu,  5 Oct 2023 09:08:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8784186CCD
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 09:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864251c908=etienne.carriere@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3955KKQ2008769; Thu, 5 Oct 2023 09:08:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 selector1; bh=tPT3cmjEXebSr0pdfze9T5cexbShgphB6hf9/XpNjaw=; b=ek
 QRpNQy0goCT3XLdR4n0k1YuyszME7qUxp9rt11oNYfHM8DX3ogEdEMp+RwO39u/U
 a00kbbXtyjPHm45Oru5/2ce5cMa4o7vqr9E4qfWCg2u9XhZ/XLGAWmfLYOkfCsWS
 J6BCFfRSMCM6njpxAYer9UFu+kpkTSe9KcWc5kaiQCQ9BzNGaWtadKSZLD4mgl5Q
 SV4i0ZI5exoM8tVP0Cy/IJqd5BQGL557HemHfezTAe19hN2sU4lSoJLv03tSAC5x
 ShXDx3mUsBgFziRMSm3Av1nXpLz6HDrQ+ZktMAVG5SpwEpiOFi7Vgoypqf6dDAbA
 Jk5jfg2NwU90BqN+DYdQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3thpwfgdh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 09:08:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDD0D10005C;
 Thu,  5 Oct 2023 09:08:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E7F3221ADCB;
 Thu,  5 Oct 2023 09:08:13 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:08:13 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1]) by
 SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1%14]) with mapi id
 15.01.2507.027; Thu, 5 Oct 2023 09:08:13 +0200
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: Simon Glass <sjg@chromium.org>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, Etienne CARRIERE
 <etienne.carriere@st.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 03/16] firmware: scmi: support dummy channels for
 sandbox agent
Thread-Topic: [PATCH v5 03/16] firmware: scmi: support dummy channels for
 sandbox agent
Thread-Index: AQHZ8Ebj7k1SK3x7Yk+K9wS3K8WM37A1mkIAgAUxHLA=
Date: Thu, 5 Oct 2023 07:08:13 +0000
Message-ID: <73a0f9bb6d3c43088882afd471bf6c08@foss.st.com>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-4-takahiro.akashi@linaro.org>,
 <CAPnjgZ1RZKqzbDf4DFAy6gtLpp9dW3PAYEVSyx6ZFrScktpyKA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1RZKqzbDf4DFAy6gtLpp9dW3PAYEVSyx6ZFrScktpyKA@mail.gmail.com>
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

>=20
> From: U-Boot <u-boot-bounces@lists.denx.de> on behalf of Simon Glass <sjg=
@chromium.org>
> Sent: Monday, October 2, 2023 3:17 AM
>=20
> On Tue, 26 Sept 2023 at 00:58, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > In sandbox scmi agent, channels are not used at all. But in this patch,
> > dummy channels are supported in order to test protocol-specific channel=
s.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> > v5
> > * new commit
> > ---
> >  arch/sandbox/include/asm/scmi_test.h       | 13 ++++
> >  drivers/firmware/scmi/sandbox-scmi_agent.c | 90 ++++++++++++++++++++++
> >  2 files changed, 103 insertions(+)
> >
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20

Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
