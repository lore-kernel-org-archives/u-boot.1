Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DA1C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 07:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1573C883F6;
	Fri,  5 Apr 2024 09:36:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="u5skZT2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FC038845A; Fri,  5 Apr 2024 09:36:02 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AC687F4B
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 09:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=482502c049=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4351XPb2008556; Fri, 5 Apr 2024 09:35:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=dIb9goX90fWEWjfY1nyXouDvCNvudroYANnHZFYCHho=; b=u5
 skZT2X1+cmJfDflq5AgZNxvyVU7AWyNFOBuMky/t0Ico0FNBpwKw2aCrtKaDvBBM
 Panu3JNgl8y9BimGjaNnTjb2coGz+mcEIeGHpH7ErY5BoczVhD6Gz+lBiZlNyFwg
 v++zUi7QAth7crbj91w/PCKDEk7jcfVTFJCZxcusq5geOjCWfRxIEedHb8Rxfgbz
 zFf+2JzTSnxWNcy2gb5JESaD0+pfgpxY0oBFZOvlZjqDvrxxZUNjHr1jQdxD/DSg
 hWJ3YoprEoJmiWsphShCIE0Um57bOSm7laWXTyB978d9vIGg4CvjXue1/jZ1ttFC
 aqsqlHTocUe5M+vv96SA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9empp1r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Apr 2024 09:35:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2384A40050;
 Fri,  5 Apr 2024 09:35:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 101A120F2AF;
 Fri,  5 Apr 2024 09:35:05 +0200 (CEST)
Received: from [10.252.29.225] (10.252.29.225) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 09:35:04 +0200
Message-ID: <0768ffcd-2e37-4a26-85a8-3d7b23ad5234@foss.st.com>
Date: Fri, 5 Apr 2024 09:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: stm32: Test whether ethernet node is enabled
 before reading MAC EEPROM on DHSOM
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
CC: <u-boot@lists.denx.de>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Andreas
 Geisreiter <ageisreiter@dh-electronics.de>, Christoph Niedermaier
 <cniedermaier@dh-electronics.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Stefano Babic <sbabic@denx.de>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240312211628.32842-1-marex@denx.de>
 <CAOMZO5BL0-1r63OiKLwgj1D2X1BHw4sN45g+QVeJ6vOSHrNFig@mail.gmail.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAOMZO5BL0-1r63OiKLwgj1D2X1BHw4sN45g+QVeJ6vOSHrNFig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.29.225]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_06,2024-04-04_01,2023-05-22_02
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



On 3/13/24 01:52, Fabio Estevam wrote:
> Hi Marek,
> 
> On Tue, Mar 12, 2024 at 6:16 PM Marek Vasut <marex@denx.de> wrote:
> 
>> NOTE: It is probably best if this goes in via either imx or stm32 tree,
>>       I can break the patch up, but that would introduce dependency
>>       between two PRs in different trees. Let me know what you prefer.
> 

Hi Marek, Fabio

Sorry for the delay.

> I can apply it to u-boot-imx next if Patrice and Patrick are OK.

yes, you can apply it directly through u-boot-imx next.

Thanks
Patrice
