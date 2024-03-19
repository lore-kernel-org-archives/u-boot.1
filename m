Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B876C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 13:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A80087F8E;
	Tue, 19 Mar 2024 14:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c2jf9xEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BABA8802B; Tue, 19 Mar 2024 14:02:14 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1583987F78
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 14:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso1826465f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 06:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853329; x=1711458129; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LOMSVS57aPfXCUeqi5TNM/NrM5knXE9gf5cGiAzXrFU=;
 b=c2jf9xEhk5Ut4kChbA85hyF1EHSjQ/OWohNcivCrEHpTNm5Izx8a0nWXxDwDoAeE8B
 mlLSpLAFE7AS+S4PWgG0TkX3cixx0Dr2aHIX/oFfFobiW17rIJuThWxrJxIrhIXLKjbj
 /7sOWJVnxicfiV+c/Nn5z+0tEOBLCWVEYORmNp3tGRzjAn7l+I/QrjdSnEdXjhERX0BB
 qrCNmFPTOZ7siYJUuBjGQLFhSvr5qWUTy7cpSJ1JO4Asf9BgLad8RJvdwlOEEo0RbRyQ
 enjt8+N0dTy+ocyE2fIUhO97TtvQa+UbxR15fDqAnL+c9u6wgbzNAYINRxStPjMl0XkC
 mbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853329; x=1711458129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LOMSVS57aPfXCUeqi5TNM/NrM5knXE9gf5cGiAzXrFU=;
 b=pX7Whw8OzSaZ4wdo8UF4JCZXXU/wGwkDi+M05dfFicTnZbuRet4LWqsWwzyMLNScEQ
 c1WyQCR+m+bt9ecGBgq0ynd3lKX/vY5IAt07Ma8jMSsvK/ys4aZK6wXqQjRNpWB72Alu
 mltf5zgqMitsm0EJHHs30g5ET4fFtAVAJAk4RlnPyC/KewGPbzMz0Ku3DRgBcUWnN/u2
 HSAat6/jbQAydD4Dp6MPBooVRcHs2TnqfdIlPABrEE97rH03Bo/nzrU/ZekKLi6kslPr
 R+zNt1yjQ31vh3BAHibEHDu74Xg+clSfE1V1nvke7OO9/j7lp8vZyImDlQ/vYKXP6nKR
 bSXQ==
X-Gm-Message-State: AOJu0YwKzXcdZg+XEVnxhMiUP95idfBnkvMcrF/nr7jWtUukia0CSfje
 oGrsi+q6+dloj9Q7wl1Buu425Zg1c6COx2L5batMBeF/oATTYrthKkSMe/988ok=
X-Google-Smtp-Source: AGHT+IH3uEZs1hol1uiWPhvLuCTC/ZW+svUdiLeu/cV5ANroNbu4wbItmx2C+DxpR3M8r61au7RK6A==
X-Received: by 2002:a5d:67cf:0:b0:33d:2775:1e63 with SMTP id
 n15-20020a5d67cf000000b0033d27751e63mr12105575wrw.41.1710853329571; 
 Tue, 19 Mar 2024 06:02:09 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bs18-20020a056000071200b0034181bea3b0sm2747271wrb.3.2024.03.19.06.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 06:02:09 -0700 (PDT)
Message-ID: <f4d35976-edbd-44d8-a86a-513bfefa6196@linaro.org>
Date: Tue, 19 Mar 2024 13:02:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] usb: dwc3-generic: implement Qualcomm wrapper
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
 <20240319-b4-qcom-usb-v3-1-09ba1f86d259@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240319-b4-qcom-usb-v3-1-09ba1f86d259@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


> +static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
> +				     enum usb_dr_mode mode)
> +{
> +	struct dwc3_glue_data *glue = dev_get_plat(dev);
> +	void __iomem *qscratch_base = (void __iomem *)glue->regs;
CI is not happy with this, it fails on 32-bit builds with
"cast to pointer from integer of different size
[-Werror=int-to-pointer-cast]"

Instead this should probably call map_physmem(glue->regs, 0x400,
MAP_NOCACHE);

I'll leave it a day in case there's any more feedback and then send a
new revision.
> +	if (IS_ERR_OR_NULL(qscratch_base)) {
> +		log_err("%s: Invalid qscratch base address\n", dev->name);
> +		return;
> +	}
> +
> +	if (dev_read_bool(dev, "qcom,select-utmi-as-pipe-clk"))
> +		dwc3_qcom_select_utmi_clk(qscratch_base);
> +

-- 
// Caleb (they/them)
