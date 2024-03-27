Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0435CCD1280
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 15:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2853588054;
	Wed, 27 Mar 2024 16:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="E9VjQr+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCC6880C5; Wed, 27 Mar 2024 16:22:53 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DCB87F28
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 16:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eajames@linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42REhUu8001675; Wed, 27 Mar 2024 15:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r+woKHFkvrt/T1EIlyiAPD0MmzW20HPkVy1H0GMVlgE=;
 b=E9VjQr+zsLsAj79N2h6GrAliErsAoN74kHQARgU3efvo8uU2fDtJBYyDFsDIKX66vx5r
 bIpQt74cSeLJD+OZJGdEppn3g6BPhriisz9ucsWUZwRtWtYMKAJDeojQY+mJEcHuK6fF
 O1A/brNOGVJqGo43tiWemLZ2OsT/RcRli1hNusUh5PPLQaxG0T+hpb+FHVh+sJHvwBx/
 0cEZgSzdzcoZWwZRfrnQ2MSje7q/QdYEGuPD7hXeOu11TAObGBF5tH0C1VjYNLNLm0Km
 ZjbU/nQsKSjmigwKUNviRWJRyNb2S3S2a+1kmxGmvpySy1zF5ICqcbpTQSbGKf9q41LF +Q== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4nf7r3f0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 15:22:47 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42RD7bDU012991; Wed, 27 Mar 2024 15:22:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0qkcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Mar 2024 15:22:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42RFMitj26346200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 15:22:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04D4758069;
 Wed, 27 Mar 2024 15:22:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DBF958052;
 Wed, 27 Mar 2024 15:22:43 +0000 (GMT)
Received: from [9.61.112.116] (unknown [9.61.112.116])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2024 15:22:43 +0000 (GMT)
Message-ID: <afab8b1e-ad41-47fc-ad76-383151f4caf2@linux.ibm.com>
Date: Wed, 27 Mar 2024 10:22:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tcg2_platform_get_log failing to read address and size of
 memory-region via ofnode_get_addr_size
To: Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Ruchika Gupta <ruchika.gupta@linaro.org>, Samuel Lee <slee@gateworks.com>
References: <CAJ+vNU12-4EJN_RPGPPTfTVden2=beq-XaeFL=dF7t+AAqje=Q@mail.gmail.com>
 <CAC_iWj+B0r7o8Hwi_KZM=+L9t6=THH=pzY38jrcDDdAntWT3Rw@mail.gmail.com>
 <CAJ+vNU0380ved3FWt_R4UVR3stFrb3B4dLTx=m6dp0377MK6hQ@mail.gmail.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAJ+vNU0380ved3FWt_R4UVR3stFrb3B4dLTx=m6dp0377MK6hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R9DmDDOjbguZVgkKPVNNyRkeNYEt6OTh
X-Proofpoint-ORIG-GUID: R9DmDDOjbguZVgkKPVNNyRkeNYEt6OTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_12,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270105
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


On 3/26/24 11:15, Tim Harvey wrote:
> On Tue, Mar 26, 2024 at 2:24 AM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>> Hi Tim,
>>
>> On Tue, 26 Mar 2024 at 03:15, Tim Harvey <tharvey@gateworks.com> wrote:
>>> Greetings,
>>>
>>> I'm unable to understand why tcg2_platform_get_log is failing to read
>>> a memory region.
>>>
>>> For example the following diffs:
>> I am not really sure what those nodes are supposed to do in sandbox.
>> Pehaps Eddie remembers.
>> What exactly are you trying to achieve here? Read the eventlog from TF-A?
>>
> Hi Ilias,
>
> I was trying to get measured boot (CONFIG_MEASURED_BOOT=y) working on
> a tpm on my board but ran into an issue when I couldn't get the
> memory-region I added for testing to be recognized with the current
> code in tcg2_platform_get_log().
>
> I wonder if an event log should be required for measured boot - it
> sounds like that was something required for EFI, so I was thinking of
> submitting the following:
> commit b3f336c2f863168219a93cd1c7ac922396e0fad5 (HEAD -> master-venice)
> Author: Tim Harvey <tharvey@gateworks.com>
> Date:   Tue Mar 26 08:49:07 2024 -0700
>
>      tpm: allow measured boot without an event log
>
>      Currently an event log is required for measured boot. Remove this
>      requirement.
>
>      Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 68eaaa639f89..994f8089ba34 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -175,17 +175,19 @@ static int tcg2_log_append_check(struct
> tcg2_event_log *elog, u32 pcr_index,
>          u32 event_size;
>          u8 *log;
>
> -       event_size = size + tcg2_event_get_size(digest_list);
> -       if (elog->log_position + event_size > elog->log_size) {
> -               printf("%s: log too large: %u + %u > %u\n", __func__,
> -                      elog->log_position, event_size, elog->log_size);
> -               return -ENOBUFS;
> -       }
> +       if (elog->log_size) {
> +               event_size = size + tcg2_event_get_size(digest_list);
> +               if (elog->log_position + event_size > elog->log_size) {
> +                       printf("%s: log too large: %u + %u > %u\n", __func__,
> +                              elog->log_position, event_size, elog->log_size);
> +                       return -ENOBUFS;
> +               }
>
> -       log = elog->log + elog->log_position;
> -       elog->log_position += event_size;
> +               log = elog->log + elog->log_position;
> +               elog->log_position += event_size;
>
> -       tcg2_log_append(pcr_index, event_type, digest_list, size, event, log);
> +               tcg2_log_append(pcr_index, event_type, digest_list,
> size, event, log);
> +       }
>
>          return 0;
>   }
> @@ -613,10 +615,8 @@ int tcg2_measurement_init(struct udevice **dev,
> struct tcg2_event_log *elog,
>                  return rc;
>
>          rc = tcg2_log_prepare_buffer(*dev, elog, ignore_existing_log);
> -       if (rc) {
> +       if (rc)
>                  tcg2_measurement_term(*dev, elog, true);
> -               return rc;
> -       }
>
>          rc = tcg2_measure_event(*dev, elog, 0, EV_S_CRTM_VERSION,
>                                  strlen(version_string) + 1,
>
> Would you agree with removing the requirement for the event log?


No, the log is required, otherwise it's fairly meaningless work. You 
need the log in your OS to verify the contents of the TPM.

Here is the device tree reserved memory stuff we're using, perhaps it 
will help.

diff --git a/arch/arm/dts/ast2600-p10bmc.dts 
b/arch/arm/dts/ast2600-p10bmc.dts
index 1d0f88bf96..8fbfeaa0d7 100755
--- a/arch/arm/dts/ast2600-p10bmc.dts
+++ b/arch/arm/dts/ast2600-p10bmc.dts
@@ -13,6 +13,17 @@
                 reg = <0x80000000 0x40000000>;
         };

+       reserved-memory {
+               #address-cells = <1>;
+               #size-cells = <1>;
+               ranges;
+
+               event_log: tcg_event_log@b3d00000 {
+                       no-map;
+                       reg = <0xb3d00000 0x100000>;
+               };
+       };
+
         chosen {
                 stdout-path = &uart5;
         };
@@ -113,6 +124,7 @@
         tpm@2e {
                 compatible = "nuvoton,npct75x";
                 reg = <0x2e>;
+               memory-region = <&event_log>;
         };
  };


>
> I have another question that perhaps you may have some feedback on.
> The tpm commands such as pcr_extend, pcr_read currently require a
> 32-byte SHA256 digest and I wish to extend that as my TPM supports
> only SHA1. The tpm2_pcr_extend and tpm2_pcr_read functions were
> extended to  function to allow the digest type and length to be passed
> in and I'm wondering what the best way to extend the tpm extend/read
> commands would be to support that.
>
> The tcg2_create_digest function creates a digest based on the
> capabilities of the tpm and the tcg2_pcr_extend loops over those
> calling tpm2_pcr_extend for each digtest supported (and same for
> tcg2_pcr_read looping over tpm2_pcr_read) and I'm assuming TPM's can
> support multiple algos so I suppose a parameter needs to be added to
> the pcr_read and pcr_extend commands. Would you agree with that?
>
> Best Regards,
>
> Tim
>
>> Thanks
>> /Ilias
>>> diff --git a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
>>> b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
>>> index 7b2130dbdb21..57b3c227ceaf 100644
>>> --- a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
>>> +++ b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
>>> @@ -112,6 +112,7 @@
>>>                  compatible = "tcg,tpm_tis-spi";
>>>                  reg = <0x1>;
>>>                  spi-max-frequency = <36000000>;
>>> +               memory-region = <&event_log>;
>>>          };
>>>   };
>>>   diff --git a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
>>> b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
>>> index c305e325d007..697fd1148785 100644
>>> --- a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
>>> +++ b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
>>> @@ -13,6 +13,17 @@
>>>                  reg = <0x0 0x40000000 0 0x80000000>;
>>>          };
>>>
>>> +       reserved-memory {
>>> +               #address-cells = <2>;
>>> +               #size-cells = <2>;
>>> +               ranges;
>>> +
>>> +               event_log: tcg_event_log {
>>> +                       no-map;
>>> +                       reg = <0 0x40000000 0x2000>;
>>> +               };
>>> +       };
>>> +
>>>          gpio-keys {
>>>                  compatible = "gpio-keys";
>>>
>>> And at runtime:
>>> u-boot=> fdt addr $fdtcontroladdr
>>> u-boot=> fdt list /soc@0/bus@30800000/spba-bus@30800000/spi@30830000/tpm@1/
>>> tpm@1 {
>>>          compatible = "tcg,tpm_tis-spi";
>>>          reg = <0x00000001>;
>>>          spi-max-frequency = <0x02255100>;
>>>          memory-region = <0x00000025>;
>>> };
>>> u-boot=> fdt list /reserved-memory/
>>> reserved-memory {
>>>          #address-cells = <0x00000002>;
>>>          #size-cells = <0x00000002>;
>>>          ranges;
>>>          tcg_event_log {
>>>          };
>>> };
>>> u-boot=> fdt list /reserved-memory/tcg_event_log
>>> tcg_event_log {
>>>          no-map;
>>>          reg = <0x00000000 0x40000000 0x00002000>;
>>>          phandle = <0x00000025>;
>>> };
>>>
>>> So why does the following code in tcg2_platform_get_log() return -ENOMEM?
>>>
>>>                  if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
>>>                                                 0, &args))
>>>                          return -ENODEV;
>>>
>>>                  a = ofnode_get_addr_size(args.node, "reg", &s);
>>>                  if (a == FDT_ADDR_T_NONE)
>>>                          return -ENOMEM;
>>>
>>> debugging shows that dev_read_phandle_with_args returns non-zero but
>>> args.args_count is 0.
>>>
>>> I feel like the construct of using dev_read_phandle_with_args followed
>>> by the ofnode_get_addr_size is just wrong but I don't understand why
>>> nor do I understand how my dt changes differ from what is in
>>> arch/sandbox/dts/test.dts (other than its using address-size=1 which
>>> doesn't appear to be the issue in my testing). The abstraction of the
>>> ofnode and fdt stuff always trip me up... very confusing.
>>>
>>> Can anyone explain the issue here?
>>>
>>> Best Regards,
>>>
>>> Tim
