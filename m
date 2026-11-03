Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE979606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S0dSMmkz;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IQape0lo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WgHmOb+w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9498C606A0;
	Tue,  3 Nov 2026 12:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-y3IkC3_oZO; Tue,  3 Nov 2026 12:15:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9E6C460778
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793708116;
	b=LNxxhiHVWry79lkN6gNjtHQXlHkMpTchAaM6YX5rG9b2WY51wS3R7deT0J69PaM7d4qA
	 D0OG2wBVTZbNLr+7rJu7+EcbAWMWS1qJGjhhIpu8ryJtFcyKWys4gipvmHt3cefCA7Pge
	 SDwDrrepzKWfweRUHa1+nfOspqWZlJld5MFgbqJPKE6ecODwl0l8fr15pQjg+Wv59l/d4
	 xkH61gDYmjBNa0TVXjIRAo4vfHfdWjpukD6sEfsIujjo9tx4NEVrYmnX34ZmSiiPSqqTx
	 uMquP+Gw2RzjQV6N2PXEA9yUJIFt9NUA/xgXHxLc2xjQD5onTh9KV4/slYct6tqJ7nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793708116;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6utDIsC8iJjGDMRNaf8wP5nYNONmgTEMUuhmvrVJ7L4=;
	b=Ekqaqoeapn5mwqVx37QQuy1hlS8A9QU2uTJHMmICO5lGqbClpyI7pnvnAsUh6BJ4YKun
	 mHGhkDKi18+zzrI8+rI7QH2e1AO1adDDx0ZRcyh4qNYwtDv23eeM8IQZfy5WLXyE2B6gp
	 /AnEgpOAfOO1PFfTjhpmBdJ0KUyDUDb9SzLOF6pFIUONaWea9sJU2q1J+E0D8XIce/mcS
	 0kqtHuDfHt8RRtgtJguY/O+A8ySgDEEpCpzHad2oyVCWe93dQxFlY5gEkSEhC4NOKPXY+
	 0l1CDPEQKmZZv66EZQxP+B1c1nHOjWtLNg/ZxLIRAqdzB0ETIC/IrN4U1t3DMw2jx+Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793708116;
	bh=6utDIsC8iJjGDMRNaf8wP5nYNONmgTEMUuhmvrVJ7L4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S0dSMmkzG4ZAONwH59I6chQIM6+6zQMHr9BN6HPgEF5M/dN/Zx0VTmv/s9EbpHI8P
	 whLZQRUHsz8Mfot0dgVWIaXWujNX8NOGTCGzTJGXd1QPODb3ChBexY4sTC5tCwY1pa
	 JANAN7stP1SKwzcsRo5OuYkjlu4+GfNvJLC4lJYGuXG7kWVvAyDmX4GicJam8vjjLe
	 I3+5AgMpgGFF9NO47e4i7opLisg6HTV+UifGqvIRfjkSFfjQQUDx5cwkT1F94xURWJ
	 0+CtQ08QY8EV9ByZNsBc0PeFK/vCdrKRRH8S0+IJRAda8c+5IQzi42L+XAV2BvP33g
	 eosxNo7KW4sHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E6C460778;
	Tue,  3 Nov 2026 12:15:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 44142A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E274380FB1
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tzwLkxGG-4Ov for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC4AA80E2D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793708096;
 b=V9tHBNwICv+KpNdQpGJtwXujpktkTzOJUeMNF1VZmVkjGmrXARyuXfpt6wIucYLINVr4
 CiX4T2Ob7ZP1yidhj/5CWkxp4n0QwfF/60HlbNYXqWEQNvyXVXrj+yoMVcorOSWSMsc5A
 d8Zct5CaKG0Rp/bevZZNjxjnodB7qxVCusHwq/MySH1n5trIEavcpRHqhl1Vk2rsNN7mN
 IwBkxR1IgPbqITkC5Mc8zeqGSSsoi9tjpxvC+ioGQY8TazsfRilKBXUfgWuqR0UDzw2Dw
 W/d3PJSfH1VHKXXNew0TYQyvjPVLpjA2/8DTxc3ktGdhvB2RjRTK4MWtQTBuY0cfpAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793708096;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6utDIsC8iJjGDMRNaf8wP5nYNONmgTEMUuhmvrVJ7L4=;
 b=CYlyHslosjcp39csx88URRYNkbrAooD+AtclgB8A9QuiEvK810dGOtvIkF3KFKEdVuh+
 yDNDs5EL2qCf9ErJDA8FizlWR5IrEBygZBQMHJ6v2fS106KHAQK3tJyDfWuJ/TSPA+ICj
 KrjhxrzB6kRIzBQQBdPjof89h2DW7SMU5Cx7Qy1LWgmESmvU5YmrkXP5p/APyk/Eimx2D
 m9BSsUSOc8mwJPdM5wIflw4NfLJvjLB6waiQOlSqjhStKMqsxfVuMBRWKRqYcX5Mt4bkt
 qSKNUbp2+r68eK9vRtjkKxtOQc3NY8cuRP5i6i/+AKkhY6VDlxwhwvqynsx8R/opXAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=IQape0lo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WgHmOb+w; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IQape0lo; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WgHmOb+w
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC4AA80E2D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:14:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAB5U3131576
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 12:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6utDIsC8iJjGDMRNaf8wP5nYNONmgTEMUuhmvrVJ7L4=; b=IQape0lof1husgvN
 XTXh3GmfgLmBXO0FL60iII4LrJ0kwsodT4HhBwTq4FK32NFPsxBM0uSG8uJ6nA3l
 M0FvpycVYKfv2v2evQXSOOq9hn5s+si9ivwS+7Q8MjdtSR0D695kFrARo8MkcMPV
 /4K3VR6Wxji291dNXUm5phDmO6BLBVzreMHmWlw07iQHzEDCY/XHyCtvlAR5pZqg
 r6NoSYHSFCqFIUoJCt/fwe8hdobwx9ztBKt8GFEi3PlYIG8P3ZlVVGI3k/2GNIfq
 dd4kqEopFRYzgXTBbARyEuHkardodbTLDXizod5MLTmJaekajn/qJF46LCdO4hGF
 78PD+A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq94csmwb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:14:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so9097138eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793708092; x=1794312892;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6utDIsC8iJjGDMRNaf8wP5nYNONmgTEMUuhmvrVJ7L4=;
 b=WgHmOb+wopVC9PbTxmQtdJqqAdYtdqmFZjVLU/5HUZ3aAjdrbZZMBZ1xm5mSHZj/Iw
 HdxdM9fPGKtGEucNqTgsVJjmXOR+elCl+0wzJAj7E1gNWGPWztAwNnLcY52YJ6Dcqsx3
 2gXQXJUjOFs42qbDiR1847ErVQKz3Q5322lvspMZ8mN9szew5elQI9S/IlnpJiQz4AGg
 iKBCpR7JyB9IcdvGEvnPUgNJeRonHJBv0fH0F5rTRyh7G3XdhH7NiyyHMYIbpWezVQ0G
 +4WV3kC4dhWQYhv4n3z30cbtJLztRQmiZrwHjiofuxum1lVUHeYnWm7/QcRZMq8l1csW
 IOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708092; x=1794312892;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6utDIsC8iJjGDMRNaf8wP5nYNONmgTEMUuhmvrVJ7L4=;
 b=seEdyHIDxFTHjNdfAG1dy2foJQXsFqLR8ADvQMhJ+gecOp9iSqFPt9t8mdF8c1v/Z+
 Zh7esNKDpl7eaYJv5LHxjt8NHLV8BUwaaK5Cz4Rd7MqFEa5UBKySkrRhcC4NsqkKqY7x
 zUD0KTVZ5/Bd1lNdibuetX02dE7zAR/ZhuZMiquWAQlJJkffUQMnrN5lPE04T1krdPTB
 TxFY9CowLczTbe7okU12oywq+ng6ZOQo1XBm98M+6CBLVInDcTaEwgMvJwXgBr8dpQuF
 lXcNBmFuqeJdKycN6L2CK0lb+u0HmuKk0aEzMXILp2OF7DwBUCTsiTM3Oyd/WiRmt2Z8
 68wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1FOmmBhp6dyRSL5teZDbLYIWy386QYS/ZtsiEkg70DJlyrbPc+XJl6qhsu7n+J3JWznDoIdY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+1QMoLSztwNM8j+ayBCklDFUu0tlxVeffPcRSPzaoFW6X7x4Y6
 3zm5gAa65vAeVd/O6D+tLejQtZoIPVBpr77iiSuE5mI7NwgMonzFuEd/gssGiIoQa5iguMKJ7aa
 S4RiXMQ/zytAG853t/PceigYjrVeAZyVG6WivlCKV8V2aJdakYLdiND3sRYF+QwBAd2tO4OE=
X-Gm-Gg: AYBFou34fjYg0xydP9uaUAh2kQbTv8Nsib3xrAIWn5KFKKWqY81Hp8AS8GH7O+HxnnK
 lm5u0M7WarovtdY/lHlkDd20hP9ukuXXBomVNUOqLdIwuhcom/rMvXaMIqKipLWx5CU9mmqgVjP
 +PbxpjCKLA9RFLKmPp40JWDw1v7WJ2Nf2dDnGY18VUETpGcImmbDVPViO3Kn0HuzAPTLB0inC3h
 rOfp3DIlBZqwBYOfzlRqYVWXqMXCIaT8CbWyfswjMRRqBFpqUjhz1NxiEIAqSJ03VEVSMkOL9BY
 AuT3tx+EVCC8TVX/XZSVF873oHcGYjcr79Wj0GnmtsIOlBwSO8GQanBQ3oUJCi8ec+XhicLv2E1
 BAI/TU099JkSVV5zQO398mk/oMLLGdVA/Al5uhShpT3igEijM1dr2omhxyNhew2jqU146EV1c19
 Vn
X-Received: by 2002:a05:701b:2091:20b0:148:bc4a:8356 with SMTP id
 a92af1059eb24-1ac5d5aae1fmr19128643c88.28.1793708092128; 
 Tue, 03 Nov 2026 04:14:52 -0800 (PST)
X-Received: by 2002:a05:701b:2091:20b0:148:bc4a:8356 with SMTP id
 a92af1059eb24-1ac5d5aae1fmr19128595c88.28.1793708091491; 
 Tue, 03 Nov 2026 04:14:51 -0800 (PST)
Received: from [10.152.198.236] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm49954817eec.20.2026.11.03.04.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 04:14:51 -0800 (PST)
Message-ID: <7a833572-90bf-42a6-889b-35acc6fcbd38@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 17:44:44 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cdt: enable CDT for Shikra SPL
To: Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261029062431.3117727-1-abhilash.v@oss.qualcomm.com>
 <20261029062431.3117727-2-abhilash.v@oss.qualcomm.com>
 <20261030143038.GA3288491@bill-the-cat>
Content-Language: en-US
From: Abhilash V <abhilash.v@oss.qualcomm.com>
In-Reply-To: <20261030143038.GA3288491@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O+KsLx9W c=1 sm=1 tr=0 ts=6ae9d03d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cMHdD-VpkRV9kXawz_wA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: gLwPh5ys49NTL2redGUWzibdt0kdVQJc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OCBTYWx0ZWRfXxlvN4rxDAyzK
 vcBtnwbHVF+AoKscw08mFFmd9MQkXMLP3Hc/2ZxQRBDa7B8q0emPzxxfAucLhzyqccfca6DfIoS
 2I4jLGeSu+62/hvdPJCffIHUsCRCmD54Qmm/5VMxJb9wKkRVgJ4QEHnKpFmPp5/3kHVcX8+bTLf
 NCtfS6e1/rWOQ1rzreDnKbpqe3+X0EoE5VGa2LyqA/xJR+x4ba8ED/TDjlZ1ycVikMGr6aspper
 9BMA58MZNYOmzmCoSQwwMmTz9elzVe6Xh5DzI+2tctiduwuB6UVMiTVMPxrjl6tuBkeU+nQB5FK
 mrNxkMZLu0QWxwFVRyeJlFb8PSo/ilzskLoKH3pM5GfNCJ3iEKAZAx23I0mpyYKuP7L1moDLUKw
 2SnKFMkBGuFvd7NJPbSkEyrG0HAhvtot0xBWP5bgiZKqmaBXFFs6/PcXlE+KNTySGbYnZEnk5Kp
 o59Yr5owjtLHb/8iK3w==
X-Proofpoint-GUID: gLwPh5ys49NTL2redGUWzibdt0kdVQJc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OCBTYWx0ZWRfX7637P6p7xgUa
 ZwXOXMTe1k4axm9ZcTwgq32yjiu4PaqBLYhglRjuifCwX33qCUekY/Km1wiBrzUle1z7rJHNQGg
 /j8+w6/PSK2klXNla+8JCW6fHTBHMpU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030048
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 10/30/2026 8:00 PM, Tom Rini wrote:
> On Wed, Oct 28, 2026 at 11:24:31PM -0700, Abhilash V wrote:
>
>> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>>
>> Add support for loading the Config/Chip Data Table (CDT) from eMMC
>> during the Shikra SPL boot flow and registering it with QCLIB via
>> the interface table.
>>
>> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
>> ---
>>   arch/arm/mach-snapdragon/Kconfig            | 73 ++++++++++++++++
>>   arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
>>   arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
>>   arch/arm/mach-snapdragon/qclib.c            |  8 ++
>>   board/qualcomm/shikra/spl-shikra.c          | 10 +++
>>   5 files changed, 188 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
>> index 9e23d6d8948..7f5a9eecb7e 100644
>> --- a/arch/arm/mach-snapdragon/Kconfig
>> +++ b/arch/arm/mach-snapdragon/Kconfig
>> @@ -76,6 +76,79 @@ config QCOM_HWDETECT
>>   	  Hardware parameter detection from SMEM and TCSR for
>>   	  DTB selection and other platform subsystems.
>>   
>> +config QCOM_SPL_CDT_SUPPORTED
>> +	bool "Enable CDT support in SPL"
>> +	depends on SPL
>> +	help
>> +	  Enable support for reading the CDT off the boot medium during
>> +	  SPL and staging it in IMEM, so that QCLIB can pick it up via
>> +	  the interface table.
>> +
>> +if QCOM_SPL_CDT_SUPPORTED
>> +
>> +choice
>> +	prompt "CDT partition lookup method"
>> +	default QCOM_SPL_CDT_USE_PARTITION_NAME
>> +	help
>> +	  Locate the CDT partition on the boot media either using partition
>> +	  name or partition type GUID.
>> +
>> +config QCOM_SPL_CDT_USE_PARTITION_NAME
>> +	bool "Look up the CDT partition by GPT partition name"
>> +	depends on SPL_PARTITIONS
>> +	help
>> +	  Locate the CDT partition on the boot medium by its GPT partition
>> +	  name (CONFIG_QCOM_SPL_CDT_PARTITION_NAME).
>> +
>> +config QCOM_SPL_CDT_USE_PARTITION_GUID
>> +	bool "Look up the CDT partition by GPT partition type GUID"
>> +	depends on SPL_PARTITION_TYPE_GUID
>> +	help
>> +	  Locate the CDT partition on the boot medium by its GPT partition
>> +	  type GUID (CONFIG_QCOM_SPL_CDT_PARTITION_GUID).
>> +
>> +endchoice
> I think I made this comment on another patch? Since both options in a
> choice depend on something else, QCOM_SPL_CDT_SUPPORTED needs to depend
> on one of those other dependencies too. Please make sure your other
> series don't have this issue as well, thanks.
>
>
> Addressed the above comments in v4 https://lore.kernel.org/u-boot/20261103120840.1575918-1-abhilash.v@oss.qualcomm.com/


Regards,
Abhilash

