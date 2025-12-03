Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3693FD12694
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE3683F6A;
	Wed,  3 Dec 2025 12:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mt2mFZsf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i5fy4eSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338FE83F85; Wed,  3 Dec 2025 12:13:42 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A0B83F24
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3Aju1a1427753
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yKPuuwfAyO7Zi3gTqqyP9SIzsbhi6nG+g2uGirPixU8=; b=mt2mFZsfduTxsSM+
 JIfzVCzsPcRgUklo897cd3pq82zIyfLo+TBy0LICWFv8wmzOkfGgYqtqTuLe3qHS
 PxJsLXz9btgW+xVZ1m+IoLQcW5nNoW4DtMYPtcjS3kaUlQ2cpa1msOgngUsf2Fw0
 bF6IQAGwLdkhqJLYROvuRuc+TuEmqV9oUPbgBQmN2oBCXI3rZbXj0OhY0nWKjbX8
 1kAW4/MN0zmwVL9myenIP6Cc6XduKviAILw7J1eEVpa8hUlf5nTkYvQ4+ZmPzjLa
 lRtRzuVi52hm4HZYHRzQ/GJCpa8dXbAtmgtLiAYQx5Fq9z1ba1xBfANXxS61Ugax
 7Nvefg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ate0js9kp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:13:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-340d3b1baafso8850390a91.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764760417; x=1765365217; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yKPuuwfAyO7Zi3gTqqyP9SIzsbhi6nG+g2uGirPixU8=;
 b=i5fy4eSUYT3woZnSfoQ7bbFDg94jrXJhQGDGDhwiovHhiF8PsSqd/qJQoj7QHNBkaf
 0nVJZT+6NZbIIVN3NhkvGyxqptc3cwEnVs0SfxzB7F5iJUaXWkkyeMqa9LWgDrwaxJn9
 zEcEazRFa0JyI4wZIeQvwpHfOtc+ojrSrvkXkx5zpBYH5FB9av4xAdP5CTNh/hSwD7zN
 NVbdi2/940P4ViJZMnIhe965E5EarJkRh6XTBAHgNLrHDKTN8wKfMBGuS8ybesgZHu76
 TtJsuXONMA+Wv8EK4t5yGYdGaPcZm53GVaAJo7zK0iS6OcWkq82XCoW81pBgKDNFFjEK
 Nlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764760417; x=1765365217;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yKPuuwfAyO7Zi3gTqqyP9SIzsbhi6nG+g2uGirPixU8=;
 b=UmewC1dnexPTi/0k7hmaRhbgIptDmKmlTpDyqdy+9Rq4fWzrn1fN0+H6XK1ZLH+s8N
 emHFSH8y1fa5BA2/LU7FxVtrg3NlhcT+iKP0F1OPl7qf7HwCX4cm/SQz2N8AO9KQYFAW
 B7faZEkK+gsz9aKbMebZrB6weMX5/0Bc1zMBaZv20IY9e7E0M9Ytkz4pwBigCOUKsV2S
 VuzjKRZNhRKL+KjxeuCwkPZWHKrCbJ0qr9l2OO0lXHru/YouHrQKrBkYYav0sodDjwVR
 EQgBuYLi7gPtnWj73urR6whI6OWRU7q0+WzL4W5O17ZFt7lAIHz2exvrM45TeskIAmQO
 NNDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy7uZ3oonKou9vV/xufYy8y+BuUdYuPa4ht8tzZ2Jf/Ac9YcArC03s158iMM000cAq+D4NHRI=@lists.denx.de
X-Gm-Message-State: AOJu0YxLqk8ffpKI+px6zeAHiimnqhMdP3tUDd3J2i9Lane/P3aK/6YA
 fJ58d8v3IjsZ7QW9J+jIo3fWIjMH2CKZtNLPq8wONMBG49M8N9waU5WlgS5eDqU54/btHKUIyXG
 7iX3kG5C/HhMpfEgM1x30Wa8LJ00s1Xsh90ChXik/imhWaUUuEzHh37bv
X-Gm-Gg: ASbGncvU3Jw8tvspisor7wB37rEeVRY0K1NIclpTolrTWNGVOUL3ueKEfGJfj6iYeJk
 rR6PmhzWNhUbrssUhAN/VzANAuozLPEPRsPfLs7wXsDrO2VImr5DA9ze1ltsVkuRTZXjBxAPDdg
 j9r9eWPAenXM/4FsgdAXQgMNP4rVEMKla/DGMf9L8Adjo0YVG/GITkKEUT6q9cSEqK/JhF3Jr7C
 uKNSxjdN22PLOqNJBjhOhJv+q+jECA801zjwva3ON6mJrBYxmVupJqzqMKeiLlEZBQptz84cQ7+
 V6z1arVcJG2N1TjnD/2mGZnVJ7LeT6LCSrrOss7rAg6mE3+yspPTTVIu4SZyk0iAnidkX8jZ41s
 8kfXH4LiX5TWZYdAo3R1L1F2IwPApLIbXbNE0AQpl/CMp+gA=
X-Received: by 2002:a05:6a20:6a12:b0:35e:521b:f488 with SMTP id
 adf61e73a8af0-363f5db722dmr2520564637.25.1764760416502; 
 Wed, 03 Dec 2025 03:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFduskRmHP6GMIrokd3XKoMajQ7bHVha4BSN0L1DEVr3l7wJY8UbqCwpd+vFD5QbgSLJ99cIA==
X-Received: by 2002:a05:6a20:6a12:b0:35e:521b:f488 with SMTP id
 adf61e73a8af0-363f5db722dmr2520525637.25.1764760415955; 
 Wed, 03 Dec 2025 03:13:35 -0800 (PST)
Received: from [192.168.0.5] ([183.82.204.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d15f080cf1sm20200844b3a.46.2025.12.03.03.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 03:13:35 -0800 (PST)
Message-ID: <e4f34509-e700-40bb-be9f-f6491af6cb10@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 16:43:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, malysagreg@gmail.com,
 arturs.artamonovs@analog.com, utsav.agarwal@analog.com,
 vasileios.bimpikas@analog.com, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-4-balaji.selvanathan@oss.qualcomm.com>
 <838611bc-35e8-433c-afc0-c8ea203ad78e@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <838611bc-35e8-433c-afc0-c8ea203ad78e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4OSBTYWx0ZWRfX1pRzyX01MBUu
 rRQwJVbj9s7Q8Tz+qM/vD3N9AvITJUm4a4lNfL2IZSe4pie4a9V3+9EbroIpvR4ZFP7gvMtUQ+D
 3lsNKnncz3YQF+OnDBNBZP5ihdSY0nyMMk5kbIYdo+nKrvjabnuRm04t2JMvcBTU/mg9W9Q1Q3L
 ujOfuKL//zGYzG5mpCAZA7ELK9QMm0ROyD8S5/re/MgQB1UISR+gN7w5BB3Ogw4TnVK8ZdjL5lX
 GdtJyRIYJo/dp/Bo65E8dqyeju8bTVqGMRuPK0UqruAstedWY6l9KloLgce4SJlHaSrLzM1zPoc
 JdDQIhQLb+YJclwQHJzDDMrwGDJZjhijRHPY+RVdxdT7Ftf3MSgRqFLw7+zNoBe8rM46XtlxnhS
 NWU902/SMcSIGgJFZPMbGnvzyJalWg==
X-Proofpoint-GUID: _Q6U68ELXNRLfkl46I0jSiNvm5ePd8ho
X-Authority-Analysis: v=2.4 cv=cOHtc1eN c=1 sm=1 tr=0 ts=69301b61 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=wdA8WxWTYlLD3QqB3+K4dA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=eScYmSlsyJCw37FtpUsA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: _Q6U68ELXNRLfkl46I0jSiNvm5ePd8ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030089
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

Thanks for your feedback.

Have addressed all your comments in this respin: 
https://lore.kernel.org/u-boot/20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com/. 
Request to check if this version is okay.

Please find reply to your comments below.

Thanks,

Balaji

On 11/26/2025 8:16 PM, Casey Connolly wrote:
> Hi Balaji,
>
> In general this looks great! I'm very excited to have SuperSpeed up and
> running in U-Boot at long last :D
>
> I'll try and give this a spin soon on my boards.
>
> On 24/11/2025 16:54, Balaji Selvanathan wrote:
>> Add support for the Qualcomm QMP USB3-DP Combo PHY found on
>> SC7280 and QCM6490 platforms. This driver currently implements
>> USB3 super-speed functionality of the combo PHY.
>>
>> The QMP Combo PHY is a dual-mode PHY
>> that can operate in either USB3 mode or DisplayPort mode. This
>> initial implementation focuses on USB3 mode to enable Super-Speed
>> USB support.
>>
>> This is a port of the upstream Linux files to U-Boot:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qmp-combo.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0
> For future reference, the best format for this is something like:
>
> Taken from Linux commit 3d25d46a255a ("pmdomain: qcom: rpmhpd: Add
> rpmhpd support for SM8750")
>
> You can get this with "git top --pretty="%h (\"%s\")" COMMIT_SHA", you
> can stick an alias for this in your .gitconfig.
>
> Few more comments below.
Have corrected this.
>
>> Enabled and tested the driver on Qualcomm RB3 Gen2 (QCS6490) board.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> v2:
>> - Added pipe clock disable in qmp_combo_power_off sequence
>> - Added all required clocks except pipe clock in qmp_combo_phy_clk_l
>> - All clocks except pipe clock are enabled and disabled seperate from pipe clock
>> - Added support for regulator power supplies
>> - Added a minimal xlate to only return the USB3 phy
>> ---
>>   drivers/phy/qcom/Kconfig                   |   8 +
>>   drivers/phy/qcom/Makefile                  |   1 +
>>   drivers/phy/qcom/phy-qcom-qmp-combo.c      | 642 +++++++++++++++++++++
>>   drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 ++
>>   drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
>>   drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
>>   drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
>>   7 files changed, 782 insertions(+)
>>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
>>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
>>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
>>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
> [snip]
>
>> diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
>> new file mode 100644
>> index 00000000000..f5596aa5e50
>> --- /dev/null
>> +++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
>> @@ -0,0 +1,642 @@
> [snip]
>
>> +/* list of clocks required by phy */
>> +static const char * const qmp_combo_phy_clk_l[] = {
>> +	"aux", "com_aux",
>> +};
>> +
>> +/* list of regulators */
>> +static const char * const qmp_phy_vreg_l[] = {
>> +	"vdda-phy",
>> +	"vdda-pll",
> On U-Boot it's necessary to use the full DT property name:
> "vdda-phy-supply".
Updated to full DT name.
>
>> +};
>
> [..]
>
>> +static int qmp_combo_power_off(struct phy *phy)
>> +{
>> +	struct qmp_combo *qmp = dev_get_priv(phy->dev);
>> +	void __iomem *com = qmp->com;
>> +
>> +	clk_disable(qmp->pipe_clk);
>> +
>> +	/* PHY reset */
>> +	qphy_setbits(qmp->pcs, QPHY_V4_PCS_SW_RESET, SW_RESET);
>> +
>> +	/* Stop SerDes and Phy-Coding-Sublayer */
>> +	qphy_clrbits(qmp->pcs, QPHY_V4_PCS_START_CONTROL,
>> +		     SERDES_START | PCS_START);
>> +
>> +	/* Put PHY into POWER DOWN state: active low */
>> +	qphy_clrbits(qmp->pcs, QPHY_V4_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
>> +
>> +	/* Power down common block */
>> +	qphy_clrbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
> Should we also turn off the regulators here?
Turning off regulators is happening in qmp_combo_com_exit.
>
>> +
>> +	return qmp_combo_com_exit(qmp);
>> +}
> [...]
>
>> +static int qmp_combo_vreg_init(struct qmp_combo *qmp)
>> +{
>> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +	struct udevice *dev = qmp->dev;
>> +	int num = cfg->num_vregs;
>> +	int i, ret;
>> +
>> +	if (!num)
>> +		return 0;
>> +
>> +	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
>> +	if (!qmp->vregs)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num; i++) {
>> +		ret = device_get_supply_regulator(dev, cfg->vreg_list[i],
>> +						  &qmp->vregs[i]);
>> +		if (ret) {
>> +			dev_dbg(dev, "regulator %s not found (optional)\n",
>> +				cfg->vreg_list[i]);
> Are these really optional?
You are right. They shouldnt be optional. Made them mandatory now, else 
probe fails.
>
>> +			qmp->num_vregs = 0;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	qmp->num_vregs = num;
>> +	dev_dbg(dev, "found %d regulators\n", num);
> Please drop this debug print.
Dropped.
>
> Kind regards,
>
>> +	return 0;
>> +}
>> +
>> +static int qmp_combo_parse_dt(struct qmp_combo *qmp)
>> +{
>> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +	const struct qmp_combo_offsets *offs = cfg->offsets;
>> +	struct udevice *dev = qmp->dev;
>> +	void __iomem *base;
>> +	int ret;
>> +
>> +	if (!offs)
>> +		return -EINVAL;
>> +
>> +	base = (void __iomem *)dev_read_addr(dev);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	qmp->com = base + offs->com;
>> +	qmp->serdes = base + offs->usb3_serdes;
>> +	qmp->tx = base + offs->txa;
>> +	qmp->rx = base + offs->rxa;
>> +	qmp->tx2 = base + offs->txb;
>> +	qmp->rx2 = base + offs->rxb;
>> +	qmp->pcs = base + offs->usb3_pcs;
>> +	qmp->pcs_usb = base + offs->usb3_pcs_usb;
>> +	qmp->pcs_misc = base + offs->usb3_pcs_misc;
>> +
>> +	ret = qmp_combo_clk_init(qmp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");
>> +	if (IS_ERR(qmp->pipe_clk)) {
>> +		dev_err(dev, "failed to get pipe clock (%ld)\n",
>> +			PTR_ERR(qmp->pipe_clk));
>> +		return ret;
>> +	}
>> +
>> +	ret = qmp_combo_reset_init(qmp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qmp_combo_vreg_init(qmp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int qmp_combo_probe(struct udevice *dev)
>> +{
>> +	struct qmp_combo *qmp = dev_get_priv(dev);
>> +	int ret;
>> +
>> +	qmp->dev = dev;
>> +	qmp->cfg = (const struct qmp_phy_cfg *)dev_get_driver_data(dev);
>> +	if (!qmp->cfg) {
>> +		printf("Failed to get PHY configuration\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = qmp_combo_parse_dt(qmp);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct qmp_phy_cfg sc7280_usb3dpphy_cfg = {
>> +	.offsets		= &qmp_combo_offsets_v3,
>> +	.serdes_tbl		= sm8150_usb3_serdes_tbl,
>> +	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
>> +	.tx_tbl			= sm8250_usb3_tx_tbl,
>> +	.tx_tbl_num		= ARRAY_SIZE(sm8250_usb3_tx_tbl),
>> +	.rx_tbl			= sm8250_usb3_rx_tbl,
>> +	.rx_tbl_num		= ARRAY_SIZE(sm8250_usb3_rx_tbl),
>> +	.pcs_tbl		= sm8250_usb3_pcs_tbl,
>> +	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_pcs_tbl),
>> +	.pcs_usb_tbl		= sm8250_usb3_pcs_usb_tbl,
>> +	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_pcs_usb_tbl),
>> +	.vreg_list		= qmp_phy_vreg_l,
>> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>> +
>> +	.has_pwrdn_delay	= true,
>> +};
>> +
>> +static int qmp_combo_xlate(struct phy *phy, struct ofnode_phandle_args *args)
>> +{
>> +	if (args->args_count != 1) {
>> +		debug("Invalid args_count: %d\n", args->args_count);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* We only support the USB3 phy at slot 0 */
>> +	if (args->args[0] == QMP_USB43DP_DP_PHY)
>> +		return -EINVAL;
>> +
>> +	phy->id = QMP_USB43DP_USB3_PHY;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct phy_ops qmp_combo_ops = {
>> +	.init = qmp_combo_power_on,
>> +	.exit = qmp_combo_power_off,
>> +	.of_xlate = qmp_combo_xlate,
>> +};
>> +
>> +static const struct udevice_id qmp_combo_ids[] = {
>> +	{
>> +		.compatible = "qcom,sc7280-qmp-usb3-dp-phy",
>> +		.data = (ulong)&sc7280_usb3dpphy_cfg,
>> +	},
>> +	{ }
>> +};
>> +
>> +U_BOOT_DRIVER(qmp_combo) = {
>> +	.name = "qcom-qmp-usb3-dp-phy",
>> +	.id = UCLASS_PHY,
>> +	.of_match = qmp_combo_ids,
>> +	.ops = &qmp_combo_ops,
>> +	.probe = qmp_combo_probe,
>> +	.priv_auto = sizeof(struct qmp_combo),
>> +};
>> diff --git a/drivers/phy/qcom/phy-qcom-qmp-common.h b/drivers/phy/qcom/phy-qcom-qmp-common.h
>> new file mode 100644
>> index 00000000000..71356fb7dd0
>> --- /dev/null
>> +++ b/drivers/phy/qcom/phy-qcom-qmp-common.h
>> @@ -0,0 +1,62 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef QCOM_PHY_QMP_COMMON_H_
>> +#define QCOM_PHY_QMP_COMMON_H_
>> +
>> +struct qmp_phy_init_tbl {
>> +	unsigned int offset;
>> +	unsigned int val;
>> +	char *name;
>> +	/*
>> +	 * mask of lanes for which this register is written
>> +	 * for cases when second lane needs different values
>> +	 */
>> +	u8 lane_mask;
>> +};
>> +
>> +#define QMP_PHY_INIT_CFG(o, v)		\
>> +	{				\
>> +		.offset = o,		\
>> +		.val = v,		\
>> +		.name = #o,		\
>> +		.lane_mask = 0xff,	\
>> +	}
>> +
>> +#define QMP_PHY_INIT_CFG_LANE(o, v, l)	\
>> +	{				\
>> +		.offset = o,		\
>> +		.val = v,		\
>> +		.name = #o,		\
>> +		.lane_mask = l,		\
>> +	}
>> +
>> +static inline void qmp_configure_lane(struct udevice *dev, void __iomem *base,
>> +				      const struct qmp_phy_init_tbl tbl[],
>> +				      int num, u8 lane_mask)
>> +{
>> +	int i;
>> +	const struct qmp_phy_init_tbl *t = tbl;
>> +
>> +	if (!t)
>> +		return;
>> +
>> +	for (i = 0; i < num; i++, t++) {
>> +		if (!(t->lane_mask & lane_mask))
>> +			continue;
>> +
>> +		dev_dbg(dev, "Writing Reg: %s Offset: 0x%04x Val: 0x%02x\n",
>> +			t->name, t->offset, t->val);
>> +		writel(t->val, base + t->offset);
>> +	}
>> +}
>> +
>> +static inline void qmp_configure(struct udevice *dev, void __iomem *base,
>> +				 const struct qmp_phy_init_tbl tbl[], int num)
>> +{
>> +	qmp_configure_lane(dev, base, tbl, num, 0xff);
>> +}
>> +
>> +#endif
>> diff --git a/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h b/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
>> new file mode 100644
>> index 00000000000..396179ef38b
>> --- /dev/null
>> +++ b/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef QCOM_PHY_QMP_DP_COM_V3_H_
>> +#define QCOM_PHY_QMP_DP_COM_V3_H_
>> +
>> +/* Only for QMP V3 & V4 PHY - DP COM registers */
>> +#define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
>> +#define QPHY_V3_DP_COM_SW_RESET				0x04
>> +#define QPHY_V3_DP_COM_POWER_DOWN_CTRL			0x08
>> +#define QPHY_V3_DP_COM_SWI_CTRL				0x0c
>> +#define QPHY_V3_DP_COM_TYPEC_CTRL			0x10
>> +#define QPHY_V3_DP_COM_TYPEC_PWRDN_CTRL			0x14
>> +#define QPHY_V3_DP_COM_RESET_OVRD_CTRL			0x1c
>> +
>> +#endif
>> diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
>> new file mode 100644
>> index 00000000000..d7fd4ac0fc5
>> --- /dev/null
>> +++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
>> @@ -0,0 +1,34 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef QCOM_PHY_QMP_PCS_USB_V4_H_
>> +#define QCOM_PHY_QMP_PCS_USB_V4_H_
>> +
>> +/* Only for QMP V4 PHY - USB3 PCS registers */
>> +#define QPHY_V4_PCS_USB3_POWER_STATE_CONFIG1		0x000
>> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_STATUS		0x004
>> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x008
>> +#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL2		0x00c
>> +#define QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_SOURCE_STATUS	0x010
>> +#define QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x014
>> +#define QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x018
>> +#define QPHY_V4_PCS_USB3_LFPS_TX_ECSTART		0x01c
>> +#define QPHY_V4_PCS_USB3_LFPS_PER_TIMER_VAL		0x020
>> +#define QPHY_V4_PCS_USB3_LFPS_TX_END_CNT_U3_START	0x024
>> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_LOCK_TIME		0x028
>> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_WAIT_TIME		0x02c
>> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_CTLE_TIME		0x030
>> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_WAIT_TIME_S2	0x034
>> +#define QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x038
>> +#define QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x03c
>> +#define QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x040
>> +#define QPHY_V4_PCS_USB3_ARCVR_DTCT_EN_PERIOD		0x044
>> +#define QPHY_V4_PCS_USB3_ARCVR_DTCT_CM_DLY		0x048
>> +#define QPHY_V4_PCS_USB3_TXONESZEROS_RUN_LENGTH		0x04c
>> +#define QPHY_V4_PCS_USB3_ALFPS_DEGLITCH_VAL		0x050
>> +#define QPHY_V4_PCS_USB3_SIGDET_STARTUP_TIMER_VAL	0x054
>> +#define QPHY_V4_PCS_USB3_TEST_CONTROL			0x058
>> +
>> +#endif
>> diff --git a/drivers/phy/qcom/phy-qcom-qmp.h b/drivers/phy/qcom/phy-qcom-qmp.h
>> index 99f4d447caf..06dac21ddc4 100644
>> --- a/drivers/phy/qcom/phy-qcom-qmp.h
>> +++ b/drivers/phy/qcom/phy-qcom-qmp.h
>> @@ -12,12 +12,17 @@
>>   #include "phy-qcom-qmp-qserdes-com-v3.h"
>>   #include "phy-qcom-qmp-qserdes-txrx-v3.h"
>>   
>> +#include "phy-qcom-qmp-qserdes-com-v4.h"
>> +#include "phy-qcom-qmp-qserdes-txrx-v4.h"
>> +
>>   #include "phy-qcom-qmp-qserdes-pll.h"
>>   
>>   #include "phy-qcom-qmp-pcs-v2.h"
>>   
>>   #include "phy-qcom-qmp-pcs-v3.h"
>>   
>> +#include "phy-qcom-qmp-pcs-v4.h"
>> +
>>   /* Only for QMP V3 & V4 PHY - DP COM registers */
>>   #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
>>   #define QPHY_V3_DP_COM_SW_RESET				0x04
>> @@ -112,4 +117,16 @@
>>   #define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
>>   #define QSERDES_V6_DP_PHY_STATUS			0x0e4
>>   
>> +/* QPHY_SW_RESET bit */
>> +#define SW_RESET                                BIT(0)
>> +/* QPHY_POWER_DOWN_CONTROL */
>> +#define SW_PWRDN                                BIT(0)
>> +
>> +/* QPHY_START_CONTROL bits */
>> +#define SERDES_START                            BIT(0)
>> +#define PCS_START                               BIT(1)
>> +
>> +/* QPHY_PCS_STATUS bit */
>> +#define PHYSTATUS                               BIT(6)
>> +
>>   #endif
