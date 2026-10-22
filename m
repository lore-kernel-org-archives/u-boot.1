Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E065606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CSAqdj6q;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=c/Xq8YG2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7660560834;
	Thu, 22 Oct 2026 07:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NukU45aFTMPD; Thu, 22 Oct 2026 07:50:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A60D607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792655409;
	b=M9htX1uUPG1GCl2yKaZwe3TRB/wnrEps9pIQEhm+e309ob9eAmcNVRRN1FOJmGBaLk8X
	 AJFTnuKJqy5f94SJPtRpgMe29wZAUp65zkxjUzS+otq6ItEzn2C4RNC5160kppAvp9RfO
	 O56yQjivC1iTOpkviwNdUCMhH+Jgdt/5By2IdVXYULFOtIY7a+562beghhMiAsJsErCnN
	 DxxudhK7K2lPTvtANrKiHKI53bsmw8W6+z11y4hjUglnoDlE/ujvZ9y4cztupceC2Tadw
	 14nE8xWomxvfd+AhPmrUgrRHFhN3+wkvff25Fq78FxDM9Im9ijXOLG+tC09NLU6AxSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792655409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:References:Content-Language:
	 Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=qWzvXS6qIdN328ERr30ki9VVZapx5rTd5Pm9vBAJtxA=;
	b=gTE2wLvxcjDxfhqgzd+DbhFb84KtSx5MTrbCMYyigLxHm+UIKpwlnZ1er52+x0EbNRLJ
	 V9rEcxMEhESaYSvEk9+/OpqWsoeX9TdyTxbXrH889MO54XWfpbUX9/fezboPw7FS4FXyZ
	 PyCieEplFIgPY8KeIuO5uehX3Fg1AfChl3rQCFfPMb4PmeDfzEGYWJZd3YaH9AD1Pob1S
	 qNuWJ5e3HzvUA9Oe9ZFPhqH2cDLgNlbf9Sp4N2PSl0S2TweSApzUe4ex3huUNWyCaV6ig
	 mOFGE4i6F8fvZJhFBAgPfn2TjDyJ9oPavUhn/oOGDlSp+0U9sKVc3LLnEODS3Du+CUw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="c/Xq8YG2";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792655409;
	bh=qWzvXS6qIdN328ERr30ki9VVZapx5rTd5Pm9vBAJtxA=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=CSAqdj6qbbANb5JyYBx+YP9dWCgDBGKul4rYC07zlx27+C4mkvQ4r0+7fY2w3VSMu
	 i3IUxTt6MjKqhSODAeqVbi9iSIUUbfacQYPaUZRAF0VyHXKRAiKNBe6bI40iL0FMr+
	 VCe5aKN3WpgtnEi1jmtS5yNiZzyhsZP4YpqbRlh7jg5wrZM61NmzGms4vYJQNyW+35
	 Em69wV6IQZzESg9OYw2k/Uhk6FoEzQFvdCjBWIGYEqdckVPPp5te1cA1443UtW+4ZH
	 4iL1ysKXCbWj7pCPg3ODe2VaDPsvOtnM5u79u3qrc3mduMeuxGi00lUnYh4wniPL4D
	 UlrR7n23B1m4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A60D607C4;
	Thu, 22 Oct 2026 07:50:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE1F81AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0133607C4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUeMC4oFDO-T for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:50:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 860FA6066A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792655407;
 b=R6wfHFOKTOMRMdreAaCkRyYvwMZFrGaBYqwuX2f0RAMncCOMwSpkmisbwC5ZjjeK7SzN
 +1ywhlC1wQc2BjOCEtZb0VOCnKNY3blFDzbX2qxWXiBQb4j7M8Z5K1GUlfykFE969DgFn
 VwjxMf5TtSmhmJ74t6Z8aUJ1oEpjdsMvvL4xElKtLTUuOdUVSXM27+ENBH01vz8FOwGul
 ztqDC16UGexoEn/INTw+DJctrbk2R8W/Zp5n461/bVJcGdakiwGZVH6L5jVeDWoHk605l
 S8r2xb+rkMwaG6cteeRyYLaV26Y0KT7iVFLVEwQCpn5USlIJSo/trn7movFG/wUmriA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792655407;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:
 References:Content-Language:Autocrypt:Organization:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=qWzvXS6qIdN328ERr30ki9VVZapx5rTd5Pm9vBAJtxA=;
 b=tglcY5drTEf8hG+LEEnAL2AckdBXeGrWNhc9ciuVWAi/oGsfDDNnd7r3p4HVZXeEpE9v
 qYYBaNlzZp1yp8JC9WnwYXLw0OvQ7NZeT1klrtklUerFE2l+kR7cLlT9yPYoxNbEh6a5e
 AuzE7jA2G2prC/ZPBhNL66oIAwwaXXmKuk98zIhMhcezbzupwR6NWcPdgJaYxJQW1we13
 1lGwu8nTVKcxDaYWOj1DJnxQSHeE0/PqRWLIVuQ7YWXulqTIQWp8Uzl+fMpRbTPP34l7Y
 /4k4uslGiYjQFb0LIyeLL8IARaK92poTLprb11Qws+EslR3L5tWV3cW35tNkuNbpCYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="c/Xq8YG2"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=c/Xq8YG2
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 860FA6066A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:50:05 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so1430885f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792655404; x=1793260204;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qWzvXS6qIdN328ERr30ki9VVZapx5rTd5Pm9vBAJtxA=;
 b=c/Xq8YG2uy3CTgxWYz+DclriesHQUbou/MXfwawFb4JijS0z1Fdq5UC9RcIS0WeBh4
 rArBaa9hiugKtinFuPs0TvU5IpJazLosRxxO3eW7H5yf2CgZoQFjVYYAsz7xwLiStW43
 KWVcPX6Bf+SoF71+Snoa45xC6lRSlx1b4+xyc+buf4Y3ce/4IzhxsVSfvfwtILSMuBS1
 93DHyovnRuBLEWSiVyuo/DL7ZU3qqphQZPYFKJf2gkMC4iz5NLWRN13iVcUHj3Do++1E
 crYgrdiHGnCZ4eblGdspVNy/W+ixdtVLldLeg/ue8eT/E+fFT0Alel1Qd/S3K9+odnUX
 cw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655404; x=1793260204;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qWzvXS6qIdN328ERr30ki9VVZapx5rTd5Pm9vBAJtxA=;
 b=m8A68RS4mbqTRvuE+HVGxxWutntrMEZUqrrC9CCrvSlbGKxpgJdzKZ3t3s4nffQCVz
 2mu87NKo52f0E7G6/IPzyIZbqlcrjZOwCrGUpBUPn6w+xILyVvh7Zat4i/7AnBxtlGSH
 QuiLmniud7kZ7kRzMIxv2ygsjTyVVhXM7etUHZ0owB+A3UPnAVdAf/pMirlndnyTQzSe
 ChrXjyr41b95yLSyI2O1wU5msyWKf5xrsHIpkm9YAMNTCIZfH4rYMVZKkYRL1Hs60YPy
 6nuFWBY8cej/Nn47SlPNKENMDmeCR8Osp8FmoMeqWz8ijWo7e/T78aCHVOqh7EBfEjk7
 VS2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzanrIloh+Xl6IqlkLVjX/l5wb5RFTREJV2MA5VZ4r70d1BiLWxSNzI/WOIAbM2SAdLFrndHUg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJF2qhk1R/cSCSg/wgfhynkVoAYfb0bld8rgU8hOmAVfFVzaVBs
 rAGPnS/cpK5VXOk2F1bbwQzd05EdJXvNzfQlKLJwbtR+r0+/t/fRMF232XzWEKeVqKQ=
X-Gm-Gg: AYBFou1v9bXB0jhTL7g8Q+D/4QI8tfNJUijlji0iQt+BJzVw5l4CP7gOvI7SReXQDdv
 0WsO4Dq6DKfGq7/OTgDiRh/f9hhJHLk+FwDTtkW/hagCkVvPu0Xr6m26CqW3cZC7h6246FMj2Hh
 hs8hwGwZOouclUxqwcZNn9F1gfuorUCVWBI0HRQCa8uzY5cOvxFeXj/zPCwYrkEOt2fe0lY6FJV
 GmIeilUt/kKo+hP+wf9KM4GUyomKRn0rUoG0oIAyE7He0VKL3MHTHoSGJkAbQjFLTkYwjKK40iK
 ESdY16izQXQtaZpNd0/KGXPwiQWguc6NGtyFvrVrlcB9DeFPtTpIKDJyk7uUnBgB+hy0QzrQntB
 q5OwsUHBYXkzfbCi74d/bQAp+0lbkwoISCjEhNZ4Ft+TI4K98I1IVaSR67ldsjaaQprF7poyGgd
 fHIidYQoJJ26L4it2mzBi3mjw6U+2g9t5F46jORZueyN0jcTYBRdA6W6PnGCKuzwZmd3FIdjdSN
 oUuZwA3lUWT/RM1YSZvKkjWJCEUU/2S2lQ1NqFVpSn6WrWU+qRaGQ73wTwU8g37v2KdXIyJZDol
 Kv1/ZxBW8wOFfbX9zKJd0MJhACpXPehHo24=
X-Received: by 2002:a05:6000:4a15:b0:48e:a9:9e2e with SMTP id
 ffacd0b85a97d-48e264a6338mr9231355f8f.14.1792655403921; 
 Thu, 22 Oct 2026 00:50:03 -0700 (PDT)
Received: from ?IPV6:2a01:cb1c:fcf:4600:211e:45da:8a88:2665?
 ([2a01:cb1c:fcf:4600:211e:45da:8a88:2665])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828c6dsm11382888f8f.24.2026.10.22.00.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 00:50:03 -0700 (PDT)
Message-ID: <fa445af4-cfeb-4ad6-a8e6-08395660bcc4@linaro.org>
Date: Thu, 22 Oct 2026 09:50:03 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/8] clk: qcom: add GCC driver for nord
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 lukma@nabladev.com, marek.vasut+usb@mailbox.org, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, nikroks@mainlining.org, luca.weiss@fairphone.com,
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com>
 <20261021160448.3893858-2-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20261021160448.3893858-2-aswin.murugan@oss.qualcomm.com>
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

On 10/21/26 18:04, Aswin Murugan wrote:
> Add support for the nord Global Clock Controller (GCC).
> 
> Implement the qcom,nord-gcc driver to provide clocks, resets and
> power domains required by nord peripherals.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/Kconfig          |   8 ++
>   drivers/clk/qcom/Makefile         |   1 +
>   drivers/clk/qcom/clock-nord-gcc.c | 165 ++++++++++++++++++++++++++++++
>   3 files changed, 174 insertions(+)
>   create mode 100644 drivers/clk/qcom/clock-nord-gcc.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 1a7957e2201..7228d5ecbf9 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -55,6 +55,14 @@ config CLK_QCOM_MILOS
>   	  on the Snapdragon Milos SoC. This driver supports the clocks
>   	  and resets exposed by the GCC hardware block.
>   
> +config CLK_QCOM_NORD
> +	bool "Qualcomm Nord GCC"
> +	select CLK_QCOM
> +	help
> +	  Say Y here to enable support for the Global Clock Controller
> +	  on the Snapdragon Nord SoC. This driver supports the clocks
> +	  and resets exposed by the GCC hardware block.
> +
>   config CLK_QCOM_QCM2290
>   	bool "Qualcomm QCM2290 GCC"
>   	select CLK_QCOM
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 58d8166072d..193740682aa 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>   obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
>   obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
>   obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
> +obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
>   obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>   obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>   obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
> diff --git a/drivers/clk/qcom/clock-nord-gcc.c b/drivers/clk/qcom/clock-nord-gcc.c
> new file mode 100644
> index 00000000000..af38b3b1daa
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-nord-gcc.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,nord-gcc.h>
> +#include "clock-qcom.h"
> +
> +static const struct gate_clk nord_gcc_clks[] = {
> +	GATE_CLK_POLLED(GCC_MMU_0_TCU_VOTE_CLK,      0x7d094, BIT(0),  0x7d094),
> +	GATE_CLK_POLLED(GCC_PCIE_A_AUX_CLK,          0x9d008, BIT(14), 0x49058),
> +	GATE_CLK_POLLED(GCC_PCIE_A_CFG_AHB_CLK,      0x9d008, BIT(13), 0x49054),
> +	GATE_CLK_POLLED(GCC_PCIE_A_PHY_AUX_CLK,      0x9d010, BIT(12), 0x4d01c),
> +	GATE_CLK_POLLED(GCC_PCIE_A_PHY_RCHNG_CLK,    0x9d008, BIT(16), 0x49078),
> +	GATE_CLK_POLLED(GCC_PCIE_A_SLV_AXI_CLK,      0x9d008, BIT(11), 0x4902c),
> +	GATE_CLK_POLLED(GCC_PCIE_A_SLV_Q2A_AXI_CLK,  0x9d008, BIT(10), 0x49024),
> +	GATE_CLK_POLLED(GCC_PCIE_B_AUX_CLK,          0x9d008, BIT(23), 0x4a058),
> +	GATE_CLK_POLLED(GCC_PCIE_B_CFG_AHB_CLK,      0x9d008, BIT(22), 0x4a054),
> +	GATE_CLK_POLLED(GCC_PCIE_B_PHY_AUX_CLK,      0x9d010, BIT(13), 0x4e01c),
> +	GATE_CLK_POLLED(GCC_PCIE_B_PHY_RCHNG_CLK,    0x9d008, BIT(25), 0x4a078),
> +	GATE_CLK_POLLED(GCC_PCIE_B_SLV_AXI_CLK,      0x9d008, BIT(20), 0x4a02c),
> +	GATE_CLK_POLLED(GCC_PCIE_B_SLV_Q2A_AXI_CLK,  0x9d008, BIT(19), 0x4a024),
> +	GATE_CLK_POLLED(GCC_PCIE_C_AUX_CLK,          0x9d010, BIT(0),  0x4b058),
> +	GATE_CLK_POLLED(GCC_PCIE_C_CFG_AHB_CLK,      0x9d008, BIT(31), 0x4b054),
> +	GATE_CLK_POLLED(GCC_PCIE_C_PHY_AUX_CLK,      0x9d010, BIT(14), 0x4f01c),
> +	GATE_CLK_POLLED(GCC_PCIE_C_PHY_RCHNG_CLK,    0x9d010, BIT(2),  0x4b078),
> +	GATE_CLK_POLLED(GCC_PCIE_C_SLV_AXI_CLK,      0x9d008, BIT(29), 0x4b02c),
> +	GATE_CLK_POLLED(GCC_PCIE_C_SLV_Q2A_AXI_CLK,  0x9d008, BIT(28), 0x4b024),
> +	GATE_CLK_POLLED(GCC_PCIE_D_AUX_CLK,          0x9d010, BIT(9),  0x4c058),
> +	GATE_CLK_POLLED(GCC_PCIE_D_CFG_AHB_CLK,      0x9d010, BIT(8),  0x4c054),
> +	GATE_CLK_POLLED(GCC_PCIE_D_PHY_AUX_CLK,      0x9d010, BIT(16), 0x5001c),
> +	GATE_CLK_POLLED(GCC_PCIE_D_PHY_RCHNG_CLK,    0x9d010, BIT(11), 0x4c078),
> +	GATE_CLK_POLLED(GCC_PCIE_D_SLV_AXI_CLK,      0x9d010, BIT(6),  0x4c02c),
> +	GATE_CLK_POLLED(GCC_PCIE_D_SLV_Q2A_AXI_CLK,  0x9d010, BIT(5),  0x4c024),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_CNOC_SF_QX_CLK, 0x9d010, BIT(24), 0x52040),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_M_CFG_CLK,      0x9d018, BIT(4),  0x52060),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_M_PDB_CLK,      0x9d018, BIT(8),  0x52084),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_PWRCTL_CLK,     0x9d018, BIT(7),  0x52080),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_QOSGEN_EXTREF_CLK, 0x9d010, BIT(19), 0x52074),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_SLAVE_AXI_CLK,  0x9d010, BIT(26), 0x52058),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_S_CFG_CLK,      0x9d018, BIT(5),  0x52064),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_S_PDB_CLK,       0x9d018, BIT(9),  0x5208c),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_TSCTR_CLK,      0x9d010, BIT(18), 0x52070),
> +	GATE_CLK_POLLED(GCC_PCIE_NOC_XO_CLK,         0x9d018, BIT(6),  0x52068),
> +	GATE_CLK_POLLED(GCC_PDM_AHB_CLK,             0x1a004, BIT(0),  0x1a004),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_2X_CLK, 0x9d000, BIT(24), 0x23020),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_CORE_CLK,    0x9d000, BIT(23), 0x2300c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_M_CLK,       0x9d000, BIT(22), 0x23004),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_QSPI_REF_CLK, 0x9d000, BIT(26), 0x23170),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S0_CLK,      0x9d000, BIT(25), 0x2315c),
> +	GATE_CLK_POLLED(GCC_QUPV3_WRAP3_S_AHB_CLK,   0x9d010, BIT(15), 0x23008),
> +	GATE_CLK_POLLED(GCC_SMMU_PCIE_QTC_VOTE_CLK,  0x7d0b8, BIT(0),  0x7d0b8),
> +
> +	GATE_CLK(GCC_BOOT_ROM_AHB_CLK,          0x1f004, BIT(0)),
> +	GATE_CLK(GCC_GP1_CLK,                   0x30000, BIT(0)),
> +	GATE_CLK(GCC_GP2_CLK,                   0x31000, BIT(0)),
> +	GATE_CLK(GCC_PCIE_A_DTI_QTC_CLK,        0x9d008, BIT(8)),
> +	GATE_CLK(GCC_PCIE_A_MSTR_AXI_CLK,       0x9d008, BIT(12)),
> +	GATE_CLK(GCC_PCIE_A_PIPE_CLK,           0x9d008, BIT(15)),
> +	GATE_CLK(GCC_PCIE_B_DTI_QTC_CLK,        0x9d008, BIT(17)),
> +	GATE_CLK(GCC_PCIE_B_MSTR_AXI_CLK,       0x9d008, BIT(21)),
> +	GATE_CLK(GCC_PCIE_B_PIPE_CLK,           0x9d008, BIT(24)),
> +	GATE_CLK(GCC_PCIE_C_DTI_QTC_CLK,        0x9d008, BIT(26)),
> +	GATE_CLK(GCC_PCIE_C_MSTR_AXI_CLK,       0x9d008, BIT(30)),
> +	GATE_CLK(GCC_PCIE_C_PIPE_CLK,           0x9d010, BIT(1)),
> +	GATE_CLK(GCC_PCIE_D_DTI_QTC_CLK,        0x9d010, BIT(3)),
> +	GATE_CLK(GCC_PCIE_D_MSTR_AXI_CLK,       0x9d010, BIT(7)),
> +	GATE_CLK(GCC_PCIE_D_PIPE_CLK,           0x9d010, BIT(10)),
> +	GATE_CLK(GCC_PCIE_NOC_ASYNC_BRIDGE_CLK, 0x9d018, BIT(18)),
> +	GATE_CLK(GCC_PCIE_NOC_MSTR_AXI_CLK,     0x9d010, BIT(25)),
> +	GATE_CLK(GCC_PCIE_NOC_REFGEN_CLK,       0x52078, BIT(0)),
> +	GATE_CLK(GCC_PCIE_NOC_SAFETY_CLK,       0x5207c, BIT(0)),
> +	GATE_CLK(GCC_PDM2_CLK,                  0x1a00c, BIT(0)),
> +	GATE_CLK(GCC_PDM_XO4_CLK,               0x1a008, BIT(0)),
> +};
> +
> +static int nord_gcc_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
> +static const struct qcom_reset_map nord_gcc_resets[] = {
> +	[GCC_PCIE_A_BCR] = { 0x49000 },
> +	[GCC_PCIE_A_LINK_DOWN_BCR] = { 0xb9000 },
> +	[GCC_PCIE_A_NOCSR_COM_PHY_BCR] = { 0xb900c },
> +	[GCC_PCIE_A_PHY_BCR] = { 0x4d000 },
> +	[GCC_PCIE_A_PHY_CFG_AHB_BCR] = { 0xb9014 },
> +	[GCC_PCIE_A_PHY_COM_BCR] = { 0xb9018 },
> +	[GCC_PCIE_A_PHY_NOCSR_COM_PHY_BCR] = { 0xb9010 },
> +	[GCC_PCIE_B_BCR] = { 0x4a000 },
> +	[GCC_PCIE_B_LINK_DOWN_BCR] = { 0xba000 },
> +	[GCC_PCIE_B_NOCSR_COM_PHY_BCR] = { 0xba008 },
> +	[GCC_PCIE_B_PHY_BCR] = { 0x4e000 },
> +	[GCC_PCIE_B_PHY_CFG_AHB_BCR] = { 0xba010 },
> +	[GCC_PCIE_B_PHY_COM_BCR] = { 0xba014 },
> +	[GCC_PCIE_B_PHY_NOCSR_COM_PHY_BCR] = { 0xba00c },
> +	[GCC_PCIE_C_BCR] = { 0x4b000 },
> +	[GCC_PCIE_C_LINK_DOWN_BCR] = { 0xbb07c },
> +	[GCC_PCIE_C_NOCSR_COM_PHY_BCR] = { 0xbb084 },
> +	[GCC_PCIE_C_PHY_BCR] = { 0x4f000 },
> +	[GCC_PCIE_C_PHY_CFG_AHB_BCR] = { 0xbb08c },
> +	[GCC_PCIE_C_PHY_COM_BCR] = { 0xbb090 },
> +	[GCC_PCIE_C_PHY_NOCSR_COM_PHY_BCR] = { 0xbb088 },
> +	[GCC_PCIE_D_BCR] = { 0x4c000 },
> +	[GCC_PCIE_D_LINK_DOWN_BCR] = { 0xbc000 },
> +	[GCC_PCIE_D_NOCSR_COM_PHY_BCR] = { 0xbc008 },
> +	[GCC_PCIE_D_PHY_BCR] = { 0x50000 },
> +	[GCC_PCIE_D_PHY_CFG_AHB_BCR] = { 0xbc010 },
> +	[GCC_PCIE_D_PHY_COM_BCR] = { 0xbc014 },
> +	[GCC_PCIE_D_PHY_NOCSR_COM_PHY_BCR] = { 0xbc00c },
> +	[GCC_PCIE_NOC_BCR] = { 0x52000 },
> +	[GCC_PDM_BCR] = { 0x1a000 },
> +	[GCC_QUPV3_WRAPPER_3_BCR] = { 0x23000 },
> +	[GCC_TCSR_PCIE_BCR] = { 0xb901c },
> +};
> +
> +static const struct qcom_power_map nord_gcc_gdscs[] = {
> +	[GCC_PCIE_A_GDSC] = { 0x49004 },
> +	[GCC_PCIE_A_PHY_GDSC] = { 0x4d004 },
> +	[GCC_PCIE_B_GDSC] = { 0x4a004 },
> +	[GCC_PCIE_B_PHY_GDSC] = { 0x4e004 },
> +	[GCC_PCIE_C_GDSC] = { 0x4b004 },
> +	[GCC_PCIE_C_PHY_GDSC] = { 0x4f004 },
> +	[GCC_PCIE_D_GDSC] = { 0x4c004 },
> +	[GCC_PCIE_D_PHY_GDSC] = { 0x50004 },
> +	[GCC_PCIE_NOC_GDSC] = { 0x52004 },
> +};
> +
> +static struct msm_clk_data nord_gcc_data = {
> +	.resets = nord_gcc_resets,
> +	.num_resets = ARRAY_SIZE(nord_gcc_resets),
> +	.clks = nord_gcc_clks,
> +	.num_clks = ARRAY_SIZE(nord_gcc_clks),
> +
> +	.power_domains = nord_gcc_gdscs,
> +	.num_power_domains = ARRAY_SIZE(nord_gcc_gdscs),
> +
> +	.enable = nord_gcc_enable,
> +};
> +
> +static const struct udevice_id gcc_nord_of_match[] = {
> +	{
> +		.compatible = "qcom,nord-gcc",
> +		.data = (ulong)&nord_gcc_data,
> +	},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(gcc_nord) = {
> +	.name		= "gcc_nord",
> +	.id		= UCLASS_NOP,
> +	.of_match	= gcc_nord_of_match,
> +	.bind		= qcom_cc_bind,
> +	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

Looks good

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
