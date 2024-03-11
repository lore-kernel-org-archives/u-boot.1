Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF59DC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 08:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE0E87A80;
	Mon, 11 Mar 2024 09:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eQcFNki8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19FE887CF2; Mon, 11 Mar 2024 09:35:23 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398128786A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 09:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710146119; x=1712738119;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=102NkdF05yKsA9h94TpygL4lTLqsHM5KWuXJwlNcR+Y=;
 b=eQcFNki8cG70zVMVOIHiNfmFbQb4NXiSBczvwEjEIAHDjGsD+WWJS0h2HQrj7fb/
 Ey+kSUmSlBopr9ci7LjEjFC+rBOhJY9ROyv0iIRZu9FC+zK1IXEUMFZXo389GA3m
 HIAHkdZraB61qK6cFrBvPSIhpGXmrgSOEaeTcjGJAFI=;
X-AuditID: ac14000a-fbefe7000000290d-2d-65eec2474d70
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 91.B1.10509.742CEE56;
 Mon, 11 Mar 2024 09:35:19 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Mar
 2024 09:35:19 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Mon, 11 Mar 2024 09:35:19 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Teresa Remmet <T.Remmet@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [PATCH v3 0/2] board: phytec_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
Thread-Topic: [PATCH v3 0/2] board: phytec_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
Thread-Index: AQHab+HxZ5+WjI+YiUaLz8wxjuih/rEsqusAgAWCpoA=
Date: Mon, 11 Mar 2024 08:35:19 +0000
Message-ID: <7181d969-a93c-48f4-9609-ac2ca277d67d@phytec.de>
References: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
 <CAOMZO5Df5WuOi-_sNvCcWM7oWxZPtm69P=7Sgmsi0iY_Q7HeoQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Df5WuOi-_sNvCcWM7oWxZPtm69P=7Sgmsi0iY_Q7HeoQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <60F9B65C555F484E90EA969F0DAE37B1@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWyRpKBV9f90LtUgyXXzS0eXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBl7J3ynqXg
 CmvFrK/bWRsYD7B2MXJySAiYSFw79JCti5GLQ0hgMZPE7ukr2SGc+4wSxz72sEI4GxglTs+e
 xALSwiagJrHrzWugBAeHCJB9ep4+SA2zwHpGiSc/3zGD1AgLJEucb9zPBGKLCKRIzNq2jxmi
 3kpi2WRNkDCLgKrEp7ef2UHCvAI2Eg/OCUOs6mSU2D/vDtgYToFAie3/N4CtZRSQldiw4TxY
 nFlAXGLTs+9QHwhILNkDEZcQEJV4+fgfVFxe4sStaUwg85kFNCXW79KHMC0kHs9Rg5iiKDGl
 +yE7iM0rIChxcuYTlgmM4rOQLJiF0DwLoXkWkuZZSJoXMLKuYhTKzUzOTi3KzNYryKgsSU3W
 S0ndxAiKQxEGrh2MfXM8DjEycTAeYpTgYFYS4X2t8zZViDclsbIqtSg/vqg0J7X4EKM0B4uS
 OO/qjuBUIYH0xJLU7NTUgtQimCwTB6dUA2Pjxj2KF18KuDy626ZjOqHh02VD59ss/1vlXcw7
 WOOMeZm/JGQGf9gjIHuw8YetQ2qR7lYFq98fbt//me7OOPNaUhiP3hT/+7PPu/ieX6qutXlB
 8p4tu26bdrIFVr1YvesG8xPrN1ria+dyMWsmhbNwTU1wf110kXXyVfYpRVdnZ2t7Vfzv2KDE
 UpyRaKjFXFScCACNL7kYsQIAAA==
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

SGkgRmFiaW8sDQoNCk9uIDA3LjAzLjI0IDIxOjI2LCBGYWJpbyBFc3RldmFtIHdyb3RlOg0KPiBI
aSBCZW5qYW1pbiwNCj4NCj4gT24gV2VkLCBNYXIgNiwgMjAyNCBhdCAxOjE44oCvUE0gQmVuamFt
aW4gSGFobiA8Qi5IYWhuQHBoeXRlYy5kZT4gd3JvdGU6DQo+PiBQQ0wtMDcwIHN1cHBvcnRzIDJH
SHogUkFNLXRpbWluZ3MgZnJvbSBwY2JfcmV2IDEgYW5kIG5ld2VyLiBQQ00tMDcwDQo+PiBzdXBw
b3J0cyAyR0h6IFJBTS10aW1pbmdzIG9ubHkgZnJvbSBwY2JfcmV2IDMgYW5kIG5ld2VyLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEhhaG4gPEIuSGFobkBwaHl0ZWMuZGU+DQo+IHYz
IGxvb2tzIGdvb2QuDQo+DQo+IElzIHRoaXMgbWF0ZXJpYWwgZm9yIFUtQm9vdCAyMDI0LjA0IG9y
IDIwMjQuMDc/DQoNCklmIGl0IGNhbiBiZSBtZXJnZWQgaW50byAyMDI0LjA0IHRoaXMgd291bGQg
YmUgcHJlZmVycmVkLiBPdGhlcndpc2UgDQoyMDI0LjA3IHdvdWxkIGFsc28gYmUgb2theS4NCg0K
QmVuamFtaW4NCg0KDQo=
