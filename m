Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FD8C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 153E940B6B;
	Fri,  4 Sep 2026 08:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3C5O3JZlZ5iS; Fri,  4 Sep 2026 08:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3733F40B37
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788508985;
	b=LlF6cUPoio3LQzD1IJq1Nmg/cR1qhu9FlhWikoRORmZtp2Jfz5RtqpOnGQpIqt7c3aa/
	 LL0owESQxmXuuwZLXKOXdhH1j/O/3CvQCsgg5s6d6V4q/fQGyOgfu3d28l0aXvRI/GP92
	 7BQMNMoHdoVpSjaB6HeuhMC4gWMJmrX82+BhasX/bdJApc9abeCJaas96zwszxJ16ue9/
	 /ulwiSwh8mi1bB55G7vMQz9h2reV0Ksog8ONDA6nEsO2DxDAZqC1xo5KSWPzBP8sW7OUR
	 LUL72ja2oWq1+Nv2jyZWfODdJkw0JSQF1eVHKLJFs49DV7e50n+mZYqfH7h6TAZmrww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788508985;
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
	bh=HW+0ABMnSuHXO6fq6eIYYta/EMABmNcOZW616/uAp7s=;
	b=pcKJ1BDgjryEDa5NDsB9Qk7+bG1wI3WO3Wd2JptnCx8aUkL/fgJ+8Hbnu4Y8PbHGosJl
	 hxxgaMBhkmccEm2ZWZDm6YBACf6Rhc1ydwV/C0FKGR/ypybT5dNrIySYWUHZAdFfPhuK5
	 xm5Exk8gYK2zyeNk4l1ilgA/0w6Fd0q+YvrPzmxYSyAWxWmwA+KKi+5a8rxsgIaoXUAY7
	 aL5PeM+yjJnn6iUNSKTTm40vyYCGZpyjz/m1Zo/jtlUh8zTl32QNxor0KADdV76uNQaOb
	 19ZK/Kp3RpapiI3lJeeAVzWAVkOV2RFilkdlbDoPaE/6hp2MRNYQhV1IbHjY6FvATOA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788508985;
	bh=HW+0ABMnSuHXO6fq6eIYYta/EMABmNcOZW616/uAp7s=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ns2zaIa8/tx1gbA3RtUeqbNn08Z6l2bo2aOSCOdwH9qhTbZ1n5Q90Yis6XrWsf0uP
	 /WiDT3yAKhRqnf8L6hQLcWG3xSRELdzH0OhDho56LpXuR25hdmlnB5jmPf54ch1K21
	 jJcG2FcwJlYlyq9Fp12xy2G1qeB9tl9l6KzCufe5iGK8qDwJ6JP3A0qDEYvMxv1H5B
	 khA8OB/2xsDE9odugKqOEx5R6S3muTIPMmk6NsY0omTLgdEw9fcJs56+wtQevL51WR
	 w/pY6j3uEpYZNA4tMbDT0sNA7ulCN4YKviz0s6g8OxNzHirwwhIEivLWfBd/VO17JD
	 SADfwyZk2J6wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3733F40B37;
	Fri,  4 Sep 2026 08:03:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECD8F363
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE3E680E52
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PQEFCmgq3zRL for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AA08A80E33
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788508983;
 b=rVH8MWDlMu+CNK2oZeWhHZYFbISsafw64ab2jEswWPPN4fTzmO9fEJfAUF0faHBIreEq
 q1Wdb5nRqyQ0uPEeN4AXyeFpDO9s/YNyLBx0J24jEgLzgOEjDMwB149I7hcEhy45Tt6cS
 Ieqb5TWjpCYz8vYE2eF54Ucsta5ISXkMIszp7wCL3SQ2eae8NyVywzLILH+u+b2Re/218
 DN85d1kC5aQYpICNyOIJz7C/pnxoB043cMd84jLN31haV87E1b8L+N94TFNtKam/kBb2v
 z8FNnmiJCzzg2mgqQw0JAD6ONkGH5imKVkZW9/GiieTD2oRDrRCcc3SjrneLPoVLT/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788508983;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=HW+0ABMnSuHXO6fq6eIYYta/EMABmNcOZW616/uAp7s=;
 b=kEWvmeEPRhXah/jfXbyIfkQvO+DaNctvZ0YST3tp2W6FNaphfDaduLmhstO4JpoPg42i
 6xDsCr5/6skLW2dz9wS9WJVQvEYjgDIhko4eQZ+BDornUqUrByr7zZ2t+5dcw76LXjne8
 J/bImPolvqUVdAsqbKZ9R14DFCNKN8weAp4tmvX1qS+NjDUhINJtk9SFmz01dXYyw9sUz
 dGgLbW89eqyu+sPzY/YVRQsSIsmGVjPIuPS9r3wQ2NBY0z4PdZV2mgJnXVrZZ1nFb7hei
 PEpUULkE5lNPbL1owj1xVbxilCGL5LTgjaE4nMz/dsusxI6kdnLa4DLEXSwzliFfZoQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="TdNE/92H"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TdNE/92H
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA08A80E33
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:03:02 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso6684245e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788508980; x=1789113780;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HW+0ABMnSuHXO6fq6eIYYta/EMABmNcOZW616/uAp7s=;
 b=TdNE/92Hl9kzlSE9y597iQHBZGfVvYxIazgAoO0OS5SpjhXsQfLrIT88SwVMeC0EtU
 eWNu+H15E1NyiWensW3NktQcLiuLwnYAQEF3EKYcgSBMxH8T/7lgaoyDPyRWiGwrJtAT
 GKGmguq8xpC4A/Ln84iBOofyXA97BfTd/1d6BFwfiK6CbMi7Hkav3km7o9YmFzWeOq0D
 +6xlRuX/W7avTjNSfXrHmmXCs2HvPQVbnFXl2iaR59BtbKPci5WnRfZcuvfCjx2JDDV7
 vLDHsr9TRxcL4v6IKpUa1LybhdJ7+kiBT4OlMfT8xGlyhDr5XsqSApJmjOZRGiBBdwiB
 tONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788508980; x=1789113780;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HW+0ABMnSuHXO6fq6eIYYta/EMABmNcOZW616/uAp7s=;
 b=dx95QePQndkBxrJAQNTYmmn7QfyX/qW0T2cjmKyifLCFG8fd6CqvAtXcWohTX2ZFPo
 XqJ/y6PEp6e572l5WrfgXH4w29CSco+4ztaWFCXvDhFvC+R5ZS8vbUOxcEbbMFicljIe
 NhyBpDo+Txo3fEkIM0nLi3IxuGtxVhmcWm4iqi8EEub0ylFh2olz1x2NO9+3V//fH5Aw
 VCw/aZSLztq38FpK1/aYQryr/Ve+vimG8b9LyVFhI6vzwqL2aG3x/v5hPhFHD68eK6K1
 Pd8ve+7NnIjeRiE7GlteMDgmNpax6nT6MfMUKSIZ+FXtf50OhHXvDyWnn+XRGuu3IoxN
 zGag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQOdA5vJklTKioXK9d8ZngUFecXcN2FP+8GKCHD+hTZ2TqzcScpyakdn6XecjxuG8Xi5t2Z2g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lHZ+uvG6N7RIq13oF3m9MkccWJCkkBj3hCfnhmoFi9/oM95VIV
 iS7zdXMdbtIer5RFDmtdQVaHDQ9btSEDzqaB2mC8wrtLwO3DoiYT/yEFXQJig8sTySQ=
X-Gm-Gg: AYBFou01yL0n9bZ1oekcBW7tNrC2RPzjC/wGtIFCjGnUcpqc2bPTpzl4zv/ao3QpZGS
 8ZxhlcuUauXaDuibAZKNnhj8gU8cnzPnwhHnR6nw0GZlRgHI6rKjxMXDqyk0AxiRP+FrK8aCvGb
 2T+RGB//FFyDrCtyJ4TpwKXSylzf+ny1GhdjmO7xp55tkdyVM2xkUV7O/2T0oiNspz6BqmDYPzf
 UV2Qm77Kkl+0jMptfU6MaywJwmbpa8l1iPL3LJNGT4BbwE29WQhQVqVRQvwXBUEjJRVu/DLbHQT
 SxatE/RWpaJwEd3rAEofaPiaaIU3cqtT3bD9D6kZpGMyuIdC33Tx29Dp9LX1ikaOlbMtzV2vQHS
 qhZVoLWdeJZNpascbu39xgx5Xzznc15ZdgR71jzLyJoNnNIvavWitTdT2NgUYFmkJSNztqWTyMz
 2c0yPgAfzZZl/6rJJMZ+aSdupbL2tCnM7jpcSErIYnp/z0OAV8/HdGVqusjrXWZvCzkCSHAjDpd
 ObIPMde3Im1XfJHP/EeAT3vS4KFwa86n02eDj3JfSY=
X-Received: by 2002:a05:600c:a4b:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-49cf824020amr35721145e9.6.1788508979725; 
 Fri, 04 Sep 2026 01:02:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e8f4:b358:2087:5bd3?
 ([2a01:e0a:106d:1080:e8f4:b358:2087:5bd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7736132sm49538685e9.12.2026.09.04.01.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 01:02:59 -0700 (PDT)
Message-ID: <fe57ec02-2b00-4174-b42a-6e546bfd12b9@linaro.org>
Date: Fri, 4 Sep 2026 10:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/10] spl: ufs: Add support for loading U-Boot from boot
 W-LU
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, David Lechner
 <dlechner@baylibre.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
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
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/4/26 09:12, Alexey Charkov wrote:
> UFS devices have a built-in A/B boot mechanism implemented via the "boot
> well known logical unit" (boot W-LU). This works by marking two of the
> provisioned LUs with a flag in their unit configuration descriptor, and
> setting the active boot LU in the whole device's attributes. The device
> then exposes a special logical unit 0xb0 (the boot W-LU) which is
> internally aliased to the currently active boot LU (if one is set). It
> allows reading and writing directly through the 0xb0 LU, but doesn't
> expose the LU geometry, so it is not quite a full-fledged block device.
> 
> Given that the normal use of this mechanism is for symmetric A/B boot,
> real world scenarios will usually have both W-LU-A and W-LU-B provisioned
> with identical geometry, so the geometry for the boot W-LU can be inferred
> from the active boot LU, while its special 0xb0 LUN can still be used for
> reads and writes to have the device itself abstract away the actual
> request routing, even when the active boot LU is changed.
> 
> This series adds support for loading the U-Boot proper from the boot W-LU,
> allowing to use the native A/B boot mechanism without the need to hardcode
> the "real" LUN in the SPL configuration.
> 
> Two classes of prerequisites are handled by the first half of this series
> before the enablement itself:
> 1. The SCSI core needs to learn to repeat inquiry requests when they
>     return with a transitive non-zero status, such as the UNIT ATTENTION
>     condition, which the W-LU returns when it's first talked to and which
>     is not an error (patches 1-2)
> 2. The scan itself needs to learn to look beyond the normal LUN range when
>     the implementation supports W-LUs, as they are numbered above 0x80, and
>     "borrow" the geometry from the physical LU the W-LU is aliased to
>     (patches 3-5)
> 
> Patches 6-10 are the enablement itself, split by logical parts.
> 
> CI passes all green:
> https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1175
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Alexey Charkov (10):
>        ufs: hand sense data to the SCSI layer
>        scsi: repeat an INQUIRY that a unit attention interrupted
>        scsi: size a well known unit from the unit it stands in for
>        scsi: allow a controller to declare well known logical units
>        scsi: add a lookup by target and LUN
>        part: name the well known logical unit device type
>        ufs: define the well known logical unit ids
>        ufs: report the logical unit the boot W-LU presents
>        ufs: expose the boot logical unit as a block device
>        spl: ufs: allow loading U-Boot from the boot logical unit
> 
>   common/spl/Kconfig         | 30 +++++++++++++-
>   common/spl/spl_ufs.c       | 18 +++++++--
>   disk/part.c                |  3 ++
>   drivers/scsi/scsi-uclass.c | 32 +++++++++++++++
>   drivers/scsi/scsi.c        | 98 ++++++++++++++++++++++++++++++++++++++++------
>   drivers/ufs/ufs-uclass.c   | 76 ++++++++++++++++++++++++++++++++++-
>   drivers/ufs/ufs.h          | 28 +++++++++++++
>   include/part.h             |  1 +
>   include/scsi.h             | 45 +++++++++++++++++++++
>   include/ufs.h              |  8 ++++
>   10 files changed, 321 insertions(+), 18 deletions(-)
> ---
> base-commit: 1c5004ffc5e3f000eca6cada32af7c83bd925c2b
> change-id: 20260903-ufs-spl-boot-wlu-10ce2e14bf15
> 
> Best regards,
> --
> Alexey Charkov <alchark@flipper.net>
> 

Apart 2 NITs, this serie is very good, I have no further comments.

I'll let other people comment & test for a few days to be sure
we didn't miss anything obvious.

Thanks,
Neil
