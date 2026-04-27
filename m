Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C36FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC83384329;
	Mon, 27 Apr 2026 18:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IXaULY39";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OykzlatO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5365B842FD; Mon, 27 Apr 2026 18:49:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE58C83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RFLPL9440983
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bKTNut5MYN7zaMJcZ5dGiMukrlfeaBRK1UQX6x2x2Cc=; b=IXaULY39DOz224SN
 OgNEQ+VUyq9LjZJO+5GHKH+xREAboTztbvpPRnr7SgYqRxqjzNj+wl0uwMbHjTjf
 EYmFKI2yr2Ol4aGYWpebW0Q/m3Ok/6fCPv5LHVLqioYuRYm1zv9D+dj+CBNzcpNd
 pWaAuAkssptOvMwnJumWyFM7S7GyHZ5vCVPiculi/bSI7rmnCUCApyAR5ElW+wdi
 6dqSHMxR2FjezFA2O30ZnS7iURyruxTvHL/kYIPRrNWDlRkiA+++ysXOuntlFBJO
 obhlmPQfSDCEZO2Wvsjbv4KaxX8Pbcd8CPFDzDGEvft/pHGTk+UcOQw7oS+aT/LR
 1XDgwA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac40an3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 16:49:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35da86144daso9963532a91.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777308583; x=1777913383; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bKTNut5MYN7zaMJcZ5dGiMukrlfeaBRK1UQX6x2x2Cc=;
 b=OykzlatOeX0QWU7DGs36zHACAZzzCf0HdhE+DseVodqLVOmejD2Cv916eGfheuYTov
 3i9WS1pc2dfH/6mPiEdtPGhJFdH45uGdtRCwGdVdkuuwARcenasUOINhKuCXTsY/g3F9
 d89r9ibZ4j8zly4/y5EcvfNF6p0V4uDFnQpgOpWwvmTY7UGKlkq1n9u29tO8dIYp8mBT
 hYW6uGsnIHta0njxwHfJ41mg/p42OBbg8lJw6L8FHpXW8TakYoIwNtAdraGwe845nmIx
 55LE7UmiMLi6ZsqNKgF2rVbtQjumhYvVDCyuRGtghJHWQsVfvcB1f7RFSb1ZTlo9sjxJ
 qrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777308583; x=1777913383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKTNut5MYN7zaMJcZ5dGiMukrlfeaBRK1UQX6x2x2Cc=;
 b=sOdP7YGz3EvpqdvEwKHloGIfpZRhmpY0BZF5I8b4b9DeBQW+IRvMJYDdJbegWsJK/q
 tzoagGR43RAFVZnqrMcXD4qOB/i4Lio2/wEjRIYX+jPoDhsx8uL5MSePuu0IbW/MsN1L
 9hz1+T67S8H2/LbDPEKRF1v/zly/F7SgYbxO2cQTxNfYtBbeF5lmn1ew2gTmHawMqtwz
 eblDb+qHiXy2MG7sqW8DwbA4bHz9QjMpv8VEEkcW+81jmqhy2CN09YMi1ooYAYRrisLT
 OqPirX9vyEn94mj5JeV229m38tuHbTVFLmXIw6KTE5dr9lW5806BaoOi3dw+0VRJs7HK
 rahw==
X-Gm-Message-State: AOJu0Yw9+AdKTVs1mlKRECQnqys7oFgGcIdCNjTamqiDklB0WCjb98yy
 p/9PUBfGxX/YxPxZ0zmOGZiubv3ndsH3wJtbHFn5jc1uXgU5wVnGnRJNfzVzPOhj8zFBUvVD3eV
 O1MwOnEW5EEoVfMZO/l0Px/6rAXoK51MrSoJIaSujBMV0QJLsd767RvlnTUU3HylV
X-Gm-Gg: AeBDievL6PjJqrA2CMwn1qtaEIxfEVt0PAPj6KfShLXRWxfxdM6KUPDANYqKisEHAW5
 EuCpHKONCp++H+kMC+p/Fx09L6nfO/iqRWf17bO6LpJY7+UD82ngaWhbN9UwnY/mLyqd0tAZuU/
 n5YWyTikuIKWLYhbhwk4X53tfrUpVxHPORkGVfjF+MfQ2DFblddKf6809yNgTu86wR1giCRPTyk
 RAO9oNlSKC10kXSBJUKncSZXVYfjQq4sVVfHM50Um3V8oMeqb0I0NRfRrL9ktDUglg+0ypxkOFD
 j0rVaQZr4D8/wwfVFjuhFSZ16dez5DtXu22Q3KbpiQXTecmpDCD2kjFCRC12Y+MbKFbRJVhevUl
 PfAJL1jsKYvWsZvl41NGS4rDEThS3NVgpT8PRjs243xZ8iv5Fgfc+zscLkkDJUj46OQp1
X-Received: by 2002:a17:90b:1d50:b0:35e:599f:aef0 with SMTP id
 98e67ed59e1d1-361404254c0mr41155824a91.11.1777308582849; 
 Mon, 27 Apr 2026 09:49:42 -0700 (PDT)
X-Received: by 2002:a17:90b:1d50:b0:35e:599f:aef0 with SMTP id
 98e67ed59e1d1-361404254c0mr41155785a91.11.1777308582206; 
 Mon, 27 Apr 2026 09:49:42 -0700 (PDT)
Received: from [192.168.0.3] ([49.206.96.228])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fa91d31sm17099169a91.2.2026.04.27.09.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:49:41 -0700 (PDT)
Message-ID: <cd81616a-0d04-4a3e-93a2-b8ab35093ea7@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 22:19:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add partition type GUID support for environment
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Jerome Forissier <jerome.forissier@arm.com>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
 <aeYsA_UOFIg0BZOx@sumit-xelite>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aeYsA_UOFIg0BZOx@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TMFyRdoav8hxSOlb51ve1Ob4iBv1hfVN
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69ef93a7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=mDd7tLh7uscPtaIqipyRMw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=j6C6XyAvxkBI0hqv__UA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: TMFyRdoav8hxSOlb51ve1Ob4iBv1hfVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE3OCBTYWx0ZWRfX2v1eSNA3Qhhb
 hi9a71sIXt4MXZaLdL31TfvZOWqi8+bYIwz3PqlxqtV8oHo/izzOqelGYaPYqqQ2ggnKbrwqadX
 yS8KUQiaANiu+vdciKS3jpmGhQy8/1I/3Zb7YbwgJoqg5Wad52nP2vf4CrJoEuRLGqD+c2pAbUh
 uJlpnO6eanqObrACqX0cFEBUYKfECLSfID16FSt1sJDVyFOPZ7SLfxyyu8C7x5xhf/t1P0hmMVL
 L7RQzifeLUC6FhLoMGzUKleMwZMiYubVj5bvk3sj8UFWr+4KHdKMWFCBR/gn+KIvY5Z905nMoCy
 WYazVfw9KaaTItG3zciLPFkUgA0Oi5WumHerFqeiq2bEJMzlnz22vb2ehc/R9ELZ2QaaE5POPbb
 DEvN0DTCmBZdSGpq3H8kMj4Wkk52Hv+B1XqfHDytHMOl3VKLrtRkSNkK9JOwAe2hp5BEoc4NMJU
 Lr2LSRHVjQoovljrA3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270178
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


On 4/20/2026 7:07 PM, Sumit Garg wrote:
> On Sun, Apr 19, 2026 at 03:54:02PM +0530, Balaji Selvanathan wrote:
>> This series adds support for locating partitions using GPT partition
>> type GUID instead of unique partition UUID. This enables the saveenv
>> command to work with partitions identified by their type rather than
>> unique identifiers, providing flexibility for systems where partition
>> UUIDs may vary across devices but types remain constant.
> Why don't we rather rely on partition name/label instead? That can be
> common across platforms too. I would rather prefer a config fragment for
> eg. UFS based environment or eMMC based environment and so on.
>
> -Sumit

Hi Sumit,

Using type GUIDs as they offer following advantages: they are 
standardized across vendors (e.g., ChromeOS kernel GUID, Linux 
filesystem GUID) unlike arbitrary partition names that vary by OEM or 
firmware version, they are immutable and set at partition creation, 
making them more robust than easily-modified partition names.

Regards,

Balaji

>
>> Patch 1 adds part_get_info_by_type_guid() function support
>> Patch 2 adds scsi_get_blk_by_type_guid() function support
>> Patch 3 adds support for partition type GUID based environment
>> Patch 4 enables partition type GUID configs for QCM6490 and QCS615
>> Patch 5 adds unit test for the partition type GUID lookup functionality
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Addressed minor corrections in Patch 1 in part_get_info_by_type_guid function
>> - Refactor env_scsi_get_part and env_scsi_load functions based
>>    on the choice configs in Patch 3
>> - Add unit test for the partition type GUID lookup functionality in Patch 5
>> - Link to v2: https://lore.kernel.org/u-boot/20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com/
>>
>> Changes in v2:
>> - Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
>> - Introduce a Kconfig choice config to select between UUID-based
>> and type GUID-based partition lookup methods.
>> - Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
>> - Link to v1: https://lore.kernel.org/u-boot/20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com/
>>
>> ---
>> Balaji Selvanathan (5):
>>        disk: Add partition lookup by type GUID functionality
>>        scsi: Add partition lookup by type GUID for SCSI devices
>>        env: scsi: Add support for partition type GUID based environment
>>        configs: Enable partition type GUID for QCM6490 and QCS615 boards
>>        test: dm: Add partition type GUID lookup test
>>
>>   configs/qcm6490_defconfig     |  5 +++++
>>   configs/qcom_qcs615_defconfig |  5 +++++
>>   disk/part.c                   | 37 +++++++++++++++++++++++++++++++
>>   drivers/scsi/scsi-uclass.c    | 28 ++++++++++++++++++++++--
>>   env/Kconfig                   | 51 ++++++++++++++++++++++++++++++++++++-------
>>   env/scsi.c                    | 45 +++++++++++++++++++++++---------------
>>   include/part.h                | 21 ++++++++++++++++++
>>   include/scsi.h                | 11 ++++++++++
>>   test/dm/part.c                | 48 ++++++++++++++++++++++++++++++++++++++++
>>   9 files changed, 223 insertions(+), 28 deletions(-)
>> ---
>> base-commit: e3405917a1806971d9e72a94186b299f05581e1a
>> change-id: 20260419-type-c6a48a1c273d
>>
>> Best regards,
>> -- 
>> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>
