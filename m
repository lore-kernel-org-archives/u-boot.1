Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6B606A31E
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z6+xhy8d;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YS2RC+RR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VdxpduG1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E540640769;
	Thu, 22 Oct 2026 10:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DyTYypJtyYSw; Thu, 22 Oct 2026 10:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18CA240786
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792663213;
	b=dgyQcchkE66WMri7MvTqGiWV42L/m9HAV6frPcoouq/Sf+I2BrnkoVQIxtgveDVaPR+r
	 8+md7V+6vgHlGUeoEhvjbajneSEyNGb8l6sknE+G0h9m47BdDDZEGHZ4FKkbMHq5CxEgL
	 vWurhknlYdD4oaL44OFtNn5QjyAhP8RN7gQT2zXCGlV/3cA7TeZt91e7qyhKtVOY/j0dN
	 SNPmZs4nvFD9HK/AMZRutdQ50jaoS7ONENBdh62dWz+tRPZliJLfzfQjSaNG6p3SbhOyz
	 VRx5dk/D7y2Sf24Gl90C9INMbHX/49+xYCwWhKUywoou+rOIapGAswDagtrwB7t4Mbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792663213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KOgOV1zcgH6Y99MZfb8sFkdniCjTtRzOpyBAqMCy3sA=;
	b=ONll6r5G0k6HCcUZGnqtgHThJW79fbnpLyamEJgO4ltnaM8+pRTcxf4/STEar6FpGFWX
	 WfZpzGs0mxmiojjesLkmA4G2kU6FbvwnlRPWbMlW55NMD3QpUNN5DhUhNjNZaCK1gUDf9
	 3Lq3q6MQ6SLyg0/ew36nuj7aUeDIJZMtJNBAo2stytTqtCnF0NT8rbPuueZyiPwbztpPC
	 J1cNDKjheUfvHY63WfcRQjvHzRcuI5STdqip5TqnU/S4UF4c6D3Z44Jwh7wBdTbYO0EUc
	 c8Tv4oDMZK5m8Oh2BEdmFEnMTxqP2qn2IZU9lzb8J0Dr1pMhtTlU/yxlgljQDd4kDkA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792663213;
	bh=KOgOV1zcgH6Y99MZfb8sFkdniCjTtRzOpyBAqMCy3sA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z6+xhy8dSvzApSpGf5I+lkFk0WzC+rbRpybMujFM0b8faOVF10H+yfwpl9V4WBt/L
	 DMXvom8la56dFlOPw6NhvcC7IqgA1vVwKAPNWHYUX5bthxmA9/3JmiN5WIHumMY9PO
	 suFRtAgdTBUEVmOWwB3I91AXc4LrCwWplJIIMaGo9p41t/O3me6050c1KKf1xEUA0F
	 +q53rHs2WG0GO09kDJc7zsFx0iuV6o7K0f0lr5Ri0OawmLlt6lw26Y3+IpHk35GqFU
	 fkr9/tEnQiDAjp79VMPW/A8Rtb3gddl8Z1DNiXDAIHrrhAPGEB6vxa0ex8/xmo/5C+
	 GU3+VZ+BtarQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18CA240786;
	Thu, 22 Oct 2026 10:00:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 02B6D356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCB3A60884
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:00:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0_0Ld1NuJQg for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 794A96070D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792663211;
 b=ZaXkLmNPnwT0EJo2ICTkXDmuRb2uyaR/5JrrMK1P694r3ZUQ3LnlbYgKbB4gwdhCw4y2
 IScdamxP92hNf8bPwyy2GlK87B1RIyeViWMLqZLlMxJUXyeoMpOfHCpBf6jq+d1NvtBEY
 /oBrR5sh770Rfm2eTFUSh8Lc4O6Ad95Spja5fqT6kKAjXi7NGmvJZXznsZVKuurD815Gr
 N6ay39V4gvMpkdZd7wOzOzgYogmiCJ4a3ErFYz0zjRfFcxoyW5umfY2MZl7J6e6ptA5Ft
 TMC7BXDU8Ww03o6oNBtbL7lKIcr/yLMHsyM65tQ6cVgpI/tiZ/sy8Jg+bRK6qBuwlfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792663211;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=KOgOV1zcgH6Y99MZfb8sFkdniCjTtRzOpyBAqMCy3sA=;
 b=SPEwBoOGtW05z+7Cch46st9buCttvqlZXVwUtInTIcTc3XCSoJwah4dxgMtjiB5Ac93d
 PWerCSGEZQ1OyBjjEMKAHJw4bzg1IZU+eVgzyV7QDQ60kZaLOZgzgkYpdGiICevrpgnl+
 9sRWMafCmj4p8JE0Qk7BX5uOt1TjqeioUOjIMuaazHisVJk9yAAbuWOPf1MZAoYUBHGLx
 KMnD7/Qlhj2z80WnCRn8yxf03XlFK/ZJeLkTqtsTR4rXNpRvoR+rbYRXAAJ0zBy4CCGT3
 kkqLwYNWszd1kEonv8rSkp99gEILDREjNadIMt4euWpmM72rq4NpsOXvdN6KR+nJDJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=YS2RC+RR; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VdxpduG1; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YS2RC+RR; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VdxpduG1
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 794A96070D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:00:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MA06aL3427069
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KOgOV1zcgH6Y99MZfb8sFkdniCjTtRzOpyBAqMCy3sA=; b=YS2RC+RRg6Uhg2LV
 +PDODoIAaQj61f8eyRiG+wd0AiUZLY6P3mMq8XzrTmWFMFG94t0I/lYfU/16iXoo
 6PiPuhPdQyzR7pARAsXeHE+wFI7P9mE6cSmCvXohe+hMwSWeTqfcYQimwAo+bUJN
 K1faxV+pxKhGL7VGyQGDPqqKJ98O+Rd3xedxz5mlbXe8K5dpCR2wDjYBGoMaz7/Q
 SlhYJjmh1lw84l27wbSvP9dlrKge39MsuZIlW3Pn9wUVOgeYn8mZgKy95nlwNNSZ
 wqAkuTj1RVktCje+h7dkvKIXcHJsepG/F03gHae6ZxVK/Norp5+0xkk85aRoY0ZU
 S6kN+A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq0eqd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:00:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-151dcfb1569so362673c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792663199; x=1793267999;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KOgOV1zcgH6Y99MZfb8sFkdniCjTtRzOpyBAqMCy3sA=;
 b=VdxpduG1CW59wAUo1Y5NC+5iddJcXomQDADIYu2g2/9DYQYT5tXqKS1Dmtm7KzMm0A
 RoSjAtu3v0uYFv7r0Up5aBg8JAh8byVQf0O7P3Bk79nSA4DbZQ42ZkysFRqCWwRWWzUR
 LXcbbJQbQgm45CMhQ92tI9hWTfWBxzIFmtnGlpgdOTITE/0crh/7LDlOERV/AaB/TavS
 sqy5xEdrZSS8J4GuTOItOghfXSNDw++pY2xu+bqlOBQeUp+zyHhWHpH8R8ys2mkNjaCd
 xAdNMOwN90IIQAHS12xNGCsRxtoSJ2p/yX7GtykZHk+Snk5c6b/8xJvIluzJjAYn3EW8
 s8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792663199; x=1793267999;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KOgOV1zcgH6Y99MZfb8sFkdniCjTtRzOpyBAqMCy3sA=;
 b=Nbdd7q/AF4llBbbHVsuw31G7aO6n6rG5rPZSUMbLdQl3UWF25I/VJjxF6W6v1TTmrv
 eAuL9Rq0GflsD7ZihOQNpo9epL9aMflpUndEukKjCCkPbBeorc9ddQpg4KOm0OGP/qAb
 H44F5AfTM8vOXCjPVBPHE6HvsstCoBrIIaELzcxKbYGz4X8yML7AUUwyW2/tuI7ENJfJ
 mIIQmMqXCe2yAcuXHpF3JPuAimpPAqxC6AO9XMp2lLlIpIFW+DqYo9+4oCDhrjgK0EFN
 TlNwvXkyYgU/N/4KV0ERy0rFftCLHCnGWTHVMc2C2vqVb/WJ/vqwKY7Q6MnamkffVSVj
 Q7Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxM8WLxFaBZpUQ/s6iCE5W6Nbqda0L8UiO/BCer3+V8Ke1rZkPUD6hOEMXUIOqa4skDebFYQjs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYILmvK0+t7PnLh0r3+tGdK96r2sYUqCzzD1VeugKDByw6On7IkU
 TiPhqaHk9ZuoFRAMM0ZPvkmo45qyt3HSefjTQJKHs/zAWU/cRCXmGWKr7RoQYJUkcQv8CJaaZI5
 M9IJKzmqIWhkOcaAOwEoXIqepsb1av09DStuNyT1jk37YqcMlXMAzbvpdAL/dEzFTKNAT4Bc=
X-Gm-Gg: AYBFou1+fviJmeKOmo9J+9gdjFhvavnxfFFXvbHN/ExA04KyHgNdS+fxgnexZu6UaVl
 NPh/JnZFVmLHdjmxLFS8rGKUHTZM2u3zDJ5m5zYfwKeqecMlWwPrY+7uQgSK3TkXEPzVztbiS71
 MeER59ILw+ItVXYkIHW9DdHiOK8P0cKsS2YEDWP3uHJbuGRxTcx1Z4ZSf2e+2Fx7OBCqDkantaV
 T4p/KvfncjG8krwpfyTI5i4iwisimCUgwfHsxFecOJhxtG97JTZFabea0EDsJQvpkhbd2mwfj8F
 ml5ZARrkTBhsPrC0X6F5daM2SdjJJLvw7xKOyXc3QMMVy5g5/gphFBy7FgiHTymiFjGgL1v+XFq
 KePFqZTAklwdZ87oBGkN0N4FhBJRg0wQ=
X-Received: by 2002:a05:7023:905:b0:184:60dc:c381 with SMTP id
 a92af1059eb24-192f113b4c6mr2888729c88.23.1792663198951; 
 Thu, 22 Oct 2026 02:59:58 -0700 (PDT)
X-Received: by 2002:a05:7023:905:b0:184:60dc:c381 with SMTP id
 a92af1059eb24-192f113b4c6mr2888692c88.23.1792663198400; 
 Thu, 22 Oct 2026 02:59:58 -0700 (PDT)
Received: from [10.151.40.133] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903e4f2eacsm12497310c88.23.2026.10.22.02.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 02:59:57 -0700 (PDT)
Message-ID: <0969e99e-ac27-4a84-a6ab-907aa17023eb@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:29:52 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1] mach-snapdragon: raise block cache limit to
 cache full GPT table
To: Sumit Garg <sumit.garg@kernel.org>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, Michael.Srba@seznam.cz,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20261013094310.2408439-1-aswin.murugan@oss.qualcomm.com>
 <atIavP8ucOMC-LN7@sumit-xelite>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <atIavP8ucOMC-LN7@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oOQ1AVnGQFIp5_EQCa-qV5ypkwQw8qCf
X-Proofpoint-ORIG-GUID: oOQ1AVnGQFIp5_EQCa-qV5ypkwQw8qCf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX/yYJON5Sp71l
 ka0c5Uwk/GGGyTWFZwdh+T8dlU6f+oWLb1xgn259pVsj1lqmlej7eSIE4WzCRycTWnsSBTYjMxc
 E78U8eLYxGWNHKeqswK50nTI9Zytyfo=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ad9dea5 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=1VxDqnHFAAAA:8 a=EUspDBNiAAAA:8 a=q1uuNYVdm6WhdRfwAy8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX8E0H57LrGIQF
 wPFoATyVrUu3NYXTF+tAhZ0zlGVq10NUsl3ryRl1/BTnVTAaLU//japcfiDuj7sD0EwqsSWp+jH
 rOSlLiq0+DceahvijcolSKM4AmmlDG4qcLkvm6dmZbUWXXLic3ndY+j6bgB9p38qLPId1AI4NGE
 L5GdSuYWCZvyP/TiMhcWBtWKrDj1RUMUUPxF7gpWGv82jReLX9yB8nFdAycDC5EvxQhP3klOsPq
 64cMKYY8Yt6vUJYqPtTn9GsPzbZVJGjwGRP3LN7fIzXaF9nW2QucZuImaTeXPnRjj9qXBT9WLSj
 l3tL4ZcJsbwnN+wu4I/0+VmMQAxnFr4hngtbtrL6RT+rxwzyhj3RzClEAW8Hb09LaeU26AlibEL
 DYnYSylVe/8mLzLemNYs+h/U1ifzoBtc3KwpOudM+rl1SjwOCJxK3MRBtpLbck3PrOxHw9L4T/F
 ygYUduxrLDNCCkNy9rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220039
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

Hi Sumit,

On 10/16/2026 6:08 PM, Sumit Garg wrote:
> On Tue, 13 Oct 2026 at 15:13:10 +0530, Aswin Murugan wrote:
>> From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
>>
>> part_get_info() calls find_valid_gpt() -> alloc_read_gpt_entries(),
>> which re-reads the entire GPT partition entry array from disk on
>> every call once per partition while looking up each partition
>> during boot.
>>
>> This happens because blkcache_fill() skips caching reads larger than
>> max_blocks_per_entry (default: 8 blocks/4KiB), and the GPT entry
>> array is bigger than that, so it never gets cached and every call
>> triggers a fresh eMMC read.
>>
>> Raise the per-entry block-cache limit to cover the full GPT table
>> (computed from CONFIG_EFI_PARTITION_ENTRIES_NUMBERS) so it is cached
>> after the first read, turning subsequent GPT entry reads into cache
>> hits and avoiding redundant eMMC accesses.
>>
>> Improves boot time by ~800ms on eMMC based devices.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>> arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/board.c 
>> b/arch/arm/mach-snapdragon/board.c
>> index 87adb100edd..b87e5ce0e89 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -11,16 +11,19 @@
>> #define pr_fmt(fmt) "QCOM: " fmt
>>
>> #include <asm/psci.h>
>> +#include <blk.h>
>> #include <dm/ofnode.h>
>> #include <env.h>
>> #include <fdt_support.h>
>> #include <init.h>
>> #include <linux/arm-smccc.h>
>> #include <linux/errno.h>
>> +#include <linux/kernel.h>
>> #include <linux/psci.h>
>> #include <linux/sizes.h>
>> #include <lmb.h>
>> #include <malloc.h>
>> +#include <part.h>
>> #include <soc/qcom/smem.h>
>> #include <sort.h>
>> #include <time.h>
>> @@ -30,6 +33,12 @@
>> enum qcom_boot_source qcom_boot_source __section(".data") = 0;
>> enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
>>
>> +/* Number of 512-byte blocks needed to hold the full GPT entry array 
>> (entries * entry size) */
>> +#define GPT_PTE_SECTOR_SIZE    512
>> +#define GPT_PTE_BLOCKS \
>> +    DIV_ROUND_UP(CONFIG_EFI_PARTITION_ENTRIES_NUMBERS * 
>> GPT_ENTRY_SIZE, \
>> +             GPT_PTE_SECTOR_SIZE)
>> +
>> #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
>
> This PSCI change is irrelavent to this commit, if needed propose a
> separate commit.
>
> -Sumit
>
There is no PSCI change as part of this commit

Thanks,
Aswin

>> static void show_psci_version(void)
>> {
>> @@ -153,6 +162,15 @@ int board_init(void)
>> {
>> #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
>>     show_psci_version();
>> +#endif
>> +    /*
>> +     * Default cache only covers 8 blocks, too small for the GPT
>> +     * partition-entry array, so it's never cached and gets re-read
>> +     * and CRC-checked on every part_get_info() call. Raise the limit
>> +     * to cache it after the first read.
>> +     */
>> +#if CONFIG_IS_ENABLED(BLOCK_CACHE)
>> +    blkcache_configure(GPT_PTE_BLOCKS, 32);
>> #endif
>>     qcom_board_init();
>>     return 0;
>> -- 
>> 2.34.1
>>
