Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4918FCD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B2D8466F;
	Thu, 14 May 2026 19:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVKm1Q8n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N1Wa7r0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC6B84690; Thu, 14 May 2026 19:20:36 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A258464D
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeSaB2554515
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uCT5ktcIKc8oS2PvyzJBOs6M5nW/QxJg/CidzZFF9O8=; b=kVKm1Q8nHBs5KWXs
 wekaSmilTGVquFgeugYqpS0fjXrzfg5GereqSq0+30wrL8ZnIFBtIueiIwz8Fh8o
 hhEiRDGCw3ZmYjIqDSwR4I/i0Jqci1cyy0diaDLzHQbJcFgPCrk3yGWLSP+5Gdvs
 AG/o13M7uo//RCSFGX/aldN7YCbA/YzSkJhcjERcR8xit5iKXyajGanyNDxgPEgx
 f/+B5XStva1rZTgiZJwnCePcgembIKq6W2q713GLGwaRfu1OmBd2HGDGzvoMlxXp
 dRTm4bCsM2FCtg9mtZYMWhUd0lBICVrTKTIgQfBQGbpHGOB+ka1A3lUTCCijXKDW
 qSBvbw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5b0bsxbs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:20:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c82751074c8so7090658a12.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779231; x=1779384031; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uCT5ktcIKc8oS2PvyzJBOs6M5nW/QxJg/CidzZFF9O8=;
 b=N1Wa7r0js8Y1tXwIS/y0XXkEl6wrUHq07gbHOG/emzm0abWP0HIUKGhmW/RvDsmG3A
 jsfiG/1/AL3uOo/TTMDIfl5Rn+J0AgVuVMfPuhrPNj8aRP9cBkUdfuCHFIEK3J0MH6mB
 SvdREGzmuxqLlbVrMYADhbWnUw4x5k46twX3gT5qBhUzTZyFGZ1U8C4IskjTvBBHF7Ds
 b/3OzlHDVo3Y7H/z1+TP5hCpfbj6HEtFZz8MNfOWuAirMWIiIdmjeEWDiFfyVST/L2nQ
 oLu5TJYzjceo0+ztjB0q1ag49ehq35tfLIaa9P2G6vwbICe8D81rDOHA9YBzK79xB97r
 IzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779231; x=1779384031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uCT5ktcIKc8oS2PvyzJBOs6M5nW/QxJg/CidzZFF9O8=;
 b=RiPNrIy9YoVaox7h+dpj/m6JZQNxKk7yev5MHQZ8FGfTvA7WaytERaGS8JR2RdldSX
 woLgkJV6CoPcTKe3bf081j/Tdl8Ufn+r6KG8LcWRwTYG6gYvLHrBaiuo7ic7qRwkYIHa
 XYjNhdlns921P7ZOoV7UtSmuCRAXbFa9dsVV6aLq9yMKz5vA1QA44vaJNSnjX1g7fYcL
 yVTZ9LcAa/8+5QyOG30B+p0eajODog4lEXv31FGmgU7E2XNUEHlgvtsslp87UYcBFrya
 E/XAJa74fxmnTiAkavsGIQTWYQ9gbNPjAlbr610fo5dhqnDSir0vk3RxMbJhbdkqkQZ4
 TnGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xBSqWSR/4kpLG1puOrKrNMwspKy66sRg0Oai7VdC3o77uiONBUOAiRnli9yf6+nXag5LRf50=@lists.denx.de
X-Gm-Message-State: AOJu0YztfEzPc8nPytJhbY1nBahp93eo031mjb6wxYFlkVhQKzha9j7P
 W/GBt6Uq14tKZ9IgS8vvHC/AFvYNhJHOmXfMWcnfNb/n2MlMxS61fl0NtzK0d7Ax6oaRgSIY6j4
 jmq4gCYzc9wSqpjVJ+L5baquFsUo1US1fP0qYvkIcjF2UvNZeBKNf3/6G
X-Gm-Gg: Acq92OGU8qHH1GjxB6oX/nEUVeXeOPn5KNzbxcs3RWCQO7QBOkpLikJA1rvz4mxQi3I
 sxtvwrU8/EtDDaSoLbD1JiccR38iXuVQztJ+/KQ1OP47MSZ7TwUPzEFIguoqfauJbMeGgOdw9MA
 IbUebEKw61hp7gJkW+l8P73mcPY8GvPeObcRU3j/ceADU3NNpCANtgLTpPqoT68tiDNr4Hkz+pb
 Cu4x/fdMTo3ylhakNg5bF3Dde0+dzQv8fDCKBD4ccrRDNRbIUZAt5aNU4taYiXZuZjD74ZST2kT
 HpRvT8APG89aviUXMWhGkQFjpK61rmsoMNw/iUWqYtWf2htbKY6dGe9PvBNYLOWv8Bdm61WpMIm
 hj//0VLotkBDXXq8mCPwEz8kY4/9hJH5xKh415abN0Gg/Q2YL09I5fLZIv7Uv1ORHxVyQKlzAa1
 zggZLeMCI/s640EsI=
X-Received: by 2002:a05:6a20:c995:b0:3aa:ca34:61e8 with SMTP id
 adf61e73a8af0-3b22e7b14c2mr232538637.2.1778779231329; 
 Thu, 14 May 2026 10:20:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:c995:b0:3aa:ca34:61e8 with SMTP id
 adf61e73a8af0-3b22e7b14c2mr232490637.2.1778779230710; 
 Thu, 14 May 2026 10:20:30 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cc9:7562:9801:e130:2c1b:41ff?
 ([2401:4900:1cc9:7562:9801:e130:2c1b:41ff])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19664a59sm3377543b3a.1.2026.05.14.10.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 10:20:30 -0700 (PDT)
Message-ID: <79dc4829-7e2f-4828-b4da-d212a15e8121@oss.qualcomm.com>
Date: Thu, 14 May 2026 22:50:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: Remove authentication header in
 GetVariable()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, michal.simek@amd.com, u-boot@lists.denx.de
References: <20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+tD8eOKxem3m94BWX42GTLuCD7tqEW0GUdtsPLpLcYqw@mail.gmail.com>
 <12a09e02-3093-47a6-850b-3be4e63b1ccb@oss.qualcomm.com>
 <2B0242ED-9FA5-44DA-8324-7D21E692B01A@gmx.de>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <2B0242ED-9FA5-44DA-8324-7D21E692B01A@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3MyBTYWx0ZWRfXxrvPWfzPSeol
 v4Jgc2t99BQ90LZsiZpjRRtaJgP4VNljgiV+dY8p59q9f9WFSlvdNMh2iUo797oiDtJMl6lSaMo
 scv4vbTXsvwSq+dIT06e7Py3vgvl0MjCsqDZo8BWgmyykm9I4pL0MzE3+Yl9fdlaYkd5t+y0jQo
 YihPKEuVsQ9U65s6bN1TQtTip9unUuWFl9uqDSr3wX+9muDUY9+C2DE32j/m5DvOqwqwCwGbkRA
 rGgYpm5hgjSoO+K/48iaJyAQQnL1KV4FLPbUzi5YCx1LkkjIzV+ROh+S5hUFGJkBQWTRUpsZ2xL
 Y2+QOVXp0vEMG/+6yiVexqtYqoIGe/NrTVbVGuH294uHL4FC0rG+KmPr5Qqx+zmYmnip7gh9HVt
 pvkZF4/gUd3bJ1t8x0a7LCQrxRJvLQS4lUB2In9HgDRq8E0fdXtrDPXTzTFZeKR2hjtrh5KVdrY
 2/YXwzgB9EuKK8DmnDA==
X-Authority-Analysis: v=2.4 cv=b+2CJNGx c=1 sm=1 tr=0 ts=6a060460 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ptGB4PJZAAAA:20 a=YfCOm-DyAAAA:8 a=vDnbUhzPtrK8134cYg0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: IhoB59q1xv8jtcjuCehTmHgNEYkW6Xl9
X-Proofpoint-ORIG-GUID: IhoB59q1xv8jtcjuCehTmHgNEYkW6Xl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140173
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

Hi Heinrich,

Submitted the patch[1] for efivar.py to strip the auth header and store 
only the payload.

[1] 
https://lore.kernel.org/u-boot/20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com/

Regards,
Aswin M

On 5/14/2026 5:09 PM, Heinrich Schuchardt wrote:
> Am 14. Mai 2026 13:01:08 MESZ schrieb Aswin Murugan <aswin.murugan@oss.qualcomm.com>:
>> Hi Ilias,
>>
>> We are attempting to pre-seed ubootefi.var created using the *efivar.py* tool for authenticated EFI variables.
>> Currently, efivar.py writes variables including the full authentication descriptor (timestamp + WIN_CERTIFICATE + payload) into ubootefi.var.
> For authorization timestamps we have a field in the variable header in the file format.
>
> We should verify that SetVariable only sets the header field and strips the authentication header to keep the efivar.py and SetVariable in sync.
>
> I think this is done here
> https://github.com/trini/u-boot/blob/36d4c653580824b16574560b21d4401614d8b68e/lib/efi_loader/efi_variable.c#L88
>
> Do you intend to provide a patch for efivar.py?
>
> Best regards
>
> Heinrich
>
>> As per the CI tests shared, it stores the authenticated EFI variables using setenv
>> When authenticated variables are set via U‑Boot using setenv -e -at, the flow goes through SetVariable(), where the firmware:
>>
>> * parses and validates the authentication descriptor
>> * removes the authentication header
>> * stores only the variable payload
>>
>>
>> Due to this mismatch, variables created with efivar.py differ from those created via U‑Boot:
>>
>> GetVariable() returns descriptor + payload instead of payload-only, this leads to inconsistent and non‑compliant variable behavior
>>
>> Fix Proposed:
>>
>> Strip the authentication descriptor within efivar.py during variable write, so that only the payload is stored in ubootefi.var, matching U‑Boot SetVariable() behavior. Please confirm if there are any concerns with this approach.
>>
>> Regards,
>> Aswin
>>
>> On 5/13/2026 11:54 AM, Ilias Apalodimas wrote:
>>> Hi Aswin,
>>>
>>> On Tue, 12 May 2026 at 22:42, Aswin Murugan
>>> <aswin.murugan@oss.qualcomm.com> wrote:
>>>> Currently, efi_get_variable_mem() returns the raw stored format for
>>>> authenticated variables, which includes the EFI_VARIABLE_AUTHENTICATION_2
>>>> descriptor . This causes image authentication failures when reading
>>>> secure boot variables as callers receive wrong data containing
>>>> authentication headers instead of the actual variable payload.
>>> What are 'the callers'? The EFI security related variables are usually
>>> read and consumed by the firmware itself during secure boot. I don't
>>> remember the code on top of my head, but i think we end up storing the
>>> auth info because it also contains timestamps etc.
>>>
>>>> The UEFI Specification Section 8.2.6(EFI_VARIABLE_AUTHENTICATION_2 descriptor)
>>>> explicitly states:
>>>> "The authentication descriptor is not part of the variable data and is
>>>> not returned by subsequent calls to GetVariable()."
>>> We can strip the headers during GetVariable, but you need more changes
>>> apart from the one here. The EFI secure boot tests fail with the
>>> change above [1].
>>>
>>>> This patch implements spec-compliant behavior by detecting variables with
>>>> the EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute and
>>>> stripping the authentication descriptor before returning data to callers.
>>> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30086
>>>
>>> Regards
>>> /Ilias
>>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>>> ---
>>>> Changes in v2:
>>>> - Enhanced commit message with explicit UEFI spec reference
>>>> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
>>>> ---
>>>>    lib/efi_loader/efi_var_mem.c | 44 +++++++++++++++++++++++++++++-------
>>>>    1 file changed, 36 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
>>>> index 8d5f99f4870..edf4522e51f 100644
>>>> --- a/lib/efi_loader/efi_var_mem.c
>>>> +++ b/lib/efi_loader/efi_var_mem.c
>>>> @@ -336,9 +336,10 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>>>>                        u32 *attributes, efi_uintn_t *data_size, void *data,
>>>>                        u64 *timep, u32 mask)
>>>>    {
>>>> -       efi_uintn_t old_size;
>>>> +       efi_uintn_t old_size, var_data_size;
>>>>           struct efi_var_entry *var;
>>>>           u16 *pdata;
>>>> +       void *var_data;
>>>>
>>>>           if (!variable_name || !vendor || !data_size)
>>>>                   return EFI_INVALID_PARAMETER;
>>>> @@ -362,19 +363,46 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>>>>           if (!u16_strcmp(variable_name, vtf))
>>>>                   return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
>>>>
>>>> +       for (pdata = var->name; *pdata; ++pdata)
>>>> +               ;
>>>> +       ++pdata;
>>>> +
>>>> +       var_data = (void *)pdata;
>>>> +       var_data_size = var->length;
>>>> +
>>>> +       /* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS */
>>>> +       if (var->attr & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) {
>>>> +               if (var_data_size > sizeof(struct efi_time)) {
>>>> +                       struct efi_time *timestamp;
>>>> +                       struct win_certificate_uefi_guid *cert;
>>>> +                       efi_uintn_t auth_size;
>>>> +
>>>> +                       timestamp = (struct efi_time *)var_data;
>>>> +                       cert = (struct win_certificate_uefi_guid *)(timestamp + 1);
>>>> +                       auth_size = sizeof(struct efi_time) + cert->hdr.dwLength;
>>>> +                       if (var_data_size > auth_size) {
>>>> +                               var_data = (u8 *)var_data + auth_size;
>>>> +                               var_data_size -= auth_size;
>>>> +                       }
>>>> +               }
>>>> +       }
>>>> +       /*
>>>> +        * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS type is old & not
>>>> +        * expected for auth variables
>>>> +        */
>>>> +       else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
>>>> +               return EFI_INVALID_PARAMETER;
>>>> +
>>>>           old_size = *data_size;
>>>> -       *data_size = var->length;
>>>> -       if (old_size < var->length)
>>>> +       *data_size = var_data_size;
>>>> +
>>>> +       if (old_size < var_data_size)
>>>>                   return EFI_BUFFER_TOO_SMALL;
>>>>
>>>>           if (!data)
>>>>                   return EFI_INVALID_PARAMETER;
>>>>
>>>> -       for (pdata = var->name; *pdata; ++pdata)
>>>> -               ;
>>>> -       ++pdata;
>>>> -
>>>> -       efi_memcpy_runtime(data, pdata, var->length);
>>>> +       efi_memcpy_runtime(data, var_data, var_data_size);
>>>>
>>>>           return EFI_SUCCESS;
>>>>    }
>>>> --
>>>> 2.34.1
>>>>
