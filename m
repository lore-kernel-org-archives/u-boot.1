Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFCC5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 15:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91EA382B0E;
	Tue, 10 Jun 2025 17:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IfVR76Iw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3C582B18; Tue, 10 Jun 2025 17:22:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DABD82B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 17:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so2133606f8f.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749568953; x=1750173753; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=omMhdXvjQm1hVx3L9qvaGhE4iGp7trBK3T7e0KPw5WU=;
 b=IfVR76IwHfcJMseVldK29puzUhQ3iQWg65rBzNKV6Qbhs70n+cJSzsIQmDg54wOLX2
 WIU4aYyQccdZQrxmEar9no/rLiw5t9QwfUlFTbi3tXkrhAHednwi2rOMTpab7z54SA3c
 zeGeWNtOLI+eIVj4k9siWMRsDLay1PD7WLs/eUvnQ5/199pT2E2dLlL7pebKkLnY/foe
 5inWP/AGjPczTGsxfLfFFj1SMbVW4ILoPFEWFHyZ+CIpz7vowblh+RpQfo+BdypUSJ0n
 Kz2LPChP2p8uwBi8CohAZmWRzgrFCcbObcWynfXscgSxRn1r9ZwsTkgoAn+qgmRnnhXq
 QO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749568953; x=1750173753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=omMhdXvjQm1hVx3L9qvaGhE4iGp7trBK3T7e0KPw5WU=;
 b=LgKp+BEEFba6mVmyHZAZhWxU/3IGmPqo9AmqM33M9eHPmIVEfO7/BEZXiqllf/UesA
 OC2AytbfxCBkdB4XIalF7sfDQasQ3k51vKJHlW+EHl6od8MG/X6sVbpzrR7yqPFW751P
 Dse1I29wdoQ1Utbv7oXILwieMMmTtd5+XtRs3CPaM+YP+v3WM0rA/LV64MzN4FDPSu9f
 //QnDzm9SJCquv5ksEAQNPGDJReIKxmbmsaywCRrubjLrhFu+6UTsrsQZcpKb2wHruM8
 u+5Ji76d8Cz0XErxvEuJHtunsFZqRv4eWT4dE3J+4hvppk/HHpiPodJbcx2yB9MuwSRx
 l87A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqfZSFl5OhZInU0gzfP9UzR/H+wEJSGvSRAxIU2O9v0whsENBwatLcQLRY9NYDqzRgD+N2+dM=@lists.denx.de
X-Gm-Message-State: AOJu0YzcZEbelaUR5JWw8FNaPOAIBZCylwAa8SOiQ5KJVdk4DDkf2s5u
 ph5oI52DdLXJZ4uZKaHrAe2y+7HTpZx7REJXHX3elF5rj11G2yhvpN0QdPL8/Vbcav4=
X-Gm-Gg: ASbGncsOXCNzUnQlaXCRSXBbrPaP/pksv8/7yCz0WXQLHmfO4mzGkx7JeTUlxlzzKaA
 7sUksyR7KdJRDFIAp9KuYZW3xhP7Mr2lpm3onALgiDo+sVyrhQ9uXTaIQsFPe3i8uJUJEEuV5Kq
 z55aovpjXNMCOBsmTFVZid+nHN2huOkEvuxbPXAo20h5N8rsGVMcK9zi1lZE0Ib1FGpzLOrjauK
 gp/U54yHrKTaWYXay93cRYb8johLl89BWfx8w1HtWhbeGt9ANp8xpXM7mqlAaaLYohdW3wdEXBo
 7SGDUhwBlT1mPNKbRHTeJtxNyBgRqjxf3rWfBe1ndlLD0VYUITAOEtCluDt28Vg9XF9ik56zMAe
 boeSmnqaafA3YKqt8hcmx80hm5h7CX2cFx+8jaw==
X-Google-Smtp-Source: AGHT+IFohCY8GkDRiNI3SEkqbT9mnzbbq3BIhwLN77zx80F4ZWi2r89XNBZwHYhTOYn/nw09PnG/og==
X-Received: by 2002:a05:6000:22c1:b0:3a4:f7d9:3f56 with SMTP id
 ffacd0b85a97d-3a5319b6a28mr14228528f8f.2.1749568952978; 
 Tue, 10 Jun 2025 08:22:32 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:3626:366e:4bd3:97c8?
 ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244fceasm12357143f8f.82.2025.06.10.08.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 08:22:31 -0700 (PDT)
Message-ID: <18193912-d05c-4584-bf45-e9f2f97be7f7@linaro.org>
Date: Tue, 10 Jun 2025 17:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] board: qualcomm: Add MAINTAINERS entries for
 Dragonwing platforms
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250610093732.2060702-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250610093732.2060702-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 6/10/25 11:37, Aswin Murugan wrote:
> Added MAINTAINERS entries for the Qualcomm Dragonwing platforms, following
> the discussion in the referenced thread.
> https://lore.kernel.org/u-boot/20250603192206.GK1382132@bill-the-cat/
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Balaji and Varadarajan can you send Acked-by tags for this?

Kind regards,

> ---
>   board/qualcomm/MAINTAINERS | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>   create mode 100644 board/qualcomm/MAINTAINERS
> 
> diff --git a/board/qualcomm/MAINTAINERS b/board/qualcomm/MAINTAINERS
> new file mode 100644
> index 00000000000..9196310f117
> --- /dev/null
> +++ b/board/qualcomm/MAINTAINERS
> @@ -0,0 +1,14 @@
> +QUALCOMM DRAGONWING QCS615
> +M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> +S:	Maintained
> +N:	qcs615
> +
> +QUALCOMM DRAGONWING QCS8300
> +M:	Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> +S:	Maintained
> +N:	qcs8300
> +
> +QUALCOMM DRAGONWING QCS9100
> +M:	Varadarajan Narayanan <quic_varada@quicinc.com>
> +S:	Maintained
> +N:	qcs9100
> \ No newline at end of file

-- 
Casey (she/they)

