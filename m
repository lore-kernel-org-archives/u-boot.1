Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3328C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCF4800CF;
	Tue, 11 Feb 2025 09:40:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KbE8cyLF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A9A803CC; Tue, 11 Feb 2025 09:39:59 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6815F80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41370a1617=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B4owCF019487;
 Tue, 11 Feb 2025 09:39:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 ZIeZqaGaPoC/kwEFknSvJEsaNhfq7zXw1TPEN6x77G4=; b=KbE8cyLFxZKqqqNb
 IIZQlsRhyfFSSBiSuplcBcbhzdJkwfSefTUklK0FlywaUP86WfeqgIyh9kNjKtS+
 XwHfV78MxKQZoWo/1M/HZ6Mlgob4L0qAlBPxTFWgDFoNgEI5p7n/9otMo44MCPLq
 jRq00q1S5Fq8PAixWN40V5OrSC4t4fAsfzs1j2GxJJ5/BGj2VyMWPXcvWjRLq9yI
 YyqdWoTA69zD+MogvWOT1HHY3TN76tzDzsDXghB6JHnT9bkzMUmo5SRCUjj+Dg9c
 LTrZXTeSOHcI6Odoh0YZxFkkogwYcNNqP6DQM62swPm5WrHu4DrGNRow15JoqusT
 L8D3dQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44p0wt22uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 09:39:52 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D5B3840059;
 Tue, 11 Feb 2025 09:38:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0D5B72CEF87;
 Tue, 11 Feb 2025 09:24:47 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 09:24:46 +0100
Message-ID: <23ee53ac-fced-4110-829f-399346ed7376@foss.st.com>
Date: Tue, 11 Feb 2025 09:24:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut
 <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241202074644.5380-1-patrice.chotard@foss.st.com>
 <87zfldnlmw.fsf@baylibre.com>
 <c89e94bf-0ed6-4b3f-9f3b-eee9d30a91df@foss.st.com>
 <f1d2068c-b393-4b90-b923-aa51b0972dc3@denx.de> <87lduc6hnh.fsf@baylibre.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <87lduc6hnh.fsf@baylibre.com>
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



On 2/11/25 08:54, Mattijs Korpershoek wrote:
> On lun., févr. 10, 2025 at 14:42, Marek Vasut <marex@denx.de> wrote:
> 
>> On 2/10/25 11:28 AM, Patrice CHOTARD wrote:
>>> Hi Marek
>>
>> Hi,
>>
>>> Any chance to get this patch merged in next U-Boot tag 2025.04-rc2 ?
>> Gadget stuff is on Mattijs desk, please ping me in a few days if he 
>> doesn't pick it up, I'll do so then. Sorry for the delay.
> 
> Somehow, this was not assigned to me on patchwork, so I missed this.
> Sorry about the delay, will pick up today.

Thanks ;-)

Patrice 
