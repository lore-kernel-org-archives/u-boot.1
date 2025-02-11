Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA98C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A262800CF;
	Tue, 11 Feb 2025 09:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="b9/D1p1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D1A8043C; Tue, 11 Feb 2025 09:41:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BB980079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41370a1617=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B4pJCR016137;
 Tue, 11 Feb 2025 09:40:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 f0x6fFRvlN9F9K10m+o0UFIcOiLpDOgs50/9QWIqbb8=; b=b9/D1p1D8f587QYd
 2QCtWYC93eCZTpSW0SU0OHuLfM39fADm7UmhltjNONeFnNgq3686USoZ/05LDbJt
 853D/ry6pG3bkH2r25R7zbCTicJ5EIGXoi81FrD+Y2fPsXATO6J2vS0bkm7gc9FE
 fZ29mabrPnolvKMtwPeVx5V1HWewb+J4VlalstfJcPpH8pKdDXU4QCzvkq7jfI2f
 AO3yCIojtvbweYCKxE2J3WKkpcEzeCucH2PgAyUgflXxNTzO9EQdu+tp1yhw6lrM
 7T34Wx6oivVuf90PfIRWW6gRZBcTU8vGRA12C58wN/9PNezhsk2x9WtYOHe957nT
 tLr1fg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0rj2brj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 09:40:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 70E434004B;
 Tue, 11 Feb 2025 09:38:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A3982CED31;
 Tue, 11 Feb 2025 09:24:24 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 09:24:23 +0100
Message-ID: <e5b559c2-ce51-4469-9fc3-a9da6132351e@foss.st.com>
Date: Tue, 11 Feb 2025 09:24:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Restore USB and add UMS support for STiH407-B2260
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut
 <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Mathieu Othacehe <othacehe@gnu.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
 Tom Rini <trini@konsulko.com>
References: <20250130163547.512990-1-patrice.chotard@foss.st.com>
 <4492fe8a-1b60-44da-93b7-383eae3fa269@foss.st.com>
 <c8790ad9-0e81-4780-8da8-bbc06377c360@denx.de> <87ikpg6hkh.fsf@baylibre.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <87ikpg6hkh.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_03,2025-02-10_01,2024-11-22_01
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



On 2/11/25 08:55, Mattijs Korpershoek wrote:
> Hi Patrice, Marek,
> 
> On lun., févr. 10, 2025 at 14:42, Marek Vasut <marex@denx.de> wrote:
> 
>> On 2/10/25 11:28 AM, Patrice CHOTARD wrote:
>>>
>>> Hi Marek
>>
>> Hi,
>>
>>> Any chance to get this series merged in next U-Boot tag 2025.04-rc2 ?
>> Gadget stuff is on Mattijs desk, please ping me in a few days if he 
>> doesn't pick it up, I'll do so then. Sorry for the delay.
> 
> Sorry about the delay, I missed this series because it was not assigned
> to me on patchwork.
> 
> I will pick it up shortly.

No worries, thanks Marek, Mattijs

Patrice
