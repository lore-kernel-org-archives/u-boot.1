Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F376606A31D
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fSPWbgL+;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MhE7zHIA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6360F811D7;
	Thu, 22 Oct 2026 22:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JePx8biGJJXz; Thu, 22 Oct 2026 22:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B053811DA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792709979;
	b=imFVSRNHoKWWl8eEXFmfiUSOkJWez8oyNEl7HfuxVielp9m8Vx3GVQP0o9ft6DN9VJwZ
	 wFvpUjoDP1dP9h9kVrYX7K/ldw1385MNNya7B7H5+tjAeXnoVUgoNiBiRv2T41bKJ64UY
	 MtWFG0DjQjwZI9naSR+7mohNy92xxTI1iw/QxAAACRpD/qKpEeftu1UIVp9kFANKnlVDO
	 Bkl+6KIIjh77JV39GLDWrkEUGogtJwkegtBRusOztGYohAHaA6Wxhmjyi5cTenLoyz9WC
	 4088UiSn7HghYF2C8leqRE8aOnIk5/t/7xNzE4/1+bFlepO0UQ5C0dw0QIXvzs8Z+UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792709979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aHQhHUOO0OHjrWLfck8cS4GeFmG/s1oig6aykyW7jNA=;
	b=nYWiWIEdxn4galls9DZNqm/hcv8pOsgfyYKiv07VRnaROz1ONJeElfAjAx17YBgvdrDS
	 dOvgAFdhgoSn0MPbM8VhAwQeIrmPZId0/DjjX2FBS+quXjWcSdfnPhYVf6aZycNpmOUte
	 hyq8sDuNK2+Slml7Wkj81AgxLK36mudgigI1sFBveWo1Z0lkIrMdUyRw+a42ehoh/sDuX
	 1vNEAl2wA5T8T1+9gIPRMvFZnvuEytacENnngiM9IGsH5CtdwkeQa6Nx02eB+orZ0LPs7
	 UGaSM9NbYkIt2B+vCQ8J2bUZYBKANAILDNssq7KuMddrNX80mubtUBgCBsiqZYDlffQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792709979;
	bh=aHQhHUOO0OHjrWLfck8cS4GeFmG/s1oig6aykyW7jNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fSPWbgL+wh+wqBBQaBEbxaA86FS1JUn1WJlq8dW7ll3muhBLZ5Gu7kVc8P5/AzsVM
	 fBmlroJIe2RadIENKD8lA3FJRgFae6qA+bQQ5mmWqirF0qbR3cQOdY70opkfz/dkCg
	 ditn8bLQfWyjp2OAYopx+CBIXJw6xDrilmrQjNoX5ovsWizx6Zy0KO4+1b0pmqZJLO
	 hTZKgx4h8w/A6pLZ2Nx4ElpMMo651m0G2pG5SUXAYI+6i+1HJTh2CVlHX6/JBRxVEX
	 WAwovSlzpvvuPd4r/VXxD9V2kktrjI3ahJS3DIML6SaYI6s3sBTd4x+gTR8IBaKLwJ
	 dv7kveBWE8JXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B053811DA;
	Thu, 22 Oct 2026 22:59:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E15549D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33D51409F8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LAQgqhMDNjl for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 22:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2842E4068F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792709977;
 b=WLTn6IK26Pz0pDML1P7auVpvlqdrRl4BVVL+iAwPTWztb9yLCq60oUlx+iCaUt9Rr9B0
 T6TMsxuwYhtHms/NeY0sGCLRp1mZyqKR53Dt/M8k1mX4N2SWcj4MYke/wfU2Zcu+GRZgh
 Z3OU1yGvtWmQX1sHf9FKuDVapMntMZ41UnN5BjTfyqxaVJg1v1SH3rX3DvxBOCu4INYZx
 SQNqbC4qRa1BUND8GY+NPdHKcnt3r8k5Lz1Ord2h9MY4gW5i2D21vDMBhh1wy72nXoruK
 5F5HNRlXVZH1Sc/J6ZS6uoMs+EzDlNsCkaITp8XD3NZE8nNp/DoyF7QeeFRZcMxuR0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792709977;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=aHQhHUOO0OHjrWLfck8cS4GeFmG/s1oig6aykyW7jNA=;
 b=Rc0S5YyD/rhgGBhosLTjGw5pmi3l3BuTcSLYxRn2jzry8JRIpnkWlh4MFeVqEpABO5Rd
 V5FfBqQ7/nyyczjXvBQy8bJyjBtAdgjll3L50vWhIOSiwpK8ZDt8/9hiyH5Xi2pPTb4cP
 vcxbKjo16S6PaL36Hnh/F44z1qa7Q2yPiwOWONpyJtgT4DNC3gKemKrQoqvsruMpOl9o7
 F+HD787oTsTwJGRSWmIua9jQbpvxwNz63G7btIGBSdXEp5tDZf9U47QKxLyrpAEEKbN/j
 CFVkvKnBPbjOlKmhIm/VLK9U16LJ6pLBg7NoNexEJkIzyMlxgX1vGxvuQ9ukoZToCsw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=MhE7zHIA; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MhE7zHIA
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2842E4068F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 22:59:35 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6de1fd5f572so162098eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792709975; x=1793314775;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aHQhHUOO0OHjrWLfck8cS4GeFmG/s1oig6aykyW7jNA=;
 b=MhE7zHIAc7CvnuNoCFMTdJb4JjZKGiI2VenIF1fMxKkL1HroZEoUgSLCirBVQLcFze
 SxOaInOfNx4i+DnTysBiMx4JLWbMRAHH4uAhxoun7wour+5mD5GaUfMSM2phE6atlHO2
 0Jz+VRN/OpXbJOcxHXVTI+t3jakPYOozbG1M7ddbpZ4Wjhd0oMzqUsfmbSyDrSzFK1fO
 hgg0f1akIaxyQ2KIUqqlVZxJBzQEflFuzny58JlwZb1rbsH2UuuTNQcSlaNzlPJJBz6f
 VY59CRDYmefZiplQL4mMS1bXEq+PdX7cDXrGZi+EdZcV2WwEwGD817zGnndVAuef2QJg
 bzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792709975; x=1793314775;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHQhHUOO0OHjrWLfck8cS4GeFmG/s1oig6aykyW7jNA=;
 b=bOGS4V0JlQZx5ZOV4+F9mtXlexdACUhf+WUFwKcI/Gb0s1kvdqu1BqUwllAstq1Fd/
 7SFO/vCAO6BC4e6ZVMb7xPa40+sMtcxY7XSQyHQINisd79Y3NZ2CwTPU8dcZwQHUN59p
 ZDRr/9kfB+m80mGe82DSv0gjPADIVbS0y9KDGESXfLBIXzWzJEFWenfu5beQU1xG0e5L
 C5b9yASGRgcYhk1vURckkL8SceI5AgiF3OwyekNIAEiwFFSjsriSnb9Z7r2mMbSA4aku
 Mjl/sACZF9wJQvzTTeXGbiarqd3ZhQtJ/OtZ80Mv9XzVMtimPInSiKC3nguF++u6pIIK
 jwYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByvFGDQM+qMbXUN+i7I32Z2qhYW3KXHhqnG9KZVMS2hqt136GWfigli/pooxDFTd/7htMiYCbU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNirUc9okhJ2UcNSnoxE7IlmEja8h+npPAFyCm1VgiG9BsNWDA
 hJe0atMFOnDq+kZdDzjKcVKnmdh9okCxaToQVtxMsYf4PApWMqgSLMX/XuHgvY1WDBs=
X-Gm-Gg: AYBFou3i9DYa+zZsX4+rZbquk2kUfzEhabsK9g6mCoHJWqF/NaNSC+vq5Io8J5qlxPc
 I1pIz3jJqafExsMOw0lnWzUhpC6eY+vCW/sh2rnWC97URe+KRQW0gEM7BpBvMcidHFZWeBbCbNB
 olJPdaVA2WWMbbwaMjFknwdAbqjQFMd1fCZasI1LGDxzr0raX6n5y2SQGiQN8pyhzF1oV0RxG0g
 eJ9lkcr0AD9yMQ38fkmbs1xmaCIIytW/BzAA5+6B/18lYiyleRexYAQ+zY6eHMmq8sGgKFBC9Mv
 3er1EPBJvabQn37oLKgNhYXsA+VUsTYQgQsddDLDOe9EZdksBkrtovggsdcyaZduVt9ckiCWoUb
 pk/RaWEQ/TqEMUDlQ+YiSPFHsio+QfE7LMyEU5Zx9zZHGAl2oZeEyCdlSuTrKP/bGBdX0LrZkxb
 3T47HrcQeZX/N800LA9eIj5rma7h8lqsIbyIYz3OYE+ISQJgOupd1+hAxErEw9qI0Ocnhy3tg6r
 ylSNW3+BeAvve3fIU0cNsMumGJEGapYFGT+mm79AxVpYOBG4Y7IjDYdkRsbJPczWCcz9tAcv+qH
 YZyenzBd/ZgeaRVqpu3wDuk6a4apVw==
X-Received: by 2002:a05:6820:1ca7:b0:708:b419:4886 with SMTP id
 006d021491bc7-70b889b8043mr522370eaf.26.1792709974678; 
 Thu, 22 Oct 2026 15:59:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d0bd:a587:44ef:f6bb?
 ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b8b274a83sm427517eaf.7.2026.10.22.15.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 15:59:33 -0700 (PDT)
Message-ID: <ef319edf-5d44-4f08-b318-faafc0778f85@baylibre.com>
Date: Thu, 22 Oct 2026 17:59:32 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] video: mediatek: mtk_disp_mutex: add DVO support
To: Julien Stephan <jstephan@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
 <20261009-mtk-genio-720-edp-v1-6-4fbcf5b2904d@baylibre.com>
 <179188123837.53105.2668338269271705271.b4-review@b4>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <179188123837.53105.2668338269271705271.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/26 3:47 AM, Julien Stephan wrote:
>> Add the MT8189 OVL -> DVO pipeline alongside its OVL -> DSI one,
>> selecting the DVO0 module and start-of-frame source instead. The MT8189
>> drives its eDP output through a DVO stage in place of the DSI, on the
>> same mutex instance and with the same overlay and RDMA modules.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>
>> diff --git a/drivers/video/mediatek/mtk_disp_mutex.c b/drivers/video/mediatek/mtk_disp_mutex.c
>> index 99e46711db5..1a7ea414f40 100644
>> --- a/drivers/video/mediatek/mtk_disp_mutex.c
>> +++ b/drivers/video/mediatek/mtk_disp_mutex.c
>> @@ -51,7 +51,10 @@
>>  #define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
>>  #define MT8188_MUTEX_MOD_DISP1_DPI1		38
>>
>> -/* The MT8365 and MT8366 DSI pipelines use instance 0 of the mmsys mutex */
>> +/*
>> + * The MT8365 and MT8366 DSI pipelines, and the MT8189 DSI and DVO ones, use
>> + * instance 0 of the mmsys mutex
>> + */
>>  #define MUTEX_DSI_ID		0
>>
>>  /* the MT8365 shifts the end-of-frame selector by 6 instead of 7 */
>> @@ -82,15 +85,26 @@
>>  #define MT8189_MUTEX_MOD_DISP_RDMA0	4
>>  #define MT8189_MUTEX_MOD_DISP_DSI0	22
>>
>> +/* the DVO output stage replaces the DSI on the eDP path of the same mmsys */
>> +#define MT8189_MUTEX_SOF_DVO0		5
>> +#define MT8189_MUTEX_EOF_DVO0		(MT8189_MUTEX_SOF_DVO0 << 7)
>> +
>> +#define MT8189_MUTEX_MOD_DISP_DVO0	21
>> +
>>  /**
>>   * struct mtk_disp_mutex_data - per-SoC mutex data
>>   * @dsi_mod: MOD0 bits of the components of the OVL -> DSI pipeline
>>   * @dsi_sof: start and end-of-frame selectors of the DSI
>> + * @dvo_mod: MOD0 bits of the components of the OVL -> DVO pipeline, 0 on
>> + *	     the SoCs without a DVO output stage
>> + * @dvo_sof: start and end-of-frame selectors of the DVO
>>   * @no_clk: the mutex has no clock of its own
>>   */
>>  struct mtk_disp_mutex_data {
>>  	u32 dsi_mod;
>>  	u32 dsi_sof;
>> +	u32 dvo_mod;
>> +	u32 dvo_sof;
>>  	bool no_clk;
>>  };
>>
>> @@ -145,8 +159,19 @@ static const struct mtk_disp_mutex_data mt8189_mutex_data = {
>>  		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_RDMA0) |
>>  		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_DSI0),
>>  	.dsi_sof = MT8189_MUTEX_EOF_DSI0 | MT8189_MUTEX_SOF_DSI0,
>> +	.dvo_mod = MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_OVL0) |
>> +		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_RDMA0) |
>> +		   MUTEX_MOD_BIT(MT8189_MUTEX_MOD_DISP_DVO0),
>> +	.dvo_sof = MT8189_MUTEX_EOF_DVO0 | MT8189_MUTEX_SOF_DVO0,
>>  };
>>
>> +static void mtk_disp_mutex_enable(struct udevice *dev, u32 mod, u32 sof)
>> +{
>> +	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID), mod);
>> +	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID), sof);
>> +	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
>> +}
>> +
>>  int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
>>  {
>>  	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
>> @@ -156,11 +181,21 @@ int mtk_disp_mutex_ovl_dsi_enable(struct udevice *dev)
>>  		return -EOPNOTSUPP;
>>  	}
>>
>> -	mtk_disp_comp_write(dev, DISP_MUTEX_MOD0(MUTEX_DSI_ID),
>> -			    mutex->data->dsi_mod);
>> -	mtk_disp_comp_write(dev, DISP_MUTEX_SOF(MUTEX_DSI_ID),
>> -			    mutex->data->dsi_sof);
>> -	mtk_disp_comp_write(dev, DISP_MUTEX_EN(MUTEX_DSI_ID), MUTEX_EN);
>> +	mtk_disp_mutex_enable(dev, mutex->data->dsi_mod, mutex->data->dsi_sof);
>> +
>> +	return 0;
>> +}
>> +
>> +int mtk_disp_mutex_ovl_dvo_enable(struct udevice *dev)
>> +{
>> +	struct mtk_disp_mutex_priv *mutex = dev_get_priv(dev);
>> +
>> +	if (!mutex->data || !mutex->data->dvo_mod) {
> 
> any reason to check only data->dvo_mod?  should we also check for
> data->dvo_sof?

They both get set at the same time, so if one is != 0, then both are.

> 
> should we also add same check on mtk_disp_mutex_ovl_dsi_enable?
> 

sure
