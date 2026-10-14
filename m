Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AD3CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA73E80CF1;
	Wed, 14 Oct 2026 12:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 75F1jjvPOzTf; Wed, 14 Oct 2026 12:20:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFE6380D85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980424;
	b=ssjB+FifF6f4SprXFVHnVFs0GTNN7MgpxO9D3Hm+Mjv0ab7BCiZQbirXYVhXvIBaW2tA
	 avPPKixhOHrLvf2r+wluT7RRS+CrfIIkcj0x0CGpin9Zah2WJjeMkUtgCKVX8Vx76yZw9
	 cTpw3USCi9A3Rg7g5mZVrxbQp3IfitmsUHwEhboPvXSJcVIc43EuDY63jb785O/oQ9UQu
	 FIuBTnvYT+JEZXE3yE+crBpaYlwHS6mG1ubkfElr4OmIt1O0Zyr5J9bVoX3CmsDamv78E
	 Al3TxxdM0l+34kzIRs27Zifhdo6nSi2AUx2C2NQSxMy3KCV2qQM0obbzueh0vNShoyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mtykiChh8D0ddhUnzwlbE3L/Q2g9JApQtjoUB/SNHFI=;
	b=shPK2+Hkguiaub585cADUU3iUwut54pLfWJG37rS4FSeZKPrz6JdswJ+vMLjfgpaKWTy
	 xAAGcqD4CJLO0f0EqK0Ipq55LRKxBmWrwxKxN/7lAjc1m5Hnadz++8T8GowqTRBkG0jtq
	 im/IpIt7WUEIhPJPnQ1Js0APtONUbc/Y8TgrDQknrqKQ+lpM6X/dBwyd0RgU7yQ960NCg
	 kWCVNEMS1UvgTJRi5Dz7QozAwly1sHzwB2pHIAPeXmRiUaXHGPXuXnjs0QzfFs1WIqC3l
	 ZF0S1dqZ6cHfLaniWEbOT/EY2+8RcxBqAUycrZ2MwES55wXyuIXlROqWlJEGkObkJkw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980424;
	bh=mtykiChh8D0ddhUnzwlbE3L/Q2g9JApQtjoUB/SNHFI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=CGzB62EcMfvQh+qN6apHHP2zmK0LV6Y50XlqKOaw7ELlXIzZ9rdeZ3+mxvc16OQ31
	 oC/MfS6FHU4MJqxDkVWV/VUulEM2lMXAnDj0j9KDYl6GdLtGBn9iGGNm/IijuXu2Sd
	 I70Y2OFVPEGu1dfCkzaEnaIaQgHAyWzeDBHW+3PSQlhrzTrgZCfm44MLhAshvH1BHS
	 zcI1wpA8I2YWo+IB9+VP07WiybCV8+ClYJsju1NTjb8swXD8wjGUy0s8echEES3r5r
	 3lv3jpYcuE7JMGvdAOvEKMAeepXfR2iudLtT0OFq33Z6cFRTeRB//YW6TOv6GSfYd5
	 4ZBwlVxM+iSZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFE6380D85;
	Wed, 14 Oct 2026 12:20:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 118C31BF9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC2FC4014E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:20:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WU7MEziWqgig for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:20:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D2B544006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980422;
 b=ATBKonFIdjea8F40146vUL1CK6ntTkWlAlccyRRqEW+9jHkhJqMUtSP/IuWHFdGdv9aZ
 KJnipJiF0wvo64hm+r8Ri+niT4cXtEzHELG9LnGn5MAUFp4jg2OBQ5eDSh3lAMI6QgxwX
 w3Mlys9q5Tyz33r2pl6NARA3jODxaW4ne9PwQz/gL/hIlDqSv4b5v5YWntOnLUSTAL1YF
 B0VbMCWj72+v9L4deoe3Mp4VQk9oi7vEk6/1xN+7Dr8si3ZllNkew0S2vHlFKMwWXh2OD
 7eF/8R6cVdAryo1npIAtaorHeYamkMvU6rvi7i7ycoZbt3ZoNMIlTcEyAeTxO3v9f6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980422;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=mtykiChh8D0ddhUnzwlbE3L/Q2g9JApQtjoUB/SNHFI=;
 b=o/MuwuDpElZ5dF6TP0OAKo6ZczaYSN+RWrrD+H++QON8JdT+7hOF6IwsBawEqOkyzmHI
 Llfa0WYjBZB+8IQE52nKoL0z4zSezYSMmJ2cj1SKtoHiW1RRBlapF8uEmjPnanRexGn/4
 cQXA8X+7eM/EcZpQvsuxP/eFKET5pPSQ8aPRH4mQ53ocvQU99zqOeih28dHTmYg6ucEHx
 wqZjqHxW8KZ04kYOCdalj1lDBkvqU6MW8UH1Drjo59ztX1Yxzux0UdNtL+i0CqBvE5Ogq
 LUeEC0w31lEyovFHoHcuOBmWiNtK667jFv2R8MJoV9U43xkiwyQ11i1kS4R1fQUuAag==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fpBrs3na; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fpBrs3na
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2B544006B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:20:20 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so24859495e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791980418; x=1792585218;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mtykiChh8D0ddhUnzwlbE3L/Q2g9JApQtjoUB/SNHFI=;
 b=fpBrs3naB2xEMjlvM0ALs+/Ojr6YiLs/yLPPQ2iFR+fy9SAN0l43+IZLsJo2RgPQ9L
 svbTCCtwOoOvmn8E4r0It750NA8hevd40DQqWMUqTRUFMgBpYqIWIm9TcmF+Plkwmf93
 G2wtg/9XTMLJCx8F+rD0U4uzNv3I/jzh4APDWbN7KXpEE9r7o+0q5mt3z4iP4g2DrLrO
 XwWFKNU85B2N44xuT1tjAWR0kwgj4RCEFXVMNaEMWpg0TG0D3l2kXAXy6SqXMA6C/uQY
 Jm5vspdmPOApsrOxztiVaccFds2zEQ1yJLt+WCGPWyIS4sWaRjPR+y9t+SqZ4PoEQCJs
 YLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980418; x=1792585218;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mtykiChh8D0ddhUnzwlbE3L/Q2g9JApQtjoUB/SNHFI=;
 b=VWeeDSKXhsYmkmjYaSo5Ls1AzyDTJseG0XVSRIsJcQUheCQoAz0kjxrdBTO8EeUV+K
 PpRJPIXNFDt8mxenuKhzffb6jl77bG+tZc5IRW057XHS3Yjn7PO/0si9EC552pY7eTJe
 Bruto8HZMdZVUq2x0DzPB0TnNmusYLYHJJBdQ0PUXW+P0Va1aN8SCkoWsxwx38+z/S86
 UZkF5dpHf20rUMX3tUcKCdNuLiBYKjSsllIskuZGA+ujt1WfBcEXzIlZxn5bX3g7/+Qi
 5MGuP6GMGHd0QLvu7cfHrglWSXn7eomVw82llO+HhPakJFSjvcoB9/XnZbQ0w6q3i9mT
 WErg==
X-Gm-Message-State: AFq9FYJxIGNmG8cQKsEPaKpi6x0rWE3xtcuLZuXOOGYTCBYOlrqanBod
 D2665XI9d9+UA7uAX7dTRu0AE50s4R36dkNNFeBqbrQj3sZAobLzZsnZnChtGG1RSZI=
X-Gm-Gg: AYBFou0cHpssUnrTTjGDK94Mv89nrFubLX6iXEjjMSQPg3RmrfrA7x+Wexra8blos5w
 0yCBG9OMQs3dCU0ZIHA9Z5rT4KJncvc+o9L4tB9+VpCfL4qP5o1RBSa5DPEBwescC2i1kJylhTd
 L7S92zQ/vNIXpwK1LpGLgF1yKAo96DuaV4yn/k3lQ0rZeguFcxSfLrVy5c6ExM5S16je/xsrXXF
 YLH06FLeMwTyPbZyisipnkFJtdIkU16xo+0UW+cbD1jmgQePqeNB6htjGuSYBnhpX7X897QwIvC
 xZMuMTdn7WqHHt9qAPPUtO49bi1Ox9X6SaBYJeOQAkNZr78iKXU0c8n2cn0P650yDFdNT85BpU3
 QdOMNReMzOei+BMGBPGQCn2rKopWE0u1uNTvWMpH/y/foSbC0TJLzG60196N8fEfGHIRzMOMs9a
 O4Px8FkCMIP0fRIewhAbO0LWBfuHwx1o4CZ6l9wFFL0hXw8wJpwA8kTQHEWgCoGpEA/ue9jKt9x
 vhiOXe6Y7SCpge4RnNLReB71kIkWDq0zgGH+9DK0/+5t8Mf2AdJCg==
X-Received: by 2002:a05:600c:3f0c:b0:4a0:1723:2d8e with SMTP id
 5b1f17b1804b1-4a18e44691emr334492495e9.2.1791980417318; 
 Wed, 14 Oct 2026 05:20:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4?
 ([2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7003982sm8728095f8f.8.2026.10.14.05.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 05:20:16 -0700 (PDT)
Message-ID: <f55fd32b-40b2-4c52-885f-965319bc5e45@linaro.org>
Date: Wed, 14 Oct 2026 14:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 2/6] ufs: surface sense data from ufs_scsi_exec()
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-3-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260918200641.2286077-3-jorge.ramirez@oss.qualcomm.com>
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

On 9/18/26 22:06, Jorge Ramirez-Ortiz wrote:
> On a CHECK CONDITION the UFS device returns SCSI sense data inline in the
> RESPONSE UPIU, but ufs_scsi_exec() discarded it and reported every
> failure as a bare -EINVAL, leaving callers unable to tell a transient
> condition such as a power-on UNIT ATTENTION from a hard error.
> 
> Preserve the sense data and SCSI status in the scsi_cmd. No caller
> inspects them yet, so behaviour is unchanged.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/ufs/ufs-uclass.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 21aed9f97bd..3d96a05281c 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1657,6 +1657,22 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>   	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
>   }
>   
> +/*
> + * On a CHECK CONDITION the sense data is returned inline in the RESPONSE
> + * UPIU; copy it into the SCSI command so callers can inspect the sense key
> + * (for example to tell a transient UNIT ATTENTION from a hard error).
> + */
> +static void ufs_scsi_copy_sense(struct ufs_hba *hba, struct scsi_cmd *pccb)
> +{
> +	u16 len = be16_to_cpu(hba->ucd_rsp_ptr->sr.sense_data_len);
> +
> +	if (len > RESPONSE_UPIU_SENSE_DATA_LENGTH)
> +		len = RESPONSE_UPIU_SENSE_DATA_LENGTH;
> +
> +	memcpy(pccb->sense_buf, hba->ucd_rsp_ptr->sr.sense_data, len);
> +	pccb->sensedatalen = len;
> +}
> +
>   static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>   {
>   	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> @@ -1664,6 +1680,9 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>   	int ocs, result = 0;
>   	u8 scsi_status;
>   
> +	pccb->status = 0;
> +	pccb->sensedatalen = 0;
> +
>   	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
>   	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
>   	prepare_prdt_table(hba, pccb);
> @@ -1683,8 +1702,12 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>   			result = ufshcd_get_rsp_upiu_result(hba->ucd_rsp_ptr);
>   
>   			scsi_status = result & MASK_SCSI_STATUS;
> -			if (scsi_status)
> +			if (scsi_status) {
> +				pccb->status = scsi_status;
> +				if (scsi_status == S_CHECK_COND)
> +					ufs_scsi_copy_sense(hba, pccb);
>   				return -EINVAL;
> +			}
>   
>   			break;
>   		case UPIU_TRANSACTION_REJECT_UPIU:

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
