Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409A4C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F8587AC6;
	Wed, 25 Oct 2023 15:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="jFJ+rNXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD8E087AC7; Wed, 25 Oct 2023 15:54:00 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5FBA87AC5
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PDkuaP016799; Wed, 25 Oct 2023 13:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hjjvvkt3NR+Wc/uEEFtfpLOerphy8o6C0eEYfFwsggQ=;
 b=jFJ+rNXlx7sYJrVcLNoZqUYjam2YKvDnCjMw5CK+zreRVtGLgMhpKVg44Z9xn456glH+
 cx1/ui/GO9baB9bNSK0gSsjWsPv0ZGvn8gawvvP+20cI2SdQH4zpaLfFWmUCaXXi88f0
 AXwK+gU/gl8+9SONjWhcbT74yewV6Nb5QriuJmbYuuKn7C61lGfDq8885IOelC1auCz/
 hT3PO3QgbGHowSjhV2j+bvV1dm8FsGfOOFPtwVR/zoVvneWTRS/dk2H6OCLlxR/uhUu0
 eg+CPCzIgG8M80b1Dj5C1cs2+I/B2bkGmlvNb5UG1G1tHz6/0Gv9mgCh6rvkkTY4LOwV wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty47287yg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Oct 2023 13:53:52 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39PDl2eN017209;
 Wed, 25 Oct 2023 13:53:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty47287xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Oct 2023 13:53:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39PD1L5W010231; Wed, 25 Oct 2023 13:53:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyq5x0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Oct 2023 13:53:50 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39PDroYu25756300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Oct 2023 13:53:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E961E58063;
 Wed, 25 Oct 2023 13:53:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C92F858061;
 Wed, 25 Oct 2023 13:53:49 +0000 (GMT)
Received: from [9.61.58.37] (unknown [9.61.58.37])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Oct 2023 13:53:49 +0000 (GMT)
Message-ID: <bb72d456-bcb7-10d5-5ba2-1d5e1acc26f3@linux.ibm.com>
Date: Wed, 25 Oct 2023 08:53:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v14 4/8] bootm: Support boot measurement
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de
References: <20231024154354.197524-1-eajames@linux.ibm.com>
 <20231024154354.197524-5-eajames@linux.ibm.com>
 <CAC_iWj+3ww08s=FnSFeAQW_tOFw3GL9pc_=MuvhrmDxDxGZe1Q@mail.gmail.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAC_iWj+3ww08s=FnSFeAQW_tOFw3GL9pc_=MuvhrmDxDxGZe1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IN1ySRuYgtNpwAAXlQZgvUlWbV2lx3Ty
X-Proofpoint-ORIG-GUID: epRFSQM4XJH-yHZ1OpuAp-pHHHeAvbHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxlogscore=958
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250120
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


On 10/25/23 07:41, Ilias Apalodimas wrote:
> On Tue, 24 Oct 2023 at 18:44, Eddie James <eajames@linux.ibm.com> wrote:
>> Add a configuration option to measure the boot through the bootm
>> function. Add the measurement state to the booti and bootz paths
>> as well.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> Changes since v8:
>>   - Added a configuration option to select to ignore any existing
>>     event log. This would only be selected for systems that know
>>     that U-Boot is the first stage bootloader. This is necessary
>>     because the reserved memory region may persist through resets
>>     and so U-Boot attempts to append to the previous boot's log.
>>
>> Changes since v6:
>>   - Added comment for bootm_measure
>>   - Fixed line length in bootm_measure
>>
>>   boot/Kconfig    | 32 +++++++++++++++++++++
>>   boot/bootm.c    | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   cmd/booti.c     |  1 +
>>   cmd/bootm.c     |  2 ++
>>   cmd/bootz.c     |  1 +
>>   include/bootm.h | 11 ++++++++
>>   include/image.h |  1 +
>>   7 files changed, 122 insertions(+)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index a01e6cb8aa..abbc72f4cf 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -685,6 +685,38 @@ config LEGACY_IMAGE_FORMAT
>>            loaded. If a board needs the legacy image format support in this
>>            case, enable it here.
>>
>> +config MEASURED_BOOT
>> +       bool "Measure boot images and configuration to TPM and event log"
>> +       depends on HASH && TPM_V2
> I know Simon reviewed this already, but don't we need to add !EFI here?
> UEFI already supports measurements via the TCG protocol implementation.
> But since EFI is 'default y' nowadays anyone minds if I change the
> help & bool messages during merge?
> Something along the lines of
> bool "Measure boot images and configuration to TPM and event log when
> booting without EFI"


Oh right, yes, go ahead, that sounds good, thanks.

Eddie


>
> [...]
>
> Thanks
> /Ilias
