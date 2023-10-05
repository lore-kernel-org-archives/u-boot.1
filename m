Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9D0E7C4F4
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 07:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F7986EBC;
	Thu,  5 Oct 2023 09:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ykkHhysl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2954986EB8; Thu,  5 Oct 2023 09:08:28 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47AC286EC9
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 09:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864251c908=etienne.carriere@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3956dgP3032313; Thu, 5 Oct 2023 09:08:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 selector1; bh=h/LMhjT/Qw9bn+R+q/CIssywCYyyfGRXbUfewe5ZUmY=; b=yk
 kHhysl4zJLP6BZjhaNDk9ap2QqPiSYfdHZ0m4Jxcg5SjgE2BRBE+lWCO424LTpBU
 xWhi/c2Qv4j86FT7G1O6nLOJS1ElECldIheUmhN9UeH5tcyyABHFRykk1LFHZKjb
 RaUvKFc5bgcWRHzMb5z1htBulsLUFerlVCnhpnTxpui5hIG/AN9maVdHWT+8dBHA
 ZQJAGjrqeGtEyJNGyNtXAq10mT7QAE7gee7jbfEg0PgtAa+npzWp3fdmm8kG8D6O
 2Xeqjp7o6hUz6JjUg4YCkiwOe3ULMVnPQJeQ9BboIz2M8c4aDFANJc/Sebyew9MD
 +8QOM6Y0CClUtExtKxZg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3thr2r03xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Oct 2023 09:08:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6BDCD10005C;
 Thu,  5 Oct 2023 09:08:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 64F6520890A;
 Thu,  5 Oct 2023 09:08:18 +0200 (CEST)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:08:18 +0200
Received: from SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1]) by
 SHFDAG1NODE1.st.com ([fe80::117e:c4ab:ed81:6cb1%14]) with mapi id
 15.01.2507.027; Thu, 5 Oct 2023 09:08:18 +0200
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: Simon Glass <sjg@chromium.org>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, Etienne CARRIERE
 <etienne.carriere@st.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 04/16] test: dm: add protocol-specific channel test
Thread-Topic: [PATCH v5 04/16] test: dm: add protocol-specific channel test
Thread-Index: AQHZ8Ebp+REqk5zYKkmuRTdKxHYynLA1mkOAgAUxoKY=
Date: Thu, 5 Oct 2023 07:08:18 +0000
Message-ID: <1dbd34a759f94318af0b328eaa9c335a@foss.st.com>
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-5-takahiro.akashi@linaro.org>,
 <CAPnjgZ2-Ci6LgPraMXgNtS8-xQhbQBjowu=KcZ1SjSvjRef0kg@mail.gmail.com>
In-Reply-To: <CAPnjgZ2-Ci6LgPraMXgNtS8-xQhbQBjowu=KcZ1SjSvjRef0kg@mail.gmail.com>
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

> From: U-Boot <u-boot-bounces@lists.denx.de> on behalf of Simon Glass <sjg=
@chromium.org>
> Sent: Monday, October 2, 2023 3:17 AM
>=20
> On Tue, 26 Sept 2023 at 00:58, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Any SCMI protocol may have its own channel.
> > Test this feature on sandbox as the necessary framework was added
> > in a prior commit.
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> > v5
> > * new commit
> > ---
> >  arch/sandbox/dts/test.dts |  1 +
> >  test/dm/scmi.c            | 20 ++++++++++++++++++--
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20

Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
