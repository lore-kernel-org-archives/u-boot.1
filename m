Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A87CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB348482E;
	Thu, 21 May 2026 20:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3S/rF+B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O0oX0hJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84CA84837; Thu, 21 May 2026 20:31:57 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAEC84825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGmCuS186589
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SddRHdG3hz2DwD7bobRYtHOjU7IzR3Ompq4Lj1l9oMk=; b=M3S/rF+BUP/wg304
 BbqpKVLGQ9CzbAanxTqH8FHdoKRoFkm3ep7RZELBQR+tb2PCtG6dQrOG48zVVaWG
 sDmuifM/uDgw9CkcyNs2pF5bYAzar+oK4k71qN6sG+slXNfbKb3kUSDGieL9K9fY
 s7O1/oGMIJ2UZi6iTaYQpqWqFy1zeMDVIHcN5Px6XLdhzUY0/ob3HySIcZNGgCgx
 Cvn2JBMP1OjdbC2YDNT87AhnIf0opykzbFiSyTBSeeujggu3o6JPWTIFKLb++AZv
 Ys8COAI6Iz19ahBIHwahxgy1mr+c915CwUVpTiOfDPNB9XKkRP0KeWLB5LRHMW3J
 LXJ/kg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahtuak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:31:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba15e384c7so44290495ad.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779388312; x=1779993112; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SddRHdG3hz2DwD7bobRYtHOjU7IzR3Ompq4Lj1l9oMk=;
 b=O0oX0hJ8PHdIb7B8WpbqAKxb3hkEENREeKMvXaCChxPY9m1YcjPhyinUzogUcSDCFr
 M/qp6mB1stOdtNOZSVniPkUFtbBfh7oTbF9Ug4d6x21YIQWOxknOj06lKi44fh6ovDkp
 byuFtV+/okzjEkSyi1v2g04rIYr1ccenjSR3jNRPY84YmW+Uety+DW0qVJBYQmQO3OWT
 1FwN49LV7nTxvdX/uHgdxa20lHBVJ50YN282WvZcMXGJSoA7MNdhAzawLdmlJhj2chVG
 BL1FS3njTu0HNe+d+GJWACt/13kkhlCiXstdXrQNsCa4YfPyYYEnmDH1eCOO+xoIp//g
 Vw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779388312; x=1779993112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SddRHdG3hz2DwD7bobRYtHOjU7IzR3Ompq4Lj1l9oMk=;
 b=QOGjPyaXAujNKY+RmG3B+5ZPdzC5F4fF7ucpNkBdCEi+DFQZVtpoyb0mVze8vTv+E+
 +zgx+tMDOqYRd9k+arjj8FTIPYkvnoZT+nUPa+iP64oLCulKC6SPHLns5aC/zg+go6Qy
 Aur0mTR7xOhN33kvROgvmfck3qsf047NvOLYvbnlsjF1u7ceNkjAFaudWo08PU70dvvB
 wvJqAf8ccZHSHcFMk7pKlgVvmO70qLyVRX++RhEcXM36tp5Wc+vcXc4fGcdptxRxJHeg
 Z5rhfDyAVTVBZa92F/Mbf3fvsmWOCXpshrIH0LnM+RwxUXKrQ1SWhy5qLW9D11IPf54Z
 g1GQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rkl1EGuRYAfj0Z+8P3Noc02m2rS1qkoBdAAiozg+iNjH3uqRfSfyTi+6DL/MreXhsZacdOpo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3PuNbe2Rc+u4b5IfcekeSXvio3QUVYI8GyybaUkjIJWQZifTp
 icXPeITD+dV0QRa69q1NIjPDgeC+Z+fFaco6qOPgZ7TiU17xhdKQrFyt8J2yR54mebUEWbSc60L
 7EieOTk/x53c6iJBA/IbKbFKKOABybIRYNQu21iuQz5EUtqFf+gExJiT0
X-Gm-Gg: Acq92OGuAHfsKFXMwo/7WgSnHoHsMBJ9uEcme5c1d1Ua++wJbMBdjA6O3bQki8Gc9Q1
 qmoytF5np/7Gh1GXAoTIPHbtwWWlAfBU83uHcjAJfk2G8JPMlFSFshREkRio+R789A/zRxiDkRR
 g0yDfeRnNhM+m6bwrlFt+aZZ4axiulfQkr+FyO3+5FbBEvnV09+Kw8bo/Hce62wo+TIpv8xhvBM
 XQo7tOqRhNoFasaLVxApVieKnT+nEaYfsudRw/vIFbaMF40BhZjW8lf6HNE6Fq/7mLnO8CDXSJr
 w8IuUXX/Gayd54HPD0SPZ6RV/auBHj5h/kqr1T3OGneB+lnDnX5vcFRzj/IOPXhaYfhd/5sshmf
 6LaECDV/aVuqJC3//5XmNTuCIu/vX7BiTMJzJGAR8v0NaIg8Queeu8vJNI0+utDon4YJgw/8Gxx
 XtBCRIdoU0zprHoik=
X-Received: by 2002:a17:902:e78e:b0:2bd:657f:3a1b with SMTP id
 d9443c01a7336-2beb065d2b3mr734375ad.40.1779388312106; 
 Thu, 21 May 2026 11:31:52 -0700 (PDT)
X-Received: by 2002:a17:902:e78e:b0:2bd:657f:3a1b with SMTP id
 d9443c01a7336-2beb065d2b3mr734125ad.40.1779388311580; 
 Thu, 21 May 2026 11:31:51 -0700 (PDT)
Received: from ?IPV6:2401:4900:889f:d7d1:9d00:59b5:dc65:27ea?
 ([2401:4900:889f:d7d1:9d00:59b5:dc65:27ea])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9174954sm16819415ad.16.2026.05.21.11.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 11:31:51 -0700 (PDT)
Message-ID: <932df312-3f26-4966-a313-fd8ac932167f@oss.qualcomm.com>
Date: Fri, 22 May 2026 00:01:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools: efivar: strip auth descriptor for authenticated
 variables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, u-boot@lists.denx.de
References: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+bgFhPbxNH-BqU1fFD0j3wzBE_9FT_kfhZ-r48Ztb7pQ@mail.gmail.com>
 <da733868-79d2-4425-acd1-f1a9ce83feba@oss.qualcomm.com>
 <CAC_iWjK+VL=OCeN+4ZufQMyKv7su+JQ-gic7YMSnt-Ci6xZh-A@mail.gmail.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <CAC_iWjK+VL=OCeN+4ZufQMyKv7su+JQ-gic7YMSnt-Ci6xZh-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4NyBTYWx0ZWRfX7/4wjrBe02at
 b2yl8TG0A/2pZCoP4qX1q0SzTTGEEmb0K2RPBtIBaf5lBVmW6Osp8jGBOHlc7tjsyaXrvKwfVt7
 hbUIjrUG/mTXauDrIsufpktCgq+NRpgjpYx8Mt4QuZhu0FPgNnzr9fP4lZv5ltDUghfwJyRoO4t
 NC4RWssAH+o1eYhWnEeL/sbwDkKGt1TOxR6MlHWCZ/TLA6E36mAD2wL1bzmRx9Q3hRqyKPiUtLu
 WxCP+3yWWoBCfrdRzO+i1/r71EwrLW01lz/oc2i6Pfa+cRcfKTQEK6vuh4yb6B3BR9EYFfGSDDV
 sgH2L/Iot7OPtOR3PpWNZr5g5+onOYSFzYUthEl5DOKQV0oV1r/vo+oZ0fRjsPi4vIDYN7LAMBW
 fYAglN9etSgof4pBrQA2SAF3OJfzuHQZ01lCH3f693+VQ2j89h2kQOAyK5I80lJsrwFhvGPh7Qn
 Om0Jot7E1RSjcjD8qPA==
X-Proofpoint-ORIG-GUID: nxKYqQSdhArRJWiCy8r-pCbXHU9WQHRG
X-Proofpoint-GUID: nxKYqQSdhArRJWiCy8r-pCbXHU9WQHRG
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f4f99 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bUIQZsnW-MHComvGq3sA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210187
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

Hi Ilias

On 5/18/2026 2:07 PM, Ilias Apalodimas wrote:
> On Fri, 15 May 2026 at 16:17, Aswin Murugan
> <aswin.murugan@oss.qualcomm.com> wrote:
>> Hi Ilias,
>>
>> This change has been verified locally with our setups on qcs615 &
>> QCS9100 SOCs
> Ok I am getting the same error here. How did you produce the final binary?
>
> The only test I am doing here is enable secure boot and variable
> preseed. The generate the preseed with
>
> ./tools/efivar.py set -i ubootefi.var -n pk  -d PK.esl  -t file
> ./tools/efivar.py set -i ubootefi.var -n kek -d KEK.esl -t file
> ./tools/efivar.py set -i ubootefi.var -n db  -d db.esl  -t file
> ./tools/efivar.py set -i ubootefi.var -n dbx -d dbx.esl -t file

Similar steps are followed but instead of .esl we pass .auth file to 
efivar tool and sign the kernel using sbsign

tools/efivar.py set --infile ubootefi.var --name PK --attrs nv,bs,rt,at 
--type file --data PK.auth

tools/efivar.py set --infile ubootefi.var --name KEK --attrs nv,bs,rt,at 
--type file --data KEK.auth

tools/efivar.py set --infile ubootefi.var --name db --attrs nv,bs,rt,at 
--type file --data db.auth

tools/efivar.py set --infile ubootefi.var --name dbx --attrs nv,bs,rt,at 
--type file --data dbx.auth

*sign the images to be verified *

sbsign --key db.key --cert db.crt bootaa64.efi --output bootaa64.efi

sbsign --key db.key --cert db.crt linux-iq-9075-evk.efi --output 
linux-iq-9075-evk.efi

Regards,
Aswin M

>
> Thanks
> /Ilias
>> Regards,
>> Aswin
>>
>> On 5/15/2026 4:02 PM, Ilias Apalodimas wrote:
>>> Hi Ashwin,
>>>
>>> On Thu, 14 May 2026 at 20:17, Aswin Murugan
>>> <aswin.murugan@oss.qualcomm.com> wrote:
>>>> efivar.py currently stores authenticated variables including the
>>>> EFI_VARIABLE_AUTHENTICATION_2 descriptor (timestamp + WIN_CERTIFICATE)
>>>> along with the payload.
>>>>
>>>> When variables are set via U-Boot, SetVariable() validates and strips
>>>> this authentication descriptor before persisting the variable data,
>>>> resulting in only the payload being stored and returned by GetVariable().
>>>>
>>>> This mismatch causes efivar.py-generated stores to differ from U-Boot
>>>> runtime behavior and leads to incorrect GetVariable() results.
>>>>
>>>> Update efivar.py to strip the authentication descriptor and store only
>>>> the payload for authenticated variables, ensuring consistency with
>>>> U-Boot behavior and compliance with UEFI expectations.
>>> The approach is fine, but when I use the tool now to create signatures
>>> and enable secure boot I am getting
>>> => bootefi bootmgr
>>> Getting signature database(db) failed"
>>>
>>> Have you tried a built that worked locally?
>>>
>>> Thanks
>>> /Ilias
>>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>>> ---
>>>> Changes in v3:
>>>> - Previously stripped the authentication descriptor at GetVariable(),
>>>>     now moved to strip it in efivar.py during variable pre-seeding/set.
>>>> Link to v2: https://lore.kernel.org/u-boot/20260512194205.1905069-1-aswin.murugan@oss.qualcomm.com/
>>>>
>>>> Changes in v2:
>>>> - Enhanced commit message with explicit UEFI spec reference
>>>> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-aswin.murugan@oss.qualcomm.com/
>>>> ---
>>>>    tools/efivar.py | 50 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 49 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/efivar.py b/tools/efivar.py
>>>> index 67729fa8505..d248cd868ba 100755
>>>> --- a/tools/efivar.py
>>>> +++ b/tools/efivar.py
>>>> @@ -79,6 +79,50 @@ class EfiVariable:
>>>>    def calc_crc32(buf):
>>>>        return zlib.crc32(buf) & 0xffffffff
>>>>
>>>> +def strip_auth_descriptor(data, attrs):
>>>> +    """
>>>> +    Strip the EFI auth descriptor from authenticated variable data.
>>>> +
>>>> +    This is used during efivar.py-based pre-seeding of ubootefi.var to
>>>> +    match U-Boot SetVariable() behavior, where the authentication header
>>>> +    is consumed during validation and only the payload is stored.
>>>> +
>>>> +    For variables with EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS:
>>>> +    - Input format: [EFI_VARIABLE_AUTHENTICATION_2 | payload]
>>>> +    - Stored format: [payload only]
>>>> +
>>>> +    Auth header size calculation (aligned with U-Boot efi_variable_authenticate()):
>>>> +        auth_size = sizeof(EFI_TIME) + WIN_CERTIFICATE.dwLength
>>>> +
>>>> +    Only the payload portion is retained after stripping the header.
>>>> +    """
>>>> +    if not (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
>>>> +        return data
>>>> +    if not data:
>>>> +        return data
>>>> +
>>>> +    efi = EfiStruct()
>>>> +    if len(data) < efi.var_time_size:
>>>> +        return data
>>>> +
>>>> +    offset = efi.var_time_size
>>>> +    if len(data) < offset + efi.var_win_cert_size:
>>>> +        return data
>>>> +
>>>> +    try:
>>>> +        cert_hdr = struct.unpack_from(efi.var_win_cert_fmt, data, offset)
>>>> +        dwLength = cert_hdr[0]
>>>> +    except struct.error:
>>>> +        return data
>>>> +
>>>> +    auth_size = efi.var_time_size + dwLength
>>>> +    if auth_size <= 0 or auth_size > len(data):
>>>> +        return data
>>>> +
>>>> +    if len(data) <= auth_size:
>>>> +        return b''
>>>> +    return data[auth_size:]
>>>> +
>>>>    class EfiVariableStore:
>>>>        def __init__(self, infile):
>>>>            self.infile = infile
>>>> @@ -172,8 +216,12 @@ class EfiVariableStore:
>>>>                    break
>>>>                offs = loffs
>>>>
>>>> +        if data and (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS):
>>>> +            data = strip_auth_descriptor(data, attrs)
>>>> +            size = len(data) if data else 0
>>>> +
>>>>            tsec = int(time.time()) if attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS else 0
>>>> -        nd = name.encode('utf_16_le') + b"\x00\x00" + data
>>>> +        nd = name.encode('utf_16_le') + b"\x00\x00" + (data if data else b'')
>>>>            # U-Boot variable format requires the name + data blob to be 8-byte aligned
>>>>            pad = ((len(nd) + 7) & ~7) - len(nd)
>>>>            nd += bytes([0] * pad)
>>>> --
>>>> 2.34.1
>>>>
