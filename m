Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5786AC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 09:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC84484942;
	Tue,  7 Jul 2026 11:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YXyd5/PU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JP2Tc1Rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F77E8498C; Tue,  7 Jul 2026 11:57:30 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A809C846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 11:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678DlBt3182161
 for <u-boot@lists.denx.de>; Tue, 7 Jul 2026 09:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DaqVFVHznL31EyOplamlzakvBKWEB+lr+paAB2x0hMg=; b=YXyd5/PUr2OwdyM/
 90h/JQQWLY+gPmdHg3Xaf7mD2Jw/+50G/PI4S14mEQQRI4arKNMDjgEGFEaepxqJ
 yPMDSVg8cn/5JGG/SxqtpA8OcM0dGI/an8yPW307qRMhLXPCTC8/x+1jPw0XmuxS
 7TSjHroC8S/PmstQaZt9+0qb/8l1mSEyCgmlcvsqbTzfWuwDm+Djvpu6A8Gakh0F
 P/cnN893TzxMy5RlQEGg71ixRQAHWf/TnKs1NmdeeWK0ok6DkxDO+Yj0Gkdv7drs
 FyPDy4eiphcQ1ht0VOF+oQJUfbVovC98o+IHo7pm4JpazdkYEa686y0drrL2aWTB
 3un7cw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t8vk2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 09:57:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9aa197d5easo686569a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783418245; x=1784023045; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DaqVFVHznL31EyOplamlzakvBKWEB+lr+paAB2x0hMg=;
 b=JP2Tc1RtO5CUfaVFJ2AVW/0GKapMfBSJYfdMUm4DLR+sma1yc2zzT/TEisJEJtg+k0
 a2gPIffbcvhyFYYXWje3DMMzMUlNon0UEv0oV/NJr6NChKLP9TeMTBOjz1zl54NKDp4k
 LV8kJYyJL28zrfsKdWvFJWMAjG6+79cejwIajGY0GMe71FIRri5R+rc3hT3PXdZxMefH
 vVN/uohSfO7lWUfmCrftEkllhUOcujsRTJr+mv5tTLVCIrhOx3MkZiIoRTZl+A0sP50z
 ++DEnGKcV+/2TqYq6r4hJ9cudr92dRAbP/Zgs6A+lF6e1aBS3vzTeDccS6uYz9fnokBj
 Kf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783418245; x=1784023045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DaqVFVHznL31EyOplamlzakvBKWEB+lr+paAB2x0hMg=;
 b=sbPcWEg8uMg1yLr+G0tuNoBjxT89KAG9H6E70+urhQTY78tR/+8tubX+sSNxPpopLT
 8b6EElv19shfemVPcCyl/zQ7kB7vjiOccg9TJdD9g2LhUYIK6k/eCOQ58EnXu4FaFy1x
 9ahA5rpk3Jem38bSGaSpFDn5DIV6RLai8ho7i9q+SbvMQSl73jlVFagUELPImxXWT5zm
 +UB4qw9rFBZ7wQKIzDtTgqe9y7eH5Mk5lw6hPSnCitCgn7p40r8mEMGfSa02hotMF7D8
 QZ6E632SJkiOlaYn+46w5NYiNS+27UatR/CiTa/04Cg9zHC7HvX6sGmPBe56lTgudNf5
 nk/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrakt9xZ4fei/zasi7SSpwkP1yW/jqAbYmiBBU7V7/DC8f/X3nFLABS8ve9Ok5nBTdsxKZ1dvM=@lists.denx.de
X-Gm-Message-State: AOJu0YyepxI3F06blnfu8kwcZuav85yi+rlXs5NHBeun7T/GL2s7vUvA
 zxllo8AqxULHN2DPS/s1AMYkMNN/vVKF2/bzR7zQpjjNo1L3sbpbKW3F224US56yH3ldpVLrYty
 KVoDtgkraOJMf+PyGfJm8ggNxobKDwz+/Bg+Yl2HwCph4wee/L0LvN0Td
X-Gm-Gg: AfdE7ckvMUReO4ZjmYtdmr4C4BFB6vRvVTdBnK0NEGT1c2/nweux8F+rb63zGBeFfmz
 x8pbD6Rn8HyeFB5DOblfLwBSL2JKTvlY4HPLgIcUyGlfnEVB3Zf1+WOsoIDeK8FHca7TsPuTr6R
 E6ViRpXKWUB/MzLXVNjE6JUOVkDAD/s37rtB4uO8Tu3AkojAUsu2ILrkPvxttf/eghDHLsGfdC0
 A2ZifLktLxDBwkAsBFrzJ1N2UaerGqsp50DADX0xD99dMTUON22n55LW3GZ5VVL6XN0ENIw9a03
 WuFBw4pWvV4JkOuME55ctnXtqUkkB4oMCY8+C/NwEqPcePe2C5uhOFkaW9N8MuWNGeEuZCqY19t
 6TRDCYpkzRSWQY+IzAsSTd5I8YBBkMU2Tp9zHdcJq+hlbFNk=
X-Received: by 2002:a05:6a21:4584:b0:3b4:731e:6fad with SMTP id
 adf61e73a8af0-3c09b05addfmr2656395637.16.1783418245059; 
 Tue, 07 Jul 2026 02:57:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:4584:b0:3b4:731e:6fad with SMTP id
 adf61e73a8af0-3c09b05addfmr2656344637.16.1783418244065; 
 Tue, 07 Jul 2026 02:57:24 -0700 (PDT)
Received: from [10.151.41.57] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm6942099c88.10.2026.07.07.02.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:57:23 -0700 (PDT)
Message-ID: <2f0928b9-0689-4dbf-92ea-e61b5ba6891f@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 15:27:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: msm_geni: validate RX data with IRQ status
To: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
References: <20260629-uart-v1-1-cbc46fe1d7d3@oss.qualcomm.com>
 <c96d6396-f741-4c02-bd7f-3b001f308feb@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <c96d6396-f741-4c02-bd7f-3b001f308feb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5wCYZ2vGM39AxuC5SlIPAMFOwCxZygYX
X-Proofpoint-ORIG-GUID: 5wCYZ2vGM39AxuC5SlIPAMFOwCxZygYX
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4ccd86 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5I7MwGemekxvx0v8UegA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfXyktDOuWGU39D
 4KXZqPD029Qw4bDu1p0h/oQ+u7u83gB+cI8vUgpfmFVBAxtnppy7KKBX/I6y8IoGtVuB7OQ9fcp
 71T52VoQb3DKXQG27NHERo8wJjRoZzE23gtyyqeTlgiBPYTCr7bA6/hSgNyfqNrjq8xK4oQaQfs
 UwpJseJthLlzeyH8o8ia+6IBb2Mwys1ZC9o6YWaB6cUzAMTp+XHH5ha/3RlWU6llHuGiOdVwXQT
 8hBa03AuQy6D/7Flrzc2EA6R7jfw4qYD0lI20NnCM2IX/6FZahii8u85SBbp1aZjrXDwdAHpFmk
 POY958UOSLWRxerjQkFpQXUe2xHr47cUZ1kjyn2nQSgH0nUK1MVhF0kn6dx7p4nV03xJoHgfJf1
 /f77KadJqJ19KVrJ6Xhvn+VJUjJFYKwqkbM1pm9RT0O3wYrRJEB+HzWM8BEoscUBREb9J9IJ+5I
 hdYktuh0Rjzl2Lbdjvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfXxzvyyrSohr9b
 C42utLWP/OGK6CgHpLmd2vnJ/GOqkbGAy5LtVAmgmdCSp/HhRnG7lNWuiZ5Rn9Ffgq+F21WwSPH
 EvQ0lTcZJ2GQGHXGxZA9/qRP6xmlZaY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070095
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

Hi Casey,

On 6/30/2026 1:27 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 6/29/26 13:31, Balaji Selvanathan wrote:
>> The GENI UART hardware can retain stale data in the RX FIFO.
>> The msm_serial_pending() function was reporting this stale data as
>> pending input, causing U-Boot to incorrectly assume a key press and
>> stop at the CLI prompt instead of continuing the boot process.
>>
>> Add IRQ status validation to distinguish between legitimate received
>> data and stale FIFO contents. Check the Secondary IRQ status register
>> for RX watermark or last flags before reporting pending data. If the
>> FIFO contains data but no valid IRQ flags are set, ignore it as stale.
>
> Taking a look here compared to the Linux polling mode driver I don't 
> think this is the right way to solve this.
>
> In qcom_geni_serial_stop_rx_fifo() in Linux after clearing the RX IRQs 
> the cancel command is sent (and polled on) and then if 
> S_RX_FIFO_LAST_EN is set the FIFO is drained.
>
> So the right fix here for U-Boot would be to do something similar in 
> msm_geni_serial_setup_rx(), send a cancel rather than an abort, wait 
> for it to complete (or timeout), drain the fifo, and then send an 
> abort if S_GENI_CMD_ACTIVE is still set to fully reset it.
>
> so NAK, please solve this properly by fixing the init sequence.

Fixed the init sequence in v2: 
https://lore.kernel.org/u-boot/20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com/

But even after fixing init sequence, still the issue is observed, so 
seems SE_GENI_S_IRQ_STATUS register has to be checked to make sure data 
is valid 
(https://lore.kernel.org/u-boot/20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com/).

Thanks,

Balaji

>
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   drivers/serial/serial_msm_geni.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/serial/serial_msm_geni.c 
>> b/drivers/serial/serial_msm_geni.c
>> index 3dca581f68f..6d30f150966 100644
>> --- a/drivers/serial/serial_msm_geni.c
>> +++ b/drivers/serial/serial_msm_geni.c
>> @@ -424,13 +424,30 @@ static int msm_serial_getc(struct udevice *dev)
>>   static int msm_serial_pending(struct udevice *dev, bool input)
>>   {
>>       struct msm_serial_data *priv = dev_get_priv(dev);
>> -
>> -    if (input)
>> -        return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
>> -               RX_FIFO_WC_MSK;
>> -    else
>> +    u32 rx_fifo_status, s_irq_status;
>> +    int result;
>> +
>> +    if (input) {
>> +        rx_fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
>> +        result = rx_fifo_status & RX_FIFO_WC_MSK;
>> +
>> +        /*
>> +         * Validate RX data with IRQ status
>> +         * Only report pending data if valid RX IRQ indicators are set.
>
> What does this mean "valid RX IRQ indicators"??? This comment is 
> fluff, use better variable names (result -> word_count)
>> +         */
>> +        if (result) {
>
> if (word_count > 0)> +            s_irq_status = readl(priv->base + 
> SE_GENI_S_IRQ_STATUS);
>> +
>> +            if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | 
>> S_RX_FIFO_LAST_EN))) {
>> +                /* No valid RX IRQ, ignore stale data */
>> +                return 0;
>> +            }
>> +        }
>> +        return result;
>> +    } else {
>>           return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
>>                  TX_FIFO_WC_MSK;
>> +    }
>>         return 0;
>>   }
>>
>> ---
>> base-commit: 6902fb4c17faa375003124c451c2550deab5463d
>> change-id: 20260629-uart-e07d893e4508
>>
>> Best regards,
>
