Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96C6FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7654983BC4;
	Mon, 27 Apr 2026 18:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qu/xwNLH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aEYO76ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA12383C14; Mon, 27 Apr 2026 18:54:36 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 628BE83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RCpGGC2383117
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8tvda4PzqpzbDRdN0XDSpvtvSk5L2KQPPzzADYksGw4=; b=Qu/xwNLHwPKlzBwX
 rsILwVPKQ80d4nlF5lFPdgV7rYC2lz57J6IfOlp6JlG48a1K28UV86CsCzTtClRD
 iiYjNBV+pd47/7mJv9iKvwQw5dE3v9FQE/WOg7/dHANHTHKWcze+h52zKLTe4TLa
 s/qEN2rRgMl1fuYvs3NSwP/48pb29jq+ALyC01E9l48c8ilM8Vi/2+ZU8y8IDUsr
 gQ6ZWq+PYrN4C8jJL+ZzNiwClZwI37vCMIohw1B8BznUy88YIFQu5diUucDymsda
 yaCQi980Gc/8FcgFvNfc7KTG5U1LLYXyNG5O+skBNYjrDzSHu0DrUTU8eBpiPZC5
 x7x38Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt85xrxeu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:54:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c798fc1a426so3883370a12.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777308872; x=1777913672; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tvda4PzqpzbDRdN0XDSpvtvSk5L2KQPPzzADYksGw4=;
 b=aEYO76ZHZoouMx8FO5M4H3X6xiwzHW/BnJh8uFhumkIvlM8Kq408pQ9nxgJGiRFLZP
 Dks1GAYJS7NGxLBM5P3NwXWP9NQb4Djm6zYhdgyLWkjv4mpdsyoVxkDa5retRiC9oJGv
 JHaLZ5Ekq4gB0Zp0fA5uBwsUmpd+HrKBn/521nGjWVqWvfUIuNsilxLAcOneiUAug/4c
 wbXMTVv/ibmKNrxoqCWUWf0ZAiI2bpiNlsRkuzLhiXFVqYGglC58SAN2woZhilFpXiKp
 sd6IRGoathKNrDthX/9HImrL/ph3myZV3FokTFwjqzkkBxnkU9C2g5JEq8NfsExv5/wb
 Vkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777308872; x=1777913672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tvda4PzqpzbDRdN0XDSpvtvSk5L2KQPPzzADYksGw4=;
 b=hb627/W3nHEjP2/adRbZW2HW5NdO20rkzj2obBA8J2gK4DxkRzyfgQtKeWJl06pLZg
 kX/9mHmCevwD+NKgG1QPCrYV+quSzpPrmLhEMAnbaTGtzXgqMv3E0TV+B8ZmH/qooXfR
 RYSgBwBMPwstyptyEyjiOsv2g3w2oULYb2tUzIUmptYfnzURaNNkW2EuVaufxlom3jxh
 QWXIjKn3/LHsQ0PnIP5/Ngxwd1mO95knzThUiVT+ko1ZEfSwOP6EWIJ/mrWGJ6BYrb03
 trpBcGqb8xSXYKDrJt/53uTJP0gLVDVIqBTSaGiSk55tG03IiRAdsGo9LmN+lJUjpXY+
 TRIg==
X-Gm-Message-State: AOJu0YxIFVelRzz/AWsr0VSK+JLi7vOUmlTf7+1fjor54ombaEPKz+7m
 wMwEdZHdlQmpUn2jXGz5uhPmd3BIb1hSz5dQt+O2nK7zyTVR1x/lojP+UFtfzlQPu2EtCgyV22/
 LGAKJijwD8bwFEe9joYTVC3GIvM3ebLzSTT0QU5pXumKDbbLGthHyZy6c
X-Gm-Gg: AeBDiet2iYidZtxM0XgH0CGh76qbB8kapETSrn3VmkBNqpQr1p11HPsu3BnFgmedIl2
 uUTSjk+x999/h6aBrBttDO7iMQZl3H6LAzs/RzSXEyz0h02/s5zmZt9YN5TkfbHEYVRRPsx67KG
 Y2pwVNEJWJyGq38Yyl508tQIxihZNQHbfpdDgnkvtfcuZpFguSUkFPItaCFEw9Xf6lu5R+v1iGt
 4KqmZuEd5R0Q4mJck7nm7hApv0nAdmxUSuTrJeYObyt04LAQIEghs/czGRws0raFF8wEtKwxNMA
 IOblHWkh4+ZjNdUjiXckAoCo6hGHLcGehjZMprtOwsA//ucMf4krNyviHU6r0yOTRyBq9kvQD75
 joS6d1c/nL7JPbyp076BLAD84iw6j0E9x0ad8uOOvijSh2iwVDz99L4jtIj/3XJRf02F5
X-Received: by 2002:a05:6a21:328f:b0:3a1:90ef:7e46 with SMTP id
 adf61e73a8af0-3a398df6a33mr178351637.33.1777308871479; 
 Mon, 27 Apr 2026 09:54:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:328f:b0:3a1:90ef:7e46 with SMTP id
 adf61e73a8af0-3a398df6a33mr178305637.33.1777308870861; 
 Mon, 27 Apr 2026 09:54:30 -0700 (PDT)
Received: from [192.168.0.3] ([49.206.96.228])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c797702faaesm24881363a12.23.2026.04.27.09.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:54:30 -0700 (PDT)
Message-ID: <f80c70eb-feac-4f1d-ad56-5ba757c81b00@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 22:24:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drivers: ufs: qcom: Initialize and enable clocks
 before hardware access
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
 <20260319-ufs_probe_clk-v1-5-08c085d6b15d@oss.qualcomm.com>
 <acI0Flg4gUKmP2FQ@sumit-xelite>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <acI0Flg4gUKmP2FQ@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zs3d7d7G c=1 sm=1 tr=0 ts=69ef94c8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=mDd7tLh7uscPtaIqipyRMw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4tWuYj6Pz0fy1KoJoJkA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: -vdyrMZDSzNffdsEFce2IzCfC_LG9nuO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE3OSBTYWx0ZWRfX8wQeDTxfZLc6
 QsDxmksAC84Kpa9tra2LLKlnOBJsBiYC58+knKoVaxFSNeGZ+vmKNIFO/nstLaRxZtXoZKeMi8Z
 aJzCsfB4AsFMsrksyUbDeV0iJ99/Nmuo81B00qbmKa7qqCQd7qa7TRnaZTOYEwRwNpVrCZLLPWu
 pR7PDWTdEAbVfXiWyvucqAuUSPiGy+ijUWwG1kdEbUOrMVblQ5KbCgPnbb8YAWECB2xFmK3CvHk
 5DXRxMbTcXjyD65jJYZ156lCpj3xuVmIc1gJC/ayV+ok5NuENDznXZ81RapyxF3uxagysgndRXp
 gQIKRRTx+pIRC+TmoLBb83GXDVlzX5ICO3gl4e1jWlvDluUrjMHSUUpNrsuoZrMez1I8J1Lom+9
 RwQA3Eui31fuE+buDYMpDuVEGEo3P9Wkskbwg1L0ecoQQC/v0+B9tCXbgVqJSzZFOxGkenA6JsX
 eTxRqQm7Zi1w5tDjyJw==
X-Proofpoint-GUID: -vdyrMZDSzNffdsEFce2IzCfC_LG9nuO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270179
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


On 3/24/2026 12:19 PM, Sumit Garg wrote:
> On Thu, Mar 19, 2026 at 03:07:42PM +0530, Balaji Selvanathan wrote:
>> Move UFS clock initialization and enabling before hardware setup
>> to ensure clocks are running when accessing UFS registers.
>>
>> Previously, U-Boot depended on earlier bootloader stages to
>> initialize UFS clocks. When these bootloaders failed to do so,
>> UFS registers became inaccessible, causing initialization to fail.
>> This change makes U-Boot initialize and enable UFS clocks early
>> in the init sequence, removing the dependency on previous
>> bootloaders.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   drivers/ufs/ufs-qcom.c | 45 +++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 37 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
>> index dc40ee62daf..c63e550c881 100644
>> --- a/drivers/ufs/ufs-qcom.c
>> +++ b/drivers/ufs/ufs-qcom.c
>> @@ -30,6 +30,7 @@
>>   #define UFS_CPU_MAX_BANDWIDTH	819200
>>   
>>   static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
>> +static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba);
>>   
>>   static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>>   {
>> @@ -49,12 +50,34 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>>   
>>   static int ufs_qcom_init_clks(struct ufs_qcom_priv *priv)
>>   {
>> -	int err;
>>   	struct udevice *dev = priv->hba->dev;
>> +	struct clk clk;
>> +	int err;
>> +	long rate;
>> +	u32 max_freq;
>> +
>> +	/* Get maximum frequency for core_clk_unipro from device tree */
>> +	max_freq = ufs_qcom_get_core_clk_unipro_max_freq(priv->hba);
>> +
>> +	/* Get and configure core_clk_unipro */
>> +	err = clk_get_by_name(dev, "core_clk_unipro", &clk);
>> +	if (err) {
>> +		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	rate = clk_set_rate(&clk, max_freq);
>> +
>> +	if (rate < 0) {
>> +		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
>> +			max_freq, rate);
>> +	}
>>   
>>   	err = clk_get_bulk(dev, &priv->clks);
>> -	if (err)
>> +	if (err) {
>> +		dev_err(dev, "clk_get_bulk failed: %d\n", err);
>>   		return err;
>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -561,6 +584,18 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>>   
>>   	priv->hba = hba;
>>   
>> +	err = ufs_qcom_init_clks(priv);
> I would just drop this wrapper and directly invoke clk_get_bulk() here.

Hi Sumit,

Implemented this in v2: 
https://lore.kernel.org/u-boot/20260427-ufs_clk-v2-6-36e10a7c0ef6@oss.qualcomm.com/

>
>> +	if (err) {
>> +		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
>> +		return err;
>> +	}
>> +
>> +	err = ufs_qcom_enable_clks(priv);
> There is already a comment related to this API:
>
> /*
>   * The PHY PLL output is the source of tx/rx lane symbol
>   * clocks, hence, enable the lane clocks only after PHY
>   * is initialized.
>   */
>
> Shouldn't PHY be initialized before clocks being enabled?

We can enable CBCRs of the tx/rx clks before we initiatize the PHYs. 
Once the PHY is turned on, these clks are enabled automatically.

The same process is followed in XBL/UEFI codes.

>
>> +	if (err) {
>> +		dev_err(hba->dev, "failed to enable clocks, err:%d\n", err);
>> +		return err;
>> +	}
>> +
>>   	/* setup clocks */
>>   	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
>>   
>> @@ -579,12 +614,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>>   		 priv->hw_ver.minor,
>>   		 priv->hw_ver.step);
>>   
>> -	err = ufs_qcom_init_clks(priv);
>> -	if (err) {
>> -		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
>> -		return err;
>> -	}
>> -
>>   	ufs_qcom_advertise_quirks(hba);
>>   	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
> While at it, I see this POST_CHANGE setup invoked twice. Can you check
> as to why that is needed?

Implemented this in v2: 
https://lore.kernel.org/u-boot/20260427-ufs_clk-v2-7-36e10a7c0ef6@oss.qualcomm.com/

Thanks,

Balaji

>
> -Sumit
