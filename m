Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8F606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wtVccU74;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wXKAviwd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E9EC4082C;
	Tue, 20 Oct 2026 09:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Msc6DA1jnQvI; Tue, 20 Oct 2026 09:16:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35F6C4081F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792487802;
	b=h/99AWYkwr9JLRHkAvBGfEOFJ8rSiK3gi6DIvkxFkE7BQSP3b8q5EsbNEfU40VimZzee
	 oglPmIupEZan+HkFH2jXWqGQJSAmOF7ub3zmZ8/vhY3OD5+TQVI8FA8KPynTBYZ2Bo7uD
	 i+pNYE/xO0ci/DDD83BtKZnFKbOgxv8azFiMyFmOWbdrIxqOkANnTXnS3OJJBQSknMRKV
	 mMY0dvP2YoAjrp4zSCal/IAeCV5nQNrx6FScAUsS3SSvkazIaPD2GuL2rIwOmETOlyb3b
	 djiKT7/E7iu8aK2m4Vqgye8HI/Z/SOx+HTPORLtdJeOas15tswhiiJRRZ7cdlJxoxLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792487802;
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
	bh=DhtNdRhfW9rc1NDhT/BpzEZte/D1al0VIKYi23015RI=;
	b=oDtnWwQli8GTCT5iSTq8Wz9Ay3Q2rHRUUu90Uay9WaLLk0MgPf3vEEWURWr1y+CNva0V
	 JyzmgyrJaX143yR15FawNau06K807Zw7DgI5J4JIOR/r940bNczHACNrxQJXq4YA1t/CK
	 cjzjmb9UPJgBF1w20/KoSwixmqY4q60WVaUKgMm7RNZCk7u73/naUbQBO0zpZUoY4Pjmh
	 p4c8VbL6xG5r9VajAQlqNZ+S3sFHjD/O7ULsbQfkktfktJGlnud7nijhcauWOs9Ibg0/L
	 Xfwa+msMzxkOfI1VgaPjUSxCaXS+NcT9eZ6cgeb19QEUV7rGqrFAlK91AWcMVvQHNGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792487802;
	bh=DhtNdRhfW9rc1NDhT/BpzEZte/D1al0VIKYi23015RI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=wtVccU74siJFkt3Izw/k4Z5ZQzt7FAEdJ+hE0gY0yNOi7FVYl224UNsHLQKwq6Tth
	 OCvpKj3TnjyQeLi0UOGcnMOX2ndt50INsLK+lveAO9r+uzey66Q2sWr+H0F4khdcFV
	 o50CpB7IgvegILLQtXwxxesr173EcVy4JvFTZU4OPI5mtso96KpCzAuby8P6XSgEKB
	 ckxTINlRWPATVfJVePlabOto1LAoIyxhUBxRoAVCQU6uEpnw7OMxXNiPkIli9/gVq7
	 XmoqhVUXjsBSis+3mhlu41XyPO3p707OhaeNH03k5rcwU70YgfK45Ebn7gjBIr/A0W
	 LUx6mNO3ZOmtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35F6C4081F;
	Tue, 20 Oct 2026 09:16:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AF44F465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95B6640328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCJDVeqw1aYs for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A77E4016F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792487799;
 b=OL6oDsk9DWmBeYivtoaCArl5BRyS32zB6hGHm++0PNu/SY+iJStsm5Ymi7Xt+XSzE57J
 jjUEwIWf+5aIy014GwRMO878UArC6onk5A8lJ9tRUU+C0DUo8k3TwVTcZSJeRy5Qbo0yD
 REYWL6ZQjYetfnqdTAW0K1P51YZOWBlUROsHYjcRGfIK9KS6N/Xb6dD0QsWL9Dn7Lb9iA
 vOJVI5vDuh6lfqUQBhro855fA2nyPZnpBiHb+QmHgZlMAPlbnN9oFqxjWWwqMb09b+DxG
 kw74DLk0z6rRKo1DyeDJnE3F0AoPp2UA287XlHNaJCmo5qVc5Eea9KtUp8dXaf3Do3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792487799;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=DhtNdRhfW9rc1NDhT/BpzEZte/D1al0VIKYi23015RI=;
 b=BcvfyqXt9z3xCWOK4LgCUEg7kVAShl5kfVLqMRIJdNQocPVkZ4kR9ytET5I57ruFAZge
 HEn8gVLXwY86As3t0QzFFjLRxcGE3wKeDMtmpPUUsY0pCf+dV+ltCrGv4e5JHhRi6g3Yg
 BQ0t1mgJnjm00ux5romBPmTHaeGuypwqmcy60EM3ZbePnbwdSACfEr5pKl13/j8lrewCc
 1zBO2ucF6ZzvC+IwkpvbdeLWuo59IWHtPyMAN3KvW/HoCDDliGMweh6KMYuVVGUTi4ciE
 hWbyEffOxRydab/geQ4PZF5DEeCNmBFT4vENi7k5iRe+1vB6fwFVdS+jIM+/IigAaUg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wXKAviwd; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wXKAviwd
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A77E4016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:16:39 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so1959424f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792487797; x=1793092597;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DhtNdRhfW9rc1NDhT/BpzEZte/D1al0VIKYi23015RI=;
 b=wXKAviwdhl60LrVzXuazGeYIx+JKrwGklsJCblGbiqScpp49+WkwgAzDrMVjU8A7M8
 xndJqxixv3XFYmKD4zASxcjxVFcQW/lg/bqfHaeYz0szrHITmwXMQ6hYF66jfWy20AV7
 fTWjBcwpNosfCVb8sElD8khzbiipYbfQfI8cbJ+1Z1NkEvWSvvdIfLHsbUYlo22Fdcx/
 VmcQCFOGMOlcyuahdwBFC8J3isOSxuzrdStsBHLqE8S5K+yuZ6G3OUsAExIpa4REBusd
 NCz08d019kPtFSc9quWK4DZJH6NP/bkAiWxXk1zvGBCdG7eHrvJ2BaPv4NMNEO398D98
 lQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792487797; x=1793092597;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DhtNdRhfW9rc1NDhT/BpzEZte/D1al0VIKYi23015RI=;
 b=yBml6W9a0BWZ2rcI4qznyR95bVagjgy66OyZ/c8I+Qmgis8patlsgDkCYrGLdxopxe
 ny19yL/Nalvrgxl1Q+5dBPUoC4hjrTt0FMFt++W3qeX2ylVa3nmd227LnCZOikfFJgHA
 M+qcWRr5RitGN3zSNh6Y0f/Y3VJcgTyhwN+74UH8LTcZRd4oeuFQwvaHXx0Kfn7cYLsp
 s/yNsKdyrJx5Zz6jEncxumY0uiROLpz5l0kAE0IfDv+4iCLWlwdHXk0XIQ+dR/JjRYEz
 DLjR0xbTYu+7YTUMwSFk7/yk0wLpM51OT/DTt7G7Kft85VIvfGxehZcrzZKrcsx6oO3u
 Fg5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZ6NkGjpHMCMcmBWcE0voI5EDmQobbVekQOiOKxfANEnmjbXE+7mSL7P4IZ4n+kQlrypAd63s=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKqyqsSBteyUWuPg9pinQAF/MbtTYg7fJKE3THwUQMYHjDphNVL
 r9wnJHjG6yWbsuKPp/EBQt6Qvg0JG+oJH4+KGfLrj1el7FRJrGNa38jaui4L+hOT9Mc=
X-Gm-Gg: AYBFou1BbaqOSp2QPPIxguuiNco2lk6ddAD+t39XOR2FvkHO5i7MBGBMQQbkdotWeYh
 +NrFO2m+SYX0+NpXaS0lWRlaF/Vlm7QsqusxdTVe0Vop8YDzYTdTZXLITZQkme1oGMez8zpVFpW
 EdkhV94dasP+cLFzAO5cZhBm8Q4eMGRiFOhqnlmWsxRhrnkE6Izw+OS+qGiMtgjQuzRc+KC94ee
 gDhWb82b/WtrHb7Tq6L8//bYWWzcVGb7G/ggH8zpMMVVpr0poLQqI64dH9wZaS5B4jqQOW58q8V
 +i/g9m4a1LgEcYMAVglQk4JTwzP2C5g8SQS3IHBpEhMspJxym6Tvq38lYNZ95mBGAl5eF3zSZFz
 pdJ+8Oyw5LL33seDWWgI+cUXDI4Pn1j7SU0GvHt3Wj/27JhdK2j74xe46l1iyZeg/Zn+gcNlNzB
 suQdifgoQIsb/ojbYVcyw2ygThz83fTqLCXzcMmt+jsKWy14n3tP4cntQoveudYNWuddO39KxGF
 val1H4JpC/3Ali+USkvR/tSvdLV8gFpxPFXprfSEqUIvigwmIsC51eDdohMntxz
X-Received: by 2002:a05:6000:2dc8:b0:48c:4d32:ccf8 with SMTP id
 ffacd0b85a97d-48e07bbe524mr20911019f8f.16.1792487796798; 
 Tue, 20 Oct 2026 02:16:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e3a1:1a65:a394:be54?
 ([2a01:e0a:106d:1080:e3a1:1a65:a394:be54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d823cfcsm4813357f8f.39.2026.10.20.02.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 02:16:36 -0700 (PDT)
Message-ID: <ccf4e1b0-cb62-4950-9265-12731463e15a@linaro.org>
Date: Tue, 20 Oct 2026 11:16:35 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] phy: qcom: qmp-combo: honor USB-C orientation for port
 select
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20261013-ss-orientation-v2-1-8daddb44447e@oss.qualcomm.com>
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
In-Reply-To: <20261013-ss-orientation-v2-1-8daddb44447e@oss.qualcomm.com>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/26 19:08, Balaji Selvanathan wrote:
> The TypeC port-select mux was always programmed with SW_PORTSELECT_MUX
> set and SW_PORTSELECT_VAL left clear, regardless of which way the
> USB-C cable was inserted. On a board where the cable goes in reversed,
> the SuperSpeed/DP lanes end up routed to the wrong side of the
> connector, so USB3/DP never comes up correctly.
> 
> Cable orientation is reported by a GPIO on the qcom,pmic-glink node
> ("orientation-gpios"), and is now sampled each time the PHY is
> enabled to check for the orientation.
> 
> Taken from Linux commit 815891eee668 ("phy: qcom-qmp-combo: Introduce
> orientation variable").
> 
> Tested on QCS6490 RB3 Gen2 board.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Instead of reading the orientation at probe, read it only during the PHY init
> - Updated the commit message to better explain why this change is required
> - Link to v1: https://lore.kernel.org/u-boot/20260724-kodiak_ss_orientation-v1-1-d9d8fd271e0c@oss.qualcomm.com/
> ---
>   drivers/phy/qcom/phy-qcom-qmp-combo.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
> index 0d63e482ee4..65141489d51 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
> @@ -7,10 +7,12 @@
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <dm/devres.h>
> +#include <dm/ofnode.h>
>   #include <generic-phy.h>
>   #include <reset.h>
>   #include <power/regulator.h>
>   #include <asm/io.h>
> +#include <asm-generic/gpio.h>
>   #include <linux/bitops.h>
>   #include <linux/compat.h>
>   #include <linux/delay.h>
> @@ -39,6 +41,7 @@
>   #define DP_MODE                                 BIT(1) /* enables DP mode */
>   
>   /* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
> +#define SW_PORTSELECT_VAL                       BIT(0)
>   #define SW_PORTSELECT_MUX                       BIT(1)
>   
>   /* PHY slot identifiers for device tree phandle arguments */
> @@ -283,6 +286,27 @@ static int qmp_combo_com_exit(struct qmp_combo *qmp)
>   	return 0;
>   }
>   
> +static bool qmp_combo_read_orientation(void)
> +{
> +	ofnode node;
> +	struct gpio_desc desc;
> +	int ret, val;
> +
> +	node = ofnode_by_compatible(ofnode_null(), "qcom,pmic-glink");
> +	if (!ofnode_valid(node))
> +		return false;
> +
> +	ret = gpio_request_by_name_nodev(node, "orientation-gpios", 0,
> +					 &desc, GPIOD_IS_IN);
> +	if (ret)
> +		return false;

So yes it will work with single-usb platforms, but will severely break
the other platforms with multiple controllers (X1, ...).

The real way to fix this is by following the graph to the pmic-glink,
not the simplest but not the hardest, and there's all the required functions
to do that in dm/ofnode_graph.h

The path is:
qmp-combo/port0 -> redriver/port@1 -> redriver/port@0 -> connector@0/port@0

get the connector reg and use this as index of the orientation-gpios.

Neil

> +
> +	val = dm_gpio_get_value(&desc);
> +	dm_gpio_free(desc.dev, &desc);
> +
> +	return val > 0;
> +}
> +
>   static int qmp_combo_com_init(struct qmp_combo *qmp)
>   {
>   	void __iomem *com = qmp->com;
> @@ -333,6 +357,8 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
>   		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>   
>   	val = SW_PORTSELECT_MUX;
> +	if (qmp_combo_read_orientation())
> +		val |= SW_PORTSELECT_VAL;
>   	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
>   
>   	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> 
> ---
> base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
> change-id: 20261013-ss-orientation-d85a156e806a
> 
> Best regards,

