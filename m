Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A13DCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 16:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C113E8726A;
	Thu, 19 Oct 2023 18:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="lpOhEz3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49FB8749B; Thu, 19 Oct 2023 18:18:29 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4085C86F4B
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 18:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JGHGW7027763; Thu, 19 Oct 2023 16:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HTNy8wfAK0EJvKgzCh9YFhfcdvMUR412J+kQ8lmCyoU=;
 b=lpOhEz3qFWpNDcy5QMkm86Sat7yzVDt75GcqHWDlekYdTFl2Ai9o0jRylnmJhcrnm+ci
 JAZQjPb70sYgWVZXWCu1WS9lg8/rQauZGtwlbLVvmfFW42OoDN+gblp2uUUVVVPeBgTZ
 GWZ+tvavCrSPXC4wd5hWoatqRRgH8TIDSJCFrfItaGwhlLLJTChT3JAyXE/YTOZ+16yc
 qRCB6Hq2mIKr3TK+8EYZRL9voOdn+WxBM9JlGu5PVf3e9mrOVlsEardSoPhSvfl90cr3
 24tsv3Mg8IM/OAYPvApbnPmsHUy8cSd7OATOo4qd9fmojZtcF2Z/qQtKDkDs/WEXIZ67 gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7ud01e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:18:23 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JGHFLj027578;
 Thu, 19 Oct 2023 16:18:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tu7ud01d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:18:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JEHnro020073; Thu, 19 Oct 2023 16:13:21 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6anhwr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Oct 2023 16:13:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39JGDKkg13107960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 16:13:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A80A458058;
 Thu, 19 Oct 2023 16:13:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A3CB58057;
 Thu, 19 Oct 2023 16:13:20 +0000 (GMT)
Received: from [9.61.89.2] (unknown [9.61.89.2])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Oct 2023 16:13:20 +0000 (GMT)
Message-ID: <b0f594be-5969-9869-3698-29d330078370@linux.ibm.com>
Date: Thu, 19 Oct 2023 11:13:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 6/8] doc: Add measured boot documentation
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
References: <20231012144551.679551-1-eajames@linux.ibm.com>
 <20231012144551.679551-7-eajames@linux.ibm.com>
 <CAPnjgZ3ZTwTa3ROfkRZgsVDUkD1MhHBwcoceSGCgKTxeT+Gm+w@mail.gmail.com>
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAPnjgZ3ZTwTa3ROfkRZgsVDUkD1MhHBwcoceSGCgKTxeT+Gm+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QqNE5C6o3Yq8-czUV_utPngStBaU0vLw
X-Proofpoint-ORIG-GUID: YMaU4Rr8Cef1zdbb6XpM93ccORVgoZsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190138
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


On 10/12/23 10:29, Simon Glass wrote:
> Hi Eddie,
>
> On Thu, 12 Oct 2023 at 08:08, Eddie James <eajames@linux.ibm.com> wrote:
>> Briefly describe the feature and specify the requirements.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
> This could use a bit more detail. What pieces are measured? What DT
> binding is used for the TPM? How is the info checked by the OS or
> whatever?


Sure, I'll add a little bit more. The DT binding is described in the 
requirements section.


>
>
>> ---
>>   doc/usage/index.rst         |  1 +
>>   doc/usage/measured_boot.rst | 23 +++++++++++++++++++++++
>>   2 files changed, 24 insertions(+)
>>   create mode 100644 doc/usage/measured_boot.rst
>>
>> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
>> index fa702920fa..fb043a8923 100644
>> --- a/doc/usage/index.rst
>> +++ b/doc/usage/index.rst
>> @@ -14,6 +14,7 @@ Use U-Boot
>>      partitions
>>      cmdline
>>      semihosting
>> +   measured_boot
>>
>>   Shell commands
>>   --------------
>> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
>> new file mode 100644
>> index 0000000000..8357b1f480
>> --- /dev/null
>> +++ b/doc/usage/measured_boot.rst
>> @@ -0,0 +1,23 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +Measured Boot
>> +=====================
>> +
>> +U-Boot can perform a measured boot, the process of hashing various components
>> +of the boot process, extending the results in the TPM and logging the
>> +component's measurement in memory for the operating system to consume.
>> +
>> +Requirements
>> +---------------------
>> +
>> +* A hardware TPM 2.0 supported by the U-Boot drivers
>> +* CONFIG_TPM=y
>> +* CONFIG_MEASURED_BOOT=y
>> +* Device-tree configuration of the TPM device to specify the memory area
>> +  for event logging. The TPM device node must either contain a phandle to
>> +  a reserved memory region or "linux,sml-base" and "linux,sml-size"
>> +  indicating the address and size of the memory region. An example can be
>> +  found in arch/sandbox/dts/test.dts
>> +* The operating system must also be configured to use the memory regions
>> +  specified in the U-Boot device-tree in order to make use of the event
>> +  log.
> Regards,
> Simon
