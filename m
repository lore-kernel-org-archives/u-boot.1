Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB62CA6009
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DF9660B6B;
	Wed,  7 Oct 2026 22:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WUkjE-lB6t7; Wed,  7 Oct 2026 22:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B790E60BAE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411403;
	b=f8MHgisJq2yk7Bkq1eYAzr7dnBU0NliT5w8S7viHcU9LXFLhrW00kMUKOSajrszswEiq
	 0ylAn++nMPZjYcyyHxgBQqsTW33QVAOCemv39fXgjXQmrTrFO9V1r8ApU3T1DWWWF+gPc
	 0dce0Qk5zzBpvAFtIG7kEsNtYtXTZj0mjgh/c1AZWH0tupbqPKbWPS7F1neshYxcqcMtc
	 e3Y0/29Xv+JVwQeB9MPcgSd5zjE8Ll55BVpzpzV1IxPsgdjiVhY0zxv59i7iYUCpWdpd/
	 QmnIdphFsG+GQNO/OQ7AIOrVza+Mh6WVkd0e873+W0PPayjhw+0/epFk0lPsvnvQaAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 From:To:References:Content-Language:Autocrypt:Organization:Cc:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=1E+OLgX72FrlAD7k0Tr3K5H/67Bxt688uVLr8BDWlR4=;
	b=YjK89F/o6lqf/ZmX4VlagAJlV9YmrKIHKevi9ztQaJQd0OekF0PeGSNwyRMPvWRbWSh6
	 IjdNbNIS0I3OJZuMvEVrHBRIxiQBpl8voGD6cbhtKaq6IEWylxcuC9oKQIC4ytBeM8cZo
	 w4yndnfBJVLj1fy6oPUa59cKIXSRGxWXZ3NpBqr4F1DCn4Uzi65q09BItU9f9LJ977Suo
	 bwIWA3AYt3ep2tMB68/v6k13OPa/kb5GZUQ35jFm37JproQ9pjk417kSkSEfRv5ZFTZwZ
	 7+Fe6r742NIz/yCLG7YWeMl+v38BH3ZEU1gdZIfLNe0RxKaFyOtN4Cu0UVgvaI+TfGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411403;
	bh=1E+OLgX72FrlAD7k0Tr3K5H/67Bxt688uVLr8BDWlR4=;
	h=Date:Subject:From:To:References:Cc:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nuFbBotIX+prhEdqeQS595A72ldtyrPA9ZYru7U1cw7DR6skscy+bCLM1wPpcWn7y
	 YUuTgxYAs1srd6biStpcK3el9ywLn4VfXpKG+1rDkMxe097cT/BzaJVK8EwStfx2Z+
	 xUKfrq4Lzdlh6jsuFDSQQRRLV64bRTO4jRXBmUeEBCVEykB5O2Lt6wKeHhYvDnpUZh
	 PXA2o8jVqwE4NAubaXXBKnE7Rv6Ye0LQQUgj7zRjyTW4VuO8wHDC6qIDQFdKRbky/p
	 6U++FatbsCL9/ocPB1284dcGaFdojrEO8+O3nSeBSA0/huYFLoZL2dv6GPYgfqOu+R
	 Fx4dDSXUUcIKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B790E60BAE;
	Wed,  7 Oct 2026 22:16:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 565FE75
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:27:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 537F540080
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:27:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pUz4TRRdb-Zi for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 21:27:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E34434004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791408429;
 b=rKh4m86nFE0cZph1YCplP9jBdJS62vv+yOVBLXe0aC1/HG3snxo0XFxvd/g2iB8JOpLo
 bWNRcumHeh2mYALraWkswUd7PIuGb4hJoWUNeSwJ5gq5s9eajk3Q/50HtVL2A8vPh/jcK
 Gq2mygdoJbaCw75VzBDnCf7DwgylENl32a4qyQ92QpNHBa8dkH85q6G2isJS82Y3L51/w
 Bmj+kb81ck9urPsAKn7hF+TFXRqEieX3IZak8ufhgx0xwwsWml/vadIXv0PVtK0qahBTx
 e8ZM9JJix3OSbxbyiWGMQMem9Hnx52dlw8aFfpx9O/QWcfWjYBiO9pupqlUy4cp8bVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791408429;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Reply-To:Subject:From:To:References:
 Content-Language:Autocrypt:Organization:Cc:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=1E+OLgX72FrlAD7k0Tr3K5H/67Bxt688uVLr8BDWlR4=;
 b=HiB7RFlOilJ+R5gD5JXxt+7xfIt5iU7SHHtO31Mydjj22bpoiI6KJi9bBb+j+UHVEArI
 yHpQOR8IZ3+L3dH4JK82B3p45dNBKQXr3cwhc4NVrm+rOuoAPE0aSJMRnSFOmaFUjObl3
 sqmYoCn3nqk8NXwDtlAADEP3hbZwkt8Y/a4uzuPXipuSIM0MJw9TLt900MheWtK6ScpeY
 fxwEGl6YjPjj1LE8+8mDn+/BjLBCmdHP+hJugLLIrLMd3qmlgBDvRYLh7Tbw5tSYRng3q
 KgU/7FqtcvtZ+9cgyEDvWh1k2+rVD3Unrt56VvnmQzkR1wcIqhjcgi1kUKvWc6uQFXQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BHGcMNlc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BHGcMNlc
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E34434004A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:27:08 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so20479785e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791408426; x=1792013226;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:cc:organization
 :autocrypt:content-language:references:to:from:subject:reply-to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1E+OLgX72FrlAD7k0Tr3K5H/67Bxt688uVLr8BDWlR4=;
 b=BHGcMNlc4vBC1iYEDrlFrWIfi4v9Eyw7t9/Sjb+zXDtdQ3WQKt1QdTgXvBMFDolp8c
 +Fqtx8jp94QBUw61nBb+6XjRfNIZDsqp9iP9Esv/Dpat5TyhZ/TNMvv2Sh+Vw2zpClEv
 BTz3xZaP9zUWZsfdq2/uUGQoMkQtnNE35q0nL1g+STPB2sfSoA3iWk1hiS6LxnM4Oaza
 y3MaqEvsBOyDCWtwRnvk6zSwvcqAQdcXA4fAy9oYzWoBtybdQp5MqtIhPVa/LtI+i4+v
 k3Qr+/0vu0BibiFyfRpjIPiGC6AQGSadAU+hVrP4acRwNpgWWgpFcRggXpy77NPgLQwr
 0Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791408426; x=1792013226;
 h=content-transfer-encoding:content-type:in-reply-to:cc:organization
 :autocrypt:content-language:references:to:from:subject:reply-to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1E+OLgX72FrlAD7k0Tr3K5H/67Bxt688uVLr8BDWlR4=;
 b=V3cXgjFCtiZJPztJaiXoG/O4UfGNHUxwXJiOWLaTRAz7NsrFVycEpEky6txLoq3l2f
 ES+IgPBnabdxKVxY6tscqB10evvghT25imG7VAMiSuqPenGSodxtJYV3ML0cAee3iIg9
 N+idt1WQFArpFUROhxagOLfNa2qp6ZK0WrJey2x69XPbEtNNaN7gUxsvH3kb6Z5ZomuN
 LV0hXF9tmTMkX9z92XXLOQU4QyMtmXYUux31jW5dRk2CLLVRnXbtRoMO85qYdtUvZUiM
 eS9MEp4mqJTXUuGNc+qgpR5jWBgr5P+I2y4vbHGOAF0hI6Sj+T59GgcWmJxEEZCJ2JX0
 8HkA==
X-Gm-Message-State: AFuF++ktJMkqDnsonZRGyup2qhB1NQl9cLZCdhRRWuIifY0zt282QB+X
 HNuNDMwDmg7/amxd99eZiqPp04cMjpTGDQCXbckMNHIE1AZ3VDW7NC9ga7m3dkSivsU=
X-Gm-Gg: AYBFou2RycMUNms/3DPLs0zz4Lvlkaynbgomxh6PJryWqN9u12xj+4/kSz6jWZtSKtX
 Y0S3OG4pZ0vQkfxxFZsGyzIbOO5kIRrq5Q5gouaXxHE8mamh7ni2idujlC3TM30Z6WWnwNd524G
 dJXoLlkhfuuM6pljeYQruPLeOtSN6m9wFzSqEhr7j8ugyGD6mQT0oR8gm631lWA6sQePGQZVsHh
 fYOO5w3uJGiBQMNvJku70eD83+QfoVaBZ12j8SVhoTVYywJShCLLEWmKH4ieXmaY9OMwTFqLizX
 m1ClkCDXoMPeTWD6wsQnVFSUWi2BROnoZSxPNH0uF0MVF8xyTePNnMWNz6KCi/6fhfEcmv1nGS+
 pbtdCNq7OD89vZQtKqhbw7EobZEC89+vGRv2SGnBGO5ZcT3MjRpY1qRsiJ+ws8lCOO2uBLpvdRt
 ZLp8OcXp8orCsFevuLJ8QV9W7DbOX6Anp1vUtsBVoZDMKC1TRfDtphPPhlBTLrUsJ1yU/zPe+nq
 3QSsEGL
X-Received: by 2002:a05:600c:4693:b0:4a1:7e1f:21bc with SMTP id
 5b1f17b1804b1-4a180648ff1mr58054175e9.29.1791408426160; 
 Wed, 07 Oct 2026 14:27:06 -0700 (PDT)
Received: from [172.20.12.220] ([89.24.97.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843d8997sm20890245e9.10.2026.10.07.14.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 14:27:05 -0700 (PDT)
Message-ID: <b5d52786-4dfa-447b-9ca0-886bb00fd444@linaro.org>
Date: Wed, 7 Oct 2026 23:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] Meetup during the Embedded Linux Conference / Open-Source
 Summit Europe 2026 in Prague
From: Neil Armstrong <neil.armstrong@linaro.org>
To: marek.vasut+u-boot@mailbox.org, neil.armstrong@linaro.org,
 tgamblin@baylibre.com, glaroque@baylibre.com, msuchanek@suse.de,
 andrey.lalaev@gmail.com, rui.silva@linaro.org, monstr@monstr.eu,
 marko.makela@iki.fi, henri.sundelin@iki.fi, nbelin@baylibre.com
References: <dac81055-ff78-4b28-9539-ea533c12cb33@linaro.org>
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
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <dac81055-ff78-4b28-9539-ea533c12cb33@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi All,

Just confirming our meetup for tomorrow! A table for 14 has been reserved at Krušovická chalupa for 19:00.

We booked a few extra spots, so please feel free to invite anyone else who might like to join us.

As a reminder, it's about a 10-minute walk (700m) from the Prague Conference Center.

The exact address is:
5. Května 798/62, 140 00 Praha

Looking forward to seeing you tomorrow!

Neil

On 9/28/26 20:28, Neil Armstrong wrote:
> Hi All,
> 
> Next week, during the Embedded Linux Conference / Open Source Summit Europe 2026 in Prague,
> we plan to meet up on Thursday the 8th around 19:15 at the Krušovická chalupa bar,
> which is a 10-minute walk from the Conference Center.
> 
> The place has a large variety of food and drinks (menu at https://krusovickachalupa.cz/menu/).
> 
> Please add yourself to the list at https://pad.sfconservancy.org/p/uboot-eoss-2026-meetup shared document.
> 
> We will make a reservation based on the headcount from the list, plus a few extra spots.
> 
> Looking forward to seeing you there!
> 
> Neil

