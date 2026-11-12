Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1C606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uDFky/5k;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LGyMCM8e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE95A607E9;
	Thu, 12 Nov 2026 16:21:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TlZVR2k790tN; Thu, 12 Nov 2026 16:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2A44607DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794500506;
	b=PnQrQ2W0s791KsZyxhwzxOCTB47fu3czLkY8zKOd7FlvxUyOe2kqeQVdsWEcP/9JvUt+
	 xsqH+ppGIsnyrQt7pL1scyBM/YxR7leJI8cxcjlDA8bhXWUshTiCoIn9jd41isRCFVmL8
	 LeqYGmwrrgae0R2n+X4kuFOiJwo+mjXxbu6sT3S3RPePfnbjI1W2oeVkaJWMS5T3yKkrc
	 q8tAbg9LXX71iFPrxeDCkfYpL1uRlNRwtoDCoIScmDRnjsR+Ue+S8ZDc+iF/9uIYQFbXt
	 Vir1Mnt6FPd+DAcvA1WW1m6hEbqg8pnlCpLnlQ7AxPVxFQAk2AvIVN3c5Awjzvd8YlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794500506;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=l7btu5AtFDaHluw2bXPxfBM9BEQk0fts74t1iBERlIQ=;
	b=UbLPi/4wd80Nyge6PBJQWN/JnDFTl3WnP/TJrhgnUNOGf26NC2NcrzQI/CzYNcDo1UyI
	 URk44Ltkdt3LqsAXtb4BWW8SQbVIVNyu9MnZ5siRVN4goPlUjHVJPV8bWr2OXbbelQN1A
	 5LhuU+zn6JhlAJ4oaYYJl+kwA+VR24FK9joF6oxcW6Fo1y71YGJ/HNoYfbL6DQ0PeFXXT
	 slA9PR5NuVFKN1foxLGoX2MD+cuMG9XSAYYUr7hxmsb9sKFzB8kQSxNfLp9w9NVM+TBAz
	 YwDw7NRPqt+sKX2v1P2+o4aHnYHWj8cgznmnNL1AaOZrdM9NvXb6//GjoOU8Pz3fwjQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794500506;
	bh=l7btu5AtFDaHluw2bXPxfBM9BEQk0fts74t1iBERlIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uDFky/5kt0pNAQHJ1DkKfVl51WMVxlKGZAMl9Dwz33JFjQO22NdT32O2LcjImXj0t
	 DAGoMmsrBmUcTL3Y/K+Ot1cg/vayJMbC7DRzRxY8d7rM5IgWSfEdLOqkvfrVPhMgw3
	 57aQptiiKOcNnE1EkNueH9jPC1KGhO18bRjCguJziVF+YSnlO6SZ2/QlFlAPI1bUTt
	 zm8zLCDQmkBI46Ars/e5uP0bB9OyWngyAQTd769dxZSrvoGcuYvCtJlu40Ht95yS/h
	 G5hhx/yK6WR8xPNDBGqpghw4p98mAaP+aV8EddEZxxsFICiRDe1sqyip60JqA9IKTX
	 gEmij30N2e2Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2A44607DA;
	Thu, 12 Nov 2026 16:21:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EBC4235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0021D4087E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qId6FB1wP7bZ for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 16:21:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A04C640842
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::9;
 helo=mail-wm2-x09.google.com; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LGyMCM8e
Received: from mail-wm2-x09.google.com (mail-wm2-x09.google.com
 [IPv6:2a00:1450:4864:31::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A04C640842
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 16:21:41 +0000 (UTC)
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-4ad5d6045d4so21116975e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794500500; x=1795105300;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l7btu5AtFDaHluw2bXPxfBM9BEQk0fts74t1iBERlIQ=;
 b=LGyMCM8eNt2vv95YFlh873NyOgqVJEKRjJ+FmLno9mMH5GaPosbF5yd4BWc9J4bp/K
 uXFr05V5/wJ2vxYyn/xDPlPOliz5EwkH57NvFIkuywNcg1i6ip/thDwgnafnmfXeaYGe
 JYz50WuxKa7RzWirmKv7qzwGfGmwd4oqAKV7jnPy9ZNKnVwvMzk82ZlIRM879haJKS5t
 Qk3sJv75FdkRwwdDFHLC+Bh27ykouDT3/7CzQu+nWBKDHmEddvCot1R4znnuAN/mZlxu
 gP7crA1aEe5hKlBMALwjzaGG7ay4402C2CId2N6ABiTA8w73pKW/fFDWV9QVpbqAlUAY
 Ev5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500500; x=1795105300;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l7btu5AtFDaHluw2bXPxfBM9BEQk0fts74t1iBERlIQ=;
 b=1yCGLVqHpfLGdK88nMhC3JoNF/FTBSpvNuFlMkd2Xb8vUF8pQtW1xmDSh8gQddyY9g
 FmD6PNS2Sv0qQRnD+5GvlMJtYPPzlB2dI1VDecNDxGuv7Vdl1TLRZfkDWrKBcGmEjh/8
 QalI48nKhmmVfpMXI59hppzScF7l5fR5D0A4P5FKuwM2nMGsJTCiW11R24hiKKC+MPUD
 BZZnjALsR4QY6m20Sek3Xwip/Je0ebpM77noHkMYyb7mar/hnILDo71LFoz9uxu7RPFx
 0N7RgbgIVwWIUsIM55LmScGld9Asix+iaFZ2YzJLFkArFppxU3m5JcVS9NzKKLYaVZRl
 vguA==
X-Forwarded-Encrypted: i=1;
 AL+hErFWneCbp8sMSWMEXvdB9E7Al5PkvMjWprXfU/3ulKMtMmA4FxFudVVRMVZCxosfezhbOGpQ/3E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+O0JLHjY4sLPcEMhD9pVpDCFmr5OLYV2d+EWMEALKg7q1BVUFp
 M+vB7muD2/fhuew/odP1Xqm2vZY2q0yoz3S/l+1NOVldxJwKhQPnaYEMOzbMF6mHF4E=
X-Gm-Gg: AYBFou3T28zC9HlcJE4VSsf2GTNinNJHSCLY2jsNCTYgymMUId8KGMMADfLSVSn/nL8
 uTq8vKrq52IA1wlSYvpKDiHvLFwNCJD+9P2ZLjnH78nrSdziq9+r/MX2LCIVYMVBxQHy2IOG/Bl
 GtuzKPypganTQqh5Pv1NgFljJkAnxpXS6u6aWU7VXOB83kT57jd/VPOb4uO4I554UPbOSZj1X97
 AINndSpqs5rGoKrwJPrtABTb1cw9qNUKtX5V+SyN9BNBUIPxxZ6xUKCLG0tFp7oAGCQKrDxo2JU
 O78aMCYt9OSyRl/VW3iNQ34bzpM6/2KdRt4+6vCVAM3OfsEesTL2Z6YrUEDPxCIPMrBSY5+D/em
 CwTWPiwODgdkt8+/NC+94lSyzWjCnnfz9oXFS6KoCeR8L0Li/TvySRmLpvUg46qNWlomLAwovbe
 PwWlfzWecEBuP7pBeLTL7eNH1sjDFh+tqG6XqbMNeFRQlif+Mwp1Y1XL75sfa3VA+0eNSNro9lr
 cnbt2B+Aya0eReoUFskbxoj/eVcgza/zM+I/SehqZk02xOd7kEssHeuKnpT23AT57uFhkKBSJCb
 AHCujwyJD04Bs4H9bYpQ2TuqW2Uke2MhQwp2lgHzw56KxMXMUZ+uwIypIKNXCDoBk8X0nzH1rqL
 0Y3xn3e/8x+t2RxA=
X-Received: by 2002:a05:600c:1c22:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4ba093b5bdcmr137905415e9.17.1794500499748; 
 Thu, 12 Nov 2026 08:21:39 -0800 (PST)
Received: from [192.168.1.37] (p549d4ba8.dip0.t-ipconnect.de. [84.157.75.168])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2842e6sm79259795e9.4.2026.11.12.08.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 08:21:37 -0800 (PST)
Message-ID: <a2b6bc3d-db58-4882-9964-ae0a1fb218e1@linaro.org>
Date: Thu, 12 Nov 2026 17:21:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] tools: qcom: mkmbn: Updates to support ipq5210
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
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



On 06/11/2026 07:07, Varadarajan Narayanan wrote:
> As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
> the mkmbn script has to be upgraded to create images that can be used
> in the ipq5210 SoC.
> 
> These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
> bringup' series [1] to use mkbn.
> 
> 1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/
> 
> While at it, fix the MBN version number for ipq5424.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> 
> ---
> Changes in v4:
> - Drop sm8550 full defconfig and instead add a config fragment in board/qualcomm/sm8550.config

why this change? let's keep it consistent. please resend the defconfig
patch standalone, i'll pick the others here.

> - Remove SPL_TEXT_BASE from mkmbn.py error mesage
> - Link to v3: https://lore.kernel.org/r/20260917-ipq5210-v3-0-d11dc3e8b16e@oss.qualcomm.com
> 
> Changes in v3:
> - Fix review comments
> 	- Add CONFIG_QCOM_GENERATE_MBN to qcom_sm8550_defconfig
> 	- Remove load address from MbnData and for all entries in boards table
> 	- Remove '--melf' option and modify the 'bin' argument to take
> 	  multiple files for combining into multi-elf.
> - '--melf' was actually not removed in v2, but included in revision
>   history. Apologies for the mistake.
> - Link to v2: https://lore.kernel.org/r/20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com
> 
> v2:
> - Remove 'load address' from MbnData and get it from .config
> - Add qcom_sm8550_defconfig
> - Use 4K alignment for padding the MBN images
> - Remove '--melfs' option and make them positional
> Link for v1: https://lore.kernel.org/u-boot/20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com/
> 
> ---
> Varadarajan Narayanan (4):
>       tools: qcom: mkmbn: Fix ipq5424 MBN version
>       board: qualcomm: introduce sm8550 config
>       tools: qcom: mkmbn: Add support for ipq5210
>       tools: qcom: mkmbn: Add support to create multi-elf
> 
>  board/qualcomm/config.mk     |  2 +-
>  board/qualcomm/sm8550.config |  5 +++
>  doc/board/qualcomm/board.rst | 12 +++++++
>  tools/qcom/mkmbn/mkmbn.py    | 85 +++++++++++++++++++++++++++++---------------
>  4 files changed, 75 insertions(+), 29 deletions(-)
> ---
> base-commit: 914dd2f5d18a3a89e4ddb6d1d97b2743618ae5ee
> change-id: 20260714-ipq5210-52e1da5af9fc
> 
> Best regards,

-- 
// Casey (she/her)

