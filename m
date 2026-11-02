Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B6606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ach7644r;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BQXPK7Cj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iF62s8S8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA51D80EFD;
	Mon,  2 Nov 2026 18:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t0XNVCBRXtBJ; Mon,  2 Nov 2026 18:23:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0341280E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793643789;
	b=Xv8rFmLFt6jw5vJotZ6+6X+fpnXQiqM8fx+RsZgr1mQhqVgCKpYreE5lzToNdn/V7lFr
	 N3Rb6QQBQzU/iCbD8dDUNLcyVvscKOnm0+3QfvMrYWb4hRMJO3mfTmRU9G7qt17dbf3TE
	 bx2R8aBOk5x79EllWIjvpD0k3tBhVzN7VVMHRYJ39W4OWHCbA2OkGKl8IGY4psMBFSaup
	 0dgdKyMAtACLDErd/6uaV8G5YC4EwAIx6c3vH8/lFuknDoMr2KtoP1Mg2eF+yAkMAAZxz
	 nj+LCHgg4TSaekNJoSX/rDjK64o4QX+gNC4BMqQRFnblB+yeEc8DZptJv2WMxuxSZ4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793643789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xZw+jOhNcdt9pZHQa9PPyZEHcYU5j6AskH9HhRq9Wek=;
	b=DZmwmYwIiFLRUUP2dNQx2OtpvyRQwziLlYd61lFGeEjNCT7iwP+iB/4ikMubiGRBIool
	 a0jU1OOPglks+i3S9tnENWK2aHWGQmQ/O73ZGf5jZsyrIJ7a6XB8Aa7mkTIlDI11nhMFJ
	 baV8EqTq0fqb0CIqzFu4spP/+wyGVaSe855DOY+av0H5dDX8frytEYYjPgqTt5QQ9Hx40
	 52Da3Qcpt8J4lsZVyF40QsXefF/47NbCUsF4XtoMNpqjKulc1MnTjYfPoFZH+keMCX7PX
	 dAI4xeJyaaoX5ZiX9PcuFwexad3D+LdRVdcOZxuJE1iRcgno+hKBPEsBRAazdc1+UtA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BQXPK7Cj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iF62s8S8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793643789;
	bh=xZw+jOhNcdt9pZHQa9PPyZEHcYU5j6AskH9HhRq9Wek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ach7644rXoaDHZcTjGM3Qx2X36cmPKm9LBL0pWZ7NP93m+Nj7AxTLr5rWEr6Cup6O
	 /idWUus9/xA4dTNXt1SEuhV6GblGz4r6jcJZmBLh4HqGdZh0Hz5qXdr/QbhceYHK4E
	 dNFQneUk2NjfHAjGPNTyimRSTBhQ8h2JchgmJU/NiqAkKT7DuTiGsm2cpOSaL3xt3w
	 GSseQRqIFKVWCY+xDvLTMl9mj2eXlpvnMeMsrifTMhcZWrAPYYpXIz0MJ71jfgJGFu
	 qvKv6cVbUqt493obZIxu/Nk9+DwdbfUmAU3kUP66nlS0oAWOMyRlpvypDXZDVjIbtQ
	 17dx/4mhhTLmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0341280E0D;
	Mon,  2 Nov 2026 18:23:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EE604BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FDDC80D62
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Az3IYxKnEndf for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 18:23:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30BE880DC2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793643786;
 b=d9Kx+JhY/kAh4fXQMX7zoMLUX3pzfHQRU8yqD3YpidsDNIzPxs6labvT1F4jpME1f1sV
 oZ9vsK5A3KaBhG7wH9RlHQ7htPTHKyU0kYNEhTD7SaZq0aFVJJh3MAnel9DOc6b+tac+m
 clqkoc8/OPVr6wY5NOlOUPFh3olhPxl7NMw9YAz3Hzts6LCpnQJbOKfFgdjnqRP5x7pt+
 bvE8BHMpHJ5J07JMtuXTtjd0+4C37od0mziDywubdYTdmI7sIhTku4WTjNs1n0HQPXJEm
 xXWxCK1VU1Xte5OKQ6djMoQ7DLxbMdw5EVP8ITc7RId29/ojOmAEnHhJCfORIxt3lAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793643786;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=xZw+jOhNcdt9pZHQa9PPyZEHcYU5j6AskH9HhRq9Wek=;
 b=WfZ8/SjLwrijZTwlMhrn2E2d6OMBiW3ryLKFDBisl7h2Z9RV9FW6OaVkH05H/4ZqJOad
 Jiyh3KFr1LVMCNQRRHSufgLw0WdW4L92Iafh9XaaHvubZPQATwmW+ceREerFzDVLRGa46
 wV6SHYyf0PE6YNDWmEImtqYhNTaeSnPqGJploY1beP4SeZmIFtsByqR7znzhOzFgSCANi
 qNAFuncsHz06Ur8G8nrO2pYOlU95Bo9qKnh9/s6FVVJLfd6ZSi5THKVHwqPDYTBRzrku5
 XRqZEUK9Y3yplcn8QrzTID7JcHspz7A+9DulTYwh/nIPwHpvaiGiJgIMm2CsuFNO5TQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BQXPK7Cj; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iF62s8S8; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=BQXPK7Cj; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iF62s8S8
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30BE880DC2
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 18:23:05 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HP2qU939664
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 18:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xZw+jOhNcdt9pZHQa9PPyZEHcYU5j6AskH9HhRq9Wek=; b=BQXPK7CjZr7zLrnC
 bbsVATzsAwe6l9zXDC8OyaUxoY3SDUu1C8rpEieqQxrCfPu0UTMJiVBnK+hvLFse
 Xjbk0nNZXI7bhLrubFRiMwxFDKvPOENyIisFjHdHWtz2kVSzLIKvvmndXDaKv7Ua
 h4T6WZJYV7n6Zci6rctyL58sUMZy7T5HwnIpqHqhSqIgixbT4Kxvf8y4uDmip/Wt
 DUALX+l+c3Ah8nuesPfEKQHLNVAaHtCtKwaXW0HBZWNkerevv00hZ/Ju85uALA21
 Z1N+RaFUxXWuvWK2xiIpFekSkgK/racTxATGfdBImAfxUTZQ5qdiVlLHcQBWreDq
 VooR3g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsa6stte-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 18:23:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3552883bd19so3445738eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 10:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793643783; x=1794248583;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xZw+jOhNcdt9pZHQa9PPyZEHcYU5j6AskH9HhRq9Wek=;
 b=iF62s8S8SVfYG59WI9+e2PFBZByKvIScJK8hU7pGI+3DYaLoQ+CXteWl+6gfrNIpmc
 Ke11H0qKwH0Rx7qo2Ns1JcK+SdZdOxNdP9H27Z9XMwqtN4Epv12L5opVZf9bTGeNdHXP
 OM75EioZJIu2R9avajn6JwM69fmZYbzvf68p/PBCn6OqIVBBHEI8XzNmJ662k+ziQRB/
 JErtjMi+oXrAkRiTUKUIwHRR94Rr2HCYzY+cQI1ahJeTBL1pJKM1BEh4hiwMG2dgjQ8A
 WdMiSaS06MH7HR+UZ+/SytafSuA9tOhVJSd/Mgf/n3wqds/os5oT8lTSLzIL1pr4AgYo
 TB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793643783; x=1794248583;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xZw+jOhNcdt9pZHQa9PPyZEHcYU5j6AskH9HhRq9Wek=;
 b=eo+Uumv6wF7iQNnrShhnvy5iRZtkh4hZb5ml0FSATEQqH3zxwuIH2DnzewBa0lH62V
 YqwwcSRF1SMsRcMJQe1oY+CHUrhCOgZGtipL1/twbSVhYwLGBr6B8MQHfn1dMK+FXwl6
 MuhjLAp7nplI3RSyhmX29XhtDoQ+VDq9OvJ78oK+BGdM3n0bg044IakYsaFmZxKT/axs
 +ONyJhFSF2Jwr+W0LKfUm3l/D4z4HOPDRbqcCy7dSx4vaHWQADzquJcqbZqNxxl6J9bX
 78fLMNlrHkKGoOwGbLJMxh82kkW/oR/YEkROq3SmWAh1OujfQlu+hPLDEHPSMNsDlljp
 MkZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSGD5paED/iww+S6izeYeDJBlHFySdsRogbKeRpPioW65oqIzKgupGJVDAZ4sWo9WEAz+KI8A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9IDOYFGmr/U1kmLHDMTtvC7uDoUax68+5zKaAADLrUPmf4eUYD
 6979NxCILtsDOOPFoWq8TJiUJwuRT1+VWZPvCgwOCc+eb2XlCE/4pGDCJwUQhN4IG0EjMUDjxkg
 8vOk5nnw2sa4d192oHK3mnb709pVr3UJL0D9/AxOCSUZQbazhubpVk2J9hL3EKxBuGcKIfiTz+Y
 AI5XM=
X-Gm-Gg: AYBFou2/vRSxgmEbSYdtSpbo5hh5evRyanarZrPxPQi3vvHBbccIGTCInX6n0b6FYO3
 OY6AdFAOKRvjb/TpyvD+8mPQMiQ22jbtR5Stnr/EweleVt1lScgmhzVKdGIArv0SNAlMJeXKmQm
 YUvlsz53IcZwwTVbNNIQ6+Ke0WFDQnHyXHpbFfcobh/fwt1vFqpHXRiKCixlxmEYnEkdRgp5xIe
 8VbkDsYoRO+DZzZX8wdMXXW4cMXzVlESnRyXoZa6JUgjX99tqJ15TIKqqlEOGDTMK2qj76hMGaM
 bY3FOxwc4OdzkVpIS6jdmqu0lkUfG+GfrDEiAVmk+pGpOyGM+SBGd0OvrcsLdI4b5+iql0ZRVsf
 KhRSkyPgRrB/nr3YRRzJOiu8YRWBpCJYK//ETyMftfUYsoLllpl2/nX9bH4EzSRSfT8qD//u/CD
 fcQqhSrH5mjzfY2w7NWUaOH3Zc2nvOm0Y+rVo/ug==
X-Received: by 2002:a05:7300:6016:b0:35d:f7f4:bc1c with SMTP id
 5a478bee46e88-36a4235facemr14935829eec.6.1793643783019; 
 Mon, 02 Nov 2026 10:23:03 -0800 (PST)
X-Received: by 2002:a05:7300:6016:b0:35d:f7f4:bc1c with SMTP id
 5a478bee46e88-36a4235facemr14935790eec.6.1793643782117; 
 Mon, 02 Nov 2026 10:23:02 -0800 (PST)
Received: from ?IPV6:2401:4900:1f2d:bd1d:fc33:324:5225:5efd?
 ([2401:4900:1f2d:bd1d:fc33:324:5225:5efd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42669128sm42215530eec.3.2026.11.02.10.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 10:23:01 -0800 (PST)
Message-ID: <7ca46186-e53f-46f7-945d-3ef385b485e3@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 23:52:53 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] configs: add shikra defconfig for IQS board
To: Tom Rini <trini@konsulko.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, marek.vasut+usb@mailbox.org,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 luca.weiss@fairphone.com, nikroks@mainlining.org, nathbappai@gmail.com,
 macpaul.lin@mediatek.com, jbx6244@gmail.com, dlechner@baylibre.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com>
 <20261021160916.3894471-10-aswin.murugan@oss.qualcomm.com>
 <20261022165536.GD3621697@bill-the-cat>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261022165536.GD3621697@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3MyBTYWx0ZWRfX7+y1YG4jGJfn
 yCB5B/GCdCtw0373sNGZ3saMHvd0V45xUYBZdE1Ezw5hLrsfYD/T0YT6jn9JR4IXn90pG/ukYeQ
 tyoLTPVxnKwtgBPTvyyhKiJ6zb+UZUEyQnKcU2xXNgsFtvE2vxPNJgI9rSJc9hIR15o+OK1aoYA
 UYWgtk8IaFN8MaO4h09ePSwdF+x2s2WXALeMSLkuAtLS1Cuc1661oKRLdQ6MXB1OwQrpGPHH9Ke
 wIPDov/M3Cyrlk0DczVURzDNLfbDr2dcNi9Yd1gMbm3YygyWXLocS2wVp9hnimY6PnD5OMICMtw
 Iwu5Rlgyk1eqMczKzArA4jQ0TZN7vXrz9Eqsr7ytr3ZDKK5Yv4ECKyHcX6qWgz4gURqYv2eXF3F
 oTAAvmhnS3tyHCpBpjJutERn9jURNpJdY7soVvjN7WQVMPO2yL+eBsoonmjk4w+OGverEMDZKzp
 R4cAICt3CRsMgRO4XwQ==
X-Proofpoint-GUID: IF_05WheP13M1a8rz43Of3DOaLNGosnV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3MyBTYWx0ZWRfX1URCcJl1IhDk
 dnWAM23W5X3JbOVzexqndHozqPrWzANtN1bY1Dj3BqjC/kwz5LthVszXXyheZBO30Fh0P7mbOyC
 oGd0JJ8L/rMXwEFwmIeg9xLYwIgEpgo=
X-Proofpoint-ORIG-GUID: IF_05WheP13M1a8rz43Of3DOaLNGosnV
X-Authority-Analysis: v=2.4 cv=I9fw19gg c=1 sm=1 tr=0 ts=6ae8d508 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=OS8BP3P7qmf99cVHhKEA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020073
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom

On 10/22/2026 10:25 PM, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:39:13PM +0530, Aswin Murugan wrote:
>
>> Introduce a defconfig for Shikra IQS board.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>>   configs/qcom_shikra_iqs_defconfig | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 configs/qcom_shikra_iqs_defconfig
> Aside from "should be with the board" comment:
>
>> +# Address where U-Boot will be loaded
>> +CONFIG_TEXT_BASE=0x9f400000
> Is POSITION_INDEPENDENT not needed here, or not working or what?
>
>> +# Shikra has eMMC only, not UFS/SCSI - override qcom_defconfig settings
>> +CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="mmc"
>> +CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=0
>> +
>> +# CONFIG_SCSI is not set
>> +
>> +# Environment stored in eMMC logfs partition
>> +CONFIG_ENV_IS_IN_MMC=y
>> +CONFIG_ENV_MMC_USE_SW_PARTITION=y
>> +CONFIG_ENV_MMC_SW_PARTITION="logfs"
>> +CONFIG_ENV_OFFSET=0x0
>> +CONFIG_ENV_SIZE=0x4000
> These kind of changes being made repeatedly tells me that qcom_defconfig
> needs to be split up in to a fragment of the really common qcom things
> and then a defconfig which works on a wide variety of qcom platforms. A
> general enhancement would be to make it easier / possible at run-time to
> determine that you need to use mmc device 0 and not UFS, and so forth.
>
> There's also quite likely a number of things which should move to the
> Kconfig files themselves as select / imply, rather than be in a
> defconfig itself.

I Agree on the runtime memory backend detection functionality, which is 
a good general enhancement, but it goes beyond a defconfig change and 
affects boards beyond Shikra. To keep the Shikra enablement focused, 
I'll address that improvement, along with any related defconfig 
cleanups, in a follow-up patch series after the initial Shikra support 
has been landed.

Thanks,
Aswin

