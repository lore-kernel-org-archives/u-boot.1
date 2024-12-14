Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F45E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 21:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72E38006F;
	Sat, 14 Dec 2024 22:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oKqNR1Ul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B9A880073; Sat, 14 Dec 2024 22:03:10 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4314C80066
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 22:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734210184; x=1734814984; i=xypron.glpk@gmx.de;
 bh=Re4QVOv/6ccp8ygKgx4dYfthsxBfnzQmG/3MhPchyIc=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oKqNR1UlgG33QNAOdXbSNrQCf6pOde9GqeQs2QH94xb2iCiyMlW5/WGPFjGF0e/3
 YnabYwK/HWM18fSKl8UCgWR0qxlcx6nxkdVLhAFF0uXIvwiroRHq84wjk1oseRHsC
 0ATlEwoGlOAXbM4x0IOCr8P/MIFCmCwq9EJLflsC07+kQEWGpxMuUOGr9Nf5kzjn6
 qWHrSXxChh624bRFJUcc8ZfjdLbZSA/nTnwYhaD757tWKEePcj653vmErD/IcNx/J
 uOyqi8lzGbQ4R3nIXi+yBqek4NZmtu9eps9ftX0M74hiWTWNNBAscac0oy6e5j+XW
 iQYWKjDIRsZS9dLppg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.106.118]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1tNM7O2ZeH-006vM2; Sat, 14
 Dec 2024 22:03:04 +0100
Date: Sat, 14 Dec 2024 22:03:00 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 5/5] gitlab: Add a StarFive VisionFive2 to the sjg lab
User-Agent: Thunderbird for Android
In-Reply-To: <20241214182024.1954974-6-sjg@chromium.org>
References: <20241214182024.1954974-1-sjg@chromium.org>
 <20241214182024.1954974-6-sjg@chromium.org>
Message-ID: <637DFD63-164A-4FFC-9D62-EC0F8C33CB25@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k7xzRhToAoEduF4r1YZpXALx6ntfkaZk5xVcmnLXJCIF0qOrgZq
 vubyfvBCrOrZZncYObOSn7PDpBRC5my6hTsBKZGewk8wIqzTOhYIy8EnMKFDegi6/IBfak7
 MSwmiHoDOleT+zQmy0mIkXZsdxBO5ECAzYSy5vpIxVO9IO2+kvskm5D2wqRunGcplNrwmoR
 7IDtChM4sSRL+Pax6lAiQ==
UI-OutboundReport: notjunk:1;M01:P0:m1ktsig2MbE=;Bm9cHh+EYx1ePxMXsAS6nqK/7mW
 DXdf40bYk8i4zQkgzh/CcilYo0DcPyDQVLEBfbm3wzLJS9KOkklawxVBzIoxD/QC7X57+fh8+
 nH8ZEax8z0iiZK7SwstKLPqJ8TNMrxk5cNvDV/rX7LhoakwHdjTfNIQFeQF/q6DBAx5uCDTyJ
 qRV7j3waSSgHEjAQsPjazp4Wv7Zqogly+igmCkziCk08CLmhg52uEhQFamuT9xb7oHc/IstI+
 +vrAgMh7L+NlQfsKr8fAIvp9JfvcgQ+6Qww7jELiLaqoWuNlZc8AZX/UM/sfvgrkCvXZvPuQm
 nw1Zb3Ru1ViUxMKdTcnbp44Ke9W72J9r6qmPN3ALEyXEZF74zTWIb3rdjz+IvM/eLxWn42FK3
 UyubCge8NupDTYjFql4M3UeoKsaXh3Vlhd5YhjZDKVCPPSAaOrlpqxGatMj1qxGqmeRJ8yi0Z
 OU/UGskSNsjR0RpMvgK67Q6qloCEFfrGWyLkWXj9m3k0UXh2Szs46CqRfXL6qLFwcDG9lhAq/
 RbKN2yTq3EdbDHK7srXOQTeIWjKdWba/5xWqyKFmHBceafSFTIojY9c84V6QY5Zxpr7NWcroj
 K2j2jSc1xykadxyxGpyKXe4n5Fks2YtpSZQemqxQIkL3tMctOjN2+4ArjoavA1zjkBu1zYCsY
 HHmyjzPCnImRs4glewVqwNeqJCRJ6F+miuVDWLTGtf/dMpH0wuY/JeUUAp5zgx7jfFcIGN646
 y6eimk5eTGNBPaWnKwvwbvy9nO4UjtM1snqwWK8n4m7LVBYFPkKVz56RX7FeYSB0yUHQbObax
 OR5uCfSoi/BEPquVOBZrvMNy906PeKka1FlaGe9oSeR4TBEG08F0FscATgh86X7eBh0rpZL6P
 Yw7Wrg6vEVN7j5nhWIQfdrz8S2pRcK2a46PnThH4yNOwAoj32OqZofQFiyw9X5QndVg2WvIdv
 OyMH3uwMAasJs7BmuhfJgM3WMaU4aoxuXcQ7T8g4Iea/U3yI+CHJX+jdosbUKjOk2BGzrL93u
 Nl1eeZ6eURpn8WkDtQQXNjauHGqnOqIhDTrR3W5/vWd69IQS1xQEBlndrcNi7Rqp0jp1TRkkV
 Q7p9/ldJM=
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

Am 14=2E Dezember 2024 19:20:24 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>I have one of these boards loaded with Ubuntu 24=2E10 (64-bit)=2E Add an
>entry for it so that it can be used for testing=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> =2Egitlab-ci=2Eyml | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/=2Egitlab-ci=2Eyml b/=2Egitlab-ci=2Eyml
>index f379c11a1ba=2E=2E33ec4b2e417 100644
>--- a/=2Egitlab-ci=2Eyml
>+++ b/=2Egitlab-ci=2Eyml
>@@ -691,3 +691,8 @@ nyan-big:
>   variables:
>     ROLE: nyan-big
>   <<: *lab_dfn
>+
>+vision5:

vf2: would better allude to what it is=2E But it is your lab=2E

>+  variables:
>+    ROLE: vision5
>+  <<: *lab_dfn

Could you, please, add a comment line describing the entry=2E

Best regards

Heinrich

