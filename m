Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518FBCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 11:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 801D880422;
	Tue, 28 Oct 2025 12:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KZvoBaJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD68582A9E; Tue, 28 Oct 2025 12:48:27 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7AF6800D7
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 12:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63c2d72582cso9423024a12.1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761652105; x=1762256905; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y8WpOH19mcLUf40okbMMnklnl4v2m4ja4Nx6xy+bS3I=;
 b=KZvoBaJRFQHuhMaEPDR2cDDC+ystz79TDwUYmokZE6NwtnMkaresjUqu4skyTMwr7J
 xjGWdcoHQ0NCsGq+qdJeCbRac2mOm9c70MLUZcLiQYVGMx0VBl6iaUIhDX77NZxJZDIV
 zKOu6xglROV6JAQMVfeqZgDvfwgcaOmrz/dti+kvzxK/dXkAhtVL7UD3bP9btxp4AR5i
 sd75OqNI50CKSATNbBNMwMGLKnN5bgIuRhVc/J52p4oE1Q041sUP+Psdxwhf1MB1X3SC
 0H8D5bO80/uBkrVV4WP177GThb+g1cPhXtVtbqfARGL431tqDlKHKf7pV/DCvCF7OEaY
 xnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761652105; x=1762256905;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8WpOH19mcLUf40okbMMnklnl4v2m4ja4Nx6xy+bS3I=;
 b=oLsoZ+Zk5HWYaWp/L8tBxu6kZ5oWFaghs/4TwMG8c/2TAXqCU4c/vSJYKeqmOXWukE
 jPGS8d0/ASyuTdvOInqx7MQEnImNQ4FVxPf0betdww3lL9Qc2HBgGgqGs4A6CEwcuHMF
 xsYIrZ8pgXHMwhH9F90KTGenANywx9mznJ5uiuHyWaA/CLAWa4KFDzOd1hhRBtY1T/SF
 g6QBJh9jyM/6+Um2JUa6S6fSpWLc54brsloCRcdBNWwiZkiXS1RYlJZhdRxvEdweAe63
 pdt5/UsbeXW1L2PnW2ULMYWyXrGePDvQDEvTM4u/eYoQpibxGXArrp+fkzmAxZBpkoi6
 1jug==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1gMr+DGLm1X2y1AGKWvYK8TKHQnnu1kCb5R2/zUeW4Ov5hX33Z26DZu61roFewluIj6zs8dc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy69nrYD63xPY//4NiKaoh9oaqNg10n6Tb7+rl5WD9wpO9Apibm
 jhWEj9gIeLapoXxZ/9xk8WkrkVWpKjPXhBKbTYumj1DqSMhQ0KHYunjV5QhffNPcOfo=
X-Gm-Gg: ASbGncuqJxi3hWpjoSQGt/RcBk6H2h9/Wl/HbIq/JFxghX97nhEl7IT/Gw+GlqqIl5G
 h9eQJV3djyhIea2o+pkwgpS5Cb4xM8aHzEWqCBqYIXySRHR4BTqqNW34oX1Zf6ltGMqvzt2RxXn
 n5mFCGUXfnCUFBUH1qGGHPYf5LXmyTlcy/ipEIw81KYXD4F4rUgBnu/KU6PWLILJ8pmR6gQhecW
 t2CaZPPuZ3crfIr7e24O+2n/iQ8W0orXLmLtoXCYPbqdYAwuR8NH4B1HPPVUFDqxqq+l4yiCc+C
 Ncib4Ex/pFlkrbBrMxIPLKykhVsINe34uYmRolnvwvR3afMaa+3QUogLxzXqXtHSq8ho3eR4NfH
 DCOgJiolRp71V0OSIL5y1sX+vhqzUhzBSrwd0gV42YaoVRGQzwoX6D9q4/Qh+7FoU9owRBM7h9+
 8V8FXACCdqbxY65t2F28GJVln/P6xNXobs2HwwDbcu8g==
X-Google-Smtp-Source: AGHT+IECPYahb/nCxYEMyD691WjHRO4boe6tRhtpN3lbEhuycHH41wRxZDeZR1SR+hNEmX9gYIWPTw==
X-Received: by 2002:a05:6402:4315:b0:63c:4d42:9928 with SMTP id
 4fb4d7f45d1cf-63ed7f0f7f5mr2813350a12.7.1761652105082; 
 Tue, 28 Oct 2025 04:48:25 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e67b.dip0.t-ipconnect.de. [91.41.230.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef8288asm9004712a12.10.2025.10.28.04.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:48:24 -0700 (PDT)
Message-ID: <705fdcaf-64de-4eb3-b92d-b3bf78d4808d@linaro.org>
Date: Tue, 28 Oct 2025 12:48:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] soc: qcom: cmd-db: Add cmd_db_read_slave_id() &
 cmd_db_read_aux_data() functions
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
 <20251027113312.3815169-2-aswinm@qti.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251027113312.3815169-2-aswinm@qti.qualcomm.com>
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



On 27/10/2025 12:33, Aswin Murugan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> Partially reverted commit "soc: qcom: cmd-db: drop unused
> functions" by restoring only the cmd_db_read_slave_id() and
> cmd_db_read_aux_data() functions, which were removed in that
> commit. These functions are required for the RPMH Power Domain
> Driver.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
> v5:
> - No changes to this patch in v5
> 
> v4:
> - Moved this change before the RPMH Power Domain Driver change
> 
> v3:
> - No changes to this patch in v3
> 
> v2:
> - No changes to this patch in v2
> ---
>  drivers/soc/qcom/cmd-db.c | 45 +++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/cmd-db.h |  2 ++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index 67be18e89f4..d0a6047b8a6 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -183,6 +183,51 @@ u32 cmd_db_read_addr(const char *id)
>  }
>  EXPORT_SYMBOL_GPL(cmd_db_read_addr);
>  
> +/**
> + * cmd_db_read_slave_id - Get the slave ID for a given resource address
> + *
> + * @id: Resource id to query the DB for version
> + *
> + * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
> + */
> +enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
> +{
> +	int ret;
> +	const struct entry_header *ent;
> +	u32 addr;
> +
> +	ret = cmd_db_get_header(id, &ent, NULL);
> +	if (ret < 0)
> +		return CMD_DB_HW_INVALID;
> +
> +	addr = le32_to_cpu(ent->addr);
> +	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
> +}
> +
> +/**
> + * cmd_db_read_aux_data() - Query command db for aux data.
> + *
> + *  @id: Resource to retrieve AUX Data on
> + *  @len: size of data buffer returned
> + *
> + *  Return: pointer to data on success, error pointer otherwise
> + */
> +const void *cmd_db_read_aux_data(const char *id, size_t *len)
> +{
> +	int ret;
> +	const struct entry_header *ent;
> +	const struct rsc_hdr *rsc_hdr;
> +
> +	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (len)
> +		*len = le16_to_cpu(ent->len);
> +
> +	return rsc_offset(rsc_hdr, ent);
> +}
> +
>  static int cmd_db_bind(struct udevice *dev)
>  {
>  	void __iomem *base;
> diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
> index 1190f2c22ca..16609ac9d78 100644
> --- a/include/soc/qcom/cmd-db.h
> +++ b/include/soc/qcom/cmd-db.h
> @@ -21,6 +21,8 @@ enum cmd_db_hw_type {
>  
>  #if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
>  u32 cmd_db_read_addr(const char *resource_id);
> +enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
> +const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
>  
>  #else
>  static inline u32 cmd_db_read_addr(const char *resource_id)

-- 
// Casey (she/her)

