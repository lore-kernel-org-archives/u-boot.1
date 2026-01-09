Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED76ED232C5
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 05:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4011784158;
	Fri,  9 Jan 2026 06:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PVXNBZ48";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H+Via81j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBCC884175; Fri,  9 Jan 2026 06:48:52 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3625784150
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 06:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 608Nr63F3729572
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 05:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6gQFhjWXQd09DtgndD27uqc7eOKw307waYHAFrePPjI=; b=PVXNBZ48Vlwgufp6
 7w5Ze0R9ZrYZ/YJJ9noiSFTHOe82moawPU9pCHK2vdpJCXkrrkaTw4AUzJWaXtzS
 PG0eEHlzSyTJPuSSGC1zisXyBKQpbkinVZrzyI75s7589Q05S65UXzj0jRXr9IZT
 wh7XCDl/3LdNg+uqZODCRAC5XBP4w+5AEy/pKtiGGUYc0q84pHJrKTlJUM/gOO8m
 Fzhwxywv7egxODL5mBRgekL5MJkb9EdEiJ39P20pDWBp+ETn8yI0lqSav6ew8tR3
 9tItfBjSz7I7jUwxVR+bxm03vgErxRYA84WR0QDcoXaf4XLUhcbWSaVqfYQ8DA9s
 g0TQzA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjpmkgt3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 05:48:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34e5a9de94bso7370956a91.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 21:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767937727; x=1768542527; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6gQFhjWXQd09DtgndD27uqc7eOKw307waYHAFrePPjI=;
 b=H+Via81jW7HvR/PZKMs+cFc8bjgprOKQTJ+yTbebaofB2/ZQAl1D1RalWIclT/fKxf
 4l5LrSg7bVNip+d+kwzgh8idjYW5piDhKDQVqVqu4B54O8Y5PtxLRvZvet08Nu9kuObv
 vuIqVRs0zsHT9Es02eBIPz0LCRxF3hQdltFjc+Xs5rOxGeUt2NTNo8Q/UEpbhfbeGqx9
 urnR3yWtQVM3GqqFO9/4NT9wHNGr/IzN2uwedzfn9w5Toz0jO/0S8TRWoX0dSGRSoICk
 x2N1KNDBPrHkV3nnvsZ/9eewzZv7fXG/9f9OF/aVsq1AKGGLNmGGrouWEK87twa8e1M7
 7t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767937727; x=1768542527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6gQFhjWXQd09DtgndD27uqc7eOKw307waYHAFrePPjI=;
 b=IpqSMbjqAhY2V2HuFuNgCoGc+uVlCkl/2skBZXGFZChbTZEdRhrpdwPWfwzprWppRg
 3uxfJMq7MQJi0mNJN5anNiUowRQ3A8f/W8aQ9Mgq//F1EhIAEOZ1NMgUOlz8hV8l3uPV
 O2mrl5xMeYNb5/h9du3mGJ4EPBrI97dJPYz15xR6suOvw+7fZtEU1JQmDgSPLvV9GmBp
 bDxLGtguPECy283GDeP50M5fc/fwPMqkgCQ+sJFxVCMQ/rjsL8CcRyd4wQIh8Z2GdlB+
 tKIk3MD5wWYH2e15N8SJSbvYaleJ+Lc2Dh5W6l3V74bYGzJfALC5VSjoLd+vVDFrs59h
 dvWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWthmtaidAcrlCltHXQ0+jnZ1XZTgHmC6ED0pyz05RDBWG/ZQ0eRzz1IMhhTKPCtuvYB2z3/0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8D0njE26eDjc15xcnUbazgcJMYY5bNBBBIvqB9+TOMLxOZNHB
 Yrw5vZ7zBeeoxDIWOzg0XaGdjWchgVALa0dJtI78UaLURJ905pR7byQFyhc7djlRYrVOqhJIQxz
 8SNig+1TSG/dTBNzSIhX4xQRDYmanDNVweoBaGtSZZW1mv3S5syr0t0Ul
X-Gm-Gg: AY/fxX47C0fdrv4k1UTqto6NzyTdKjSsU23zP0iVcMGlv/5QsPyRuroafU60ADfeFkk
 YYPswXhjQYCexmdqo4YPFj+Q+83Yd4ctqKUP6XnVFdU+p4qpQ4GXCdv4uT4dLcTw3SNavxZiSir
 rVSyNuRas/jzjJ5pvjJN/6bARZ++Unm3PkUQV4f0nx2vh4I5wxTbqMPSE5cLDpbnmqZLI/V5i0H
 XSsRFhpm2XNMiy1tdYhDv4XqjCcxfq0XWuafdOOPYRF2917obRhHiD1h6Hqy4GkCRexo6v1AteF
 fFqsgGW3V93GYBFEZbztw22pnAbnklvdO/Q3t2X9s1qfmdcA/IDpzGNEBiyQJXtZSA2hpff6s1j
 WYMNlhTKCOiAWSTot+W6ww4e6lY+b7ZakTRRIpKn9Hv0j2LI=
X-Received: by 2002:a17:90b:4b0b:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-34f68d0bc5fmr8941540a91.20.1767937727490; 
 Thu, 08 Jan 2026 21:48:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGss04/3zfJ4yATueSC3GifVdm55pgRKrI5zymT+z7RsMdGoF4OD/YJRaNepNwCMXvfDtKxcA==
X-Received: by 2002:a17:90b:4b0b:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-34f68d0bc5fmr8941506a91.20.1767937726973; 
 Thu, 08 Jan 2026 21:48:46 -0800 (PST)
Received: from [10.151.41.119] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81db6e09161sm1576902b3a.24.2026.01.08.21.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 21:48:46 -0800 (PST)
Message-ID: <0ce0b213-7e9c-4377-b075-97129adbab15@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 11:18:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] soc: qcom: rpmh-rsc: Clear TCS state before kernel
 boot
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, me@samcday.com, sughosh.ganu@linaro.org,
 gchan9527@gmail.com, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
 <20260108101721.3411854-2-balaji.selvanathan@oss.qualcomm.com>
 <CAFLszThHG=mwX4gpC5b-2c+jagLb1NmXKCP-U-dPMoROk3+93g@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAFLszThHG=mwX4gpC5b-2c+jagLb1NmXKCP-U-dPMoROk3+93g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YNiSCBGx c=1 sm=1 tr=0 ts=696096c0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=5gP-299sZ9AAChZJ51gA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8haEOal02z6u7wPzDBpZk7ASGbR4beG1
X-Proofpoint-ORIG-GUID: 8haEOal02z6u7wPzDBpZk7ASGbR4beG1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfX9kToJTssY/l3
 XwnBQ1M/wDlmf38/PQMABEcDbiQDHPiOdbkwGAZaf/K9dRuCsoSJOGZQ93hJEnZ8Rs22vuYKPrC
 Qu0wu0GvdWo+Z5ZdIzJEeVrQdDYKVv8htyldv3rsWxx48/lmhHjm67qws0PyJicLtQyRxdXbAiH
 sZ/0HDxNgBNjHEDCcuOLZOd+3toxMYNdENx4OoLZzFudO7jlWAfdITrmbPmLt1nqhbPzDH/dYGj
 ZurTzrPM+K4h4TyRNtVGMpcXwWwuHagS4QWY4U7I0z0RmgQYvG06FM0K5l2cJuW0zvkPCdDLdyU
 HLBNs0DHZ6DfWvAmdBkyzMI3/f1amnT1br684m81+oS0La/HU6GI7Uk/cBIVLA9fTfeGTJhwd9M
 yclq1g4DUtEGvDdit21Bsn7DuYVzQoiETKHq2PaAvcsL4uppON7VY0OT2p8WZcFjTQbcmp7CW2+
 85Eai7HHYbaZjbvq2Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090037
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

Hi Simon,

Thank you for your feedback. The following patch series addresses the 
same issue that we had reported:

https://lore.kernel.org/u-boot/20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org

We can proceed with this series going forward.

Regards,
Balaji

On 1/8/2026 11:12 PM, Simon Glass wrote:
> Hi Balaji,
>
> On Thu, 8 Jan 2026 at 03:17, Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>> Add cleanup mechanism to clear RPMH TCS hardware state before
>> booting the kernel. Without this cleanup, leftover U-Boot TCS
>> configurations cause timeout errors during kernel RPMH driver
>> initialization.
>>
>> The cleanup clears CMD_STATUS, CMD_WAIT_FOR_CMPL, CMD_ENABLE,
>> CONTROL, and IRQ_STATUS registers for all TCS.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   drivers/soc/qcom/rpmh-rsc.c | 101 ++++++++++++++++++++++++++++++++++++
>>   include/soc/qcom/rpmh.h     |   9 ++++
>>   2 files changed, 110 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index aee9e55194e..772be401f0d 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -471,6 +471,106 @@ static int rpmh_probe_tcs_config(struct udevice *dev, struct rsc_drv *drv)
>>          return 0;
>>   }
>>
>> +/**
>> + * rpmh_rsc_clear_tcs() - Clear TCS state before kernel handoff
>> + * @drv: The RSC controller
>> + *
>> + * Clears all TCS hardware state to ensure kernel starts with clean state.
>> + * This prevents timeout errors during kernel RPMH initialization by clearing:
>> + * - CMD_STATUS: Leftover ISSUED/COMPLETED flags
>> + * - CMD_WAIT_FOR_CMPL: Completion wait configuration
>> + * - CMD_ENABLE: Command slot enables
>> + * - CONTROL: AMC mode bits
>> + * - IRQ_STATUS: Pending interrupts
>> + */
>> +static void rpmh_rsc_clear_tcs(struct rsc_drv *drv)
>> +{
>> +       int i, j, ncpt, pending_cmds = 0;
>> +       u32 status, irq_status;
>> +
>> +       ncpt = drv->tcs[ACTIVE_TCS].ncpt;
>> +
>> +       for (i = 0; i < drv->num_tcs; i++) {
>> +               for (j = 0; j < ncpt; j++) {
>> +                       status = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_STATUS], i, j);
>> +                       if (status)
>> +                               pending_cmds++;
>> +               }
>> +
>> +               /* Clear completion wait, command enable, and control registers */
>> +               write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_WAIT_FOR_CMPL], i, 0);
>> +               write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i, 0);
>> +               write_tcs_reg(drv, drv->regs[RSC_DRV_CONTROL], i, 0);
>> +       }
>> +
>> +       /* Clear any pending IRQ status */
>> +       irq_status = readl(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
>> +       if (irq_status)
>> +               writel(irq_status, drv->tcs_base + drv->regs[RSC_DRV_IRQ_CLEAR]);
>> +
>> +       log_debug("RPMH: Cleared %d TCS for %s (pending: %d cmds, IRQ: 0x%x)\n",
>> +                 drv->num_tcs, drv->name, pending_cmds, irq_status);
>> +}
>> +
>> +/**
>> + * rpmh_rsc_cleanup_all() - Public function to cleanup all RPMH controllers
>> + *
>> + * This function should be called before booting the kernel to ensure all
>> + * RPMH controllers have clean TCS state. Can be called from board_quiesce_devices()
>> + * or directly before kernel boot.
>> + */
>> +void rpmh_rsc_cleanup_all(void)
>> +{
>> +       struct udevice *dev;
>> +       struct uclass *uc;
>> +       int ret, count = 0;
>> +
>> +       ret = uclass_get(UCLASS_MISC, &uc);
>> +       if (ret) {
>> +               log_err("RPMH: Failed to get MISC uclass: %d\n", ret);
>> +               return;
>> +       }
>> +
>> +       uclass_foreach_dev(dev, uc) {
>> +               if (device_is_compatible(dev, "qcom,rpmh-rsc")) {
>> +                       struct rsc_drv *drv = dev_get_priv(dev);
>> +
>> +                       if (drv && drv->num_tcs > 0) {
>> +                               rpmh_rsc_clear_tcs(drv);
>> +                               count++;
>> +                       }
>> +               }
>> +       }
>> +
>> +       if (count > 0)
>> +               log_debug("RPMH: Cleaned up %d controller(s)\n", count);
>> +       else
>> +               log_warning("RPMH: No controllers found to clean up\n");
>> +}
>> +
>> +/**
>> + * rpmh_rsc_remove() - Cleanup before handing off to kernel
>> + * @dev: The device
>> + *
>> + * Called before booting kernel to ensure clean TCS state. This prevents
>> + * kernel RPMH driver from encountering busy/configured TCS that could
>> + * cause timeout errors during initialization.
>> + *
>> + * Return: 0 on success
>> + */
>> +static int rpmh_rsc_remove(struct udevice *dev)
>> +{
>> +       struct rsc_drv *drv = dev_get_priv(dev);
>> +
>> +       if (!drv)
>> +               return 0;
>> +
>> +       /* Clear all TCS configurations to provide clean state for kernel */
>> +       rpmh_rsc_clear_tcs(drv);
>> +
>> +       return 0;
>> +}
>> +
>>   static int rpmh_rsc_probe(struct udevice *dev)
>>   {
>>          ofnode dn = dev_ofnode(dev);
>> @@ -539,6 +639,7 @@ U_BOOT_DRIVER(qcom_rpmh_rsc) = {
>>          .id             = UCLASS_MISC,
>>          .priv_auto      = sizeof(struct rsc_drv),
>>          .probe          = rpmh_rsc_probe,
>> +       .remove         = rpmh_rsc_remove,
>>          .of_match       = qcom_rpmh_ids,
>>          /* rpmh is under CLUSTER_PD which we don't support, so skip trying to enable PDs */
>>          .flags          = DM_FLAG_DEFAULT_PD_CTRL_OFF,
> add DM_REMOVE_OS_PREPARE in there too so it will cleanup
>
>> diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
>> index 3421fbf1ee3..da3b1517392 100644
>> --- a/include/soc/qcom/rpmh.h
>> +++ b/include/soc/qcom/rpmh.h
>> @@ -25,4 +25,13 @@ static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
>>   /* u-boot: no multithreading */
>>   #define rpmh_write_async(dev, state, cmd, n) rpmh_write(dev, state, cmd, n)
>>
>> +/**
>> + * rpmh_rsc_cleanup_all() - Cleanup all RPMH controllers before kernel boot
>> + *
>> + * This function clears TCS (Trigger Command Set) hardware state for all
>> + * RPMH controllers to ensure the kernel starts with clean state. Should
>> + * be called from board_quiesce_devices() before booting the kernel.
>> + */
>> +void rpmh_rsc_cleanup_all(void);
> I'm not sure who calls this, but each device will be removed before
> booting if you use the DM_REMOVE_OS_PREPARE flag
>
>> +
>>   #endif /* __SOC_QCOM_RPMH_H__ */
>> --
>> 2.34.1
>>
> Regards,
> Simon
