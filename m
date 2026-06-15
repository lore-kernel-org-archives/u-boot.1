Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE7DCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F4F848C5;
	Mon, 15 Jun 2026 14:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cbfo7TE5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I2loCxr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D56C84704; Mon, 15 Jun 2026 10:59:14 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB2E83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 10:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6KxfO3888466
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ANmb6/wz5ziRiGJR0bHB9oEez+cd1svkAzD3buRTWSA=; b=cbfo7TE5d0WUevfT
 NlkV36Lkr/BrqoK9p/I86YkrPta9tdxEeQYrxLds+ukVGOMRTpYZ1NxaTRau2yJ6
 nKa22IGazVZXLeAhJKSOtnexl+TTmFpZy5t9aQwZrwUK9U36T/RuHfDtyDBrazy7
 n/YezHlQb2twXh+ZaPcgtxvcmL/vwKcpGJntGSq5AS4om4PW3CGPoZDQJEwvGvdb
 eJxWHqyf+WMla/pm2plwKrDGffhaT6+fqn0MN+Yo6LXEgw6zDGNXMA0eSceJwcWx
 OB7MG+Aa182WIjSQ8dStWf5hHdFkBGrRkTlne/e6GCbY3BfRVZoE6Oc8FhlQvpU1
 R1kgOA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery8wxj2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:59:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85a2cde332so1459692a12.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781513948; x=1782118748; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ANmb6/wz5ziRiGJR0bHB9oEez+cd1svkAzD3buRTWSA=;
 b=I2loCxr1IK8PhlSjVPZvlxh5O6itwbRk4pJj1uhj9XH50OG13tol98IwjvFcrXrhwl
 SuDw27h79m0CUR4ZNQMPUSA6yzDQ8znaq7yqjfc4x/kqCIif3ftnoKqyw7XkIjJMyEfq
 mFLenp0opC22OlgLzrqfBS+IF5w1Q4sbbpfNKMGt/D803mamjGvQjOI6h1kwiRD1I92U
 NaR6DIYgl9JBg2DWWDigSgt41G3/RyiTc3SboVKhP+RMMhpG/MMvVC0GxKWn5m56YNR+
 4/w6JSjVq2Zi6GOrhZa7tRJYTly/bvuyAByhmUxfDLvsH2AvW5lRkBey4YGkZ/HLJKuu
 mhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781513948; x=1782118748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ANmb6/wz5ziRiGJR0bHB9oEez+cd1svkAzD3buRTWSA=;
 b=kje1XHHBu2D9gYPmaEJEgOhww+BwRRn48epakMe4AKTAerIRhAgndoDVNx0ztLRkkT
 uSMuikq2qbXrDsiBSOiI9wBPvcT6OZCZgjAkvwPe+fXzVH7/ze4FjMX21qY9/OXxlB1l
 RKxHNvQVrJrCdB1yxAyBjvMlhPJDHKYXMao6TlUkM8lBGcZGJ3GY/Po3NU9H8YRD1TMo
 oR9x3v5B0EaeWSFpDAMg0JRxM2XDoatj7pkOmVLeHcnX60aWX3eqaC9a7GJKEPXMbNnP
 Qr7WURMhUYqGXqHiQCTXXv3vwdz+yo3p5x4fvtARSGHmNGREJc1lChYJY3JsXhAFzgVh
 K5jw==
X-Gm-Message-State: AOJu0Yw1xrZ3qvAsm2owGfODxN8lmc6hVc329YeKgWGhIvdhWMoomTrI
 mh3Zf3SLDIHXIUKqOQ8/IOSZNZo6n6i3ISC4gjDJJSQ8dcXpxzuiDLyc/Zpylz/KAE9lx9YJvdn
 W1vJ29Z1ni95S38O1ZyGfnk+i8N9yX2hGRU2EnfQx190FIcdNQgfIdwwo
X-Gm-Gg: Acq92OHZJ6vOW14Byr+AjtkfNiWkPlu2e5LB6LSLqZtyz5p+wjkpLHET0+Ra3zfNe6M
 ummbAaCoIV/CCUBPAz1/TcsEMdRTmY47/CS3O03S71qIliDIZXR+0oZLpxBlkEQ92nd12BGAq5x
 0K2ssGyLGEx/tIOf17mFuLnJvpbmrxRKlaTgGETWgHbaXQrmfUGnLILAW8RWUWR+Xtb90b/5ZOo
 cp4UOCe0pQqYP/UCk8ts2uJViIVxpGg/5D8Pt/3oDRGRNa9PtcVzGimjima8WzvPjtIuFzmNWDw
 JxS17mxip39SBCKQKhDSoJ+qrKk8ovOLsWYGdLNbSl07oKqQd5sxKyY0x9adk4h8l5s5ms5EZou
 Se+D+tcbWcoomjmtymUB2uBiLWtzh3MH83CHmcatRtWU77GSiwJ+ayOW4iXk=
X-Received: by 2002:a05:6a20:9f48:b0:3b4:8566:1ca4 with SMTP id
 adf61e73a8af0-3b783b30e0dmr15389373637.7.1781513948510; 
 Mon, 15 Jun 2026 01:59:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f48:b0:3b4:8566:1ca4 with SMTP id
 adf61e73a8af0-3b783b30e0dmr15389341637.7.1781513947903; 
 Mon, 15 Jun 2026 01:59:07 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8665186d98sm8125677a12.16.2026.06.15.01.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 01:59:07 -0700 (PDT)
Message-ID: <226603a9-98cc-4935-a708-565a4af65554@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:28:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] spl: ufs: add SPL_UFS_FS Kconfig and filesystem
 boot stub
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
 <20260606-spl_ufs-v2-4-72fed24ef01b@oss.qualcomm.com>
 <aiqcF4MfSQUmB7Zi@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aiqcF4MfSQUmB7Zi@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ywVPgk1PuZeEEudDcKfveVfpz7cEa6wH
X-Proofpoint-GUID: ywVPgk1PuZeEEudDcKfveVfpz7cEa6wH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NCBTYWx0ZWRfXyoVtv9ehwMsa
 RoZlaVc6XaQyTp6aki9TJL1Ns7NShSQ1W8d8LiaHwQ+3AB+33nQZjjhR00keb0d1y0/S3rKZ7mT
 P69rlWZL/sNDRQMmhLXy8lEO19p489M=
X-Authority-Analysis: v=2.4 cv=IqAutr/g c=1 sm=1 tr=0 ts=6a2fbedd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IMfkktUswe34qO0IiugA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NCBTYWx0ZWRfX/NfvBXfgZL/U
 X2JyQLlCKF2MV21zFdyxBNMT9siv7WnI3L6KYqQ0SHz/Yov2H52hIOZlGHOf0XB6jj4dOZlIaak
 h9UQSQLEtMgyRGMqMFFQy9QRINeIDEf9fBi4VGUNG1cuOk9CjJi3MWwZ4VPvRZRUl8/FjWpwDTQ
 IMTmPAr9i4ZWo7WVNbG+HX/mLNSDvZNvU9PE3ioLpkVfpovLFUe/nZI0BaSVUI3rglqEudOQMjA
 63fVWVs8KyhIxBmoZ9zg0wyhbJmih33L7XkbVs5xd2/lsJIyGucAX60uf8nF7QQyF7px+DwFG3Z
 IEGQjqD6YTFBFJy+o3HzGFNzAiLygQDTPbAU6ZSCO5dNOa1mIPB/oBhEmLkVUnSSwCDjzly8QF0
 i8jEZu+toN8fCr5hg25fay54d8HmeKk48ecljJyBM1oOkwFHmwgTEG6pcz4/pBJ8IOlOamW2XQ8
 +mcKrcLWheAjpQCjeug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150094
X-Mailman-Approved-At: Mon, 15 Jun 2026 14:45:05 +0200
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

Hi Varada,

On 6/11/2026 4:59 PM, Varadarajan Narayanan wrote:
> On Sat, Jun 06, 2026 at 03:48:35PM +0530, Balaji Selvanathan wrote:
>> Add a new SPL_UFS_FS Kconfig option to enable filesystem-based boot
>> from UFS (FAT or EXT4). When selected, a UFS_MODE_FS case is added
>> to the boot-mode switch in spl_ufs_load() raw mode on failure.
>>
>> The filesystem path is currently a stub that
>> returns -ENOSYS, serving as a placeholder for future implementation.
> Is this really needed? Can't this be added along with the actual support.

Removed as suggested in v3: 
https://lore.kernel.org/u-boot/20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com/

Thanks,

Balaji

>
> -Varada
>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Added the filesystem support in SPL UFS as a seperate patch
>> ---
>> ---
>>   common/spl/Kconfig   | 10 ++++++++++
>>   common/spl/spl_ufs.c |  9 +++++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 82b757d1efa..8609f08413b 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1682,6 +1682,16 @@ config SPL_UFS_RAW_U_BOOT_PARTITION_NUM
>>   	  with partition support. This is used if partition name is not
>>   	  specified or not found.
>>
>> +config SPL_UFS_FS
>> +	bool "Enable UFS filesystem boot mode"
>> +	depends on SPL_UFS
>> +	help
>> +	  Enable filesystem-based boot from UFS. This allows loading
>> +	  U-Boot from FAT or EXT4 filesystems on UFS partitions.
>> +	  This is tried as a fallback if raw mode loading fails.
>> +
>> +	  Note: Filesystem support is not yet fully implemented.
>> +
>>   config SPL_WATCHDOG
>>   	bool "Support watchdog drivers"
>>   	imply SPL_WDT if !HW_WATCHDOG
>> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
>> index 0590b796267..8a60948a304 100644
>> --- a/common/spl/spl_ufs.c
>> +++ b/common/spl/spl_ufs.c
>> @@ -142,6 +142,15 @@ int spl_ufs_load(struct spl_image_info *spl_image,
>>   			return 0;
>>   #endif
>>   		break;
>> +#ifdef CONFIG_SPL_UFS_FS
>> +	case UFS_MODE_FS:
>> +		debug("spl: ufs: boot mode: fs\n");
>> +
>> +		/* TODO: Implement filesystem support */
>> +		printf("spl: ufs: filesystem boot not implemented\n");
>> +		ret = -ENOSYS;
>> +		break;
>> +#endif
>>   	default:
>>   		puts("spl: ufs: wrong boot mode\n");
>>   	}
>>
>> --
>> 2.34.1
>>
