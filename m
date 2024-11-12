Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65A1D32D8F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 11:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C7F189432;
	Tue, 12 Nov 2024 12:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SI2DD+0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026A78943F; Tue, 12 Nov 2024 12:02:08 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 268BE89431
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 12:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=104698dab8=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC97NE8029351;
 Tue, 12 Nov 2024 12:01:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 kW4Ac6iiqfuegVFISpO2a7maS+gITY0i+U3ynjnunK4=; b=SI2DD+0usAJunX5L
 9ou4xZNq33OSx0+Q50wg4D8SW/dQDRlVCkTyIirfMkoOY/5LfE8JxbywImK16HOh
 SFOLVeA6D5/r+jdSNOLpLHJBItlG1JV3rtVjMx7NY59iviL5DCONsC80g5LZNoMV
 TjMkI87q7dO6I8omqVDqgPCDGb2nPkeu8euVCKYtUj7d0DvNkZnE71pUVObYqrJd
 0A7Q8HgHFLwXBttdb7aA4+/OjcyDJHkHOXJ/YCC4XV8sRk3t4Ziw7Whul6/2j17C
 YWei0sU+u5LmNH6Qtz3q2rKLUf8Atm9h9RBgjDbCSdrny10J41KLZBx3KcPZ3Ssn
 e4qNzw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42tkjnh1j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 12:01:49 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9458440044;
 Tue, 12 Nov 2024 12:00:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E8F529D605;
 Tue, 12 Nov 2024 12:00:07 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 12:00:06 +0100
Message-ID: <0af6993f-2e1f-4f4a-a84b-7be3d9526ed1@foss.st.com>
Date: Tue, 12 Nov 2024 12:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] lib: provide function hextoull()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
CC: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Raymond Mao
 <raymond.mao@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Hi,

On 11/3/24 23:42, Heinrich Schuchardt wrote:
> We often convert hexadecimal strings to hextoull(). Provide a wrapper
> function to simple_strtoull() that does not require specifying the radix.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	no change
> ---
>   include/vsprintf.h | 13 +++++++++++++
>   lib/strto.c        |  5 +++++
>   2 files changed, 18 insertions(+)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

