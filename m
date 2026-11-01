Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89220606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CaUoeHf4;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPkCnsde;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GbvOWNkC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5081580CB2;
	Sun,  1 Nov 2026 10:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gUrtbxcATRHN; Sun,  1 Nov 2026 10:34:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7480580CE0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793529245;
	b=O0kPcq5umwPujZ6+9Ny0olw5O7HcA0NtRvorHKlOXSY+T7C9El/wz/qPyZWDT9hyfEQE
	 CSUuuMSi0Zz+I9hbWVmF8E+ea56QmiTpTxwneS5yE06FHbAdhbVMA5xLR2xWCsTWURZQr
	 Pr06sHmSSySxKDxQmM3ytJ2jJrCpnKWPcGPmOF+rnLiH7/soE2XxX+DByAyf0Ck+burgt
	 FTHXynwjNGnz+ZvRwIsO3SsMB1XiUuJ47xIW6jkUNGPd5LZi28GJLOX8KrXcgR+TfwGvN
	 FIFQnS5iJFavZ+As9Y/5kLT2OFIw+0hgypkGH+5vgXmH3/xyPIKyQYQhdRqb58b/V/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793529245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gSvRnLYT8fB52qPAUBCPULroyCSQDZsg1MfREi2af2M=;
	b=VCxeVx5aPI2zZqaamldoEVPWTYOkUwplOjxPhc/bSGdd1KJgZ2qYRJ3ZrzWuBvLAg6TI
	 j8b5zUR0yjEGtnrEASULHciKtsQvHMqUYhYZ/KQM1UxUpaJr4Ihl88h564zMWzaEtB3Pq
	 MzOlOuPwCWnVBXhCOHMkWA3dr0kXnH8H1rj/XjhBZAtOGGStoNAYwjyK6+katZGqYu8r6
	 b7JTAUbIHZyehH2Ksb7HXj+hPH5B3v+Cg+QdUG0tt0h9hv9bhQKUK19OWgOYpsGD+4Sz3
	 Fy6jooKlyXsatuYM2SNmZvd3TlFHqXrRDlgg0qrSeI0dcfG30HCBUwPQVwR6EzaVdWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPkCnsde;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GbvOWNkC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793529245;
	bh=gSvRnLYT8fB52qPAUBCPULroyCSQDZsg1MfREi2af2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CaUoeHf4+rpaQtuzyH1sOiYYvKF/DJzf8DNeQ9Yu5IkxG98kamQ9F/w4NAzimqY+/
	 aJc0xtUG8cag5FzMWYoPiocKHudSEXBNBWstH40pv8C0QDmhoK4fc2hASfp8lTi/W/
	 AggramPWuynREVkhI88nGC0IWpvGOnDJTrCuE5zwBTdkFMGAAqB6rWh0u1ilzq8XKT
	 jhvsEV/EXR0zDR46EgNYCm/3Oqz0+xjBOYhs3xDHU/TECXVse6vkR7/JKlkmyCH+KV
	 LppK/+jfK32T/pZEQRZTDGHEerhm9z8wkverW5rrieYDC8s42XgqbC5bSV7F7pQHEN
	 LftBJ2LZsU8ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7480580CE0;
	Sun,  1 Nov 2026 10:34:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD59A4B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:34:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A25BA80CE0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0crzHbY3vjd for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DBE7B80CB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793529244;
 b=VDG1D6ZGSn2izAIFPgbV/MhKiV0I1PpHunwQTD0YyBwzMYzem9zERg6eFY/5DDy8PokB
 YvyBUx4Ql+GT2LHe+ODb5kDoo+ZlNbllJzBgEuu2h6fFHrQI2cHaOGFK2nnnOgezmyXw2
 tXGcWIpcbdPDwBVogArhic8GrFQ13EHrqN83lRpj4M6DeS5aFsrIUYqeBWfxHDgvP/Q4E
 AsUo5wqOC8bbvBt5wOBCsdUpkANpiaJNh/8ti+ECAlnZhAM/c9A/OWaCAiGINA1PyzEzh
 yPFuQksnBj3TdWGd2+9W7mF2ojq63HxFJhr3sHoD1l89uxiIQMcVaXyflzZgO1I2q+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793529244;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=gSvRnLYT8fB52qPAUBCPULroyCSQDZsg1MfREi2af2M=;
 b=eR0+Lp38Ek3zmC1ZYynSc4dDaLBJp/O3rOhi8t2C3pCXeDZhCL3QZejs81pf6OeiEpd+
 AjH2TDsY0hVYB0x9TQP7uwq40dqVQrA0qMLewTRfpYDY4F5GxGwf4U61fXWad+WXAsW30
 HHC+mNZyxIIgsGcSSC8xDxmjodtb5y7+Ii8ncuUEw9d0if8ofXij6nmipxyqsJDyT+bxp
 DFFUml3a34EVUKNcW7LERswT0Ll3Nnn8OuGOZb166VcCynZw+x/GSqWQZ1yP4SNgsskqU
 JqNihp4jOSuwQTQUWtS9sgiO8+ynfy2Ey3861+MwtpcyYwKu7T3h7CXneUnnKIAT3Yw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=OPkCnsde; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GbvOWNkC; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPkCnsde; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=GbvOWNkC
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBE7B80CB2
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:34:03 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K2ew3570539
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gSvRnLYT8fB52qPAUBCPULroyCSQDZsg1MfREi2af2M=; b=OPkCnsdePOBgpffh
 yL2+/aLJH8R/oFGXC8hUL/+1ONGesBR5dtjtvRvnXCXChsIBTWtNFsdlwOgrPp6h
 dIHrxAWlCKvO2MxyDWGWiouMZFRFw0DmILk/Nez9+v2d7I4DiHp3a8j14Cc6Ht2D
 VFxnF8r6Vj7a8/cXSTZdWHYlTQ18y8mdjl2RXTl14sEkWwTUXurtLoLPBpqiP6LJ
 0jYg7usoq9zUBzvj+e6qJ6PhfxhPHNXx0A2Jw1t09Tf5bZMlaaUXasEG/XHmPVE8
 CP+i851n9nJyTuSIZoq/I0qShuNWHf4YTRaKWrXUPQmgoxPH9nOovaZCLg+948N2
 6J5Lpw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m9ay38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:34:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so5172258eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793529242; x=1794134042;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gSvRnLYT8fB52qPAUBCPULroyCSQDZsg1MfREi2af2M=;
 b=GbvOWNkCjRBVBeN29RaeTxUHLohDjO1eblowJrsxfNQFlb6VuToH/bygycbMZT74QP
 p/bNk35K5ya4DJitGQvub5933uyqYJG964LeY3bwUKDr4FRUHDUMeKmpuc9OLC9ZCNM2
 Kau6dV0Zr7HId7EBnzjLp9Itbd9nyfovzbcuf2WeISniFD9oYl5sRiIq7uZTldKYPeVA
 wM9rpdFOYQ7siu6L3IiPPYENlExE0lU1tGgZG8CuUUnXtaPu5phypGGv0lufly440A3M
 mvjn1YxKHGgMKgel1+4fkyioPfxG0W43f0sawSqhr2gYf3n/+lES20AP5yP8VNquoDjk
 sliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793529242; x=1794134042;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gSvRnLYT8fB52qPAUBCPULroyCSQDZsg1MfREi2af2M=;
 b=bIpA9cXB4RT9Wbvoj4QDvQuLLIlHLm3BFsx/B8Ec2Md15zUCTFAB001WPqYMQnjpT8
 /lAxoJlXM1oqc6VvUjWQ/LEy0f+Q7EnGNQxQZMH4W/Ox3CL63A2JiYz7L0iYXNbDXRYJ
 eZQjUKIVBtXiutmovV+2S3U9KEo4I33HT9pfEQWzfSE9BBW46rozTIY0BYcjwA7yqW4H
 0ZSsvGvWt3DWdE44rizuRjuNu1l/NmrOzhyfpsjAmtGATLzUupIOI6BGV3Xevo+g5M0x
 +Yi8gCH7M9QpG0OSNHFZa9E48IyGlCIdKN5VlDAF2C2QduWYKnQhMbi97i2x15HuQUN5
 SWJQ==
X-Gm-Message-State: AFq9FYLe/GYLoBpm7CZ3bwESb1yhM07ltFjXdMJw94Q4wgVx0lN1yr+/
 xkEsH6qTPtQ7Pzr3QkrpkbV6Xk0Np3zWJFmIwzfLaeBDEPZBfGN6SFXYaH8JPL7BnUaQCFa9DHt
 YR8nfrb/z8VLCDDaKliY8IN7lSr6AfMsfgCgos13051y24Qz/LbOKqnW1FnAvqinU2fezOO8=
X-Gm-Gg: AYBFou0w0n310npLyCFczQfpf9F976A95Wf9mg+obGvqgodjI/8oKCL1b1WXPqs/0uo
 tDYqHvylhNRgdQJmz5/ke+8+5KMig+10zmhWKXFdtQA4XdhzJDjm6bZmMeMV1ovUpcRS7aJca7+
 1f4rWD3kLDdsrUJgSIIgxm4voGTm36znCW8CLT8QN1p1r/wmub+eLeBM1Sc2xQcKfTq4NiLBvBD
 5UGqI88kf5pMb+4NOCegzMzLxqe7wBxDgLcwPOT5rYzbz67BsXNuY9wqL3sxZ/o1wqLQyPwl/Of
 gEexcCnhnzttT7PvlBR4ZKR1GEGnkm/ay7EsSFybLnGKzC+ArqmP+UR2xBqFxfcYXe72QJFy20S
 pfxaBj7k2xocwDgLmBH+4wu/NGvrNCpBhB3TkfBudenIGvi1ZSV2kCx3vFZ/0Ijs9nUuIka4ZHM
 BWJNA5EHLH
X-Received: by 2002:a05:701b:2310:b0:160:a80f:3ed2 with SMTP id
 a92af1059eb24-1ac5bbb9664mr9047377c88.10.1793529242181; 
 Sun, 01 Nov 2026 02:34:02 -0800 (PST)
X-Received: by 2002:a05:701b:2310:b0:160:a80f:3ed2 with SMTP id
 a92af1059eb24-1ac5bbb9664mr9047354c88.10.1793529241596; 
 Sun, 01 Nov 2026 02:34:01 -0800 (PST)
Received: from [192.168.0.6] ([183.82.206.236])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac18458fa3sm25786307c88.4.2026.11.01.02.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 02:34:01 -0800 (PST)
Message-ID: <5cee8ec5-bcda-4636-97e4-1b27a1e5a0ae@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 16:03:54 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE
 option
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-4-18ce3e431320@oss.qualcomm.com>
 <20261021174707.GC3275858@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261021174707.GC3275858@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OgMt3h1kwqRbmerm1NSlldsLkimB5LUq
X-Proofpoint-GUID: OgMt3h1kwqRbmerm1NSlldsLkimB5LUq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX8/yYjuhnDToV
 Ag9ud22k7k9crF2h7mp/L7O927DisqpJF+nFUXoLonPoXjkRtNvSjgJ/kykF0MfpB3DoR94Dz9X
 xWiIRhPE5J6Gh1wRy89WrhQtDuTVjHfDMrByAVsrFzT+L4CFlQcjsgg1N69h5wNaw+xXrIxof52
 FpRTxQ3Taj77KpdqPPyduddEZowyvcRkKq4hAIpDhppS0tjf3hT/PB+tzFlYoE0B9p/qR2pai2a
 tAmfLsNAtiPC1LGLKalyEtjQKZzb+9jASDgYzIGzOGW7gSSnh/OKpJiOaTtFp6bnBrBUBrKc2Dt
 ATwTe7/9upI4AUpItNlL6duWrkwHN1JtejAjcfBUN8SdKx97kCsiCRIUpKbW8i5km/J9jJoUROS
 0wI47MgRfS4hYghHdvKXlRIZtmAFVevIZHwCAJiI4zz/CSTHeo5YzWd/ZtC3Z5XsF9dKsk6WHXu
 T+PWpPKwj8wGlIsYYbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX64s96oEVf2XI
 MX/Wp+T1Fv558iFoQJ2K5HVqqIlca6k4hSDtjM8jluUANYGjBScglEvJ85JQQlVDsxJ84shW6cs
 Oz7/nakqcAHhURFUUyvRDR5j3TDnj9I=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae7159b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tp4+1iC1jwEXx1kf+84ntw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=6w8Gx9PfewQ146hzqkUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010041
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

Hi Tom,

On 10/21/2026 11:17 PM, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:48:23PM +0530, Balaji Selvanathan wrote:
>> Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
>> platforms. This config automatically selects the required dependencies.
>> Express the platform-specific requirements and configs that must be
>> selected and disabled in snagboot mode.
>>
>> Add QCOM_BOOT0_SNAGBOOT_MODE as a hidden boot0.h config, selected
>> automatically by QCOM_SNAGBOOT_MODE. This boot0.h config is for
>> disabling MMU at the start of U-Boot execution.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v9:
>> - Remove depends on !IOMMU from QCOM_SNAGBOOT_MODE
>>
>> Changes in v7:
>> - No changes
>>
>> Changes in v5:
>> - Made QCOM_BOOT0_SNAGBOOT_MODE dependent on QCOM_SNAGBOOT_MODE so
>>    it is not exposed to users
>> - Add dependencies for QCOM_SNAGBOOT_MODE explicitly as "depends"
>>
>> Changes in v4:
>> - Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
>> - Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
>>    QCOM_SNAGBOOT_MODE
>> - Document the platform-specific requirements and configs that must be
>>    disabled in snagboot mode.
>>
>> Changes in v3:
>> - Newly introduced in v3
>> ---
>>   arch/arm/mach-snapdragon/Kconfig | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
>> index ddded0029ef..db770ad6edc 100644
>> --- a/arch/arm/mach-snapdragon/Kconfig
>> +++ b/arch/arm/mach-snapdragon/Kconfig
>> @@ -82,4 +82,23 @@ config BOOT0_SDM845_WORKAROUND
>>   
>>   endchoice
>>   
>> +config QCOM_BOOT0_SNAGBOOT_MODE
>> +	bool
>> +	depends on QCOM_SNAGBOOT_MODE
>> +
>> +config QCOM_SNAGBOOT_MODE
>> +	bool "Build U-Boot for Snagboot mode loading"
>> +	select QCOM_BOOT0_SNAGBOOT_MODE
>> +	select ENABLE_ARM_SOC_BOOT0_HOOK
>> +	select SKIP_RELOCATE
>> +	select ENV_IS_NOWHERE
>> +	depends on !ENV_IS_IN_SCSI
> You probably want to look at testing ENV_IS_DEFAULT
Done. v10 depends on ENV_IS_DEFAULT, and drops the select ENV_IS_NOWHERE 
and the !ENV_IS_IN_SCSI depends.
>
>> +	depends on !PSCI_RESET
> You earlier change PSCI_RESET so this is redundant?
  Not quite. Patch 1 only changes SYSRESET_PSCI, and PSCI_RESET is a 
separate symbol (default y). I've dropped the depends on !PSCI_RESET 
anyway, and qcom-snagboot.config now unsets it instead.
>
>> +	depends on !SAVE_PREV_BL_INITRAMFS_START_ADDR
> Why?
save_prev_bl_data() treats the entry x0 value as a pointer to an FDT. In 
snagboot mode U-Boot is loaded by XBL, so x0 isn't an FDT and hence 
shouldnt be processed by U-Boot. v10 drops the depends on as it is not 
necessary and unsets it in qcom-snagboot.config.
>
>> +	depends on COUNTER_FREQUENCY != 0
> You probably need to be setting a default then for the snagboot case as
> I assume this is currently 0.
Dropped the depends on COUNTER_FREQUENCY != 0 as it is not necessary. 
The Lemans snagboot defconfig sets CONFIG_COUNTER_FREQUENCY=19200000.
>
>> +	depends on TEXT_BASE != 0
> You probably meant !POSITION_INDEPENDENT, and need to set a default.
> This doesn't work since TEXT_BASE is a hex and 0x0 != 0 is true in
> Kconfig.

Dropped the TEXT_BASE check. It is not necessary. The snagboot defconfig 
sets TEXT_BASE explicitly (0x1c100000 for Lemans).

Regards,

Balaji

>
