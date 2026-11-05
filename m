Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97E606A329
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l3pqwrIL;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r3tU8nvr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 738D7606D3;
	Thu,  5 Nov 2026 10:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OGNgSMjaipv; Thu,  5 Nov 2026 10:39:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9AD76078E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793875174;
	b=ZLP94GkAwSG9K3i35QpM77aqmK9Y/NgRF72SEJuVQ8bkU+i/tKevbcLy76WNwJPiO0SK
	 AH6e6t3tV2LAfk/lV4U8skTso7BBU5uXk+s7M5ocmP87FtkFqCMv2zk837N+BE4vw9GZd
	 45aYIEy6klUboh4EhsY7tOK0vdt0Z4fRA9f/zAnHNcIE+jKp2uXj58cwULcMhI8K5m8Bs
	 IZ5KpW3aiaKcNrKZ8gzrY/bPnuJIEwQSc5WhFRkQCoDFwWU7/SSKsznXZOI591I6NMoF2
	 2OgSlsHTid4eZxa0awaQ+mFjKTkBySysq5ZGjIViCMnm+01ECT1hddMAJtlR4S3/15w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793875174;
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
	bh=d3wtW0I6Uxgv741irRUou366hPVWHMrW7CGGaDkl/bY=;
	b=IOosXa7DfwA8/IFwvIhR2Rvi8T9EK3zE7seKFQJOmxj8D2fIvcbhSTnoQ3QuFtSfQlpQ
	 aRXKK5PdArdCTh8yGWXF4ncgeQAeAyBo7dD0OWKXK5XaOptI3ERoos+bsHU7NH9jEWYRM
	 V1NkYkR6sYtsC8f3pKDfHh4I9LQnxFrLyHHA6mL2xzFeYPDWO6Peb9EwJZpNsM0BZocgg
	 8SG//dv0Zp1J8B4jOJSD6OhvJowq8Iwg2yC/uQZQlmkQ2mVbVGOXlvAAP/KbyxBGJuR6s
	 yO/IUgsHLySBjzUx64Mn4uKcOeQGLy7hEdukgvlsjvGd/nTo3zJryVX7OFurDFnfs8Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=r3tU8nvr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793875174;
	bh=d3wtW0I6Uxgv741irRUou366hPVWHMrW7CGGaDkl/bY=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=l3pqwrILFdW+Epg1nvIv8/Gn6XTCr060oJpPNrDEycUU0LhXqqew97RVv6aMK6sDQ
	 yF8FHgaKDw6F2rgrTAK2axV5R4P7tOufxy7Irfobl+UhzoAz1X7jwW+LypSLDp5SEe
	 ZlpTHDNMzTWjLLTB3EzDeGUXw+/4VITpNeYgL+Yr+tKTpROyhF5D0Uh0NXT7j0yzXO
	 C/9hyKKc3v7K6JYASKTbJlDWTtRjyfOhZbqx7Z7s5pHMK77vhUE46yZoU+dOQ1HvcP
	 u8Zt+BlRcAhoko6pN/t+7U8DRAuQrj/uEHGWQaOkjdR4YQx/7/j3zj/BzUdC4GtODt
	 xxQKAcNGkzJqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9AD76078E;
	Thu,  5 Nov 2026 10:39:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 251871779
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 16F976078E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bpMwHaOUwCff for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 10DAE606D3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=r3tU8nvr
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 10DAE606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:39:30 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so18215475e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793875169; x=1794479969;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d3wtW0I6Uxgv741irRUou366hPVWHMrW7CGGaDkl/bY=;
 b=r3tU8nvru3PGsV3ZOg7IU55PiQ9hn30Itps7m2Cu1NX9ly7nxZWFyDt8UgCEhD2sja
 iCrkSCVQCVa+8+YhT4nTuch+wGKl17RqWDtIq81EkuUEQ3zItF9g3Kkj/1AnZOwN3Q/J
 Tkz6JCDXDAWf6F3R38E5zohPLqCaZ5BAOFGELr+UNpvUbnm5CMUq0AD3i7u+FRtCsPS7
 nNT4+WJPM+GLN1Ef5r6SE+sgXZ9o8p/84L9y/sdPnhrGojhHvDT1BEOelN9P2cJnUc8f
 /HJYSPDC4qn9lZoGLh2lQ0f388COw0LcIbPEW+uwEl8l5cRjc0ho28UZ8qIotYeY8yrd
 SSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793875169; x=1794479969;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d3wtW0I6Uxgv741irRUou366hPVWHMrW7CGGaDkl/bY=;
 b=JFz7kfSN70LVscwNuKQfVgww9RTpq5eJ6AG0tyvhznwujZIFTrhcbAvX1dpXBjmYb0
 q8+4Y8m7Y5TyTPvaVMdRjJuPvcN0/HBIx3SoAEIoByKSnyYM2xSE6CoYTdNSPN5PijMn
 w7UYi34QgMqOfHjDYx84g2J+vPlFyNFNUzR1fncep4c/EhE42Z93QY10sZMVldQWvRkJ
 LqhGyj/ZYWcPZE9CDPu9x1ZG6FvSy9XDFfSlRfCJnTyuatg5UE5myfF9PoxAXg6LsbSZ
 4W0cRpJqKCjQrFWUBUOZEhcxGz4S5W6WAAua6meJSKym4f4WpieLFANvGKvtSbXjjjtQ
 XNOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxj0uhKqPl+25W1AGKG7goJi3Cq/jKg4iaOSCNGqwA+qQ4KWEl0aSGlHaiDO9jwUN0tI1h0kpc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9hkTJwa6ln15uVbB8figPl5JvVPsINyGIvlnee5uepiYhTYEeY
 90X4r7smW49IkMQ/waSZ+WkMf2BSs14V8RXLFI296vPcSinXsVUNrynBym8bWLuI7DE=
X-Gm-Gg: AYBFou28MECfNdtAh33woOKbA6B8sFFXrJw5EjstzRDs5gC+rrZNMiXj6rbGnth61Bq
 5LvrXmTeie/mgMAKhVl78gQSyVR1bPMstPGGikoRuIB19vljNg+HV1VzK/9jtpUxmfvkYT1n6me
 cHYuA4x17Rb/dtjEntDMcnIwnv9mbFflNeCpEtuIVvvBGSxA56i8wnXeWK6u2Ra8yHN0TA1SnRO
 nj08q98bnAsuMti9d0cL+nrwtoiq//l3qe42WhN1WU0WCKGUelojNYpAH0iM+peLjlV7xuy1N9Y
 UvC4UvXikNaS/VjOANzHuYqY2WRbAaIKhVtPm5dkxeyPmnLOiUEoh7fhvWayAbnH406ZNlHDBHI
 EUedorkhpyMwJey0iXV0CHJrJ0BfUfuhz+2maLplRXM5W5NIVbkBnbgNq3PO8D2QtWiDYTKkpFS
 vLKTDhRSVDws3U1elETg17QsoYm4au6AvFkoOLfBDoUie7MSLw/AINonnrsUF6V7a0yyYfW22qX
 qmLZZBLRXmQ5ipJW5zC0ulZk6rpLBZPTsPWbJ+TdjIWiFLcGoAxtnp3z7ExsvYxx4WF8JojQqaa
 gmnT3E+4XmreFvs8ttUAd7t4OTrznvKx3sDHJ4K3RC4dLka36q40u13xq7Dq2Sf/Dkv+VShBFC7
 yeK4IXr2x
X-Received: by 2002:a05:600c:1d16:b0:4a1:fa33:441a with SMTP id
 5b1f17b1804b1-4ac151a8fd2mr418372555e9.2.1793875168566; 
 Thu, 05 Nov 2026 02:39:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57317cae5sm87380905e9.12.2026.11.05.02.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:39:28 -0800 (PST)
Message-ID: <7f777603-2956-43f6-b693-1e6adbdcbec3@linaro.org>
Date: Thu, 5 Nov 2026 11:39:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 3/9] pci: pcie_dw_qcom: program PARF DBI/ATU base
 address registers
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, senthilkumar.l@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
 <20261104163408.1250410-4-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104163408.1250410-4-sumit.dhami@oss.qualcomm.com>
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

On 11/4/26 17:33, Sumit Singh Dhami wrote:
> From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> 
> The V2 DBI/ATU base address and slave-address-space-size PARF
> registers remain unprogrammed and retain their hardware-reset
> default of 0.
> 
> Program these registers so the RC's internal routing logic knows the
> location of its DBI/ATU register blocks, matching Linux's
> qcom_pcie_configure_dbi_atu_base() implementation for
> IP revision 1_9_0.
> 
> Also, remove the unused legacy PARF_DBI_BASE_ADDR and
> PARF_SLV_ADDR_SPACE_SIZE which are not required for IP revision 1_9_0.
> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/pci/pcie_dw_qcom.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
> index 1215346bcb4..dbcdc82224f 100644
> --- a/drivers/pci/pcie_dw_qcom.c
> +++ b/drivers/pci/pcie_dw_qcom.c
> @@ -17,6 +17,7 @@
>   #include <linux/delay.h>
>   #include <linux/log2.h>
>   #include <linux/bitfield.h>
> +#include <linux/kernel.h>
>   #include <linux/sizes.h>
>   
>   #include "pcie_dw_common.h"
> @@ -49,7 +50,6 @@ struct qcom_pcie {
>   #define PARF_PHY_CTRL				0x40
>   #define PARF_PHY_REFCLK				0x4c
>   #define PARF_CONFIG_BITS			0x50
> -#define PARF_DBI_BASE_ADDR			0x168
>   #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>   #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
> @@ -57,7 +57,12 @@ struct qcom_pcie {
>   #define PARF_LTSSM				0x1b0
>   #define PARF_SID_OFFSET				0x234
>   #define PARF_BDF_TRANSLATE_CFG			0x24c
> -#define PARF_SLV_ADDR_SPACE_SIZE		0x358
> +#define PARF_DBI_BASE_ADDR_V2			0x350
> +#define PARF_DBI_BASE_ADDR_V2_HI		0x354
> +#define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
> +#define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
> +#define PARF_ATU_BASE_ADDR			0x634
> +#define PARF_ATU_BASE_ADDR_HI			0x638
>   #define PARF_DEVICE_TYPE			0x1000
>   #define PARF_BDF_TO_SID_TABLE_N			0x2000
>   
> @@ -111,8 +116,8 @@ struct qcom_pcie {
>   /* PARF_CONFIG_BITS register fields */
>   #define PHY_RX0_EQ(x)				FIELD_PREP(GENMASK(26, 24), x)
>   
> -/* PARF_SLV_ADDR_SPACE_SIZE register value */
> -#define SLV_ADDR_SPACE_SZ			0x10000000
> +/* PARF_SLV_ADDR_SPACE_SIZE_V2/_HI register value (64-bit pair, matches Linux) */
> +#define SLV_ADDR_SPACE_SZ_V2_HI			0x80000000
>   
>   /* PARF_MHI_CLOCK_RESET_CTRL register fields */
>   #define AHB_CLK_EN				BIT(0)
> @@ -298,6 +303,7 @@ static int qcom_pcie_init_port(struct udevice *dev)
>   	struct qcom_pcie *priv = dev_get_priv(dev);
>   	int vreg, ret;
>   	u32 val;
> +	u64 dbi_phys, atu_phys;
>   
>   	dm_gpio_set_value(&priv->rst_gpio, 1);
>   	udelay(PERST_DELAY_US);
> @@ -346,8 +352,16 @@ static int qcom_pcie_init_port(struct udevice *dev)
>   	val &= ~PHY_TEST_PWR_DOWN;
>   	writel(val, priv->parf + PARF_PHY_CTRL);
>   
> -	/* change DBI base address */
> -	writel(0, priv->parf + PARF_DBI_BASE_ADDR);
> +	/* Tell the RC where its DBI/ATU blocks live, and size the slave address space */
> +	dbi_phys = (u64)(uintptr_t)priv->dw.dbi_base;
> +	atu_phys = (u64)(uintptr_t)priv->dw.atu_base;
> +
> +	writel(lower_32_bits(dbi_phys), priv->parf + PARF_DBI_BASE_ADDR_V2);
> +	writel(upper_32_bits(dbi_phys), priv->parf + PARF_DBI_BASE_ADDR_V2_HI);
> +	writel(lower_32_bits(atu_phys), priv->parf + PARF_ATU_BASE_ADDR);
> +	writel(upper_32_bits(atu_phys), priv->parf + PARF_ATU_BASE_ADDR_HI);
> +	writel(0x0, priv->parf + PARF_SLV_ADDR_SPACE_SIZE_V2);
> +	writel(SLV_ADDR_SPACE_SZ_V2_HI, priv->parf + PARF_SLV_ADDR_SPACE_SIZE_V2_HI);
>   
>   	/* MAC PHY_POWERDOWN MUX DISABLE  */
>   	val = readl(priv->parf + PARF_SYS_CTRL);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
