Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50761606A339
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RwHknbN4;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hxlr3Aju;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d0nIwe1b
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC1CA60778;
	Tue,  3 Nov 2026 13:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LbpUUNM3zAie; Tue,  3 Nov 2026 13:04:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 061B7606E6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711084;
	b=JDPe7gJgwJt8jNX/LElnrsPaKS/ib7dHFNHGUMB6frNzFnfU5l/wzYfvLxA0A56j0t6e
	 eenFZpXjY8q/LQCcVfu+pySExTvPVCaqKPh360R60ZFbR+BtYqrrXnykXirh1BxhOWJfu
	 ARIZgKzQDV4fEsRdGGnbOVbtUVLqnzJqhe3CAxodyk1j40WJv1zgeA+rzNygjVvmwwP/q
	 S4dTqh6Q/nuWbnKYU0CWwpveUGI5VpB2+iBeQ0OlJ8TKYJgtokKrKT74ZEOJHDKf07mQS
	 7BCqNXPaF3zQotdCODb5bgb3rk44WQJqjkYVnH6kgqLdRKVS0YkGBtnsofamXW0U2bQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/X5QsqEPN1GA/PbUJ/69ikYRj7alVTlM/d/GgmRxhos=;
	b=NsWDJKH3e7FxGfsS2aD7SgbK7QHhBq8kYj7hxRfJHxxOXn3D5zxIxVJZzbDyZ7U/VkrH
	 YbOowKyuZ1RMRyLmqePdaDmTL23Dt+4eRIK/X0bGNkSUusQ5q6iCTcBBVTzZ8X18zQzeS
	 cMAEOoRIpojefLNliyY9DxFW1k8fU3wsgFI2t1cPcOjrgprKoo5WiNHFGIqy1q7pYLK6B
	 WgfmdU05Azwt6mTVLtkF/9442Dvzk5e7jbePJsV40dlJXezwhE9i3RZOwDNJdjwIvIXxY
	 mZfsz/oBPrJja10aQ99tIGbTCW0QNOkGWdoZXbSSYgb20YMZWm7tNroUOHfpMyQHo2Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711084;
	bh=/X5QsqEPN1GA/PbUJ/69ikYRj7alVTlM/d/GgmRxhos=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RwHknbN40R5+SljKY5eTlO7p8aAGyVivvUYYtwLnFOHGkyrIFxY0Aq573B2aEBFRa
	 LPj9Z4MO5cSWSlGv5WQih8vrWhkpgNldD9T67UStKmO29ORHIclz+SKuHKQOUk54fu
	 e8YSkx4XzXWvctkEirOX2cAtaDzW3ioEXzuu5KoGaYw85SqSAtFpAKagSrK0MwvMkb
	 DQqHflOhbkZjJgTbdnFI2lJiQCvnkQGUKYcWh+FZcwzx5V2tANsZUN9P6XiGWkHDR0
	 VD4FMFKBYj+La9tphNBa0Nq0/lK6oZpCFKTh6EjNXgwDCFFJqCQtfwF/O0oFTNsFnw
	 0RK2VlOHu5Ekw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 061B7606E6;
	Tue,  3 Nov 2026 13:04:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FF124BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C8D9400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:43:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKCiAe1Csb25 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C89DC4009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793691809;
 b=p8sM8MP96/ZQFSYTberc+5g20VligsgugsrooN4lppbDQgNW9MBSpKAMh1FEtchzbrNS
 nkiFYdNSeD2jpdr3jM3n6uGIPSmBXOxF8cD3+seyBoed1UcmLDmtKd8i2+IqvYAuRcCeQ
 /FE7dBBmQNVspkWMYsUKD8XG97eF1lJSi8KW9YL7HtsNGiK4lHj4/8PedekcaCPgeTclo
 P/a88jgDIIzNXwnD4T7Fw+4ypObyfD5BVNjbIDkf32ruVDX9AQLAlcdkcUeMA31xG3DuN
 hXDyitPwLjNqYAClhTN/h+Y8vyXb3GZVcn0ogI8MA/lQ5bCYJAZPTHPp4v3xty6/XVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793691809;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=/X5QsqEPN1GA/PbUJ/69ikYRj7alVTlM/d/GgmRxhos=;
 b=gMiPv7zips5HkpWwXwH43Hc3B1dtIiQchKvd3rxYBIMohNjA6WhzUSAuIsdjQF38u4/D
 XJrGsEmHlP15dSHMBTtjb5M2TKeqc2qqPP4Fn9djKwdchZ4XT7DH5gcTimPOcCL6PZfO7
 Xt+4lUgTnyZJktM2TRZKcxt9w6/iDeN+h/4zrC3V/6btAGxTpgf46eG/YvmRl68s0qE07
 WuyL/0AwjYuOTnAYpwmZzclJ6n94MTvAjOixW3XmK89QI6SoIDtVLhj+s7pW3rQMJ3Njt
 u0sZ1R3bBOmXsp73ld5RBJ13c1VBm+5wusvNSPNj1cbb2ri0W389+2688zx/U508CKA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hxlr3Aju; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d0nIwe1b; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hxlr3Aju; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d0nIwe1b
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C89DC4009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:43:27 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A32oY2M2608916
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 07:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/X5QsqEPN1GA/PbUJ/69ikYRj7alVTlM/d/
 GgmRxhos=; b=hxlr3AjuMPeRoqcE9lSD/SfWlGvfxEhIdu+g2MxWJDJ6Rc3pBXF
 Xgz95XiTiQu3fUuHu1rkmLQL6FmzVZ9kMGJ5sbYZu4I+E7lh/JPr67vHGbix+Imk
 4HbdPD9FRhymKNm4azBW0WdyVUNIh2CjNkfxnb6mEDEtK6Ty5Gkarin3Y+GBxGaF
 0tBSkH4DHnbncmzur0zWIxFgqofLd90ECO3ImiyBq6FUq100zP0Bb66yN7XTAwTI
 yX2cA1ilvjyuNBVz9QA4F/KGsHwKz4rMYgv2YNu3s7Bmf5JGPWkgBoJni3lwQ6rW
 NBPmjko0LAcLVfZp/2r5K7wcBSCCNs0i7JQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq76d907a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:43:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so7562737eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 23:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793691807; x=1794296607;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/X5QsqEPN1GA/PbUJ/69ikYRj7alVTlM/d/GgmRxhos=;
 b=d0nIwe1bg+xso26TIrsRxx14tHrU0/8KWZo+Tlr03YR+m1CJ9wqH+vfSo6tgxmDsvt
 5pKnv6JgdLOgisURMG1f9hOljtIAC0+lVBRgrERMIQOpZKn10bUAfRxZ7JPjrIGAzlbm
 4K7x8OveKzpsKPsYV4BYlqVnBdpuUyY3DTCSBs5AUVTR8dkIOyw4c7UKzQ7gi5Uy3wjc
 qbFXLouMP2F7/Y44E1wxtLn0FoklUvqVS13ucE1EBDJb9t0rvJegFDrtCwysXzOgZk21
 sGJaJOF3O6NpP4oktVLAPNJlMHkNzE+x14ir7bHX8m4t84YyGCqflSmDZ+jpad9Ob9I7
 0sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793691807; x=1794296607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/X5QsqEPN1GA/PbUJ/69ikYRj7alVTlM/d/GgmRxhos=;
 b=vbdZxjIz8LgjEm7kephnmcCN23r65bvIlc+AzDQMP32FoorUtgr3cQSCm9Bn9diJfj
 ONkHMM2qT8MxXdZb60afHgpZQoW/NOzDjxxqtUoOEjSY9xMGDv3CvBPfVxfQYp9+M+Us
 V/K+tWZJrR3VPpw6Dz1Cvq5zQT+sSlOXmEqtgfBjLl8dmml2hD/jftqzif5pwrH1/OFO
 ohZDkmBTVQB3tyzw9IqLBZcYfK8SEMdpybQfLcEkrtnIUQP7UUIE++R9oVxdc4yMEkoK
 P4ivk0x4DC7BwZ1mMy7tX1y2WxnN8R3ijqac8iPBKH+5a8TOlkoOhKzfhj5Iq6lNCRIn
 DgCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXgRtCA4oOVsxmdWY6WWkvqKEto3noAB1AOgdYdFtFJTE8YUqiXmahfbwF64YX4SPyO/rIz9Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9BbwVOQf1iLCZ7jO8Xa82TMh5XrDOLGJ8rP9nJw3V7dAnum2hu
 eB739/cwQ85JpgaeLiKG5qMxwNPUl/UWTix8C4RogTVMNFVbuH3Z3cD9KmEKBdvnJXn3CgQbWI5
 Um9q1a7XgA34UlIeCpdXNySPrL1uMhT836yqhDSx3WJ8o0l/FiUbpiuinsyEWpBLmYc3QKZo=
X-Gm-Gg: AYBFou1KbQGwcNYyJOeQH7+gjNuQfqMAY0pXl2/V6wLZ0la/j3MlSTc8LBxRuX+pPRk
 +v/PnvXDoJleWa9m42TAE8EmZ+oXw+aDl3masGArRS0ClUXURjletP0d39XrkgGwgd5IyDLEdoo
 WIonVuKS2UEzKfP2kHurzk+Yov2xJo3vCEN+RLZi6MYswgPnd8OiG1GWrCqJqQedMeAYslaLi6h
 oq+N9+gONKQvGdhHDPHyS2B8P3tgtHpKtlJ48NetwtIxuPxNhSRQ30TYgnigFDnVkiSoTte9mbj
 lGNlAi4kxuqUH03ixR+kjGxuG4yt6NGx2Qt7Ia4FksKgdWRymxMhybkopctO6MJpvV1BGNqveVO
 o2dPjB//HBUBtaNYfGqS2zJ7EnoHuNvEov9US/i80YEOGZQwwxtAu8wRFoadN02b77/0TQTpFBQ
 Sq1exqNTlH1dZ0nSK0/lHPOHS3zFl4klsTO6+2/Ojnq8EXeM/1ZIysOLGQ5Hic95GkXQ==
X-Received: by 2002:a05:701b:4244:10b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-1ac5b211405mr19244751c88.15.1793691806349; 
 Mon, 02 Nov 2026 23:43:26 -0800 (PST)
X-Received: by 2002:a05:701b:4244:10b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-1ac5b211405mr19244703c88.15.1793691805596; 
 Mon, 02 Nov 2026 23:43:25 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1854d925sm72328207c88.7.2026.11.02.23.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:43:25 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, u-boot@lists.u-boot-project.org,
 kr.sowmiya@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io
Subject: [PATCH v3 0/1] Enable DDR training in Shikra SPL
Date: Tue,  3 Nov 2026 13:13:14 +0530
Message-ID: <20261103074315.2868454-1-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KJTPn1Fo c=1 sm=1 tr=0 ts=6ae9909f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=R0JtNs4P8E7CgTWNuXIA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzMCBTYWx0ZWRfX7ARXAvTAmxo/
 LWfu2pW1JhANSldnAYMXWlXCTQV+WknJI/kSBd8DszLmLiMs6orjWgR0EZ/ia4bZR9KTVdLuiGd
 P0wHXrAqCLQfW1Yxy6v4wN6nLqRzRIY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzMCBTYWx0ZWRfX1gsPs4dP/Gth
 kA/QtbQex4GdVhVV443Hso+0HahnU+MucLCstNOk4NdnchYhLnMjdJG8hQyl1I99+jBme6HBhR6
 4VBZuHdv81GIjgsKSeMh3B/iOn5C1WaVdU1YLYWe0m6PpymJmMz0jX3kL52sBJB3jklaqY6KODU
 /evUIFUJnz/5xDn2mF87poD0Sr1gqYS1yjoJYXdwz9XWSOxEdZq73JDNtVFj106nwB+2GaRdteM
 nh7QB24EvPxAmQbOmgtzLEoukC6dCticPIhrriReCxB3gieec+2JFjo2y+93ttKKHxqlexP21dW
 2arDFNTxiYg60wZtru44o9wusnbDqA7ezzl/4NIZ+uSKAM9zOV9K8armUKV6koN3ujNjSJdwPYZ
 qMn+dU31dsmqg9TBMAQ52qFE+4H1D0unNJwYqzGfgcv2C+TFYl6HrIvP8F5PqPPmschvXk0ZX2G
 sZeJbLucfqXYykRCUuA==
X-Proofpoint-GUID: JM4_XQYGgein6sT73L5TMQoG0gHqKrFf
X-Proofpoint-ORIG-GUID: JM4_XQYGgein6sT73L5TMQoG0gHqKrFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030030
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dded support for DDR training for Shikra.

Following are added:
Reading DDR training data from eMMC during Shikra boot flow and sending it to 
QcLIB via interface table.
Saving DDR training data in eMMC when QcLIB performs DDR training and sends
the data via interface table.

Depends on:
https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/


Changes in v3
- Addressed review comment on Kconfig

KR Sowmiya (1):
  DDR training: enabled DDR training for Shikra SPL

 arch/arm/mach-snapdragon/Kconfig              |  67 +++++++++
 arch/arm/mach-snapdragon/board_spl.c          | 128 ++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/qclib.h |   3 +
 arch/arm/mach-snapdragon/include/mach/spl.h   |   2 +
 board/qualcomm/shikra/spl-shikra.c            |  35 ++++-
 5 files changed, 228 insertions(+), 7 deletions(-)

-- 
2.43.0

