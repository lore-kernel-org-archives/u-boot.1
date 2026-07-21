Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D773C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 05:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66CD180B9D;
	Tue, 21 Jul 2026 05:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NXk47rlSRj51; Tue, 21 Jul 2026 05:45:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E2C2808A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784612704;
	bh=ki54V7P7386qgyShg2YMGxzAywiW+fXnyoDv7C+rzLk=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=01m9vtgriLgGS+idN9Dd3ku3Birool4qREFsoP5VEifG90b9fqY4V555NStn6IiWe
	 uECbF4919KJv1mPy3kEvTdbbPkAsYpHn7jfHCphw20XKRXjQAf3kbwnRcUt/46PYJ6
	 bvIrOVBLJKALQ9yamhgjYtJXYxI8qRl3ILDmF28MrmRDETX332ejEN19zzr04r12eq
	 L5XqG/CZILx2qwVhCvK/SS0DJjnDHWyd+QHmx1ubgAq7xh88s7KY1mNfNW7184ilsQ
	 gIMH+iS0pBrdFuXxD3FJ34DqZkVKzocdiulBaAJL1+VDVIwq8b59diWEc2ICXDNynJ
	 NLn2GIlLuE8mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E2C2808A0;
	Tue, 21 Jul 2026 05:45:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB1DF109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0F5340298
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WCuG5CLPDTt8 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 05:45:01 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=balaji.selvanathan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3E2D8400BB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E2D8400BB
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E2D8400BB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 05:45:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FED582991; Tue, 21 Jul 2026 07:44:59 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42B9803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:44:56 +0200 (CEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L4T2nE528065
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:44:55 GMT
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se08ck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 05:44:55 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c860544c077so17929085a12.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 22:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784612694; x=1785217494;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ki54V7P7386qgyShg2YMGxzAywiW+fXnyoDv7C+rzLk=;
 b=QEwXIQ71njXpfq4EUnFFsHNJKBJ8S/ASDFThCaVIFa8tNFbsn5M6xgnKosr79rHRrv
 vBtjgPo5hezmQR1X2mxKDEXo3mWaW+aGUrf+wldCRo7acn+D51M891VcRFdV4BGKM4ca
 DTIFJxQYi/+vZmTIougstEQaVZfG/0xrP3tkYS51TYi0yDjgy4lFIGyFhpHfHpEZu0t0
 5VBdWYRCNjRCHn7ictwnUSKWZ9micyZ3kYM2Tar7jyEc53pXqcVq7SL/Zij7WBqfCEXQ
 GZlgSfBxJo1X8dt+3pRvgQB8NKzTGc7LbXPT1VTvaGc5vlFx3j13Iem6OjCt/MZe9yzW
 G43A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfyRgK9nfp4pBYgfw/WfUVRBp3naDQAXjqkP5PFs0rrSz2BGza0Re2UQtt2UMagXrTH8x8VfA=@lists.denx.de
X-Gm-Message-State: AOJu0YxZtPs8i/iUN/7Y4C8bvH0GQr4GP7hs+HIdbGjCaPRBlNGldUSn
 cJoJhwAZn50rG3SMcVgWOe6fAs7NULkUgi9pmmQbA3UZwn6+w+nNzDUZEJyJrGUGW0n3ME6HuPa
 tUC0WD58PS3d8UjmVjya6ShtbT5PBga+jO9mwqIDf4D8QBLtB9wE+dgzD
X-Gm-Gg: AfdE7cnr/aBzcND3SxtPFRcndY7FAcByW7mrkuO7y20mKkxYTBPf1YUFE7cRznRwa4p
 SavNIo6lecHVKGJuNimCoRP9x3l13/iqIQj1iYUdLbr5srMJu4kfQ2HzkwBY2fMBnhh47mBwCuD
 LeTCzxPYnSv6HJh88dlnvZki0K9ST9m9c1F3lTlerSV7mwxn2rV7dIfhpnKQj/z15oSx1aniEs0
 X+lWWC43hiwnJtXvrZTncHFQRYmvTxmz9DSJqpR5wLVOD2JNNwuoKk9j9SRrILNR4O7EmN0BELS
 /VLEvsuj298RlwrFkms5EQ1PBesppVcq6SD6cDW6K+IPyk/g8CCSwUaWTnTRfGIPvDxX1ptgEtm
 r2oqoGzj9MDrEp1YaMX7dXRfZVyvemRCBybi44g==
X-Received: by 2002:a05:6300:83c6:10b0:3c3:becb:b705 with SMTP id
 adf61e73a8af0-3c3becbd092mr11514144637.27.1784612694105; 
 Mon, 20 Jul 2026 22:44:54 -0700 (PDT)
X-Received: by 2002:a05:6300:83c6:10b0:3c3:becb:b705 with SMTP id
 adf61e73a8af0-3c3becbd092mr11514122637.27.1784612693673; 
 Mon, 20 Jul 2026 22:44:53 -0700 (PDT)
Received: from [10.151.41.190] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bb8a4sm46547594eec.14.2026.07.20.22.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 22:44:53 -0700 (PDT)
Message-ID: <941ea27b-9541-4f24-a91c-5deaa88fde9e@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 11:14:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qcom: qcs615: disable SCSI and use MMC for fastboot
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Tom Rini
 <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260502-talos_emmc-v1-0-98fe4a4d6f8d@oss.qualcomm.com>
 <20260502-talos_emmc-v1-1-98fe4a4d6f8d@oss.qualcomm.com>
 <agrvLQfkJ4gid6CD@sumit-xelite>
Content-Language: en-US
In-Reply-To: <agrvLQfkJ4gid6CD@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wQSTji2vU_GqnjxcdHQGS0Dwqk3ovYGh
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f0757 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9JNZfU3L0i_FbPpp6JcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA1NyBTYWx0ZWRfXyzpihA0ekZJ+
 tz3j/6Q6e5dGw0IzczWvSeuHJB+KDfyUYpDNNJUXWi0QPrNX1OC02wqsI1C4YhLwR6qYQFNHRdV
 vGMvs9Kqa0eWfdnjVyP3FIM2GaYiiq4=
X-Proofpoint-GUID: wQSTji2vU_GqnjxcdHQGS0Dwqk3ovYGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA1NyBTYWx0ZWRfX1j4sixpXFTDg
 kiVUxE8bgXhJQQfBmtllh5WZ+BZmPCR6mEKeC0cO8i88Lj3Y1o2eBYwzb+V3L9B/tWw9rUNEK4f
 TWSLLKjAZHAcZc25/KrJgqhskHk7DvKLa1CcldsINLpEiPCHwZ8RyWg04SLw6mI1+PrV1VKUzKb
 VaxKQVFpCdKQn0sDZr/gcMwTIgpgEbyDjJb8qUJDKnqmpimBRaMaNbmBM2VgHG+mcz6wHzA52Un
 GKsZbNYIfhdf8HWlMWEmXbCLJWnKPXbZQSeLHtQcy5lwjnf7++gXWygzcWVZlu1bDXWGafvVDT1
 rfcBxxUCzQt9Y9bgmyAnAXHvvAySNjSgI5ea/vxY6mgifn01dXOT4X3ozcWpSskbgu7vOF2kz7a
 FZvH/QB8NDbN1gLR0R5hu5ch9GgWpmuDaGSrbwnbp/tpKZraC2MASEMVk3ugP5KwBlHLtNObf2u
 gEw+oDwp4UXbAKU+tpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210057
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ki54V7P7386qgyShg2YMGxzAywiW+fXnyoDv7C+rzLk=; b=mMaCKB3j1qrgdz9Y
 D06uNaPVgzSNsY6CfwpJ+oZKvhAzxTooo2u0/rDdCV16sr+61zvK8iG6/UhQRRCR
 zEPjbCXtVPxem+h1qWj/YkCcr2a7VW1J+PpVZzN+HUEW3ugZXQ8zsscD2b6XGV3d
 QaM8aLSIVkovpVYMSMGwhwLA7uguxTF4HS99DJjqHY2srY9QxMNo0yUpXN9uy2mf
 EpxqtXa3cAUUzy6LgioPxS7CtGzrG60DtxLwqzh2MrWgb+tjcKTiHD+Ux/ThYd2k
 ezIqZrGO3FQA9JY36rIpqWj4SnBFJK8rITxg86YoLgnT0kblF0RIxHJiDoAs/rqg
 WlFsLQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784612694; x=1785217494; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ki54V7P7386qgyShg2YMGxzAywiW+fXnyoDv7C+rzLk=;
 b=J/Wq/Z13HJ4KjKeJW5rTenAPOIcc0xRIxUPk4N2KqnC9POIQaebMleH8zYBhLMdK7r
 pHFkvCHYc6wKFgPmBayl7PP540neCw8ez/f9q+7W6LY6yX6Ax/qXd7YUMt7uDkDLpxBC
 T5R15sUc8DCXPN1uuS/ysEnWnd29QgMN07Ab/33c1uIz3r0hxt0k/3xZNttgKnwpGOUl
 jWGYjZaqquIAgpE5ujCGOmsx+pX1CsZ7Lhh33lTPTey0ygQ3H7GBnDhApTvXYssDqmJc
 LeNrlPVW0iRKgEGz0/2RJGG0k92g2L4ErloUlzX84BneEPvTwuovZcYW8fP1RE/YHCyq
 qALw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mMaCKB3j; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=J/Wq/Z13
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mMaCKB3j";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="J/Wq/Z13"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Sumit,

On 5/18/2026 4:21 PM, Sumit Garg wrote:
> On Sat, May 02, 2026 at 07:31:48AM +0530, Balaji Selvanathan wrote:
>> QCS615 platforms are equipped with eMMC storage only and do not
>> support UFS or other SCSI-backed devices.
>>
>> Disable SCSI support and override the inherited qcom_defconfig
>> fastboot settings to use the MMC block interface with device 0.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   configs/qcom_qcs615_defconfig | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
> This patch seems to be dependent on this series [1]. Either mention a
> dpendency here or bundle this patch alongside that series.
>
> [1] https://lore.kernel.org/all/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
>
> -Sumit
>
>> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
>> index 27666a8129d..494e55bb18c 100644
>> --- a/configs/qcom_qcs615_defconfig
>> +++ b/configs/qcom_qcs615_defconfig
>> @@ -22,3 +22,9 @@ CONFIG_REMAKE_ELF=y
>>   CONFIG_TEXT_BASE=0x9fc00000
>>   
>>   CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
>> +
>> +# CONFIG_SCSI is not set
>> +
>> +# QCS615 has eMMC only, not UFS/SCSI - override qcom_defconfig settings
>> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
>> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0

There is no dependency on the mentioned series.

Thanks,

Balaji

>>
>> -- 
>> 2.34.1
>>
