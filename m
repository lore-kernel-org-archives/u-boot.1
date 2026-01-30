Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A7AE6BF2F
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 17:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CE5844F4;
	Fri, 30 Jan 2026 18:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PifAjg5U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UvKE7d34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC6D84517; Fri, 30 Jan 2026 18:13:43 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C738C844F1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 18:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60UAPNmG1488307
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 17:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M+zQBYSZQ5VNpiQx73aIoDGDHlc/pnUp1m/d6dLcLoU=; b=PifAjg5UaB2juHco
 35qRXLKjlnbnxK5LRSN4JTHfHJkhcS+1Fa5leuDMmKtHgD9EbrS9NUfoaDqC1iU2
 Mjh9J3ISs1zDtrPNfIvprr8yQIwue+BSZdoxMEVvvlev9eEUf/T/2PpD5tPLZMMZ
 aSdbV+GS1xWaZecGn+pMX8/o6ypmmCsVc06o6Fk86Q3DkFFXbYmeAU3dg+b0piL+
 TTks8RDDB/TOuoH6+6fZhif7f915rk0LlsShm2A3ii6hkxb6kANYOez35iLOSI9D
 lieXyIff5FKHoxnmtS3z4tOYNA5atGhTrCTR4Mz5ZCR/Dn1flz48VYW1kdP4F4lT
 aHrXfw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bp3v2de-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 17:13:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c549aaa796dso4223365a12.1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 09:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769793218; x=1770398018; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M+zQBYSZQ5VNpiQx73aIoDGDHlc/pnUp1m/d6dLcLoU=;
 b=UvKE7d34HxtlmYfOezvwFjhIlhZTAbgUKW1cc14WB1LiBOBgYqtNTKf0pe7LA4TJgw
 qYfdumOYnvwMhOaBe+pmsWd4kNqnIDL0o4rYiAk4CCXSNxU0IEYq+Ie6rACpBYsXr/2R
 Nrp/I3i9pfndnA+3P1uzXJAOaOaKD5YEOsxqVro12/A5SIJ5UDHh4RbBYTOLFlj7tbqV
 SOTNouCK+GacSfbj1JmFlgztIhUwcr6JIS5gbLE2WGBUXKCHXXWFKcUmKfz7zWW3rEtv
 Qs89zlASYZ9IEvS2rO9pRzoIanGpMQS3WcW5WgVj0AJqgZ1sKAtdB7EfDysuKfFeg2xU
 xFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769793218; x=1770398018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+zQBYSZQ5VNpiQx73aIoDGDHlc/pnUp1m/d6dLcLoU=;
 b=QtW6Bosoj5E32vRLcssj4LQjqHTk6klXUBy3nG5i9zdDP2AXWAWCpA472W1vQSCr8X
 QPvHaJvsliMdtENudBhYBj+h/ZHRpu2vfD0cA2ZG6VINW/kktqCqNS7VumdEpYdyob32
 stToe8I/xVqUsnj+Lj7IK2t187YHseLkqQhWKYLbUnlwVRWZPkcCzQYWHxDfHn0zmGC2
 J2xBaSf5anZLD9ktQzfc4ZPgPTHE0rRtd6J/CdvMuTvkz554/I+U0ZNpXlgjjJQBt/9U
 dIBsdZSjfxfgLKV8Dc744x8QHzdxq4dNWZ4z8srVh0Gn6uyyI22uNLwPyPuGF5fPhzs3
 sO9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCiQ+skAkBRhjww7o3SQOL52lon9IYh2AXzxD8uZn3GhhVDLCZsSKAVS7iYdgCKBsKb5VW/b8=@lists.denx.de
X-Gm-Message-State: AOJu0YyTob/5KS92/2qodi3X4vh8mEJKK85Raf5LH5gm5Vcc1LDbFvyo
 EVqFrTVQzGqvQvkphh74ICO/E82Gq0OMDfvyqUcxX00Jf2kH1EoxzL/rLZgRXBA8QborKnWpfNJ
 iyE24Rcv2Fq2rLvA1CvcSB+Gi/CwDADE8JfTvNSdNvgFVHU5O7M4VuGOs
X-Gm-Gg: AZuq6aIyXqfp9qycsqOzUhJnVz7AB+hvY2j/WonPNjjf4m/IHlfjJP5V6OBpT+XiJUw
 3yhLmSY0kbncPlmwLhX6DUrOCP6pqEXmlFxGS/5WYVt5LVPyvW4DnM/UjgfLx1N/SqupUcJJuiC
 mG0OzWtVBNru01GwP/7ap/aJENlpYazRrS2b/Foie5W/Q65pkXEGEqppgRW6kFBwtrD3mR/paY6
 KMIq8YFYaT4EAfNxpTqGEeTa0iMYwZyZbuepD5unwDj5Xh3hnrBn38TgXEgDPI07sRfmVelV5zh
 9UaiNoy9p4RJi99CZjPy+sqFG7GbbDehtysdGhr9Jnidjr0w0q83licxw1M37kpAJdDYvLklSeR
 ZT0uTJcu550t/6GCYLnaKZe5Sij674VHY4q+DTOs7LFydufRFc87MXLNFURQBAfDr3c+czFKNjC
 kHu/U=
X-Received: by 2002:a05:6a00:2290:b0:81f:852b:a91d with SMTP id
 d2e1a72fcca58-823ab9755b0mr3604535b3a.58.1769793217944; 
 Fri, 30 Jan 2026 09:13:37 -0800 (PST)
X-Received: by 2002:a05:6a00:2290:b0:81f:852b:a91d with SMTP id
 d2e1a72fcca58-823ab9755b0mr3604499b3a.58.1769793217418; 
 Fri, 30 Jan 2026 09:13:37 -0800 (PST)
Received: from ?IPV6:2401:4900:1cc9:68c8:d0b9:1522:2fad:2de3?
 ([2401:4900:1cc9:68c8:d0b9:1522:2fad:2de3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b59e10sm8862799b3a.25.2026.01.30.09.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 09:13:36 -0800 (PST)
Message-ID: <1ffaa53f-75f5-43f3-a5b4-53a0d203abc0@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 22:43:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] Added QCOM RPMH Power Domain Driver
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 jh80.chung@samsung.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
 <5ae1432d-b5fa-4f30-b58a-0e4b08de744f@linaro.org>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <5ae1432d-b5fa-4f30-b58a-0e4b08de744f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: j77Uvp5Isu3bjs1GHusRWzDZKI7U9cMz
X-Proofpoint-ORIG-GUID: j77Uvp5Isu3bjs1GHusRWzDZKI7U9cMz
X-Authority-Analysis: v=2.4 cv=d6T4CBjE c=1 sm=1 tr=0 ts=697ce6c2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=-ahtfY8fPboJ07B6I6YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE0MSBTYWx0ZWRfX/arNI2nrl+td
 svbB3PXVD4f9Jlt9GD8B4VZbp+rznjHd3uBpntvSR142jlQHTl62lV/UJ/Br4QAv+IFuM073wJg
 TZtNbJfH4zY3qeOQdhYF+FJsH+5D2QG8joaPK6qPxLNxUvAmDGbkaPXHurMnPjD+xOp1nByfKlK
 tCSoEyodTAOJY2bBXQB5OASSSiEvl+Dr+0gT0mHkDERK9bfYhoMLEvhvbUldoKBLwPUvFA3apYs
 ZTu/VmgL1wC7WNIv2cBk2Cb4HYn08aHiLBBCbgPsyu1UHq35QZlEnhWRftH2mh2eLtTjhs1gPVi
 t/U3Cv4Z3f6bs9B1qu9BRg2Pr58xHDE6+DtNGoS6+apX7iyEpCmDdaJqg0UNOun6CXvCqaTx8W0
 Kcpvp9+W0WoCBpeSSpedGdm+dIfR7OObkIxOk7ZpAF5YYUc36NrZzRAqn7by3LepvQ7qYMfMD4S
 OgiiCdtLeG15DzyPrEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300141
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

Thanks for the review & feedback

Regarding comment *#2*, this was already discussed in v5 [1] and got 
addressed from v6.
In Patch No 2 "power-domain: Add warning when power-domain driver is 
missing", |dev_power_domain_ctrl()| was updated to log a warning when 
the power‑domain driver isn’t found (|-ENODEV|) and return 0 so that 
execution continues without breaking the rpmpd platforms.

For the remaining comments (#1 and #3), I’ll incorporate the suggestions 
and respin the series.

[1] 
https://lore.kernel.org/u-boot/2e387aeb-2ba2-4b72-aa91-0815cd06f831@linaro.org/

Regards,
Aswin

On 1/14/2026 8:08 PM, Casey Connolly wrote:
> Hi Aswin,
>
> Sorry for the late response here.
>
> Still a few minor issues with this series but it's more or less there.
> I'll just list everything here rather than replying to individual patches.
>
> 1. Please rename the kconfig option to something more specific like
> QCOM_RPMH_POWER_DOMAIN
> 2. Removing the fixup code will break msm8916 and other platforms that
> use rpmpd (non-hardened), it should be pretty trivial to check if the
> compatible string for the power-controller node ends with "rpmpd" or
> "rpmhpd" and skip the logic in the latter case.
> 3. The commit "mach-snapdragon: fixup power-domains" should have a more
> specific title.
>
> I'll pick this up as soon as I get the next revision.
>
> Kind regards,
>
> On 22/12/2025 12:48, Aswin Murugan wrote:
>> This patch series adds support for the Qualcomm RPMH power domain
>> driver, responsible for managing power domains on Qualcomm SoCs.
>> The driver is ported from the Linux kernel and adapted for
>> U-Boot to enable proper power domain control on SA8775P platform.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>> Changes in v7:
>> - Droped soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data() functions
>>    patch from previous version, since it was already picked
>>    Link: https://lore.kernel.org/u-boot/176363183220.2293399.7296647117885059868.b4-ty@linaro.org/
>> - Cleaned up the warning logic in drivers/power/domain/power-domain-uclass.c
>>    when power-domain driver is missing
>> - Link to v6: https://lore.kernel.org/u-boot/20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com/
>>
>> Changes in v6:
>> - Added the change in drivers/power/domain/power-domain-uclass.c to give warning
>>    when power-domain driver is missing
>> - Added the change log 'In qcom-rpmhpd driver, the un-supported power domains are handled with warning
>>    in rpmhpd_power_on() & rpmhpd_power_on()'
>> - In drivers/power/domain/qcom-rpmhpd.c, the 'ret' variable in rpmhpd_probe() is initialized with 0
>> - Link to v5: https://lore.kernel.org/u-boot/20251027113312.3815169-1-aswinm@qti.qualcomm.com/
>>
>> Changes in v5:
>> - As part of "qcom_rpmhpd" driver removal change did in v4, the rpmh_write() in drivers/power/domain/qcom-rpmhpd.c
>>    should be passed with pd->dev as first argument to align with it.
>> - Added (ulong) casting in rpmhpd_match_table to address the warning.
>>
>> Changes in v4:
>> - Added all soc entries in power domain linux driver to drivers/power/domain/qcom-rpmhpd.c and
>>    stubbed it
>> - Removed "qcom_rpmhpd" driver & unused members of struct rpmhpd in drivers/power/domain/qcom-rpmhpd.c
>> - Moved the "soc: qcom: cmd-db" change before the "power-domain" change
>> - Link to v3: https://lore.kernel.org/u-boot/20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com/
>>
>> Changes in v3:
>> - Removed OF_LIVE_SA8775P config in arch/arm/mach-snapdragon/Kconfig & configs/qcs9100_defconfig,
>>    since there is no SA8775p specific fixups are done
>> - Link to v2: https://lore.kernel.org/u-boot/20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com/
>>
>> Changes in v2:
>> - Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN in drivers/power/domain/Kconfig
>> - In drivers/power/domain/qcom-rpmhpd.c, the un-supported power domains are handled with warning
>> - Power domain fixups have been removed since they are now managed by drivers/power/domain/qcom-rpmhpd.c
>> - Link to v1: https://lore.kernel.org/u-boot/20250626112441.143064-1-aswin.murugan@oss.qualcomm.com/
>> ---
>>
>> Aswin Murugan (5):
>>    soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data()
>>      functions
>>    power-domain: Add QCOM RPMH Power Domain Driver Support
>>    power-domain: Add warning when power-domain driver is missing
>>    mach-snapdragon: fixup power-domains
>>    configs: qcom: Add QCOM_POWER_DOMAIN config
>>
>>   arch/arm/mach-snapdragon/of_fixup.c        |  31 ---
>>   configs/qcom_defconfig                     |   1 +
>>   drivers/power/domain/Kconfig               |   8 +
>>   drivers/power/domain/Makefile              |   1 +
>>   drivers/power/domain/power-domain-uclass.c |   7 +
>>   drivers/power/domain/qcom-rpmhpd.c         | 278 +++++++++++++++++++++
>>   drivers/soc/qcom/cmd-db.c                  |  45 ++++
>>   include/soc/qcom/cmd-db.h                  |   2 +
>>   8 files changed, 342 insertions(+), 31 deletions(-)
>>   create mode 100644 drivers/power/domain/qcom-rpmhpd.c
>>
