Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2FD606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xf8Sux9R;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=E9dAWZsi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 521B960711;
	Mon, 23 Nov 2026 17:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eXjNsH44WMRO; Mon, 23 Nov 2026 17:16:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 99E6B60681
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795454163;
	b=GH3C3mOw5mlqtiT7Z4cwlRTR7LVxiFjiUuCftPCQUYa4+1XTURV2oAJNDRoM3LfwUhhl
	 ZMrplraRtNgbNgEfp72LFdM5GqE7u514DtP19CYUPp9bffLKY2Xwmq93jOa6UD4+xrtXm
	 pRMg90MdA+GYThjFhYsSAu1W0tu97dySHI89+dJg6+B6QFXkt3e+PXWj9J0Yd061pfWcy
	 bYXAxiKu2zfhrpQCHz+TpdkPxrxgjlWVQMYahqwJ7BhAjivy6sSnWWoq8TybnBy3O+36G
	 ZFWC2FiSFmoJX80KZfuMqp3zBzgEJw90Dp8t9nUSZkMNhymFih/E41ghQNV3ZvUvn2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795454163;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=NfPWfwPLJWrP37ex+xhHIbA3gBnmKEI/6hcJpq6bYks=;
	b=cdsd3DkTi7C8yosPCqLRplCI7Mj9OxMGgipNZ4oPtCxPuFl8DjgX8FeXTvhqqCR6mz90
	 e/AaSsT7CnAH8gsrPsXnP3SOltHNcyjJ61YnBPc1IDyfgrpjtDM2Z2doPnUjrWv7yx1Id
	 akfFRAOFqphdiWCJKb68yzlAnKK8JUPYl1Z3+q3UZIJ7CVjT/vnAaXVP/2t33w02K2UdL
	 PcON6yKgiLLL+/LN6L8hdHdbAJFS9KV78YtgiDZanxev/T+f7COCTxBd0biGYjqL//k+U
	 Jn96locfbjI15/0bUwdFez28Z12Hx03avEsiHreTbrpnM59HuNjVjsboQWTHsCCtDkQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795454163;
	bh=NfPWfwPLJWrP37ex+xhHIbA3gBnmKEI/6hcJpq6bYks=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Xf8Sux9R7rz6Od76cAsFsrsJdOd7uipukjbyS6y4pjRQ0T5aKs2zr6FTs51FfACjU
	 7NhRmWKU1yiIGwyw/mz0mTa7sIZ2hv2YcTk8DGSHMjEueqTd6MzelouiHuMwhtBlbQ
	 574V8oFvjLuaGrP/upkGq/bN6+XmQrP0geupIVeOfzGyc5BY8sD94lOrWCwOEBe1ZL
	 eVCmoPD9uqeUvuJWMF9hNex04pIKWDqCQi5AMSkdbVMYHvPXjy9aa6ZQjbvXfIRy53
	 HpOmOx9SBrSSHB45WFDFTGjmd8MYieItPS6mJ+zOL6uDJrAEx/GODKIGMYsG/MTq83
	 kqkqWHH1EeN6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99E6B60681;
	Mon, 23 Nov 2026 17:16:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 53FAC759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38AAA80CE8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0C23LQnA_fSA for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 17:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C42580CD8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=E9dAWZsi
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C42580CD8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 17:16:00 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so2734288f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795454159; x=1796058959;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NfPWfwPLJWrP37ex+xhHIbA3gBnmKEI/6hcJpq6bYks=;
 b=E9dAWZsiU8UnTU1Y3PcWBfWu/PFG6bk+ZMahPPwAmg59+3af0ykmXGyBsT5hvfx7ey
 4tr5LsQXbt6UVR0LY7z4AFqc8/N/hg/cnMU/vd93KczlryPFa8+AXFt4MTEiL39DYYev
 mb6trXhuZhXswy26Rhc8KDI9IKv3G1ym4WgsskPVeAQ+sS947WinFP6u2YDeJFkImnLo
 BjjzWWcpA0FY2XAWxWbPZE0LftiG7LPcnSdR4GaB7CCiuRFXKKjVIdfm4Pk3/1Q25c6f
 1IZTymhMhn5d81uckgx+VEnKxF+5SLMfolau8wFANUDBnn67Y8TVJQdGXInA0QG6vdkw
 qjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795454159; x=1796058959;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NfPWfwPLJWrP37ex+xhHIbA3gBnmKEI/6hcJpq6bYks=;
 b=0MapZiln8V4oMzncdiz54thndtxUs0sSxnW0cVWmOTlSg+n+/a6bEaRKXV53jnc4AY
 M6+GJapZ7ewcr0ZuS+LpJQtCcZmKTanr6g8e/E10K8WSknZVzYMZ7VmQX7sLZYOCDwjw
 qBoK8wqAFiCb66AjTIzZwBzOMICCdzp3vCvdHl2WyX3OjvEmwHHTpf7iKgsc6XmCPZS4
 dm6Zkn7p+T/OPeazWcPlQ33UZnsU95ih9+c5PxTt1LrAA031qUy4lBx/OTwKvNPOZoaO
 0yn919BWhAkT/UcAwb8J/wdHazYQhVYPYYE1ulwk5ge03rmLOVneh7pWDexBMYVmk1gZ
 zyIw==
X-Forwarded-Encrypted: i=1;
 AL+hErEJaoOKLlBWGhMum2kWihU4V45f2+2pqxSl+SuFQB+PoOLLCHUHnOUyRA//46b4HYXAQMCqA4Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8X4gG04PepXEFJ9iBzxFCsjH8efMSouhqHBS9gMkYg9w338tmf
 p1OADPUsdhiW6A72NfxFYooP2Otdx8zKOtgG6GnTyznnfYFDNz7H42S4ORYwFkgTThM=
X-Gm-Gg: AZFdTZe346BM3dIoiBZnJvGFsRZ/m3iC2pk+tPNVfYBNbCxn3ZEvovu9/P8vD4NKbT+
 3IgDQCWLoMZhGMazcPXYpGjU57HiDo6MNyIkDX31ziRp01BDsBQ3oIn5z+u4ykxn7vETFPWgdcy
 fmDRJoq67q9NAWkkn5lA5Ch32MQmMOr9RagTq07Koh6THWkpfyB3vLw2AWWiMtWaz6QAsd5x5PP
 UXHvn+Az0D405tcuPXh/dg4RVEc14xxOlPGx3Uw/At0dzj4Fm6Puhev0PEmWQWDQ4WiAnmtPJX6
 K7gnVRPqMt0KJYPlF7zDz9bR2AhNakBISa/x5nycJvsuLD4uP9lK8bBrLtGPgdjny5dYa8RMQ6P
 h0y0UL85CBkrRZjAqvfFarpnNg5iqH4Mp6PxfLPSrl5+IDqYzInNtzO3gSAunSbC15BB5jhbZwC
 2ZYy/3JJK9nyy34j9AF5pWKUv8a9zTfe9l+Lt5L5BhhuJ4N0wGR9WIGCzw5yplMuN0jDkWHNNnS
 ZFvxTZ4BPtxADXmij4eRuU4gnSTZXTzL4IJaEsHzqBTxymgczwNsH9NHZSoR9j8BtfBqt55qPqR
 qbmCxOYyM7ZmMqWu58CsKNqzKt2hLgTwfJuoS8Th74+dkw8MZEVEMHUsRoIBQPmsLi25F2TtoYi
 D5jhCdHkLBF17ALlOOJSznOloMZguR6c=
X-Received: by 2002:a05:600c:64c7:b0:4bb:872a:f500 with SMTP id
 5b1f17b1804b1-4bb887c2697mr268637825e9.3.1795454158843; 
 Mon, 23 Nov 2026 09:15:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:f4dc:7806:c7b4:be9c?
 ([2a01:e0a:106d:1080:f4dc:7806:c7b4:be9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm22819300f8f.47.2026.11.23.09.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:15:58 -0800 (PST)
Message-ID: <ec515554-fe59-4d6b-b889-80a5974fe7d2@linaro.org>
Date: Mon, 23 Nov 2026 18:15:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/7] ufs: rpmb: stop the model string at its NUL
 terminator
To: Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker
 <jbx6244@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
 <20261116-genio720-ufs-rpmb-minimal-v2-2-b64eefcfb0f6@baylibre.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261116-genio720-ufs-rpmb-minimal-v2-2-b64eefcfb0f6@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 21:45, Carlo Caione wrote:
> Some UFS model descriptors contain trailing UTF-16 NULs. Converting them
> to spaces changes the RPMB identity, whereas Linux stops at the first
> NUL. OP-TEE then derives different keys for the same region in the two
> boot stages. Stop at the terminator to preserve a common identity.
> 
> Fixes: 87094d8062bd ("ufs: derive the per-region RPMB CID and size for OP-TEE")
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   drivers/ufs/ufs-rpmb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> index 508eb74d976..8b61760f071 100644
> --- a/drivers/ufs/ufs-rpmb.c
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -270,6 +270,8 @@ static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
>   	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
>   		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
>   
> +		if (!c)
> +			break;
>   		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
>   	}
>   	out[n] = '\0';
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
