Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0F1C88E45
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 210406067C;
	Fri, 11 Sep 2026 13:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQeMo7N7vyJF; Fri, 11 Sep 2026 13:57:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1841460644
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789135049;
	b=AJIU3w8N5C2a9cAme3Xy1bk5YB4KhUyImqjiFSb5inO0Vv+ZE4oLvc1VC91+ReqCH1PU
	 TyYstbqqg6/C6gyn4FgU4rC9qzTx6lZaXtxGSgZIAr47cW02gk1l+D3jWLjbwLuvI7joE
	 8vC/q1iVY8gxvEbSeRFPbuUIvt6oURYi9HKeqYrK6HTbne4QbRcOzSM0TmFr6J0oUx7jq
	 EmKJWxzH7axnxxOVkKYjl8H7wVAz7cr+C5jAx+DdZ7flBzGCRgN4kav9a8rCDRtV4cQH+
	 cwR1/11ycrj6+VEe9irj1cnNm8LNN7qvw+c0gY6YZqtK1D9AvnDsr/UiV+DnaeFwLGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789135049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:Content-Language:Autocrypt:Organization:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=8otE4vz5mIII+/Lnf3cuY/StxbMh29Tcv24y8oI3yds=;
	b=Ai9xmsDxXKXMFszqDPhO8Pf5aENN+5jxBfeBSCV6iafhhPjTv2WkPIrKHWL0fOZgOvNj
	 LLQYfLoqAsgDS0RizDDhqe+i6QdY3JxF0o/51nesQvFux+lSoCzeVg6xl3eK0wVYhZiOU
	 R0TiIX+hFOzNHodGWTm3zd5eJ24jJlYBvbx01uvFJX7+do9lYH2IGNoKzHbmD77VpPvHA
	 5h6xKChpPiovOSSEJqa7Uvj9DipY8yU1atLD71li111E3qJTdv5yp6ND/RTC5a8mqpRk1
	 oq+IRdTWc51R/b00QnCYNHM7F5L6Sw95oFU/KSQhNkPWzl5tU20KsV+O5FHD4c5wCUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=twgOcGN5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789135049;
	bh=8otE4vz5mIII+/Lnf3cuY/StxbMh29Tcv24y8oI3yds=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=qxrbFffDyz+hMlvc6HigfSmBWYCT/2ipcpwdxB90/q3yzdGwMut9KPw1PcVmFoyxS
	 MaASNV+g5m42wA8xCA94hByt+Uc5KSUXUVP08a7jSZN1POL+HTi3ZRVnZgfp9F1FoC
	 kFMqhPloUBC8m6ar67+dUl2Z6Ak320xWtPiUWtGoHsm+qH7Zzm776jTozlihyoPNTz
	 22DJa1gJP/++pAmIzG4VJlGJYQf5+tMsZ+l2Dge6Amx9T8dbWz5CzRa5DW54/TDETH
	 HncLKXIk12OCEWN+9SPBufrUX90OpbUkkxIeIlN1CBmULGnCS92mDCYAOoCmu6pGyp
	 LcN1Mm+X4oEyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1841460644;
	Fri, 11 Sep 2026 13:57:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B5C16701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B34E36066A
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxeMkbzUvq3f for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:57:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5CE6F60644
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789135046;
 b=BS4f8a2yS0Uaz98UtJI4C3bIqI30rxrZ65P35iyP4gGxDY7nqIRyq/ZX5UoiEUZer9jt
 qvJUFXfQc2MQxb1nWM4gL0EJJkT2A4tqh2ju+79IW7yYIJNGsAG8XHSmJsPsnr5TZZcWU
 mXOkD1FBkJG6bL/CBsQwVqJjUp8r3PaOa/IXgXFI9C9E2oD9aKOFYsSQhgdSR59Z76mgr
 kJ80Ff0fWQetVHQO7Y3y8/6Smruj62o7QM5G1NOmCqrbzBEUd/1gQJ3W0510nsZ25n1y1
 TADjcuhPNyC33KFrUf0Zi8o8ky+7DhUk0r/KzRShLcLAP9Oov9grACPfzetbYlNfSQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789135046;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:Content-Language:
 Autocrypt:Organization:Content-Type:Content-Transfer-Encoding;
 bh=8otE4vz5mIII+/Lnf3cuY/StxbMh29Tcv24y8oI3yds=;
 b=XyifWEAhr4TPPvFxaJe7euY1p8vFEiRUegkTAuTWwOR4krYlzogfxhQ1CpGH+sDzdYKa
 9g8FAjMC1IP2OS0UeELPKL7VpFzPKmS3Xy6G11pOL7ivfNmfiKTkKSb9HdN5rKITUg+9c
 Mvt4UekzyWBOCc09CWg+kCu4qNx4fe9BcMbrm6JJo+o8OFzKO6fj5DwOA3R3mS9iqjJkl
 6ys87oQcYVP6EsbAmh7IxTINDaA5ndt0CrAfclS066dE4e3dSGvucSUWbw3vevTTDrFmC
 T5TqsQBX4vrX/kS8gz4sC2VSj+2P0miLuT1Rq/82IiC1ky5vs1C7rV8owHR/gMTgsZA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=twgOcGN5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=twgOcGN5
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CE6F60644
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:57:25 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso14359785e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789135044; x=1789739844;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8otE4vz5mIII+/Lnf3cuY/StxbMh29Tcv24y8oI3yds=;
 b=twgOcGN5Aan0+jMzdFg6LMbYQYsRhPBoMiueGG4LbiZXS4sd+CxD6/2SkticSpSnBB
 XJ+4/2GRpGGuBSHHBN8t9+o70o+Ge6xiXVP3c5VwHy260Z8u1LKhdmMRJBrdzT6jBknr
 TrUDT13qe8Hk91FA6RSic/3p1g2cjcrBMsjiY+FsIbEhfllAN2wzzK/+XCJfudr6YcVe
 PgZwzViTTkkKiUMo/Bf1Jz3m7ZjwxZMj+P+RNSdDWvkZ6r+TxxH1eEDgrHU3Co2st3PQ
 vXDYz7m9/ip/8vDz2F96Jk1nk3rqY0YWbKZVTjSZzclrElsPmsqtSbQjsLeHn16kWmsH
 5sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789135044; x=1789739844;
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8otE4vz5mIII+/Lnf3cuY/StxbMh29Tcv24y8oI3yds=;
 b=W4rvpvnSPFRZaXc/Rcmh8EvRLjcEqOuM16RNEO5DAE06VxY4g26T8mitX0G2h98FuG
 rAxug997nyfc0vrfVqFGHB6Yf2dpIRv/8dtYNCB2d3RPq+biOyzDia41IK8Fkq1hWfsJ
 WdH7eUrRXHY9/3mmliMRWW8L2gSVo2c+nVeijyYh0jQtDUN1Ub/7cHd0VPdycBqciwt/
 Hz8LE1ov6BflaKCTqMZD249T5ommMFusCCKfO65vNrl7V54LSIHbk5lx9x4sHHK2TISU
 IAxhJOgtiNY3uyRXzk3GZ6D6kgiIYWLXchYPYTFHt3knvick420W22tfi19EoVlQ9TVJ
 t9TA==
X-Gm-Message-State: AFuF++l3YBnhcScnjSio6tj8HPIlC4tKzkM0cuIvFsayjSMbONS3MW5D
 g72rRo3+PmTkDOqj6jbFseMKECt2JXiUTJAUGSZPB4pfwoBpmAkRKyRAKjnP/m7UUTWUWZSUvUW
 dcFVFp3o=
X-Gm-Gg: AYBFou3PKfr9q3iPwsjYypCfxYSrz6dZW8EzYbSyj4vl+3yJRVYbAHcCALVDBX0O10H
 JZhDU4E8TY5l87eibykrn7QH4+L4EX73zRv6D3pXpez9oQSVC5GKGj7WVAT8dDxYF4Zw1GF7OUr
 0FC33w3I9vWk4mjdpqubBvCQa5BjT2zq1mmPZQ3o0utOmDTaywmhkHuN88R/nJl/fpp7mWD3JuH
 mFQOyso83i5J6dCmGeE5AchFcPB9w1I+aU3Lk1n+KLIvqrIMmuOBXo/9AYQ3xTPPI0XaZomHTJz
 fm6v3lZdKMxKOPjjy0gy+Pikxa9uXEX314jYtFJlk+uio2RPQVM7J+14ibJUg0WptKGj76C3/ZM
 sng48b34M7/0mjc+vs8GTyoIxgS2lb9Od85YPAAqKL37oW5wXpsTECftLbZnuyePgujWJmDYnSt
 MvKm+V5J7jKLFSEUaNnVDXwy6MUMEY3q9dZ9C5q2ny/jEWVi0mwL3fUYu7Dtdbr+eZ/WXoR84sO
 LHh+QbAdiUu+iXx1psT/aqzYlhXYUwXuzk9soP/XesZtTiIwa8xl/sp4I2Jo0gYsw==
X-Received: by 2002:a05:600d:8649:10b0:49c:e1cd:536 with SMTP id
 5b1f17b1804b1-49e61988908mr38022305e9.12.1789135043728; 
 Fri, 11 Sep 2026 06:57:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2a61:5ca8:b7f3:2a11?
 ([2a01:e0a:106d:1080:2a61:5ca8:b7f3:2a11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6aac22bbsm52605e9.0.2026.09.11.06.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 06:57:23 -0700 (PDT)
Message-ID: <6a802e6a-5c25-4c07-a33e-d2043e3eac4e@linaro.org>
Date: Fri, 11 Sep 2026 15:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-nvme-fixes-20260911
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, Bin Meng <bmeng.cn@gmail.com>
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

Hi Tom,

This a set of fixes to support NVMe on Apple M series with macOS 15+ firmware & M4 support.

Thanks,
Neil

The following changes since commit b4ac71db13a33c4e6532c60a781ddf34b7f4375a:

   Prepare v2026.10-rc4 (2026-09-07 14:08:25 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-nvme.git tags/u-boot-nvme-fixes-20260911

for you to fetch changes up to b3f756587082dac42a828ed74b58f64ac4f336e5:

   nvme: apple: Drop the PRP null check chicken bit (2026-09-10 15:14:28 +0200)

----------------------------------------------------------------
- Apple NVMe fixes for macOS 15+ firmware / M4 support

----------------------------------------------------------------
Janne Grunau (4):
       nvme: apple: Don't set a DMA direction for commands without a data transfer
       nvme: apple: Never set the opcode in the NVMMU TCB
       nvme: apple: Add WARN_ON_ONCE for non page-aligned admin queue buffers
       nvme: apple: Drop the PRP null check chicken bit

  drivers/nvme/nvme_apple.c | 19 ++++++++++++-------
  1 file changed, 12 insertions(+), 7 deletions(-)
